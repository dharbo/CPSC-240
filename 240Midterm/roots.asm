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
extern get_coeff
extern display_values
extern tworoots
extern oneroot
extern noroots

global roots

array_size equ 3

section .data
  text1 db "Good morning", 10, 10, 0
  text2 db "Please enter the three coefficients a, b, and c of a quadratic equation separated by ws.", 10, 0
  text3 db "You entered ", 0
  text4 db "One root will be returned to the caller. If no roots exist then 0.0 will be returned.", 10, 0
  float_format3 db "%lf %lf %lf", 10, 0
  float_format db "%lf", 0


section .bss
  input_array resq 3


section .text

roots:

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

  ; Print Welcome message
  push qword 0
  mov rax, 0
  mov rdi, text1
  call printf
  pop rax

  ; Ask for the 3 coefficients
  push qword 0
  mov rax, 0
  mov rdi, text2
  call printf
  pop rax

  ; Call coeff function and store the # of values into r14.
  mov rax, 0
  mov rdi, input_array    ; Address of array.
  mov rsi, array_size     ; Max size of array.
  call get_coeff
  mov r14, rax           ; Save copy of the # of values into r14.


  ; Display "You entered".
  push qword 0
  mov rax, 0
  mov rdi, text3
  call printf
  pop rax

  ; Display the coefficients.
  mov rax, 0
  mov rdi, input_array
  mov rsi, array_size
  call display_values

  ; Find the value of the sqrt's inside.
  mov rax, 4
  movsd xmm14, [input_array+8]
  mulsd xmm14, xmm14     ; xmm14 holds b^2
  movsd xmm15, [input_array]
  mulsd xmm15, [input_array+16]
  cvtsi2sd xmm13, rax    ; xmm13 holds 4.0
  mulsd xmm15, xmm13     ; xmm15 holds 4ac
  subsd xmm14, xmm15     ; xmm14 holds b^2-4ac

  ; Convert 0 to 0.0
  mov rax, 2
  mov r8, 0
  cvtsi2sd xmm12, r8


  ; Compare the indsides of the sqrt with 0.0.
  ucomisd xmm14, xmm12
  ja root2
  ucomisd xmm14, xmm12
  je root1
  ucomisd xmm14, xmm12
  jb root0

root2:
  ; Call tworoots
  mov rax, 0
  mov rdi, input_array
  movsd xmm0, xmm14
  call tworoots
  movsd xmm8, xmm0     ; xmm8 holds one root
  movsd xmm9, xmm8

  push qword 0
  mov rax, 1
  mov rdi, float_format
  movsd xmm0, xmm9
  call printf
  pop rax

  jmp end_pops

root1:
  ; Call oneroot
  push qword 0
  mov rax, 0
  mov rdi, input_array
  mov rsi, array_size
  call oneroot
  movsd xmm8, xmm0
  pop rax
  movsd xmm9, xmm8

  jmp end_pops

root0:
  ; Call noroots
  push qword 0
  mov rax, 0
  call noroots
  movsd xmm8, xmm0
  pop rax
  movsd xmm9, xmm8

  jmp end_pops

end_pops:
  ;movsd xmm9, xmm8

  push qword 0
  mov rax, 0
  mov rdi, text4
  call printf
  pop rax

  movsd xmm0, xmm9
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
