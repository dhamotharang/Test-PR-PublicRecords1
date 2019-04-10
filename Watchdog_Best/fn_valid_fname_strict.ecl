// don't accept initials
IMPORT Address;
EXPORT fn_valid_fname_strict(string s, string src) :=
			LENGTH(TRIM(s)) > 1 AND Watchdog_Best.fn_valid_fname(s, src) AND Address.NameTester.IsFirstName(s);
