/****
prefer G=good SSNs
second choise includes all others
***/
import STD;
EXPORT fn_ok_ssn(string s, string src) := FUNCTION
	words := Std.Str.SplitWords(s, '|');
	return IF(words[2] <> 'G', true, false);
END;