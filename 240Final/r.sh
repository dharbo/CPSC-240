# ; Author Contact:
# ;   Name: David Harboyan
# ;   Email: harboyandavid@csu.fullerton.edu
# ;   Section: 07
# ; Name of Program: Current Calculator
# ; Purpose: Compute the current given the emf value and resistance.

#!/bin/bash

rm *.o
rm *.out

echo "Assemble the X86 files"
nasm -f elf64 -l electric.lis -o electric.o electric.asm

echo "Compile the C files"
gcc -c -Wall -m64 -no-pie -o driver.o driver.c -std=gnu11 -lm

echo "Link the files triangle.o geometry.o"
g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out electric.o driver.o

echo "Next the program ""String I/O"" will run"
./output.out

rm *.lis
rm *.o
rm *.out
