// ; Author Contact:
// ;   Name: David Harboyan
// ;   Email: harboyandavid@csu.fullerton.edu
// ;   Section: 07
// ; Name of Program: Root solver
// ; Purpose: To find all roots given three values a, b, and c.
#include "stdio.h"

extern "C" double oneroot(double dataarray[], long index);

double oneroot(double dataarray[], long index) {
  double b = dataarray[1];
  double negative_b = b * (-1);

  printf("The equation has one root which is %lf\n\n", negative_b);

  return negative_b;
}
