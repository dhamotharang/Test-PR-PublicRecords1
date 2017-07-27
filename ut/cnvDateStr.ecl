IMPORT STD ; 
/**
 * Converts a string to a Date_t using the relevant string format.  
 *
 * @param date_text     The string to be converted.
 * @param format        The format of the input string.
 * @return              The date that was matched in the string.  Returns 0 if failed to match 
 *                      or if the date components match but the result is an invalid date.
**/
EXPORT UNSIGNED4 cnvDateStr(STRING input) := STD.Date.FromStringToDate(input , '%b %d %Y') :DEPRECATED('Use STD.Date.FromStringToDate Instead'); 
	
