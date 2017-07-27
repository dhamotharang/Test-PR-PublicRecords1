export mod_SSNParse(string9 SSN) := 
module

/*
Rules:
1) If SSN is less than 4 digits, SSN4 and SSN5 will be empty.
2) If SSN is 4 digits, it is SSN4 and SSN5 is empty.
3) If SSN is 5 digits, it is SSN5 and SSN4 is empty.
4) If SSN is 6-8 digits, zero pad to the right to form a 9 digit SSN.
5) If SSN is 9 digits, SSN5 is first 5 and SSN4 is last 4.
*/

shared trm := trim(ssn, left, right);
shared len := length(trm);

shared trm9 := (trm + '000000000')[1..9];//this is just a 9 digit, zero padded (to the right) version of trm

export ssn4 := 
map(
	len < 4 => '',
	len = 4 => trm	,
	len = 5 => '',
	len = 9 => trm[6..9], //technically dont need this line, but it may be more clear
	trm9[6..9] 	//all thats left is len 6-8
);	

export ssn5 := 
map(
	len < 4 => '',
	len = 4 => ''	,
	len = 5 => trm,
	len = 9 => trm[1..5], //technically dont need this line, but it may be more clear
	trm9[1..5] 	//all thats left is len 6-8
);	

end;