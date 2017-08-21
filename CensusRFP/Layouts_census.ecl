
IMPORT BatchReverseServices;

EXPORT Layouts_census := MODULE

	EXPORT LatLong := RECORD
		REAL      latitude;
		REAL      longitude;
	END;
	
	EXPORT Address := RECORD
		STRING5  zip;
		STRING4  zip4;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  predir;
		STRING2  postdir;
		STRING10 prim_range;
		STRING8  sec_range;
		REAL      geo_lat;
		REAL      geo_long;
		STRING1   geo_match;
	END;
	
	EXPORT Final := RECORD
		STRING1   bi_ind;
		UNSIGNED6  id;
		UNSIGNED3  dt_first_seen;
		UNSIGNED3  dt_last_seen;
		BOOLEAN    same_address;
		STRING5   title;
		STRING20  fname;
		STRING20  mname;
		STRING20  lname;
		STRING5   name_suffix;
		STRING9   ssn;
		STRING8  dob;
		STRING8   dod;
		STRING120 company_name;
		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   suffix;
		STRING2   postdir;
		STRING10  unit_desig;
		STRING8   sec_range;
		STRING25  city_name;
		STRING2   st;
		STRING5   zip;
		STRING4   zip4;
		REAL       geo_lat;
		REAL       geo_long;
		STRING1    geo_match;
		STRING5   best_title;
		STRING20  best_fname;
		STRING20  best_mname;
		STRING20  best_lname;
		STRING5   best_name_suffix;
		STRING120 best_company_name;
		STRING10  best_prim_range;
		STRING2   best_predir;
		STRING28  best_prim_name;
		STRING4   best_suffix;
		STRING2   best_postdir;
		STRING10  best_unit_desig;
		STRING8   best_sec_range;
		STRING25  best_city_name;
		STRING2   best_st;
		STRING5   best_zip;
		STRING4   best_zip4;
	END;
	
	EXPORT layout_ssn := RECORD
		UNSIGNED6  did;
		STRING9   ssn;
	END;
	
	EXPORT layout_pre := RECORD
		STRING5   title;
		STRING20  fname;
		STRING20  mname;
		STRING20  lname;
		STRING5   name_suffix;
		STRING9   ssn;
		STRING8   dob;
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
		
		STRING10  listed_phone_num;
		STRING1   listed_phone_type;
		STRING12  listed_phone_status;
		STRING8  	listed_phone_status_date;
		STRING10  alternate_phone_num;
		STRING1   alternate_phone_type;
		STRING12  alternate_phone_status;
		STRING8  	alternate_phone_status_date;
		STRING10  cellphone_num;
		STRING12  cellphone_status;
		STRING8  	cellphone_status_date;

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

	EXPORT layout_for_joins := RECORD
			UNSIGNED6 link_id;
			layout_pre;
	END;
	
	EXPORT layout_out := RECORD
			STRING20  link_id;
			layout_pre;
	END;
	
END;