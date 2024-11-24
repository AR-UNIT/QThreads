Lab 3 - User-space thread library
=======================

In this homework you will write a user-space thread system (named “qthreads”, vs. the standard “pthreads” library), which creates threads, performs context switches, and includes implementations of mutexes and condition variables. You will be responsible for writing a thorough test suite for your code.

Rules
-----

Feel free to discuss the ideas in the assignment with other groups, or on Piazza; howeversharing of code across groups or use of code copied from the internet is not allowed. You do not need to explicitly submit your assignment – your grade will be based on the code in your repository at the time it is due.

**Commit and push your code at the end of every day that you work on it**, or (preferably) more frequently. **Include a commit message which describes what you have done**.
You should push your changes even if your code isn't working - you can always go "backwards" in Git to restore a working version. (feel free to ask on Piazza if you need help with this)

**If you do not push your code sufficiently frequently, or fail to provide comments describing your work, you may lose points.**

Note that code similarity between groups, a lack of understanding of your submitted code, or evidence of variables changed by search-and-replace may be considered evidence of academic dishonesty.

Materials and resources
-------------------------------------------

You will download the skeleton code for the assignment from the CCIS GitHub  server, github.ccs.neu.edu, using the 'git clone' command:
```
 git clone https://github.ccs.neu.edu/cs5600-f24/team-N-hw3
```
where *N* is your team number. Periodically you will commit checkpoints of your work into your local repository using 'git commit':
```
    git commit -a -m 'message describing the checkin'
```
(or enter a message in the text editor) and push the commits to the central repository:
```
	git push
```
You are expected to complete this assignment on the CS 5600 virtual machine, either on an Intel or Apple 64-bit CPU (x86-64 or aarch64 architecture). 
Due to the use of machine and OS-specific assembly code in the `switch_thread` function, the provided code is **not** expected to work under either Windows or MacOS.

Repository Contents
-----------------

The repository you clone contains the following files:

* `qthread.c` – this is the file you will be implementing. It has some comments describing the functions and types you have to implement.
* `qthread.h` – analogous to pthread.h, this defines the types used by qthread applications. Note that I've defined qthread_mutex_t and qthread_cond_t as structures with a single pointer to an “implementation” structure that you'll define in qthread.c.
* `switch.S` – this file contains the context switch function (`switch_thread`) and the stack initialization function (`setup_stack`). You don't need to understand these files - the code is considerably more complex than discussed in class because of (a) alignment constraints on modern CPUs and (b) additional debug code.
* `test.c` – this is where your test code should go. (you may also add additional C files and Makefile targets if you wish)
* `Makefile` – this is set up to build the `test` executable. Compile your code by typing ‘make’. 

Deliverables
----------
The following files from your repository will be examined, tested, and graded:
* `qthread.c`
* `test.c`

Assignment description
--------------------

You will need to implement all the functions in the "qthreads" interface described below. To do this you'll almost certainly want to use the following design elements:

