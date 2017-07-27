// Input request for the property report
export Layout_PropHistory_In := RECORD
	UNSIGNED4	seq;
	STRING45	in_fares_unformatted_apn;
	STRING120	in_streetAddress;			// copy of the string from WS-ECL
	STRING10  prim_range;
	STRING2   predir;
	STRING28  prim_name;
	STRING4   addr_suffix;
	STRING2   postdir;
	STRING10  unit_desig;
	STRING8   sec_range;
	STRING25	in_city;
	STRING2		in_state;
	STRING5		in_zipCode;
	STRING5		in_fips;
END;