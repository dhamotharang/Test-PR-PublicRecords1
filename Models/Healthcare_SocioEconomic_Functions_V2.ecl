Import STD,UT;
EXPORT Healthcare_SocioEconomic_Functions_V2 := Module
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
								clnVal = 'DISCHARGE GRANTED' => 4,
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

End;