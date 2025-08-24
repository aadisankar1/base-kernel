/* linker.ld - link kernel into a GRUB-friendly ELF at 0x00100000 */
ENTRY(start)

OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)

SECTIONS
{
  . = 0x00100000;

  .multiboot : { *(.multiboot) }

  .text : { *(.text*) }
  .rodata : { *(.rodata*) }
  .data : { *(.data*) }
  .bss : { *(.bss*) *(COMMON) }
}
