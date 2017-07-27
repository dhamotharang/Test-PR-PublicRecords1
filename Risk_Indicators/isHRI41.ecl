export isHRI41(Layout_Output l) := 
FUNCTION
	
	RETURN l.drlcvalflag='1' or l.drlcvalflag='3';

END;