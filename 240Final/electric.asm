; Author Contact:
;   Name: David Harboyan
;   Email: harboyandavid@csu.fullerton.edu
;   Section: 07
; Name of Program: Current Calculator
; Purpose: Compute the current given the emf value and resistance.

extern scanf
extern printf


global electric

section .data
  text1 db "The time on the clock is now %lu tics.", 10, 0
  text2 db "We turn your night into day.", 10, 0
  text3 db "Please enter the emf value (volts): ", 0
  text4 db "Pleaes enter the resistance (ohms): ", 0
  text5 db "The computed current is %.4lf amps.", 10, 0
  text6 db "The Electric Power will send the current to the caller.", 10, 0
  text7 db "The end time on the clock is now %lu tics.", 10, 10, 0

  float_form db "%lf", 0

section .bss


section .text

electric:
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

  ; get tics and store in r14.
  mov rax, 0
  mov rdx, 0

  ; stop system and read clock time.
  cpuid
  rdtsc

  ; shift all the bits of rax 32 bits to the left.
  shl rdx, 32
  ; our number of tics.
  add rdx, rax
  ; store the number of tics in r14.
  mov r14, rdx

  ; Print the number of tics.
  push qword 0
  mov rax, 0
  mov rdi, text1
  mov rsi, r14
  call printf
  pop rax

  ; Print message.
  push qword 0
  mov rax, 0
  mov rdi, text2
  call printf
  pop rax

  ; Ask for volts.
  push qword 0
  mov rax, 0
  mov rdi, text3
  call printf
  pop rax

  ; Store volts value in xmm14.
  push qword 0
  mov rax, 1
  mov rdi, float_form
  mov rsi, rsp
  call scanf
  movsd xmm14, xmm0
  pop rax

  ; Ask for ohms.
  push qword 0
  mov rax, 0
  mov rdi, text4
  call printf
  pop rax

  ; Store ohms in xmm13.
  push qword 0
  mov rax, 1
  mov rdi, float_form
  mov rsi, rsp
  call scanf
  movsd xmm13, xmm0
  pop rax

  movsd xmm15, xmm14    ; mov emf into xmm15.
  divsd xmm15, xmm13    ; divide emf by resistance to get the current and store in xmm15.

  ; Print th computed current.
  push qword 0
  mov rax, 1
  mov rdi, text5
  movsd xmm0, xmm15
  call printf
  pop rax

  ; Print message.
  push qword 0
  mov rax, 0
  mov rdi, text6
  call printf
  pop rax

  ; get tics and store in r13.
  mov rax, 0
  mov rdx, 0

  ; stop system and read clock time.
  cpuid
  rdtsc

  ; shift all the bits of rax 32 bits to the left.
  shl rdx, 32
  ; our number of tics.
  add rdx, rax
  ; store the number of tics in r13.
  mov r13, rdx

  ; Print the number of tics.
  push qword 0
  mov rax, 0
  mov rdi, text7
  mov rsi, r13
  call printf
  pop rax

  ; Prepare to return the current from xmm15.
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
