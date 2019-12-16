	IMPORT Scrubs_PAW, Scrubs, ut, Codes, PAW, _validate;
	
EXPORT Functions := MODULE

	//********************************************************************************
	//fn_invalid_name:  returns true if length not 1 or greater, or contains 'UNAVAILABLE'
	//********************************************************************************
	EXPORT fn_invalid_name(STRING s) := function    
	  RETURN IF(LENGTH(s) > 1 AND NOT REGEXFIND('UNAVAILABLE',s),1,0);
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
              Stringlib.StringFilterOut(alphanum, ' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',1,0);
  END;	
		
  //****************************************************************************
  //fn_alpha: 	returns true if only populated with letters
  //****************************************************************************
  EXPORT fn_alpha(STRING alpha, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(alpha, ALL)) > 0, LENGTH(TRIM(alpha, ALL)) >= size) AND
              Stringlib.StringFilterOut(alpha, ' ABCDEFGHIJKLMNOPQRSTUVWXYZ\'-') = '',1,0);
  END;	
	
	//****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************  
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;
			
  //****************************************************************************
  //fn_numeric_or_blank: 	returns true if only populated with numbers or blanks
  //****************************************************************************  
	EXPORT fn_numeric_or_blank(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN if(LENGTH(TRIM(nmbr, ALL)) = 0 or Stringlib.StringFilterOut(nmbr, '0123456789') = '' ,1 ,0);
  END;	
	
  //****************************************************************************
	 //fn_verify_zip4:  returns true or false based upon whether or not there is
  //                 a empty or 4-digit value.
	 //****************************************************************************
	 EXPORT fn_verify_zip4(STRING zip4) := function    
		  RETURN IF(LENGTH(zip4) = 0 OR fn_numeric(zip4,4) > 0, 1, 0);
  END;		
		
  //*******************************************************************************
  //fn_valid_ReformatedDate: 	returns true if valid date, else false
  //*******************************************************************************	
  EXPORT fn_valid_ReformatedDate(string sDate) :=function
		clean_date := sDate;
		isValidDate := IF(clean_date = '0' or _validate.date.fIsValid(clean_date), TRUE, FALSE);
		RETURN IF(isValidDate, 1, 0);
  end;	
	
  //****************************************************************************
  //fn_verify_zip5: 	returns true if only populated with numbers or blanks
  //****************************************************************************  
	EXPORT fn_verify_zip5(STRING nmbr) := FUNCTION
    RETURN if((LENGTH(TRIM(nmbr, ALL)) = 0)
		           or (LENGTH(TRIM(nmbr, ALL)) = 5 and Stringlib.StringFilterOut(nmbr, '0123456789') = '') 
		           // or (countryName != 'USA') 
							 ,1 ,0);
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
    RETURN IF(clean_phone = '0' OR clean_phone = '' OR ut.CleanPhone(clean_phone) != '', 1, 0);
  END;

END;
