IMPORT ut, Scrubs, Codes;

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
  //fn_non_empty_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_non_empty_numeric(STRING nmbr) := FUNCTION
    RETURN IF(LENGTH(TRIM(nmbr, ALL)) > 0 AND Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;

  //****************************************************************************
  //fn_non_empty_alphanum: 	returns true if only populated with alphanumeric
  //****************************************************************************
  EXPORT fn_non_empty_alphanum(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',1,0);
  END;

  //****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
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
	 //fn_verify_zip59:  returns true or false based upon whether or not there is
  //                  a 5-digit or 9-digit value.
	 //****************************************************************************
	 EXPORT fn_verify_zip59(STRING zip59) := function    
		  RETURN IF((LENGTH(zip59) = 5 OR LENGTH(zip59) = 9) AND Stringlib.StringFilterOut(zip59, '0123456789') = '', 1, 0);
  END;

  //****************************************************************************
	 //fn_verify_zip5:  returns true or false based upon whether or not there is
  //                 a 5-digit value.
	 //****************************************************************************
	 EXPORT fn_verify_zip5(STRING zip5) := function    
		  RETURN IF(LENGTH(zip5) = 5 AND Stringlib.StringFilterOut(zip5, '0123456789') = '', 1, 0);
  END;

  //****************************************************************************
	 //fn_verify_zip4:  returns true or false based upon whether or not there is
  //                 a 4-digit value.
	 //****************************************************************************
	 EXPORT fn_verify_zip4(STRING zip4) := function    
		  RETURN IF(LENGTH(zip4) = 4 AND Stringlib.StringFilterOut(zip4, '0123456789') = '', 1, 0);
  END;

  //****************************************************************************
	 //fn_verify_cart:  returns true or false based upon whether or not there is
  //                 a valid cart value.
	 //****************************************************************************
	 EXPORT fn_verify_cart(STRING cart) := function    
		  RETURN IF(LENGTH(cart) = 4 AND 
              Stringlib.StringFilterOut(cart[1], 'BCHR') = '' AND
              Stringlib.StringFilterOut(cart[2..], '0123456789') = '', 1, 0);
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
  //fn_nyc_borough: 	returns true or false based upon whether the term is
  //							         a valid nyc borough.
  //****************************************************************************
  EXPORT fn_nyc_borough(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                       'MANHATTAN'            => TRUE,
                       'QUEENS'               => TRUE,
                       'BROOKLYN'             => TRUE,
                       'BRONX'                => TRUE,
                       ''                     => TRUE,
                       FALSE);
    RETURN IF(isValidTerm,1,0);
  END;
  


//*********************************************************//
//***************END ADDRESS SECTION***********************//
//*********************************************************//
//***************BEGIN DATE/TIME SECTION*******************//
//*********************************************************//



  //*******************************************************************************
  //fn_orig_filing_date: 	returns true or false based upon the incoming date.
  //													
  //Returns true if valid past date
  //*******************************************************************************
  EXPORT fn_orig_filing_date(STRING sDate) := FUNCTION
    
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(clean_date = '19000000', TRUE, Scrubs.fn_valid_pastDate(clean_date) > 0);
    
    RETURN IF(clean_date != '' AND isValidDate, 1, 0);
  END;

  //*******************************************************************************
  //fn_date1_xor_date2: 	returns true or false based upon the incoming date.
  //													
  //Returns true if valid past date or other date exists
  //*******************************************************************************
  EXPORT fn_date1_xor_date2(STRING sDate, STRING sDate2) := FUNCTION
    
    clean_date   := TRIM(sDate, ALL);
    clean_date2  := TRIM(sDate2, ALL);
    isValidDate  := IF(clean_date = '', clean_date2 != '', Scrubs.fn_valid_pastDate(clean_date) > 0);
    
    RETURN IF(isValidDate, 1, 0);
  END;

  //*******************************************************************************
  //fn_past_yyyymmdd: 	returns true or false based upon the incoming date.
  //													
  //Returns true if valid past date
  //*******************************************************************************
  EXPORT fn_past_yyyymmdd(STRING sDate) := FUNCTION
    
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_pastDate(clean_date) > 0, FALSE);
    
    RETURN IF(isValidDate, 1, 0);
  END;

  //*******************************************************************************
  //fn_optional_past_yyyymmdd: 	returns true or false based upon the incoming date.
  //													
  //Returns true if valid past date or empty
  //*******************************************************************************
  EXPORT fn_optional_past_yyyymmdd(STRING sDate) := FUNCTION
    
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_pastDate(clean_date) > 0, FALSE);
    
    RETURN IF(clean_date = '' OR isValidDate, 1, 0);
  END;

  //*******************************************************************************
  //fn_general_yyyymmdd: 	returns true or false based upon the incoming date.
  //													
  //Returns true if valid date
  //*******************************************************************************
  EXPORT fn_general_yyyymmdd(STRING sDate) := FUNCTION
    
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_GeneralDate(clean_date) > 0, FALSE);
    
    RETURN IF(isValidDate, 1, 0);
  END;

  //*******************************************************************************
  //fn_expiration_date: 	returns true or false based upon the incoming date.
  //													
  //Returns true if valid date
  //*******************************************************************************
  EXPORT fn_expiration_date(STRING sDate) := FUNCTION
    
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(clean_date = '99991231' OR clean_date = '99999999', TRUE, Scrubs.fn_valid_GeneralDate(clean_date) > 0);
    
    RETURN IF(clean_date != '' AND isValidDate, 1, 0);
  END;

  //*******************************************************************************
  //fn_past_yyyymm: 	returns true or false based upon the incoming date.
  //													
  //Returns true if valid past date
  //*******************************************************************************
  EXPORT fn_past_yyyymm(STRING sDate) := FUNCTION
    
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 6, Scrubs.valid_date.fn_valid_0468pastDate(clean_date, FALSE, TRUE) > 0, FALSE);
    
    RETURN IF(clean_date != '' AND isValidDate, 1, 0);
  END;

  //*******************************************************************************
  //fn_check_year: 	returns true or false based upon the incoming year.
  //													
  //Returns true if blank, 0000, or a valid past year
  //****************************************************************************
  EXPORT fn_check_year(STRING year) := FUNCTION
    
    clean_year := TRIM(year, ALL);
    isValidYear := CASE(LENGTH(clean_year),
                        4 => IF(clean_year = '0000', TRUE, Scrubs.valid_date.fn_valid_0468pastDate(clean_year, TRUE, TRUE) > 0),
                        0 => TRUE,
                        FALSE);
    
    RETURN IF(isValidYear, 1, 0);
  END;

  //*******************************************************************************
  //fn_check_time: 	returns true or false based upon the incoming time.
  //													
  //Returns true if valid military time
  //****************************************************************************
  EXPORT fn_check_time(STRING time) := FUNCTION
    
    clean_time := TRIM(time, ALL);
    isValidTime := CASE(LENGTH(clean_time),
                        4 => IF((UNSIGNED2)clean_time[1..2] BETWEEN 0 AND 24 AND (UNSIGNED2)clean_time[3..4] BETWEEN 0 AND 59, TRUE, FALSE),
                        0 => TRUE,
                        FALSE);
    
    RETURN IF(isValidTime, 1, 0);
  END;


