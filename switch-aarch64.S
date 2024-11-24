	.arch armv8-a
	.file	"switch-arm.c"
	.text
.Ltext0:
	.file 0 "/home/cs3650/2019-hw2" "switch-arm.c"
	.align	2
	.type	save_stack, %function
save_stack:
.LVL0:
.LFB51:
	.file 1 "switch-arm.c"
	.loc 1 10 1 view -0
	.cfi_startproc
	.loc 1 10 1 is_stmt 0 view .LVU1
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	str	x1, [sp]
	.loc 1 11 5 is_stmt 1 view .LVU2
	.loc 1 11 8 is_stmt 0 view .LVU3
	ldr	x0, [sp, 8]
	.loc 1 11 8 view .LVU4
	cmp	x0, 0
	beq	.L3
	.loc 1 12 9 is_stmt 1 view .LVU5
	.loc 1 12 15 is_stmt 0 view .LVU6
	ldr	x0, [sp, 8]
	.loc 1 12 15 view .LVU7
	ldr	x1, [sp]
	.loc 1 12 15 view .LVU8
	str	x1, [x0]
	.loc 1 13 9 is_stmt 1 view .LVU9
	.loc 1 13 13 is_stmt 0 view .LVU10
	ldr	x1, [sp]
	.loc 1 13 13 view .LVU11
	mov	w0, 42405
.LVL1:
	.loc 1 13 13 view .LVU12
	movk	w0, 0xa5a5, lsl 16
	str	w0, [x1]
	str	w0, [x1, 4]
.L3:
	.loc 1 15 1 view .LVU13
	nop
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
.LVL2:
	.loc 1 15 1 view .LVU14
	ret
	.cfi_endproc
.LFE51:
	.size	save_stack, .-save_stack
	.align	2
	.global	trampoline
	.type	trampoline, %function
trampoline:
.LFB54:
	.loc 1 37 1 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 38 5 view .LVU16
