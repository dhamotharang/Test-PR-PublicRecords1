import salt29;

EXPORT fn_MatchesToText (STRING m) := FUNCTION
	noMatch := [(String)SALT29.MatchCode.OneComponentNull, (String)SALT29.MatchCode.OneSideNull, '0', '-'];
	matchSet := StringLib.SplitWords(m, '/', false);
	// output(matchSet, named('matchSet'));
	res := IF(TRIM(M)='', m, 
					IF(matchSet[1] not in noMatch,  'NAMESUFFIX,', '')  + IF(matchSet[2] not in noMatch, 'FIRSTNAME,', '') + 
				 IF(matchSet[3] not in noMatch,  'MIDDLENAME,', '')  + IF(matchSet[4] not in noMatch, 'LASTNAME,', '') + 
				 IF(matchSet[5] not in noMatch, 'DERIVED_GENDER,', '') + 
				 IF(matchSet[6] not in noMatch,  'PRIM_RANGE,', '')  + IF(matchSet[7] not in noMatch, 'PRIM_NAME,', '') + 
				 IF(matchSet[8] not in noMatch,  'SEC_RANGE,', '')   + IF(matchSet[9] not in noMatch, 'CITY,', '') + 
				 IF(matchSet[10] not in noMatch, 'STATE,', '') 	    + IF(matchSet[11] not in noMatch, 'ZIP,', '') + 
				 IF(matchSet[12] not in noMatch, 'SSN5,', '')         + 
				  IF(matchSet[13] not in noMatch, 'SSN4,', '')         + 
					IF(matchSet[14] not in noMatch, 'DOB_YEAR,', '')      +
					IF(matchSet[15] not in noMatch, 'DOB_MONTH,', '')      +
					IF(matchSet[16] not in noMatch, 'DOB_DAY,', '')      +							
				 IF(matchSet[17] not in noMatch, 'PHONE,', '')       + IF(matchSet[18] not in noMatch, 'DL_STATE,', '') + 
				 IF(matchSet[19] not in noMatch, 'DL_NBR,', '')      + IF(matchSet[20] not in noMatch, 'SRC,', '') + 
				 IF(matchSet[21] not in noMatch, 'SOURCE_RID,', '')  +
				 IF(matchSet[22] not in noMatch, 'MAINNAME,', ''));							
	RETURN res;
END;