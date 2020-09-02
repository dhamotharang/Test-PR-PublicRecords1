IMPORT ut, Scrubs, Codes, std;

EXPORT Functions := MODULE

//****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************  
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;
	
	//*******************************************************************************
	//fn_general_date: returns true or false based upon the incoming date.
	//Returns true if it's a valid date
	//*******************************************************************************
	EXPORT fn_general_date(STRING10 sDate) := FUNCTION

		isValidDate := IF(Scrubs.fn_valid_GeneralDate(sDate)>0 ,true ,false);

		RETURN IF(isValidDate, 1, 0);

	END;
  //*******************************************************************************
  //fn_past_yyyymmdd: 	returns true if valid past date, else false
  //*******************************************************************************
  EXPORT fn_past_yyyymmdd(STRING sDate) := FUNCTION
	  //clean_date := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(sDate);
    isValidDate := IF((STRING)sDate in ['',' '] or (LENGTH(sDate) = 8 and sDate < (STRING8)Std.Date.Today()), TRUE, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//*******************************************************************************
  //fn_trans_date: 	returns true if valid transaction date, else false
  //*******************************************************************************
  EXPORT fn_trans_date(STRING sDate) := FUNCTION
	  //DataBridge only sends a 6-digit date, so the 01 is added for validation purposes
	  in_date := sDate + '01';
		isValidDate := IF(Scrubs.fn_valid_pastDate(in_date)>0 ,true ,false);

		RETURN IF(isValidDate, 1, 0);
  END;
  //****************************************************************************
  //fn_numeric_or_blank: 	returns true if only populated with numbers or blanks
  //****************************************************************************  
	EXPORT fn_numeric_or_blank(STRING nmbr) := FUNCTION
    RETURN if(LENGTH(TRIM(nmbr, ALL)) < 10 and Stringlib.StringFilterOut(nmbr, '0123456789') = '' ,1 ,0);
  END;
	
   //****************************************************************************
	 //fn_verify_state:  returns true or false based upon whether or not the state
	 //                  code is blank or there is a valid state abbreviation.
	 //                  Having a blank state code is valid.
	 //****************************************************************************
	 EXPORT fn_verify_state(STRING code) := function    
		  RETURN IF(TRIM(code,LEFT,RIGHT) = '' OR LENGTH(Codes.St2Name(code)) > 0, 1, 0);
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
  //                 an empty, 2-digit, 4-digit, 6-digit or 8-digit value.
	//****************************************************************************
	EXPORT fn_sic(STRING s) := function    
	  RETURN IF((s = '' or LENGTH(TRIM(s, ALL)) in [2,4,6,8]) AND Stringlib.StringFilterOut(s, ' 0123456789') = '', 1, 0);
  END;

END;