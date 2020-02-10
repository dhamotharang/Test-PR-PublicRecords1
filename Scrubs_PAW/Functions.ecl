	IMPORT Scrubs_PAW, Scrubs, ut, Codes, PAW, _validate;
	
EXPORT Functions := MODULE

	//********************************************************************************
	//fn_invalid_name:  returns true if length not 1 or greater, or contains 'UNAVAILABLE'
	//********************************************************************************
	EXPORT fn_invalid_name(STRING s) := function    
	  RETURN IF(LENGTH(s) > 1 AND NOT REGEXFIND('UNAVAILABLE',s),1,0);
  END;
			
	//****************************************************************************
  //fn_verify_optional_phone:  returns true or false based upon whether it contains an
  //                           empty or valid phone #
  //****************************************************************************
	EXPORT fn_verify_optional_phone(STRING phone) := function    
    clean_phone := TRIM(phone, ALL);
    RETURN IF(clean_phone = '0' OR clean_phone = '' OR ut.CleanPhone(clean_phone) != '', 1, 0);
  END;

  //****************************************************************************
	 //fn_verify_zip4:  returns true or false based upon whether or not there is
  //                 a empty or 4-digit value.
	 //****************************************************************************
	 EXPORT fn_verify_zip4(STRING zip4) := function    
		  RETURN IF(LENGTH(zip4) = 0 OR Scrubs.Functions.fn_numeric(zip4,4) > 0, 1, 0);
  END;		

END;
