import std;
EXPORT fn_LowQualityDob(string s, string src) := FUNCTION
				words := Std.Str.SplitWords(s, '|', true);
				return IF(words[2]='L', true, false);
END;