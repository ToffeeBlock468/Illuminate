ENTRY(_reset)



SECTIONS
{
	/* U-Boot loads the kernel here */
	. = 0x40400000;

	.text : {
		/*KEEP(*(.text.isr_vectors));*/
		KEEP(*(.text.startup));
		*(.text*)
		*(.rodata*)
	}

	.data : {
		*(.data*);
	}

	.bss : {
		*(.bss*)
		*(COMMON)
	}

	__stack_start = ADDR(.bss) + SIZEOF(.bss);
	__stack_end = __stack_start + 0x10000;

	/* Page tables */
	. = ALIGN(0x1000);
	ttbr0_base = .;
	. = . + 0x1000;
}
