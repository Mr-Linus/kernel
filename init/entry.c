#include "console.h"
#include "debug.h"
int kern_entry()
{
init_debug();

	console_clear();

	printk_color(rc_black, rc_green, "Hello, OS kernel!\n");

	panic("test");

	return 0;

}
