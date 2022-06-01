extern scanf
extern printf
extern cos

global triangle

section .data
  text1 db "Please enter the values for side1, side2, and angle (in degrees) separated by ws.", 10, 0
  text2 db 10, "The computation of the length has completed.", 10, 10, 0
  text3 db "The three sides of this triangle have length %lf %lf %lf inches.", 10, 10, 0

  float3 db "%lf %lf %lf", 0


section .bss


section .text

triangle:
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

  ; Ask for input.
  push qword 0
  mov rax, 0
  mov rdi, text1
  call printf
  pop rax

  ; Read and store user input.
  push qword 0
  push qword 0
  push qword 0
  mov rax, 0
  mov rdi, float3
  mov rsi, rsp
  mov rdx, rsp
  add rdx, 8
  mov rcx, rsp
  add rcx, 16
  call scanf
  movsd xmm15, [rsp]       ; xmm15 has side1
  movsd xmm14, [rsp+8]     ; xmm14 has side2
  movsd xmm13, [rsp+16]    ; xmm13 has the angle in deg
  pop rax
  pop rax
  pop rax

  ; Place pi into xmm12
  mov rax, 0x400921F854442D18
  push rax
  movsd xmm12, [rsp]
  pop rax

  ; Place 180.0 into xmm11
  mov rax, 180
  cvtsi2sd xmm11, rax

  ; Convert xmm13 (deg) to xmm10 (rad)
  movsd xmm10, xmm13
  mulsd xmm10, xmm12
  divsd xmm10, xmm11       ; xmm10 has the angle in radians

  ; Calculate cos(rad)
  mov rax, 1
  movsd xmm0, xmm10
  call cos
  movsd xmm9, xmm0

  ; Convert 2 to 2.0 and store in xmm8
  mov rax, 2
  cvtsi2sd xmm8, rax

  ; Calculate 2(side1)(side2)cos(rad) and store it in xmm11
  mov rax, 4
  movsd xmm11, xmm8
  mulsd xmm11, xmm15
  mulsd xmm11, xmm14
  mulsd xmm11, xmm9

  ; Calculate side1^2 and side2^2
  mov rax, 4
  movsd xmm7, xmm14
  mulsd xmm7, xmm7
  movsd xmm8, xmm15
  mulsd xmm8, xmm8

  ; Calculate side3
  mov rax, 3
  addsd xmm8, xmm7
  subsd xmm8, xmm11
  sqrtsd xmm8, xmm8
  movsd xmm13, xmm8  ; xmm13 has side3

  ; Print that computation has finished.
  push qword 0
  mov rax, 0
  mov rdi, text2
  call printf
  pop rax

  ; Print the 3 sides.
  push qword 0
  mov rax, 3
  mov rdi, text3
  movsd xmm0, xmm15
  movsd xmm1, xmm14
  movsd xmm2, xmm13
  call printf
  pop rax

  ; Return side3.
  movsd xmm0, xmm13
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
