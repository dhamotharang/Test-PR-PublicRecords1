// note: order of bits is "normal"
unsigned8 string2intBitmask (string bitstr) := BEGINC++
  size32_t len = lenBitstr;
  unsigned __int64 sm = 0;
  for (size32_t i= 0; i < len; i++)
  {
    char ch = bitstr[i];
    if (ch == '1')
      sm |= ((unsigned __int64)1) << (len-i-1);
  }
  return sm;

ENDC++;


// To complement ut\IntegerToBinaryString, convert binary string to an integer (unsigned8, actually):
//   '1'     --> 1
//   '0001'  --> 1
//   '10011' --> 19
//   '0'     --> 0
//   'AAA'   --> 0
//   'A1A'   --> 2
//   '10..0' (63 zeroes) -->	9223372036854775808
//   '1..1'	 (64 ones)   --> 18446744073709551615 (maximum value possible)

// Returns a non-negative integer corresponding to a binary string.
// It is responsibility of a caller to ensure the validity of an input string.
EXPORT BinaryStringToInteger (string str) := string2intBitmask (TRIM (str, LEFT, RIGHT));