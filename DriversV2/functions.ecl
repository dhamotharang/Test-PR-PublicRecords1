Import STD, Corp2_Mapping;
EXPORT Functions := MODULE
	
	//cleanspaces & upper casing! 
	EXPORT TrimUpper(STRING s):= FUNCTION
	 RETURN std.str.touppercase(std.str.cleanspaces(s));
  END;
	
	//Cleaning '*' ,'{' from StreetAddrs & city  Ex:"268 LORA *" or "LAKEWOOD{" -- will return "268 LORA" ,"LAKEWOOD"
	EXPORT fn_RemoveSpecialChars(string s, string replacement='') := function				
		stripInvalids := regexreplace('\\x2A|\\x7B', TrimUpper(s),replacement);		
		RETURN stripInvalids;
	END;
	
	//'CCYYMMDD' dates will be returned
	EXPORT ValidateDate(STRING d)		 := function
		RETURN Corp2_Mapping.fValidateDate(trim(d,left,right),'MMDDCCYY').GeneralDate;
	END;	
		
	//Removing Special Chars from raw verdor data												
	EXPORT fn_RemoveRawDataSpecialChars(string s, string replacement='') := function				
		stripInvalids := regexreplace('([ï»¿]+)',s,replacement);		
		RETURN stripInvalids;
	END;
	
	//Process each two-character restriction code (2digit codes are separated with comma) 
	EXPORT f2CharCodeAndComma(string pRestrictionCode) := function	
	  RETURN if(trim(pRestrictionCode,right)<>'', ',' + trim(pRestrictionCode,right) ,'' );
  END;
	
END; 