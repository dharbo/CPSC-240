#!/bin/bash

rm *.o
rm *.out

echo "Assemble the X86 file triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm -g -gdwarf

echo "Compile the C++ file geometry.cpp"
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o geometry.o geometry.cpp -g

echo "Link the files triangle.o geometry.o"
g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out triangle.o geometry.o -g

echo "Next the program ""String I/O"" will run"
gdb ./output.out

rm *.lis
rm *.o
rm *.out
