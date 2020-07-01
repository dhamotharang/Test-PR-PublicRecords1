IMPORT ut,Codes;

EXPORT Functions := MODULE

  //****************************************************************************
  //fn_check_dl_number: 	returns true or false based upon the incoming code.
  // Ohio drivers license numbers consist of 2 letters followed by 6 numbers OR It can be all(9) numbers
  //****************************************************************************
  EXPORT fn_check_dl_number(STRING dlnum) := FUNCTION
    dlnum_clean 	 := ut.CleanSpacesAndUpper(dlnum);    
		isValidPattern := IF(regexfind('[A-Z]{2}[0-9]{6}|[0-9]', dlnum_clean), TRUE, FALSE);
    RETURN IF(isValidPattern, 1, 0);
  END; 
	
  //****************************************************************************
  //fn_class: 	returns true or false based upon the incoming code.
  // Classes ():
  // A:  Any combination of vehicles with a combined Gross Vehicle Weight Rating (GVWR) of 26,001 lbs. or more, if the GVWR of the vehicle or vehicles being towed is in excess of 10,000 lbs.
  // B:  Any single vehicle with a GVWR of 26,001 lbs. or more or any such vehicle towing a vehicle having a GVWR that is not in excess of 10,000 lbs.
  // C:  Any single vehicle, or combination of vehicles, designed to transport 16 or more passengers, including the driver, or is placarded for hazardous materials and any school bus with a GVWR of less than 26,001 lbs. that is designed to transport fewer than 16 passengers including the driver.
  // D:  Operator
  // I:  Identification Card
  // M1: Motorcycle Only
  // M2: Motorized Bicycle Only
  // M3: 3-Wheel Motorcycle Only
	// M4: Motor Scooter Only	
  // T:  Temporary ID
	// '': Unknown
  //****************************************************************************
  EXPORT fn_class(STRING code) := FUNCTION
	  uc_code 		:= ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'A'  => TRUE,
                        'B'  => TRUE,
                        'C'  => TRUE,
                        'D'  => TRUE,
                        'I'  => TRUE,
                        'M1' => TRUE,
                        'M2' => TRUE,
                        'M3' => TRUE,
												'M4' => TRUE,												
                        'T'  => TRUE,
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;
    
  //**************************************************************************** 
  //fn_check_hair_color: 	returns true or false based upon the incoming code.
  // Hair colors:	
  // BAL: Bald
	// BLD: Blond
  // BLN: Blonde
  // BLK: Black
  // BRO: Brown
  // GRY: Gray
  // RED: Red	
  // SDY: Sandy
  // UNK: Unknown
	// WHI: White
  //****************************************************************************
  EXPORT fn_check_hair_color(STRING code) := FUNCTION
	  uc_code 		:= ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,		
                        'BAL' => TRUE,
												'BLD' => TRUE,				
                        'BLK' => TRUE,
                        'BLN' => TRUE,
                        'BRO' => TRUE,
                        'GRY' => TRUE,
                        'RED' => TRUE,
                        'SDY' => TRUE,
                        'UNK' => TRUE,												
                        'WHI' => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;

  //****************************************************************************
  //fn_check_eye_color: 	returns true or false based upon the incoming code.
  // Eye colors:
	// BLK: Black
	// BLU: Blue
	// BRO: Brown
	// DIC: Dichromatic
	// GRN: Green
	// GRY: Gray
	// HAZ: Hazel
	// MAR: Maroon
	// PNK: Pink	 
	// UNK: Unknown
  //****************************************************************************
  EXPORT fn_check_eye_color(STRING code) := FUNCTION 
	  uc_code 		:= ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
												'BLK' => TRUE,		
                        'BLU' => TRUE,
                        'BRO' => TRUE,
												'DIC' => TRUE,
                        'GRN' => TRUE,												
                        'GRY' => TRUE,
                        'HAZ' => TRUE,
                        'MAR' => TRUE,
                        'PNK' => TRUE,												
                        'UNK' => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;

  //*******************************************************************************
  //fn_verify_weight: 	returns true or false based upon validity of driver weight											
  //*******************************************************************************
  EXPORT fn_verify_weight(STRING weight) := FUNCTION
    weight_clean 		:= (INTEGER2)ut.CleanSpacesAndUpper(weight);    
		isValidWeight   := IF(weight_clean >= 30 AND weight_clean <= 1000, TRUE, FALSE);    
    RETURN IF(weight = '' OR weight_clean = 0 OR isValidWeight, 1, 0);
  END;
  
	//*******************************************************************************
  //fn_verify_height: returns true or false based upon validity of driver height
  //*******************************************************************************
  EXPORT fn_verify_height(STRING height, STRING inches) := FUNCTION
    height_clean          := trim(height,all);   
		inches_clean          := trim(inches,all); 
		isValidFeet_Inches    := IF(regexfind('[3456789]', height_clean) and regexfind('0|1|2|3|4|5|6|7|8|9|10|11', inches_clean), TRUE, FALSE);
		RETURN IF(height_clean = '' OR (isValidFeet_Inches), 1, 0);
  END;
	
	//****************************************************************************
	// fn_verify_zip: returns true or false based upon whether or not there is
	// a 5-digit , 9-digit  or 11-digit(OH-data has '11' digit zip codes)
	//****************************************************************************
	EXPORT fn_verify_zip(STRING zip) := function 
		RETURN IF(LENGTH(trim(zip, all))in [5,9,11] AND Stringlib.StringFilterOut(trim(zip, all), '0123456789') = '', 1, 0);
	END;
	
	//****************************************************************************
	//fn_verify_state: Returns true or false based upon whether or not there is
	// a valid state abbreviation.(OH-data has foreign state data)
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function
	  list:=['AA','AB','AE','AG','AP','BC','CH','DI','DS','DU','GR','IR','JA','MB','NA','NB',
					 'NL','NT','NS','NU','OA','ON','PE','PU','PZ','QC','QU','RO','SI','SK','SL','SO',
					 'TA','TL','UM','VE','YT','YU','ZA']; 
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0 or trim(code,all)in list, 1, 0);		
	END;
	
END; 