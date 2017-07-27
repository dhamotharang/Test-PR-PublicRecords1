/* Contains Common Functions Used in SAOT */

IMPORT Address, UT;

EXPORT Common := MODULE
	// Takes in the Year/Month/Day from ESP results and formats it as YYYYMMDD
	EXPORT ParseDate(STRING In_Year, STRING In_Month, STRING In_Day) := FUNCTION
		Month := INTFORMAT((INTEGER)TRIM(In_Month), 2, 1);
		Day := INTFORMAT((INTEGER)TRIM(In_Day), 2, 1);
		Year := TRIM(In_Year);
		Combined := IF((INTEGER)Year = 0 OR (INTEGER)Month = 0 OR (INTEGER)Day = 0, '', Year + Month + Day); // Blank it out if we can't calculate a full YYYYMMDD
		
		RETURN(Combined);
	END;
	
	EXPORT ParseSSN(STRING In_SSN) := IF((INTEGER)In_SSN <> 0, INTFORMAT((INTEGER)In_SSN, 9, 1), '');
	
	EXPORT ParseZIP(STRING In_Zip5) := IF((INTEGER)In_Zip5 <> 0, INTFORMAT((INTEGER)(In_Zip5[1..5]), 5, 1), '');
	
	EXPORT ParseAddress(STRING In_StreetAddress1, STRING In_StreetAddress2 = '', STRING In_Num = '', STRING In_PreDir = '', STRING In_Name = '', STRING In_Suffix = '', STRING In_PostDir = '', STRING UnitDesig = '', STRING UnitNum = '') := FUNCTION
		ParsedAddress := Address.Addr1FromComponents(TRIM(In_Num), TRIM(In_PreDir), TRIM(In_Name), TRIM(In_Suffix), TRIM(In_PostDir), TRIM(UnitDesig), TRIM(UnitNum));
		UnparsedAddress := TRIM(In_StreetAddress1 + ' ' + In_StreetAddress2);
		
		RETURN (IF(UnparsedAddress <> '', UnparsedAddress, ParsedAddress));
	END;
	
	EXPORT ParsePhone(STRING In_Phone10) := IF((INTEGER)In_Phone10 <> 0, INTFORMAT((INTEGER)In_Phone10, 10, 1), '');
END;