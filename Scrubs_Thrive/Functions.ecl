IMPORT Scrubs_Thrive, Scrubs, ut, _validate, std;
	
EXPORT Functions := MODULE

  
		
	//****************************************************************************
  //fn_alphanum: 	returns true if only populated with letters,1,2,3,4, and a few symbols
  //****************************************************************************
  EXPORT fn_alphanum(STRING alpha, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(alpha, ALL)) > 0, LENGTH(TRIM(alpha, ALL)) >= size) AND
              Stringlib.StringFilterOut(alpha, ' 1234ABCDEFGHIJKLMNOPQRSTUVWXYZ\'-.') = '',1,0);
  END;	
	
	//****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;
	
	//********************************************************************************
	//fn_invalid_addr:  returns true if length not 1 or greater, or contains bad addresses
	//********************************************************************************
	EXPORT fn_invalid_addr(STRING s) := function    
	  RETURN IF(LENGTH(s) > 1 AND NOT REGEXFIND('^JR$|#NAME?|^CALL$|UNSTATED|^NONE$|N/A|GENERAL DELIVERY',ut.fnTrim2Upper(s)),1,0);
  END;
	
	//********************************************************************************
	//fn_invalid_date:  Returns true if valid past date.
	//********************************************************************************
	EXPORT fn_invalid_date(STRING s) := function   
     Dte_time := Std.Str.SplitWords(s,' ');	 
		 dte_str := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(Dte_time[1]);
		 RETURN IF(Scrubs.Functions.fn_past_yyyymmdd(dte_str) > 0, 1, 0);
  END;
	
	
END;