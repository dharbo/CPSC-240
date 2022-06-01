#include <stdio.h>
#include <stdint.h>                                         //To students: the second, third, and fourth header files are probably not needed.
#include <ctime>

extern "C" double triangles();                            //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(){

  printf("Welcome to Amazing Triangles programmed by David Harboyan on January 24, 2022.\n");

  double result = triangles();

  printf("The driver recieved this number %lf and will simply keep it.\n", result);

  printf("An integer zero will now be sent to the operating system. Have a good day. Bye.\n");

  return 0;
}
