EXPORT Functions := MODULE

EXPORT JIRA_266(c1,c2,c3,c4,c5,c6,c7,c8):=FUNCTION

 res:= ((integer)c1 <=(integer)c2 ) and
			 ((integer)c2 <=(integer)c3 ) and
			 ((integer)c3 <=(integer)c4 ) and
			 ((integer)c4 <=(integer)c5 ) and
			 ((integer)c5 <=(integer)c6 ) and
			 ((integer)c6 <=(integer)c7 ) and
			 ((integer)c7 <=(integer)c8 );
			 
	RETURN res;				
	
END;

EXPORT JIRA_lessthanequal(c1,c2):=FUNCTION

 res:= (integer)c1 <=(integer)c2 ;
			 
	RETURN res;				
	
END;

EXPORT JIRA_greaterthanequal(c1,c2):=FUNCTION

 res:= (integer)c1 >=(integer)c2 ;
			 
	RETURN res;				
	
END;

EXPORT JIRA_equal(c1,c2):=FUNCTION

 res:= (integer)c1 =(integer)c2 ;
			 
	RETURN res;				
	
END;


END;