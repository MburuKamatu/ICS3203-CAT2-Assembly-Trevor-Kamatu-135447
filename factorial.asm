section .data
    prompt_msg db 'Enter a number (1-8): '
    prompt_len equ $ - prompt_msg
    result_msg1 db 'The factorial of:', 10  ; First line with newline
    result_len1 equ $ - result_msg1
    result_msg2 db 'The factorial is:', 10  ; Second line with newline
    result_len2 equ $ - result_msg2
    newline db 10

section .bss
    input resb 2
    output resb 32

section .text
    global _start

_start:
    ; Print prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_msg
    mov edx, prompt_len
    int 80h

    ; Read input
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 2
    int 80h

    ; Convert ASCII to number
    movzx eax, byte [input]
    sub eax, '0'
    push eax            ; Save original input

    ; Print first line
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg1
    mov edx, result_len1
    int 80h

    ; Print second line
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg2
    mov edx, result_len2
    int 80h

    ; Print input number
    mov al, [input]
    mov [output], al
    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, 1
    int 80h

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    ; Calculate factorial
    pop eax             ; Restore input number
    call factorial

    ; Convert result to string
    mov ecx, output
    add ecx, 31         ; Point to end of buffer
    mov byte [ecx], 0   ; Null terminate
    mov ebx, 10

convert:
    xor edx, edx
    div ebx
    add dl, '0'         ; Convert remainder to ASCII
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz convert

    ; Print result
    mov edx, output
    add edx, 31
    sub edx, ecx        ; Calculate length
    mov eax, 4
    mov ebx, 1
    int 80h

    ; Print final newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 80h

factorial:
    push ebp
    mov ebp, esp
    push ebx
    push ecx

    cmp eax, 0
    je return_one
    
    mov ecx, eax        ; Counter
    dec ecx             ; Start with n-1

multiply_loop:
    cmp ecx, 1
    jbe factorial_done  ; If counter <= 1, we're done
    mul ecx             ; EAX = EAX * ECX
    dec ecx
    jmp multiply_loop

return_one:
    mov eax, 1

factorial_done:
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret