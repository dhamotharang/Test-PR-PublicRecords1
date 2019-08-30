IMPORT	std, Address;
	rgxMispelledTrust := ' (TRU ST|TRUS, T|TR, UST)$';
	CheckMispelledTrust(string s) := IF(REGEXFIND(rgxMispelledTrust, s), REGEXREPLACE(rgxMispelledTrust, s, ' TRUST'), s);
	string TrimRightPunct(string s) := REGEXREPLACE('[ ,&+*/\\x00-\\x1f\\x80-\\xff-]+$',s,'');
	string Unquote(string s) := REGEXREPLACE('^\'(.+)\'$', s, '$1');

EXPORT string Preprocess (string s, string options) := Std.Str.CleanSpaces(CheckMispelledTrust(
		TrimRightPunct($.NameTester.RemoveNonPrintingChars(Unquote(
			STD.str.SubstituteIncluded(
				Address.Persons.SuffixToAlpha(s),
						'\r\n\t\000',' ')
				)))));
		;