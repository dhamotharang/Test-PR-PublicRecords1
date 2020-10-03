IMPORT Scrubs_SAM, Scrubs, ut, STD;
	
EXPORT Functions := MODULE

  //****************************************************************************
  //fn_populated_strings: 	returns true if one of the strings is populated
  //****************************************************************************
  EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '') := FUNCTION
    RETURN Scrubs.Functions.fn_populated_strings(str1, str2, str3, str4, str5);
  END;

  //*******************************************************************************
  //fn_str1_depends_str2: 	returns true or false based upon the values.
  //													
  //Returns true if both are populated or if str1 is empty
  //*******************************************************************************
  EXPORT fn_str1_depends_str2(STRING str1, STRING str2) := FUNCTION
    RETURN IF(str1 = '' OR str2 != '', 1, 0);   
  END;

  //*******************************************************************************
  //fn_str1_depends_str2_str3: 	returns true or false based upon the values.
  //													
  //Returns true if all are populated or if str1 is empty
  //*******************************************************************************
  EXPORT fn_str1_depends_str2_str3(STRING str1, STRING str2, STRING str3) := FUNCTION
    RETURN IF(str1 = '' OR (str2 != '' AND str3 != ''), 1, 0);   
  END;

  //*******************************************************************************
  //fn_str1_depends_str2_str3_str4: 	returns true or false based upon the values.
  //													
  //Returns true if all are populated or if str1 is empty
  //*******************************************************************************
  EXPORT fn_str1_depends_str2_str3_str4(STRING str1, STRING str2, STRING str3, STRING str4) := FUNCTION
    RETURN IF(str1 = '' OR (str2 != '' AND str3 != '' AND str4 != ''), 1, 0);   
  END;

  //****************************************************************************
  //fn_Valid_StateAbbrev: returns true if there is a valid state abbreviation
  //                      or if the code is empty.
  //****************************************************************************
  EXPORT fn_Valid_StateAbbrev(STRING st, STRING cntry) := FUNCTION
    st_clean     := ut.CleanSpacesAndUpper(st);
    cntry_clean  := ut.CleanSpacesAndUpper(cntry);
    RETURN IF(cntry_clean NOT IN ['','USA'] OR Scrubs.Functions.fn_Valid_StateAbbrev(st_clean) > 0, 1, 0);
  END;

  //****************************************************************************
  //fn_Valid_Country3Abbrev: returns true if there is a valid country
  //                         abbreviation or if the code is empty.
  //****************************************************************************
  EXPORT fn_Valid_Country3Abbrev(STRING cntry) := FUNCTION
    RETURN Scrubs.Functions.fn_Valid_Country3Abbrev(cntry);
  END;

  //****************************************************************************
  //fn_verify_zip59:  returns true or false based upon whether or not there is
  //                  a 5-digit, 9-digit, or empty value. Removed hyphens.
  //****************************************************************************
  EXPORT fn_verify_zip059(STRING zip059) := FUNCTION
    zip059_clean := TRIM(Stringlib.StringFilterOut(zip059, '-'), WHITESPACE);
    RETURN IF(zip059_clean = '' OR Scrubs.Functions.fn_verify_zip59(zip059_clean) = 1, 1, 0);
  END;
 
  //****************************************************************************
  //fn_exclusion_program: 	returns true or false based upon the incoming
  //										  value.
  //****************************************************************************
  EXPORT fn_exclusion_program(STRING expr) := FUNCTION
    expr_clean  := ut.CleanSpacesAndUpper(expr);
    isValidExPr := CASE(expr_clean,
                        'RECIPROCAL'      => TRUE,
                        'NONPROCUREMENT'  => TRUE,
                        'PROCUREMENT'     => TRUE,
                        FALSE);
    RETURN IF(isValidExPr,1,0);
  END;
  
  //****************************************************************************
  //fn_exclusion_type: 	returns true or false based upon the incoming
  //										value.
  //****************************************************************************
  EXPORT fn_exclusion_type(STRING extyp) := FUNCTION
    extyp_clean  := ut.CleanSpacesAndUpper(extyp);
    isValidExTyp := CASE(extyp_clean,
                         'PROHIBITION/RESTRICTION'             => TRUE,
                         'INELIGIBLE (PROCEEDINGS COMPLETED)'  => TRUE,
                         'INELIGIBLE (PROCEEDINGS PENDING)'    => TRUE,
                         'VOLUNTARY EXCLUSION'                 => TRUE,
                         FALSE);
    RETURN IF(isValidExTyp,1,0);
  END;
  
  //*******************************************************************************
  //fn_Valid_Past_Date: 	Returns true if valid past date or empty.
  //*******************************************************************************
  EXPORT fn_Valid_Past_Date(STRING sDate = '') := FUNCTION
     RETURN IF(sDate = '' OR Scrubs.fn_valid_pastDate((STRING) STD.Date.FromStringToDate(sDate, '%m/%d/%Y')) > 0, 1, 0);
  END;


  //*******************************************************************************
  //fn_Valid_General_Date: 	Returns true if valid date, "indefinite", or empty.
  //*******************************************************************************
  EXPORT fn_Valid_General_Date(STRING sDate = '') := FUNCTION
     RETURN IF(ut.CleanSpacesAndUpper(sDate) = 'INDEFINITE' OR sDate = '' OR Scrubs.Functions.fn_general_yyyymmdd((STRING) STD.Date.FromStringToDate(sDate, '%m/%d/%Y')) > 0, 1, 0);
  END;

  //****************************************************************************
  //fn_alphanum: 	returns true if only populated with numbers and letters
  //****************************************************************************
  EXPORT fn_alphanum(STRING alphanum, UNSIGNED1 size = 0) := FUNCTION
    RETURN Scrubs.Functions.fn_alphanum(alphanum, size);
  END;


END;