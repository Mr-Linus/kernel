#include "console.h"
#include "debug.h"

int kern_entry()
{
	init_debug();

	init_gdt();
	init_idt();
	console_clear();

	printk_color(rc_black, rc_green, "Hello, CherryOS kernel!\n");

	asm volatile ("int $0x3");
    asm volatile ("int $0x4");

	print_cur_status();

	

	panic("debug-panic");

	return 0;

}
