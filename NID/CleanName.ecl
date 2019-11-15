IMPORT Std, Address;

set of string1 Types :=  ['$', 'T', 'B', 'P', 'D', 'U', 'I', ''];

EXPORT CleanName(string s) := FUNCTION

		rawName := s;
		preprocessed := TRIM($.Preprocess(Std.Str.ToUpperCase(s),''),LEFT,RIGHT);
		preCleaned := Address.PrecleanName(s);
		fmt := Address.Persons.PersonalNameFormat(preCleaned);
		quality := Address.Persons.NameQuality(preCleaned);
		isDual := false;			//Address.Persons.IsDualName(preCleaned);
		
		ntype := $.fn_nonPerson(rawName, preprocessed, preCleaned, quality);
		cleaned := CASE(ntype,
							   MatchType.Person => $.mod_NameFormat.FormatName(preCleaned, fmt), 
							   MatchType.Dual => $.mod_NameFormat.FormatName1(preCleaned, fmt),
								 '');
		cleaned2 := IF(ntype = MatchType.Dual, $.mod_NameFormat.FormatName2(preCleaned, fmt), '');
		
		dBiz := DATASET([{rawName, preprocessed, preCleaned, cleaned, cleaned2, ntype, fmt, quality, isDual}], $.rNameId);

		return dBiz;

END;