/* ****************************************************************************
 *  This function takes in an INTEGER and returns the BINARY representation   *
 *  Set dropLeadingZeros to TRUE if you don't wish to return the full 64 bit  *
 *  character string.                                                         *
 ******************************************************************************
 *  Ex: input := 4, dropLeadingZeros := TRUE == final := '100'                *
 **************************************************************************** */

IMPORT STD; 

EXPORT STRING IntegerToBinaryString(UNSIGNED8 input, BOOLEAN dropleadingzeros = FALSE) := FUNCTION
    STRING64 BinStr(UNSIGNED8 n) := BEGINC++
        for (int x = 0; x < 64; x++)
        {
            __result[63-x] = ((n & 1) == 1 ? '1' : '0');
            n >>= 1;
        }
    ENDC++;

    bit_str := BinStr(input);
    first_bit := Std.Str.Find(bit_str, '1', 1);

    RETURN (STRING)IF(dropleadingzeros, bit_str[first_bit..], bit_str);
END;

