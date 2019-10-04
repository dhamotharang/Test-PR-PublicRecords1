IMPORT Scrubs_Thrive, Scrubs, ut, _validate, std;
	
EXPORT Functions := MODULE
		
	
	//************************************************************************************
	//fn_invalid_addr:  returns true if length not 1 or greater, or contains bad addresses
	//************************************************************************************
	EXPORT fn_invalid_addr(STRING s) := function  
    cln_str := ut.CleanSpacesAndUpper(s);
	  RETURN IF(LENGTH(cln_str) > 1 AND NOT REGEXFIND('^JR$|#NAME?|^CALL$|UNSTATED|^NONE$|N/A|GENERAL DELIVERY',cln_str),1,0);
  END;
	
	//**********************************************************************************************
  //fn_chk_city: 	returns true if only populated with numbers, letters and some special characters
  //**********************************************************************************************
  EXPORT fn_chk_city(STRING citystr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(citystr, ALL)) > 0, LENGTH(TRIM(citystr, ALL)) = size) AND
              Stringlib.StringFilterOut(citystr, 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\' ') = '',1,0);
  END;
	
	//********************************************************************************
	//fn_invalid_date:  Returns true if valid past date.
	//********************************************************************************
	EXPORT fn_invalid_date(STRING s) := function   
     Dte_time := Std.Str.SplitWords(s,' ');	 
		 dte_str := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(Dte_time[1]);
		 RETURN IF(Scrubs.Functions.fn_past_yyyymmdd(dte_str) > 0, 1, 0);
  END;
	
	//****************************************************************************
	//fn_chk_blank_names: returns true only for names of alpha or with ['- ] characters 
	//****************************************************************************
	EXPORT fn_chk_blank_names(STRING f, STRING m, STRING l ) := FUNCTION

		//Note:Hex values are as follows:x27=>';x2D=>-
		PatternValidChar		:= '[A-Z]|\\x2D|\\x27';
		name								:= ut.CleanSpacesAndUpper(f) +  ut.CleanSpacesAndUpper(m) + ut.CleanSpacesAndUpper(l);	
		RETURN IF(regexreplace(PatternValidChar,name,'')!='' or length(name)=0 ,0,1);
	END;
	
	//**********************************************************************************************
  //fn_chk_email: 	returns true if only populated with numbers, letters and some special characters
  //**********************************************************************************************
  EXPORT fn_chk_email(STRING emailstr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(emailstr, ALL)) > 0, LENGTH(TRIM(emailstr, ALL)) = size) AND
              Stringlib.StringFilterOut(emailstr, ' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&\\!#$%*/:?{|}~+=()^`><') = '',1,0);
  END;
	
	
	//**********************************************************************************************
  //fn_chk_employer: 	returns true if only populated with numbers, letters and some special characters
  //**********************************************************************************************
  EXPORT fn_chk_employer(STRING fn_chk_employer, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(fn_chk_employer, ALL)) > 0, LENGTH(TRIM(fn_chk_employer, ALL)) = size) AND
              Stringlib.StringFilterOut(fn_chk_employer, '0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-_,;\'&./+()#!:%& ') = '',1,0);
  END;
END;