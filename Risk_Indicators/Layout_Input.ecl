export Layout_Input := RECORD
	UNSIGNED4 seq;
	
	unsigned3 historydate := 999999; // moved here from layout_output
	string20	historyDateTimeStamp := '';  // new for shell 5.0
	UNSIGNED6 DID := 0;  		// moved here from layout_output
	UNSIGNED2 score := 0; 	// moved here from layout_output
	
	STRING5  title := '';
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5  suffix;

	STRING120 in_streetAddress;
	STRING25 in_city;
	STRING2 in_state;
	STRING5 in_zipCode;
	STRING25 in_country;

	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  z5;
	STRING4  zip4;
	STRING10 lat := '';
	STRING11 long := '';
	string3 county := '';
	string7 geo_blk := '';
	
	STRING1  addr_type;
	STRING4  addr_status;
	
	STRING25 country;
	
	STRING9  ssn;
	STRING8  dob;
	STRING3  age;
	
	STRING20 dl_number := '';
	STRING2 dl_state := '';
	
	STRING50 email_address := '';
	STRING45 ip_address := '';

	STRING10 phone10;
	STRING10 wphone10;
	STRING100 employer_name := '';
	STRING20 lname_prev := '';
END;