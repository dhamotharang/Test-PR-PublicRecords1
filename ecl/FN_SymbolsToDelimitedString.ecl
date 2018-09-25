/**
 * Converts one or more symbols (such as field names) into a comma-delimited
 * string.
 *
 * @param f1                A symbol to process; this is not a string; REQUIRED.
 * @param f2                A symbol to process; this is not a string; OPTIONAL.
 * @param f3                A symbol to process; this is not a string; OPTIONAL.
 * @param f4                A symbol to process; this is not a string; OPTIONAL.
 * @param f5                A symbol to process; this is not a string; OPTIONAL.
 * @param f6                A symbol to process; this is not a string; OPTIONAL.
 * @param f7                A symbol to process; this is not a string; OPTIONAL.
 * @param f8                A symbol to process; this is not a string; OPTIONAL.
 * @param f9                A symbol to process; this is not a string; OPTIONAL.
 * @param f10               A symbol to process; this is not a string; OPTIONAL.
 *
 * @return                  A string value containing all provided symbols
 *                          delimited by a comma and with all spaces removed.
 */

EXPORT FN_SymbolsToDelimitedString(f1, f2 = '', f3 = '', f4 = '', f5 = '', f6 = '', f7 = '', f8 = '', f9 = '', f10 = '') := FUNCTIONMACRO
    LOCAL s1 := #TEXT(f1) + ',' + #TEXT(f2) + ',' + #TEXT(f3) + ',' + #TEXT(f4) + ',' + #TEXT(f5) + ',' + #TEXT(f6) + ',' + #TEXT(f7) + ',' + #TEXT(f8) + ',' + #TEXT(f9) + ',' + #TEXT(f10);
    LOCAL s2 := REGEXREPLACE(',,+', s1, ',');
    LOCAL s3 := REGEXREPLACE('^,', s2, '');
    LOCAL s4 := REGEXREPLACE(',$', s3, '');

    RETURN TRIM(s4, ALL);
ENDMACRO;
