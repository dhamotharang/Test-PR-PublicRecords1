IMPORT ut, Scrubs;

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
  //fn_check_license_type: 	returns true or false based upon the incoming
  //											  code.
  // License Types:
  // CLASSIFIED: ???
  // PERMIT:     Learner's Permit
  // COMMERCIAL: CDL
  // MOTORCYCLE: Motorcycle/Moped License
  // The law provides for three levels of licensing of a person under age 18:
  // GRAD. L-1.: Level 1 restrictions apply to persons with limited learner's permits. The driver: Must have the permit in his or her possession; Must have a supervising driver in front seat (parent, guardian or person who signs application for permit); Must have no other person in front seat; Must for first six months, drive only between the hours of 5:00 a.m. and 9:00 p.m.-- (after first six months, may drive anytime with supervision): Must have all persons in a vehicle use seatbelts or child safety restraints. 
  // GRAD. L-2.: Level 2 restrictions apply to the driver holding a limited provisional license. These restrictions are that the driver:
    // Must have the license in the driver's possession.
    // May drive without a supervising driver when driving to and from work.
    // May drive without a supervising driver when driving to and from an activity of a volunteer fire department, rescue squad, or emergency medical services, if the driver is a member.
    // May drive without a supervising driver for any other purpose from 5:00 a.m. to 9:00 p.m. only.
    // Must drive at any other time with a supervising driver where the supervising driver is seated beside the license holder but need not be the only other front seat passenger.
    // Must have all persons in vehicle use seatbelts or child safety restraints.
    // There may be no more than one passenger under 21 years of age in the vehicle.  This limit does not apply to the license holder's immediate family.
  // GRAD. L-3.:
  //****************************************************************************
  EXPORT fn_check_license_type(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(ut.fn_KeepPrintableChars(code));
		isValidCode := CASE(uc_code,
                        'CLASSIFIED' => TRUE,
                        'PERMIT' => TRUE,
                        'COMMERCIAL' => TRUE,
                        'MOTORCYCLE' => TRUE,
                        'GRAD. L-1.' => TRUE,
                        'GRAD. L-2.' => TRUE,
                        'GRAD. L-3.' => TRUE,
                        // '' => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
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
    

  //*******************************************************************************
  //fn_check_status: 	returns true or false based upon the incoming string.
  //													
  //Checks to see if just words after unprintables stripped out.
  //****************************************************************************
  EXPORT fn_check_status(STRING status) := FUNCTION
    status_clean := ut.CleanSpacesAndUpper(ut.fn_KeepPrintableChars(status));
    
		isValidWords := IF(Stringlib.StringFilterOut(status_clean, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ') = '', TRUE, FALSE);
    
    RETURN IF(status_clean = '' OR isValidWords, 1, 0);
  END;


END; //End Functions Module