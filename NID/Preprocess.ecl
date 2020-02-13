IMPORT	STD;
	string TrimRightPunct(string s) := REGEXREPLACE('[ ,&+*/\\x00-\\x1f\\x80-\\xff-]+$',s,'');
	string Unquote(string s) := REGEXREPLACE('^\'(.+)\'$', s, '$1');
	rgxMispelledTrust := ' (TRU ST|TRUS, T|TR, UST)$';
	CheckMispelledTrust(string s) := IF(REGEXFIND(rgxMispelledTrust, s), REGEXREPLACE(rgxMispelledTrust, s, ' TRUST'), s);

EXPORT string Preprocess(string s, string options) := Std.Str.CleanSpaces(CheckMispelledTrust(
		TrimRightPunct($.NameTester.RemoveNonPrintingChars(Unquote(
			STD.str.SubstituteIncluded(s,
				'\r\n\t\000',' ')
		)))));
