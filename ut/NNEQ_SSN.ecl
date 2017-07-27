export NNEQ_SSN(string9 ssn1, string9 ssn2) := ut.NNEQ(ssn1,ssn2) or
			((unsigned)ssn1 % 10000 = (unsigned)ssn2 % 10000 AND 
		(((unsigned)ssn1 div 10000) = 0 OR ((unsigned)ssn2 div 10000) = 0));