; boot.s
; Tiny NASM stub: Multiboot v1 header, stack setup, call into C kernel_main.
BITS 32

SECTION .multiboot
  align 4
multiboot_header:
  dd 0x1BADB002                ; multiboot magic
  dd 0x00010003                ; flags: request mem info (bit0) and align modules (bit1)
  dd -(0x1BADB002 + 0x00010003)

SECTION .text
global start
extern kernel_main              ; void kernel_main(unsigned long magic, unsigned long mbinfo)

start:
    cli
    xor ebp, ebp

    ; set up a minimal stack (stack_top defined in .bss)
    mov esp, stack_top

    ; according to Multiboot: EAX = magic, EBX = addr of multiboot info
    ; push args right-to-left for cdecl: push second, then first
    push ebx                    ; push mbinfo (2nd arg)
    push eax                    ; push magic (1st arg)
    call kernel_main

.hang:
    hlt
    jmp .hang

SECTION .bss
align 16
stack:
    resb 0x4000               ; 16 KiB stack
stack_top:
