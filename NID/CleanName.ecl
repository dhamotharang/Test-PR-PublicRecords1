IMPORT Std, Address;

set of string1 Types :=  ['T', 'B', 'P', 'D', 'U', 'I', ''];

EXPORT CleanName(string s) := FUNCTION
		__nid := $.Common.fGetNID(s);

		rawName := s;
		preprocessed := TRIM($.Preprocess(Std.Str.ToUpperCase(s),''),LEFT,RIGHT);
		preCleaned := Address.PrecleanName(s);
		fmt := $.mod_NameFormat.PersonalNameFormat(preCleaned);
		quality := $.mod_NameFormat.NameQuality(preCleaned, fmt);
		isDual := false;			//Address.Persons.IsDualName(preCleaned);
		
		ntype := $.fn_nonPerson(TRIM(rawName), TRIM(preprocessed), TRIM(preCleaned), quality, fmt);
		cleaned := CASE(ntype,
							   MatchType.Person => $.mod_NameFormat.FormatName(preCleaned, fmt), 
							   MatchType.Dual => $.mod_NameFormat.FormatName1(preCleaned, fmt),
								 '');
		cleaned2 := IF(ntype = MatchType.Dual, $.mod_NameFormat.FormatName2(preCleaned, fmt), '');
		
		dBiz := DATASET([{__nid, rawName, preprocessed, preCleaned, cleaned, cleaned2, ntype, fmt, quality, isDual}], $.rNameId);

		return dBiz;

END;