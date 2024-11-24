/*
 * file:        switch-x86.s
 * description: assembly code to switch 64-bit stack
 * class:       CS 5600, Fall 2024
 */

// gcc -S stack.c:
//void *setup_stack(void *_stack, int len, void *func, void *arg1, void *arg2)
//{
//      _stack += len;
//      long *stack = (long*)(_stack - ((long)_stack & 0x0F));
//      long old_bp = (long)stack;  /* top frame - SP = BP */
//
//      *(--stack) = 0x3A3A3A3A3A3A3A3A;    /* guard zone */
//      *(--stack) = 0x3A3A3A3A3A3A3A3A;
//      *(--stack) = 0x3A3A3A3A3A3A3A3A;
//
//      /* this is the stack frame calling 'switch_to'
//       */
//      *(--stack) = (long)func;     /* return address */
//      *(--stack) = old_bp;        /* %rbp */
//      *(--stack) = (long)arg2;     /* argument */                 // RSI
//      *(--stack) = (long)arg1;     /* argument (reverse order) */ // RDI 
//      *(--stack) = 0;             /* %rbx */
//      *(--stack) = 0;             /* %r12 */
//      *(--stack) = 0;             /* %r13 */
//      *(--stack) = 0;             /* %r14 */
//      *(--stack) = 0;             /* %r15 */
//      *(--stack) = 0xa5a5a5a5a5a5a5a5;    /* valid stack flag */
//      return stack;
//}

	.text
	.globl	setup_stack
	.type	setup_stack, @function
setup_stack:
.LFB0:
	.cfi_startproc
	endbr64
	movslq	%esi, %rsi
	addq	%rsi, %rdi
	andq	$-16, %rdi
	movabsq	$4195730024608447034, %rax
	movq	%rax, -8(%rdi)
	movq	%rax, -16(%rdi)
	movq	%rax, -24(%rdi)
	movq	%rdx, -32(%rdi)
	movq	%rdi, -40(%rdi)
	movq	%r8, -48(%rdi)
	movq	%rcx, -56(%rdi)
	movq	$0, -64(%rdi)
	movq	$0, -72(%rdi)
	movq	$0, -80(%rdi)
	movq	$0, -88(%rdi)
	movq	$0, -96(%rdi)
	movabsq	$-6510615555426900571, %rax
	movq	%rax, -104(%rdi)
	leaq	-104(%rdi), %rax
	ret
	.cfi_endproc
.LFE0:
	.size	setup_stack, .-setup_stack

/*
 * switch_thread - save stack pointer to *location_for_old_sp, set 
 *             stack pointer to 'new_value', and return.
 *             Note that the return takes place on the new stack.
 *
 * switch_thread(void **location_for_old_sp, void *new_value)
 *   location_for_old_sp = RDI
 *   new_value = RSI
 *
 * For more details, see:
 *  http://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf
 */
 
switch_thread:
        /* frame pointer - makes life easier in assembler, too 
	 */
	push %rbp 
	mov  %rsp,%rbp
	
	/* debugging support - the last value pushed before switching
         * is a flag; check for that here and halt *before* switching
         * so you have a chance to debug
	 */ 
	mov  $0xA5A5A5A5A5A5A5A5,%rax
	cmp %rax, (%rsi)	/* flag value on top of new stack? */
	je   ok			/* yes - skip */
	mov  $0,%rax		/* no - simple assert */
	mov  0(%rax),%rax	
ok:	
	/* save and restore arg1 and arg2 so we can pass args to thread function
	*/
	push %rsi
	push %rdi
	
	/* C calling conventions require that we preserve %rbp (already
         * saved above), %rbx, %r12, $r13, %r14, %r15 - push them onto the stack
	*/
	push %rbx
	push %r12
	push %r13
	push %r14
	push %r15

	mov $0xA5A5A5A5A5A5A5A5, %rax
	push %rax		/* push the flag value */

	cmp  $0,%rdi		/* is 'location_for_old' null? */
	je   skip
	mov  %rsp,(%rdi)	/* into 'location_for_old' */
skip:
	
	mov %rsi,%rsp		/* switch */

	pop  %rax		/* pop flag and ignore it */

	pop %r15		/* pop callee-save registers */
	pop %r14
	pop %r13
	pop %r12
	pop %rbx
	
	pop %rdi		/* this is so we can pass args */
	pop %rsi

	pop %rbp		/* and the frame pointer */
	ret			/* and return */

.global	switch_thread
