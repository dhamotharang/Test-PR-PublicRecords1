EXPORT Layout_Final := RECORD
		string20	LexID;
		STRING64  fullname;
//		STRING9   ssn;
		STRING8   dob;
		string3		age;		// new
//		STRING8   dod;
//		STRING14  dl_number;
//		STRING2   dl_state;
		STRING1   sex;
//		STRING1   race;

		STRING80  addr_curr_address;
		STRING25  addr_curr_city_name;
		STRING2   addr_curr_st;
		STRING5   addr_curr_zip;
		STRING4   addr_curr_zip4;
//		STRING10  addr_curr_geo_lat;
//		STRING11  addr_curr_geo_long;
//		STRING6   addr_curr_dt_first_seen;
//		STRING6   addr_curr_dt_last_seen;
//		string2		Housing_Tenure;			// new
//		string2		Housing_Population;	// new
		
		STRING10  listed_phone_num;
		STRING1   listed_phone_type;
		string12	listed_phone_status;			// new
		string8		listed_phone_status_date;			// new
		STRING10  alternate_phone_num;
		STRING1   alternate_phone_type;
		string12	alternate_phone_status;			// new
		string8		alternate_phone_status_date;			// new
//		STRING10  cellphone_num;
		
		string64	email_address;				// new
		string8		email_address_activity_date;
/*		
		STRING80  addr_alt_address;
		STRING25  addr_alt_city_name;
		STRING2   addr_alt_st;
		STRING5   addr_alt_zip;
		STRING4   addr_alt_zip4;
		STRING10  addr_alt_geo_lat;
		STRING11  addr_alt_geo_long;
		STRING6   addr_alt_dt_first_seen;
		STRING6   addr_alt_dt_last_seen;

		STRING80  addr_hist1_address;
		STRING25  addr_hist1_city_name;
		STRING2   addr_hist1_st;
		STRING5   addr_hist1_zip;
		STRING4   addr_hist1_zip4;
		STRING10  addr_hist1_geo_lat;
		STRING11  addr_hist1_geo_long;
		STRING6   addr_hist1_dt_first_seen;
		STRING6   addr_hist1_dt_last_seen;

		STRING80  addr_hist2_address;
		STRING25  addr_hist2_city_name;
		STRING2   addr_hist2_st;
		STRING5   addr_hist2_zip;
		STRING4   addr_hist2_zip4;
		STRING10  addr_hist2_geo_lat;
		STRING11  addr_hist2_geo_long;
		STRING6   addr_hist2_dt_first_seen;
		STRING6   addr_hist2_dt_last_seen;
	*/	
		//string	  eol := '\n';
END;