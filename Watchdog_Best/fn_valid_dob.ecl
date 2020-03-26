import STD;
RightNow() := STD.Date.Today();
YearOf(unsigned4 dt, unsigned adjustment) := Std.Date.Year(STD.Date.AdjustDate(dt, adjustment));
EXPORT fn_valid_dob (string s, string src) := FUNCTION
			dob := TRIM(s);
			return
						dob <> ''
				AND	STD.Date.IsValidDate((UNSIGNED4) dob, YearOf(rightNow(), -150) , STD.Date.Year(rightNow()));
END;
