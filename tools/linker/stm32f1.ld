ENTRY(Reset_Handler)

/* Memories definition */
MEMORY
{
	FLASH   (rx)    	: ORIGIN = 0x08000000,  LENGTH = 64K
  SRAM    (xrw)    	: ORIGIN = 0x20000000,  LENGTH = 20K
}

SECTIONS
{
	.text :
	{
		*(.isr_vector)
		*(.text)
		*(.rodata)
		. = ALIGN(4);
		_etext = .;
	} > FLASH

	_la_data = LOADADDR(.data);
	
	.data :
	{
		_sdata = .;
		*(.data)
		. = ALIGN(4);
		_edata = .;
	} > SRAM AT > FLASH
	.bss :
	{
		_sbss = .;
		*(.bss)
		*(COMMON)
		. = ALIGN(4);
		_ebss = .;
	} > SRAM
}