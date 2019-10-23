IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE

  //*******************************************************************************
  //fn_verify_licno: 	returns true or false based upon validity of license no.
  //
  // A computer generated number with one letter (usually an "S") and 8 numbers
  // is automatically issued.  - 2013 MVR Access and Decoder Digest
  //*******************************************************************************
  EXPORT fn_verify_licno(STRING dlnum) := FUNCTION
    dlnum_clean := ut.CleanSpacesAndUpper(dlnum);
    
		isValidAlphaNum := IF(regexfind('[0-9A-Z]', dlnum_clean[1]), TRUE, FALSE);
		isValidNumber   := IF(Stringlib.StringFilterOut(dlnum_clean[2..], '0123456789') = '', TRUE, FALSE);
    
    RETURN IF(isValidAlphaNum AND isValidNumber, 1, 0);
  END;
  
  
  //****************************************************************************
  //fn_verify_lic_class: 	returns true or false based upon the incoming
  //															code.
  // Classes (from http://www.massrmv.com/LicenseandID.aspx and SALT report):     
  // Class A - Any combination of vehicles with a GVWR of 26,001 or more pounds provided the GVWR of the vehicle(s) being towed is in excess of 10,000 pounds. (Holders of a Class A license may, with any appropriate endorsements, operate all vehicles within Classes B, C, and D).
  // Class B - Any single vehicle with a GVWR of 26,001 or more pounds, or any such vehicle towing a vehicle not in excess of 10,000 pounds GVWR. (Holders of a Class B license may, with any appropriate endorsements, operate all vehicles within Classes B, C, and D).
  // Class C - Any single vehicle, or combination of vehicles, that does not meet the definition of Class A or Class B, but is either designed to transport 16 or more passengers, including the driver, or is placarded for hazardous materials. (Holders of a Class C license may, with any appropriate endorsements, operate all vehicles within Classes C and D).
  // Class D - Any single passenger vehicle or combination, except a semi-trailer unit, truck-trailer combination, tractor, or truck with a gross vehicle weight rating (GVWR) over 26,000 lbs., bus or school bus.
  // Class M - A motorcycle or any other motor vehicle having a seat or saddle for the rider and designed to travel with no more than three wheels in contact with the ground.
  // Class I - Identification card.
  //****************************************************************************
  EXPORT fn_verify_lic_class(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
    isValidCode	:= CASE(LENGTH(uc_code),
                        1 => IF(Stringlib.StringFilterOut(uc_code[1], 'ABCDMI') = '', TRUE, FALSE),
                        2 => IF(Stringlib.StringFilterOut(uc_code[1], 'ABCD')  = ''  AND 
                                Stringlib.StringFilterOut(uc_code[2], 'M')     = '', TRUE, FALSE),
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END; 
  
  
  //*******************************************************************************
  //fn_verify_height: 	returns true or false based upon validity of driver height											
  //*******************************************************************************
  EXPORT fn_verify_height(STRING height) := FUNCTION
    height_clean := ut.CleanSpacesAndUpper(height);
    
		isValidFeet   := IF(regexfind('[2345678]', height_clean[1]), TRUE, FALSE);
		isValidInches := IF(regexfind('00|01|02|03|04|05|06|07|08|09|10|11', height_clean[2..]), TRUE, FALSE);
    
    RETURN IF(isValidFeet AND isValidInches, 1, 0);
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
	//fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function    
		RETURN IF(LENGTH(ut.CleanSpacesAndUpper(Codes.St2Name(code))) > 0, 1, 0);
  END;


  //****************************************************************************
	//fn_verify_zip:  returns true or false based upon whether or not the zip is 
  //                  valid for a given US address.
	//****************************************************************************
	EXPORT fn_verify_zip(STRING zip, string code) := function    
		RETURN IF(LENGTH(ut.CleanSpacesAndUpper(Codes.St2Name(code))) > 0,
								if(Stringlib.StringFilterOut(zip, '0123456789') = '' , 
										1, 
										0
									 ),
								1
							 );
  END;

END; //End Functions Module