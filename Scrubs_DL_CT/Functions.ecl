IMPORT ut, Scrubs;

EXPORT Functions := MODULE


  //****************************************************************************
  //fn_check_dl_number: 	returns true or false based upon the incoming
  //									    code.
  // CT drivers license numbers is 9 numbers.  The first 2 digits indicate,
  // by odd or even year, the driver's month of birth and the 7 additional
  // numbers are the next available sequential number.
  //****************************************************************************
  EXPORT fn_check_dl_number(STRING dlnum) := FUNCTION
    
		isValidPattern := IF((INTEGER)dlnum[1..2] < 25, TRUE, FALSE);

    RETURN IF(dlnum = '' OR isValidPattern, 1, 0);
  END;  
  

  //*******************************************************************************
  //fn_verify_height: 	returns true or false based upon validity of driver height											
  //*******************************************************************************
  EXPORT fn_verify_height(STRING feet, STRING inches) := FUNCTION
    clean_feet   := ut.CleanSpacesAndUpper(feet);
    clean_inches := ut.CleanSpacesAndUpper(inches);
    
		isValidFeet   := IF(regexfind('[2345678]', clean_feet), TRUE, FALSE);
		isValidInches := IF(regexfind('00|01|02|03|04|05|06|07|08|09|10|11', clean_inches), TRUE, FALSE);
    
    RETURN IF(isValidFeet AND isValidInches, 1, 0);
  END;


  //****************************************************************************
  //fn_check_eye_color: 	returns true or false based upon the incoming
  //											code.
  // Eye colors:
  // BRO: Brown
  // BLU: Blue
  // HAZ: Hazel
  // GRN: Green
  // BLK: Black
  // GRY: Gray
  // DIC: Dichromatic
  // UNK: Unknown
  //****************************************************************************
  EXPORT fn_check_eye_color(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'BRO' => TRUE,
                        'BLU' => TRUE,
                        'HAZ' => TRUE,
                        'GRN' => TRUE,
                        'BLK' => TRUE,
                        'GRY' => TRUE,
                        'DIC' => TRUE,
                        'UNK' => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;


  //****************************************************************************
  //fn_class: 	returns true or false based upon the incoming
  //						code.
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
                        '1'  => TRUE,
                        '2'  => TRUE,
                        'M'  => TRUE,
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;
    

	//****************************************************************************
	//fn_check_pastdate:  converts yyyymm and dd to yyyymmdd date and time
	//****************************************************************************
	EXPORT fn_check_pastdate(string yyyymm, string dd) := function
    pDate       := TRIM(yyyymm + dd,ALL);
    isValidDate	:= IF(Scrubs.fn_valid_pastDate(pDate) > 0, TRUE, FALSE);                   
		RETURN IF(pDate = '' OR isValidDate, 1, 0);
  END;
 
  
	//****************************************************************************
	//fn_check_date:  converts yyyymm and dd to yyyymmdd date and time
	//****************************************************************************
	EXPORT fn_check_date(string yyyymm, string dd) := function
    pDate       := TRIM(yyyymm + dd,ALL);
    isValidDate	:= IF(Scrubs.fn_valid_GeneralDate(pDate) > 0, TRUE, FALSE);                   
		RETURN IF(pDate = '' OR isValidDate, 1, 0);
  END;
 
  
  //****************************************************************************
  //fn_check_status_code: 	returns true or false based upon the incoming
  //												code.
  // License Status Codes:     
  // CAN:  Cancelled???
  // CDL:  Commercial Drivers License
  // DED:  ???
  // DIS:  Disqualified???
  // DNG:  ???
  // REV:  Revoked???
  // SUS:  Suspended???
  // VAL:  Valid???
  // VOI:  Voided???
  // XRF:  ???
  //****************************************************************************
  EXPORT fn_check_status_code(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'CAN' => TRUE,
                        'CDL' => TRUE,
                        'DED' => TRUE,
                        'DIS' => TRUE,
                        'DNG' => TRUE,
                        'REV' => TRUE,
                        'SUS' => TRUE,
                        'VAL' => TRUE,
                        'VOI' => TRUE,
                        'XRF' => TRUE,
                        '' => TRUE,
                        FALSE);
    RETURN IF(isValidCode, 1, 0);
  END;  
 
 
  //****************************************************************************
  //fn_check_restriction_codes: 	returns true or false based upon the incoming
  //															code.
  // Restrictions (from the 2013 MVR Access and Decoder Digest):        
  // B. Corrective Lenses
  // C. Mechanical Aid
  // D. Prosthetic Aid
  // E. Automatic Transmission
  // F. Outside Mirror
  // G. Limited to Daylight Only
  // K. CDL Intrastate Only
  // L. Vehicle Without Air Brakes
  // M. ???
  // N. ???
  // O. ???
  // Q. Any Vehicle Exempt from the CDL Program with a GVWR of 26,001 or More Pounds Excluding Recreational Vehicles
  // R. No Limited Access Roads
  // T. Taxicab, Service Bus, Motor Vehicle in Livery Service, Coach, Motorbus
  // U. Hearing Aid Required
  // V. STVs and vehicles listed Under Restriction T; drivers with V restriction will not be allowed to drive students to home or school
  // W. Medical Waiver Required
  // Y. ???
  // Z. School Bus - CDL only
  //****************************************************************************
  EXPORT fn_check_restriction_codes(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := IF(Stringlib.StringFilterOut(uc_code, 'BCDEFGKLMNOQRTUVWYZ') = '', TRUE, FALSE);
    isAllUnique := IF(ut.fn_count_unique_characters_in_a_string(uc_code) = LENGTH(uc_code), TRUE, FALSE);
    RETURN IF(isValidCode AND isAllUnique,1,0);
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