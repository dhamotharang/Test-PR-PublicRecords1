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
    
		isValidLetter := IF(regexfind('[ABCEGHV]', dlnum_clean[1]), TRUE, FALSE);
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


  //*******************************************************************************
  //fn_verify_height: 	returns true or false based upon validity of driver height											
  //*******************************************************************************
  EXPORT fn_verify_height(STRING height) := FUNCTION
    height_clean := ut.CleanSpacesAndUpper(height);
    
		isValidFeet   := IF(regexfind('[2345678]', height_clean[1]), TRUE, FALSE);
		isValidInches := IF(regexfind('00|01|02|03|04|05|06|07|08|09|10|11', height_clean[2..]), TRUE, FALSE);
    
    RETURN IF(height_clean = '' OR (isValidFeet AND isValidInches), 1, 0);
  END;


  //*******************************************************************************
  //fn_verify_weight: 	returns true or false based upon validity of driver height											
  //*******************************************************************************
  EXPORT fn_verify_weight(STRING weight) := FUNCTION
    weight_clean := (INTEGER2)ut.CleanSpacesAndUpper(weight);
    
		isValidWeight   := IF(weight_clean >= 40 AND weight_clean <= 600, TRUE, FALSE);
    
    RETURN IF(weight = '' OR isValidWeight, 1, 0);
  END;


  //****************************************************************************
  //fn_check_eye_color: 	returns true or false based upon the incoming
  //											code.
  // Eye colors:
  // BRO: Brown
  // GRY: Gray
  // GRN: Green
  // BLK: Black
  // HAZ: Hazel
  // BLU: Blue
  // DIC: Dichromatic
  // UNK: Unknown
  //****************************************************************************
  EXPORT fn_check_eye_color(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'BRO' => TRUE,
                        'GRY' => TRUE,
                        'GRN' => TRUE,
                        'BLK' => TRUE,
                        'HAZ' => TRUE,
                        'BLU' => TRUE,
                        'DIC' => TRUE,
                        'UNK' => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;


  //****************************************************************************
  //fn_check_hair_color: 	returns true or false based upon the incoming
  //											code.
  // Hair colors:
  // BRO: Brown
  // BLN: Blonde
  // BLK: Black
  // GRY: Gray
  // RED: Red
  // WHI: White
  // BAL: Bald
  // SDY: Sandy
  // UNK: Unknown
  //****************************************************************************
  EXPORT fn_check_hair_color(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'BRO' => TRUE,
                        'BLN' => TRUE,
                        'BLK' => TRUE,
                        'GRY' => TRUE,
                        'RED' => TRUE,
                        'WHI' => TRUE,
                        'BAL' => TRUE,
                        'SDY' => TRUE,
                        'UNK' => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;


  //****************************************************************************
  //fn_check_license_type: 	returns true or false based upon the incoming
  //											  code.
  // License Types:
  // LIC: Driver's License
  // LPD: Class O/M Learner
  // POP: Provisional Operator's Permit
  // LPE: School Learner's Permit
  // IIP: Ignition Interlock Permit
  // SCP: School Permit
  // WRK: Work Permit
  // BUS: School Bus Driver Permit
  // CLP: Commercial Learner's Permit
  // LPC: Commercial Learner
  // MHP: Medical Hardship Permit
  // FHP: Farm Husbandry
  // ID:  Identification Card
  // SEP: Seasonal Permit
  // TPL: Temporary Permit
  //****************************************************************************
  EXPORT fn_check_license_type(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(ut.fn_KeepPrintableChars(code));
		isValidCode := CASE(uc_code,
                        'LIC' => TRUE,
                        'LPD' => TRUE,
                        'POP' => TRUE,
                        'LPE' => TRUE,
                        'IIP' => TRUE,
                        'SCP' => TRUE,
                        'WRK' => TRUE,
                        'BUS' => TRUE,
                        'CLP' => TRUE,
                        'LPC' => TRUE,
                        'MHP' => TRUE,
                        'FHP' => TRUE,
                        'ID'  => TRUE,
                        'SEP' => TRUE,
                        'TPL' => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;  


  //****************************************************************************
	//fn_valid_name:  returns true or false based upon whether or not there is
  //                a valid name.
	//****************************************************************************
	EXPORT fn_valid_name(string lname, string fname, string mname) := function
    isValidName	:= IF( ut.CleanSpacesAndUpper(fname) <> '' OR ut.CleanSpacesAndUpper(mname) <> '' OR ut.CleanSpacesAndUpper(lname) <> '', 1, 0);
		RETURN isValidName;
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