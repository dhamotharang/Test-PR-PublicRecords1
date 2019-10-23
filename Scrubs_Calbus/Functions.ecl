IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE

	//****************************************************************************
	//fn_numeric: returns true if only populated with numbers !
	//****************************************************************************
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION

		RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
		Stringlib.StringFilterOut(nmbr, '0123456789') = '' and (integer)nmbr<>0, 1, 0);

	END;

	//****************************************************************************
	//fn_chk_blanks: returns true if the value is populated
	//****************************************************************************
	EXPORT fn_chk_blanks(STRING name) := FUNCTION
	
		RETURN IF(LENGTH(TRIM(name, ALL)) > 0, 1, 0);
	
	END;

	//*******************************************************************************
	//fn_general_date: returns true or false based upon the incoming date.
	//Returns true if it's a valid date
	//*******************************************************************************
	EXPORT fn_general_date(STRING10 sDate) := FUNCTION

		isValidDate := IF(Scrubs.fn_valid_GeneralDate(sDate)>0 ,true ,false);
		RETURN IF(isValidDate, 1, 0);

	END;
	
	EXPORT fn_district_code(STRING code) := FUNCTION
	
	  a_code 					 := ut.CleanSpacesAndUpper(code);
		isValid_district := CASE( a_code,
															'AA'  => TRUE,
															'AC'  => TRUE,
															'AP'  => TRUE,
															'AR'  => TRUE,
															'AS'  => TRUE,
															'BH'  => TRUE,
															'CH'  => TRUE,
															'DF'  => TRUE,
															'DFB' => TRUE,
															'EA'  => TRUE,
															'EH'  => TRUE,
															'EHC' => TRUE,
															'FH'  => TRUE,
															'FHA' => TRUE,
															'GH'  => TRUE,
															'GHC' => TRUE,
															'JH'  => TRUE,
															'JHF' => TRUE,
															'KH'  => TRUE,
															'KHM' => TRUE,
															'OH'  => TRUE,
															'OHA' => TRUE,
															'OHB' => TRUE,
															'OHC' => TRUE,
															'RC'  => TRUE,
															'SO'  => TRUE,
															''   	=> TRUE,
														  FALSE);
	RETURN IF(isValid_district,1,0);
	
	END;
	
	//****************************************************************************
	//fn_verify_state: returns true or false based upon whether or not there is
	// a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function

		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);

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
	
END; 