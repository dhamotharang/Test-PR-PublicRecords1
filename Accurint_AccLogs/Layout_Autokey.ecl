import standard;

export Layout_Autokey := record
	
	unsigned6 record_id;
	
	string10 orig_company_id;
	string15 orig_loginid;
	string15 orig_billing_code;

	string100 orig_User_CompanyName;
	string60 orig_User_FirstName;
	string60 orig_User_LastName;
	string5 orig_User_Status; // new
	string60 orig_login_history_id;

	string60 orig_fname;
	string60 orig_mname;
	string60 orig_lname;
	string180 orig_full_name;
	string100 orig_business_name;
	string180 orig_address;
	string60 orig_city;
	string20 orig_state;
	string15 orig_zip;
	string15 orig_zip4;
	string15 orig_phone;
	string15 orig_ssn;
	string15 orig_dob;
	string15 orig_transaction_type;
	string60 orig_function_name;
	string60 orig_searchdescription;
	string5 orig_transaction_code;

	string60 orig_unique_id;
	string60 orig_ein; // new
	string60 orig_charter_nbr; // new
	string60 orig_ucc_nbr; // new
	string60 orig_did; // new
	string60 orig_domain; // new
	string60 orig_dl; // new

	string15 user_id;
	string5 user_title;
	string20 user_fname;
	string20 user_mname;
	string20 user_lname;
	string5 user_name_suffix;
	string20 user_name_append;
	string100 user_cname;

	string13 phone;
	
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string9 ssn;
	string8 dob;
	
	string100 cname;
	
	string10        prim_range; 	// [1..10]
	string2         predir;		// [11..12]
	string28        prim_name;	// [13..40]
	string4         addr_suffix;  // [41..44]
	string2         postdir;		// [45..46]
	string10        unit_desig;	// [47..56]
	string8         sec_range;	// [57..64]
	string25        p_city_name;	// [65..89]
	string25        v_city_name;  // [90..114]
	string2         st;			// [115..116]
	string5         zip;		// [117..121]
	string4         zip4;		// [122..125]
	string4         cart;		// [126..129]
	string1         cr_sort_sz;	// [130]
	string4         lot;		// [131..134]
	string1         lot_order;	// [135]
	string2         dbpc;		// [136..137]
	string1         chk_digit;	// [138]
	string2         rec_type;	// [139..140]
	string5         county;		// [141..145]
	string10        geo_lat;		// [146..155]
	string11        geo_long;	// [156..166]
	string4         msa;		// [167..170]
	string7         geo_blk;		// [171..177]
	string1         geo_match;	// [178]
	string4         err_stat;	// [179..182]
	
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	string8 dt_first_seen := '';
	string8 dt_last_seen := '';
	unsigned6 did := 0;
	unsigned6 bdid := 0;
	
	string60 search_description;
	string60 orig_transaction_id;
	string60 orig_dateadded;
	
	string10 permissions := '';
	string20 deconfliction_type := '';

	
	unsigned1 zero := 0;
end;