IMPORT Corp2_Mapping;

EXPORT Functions := MODULE

  //****************************************************************************
  //fn_verify_zip59:  returns true or false based upon whether or not there is
  //                  a 5-digit or 9-digit value.
  //****************************************************************************
  EXPORT fn_verify_zip59(STRING zip) := FUNCTION
	  //Noticed unprintable letters in vendor zips & Cleaning them before analyzing zip codes
	  zip59:= Stringlib.StringFilterOut(Corp2_Mapping.fn_RemoveSpecialChars(trim(zip,left,right)), '-');	 
    RETURN IF((LENGTH(zip59) IN [5,9]) AND Stringlib.StringFilterOut(zip59, '0123456789') = '', 1, 0);
  END;
	
END;