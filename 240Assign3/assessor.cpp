// ****************************************************************************************************************************
// Program name: "Property Tax Assessor". This program asks the user for values of their properties, taking the sum and
// mean of them. This program also handles invalid input. Copyright (C) 2022 David Harboyan.
//
// This file is part of the software program "Manager".
// Property Tax Assessor is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
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
//  Program name: Property Tax Assessor
//  Programming languages: Three modules in X86, two modules in C++, one module in c, and one in bash
//  Date program began: 2022 Feb 28
//  Date of last update: 2022 Mar 14
//  Date of reorganization of comments: 2022 Mar 14
//  Files in this program: manager.asm, get_values.asm, sum_values.asm, isFloat.cpp, assessor.cpp, show_values.c, tax.sh
//  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
//
// Purpose: C++ file that calls the manager function which does most of the work.
//
// This file
//   File name: assessor.cpp
//   Language: C++.
//   Max page width: 132 columns
//   Compile: g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o assessor.o assessor.cpp
//   Link: g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out isfloat.o assessor.o manager.o get_values.o show_values.o sum_values.o
//
// ===== Begin code area ================================================================================================



#include <stdio.h>
#include <ctime>

extern "C" double manager();

int main() {

  printf("Welcome to the Orange County Property Assessment Office on ");

  // Get the date.
  time_t current_linux_time;
  current_linux_time = time(NULL);
  struct tm * broken = localtime(&current_linux_time);

  printf("Today is ");
  switch(broken->tm_mon) {
    case 0: printf("January");
            break;
    case 1: printf("February");
            break;
    case 2: printf("March");
            break;
    case 3: printf("April");
            break;
    case 4: printf("May");
            break;
    case 5: printf("June");
            break;
    case 6: printf("July");
            break;
    case 7: printf("August");
            break;
    case 8: printf("September");
            break;
    case 9: printf("October");
            break;
    case 10: printf("November");
            break;
    case 11: printf("December");
            break;
    default: printf("Unknown");
            break;
  }

  printf(" %d, %d.\n", broken->tm_mday, broken->tm_year+1900);

  printf("For assistance contact David Harboyan at davidgrander@premier.com\n\n");

  double result = 0.0;

  // Call and store the return value from manager.
  result = manager();

  printf("The Assessor's Office received this number %lf and will keep it.\n", result);
  printf("Next an integer 0 will be sent to the operating system as a signal of successful completion.\n");

  return 0;
}
