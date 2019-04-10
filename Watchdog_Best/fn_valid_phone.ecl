import ut;
EXPORT fn_valid_phone(string s, string src) := CASE(LENGTH(trim(s)),
			10 => 	ut.isNumeric(s) and (unsigned)s[..3] > 0 and s not in ut.Set_BadPhones,
			 7 => 	ut.isNumeric(s),
			 false);

