#include <kstdio.h>
#include <string.h>
#include <arm64/arch.h>





uint32_t get_icc_ctl(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_ctlr_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_ctl(uint32_t x) {
	__asm__ volatile("msr icc_ctlr_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

uint32_t get_icc_bpr0(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_bpr0_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_bpr0(uint32_t x) {
	__asm__ volatile("msr icc_bpr0_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

uint32_t get_icc_bpr1(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_bpr1_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_bpr1(uint32_t x) {
		__asm__ volatile("msr icc_bpr1_el1, %0\n\t"
						 : : "r"(x) : "memory");
}

uint32_t get_icc_dir(void) {
	uint32_t x = 0;

	__asm__ volatile("msr icc_dir_el1, %0\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_dir(uint32_t x) {
	__asm__ volatile("msr icc_dir_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

/*
uint32_t get_icc_eoir0(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_eoir0_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_eoir0(uint32_t x) {
	__asm__ volatile("msr icc_eoir0_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

uint32_t get_icc_eoir1(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_eoir1_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_eoir1(uint32_t x) {
	__asm__ volatile("msr icc_eoir1_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

uint32_t get_icc_hppir0(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_hppir0_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_hppir0(uint32_t x) {
	__asm__ volatile("msr icc_hppir0_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

uint32_t get_icc_hppir1(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_hppir1_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_hppir1(uint32_t x) {
	__asm__ volatile("msr icc_hppir1_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

uint32_t get_icc_iar0(void) {
	uint32_t x = 0;

	//__asm__ volatile("mrs %0, icc_iar0_el1\n\t"

	return x;
}

void set_icc_iar0(uint32_t x) {
	__asm__ volatile("msr icc_iar0_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

uint32_t get_icc_iar1(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_iar1_el1\n\n"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_iar1(uint32_t x) {
	__asm__ volatile("msr icc_iar1_el1, %0\n\t"
					 : : "r"(x) : "memory");
}
*/

uint32_t get_icc_igrpen0(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_igrpen0_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_igrpen0(uint32_t x) {
	__asm__ volatile("msr icc_igrpen0_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

uint32_t get_icc_igrpen1(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_igrpen1_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_igrpen1(uint32_t x) {
	__asm__ volatile("msr icc_igrpen1_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

uint32_t get_icc_pmr(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_pmr_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_pmr(uint32_t x) {
	__asm__ volatile("msr icc_pmr_el1, %0\n\t"
					 : : "r"(x) : "memory");
}

uint32_t get_icc_rpr(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_rpr_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

/*
void set_icc_rpr(uint32_t x) {
	__asm__ volatile("msr icc_rpr_el1, %0\n\t"
					 : : "r"(x) : "memory");
}
*/


uint32_t get_icc_sre(void) {
	uint32_t x = 0;

	__asm__ volatile("mrs %0, icc_sre_el1\n\t"
					 : "=r"(x) : : "memory");

	return x;
}

void set_icc_sre(uint32_t x) {
	__asm__ volatile("msr icc_sre_el1, %0\n\t"
					 : : "r"(x) : "memory");
}
