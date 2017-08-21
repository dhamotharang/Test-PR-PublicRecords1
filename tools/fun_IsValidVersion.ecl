export fun_IsValidVersion(string pversion) := 
	regexfind('^[[:digit:]]{6,8}[[:alpha:]]?$',pversion);
