IMPORT ut, Codes;

EXPORT Functions := MODULE
  //****************************************************************************
  //fn_check_dl_number: 	returns true or false based upon the incoming code.
  // Michigan drivers license numbers consist of 2 letters followed by 6 numbers OR It can be all(9) numbers
  //****************************************************************************
  EXPORT fn_check_dl_number(STRING dlnum) := FUNCTION
    dlnum_clean 	 := ut.CleanSpacesAndUpper(dlnum);    
		isValidPattern := IF(regexfind('[A-Z]{2}[0-9]{6}|[0-9]', dlnum_clean), TRUE, FALSE);
    RETURN IF(isValidPattern, 1, 0);
  END;
	
	//****************************************************************************
	//fn_verify_state: Returns true or false based upon whether or not there is
	// a valid state abbreviation.(Michigan-data has foreign state data)
	//****************************************************************************
 	EXPORT fn_verify_state(STRING code) := function
   	  list:=['AA','AB','AE','AG','AP','BC','CH','DI','DS','DU','GR','IR','JA','MB','NA','NB',
   					 'NL','NT','NS','NU','OA','ON','PE','PU','PZ','QC','QU','RO','SI','SK','SL','SO',
   					 'TA','TL','UM','VE','YT','YU','ZA']; 
   		RETURN IF(LENGTH(Codes.St2Name(code)) > 0 or trim(code,all)in list, 1, 0);		
  END;
		
END; 