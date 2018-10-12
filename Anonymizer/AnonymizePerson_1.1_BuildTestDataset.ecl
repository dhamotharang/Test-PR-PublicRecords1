d1 := DATASET([
	{'ANDREW','JACKSON', 'M', '591977682', 19681203, 'JACKSON ANDREW T'},
	{'MARTHA','JACKSON','F', '582828431', 19720602, 'MARTHA K JACKSON'},
	{'JANET','JONES', 'F', '921922341', 19680701, 'JONES JANET'}], 
		{string fname, 
		string lname, 
		string gender, 
		string ssn, 
		INTEGER dob,
		string fullname});

output(d1,, '~qa::anonymizer::anonymizeperson::input');
