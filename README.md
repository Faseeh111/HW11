# HW11

How to use my code:

nasm -f elf32 -g -F dwarf -o hw11translate2Ascii.o hw11translate2Ascii.asm
ld -m elf_i386 -o hw11translate2Ascii hw11translate2Ascii.o
db  0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A 
./hw11translate2Ascii
