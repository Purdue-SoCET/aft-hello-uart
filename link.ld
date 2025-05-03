SECTIONS
{
  . = 0x8400;
  .text : { *(.text) }
  .data : { *(.data) }
  .bss  : { *(.bss) }
  /* Align to the next 4-byte boundary after all sections */
  . = ALIGN(4);
  _end = .;
}