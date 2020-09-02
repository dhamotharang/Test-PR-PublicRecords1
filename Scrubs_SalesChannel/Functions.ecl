IMPORT Scrubs;

EXPORT Functions := MODULE



	//********************************************************************************
	//fn_ASCII_printable:  returns true if all the characters are valid ASCII chars
	//********************************************************************************
	EXPORT fn_ASCII_printable(STRING s) := function    
	  RETURN Scrubs.Functions.fn_ASCII_printable(TRIM(s, WHITESPACE));
    END;
	
END; //End Functions Module