IMPORT ut, Scrubs, Codes, Scrubs_SKA;

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
  //fn_populated_strings: 	returns true if one of the strings is populated
  //****************************************************************************
  EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '', STRING str6 = '') := FUNCTION
    RETURN IF(LENGTH(TRIM(str1 + str2 + str3 + str4 + str5 + str6, ALL)) > 0,1,0);
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

  //****************************************************************************
  //fn_alpha_opt: 	returns true if only populated with letters or empty
  //****************************************************************************
  EXPORT fn_alpha_opt(STRING str, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(str, ALL)) > 0, LENGTH(TRIM(str, ALL)) = size OR LENGTH(TRIM(str, ALL)) = 0) AND
              Stringlib.StringFilterOut(str, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_') = '',1,0);
  END;

  //****************************************************************************
  //fn_numeric_opt: 	returns true if only populated with numbers or empty
  //****************************************************************************
  EXPORT fn_numeric_opt(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size OR LENGTH(TRIM(nmbr, ALL)) = 0) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;

  //****************************************************************************
  //fn_alpha: 	returns true if only populated with letters
  //****************************************************************************
  EXPORT fn_alpha(STRING alpha, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(alpha, ALL)) > 0, LENGTH(TRIM(alpha, ALL)) = size) AND
              Stringlib.StringFilterOut(alpha, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',1,0);
  END;

  //*******************************************************************************
  //fn_str1_xor_str2_xor_str3: 	returns true or false based upon the values.
  //													
  //Returns true if all are populated or if all are empty
  //*******************************************************************************
  EXPORT fn_str1_xor_str2_xor_str3(STRING str1, STRING str2, STRING str3) := FUNCTION
    clean_str1   := TRIM(str1, ALL);
    clean_str2   := TRIM(str2, ALL);
    clean_str3   := TRIM(str3, ALL);
    RETURN IF((clean_str1 != '' AND clean_str2 != '' AND clean_str3 != '') OR
              (clean_str1  = '' AND clean_str2  = '' AND clean_str3  = ''), 1, 0);   
  END;

  //*******************************************************************************
  //fn_str1_only_if_str2: 	returns true or false based upon the values.
  //													
  //Returns true if str1 empty or if both str1 and str2 are populated
  //*******************************************************************************
  EXPORT fn_str1_only_if_str2(STRING str1, STRING str2) := FUNCTION
    clean_str1   := TRIM(str1, ALL);
    clean_str2   := TRIM(str2, ALL);
    RETURN IF(clean_str1 = '' OR clean_str2 != '', 1, 0);   
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
  //fn_verify_zip:  returns true or false based upon whether or not there is
  //                a valid zip format.
  //****************************************************************************
  EXPORT fn_verify_zip(STRING zip) := function
    cleaned_zip := Stringlib.StringFilterOut(zip, ' -'); 
    RETURN IF(LENGTH(cleaned_zip) IN [5,9] AND Stringlib.StringFilterOut(cleaned_zip, '0123456789') = '', 1, 0);
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

  //****************************************************************************
  //fn_verify_phone:  returns true or false based upon whether or not there is
  //                  a valid phone number.
  //****************************************************************************
  EXPORT fn_verify_phone(STRING phone) := function
    cleaned_phone := ut.CleanPhone(phone); 
    RETURN IF(LENGTH(cleaned_phone) = 10 AND Stringlib.StringFilterOut(cleaned_phone, '0123456789') = '', 1, 0);
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
  
  
  

//*********************************************************//
//***************END DATE/TIME SECTION*********************//
//*********************************************************//
//***************BEGIN SPECIAL SECTION*********************//
//*********************************************************//




  //****************************************************************************
  //fn_spec_expl: 	returns true if both populated or certain string in expl
  //****************************************************************************
  EXPORT fn_spec_expl(STRING expl, STRING spec) := FUNCTION
    clean_expl   := TRIM(expl, LEFT, RIGHT);
    clean_spec   := TRIM(spec, ALL);
    RETURN IF((clean_spec != '' AND clean_expl != '') OR (clean_spec = '' AND clean_expl = 'SPECIALTY IS NOT SPECIFIED'), 1, 0);   
  END;




//*********************************************************//
//***************BEGIN SPECIAL SECTION*********************//
//*********************************************************//
    
END; //End Functions Module