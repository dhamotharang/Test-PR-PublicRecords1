IMPORT	Std, Address;

EXPORT CleanNames(DATASET($.rNameId) ds) :=
		PROJECT(ds, TRANSFORM($.rNameId,
					__nid := $.Common.fGetNID(left.__rawName);
					self.__rawName := left.__rawName;
					self.__preProcessed := TRIM($.Preprocess(Std.Str.ToUpperCase(self.__rawName),''),LEFT,RIGHT);
					preCleaned := Address.PrecleanName(self.__rawName);
					self.__preCleaned := preCleaned;
					fmt := $.mod_NameFormat.PersonalNameFormat(preCleaned);
					quality := $.mod_NameFormat.NameQuality(preCleaned, fmt);
					
					self.__nameFormat := fmt;
					self.__nameQuality := quality;
					self.__isDualName := false;			//Address.Persons.IsDualName(preCleaned);
		
					ntype := $.fn_nonPerson(TRIM(self.__rawName), TRIM(self.__preProcessed), TRIM(preCleaned),
													self.__nameQuality, fmt);
					self.__nameType := ntype;
					self.__CleanedName := CASE(ntype,
							   $.MatchType.Person => $.mod_NameFormat.FormatName(preCleaned, fmt), 
							   $.MatchType.Dual => $.mod_NameFormat.FormatName1(preCleaned, fmt),
								 '');
					self.__CleanedName2 := IF(ntype = $.MatchType.Dual, $.mod_NameFormat.FormatName2(preCleaned, fmt), '');
					self.__nameind := ntype | (self.__nameQuality << 3);
					self.__nType := $.Conversions.NameTypeToChar(ntype);
					
		));