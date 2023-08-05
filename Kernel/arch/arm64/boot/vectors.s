.section .text.startup
.global _vector_table


.equ ARM64_SP0_SYNC, 	0x1
.equ ARM64_SP0_IRQ,		0x2
.equ ARM64_SP0_FIQ,		0x3
.equ ARM64_SP0_SERR,	0x4

.equ ARM64_SPX_SYNC,	0x11
.equ ARM64_SPX_IRQ,		0x12
.equ ARM64_SPX_FIQ,		0x13
.equ ARM64_SPX_SERR,	0x14


.macro save_context64 exc_type
	// Save LR and FP
	stp x29, x30, [sp, #-32]!

	// Save gp registers
	stp x27, x28, [sp, #-32]!
	stp x25, x26, [sp, #-32]!
	stp x23, x24, [sp, #-32]!
	stp x21, x22, [sp, #-32]!
	stp x19, x20, [sp, #-32]!
	stp x17, x18, [sp, #-32]!
	stp x15, x16, [sp, #-32]!
	stp x13, x14, [sp, #-32]!
	stp x11, x12, [sp, #-32]!
	stp x9, x10, [sp, #-32]!
	stp x7, x8, [sp, #-32]!
	stp x5, x6, [sp, #-32]!
	stp x3, x4, [sp, #-32]!
	stp x1, x2, [sp, #-32]!
	stp x0, xzr, [sp, #-32]!

	mrs x21, spsr_el1
	stp x21, x0, [sp, #-32]!

	mrs x21, elr_el1
	stp x21, xzr, [sp, #-32]!

	mov x21, #(\exc_type)
	mrs x22, esr_el1
	stp x21, x22, [sp, #-32]!
.endm

.macro restore_context64
	add sp, sp, #32

	ldp x21, xzr, [sp], #32
	msr elr_el1, x21

	ldp x21, x0, [sp], #32
	msr spsr_el1, x21

	ldp x0, xzr, [sp], #32
	ldp x1, x2, [sp], #32
	ldp x3, x4, [sp], #32
	ldp x5, x6, [sp], #32
	ldp x7, x8, [sp], #32
	ldp x9, x10, [sp], #32
	ldp x11, x12, [sp], #32
	ldp x13, x14, [sp], #32
	ldp x15, x16, [sp], #32
	ldp x17, x18, [sp], #32
	ldp x19, x20, [sp], #32
	ldp x21, x22, [sp], #32
	ldp x23, x24, [sp], #32
	ldp x25, x26, [sp], #32
	ldp x27, x28, [sp], #32
	ldp x29, x30, [sp], #32
.endm



.balign 0x200
_vector_table:
	// Current exception level with SP0
	b _curr_el_sp0_sync

	.balign 0x80
	b _curr_el_sp0_irq

	.balign 0x80
	b _curr_el_sp0_fiq

	.balign 0x80
	b _curr_el_sp0_serror

	// Current exception level with SPX
	.balign 0x80
	b _curr_el_spx_sync

	.balign 0x80
	b _curr_el_spx_irq

	.balign 0x80
	b _curr_el_spx_fiq

	.balign 0x80
	b _curr_el_spx_serror

	// Lower exception level in AARCH64 mode
	.balign 0x80
	b _low_el_aarch64_sync

	.balign 0x80
	b _low_el_aarch64_irq

	.balign 0x80
	b _low_el_aarch64_fiq

	.balign 0x80
	b _low_el_aarch64_serror

	// Lower exception level in AARCH32 mode
	.balign 0x80
	b _low_el_aarch32_sync

	.balign 0x80
	b _low_el_aarch32_irq

	.balign 0x80
	b _low_el_aarch32_fiq

	.balign 0x80
	b _low_el_aarch32_serror


// SP0
_curr_el_sp0_sync:
	save_context64 ARM64_SP0_SYNC

	mov x0, sp
	bl exc_handler

	restore_context64
	eret

_curr_el_sp0_irq:
	save_context64 ARM64_SP0_IRQ

	mov x0, sp
	bl irq_handler

	restore_context64
	eret

_curr_el_sp0_fiq:
	save_context64 ARM64_SP0_FIQ

	mov x0, sp
	bl irq_handler

	restore_context64
	eret

_curr_el_sp0_serror:
	save_context64 ARM64_SP0_SERR

	mov x0, sp
	bl exc_handler

	restore_context64
	eret


// SPX
_curr_el_spx_sync:
	// Save current context
	save_context64 ARM64_SPX_SYNC

	// Handle exception
	mov x0, sp
	bl exc_handler

	// Restore context and return
	restore_context64
	eret

_curr_el_spx_irq:
	save_context64 ARM64_SPX_IRQ

	mov x0, sp
	bl irq_handler

	restore_context64
	eret

_curr_el_spx_fiq:
	save_context64 ARM64_SPX_FIQ

	mov x0, sp
	bl irq_handler

	restore_context64
	eret

_curr_el_spx_serror:
	save_context64 ARM64_SPX_SERR

	mov x0, sp
	bl exc_handler

	restore_context64
	eret

// AARCH64 (lower exception level)
_low_el_aarch64_sync:
	save_context64 0

	mov x0, sp
	bl exc_handler

	restore_context64
	eret

_low_el_aarch64_irq:
	save_context64 0

	mov x0, sp
	bl irq_handler

	restore_context64
	eret

_low_el_aarch64_fiq:
	save_context64 0

	mov x0, sp
	bl irq_handler

	restore_context64
	eret

_low_el_aarch64_serror:
	save_context64 0

	mov x0, sp
	bl exc_handler

	restore_context64
	eret


// AARCH32 (lower exception level)
_low_el_aarch32_sync:
	b .

_low_el_aarch32_irq:
	b .

_low_el_aarch32_fiq:
	b .

_low_el_aarch32_serror:
	b .
