IMPORT ut, Scrubs, Codes, MDR, STD;

EXPORT Functions := MODULE




//*********************************************************//
//***************BEGIN GENERAL PURPOSE SECTION*************//
//*********************************************************//




  //****************************************************************************
  //fn_populated_strings: 	returns true if one of the strings is populated
  //****************************************************************************
  EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '') := FUNCTION
    RETURN IF(LENGTH(TRIM(str1 + str2 + str3 + str4 + str5, ALL)) > 0,1,0);
  END;

  //****************************************************************************
  //fn_numeric_opt_size: 	returns true if empty or only populated with a 
  //                       certain size of digits
  //****************************************************************************
  EXPORT fn_numeric_opt_size(STRING nmbr, UNSIGNED1 size) := FUNCTION
    RETURN IF((TRIM(nmbr, ALL) = '' OR TRIM(nmbr, ALL) = '0') OR
              (LENGTH(TRIM(nmbr, ALL)) = size AND Stringlib.StringFilterOut(nmbr, '0123456789') = ''),1,0);
  END;
  
  //****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;

  //****************************************************************************
  //fn_non_empty_alphanum: 	returns true if only populated with alphanumeric
  //****************************************************************************
  EXPORT fn_alphanum_opt_size(STRING nmbr, UNSIGNED1 size) := FUNCTION
    RETURN IF(TRIM(nmbr, ALL) = '' OR LENGTH(TRIM(nmbr, ALL)) = size AND
              Stringlib.StringFilterOut(nmbr, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',1,0);
  END;

  //*******************************************************************************
  //fn_str1_xor_str2: 	returns true or false based upon the values.
  //													
  //Returns true if both are populated or if both are empty
  //*******************************************************************************
  EXPORT fn_str1_xor_str2(STRING str1, STRING str2) := FUNCTION
    clean_str1   := TRIM(str1, ALL);
    clean_str2   := TRIM(str2, ALL);
    RETURN IF((clean_str1 != '' AND clean_str2 != '') OR (clean_str1 = '' AND clean_str2 = ''), 1, 0);   
  END;

  //*******************************************************************************
  //fn_str1_only_if_str2: Returns true if empty or if both populated
  //*******************************************************************************
  EXPORT fn_str1_only_if_str2(STRING str1, STRING str2) := FUNCTION
    clean_str1   := TRIM(str1, ALL);
    clean_str2   := TRIM(str2, ALL);
    RETURN IF((clean_str1 != '' AND clean_str2 != '') OR clean_str1 = '', 1, 0);   
  END;

  //*******************************************************************************
  //fn_str2_only_if_str1: Returns true if empty or if both populated
  //*******************************************************************************
  EXPORT fn_str2_only_if_str1(STRING str2, STRING str1) := FUNCTION
    clean_str1   := TRIM(str1, ALL);
    clean_str2   := TRIM(str2, ALL);
    RETURN IF((clean_str1 != '' AND clean_str2 != '') OR clean_str1 = '', 1, 0);   
  END;

  //****************************************************************************
  //fn_range_numeric: 	returns true if number in range
  //****************************************************************************
  EXPORT fn_range_numeric(STRING nmbr, UNSIGNED6 lbound, UNSIGNED6 ubound) := FUNCTION
    RETURN IF((UNSIGNED6)nmbr >= lbound AND (UNSIGNED6)nmbr <= ubound,1,0);
  END;
  
  
  
  
//*********************************************************//
//***************END GENERAL PURPOSE SECTION***************//
//*********************************************************//
//***************BEGIN ADDRESS SECTION*********************//
//*********************************************************//




  //****************************************************************************
  //fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	//****************************************************************************
  EXPORT fn_verify_state(STRING code) := function    
	  RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
  END;

  //****************************************************************************
  //fn_verify_opt_state:  returns true or false based upon whether or not the
  //                      code is a valid state abbreviation or empty.
  //****************************************************************************
  EXPORT fn_verify_opt_state(STRING code) := function    
	  RETURN IF(TRIM(code,ALL) = '' OR LENGTH(Codes.St2Name(code)) > 0, 1, 0);
  END;

  //****************************************************************************
	 //fn_verify_cart: returns true or false based upon whether or not there is
  //                 an empty or valid cart value.
	 //****************************************************************************
	 EXPORT fn_verify_cart(STRING cart) := function    
		  RETURN IF(LENGTH(TRIM(cart,ALL)) = 0 OR (LENGTH(cart) = 4 AND 
              Stringlib.StringFilterOut(cart[1], 'BCDFGHPRSU') = '' AND
              Stringlib.StringFilterOut(cart[2..], '0123456789') = ''), 1, 0);
  END;

  //****************************************************************************
  //fn_addr_rec_type: 	returns true or false based upon the incoming
  //										        code.
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

  //****************************************************************************
  //fn_geo_coord: 	returns true or false based upon the lat/long value.
  //****************************************************************************
  EXPORT fn_geo_coord(STRING geo) := FUNCTION
    geo_clean := TRIM(geo,ALL);
    
    //Verifying the pattern for coordinates is an optional negative sign (-),
    //followed by at least 1 digit, followed by decimal (.), and ending
    //with at least 1 digit
    RETURN IF(regexfind('^-?\\d+.\\d+$', geo_clean) OR geo_clean = '', 1, 0);
  END;

  //****************************************************************************
	 //fn_verify_phone:  returns true or false based upon whether its a valid
  //                    phone # or empty
	 //****************************************************************************
	 EXPORT fn_verify_phone(STRING phone) := function    
    clean_phone := TRIM(phone, ALL);
    RETURN IF(clean_phone = '' OR ut.CleanPhone(clean_phone) != '', 1, 0);
  END;



//*********************************************************//
//***************END ADDRESS SECTION***********************//
//*********************************************************//
//***************BEGIN DATE/TIME SECTION*******************//
//*********************************************************//




  //*******************************************************************************
  //fn_is_valid_earlier_date: 	returns true or false based upon the incoming date.
  //Returns true if valid early date is earlier or equal to later valid date
  //*******************************************************************************
  EXPORT fn_is_valid_earlier_date(STRING sEarlyDate, STRING sLaterDate) := FUNCTION

    // Commented these lines out since BIP team only wants valid 8 digit dates    
    // norm_sEarlyDate  := IF(LENGTH(sEarlyDate) = 6, sEarlyDate + '01', sEarlyDate);
    // norm_sLaterDate  := IF(LENGTH(sLaterDate) = 6, sLaterDate + '01', sLaterDate);
    
    valid_EarlyDate  := Scrubs.fn_valid_pastDate(TRIM(sEarlyDate, ALL)) > 0;
    valid_LaterDate  := Scrubs.fn_valid_pastDate(TRIM(sLaterDate, ALL)) > 0;
    
    isValidEarlierDate := IF(valid_EarlyDate AND valid_LaterDate,
                             ut.EarliestDate((INTEGER)sEarlyDate, (INTEGER)sLaterDate) = (INTEGER)sEarlyDate,
                             FALSE);
    
    RETURN IF((INTEGER)sEarlyDate != 0 AND (INTEGER)sLaterDate != 0 AND isValidEarlierDate, 1, 0);
  END;

  //***********************************************************************************
  //fn_is_valid_opt_earlier_date: 	returns true or false based upon the incoming date.
  //Returns true if empty/0 or valid early date is earlier or equal to later valid date
  //***********************************************************************************
  EXPORT fn_is_valid_opt_earlier_date(STRING sEarlyDate, STRING sLaterDate) := FUNCTION
    
    // Commented these lines out since BIP team only wants valid 8 digit dates
    // norm_sEarlyDate  := IF(LENGTH(sEarlyDate) = 6, sEarlyDate + '01', sEarlyDate);
    // norm_sLaterDate  := IF(LENGTH(sLaterDate) = 6, sLaterDate + '01', sLaterDate);
    
    valid_EarlyDate  := Scrubs.fn_valid_pastDate(TRIM(sEarlyDate, ALL)) > 0;
    valid_LaterDate  := Scrubs.fn_valid_pastDate(TRIM(sLaterDate, ALL)) > 0;
    
    isValidEarlierDate := IF(valid_EarlyDate AND valid_LaterDate,
                             ut.EarliestDate((INTEGER)sEarlyDate, (INTEGER)sLaterDate) = (INTEGER)sEarlyDate,
                             FALSE);
   
    RETURN IF((INTEGER)sEarlyDate = 0 OR (INTEGER)sLaterDate = 0 OR isValidEarlierDate, 1, 0);
  END;

  //*******************************************************************************
  //fn_past_yyyymmdd: 	returns true or false based upon the incoming date.
  //Returns true if valid past date
  //*******************************************************************************
  EXPORT fn_past_yyyymmdd(STRING sDate) := FUNCTION
    
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_pastDate(clean_date) > 0, FALSE);
    
    RETURN IF(isValidDate, 1, 0);
  END;

  //****************************************************************************
  //fn_dob: 	returns true or false based on validity of dob
  //****************************************************************************
  EXPORT fn_dob(STRING dob) := FUNCTION
    clean_dob  := TRIM(dob, ALL);
    isValidDOB := CASE(LENGTH(clean_dob),
                        8 => Scrubs.fn_valid_pastDate(clean_dob) > 0,
                        4 => Scrubs.valid_date.fn_valid_0468pastDate(clean_dob, TRUE, TRUE) > 0,
                        0 => TRUE,
                        FALSE);
	  RETURN IF(clean_dob = '0' OR isValidDOB, 1, 0);
	END;




//*********************************************************//
//***************END DATE/TIME SECTION*********************//
//*********************************************************//
//***************BEGIN GENERAL SECTION*********************//
//*********************************************************//




  //****************************************************************************
  //fn_source: 	returns true or false based upon the source code
  //****************************************************************************
  EXPORT fn_source(STRING2 code) := FUNCTION
    RETURN IF(MDR.sourceTools.TranslateSource(code) != '?' + code, 1, 0);
  END;

  //****************************************************************************
  //fn_sic: 	returns true or false based on validity of sic code
  //****************************************************************************
  EXPORT fn_sic(STRING s) := FUNCTION
	  RETURN IF(LENGTH(s) in [0,4,8] AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
	END;

  //****************************************************************************
  //fn_naics: 	returns true or false based on validity of naics code
  //****************************************************************************
  EXPORT fn_naics(STRING s) := FUNCTION
	  RETURN IF(LENGTH(s) in [0,6] AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
	END;

  //****************************************************************************
  //fn_url: 	returns true or false based on validity of the url
  //****************************************************************************
  EXPORT fn_url(STRING url) := FUNCTION
    bad_urls := '^n/?a$|^[\\d\\-\\l\\u\\h,;:]+(\\.)?$';
    // url_clean := regexreplace('\\s+', url, '');  //Remove all the whitespace which is invalid in an url
	  // RETURN IF(url_clean = '', 1, IF(STD.System.Util.ResolveHostName(url_clean) != '0.0.0.0', 1, 0));
	  RETURN IF(REGEXFIND(bad_urls, TRIM(url), NOCASE), 0, 1);
	END;

  //****************************************************************************
  //fn_comp_name_status: 	returns true or false based upon the incoming
  //							         status.
  //****************************************************************************
  EXPORT fn_comp_name_status(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		isValidTerm := CASE(uc_term,
                        'ABANDONED'                     => TRUE,
                        'ACTIVE'                        => TRUE,
                        'ACTIVE NAME'                   => TRUE,
                        'ADMINISTRATIVELY DISSOLVED'    => TRUE,
                        'CANCELLED'                     => TRUE,
                        'EFFECTIVE'                     => TRUE,
                        'EFFECTIVENESS PREVENTED'       => TRUE,
                        'ENTITY DELETED'                => TRUE,
                        'ENTITY INACTIVE'               => TRUE,
                        'EXPIRED'                       => TRUE,
                        'EXPIRED NAME RESERVATION'      => TRUE,
                        'INACTIVE'                      => TRUE,
                        'NAME RESERVATION'              => TRUE,
                        'NAME RESERVATION REJECTED'     => TRUE,
                        'PRIOR'                         => TRUE,
                        'REGISTERED'                    => TRUE,
                        'REGISTERED NAME CANCELLATION'  => TRUE,
                        'REGISTERED NAME EXPIRATION'    => TRUE,
                        'REVOKED'                       => TRUE,
                        'VOLUNTARILY TERMINATED'        => TRUE,
                        'WITHDRAWN'                     => TRUE,
                        ''                              => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;

  //****************************************************************************
  //fn_contact: 	returns 1 if is_contact is false or if it is true and
  //              fname and/or lname are populated
  //****************************************************************************
  EXPORT fn_contact(STRING is_contact, STRING fname, STRING lname) := FUNCTION
     RETURN IF((BOOLEAN)is_contact,
               IF(LENGTH(TRIM(fname + lname, ALL)) > 0, 1, 0),
               1);
  END;

  //****************************************************************************
  //fn_contact_did: 	returns 1 if did empty or is numeric and
  //                fname and/or lname are populated
  //****************************************************************************
  EXPORT fn_contact_did(STRING did, STRING fname, STRING lname) := FUNCTION
     RETURN IF((UNSIGNED)did > 0 AND LENGTH(TRIM(fname + lname, ALL)) > 0,
               1,
               IF((UNSIGNED)did = 0 AND TRIM(fname + lname, ALL) = '', 1, 0));
  END;

  //****************************************************************************
  //fn_status: 	returns true or false based upon the incoming status.
  //****************************************************************************
  EXPORT fn_status(STRING status) := FUNCTION
	  uc_status := ut.CleanSpacesAndUpper(status);
    isValidStatus := CASE(uc_status,
                          'ACTIVE'      => TRUE,
                          'CURRENT'     => TRUE,                          
                          'INACTIVE'    => TRUE,
                          'RESIGNED'    => TRUE,
                          'TERMINATED'  => TRUE,
                          ''            => TRUE,
                          FALSE);
    RETURN IF(isValidStatus,1,0);
  END;
  
 
  

//*********************************************************//
//***************END GENERAL SECTION***********************//
//*********************************************************//
    
END; //End Functions Module