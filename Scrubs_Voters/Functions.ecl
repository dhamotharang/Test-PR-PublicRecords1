IMPORT ut, Scrubs, Codes, Scrubs_Voters;

EXPORT Functions := MODULE




//*********************************************************//
//***************BEGIN GENERAL PURPOSE SECTION*************//
//*********************************************************//





   //****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;

  //****************************************************************************
  //fn_range_numeric: 	returns true if number in range
  //****************************************************************************
  EXPORT fn_range_numeric(STRING nmbr, UNSIGNED6 lbound, UNSIGNED6 ubound) := FUNCTION
    RETURN IF((UNSIGNED6)nmbr >= lbound AND (UNSIGNED6)nmbr <= ubound,1,0);
  END;

 //****************************************************************************
  //fn_populated_strings: 	returns true if one of the strings is populated
  //****************************************************************************
  EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '', STRING str6 = '') := FUNCTION
    RETURN IF(LENGTH(TRIM(str1 + str2 + str3 + str4 + str5 + str6, ALL)) > 0,1,0);
  END;

  //****************************************************************************
  //fn_non_empty_alphanum: 	returns true if only populated with alphanumeric
  //****************************************************************************
  EXPORT fn_non_empty_alphanum(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(ut.CleanSpacesAndUpper(nmbr), '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',1,0);
  END;

  //*******************************************************************************
  //fn_dependent_strings: 	returns true or false based upon the incoming strings.
  //													
  //Returns true if both exist or both empty
  //*******************************************************************************
  EXPORT fn_dependent_strings(STRING str1, STRING str2) := FUNCTION
    
    clean_str1   := TRIM(str1, ALL);
    clean_str2   := TRIM(str2, ALL);
    isValidStrs  := IF((clean_str1 = '' AND clean_str1 = '') OR (clean_str1 != '' AND clean_str1 != ''), TRUE, FALSE);
    
    RETURN IF(isValidStrs, 1, 0);
  END;





//*********************************************************//
//***************END GENERAL PURPOSE SECTION***************//
//*********************************************************//
//***************BEGIN ADDRESS SECTION*********************//
//*********************************************************//





  //****************************************************************************
  //fn_verify_phone:  returns true or false based upon whether it contains an
  //                  empty or valid phone #
  //****************************************************************************
	 EXPORT fn_verify_optional_phone(STRING phone) := function    
    clean_phone := TRIM(phone, ALL);
    RETURN IF(clean_phone = '' OR ut.CleanPhone(clean_phone) != '', 1, 0);
  END;
  
  //****************************************************************************
	 //fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	 //****************************************************************************
	 EXPORT fn_verify_state(STRING code) := function    
		  RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
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
	 //fn_verify_cart:  returns true or false based upon whether or not there is
  //                 a valid cart value.
	 //****************************************************************************
	 EXPORT fn_verify_cart(STRING cart) := function    
		  RETURN IF(LENGTH(cart) = 4 AND 
              Stringlib.StringFilterOut(cart[1], 'BCGHR') = '' AND
              Stringlib.StringFilterOut(cart[2..], '0123456789') = '', 1, 0);
  END;
    
  //****************************************************************************
  //fn_geo_coord: 	returns true or false based upon the lat/long value.
  //****************************************************************************
  EXPORT fn_geo_coord(STRING geo) := FUNCTION
    geo_clean := TRIM(geo,ALL);
    
    //Verifying the pattern for coordinates is an optional negative sign (-),
    //followed by at least 1 digit, followed by decimal (.), and ending
    //with at least 1 digit
    RETURN IF(regexfind('^-?\\d+.\\d+$', geo_clean), 1, 0);
  END;





//*********************************************************//
//***************END ADDRESS SECTION***********************//
//*********************************************************//
//***************BEGIN DATE/TIME SECTION*******************//
//*********************************************************//





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
  //fn_valid_year: 	returns true or false based upon the incoming year.
  //													
  //Returns true if valid year
  //*******************************************************************************
  EXPORT fn_valid_year(STRING sYear) := FUNCTION
    
    clean_year  := TRIM(sYear, ALL);
    isValidYear := IF(LENGTH(clean_year) = 4, Scrubs.fn_valid_GeneralDate(clean_year + '0101') > 0, FALSE);
    
    RETURN IF(isValidYear, 1, 0);
  END;

  //*******************************************************************************
  //fn_valid_generic_date: 	returns true or false based upon the incoming date.
  //													
  //Returns true if at least a valid year or empty.  
  //Can be a valid month or 00 and can be a valid day or 00
  //****************************************************************************
  EXPORT fn_valid_generic_date(STRING sDate) := FUNCTION
    
    clean_date  := TRIM(sDate, ALL);
    norm_date   := IF(LENGTH(clean_date) != 8, clean_date,
                      clean_date[1..4]
                      + IF(clean_date[5..6] = '00', '01', clean_date[5..6])
                      + IF(clean_date[7..8] = '00', '01', clean_date[7..8]));
    isValidDate := CASE(LENGTH(norm_date),
                        8 => IF(Scrubs.fn_valid_GeneralDate(norm_date) > 0, TRUE, FALSE),
                        0 => TRUE,
                        FALSE);
    
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
  
  



//*********************************************************//
//***************END DATE/TIME SECTION*********************//
//*********************************************************//
//***************BEGIN GENERAL SECTION*********************//
//*********************************************************//





  //*******************************************************************************
  //fn_valid_agecat: 	returns true or false based upon the incoming value.
  //													
  //Returns true if empty or valid age category (1-11)
  // value      age range
  // 1          18-24	
  // 2          25-34
  // 3          35-44
  // 4          45-54
  // 5          55-64
  // 6          65+	
	 //
  // 7          18-25
  // 8          26-40
  // 9          41-66
  // 10         over 66
  // 11         under 18
  //*******************************************************************************
  EXPORT fn_valid_agecat(STRING sAgeCat) := FUNCTION
    
    clean_AgeCat   := TRIM(sAgeCat, ALL);
    isValidsAgeCat := IF(LENGTH(clean_AgeCat) != 0, fn_range_numeric(clean_AgeCat, 1, 11) > 0, FALSE);
    
    RETURN IF(clean_AgeCat = '' OR isValidsAgeCat, 1, 0);
  END;

  //*******************************************************************************
  //fn_valid_agecat_exp: 	returns true or false based upon the incoming value.
  //													
  //Returns true if empty or valid age category (1-11)
  // value      age range
  // 1          18-24	
  // 2          25-34
  // 3          35-44
  // 4          45-54
  // 5          55-64
  // 6          65+	
	 //
  // 7          18-25
  // 8          26-40
  // 9          41-66
  // 10         over 66
  // 11         under 18
  //*******************************************************************************
  EXPORT fn_valid_agecat_exp(STRING sAgeCatExp, STRING sAgeCat) := FUNCTION
    
    clean_AgeCatExp   := ut.CleanSpacesAndUpper(sAgeCatExp);
    clean_AgeCat      := TRIM(sAgeCat, ALL);
    ExpAgeCat         := CASE(clean_AgeCat,
                              '1'                        => '18-24',
                              '2'                        => '25-34',
                              '3'                        => '35-44',
                              '4'                        => '45-54',
                              '5'                        => '55-64',
                              '6'                        => '65+',
                              '7'                        => '18-25',
                              '8'                        => '26-40',
                              '9'                        => '41-66',
                              '10'                       => 'OVER 66',
                              '');
    
    RETURN IF((sAgeCatExp = '' AND clean_AgeCat = '') OR 
               clean_AgeCatExp = ExpAgeCat, 1, 0);
  END;

  //****************************************************************************
  //fn_race: 	returns true or false based upon the incoming code.
  //										        
  // Race Ethnicity:
  // A:	Asian/Pacific Island
  // B:	Black
  // C:	Chinese
  // H:	Hispanic
  // I:	Indian or Alaskan Native
  // J:	Jewish
  // K:	Korean
  // M:	Multi cultural two or more
  // N:	Native American
  // O:	Other
  // P:	Filipino
  // U:	Undefined
  // W:	White
  //****************************************************************************
  EXPORT fn_race(STRING sRace) := FUNCTION
    clean_Race   := ut.CleanSpacesAndUpper(sRace);
		  isValidCode := IF(Stringlib.StringFilterOut(clean_Race, 'ABCHIJKMNOPUW') = '', 1, 0);
    RETURN isValidCode;
  END;  
  
  //****************************************************************************
  //fn_race_exp: 	returns true or false based upon the incoming code.
  //										        
  // Race Ethnicity:
  // A:	Asian/Pacific Island
  // B:	Black
  // C:	Chinese
  // H:	Hispanic
  // I:	Indian or Alaskan Native
  // J:	Jewish
  // K:	Korean
  // M:	Multi cultural two or more
  // N:	Native American
  // O:	Other
  // P:	Filipino
  // U:	Undefined
  // W:	White
  //****************************************************************************
  EXPORT fn_race_exp(STRING sRaceExp, STRING sRace) := FUNCTION
    
    clean_RaceExp   := ut.CleanSpacesAndUpper(sRaceExp);
    clean_Race      := ut.CleanSpacesAndUpper(sRace);
    ExpRace         := CASE(clean_Race[1],
                              'A'                        => 'ASIAN PACIFIC ISLAND',
                              'B'                        => 'BLACK',
                              'C'                        => 'CHINESE',
                              'H'                        => 'HISPANIC',
                              'I'                        => 'INDIAN',
                              'M'                        => 'MULTI CULTURAL',
                              'N'                        => 'NATIVE AMERICAN',
                              'O'                        => 'OTHER',
                              'P'                        => 'FILIPINO',
                              'U'                        => 'UNKNOWN',
                              'W'                        => 'WHITE',
                              '');
    
    RETURN IF((sRaceExp = '' AND sRace = '') OR 
               clean_RaceExp = ExpRace, 1, 0);
  END;  
  
  //****************************************************************************
  //fn_political_party: 	returns true or false based upon the incoming 
  //                     political party name.
  //****************************************************************************
  EXPORT fn_political_party(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                        'DEMOCRAT'                       => TRUE,
                        'NONE DECLARED'                  => TRUE,
                        'REPUBLICAN'                     => TRUE,
                        'OTHER'                          => TRUE,
                        'MUST REREGISTER'                => TRUE,
                        'INDEPENDENT'                    => TRUE,
                        'INDEPENDENCE'                   => TRUE,
                        'LIBERTARIAN'                    => TRUE,
                        'CONSERVATIVE'                   => TRUE,
                        'UNKNOWN'                        => TRUE,
                        'NATURAL LAW'                    => TRUE,
                        'LIBERAL'                        => TRUE,
                        'GREEN'                          => TRUE,
                        'YOUTH INTL.'                    => TRUE,
                        'WORKING FAMILIES'               => TRUE,
                        'CONSTITUTION'                   => TRUE,
                        'RIGHT TO LIFE'                  => TRUE,
                        'REFORM'                         => TRUE,
                        'SOCIALIST WORKERS'              => TRUE,
                        'MODERATE GOP ALASKA'            => TRUE,
                        'NEW WORLD COUNCIL'              => TRUE,
                        'STATEHOOD'                      => TRUE,
                        'AMERICAN'                       => TRUE,
                        'CHRISTIAN'                      => TRUE,
                        'INTERDEPENDENT'                 => TRUE,
                        'FEDERALIST'                     => TRUE,
                        'FAMILY VALUES'                  => TRUE,
                        'PEACE FREEDOM'                  => TRUE,
                        'FAITH & PATIENCE'               => TRUE,
                        'DELAWARE PARTY'                 => TRUE,
                        'SOUTHERN PARTY'                 => TRUE,
                        'WHIG'                           => TRUE,
                        'US TAXPAYERS'                   => TRUE,
                        'NEW ALLIANCE'                   => TRUE,
                        'THE NEW PARTY FL'               => TRUE,
                        'CITIZENS'                       => TRUE,
                        'WE THE PEOPLE'                  => TRUE,
                        'BRIT REFORM'                    => TRUE,
                        'CONCERNS OF THE PEOPLE'         => TRUE,
                        'PROHIBITION'                    => TRUE,
                        'ANARCHIST'                      => TRUE,
                        'COOL MOOSE'                     => TRUE,
                        'RAINBOW COALITION'              => TRUE,
                        'NEW FRONTIER'                   => TRUE,
                        'POPULIST'                       => TRUE,
                        'REFORM SILLY PARTY'             => TRUE,
                        'FIRST UNITED OF GOD'            => TRUE,
                        'PATRIOT'                        => TRUE,
                        'FREEDOM'                        => TRUE,
                        'MARIJUANA'                      => TRUE,
                        ''                               => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;
  
  //****************************************************************************
  //fn_voter_status: 	returns true or false based upon the incoming voter status.
  //****************************************************************************
  EXPORT fn_voter_status(STRING term) := FUNCTION
	  uc_term := ut.CleanSpacesAndUpper(term);
		 isValidTerm := CASE(uc_term,
                        'VERIFIED'                        => TRUE,
                        'ABSENTEE'                        => TRUE,
                        'MOVED NOT FORWARDED'             => TRUE,
                        'DECEASED'                        => TRUE,
                        'PURGED/CANCEL'                   => TRUE,
                        'DUPLICATE'                       => TRUE,
                        'VOTE BY MAIL'                    => TRUE,
                        'MOVED'                           => TRUE,
                        'PERM ABSENTEE'                   => TRUE,
                        'VOTED EARLY'                     => TRUE,
                        'NVRA'                            => TRUE,
                        'MOVED OUT OF STATE'              => TRUE,
                        'LEGACY DATA'                     => TRUE,
                        'ELIGIBLE TO VOTE ABSENTEE'       => TRUE,
                        'CHALLENGED'                      => TRUE,
                        'FEDERAL'                         => TRUE,
                        'DISABLED'                        => TRUE,
                        'TRANSFER MOVED'                  => TRUE,
                        'PENDING CANCEL'                  => TRUE,
                        'FELON'                           => TRUE,
                        'RESERVED'                        => TRUE,
                        'PROVISIONAL'                     => TRUE,
                        'MILITARY'                        => TRUE,
                        'INCOMPETENT MENTAL'              => TRUE,
                        'PENDING TURNING 18 YEARS OLD'    => TRUE,
                        'REJECTED'                        => TRUE,
                        'NAME CHANGE'                     => TRUE,
                        'CHANGE PARTY'                    => TRUE,
                        'FOWARDED'                        => TRUE,
                        'COURT ORDERED'                   => TRUE,
                        'SUSPENDED'                       => TRUE,
                        ''                                => TRUE,
                        FALSE);
    RETURN IF(isValidTerm,1,0);
  END;
  


  
 
//*********************************************************//
//***************END GENERAL SECTION***********************//
//*********************************************************//
    
END; //End Functions Module