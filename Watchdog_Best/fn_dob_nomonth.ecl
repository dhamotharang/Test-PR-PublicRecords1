import std;
EXPORT fn_dob_nomonth(string s, string src) := FUNCTION
				words := Std.Str.SplitWords(s, '|', true);
				dob := words[1];
			return
				s[5..8]='0000'
				AND Watchdog_Best.fn_valid_dob(s[1..4] + '0101|'+words[2], src)
					;
END;