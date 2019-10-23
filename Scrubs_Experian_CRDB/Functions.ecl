IMPORT ut, Scrubs, Codes, _validate;

EXPORT Functions := MODULE

	//****************************************************************************
	//fn_valid year: returns true if its a valid year!!
	//****************************************************************************
	EXPORT fn_valid_year(STRING yr) := FUNCTION

		RETURN if(stringlib.stringfilter(yr,'0123456789') <> '' and
							_validate.date.fIsValid(stringlib.stringfilter(yr,'0123456789'), _validate.date.Rules.YearValid)
							or trim(yr, all)='', 1, 0);

	END;
	
	//****************************************************************************
	//fn_CleanPhone: returns true if its a valid phone number!!
	//****************************************************************************
	EXPORT fn_CleanPhone(STRING ph_a ) := FUNCTION

		RETURN IF(ut.CleanPhone(ph_a) != '' or trim(ph_a, all)='', 1, 0);

	END;

	//****************************************************************************
	//fn_verify_zip5: returns true or false based upon whether or not there is
	// a 5-digit numeric value.
	//****************************************************************************
	EXPORT fn_verify_zip5(STRING zip5) := function 

		RETURN IF(LENGTH(trim(zip5, all)) = 5 AND Stringlib.StringFilterOut(trim(zip5, all), '0123456789') = '', 1, 0);

	END;

	//****************************************************************************
	//fn_verify_zip4: returns true or false based upon whether or not there is
	// a 4-digit value.
	//****************************************************************************
	EXPORT fn_verify_zip4(STRING zip4) := function  

		RETURN IF(LENGTH(trim(zip4, all)) = 4 AND Stringlib.StringFilterOut(trim(zip4, all), '0123456789') = '', 1, 0);

	END;

	//****************************************************************************
	//fn_range_numeric: returns true if number in range
	//****************************************************************************
	EXPORT fn_range_numeric(STRING nmbr, UNSIGNED6 lbound, UNSIGNED6 ubound) := FUNCTION

		RETURN IF((UNSIGNED6)nmbr >= lbound AND (UNSIGNED6)nmbr <= ubound, 1, 0);

	END;

	//****************************************************************************
	//fn_chk_people_names: returns true only for names of alpha and with special characters 
	// returns false** for blank Or only allowed special[-.'&]characters in names,nothing else!
	//****************************************************************************
	EXPORT fn_chk_people_names(STRING f, STRING m= '', STRING l= '' ) := FUNCTION

		PatternValidChar		:= '[A-Z]|\\x2D|\\x2E|\\x27|\\x26|\\x20';//alpha or with [-.'& space] these characters allowed
		name								:= ut.CleanSpacesAndUpper(f) + ut.CleanSpacesAndUpper(m) + ut.CleanSpacesAndUpper(l);	
		RETURN IF(regexreplace(PatternValidChar, name, '')!='' or regexreplace('\\x2D|\\x2E|\\x27|\\x26', name, '')='', 0, 1);

	END;

  //****************************************************************************
  //fn_chk_blanks: returns true if the value is populated
  //****************************************************************************
  EXPORT fn_chk_blanks(STRING Busname) := FUNCTION
    RETURN IF(LENGTH(TRIM(Busname, ALL)) > 0, 1, 0);
  END;
  
  //****************************************************************************
  //fn_clean_dba_name: returns true if dba_name is populated then clean value should be
  //****************************************************************************
   EXPORT fn_clean_dba_name(STRING clean_dba_name,STRING dba_name) := FUNCTION
       RETURN IF( TRIM(dba_name, ALL)<>'' and TRIM(clean_dba_name, ALL) ='', 0, 1);
   END;
  
   //****************************************************************************
   //fn_bName_pName: returns true either valid company_name or valid people names available in the data 
  //****************************************************************************
   EXPORT fn_bName_pName(STRING company_name,STRING f,STRING m,STRING l) := FUNCTION
    name	:= ut.CleanSpacesAndUpper(f) + ut.CleanSpacesAndUpper(m) + ut.CleanSpacesAndUpper(l);	
    RETURN IF( TRIM(name, ALL)<>'' or  TRIM(company_name, ALL)<>'' , 1, 0);
   END;
   
	//****************************************************************************
	//fn_geo_coord: returns true or false based upon the lat/long value.
	//****************************************************************************
	EXPORT fn_geo_coord(STRING geo) := FUNCTION

		geo_clean := TRIM(geo, ALL);
		//Verifying the pattern for coordinates is an optional negative sign (-), 
		//followed by at least 1 digit, followed by decimal (.), and ending
		//with at least 1 digit
		RETURN IF(regexfind('^-?\\d+.\\d+$', geo_clean), 1, 0);

	END;

	//****************************************************************************
	//fn_alphanumeric: returns true if only populated with numbers or letters
	//****************************************************************************
	EXPORT fn_alphanumeric(STRING alphanum, UNSIGNED1 size = 0) := FUNCTION

		RETURN IF(IF(size = 0, LENGTH(TRIM(alphanum, ALL)) > 0, LENGTH(TRIM(alphanum, ALL)) = size) AND
		Stringlib.StringFilterOut(alphanum, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789') = '', 1, 0);

	END;

	//****************************************************************************
	//fn_numeric: returns true if only populated with numbers !
	//****************************************************************************
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION

		RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
		Stringlib.StringFilterOut(nmbr, '0123456789') = '' and (integer)nmbr<>0, 1, 0);

	END;

	//****************************************************************************
	//fn_sic_code: returns true if sic codes are numberic digits in [0,4,8] length! 
	//per rosemary ,allow 6 lenght sic codes for CRDB as they appear as is** online !
	//****************************************************************************
	EXPORT fn_sic_code(STRING sic_cd) := FUNCTION

		RETURN IF(LENGTH(TRIM(sic_cd, ALL))in [0,4,6,8] AND
							Stringlib.StringFilterOut(sic_cd, '0123456789') = '' , 1, 0);

	END;
	
	//****************************************************************************
	//fn_naics_code: returns true if naics codes are numberic digits in [0,6] length!
	//****************************************************************************
	EXPORT fn_naics_code(STRING naics_cd) := FUNCTION

		RETURN IF(LENGTH(TRIM(naics_cd, ALL))in [0,6] AND
							Stringlib.StringFilterOut(naics_cd, '0123456789') = '' , 1, 0);

	END;
	
	//*******************************************************************************
	//fn_past_yyyymmdd: returns true or false based upon the incoming date.
	//Returns true if valid past date
	//*******************************************************************************
	EXPORT fn_past_yyyymmdd(STRING sDate) := FUNCTION

		clean_date  := TRIM(sDate, ALL);
		isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_pastDate(clean_date) > 0, FALSE);
		RETURN IF(isValidDate, 1, 0);

	END;

	//****************************************************************************
	//fn_verify_state: returns true or false based upon whether or not there is
	// a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function
    
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);

	END;

END;