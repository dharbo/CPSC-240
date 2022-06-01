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
// Purpose: C++ file that checks if a string would be a valid float.
//
// This file
//   File name: isfloat.cpp
//   Language: C++.
//   Max page width: 132 columns
//   Compile: g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o isfloat.o isfloat.cpp
//   Link: g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out isfloat.o assessor.o manager.o get_values.o show_values.o sum_values.o
//
// ===== Begin code area ================================================================================================



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
