IMPORT Scrubs_FBNV2, Scrubs, ut, Codes;
	
EXPORT Functions := MODULE

  //****************************************************************************
  //fn_populated_strings: 	returns true if one of the strings is populated
  //****************************************************************************
  EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '') := FUNCTION
    RETURN IF(LENGTH(TRIM(str1 + str2 + str3 + str4 + str5, ALL)) > 0,1,0);
  END;

	//********************************************************************************
	//fn_invalid_name:  returns true if length not 1 or greater, or contains 'UNAVAILABLE'
	//********************************************************************************
	EXPORT fn_invalid_name(STRING s) := function    
	  RETURN IF(LENGTH(s) > 1 AND NOT REGEXFIND('UNAVAILABLE',s),1,0);
  END;

	//********************************************************************************
	//fn_invalid_legal_name:  returns true if contains 'UNAVAILABLE'
	//********************************************************************************
	EXPORT fn_invalid_legal_name(STRING s) := function    
	  RETURN IF(NOT REGEXFIND('UNAVAILABLE',s),1,0);
  END;
	
	//****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************  
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;

  //****************************************************************************
  //fn_range_numeric: 	returns true if number in range
  //****************************************************************************
  EXPORT fn_range_numeric(STRING nmbr, UNSIGNED6 lbound, UNSIGNED6 ubound) := FUNCTION
    RETURN IF((UNSIGNED6)nmbr >= lbound AND (UNSIGNED6)nmbr <= ubound,1,0);
  END;
		
  //****************************************************************************
  //fn_alphanum: 	returns true if only populated with numbers and letters
  //****************************************************************************
  EXPORT fn_alphanum(STRING alphanum, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(alphanum, ALL)) > 0, LENGTH(TRIM(alphanum, ALL)) = size) AND
              Stringlib.StringFilterOut(alphanum, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',1,0);
  END;	

  //****************************************************************************
  //fn_addr_rec_type: 	returns true or false based upon the incoming
  //										code.
  // Record Types (ACE Quick Reference for Views and Job-File Products):
  // F:  Firm.
  // G:  General delivery.
  // H:  High-rise apartment or office building.
  // M:  Military.
  // P:  Post office box.
  // R:  Rural route or highway contract.
  // S:  Street (usually, one side of one city block).
  // FD:  Firm default. ACE did not assign a firm-level ZIP+4, but could do so if given more or better firm information.
  // GD:  General delivery default. Assigned only when General Delivery is the only primary name listed for the ZIP Code.
  // HD:  High-rise default. ACE assigned the ZIP+4 code for the whole building. Assignment at the unit, floor, or wing level is possible. Often caused by a suite or apartment number out of range.
  // RD:  Rural route or highway contract default. ACE assigned the ZIP+4 for the whole route; could do better with box number.
  // SD:  Street default. Usually means that there is no ZIP+4 for the building, so ACE had to assign the ZIP+4 for the block.
  // UD:  Unique default. Either the owner of the unique ZIP has not provided ZIP+4 assignments, or the address could not be matched.
  //****************************************************************************
  EXPORT fn_addr_rec_type(STRING code) := FUNCTION
	   uc_code := ut.CleanSpacesAndUpper(code);
		  isValidCode := CASE(uc_code,
                        'F'  => TRUE,
                        'G'  => TRUE,
                        'H'  => TRUE,
                        'M'  => TRUE,
                        'P'  => TRUE,
                        'R'  => TRUE,
                        'S'  => TRUE,
                        'FD' => TRUE,
                        'GD' => TRUE,
                        'HD' => TRUE,
                        'RD' => TRUE,
                        'SD' => TRUE,
                        'UD' => TRUE,
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;	
	
  //****************************************************************************
	 //fn_verify_zip4:  returns true or false based upon whether or not there is
  //                 a empty or 4-digit value.
	 //****************************************************************************
	 EXPORT fn_verify_zip4(STRING zip4) := function    
		  RETURN IF(LENGTH(zip4) = 0 OR fn_numeric(zip4,4) > 0, 1, 0);
  END;		
	
  //*******************************************************************************
  //fn_future_date: 	returns true if valid future date, else false
  //*******************************************************************************
  EXPORT fn_future_date(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8 and clean_date > ut.GetDate, TRUE, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
  //*******************************************************************************
  //fn_current_future_date: 	returns true if valid current and/or future date, else false
  //*******************************************************************************
  EXPORT fn_current_future_date(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8 and clean_date >= ut.GetDate, TRUE, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
		
  //*******************************************************************************
  //fn_current_past_date: 	returns true if valid current and/or past date, else false
  //*******************************************************************************
  EXPORT fn_current_past_date(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8 and clean_date <= ut.GetDate, TRUE, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
		
  //*******************************************************************************
  //fn_valid_year: 	returns true if valid year, else false
  //*******************************************************************************
  EXPORT fn_valid_year_established(STRING sYear) := FUNCTION
    clean_year  := TRIM(sYear, ALL);
		isValidYear  			:= IF(clean_year <= ut.GetDate [1..4], TRUE, FALSE); 
    RETURN IF(isValidYear, 1, 0);
  END;
	
  //****************************************************************************
  //fn_numeric_or_blank: 	returns true if only populated with numbers or blanks
  //****************************************************************************  
	EXPORT fn_numeric_or_blank(STRING nmbr) := FUNCTION
    RETURN if(LENGTH(TRIM(nmbr, ALL)) < 10 and Stringlib.StringFilterOut(nmbr, '0123456789') = '' ,1 ,0);
  END;
	
   //****************************************************************************
	 //fn_verify_state:  returns true or false based upon whether or not there is
   //                  a valid state abbreviation.
	 //****************************************************************************
	 EXPORT fn_verify_state(STRING code) := function    
		  RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
  END;  
	
  //****************************************************************************
  //fn_verify_optional_phone:  returns true or false based upon whether it contains an
  //                           empty or valid phone #
  //****************************************************************************
	EXPORT fn_verify_optional_phone(STRING phone) := function    
    clean_phone := TRIM(phone, ALL);
    RETURN IF(clean_phone = '' OR ut.CleanPhone(clean_phone) != '', 1, 0);
  END;

	//********************************************************************************
	//fn_url:  returns true if all the characters are valid, else returns false
	//********************************************************************************
	EXPORT fn_url(STRING s) := function    
	  RETURN IF(Stringlib.StringFilterOut(s, ' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\'-!#$%&*,./:;?@_{}~+=()') = '', 1, 0);
  END;
	
	//****************************************************************************
	//fn_sic:  returns true or false based upon whether or not there is
  //                 an empty, 4-digit value.
	//****************************************************************************
	EXPORT fn_sic(STRING s) := function    
	  RETURN IF((s = '' or LENGTH(TRIM(s, ALL)) in [4]) AND Stringlib.StringFilterOut(s, ' 0123456789') = '', 1, 0);
  END;
		
	//****************************************************************************
	//fn_naics:  returns true or false based upon whether or not there is
  //                 an empty, 4-digit value.
	//****************************************************************************
	EXPORT fn_naics(STRING s) := function    
	  RETURN IF((s = '' or LENGTH(TRIM(s, ALL)) in [6]) AND Stringlib.StringFilterOut(s, ' 0123456789') = '', 1, 0);
  END;
	
END;
