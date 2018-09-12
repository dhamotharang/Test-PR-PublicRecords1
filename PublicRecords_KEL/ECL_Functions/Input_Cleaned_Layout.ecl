//Taken from PublicRecords.risk_indicators.layout_input
EXPORT Input_Cleaned_Layout := RECORD
	UNSIGNED4 seq;
  
	STRING in_streetAddress;
	STRING in_city;
	STRING in_state;
	STRING in_zipCode;
	STRING in_country;

	STRING prim_range;
	STRING predir;
	STRING prim_name;
	STRING addr_suffix;
	STRING postdir;
	STRING unit_desig;
	STRING sec_range;
	STRING p_city_name;
	STRING st;
	STRING z5;
	STRING zip4;
	STRING lat := '';
	STRING long := '';
	STRING county := '';
	STRING geo_blk := '';
	STRING addr_type;
	STRING addr_status;
	STRING country;
	STRING dl_number := '';
	STRING dl_state := '';
	STRING email_address := '';
  
  	//FOR TESTING to get lexid
	string tweaked_zip;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;	
	STRING9  ssn;
	STRING8  dob;
  UNSIGNED6 Lexid;
  string suffix;
  string phone10;
  integer score;
END;