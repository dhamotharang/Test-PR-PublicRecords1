export isHRI45(Layout_Output l) := 
FUNCTION
	
	RETURN l.lastcount=0 AND l.socscount>=1 AND l.addrcount>=1 AND 
		  ((l.phonever_type='P' and l.phonelastcount>=1 AND l.phonephonecount>=1 AND l.phoneaddrcount=0) OR
		  (l.phonever_type='A' and l.phoneaddr_lastcount>=1 and l.phoneaddr_phonecount>=1 and l.phoneaddr_addrcount=0) OR
		  (l.phonever_type='U' and l.utiliaddr_lastcount>=1 and l.utiliaddr_phonecount>=1 and l.utiliaddr_addrcount=0));

END;