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
	//fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function    
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
  END;


  //****************************************************************************
  //fn_check_license_type: 	returns true or false based upon the incoming
  //											  code.
  // License Type (https://apps.tn.gov/imvr/codes.html):
  // M*** Class M (Motorcycle) 
  // PA*** Class A Permit 
  // A*** Class A 
  // AM** Class A with Motorcycle 
  // APM* Class A with Motorcycle Permit 
  // APA* Class A with Class A Permit 
  // APB* Class A with Class B Permit 
  // APC* Class A with Class C Permit 
  // AMPA Class A License with Motorcycle and Class A Permit 
  // AMPB Class A License with Motorcycle and Class B Permit 
  // AMPC Class A License with Motorcycle and Class C Permit 
  // PB** Class B Permit 
  // B*** Class B License 
  // BM** Class B License with Motorcycle 
  // BPA* Class B License with Class A Permit 
  // BPM* Class B License with Class M Permit 
  // BMPA Class B with Class M and Permit for Class A 
  // BPC* Class B with Class C Permit 
  // BMPC Class B with Class M and Permit for Class C 
  // PC** Class C Permit 
  // C*** Class C License 
  // CM** Class C License with Motorcycle 
  // CPA* Class C License with Class A Permit 
  // CPB* Class C License with Class B Permit 
  // CPM* Class C License with Class M Permit 
  // CMPA Class C License with Motorcycle and Class A Permit 
  // CMPB Class C License with Motorcycle and Class B Permit 
  // PD** Class D Permit 
  // D*** Class D License 
  // DM** Class D License with Motorcycle 
  // DPA* Class D License with Class A Permit 
  // DPB* Class D License with Class B Permit 
  // DPC* Class D License with Class C Permit 
  // DPM* Class D License with Class M Permit 
  // DMPA Class D License with Motorcycle and Class A Permit 
  // DMPB  Class D License with Motorcycle and Class B Permit 
  // DMPC Class D License with Motorcycle and Class C Permit 
  // PDPM Class D Permit with Class M Permit 
  // PM** Class M Permit 
  // MPD* Class M License with Class D Permit 
  // MPA* Class M License with Class A Permit 
  // MPB* Class M License with Class B Permit 
  // MPC* Class M License with Class C Permit 
  // HM** Hardship License with Class M License 
  // HPM* Hardship License with Class M Permit 
  // H*** Hardship License 
  // ID** Identification Only 
  // 
  // BPB* ??? 
  // BMPB ??? 
  // HO** ??? 
  // PID* ??? 
  // XD** ??? 
  // XDM* ??? 
  // XH** ??? 
  // XID* ??? 
  // XM** ??? 
  // XMPD ??? 
  // XPD* ??? 
  //****************************************************************************
  EXPORT fn_check_license_type(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(regexreplace('[0-9]', code, ''));
		isValidCode := CASE(uc_code,
                        'M'    => TRUE,
                        'PA'   => TRUE,
                        'A'    => TRUE,
                        'AM'   => TRUE,
                        'APM'  => TRUE,
                        'APA'  => TRUE,
                        'APB'  => TRUE,
                        'APC'  => TRUE,
                        'AMPA' => TRUE,
                        'AMPB' => TRUE,
                        'AMPC' => TRUE,
                        'PB'   => TRUE,
                        'B'    => TRUE,
                        'BM'   => TRUE,
                        'BPA'  => TRUE,
                        'BPM'  => TRUE,
                        'BMPA' => TRUE,
                        'BPC'  => TRUE,
                        'BMPC' => TRUE,
                        'PC'   => TRUE,
                        'C'    => TRUE,
                        'CM'   => TRUE,
                        'CPA'  => TRUE,
                        'CPB'  => TRUE,
                        'CPM'  => TRUE,
                        'CMPA' => TRUE,
                        'CMPB' => TRUE,
                        'PD'   => TRUE,
                        'D'    => TRUE,
                        'DM'   => TRUE,
                        'DPA'  => TRUE,
                        'DPB'  => TRUE,
                        'DPC'  => TRUE,
                        'DPM'  => TRUE,
                        'DMPA' => TRUE,
                        'DMPB' => TRUE,
                        'DMPC' => TRUE,
                        'PDPM' => TRUE,
                        'PM'   => TRUE,
                        'MPD'  => TRUE,
                        'MPA'  => TRUE,
                        'MPB'  => TRUE,
                        'MPC'  => TRUE,
                        'HM'   => TRUE,
                        'HPM'  => TRUE,
                        'H'    => TRUE,
                        'ID'   => TRUE,
                        'BPB'  => TRUE,
                        'BMPB' => TRUE,
                        'HO'   => TRUE,
                        'PID'  => TRUE,
                        'XD'   => TRUE,
                        'XDM'  => TRUE,
                        'XH'   => TRUE,
                        'XID'  => TRUE,
                        'XM'   => TRUE,
                        'XMPD' => TRUE,
                        'XPD'  => TRUE,
                        ''     => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
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


  //*******************************************************************************
  //fn_verify_weight: 	returns true or false based upon validity of driver height											
  //*******************************************************************************
  EXPORT fn_verify_weight(STRING weight) := FUNCTION
    weight_clean := (INTEGER2)ut.CleanSpacesAndUpper(weight);
    
		isValidWeight   := IF(weight_clean >= 40 AND weight_clean <= 600, TRUE, FALSE);
    
    RETURN IF(weight = '' OR weight_clean = 0 OR isValidWeight, 1, 0);
  END;
  
  
  //****************************************************************************
  //fn_check_eye_color: 	returns true or false based upon the incoming
  //											code.
  // Eye colors:
  // BR: Brown
  // BL: Blue
  // HZ: Hazel
  // GN: Green
  // UN: Unknown
  // BK: Black
  // GR: Gray
  // DI: Dichromatic
  //****************************************************************************
  EXPORT fn_check_eye_color(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'BR' => TRUE,
                        'BL' => TRUE,
                        'HZ' => TRUE,
                        'GN' => TRUE,
                        'UN' => TRUE,
                        'BK' => TRUE,
                        'GR' => TRUE,
                        'DI' => TRUE,
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;


  //****************************************************************************
  //fn_check_hair_color: 	returns true or false based upon the incoming
  //											code.
  // Hair colors:
  // BR: Brown
  // BK: Black
  // BN: Blonde
  // GY: Gray
  // UK: Unknown
  // RD: Red
  // BD: Bald
  // AB: Auburn
  // RB: ???
  // LB: ???
  //****************************************************************************
  EXPORT fn_check_hair_color(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'BR' => TRUE,
                        'BK' => TRUE,
                        'BN' => TRUE,
                        'GY' => TRUE,
                        'UK' => TRUE,
                        'RD' => TRUE,
                        'BD' => TRUE,
                        'AB' => TRUE,
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;


  //****************************************************************************
  //fn_check_endorsement: 	returns true or false based upon the incoming
  //									      code.
  // Endorsement Codes:
  // B: School Bus, Private
  // C: Cargo Tank
  // H: Hazardous Material
  // N: Cargo Tanker
  // F: For Hire - Non Commercial Class D
  // P: Passenger
  // S: School Bus, Public
  // T: Multiple Trailer
  // X: Tanker and Hazardous Material
  //****************************************************************************
  EXPORT fn_check_endorsement(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'B'  => TRUE,
                        'C'  => TRUE,
                        'H' => TRUE,
                        'N'  => TRUE,
                        'F'  => TRUE,
                        'P'  => TRUE,
                        'S'  => TRUE,
                        'T'  => TRUE,
                        'X'  => TRUE,
                        ''   => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;  


  //****************************************************************************
  //fn_check_race: 	returns true or false based upon the incoming
  //								code.
  // Race cards:
  // WHITE
  // AFRICA
  // OTHER
  // HISPAN
  // ASIAN
  // NATIVE
  //****************************************************************************
  EXPORT fn_check_race(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'WHITE'  => TRUE,
                        'AFRICA' => TRUE,
                        'OTHER'  => TRUE,
                        'HISPAN' => TRUE,
                        'ASIAN'  => TRUE,
                        'NATIVE' => TRUE,
                        ''       => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;
 
 
END; //End Functions Module