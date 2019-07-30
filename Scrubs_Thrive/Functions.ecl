IMPORT Scrubs_Thrive, Scrubs, ut, _validate, std;
	
EXPORT Functions := MODULE
		
	
	//********************************************************************************
	//fn_invalid_addr:  returns true if length not 1 or greater, or contains bad addresses
	//********************************************************************************
	EXPORT fn_invalid_addr(STRING s) := function    
	  RETURN IF(LENGTH(s) > 1 AND NOT REGEXFIND('^JR$|#NAME?|^CALL$|UNSTATED|^NONE$|N/A|GENERAL DELIVERY',ut.CleanSpacesAndUpper(s)),1,0);
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