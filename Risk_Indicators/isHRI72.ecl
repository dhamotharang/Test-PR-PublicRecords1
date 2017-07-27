export isHRI72(Layout_Output l) := 
FUNCTION
	
	RETURN l.socsverlevel in [1,2,3,4,5,8] and LENGTH(Stringlib.StringFilter(l.ssn,'0123456789'))=9;

END;