//*********************************************************//
//***************END DATE/TIME SECTION*********************//
//*********************************************************//
//***************BEGIN ID SECTION**************************//
//*********************************************************//


  //*************************************************************************************
  //fn_state_tmsid_rmsid: 	returns true or false based upon the incoming sid and state.
  //*************************************************************************************
  EXPORT fn_state_tmsid_rmsid(STRING sid, STRING state) := FUNCTION
    sid_clean := ut.CleanSpacesAndUpper(sid);
    
		  isValidState    := IF(regexfind(state, sid_clean[1..LENGTH(state)]), TRUE, FALSE);
		  isValidNumber   := IF(Stringlib.StringFilterOut(sid_clean[LENGTH(state) + 1..], '0123456789') = '', TRUE, FALSE);
 		 isValidAlphaNum := IF(Stringlib.StringFilterOut(sid_clean[(LENGTH(state) + 1)..(LENGTH(state) + 2)], '0123456789') = '' AND
                          Stringlib.StringFilterOut(sid_clean[(LENGTH(state) + 3)..(LENGTH(state) + 4)], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '' AND
                          Stringlib.StringFilterOut(sid_clean[(LENGTH(state) + 5)..], '0123456789') = '', TRUE, FALSE);
   
    RETURN IF(sid_clean = '' OR (isValidState AND (isValidNumber OR isValidAlphaNum)), 1, 0);
  END;

  //****************************************************************************
  //fn_dnb_tmsid: 	returns true or false based upon the incoming tmsid.
  //****************************************************************************
  EXPORT fn_dnb_tmsid(STRING tmsid) := FUNCTION
    tmsid_clean := ut.CleanSpacesAndUpper(tmsid);
    
		  isValidLetter := IF(regexfind('DNB', tmsid_clean[1..3]), TRUE, FALSE);
		  isValidNumber := IF(Stringlib.StringFilterOut(tmsid_clean[4..], '0123456789-ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '', TRUE, FALSE);
    
    RETURN IF(isValidLetter AND isValidNumber, 1, 0);
  END;

  //****************************************************************************
  //fn_dnb_rmsid: 	returns true or false based upon the incoming rmsid.
  //****************************************************************************
  EXPORT fn_dnb_rmsid(STRING rmsid) := FUNCTION
    rmsid_clean := ut.CleanSpacesAndUpper(rmsid);
    
		  isValidDID  := IF(regexfind('\\*\\*D', rmsid_clean[1..3]) AND Stringlib.StringFilterOut(rmsid_clean[4..], '0123456789') = '', TRUE, FALSE);
		  isValidNum  := IF(Stringlib.StringFilterOut(rmsid_clean, '0123456789') = '', TRUE, FALSE);
    
    RETURN IF(rmsid_clean != '' AND (isValidDID OR isValidNum), 1, 0);
  END;

  //****************************************************************************
  //fn_ca_tmsid: 	returns true or false based upon the incoming tmsid.
  //****************************************************************************
  EXPORT fn_ca_tmsid(STRING tmsid) := FUNCTION
    tmsid_clean := ut.CleanSpacesAndUpper(tmsid);
    
		  isValidLetter := IF(regexfind('CA', tmsid_clean[1..2]), TRUE, FALSE);
		  isValidNumber := IF(Stringlib.StringFilterOut(tmsid_clean[3..], '0123456789') = '', TRUE, FALSE);
    
    RETURN IF(tmsid_clean = '' OR (isValidLetter AND isValidNumber), 1, 0);
  END;

  //****************************************************************************
  //fn_ca_rmsid: 	returns true or false based upon the incoming rmsid.
  //****************************************************************************
  EXPORT fn_ca_rmsid(STRING rmsid) := FUNCTION
    rmsid_clean := ut.CleanSpacesAndUpper(rmsid);
    
		  isValidLetters  := IF(regexfind('CA', rmsid_clean[1..2]), TRUE, FALSE);
		  isValidAlphaNum := IF(Stringlib.StringFilterOut(rmsid_clean[3..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789') = '', TRUE, FALSE);
    
    RETURN IF(rmsid_clean = '' OR (isValidLetters AND isValidAlphaNum), 1, 0);
  END;


//*********************************************************//
//***************END ID SECTION****************************//
//*********************************************************//
//***************BEGIN FILING_NUMBER SECTION***************//
//*********************************************************//



  //****************************************************************************
  //fn_nyc_filing_number: 	returns true if only populated with 13 numbers
  //****************************************************************************
  EXPORT fn_nyc_filing_number(STRING nmbr) := FUNCTION
    RETURN IF(LENGTH(TRIM(nmbr, ALL)) = 13 AND Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;



//*********************************************************//
//***************END FILING_NUMBER SECTION*****************//
//*********************************************************//
//***************BEGIN FILING_TYPE SECTION*****************//
//*********************************************************//


  //****************************************************************************
  //fn_dnb_filing_type: 	returns true or false based upon the incoming
  //							        type.
  //****************************************************************************
  EXPORT fn_dnb_filing_type(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		isValidTerm := CASE(uc_term,
                        'AMENDMENT'        => TRUE,
                        'ASSIGNMENT'       => TRUE,
                        'CONTINUATION'     => TRUE,
                        'INITIAL FILING'   => TRUE,
                        'PARTIAL RELEASE'  => TRUE,
                        'RELEASE'          => TRUE,
                        'SUBORDINATION'    => TRUE,
                        'TERMINATION'      => TRUE,
                        // ''                 => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;

  //****************************************************************************
  //fn_ca_orig_filing_type: 	returns true or false based upon the incoming
  //							            type.
  //****************************************************************************
  EXPORT fn_ca_orig_filing_type(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                        'FINANCING STATEMENT'                     => TRUE,
                        'STATE TAX LIEN'                          => TRUE,
                        'FEDERAL TAX LIEN'                        => TRUE,
                        'JUDGMENT LIEN'                           => TRUE,
                        'JUDGEMENT LIEN'                          => TRUE,
                        'TRANSMITTING UTILITY'                    => TRUE,
                        'PUBLIC FINANCE TRANSACTION'              => TRUE,
                        'MANUFACTURED HOME TRANSACTION'           => TRUE,
                        'ATTACHMENT LIEN'                         => TRUE,
                        'FEDERAL ESTATE TAX LIEN'                 => TRUE,
                        'DAIRY CATTLE LIEN'                       => TRUE,
                        'PENSION BENEFIT LIEN'                    => TRUE,
                        'CHEMICAL SEED LIEN'                      => TRUE,
                        'LIVESTOCK LIEN'                          => TRUE,
                        'FISH/POULTRY LIEN'                       => TRUE,
                        // ''                                        => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;

  //****************************************************************************
  //fn_ca_filing_type: 	returns true or false based upon the incoming
  //							      type.
  //****************************************************************************
  EXPORT fn_ca_filing_type(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                        'AMENDMENT'                             => TRUE,
                        'ASSIGNMENT'                            => TRUE,
                        'CONTINUATION'                          => TRUE,
                        'CORRECTION STATEMENT'                  => TRUE,
                        'COURT ORDER'                           => TRUE,
                        'COURT ORDER NO CHANGE'                 => TRUE,
                        'ERRONEOUS TERMINATION'                 => TRUE,
                        'FILING OFFICER STATEMENT'              => TRUE,
                        'FULL MASTER AMENDMENT'                 => TRUE,
                        'FULL MASTER ASSIGNMENT'                => TRUE,
                        'TERMINATION'                           => TRUE,
                        'UCC3 AMENDMENT'                        => TRUE,
                        'UCC3 ASSIGNMENT'                       => TRUE,
                        'UCC3 CONTINUATION'                     => TRUE,
                        'UCC3 CORRECTION STATEMENT'             => TRUE,
                        'UCC3 COURT ORDER'                      => TRUE,
                        'UCC3 COURT ORDER NO CHANGE'            => TRUE,
                        'UCC3 ERRONEOUS TERMINATION'            => TRUE,
                        'UCC3 FILING OFFICER STATEMENT'         => TRUE,
                        'UCC3 FULL MASTER AMENDMENT'            => TRUE,
                        'UCC3 FULL MASTER ASSIGNMENT'           => TRUE,
                        'UCC3 TERMINATION'                      => TRUE,
                        // ''                                      => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;

  //****************************************************************************
  //fn_il_orig_filing_type: 	returns true or false based upon the incoming
  //							                 type.
  //****************************************************************************
  EXPORT fn_il_orig_filing_type(STRING term) := FUNCTION
    RETURN IF(ut.CleanSpacesAndUpper(term) = 'UCC-1 FINANCING STATEMENT', 1, 0);
  END;

  //****************************************************************************
  //fn_il_filing_type: 	returns true or false based upon the incoming
  //							             type.
  //****************************************************************************
  EXPORT fn_il_filing_type(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                        'CONTINUATION'                           => TRUE,
                        'TERMINATION'                            => TRUE,
                        'AMENDMENT TO A SECURED PARTY'           => TRUE,
                        'ASSIGNMENT TO A SECURED PARTY'          => TRUE,
                        'DEBTOR AMENDMENT (FORMAT 01)'           => TRUE,
                        'MISC AMENDMENT'                         => TRUE,
                        'PARTIAL RELEASE'                        => TRUE,
                        'FILING OFFICER STATEMENT'               => TRUE,
                        'SUBORDINATION'                          => TRUE,
                        'CORRECTION STATEMENT'                   => TRUE,
                        'DEBTOR TERMED'                          => TRUE,
                        // ''                                      => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;
   
  //****************************************************************************
  //fn_ma_orig_filing_type: 	returns true or false based upon the incoming
  //							                 type.
  //****************************************************************************
  EXPORT fn_ma_orig_filing_type(STRING term) := FUNCTION
    RETURN IF(ut.CleanSpacesAndUpper(term) = 'UCC-1 ORIGINAL', 1, 0);
  END;

  //****************************************************************************
  //fn_ma_filing_type: 	returns true or false based upon the incoming
  //							             type.
  //****************************************************************************
  EXPORT fn_ma_filing_type(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                        'UCC-3 TERMINATION'                   => TRUE,
                        'CONTINUATION'                        => TRUE,
                        'AMENDMENT'                           => TRUE,
                        'ASSIGNMENT'                          => TRUE,
                        'PARTIAL RELEASE'                     => TRUE,
                        'SUBORDINATION'                       => TRUE,
                        'UCC-5 CORRECTION'                    => TRUE,
                        'UCC-5 INTERNAL CORRECTION'           => TRUE,
                        'ENVIRONMENTAL LIEN'                  => TRUE,
                        'TERMINATION DBA'                     => TRUE,
                        'UCC DBA'                             => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;
  
  //****************************************************************************
  //fn_nyc_orig_filing_type: 	returns true or false based upon the incoming
  //							                  type.
  //****************************************************************************
  EXPORT fn_nyc_orig_filing_type(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                       'INITIAL COOP UCC1'            => TRUE,
                       'INITIAL UCC1'                 => TRUE,
                       ''                             => TRUE,
                       FALSE);
    RETURN IF(isValidTerm,1,0);
  END;
  
  //****************************************************************************
  //fn_nyc_filing_type: 	returns true or false based upon the incoming
  //							              type.
  //****************************************************************************
  EXPORT fn_nyc_filing_type(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                        'UCC3 TERMINATION'                         => TRUE,
                        'UCC3 ASSIGNMENT'                          => TRUE,
                        'UCC3 AMENDMENT'                           => TRUE,
                        'UCC3 CONTINUATION'                        => TRUE,
                        'UCC3 RELEASE'                             => TRUE,
                        'UCC3 SUBORDINATION'                       => TRUE,
                        'UCC3 PARTIAL ASSIGNMENT'                  => TRUE,
                        'UCC3 BANKRUPTCY'                          => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;
  

  
//*********************************************************//
//***************END FILING_TYPE SECTION*******************//
//*********************************************************//
//***************BEGIN STATUS_TYPE SECTION*****************//
//*********************************************************//


  //****************************************************************************
  //fn_status_type: 	returns true or false based upon the incoming
  //							    type.
  //****************************************************************************
  EXPORT fn_status_type(STRING status) := FUNCTION
	  uc_status := ut.CleanSpacesAndUpper(status);
		 isValidStatus := CASE(uc_status,
                          'ACTIVE'    => TRUE,
                          'DELETED'   => TRUE,
                          'EXPUNGED'  => TRUE,
                          'LAPSED'    => TRUE,
                          ''          => TRUE,
                          FALSE);
    RETURN IF(isValidStatus,1,0);
  END;

  //****************************************************************************
  //fn_ma_status_type: 	returns true or false based upon the incoming
  //							             type.
  //****************************************************************************
  EXPORT fn_ma_status_type(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                        'ACTIVE'                   => TRUE,
                        'TERMINATED'               => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;
  
  

//*********************************************************//
//***************END STATUS_TYPE SECTION*******************//
//*********************************************************//
//***************BEGIN GENERAL SECTION*********************//
//*********************************************************//



  //****************************************************************************
  //fn_contract_type: 	returns true or false based upon the incoming
  //							      type.
  //****************************************************************************
  EXPORT fn_contract_type(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                        'SALE'       => TRUE,
                        'LEASE'      => TRUE,
                        'RENTAL'     => TRUE,
                        'REFINANCE'  => TRUE,
                        'WHOLESALE'  => TRUE,
                        'OTHER'      => TRUE,
                        'UNKNOWN'    => TRUE,
                        ''           => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;

  //****************************************************************************
	 //fn_duns:  returns true or false based upon whether or not there is
  //          a 9-digit value.
	 //****************************************************************************
	 EXPORT fn_duns(STRING duns) := function    
		  RETURN IF(LENGTH(duns) = 9 AND Stringlib.StringFilterOut(duns, '0123456789') = '', 1, 0);
  END;

  //****************************************************************************
	 //fn_collateral_count:  returns true or false based upon whether or not there is
  //                      a empty, decimal, or hexadecimal value.
	 //****************************************************************************
	 EXPORT fn_collateral_count(STRING collateral) := function    
		  RETURN IF((collateral = '' OR LENGTH(collateral) = 5) AND
              Stringlib.StringFilterOut(collateral, 'ABCDEF0123456789') = '', 1, 0);
  END;

  //****************************************************************************
  //fn_party_type: 	returns true or false based upon the incoming
  //							  code.
  //****************************************************************************
  EXPORT fn_party_type(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		 isValidCode := CASE(uc_code,
                        'A'    => TRUE,
                        'D'    => TRUE,
                        'S'    => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;

  //****************************************************************************
  //fn_filing_status: 	returns true or false based upon the incoming
  //							      status.
  //****************************************************************************
  EXPORT fn_filing_status(STRING status) := FUNCTION
	  uc_status := ut.CleanSpacesAndUpper(status);
		 isValidStatus := CASE(uc_status,
                          'A'    => TRUE,
                          'D'    => TRUE,
                          'E'    => TRUE,
                          'L'    => TRUE,
                          ''    => TRUE,
                          FALSE);
    RETURN IF(isValidStatus,1,0);
  END;

  //****************************************************************************
  //fn_company_xor_person: 	returns true if only a company name or only a person 
  //****************************************************************************
  EXPORT fn_company_xor_person(STRING company, STRING fname, STRING mname, STRING lname) := FUNCTION
    company_populated := LENGTH(TRIM(company, ALL)) > 0;
    person_populated := fn_populated_strings(fname, mname, lname) > 0;
    RETURN IF((company_populated OR person_populated) AND NOT (company_populated AND person_populated),1,0);
  END;

 	//********************************************************************
	 //fn_country: Verifies country code against ISO 3166-1 alpha-3 codes.
	 //********************************************************************	
	 EXPORT fn_country(STRING country_code) := FUNCTION
		  cntry_code := ut.CleanSpacesAndUpper(country_code);
		  country    := case(cntry_code,
                       'ABW'=>'ARUBA',
                       'AFG'=>'AFGHANISTAN',
                       'AGO'=>'ANGOLA',
                       'AIA'=>'ANGUILLA',
                       'ALA'=>'ALAND ISLANDS',
                       'ALB'=>'ALBANIA',
                       'AND'=>'ANDORRA',
                       'ANT'=>'NETHERLANDS ANTILLES',
                       'ARE'=>'UNITED ARAB EMIRATES',
                       'ARG'=>'ARGENTINA',
                       'ARM'=>'ARMENIA',
                       'ASM'=>'AMERICAN SAMOA',
                       'ATA'=>'ANTARCTICA',
                       'ATF'=>'FRENCH SOUTHERN TERRITORIES',
                       'ATG'=>'ANTIGUA AND BARBUDA',
                       'AUS'=>'AUSTRALIA',
                       'AUT'=>'AUSTRIA',
                       'AZE'=>'AZERBAIJAN',
                       'BDI'=>'BURUNDI',
                       'BEL'=>'BELGIUM',
                       'BEN'=>'BENIN',
                       'BFA'=>'BURKINA FASO',
                       'BGD'=>'BANGLADESH',
                       'BGR'=>'BULGARIA',
                       'BHR'=>'BAHRAIN',
                       'BHS'=>'BAHAMAS',
                       'BIH'=>'BOSNIA AND HERZEGOVINA',
                       'BLM'=>'SAINT-BARTHELEMY',
                       'BLR'=>'BELARUS',
                       'BLZ'=>'BELIZE',
                       'BMU'=>'BERMUDA',
                       'BOL'=>'BOLIVIA',
                       'BRA'=>'BRAZIL',
                       'BRB'=>'BARBADOS',
                       'BRN'=>'BRUNEI DARUSSALAM',
                       'BTN'=>'BHUTAN',
                       'BVT'=>'BOUVET ISLAND',
                       'BWA'=>'BOTSWANA',
                       'CAF'=>'CENTRAL AFRICAN REPUBLIC',
                       'CAN'=>'CANADA',
                       'CCK'=>'COCOS (KEELING) ISLANDS',
                       'CHE'=>'SWITZERLAND',
                       'CHL'=>'CHILE',
                       'CHN'=>'CHINA',
                       'CIV'=>'CÃ”TE D`IVOIRE',
                       'CMR'=>'CAMEROON',
                       'COD'=>'CONGO (KINSHASA)',
                       'COG'=>'CONGO (BRAZZAVILLE)',
                       'COK'=>'COOK ISLANDS',
                       'COL'=>'COLOMBIA',
                       'COM'=>'COMOROS',
                       'CPV'=>'CAPE VERDE',
                       'CRI'=>'COSTA RICA',
                       'CUB'=>'CUBA',
                       'CXR'=>'CHRISTMAS ISLAND',
                       'CYM'=>'CAYMAN ISLANDS',
                       'CYP'=>'CYPRUS',
                       'CZE'=>'CZECH REPUBLIC',
                       'DEU'=>'GERMANY',
                       'DJI'=>'DJIBOUTI',
                       'DMA'=>'DOMINICA',
                       'DNK'=>'DENMARK',
                       'DOM'=>'DOMINICAN REPUBLIC',
                       'DZA'=>'ALGERIA',
                       'ECU'=>'ECUADOR',
                       'EGY'=>'EGYPT',
                       'ERI'=>'ERITREA',
                       'ESH'=>'WESTERN SAHARA',
                       'ESP'=>'SPAIN',
                       'EST'=>'ESTONIA',
                       'ETH'=>'ETHIOPIA',
                       'FIN'=>'FINLAND',
                       'FJI'=>'FIJI',
                       'FLK'=>'FALKLAND ISLANDS (MALVINAS)',
                       'FRA'=>'FRANCE',
                       'FRO'=>'FAROE ISLANDS',
                       'FSM'=>'MICRONESIA',
                       'GAB'=>'GABON',
                       'GBR'=>'UNITED KINGDOM',
                       'GEO'=>'GEORGIA',
                       'GGY'=>'GUERNSEY',
                       'GHA'=>'GHANA',
                       'GIB'=>'GIBRALTAR',
                       'GIN'=>'GUINEA',
                       'GLP'=>'GUADELOUPE',
                       'GMB'=>'GAMBIA',
                       'GNB'=>'GUINEA-BISSAU',
                       'GNQ'=>'EQUATORIAL GUINEA',
                       'GRC'=>'GREECE',
                       'GRD'=>'GRENADA',
                       'GRL'=>'GREENLAND',
                       'GTM'=>'GUATEMALA',
                       'GUF'=>'FRENCH GUIANA',
                       'GUM'=>'GUAM',
                       'GUY'=>'GUYANA',
                       'HKG'=>'HONG KONG',
                       'HMD'=>'HEARD ISLAND AND MCDONALD ISLANDS',
                       'HND'=>'HONDURAS',
                       'HRV'=>'CROATIA',
                       'HTI'=>'HAITI',
                       'HUN'=>'HUNGARY',
                       'IDN'=>'INDONESIA',
                       'IMN'=>'ISLE OF MAN',
                       'IND'=>'INDIA',
                       'IOT'=>'BRITISH INDIAN OCEAN TERRITORY',
                       'IRL'=>'IRELAND',
                       'IRN'=>'IRAN',
                       'IRQ'=>'IRAQ',
                       'ISL'=>'ICELAND',
                       'ISR'=>'ISRAEL',
                       'ITA'=>'ITALY',
                       'JAM'=>'JAMAICA',
                       'JEY'=>'JERSEY',
                       'JOR'=>'JORDAN',
                       'JPN'=>'JAPAN',
                       'KAZ'=>'KAZAKHSTAN',
                       'KEN'=>'KENYA',
                       'KGZ'=>'KYRGYZSTAN',
                       'KHM'=>'CAMBODIA',
                       'KIR'=>'KIRIBATI',
                       'KNA'=>'SAINT KITTS AND NEVIS',
                       'KOR'=>'SOUTH KOREA',
                       'KWT'=>'KUWAIT',
                       'LAO'=>'LAO PEOPLE`S DEMOCRATIC REPUBLIC',
                       'LBN'=>'LEBANON',
                       'LBR'=>'LIBERIA',
                       'LBY'=>'LIBYAN ARAB JAMAHIRIYA',
                       'LCA'=>'SAINT LUCIA',
                       'LIE'=>'LIECHTENSTEIN',
                       'LKA'=>'SRI LANKA',
                       'LSO'=>'LESOTHO',
                       'LTU'=>'LITHUANIA',
                       'LUX'=>'LUXEMBOURG',
                       'LVA'=>'LATVIA',
                       'MAC'=>'MACAO',
                       'MAF'=>'SAINT-MARTIN',
                       'MAR'=>'MOROCCO',
                       'MCO'=>'MONACO',
                       'MDA'=>'MOLDOVA',
                       'MDG'=>'MADAGASCAR',
                       'MDV'=>'MALDIVES',
                       'MEX'=>'MEXICO',
                       'MHL'=>'MARSHALL ISLANDS',
                       'MKD'=>'MACEDONIA',
                       'MLI'=>'MALI',
                       'MLT'=>'MALTA',
                       'MMR'=>'MYANMAR',
                       'MNE'=>'MONTENEGRO',
                       'MNG'=>'MONGOLIA',
                       'MNP'=>'NORTHERN MARIANA ISLANDS',
                       'MOZ'=>'MOZAMBIQUE',
                       'MRT'=>'MAURITANIA',
                       'MSR'=>'MONTSERRAT',
                       'MTQ'=>'MARTINIQUE',
                       'MUS'=>'MAURITIUS',
                       'MWI'=>'MALAWI',
                       'MYS'=>'MALAYSIA',
                       'MYT'=>'MAYOTTE',
                       'NAM'=>'NAMIBIA',
                       'NCL'=>'NEW CALEDONIA',
                       'NER'=>'NIGER',
                       'NFK'=>'NORFOLK ISLAND',
                       'NGA'=>'NIGERIA',
                       'NIC'=>'NICARAGUA',
                       'NIU'=>'NIUE',
                       'NLD'=>'NETHERLANDS',
                       'NOR'=>'NORWAY',
                       'NPL'=>'NEPAL',
                       'NRU'=>'NAURU',
                       'NZL'=>'NEW ZEALAND',
                       'OMN'=>'OMAN',
                       'PAK'=>'PAKISTAN',
                       'PAN'=>'PANAMA',
                       'PCN'=>'PITCAIRN',
                       'PER'=>'PERU',
                       'PHL'=>'PHILIPPINES',
                       'PLW'=>'PALAU',
                       'PNG'=>'PAPUA NEW GUINEA',
                       'POL'=>'POLAND',
                       'PRI'=>'PUERTO RICO',
                       'PRK'=>'NORTH KOREA',
                       'PRT'=>'PORTUGAL',
                       'PRY'=>'PARAGUAY',
                       'PSE'=>'PALESTINIAN TERRITORY',
                       'PYF'=>'FRENCH POLYNESIA',
                       'QAT'=>'QATAR',
                       'REU'=>'REUNION',
                       'ROU'=>'ROMANIA',
                       'RUS'=>'RUSSIAN FEDERATION',
                       'RWA'=>'RWANDA',
                       'SAU'=>'SAUDI ARABIA',
                       'SDN'=>'SUDAN',
                       'SEN'=>'SENEGAL',
                       'SGP'=>'SINGAPORE',
                       'SGS'=>'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS',
                       'SHN'=>'SAINT HELENA',
                       'SJM'=>'SVALBARD AND JAN MAYEN',
                       'SLB'=>'SOLOMON ISLANDS',
                       'SLE'=>'SIERRA LEONE',
                       'SLV'=>'EL SALVADOR',
                       'SMR'=>'SAN MARINO',
                       'SOM'=>'SOMALIA',
                       'SPM'=>'SAINT PIERRE AND MIQUELON',
                       'SRB'=>'SERBIA',
                       'SSD'=>'SOUTH SUDAN',
                       'STP'=>'SAO TOME AND PRINCIPE',
                       'SUR'=>'SURINAME',
                       'SVK'=>'SLOVAKIA',
                       'SVN'=>'SLOVENIA',
                       'SWE'=>'SWEDEN',
                       'SWZ'=>'SWAZILAND',
                       'SYC'=>'SEYCHELLES',
                       'SYR'=>'SYRIAN ARAB REPUBLIC',
                       'TCA'=>'TURKS AND CAICOS ISLANDS',
                       'TCD'=>'CHAD',
                       'TGO'=>'TOGO',
                       'THA'=>'THAILAND',
                       'TJK'=>'TAJIKISTAN',
                       'TKL'=>'TOKELAU',
                       'TKM'=>'TURKMENISTAN',
                       'TLS'=>'TIMOR-LESTE',
                       'TON'=>'TONGA',
                       'TTO'=>'TRINIDAD AND TOBAGO',
                       'TUN'=>'TUNISIA',
                       'TUR'=>'TURKEY',
                       'TUV'=>'TUVALU',
                       'TWN'=>'TAIWAN',
                       'TZA'=>'TANZANIA',
                       'UGA'=>'UGANDA',
                       'UKR'=>'UKRAINE',
                       'UMI'=>'UNITED STATES MINOR OUTLYING ISLANDS',
                       'URY'=>'URUGUAY',
                       'USA'=>'UNITED STATES OF AMERICA',
                       'US' =>'UNITED STATES OF AMERICA',
                       'UZB'=>'UZBEKISTAN',
                       'VAT'=>'HOLY SEE (VATICAN CITY STATE)',
                       'VCT'=>'SAINT VINCENT AND THE GRENADINES',
                       'VEN'=>'VENEZUELA',
                       'VGB'=>'BRITISH VIRGIN ISLANDS',
                       'VIR'=>'VIRGIN ISLANDS',
                       'VNM'=>'VIET NAM',
                       'VUT'=>'VANUATU',
                       'WLF'=>'WALLIS AND FUTUNA',
                       'WSM'=>'SAMOA',
                       'YEM'=>'YEMEN',
                       'ZAF'=>'SOUTH AFRICA',
                       'ZMB'=>'ZAMBIA',
                       'ZWE'=>'ZIMBABWE',
                       ''   =>'EMPTY',
                       '');
    RETURN IF(country != '',1,0);
  END;
              
 	//********************************************************************
	 //fn_country2: Verifies country code against ISO 3166-1 alpha-2 codes.
	 //********************************************************************	
	 EXPORT fn_country2(STRING country_code) := FUNCTION
		  cntry_code := ut.CleanSpacesAndUpper(TRIM(country_code,ALL));
		  country    := case(cntry_code,
                       'AD'=>'Andorra',
                       'AE'=>'United Arab Emirates (the)',
                       'AF'=>'Afghanistan',
                       'AG'=>'Antigua and Barbuda',
                       'AI'=>'Anguilla',
                       'AL'=>'Albania',
                       'AM'=>'Armenia',
                       'AO'=>'Angola',
                       'AQ'=>'Antarctica',
                       'AR'=>'Argentina',
                       'AS'=>'American Samoa',
                       'AT'=>'Austria',
                       'AU'=>'Australia',
                       'AW'=>'Aruba',
                       'AX'=>'Ã…land Islands',
                       'AZ'=>'Azerbaijan',
                       'BA'=>'Bosnia and Herzegovina',
                       'BB'=>'Barbados',
                       'BD'=>'Bangladesh',
                       'BE'=>'Belgium',
                       'BF'=>'Burkina Faso',
                       'BG'=>'Bulgaria',
                       'BH'=>'Bahrain',
                       'BI'=>'Burundi',
                       'BJ'=>'Benin',
                       'BL'=>'Saint BarthÃ©lemy',
                       'BM'=>'Bermuda',
                       'BN'=>'Brunei Darussalam',
                       'BO'=>'Bolivia (Plurinational State of)',
                       'BQ'=>'Bonaire, Sint Eustatius and Saba',
                       'BR'=>'Brazil',
                       'BS'=>'Bahamas (the)',
                       'BT'=>'Bhutan',
                       'BV'=>'Bouvet Island',
                       'BW'=>'Botswana',
                       'BY'=>'Belarus',
                       'BZ'=>'Belize',
                       'CA'=>'Canada',
                       'CC'=>'Cocos (Keeling) Islands (the)',
                       'CD'=>'Congo (the Democratic Republic of the)',
                       'CF'=>'Central African Republic (the)',
                       'CG'=>'Congo (the)',
                       'CH'=>'Switzerland',
                       'CI'=>'CÃ´te dIvoire',
                       'CK'=>'Cook Islands (the)',
                       'CL'=>'Chile',
                       'CM'=>'Cameroon',
                       'CN'=>'China',
                       'CO'=>'Colombia',
                       'CR'=>'Costa Rica',
                       'CU'=>'Cuba',
                       'CV'=>'Cabo Verde',
                       'CW'=>'CuraÃ§ao',
                       'CX'=>'Christmas Island',
                       'CY'=>'Cyprus',
                       'CZ'=>'Czechia',
                       'DE'=>'Germany',
                       'DJ'=>'Djibouti',
                       'DK'=>'Denmark',
                       'DM'=>'Dominica',
                       'DO'=>'Dominican Republic (the)',
                       'DZ'=>'Algeria',
                       'EC'=>'Ecuador',
                       'EE'=>'Estonia',
                       'EG'=>'Egypt',
                       'EH'=>'Western Sahara*',
                       'ER'=>'Eritrea',
                       'ES'=>'Spain',
                       'ET'=>'Ethiopia',
                       'FI'=>'Finland',
                       'FJ'=>'Fiji',
                       'FK'=>'Falkland Islands (the) [Malvinas]',
                       'FM'=>'Micronesia (Federated States of)',
                       'FO'=>'Faroe Islands (the)',
                       'FR'=>'France',
                       'GA'=>'Gabon',
                       'GB'=>'United Kingdom of Great Britain and Northern Ireland (the)',
                       'GD'=>'Grenada',
                       'GE'=>'Georgia',
                       'GF'=>'French Guiana',
                       'GG'=>'Guernsey',
                       'GH'=>'Ghana',
                       'GI'=>'Gibraltar',
                       'GL'=>'Greenland',
                       'GM'=>'Gambia (the)',
                       'GN'=>'Guinea',
                       'GP'=>'Guadeloupe',
                       'GQ'=>'Equatorial Guinea',
                       'GR'=>'Greece',
                       'GS'=>'South Georgia and the South Sandwich Islands',
                       'GT'=>'Guatemala',
                       'GU'=>'Guam',
                       'GW'=>'Guinea-Bissau',
                       'GY'=>'Guyana',
                       'HK'=>'Hong Kong',
                       'HM'=>'Heard Island and McDonald Islands',
                       'HN'=>'Honduras',
                       'HR'=>'Croatia',
                       'HT'=>'Haiti',
                       'HU'=>'Hungary',
                       'ID'=>'Indonesia',
                       'IE'=>'Ireland',
                       'IL'=>'Israel',
                       'IM'=>'Isle of Man',
                       'IN'=>'India',
                       'IO'=>'British Indian Ocean Territory (the)',
                       'IQ'=>'Iraq',
                       'IR'=>'Iran (Islamic Republic of)',
                       'IS'=>'Iceland',
                       'IT'=>'Italy',
                       'JE'=>'Jersey',
                       'JM'=>'Jamaica',
                       'JO'=>'Jordan',
                       'JP'=>'Japan',
                       'KE'=>'Kenya',
                       'KG'=>'Kyrgyzstan',
                       'KH'=>'Cambodia',
                       'KI'=>'Kiribati',
                       'KM'=>'Comoros (the)',
                       'KN'=>'Saint Kitts and Nevis',
                       'KP'=>'Korea (the Democratic Peoples Republic of)',
                       'KR'=>'Korea (the Republic of)',
                       'KW'=>'Kuwait',
                       'KY'=>'Cayman Islands (the)',
                       'KZ'=>'Kazakhstan',
                       'LA'=>'Lao Peoples Democratic Republic (the)',
                       'LB'=>'Lebanon',
                       'LC'=>'Saint Lucia',
                       'LI'=>'Liechtenstein',
                       'LK'=>'Sri Lanka',
                       'LR'=>'Liberia',
                       'LS'=>'Lesotho',
                       'LT'=>'Lithuania',
                       'LU'=>'Luxembourg',
                       'LV'=>'Latvia',
                       'LY'=>'Libya',
                       'MA'=>'Morocco',
                       'MC'=>'Monaco',
                       'MD'=>'Moldova (the Republic of)',
                       'ME'=>'Montenegro',
                       'MF'=>'Saint Martin (French part)',
                       'MG'=>'Madagascar',
                       'MH'=>'Marshall Islands (the)',
                       'MK'=>'Macedonia (the former Yugoslav Republic of)',
                       'ML'=>'Mali',
                       'MM'=>'Myanmar',
                       'MN'=>'Mongolia',
                       'MO'=>'Macao',
                       'MP'=>'Northern Mariana Islands (the)',
                       'MQ'=>'Martinique',
                       'MR'=>'Mauritania',
                       'MS'=>'Montserrat',
                       'MT'=>'Malta',
                       'MU'=>'Mauritius',
                       'MV'=>'Maldives',
                       'MW'=>'Malawi',
                       'MX'=>'Mexico',
                       'MY'=>'Malaysia',
                       'MZ'=>'Mozambique',
                       'NA'=>'Namibia',
                       'NC'=>'New Caledonia',
                       'NE'=>'Niger (the)',
                       'NF'=>'Norfolk Island',
                       'NG'=>'Nigeria',
                       'NI'=>'Nicaragua',
                       'NL'=>'Netherlands (the)',
                       'NO'=>'Norway',
                       'NP'=>'Nepal',
                       'NR'=>'Nauru',
                       'NU'=>'Niue',
                       'NZ'=>'New Zealand',
                       'OM'=>'Oman',
                       'PA'=>'Panama',
                       'PE'=>'Peru',
                       'PF'=>'French Polynesia',
                       'PG'=>'Papua New Guinea',
                       'PH'=>'Philippines (the)',
                       'PK'=>'Pakistan',
                       'PL'=>'Poland',
                       'PM'=>'Saint Pierre and Miquelon',
                       'PN'=>'Pitcairn',
                       'PR'=>'Puerto Rico',
                       'PS'=>'Palestine, State of',
                       'PT'=>'Portugal',
                       'PW'=>'Palau',
                       'PY'=>'Paraguay',
                       'QA'=>'Qatar',
                       'RE'=>'RÃ©union',
                       'RO'=>'Romania',
                       'RS'=>'Serbia',
                       'RU'=>'Russian Federation (the)',
                       'RW'=>'Rwanda',
                       'SA'=>'Saudi Arabia',
                       'SB'=>'Solomon Islands',
                       'SC'=>'Seychelles',
                       'SD'=>'Sudan (the)',
                       'SE'=>'Sweden',
                       'SG'=>'Singapore',
                       'SH'=>'Saint Helena, Ascension and Tristan da Cunha',
                       'SI'=>'Slovenia',
                       'SJ'=>'Svalbard and Jan Mayen',
                       'SK'=>'Slovakia',
                       'SL'=>'Sierra Leone',
                       'SM'=>'San Marino',
                       'SN'=>'Senegal',
                       'SO'=>'Somalia',
                       'SR'=>'Suriname',
                       'SS'=>'South Sudan',
                       'ST'=>'Sao Tome and Principe',
                       'SV'=>'El Salvador',
                       'SX'=>'Sint Maarten (Dutch part)',
                       'SY'=>'Syrian Arab Republic',
                       'SZ'=>'Swaziland',
                       'TC'=>'Turks and Caicos Islands (the)',
                       'TD'=>'Chad',
                       'TF'=>'French Southern Territories (the)',
                       'TG'=>'Togo',
                       'TH'=>'Thailand',
                       'TJ'=>'Tajikistan',
                       'TK'=>'Tokelau',
                       'TL'=>'Timor-Leste',
                       'TM'=>'Turkmenistan',
                       'TN'=>'Tunisia',
                       'TO'=>'Tonga',
                       'TR'=>'Turkey',
                       'TT'=>'Trinidad and Tobago',
                       'TV'=>'Tuvalu',
                       'TW'=>'Taiwan (Province of China)',
                       'TZ'=>'Tanzania, United Republic of',
                       'UA'=>'Ukraine',
                       'UG'=>'Uganda',
                       'UM'=>'United States Minor Outlying Islands (the)',
                       'US'=>'United States of America (the)',
                       'UY'=>'Uruguay',
                       'UZ'=>'Uzbekistan',
                       'VA'=>'Holy See (the)',
                       'VC'=>'Saint Vincent and the Grenadines',
                       'VE'=>'Venezuela (Bolivarian Republic of)',
                       'VG'=>'Virgin Islands (British)',
                       'VI'=>'Virgin Islands (U.S.)',
                       'VN'=>'Viet Nam',
                       'VU'=>'Vanuatu',
                       'WF'=>'Wallis and Futuna',
                       'WS'=>'Samoa',
                       'YE'=>'Yemen',
                       'YT'=>'Mayotte',
                       'ZA'=>'South Africa',
                       'ZM'=>'Zambia',
                       'ZW'=>'Zimbabwe',
                       ''   =>'EMPTY',
                       '');
    RETURN IF(country != '',1,0);
  END;
  
  
  
//*********************************************************//
//***************END GENERAL SECTION***********************//
//*********************************************************//
    
END; //End Functions Module