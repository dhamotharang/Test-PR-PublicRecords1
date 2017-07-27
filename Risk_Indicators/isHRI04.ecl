export isHRI04(Layout_Output l) := 
FUNCTION
	
	RETURN l.lastcount>=1 AND l.socscount>=1 AND l.addrcount=0 AND 
		  ((l.phonever_type='P' and l.phonelastcount=0 AND l.phonephonecount>=1 AND l.phoneaddrcount>=1) OR
		  (l.phonever_type='A' and l.phoneaddr_lastcount=0 and l.phoneaddr_phonecount>=1 and l.phoneaddr_addrcount>=1) OR
		  (l.phonever_type='U' and l.utiliaddr_lastcount=0 and l.utiliaddr_phonecount>=1 and l.utiliaddr_addrcount>=1));

END;