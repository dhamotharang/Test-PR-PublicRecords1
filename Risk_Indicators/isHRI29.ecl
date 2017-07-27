export isHRI29(STRING9 corrected_ssn) := 
FUNCTION
	
	//RETURN l.socsmiskeyflag=true;
	RETURN corrected_ssn<>'';

END;