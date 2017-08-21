EXPORT Layout_2015 := RECORD
		unsigned6		LexID;
		STRING64  fullname;
		STRING9   ssn;
		STRING8   dob;
		integer2		age;		// new
		STRING8   dod;
		STRING14  dl_number;
		STRING2   dl_state;
		STRING1   gender;
		STRING1   race;

		STRING10  addr_curr_prim_range;
		STRING2   addr_curr_predir;
		STRING28  addr_curr_prim_name;
		STRING4   addr_curr_suffix;
		STRING2   addr_curr_postdir;
		STRING10  addr_curr_unit_desig;
		STRING8   addr_curr_sec_range;
		STRING25  addr_curr_city_name;
		STRING2   addr_curr_st;
		STRING5   addr_curr_zip;
		STRING4   addr_curr_zip4;
		STRING10  addr_curr_geo_lat;
		STRING11  addr_curr_geo_long;
		STRING6   addr_curr_dt_first_seen;
		STRING6   addr_curr_dt_last_seen;
		integer2	Housing_Tenure;			// new
		integer2	Housing_Population;	// new
		
		STRING10  listed_phone_num;
		STRING1   listed_phone_type;
		string12	listed_phone_status;			// new
		string8		listed_phone_status_date;			// new
		STRING10  alternate_phone_num;
		STRING1   alternate_phone_type;
		string12	alternate_phone_status;			// new
		string8		alternate_phone_status_date;			// new
		STRING10  cellphone_num;
		STRING12  cellphone_status;
		STRING8  	cellphone_status_date;
		
		string64	email_address;				// new
		string8		email_address_activity_date;
		
		STRING10  addr_alt_prim_range;
		STRING2   addr_alt_predir;
		STRING28  addr_alt_prim_name;
		STRING4   addr_alt_suffix;
		STRING2   addr_alt_postdir;
		STRING10  addr_alt_unit_desig;
		STRING8   addr_alt_sec_range;
		STRING25  addr_alt_city_name;
		STRING2   addr_alt_st;
		STRING5   addr_alt_zip;
		STRING4   addr_alt_zip4;
		STRING10  addr_alt_geo_lat;
		STRING11  addr_alt_geo_long;
		STRING6   addr_alt_dt_first_seen;
		STRING6   addr_alt_dt_last_seen;

		STRING10  addr_hist1_prim_range;
		STRING2   addr_hist1_predir;
		STRING28  addr_hist1_prim_name;
		STRING4   addr_hist1_suffix;
		STRING2   addr_hist1_postdir;
		STRING10  addr_hist1_unit_desig;
		STRING8   addr_hist1_sec_range;
		STRING25  addr_hist1_city_name;
		STRING2   addr_hist1_st;
		STRING5   addr_hist1_zip;
		STRING4   addr_hist1_zip4;
		STRING10  addr_hist1_geo_lat;
		STRING11  addr_hist1_geo_long;
		STRING6   addr_hist1_dt_first_seen;
		STRING6   addr_hist1_dt_last_seen;

		STRING10  addr_hist2_prim_range;
		STRING2   addr_hist2_predir;
		STRING28  addr_hist2_prim_name;
		STRING4   addr_hist2_suffix;
		STRING2   addr_hist2_postdir;
		STRING10  addr_hist2_unit_desig;
		STRING8   addr_hist2_sec_range;
		STRING25  addr_hist2_city_name;
		STRING2   addr_hist2_st;
		STRING5   addr_hist2_zip;
		STRING4   addr_hist2_zip4;
		STRING10  addr_hist2_geo_lat;
		STRING11  addr_hist2_geo_long;
		STRING6   addr_hist2_dt_first_seen;
		STRING6   addr_hist2_dt_last_seen;
		
END;