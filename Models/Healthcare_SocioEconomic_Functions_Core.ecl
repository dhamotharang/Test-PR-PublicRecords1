Import STD,UT;
EXPORT Healthcare_SocioEconomic_Functions_Core := Module
	export calcAge(STRING8 inDOB) := function
		AgeinYears := (string)ut.GetAge(inDOB);
		newYear := STD.Date.Year((integer)inDOB)+(integer)AgeinYears;
		compareDate := STD.Date.DateFromParts(newYear,STD.Date.Month((integer)inDOB),STD.Date.Day((integer)inDOB));
		monthsDiff := ut.MonthsApart(ut.getDate,(string)compareDate);
		partialAge := monthsDiff/12;
		finalAge := (integer)AgeinYears+partialAge;
		// output(AgeinYears);
		// output(newYear);
		// output(compareDate);
		// output(monthsDiff);
		// output(partialAge);
		// output(finalAge);
		return if(inDOB='',0,finalAge);
	end;
	export calcDaysInMonth(String RefYYYYMM) := function
		RefYYYY := (INTEGER2)RefYYYYMM[1..4];
		RefMM := (UNSIGNED1)RefYYYYMM[5..6];
		days := case(RefMM, 
					 01 => 31,
					 03 => 31,
					 05 => 31,
					 07 => 31,
					 08 => 31,
					 10 => 31,
					 12 => 31,
					 02 => IF(STD.Date.IsLeapYear(RefYYYY), 29, 28), 30);
		return if(RefYYYYMM='',0,days);
	end;
	export calcAgeInYears(STRING8 inDOB, STRING8 AgeRefYYYYMMDD) := function
		inDOBYear := (INTEGER2)inDOB[1..4];
		inDOBMonth := (UNSIGNED1)inDOB[5..6];
		inDOBDay := (UNSIGNED1)inDOB[7..8];
		AgeRefYear := (INTEGER2)AgeRefYYYYMMDD[1..4];
		AgeRefMonth := (UNSIGNED1)AgeRefYYYYMMDD[5..6];
		AgeRefDay := (UNSIGNED1)AgeRefYYYYMMDD[7..8];
		finalAge := ( STD.Date.FromGregorianYMD(AgeRefYear,AgeRefMonth,AgeRefDay)-STD.Date.FromGregorianYMD(inDOBYear,inDOBMonth,inDOBDay) )/365.2425;
		return if(inDOB='',0,finalAge);
	end;
	export RScalcAgeInYears(STRING8 inDOB, STRING8 AgeRefYYYYMMDD) := function
		inDOBYear := (INTEGER2)inDOB[1..4];
		inDOBMonth := (UNSIGNED1)inDOB[5..6];
		inDOBDay := (UNSIGNED1)inDOB[7..8];
		AgeRefYear := (INTEGER2)AgeRefYYYYMMDD[1..4];
		AgeRefMonth := (UNSIGNED1)AgeRefYYYYMMDD[5..6];
		AgeRefDay := (UNSIGNED1)AgeRefYYYYMMDD[7..8];
		finalAge := ( STD.Date.FromGregorianYMD(AgeRefYear,AgeRefMonth,AgeRefDay)-STD.Date.FromGregorianYMD(inDOBYear,inDOBMonth,inDOBDay) )/365.24;
		return if(inDOB='',0,ROUND(finalAge,2));
	end;
	
	export SeMAcalcAgeInYears(STRING8 inDOB, STRING8 AgeRefYYYYMMDD) := function
		inDOBYear := (INTEGER2)inDOB[1..4];
		inDOBMonth := (UNSIGNED1)inDOB[5..6];
		inDOBDay := (UNSIGNED1)inDOB[7..8];
		AgeRefYear := (INTEGER2)AgeRefYYYYMMDD[1..4];
		AgeRefMonth := (UNSIGNED1)AgeRefYYYYMMDD[5..6];
		AgeRefDay := (UNSIGNED1)AgeRefYYYYMMDD[7..8];
		finalAge := ( STD.Date.FromGregorianYMD(AgeRefYear,AgeRefMonth,AgeRefDay)-STD.Date.FromGregorianYMD(inDOBYear,inDOBMonth,inDOBDay) )/365.24;
		outAge := ROUND(finalAge,2);
		outAge_trunc := TRUNCATE(outAge*100)/100;
		return if(inDOB='',0,(DECIMAL5_2)outAge_trunc);
	end;
	export calc_Age_Gender_PDC_Rate(REAL8 age_in, STRING1 gender_in) := function
	age := if(age_in > 80, 80, age_in);
	Age_Gender_PDC_Rate := if(gender_in = 'F', 
	((-0.00000129 * POWER(age,3)) + (0.00004032 * POWER(age,2)) + (0.00335532 * age) + 0.63803229),
	((-0.00000092 * POWER(age,3)) + (0.00005444 * POWER(age,2)) + (0.00173714 * age) + 0.68144918));
	return Age_Gender_PDC_Rate;
	end;

	export calc_AG_Pred_Mot(REAL8 age_in, INTEGER female) := function
	REAL8 AG_Pred_Mot := MAX(0, 
							MIN(200, 55.90873 
								+ (18.26601 * (FEMALE))
								+ (0.7748944 * (age_in))
								+ ((-7.65616E-03)*POWER(age_in,2))
								+ ((7.154178E-05)*POWER(age_in,3))
								));
	return AG_Pred_Mot;
	end;
	
	export crosswalkState(String inState) := function
		clnState := trim(STD.Str.ToUpperCase(inState),left,right);
		return map(clnState = 'AK' => 1,
								clnState = 'AL' => 2,
								clnState = 'AR' => 3,
								clnState = 'AZ' => 4,
								clnState = 'CA' => 5,
								clnState = 'CO' => 6,
								clnState = 'CT' => 7,
								clnState = 'DE' => 8,
								clnState = 'FL' => 9,
								clnState = 'GA' => 10,
								clnState = 'HI' => 11,
								clnState = 'IA' => 12,
								clnState = 'ID' => 13,
								clnState = 'IL' => 14,
								clnState = 'IN' => 15,
								clnState = 'KS' => 16,
								clnState = 'KY' => 17,
								clnState = 'LA' => 18,
								clnState = 'MA' => 19,
								clnState = 'MD' => 20,
								clnState = 'ME' => 21,
								clnState = 'MI' => 22,
								clnState = 'MN' => 23,
								clnState = 'MO' => 24,
								clnState = 'MS' => 25,
								clnState = 'MT' => 26,
								clnState = 'NC' => 27,
								clnState = 'ND' => 28,
								clnState = 'NE' => 29,
								clnState = 'NH' => 30,
								clnState = 'NJ' => 31,
								clnState = 'NM' => 32,
								clnState = 'NV' => 33,
								clnState = 'NY' => 34,
								clnState = 'OH' => 35,
								clnState = 'OK' => 36,
								clnState = 'OR' => 37,
								clnState = 'PA' => 38,
								clnState = 'RI' => 39,
								clnState = 'SC' => 40,
								clnState = 'SD' => 41,
								clnState = 'TN' => 42,
								clnState = 'TX' => 43,
								clnState = 'UT' => 44,
								clnState = 'VA' => 45,
								clnState = 'VT' => 46,
								clnState = 'WA' => 47,
								clnState = 'WI' => 48,
								clnState = 'WV' => 49,
								clnState = 'WY' => 50,
								clnState = 'DC' => 51,
								clnState = 'PR' => 52,
								clnState = 'AA' => 53,
								clnState = 'AE' => 53,
								clnState = 'AP' => 53,
								clnState = 'AS' => 53,
								clnState = 'FM' => 53,
								clnState = 'GS' => 53,
								clnState = 'GU' => 53,
								clnState = 'MH' => 53,
								clnState = 'MP' => 53,
								clnState = 'PW' => 53,
								clnState = 'VI' => 53,
								clnState = 'RN' => 54,
								clnState = 'RR' => 55,
								clnState = 'EE' => 56,
								0);
	end;
	export crosswalkAddrRecentEconTrajectory(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = 'AA' => 1,
								clnVal = 'AB' => 2,
								clnVal = 'AC' => 3,
								clnVal = 'AD' => 4,
								clnVal = 'AE' => 5,
								clnVal = 'AF' => 6,
								clnVal = 'AU' => 7,
								clnVal = 'BA' => 8,
								clnVal = 'BB' => 9,
								clnVal = 'BC' => 10,
								clnVal = 'BD' => 11,
								clnVal = 'BE' => 12,
								clnVal = 'BF' => 13,
								clnVal = 'BU' => 14,
								clnVal = 'CA' => 15,
								clnVal = 'CB' => 16,
								clnVal = 'CC' => 17,
								clnVal = 'CD' => 18,
								clnVal = 'CE' => 19,
								clnVal = 'CF' => 20,
								clnVal = 'CU' => 21,
								clnVal = 'DA' => 22,
								clnVal = 'DB' => 23,
								clnVal = 'DC' => 24,
								clnVal = 'DD' => 25,
								clnVal = 'DE' => 26,
								clnVal = 'DF' => 27,
								clnVal = 'DU' => 28,
								clnVal = 'EA' => 29,
								clnVal = 'EB' => 30,
								clnVal = 'EC' => 31,
								clnVal = 'ED' => 32,
								clnVal = 'EE' => 33,
								clnVal = 'EF' => 34,
								clnVal = 'EU' => 35,
								clnVal = 'FA' => 36,
								clnVal = 'FB' => 37,
								clnVal = 'FC' => 38,
								clnVal = 'FD' => 39,
								clnVal = 'FE' => 40,
								clnVal = 'FF' => 41,
								clnVal = 'FU' => 42,
								clnVal = 'UA' => 43,
								clnVal = 'UB' => 44,
								clnVal = 'UC' => 45,
								clnVal = 'UD' => 46,
								clnVal = 'UE' => 47,
								clnVal = 'UF' => 48,
								clnVal = 'UU' => 49,
								-1);		
	end;
	export CrosswalkBankruptcyStatus(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = 'CASE DISMISSED' => 1,
								clnVal = 'DISCHARGE GRANTED' => 2,
								clnVal = 'DISCHARGE NA' => 3,
								clnVal = 'DISCHARGED' => 5,
								clnVal = 'DISMISSED' => 6,
								clnVal = 'TERMINATED' => 7,
								-1);
	end;
	export CrosswalkBankruptcyType(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = 'I' => 1,
								clnVal = 'B' => 2,
								-1);
	end;
	export CrosswalkCurrAddrDwellType(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = 'F' => 1,
								clnVal = 'G' => 2,
								clnVal = 'H' => 3,
								clnVal = 'M' => 4,
								clnVal = 'P' => 5,
								clnVal = 'R' => 6,
								clnVal = 'S' => 7,
								clnVal = 'U' => 8,
								-1);
	end;
	export CrosswalkInputAddrDwellType(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = 'F' => 1,
								clnVal = 'G' => 2,
								clnVal = 'H' => 3,
								clnVal = 'M' => 4,
								clnVal = 'P' => 5,
								clnVal = 'R' => 6,
								clnVal = 'S' => 7,
								clnVal = 'U' => 8,
								-1);
	end;
	export CrosswalkInputAddrValidation(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = 'M' => 1,
								clnVal = 'N' => 2,
								clnVal = 'V' => 3,
								-1);
	end;
	export CrosswalkInputPhoneType(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = '0' => 0,
								clnVal = '1' => 1,
								clnVal = '2' => 2,
								clnVal = '3' => 3,
								clnVal = '4' => 4,
								clnVal = '5' => 5,
								clnVal = '6' => 6,
								clnVal = '7' => 7,
								clnVal = '8' => 8,
								clnVal = '9' => 9,
								clnVal = 'A' => 10,
								clnVal = 'U' => 11,
								clnVal = 'Z' => 12,
								-1);
	end;
	export CrosswalkPrevAddrDwellType(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = 'F' => 1,
								clnVal = 'G' => 2,
								clnVal = 'H' => 3,
								clnVal = 'M' => 4,
								clnVal = 'P' => 5,
								clnVal = 'R' => 6,
								clnVal = 'S' => 7,
								clnVal = 'U' => 8,
								-1);
	end;
	export CrosswalkSsnIssueState(String inVal) := function
		clnState := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnState = 'AK' => 1,
								clnState = 'AL' => 2,
								clnState = 'AR' => 3,
								clnState = 'AZ' => 4,
								clnState = 'CA' => 5,
								clnState = 'CO' => 6,
								clnState = 'CT' => 7,
								clnState = 'DE' => 8,
								clnState = 'FL' => 9,
								clnState = 'GA' => 10,
								clnState = 'HI' => 11,
								clnState = 'IA' => 12,
								clnState = 'ID' => 13,
								clnState = 'IL' => 14,
								clnState = 'IN' => 15,
								clnState = 'KS' => 16,
								clnState = 'KY' => 17,
								clnState = 'LA' => 18,
								clnState = 'MA' => 19,
								clnState = 'MD' => 20,
								clnState = 'ME' => 21,
								clnState = 'MI' => 22,
								clnState = 'MN' => 23,
								clnState = 'MO' => 24,
								clnState = 'MS' => 25,
								clnState = 'MT' => 26,
								clnState = 'NC' => 27,
								clnState = 'ND' => 28,
								clnState = 'NE' => 29,
								clnState = 'NH' => 30,
								clnState = 'NJ' => 31,
								clnState = 'NM' => 32,
								clnState = 'NV' => 33,
								clnState = 'NY' => 34,
								clnState = 'OH' => 35,
								clnState = 'OK' => 36,
								clnState = 'OR' => 37,
								clnState = 'PA' => 38,
								clnState = 'RI' => 39,
								clnState = 'SC' => 40,
								clnState = 'SD' => 41,
								clnState = 'TN' => 42,
								clnState = 'TX' => 43,
								clnState = 'UT' => 44,
								clnState = 'VA' => 45,
								clnState = 'VT' => 46,
								clnState = 'WA' => 47,
								clnState = 'WI' => 48,
								clnState = 'WV' => 49,
								clnState = 'WY' => 50,
								clnState = 'DC' => 51,
								clnState = 'PR' => 52,
								clnState = 'AA' => 53,
								clnState = 'AE' => 53,
								clnState = 'AP' => 53,
								clnState = 'AS' => 53,
								clnState = 'FM' => 53,
								clnState = 'GS' => 53,
								clnState = 'GU' => 53,
								clnState = 'MH' => 53,
								clnState = 'MP' => 53,
								clnState = 'PW' => 53,
								clnState = 'VI' => 53,
								clnState = 'RN' => 54,
								clnState = 'RR' => 55,
								clnState = 'EE' => 56,
								0);
	end;
	export CrosswalkStatusMostRecent(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = 'O' => 1,
								clnVal = 'R' => 2,
								clnVal = 'U' => 3,
								-1);
	end;
	export CrosswalkStatusNextPrevious(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = 'O' => 1,
								clnVal = 'R' => 2,
								clnVal = 'U' => 3,
								-1);
	end;
	export CrosswalkStatusPrevious(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = 'O' => 1,
								clnVal = 'R' => 2,
								clnVal = 'U' => 3,
								-1);
	end;
	export Crosswalkv1_ProspectMaritalStatus(String inVal) := function
		clnVal := trim(STD.Str.ToUpperCase(inVal),left,right);
		return map(clnVal = '0' => 0,
								clnVal = '-1' => -1,
								clnVal = 'M' => 1,
								-1);
	end;
	
	export GetAge_Group(real8 inVal) := function
		trnc_inVal := TRUNCATE(inVal);
		return map( trnc_inVal <= 11 => 11,
					trnc_inVal >= 12 and trnc_inVal <= 40 => 40,
					trnc_inVal >= 41 and trnc_inVal <= 69 => 69,
					70);
	end;

	//SSN
	// 1. The input SSN will be cleaned first to remove all non-digit characters. 
	// 2. If the number of digits is 7 or 8, then the input SSN is padded with 
	// two 0s or one 0 respectively.
	// 3. If the first 8 digits of the SSN contains any of the following values, 
	// then the Validator returns an empty string: 00000000, 11111111, 22222222, 33333333, 44444444, 
	// 55555555, 66666666, 77777777, 88888888, 99999999, 12345678, 01234567, 98765432, 87654321, 10101010.
	// 4. If the number of digits is 4 and it is equal to any of the following values, 
	// then the Validator returns an empty string: 0000, 1111, 2222, 3333, 4444, 5555, 
	// 6666, 7777, 8888, 9999, 1234, 5678, 0123, 4567, 9876, 5432, 8765, 4321, 1010.
	// 5. If the number of digits is different than 4, 7, 8 or 9, then it returns an empty string.
	// 6. Otherwise, it returns a clean SSN in the format XXXXXXXXX or XXXX.

	EXPORT SSNCleaner(string SSN) := FUNCTION
		string cleanSSN := STD.STR.filter(SSN,'0123456789');
		ssnlength	:= length(cleanSSN);
		paddedSSN := map(ssnlength =7 => '00'+ cleanSSN,
						 ssnlength =8 => '0'+ cleanSSN,
						 cleanSSN);
		set_invalid_ssn8	:= ['00000000','11111111','22222222','33333333','44444444','55555555','66666666','77777777','88888888','99999999','12345678','01234567','98765432','87654321','10101010'];
		BOOLEAN	is_invalid_ssn8	:= paddedSSN[1..8] IN set_invalid_ssn8; 
		set_invalid_ssn4	:= ['0000','1111','2222','3333','4444','5555','6666','7777','8888','9999','1234','5678','0123','4567','9876','5432','8765','4321','1010'];
		BOOLEAN	is_invalid_ssn4	:= ssnlength = 4 AND paddedSSN IN set_invalid_ssn4;
		BOOLEAN	is_invalid_ssn_length := IF(ssnlength IN [4,7,8,9], FALSE, TRUE);
		OutSSN := IF(is_invalid_ssn8 OR is_invalid_ssn4 OR is_invalid_ssn_length,'', paddedSSN);
		return OutSSN;
	END;

	//DOB or DATE
	// 1. If the input date is 00000000, then the Validator returns an empty string.
	// 2. If the Strict Parsing Date option is enabled and the format of the input date is invalid, 
	// then it returns an empty string.
	// 3. Otherwise, it returns a clean DOB in the format YYYYMMDD.
	//Code can be used for DOB only and admit date
	EXPORT DOBCleaner(string8 InDate) := FUNCTION
		string cleanDOB := STD.STR.filter(InDate,'0123456789');
		LEN_DATE :=	LENGTH(TRIM(cleanDOB,LEFT,RIGHT));
		is_Valid_DOB := IF(STD.Date.IsValidDate((integer)cleanDOB) 
							AND (integer) cleanDOB <= (integer) STD.Date.CurrentDate()
							AND (integer) cleanDOB[1..4] >= 1900 , TRUE, FALSE);
		OutDOB := IF(LEN_DATE = 8 and is_Valid_DOB, cleanDOB, '');
		return OutDOB;	
	END;

	//PHONE
	// 1.	If the number of digits is 11 and the first digit is not 1, 
	// the Validator returns an empty string.
	// 2.	If the input phone number has an area code and the first digit is 0 or 1, 
	// or the second digit is 9, then it returns an empty string.
	// 3.	If the second group of three digits starts with 0 or 1, then it returns an empty string.
	// 4.	If number of digits is different than 11, 10 or 7, then it returns an empty string.
	// 5.	Otherwise, it returns a cleaned phone in the format XXXXXXXXXX.
	//Code can be used for US Phone Numbers
	EXPORT PhoneCleaner(string pPhone) := function
		alpha		:= '[[:alpha:]]+';
		whitespace	:= '[[:space:]]*';
		sepchar		:= '[-./]?';
		separator1	:= whitespace + sepchar + whitespace;
		frontdigit	:= '[01]?' + separator1;  // front digit
		OpenParen 	:= '[[({<]?';
		CloseParen	:= '[])}>]?';
		areacode 	:= frontdigit + OpenParen + '([[:digit:]]{3})' + CloseParen;
		exchange	:= '([[:digit:]]{3})';
		lastfour	:= '([[:digit:]]{4})';
		seven		:= exchange + separator1 + lastfour;
		extension	:= '(' + whitespace + alpha + sepchar + whitespace + '[[:digit:]]+' + ')?';
		phonenumber_regex := '(' + areacode + ')?' +  separator1 + seven + extension + whitespace;
		phone_number := regexreplace(phonenumber_regex, pPhone, '$2$3$4');
		find_phone_number := regexfind(phonenumber_regex, pPhone);
		clean_phone_length := length(trim(phone_number));
		clean_phone := if(find_phone_number,
							map(clean_phone_length = 7 => '' + phone_number,
							clean_phone_length < 7 or clean_phone_length > 10 => '',
							phone_number)
							,'');
		clean_phone_area := if(length(clean_phone) = 10 and (clean_phone[1] in ['0','1'] or clean_phone[2] = '9'), '', clean_phone);
	 	clean_phone_second_group := if((length(clean_phone_area) = 10 and clean_phone_area[4] in ['0','1']) or (length(clean_phone_area) = 7 and clean_phone_area[1] in ['0','1']), '', clean_phone_area);
		return clean_phone_second_group;
	end;

	//ZIP
	// 1.The input ZIP will be cleaned first to remove all non-digit characters.
	// 2.If the number of digits is 3 or 4, the input zip code will be left padded with two 0s 
	// or one 0 respectively.
	// 3.If the number of digits is 5 and the input zip code is 00000, the Validator returns an 
	// empty string.
	// 4.If the number of digits is greater than 9, it returns an empty string.
	// 5.If the number of digits is 1 or 2, it returns an empty string.
	// 6.If the number of digits is between 5 and 9, it returns the first 5 digits.
	//Code for US Zip cleaner
	EXPORT ZIPCleaner(STRING ZIP) := FUNCTION
	string cleanZIP := STD.STR.filter(ZIP,'0123456789');
	ZIPlength	:= length(cleanZIP);
	OutZIP := map(ZIPlength =3 => '00'+ cleanZIP,
					ZIPlength =4 => '0'+ cleanZIP,
					ZIPlength =5 AND cleanZIP<>'00000'  => cleanZIP,
					ZIPlength in [6,7,8,9] => cleanZIP[1..5],
					'');
	return OutZip;
	END;

	//STATE Cleaner
	EXPORT StateCleaner(string InState) := FUNCTION
		clnVal := trim(STD.Str.ToUpperCase(InState),left,right);
		CleanState := STD.STR.filter(clnVal, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		set_valid_state := ['AK','AL','AR','AZ','CA','CO','CT','DE','FL',
		'GA','HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MI',
		'MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH',
		'OK','OR','PA','RI','SC','SD','TN','TX','UT','VA','VT','WA','WI',
		'WV','WY','DC','PR','AA','AE','AP','AS','FM','GS','GU','MH','MP','PW','VI','RN',
		'RR','EE'];
		OutState := IF( length(CleanState) = 2 AND CleanState IN set_valid_state, CleanState, '');
		return OutState;
	END;

	//GENDER Cleaner and Validator
	EXPORT GenderCleaner(string inGender) := FUNCTION
		clnVal := trim(STD.Str.ToUpperCase(inGender),left,right);
		CleanGender := STD.STR.filter(clnVal , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		OutGender := map(CleanGender ='F' => 'F',
							CleanGender ='M' => 'M',
							CleanGender ='FEMALE' => 'F',
							CleanGender ='MALE' => 'M',
							'');
		return OutGender;
	END;

	EXPORT Trimmer(string inString) := FUNCTION
		clnVal := trim(inString,left,right);
		outString := IF(clnVal <>'', clnVal, '');
		return outString;
	END;

	EXPORT RequestOptionsCleaner(string input) := FUNCTION
		input_upper := STD.Str.ToUpperCase(input);
		clnVal := STD.STR.filter(input_upper , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		Cleaninput := trim(clnVal,left,right);
		BOOLEAN OutOption := map(Cleaninput ='F' => FALSE,
							Cleaninput ='T' => TRUE,
							Cleaninput ='FALSE' => FALSE,
							Cleaninput ='TRUE' => TRUE,
							FALSE);
		return OutOption;
	END;
	
End;