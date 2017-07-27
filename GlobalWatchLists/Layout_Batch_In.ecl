export Layout_batch_in := 
RECORD
	// You can use either as grouping, as we don't actually use either in base_function
	string10 acctno;
	unsigned4 seq := 0;
	
	STRING50 name_first;
	STRING50 name_middle;
	STRING50 name_last;
	STRING150 name_unparsed;
	STRING20 search_type;
	string20 country;
	STRING8  dob := '';
	STRING8	 version_number;
END;