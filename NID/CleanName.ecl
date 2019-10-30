IMPORT Std, Address;

	rgxMispelledTrust := ' (TRU ST|TRUS, T|TR, UST)$';
	CheckMispelledTrust(string s) := IF(REGEXFIND(rgxMispelledTrust, s), REGEXREPLACE(rgxMispelledTrust, s, ' TRUST'), s);
	string TrimRightPunct(string s) := REGEXREPLACE('[ ,&+*/\\x00-\\x1f\\x80-\\xff-]+$',s,'');
	string Unquote(string s) := REGEXREPLACE('^\'(.+)\'$', s, '$1');

	string Preprocess(string s, string options) := Std.Str.CleanSpaces(CheckMispelledTrust(
		TrimRightPunct(Address.NameTester.RemoveNonPrintingChars(Unquote(
			STD.str.SubstituteIncluded(
				Address.Persons.SuffixToAlpha(s),
						'\r\n\t\000',' ')
				)))));
		
EXPORT CleanName(string s) := FUNCTION

		rawName := s;
		preprocessed := TRIM(Preprocess(Std.Str.ToUpperCase(s),''),LEFT,RIGHT);
		preCleaned := Address.PrecleanName(s);
		fmt := Address.Persons.PersonalNameFormat(preCleaned);
		quality := Address.Persons.NameQuality(preCleaned);
		isDual := Address.Persons.IsDualName(preCleaned);
		
		ntype := $.fn_nonPerson(rawName, preprocessed, preCleaned);

		
		ds := DATASET([{rawName, preprocessed, preCleaned, '', ntype, fmt, quality, isDual}], $.rNameId);

		return ds;

END;