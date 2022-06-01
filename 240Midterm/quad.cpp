// ; Author Contact:
// ;   Name: David Harboyan
// ;   Email: harboyandavid@csu.fullerton.edu
// ;   Section: 07
// ; Name of Program: Root solver
// ; Purpose: To find all roots given three values a, b, and c.
#include <stdio.h>

extern "C" double roots();

int main() {
  printf("This is 240-7 midterm by David Harboyan\n\n");

  double result = roots();

  printf("The main function received %lf and will keep it. Have a nice day.\n\n", result);

  return 0;
}
