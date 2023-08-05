#include <kstdio.h>
#include <stdint.h>
#include <arm64/syscall.h>
#include <arm64/exception.h>


static void exc_halt(stack_frame_t *frame) {
	printf("\033[1;31m*** ToyOS exception ***\033[0m\n\n");

	printf("X0: 0x%08X X1: 0x%08X X2: 0x%08X X3: 0x%08X\n", frame->x0, frame->x1, frame->x2, frame->x3);
	printf("X4: 0x%08X X5: 0x%08X X6: 0x%08X X7: 0x%08X\n", frame->x4, frame->x5, frame->x6, frame->x7);
	printf("X8: 0x%08X X9: 0x%08X X10: 0x%08X X11: 0x%08X\n", frame->x8, frame->x9, frame->x10, frame->x11);
	printf("X12: 0x%08X X13: 0x%08X X14: 0x%08X X15: 0x%08X\n", frame->x12, frame->x13, frame->x14, frame->x15);
	printf("X16: 0x%08X X17: 0x%08X X18: 0x%08X X19: 0x%08X\n", frame->x16, frame->x17, frame->x18, frame->x19);
	printf("X20: 0x%08X X21: 0x%08X X22: 0x%08X X23: 0x%08X\n", frame->x20, frame->x21, frame->x22, frame->x23);
	printf("X24: 0x%08X X25: 0x%08X X26: 0x%08X X27: 0x%08X\n", frame->x24, frame->x25, frame->x26, frame->x27);
	printf("X28: 0x%08X X29: 0x%08X X30: 0x%08X\n\n", frame->x28, frame->x29, frame->x30);

	printf("SP: 0x%08X ESR: 0x%08X ELR: 0x%08X SPSR: 0x%08X\n", frame->sp, frame->esr, frame->elr, frame->spsr);

	switch(frame->esr >> 26) {
		case 0b000000:
			printf("Unknown exception!\n");
			break;
	}

	while(1);
}

void exc_handler(stack_frame_t *frame) {
	switch(frame->esr >> 26) {
		case 0x15:
			syscall_handler(frame);
			break;

		case 0x16:
			// HVC
			break;

		case 0x17:
			// SMC
			break;

		case 0x18:
			// SYS
			break;

		default:
			exc_halt(frame);
			break;
	}
}
