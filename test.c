/*
 * file:        test.c
 * description: basic unit tests for Lab 3
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "qthread.h"

/*
  create/yield/join/exit, make sure you test the following cases:
    1 thread, yield several times, then exit
    2 threads, yield back and forth a few times, both exit
    3 or more threads, same
    call join before the child thread exits
    call join after the child thread exits (you may want to use qthread_usleep for this)
*/
void* run_test1(void* arg)
{
    int i;
    for (i = 0; i < 3; i++) {
        qthread_yield();
        printf("%s\n", (char*)arg);
    }
    return arg;
}

void test1(void)
{
    qthread_t t = qthread_create(run_test1, "1");
    void *val = qthread_join(t);
    assert(!strcmp(val, "1"));

    qthread_t t2[2] = {qthread_create(run_test1, "1"),
                       qthread_create(run_test1, "2")};
    val = qthread_join(t2[0]);
    assert(!strcmp(val, "1"));
    val = qthread_join(t2[1]);
    assert(!strcmp(val, "2"));

    qthread_t t3[3] = {qthread_create(run_test1, "1"),
                       qthread_create(run_test1, "2"),
                       qthread_create(run_test1, "3")};
    val = qthread_join(t3[0]);
    assert(!strcmp(val, "1"));
    val = qthread_join(t3[1]);
    assert(!strcmp(val, "2"));
    val = qthread_join(t3[2]);
    assert(!strcmp(val, "3"));
}    
    
int main(int argc, char** argv)
{
    qthread_init();
    test1();
}
