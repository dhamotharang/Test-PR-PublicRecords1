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
  // T:  Temporary ID
  // M1: Motorcycle Only
  // M2: Motorized Bicycle Only
  // M3: 3-Wheel Motorcycle Only
	// M4: Motor Scooter Only
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
                        'T'  => TRUE,
                        'M1' => TRUE,
                        'M2' => TRUE,
                        'M3' => TRUE,
												'M4' => TRUE,												
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;
    
  //**************************************************************************** 
  //fn_check_hair_color: 	returns true or false based upon the incoming code.
  // Hair colors:
  // BRO: Brown
  // BLN: Blonde
  // BLK: Black
  // GRY: Gray
  // RED: Red
  // WHI: White
  // BAL: Bald
	// BLD: Blond
  // SDY: Sandy
  // UNK: Unknown
  //****************************************************************************
  EXPORT fn_check_hair_color(STRING code) := FUNCTION
	  uc_code 		:= ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,		
                        'BAL' => TRUE,
												'BLD' => TRUE,
                        'BRO' => TRUE,												
                        'BLK' => TRUE,
                        'BLN' => TRUE,
                        'GRY' => TRUE,
                        'RED' => TRUE,
                        'WHI' => TRUE,
                        'SDY' => TRUE,
                        'UNK' => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;

  //****************************************************************************
  //fn_check_eye_color: 	returns true or false based upon the incoming code.
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
	  uc_code 		:= ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'BRO' => TRUE,
                        'BLU' => TRUE,
												'BLK' => TRUE,
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
  //fn_verify_weight: 	returns true or false based upon validity of driver height											
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
	  list:=['NB','DI','AB','BC','DS','VE','MB','NS','QU','IR','DU','SK','OA','PE','NL','CH','NT','TA',
					 'GR','NA','NU','YT','SL','RO','AG','YU','ON','SO','JA','PU','UM','AP','TL','PZ','ZA','SI',
					 'QC','AE','AA']; 
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0 or trim(code,all)in list, 1, 0);		
	END;

	//****************************************************************************
	//fn_verify_RrestrictionCode:  returns true or false based upon whether or not there is
  //   a valid vendor restriction code.
	//****************************************************************************
	EXPORT fn_verify_RestrictionCode(STRING pRestCode) := function
		List :=	['A','B','C1','C2','C3','C4','C5','C6','C7','C8','C9','C0','D1','D2',
						 'D3','D4','D5','D6','D7','D8','D9','E','E1','E2','E3','F1','F2','F3',
						 'G','G1','G2','J1','G3','G4','I','J','K','K1','K2','K3','L','P1','P2',
						 'P3','P4','W','C','D','F','H','O','P','V','X','Z','PG','J2','J3','J4',
						 'J5','J6','M','N',''];
		Rrestriction 	 := map(trim(pRestCode[1..2],right)   in list =>1,
													trim(pRestCode[3..4],right)   in list =>1, 
													trim(pRestCode[5..6],right)   in list =>1, 
													trim(pRestCode[7..8],right)   in list =>1, 
													trim(pRestCode[9..10],right)  in list =>1, 
													trim(pRestCode[11..12],right) in list =>1, 
													trim(pRestCode[13..14],right) in list =>1, 
													trim(pRestCode[15..16],right) in list =>1, 
													trim(pRestCode[17..18],right) in list =>1, 
													trim(pRestCode[19..20],right) in list =>1, 
													trim(pRestCode[21..22],right) in list =>1, 
													trim(pRestCode[23..24],right) in list =>1, 
													trim(pRestCode[25..26],right) in list =>1,
													trim(pRestCode[27..28],right) in list =>1,
													trim(pRestCode[29..30],right) in list =>1,
													trim(pRestCode[31..32],right) in list =>1, 
													trim(pRestCode[33..34],right) in list =>1,
													trim(pRestCode[35..36],right) in list =>1,
													trim(pRestCode[37..38],right) in list =>1,
													trim(pRestCode[39..40],right) in list =>1,
													trim(pRestCode[41..42],right) in list =>1,
													trim(pRestCode,all) ='' =>1,0);
		RETURN Rrestriction	;
	END;
	
END; 