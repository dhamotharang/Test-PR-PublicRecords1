IMPORT ut, Scrubs, Codes, _validate;

EXPORT Functions := MODULE
	
	//****************************************************************************
	//fn_numeric: returns true if only populated with numbers !
	//****************************************************************************
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION

		RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
		Stringlib.StringFilterOut(nmbr, '0123456789') = '' and (integer)nmbr<>0, 1, 0);

	END;

	//*******************************************************************************
	//fn_past_yyyymmdd: returns true or false based upon the incoming date.
	//Returns true if valid past* date
	//2017-07-16T16:48:09-0600 --Noticed in the data 
	//*******************************************************************************
	EXPORT fn_past_yyyymmdd(STRING sDate) := FUNCTION

		clean_date  := stringlib.stringfilterout(if( LENGTH(sDate) = 10, sDate, TRIM(sDate[1..10], ALL) ),'-');
		RETURN IF(Scrubs.fn_valid_pastDate(clean_date) > 0, 1, 0);

	END;

	//*******************************************************************************
	//fn_valid_yyyymmdd: returns true or false based upon the incoming date.
	//Returns true if valid* date
	//2018-03-06T16:48:09-0600 --Noticed in the data 
	//*******************************************************************************
	EXPORT fn_valid_yyyymmdd(STRING sDate) := FUNCTION

		clean_date  := stringlib.stringfilterout(if( LENGTH(sDate) = 10, sDate, TRIM(sDate[1..10], ALL) ),'-');
		RETURN IF(Scrubs.fn_valid_GeneralDate(clean_date) > 0, 1, 0);

	END;

	//****************************************************************************
	// fn_chk_names: returns true only for names of AlphaNumeric and with few special characters 
	// ex: "CAR WASH INVESTMENT GROUP, INC. #2 401 (K) PROFIT @ SHARING PLAN", "A+ ACQUISITIONS, INC. RETIREMENT PLAN" ,"JUST WIND, LLC 401(K)/PROFIT SHARING PLAN"                                                                                                  
  // returns false** for blanks Or only allowed special[*+ , -.# &'()/ @ ]special characters in names,nothing else!  
	//****************************************************************************
	EXPORT fn_chk_names(STRING n ) := FUNCTION

		PatternValidChar		:= '[A-Z]|[0-9]|\\x2A|\\x2B|\\x2C|\\x2D|\\x2E|\\x23|\\x26|\\x27|\\x28|\\x29|\\x2F|\\x40|\\x20';//alpha or with [*+ , -.# &'()/ @ space] characters allowed
		name								:= ut.CleanSpacesAndUpper(n);	
		RETURN IF(regexreplace(PatternValidChar, name, '')!='' or regexreplace('[0-9]|\\x2A|\\x2B|\\x2C|\\x2D|\\x2E|\\x23|\\x26|\\x27|\\x28|\\x29|\\x2F|\\x40', name, '')='', 0, 1);

	END;

	//****************************************************************************
	//fn_chk_blanks: returns true if the value is populated
	//****************************************************************************
	EXPORT fn_chk_blanks(STRING Addr1 ,STRING Addr2 ='') := FUNCTION
	
	  RETURN IF(LENGTH(TRIM(Addr1 + Addr2 , ALL)) > 0, 1, 0);
	 
	END;

	//****************************************************************************
	//fn_verify_state: returns true or false based upon whether or not there is
	// a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function

	  RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);

	END;

	//****************************************************************************
	//fn_verify_full_zip: returns true or false based upon whether or not there is
	// a numeric value.
	//****************************************************************************
	EXPORT fn_verify_full_zip(STRING zip) := function 

		RETURN IF(LENGTH(trim(zip, all)) in [5,9] AND Stringlib.StringFilterOut(trim(zip, all), '0123456789') = '', 1, 0);

	END;

	//****************************************************************************
	//fn_CleanPhone: returns true if it's a valid phone number!!
	//****************************************************************************
	EXPORT fn_CleanPhone(STRING ph_a ) := FUNCTION

	 RETURN IF(ut.CleanPhone(ph_a) != '' or trim(ph_a, all)='', 1, 0);

	END;
	
End;