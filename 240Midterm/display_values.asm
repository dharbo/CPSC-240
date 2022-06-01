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
extern get_coeff

global display_values

section .data
  float_format3 db "%lf %lf %lf", 10, 0
  float_format db "%lf", 0


section .bss

section .text

display_values:

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

 mov r15, rdi
 mov r14, rsi

 ; Display the values in the array.
 mov rax, 3
 mov rdi, float_format3
 movsd xmm0, [r15]
 movsd xmm1, [r15+8]
 movsd xmm2, [r15+16]
 call printf


 pop rax

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
