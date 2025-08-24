# Makefile - builds a GRUB-loadable 32-bit ELF kernel
NASM = nasm
CC   = gcc
LD   = ld

ASFLAGS = -f elf32
CFLAGS  = -m32 -ffreestanding -O2 -fno-builtin -fno-stack-protector -nostdlib -fno-pie -Wall -Wextra
LDFLAGS = -m elf_i386

all: kernel.elf

boot.o: boot.s
	$(NASM) $(ASFLAGS) boot.s -o boot.o

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

kernel.elf: boot.o kernel.o linker.ld
	$(LD) $(LDFLAGS) -T linker.ld boot.o kernel.o -o kernel.elf

clean:
	rm -f *.o kernel.elf
