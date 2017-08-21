IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE


  //*******************************************************************************
  //fn_check_dl_number: 	returns true or false based upon the incoming string.
  //													
  //dl number and last name are interrelated.  The first letter of the driver's
  //last name corresponds with the letter in the dl number/pid.  However, it
  //was decided not to check for that since last names can change.
  //****************************************************************************
  EXPORT fn_check_dl_number(STRING dlnum) := FUNCTION
    dlnum_clean := ut.CleanSpacesAndUpper(dlnum);
    
		isValidLetter := IF(regexfind('[A-Z]', dlnum_clean[1]), TRUE, FALSE);
		isValidNumber := IF(Stringlib.StringFilterOut(dlnum_clean[2..], '0123456789') = '', TRUE, FALSE);
    
    RETURN IF(dlnum_clean = '' OR (isValidLetter AND isValidNumber), 1, 0);
  END;


  //****************************************************************************
	//fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function    
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
  END;


	//****************************************************************************
	//fn_mddyyyy_to_yyyymmdd:  converts mddyyyy formatted date to yyyymmdd date.
	//****************************************************************************
	EXPORT fn_mddyyyy_to_yyyymmdd(string pdate_in) := function
    pdate   := TRIM(pdate_in,ALL);
    NewDate	:= pdate[5..8] + pdate[1..2] + pdate[3..4];                   
		RETURN NewDate;
  END;


	//****************************************************************************
	//fn_valid_past_date:  returns true or false based upon whether or not there
  //                     is a valid past date.
	//****************************************************************************
	EXPORT fn_valid_past_date(string ppdate) := function                
		RETURN Scrubs.fn_valid_pastDate(fn_mddyyyy_to_yyyymmdd(ppdate));
  END;


  //*******************************************************************************
  //fn_verify_county: 	returns true or false based upon validity of county 1-84											
  //*******************************************************************************
  EXPORT fn_verify_county(STRING cnty) := FUNCTION
    cnty_num := (INTEGER2)cnty;
    
    RETURN IF(cnty_num > 0 AND cnty_num < 85, 1, 0);
  END;


  //*******************************************************************************
  //fn_verify_indicator: 	returns true or false based upon validity of the indicator
  //                      to be D (dlnum), P (pid), or B (both dlnum and pid)
  //*******************************************************************************
  EXPORT fn_verify_indicator(STRING ind, STRING dlnum, STRING pid) := FUNCTION
	  uc_ind   := ut.CleanSpacesAndUpper(ind);
	  uc_dlnum := ut.CleanSpacesAndUpper(dlnum);
	  uc_pid   := ut.CleanSpacesAndUpper(pid);
		isValidInd  := CASE(uc_ind,
                        'D' => IF(LENGTH(uc_dlnum) > 0, TRUE, FALSE),
                        'P' => IF(LENGTH(uc_pid)   > 0, TRUE, FALSE),
                        'B' => IF(LENGTH(uc_dlnum) > 0 AND LENGTH(uc_pid)   > 0, TRUE, FALSE),
                        FALSE);
    RETURN IF(isValidInd,1,0);
  END;


  //****************************************************************************
	//fn_valid_name:  returns true or false based upon whether or not there is
  //                a valid name.
	//****************************************************************************
	EXPORT fn_valid_name(string lname, string fname, string mname) := function
    isValidName	:= IF( ut.CleanSpacesAndUpper(fname) <> '' OR ut.CleanSpacesAndUpper(mname) <> '' OR ut.CleanSpacesAndUpper(lname) <> '', 1, 0);
		RETURN isValidName;
  END;


END; //End Functions Module