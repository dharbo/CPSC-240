# ; Author Contact:
# ;   Name: David Harboyan
# ;   Email: harboyandavid@csu.fullerton.edu
# ;   Section: 07
# ; Name of Program: Root solver
# ; Purpose: To find all roots given three values a, b, and c.
#!/bin/bash

rm *.o
rm *.out

echo "Assemble the X86 file roots.asm"
nasm -f elf64 -l roots.lis -o roots.o roots.asm

echo "Assemble the X86 file get_coeff.asm"
nasm -f elf64 -l get_coeff.lis -o get_coeff.o get_coeff.asm

echo "Assemble the X86 file display_values.asm"
nasm -f elf64 -l display_values.lis -o display_values.o display_values.asm

echo "Assemble the X86 file tworoots.asm"
nasm -f elf64 -l tworoots.lis -o tworoots.o tworoots.asm

echo "Compile the C++ file quad.cpp"
g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o quad.o quad.cpp

echo "Compile the C++ file oneroot.cpp"
g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o oneroot.o oneroot.cpp

echo "Compile the C++ file noroots.cpp"
g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o noroots.o noroots.cpp

echo "Link the three files quad.o roots.o"
g++ -m64 -std=c++14 -fno-pie -no-pie -o driver.out quad.o roots.o get_coeff.o display_values.o tworoots.o oneroot.o noroots.o

echo "Next the program ""String I/O"" will run"
./driver.out

rm *.lis
rm *.o
rm *.out
