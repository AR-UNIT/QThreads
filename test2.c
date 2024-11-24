/*
* file:        test.c
 * description: basic and extended unit tests for Lab 3
 */

#include <stdio.h>
#include <assert.h>
#include "qthread.h"
#include <sys/time.h>
#include <unistd.h> 

int counter = 1;
qthread_mutex_t *mutex;

long get_current_time_us()
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec * 1000000 + tv.tv_usec;
}

void* mutexLockIncrementCounterSleepIncrementCounterUnlock(void* arg)
{
    qthread_mutex_lock(mutex);
    counter += 1;
    qthread_usleep(5000000);
    counter += 1;
    qthread_mutex_unlock(mutex);
}

void testMutexWithCounterAndSleeping()
{
    mutex = qthread_mutex_create();

    qthread_t t1 = qthread_create(mutexLockIncrementCounterSleepIncrementCounterUnlock, NULL);
    qthread_t t2 = qthread_create(mutexLockIncrementCounterSleepIncrementCounterUnlock, NULL);

    for (size_t i = 0; i < 5; i++) {
        qthread_yield();
    }

    assert(counter == 2);
    long start_time = get_current_time_us();
    qthread_join(t1);
    long elapsed_time = get_current_time_us() - start_time;
    assert(elapsed_time >= 5000000 && elapsed_time < 6000000);

    for (size_t i = 0; i < 5; i++) {
        qthread_yield();
    }

    start_time = get_current_time_us();
    qthread_join(t2);
    elapsed_time = get_current_time_us() - start_time;
    assert(elapsed_time >= 5000000 && elapsed_time < 6000000);
    assert(counter == 4);
    qthread_mutex_destroy(mutex);
}

int main()
{
    qthread_init();
    testMutexWithCounterAndSleeping();
    return 0;
}