IMPORT STD;
/**
 * Removes the suffix from the search string, if present, and returns the result.  Trailing spaces are 
 * stripped from both strings before matching.
 */
EXPORT StripTail(STRING L, STRING R) := Std.Str.RemoveSuffix(L,R):DEPRECATED('Use Std.Str.RemoveSuffix Instead');