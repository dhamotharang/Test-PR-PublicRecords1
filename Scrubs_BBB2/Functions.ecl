IMPORT ut, scrubs, codes, Corp2_Mapping, _validate;

EXPORT Functions := MODULE

  //****************************************************************************
  //fn_numeric:  Returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    
		RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
							
  END;

  //****************************************************************************
  //fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	//****************************************************************************
  EXPORT fn_verify_state(STRING code) := function    
	  
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
		
  END;

  //****************************************************************************
	//fn_verify_phone: returns true or false based upon whether its a valid phone # or empty
	//(888) USA-9550 -- Alphanumeric phones return false !!
	//****************************************************************************
	 EXPORT fn_verify_phone(STRING phone) := function    
    
		clean_phone := TRIM(phone, ALL);
    RETURN IF(clean_phone = '' OR ut.CleanPhone(clean_phone) != '', 1, 0);
		
   END;

  //*******************************************************************************
  //fn_past_yyyymmdd_yyyy: Returns true or false based upon the incoming date.
  //Returns true if valid date OR valid listing_year     
	//Ex:20180422 OR 2015
  //*******************************************************************************
  EXPORT fn_valid_general_yyyymmdd(STRING yyyy, STRING mm='', STRING dd='') := FUNCTION

    report_date := yyyy + intformat((unsigned1) mm, 2, 1)   + intformat((unsigned1) dd, 2, 1) ;
		isValidDate := IF(Scrubs.fn_valid_GeneralDate(report_date)>0      or 
		                  _validate.date.fIsValid(yyyy, _validate.date.Rules.YearValid) ,true ,false);
		RETURN IF(isValidDate, 1, 0);
		
  END;
  
	//*******************************************************************************
	//fn_valid_yyyymmdd: returns true or false based upon the incoming date.
	//Returns true if valid* date
	//3/31/2017  12:00:00 AM --Noticed in the data
	//*******************************************************************************
	EXPORT fn_valid_past_yyyymmdd(STRING sDate) := FUNCTION
	
		date  := Corp2_Mapping.fValidateDate(sDate[1..10],'MM/DD/CCYY').PastDate;
		RETURN IF(LENGTH(date)>0, 1, 0);

	END;
	
	//****************************************************************************
	//fn_chk_blanks: returns true if the value is populated
	//****************************************************************************
	EXPORT fn_chk_blanks(STRING s ) := FUNCTION
	
	  RETURN IF(LENGTH(TRIM(s, ALL)) > 0, 1, 0);
	 
	END;
	
	//****************************************************************************
	//fn_chk_country: 	returns true or false based upon the incoming value.
	//****************************************************************************
	EXPORT fn_chk_country(STRING s) := FUNCTION

		uc_s 		     := ut.CleanSpacesAndUpper(s);
		isValid_Cnty := map(uc_s in ['CAN','MEX','USA',''] => true,false);

		return if(isValid_Cnty,1,0);

	END;
	
  //The address values that are all commas & will be considered as blank address
	EXPORT fn_chk_blank_addr(STRING s) := function 
	
	 test:= map(Stringlib.StringFilterOut(s, ',') = '' => false,
							trim(s,all)=''  =>false,		
							trim(s,all)<>'' =>true,
							false);
	 RETURN IF(test, 1, 0);
	 
  END;
	
	//********************************************************************************
	//fn_url: spaces not permitted in a URLs !!
	//********************************************************************************
	EXPORT fn_url(STRING s) := function 
	
	 test:= map( trim(s,all)='' =>true,
							 StringLib.StringFind(s,' ',1)<>0=>false,
							 Stringlib.StringFilterOut(s, '0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\'-!#$%&*,./:;?@_{}~+=()') = '' => true,
							 false);
	 RETURN IF(test, 1, 0);
		
  END;
		
END;