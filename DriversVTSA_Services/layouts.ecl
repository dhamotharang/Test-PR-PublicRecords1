import  doxie, doxie_build,DriversVTSA;

export layouts := module
	
	export key_dl					:= DriversVTSA.Key_DL_Seq;
	
	export seq := record
		key_dl.dl_seq;
	end;
	
	export search_ids := record
		seq;
		boolean isDeepDive := false;
	end;
	
	export num := record
		key_dl.dl_number;
	end;
	
	export snum := record
		key_dl.dl_number;
		key_dl.orig_state;
	end;

	export did := doxie.layout_references;
	
	export pen := record
		unsigned2 penalt;
	end;
	
	export name := module
		export narrow := record
			key_dl.name;
			key_dl.title;
			key_dl.fname;
			key_dl.mname;
			key_dl.lname;
			key_dl.name_suffix;
		end;
		export wide := record
			narrow;
			key_dl.name_change;
		end;
	end;
	
	export address := module
		export narrow := record			
			key_dl.addr1;
			key_dl.city;
			key_dl.state;
			key_dl.zip;
			
			key_dl.prim_range;
			key_dl.predir;
			key_dl.prim_name;
			key_dl.suffix;
			key_dl.postdir;
			key_dl.unit_desig;
			key_dl.sec_range;
			key_dl.p_city_name;
			key_dl.v_city_name;
			key_dl.st;
			key_dl.zip5;
			key_dl.zip4;
		end;
		export wide := record
			narrow;
			key_dl.address_change;
			key_dl.country;
			key_dl.postal_code;
			key_dl.province;
		end;
	end;
	
	export individual := module
		export narrow := record
			key_dl.did;							// needed for suppression
			key_dl.dob;
			key_dl.race;
			key_dl.sex_flag;
			key_dl.ssn;
			key_dl.height;
			key_dl.hair_color;
			key_dl.eye_color;
			key_dl.weight;
			key_dl.history;
			
			// derived fields
			string20	race_name;				// max=15
			string10	sex_name;					// max=7
			string10	hair_color_name;	// max=9
			string15	eye_color_name;		// max=11
			string10	history_name;			// max=10
		end;
		export wide := record
			narrow;
			key_dl.dod;
			key_dl.age;
			key_dl.privacy_flag;		// needed for DPPA
		end;
	end;
	
	export DLinfo := module
		export narrow := record
			key_dl.license_type;
			key_dl.license_class;
			key_dl.status;
			key_dl.cdl_status;
			key_dl.attention_flag;
			key_dl.lic_issue_date;
			key_dl.expiration_date;			
			key_dl.motorcycle_code;
			key_dl.dl_number;
			key_dl.orig_state;			// listed as "state_origin" in spreadsheet
			key_dl.county;
			key_dl.rec_type;
			key_dl.restrictions;// TSA
			key_dl.restrictions_delimited;
			key_dl.lic_endorsement;
			key_dl.oos_previous_dl_number;
			key_dl.oos_previous_st;
			
			// derived fields
			string75	license_type_name;	// max=69
			string250 license_class_name;	// max=241
			string50	status_name;				// max=33
			string50	cdl_status_name;		// max=33
			string25	attention_name;			// max=22
  		string20	orig_state_name;		// max=20
			string18	county_name;				// max=18
			string120	restriction1;				// max=107
			string120	restriction2;				// max=107
			string120	restriction3;				// max=107
			string120	restriction4;				// max=107
			string120	restriction5;				// max=107
			string135 endorsement1;				// max=131
			string135 endorsement2;				// max=131
			string135 endorsement3;				// max=131
			string135 endorsement4;				// max=131
			string135 endorsement5;				// max=131
		end;
		export wide := record
			narrow;
			key_dl.orig_expiration_date;
			key_dl.orig_issue_date;
			key_dl.active_date;
			key_dl.inactive_date;
			key_dl.issuance;
			key_dl.old_dl_number;
			
			// derived fields
			unsigned1 age_today;
			unsigned1 dead_age;
		end;
	end;
	
	export result_narrow := record
		seq;
		pen;
		key_dl.source_code;
		string1 nonDMVsource;
		name.narrow;
		address.narrow;
		individual.narrow;
		DLinfo.narrow;
	end;
	
	export result_wide := record
		seq;
		pen;
		key_dl.source_code;
		string1 nonDMVsource;
		key_dl.dt_first_seen;
		key_dl.dt_last_seen;
		name.wide;
		address.wide;
		individual.wide;
		DLinfo.wide;
 	  integer2 addr_no := 0;
	end;
	export result_wide_tmp := record
		result_wide;
		
		// This is needed to join with the CP keys
		key_dl.dlcp_key;
		
		// These are all needed for MOXIE
		key_dl.Preglb_did; // STUB - is this right?
		key_dl.cleaning_score;
		key_dl.addr_fix_flag;
		key_dl.cart;
		key_dl.cr_sort_sz;
		key_dl.lot;
		key_dl.lot_order;
		key_dl.dpbc;
		key_dl.chk_digit;
		key_dl.ace_fips_st;
		key_dl.geo_lat;
		key_dl.geo_long;
		key_dl.msa;
		key_dl.geo_blk;
		key_dl.geo_match;
		key_dl.err_stat;
		key_dl.dob_change;
		key_dl.sex_change;
		key_dl.driver_edu_code;
		key_dl.dup_lic_count;
		key_dl.rcd_stat_flag;
		key_dl.dl_key_number;
		// tsa moved above key_dl.restrictions;
		key_dl.moxie_license_type;
		
		// and these are needed for legacy
		key_dl.dt_vendor_first_reported;
		key_dl.dt_vendor_last_reported;
		key_dl.record_type;
		key_dl.ssn_safe;
	end;
	
	// This layout is supplied by Lee, defining output for the moxie services
	export Layout_drivers_license2_1 := record
		string12  	did;
		string12  	pgid;
		string1   	history;
		string2   	state_origin;
		string2   	source_code;
		string52  	name;
		string40  	addr1;
		string20  	city;
		string2   	state;
		string5   	zip;
		string8   	dob;
		string1   	race;
		string1   	sex_flag;
		string4   	license_type;
		string14  	attention_flag;
		string8   	dod;
		string42  	restrictions;
		string42  	restrictions_delimited;
		string8   	expiration_date;
		string8   	lic_issue_date;
		string10  	lic_endorsement;
		string4   	motorcycle_code;
		string14  	dl_number;
		string9   	ssn;
		string3   	age;
		string1   	privacy_flag;
		string8   	dl_orig_issue_date;
		string3   	height;
		string25  	oos_previous_dl_number;
		string2   	oos_previous_st;
		string5   	title;
		string20  	fname;
		string20  	mname;
		string20  	lname;
		string5   	name_suffix;
		string3   	cleaning_score;
		string1   	addr_fix_flag;
		string10  	prim_range;
		string2   	predir;
		string28  	prim_name;
		string4   	suffix;
		string2   	postdir;
		string10  	unit_desig;
		string8   	sec_range;
		string25  	p_city_name;
		string25  	v_city_name;
		string2   	st;
		string5   	zip5;
		string4   	zip4;
		string4   	cart;
		string1   	cr_sort_sz;
		string4   	lot;
		string1   	lot_order;
		string2   	dpbc;
		string1   	chk_digit;
		string2   	rec_type;
		string2   	ace_fips_st;
		string3   	county;
		string10  	geo_lat;
		string11  	geo_long;
		string4   	msa;
		string7   	geo_blk;
		string1   	geo_match;
		string4   	err_stat;
		string1   	status;
		string2   	issuance;
		string8   	address_change;
		string1   	name_change;
		string1   	dob_change;
		string1   	sex_change;
		string14  	old_dl_number;
		string1   	driver_edu_code;
		string1   	dup_lic_count;
		string1   	rcd_stat_flag;
		string3   	hair_color;
		string3   	eye_color;
		string3   	weight;
		string9   	dl_key_number;
	end;
	
	// Extra fields are used for deduping, then thinned back out before delivery
	export moxie_tmp := record
		Layout_drivers_license2_1;
		string10 history_name;
	end;
end;
