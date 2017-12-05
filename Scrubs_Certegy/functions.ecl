IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE

	//****************************************************************************
	//fn_verify_state: returns true or false based upon whether or not there is
	//                  a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function  

		list:=['AL','AK','AR','AS','AZ','CA','CO','CT','DC','DE','FL',
					 'GA','GU','HI','IA','ID','IL','IN','KS','KY','LA','MA',
					 'MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH',
					 'NJ','NM','NV','NY','OH','OK','OR','PA','PR','RI','SC',
					 'SD','TN','TX','US','UT','VA','VI','VT','WA','WI','WV',
					 'WY'];
		RETURN IF(ut.CleanSpacesAndUpper(code)in list , 1, 0);

	END;  

	//****************************************************************************
	//fn_verify_zip5: returns true or false based upon whether or not there is
	//  a 5-digit numeric value.
	//****************************************************************************
	EXPORT fn_verify_zip5(STRING zip5) := function 

		RETURN IF(LENGTH(trim(zip5,all)) = 5 AND Stringlib.StringFilterOut(trim(zip5,all), '0123456789') = '', 1, 0);

	END;

	//****************************************************************************
	//fn_verify_zip4: returns true or false based upon whether or not there is
	//                 a 4-digit value.
	//****************************************************************************
	EXPORT fn_verify_zip4(STRING zip4) := function  

		RETURN IF(LENGTH(trim(zip4,all)) = 4 AND Stringlib.StringFilterOut(trim(zip4,all), '0123456789') = '', 1, 0);

	END;

	//*******************************************************************************
	//fn_general_date: returns true or false based upon the incoming date.
	//Returns true if it's a valid date
	//*******************************************************************************
	EXPORT fn_general_date(STRING10 sDate) := FUNCTION

		clean_date  := sDate[1..4]+sDate[6..7]+sDate[9..10];
		isValidDate := IF(Scrubs.fn_valid_GeneralDate(clean_date)>0 ,true ,false);

		RETURN IF(isValidDate, 1, 0);

	END;

	//*******************************************************************************
	//fn_past_date: returns true or false based upon the incoming date.
	//Returns true if valid past date
	//*******************************************************************************
	EXPORT fn_past_date(STRING10 sDate) := FUNCTION

		clean_date  := sDate[1..4]+sDate[6..7]+sDate[9..10];
		isValidDate := if(Scrubs.fn_valid_pastDate(clean_date)>0 ,true ,false);

		RETURN IF(isValidDate, 1, 0);

	END;

	//*******************************************************************************
	//fn_deceased_dte: returns true or false based upon the incoming date.
	//Returns true [if deceased_dte is a past date and it should be greater than date of birth OR for blank values]
	//*******************************************************************************
	EXPORT fn_deceased_dte(STRING10 deceas, STRING10 dob) := FUNCTION

		clean_deceas  := deceas[1..4]+deceas[6..7]+deceas[9..10];
		clean_dob  		:= dob[1..4]+dob[6..7]+dob[9..10];
		isPast_dt 		:= if(Scrubs.fn_valid_pastDate(clean_deceas)>0 ,true ,false);
		ispast_gtDob  := if(isPast_dt and clean_deceas>clean_dob ,true ,false);

		RETURN IF(ispast_gtDob  or trim(clean_deceas,all) = '', 1, 0);

	END;

	//****************************************************************************
	//fn_tel_ext: returns true if its numeric value or blank!!
	//****************************************************************************
	EXPORT fn_tel_ext(STRING tel_ext ) := FUNCTION

		RETURN IF(regexreplace('[0-9]', trim(tel_ext, all), '')= ''or trim(tel_ext,all) = '', 1, 0);

	END;
	
	//****************************************************************************
	//fn_CleanPhone: returns true if its a valid phone number!!
	//****************************************************************************
	EXPORT fn_CleanPhone(STRING3 ph_a, STRING7 ph_n ) := FUNCTION

		RETURN IF(ut.CleanPhone(ph_a + ph_n) != '', 1, 0);

	END;

	//****************************************************************************
	//fn_gen_del: returns true only for values,Starts with [PO BOX |P.O. BOX |P O BOX] OR  blank values!
	//****************************************************************************
	EXPORT fn_gen_del(STRING gen_del ) := FUNCTION
	
		PatternPOBOX:='(^PO BOX|^P.O. BOX|^P O BOX)';
		RETURN if(regexfind(PatternPOBOX,ut.CleanSpacesAndUpper(gen_del),0)<>'' or trim(gen_del,all)='',1,0);

	END;;

	//****************************************************************************
	//fn_chk_blank_names: returns true only for names of alpha or with ['- ] characters 
	//****************************************************************************
	EXPORT fn_chk_blank_names(STRING f, STRING m, STRING l ) := FUNCTION

		//Note:Hex values are as follows:x27=>';x2D=>-
		PatternValidChar		:= '[A-Z]|\\x2D|\\x27';
		name								:= ut.CleanSpacesAndUpper(f) + ut.CleanSpacesAndUpper(m) + ut.CleanSpacesAndUpper(l);	
		RETURN IF(regexreplace(PatternValidChar,name,'')!='' or length(name)=0 ,0,1);
	END;

	//****************************************************************************
	//fn_valid_ssn: returns true only for numeric values of length [9,4]---returns false for all zero's [ex:000000000,0000]
	//****************************************************************************
	EXPORT fn_valid_ssn(STRING9 ssn ) := FUNCTION

		RETURN IF(regexreplace('[0-9]', trim(ssn, all), '')= '' and length(trim(ssn, all))in [9,4] and (integer)trim(ssn, all)!=0, 1, 0);

	END;

END;
