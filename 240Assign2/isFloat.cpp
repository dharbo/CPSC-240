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
// ;Purpose: This file contains the function isFloat that will check whether or not a string input is a float.
// ;
// ;This file
// ;   File name: isFloat.cpp
// ;   Language: C++
// ;   Max page width: 132 columns
// ;   Compile: g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o isFloat.o isFloat.cpp
// ;   Link: g++ -m64 -std=c++14 -fno-pie -no-pie -o driver2.out isFloat.o driver2.o compute_time.o
//
// ;===== Begin code area ================================================================================================

#include <iostream>

extern "C" bool isFloat(char [ ]);

bool isFloat(char w[ ])
{   bool result = true;
    bool onepoint = false;
    int start = 0;
    if (w[0] == '-' || w[0] == '+') start = 1;
    unsigned long int k = start;
    while (!(w[k] == '\0') && result )
    {    if (w[k] == '.' && !onepoint)
               onepoint = true;
         else
               result = result && isdigit(w[k]) ;
         k++;
     }
     return result && onepoint;
}
