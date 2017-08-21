import SALT29;

EXPORT matches (STRING matchCode) := MODULE

	EXPORT isSuffixMatch := matchCode[1] <> '-';
	EXPORT isFirstMatch := matchCode[2] <> '-';
	EXPORT isMiddleMatch := matchCode[3] <> '-';
	EXPORT isLastMatch := matchCode[4] <> '-';
	EXPORT isPrimRangeMatch := matchCode[5] <> '-';
	EXPORT isPrimNameMatch := matchCode[6] <> '-';
	EXPORT isSecRangeMatch := matchCode[7] <> '-';
	EXPORT isCityMatch := matchCode[8] <> '-';
	EXPORT isStateMatch := matchCode[9] <> '-';
	EXPORT isZipMatch := matchCode[10] <> '-';
	EXPORT isSSN5Match := matchCode[11] <> '-';
	EXPORT isSSN4Match := matchCode[12] <> '-';
	EXPORT isDobYearMatch := matchCode[13] <> '-';
	EXPORT isDobMonthMatch := matchCode[14] <> '-';
	EXPORT isDobDayMatch := matchCode[15] <> '-';
	EXPORT isPhoneMatch := matchCode[16] <> '-';
	EXPORT isDOBMatch := isDobYearMatch and isDobMonthMatch and isDobDayMatch ;
	EXPORT isNameMatch := isFirstMatch and isLastMatch;
	EXPORT isAnyDOBMatch := isDobYearMatch or isDobMonthMatch or isDobDayMatch;
	
	EXPORT isNameStOnlyMatch := isNameMatch and isStateMatch and 
			not (isPrimRangeMatch or isPrimNameMatch or isSecRangeMatch or isCityMatch 
				or isZipMatch or isSSN5Match or isSSN4Match or isAnyDOBMatch or isPhoneMatch);
				
	EXPORT isNamePhoneOnlyMatch := isNameMatch and isPhoneMatch and
			not (isPrimRangeMatch or isPrimNameMatch or isSecRangeMatch or isCityMatch 
				or isZipMatch or isSSN5Match or isSSN4Match or isAnyDOBMatch or isStateMatch);
				
	EXPORT isNameAddrOnlyMatch := isNameMatch and isPrimNameMatch and
			not (isSSN5Match or isSSN4Match or isAnyDOBMatch);
			
	EXPORT isNameDobOnlyMatch := isNameMatch and isDobMatch and 
		not(isPrimRangeMatch or isPrimNameMatch or isSecRangeMatch or isCityMatch 
				or isZipMatch or isSSN5Match or isSSN4Match or isStateMatch or isPhoneMatch);
				
	EXPORT isNameSsnOnlyMatch := isNameMatch and isSSN5Match and isSSN4Match and 
		not(isPrimRangeMatch or isPrimNameMatch or isSecRangeMatch or isCityMatch 
				or isZipMatch or isStateMatch or isPhoneMatch or isAnyDOBMatch);
	
	/**
	 * Translate match numbers to readable text matches 
	 */	 
	EXPORT xADL2_MatchesToText := 
				IF(TRIM(matchCode) = '', matchCode, 
				IF(matchCode[1]<>'-',  'NAMESUFFIX,', '') + 	IF(matchCode[2]<>'-',  'FIRSTNAME,', '') + 
				IF(matchCode[3]<>'-',  'MIDDLENAME,', '') + 	IF(matchCode[4]<>'-',  'LASTNAME,', '') + 
				IF(matchCode[5]<>'-',  'PRIM_RANGE,', '') + 	IF(matchCode[6]<>'-',  'PRIM_NAME,', '') + 
				IF(matchCode[7]<>'-',  'SEC_RANGE,', '') + 		IF(matchCode[8]<>'-',  'CITY,', '') + 
				IF(matchCode[9]<>'-',  'STATE,', '') + 				IF(matchCode[10]<>'-', 'ZIP,', '') + 
				IF(matchCode[11]<>'-', 'SSN5,', '') + 				IF(matchCode[12]<>'-', 'SSN4,', '') + 
				IF(matchCode[13]<>'-', 'DOB_YEAR,', '') + 		IF(matchCode[14]<>'-', 'DOB_MONTH,', '') + 
				IF(matchCode[15]<>'-', 'DOB_DAY,', '') + 			IF(matchCode[16]<>'-', 'PHONE', '') );
	
	
	/**
	 * translate xLink matches string into xadl2 matches format.
	 */
	 
	EXPORT xLinkToxADL2Matches(String xLinkMatches) := 	FUNCTION
			noMatch := [(String)SALT29.MatchCode.OneComponentNull, 
									(String)SALT29.MatchCode.OneSideNull, '0', '-'];
									
			matchset := StringLib.SplitWords(xLinkMatches, '/', false);	
			res := 		IF(matchSet[1]  not in noMatch, '1', '-') + 
								IF(matchSet[2]  not in noMatch, '1', '-') + 
								IF(matchSet[3]  not in noMatch, '1', '-') + 
								IF(matchSet[4]  not in noMatch, '1', '-') + 				 
				 // skip matchset[5] because it is derived gender
								IF(matchSet[6]  not in noMatch, '1', '-') + 
								IF(matchSet[7]  not in noMatch, '1', '-') + 
								IF(matchSet[8]  not in noMatch, '1', '-') + 
								IF(matchSet[9]  not in noMatch, '1', '-') + 
								IF(matchSet[10] not in noMatch, '1', '-') + 
								IF(matchSet[11] not in noMatch, '1', '-') + 
								IF(matchSet[12] not in noMatch, '1', '-') +  
								IF(matchSet[13] not in noMatch, '1', '-') + 
								IF(matchSet[14] not in noMatch, '1', '-') + 
								IF(matchSet[15] not in noMatch, '1', '-') +
								IF(matchSet[16] not in noMatch, '1', '-') +
								IF(matchSet[17] not in noMatch, '1', '-');
		RETURN res;
	END;
END;
