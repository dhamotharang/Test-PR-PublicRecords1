/*
This function will remove ASCII special characters from a string.
It will optionally replace a contiguous length of special characters with another specified string

*/
export fn_RemoveSpecialChars(string s, string replacement='') := 
			REGEXREPLACE('([^ -~]+)',s,replacement);