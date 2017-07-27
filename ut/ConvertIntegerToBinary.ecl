/* ****************************************************************************
 *  This function takes in an INTEGER and returns the BINARY representation   *
 *  Set dropLeadingZeros to TRUE if you don't wish to return the full 64 bit  *
 *  character string.                                                         *
 ******************************************************************************
 *  Ex: input := 4, dropLeadingZeros := TRUE == final := '100'                *
 **************************************************************************** */
IMPORT STD; 

EXPORT ConvertIntegerToBinary(UNSIGNED8 input, BOOLEAN dropLeadingZeros = FALSE) 
  := ut.IntegerToBinaryString (input, dropLeadingZeros) : DEPRECATED('Use ut.IntegerToBinaryString Instead');