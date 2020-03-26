import std;
EXPORT fn_dob_noday(string s, string src) := FUNCTION
				words := Std.Str.SplitWords(s, '|', true);
				dob := words[1];
			return
				dob[7..8]='00'
				AND Watchdog_Best.fn_valid_dob(s[1..6] + '01|'+words[2], src)
		;
END;