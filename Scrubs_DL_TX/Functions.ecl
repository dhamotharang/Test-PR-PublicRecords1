IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE


  //****************************************************************************
	//fn_valid_name:  returns true or false based upon whether or not there is
  //                a valid name.
	//****************************************************************************
	EXPORT fn_valid_name(string lname, string fname, string mname) := function
    isValidName	:= IF( ut.CleanSpacesAndUpper(fname) <> '' OR ut.CleanSpacesAndUpper(mname) <> '' OR ut.CleanSpacesAndUpper(lname) <> '', 1, 0);
		RETURN isValidName;
  END;
 
 
	//****************************************************************************
	//fn_mddyyyy_to_yyyymmdd:  converts mddyyyy formatted date to yyyymmdd date.
	//****************************************************************************
	SHARED fn_mddyyyy_to_yyyymmdd(string pdate_in) := function
    pdate   := TRIM(pdate_in,ALL);
    NewDate	:= CASE(LENGTH(pdate),
                    8 => pdate[5..8] + pdate[1..2]    + pdate[3..4],
                    7 => pdate[4..7] + '0' + pdate[1] + pdate[2..3],
                    pdate);                   
		RETURN NewDate;
  END;


	//****************************************************************************
	//fn_valid_past_date:  returns true or false based upon whether or not there
  //                     is a valid past date.
	//****************************************************************************
	EXPORT fn_valid_past_date(string ppdate) := function                
		RETURN Scrubs.fn_valid_pastDate(fn_mddyyyy_to_yyyymmdd(ppdate));
  END;
  
  
  //****************************************************************************
	//fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function    
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
  END;


	//****************************************************************************
	//fn_valid_date:  returns true or false based upon whether or not there
  //                is a valid date.
	//****************************************************************************
	EXPORT fn_valid_date(string ppdate) := function                
		RETURN Scrubs.fn_valid_GeneralDate(fn_mddyyyy_to_yyyymmdd(ppdate));
  END;
  
  
  //****************************************************************************
  //fn_addr_rec_type: 	returns true or false based upon the incoming
  //										code.
  // Record Types (ACE Quick Reference for Views and Job-File Products):
  // F:  Firm.
  // G:  General delivery.
  // H:  High-rise apartment or office building.
  // M:  Military.
  // P:  Post office box.
  // R:  Rural route or highway contract.
  // S:  Street (usually, one side of one city block).
  // FD:  Firm default. ACE did not assign a firm-level ZIP+4, but could do so if given more or better firm information.
  // GD:  General delivery default. Assigned only when General Delivery is the only primary name listed for the ZIP Code.
  // HD:  High-rise default. ACE assigned the ZIP+4 code for the whole building. Assignment at the unit, floor, or wing level is possible. Often caused by a suite or apartment number out of range.
  // RD:  Rural route or highway contract default. ACE assigned the ZIP+4 for the whole route; could do better with box number.
  // SD:  Street default. Usually means that there is no ZIP+4 for the building, so ACE had to assign the ZIP+4 for the block.
  // UD:  Unique default. Either the owner of the unique ZIP has not provided ZIP+4 assignments, or the address could not be matched.
  //****************************************************************************
  EXPORT fn_addr_rec_type(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'F'  => TRUE,
                        'G'  => TRUE,
                        'H'  => TRUE,
                        'M'  => TRUE,
                        'P'  => TRUE,
                        'R'  => TRUE,
                        'S'  => TRUE,
                        'FD' => TRUE,
                        'GD' => TRUE,
                        'HD' => TRUE,
                        'RD' => TRUE,
                        'SD' => TRUE,
                        'UD' => TRUE,
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;

  
END; //End Functions Module