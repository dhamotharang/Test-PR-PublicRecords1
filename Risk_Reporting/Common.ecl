/* Contains Common Functions Used in SAOT */

IMPORT Address, UT;

EXPORT Common := MODULE
	// Takes in the Year/Month/Day from ESP results and formats it as YYYYMMDD
	EXPORT ParseDate(STRING In_Year, STRING In_Month, STRING In_Day) := FUNCTION
		Today := ut.GetDate;
		Month := INTFORMAT((INTEGER)TRIM(In_Month), 2, 1);
		Day := INTFORMAT((INTEGER)TRIM(In_Day), 2, 1);
		YearTemp := INTFORMAT((INTEGER)TRIM(In_Year), 4, 1);
		Year := MAP((INTEGER)In_Year <= 0 => '',
								(INTEGER)YearTemp[1..2] > 0 => YearTemp,
								(INTEGER)YearTemp[1..2] = 0 AND (INTEGER)YearTemp[3..4] > (INTEGER)Today[3..4] => ((STRING)((INTEGER)Today[1..2] - 1)) + YearTemp[3..4], // Last 2 digits indicates we are probably in 19**
								(INTEGER)YearTemp[1..2] = 0 AND (INTEGER)YearTemp[3..4] <= (INTEGER)Today[3..4] => Today[1..2] + YearTemp[3..4], // Last 2 digits indicates we are probably in 20**
								'');
		Combined := IF((INTEGER)Year = 0 OR (INTEGER)Month = 0 OR (INTEGER)Day = 0, '', Year + Month + Day); // Blank it out if we can't calculate a full YYYYMMDD
		
		RETURN(Combined);
	END;
	
	EXPORT ParseSSN(STRING In_SSN, Integer1 Num_Length = 9) := IF((INTEGER)In_SSN <> 0, In_SSN, '');
	
	EXPORT ParseZIP(STRING In_Zip5) := IF((INTEGER)In_Zip5 <> 0, INTFORMAT((INTEGER)(In_Zip5[1..5]), 5, 1), '');
	
	EXPORT ParseAddress(STRING In_StreetAddress1, STRING In_StreetAddress2 = '', STRING In_Num = '', STRING In_PreDir = '', STRING In_Name = '', STRING In_Suffix = '', STRING In_PostDir = '', STRING UnitDesig = '', STRING UnitNum = '') := FUNCTION
		ParsedAddress := Address.Addr1FromComponents(TRIM(In_Num), TRIM(In_PreDir), TRIM(In_Name), TRIM(In_Suffix), TRIM(In_PostDir), TRIM(UnitDesig), TRIM(UnitNum));
		UnparsedAddress := TRIM(In_StreetAddress1 + ' ' + In_StreetAddress2);
		
		RETURN (IF(UnparsedAddress <> '', UnparsedAddress, ParsedAddress));
	END;
	
	EXPORT ParsePhone(STRING In_Phone10) := IF((INTEGER)In_Phone10 <> 0, INTFORMAT((INTEGER)In_Phone10, 10, 1), '');
END;