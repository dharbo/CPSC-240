;****************************************************************************************************************************
;Program name: "Property Tax Assessor". This program asks the user for values of their properties, taking the sum and
; mean of them. This program also handles invalid input. Copyright (C) 2022 David Harboyan.
;
;This file is part of the software program "Manager".
;Property Tax Assessor is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;version 3 as published by the Free Software Foundation.
;Property Tax Assessor is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
;****************************************************************************************************************************

;Author information
;  Author name: David Harboyan
;  Author email: harboyandavid@csu.fullerton.edu
;
;Program information
;  Program name: Property Tax Assessor
;  Programming languages: Three modules in X86, two modules in C++, one module in c, and one in bash
;  Date program began: 2022 Feb 28
;  Date of last update: 2022 Mar 14
;  Date of reorganization of comments: 2022 Mar 14
;  Files in this program: manager.asm, get_values.asm, sum_values.asm, isFloat.cpp, assessor.cpp, show_values.c, tax.sh
;  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
;
;Purpose: Assembly file that finds the sum in the array passed into it.
;
;This file
;   File name: sum_values.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l sum_values.lis -o sum_values.o sum_values.asm
;   Link: g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out isfloat.o assessor.o manager.o get_values.o show_values.o sum_values.o

;===== Begin code area ================================================================================================


global sum_values

section .data

section .bss


section .text

sum_values:
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

  mov rax, 1
  mov r15, rdi   ; Copies array.
  mov r14, rsi   ; # of elements in the array.
  mov r13, 0
  cvtsi2sd xmm15, r13 ; Holds the sum.
  mov r12, 0     ; Counter to help iterate.

  begin_loop:

    mov rax, 1
    cmp r12, r14
    jge out_of_loop

    addsd xmm15, [r15 + 8 * r12]
    inc r12

    jmp begin_loop

  out_of_loop:

  pop rax

  movsd xmm0, xmm15 ; Return the sum (xmm15).

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
