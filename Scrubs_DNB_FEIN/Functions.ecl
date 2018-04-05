IMPORT ut, Scrubs, Codes;

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
  EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '') := FUNCTION
    RETURN IF(LENGTH(TRIM(str1 + str2 + str3 + str4 + str5, ALL)) > 0,1,0);
  END;




//*********************************************************//
//***************END GENERAL PURPOSE SECTION***************//
//*********************************************************//
//***************BEGIN ID SECTION**************************//
//*********************************************************//




  //****************************************************************************
  //fn_tmsid: 	returns true or false based upon the incoming tmsid.
  //****************************************************************************
  EXPORT fn_tmsid(STRING tmsid) := FUNCTION
    tmsid_clean := ut.CleanSpacesAndUpper(tmsid);
    
		  isValidLetter := IF(regexfind('DF', tmsid_clean[1..2]), TRUE, FALSE);
		  isValidNumber := IF(Stringlib.StringFilterOut(tmsid_clean[3..], '0123456789') = '', TRUE, FALSE);
		  isValidLength := IF(LENGTH(tmsid_clean) = 20 OR LENGTH(tmsid_clean) = 29, TRUE, FALSE);
    
    RETURN IF(isValidLetter AND isValidNumber AND isValidLength, 1, 0);
  END;




//*********************************************************//
//***************END ID SECTION****************************//
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
	 //fn_verify_phone:  returns true or false based upon whether its a valid
  //                  phone #
	 //****************************************************************************
	 EXPORT fn_verify_phone(STRING phone) := function    
    clean_phone := TRIM(phone, ALL);
    RETURN IF(ut.CleanPhone(clean_phone) != '', 1, 0);
  END;




//*********************************************************//
//***************END ADDRESS SECTION***********************//
//*********************************************************//
//***************BEGIN GENERAL SECTION*********************//
//*********************************************************//




  //****************************************************************************
	 //fn_sic_code:  returns true or false based upon whether or not there is
  //              an empty, 4-digit, or 8-digit value.
	 //****************************************************************************
	 EXPORT fn_sic_code(STRING sic) := function    
		  RETURN IF((sic = '' OR LENGTH(sic) = 4 OR LENGTH(sic) = 8) AND
              Stringlib.StringFilterOut(sic, '0123456789') = '', 1, 0);
  END;

  //****************************************************************************
	 //fn_duns:  returns true or false based upon whether or not there is
  //          an empty or 9-digit value.
	 //****************************************************************************
	 EXPORT fn_duns(STRING duns) := function    
		  RETURN IF((duns = '' OR LENGTH(duns) = 9) AND
              Stringlib.StringFilterOut(duns, '0123456789') = '', 1, 0);
  END;

  //****************************************************************************
	 //fn_valid_name:  returns true or false based upon whether the name was 
  //                was cleaned successfully.
	 //****************************************************************************
	 EXPORT fn_valid_name(STRING lname, STRING mname, STRING fname, STRING raw_name) := function    
		  RETURN IF(fn_populated_strings(raw_name) = 1, 
              IF(fn_populated_strings(fname, mname, lname) = 1, 1, 0),
              1);
  END;




//*********************************************************//
//***************END GENERAL SECTION***********************//
//*********************************************************//
    
END; //End Functions Module