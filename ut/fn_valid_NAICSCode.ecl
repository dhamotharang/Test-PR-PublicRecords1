IMPORT NAICSCodes;

EXPORT integer fn_valid_NAICSCode(string code) := function
 
  RETURN ut.fn_NAICS_functions.fn_validate_NAICSCode(code);						
						
END;