IMPORT Models, Phone_Shell, Risk_Indicators, UT, STD;

EXPORT Common := MODULE
	EXPORT STRING30 generateMatchcode (STRING20 in_FirstName, STRING20 in_LastName,
														STRING120 in_StreetAddress, STRING10 in_PrimRange, STRING28 in_PrimName, STRING4 in_AddrSuffix,
														STRING25 in_City, STRING2 in_State, STRING5 in_Zip,
														STRING8 in_DOB, STRING9 in_SSN,
														UNSIGNED8 in_DID, STRING10 in_HomePhone, STRING10 in_WorkPhone,
														STRING20 FirstName, STRING20 LastName,
														STRING120 StreetAddress, STRING10 PrimRange, STRING28 PrimName, STRING4 AddrSuffix, 
														STRING25 City, STRING2 State, STRING5 Zip,
														STRING8 DOB, STRING9 SSN,
														UNSIGNED8 DID, STRING10 Phone) := FUNCTION
		matchName 	:= TRIM(in_FirstName) <> '' AND TRIM(in_LastName) <> '' AND
									Risk_Indicators.iid_constants.g(Risk_Indicators.FnameScore(StringLib.StringToUpperCase(TRIM(in_FirstName)), StringLib.StringToUpperCase(TRIM(FirstName)))) AND
									Risk_Indicators.iid_constants.g(Risk_Indicators.LnameScore(StringLib.StringToUpperCase(TRIM(in_LastName)), StringLib.StringToUpperCase(TRIM(LastName))));
		matchStreetAddress := TRIM(in_StreetAddress) <> '' AND StringLib.StringToUpperCase(TRIM(in_StreetAddress)) = StringLib.StringToUpperCase(TRIM(StreetAddress));
		matchPartsStreetAddress := TRIM(in_PrimRange) <> '' AND TRIM(in_PrimName) <> '' AND
															StringLib.StringToUpperCase(TRIM(in_PrimRange)) = StringLib.StringToUpperCase(TRIM(PrimRange)) AND
															StringLib.StringToUpperCase(TRIM(in_PrimName)) = StringLib.StringToUpperCase(TRIM(PrimName)) AND
															StringLib.StringToUpperCase(TRIM(in_AddrSuffix)) = StringLib.StringToUpperCase(TRIM(AddrSuffix));
		matchCity 	:= TRIM(in_City) <> '' AND StringLib.StringToUpperCase(TRIM(in_City)) = StringLib.StringToUpperCase(TRIM(City));
		matchState 	:= TRIM(in_State) <> '' AND StringLib.StringToUpperCase(TRIM(in_State)) = StringLib.StringToUpperCase(TRIM(State));
		matchZip		:= TRIM(in_Zip) <> '' AND Risk_Indicators.iid_constants.g(Risk_Indicators.AddrScore.zip_score(TRIM(in_Zip[1..5]), TRIM(Zip[1..5])));
		matchDOB 		:= (INTEGER)in_DOB > 0 AND Risk_Indicators.iid_constants.g(100 - MAX(UT.StringSimilar100(TRIM(in_DOB), TRIM(DOB)), UT.StringSimilar100(TRIM(DOB), TRIM(in_DOB))));
		matchSSN 		:= (INTEGER)in_SSN > 0 AND Risk_Indicators.iid_constants.g(100 - MAX(UT.StringSimilar100(TRIM(in_SSN), TRIM(SSN)), UT.StringSimilar100(TRIM(SSN), TRIM(in_SSN))));
		matchDID 		:= in_DID <> 0 AND in_DID = DID;
		matchPhone 	:= ((INTEGER)in_HomePhone > 0 OR (INTEGER)in_WorkPhone > 0) AND (Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(TRIM(in_HomePhone), TRIM(Phone))) OR Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(TRIM(in_WorkPhone), TRIM(Phone))));
		
		matchCode 	:= IF(matchStreetAddress OR matchPartsStreetAddress, 'A,', '') +
									 IF(matchCity,					'C,', '') +
									 IF(matchDOB,						'D,', '') +
									 IF(matchDID,						'L,', '') +
									 IF(matchName,					'N,', '') +
									 IF(matchPhone,					'P,', '') +
									 IF(matchSSN,						'S,', '') +
									 IF(matchState,					'T,', '') +
									 IF(matchZip,						'Z,', '');
		RETURN (matchCode);
	END;	
	
	EXPORT STRING30 CombineMatchcodes(STRING30 leftMatchCode, STRING30 rightMatchCode) := FUNCTION
		matchAddress := StringLib.StringFind(leftMatchCode, 'A', 1) > 0 OR StringLib.StringFind(rightMatchCode, 'A', 1) > 0;
		matchCity := StringLib.StringFind(leftMatchCode, 'C', 1) > 0 OR StringLib.StringFind(rightMatchCode, 'C', 1) > 0;
		matchDOB := StringLib.StringFind(leftMatchCode, 'D', 1) > 0 OR StringLib.StringFind(rightMatchCode, 'D', 1) > 0;
		matchDID := StringLib.StringFind(leftMatchCode, 'L', 1) > 0 OR StringLib.StringFind(rightMatchCode, 'L', 1) > 0;
		matchName := StringLib.StringFind(leftMatchCode, 'N', 1) > 0 OR StringLib.StringFind(rightMatchCode, 'N', 1) > 0;
		matchPhone := StringLib.StringFind(leftMatchCode, 'P', 1) > 0 OR StringLib.StringFind(rightMatchCode, 'P', 1) > 0;
		matchSSN := StringLib.StringFind(leftMatchCode, 'S', 1) > 0 OR StringLib.StringFind(rightMatchCode, 'S', 1) > 0;
		matchState := StringLib.StringFind(leftMatchCode, 'T', 1) > 0 OR StringLib.StringFind(rightMatchCode, 'T', 1) > 0;
		matchZip := StringLib.StringFind(leftMatchCode, 'Z', 1) > 0 OR StringLib.StringFind(rightMatchCode, 'Z', 1) > 0;
		
		matchCode 	:= IF(matchAddress, 'A,', '') +
									 IF(matchCity,		'C,', '') +
									 IF(matchDOB,			'D,', '') +
									 IF(matchDID,			'L,', '') +
									 IF(matchName,		'N,', '') +
									 IF(matchPhone,		'P,', '') +
									 IF(matchSSN,			'S,', '') +
									 IF(matchState,		'T,', '') +
									 IF(matchZip,			'Z,', '');
									 
		RETURN(matchCode);
	END;
	
	EXPORT STRING8 parseDate(STRING date, BOOLEAN leaveBlank = FALSE) := FUNCTION
    todays_date := STD.Date.Today();
		commonDate := Models.Common.readDate(date);
		// Make sure that the date isn't a future date, and if there is no date information populate with todays date
    RETURN IF ((INTEGER)commonDate <> 0, (string) MIN((UNSIGNED8)commonDate, todays_date), IF(leaveBlank, '', (string) todays_date));
	END;
	
	// Returns TRUE if the found phone is allowed by the Phone Restriction Mask.  
	// anyAddress overrides the input address match for historical PP and EDA searches.
	// firstDegreeRelative just states if this is a first degree relative phone.
	// isGatewayResult indicates that this phone was returned from a Gateway, since we spent money to get this phone always return it
	EXPORT BOOLEAN PhoneRestrictionMaskOK(UNSIGNED1 PhoneRestrictionMask, STRING30 matchcode, STRING25 inputLastName, STRING25 foundLastName, BOOLEAN anyAddress = FALSE, BOOLEAN firstDegreeRelative = FALSE, BOOLEAN isGatewayResult = FALSE) := FUNCTION
							// Mask is OK if all phones are allowed...
		maskOK := PhoneRestrictionMask = Phone_Shell.Constants.PRM.AllPhones OR
							// Mask is OK if SubjectDIDOnly is turned on and the LexID matches...
							(PhoneRestrictionMask = Phone_Shell.Constants.PRM.SubjectDIDOnly AND StringLib.StringFind(matchCode, 'L', 1) > 0) OR
							// Mask is OK if LastNameAddressOnly is turned on and the Last name matches and the address matches...
							(PhoneRestrictionMask = Phone_Shell.Constants.PRM.LastNameAddressOnly AND Risk_Indicators.iid_constants.g(Risk_Indicators.LnameScore(StringLib.StringToUpperCase(TRIM(inputLastName)), StringLib.StringToUpperCase(TRIM(foundLastName)))) AND StringLib.StringFind(matchcode, 'A', 1) > 0) OR
							// Mask is ok if SSNOnly is turned on and the SSN matches...
							(PhoneRestrictionMask = Phone_Shell.Constants.PRM.SSNOnly AND StringLib.StringFind(matchCode, 'S', 1) > 0) OR
							// Mask is OK if AddressOnly is turned on and the Address matches...
							(PhoneRestrictionMask = Phone_Shell.Constants.PRM.AddressOnly AND StringLib.StringFind(matchCode, 'A', 1) > 0) OR
							// Mask is OK if AddressOnly is turned on and the Address Override is TRUE...
							(PhoneRestrictionMask = Phone_Shell.Constants.PRM.AddressOnly AND anyAddress = TRUE) OR
							// Mask is OK if FirstDegreeRelativeOnly is turned on and this is a FirstDegreeRelative...
							(PhoneRestrictionMask = Phone_Shell.Constants.PRM.FirstDegreeRelativeOnly AND firstDegreeRelative = TRUE) OR
							// Mask is OK if this phone came from a Gateway call - we spent money to get this phone, return it...
							isGatewayResult = TRUE;
		RETURN(maskOK);
	END;
END;