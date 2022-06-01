#!/bin/bash

rm *.o
rm *.out

echo "Assemble the X86 file manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble the X86 file get_values.asm"
nasm -f elf64 -l get_values.lis -o get_values.o get_values.asm

echo "Assemble the X86 file sum_values.asm"
nasm -f elf64 -l sum_values.lis -o sum_values.o sum_values.asm

echo "Compile the C++ file isfloat.cpp"
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o isfloat.o isfloat.cpp

echo "Compile the C++ file assessor.cpp"
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o assessor.o assessor.cpp

echo "Compile the C file show_values.c"
gcc -c -Wall -m64 -no-pie -o show_values.o show_values.c -std=gnu11 -lm

echo "Link the three files isFloat.o driver2.o compute_time.o"
g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out isfloat.o assessor.o manager.o get_values.o show_values.o sum_values.o

#gcc -m64 -no-pie -std=11 -o output.out isfloat.o assessor.o manager.o get_values.o show_values.o

echo "Next the program ""String I/O"" will run"
./output.out

rm *.lis
rm *.o
rm *.out
