; // ****************************************************************************************************************************
; // Program name: "Harmonic Sum". This program asks the user for a value n and finds its harmonic sum.
; // Copyright (C) 2022 David Harboyan.
; //
; // Harmonic Sum is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
; // version 3 as published by the Free Software Foundation.
; // Property Tax Assessor is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
; // warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
; // A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
; // ****************************************************************************************************************************
; //
; // Author information
; //  Author name: David Harboyan
; //  Author email: harboyandavid@csu.fullerton.edu
; //
; // Program information
; //  Program name: Harmonic Sum
; //  Programming languages: Three modules in X86, one modules in C++, one module in c, and one in bash
; //  Date program began: 2022 Apr 10
; //  Date of last update: 2022 Apr 25
; //  Date of reorganization of comments: 2022 Apr 25
; //  Files in this program: manager.asm, compute_sum.asm, get_frequency.asm, harmonic.cpp, output_one_line.c, r.sh
; //  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
; //
; // Purpose: Computes the harmonic sum.
; //
; // This file
; //   File name: compute_sum.asm
; //   Language: x86.
; //   Max page width: 132 columns
; //   Assemble: nasm -f elf64 -l compute_sum.lis -o compute_sum.o compute_sum.asm
; //   Link: g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out manager.o harmonic.o compute_sum.o get_frequency.o output_one_line.o
; //
; // ===== Begin code area ================================================================================================

extern scanf
extern printf
extern output_one_line

global compute_sum

section .data
  text1 db "Term#              Sum", 10, 0
  text2 db "The sum of %ld terms is %lf", 10, 0

  int_format db "%ld", 10, 0

section .bss

section .text

compute_sum:
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

  ; Store passed user input in r8.
  mov r15, rdi

  ; Print the categories.
  push qword 0
  mov rax, 0
  mov rdi, text1
  call printf
  pop rax

  ; go up to n
  mov r13, 1

  ; 1 from 1/n
  mov rax, 0x3ff0000000000000
  movq xmm15, rax

  ; xmm10 = 0.0
  xorpd xmm10, xmm10
  start_loop:

  cmp r13, r15
  jg end_pops

  ; convert the current n to a float
  mov rax, 4
  cvtsi2sd xmm14, r13

  ; divide 1/current n; add to total
  movsd xmm13, xmm15
  divsd xmm13, xmm14
  addsd xmm10, xmm13

  ; call output_one_line to print the sum.
  mov rax, 1
  mov rdi, r13
  movsd xmm0, xmm10
  mov rsi, r15
  call output_one_line

  xorpd xmm14,xmm14
  inc r13

  jmp start_loop

end_pops:
  ; Print the final harmonic sum.
  mov rax, 1
  mov rdi, text2
  mov rsi, r15
  movsd xmm0, xmm10
  call printf

  ; Mov sum into xmm0 to return.
  movsd xmm0, xmm10
  pop rax

  ; pop registers.
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
