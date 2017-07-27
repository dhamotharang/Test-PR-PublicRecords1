export Layout_AddressHistory :=
RECORD
	unsigned1 seq;
	STRING65 Address;
	// parsed address
	STRING10 PrimRange;
	STRING2  PreDir;
	STRING28 PrimName;
	STRING4  AddrSuffix;
	STRING2  PostDir;
	STRING10 UnitDesignation;
	STRING8  SecRange;
	STRING25 City;
	STRING2 St;
	STRING5 Zip;
	STRING4 Zip4;
	STRING50 phone;
	UNSIGNED3 dt_first_seen := 0;
	UNSIGNED3 dt_last_seen := 0;
	boolean isBestMatch := false;
	string12 dpbc;
END;