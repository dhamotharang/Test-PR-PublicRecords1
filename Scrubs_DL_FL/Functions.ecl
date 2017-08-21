IMPORT ut, Scrubs;

EXPORT Functions := MODULE

	//****************************************************************************
	//fn_mddyyyy_to_yyyymmdd:  converts mddyyyy formatted date to yyyymmdd date.
	//****************************************************************************
	EXPORT fn_mddyyyy_to_yyyymmdd(string pdate_in) := function
    pdate   := TRIM(pdate_in,ALL);
    NewDate	:= pdate[5..8] + pdate[1..2] + pdate[3..4];                   
		RETURN NewDate;
  END;

	//****************************************************************************
	//fn_valid_date:  returns true or false based upon whether or not there is
  //                a valid date.
	//****************************************************************************
	EXPORT fn_valid_date(string pdate) := function                
		RETURN IF(pdate = '', 1, Scrubs.fn_valid_GeneralDate(fn_mddyyyy_to_yyyymmdd(pdate)));
  END;


	//****************************************************************************
	//fn_valid_past_date:  returns true or false based upon whether or not there
  //                     is a valid date.
	//****************************************************************************
	EXPORT fn_valid_past_date(string ppdate) := function                
		RETURN IF(ppdate = '', 1, Scrubs.fn_valid_pastDate(fn_mddyyyy_to_yyyymmdd(ppdate)));
  END;
  
  //****************************************************************************
  //fn_check_restriction_codes: 	returns true or false based upon the incoming
  //															code.
  // Restrictions (from https://www.flhsmv.gov/ddl/dlclass.html):        
  // A. Corrective Lenses
  // B. Outside Rearview Mirror
  // C. Business Purposes
  // D. Employment Purposes
  // E. Daylight Driving Only
  // F. Automatic Transmission
  // G. Power Steering
  // I. Directional Signals
  // J. Grip on Steering Wheel
  // K. Hearing Aid
  // L. Seat Cushion
  // M. Hand Control or Pedal Extension
  // N. Left Foot Accelerator
  // P. Probation-Interlock Device
  // S. Other Restrictions
  // T. No Passengers
  // V. ??? (NOT in book, but in SALT report)
  // X. Medical Alert Bracelet
  // Y. Education Purposes
  // 1. Vehicles Without Airbrakes
  // 2. (CDL) Intrastate Only
  // 3. (CDL) Bus Only
  // 4. CMV <26,001 LBS. GVWR
  // 5. No Tractor/Trailers
  // 6. No Class A Passenger Vehicle
  // 7. No Class B Passenger Vehicle
  //****************************************************************************
  EXPORT fn_check_restriction_codes(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := IF(Stringlib.StringFilterOut(uc_code, '1234567ABCDEFGIJKLMNPSTVXY') = '', TRUE, FALSE);																 
    isAllUnique := IF(ut.fn_count_unique_characters_in_a_string(uc_code) = LENGTH(uc_code), TRUE, FALSE);
    RETURN IF(isValidCode AND isAllUnique,1,0);
  END;


  //****************************************************************************
  //fn_check_endorsement_codes: 	returns true or false based upon the incoming
  //															code.
  // Endorsements (from https://www.flhsmv.gov/ddl/dlclass.html):    
  // H. 	Any vehicle used to transport hazardous materials in placardable amounts.
  // N. 	A tank vehicle designed to transport any liquid or gaseous material with designed capacity of 1,000 gallons or more.
  // P. 	Any vehicles, public or private, designed to transport 16 or more passengers, including the driver
  // S. 	A commercial motor vehicle (requires CDL) used to transport pre-primary, primary, or secondary school students from home to school, from school to home, or to and from school-sponsored events. Does not include a bus used as a common carrier.
  // T. 	Combination vehicles with double/triple trailers
  // X. 	Any tank vehicle used to transport placardable amounts of hazardous materials
  //****************************************************************************
  EXPORT fn_check_endorsement_codes(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := IF(Stringlib.StringFilterOut(uc_code, 'HNPSTX') = '', TRUE, FALSE);
    isAllUnique := IF(ut.fn_count_unique_characters_in_a_string(uc_code) = LENGTH(uc_code), TRUE, FALSE);
    RETURN IF(isValidCode AND isAllUnique,1,0);
  END;

  //*******************************************************************************
  //fn_check_new_dl_number: 	returns true or false based upon the incoming string.
  //													
  //new_dl_number, oos_previous_dl_number, and oos_previous_st are all
  //interrelated.
  //****************************************************************************
  EXPORT fn_check_dl_number(STRING dlnum) := FUNCTION
    dlnum_clean := ut.CleanSpacesAndUpper(dlnum);
    
		isValidLetter := IF(regexfind('[A-Z]', dlnum_clean[1]), TRUE, FALSE);
		isValidNumber := IF(Stringlib.StringFilterOut(dlnum_clean[2..], '0123456789') = '', TRUE, FALSE);
    
    RETURN IF(dlnum_clean = '' OR (isValidLetter AND isValidNumber), 1, 0);
  END;

  //*******************************************************************************
  //fn_verify_height: 	returns true or false based upon validity of driver height											
  //*******************************************************************************
  EXPORT fn_verify_height(STRING height) := FUNCTION   
    clean_feet   := ut.CleanSpacesAndUpper(height[1]);
    clean_inches := ut.CleanSpacesAndUpper(height[2..3]);
    
		isValidFeet   := IF(regexfind('[2345678]', clean_feet), TRUE, FALSE);
		isValidInches := IF(regexfind('00|01|02|03|04|05|06|07|08|09|10|11', clean_inches), TRUE, FALSE);
    
    RETURN IF(isValidFeet AND isValidInches, 1, 0);
  END;


	//****************************************************************************
	//fn_valid_name:  returns true or false based upon whether or not there is
  //                a valid name.
	//****************************************************************************
	EXPORT fn_valid_name(string fname, string mname, string lname) := function
    isValidName	:= IF( ut.CleanSpacesAndUpper(fname) <> '' OR ut.CleanSpacesAndUpper(mname) <> '' OR ut.CleanSpacesAndUpper(lname) <> '', 1, 0);
		RETURN isValidName;
  END;

END; //End Functions Module