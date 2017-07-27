/**
 * Returns bit count of given integer
 */
EXPORT unsigned4 bit_count(unsigned4 n) := 
BEGINC++
#include <stdio.h>
#include <string.h>
  unsigned int c; // the total bits set in n
  for (c = 0; n; n = n & (n-1))
  {
    c++;
  }
  return c;
ENDC++;