#APP
// 38 "switch-arm.c" 1
	ldr x3, [sp, #-96]
// 0 "" 2
	.loc 1 39 5 view .LVU17
// 39 "switch-arm.c" 1
	ldr x0, [sp, #-88]
// 0 "" 2
	.loc 1 40 5 view .LVU18
// 40 "switch-arm.c" 1
	ldr x1, [sp, #-80]
// 0 "" 2
	.loc 1 41 5 view .LVU19
// 41 "switch-arm.c" 1
	ldr x2, [sp, #-72]
// 0 "" 2
	.loc 1 42 5 view .LVU20
// 42 "switch-arm.c" 1
	blr x3
// 0 "" 2
	.loc 1 43 5 view .LVU21
	.loc 1 43 14 is_stmt 0 view .LVU22
#NO_APP
	mov	x0, 0
	str	wzr, [x0]
	.loc 1 44 1 view .LVU23
	ret
	.cfi_endproc
.LFE54:
	.size	trampoline, .-trampoline
	.align	2
	.global	_switch
	.type	_switch, %function
_switch:
.LVL3:
.LFB52:
	.loc 1 19 1 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 19 1 is_stmt 0 view .LVU25
	stp	x29, x30, [sp, -112]!
	.cfi_def_cfa_offset 112
	.cfi_offset 29, -112
	.cfi_offset 30, -104
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	.cfi_offset 19, -96
	.cfi_offset 20, -88
	.cfi_offset 21, -80
	.cfi_offset 22, -72
	.cfi_offset 23, -64
	.cfi_offset 24, -56
	.cfi_offset 25, -48
	.cfi_offset 26, -40
	.cfi_offset 27, -32
	.cfi_offset 28, -24
	mov	x3, x0
	mov	x0, x1
.LVL4:
	.loc 1 19 1 view .LVU26
	str	x2, [sp, 104]
	.loc 1 20 5 is_stmt 1 view .LVU27
	.loc 1 21 5 view .LVU28
	.loc 1 22 5 view .LVU29
#APP
// 22 "switch-arm.c" 1
	mov x1, sp
// 0 "" 2
.LVL5:
	.loc 1 23 5 view .LVU30
#NO_APP
	sub	x1, x1, #16
.LVL6:
	.loc 1 23 5 is_stmt 0 view .LVU31
	blr	x3
.LVL7:
	.loc 1 24 5 is_stmt 1 view .LVU32
	ldr	x0, [sp, 104]
#APP
// 24 "switch-arm.c" 1
	mov sp, x0
// 0 "" 2
	.loc 1 25 1 is_stmt 0 view .LVU33
#NO_APP
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 112
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 27
	.cfi_restore 28
	.cfi_restore 25
	.cfi_restore 26
	.cfi_restore 23
	.cfi_restore 24
	.cfi_restore 21
	.cfi_restore 22
	.cfi_restore 19
	.cfi_restore 20
	.cfi_def_cfa_offset 0
.LVL8:
	.loc 1 25 1 view .LVU34
	ret
	.cfi_endproc
.LFE52:
	.size	_switch, .-_switch
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"switch-arm.c"
	.align	3
.LC1:
	.string	"*(unsigned long*)new_sp == 0xA5A5A5A5A5A5A5A5"
	.text
	.align	2
	.global	switch_thread
	.type	switch_thread, %function
switch_thread:
.LVL9:
.LFB53:
	.loc 1 28 1 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 28 1 is_stmt 0 view .LVU36
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	.loc 1 29 5 is_stmt 1 view .LVU37
	ldr	x3, [x1]
	mov	x2, 42405
	movk	x2, 0xa5a5, lsl 16
	movk	x2, 0xa5a5, lsl 32
	movk	x2, 0xa5a5, lsl 48
	cmp	x3, x2
	bne	.L10
	.loc 1 30 5 view .LVU38
	add	x2, x1, 16
	mov	x1, x0
.LVL10:
	.loc 1 30 5 is_stmt 0 view .LVU39
	adrp	x0, save_stack
.LVL11:
	.loc 1 30 5 view .LVU40
	add	x0, x0, :lo12:save_stack
	bl	_switch
.LVL12:
	.loc 1 31 1 view .LVU41
	ldp	x29, x30, [sp], 16
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
.LVL13:
.L10:
	.cfi_restore_state
	.loc 1 29 5 is_stmt 1 discriminator 1 view .LVU42
	adrp	x3, .LANCHOR0
	add	x3, x3, :lo12:.LANCHOR0
	mov	w2, 29
	adrp	x1, .LC0
.LVL14:
	.loc 1 29 5 is_stmt 0 discriminator 1 view .LVU43
	add	x1, x1, :lo12:.LC0
	adrp	x0, .LC1
.LVL15:
	.loc 1 29 5 discriminator 1 view .LVU44
	add	x0, x0, :lo12:.LC1
	bl	__assert_fail
.LVL16:
	.cfi_endproc
.LFE53:
	.size	switch_thread, .-switch_thread
	.align	2
	.global	setup_stack
	.type	setup_stack, %function
setup_stack:
.LVL17:
.LFB56:
	.loc 1 67 1 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 68 5 view .LVU46
.LBB4:
.LBI4:
	.loc 1 46 14 view .LVU47
.LBB5:
	.loc 1 49 5 view .LVU48
	.loc 1 49 42 is_stmt 0 view .LVU49
	sub	x1, x1, #256
.LVL18:
	.loc 1 49 42 view .LVU50
	add	x0, x0, x1
.LVL19:
	.loc 1 49 48 view .LVU51
	and	x0, x0, -16
.LVL20:
	.loc 1 50 5 is_stmt 1 view .LVU52
	.loc 1 52 5 view .LVU53
	.loc 1 52 13 is_stmt 0 view .LVU54
	mov	w1, 42405
.LVL21:
	.loc 1 52 13 view .LVU55
	bfi	w1, w1, 16, 16
	str	w1, [x0]
	str	w1, [x0, 4]
	.loc 1 53 5 is_stmt 1 view .LVU56
.LVL22:
	.loc 1 53 13 is_stmt 0 view .LVU57
	str	xzr, [x0, 8]
	.loc 1 56 5 is_stmt 1 view .LVU58
.LVL23:
	.loc 1 56 13 is_stmt 0 view .LVU59
	str	xzr, [x0, 16]
	.loc 1 57 5 is_stmt 1 view .LVU60
.LVL24:
	.loc 1 57 13 is_stmt 0 view .LVU61
	adrp	x1, trampoline
	add	x1, x1, :lo12:trampoline
	str	x1, [x0, 24]
	.loc 1 60 5 is_stmt 1 view .LVU62
.LVL25:
	.loc 1 60 13 is_stmt 0 view .LVU63
	str	x2, [x0, 32]
	.loc 1 61 5 is_stmt 1 view .LVU64
.LVL26:
	.loc 1 61 13 is_stmt 0 view .LVU65
	str	x3, [x0, 40]
	.loc 1 62 5 is_stmt 1 view .LVU66
.LVL27:
	.loc 1 62 13 is_stmt 0 view .LVU67
	str	x4, [x0, 48]
	.loc 1 63 5 is_stmt 1 view .LVU68
.LVL28:
	.loc 1 63 5 is_stmt 0 view .LVU69
.LBE5:
.LBE4:
	.loc 1 69 1 view .LVU70
	ret
	.cfi_endproc
.LFE56:
	.size	setup_stack, .-setup_stack
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
	.type	__PRETTY_FUNCTION__.0, %object
	.size	__PRETTY_FUNCTION__.0, 14
__PRETTY_FUNCTION__.0:
	.string	"switch_thread"
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/aarch64-linux-gnu/11/include/stddef.h"
	.file 3 "/usr/include/assert.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x3c6
	.2byte	0x5
	.byte	0x1
	.byte	0x8
	.4byte	.Ldebug_abbrev0
	.uleb128 0xf
	.4byte	.LASF21
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x10
	.4byte	.LASF22
	.byte	0x2
	.byte	0xd1
	.byte	0x17
	.4byte	0x3a
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.4byte	.LASF2
	.uleb128 0x11
	.byte	0x8
	.uleb128 0x12
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF3
	.uleb128 0x1
	.byte	0x2
	.byte	0x7
	.4byte	.LASF4
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.4byte	.LASF6
	.uleb128 0x1
	.byte	0x2
	.byte	0x5
	.4byte	.LASF7
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.4byte	.LASF8
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF9
	.uleb128 0x9
	.4byte	0x74
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.4byte	.LASF10
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.4byte	.LASF11
	.uleb128 0x6
	.4byte	0x7b
	.uleb128 0x13
	.4byte	.LASF23
	.byte	0x3
	.byte	0x45
	.byte	0xd
	.4byte	0xb4
	.uleb128 0x4
	.4byte	0x8e
	.uleb128 0x4
	.4byte	0x8e
	.uleb128 0x4
	.4byte	0x58
	.uleb128 0x4
	.4byte	0x8e
	.byte	0
	.uleb128 0x14
	.4byte	.LASF24
	.byte	0x1
	.byte	0x42
	.byte	0x7
	.4byte	0x41
	.8byte	.LFB56
	.8byte	.LFE56-.LFB56
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1a5
	.uleb128 0x3
	.4byte	.LASF12
	.byte	0x42
	.byte	0x19
	.4byte	0x41
	.4byte	.LLST7
	.4byte	.LVUS7
	.uleb128 0x15
	.string	"len"
	.byte	0x1
	.byte	0x42
	.byte	0x27
	.4byte	0x2e
	.4byte	.LLST8
	.4byte	.LVUS8
	.uleb128 0xa
	.string	"f"
	.byte	0x42
	.byte	0x32
	.4byte	0x41
	.uleb128 0x1
	.byte	0x52
	.uleb128 0xb
	.4byte	.LASF13
	.byte	0x42
	.byte	0x3b
	.4byte	0x41
	.uleb128 0x1
	.byte	0x53
	.uleb128 0xb
	.4byte	.LASF14
	.byte	0x42
	.byte	0x47
	.4byte	0x41
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x16
	.4byte	0x1a5
	.8byte	.LBI4
	.byte	.LVU47
	.8byte	.LBB4
	.8byte	.LBE4-.LBB4
	.byte	0x1
	.byte	0x44
	.byte	0xc
	.uleb128 0x5
	.4byte	0x1ea
	.4byte	.LLST9
	.4byte	.LVUS9
	.uleb128 0x5
	.4byte	0x1df
	.4byte	.LLST10
	.4byte	.LVUS10
	.uleb128 0x5
	.4byte	0x1d5
	.4byte	.LLST11
	.4byte	.LVUS11
	.uleb128 0x17
	.4byte	0x1cc
	.uleb128 0x5
	.4byte	0x1c1
	.4byte	.LLST12
	.4byte	.LVUS12
	.uleb128 0x5
	.4byte	0x1b6
	.4byte	.LLST13
	.4byte	.LVUS13
	.uleb128 0xc
	.4byte	0x1f5
	.4byte	.LLST14
	.4byte	.LVUS14
	.uleb128 0xc
	.4byte	0x1ff
	.4byte	.LLST15
	.4byte	.LVUS15
	.byte	0
	.byte	0
	.uleb128 0x18
	.4byte	.LASF25
	.byte	0x1
	.byte	0x2e
	.byte	0xe
	.4byte	0x41
	.byte	0x1
	.4byte	0x209
	.uleb128 0x7
	.4byte	.LASF12
	.byte	0x2e
	.byte	0x21
	.4byte	0x41
	.uleb128 0x8
	.string	"len"
	.byte	0x2e
	.byte	0x2f
	.4byte	0x2e
	.uleb128 0x8
	.string	"f"
	.byte	0x2f
	.byte	0x19
	.4byte	0x41
	.uleb128 0x8
	.string	"f2"
	.byte	0x2f
	.byte	0x22
	.4byte	0x41
	.uleb128 0x7
	.4byte	.LASF13
	.byte	0x2f
	.byte	0x2c
	.4byte	0x41
	.uleb128 0x7
	.4byte	.LASF14
	.byte	0x2f
	.byte	0x38
	.4byte	0x41
	.uleb128 0xd
	.string	"sp"
	.byte	0x31
	.byte	0xc
	.4byte	0x209
	.uleb128 0xd
	.string	"i"
	.byte	0x32
	.byte	0x9
	.4byte	0x43
	.byte	0
	.uleb128 0x6
	.4byte	0x41
	.uleb128 0x19
	.4byte	.LASF26
	.byte	0x1
	.byte	0x24
	.byte	0x6
	.8byte	.LFB54
	.8byte	.LFE54-.LFB54
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0xe
	.4byte	.LASF17
	.byte	0x1b
	.8byte	.LFB53
	.8byte	.LFE53-.LFB53
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2e7
	.uleb128 0x3
	.4byte	.LASF15
	.byte	0x1b
	.byte	0x1b
	.4byte	0x209
	.4byte	.LLST5
	.4byte	.LVUS5
	.uleb128 0x3
	.4byte	.LASF16
	.byte	0x1b
	.byte	0x29
	.4byte	0x41
	.4byte	.LLST6
	.4byte	.LVUS6
	.uleb128 0x1a
	.4byte	.LASF27
	.4byte	0x2f7
	.uleb128 0x9
	.byte	0x3
	.8byte	__PRETTY_FUNCTION__.0
	.uleb128 0x1b
	.8byte	.LVL12
	.4byte	0x2fc
	.4byte	0x2ac
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x9
	.byte	0x3
	.8byte	save_stack
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xa3
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x5
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x23
	.uleb128 0x10
	.byte	0
	.uleb128 0x1c
	.8byte	.LVL16
	.4byte	0x93
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC1
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC0
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x4d
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x9
	.byte	0x3
	.8byte	.LANCHOR0
	.byte	0
	.byte	0
	.uleb128 0x1d
	.4byte	0x7b
	.4byte	0x2f7
	.uleb128 0x1e
	.4byte	0x3a
	.byte	0xd
	.byte	0
	.uleb128 0x9
	.4byte	0x2e7
	.uleb128 0xe
	.4byte	.LASF18
	.byte	0x12
	.8byte	.LFB52
	.8byte	.LFE52-.LFB52
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x37a
	.uleb128 0x3
	.4byte	.LASF19
	.byte	0x12
	.byte	0x15
	.4byte	0x38a
	.4byte	.LLST1
	.4byte	.LVUS1
	.uleb128 0x3
	.4byte	.LASF15
	.byte	0x12
	.byte	0x32
	.4byte	0x209
	.4byte	.LLST2
	.4byte	.LVUS2
	.uleb128 0x3
	.4byte	.LASF16
	.byte	0x12
	.byte	0x40
	.4byte	0x41
	.4byte	.LLST3
	.4byte	.LVUS3
	.uleb128 0x1f
	.string	"sp"
	.byte	0x1
	.byte	0x14
	.byte	0xb
	.4byte	0x41
	.4byte	.LLST4
	.4byte	.LVUS4
	.uleb128 0x20
	.8byte	.LVL7
	.uleb128 0x3
	.byte	0xa3
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x3
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.byte	0
	.uleb128 0x21
	.4byte	0x38a
	.uleb128 0x4
	.4byte	0x209
	.uleb128 0x4
	.4byte	0x209
	.byte	0
	.uleb128 0x6
	.4byte	0x37a
	.uleb128 0x22
	.4byte	.LASF28
	.byte	0x1
	.byte	0x9
	.byte	0xd
	.8byte	.LFB51
	.8byte	.LFE51-.LFB51
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x3
	.4byte	.LASF20
	.byte	0x9
	.byte	0x1f
	.4byte	0x209
	.4byte	.LLST0
	.4byte	.LVUS0
	.uleb128 0xa
	.string	"sp"
	.byte	0x9
	.byte	0x2c
	.4byte	0x209
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x49
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x7e
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x87
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x83
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.4byte	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.2byte	0x5
	.byte	0x8
	.byte	0
	.4byte	0
.Ldebug_loc0:
.LVUS7:
	.uleb128 0
	.uleb128 .LVU51
	.uleb128 .LVU51
	.uleb128 0
.LLST7:
	.byte	0x4
	.uleb128 .LVL17-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL19-.Ltext0
	.uleb128 .LFE56-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.byte	0
.LVUS8:
	.uleb128 0
	.uleb128 .LVU50
	.uleb128 .LVU50
	.uleb128 .LVU55
	.uleb128 .LVU55
	.uleb128 0
.LLST8:
	.byte	0x4
	.uleb128 .LVL17-.Ltext0
	.uleb128 .LVL18-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL18-.Ltext0
	.uleb128 .LVL21-.Ltext0
	.uleb128 0x4
	.byte	0x71
	.sleb128 256
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL21-.Ltext0
	.uleb128 .LFE56-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0
.LVUS9:
	.uleb128 .LVU47
	.uleb128 .LVU69
.LLST9:
	.byte	0x4
	.uleb128 .LVL17-.Ltext0
	.uleb128 .LVL28-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0
.LVUS10:
	.uleb128 .LVU47
	.uleb128 .LVU69
.LLST10:
	.byte	0x4
	.uleb128 .LVL17-.Ltext0
	.uleb128 .LVL28-.Ltext0
	.uleb128 0x1
	.byte	0x53
	.byte	0
.LVUS11:
	.uleb128 .LVU47
	.uleb128 .LVU69
.LLST11:
	.byte	0x4
	.uleb128 .LVL17-.Ltext0
	.uleb128 .LVL28-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0
.LVUS12:
	.uleb128 .LVU47
	.uleb128 .LVU50
	.uleb128 .LVU50
	.uleb128 .LVU55
	.uleb128 .LVU55
	.uleb128 .LVU69
.LLST12:
	.byte	0x4
	.uleb128 .LVL17-.Ltext0
	.uleb128 .LVL18-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL18-.Ltext0
	.uleb128 .LVL21-.Ltext0
	.uleb128 0x4
	.byte	0x71
	.sleb128 256
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL21-.Ltext0
	.uleb128 .LVL28-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0
.LVUS13:
	.uleb128 .LVU47
	.uleb128 .LVU51
	.uleb128 .LVU51
	.uleb128 .LVU69
.LLST13:
	.byte	0x4
	.uleb128 .LVL17-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL19-.Ltext0
	.uleb128 .LVL28-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.byte	0
.LVUS14:
	.uleb128 .LVU52
	.uleb128 .LVU69
.LLST14:
	.byte	0x4
	.uleb128 .LVL20-.Ltext0
	.uleb128 .LVL28-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0
.LVUS15:
	.uleb128 .LVU53
	.uleb128 .LVU54
	.uleb128 .LVU54
	.uleb128 .LVU57
	.uleb128 .LVU57
	.uleb128 .LVU59
	.uleb128 .LVU59
	.uleb128 .LVU61
	.uleb128 .LVU61
	.uleb128 .LVU63
	.uleb128 .LVU63
	.uleb128 .LVU65
	.uleb128 .LVU65
	.uleb128 .LVU67
	.uleb128 .LVU67
	.uleb128 0
.LLST15:
	.byte	0x4
	.uleb128 .LVL20-.Ltext0
	.uleb128 .LVL20-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL20-.Ltext0
	.uleb128 .LVL22-.Ltext0
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL22-.Ltext0
	.uleb128 .LVL23-.Ltext0
	.uleb128 0x2
	.byte	0x32
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL23-.Ltext0
	.uleb128 .LVL24-.Ltext0
	.uleb128 0x2
	.byte	0x33
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LVL25-.Ltext0
	.uleb128 0x2
	.byte	0x34
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL25-.Ltext0
	.uleb128 .LVL26-.Ltext0
	.uleb128 0x2
	.byte	0x35
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL26-.Ltext0
	.uleb128 .LVL27-.Ltext0
	.uleb128 0x2
	.byte	0x36
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LFE56-.Ltext0
	.uleb128 0x2
	.byte	0x37
	.byte	0x9f
	.byte	0
.LVUS5:
	.uleb128 0
	.uleb128 .LVU40
	.uleb128 .LVU40
	.uleb128 .LVU41
	.uleb128 .LVU41
	.uleb128 .LVU42
	.uleb128 .LVU42
	.uleb128 .LVU44
	.uleb128 .LVU44
	.uleb128 0
.LLST5:
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL11-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL11-.Ltext0
	.uleb128 .LVL12-1-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL12-1-.Ltext0
	.uleb128 .LVL13-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL13-.Ltext0
	.uleb128 .LVL15-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL15-.Ltext0
	.uleb128 .LFE53-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.byte	0
.LVUS6:
	.uleb128 0
	.uleb128 .LVU39
	.uleb128 .LVU39
	.uleb128 .LVU41
	.uleb128 .LVU41
	.uleb128 .LVU42
	.uleb128 .LVU42
	.uleb128 .LVU43
	.uleb128 .LVU43
	.uleb128 0
.LLST6:
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL10-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL10-.Ltext0
	.uleb128 .LVL12-1-.Ltext0
	.uleb128 0x3
	.byte	0x72
	.sleb128 -16
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL12-1-.Ltext0
	.uleb128 .LVL13-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL13-.Ltext0
	.uleb128 .LVL14-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL14-.Ltext0
	.uleb128 .LFE53-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0
.LVUS1:
	.uleb128 0
	.uleb128 .LVU26
	.uleb128 .LVU26
	.uleb128 .LVU32
	.uleb128 .LVU32
	.uleb128 0
.LLST1:
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LVL4-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL4-.Ltext0
	.uleb128 .LVL7-1-.Ltext0
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL7-1-.Ltext0
	.uleb128 .LFE52-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.byte	0
.LVUS2:
	.uleb128 0
	.uleb128 .LVU30
	.uleb128 .LVU30
	.uleb128 .LVU32
	.uleb128 .LVU32
	.uleb128 0
.LLST2:
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LVL5-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL5-.Ltext0
	.uleb128 .LVL7-1-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL7-1-.Ltext0
	.uleb128 .LFE52-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0
.LVUS3:
	.uleb128 0
	.uleb128 .LVU32
	.uleb128 .LVU32
	.uleb128 .LVU34
	.uleb128 .LVU34
	.uleb128 0
.LLST3:
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LVL7-1-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL7-1-.Ltext0
	.uleb128 .LVL8-.Ltext0
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.byte	0x4
	.uleb128 .LVL8-.Ltext0
	.uleb128 .LFE52-.Ltext0
	.uleb128 0x2
	.byte	0x8f
	.sleb128 -8
	.byte	0
.LVUS4:
	.uleb128 .LVU30
	.uleb128 .LVU31
	.uleb128 .LVU31
	.uleb128 .LVU32
.LLST4:
	.byte	0x4
	.uleb128 .LVL5-.Ltext0
	.uleb128 .LVL6-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL6-.Ltext0
	.uleb128 .LVL7-1-.Ltext0
	.uleb128 0x3
	.byte	0x71
	.sleb128 16
	.byte	0x9f
	.byte	0
.LVUS0:
	.uleb128 0
	.uleb128 .LVU12
	.uleb128 .LVU12
	.uleb128 .LVU14
	.uleb128 .LVU14
	.uleb128 0
.LLST0:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL2-.Ltext0
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.byte	0x4
	.uleb128 .LVL2-.Ltext0
	.uleb128 .LFE51-.Ltext0
	.uleb128 0x2
	.byte	0x8f
	.sleb128 -8
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	0
	.8byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF28:
	.string	"save_stack"
.LASF23:
	.string	"__assert_fail"
.LASF17:
	.string	"switch_thread"
.LASF12:
	.string	"stack"
.LASF16:
	.string	"new_sp"
.LASF15:
	.string	"old_sp"
.LASF27:
	.string	"__PRETTY_FUNCTION__"
.LASF13:
	.string	"arg1"
.LASF14:
	.string	"arg2"
.LASF3:
	.string	"unsigned char"
.LASF26:
	.string	"trampoline"
.LASF4:
	.string	"short unsigned int"
.LASF22:
	.string	"size_t"
.LASF19:
	.string	"save"
.LASF2:
	.string	"long unsigned int"
.LASF18:
	.string	"_switch"
.LASF5:
	.string	"unsigned int"
.LASF11:
	.string	"long long unsigned int"
.LASF10:
	.string	"long long int"
.LASF20:
	.string	"p_sp"
.LASF9:
	.string	"char"
.LASF21:
	.string	"GNU C17 11.4.0 -mlittle-endian -mabi=lp64 -g -O -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection"
.LASF7:
	.string	"short int"
.LASF8:
	.string	"long int"
.LASF25:
	.string	"_setup_stack"
.LASF24:
	.string	"setup_stack"
.LASF6:
	.string	"signed char"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/cs3650/2019-hw2"
.LASF0:
	.string	"switch-arm.c"
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
