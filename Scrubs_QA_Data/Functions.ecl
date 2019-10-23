IMPORT Scrubs_QA_Data, Scrubs, ut, Codes;
	
EXPORT Functions := MODULE

	//********************************************************************************
	//fn_src_rid:  returns true if is a 10 to 20 digit numeric value, else returns false
	//********************************************************************************
	EXPORT fn_src_rid(STRING s) := function    
	  RETURN IF(LENGTH(s) in [10,11,12,13,14,15,16,17,18,19,20] AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
  END;
	
	//****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************  
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;
	
  //*******************************************************************************
  //fn_past_yyyymmdd: 	returns true if valid past date, else false
  //*******************************************************************************
  EXPORT fn_past_yyyymmdd(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_pastDate(clean_date) > 0, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//*******************************************************************************
  //fn_date_time: 	returns true if valid past date, else false
  //*******************************************************************************
  EXPORT fn_date_time(STRING sDate) := FUNCTION
    ccyy := sDate[1..4];
		mm   := sDate[6..7];
		dd   := sDate[9..10];
		clean_date := ccyy + mm + dd;
		isValidDate := IF(LENGTH(sDate) >= 10, Scrubs.fn_valid_pastDate(clean_date) > 0, FALSE);
    RETURN IF(isValidDate, 1, 0);
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

END;

