IMPORT STD;
EXPORT fn_valid_mname(string s, string src) := FUNCTION

		return s <>''
				AND TRIM(s) NOT IN ['NMI','NMN','TR','RD']
				AND Watchdog_Best.fn_valid_fname(TRIM(s), src);
END;