IMPORT ut, Scrubs;

EXPORT Functions := MODULE

  //****************************************************************************
	//fn_valid_name:  returns true or false based upon whether or not there is
  //                a valid owner name or business name.
	//****************************************************************************
	EXPORT fn_valid_name(string str) := function
    isValidName	:= IF( ut.CleanSpacesAndUpper(str) <> '', 1, 0);
		RETURN isValidName;
  END;
	
END;