#!/bin/bash

rm *.o
rm *.out

echo "Assemble the X86 file hello.asm"
nasm -f elf64 -l triangles.lis -o triangles.o triangles.asm

echo "Compile the C++ file good_morning.cpp"
g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o driver1.o driver1.cpp

echo "Link the two 'O' files good_morning.o triangles.o"
g++ -m64 -std=c++14 -fno-pie -no-pie -o driver1.out driver1.o triangles.o

echo "Next the program ""String I/O"" will run"
./driver1.out
