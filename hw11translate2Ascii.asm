section .data
    inputBuf db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
    inputLen equ 8
    newline db 0xA

section .bss
    outputBuf resb 80

section .text
    global _start

_start:
    mov esi, inputBuf        ; Point to the start of input data
    mov edi, outputBuf       ; Point to output buffer
    mov ecx, inputLen        ; Number of bytes to translate

next_byte:
    lodsb                    ; Load next byte from inputBuf into AL
    mov ah, al               ; Store original byte

    shr al, 4                ; Get high nibble
    call nibble_to_ascii     ; Convert to ASCII character
    stosb                    ; Write to output buffer

    mov al, ah               ; Restore original byte
    and al, 0x0F             ; Get low nibble
    call nibble_to_ascii
    stosb

    mov al, ' '              ; Add space between byte values
    stosb

    loop next_byte

    ; Replace last space with newline
    dec edi
    mov byte [edi], 0xA

    ; Write outputBuf to stdout
    mov eax, 4
    mov ebx, 1
    mov ecx, outputBuf
    mov edx, edi
    sub edx, outputBuf       ; Length = edi - outputBuf
    inc edx                  ; Include newline
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Converts a nibble (0–15) in AL to ASCII '0'–'9' or 'A'–'F'
nibble_to_ascii:
    cmp al, 9
    jbe to_digit
    add al, 0x37             ; For A–F: ASCII = value + ('A' - 10)
    ret

to_digit:
    add al, 0x30             ; For 0–9: ASCII = value + '0'
    ret
