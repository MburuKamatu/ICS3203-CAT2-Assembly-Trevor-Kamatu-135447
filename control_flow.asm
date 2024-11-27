section .data
    prompt db "Enter a number: ", 0
    pos_msg db "POSITIVE", 0
    neg_msg db "NEGATIVE", 0
    zero_msg db "ZERO", 0

section .bss
    num resb 4

section .text
    global _start

_start:
    ; Prompt the user
    mov rax, 1           ; syscall: write
    mov rdi, 1           ; file descriptor: stdout
    mov rsi, prompt      ; message address
    mov rdx, 14          ; message length
    syscall

    ; Read input
    mov rax, 0           ; syscall: read
    mov rdi, 0           ; file descriptor: stdin
    mov rsi, num         ; buffer address
    mov rdx, 4           ; buffer size
    syscall

    ; Convert input to integer
    mov rax, [num]       ; load input into rax
    sub rax, 48          ; convert ASCII to integer

    ; Conditional logic
    cmp rax, 0
    je zero              ; jump if zero
    jl negative          ; jump if less than zero

positive:
    mov rsi, pos_msg
    jmp print_message

negative:
    mov rsi, neg_msg
    jmp print_message

zero:
    mov rsi, zero_msg

print_message:
    mov rax, 1
    mov rdi, 1
    mov rdx, 8           ; length of message
    syscall

    ; Exit program
    mov rax, 60          ; syscall: exit
    xor rdi, rdi         ; return code: 0
    syscall
