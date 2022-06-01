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

global tworoots

section .data
  info db "The roots of the equation are %lf and %lf", 10, 10, 0
  float_format3 db "%lf %lf %lf", 10, 0
  float_format db "%lf", 0


section .bss

section .text

tworoots:

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

 mov r15, rdi         ; r15 holds the address of the array.
 movsd xmm10, xmm0    ; xmm10 has b^2-4ac

 sqrtsd xmm10, xmm10   ; xmm10 has the sqrt.

 mov r14, 2
 cvtsi2sd xmm11, r14   ; xmm11 has 2.0
 mulsd xmm11, [r15]    ; xmm11 has the denominator

 divsd xmm10, xmm11    ; xmm10 has the right side

 xorpd xmm8, xmm8   ; zero out
 subsd xmm8, [r15+8] ; xmm8 has -b

 movsd xmm15, xmm8
 addsd xmm15, xmm10   ; xmm15 has the added one.

 movsd xmm14, xmm8
 subsd xmm14, xmm10   ; xmm14 has the subtracted one.

 mov rax, 2
 mov rdi, info
 movsd xmm0, xmm15
 movsd xmm1, xmm14
 call printf

 movsd xmm0, xmm15
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
