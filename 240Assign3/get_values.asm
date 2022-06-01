; ****************************************************************************************************************************
; Program name: "Property Tax Assessor". This program asks the user for values of their properties, taking the sum and
; mean of them. This program also handles invalid input. Copyright (C) 2022 David Harboyan.
;
; This file is part of the software program "Manager".
; Property Tax Assessor is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
; version 3 as published by the Free Software Foundation.
; Property Tax Assessor is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
; A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
; ****************************************************************************************************************************
;
; Author information
;  Author name: David Harboyan
;  Author email: harboyandavid@csu.fullerton.edu
;
; Program information
;  Program name: Property Tax Assessor
;  Programming languages: Three modules in X86, two modules in C++, one module in c, and one in bash
;  Date program began: 2022 Feb 28
;  Date of last update: 2022 Mar 14
;  Date of reorganization of comments: 2022 Mar 14
;  Files in this program: manager.asm, get_values.asm, sum_values.asm, isFloat.cpp, assessor.cpp, show_values.c, tax.sh
;  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
;
; Purpose: Assembly file that finds asks the user for property values.
;
; This file
;   File name: get_values.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l get_values.lis -o get_values.o get_values.asm
;   Link: g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out isfloat.o assessor.o manager.o get_values.o show_values.o sum_values.o
;
; ===== Begin code area ================================================================================================



extern scanf
extern printf
extern atof
extern isFloat

global get_values

section .data
  string_format db "%s", 0
  invalid db "Invalid input, please enter a valid input!", 10, 0

section .bss


section .text

get_values:
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

  mov r10, -99

  begin_loop:


; github:
    ; Scanf called to take user input.
    mov rax, 0
    mov rdi, string_format
    mov rsi, rsp
    call scanf

    ;Test if Ctrl+D is entered to finish inputting into array.
    cdqe
    cmp rax, -1
    je end_of_loop

    ; Check to see if the input is a float.
    mov rax, 0
    mov rdi, rsp
    call isFloat
    cmp rax, 0
    je invalid_input
    ;je invalid_input ;keep this

    ; Convert from string to float.
    mov rax, 0
    mov rdi, rsp
    call atof
    movsd xmm15, xmm0
  ;  mov r12, rax

    ; Adds copy of float saved in r12 into array at the index counter (r13).
    movsd [r15 + 8 * r13], xmm15
    inc r13

    ; Check if array capacity has been reached.
    cmp r13, r14
    je exit

    ; Repeat loop.
    jmp begin_loop

    invalid_input:

    ; edit
      ;mov rax, 0
      ;mov r11, -99   ; Holds whether or not there was invalid input.
      mov rax, 0
      mov rdi, invalid
      call printf
      jmp begin_loop



      ; keep
      ;jmp exit

    end_of_loop:

    ; mov rdi, invalid
    ; mov rsi, r11
    ; call printf
    ;
    ;   cmp r11, -99
    ;   je ret_invalid
    ;

      pop rax

      mov rax, r13
      jmp exit


    ; ret_invalid: ; not getting here
    ;
    ;   pop rax
    ;
    ;   ; mov rdi, invalid
    ;   ; mov rsi, r11
    ;   ; call printf
    ;
    ;   mov rax, r11
    ;   jmp exit

    ;
    exit:

  ;pop rax

;  mov rax, r13

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
