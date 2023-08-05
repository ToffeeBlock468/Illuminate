.section .text.startup
.global _reset


.equ TTBR_FAULT,		0x0
.equ TTBR_NORMAL_NC,	0x00000000000000401
.equ TTBR_WBWA,			0x00000000000000405
.equ TTBR_nGnRnE,		0x00000000000000409

.equ TTBR_BLOCK,		0x20000000000705
.EQU TTBR_PAGE,			0x20000000000707

.equ PT_UNX,	(1 << 54)
.equ PT_PNX,	(1 << 53)
.equ PT_NG,		(1 << 11)
.equ PT_NS,		(1 << 5)

.equ PT_NON_SHARED,		(0 << 8)
.equ PT_INNER_SHARED,	(3 << 8)
.equ PT_OUTTER_SHARED,	(2 << 8)

.equ PT_PRIV_RW,	(0x0)
.equ PT_PRIV_RO,	(0x2 << 6)
.equ PT_USER_RW,	(0x1 << 6)
.equ PT_USER_RO,	(0x3 << 6)



_reset:
	// Ensure we're the primary core
	mrs x0, mpidr_el1
	and x0, x0, #3
	cmp x0, #0
	bne _halt

	// Set VBAR to point to our vector table
	adr x0, _vector_table
	msr vbar_el1, x0

	// Disable interrupts
	msr daifset, #0x3

	// Setup inital stack space
	ldr x0, =__stack_start
	mov sp, x0

	// Initialize user stack (for now)
	//ldr x0, =__user_stack_start
	//msr sp_el0, x0

	// Disable MMU
	mrs x0, sctlr_el1
	bic x0, x0, #(1 << 0)
	bic x0, x0, #(1 << 2)
	bic x0, x0, #(1 << 12)
	msr sctlr_el1, x0
	isb

	// Invalidate caches, etc
	tlbi vmalle1
	dsb sy
	isb

	mov x0, #19
	orr x0, x0, #(0x1 << 8)
	orr x0, x0, #(0x1 << 10)
	orr x0, x0, #(0x3 << 12)
	msr tcr_el1, x0

	mov x0, #0x000000000000FF44
	msr mair_el1, x0

	// Setup single level 1:1 mapping. This will get the
	// MMU up early so the kernel can swap in new page
	// page tables
	ldr x0, =ttbr0_base

	// [0]: 0x00000000 - 0x3FFFFFFF
	ldr x1, =TTBR_nGnRnE
	str x1, [x0]

	// [1]: 0x40000000 - 0x7FFFFFFF
	ldr x1, =TTBR_WBWA
	orr x1, x1, #0x40000000
	str x1, [x0, #8]

	// Load TTBR0_EL1
	msr ttbr0_el1, x0
	isb

	// Enable MMU and caches
	mrs x0, sctlr_el1
	orr x0, x0, #(1 << 0)
	orr x0, x0, #(1 << 2)
	orr x0, x0, #(1 << 12)
	msr sctlr_el1, x0
	dsb sy
	isb

	// Allow MMU to settle
	nop
	nop
	nop
	nop

	// Enable interrupts
	msr daifclr, #0x3

main_label:
	// Start main application
	bl init_main


_halt:
	wfi
	b _halt
