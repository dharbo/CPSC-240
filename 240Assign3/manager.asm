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
;Purpose: Assembly file that manages most of the functions called.
;
;This file
;   File name: manager.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm
;   Link: g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out isfloat.o assessor.o manager.o get_values.o show_values.o sum_values.o

;===== Begin code area ================================================================================================


extern scanf
extern printf
extern fgets
extern atof
extern strlen
extern stdin

extern get_values
extern show_values
extern sum_values

array_size equ 100

global manager

section .data
  text1 db "Please enter your name and press enter: ", 0
  text2 db "Please enter your title: ", 0
  text3 db "Thank you %s.", 10, 10, 0
  text4 db "Next we will collect the property values in your assessment district. Between each value", 10, 0
  text5 db "enter white space. When finished entering values press <enter> followed by control+D.", 10, 10, 0
  text6 db 10, "Thank you. Here are the assessed property values in this district.", 10, 10, 0
  text7 db "The sum of the assessed values is $%lf.", 10, 0
  text8 db "The mean assessed value is $%lf.", 10, 10, 0
  text9 db "The mean will now be returned to the caller function.", 10, 0
  text10 db "We enjoy serving everyone who is a %s.", 10, 10, 0

  string_format db "%s", 0
  int_format db 10, "%d", 10, 0
  float_format db "%lf", 10, 0

section .bss
  name resb 256
  title resb 256
  floatArray resq 100

section .text

manager:
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

  ; Ask for name.
  push qword 0
  mov rax, 0
  mov rdi, text1
  call printf
  pop rax

  push qword 0
  ; Get the name of the user using fgets and store in "name".
  mov rax, 0
  mov rdi, name ; 1st argument
  mov rsi, 256 ; size of bytes reserved
  mov rdx, [stdin] ; mov the contents at address of stdin, dereference
  call fgets

  ; Remove newline char from fgets input.
  mov rax, 0
  mov rdi, name ; move name into 1st register
  call strlen   ; returns the length of the string leading up to '\0'
  sub rax, 1    ; length is stored in rax. now we subtract 1 from rax to obtain location of '\n'
  mov byte [name + rax], 0  ; replace the byte where '\n' exits with '\0'

  pop rax

  ; Ask user fo title.
  push qword 0
  mov rax, 0
  mov rdi, text2
  call printf
  pop rax

  push qword 0
  ; Get the title of the user using fgets and store in "title".
  mov rax, 0
  mov rdi, title ; 1st argument
  mov rsi, 256 ; size of bytes reserved
  mov rdx, [stdin] ; mov the contents at address of stdin, dereference
  call fgets

  ; Remove newline char from fgets input.
  mov rax, 0
  mov rdi, title ; move name into 1st register
  call strlen   ; returns the length of the string leading up to '\0'
  sub rax, 1    ; length is stored in rax. now we subtract 1 from rax to obtain location of '\n'
  mov byte [title + rax], 0  ; replace the byte where '\n' exits with '\0'

  pop rax


  ; Thank you message.
  push qword 0
  mov rax, 0
  mov rdi, text3
  mov rsi, name
  call printf
  pop rax

  ; Print prompt.
  push qword 0
  mov rax, 0
  mov rdi, text4
  call printf
  pop rax

  ; Print prompt.
  push qword 0
  mov rax, 0
  mov rdi, text5
  call printf
  pop rax

  ; Call get_values function and store the # of values into r14.
  mov rax, 0
  mov rdi, floatArray    ; Address of array.
  mov rsi, array_size    ; Max size of array.
  call get_values
  mov r14, rax           ; Save copy of the # of values into r14.

  ; Check if there are no valid inputs.
  cmp r14, 0
  je no_valid_input  ; jmp if r14 holds no valid inputs.

  ; Thank you message.
  mov rax, 0
  mov rdi, string_format
  mov rsi, text6
  call printf

  ; Display values that are in the array, using show_values.
  push qword 0
  mov rax, 0
  mov rdi, floatArray  ; Address of array.
  mov rsi, r14         ; # of elements in the array.
  call show_values
  pop rax

  ; Calculate the sum of the array's elements, using sum_values.
  push qword 0
  mov rax, 1
  mov rdi, floatArray ; Address of array.
  mov rsi, r14        ; # of elements in the array.
  call sum_values
  movsd xmm15, xmm0   ; Store the sum in xmm15.
  pop rax

  ; Print the sum.
  push qword 0
  mov rax, 1
  mov rdi, text7
  movsd xmm0, xmm15
  call printf
  pop rax

  ; Calculate the mean.
  push qword 0
  mov rax, 2
  cvtsi2sd xmm14, r14   ; Convert the # of elements from int to float.
  movsd xmm13, xmm15
  divsd xmm13, xmm14    ; sum/# of elements -> xmm13 holds the mean
  pop rax

  ; Print the mean.
  push qword 0
  mov rax, 1
  mov rdi, text8
  movsd xmm0, xmm13
  call printf
  pop rax

  ; Print filler text.
  push qword 0
  mov rax, 0
  mov rdi, text9
  call printf
  pop rax

  ; Print filler text, with title.
  push qword 0
  mov rax, 0
  mov rdi, text10
  mov rsi, title
  call printf
  pop rax

  ; Move the mean into xmm0 to return to driver.
  movsd xmm0, xmm13
  ; jmp to the end pops.
  jmp end_pops

no_valid_input:

  ; Convert 0 to 0.0 and store it in xmm10.
  push qword 0
  mov rax, 2
  mov r8, 0
  cvtsi2sd xmm10, r8 ; xmm10 = 0.0
  pop rax

  ; Print the sum, as 0.0.
  push qword 0
  mov rax, 1
  mov rdi, text7
  movsd xmm0, xmm10
  call printf
  pop rax

  ; Print the mean, as 0.0.
  push qword 0
  mov rax, 1
  mov rdi, text8
  movsd xmm0, xmm10
  call printf
  pop rax

  ; Print filler text.
  push qword 0
  mov rax, 0
  mov rdi, text9
  call printf
  pop rax

  ; Print filler text with title.
  push qword 0
  mov rax, 0
  mov rdi, text10
  mov rsi, title
  call printf
  pop rax

  ; Move 0.0 into xmm0 to return.
  movsd xmm0, xmm10
  ; jmp to end pops.
  jmp end_pops


end_pops:
  pop rax   ; pop from initial push.

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
