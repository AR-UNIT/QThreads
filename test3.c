/*
* file:        test.c
 * description: basic and extended unit tests for Lab 3
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "qthread.h"

int counter = 0;

qthread_mutex_t *mutex;
qthread_cond_t *cond;

void *test_thread(void *arg) {
    qthread_mutex_lock(mutex);
    qthread_cond_wait(cond, mutex);
    counter += 1;
    qthread_mutex_unlock(mutex);
}

void signal_condition() {
    qthread_mutex_lock(mutex);
    qthread_cond_signal(cond);
    qthread_mutex_unlock(mutex);
}

void broadcast_condition() {
    qthread_mutex_lock(mutex);
    qthread_cond_broadcast(cond);
    qthread_mutex_unlock(mutex);
}

int main() {
    qthread_init();
    mutex = qthread_mutex_create();
    cond = qthread_cond_create();
    
    qthread_t threads[5];
    for (int i = 0; i < 5; i++) {
        threads[i] = qthread_create(test_thread, NULL);
    }
    
    qthread_usleep(50000);
    signal_condition();
    qthread_usleep(50000);
    assert(counter == 1);
    qthread_usleep(50000);
    broadcast_condition();
    qthread_usleep(50000);
    assert(counter == 5);
    
    qthread_mutex_destroy(mutex);
    qthread_cond_destroy(cond);

    return 0;
}