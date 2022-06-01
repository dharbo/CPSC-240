#include "stdio.h"

extern "C" double triangle();

int main() {

  printf("Welcome to Pythagoras, Inc.\n");
  printf("We make the cheapest triangle anywhere. Visit us at www.cheaptriangles.com.\n\n");

  double result = triangle();

  printf("The main program received this number %lf and will keep it for a while.\n\n", result);
  printf("Now a zero will be sent to the operating system.\n");


  return 0;
}
