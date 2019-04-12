import STD;
RightNow() := STD.Date.Today();
YearOf(unsigned4 dt, unsigned adjustment) := Std.Date.Year(STD.Date.AdjustDate(dt, adjustment));
EXPORT fn_valid_dob (string s, string src) := FUNCTION
				words := Std.Str.SplitWords(s, '|', true);
				return
						words[1] <> ''
				AND	STD.Date.IsValidDate((UNSIGNED4) words[1], YearOf(rightNow(), -150) , STD.Date.Year(rightNow()));
END;
