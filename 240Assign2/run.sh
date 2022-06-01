#!/bin/bash

rm *.o
rm *.out

echo "Assemble the X86 file hello.asm"
nasm -f elf64 -l compute_time.lis -o compute_time.o compute_time.asm

echo "Compile the C++ file isFloat.cpp"
g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o isFloat.o isFloat.cpp

echo "Compile the C++ file driver2.cpp"
g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o driver2.o driver2.cpp

echo "Link the three files isFloat.o driver2.o compute_time.o"
g++ -m64 -std=c++14 -fno-pie -no-pie -o driver2.out isFloat.o driver2.o compute_time.o

echo "Next the program ""String I/O"" will run"
./driver2.out

rm *.lis
rm *.o
rm *.out
