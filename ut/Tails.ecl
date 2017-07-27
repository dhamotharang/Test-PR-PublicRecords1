IMPORT STD; 
/**
 * Returns true if the suffix string matches the trailing characters in the source string.  Trailing spaces are 
 * stripped from both strings before matching.
 */
EXPORT Tails(string l, string r) := Std.Str.EndsWith(L,R):DEPRECATED('Use Std.Str.EndsWith Instead') ;