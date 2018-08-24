IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE

	//****************************************************************************
	//fn_verify_state: returns true or false based upon whether or not there is
	// a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function

		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);

	END;

	//****************************************************************************
	//fn_numeric: returns true if only populated with numbers !
	//****************************************************************************
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION

		RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
		Stringlib.StringFilterOut(nmbr, '0123456789') = '' and (integer)nmbr<>0, 1, 0);

	END;
	
	//****************************************************************************
	//fn_chk_blanks: returns true if the value is populated
	//****************************************************************************
	EXPORT fn_chk_blanks(STRING Busname) := FUNCTION
	
		RETURN IF(LENGTH(TRIM(Busname, ALL)) > 0, 1, 0);
	
	END;

	//****************************************************************************
	//fn_verify_zip5: returns true or false based upon whether or not there is
	// a 5-digit numeric value.
	//****************************************************************************
	EXPORT fn_verify_zip5(STRING zip5) := function 

		RETURN IF(LENGTH(trim(zip5, all)) = 5 AND Stringlib.StringFilterOut(trim(zip5, all), '0123456789') = '', 1, 0);

	END;

 //****************************************************************************
	//fn_chk_people_names: returns true only for names of alpha and with special characters 
	//returns false** for blanks (OR) only special characters in names with no valid data
	//returns false for names those have only* middle name!
	//****************************************************************************
	EXPORT fn_chk_people_names(STRING str1, STRING str2= '', STRING str3= '' ) := FUNCTION

		PatternValidChar		:= '[A-Z]|\\x2D|\\x2E|\\x27|\\x26|\\x20';//alpha or with [-.'& space] these characters allowed
		name_str						:= ut.CleanSpacesAndUpper(str1) + ut.CleanSpacesAndUpper(str2) + ut.CleanSpacesAndUpper(str3);	
		RETURN IF(regexreplace(PatternValidChar, name_str, '')!='' or regexreplace('\\x2D|\\x2E|\\x27|\\x26', name_str, '')='', 0, 1);

	END;

	//****************************************************************************
	//fn_geo_coord: returns true or false based upon the lat/long value.
	//****************************************************************************
	EXPORT fn_geo_coord(STRING geo) := FUNCTION

		geo_clean := TRIM(geo, ALL);
		//Verifying the pattern for coordinates is an optional negative sign (-), 
		//followed by at least 1 digit, followed by decimal (.), and ending
		//with at least 1 digit
		RETURN IF(regexfind('^-?\\d+.\\d+$', geo_clean), 1, 0);

	END;
	
	//*******************************************************************************
	//fn_valid_past_date: 	returns true or false based upon the incoming date.
	//Returns true if valid past date
	//*******************************************************************************
	EXPORT fn_valid_past_date(STRING sDate) := FUNCTION
	
		isValidDate := IF(LENGTH(sDate) = 8, Scrubs.fn_valid_pastDate(sDate) > 0, FALSE);
		RETURN IF(isValidDate, 1, 0);
		
	END;

	//****************************************************************************
	//fn_valid_general_Date: returns true or false based upon whether or not there is
	//               a valid date.
	//****************************************************************************
	EXPORT fn_valid_general_Date(STRING sDate) := FUNCTION

		isValidDate := IF(LENGTH(sDate) = 8, Scrubs.fn_valid_GeneralDate(sDate) > 0, FALSE);
		RETURN IF(isValidDate, 1, 0);
	
	END;

END; 