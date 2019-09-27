IMPORT Address;
EXPORT fn_valid_mname_strict(string s, string src) :=
			LENGTH(TRIM(s)) = 1 OR (Watchdog_Best.fn_valid_mname(s, src) AND Address.NameTester.IsFirstName(s));