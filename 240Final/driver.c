// ; Author Contact:
// ;   Name: David Harboyan
// ;   Email: harboyandavid@csu.fullerton.edu
// ;   Section: 07
// ; Name of Program: Current Calculator
// ; Purpose: Compute the current given the emf value and resistance.

#include "stdio.h"

extern double electric();

int main() {

  printf("\nWelcome to the Electric Power Program by David Harboyan.\n\n");

  double result = electric();

  printf("The caller received this number %.4lf and will keep it.\n", result);
  printf("A zero will be sent to the OS as a signal of success.\n");

  return 0;
}
