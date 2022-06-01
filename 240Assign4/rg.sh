#!/bin/bash

rm *.o
rm *.out

echo "Assemble the X86 file manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm -g -gdwarf

echo "Assemble the X86 file get_frequency.asm"
nasm -f elf64 -l get_frequency.lis -o get_frequency.o get_frequency.asm -g -gdwarf

echo "Assemble the X86 file compute_sum.asm"
nasm -f elf64 -l compute_sum.lis -o compute_sum.o compute_sum.asm -g -gdwarf

echo "Compile the C++ file harmonic.cpp"
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o harmonic.o harmonic.cpp -g

echo "Compile the C file output_one_line.c"
gcc -c -Wall -m64 -no-pie -o output_one_line.o output_one_line.c -std=gnu11 -lm -g

echo "Link the files"
g++ -m64 -std=c++17 -fno-pie -no-pie -o output.out manager.o harmonic.o compute_sum.o get_frequency.o output_one_line.o -g

#gcc -m64 -no-pie -std=11 -o output.out isfloat.o assessor.o manager.o get_values.o show_values.o

echo "Next the program ""String I/O"" will run"
gdb ./output.out

rm *.lis
rm *.o
rm *.out
