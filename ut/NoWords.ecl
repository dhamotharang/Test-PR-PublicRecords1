IMPORT STD; 

/**
 * Returns the number of words that the string contains.  Words are separated by one or more separator strings. No 
 * spaces are stripped from either string before matching.
 * 
 * @param src           The string being searched in.
 * @param separator     The string used to separate words
 */
 
EXPORT UNSIGNED4 NoWords(STRING src,STRING1 separator =' ') := STD.Str.CountWords( src, separator) : DEPRECATED('Use STD.Str.CountWords with non empty separator instead.'); 