/*
 * file:        test.c
 * description: basic and extended unit tests for Lab 3
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <math.h>
#include "qthread.h"
#include <sys/time.h>

qthread_mutex_t *mutex;  

long get_current_time_us()
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec * 1000000 + tv.tv_usec;
}


void* valueTimes2(void* arg) 
{
    int* int_arg = (int*)arg;
    *int_arg = *int_arg * 2;
    return arg;
}


void test_single_thread_create_and_join(void) 
{
    int arg = 1;
    qthread_t t1 = qthread_create(valueTimes2, &arg);
    qthread_join(t1);
    assert(arg == 2);
}


void test_two_threads(void) 
{
    int arg1 = 2;
    int arg2 = 4;
    qthread_t t1 = qthread_create(valueTimes2, &arg1);
    qthread_t t2 = qthread_create(valueTimes2, &arg2);
    qthread_join(t1);
    qthread_join(t2);
    assert(arg1 == 4);
    assert(arg2 == 8);
}


void test_three_threads(void) 
{
    int arg1 = 123;
    int arg2 = 456;
    int arg3 = 789;
    qthread_t t1 = qthread_create(valueTimes2, &arg1);
    qthread_t t2 = qthread_create(valueTimes2, &arg2);
    qthread_t t3 = qthread_create(valueTimes2, &arg3);
    qthread_join(t1);
    qthread_join(t2);
    qthread_join(t3);
    assert(arg1 == 246);
    assert(arg2 == 912);
    assert(arg3 == 1578);
}

int main() {
    qthread_init();
    mutex = qthread_mutex_create();
    test_single_thread_create_and_join();
    test_two_threads();
    test_three_threads();
    return 0;
}