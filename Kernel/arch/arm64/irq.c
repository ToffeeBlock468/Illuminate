#include <kstdio.h>
#include <stdint.h>
#include <arm64/irq.h>
#include <arm64/exception.h>







void irq_handler(stack_frame_t *frame) {
	printf("IRQ!\n");
}
