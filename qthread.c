/*
 * file:        qthread.c
 * description: assignment - simple emulation of POSIX threads
 * class:       CS 5600, Fall 2024
 */

/* a bunch of includes which will be useful */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>
#include <sys/time.h>
#include <errno.h>
#include "qthread.h"
#include <stdbool.h>
#include <limits.h>

/* prototypes for stack.c and switch.s
 * see source files for additional details
 */
extern void switch_thread(void **location_for_old_sp, void *new_value);
extern void *setup_stack(void *_stack, size_t len, f_2arg_t f, f_1arg_t f2, void *arg);
#define MAX_SLEEPING_THREADS 32

/* this is your qthread structure.
 */
struct qthread {
    /* your code here */;
    struct qthread *next;
    /* need this stack base pointer to let us free space allocated for stack once thread exits */
    void *stack;
    void *saved_sp;
    int exited_flag;
    void *exit_val;
    struct qthread *waiting_for_me; /* pointer to thread waiting for join */
    long wake_time;
};

/* tracks the thread taken off from front of active_q ,
    when yield called by current thread, it would be put into back of active_q,
    and the thread at front of active_q would be put in current
    */
struct qthread *current;


/* You'll probably want to define a thread queue structure, and
 * functions to append and remove threads. (Note that you only need to
 * remove the oldest item from the head, makes removal a lot easier)
 */
typedef struct threadq {
    /* the front of the queue holds the earliest thread, first thread to select */
    struct qthread *front;
    /* the back of the queue holds the most recent process, last thread to select */
    struct qthread *back;
} threadq;

/* Mutex structure */
struct qthread_mutex {
    int lock_acquired;
    threadq waiting_threads;
};

/* Condition variable structure */
struct qthread_cond {
    threadq waiting_threads;
};

threadq active_q;
struct qthread *sleeping_threads[MAX_SLEEPING_THREADS];

/* Helper function to get current time in microseconds */
long int get_usecs() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec*1000000 + tv.tv_usec;
}

/* Check if thread queue is empty */
bool is_empty(threadq *queue) {
    return queue->front == NULL;
}

/* adds a thread to the back/end of a threadq */
void add_thread_to_q(struct threadq *queue, struct qthread *new_thread) {
    if (queue->back) {
        queue->back->next = new_thread;
        queue->back = new_thread;
    } else {
        queue->front = queue->back = new_thread;
    }
    new_thread->next = NULL;
}

/* removes thread from front/head of a threadq */
struct qthread* remove_queue_oldest(struct threadq *queue) {
    /* if the queue is empty, then nothing to remove, return null */
    if (!queue->front) {
        return NULL;
    }
    struct qthread *oldest_thread = queue->front;
    queue->front = queue->front->next;
    /* if there is no qthread remaining after removing front, then set back to null
    the back of the queue is only updated while removing when the whole threadq becomes empty */
    if (!queue->front) {
        queue->back = NULL;
    }
    /* disconnect the front of the queue to remove it, after setting it's next to front of the queue*/
    oldest_thread->next = NULL;
    return oldest_thread;
}

void wake_up_threads(long current_time) {
        for (int i = 0; i < MAX_SLEEPING_THREADS; i++) {
        if (sleeping_threads[i] && current_time >= sleeping_threads[i]->wake_time) {
            add_thread_to_q(&active_q, sleeping_threads[i]);
            sleeping_threads[i] = NULL;
        }
    }
}

/* function to calculate minimum amount of time to sleep, and sleep for that time */
void sleep_until_first_thread_runnable(long current_time){
    long min_wake_time = LONG_MAX;
    for (int i = 0; i < MAX_SLEEPING_THREADS; i++) {
        if (sleeping_threads[i] && sleeping_threads[i]->wake_time < min_wake_time) {
            min_wake_time = sleeping_threads[i]->wake_time;
        }
    }
    if (min_wake_time != LONG_MAX) {
        long sleep_for_time = min_wake_time - current_time;
        if (sleep_for_time > 0) {
            usleep(sleep_for_time);
        }
    }
}

