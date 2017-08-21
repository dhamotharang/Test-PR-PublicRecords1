//functions to clean names
IMPORT ut, Address, NID;

EXPORT fnCleanNames := MODULE
	
	SHARED DBA_Pattern := '( DBA | C/O | AKA | D/B/A | A/K/A | T/A )';
	SHARED Internet_Company_Pattern := '(\\.COM|\\.NET|\\.ORG)';

	//Fix the issue when the last name is bank, school, etc and the middle name is taken as the last name
	EXPORT easyClean(string fname, string mname, string lname, string suffix) := FUNCTION
	
		TrimNAME_LAST 				:= ut.fnTrim2Upper(lname);
		TrimNAME_FIRST 				:= ut.fnTrim2Upper(fname);
		TrimNAME_MID					:= ut.fnTrim2Upper(mname);
		TrimNAME_SUFFIX				:= ut.fnTrim2Upper(suffix);
		
		FullName							:= StringLib.StringCleanSpaces(TrimNAME_FIRST + ' ' + TrimNAME_MID + ' ' + TrimNAME_LAST + ' ' + TrimNAME_SUFFIX);
		removeNick						:= Prof_License_Mari.fGetNickname(FullName,'strip_nick');
		stripNickName					:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeNick));
		//ParsedName 						:= Address.CleanPersonFML73(stripNickName);
		ParsedName 						:= NID.CleanPerson73(stripNickName);	
		Title									:= TRIM(ParsedName[1..5],left,right);
		FirstName 						:= TRIM(ParsedName[6..25],left,right);
		MidName   						:= TRIM(ParsedName[26..45],left,right);	
		LastName  						:= TRIM(ParsedName[46..65],left,right); 
		sufx		  						:= TRIM(ParsedName[66..70],left,right);
		string5 title_5				:= Title;
		string20 fname_20			:= FirstName;
		string20 mname_20			:= IF(length(LastName)=1,LastName,MidName);
		string20 lname_20			:= IF(length(LastName)=1,TrimNAME_LAST,LastName);
		string5 sufx_5				:= IF(length(LastName)=1,TrimNAME_SUFFIX,sufx);
		string3 score_3				:= ParsedName[71..73];
		
		RETURN title_5+fname_20+mname_20+lname_20+sufx_5+score_3;

	END;
	
	//Input is office name and org name. 
	//Extract DBA name from office name or orgName
	//Output string -
	//         1.. 20 - prefix
	//				21.. 40 - suffix
	//				41..140 - dba name
	//			 141..240 - dba orig	
	EXPORT STRING240 ExtractCleanDBA(string officeName, string orgName) := FUNCTION
		
		TrimNAME_OFFICE := ut.fnTrim2Upper(officeName);
		prepName_OFFICE := REGEXREPLACE('(^DBA |^D/B/A |^AKA |^A/K/A |^C/O )',TrimNAME_OFFICE,'');
		TrimNAME_ORG := ut.fnTrim2Upper(orgName);
		prepName_ORG := REGEXREPLACE('(^DBA |^D/B/A |^AKA |^A/K/A |^C/O )',TrimNAME_ORG,'');

		//Identifying DBA NAMES
		getNAME_DBA	:= IF(REGEXFIND(DBA_Pattern,prepName_OFFICE), 
		                  Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepName_OFFICE),
											IF(REGEXFIND(DBA_Pattern,prepName_ORG),
											   Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepName_ORG), 
												 ''));
		StdNAME_DBA := REGEXREPLACE(',',Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getNAME_DBA),', ');
		CleanNAME_DBA	:= MAP(REGEXFIND(Internet_Company_Pattern,StdNAME_DBA) 
													=> Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
												 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,left,right))
												 OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,left,right)) 
												  => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
									    	 REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right))
												 OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,left,right)) 
												  => StdNAME_DBA,
									   		 Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
		string20 DBA_PREFIX := Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);  
		string100 NAME_DBA	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_DBA,'/',' '));
		string20 NAME_DBA_SUFX	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA)); 
		string100 NAME_DBA_ORIG := getNAME_DBA;														
		RETURN DBA_PREFIX+NAME_DBA_SUFX+NAME_DBA+NAME_DBA_ORIG;
		
	END;	

	//Input- office name and org name
	//Remove DBA and standardize the office name
	//Output string -
	//        1.. 2 - office name type (GR or MD)
	//				3 - 102 - office name
	EXPORT STRING102 ExtractCleanOfficeName(string officeName, string orgName) := FUNCTION

		TrimNAME_OFFICE := ut.fnTrim2Upper(officeName);
		prepName_OFFICE := REGEXREPLACE('(^DBA |^D/B/A |^AKA |^A/K/A |^C/O )',TrimNAME_OFFICE,'');
		TrimNAME_ORG := ut.fnTrim2Upper(orgName);
		prepName_ORG := REGEXREPLACE('(^DBA |^D/B/A |^AKA |^A/K/A |^C/O )',TrimNAME_ORG,'');

		rmvOfficeDBA := MAP(prepName_OFFICE<>'' AND REGEXFIND(DBA_Pattern,prepName_OFFICE) 
		                     => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepName_OFFICE),
												prepName_OFFICE<>'' AND NOT REGEXFIND(DBA_Pattern,prepName_OFFICE)
												 => prepName_OFFICE,
											  prepName_OFFICE='' AND prepName_ORG<>'' AND REGEXFIND(DBA_Pattern,prepName_ORG)
												 => Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepName_ORG),
											  prepName_OFFICE='' AND prepName_ORG<>'' AND NOT REGEXFIND(DBA_Pattern,prepName_ORG)
												 => prepName_ORG,
												prepName_OFFICE);
												
		tmpNAME_OFFICE := IF(rmvOfficeDBA = '' and prepName_ORG != '' 
												 and Prof_License_Mari.func_is_company(prepName_ORG)
												 and NOT REGEXFIND(DBA_Pattern,prepName_ORG),prepName_ORG,rmvOfficeDBA);
																					
		StdNAME_OFFICE	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(tmpNAME_OFFICE);														
		CleanNAME_OFFICE := IF(REGEXFIND(Internet_Company_Pattern,StdNAME_OFFICE), 
		                       Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_OFFICE),
													 Prof_License_Mari.mod_clean_name_addr.strippunctMisc(StdNAME_OFFICE)); 
		STRING100 NAME_OFFICE	    := StringLib.StringCleanSpaces(CleanNAME_OFFICE);
		STRING2 OFFICE_PARSE			:= IF(NAME_OFFICE != '' and Prof_License_Mari.func_is_company(NAME_OFFICE),
		                            'GR',
																 IF(NAME_OFFICE != '' and not Prof_License_Mari.func_is_company(NAME_OFFICE),
																    'MD',
																		'  '));
																		
		RETURN OFFICE_PARSE+NAME_OFFICE;
		
	END;	

END;