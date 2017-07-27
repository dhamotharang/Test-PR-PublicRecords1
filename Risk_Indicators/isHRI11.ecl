export isHRI11(Layout_Output l) := 
FUNCTION
	
	RETURN l.addrvalflag='N' and l.in_streetAddress<>'' and l.in_city<>'' and l.in_state<>'' and l.in_zipCode<>'';

END;