export Layout_Determiner :=
RECORD
	// original in
	// unsigned6 did;
	STRING25 city;
	STRING2 st;
	STRING4 lname4;
	STRING3 fname3;
	// flags
	STRING1 incAge := '';
	STRING1 incSt := '';
	STRING1 incCity := '';
	STRING1 incCoHabit := '';
	STRING1 incFname := '';
	STRING1 incLast := '';
	STRING1 incMaiden := '';
	UNSIGNED2 incCode := 0;
	INTEGER2 incCost := -1;
	unsigned1 prob := 1;
END;