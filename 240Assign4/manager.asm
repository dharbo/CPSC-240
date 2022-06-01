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
; // Purpose: Manages all most function calls, and returns the sum to driver.
; //
; // This file
; //   File name: manager.asm
; //   Language: x86.
; //   Max page width: 132 columns
; //   Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm
; //   Link: g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out manager.o harmonic.o compute_sum.o get_frequency.o output_one_line.o
; //
; // ===== Begin code area ================================================================================================


extern scanf
extern printf

extern compute_sum
extern clock_speed
extern compute_sum

global manager

section .data
  text1 db "How many terms do you want to include? ", 0
  text2 db "Thank you. The time is now %lu tics.", 10, 0
  text3 db "The computation has begun.", 10, 10, 0
  text5 db "The time is now %lu tics.", 10, 10, 0
  text6 db "The elapsed time is %lu tics.", 10, 10, 0
  text7 db "Your processor frequency in GHz is %.2lf.", 10, 10, 0
  text8 db "The elapsed time equals %.9lf seconds.", 10, 10, 0
  text9 db "The sum will be returned to the caller module.", 10, 10, 0
  frequency db "An AMD processor was detected. Please enter your processor frequency in GHz: ", 0

  ld db "%ld", 0
  lf db "%lf", 0

section .bss

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

  ; Ask user for the number of terms.
  push qword 0
  mov rax, 0
  mov rdi, text1
  call printf
  pop rax

  ; Take user input and store it in r15.
  push qword 0
  mov rax, 0
  mov rdi, ld
  mov rsi, rsp
  call scanf
  mov r15, [rsp]
  pop rax

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
  mov rdi, text2
  mov rsi, r14
  call printf
  pop rax

  ; Print simple message.
  push qword 0
  mov rax, 0
  mov rdi, text3
  call printf
  pop rax

  ; Call compute_sum.
  mov rax, 1
  mov rdi, r15
  call compute_sum
  movsd xmm15, xmm0

  ; get tics and store in r13.
  mov rax, 0
  mov rdx, 0

  ; stop system processes and
  ; read clock time stamp
  cpuid
  rdtsc

  ; shift all the bits of rax 32 bits to the left
  shl rdx, 32

  ; our complete number of tics
  add rdx, rax

  ; move tics elapsed to r14
  mov r13, rdx

  ; Print out start time tics elapsed
  push qword 0
  mov rax, 0
  mov rdi, text5
  mov rsi, r13
  call printf
  pop rax

  ; Calculate elapsed time.
  mov rax, 0
  mov r12, r13
  sub r12, r14  ; r12 holds elapsed time in tics

  ; Print elapsed time.
  push qword 0
  mov rax, 0
  mov rdi, text6
  mov rsi, r12
  call printf
  pop rax

  ; Get the frequency and store it in xmm11.
  mov rax, 1
  call clock_speed
  movsd xmm11, xmm0

  ; Print the frequency of the user's machine.
  push qword 0
  mov rax, 1
  mov rdi, text7
  movsd xmm0, xmm11
  call printf
  pop rax

  ; Check for AMD processor.
  mov rax, 0
  cvtsi2sd xmm9, rax

  comisd xmm11, xmm9
  je AMD

calculate_time:
  ; Convert tics to floats.
  cvtsi2sd xmm14, r14 ; start time
  cvtsi2sd xmm13, r13 ; end time

  ; End - start
  subsd xmm13, xmm14

  ; Move  elapsed time into xmm12.
  movsd xmm12, xmm13

  ; Elapsed time / GHz and store it in xmm12.
  divsd xmm12, xmm11

  ; Get value of 1 billion and store it in xmm10.
  mov rax, 0x41cdcd6500000000
  push rax
  movsd xmm10, [rsp]
  pop rax

  ; Convert the nanosecs into seconds.
  divsd xmm12, xmm10

  ; Print the elapsed time in seconds.
  push qword 0
  mov rax, 1
  mov rdi, text8
  movsd xmm0, xmm12
  call printf
  pop rax

  push qword 0
  mov rax, 0
  mov rdi, text9
  call printf
  pop rax

  jmp end_pops

AMD:
  ; Ask user for their processor's frequency.
  push qword 0
  mov rax, 0
  mov rdi, frequency
  call printf
  pop rax

  ; Store the input in xmm11.
  push qword 0
  mov rax, 1
  mov rdi, lf
  mov rsi, rsp
  call scanf
  movsd xmm11, [rsp]
  pop rax

  jmp calculate_time

end_pops:
  pop rax

  movsd xmm0, xmm15
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
