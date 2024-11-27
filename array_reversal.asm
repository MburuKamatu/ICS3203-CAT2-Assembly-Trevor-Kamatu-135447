section .data
    msg_positive db "POSITIVE", 0
    msg_negative db "NEGATIVE", 0
    msg_zero db "ZERO", 0

section .bss
    num resb 4

section .text
    global _start

_start:
    ; Read input number
    mov eax, 3          
    mov ebx, 0
    mov ecx, num
    mov edx, 4
    int 0x80

    ; Convert to integer
    mov eax, [num]
    cmp eax, 0
    je is_zero
    jl is_negative
    jmp is_positive

is_positive:
    mov eax, 4          
    mov ebx, 1
    mov ecx, msg_positive
    mov edx, 8
    int 0x80
    jmp exit

is_negative:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_negative
    mov edx, 8
    int 0x80
    jmp exit

is_zero:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_zero
    mov edx, 4
    int 0x80

exit:
    mov eax, 1         
    xor ebx, ebx
    int 0x80