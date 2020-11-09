IMPORT ut, Scrubs, STD;

EXPORT Functions := MODULE
  //****************************************************************************
	//fn_valid_name:  returns true or false based upon whether or not there is
  //                a valid owner name or business name.
	//****************************************************************************
	EXPORT fn_valid_name(string str) := function
    isValidName	:= IF(trim(str,WHITESPACE) <> '', 1, 0);
		RETURN isValidName;
  END;

	//CHECK FOR VALID DATE DESPITE FORMAT
  EXPORT fn_Valid_Date(STRING st = '') := FUNCTION
     dateStr := st[1..10];
     return if(
            Scrubs.fn_valid_pastDate(dateStr) > 0
            OR Scrubs.fn_valid_pastDate((string) STD.Date.FromStringToDate(dateStr, '%Y-%m-%d')) > 0
            ,1
            ,0
            );

  END;
END;
