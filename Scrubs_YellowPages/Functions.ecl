IMPORT Scrubs_YellowPages, Scrubs, std;
	
EXPORT Functions := MODULE



  //****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN Scrubs.Functions.fn_numeric(nmbr, size);
  END;
  
  //****************************************************************************
  //fn_populated_strings: 	returns true if one of the strings is populated
  //****************************************************************************
  EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '') := FUNCTION
    RETURN Scrubs.Functions.fn_populated_strings(str1, str2, str3, str4, str5);
  END;

  //*******************************************************************************
  //fn_valid_date: 	General purpose date function for past/current/future dates
  //*******************************************************************************
  EXPORT fn_valid_date(STRING st, STRING dt_type = '') := FUNCTION
    RETURN Scrubs.Functions.fn_valid_date(st, dt_type);
  END;

  //****************************************************************************
  //fn_verify_state: returns true or false based upon whether or not there is
  //                 a valid state abbreviation.  If the can_be_empty parameter
  //                 is set to 'T' (TRUE) then the code can be empty.
  //****************************************************************************
  EXPORT fn_verify_state(STRING code, BOOLEAN can_be_empty = FALSE) := FUNCTION    
    RETURN Scrubs.Functions.fn_verify_state(code, can_be_empty);
  END;

  //****************************************************************************
  //fn_verify_zip59:  returns true or false based upon whether or not there is
  //                  a 5-digit or 9-digit value.
  //****************************************************************************
  EXPORT fn_verify_zip59(STRING zip59) := FUNCTION    
    RETURN Scrubs.Functions.fn_verify_zip59(zip59);
  END;

  //****************************************************************************
  //fn_validate_SICCode: returns true if SIC code is found in lookup table or is zero/null
  //****************************************************************************
  EXPORT fn_valid_SicCode(string code) := FUNCTION
    RETURN Scrubs.Functions.fn_valid_SicCode(code);
  END;  
 
  //****************************************************************************
  //fn_validate_NAICSCode: 	returns true if NAICS code is found in lookup table or is zero/null
  //****************************************************************************
  EXPORT fn_validate_NAICSCode(string code) := function
    RETURN Scrubs.Functions.fn_validate_NAICSCode(code);
  END;



END;