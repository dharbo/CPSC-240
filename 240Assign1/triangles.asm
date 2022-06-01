extern printf
extern scanf
extern sin
extern cos
global triangles

section .data
    text1 db "We take care of all your triangles.", 10, 0
    text2 db "Please enter your name: ", 0
    text3 db "Good morning ", 0
    text4 db ", please enter the length of side 1, length of side2, and size (degrees) of", 10, 0
    text5 db " the included angle between them as real float numbers. Separate the numbers by white", 10, 0
    text6 db " space, and be sure to press <enter> after the last inputted number.", 10, 0
    text7 db "Thank you ", 0
    text8 db ". You entered %lf %lf %lf", 10, 0
    text9 db "The area of your triangle is %lf square units", 10, 0
    text10 db " square units", 10, 0
    text11 db "The perimeter is %lf linear units.", 10, 0
  ;  text12 db " linear units.", 10, 0
    text13 db "The area will now be sent to the driver function.", 10, 0

    error db "Unfortunately, one of your inputs is invalid. Please run this program again.", 10, 0

    string_format db "%s", 0
    float_format db "%lf ", 0
    float_format3 db "%lf %lf %lf", 0

section .bss
    first_name resb 64
    last_name resb 64


section .text

triangles:

  push rbp
  mov rbp, rsp
  push rdi
  push rsi
  push rdx
  push rcx
  push r8
  push r9
  push r10
  push r11
  push r12
  push r13
  push r14
  push r15
  push rbx
  pushf



;;_printText1:
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, text1
    call printf
    pop rax

;_printText2:
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, text2
  ;  mov rdi, text2
    call printf
    pop rax

;_getName:
    mov rax, 0
    mov rdi, string_format
    mov rsi, first_name
    call scanf

    mov rax, 0
    mov rdi, string_format
    mov rsi, last_name
    call scanf

;_printText3:
    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, text3
    call printf
    pop rax

    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, first_name
    call printf
    pop rax

    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, text4
    call printf
    pop rax

    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, text5
    call printf
    pop rax

    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, text6
    call printf
    pop rax


    ;input 3 floats
    push qword 0
    push qword 0
    push qword 0
    push qword 0
    mov rdi, float_format3
    mov rsi, rsp
    mov rdx, rsp
    add rdx, qword 8
    mov rcx, rsp
    add rcx, qword 16
    call scanf
    movsd xmm15, [rsp]
    movsd xmm14, [rsp+8]
    movsd xmm13, [rsp+16]
    pop rax
    pop rax
    pop rax
    pop rax


    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, text7
    call printf
    pop rax

    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, first_name
    call printf
    pop rax


    mov rax, 3
    mov rdi, text8
    movsd xmm0, xmm15
    movsd xmm1, xmm14
    movsd xmm2, xmm13
    call printf

; check for invalid inputs
    push qword 0
    mov rax, 4
    mov r8, 0
    cvtsi2sd xmm5, r8
    ucomisd xmm15, xmm5
    jbe input_error
    ucomisd xmm14, xmm5
    jbe input_error
    ucomisd xmm13, xmm5
    jbe input_error
    pop rax


    ;Place pi into xmm12
    mov rax, 0x400921F854442D18
    push rax
    movsd xmm12, [rsp]
    pop rax


    ;Place 180.0 into xmm11
    mov rax, 180
    cvtsi2sd xmm11, rax

    ;Convert xmm13 (deg) to xmm10 (rad)
    movsd xmm10, xmm13
    mulsd xmm10, xmm12
    divsd xmm10, xmm11

    ;Place sin(rad) into xmm9
    mov rax, 1
    movsd xmm0, xmm10
    call sin
    movsd xmm9, xmm0

    ;Convert 2 to 2.0 and store in xmm8
    mov rax, 2
    cvtsi2sd xmm8, rax

    ;Cumpute area and store in xmm7
    movsd xmm7, xmm15
    mulsd xmm7, xmm14
    mulsd xmm7, xmm9
    divsd xmm7, xmm8

    ;Print area
    mov rax, 1
    mov rdi, text9
    movsd xmm0, xmm7
    call printf ;area is correct

    ;Find perimeter
    ;Square sides 1 and 2
    mov rax, 2
    movsd xmm6, xmm15 ;side1
    movsd xmm5, xmm14 ;side2
    mulsd xmm6, xmm6
    mulsd xmm5, xmm5
    addsd xmm6, xmm5 ; this works!


    ;Place side 1 + side 2 in xmm11, don't need 180.0 anymore
    mov rax, 1
    movsd xmm11, xmm15
    addsd xmm11, xmm14 ; this works!


    ;Place cos(rad) in xmm12, don't need pi anymore
    mov rax, 2
    movsd xmm0, xmm10
    call cos
    movsd xmm12, xmm0 ; this works!

    ;could remove maybe
    ;mov rax, 2
    ;cvtsi2sd xmm8, rax


    ;Place side 3 into xmm12  ; problem here
    mov rax, 2
    mulsd xmm12, xmm15
    mulsd xmm12, xmm14
    mulsd xmm12, xmm8
    subsd xmm6, xmm12
    sqrtsd xmm6, xmm6


    ;Add all the sides and store in xmm6
    mov rax, 1
    addsd xmm6, xmm15
    addsd xmm6, xmm14

    ;Print perimeter
    mov rax, 1
    mov rdi, text11
    movsd xmm0, xmm6
    call printf

    mov rax, 1
    mov rdi, string_format
    mov rsi, text13
    call printf

    ;movsd xmm0, xmm7
    jmp code_is_good


code_is_good:
    movsd xmm0, xmm7
    jmp end_pops


input_error:
    push qword 0
    mov rax, 1
    mov rdi, string_format
    mov rsi, error
    call printf
    pop rax
    pop rax

    movsd xmm0, xmm5
    jmp end_pops


end_pops:
    popf
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rbp

    ret
