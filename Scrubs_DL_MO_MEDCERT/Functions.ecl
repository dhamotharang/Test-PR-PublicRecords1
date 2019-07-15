IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE

	//****************************************************************************
	//fn_verify_state: returns true or false based upon whether or not there is
	// a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function

		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);

	END;
  
	//****************************************************************************
	//fn_alphanumeric: returns true if only populated with numbers or letters
	//****************************************************************************
	EXPORT fn_alphanumeric(STRING alphanum, UNSIGNED1 size = 0) := FUNCTION

		RETURN IF(IF(size = 0, LENGTH(TRIM(alphanum, ALL)) > 0, LENGTH(TRIM(alphanum, ALL)) = size) AND
		Stringlib.StringFilterOut(alphanum,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789') ='', 1, 0);

	END;

	//****************************************************************************
	//fn_numeric: returns true if only populated with numbers !
	//****************************************************************************
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION

		RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
		Stringlib.StringFilterOut(nmbr,'0123456789') ='' and (integer)nmbr<>0, 1, 0);

	END;
	
	//****************************************************************************
	//fn_chk_blanks: returns true if the value is populated
	//****************************************************************************
	EXPORT fn_chk_blanks(STRING Busname) := FUNCTION
	
		RETURN IF(LENGTH(TRIM(Busname, ALL)) > 0, 1, 0);
	
	END;

	//****************************************************************************
	//fn_verify_zip5: returns true or false based upon whether or not there is
	// a 5-digit numeric value.
	//****************************************************************************
	EXPORT fn_verify_zip5(STRING zip5) := function 

		RETURN IF(LENGTH(trim(zip5, all)) = 5 AND Stringlib.StringFilterOut(trim(zip5, all),'0123456789') ='', 1, 0);

	END;

	//****************************************************************************
	//fn_verify_zip4: returns true or false based upon whether or not there is
	// a 4-digit value.
	//****************************************************************************
	EXPORT fn_verify_zip4(STRING zip4) := function  

		RETURN IF(LENGTH(trim(zip4, all)) = 4 AND Stringlib.StringFilterOut(trim(zip4, all),'0123456789') ='', 1, 0);

	END;

	//****************************************************************************
	//fn_mailing_zip: returns true or false based upon whether or not there is
	// a 9-digit or 5-digit numeric value.
	//****************************************************************************
	EXPORT fn_mailing_zip(STRING mzip) := function 

		RETURN IF(LENGTH(trim(mzip, all)) in [ 5,9] AND Stringlib.StringFilterOut(trim(mzip, all),'0123456789') ='', 1, 0);

	END;

  //****************************************************************************
	//fn_chk_people_names: returns true only for names of alpha and with special characters 
	//returns false** for blanks (OR) only special characters in names with no valid data
	//****************************************************************************
	EXPORT fn_chk_people_names(STRING str1, STRING str2= '', STRING str3= '' ) := FUNCTION

		PatternValidChar		:= '[A-Z]|\\x2D|\\x2E|\\x27|\\x26|\\x20';//alpha or with [-.'& space] these characters allowed
		name_str						:= ut.CleanSpacesAndUpper(str1) + ut.CleanSpacesAndUpper(str2) + ut.CleanSpacesAndUpper(str3);	
		RETURN IF(regexreplace(PatternValidChar, name_str, '')!='' or regexreplace('\\x2D|\\x2E|\\x27|\\x26', name_str, '')='', 0, 1);

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

	//*******************************************************************************
	//fn_valid_past_date: 	returns true or false based upon the incoming date.
	//Returns true if valid past date
	//*******************************************************************************
	EXPORT fn_valid_past_date(STRING sDate) := FUNCTION

		clean_date  := TRIM(sDate, ALL);
		isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_pastDate(clean_date) > 0, FALSE);
		RETURN IF(isValidDate, 1, 0);
		
	END;

	//****************************************************************************
	//fn_valid_general_Date: returns true or false based upon whether or not there is
	//               a valid date.
	//****************************************************************************
	EXPORT fn_valid_general_Date(STRING sDate) := FUNCTION

		clean_date  := TRIM(sDate, ALL);
		isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_GeneralDate(clean_date) > 0, FALSE);
		RETURN IF(isValidDate, 1, 0);
	
	END;
	
	//****************************************************************************
	//license_transType: returns true or false based upon the incoming code.
	//****************************************************************************
	EXPORT license_transType(STRING s) := FUNCTION
	
		 Tc							  := ut.CleanSpacesAndUpper(s);
		 list					    := ['AA','DA','DO','DP','NA','NP','OA','PA','RA','RO','RW',
													'WA','01','02','03','04','10','11','12','13','14','15',
													'16','17','18','20','21','22','23','24','25','26','27',
													'28','30','31','32','33','34','35','40','41','42','50',
													'51','52','60','61','62','70','71','72','80','81','82',
													'85','86','90','91'];
		 isValidCode			:= if(Tc in list ,true,false);																	 
		 RETURN if(isValidCode,1,0);
						 
	END;
	
	//****************************************************************************
	//action_counts: returns true or false based upon the incoming code.
	//****************************************************************************
	EXPORT action_counts(STRING s) := FUNCTION
	
		 ac							  := trim(s,all);
		 list					    := ['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15',
													'16','17','18','19','20','21','22','23','24','25','26','27','28','29',
													'30','31','32','33','34','35','36','37','38','39','40','41','42','43',
													'44','45','46','48','52','58','60','70'];
		 isValidCode			:= if(ac in list,true,false);																	 
		 RETURN if(isValidCode,1,0);
				 
	END;
	
	//****************************************************************************
	//conv_counts: returns true or false based upon the incoming code.
	//****************************************************************************
	EXPORT conv_counts(STRING s) := FUNCTION
	
		 c							  := trim(s,all);
		 list					    := ['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16',
													'17','18','19','20','21','22','23','24','25','26','27','28','29','30','31',
													'32','33','34','35','36','37','38','39','40','41','42','43','44','45','46',
													'47','49','51','58','59','60','61'];
		 isValidCode			:= if(c in list,true,false);																	 
		 RETURN if(isValidCode,1,0);
				 
	END;
		
END; 