import autokey;
export Layout_Wild_Address :=
RECORD(autokey.Layout_Address_bare)
	STRING20 lname;
	STRING20 fname;
	UNSIGNED8 states;
	UNSIGNED4 lname1;
	UNSIGNED4 lname2;
	UNSIGNED4 lname3;
	UNSIGNED4 lookups;
	UNSIGNED6 did;
END;