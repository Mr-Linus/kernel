#include "console.h"
#include "debug.h"
int kern_entry()
{
	init_debug();

	console_clear();

	printk_color(rc_black, rc_green, "Hello, CherryOS kernel!\n");

	print_cur_status();

	panic("debug-panic");

	return 0;

}
