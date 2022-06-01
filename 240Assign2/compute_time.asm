;****************************************************************************************************************************
;Program name: "Compute Time". This program takes in 1 float from the user, representing the height that a marble will fall from.
;Then it will compute the free fall time it takes for the marble to reach the ground. Copyright (C) 2021 David Harboyan.
;
;This file is part of the software program "Compute Time".
;Compute Time is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;version 3 as published by the Free Software Foundation.
;Compute Time is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
;****************************************************************************************************************************

;Author information
;  Author name: David Harboyan
;  Author email: harboyandavid@csu.fullerton.edu
;
;Program information
;  Program name: Compute Time
;  Programming languages: One module in X86, two modules in C++, and one in bash
;  Date program began: 2022 Feb 7
;  Date of last update: 2022 Feb 18
;  Date of reorganization of comments: 2022 Feb 18
;  Files in this program: compute_time.asm, isFloat.cpp, driver2.cpp, run.sh
;  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
;
;Purpose: Assembly file that gets a float number from the user and calculates free fall time.
;
;This file
;   File name: compute_time.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l compute_time.lis -o compute_time.o compute_time.asm
;   Link: g++ -m64 -std=c++14 -fno-pie -no-pie -o driver2.out isFloat.o driver2.o compute_time.o

;===== Begin code area ================================================================================================



extern printf
extern scanf
extern fgets
extern stdin
extern strlen
extern isFloat
extern atof

global compute_time

section .data

  text1 db "If errors are discovered please report them to David at david@columbia.com for a rapid", 10, "%s%s", 0
  text2 db "update. At Columbia, Inc, the customer comes first.", 10, 0
  text3 db "Please enter your first and last names: ", 0
  text4 db "Please enter your job title (Nurse, Programmer, Teacher, Carpenter, Mechanic, Bus Driver,", 10, "%s", 0
  text5 db "Barista, Hair Dresser, Acrobat, Senator, Sales Clerk, etc): ", 0
  text6 db "Thank you %s. We appreciate your business.", 10, 0
  text7 db "We understand that you plan to drop a marble from a high vantage point.", 10, 0
  text8 db "Please enter the height of the marble above ground surface in meters: ", 0
  text9 db "The marble you drop from that height will reach the earth after %lf seconds.", 10, 0
  text10 db "Thank you %s for your participation. May you always reach great heights.", 10, 0

  alt1 db "An error was detected in the input data. You may run this program again.", 10, 0
  alt2 db "Thank you %s for your participation. May you never lose sight of the goal.", 10, 0

  stringformat db "%s", 0
  stringformat2 db "%s %s", 10, 0
  floatformat db "%lf", 0

section .bss
  name resb 256
  title resb 256
  inputfloat resb 256

section .text

compute_time:

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

  ; Welcome and ask for name.
  push qword 0
  mov rax, 0
  mov rdi, text1
  mov rsi, text2
  mov rdx, text3
  call printf
  pop rax

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

  ; Ask for job title.
  push qword 0
  mov rax, 0
  mov rdi, text4
  mov rsi, text5
  call printf
  pop rax

  ; Get the job title of the user using fgets and store in "title".
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

  ; Thank you message.
  push qword 0
  mov rax, 0
  mov rdi, text6
  mov rsi, title
  call printf
  pop rax

  ; Vantage point prompt.
  push qword 0
  mov rax, 0
  mov rdi, stringformat
  mov rsi, text7
  call printf
  pop rax

  ; Enter height prompt.
  push qword 0
  mov rax, 0
  mov rdi, stringformat
  mov rsi, text8
  call printf
  pop rax

  ; Get the float as a string, including whitespace, using fgets.
  push qword 0

  mov rax, 0
  mov rdi, inputfloat
  mov rsi, 256
  mov rdx, [stdin]
  call fgets

  ; Remove newline char from fgets input.
  mov rax, 0
  mov rdi, inputfloat
  call strlen
  sub rax, 1
  mov byte [inputfloat + rax], 0

  ; Check if valid using isFloat function.
  mov rax, 0
  mov rdi, inputfloat
  call isFloat
  cmp rax, 0
  je invalidRoot ; Jump to invalidRoot if the float is not valid.

  ; Input is valid so convert to float and store it in xmm15.
  mov rdi, inputfloat
  call atof
  movsd xmm15, xmm0

  pop rax

  ; Make xmm14 = 9.8 (gravity).
  push qword 0
  mov rax, 3
  mov r8, 10
  mov r9, 98
  cvtsi2sd xmm14, r9
  cvtsi2sd xmm13, r8
  divsd xmm14, xmm13
  mov r10, 2
  cvtsi2sd xmm12, r10 ; Store 2.0 in xmm12.
  pop rax

  ; Calculate time and store it in xmm11.
  push qword 0
  mov rax, 3
  movsd xmm11, xmm15
  mulsd xmm11, xmm12
  divsd xmm11, xmm14
  sqrtsd xmm11, xmm11
  pop rax

  ; Print calculated time.
  push qword 0
  mov rax, 1
  mov rdi, text9
  movsd xmm0, xmm11
  call printf
  pop rax

  ; Print thank you text.
  push qword 0
  mov rax, 0
  mov rdi, text10
  mov rsi, name
  call printf
  pop rax

  ; Return the calculated time to driver.
  movsd xmm0, xmm11
  jmp endPops

invalidRoot:
  ; Print the first error text.
  pop rax
  push qword 0
  mov rax, 0
  mov rdi, alt1
  call printf
  pop rax

  ; Print the second error text.
  push qword 0
  mov rax, 0
  mov rdi, alt2
  mov rsi, name
  call printf
  pop rax

  ; Return -99.0 to signify an invalid input.
  push qword 0
  mov rax, -99
  cvtsi2sd xmm15, rax
  pop rax

  movsd xmm0, xmm15
  jmp endPops


endPops:
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
