IMPORT Scrubs_OneKey, Scrubs, ut, STD;
	
EXPORT Functions := MODULE



//*********************************************************//
//***************BEGIN GENERAL PURPOSE SECTION*************//
//*********************************************************//



  //****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN Scrubs.Functions.fn_numeric(nmbr, size);
  END;
  
  //****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric_nonzero(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(Scrubs.Functions.fn_numeric(nmbr, size) > 0 AND nmbr != '0', 1, 0);
  END;

  //****************************************************************************
  //fn_numeric_optional:   returns true if only populated with numbers and
  //                       length equals size or empty
  //****************************************************************************
  EXPORT fn_numeric_optional(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN Scrubs.Functions.fn_numeric_optional(nmbr, size);
  END;

  //****************************************************************************
  //fn_populated_strings: 	returns true if one of the strings is populated
  //****************************************************************************
  EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '') := FUNCTION
    RETURN Scrubs.Functions.fn_populated_strings(str1, str2, str3, str4, str5);
  END;

  //*******************************************************************************
  //fn_str1_xor_str2: 	returns true or false based upon the values.
  //													
  //Returns true if both are populated or if both are empty
  //*******************************************************************************
  EXPORT fn_str1_xor_str2(STRING str1, STRING str2) := FUNCTION
    RETURN Scrubs.Functions.fn_str1_xor_str2(str1, str2);   
  END;

  //*******************************************************************************
  //fn_str1_xor_str2: 	returns true or false based upon the values.
  //													
  //Returns true if both are populated or if both are empty
  //*******************************************************************************
  EXPORT fn_str1_xor_str2_xor_str3(STRING str1, STRING str2, STRING str3) := FUNCTION
    RETURN IF(Scrubs.Functions.fn_str1_xor_str2(str1, str2) = 1 AND Scrubs.Functions.fn_str1_xor_str2(str1, str3) = 1, 1, 0);   
  END;



//*********************************************************//
//***************END GENERAL PURPOSE SECTION***************//
//*********************************************************//
//***************BEGIN DATE/TIME SECTION*******************//
//*********************************************************//



  //*******************************************************************************
  //fn_past_yyyymmdd: 	Returns true if valid past date. If the can_be_zero parameter
  //                   is set to TRUE then the sDate can be zero.
  //*******************************************************************************
  EXPORT fn_past_yyyymmdd(STRING sDate, BOOLEAN can_be_zero = FALSE) := FUNCTION 
    RETURN Scrubs.Functions.fn_past_yyyymmdd(sDate, can_be_zero);
  END;

  //*******************************************************************************
  //fn_mm_dd_yyyy: 	Returns true if valid date. If the can_be_zero parameter
  //                is set to TRUE then the sDate can be zero.
  //*******************************************************************************
  EXPORT fn_mm_dd_yyyy(STRING sDate, BOOLEAN can_be_zero =  TRUE) := FUNCTION 
    RETURN Scrubs.Functions.fn_general_yyyymmdd((STRING)STD.Date.FromStringToDate(sDate, '%Y-%m-%d'), can_be_zero);
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
    RETURN Scrubs.Functions.fn_Valid_StateAbbrev(st);
  END;


    

//*********************************************************//
//***************END ADDRESS SECTION***********************//
//*********************************************************//
//***************BEGIN PUB-SPECIFIC SECTION****************//
//*********************************************************//



  //*******************************************************************************
  //fn_onekey_id: 	returns true or false whether it matches "WUS"{alpha}{num}(8) pattern.
  //													
  //Returns true the string matches the pattern
  //*******************************************************************************
  EXPORT fn_onekey_id(STRING ok_id) := FUNCTION
    clean_ok_id := TRIM(ok_id, LEFT, RIGHT);
    RETURN IF(LENGTH(clean_ok_id) = 12 AND clean_ok_id[1..3] = 'WUS' AND Stringlib.StringFilterOut(clean_ok_id[5..12], '0123456789') = '', 1, 0);
  END;

  //*******************************************************************************
  //fn_onekey_id: 	returns true or false whether it matches "WUS"{alpha}{num}(8) pattern.
  //													
  //Returns true the string matches the pattern
  //*******************************************************************************
  EXPORT fn_hcp_affil_xid(STRING xid, STRING hcp_hce_id, STRING hco_hce_id, STRING titl_typ_id) := FUNCTION
    clean_xid  := TRIM(xid, LEFT, RIGHT);
    clean_hcp  := TRIM(hcp_hce_id, LEFT, RIGHT);
    clean_hco  := TRIM(hco_hce_id, LEFT, RIGHT);
    clean_titl := TRIM(titl_typ_id, LEFT, RIGHT);
    RETURN CASE(Stringlib.StringFilterOut(clean_xid, '0123456789'), 
                ''    => IF(clean_xid = clean_hcp + clean_hco, 1, 0),
                '.'   => IF(clean_xid = clean_hcp + clean_hco + '.' + INTFORMAT((INTEGER)clean_titl, 4, 1), 1, 0),
                0
               );
  END;



//*********************************************************//
//***************END PUB-SPECIFIC SECTION******************//
//*********************************************************//

END;