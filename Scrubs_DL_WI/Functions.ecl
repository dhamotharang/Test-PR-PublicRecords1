IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE


  //*******************************************************************************
  //fn_check_dl_number: 	returns true or false based upon the incoming string.
  //													
  //dl number and last name are interrelated.  The first letter of the driver's
  //last name corresponds with the 1st letter in the dl number/pid.  However, it
  //was decided not to check for that since last names can change.
  //****************************************************************************
  EXPORT fn_check_dl_number(STRING dlnum) := FUNCTION
    dlnum_clean := ut.CleanSpacesAndUpper(dlnum);
    
		isValidLetter := IF(regexfind('[A-Z]', dlnum_clean[1]), TRUE, FALSE);
		isValidNumber := IF(Stringlib.StringFilterOut(dlnum_clean[2..], '0123456789') = '', TRUE, FALSE);
    
    RETURN IF(dlnum_clean = '' OR (isValidLetter AND isValidNumber), 1, 0);
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
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
  END;


  //****************************************************************************
  //fn_lic_type: 	returns true or false based upon the incoming
  //							code.
  // License Types (ACE Quick Reference for Views and Job-File Products):
  // REGI:  Class D Instruction Permit
  // RGLR:  Regular Commercial or Non-Commercial
  // PROB:  Probationary (points double on second and subsequent violations)
  // SPRR:  Special Restricted License
  // JUVP:  Juvenile Restricted License
  // CYCI:  Cycle Instruction Permit
  // JUVI:  Juvenile Instruction Permit
  // MPDI:  Moped/Motor Bicycle Instruction Permit
  // Not in the book:
  // NON:   Non-commercial???
  // CDLI:  Commercial Drivers License???
  // OCCL:  Occupational License???
  // SPRI:  Special Restricted License???
  //****************************************************************************
  EXPORT fn_lic_type(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'REGI'  => TRUE,
                        'RGLR'  => TRUE,
                        'PROB'  => TRUE,
                        'SPRR'  => TRUE,
                        'JUVP'  => TRUE,
                        'CYCI'  => TRUE,
                        'JUVI'  => TRUE,
                        'MPDI'  => TRUE,
                        'NON'   => TRUE,
                        'CDLI'  => TRUE,
                        'OCCL'  => TRUE,
                        'SPRI'  => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;

  
  //****************************************************************************
  //fn_check_class: 	  returns true or false based upon the incoming
  //										code.
  // License Class (from the 2013 MVR Access and Decoder Digest):     
  // A:  Any combination of commercial motor vehicles weighing over 26,000 pounds.  In addition, the towed unit must weigh more than 10,000 pounds.
  // B:  A single commercial motor vehicle weighing over 26,000 pounds.  In addition, any towed trailers must weigh less than 10,000 pounds.
  // C:  Any vehicles that do not meet the definitions of Classes A and B.  In addition, these vehicles must carry sixteen or more passengers
  //     (including the driver) or transport hazardous materials.  Please note: You cannot drive this class of vehicle without the endorsement
  //     for passengers or hazardous materials.
  // D:  Non-commercial vehicles other than motorcycles; includes regular passenger cars, light trucks, and mopeds
  // M:  Motorcycles
  //****************************************************************************
  EXPORT fn_check_lic_class(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := IF(Stringlib.StringFilterOut(uc_code, 'ABCDM') = '', TRUE, FALSE);	
    
    RETURN IF(uc_code = '' OR isValidCode, 1, 0);
  END;  
 
 
  //****************************************************************************
  //fn_check_endorsements: 	  returns true or false based upon the incoming
  //										      code.
  // License Endorsements (from the 2013 MVR Access and Decoder Digest):     
  // F:  Farm Service Industry CMV
  // H:  Hazardous Materials
  // N:  Tank Vehicles
  // P:  Passengers
  // S:  School Bus
  // T:  Double-/Triple-Trailers
  //****************************************************************************
  EXPORT fn_check_endorsements(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := IF(Stringlib.StringFilterOut(uc_code, 'FHNPST') = '', TRUE, FALSE);	
    
    RETURN IF(uc_code = '' OR isValidCode, 1, 0);
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