* a per-thread structure (let's call it `struct qthread`), holding the following information:
  * next pointer
  * saved stack pointer
  * timing information (see `qthread_sleep`)

* a FIFO queue of thread structures (let's call it `struct qthread_queue`) for the active list and for lists of threads waiting on various things. (with a head and tail pointer, an `append` function that adds to the tail, a `pop` function that pops from the head, and an `empty` function to see if it's empty or not.

* the scheduling pattern described in lecture:
  * `struct qthread *current` - points to currently executing thread
  * `struct qthread_queue active` - list of threads that are ready to run (i.e. not sleeping)

* the set of threads waiting for a timeout

As always I would suggest the absolutely simplest data structures to accomplish the job.
In particular, I would suggest implementing the thread set as an array of pointers:

* insert into the set by searching for an index holding NULL and setting it to the pointer value
* find a match item by exhaustive search
* remove a pointer by replacing it with NULL
You can assume there will never be more than 32 threads in total.

### Typedefs (provided in the qthread.h file)

The following typedefs are defined:
* `typedef struct qthread *qthread_t` - you need to define `struct qthread` in `qthread.c`
* `typedef void * (*f_1arg_t)(void*)` - this is the function argument to `qthread_create`; it takes a single `void*` argument, and returns `void*`;
* `typedef void (*f_2arg_t)(f_1arg_t, void*)` - this is the function argument to `setup_stack`; it takes 2 arguments, the first of which is a `f_1arg_t`

Finally, `qthread_mutex_t` and `qthread_cond_t` are defined as pointers to `struct qthread_mutex` and `struct qthread_cond`; you will need to define both structures in your code.

### Functions (you implement)

Note that except for the first function, these are basically the POSIX thread functions with simplified interfaces. First the basic thread functions:

* `void qthread_init(void)` - this initializes your thread implementation
* `qthread_t qthread_create(f_1arg_t f, void *arg1)` - create a thread which executes `f(arg1)`.
* `void qthread_exit(void *val)` - exit (i.e. switch to another thread and never return) and save `val` as return value (see `qthread_join`)
* `void qthread_yield(void)` - put self on tail of active list and switch to the next active thread
* `void *qthread_join(qthread_t thread)` - wait for a thread to exit and get its return value. A thread can only be "joined" by one other thread. (i.e. it's OK to crash if two threads call join on the same thread)

Then mutexes and condition variables:

* `qthread_mutex_t *qthread_mutex_create(void)` 
* `void qthread_mutex_lock(qthread_mutex_t *m)`
* `void qthread_mutex_unlock(qthread_mutex_t *m)`
* `void qthread_mutex_destroy(qthread_mutex_t *m)`

* `qthread_cond_t *qthread_cond_init(qthread_cond_t *c)`
* `void qthread_cond_wait(qthread_cond_t *c, qthread_mutex_t *m)`
* `void qthread_cond_signal(qthread_cond_t *c)`
* `void qthread_cond_broadcast(qthread_cond_t *c)`
* `void qthread_cond_destroy(qthread_cond_t *c)`

And finally a sleep function, with the same interface as the Unix `usleep` function:

* `void qthread_usleep(long int microsecs)`

## Hints and advice

`qthread_init` - this is going to have to allocate a thread structure for the current (OS-provided) thread and put it on `current`, so that things don't crash when you try to switch to another thread.

`qthread_create` - qthreads allows you to return from the thread function, just like you can return from `main` in a normal program; however you hopefully remember that you can't return from a thread or process - you have to exit. So you need to have a "wrapper" function which calls the thread function and then calls `qthread_exit` when it returns. A possible approach is:
```
qthread_t create_2arg_thread(f_2arg_t f, void *arg1, void *arg2)
{
  /* do all your thread creation stuff */
}
void wrapper(void *arg1, void *arg2)
{
    f_1arg_t f = arg1;
    void *tmp = f(arg2);
    qthread_exit(tmp);
}
qthread_t qthread_create(f_1arg_t f, void *arg)
{
    return create_2arg_thread(wrapper, f, arg);
}
```

`qthread_exit` and `qthread_join` - You're going to have to stash the return value (from 'exit') in the thread structure so that 'join' can retrieve it. If 'join' is called first, it has to sleep until the other thread calls 'exit', which wakes it up. This means you're going to need the following fields in your thread structure:

* return value (i.e. the argument to 'exit')
* flag indicating whether 'exit' was already called
* pointer to a thread waiting in 'join' (or NULL if there isn't one)

**Current/Active**
Here are the possible ways that we can manipulate *current* and *active* for thread scheduling:

1. give another thread a turn (but don't sleep):  
append *current* to tail of *active*  
*current* = [remove head of *active*]  
switch to new *current*  
  
2. go to sleep (block on mutex / wait on condvar / wait in usleep) :  
[somewhere] = current  
*current* = [remove head of *active*]  
switch to new *current*  
  
3. wake another thread up (without switching)
   *th* = [somewhere]
   append *th* to tail of *active*

In each case you put pointer to the current thread somewhere safe (but not on the active list), and then switch to the next thread in *active*. Similarly, waking another thread up means taking a pointer to that thread from somewhere and putting it back on the active list.

Traditionally the two steps:

* *current* = [remove head of *active*]
* switch to new *current*

are combined into a function called `schedule`, which picks the next thread and switches to it. (factoring this out might be useful when you write `qthread_usleep`, as it will make that scheduling decision more complex)

Finally, note that qthreads doesn't have to be big and complex - it’s possible to implement it in less than 300 lines of code.
