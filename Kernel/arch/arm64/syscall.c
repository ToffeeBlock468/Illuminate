#include <kstdio.h>
#include <arm64/exception.h>
#include <syscall.h>
#include <stddef.h>



uint64_t (*syscall_table[291])() = {
	NULL,
};



void syscall_handler(stack_frame_t *frame) {
	frame->x8 = frame->x0;

	printf("X8: 0x%08X\n", frame->x8);
}
