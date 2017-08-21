r := 
	record
		string1 s1;
	end;

export LocalTest := dataset(LOCAL('z:\\temp\\analyzeHex.txt'),r, FLAT);