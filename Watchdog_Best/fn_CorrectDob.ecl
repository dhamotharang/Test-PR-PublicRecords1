import std;
/*
C - correct 
L - correct but low quality
I - invalid
T - typo
B - bad
U - undetermined
*/
EXPORT fn_CorrectDob(string s, string src) := FUNCTION
				words := Std.Str.SplitWords(s, '|', true);
				return IF(words[2]='C', true, false);
END;