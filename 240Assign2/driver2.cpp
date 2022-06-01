// ;****************************************************************************************************************************
// ;Program name: "Compute Time". This program takes in 1 float from the user, representing the height that a marble will fall from.
// ;Then it will compute the free fall time it takes for the marble to reach the ground. Copyright (C) 2021 David Harboyan.
// ;
// ;This file is part of the software program "Compute Time".
// ;Compute Time is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
// ;version 3 as published by the Free Software Foundation.
// ;Compute Time is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
// ;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
// ;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
// ;****************************************************************************************************************************
//
// ;Author information
// ;  Author name: David Harboyan
// ;  Author email: harboyandavid@csu.fullerton.edu
// ;
// ;Program information
// ;  Program name: Compute Time
// ;  Programming languages: One module in X86, two modules in C++, and one in bash
// ;  Date program began: 2022 Feb 7
// ;  Date of last update: 2022 Feb 18
// ;  Date of reorganization of comments: 2022 Feb 18
// ;  Files in this program: compute_time.asm, isFloat.cpp, driver2.cpp, run.sh
// ;  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
// ;
// ;Purpose: This file is the driver file that calls compute_time, which does most of the work for this program.
// ;
// ;This file
// ;   File name: driver2.cpp
// ;   Language: C++
// ;   Max page width: 132 columns
// ;   Compile: g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o driver2.o driver2.cpp
// ;   Link: g++ -m64 -std=c++14 -fno-pie -no-pie -o driver2.out isFloat.o driver2.o compute_time.o
//
// ;===== Begin code area ================================================================================================


#include <stdio.h>

extern "C" double compute_time();

int main() {
  double time = 0.0;
  printf("Welcome to Gravitational Attraction maintained by David Harboyan.\n");
  printf("This program was last updated on February 23, 2022.\n");

  time = compute_time();

  printf("The main driver received this number %lf and will simply keep it.\n", time);
  printf("The driver will now send integer 0 to the operating system. Have a nice day. Bye.\n");

  return 0;
}
