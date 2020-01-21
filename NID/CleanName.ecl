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
		
		cln_fname		:= cleaned[6..25];
		cln_mname		:= cleaned[26..45];
		gender			:= if(ntype = $.MatchType.Person,
								$.NameTester.GenderEx(cln_fname,cln_mname),'');

		nameind := $.NameIndicators.fn_setNameIndicators(ntype, quality, gender);

		dBiz := DATASET([{__nid, NID.Conversions.NameTypeToChar(ntype),
					rawName, preprocessed, preCleaned, cleaned, cleaned2, ntype, fmt, quality, nameind, gender, isDual}], $.rNameId);

		return dBiz;

END;