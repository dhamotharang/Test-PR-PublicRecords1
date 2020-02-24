IMPORT ut, Scrubs, codes;

EXPORT Functions := MODULE

	//****************************************************************************
	// fn_check_dl_number: Returns true or false based upon the incoming code.
	// CT drivers license numbers are 9 digits.  The first 2 digits indicate,
	// by odd or even year, the driver's month of birth and the 7 additional
	// numbers are the next available sequential number.
	//****************************************************************************
	EXPORT fn_check_dl_number(STRING dlnum, UNSIGNED1 size = 0) := FUNCTION
		RETURN IF(IF(size = 0, LENGTH(TRIM(dlnum, ALL)) > 0, LENGTH(TRIM(dlnum, ALL)) = size) AND
							Stringlib.StringFilterOut(dlnum, '0123456789') = '',1,0);
	END;

	//****************************************************************************
	// fn_verify_zip: returns true or false based upon whether or not there is
	// a 5-digit , 9-digit  or blank value.
	//****************************************************************************
	EXPORT fn_verify_zip(STRING zip) := function 
		RETURN IF(LENGTH(trim(zip, all))in [5,9] AND Stringlib.StringFilterOut(trim(zip, all), '0123456789') = '', 1, 0);
	END;

	//*******************************************************************************
  //fn_verify_height: returns true or false based upon validity of driver height
  //*******************************************************************************
  EXPORT fn_verify_height(STRING height) := FUNCTION
    height_clean          := trim(height,all);    
		isValidFeet_Inches    := IF(regexfind('[3456789]', height_clean[1]) and regexfind('00|01|02|03|04|05|06|07|08|09|10|11', height_clean[2..]), TRUE, FALSE);
		RETURN IF(height_clean = '' OR (isValidFeet_Inches), 1, 0);
  END;

	//****************************************************************************
	//fn_verify_state: Returns true or false based upon whether or not there is
	//                  a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);		
	END;

	//****************************************************************************
	//fn_check_eye_color: Returns true or false based upon the incoming	code.
	// Eye colors:
	// BRO: Brown
	// BLU: Blue
	// HAZ: Hazel
	// GRN: Green
	// BLK: Black
	// GRY: Gray
	// DIC: Dichromatic
	// PNK: Pink
	// UNK: Unknown
	//****************************************************************************
	EXPORT fn_check_eye_color(STRING code) := FUNCTION
		uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
												'BRO' => TRUE,
												'BLU' => TRUE,												
												'BLK' => TRUE,												
												'DIC' => TRUE,
												'GRN' => TRUE,
												'GRY' => TRUE,
												'HAZ' => TRUE,
												'PNK' => TRUE,
												'UNK' => TRUE,
												FALSE);
		RETURN IF(isValidCode,1,0);
	END;


  //****************************************************************************
  //fn_class: returns true or false based upon the incoming code.
  // Classes (2013 MVR Access and Decoder Digest):
  // A:  Any combination of vehicles with a gross combined weight rating (GVWR) of 26,001 lbs. or more, provided the GVWR of the vehicles being towed is in excess of 10,000 lbs.
  // B:  Any single vehicle with a GVWR of 26,001 lbs. or more, or any such vehicle towing a vehicle not in excess of 10,000 lbs.
  // C:  Any single vehicle not in excess of 26,001 lbs., or any such vehicle towing a vehicle not in excess, including vehicles required to be placarded for hazardous materials; or any vehicle designed to transport 16 or more passengers, including the driver.  Also, vehicles designed to transport more than 10 passengers (including the driver), and used to transport students under the age of 21 yeas to and from school.
  // D:  (Issued as of 01/01/2006) Any motor vehicle including a combination of motor vehicle and trailer or trailing unit used exclusively for camping or any other recreatiional purposes regardless of gross weight of the trailer or trailing unit, except a commercial motor vehicle or an articulated vehicle or any other combination of motor vehicle and trailer where the gross weight of the trailing unit or trailer is more than 10,000 lbs.
  // 1:  (Has not been issued since 01/01/2006) Any motor vehicle except a commercial motor vehicle.
  // 2:  (Has not been issued since 01/01/2006) Any motor vehicle including a combination of motor vehicle and trailer or trailing unit used exclusively for camping or any other recreatiional purposes regardless of gross weight of the trailer or trailing unit, except a commercial motor vehicle or an articulated vehicle or any other combination of motor vehicle and trailer where the gross weight of the trailing unit or trailer is more than 10,000 lbs.
  // M:  (Made an Endorsement 01/01/2006) Alone or combined with any other class evidence the holder is licensed to operate a motorcycle.
  //****************************************************************************
  EXPORT fn_class(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'A'  => TRUE,
                        'B'  => TRUE,
                        'C'  => TRUE,
                        'D'  => TRUE,												
                        'M'  => TRUE,
                        '1'  => TRUE,
                        '2'  => TRUE,
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;
	
	//****************************************************************************
	//fn_check_past_date: 
	//****************************************************************************
	EXPORT fn_check_past_date(string yyyymmdd) := function
		isValidDate	:= IF(Scrubs.fn_valid_pastDate(yyyymmdd) > 0, TRUE, FALSE);                   
		RETURN IF(trim(yyyymmdd,all) = '' OR isValidDate, 1, 0);
	END;
	
	//****************************************************************************
	//fn_check_general_date:  
	//****************************************************************************
	EXPORT fn_check_general_date(string yyyymmdd) := function
		isValidDate	:= IF(Scrubs.fn_valid_GeneralDate(yyyymmdd) > 0, TRUE, FALSE);                   
		RETURN IF(trim(yyyymmdd,all) = ''  OR isValidDate, 1, 0);
	END;
	
	//****************************************************************************
	//fn_check_status_code: Returns true or false based upon the incoming code.
	// License Status Codes:     
	// LIC – Licensed
	// DED – Deceased
	// REV – Revoked
	// SUS – Suspended
	// DIS – Disqualified
	// CAN – Cancelled
	//****************************************************************************
	EXPORT fn_check_status_code(STRING code) := FUNCTION
		uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
												'CAN' => TRUE,
												'DED' => TRUE,												
												'DIS' => TRUE,
												'LIC' => TRUE,
												'REV' => TRUE,
												'SUS' => TRUE,
												'' => TRUE,
												FALSE);
		RETURN IF(isValidCode, 1, 0);
	END; 
	
	//****************************************************************************
	//fn_check_cdl_status_code: Returns true or false based upon the incoming code.
	// License Status Codes:     
	// LIC – Licensed
	// DED – Deceased
	// REV – Revoked
	// SUS – Suspended
	// DIS – Disqualified
	// CAN – Cancelled
	//****************************************************************************
	EXPORT fn_check_cdl_status_code(STRING code) := FUNCTION
		uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
												'CAN' => TRUE,
												'DED' => TRUE,												
												'DIS' => TRUE,
												'LIC' => TRUE,
												'REV' => TRUE,
												'SUS' => TRUE,
												''    => TRUE,
												FALSE);
		RETURN IF(isValidCode, 1, 0);
	END;  

	//****************************************************************************
	//fn_valid_name: Returns true or false based upon whether or not there is
	//                a valid name.
	//****************************************************************************
	EXPORT fn_valid_name(string lname, string fname, string mname) := function
		isValidName	:= IF( ut.CleanSpacesAndUpper(fname) <> '' OR ut.CleanSpacesAndUpper(mname) <> '' OR ut.CleanSpacesAndUpper(lname) <> '', 1, 0);
		RETURN isValidName;
	END;
	
END; 