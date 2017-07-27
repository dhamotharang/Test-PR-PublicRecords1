export layout_consumer_search := 
	RECORD
		unsigned8 persistent_record_id;
		string10	IB_Individual_ID;
		string10	IB_Household_ID;
		unsigned8 DID;
		string5		title;
		string20	fname;
		string20	mname;
		string20	lname;
		string5		name_suffix;
		string10  prim_range;
		string2  	predir;
		string28  prim_name;
		string4   addr_suffix;
		string2   postdir;
		string10  unit_desig;
		string8   sec_range;
		string25  p_city_name;
		string2   st;
		string5   zip5;
		string4   zip4;
		string4   cart;
		string5 	county;
		string10  geo_lat;
		string11  geo_long;
		string7   geo_blk;
		string4   err_stat;
		string10	phone_1;
		string10	phone_2;
		string8		date_first_seen;
		string8		date_last_seen;
	END;