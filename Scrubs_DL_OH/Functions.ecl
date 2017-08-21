IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE


  //****************************************************************************
  //fn_check_dl_number: 	returns true or false based upon the incoming
  //									    code.
  // Ohio drivers license numbers consist of 2 letters followed by 6 numbers.
  //****************************************************************************
  EXPORT fn_check_dl_number(STRING dlnum) := FUNCTION
    dlnum_clean := ut.CleanSpacesAndUpper(dlnum);
    
		isValidPattern := IF(regexfind('[A-Z]{2}[0-9]{6}', dlnum_clean), TRUE, FALSE);

    RETURN IF(isValidPattern, 1, 0);
  END;  
  
  
  //****************************************************************************
  //fn_class: 	returns true or false based upon the incoming
  //						code.
  // Classes ():
  // A:  Any combination of vehicles with a combined Gross Vehicle Weight Rating (GVWR) of 26,001 lbs. or more, if the GVWR of the vehicle or vehicles being towed is in excess of 10,000 lbs.
  // B:  Any single vehicle with a GVWR of 26,001 lbs. or more or any such vehicle towing a vehicle having a GVWR that is not in excess of 10,000 lbs.
  // C:  Any single vehicle, or combination of vehicles, designed to transport 16 or more passengers, including the driver, or is placarded for hazardous materials and any school bus with a GVWR of less than 26,001 lbs. that is designed to transport fewer than 16 passengers including the driver.
  // D:  Operator
  // I:  Identification Card
  // T:  Temporary ID
  // M1: Motorcycle Only
  // M2: Motorized Bicycle Only
  // M3: 3-Wheel Motorcycle Only
  //****************************************************************************
  EXPORT fn_class(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'A'  => TRUE,
                        'B'  => TRUE,
                        'C'  => TRUE,
                        'D'  => TRUE,
                        'I'  => TRUE,
                        'T'  => TRUE,
                        'M1' => TRUE,
                        'M2' => TRUE,
                        'M3' => TRUE,
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;
    

  //****************************************************************************
  //fn_check_license_type: 	returns true or false based upon the incoming
  //											  code.
  // License Types:
  // E
  // F
  // G
  // G1
  // O
  // R
  //****************************************************************************
  EXPORT fn_check_license_type(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(ut.fn_KeepPrintableChars(code));
		isValidCode := CASE(uc_code,
                        'E'  => TRUE,
                        'F'  => TRUE,
                        'G'  => TRUE,
                        'G1' => TRUE,
                        'O'  => TRUE,
                        'R'  => TRUE,
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;  


  //****************************************************************************
  //fn_check_donor: 	returns true or false based upon the incoming
  //									code.
  // Donor Types:
  // F
  // M
  // N
  // S
  // U
  // Y
  //****************************************************************************
  EXPORT fn_check_donor(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(ut.fn_KeepPrintableChars(code));
		isValidCode := CASE(uc_code,
                        'F'  => TRUE,
                        'M'  => TRUE,
                        'N' => TRUE,
                        'S'  => TRUE,
                        'U'  => TRUE,
                        'Y'  => TRUE,
                        ''   => TRUE,
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
  //fn_check_eye_color: 	returns true or false based upon the incoming
  //											code.
  // Eye colors:
  // BRO: Brown
  // BLU: Blue
  // HAZ: Hazel
  // GRN: Green
  // BLK: Black
  // UNK: Unknown
  // GRY: Gray
  // DIC: Dichromatic
  // MAR: Maroon
  // PNK: Pink
  //****************************************************************************
  EXPORT fn_check_eye_color(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'BRO' => TRUE,
                        'BLU' => TRUE,
                        'HAZ' => TRUE,
                        'GRN' => TRUE,
                        'BLK' => TRUE,
                        'UNK' => TRUE,
                        'GRY' => TRUE,
                        'DIC' => TRUE,
                        'MAR' => TRUE,
                        'PNK' => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;


  //*******************************************************************************
  //fn_verify_weight: 	returns true or false based upon validity of driver height											
  //*******************************************************************************
  EXPORT fn_verify_weight(STRING weight) := FUNCTION
    weight_clean := (INTEGER2)ut.CleanSpacesAndUpper(weight);
    
		isValidWeight   := IF(weight_clean >= 40 AND weight_clean <= 600, TRUE, FALSE);
    
    RETURN IF(weight = '' OR weight_clean = 0 OR isValidWeight, 1, 0);
  END;
  
  
  //*******************************************************************************
  //fn_verify_height: 	returns true or false based upon validity of driver height											
  //*******************************************************************************
  EXPORT fn_verify_height(STRING feet, STRING inches) := FUNCTION
    clean_feet   := ut.CleanSpacesAndUpper(feet);
    clean_inches := ut.CleanSpacesAndUpper(inches);
    
		isValidFeet   := IF(regexfind('[2345678]', clean_feet), TRUE, FALSE);
		isValidInches := IF(regexfind('00|01|02|03|04|05|06|07|08|09|10|11', clean_inches), TRUE, FALSE);

		isValidInchesOnly := IF(((clean_feet = '' OR clean_feet = '0') AND (clean_inches = '' OR clean_inches = '0' OR clean_inches = '00')) OR 
                            ((clean_feet = '' OR clean_feet = '0') AND (INTEGER1)clean_inches > 23 AND (INTEGER1)clean_inches < 108), TRUE, FALSE);
    
    RETURN IF((isValidFeet AND isValidInches) OR isValidInchesOnly, 1, 0);
  END;


  //****************************************************************************
  //fn_check_trans_type: 	returns true or false based upon the incoming
  //											code.
  // Application Trans Type:
  // AED:
  // DNG:
  // DUP: Duplicate
  // ORG: Original
  // OSC: 
  // REN: Renew
  // RPL: Replacement
  // SDP:
  // TMP: Temporary
  // UPG: Upgrade
  //****************************************************************************
  EXPORT fn_check_trans_type(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'AED' => TRUE,
                        'DNG' => TRUE,
                        'DUP' => TRUE,
                        'ORG' => TRUE,
                        'OSC' => TRUE,
                        'REN' => TRUE,
                        'RPL' => TRUE,
                        'SDP' => TRUE,
                        'TMP' => TRUE,
                        'UPG' => TRUE,
                        ''    => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;


  //****************************************************************************
  //fn_check_sycpgm: 	returns true or false based upon the incoming
  //									code.
  //****************************************************************************
  EXPORT fn_check_sycpgm(STRING sycpgm) := FUNCTION
    sycpgm_clean := ut.CleanSpacesAndUpper(sycpgm);
    
		isValidPattern := IF(regexfind('[DLMUZ][0-9]{3}', sycpgm), TRUE, FALSE);

    RETURN IF(isValidPattern, 1, 0);
  END;  
  
  
	//****************************************************************************
	//fn_yyyymmddHHMMsss0:  converts yyyymmddHHMMsss0 to yyyymmdd date and time
	//****************************************************************************
	EXPORT fn_yyyymmddHHMMsss0(string pDateTime_in) := function
    pDateTime   := TRIM(pDateTime_in,ALL);
    isValidDate	:= IF(Scrubs.fn_valid_pastDate(pDateTime[1..8]) > 0, TRUE, FALSE);                   
    isValidTime	:= IF(((INTEGER1)pDateTime[9..10] >= 0  AND (INTEGER1)pDateTime[9..10]  <= 23) AND //hours
                   ((INTEGER1)pDateTime[11..12] >= 0 AND (INTEGER1)pDateTime[11..12] <= 59)        //minutes
                   , TRUE, FALSE);               
		RETURN IF(isValidDate AND isValidTime, 1, 0);
  END;
 
 
  //****************************************************************************
	//fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function    
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
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