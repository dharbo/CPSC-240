// ****************************************************************************************************************************
// Program name: "Harmonic Sum". This program asks the user for a value n and finds its harmonic sum.
// Copyright (C) 2022 David Harboyan.
//
// Harmonic Sum is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
// version 3 as published by the Free Software Foundation.
// Property Tax Assessor is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
// A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
// ****************************************************************************************************************************
//
// Author information
//  Author name: David Harboyan
//  Author email: harboyandavid@csu.fullerton.edu
//
// Program information
//  Program name: Harmonic Sum
//  Programming languages: Three modules in X86, one modules in C++, one module in c, and one in bash
//  Date program began: 2022 Apr 10
//  Date of last update: 2022 Apr 25
//  Date of reorganization of comments: 2022 Apr 25
//  Files in this program: manager.asm, compute_sum.asm, get_frequency.asm, harmonic.cpp, output_one_line.c, r.sh
//  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
//
// Purpose: Output the sum for only 10 terms of the inputted n value.
//
// This file
//   File name: output_one_line.c
//   Language: C.
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o output_one_line.o output_one_line.c -std=gnu11 -lm
//   Link: g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out manager.o harmonic.o compute_sum.o get_frequency.o output_one_line.o
//
// ===== Begin code area ================================================================================================

#include "stdio.h"

extern void output_one_line(int, double, int);

void output_one_line(int i, double sum, int n) {
  int ith = n / 10;
  if (n/10 < 1) {
    ith = 1;
  }
  if (i % ith == 0 || i == n) {
    printf("%d                %lf\n", i, sum);
   }
}
