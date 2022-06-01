; Author Contact:
;   Name: David Harboyan
;   Email: harboyandavid@csu.fullerton.edu
;   Section: 07
; Name of Program: Root solver
; Purpose: To find all roots given three values a, b, and c.

extern printf
extern scanf
extern sin
extern cos
extern stdin
extern strlen
extern fgets
extern atof
extern isFloat

global get_coeff

section .data
  string_format db "%s", 0


section .bss


section .text

get_coeff:

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

  push qword 0

    ; Initialize parameters.
  mov r15, rdi   ; Address of array is saved to r15.
  mov r14, rsi   ; r14 holds the max size of the array.
  mov r13, 0     ; Set a counter to 0.

begin_loop:
    ; Scanf called to take user input.
    mov rax, 0
    mov rdi, string_format
    mov rsi, rsp
    call scanf

    ; Convert from string to float.
    mov rax, 0
    mov rdi, rsp
    call atof
    movsd xmm15, xmm0

    ; Adds copy of float saved in xmm15 into array at the index counter (r13).
    movsd [r15 + 8 * r13], xmm15
    inc r13

    ; Check if array capacity has been reached.
    cmp r13, r14
    je end_of_loop

    ; Repeat loop.
    jmp begin_loop


end_of_loop:
  pop rax
  mov rax, r13
  jmp exit

exit:
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
