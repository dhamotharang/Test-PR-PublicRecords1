export isHRI38(Layout_Output l) := 
FUNCTION
	
	RETURN (l.altlast<>'' and l.socscount>0 and l.lastcount>0) OR (l.altlast2<>'');

END;