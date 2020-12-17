IMPORT ut, Scrubs, Codes, MDR, _validate, Codes, std;

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
  //fn_numeric_optional: 	returns true if only populated with numbers or empty
	//                      If the string contains all numbers the size provided must 
	//                      equal the length of the string.  Use ALLOW in spc file 
	//                      if your optional numeric string has varying lengths.
	//                      EXAMPLE: FIELDTYPE:Numeric_Optional:ALLOW(0123456789)
  //****************************************************************************
  EXPORT fn_numeric_optional(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(LENGTH(TRIM(nmbr, ALL)) IN [0,size] AND Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
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
  EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '') := FUNCTION
    RETURN IF(LENGTH(TRIM(str1 + str2 + str3 + str4 + str5, ALL)) > 0,1,0);
  END;

  //****************************************************************************
  //fn_alphanum: 	returns true if only populated with numbers and letters
  //****************************************************************************
  EXPORT fn_alphanum(STRING alphanum, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(alphanum, ALL)) > 0, LENGTH(TRIM(alphanum, ALL)) = size) AND
              Stringlib.StringFilterOut(alphanum, '0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz') = '',1,0);
  END;
  
  //****************************************************************************
  //fn_alpha: 	returns true if only populated with letters
  //****************************************************************************
  EXPORT fn_alpha(STRING alpha, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(alpha, ALL)) > 0, LENGTH(TRIM(alpha, ALL)) = size) AND
              Stringlib.StringFilterOut(alpha, 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz') = '',1,0);
  END;
	
	//****************************************************************************
  //fn_alphaNum_or_blank: 	returns true if only populated with letters, numbers or blank
  //****************************************************************************
  EXPORT fn_alphaNum_or_blank(STRING s) := FUNCTION
    RETURN IF(Stringlib.StringFilterOut(s, ' 1234567890AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz') = '',1,0);
  END;
  
  //****************************************************************************
  //fn_alpha_optional: 	returns true if only populated with letters or empty
  //****************************************************************************
  EXPORT fn_alpha_optional(STRING alpha, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(LENGTH(TRIM(alpha, ALL)) IN [0,size] AND Stringlib.StringFilterOut(alpha, 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz') = '',1,0);
  END;

	//********************************************************************************
	//fn_ASCII_printable:  returns true if all the characters are valid ASCII chars
	//********************************************************************************
	EXPORT fn_ASCII_printable(STRING s) := function    
	  RETURN IF(Stringlib.StringFilterOut(s, ' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~') = '', 1, 0);
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
  //fn_valid_codesv3: 	CodesV3 table.  Generic table lookup function
  //													
  //Returns true if the code is empty/zero of if a lookup value is returned
  //*******************************************************************************
  EXPORT fn_valid_codesv3 (STRING code = '', STRING source = '', STRING field_name_in = '', STRING file_name_in =''):= FUNCTION
    codes_v3 := Codes.File_Codes_V3_In(file_name = file_name_in);
    STRING to_find := file_name_in + '|' +  field_name_in + '|' + source + '|'+ code;
    my_dict := PROJECT(codes_v3, TRANSFORM({STRING search_str},
                                           SELF.search_str:= TRIM(LEFT.file_name, LEFT, RIGHT) + '|' + 
                                           TRIM(LEFT.field_name, LEFT, RIGHT) + '|' + 
                                           TRIM(LEFT.field_name2, LEFT, RIGHT) + '|' + 
                                           TRIM(LEFT.code, LEFT, RIGHT)));

    dict := DICTIONARY(my_dict);
    RETURN IF(dict[to_find].search_str <> '' OR code = '' OR code = '0', 1, 0);
  END;




//*********************************************************//
//***************END GENERAL PURPOSE SECTION***************//
//*********************************************************//
//***************BEGIN DATE/TIME SECTION*******************//
//*********************************************************//




  //*******************************************************************************
  //fn_valid_date: 	General purpose date function for past/current/future dates
  //*******************************************************************************
  EXPORT fn_valid_date(STRING st, STRING dt_type = '') := FUNCTION
    current := st = ''
               OR (UNSIGNED) st = 0 
               OR (_validate.date.fCorrectedDateString(st) <> '' 
               AND _validate.date.fCorrectedDateString(st) > '18000101'
               AND _validate.date.fCorrectedDateString(st) <= (STRING)Std.Date.Today());
    future := st = ''
              OR (UNSIGNED) st = 0
              OR (_validate.date.fCorrectedDateString(st) <> ''
              AND _validate.date.fCorrectedDateString(st) > '18000101');

    RETURN IF(dt_type = '', (UNSIGNED)current, (UNSIGNED) future);
  END;

  //***********************************************************************************
  //fn_valid_GeneralDate: 	General purpose date function for past/current/future dates
  //***********************************************************************************
  EXPORT fn_valid_GeneralDate(STRING st) := FUNCTION
    yyyymmdd := st = '' OR (UNSIGNED) st = 0 OR _validate.date.fIsValid(st);
    RETURN (UNSIGNED)yyyymmdd;
  END;

  //*******************************************************************************
  //fn_valid_pastDate: 	General purpose date function for past/current dates
  // This custom scrub was created for the Corporation Re-corp Project. If it works for you, 
  // then feel free to use it. Otherwise you must create your own version or modfy this one 
  // to accomodate your needs without breaking this one. 
  // This will send back a 1, valid date flag, if: 1) date is blank or zero 2) the date is a 
  // valid past date greater than 16000101. Otherwise it returns a 0, invalid date flag. Thanks! 
  //*******************************************************************************
  EXPORT fn_valid_pastDate(STRING st) := FUNCTION
    yyyymmdd := MAP(st = '' => '1', 
								 (UNSIGNED)st = 0 => '1',
						      _validate.date.fIsValid(st) AND _validate.date.fIsValid(st,_validate.date.rules.DateInPast) AND (st) > '16000101' => '1',
								 '0');
    RETURN (UNSIGNED)yyyymmdd;
  END;

  //*******************************************************************************
  //fn_past_yyyymmdd: 	Returns true if valid past date. If the can_be_zero parameter
  //                   is set to TRUE then the sDate can be zero.
  //*******************************************************************************
  EXPORT fn_past_yyyymmdd(STRING sDate, BOOLEAN can_be_zero = FALSE) := FUNCTION 
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8, fn_valid_pastDate(clean_date) > 0, FALSE); 
    RETURN IF((can_be_zero AND sDate = '0') OR isValidDate, 1, 0);
  END;
  
	//****************************************************************************
	//fn_general_yyyymmdd: returns true or false based upon whether or not there is
	//                     a valid date (can be future date). If the can_be_zero
  //                     parameter is set to TRUE then the sDate can be zero.
	//****************************************************************************
	EXPORT fn_general_yyyymmdd(STRING sDate, BOOLEAN can_be_zero = FALSE) := FUNCTION
		clean_date  := TRIM(sDate, ALL);
		isValidDate := IF(LENGTH(clean_date) = 8, fn_valid_GeneralDate(clean_date) > 0, FALSE);
		RETURN IF((can_be_zero AND sDate = '0') OR isValidDate, 1, 0);
	END;

  //*******************************************************************************
  //fn_valid_generic_date: Returns true or false based upon the incoming date.													
  //                       Returns true if at least a valid year or empty.  
  //                       Can be a valid month or 00 and can be a valid day or 00
  //*******************************************************************************
  EXPORT fn_valid_generic_date(STRING sDate) := FUNCTION    
    clean_date  := TRIM(sDate, ALL);
    norm_date   := IF(LENGTH(clean_date) != 8, clean_date,
                      clean_date[1..4]
                      + IF(clean_date[5..6] = '00', '01', clean_date[5..6])
                      + IF(clean_date[7..8] = '00', '01', clean_date[7..8]));
    isValidDate := CASE(LENGTH(norm_date),
                        8 => IF(fn_valid_GeneralDate(norm_date) > 0, TRUE, FALSE),
                        0 => TRUE,
                        FALSE);   
    RETURN IF(isValidDate, 1, 0);
  END;

  //*******************************************************************************
  //fn_is_valid_earlier_date: 	returns true or false based upon the incoming date.
  //                            Returns true if valid early date is earlier or 
  //                            equal to later valid date
  //*******************************************************************************
  EXPORT fn_is_valid_earlier_date(STRING sEarlyDate, STRING sLaterDate) := FUNCTION
    valid_EarlyDate  := Scrubs.fn_valid_pastDate(TRIM(sEarlyDate, ALL)) > 0;
    valid_LaterDate  := Scrubs.fn_valid_pastDate(TRIM(sLaterDate, ALL)) > 0;
    isValidEarlierDate := IF(valid_EarlyDate AND valid_LaterDate,
                             ut.EarliestDate((INTEGER)sEarlyDate, (INTEGER)sLaterDate) = (INTEGER)sEarlyDate,
                             FALSE);   
    RETURN IF((INTEGER)sEarlyDate != 0 AND (INTEGER)sLaterDate != 0 AND isValidEarlierDate, 1, 0);
  END;

  //***********************************************************************************
  //fn_is_valid_opt_earlier_date:   Returns true or false based upon the incoming date.
  //                                Returns true if empty/0 or valid early date is 
  //                                earlier or equal to later valid date.
  //***********************************************************************************
  EXPORT fn_is_valid_opt_earlier_date(STRING sEarlyDate, STRING sLaterDate) := FUNCTION
    valid_EarlyDate  := Scrubs.fn_valid_pastDate(TRIM(sEarlyDate, ALL)) > 0;
    valid_LaterDate  := Scrubs.fn_valid_pastDate(TRIM(sLaterDate, ALL)) > 0;
    isValidEarlierDate := IF(valid_EarlyDate AND valid_LaterDate,
                             ut.EarliestDate((INTEGER)sEarlyDate, (INTEGER)sLaterDate) = (INTEGER)sEarlyDate,
                             FALSE);
    RETURN IF((INTEGER)sEarlyDate = 0 OR (INTEGER)sLaterDate = 0 OR isValidEarlierDate, 1, 0);
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

  //*******************************************************************************
  //fn_check_time:  Returns true or false based upon the incoming time.											
  //                Returns true if valid military time or empty
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
//***************BEGIN ADDRESS SECTION*********************//
//*********************************************************//




  //****************************************************************************
  //fn_Valid_StateAbbrev: returns true if there is a valid state abbreviation
  //                      or if the code is empty.
  //****************************************************************************
  EXPORT fn_Valid_StateAbbrev(STRING st) := FUNCTION
    RETURN IF(st='' OR Codes.valid_st(st),1,0);
  END;

  //****************************************************************************
  //fn_verify_state: returns true or false based upon whether or not there is
  //                 a valid state abbreviation.  If the can_be_empty parameter
  //                 is set to 'T' (TRUE) then the code can be empty.
  //****************************************************************************
  EXPORT fn_verify_state(STRING code, BOOLEAN can_be_empty = FALSE) := FUNCTION    
    RETURN IF((can_be_empty AND code = '') OR LENGTH(Codes.St2Name(code)) > 0, 1, 0);
  END;

  //****************************************************************************
  //fn_verify_zip59:  returns true or false based upon whether or not there is
  //                  a 5-digit or 9-digit value.
  //****************************************************************************
  EXPORT fn_verify_zip59(STRING zip59) := FUNCTION    
    RETURN IF((LENGTH(zip59) IN [5,9]) AND Stringlib.StringFilterOut(zip59, '0123456789') = '', 1, 0);
  END;

  //****************************************************************************
  //fn_valid_zip:  returns true or false based upon whether or not there is
  //               a 5-digit or 9-digit value and allows for a hyphen.
  //****************************************************************************
  EXPORT fn_valid_zip(STRING zip) := FUNCTION
    STRING TrimedZip := TRIM(zip,LEFT,RIGHT);
    BOOLEAN ValidZip := IF((LENGTH(TrimedZip) = 5 OR LENGTH(TrimedZip) = 9) AND std.str.filterout(TrimedZip[1..5],'0123456789') = ''
                           ,TRUE
                           ,IF(LENGTH(TrimedZip) <> 10
                               ,FALSE
                               ,IF((std.str.filterout(TrimedZip[1..5],'0123456789') = '')
                                   AND (std.str.filterout(TrimedZip[6],' -')='')
                                   AND (std.str.filterout(TrimedZip[7..10],'0123456789')='')
                                  ,TRUE
                                  ,FALSE)));

    RETURN IF(zip = '' OR ValidZip,1,0);
  END;

  //****************************************************************************
  //fn_verify_phone:  returns true or false based upon whether its a valid
  //                  phone #.  If the can_be_empty parameter is set to
  //                  'T' (TRUE) then the phone number can be empty.
  //****************************************************************************
	 EXPORT fn_verify_phone(STRING phone, BOOLEAN can_be_empty = FALSE) := FUNCTION    
    clean_phone := TRIM(phone, ALL);
    RETURN IF((can_be_empty AND clean_phone = '') OR ut.CleanPhone(clean_phone) != '', 1, 0);
  END;

  //****************************************************************************
  //fn_verify_optional_phone:  returns true or false based upon whether it contains an
  //                           empty or valid phone #
  //****************************************************************************
	EXPORT fn_verify_optional_phone(STRING phone) := function    
    clean_phone := TRIM(phone, ALL);
    RETURN IF(clean_phone = '' OR ut.CleanPhone(clean_phone) != '', 1, 0);
  END;
	
  //****************************************************************************
  //fn_verify_cart: returns true or false based upon whether or not there is
  //                 an empty or valid cart value.
  //****************************************************************************
  EXPORT fn_verify_cart(STRING cart) := FUNCTION    
  RETURN IF(LENGTH(TRIM(cart,ALL)) = 0 OR (LENGTH(cart) = 4 AND 
            Stringlib.StringFilterOut(cart[1], 'BCDFGHPRSU') = '' AND
            Stringlib.StringFilterOut(cart[2..], '0123456789') = ''), 1, 0);
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
  
  //****************************************************************************
  //fn_geo_coord: 	returns true or false based upon the lat/long value.
  //****************************************************************************
  EXPORT fn_geo_coord(STRING geo) := FUNCTION
    geo_clean := TRIM(geo,ALL);
    
    //Verifying the pattern for coordinates is an optional negative sign (-),
    //followed by at least 1 digit, followed by decimal (.), and ending
    //with at least 1 digit
    RETURN IF(regexfind('^[-]?\\d+\\.\\d+$', geo_clean) OR geo_clean = '', 1, 0);
  END;

  //****************************************************************************
  //fn_Valid_Country3Abbrev: returns true if there is a valid country
  //                         abbreviation or if the code is empty.
  //****************************************************************************
  EXPORT fn_Valid_Country3Abbrev(STRING cntry) := FUNCTION
    RETURN IF(cntry = '' OR ut.Country_ISO3_To_Name(cntry) != '', 1, 0);
  END;


    

//*********************************************************//
//***************END ADDRESS SECTION***********************//
//*********************************************************//
//***************BEGIN BUSINESS SECTION********************//
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
  //fn_naics: 	returns true if only populated with 0,2-6 digit codes
  //****************************************************************************
  EXPORT fn_naics(STRING naics) := FUNCTION
    RETURN IF(LENGTH(TRIM(naics, ALL)) IN [0,2,3,4,5,6] AND Stringlib.StringFilterOut(naics, '0123456789') = '',1,0);
  END;

  //****************************************************************************
  //fn_company_xor_person: 	returns true if only a company name or only a person 
  //****************************************************************************
  EXPORT fn_company_xor_person(STRING company, STRING fname, STRING mname, STRING lname) := FUNCTION
    company_populated := LENGTH(TRIM(company, ALL)) > 0;
    person_populated := fn_populated_strings(fname, mname, lname) > 0;
    RETURN IF((company_populated OR person_populated) AND NOT (company_populated AND person_populated),1,0);
  END;

  //****************************************************************************
  //fn_validate_NAICSCode: 	returns true if NAICS code is found in lookup table or is zero/null
  //****************************************************************************
EXPORT integer fn_validate_NAICSCode(string code) := function
  return ut.fn_NAICS_functions.fn_validate_NAICSCode(code);
END;

  //****************************************************************************
  //fn_validate_SICCode: 	returns true if SIC code is found in lookup table or is zero/null
  //****************************************************************************
EXPORT integer fn_valid_SicCode(string code) := function
	return ut.fn_SIC_functions.fn_validate_SicCode(code);
END;

//*********************************************************//
//***************END BUSINESS SECTION**********************//
//*********************************************************//
    
    EXPORT fn_valid_email(string em) := FUNCTION

    cleanEm         := TRIM(em,ALL);
    rgxEmail        := '^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';
    isValidEmail    := REGEXFIND(rgxEmail, cleanEm);
    isBlank         := LENGTH(cleanEm) = 0;

    RETURN if(
                isValidEmail OR isBlank
                ,1
                ,0
            );

    END;

    EXPORT fn_Valid_Phone2(string no) := FUNCTION 
        cNo := TRIM(no,ALL);
        isPhoneValid := LENGTH(STD.str.filter(cNo,'0123456789')) = 10
                AND STD.str.findCount(cNo[LENGTH(cNo)-6..LENGTH(cNo)],cNo[LENGTH(cNo)-6]) < 7
                AND cNo[LENGTH(cNo)-3..LENGTH(cNo)] NOT IN ['0000','9999']
                AND cNo[LENGTH(cNo)-6] NOT IN ['0','1']
                AND cNo[..3] NOT IN ['800','811','822','833','844','855','866','877','888','899'];
        isBlank := no = '';

        RETURN IF(
            isPhoneValid OR isBlank,
            1,
            0
        );

    END;

    EXPORT fn_valid_IP(string ip) := FUNCTION

        cleanIp      := TRIM(ip,whitespace);
        isIPV4      := STD.str.filterOut(cleanIp, '0123456789') = '...';
        isMinMaxLength := LENGTH(cleanIp) > 6 AND LENGTH(cleanIP) < 16;
        isBlank     := LENGTH(cleanIp) = 0;

        RETURN if(
                    (isIPV4 AND isMinMaxLength) or isBlank
                    ,1
                    ,0
                );
    END;
END; //End Functions Module