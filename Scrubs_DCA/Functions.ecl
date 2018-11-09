IMPORT Scrubs_DCA, Scrubs, ut;
	
EXPORT Functions := MODULE

	//********************************************************************************
	//fn_url:  returns true if all the characters are valid, else returns false
	//********************************************************************************
	EXPORT fn_url(STRING s) := function    
	  RETURN IF(Stringlib.StringFilterOut(s, ' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\'-!#$%&*,./:;?@_{}~+=()') = '', 1, 0);
  END;
	
	//********************************************************************************
	//fn_src_rid:  returns true if is a 1 to 8 digit numeric value, else returns false
	//********************************************************************************
	EXPORT fn_src_rid(STRING s) := function    
	  RETURN IF(LENGTH(s) in [1,2,3,4,5,6,7,8] AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
  END;
	
	//********************************************************************************
	//fn_rid:  returns true if is a 1 to 9 digit numeric value, else returns false
	//********************************************************************************
	EXPORT fn_rid(STRING s) := function    
	  RETURN IF(LENGTH(s) in [1,2,3,4,5,6,7,8,9] AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
  END;
	
	//********************************************************************************
	//fn_bdid:  returns true if is a 1 to 9 digit numeric value, else returns false
	//********************************************************************************
	EXPORT fn_bdid(STRING s) := function    
	  RETURN IF(LENGTH(s) in [1,2,3,4,5,6,7,8,9,10] AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
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
	
	//****************************************************************************
	//fn_numeric_or_blank:  returns true if numeric or blank
	//****************************************************************************
	EXPORT fn_numeric_or_blank(STRING s) := function    
	  RETURN IF(Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
  END;
	
	//****************************************************************************
	//fn_sic:  returns true or false based upon whether or not there is
  //                 an empty, 3-digit, or 4-digit value.
	//****************************************************************************
	EXPORT fn_sic(STRING s) := function    
	  RETURN IF((s = '' or LENGTH(TRIM(s, ALL)) in [3,4]) AND Stringlib.StringFilterOut(s, ' 0123456789') = '', 1, 0);
  END;
	
	//****************************************************************************
	//fn_naics:  returns true or false based upon whether or not there is
  //                 an empty, 6-digit, or 7-digit value.
	//****************************************************************************
	EXPORT fn_naics(STRING s) := function    
	  RETURN IF((s = '' or LENGTH(s) in [6,7]) AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
  END;
	
	//******************************************************************************
	//fn_verify_phone:  returns true or false based upon whether its a valid phone #
	//******************************************************************************
	EXPORT fn_verify_phone(STRING phone) := function    
    clean_phone := TRIM(phone, ALL);
    RETURN IF(ut.CleanPhone(clean_phone) != '', 1, 0);
  END;

END;

