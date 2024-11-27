section .data
    prompt_msg db "Enter water level (0-100 ): ", 0    ; Prompt message
    motor_on_msg db "Motor is ON", 0                     ; Message: Motor ON
    motor_off_msg db "Motor is OFF", 0                   ; Message: Motor OFF
    alarm_msg db "ALARM: Water level too high!", 0       ; Message: Alarm triggered
    normal_msg db "Water level is normal", 0             ; Message: Normal water level
    newline db 10, 0                                    ; New line for output

section .bss
    sensor_value resb 5                                  ; Buffer for the sensor input (water level)
    motor_control resb 1                                  ; Memory location for motor control (0=OFF, 1=ON)
    alarm_control resb 1                                  ; Memory location for alarm control (0=OFF, 1=ON)

section .text
    global _start

_start:
    ; Prompt user to enter water level
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; file descriptor: stdout
    mov rsi, prompt_msg     ; message address
    mov rdx, 23             ; message length
    syscall

    ; Read the water level (sensor value)
    mov rax, 0              ; syscall: read
    mov rdi, 0              ; file descriptor: stdin
    mov rsi, sensor_value   ; buffer address
    mov rdx, 5              ; buffer size (allow space for 4 digits and null terminator)
    syscall

    ; Convert the input string to an integer (base 10)
    ; Initialize registers for the conversion
    xor rbx, rbx            ; Clear rbx, will be used to accumulate the result
    xor rcx, rcx            ; Clear rcx, used as counter (digit counter)

convert_loop:
    movzx rdx, byte [sensor_value + rcx]   ; Load next byte (character) from the input string
    cmp rdx, 10                          ; Check if it is the newline character (end of input)
    je done_convert                       ; If newline, end the conversion
    sub rdx, '0'                          ; Convert ASCII to integer
    imul rbx, rbx, 10                     ; Multiply current result by 10 (shift left)
    add rbx, rdx                          ; Add the new digit to the result
    inc rcx                               ; Move to the next character
    jmp convert_loop

done_convert:
    ; Now the water level value is in rbx

    ; Perform actions based on the water level (in rbx)
    cmp rbx, 80              ; Check if water level is above 80 (too high)
    jge high_water_level     ; Jump if water level is high

    cmp rbx, 30              ; Check if water level is above 30 (moderate)
    jge moderate_water_level ; Jump if water level is moderate

    ; Default: Low water level - Turn off motor and no alarm
    mov byte [motor_control], 0   ; Turn off motor
    mov byte [alarm_control], 0   ; No alarm
    jmp normal_level

high_water_level:
    ; Water level is too high, turn on alarm and turn off motor
    mov byte [alarm_control], 1   ; Trigger alarm
    mov byte [motor_control], 0   ; Turn off motor
    jmp print_alarm

moderate_water_level:
    ; Water level is moderate, turn on motor and no alarm
    mov byte [motor_control], 1   ; Turn on motor
    mov byte [alarm_control], 0   ; No alarm
    jmp print_motor

normal_level:
    ; Water level is normal, turn off motor and no alarm
    mov byte [motor_control], 0   ; Turn off motor
    mov byte [alarm_control], 0   ; No alarm
    jmp print_normal

print_motor:
    ; Print "Motor is ON" message
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; file descriptor: stdout
    mov rsi, motor_on_msg   ; message address
    mov rdx, 14             ; message length
    syscall
    jmp print_newline

print_alarm:
    ; Print "ALARM: Water level too high!" message
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; file descriptor: stdout
    mov rsi, alarm_msg      ; message address
    mov rdx, 25             ; message length
    syscall
    jmp print_newline

print_normal:
    ; Print "Water level is normal" message
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; file descriptor: stdout
    mov rsi, normal_msg     ; message address
    mov rdx, 19             ; message length
    syscall
    jmp print_newline

print_newline:
    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Exit program
    mov rax, 60             ; syscall: exit
    xor rdi, rdi            ; return code: 0
    syscall