/* Scheduler function */
void schedule(void) {
    long current_time = get_usecs();
    qthread_t tmp = current;
    wake_up_threads(current_time);
    qthread_t next_runnable_thread = remove_queue_oldest(&active_q);
    if (next_runnable_thread == NULL) {
        sleep_until_first_thread_runnable(current_time);
        return schedule();
    }
    if (next_runnable_thread!= current) {
        struct qthread *prev = current;
        current = next_runnable_thread;
        switch_thread(&tmp->saved_sp, next_runnable_thread->saved_sp);
    }
}

/* Create a thread with two arguments */
qthread_t create_2arg_thread(f_2arg_t f, void *arg1, void *arg2)
{
    /* do all your thread creation stuff */
    qthread_t created_thread = malloc(sizeof(struct qthread));
    size_t len = 64 * 1024; /*64kb*/

    /* this is the base stack pointer, i.e, the first address in empty stack */
    void *base_pointer = malloc(len);

    /* this is the pointer to actual top variable in stack */
    void * stack_pointer = setup_stack(base_pointer, len, f, arg1, arg2);

    created_thread->next = NULL;
    created_thread->stack = base_pointer;
    created_thread->saved_sp = stack_pointer;
    created_thread->waiting_for_me = NULL;
    created_thread->exit_val = NULL;
    created_thread->exited_flag = 0;
    created_thread->wake_time = 0;

    /* adding the thread to the active q here? */
    add_thread_to_q(&active_q, created_thread);

    /* return the pointer to the created_thread, so that user can use pointer to interact with thread(join) */
    return created_thread;
}

/* Wrapper function for thread creation */
void wrapper(void *arg1, void *arg2) {
    f_1arg_t f = arg1;
    void *tmp = f(arg2);
    qthread_exit(tmp);
}

/* Initialize the threading system */
void qthread_init(void) {
    current = malloc(sizeof(struct qthread));
    /* the next is set to null, because initially no next thread */
    current->next = NULL;

    /* the pointer to stack, and the pointer to location in stack are not saved in qthread_init,
        because the OS thread already has a stack,
        once we switch away from the initial OS thread by using switch_thread, switch_thread will set the saved_sp field,
        so that we can continue when we switch back.
        In order to have switch_thread set saved_sp, send address of saved_sp as 1st argument to switch_thread*/
    current->stack = NULL;
    current->saved_sp = NULL;
    current->exited_flag = 0; /* 0 MEANS FALSE, 1 MEANS TRUE */
    current->waiting_for_me = NULL;
    current->exit_val = NULL;
    current->wake_time = 0;
}

/* Create a new thread */
qthread_t qthread_create(f_1arg_t f, void *arg1) {
    return create_2arg_thread(wrapper, f, arg1);
}

/* qthread_yield - yield to the next @runnable thread.
 */
void qthread_yield(void)
{
    /* put current to back of active_q, and context switch to next available active thread via schedule */
    add_thread_to_q(&active_q, current);
    schedule();
}

/* qthread_exit, qthread_join - exit argument is returned by
 * qthread_join. Note that join blocks if the thread hasn't exited
 * yet, and is allowed to crash @if the thread doesn't exist.
 */
void qthread_exit(void *val)
{
    /* your code here */
    /* set the exit_val to val and exited_flags to 1 for current thread, which is exiting */
    current->exit_val = val;
    current->exited_flag = 1;

    /* if any thread is waiting for the current thread, we can put that waiting thread back on the active_q
            the waiting thread was taken off of active, and then just put into waiting_for_me of this current thread in join,
            so it was just taken out of execution, but we never came back to it. This allowed us to do qthread_exit and qthread_join
            syncronization without any mutexes or condition variables.
    */
    if (current->waiting_for_me) {
        /* now that this thread is completed, we can let the thread calling join on this thread complete, and it would find a non-null exit_val */
        add_thread_to_q(&active_q,current->waiting_for_me);
    }
    schedule();
}


/* wait for a thread to exit and get its return value */
void *qthread_join(qthread_t thread)
{
    /* your code here */

    /* if the thread has not already exited */
    if (thread->exited_flag == 0) {

        /* if thread has not exited, wait for it to exit,
        store current thread calling join to waiting_for_me value in the thread we are waiting for,
        now we are able to synchronize both threads by storing it in the thread construct, and not using
        any mutexes or condition variables. */
        thread->waiting_for_me = current;
        schedule();
    }
    /* if the thread has already exited, just return the exit_val */
    return thread->exit_val;
}

/* Mutex functions
 */

/* initializes the global mutex struct, which has a lock_acquired boolean and a queue of waiting threads  */
qthread_mutex_t *qthread_mutex_create(void)
{
    qthread_mutex_t *mutex = malloc(sizeof(qthread_mutex_t));
    /* set lock_acquired of global mutex variable */
    mutex->lock_acquired = 0;
    mutex->waiting_threads.front = mutex->waiting_threads.back = NULL;
    return mutex;
}

/* Destroy a mutex */
void qthread_mutex_destroy(qthread_mutex_t *mutex) {
    free(mutex);
}


/* attempts to fetch mutex lock, if lock acquired, then sleep in condition variable queue */
void qthread_mutex_lock(qthread_mutex_t *mutex)
{
    /* if mutex already acquired, put thread to mutex waiting queue */
    if(mutex->lock_acquired) {
        add_thread_to_q(&mutex->waiting_threads, current);
        schedule();
    }
    /* if mutex not acquired yet, acquire it now for this thread */
    mutex->lock_acquired = 1;
}

/* unlocks mutex acquired by current thread, assigns mutex to front of mutex_q, puts front of mutex_q to back of active_q */
void qthread_mutex_unlock(qthread_mutex_t *mutex)
{
    /*check if the lock is not acquired at all (no op)*/
    if(mutex->lock_acquired = 0) {
        return;
    }

    /* get the oldestwaiting thread in mutex_q */
    qthread_t oldestWaiting = remove_queue_oldest(&mutex->waiting_threads);
    /* if mutex_q is not empty, then take the front of the mutex q and add it to back of active_q */
    if(oldestWaiting != NULL) {
        add_thread_to_q(&active_q, oldestWaiting);
        /* no switching threads right now, need to let the current process complete any other steps after releasing mutex lock */
    }
    else {
        /* if the mutex_q is empty, then just make the mutex available for future threads */
        mutex->lock_acquired = 0;
    }
}

/* Condition variable functions
 */

/* Create a condition variable */
qthread_cond_t *qthread_cond_create(void) {
    qthread_cond_t *cond = malloc(sizeof(qthread_cond_t));
    cond->waiting_threads.front = cond->waiting_threads.back = NULL;
    return cond;
}

/* Destroy a condition variable */
void qthread_cond_destroy(qthread_cond_t *cond) {
    free(cond);
}

/* Wait on a condition variable */
void qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex)
{
    /* unlock the mutex before putting thread in cond_var waiting queue */
    qthread_mutex_unlock(mutex);
    add_thread_to_q(&cond->waiting_threads, current);
    schedule();
    qthread_mutex_lock(mutex);
}

/* wakes up thread at front of cond_var_q, puts thread to back of active_q */
void qthread_cond_signal(qthread_cond_t *cond)
{
    /* get the oldestwaiting thread in the condition variable queue, and put it in active list */
    qthread_t oldestWaiting = remove_queue_oldest(&cond->waiting_threads);
    if(oldestWaiting != NULL) {
        /* now the thread 'woken up' by signal will get a chance to execute */
        add_thread_to_q(&active_q, oldestWaiting);
    }
}


/* wakes up every thread that is sleeping in the cond_var waiting queue */
void qthread_cond_broadcast(qthread_cond_t *cond)
{
    while (!is_empty(&cond->waiting_threads)) {
        qthread_t waiting_thread = remove_queue_oldest(&cond->waiting_threads);
        add_thread_to_q(&active_q, waiting_thread);
    }
}


/* POSIX replacement API. This semester we're only implementing 'usleep'
 *
 * If there are no runnable threads, your scheduler needs to wait,
 * using one or more calls to the system usleep() function, until
 * a thread blocked in 'qthread_usleep' is ready to wake up.
 */


/* qthread_usleep - yield to next runnable thread, making arrangements
 * to be put back on the active list after 'usecs' timeout.
 */
void qthread_usleep(long int usecs)
{
	/* Sleep for a specified amount of microseconds */
    long when_to_wake = get_usecs() + usecs;
    for (int i = 0; i < MAX_SLEEPING_THREADS; i++) {
        if (sleeping_threads[i] == NULL) {
            sleeping_threads[i] = current;
            sleeping_threads[i]->wake_time = when_to_wake;
            break;
        }
    }
    schedule();
}
