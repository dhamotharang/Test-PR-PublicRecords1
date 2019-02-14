﻿import standard, Prof_License;

export Layouts_ProfLic := module

	export Layout_In_Common := record
	    string50    unique_number;
		string60    license_board;
		string60    license_type;
		string45    license_status;
		string20    license_number;
		string20    other_license_number;
		string60    other_license_type;
		string2     source_st;
		string60    vendor;
		string8     date_first_seen;
		string8     date_last_seen;
		string100   company_name;
		string80    name;
		string20    last_name;
		string20    first_name;
		string20    middle_name;
		string5     suffix;
		string5     name_title;
		string80    former_name;
		string80    address1;
		string80    address2;
		string80    address3;
		string80    address4;
		string40    city;
		string2     state;
		string9     zipcode;
		string5     zipcode5;
		string4     zipcode4;
		string25    county;
		string35    country;
		string3     area_code;
		string10    telephone;
		string8     gender;
		string8     birthdate;
		string8     license_issue_date;
		string8     license_expiration_date;
		string8     license_renewal_date;
		string50    license_obtained_by;
		string1     disciplinary_action_flag;
		string200   disciplinary_action;
		string8     disciplinary_status;
		string8     disciplinary_date;
		string80    additional_name;
		string80    additional_address1;
		string80    additional_address2;
		string80    additional_address3;
		string80    additional_address4;
		string40    additional_address_city;
		string2     additional_address_state;
		string9     additional_address_zipcode;
		string5     additional_address_zip5;
		string4     additional_address_zip4;	
		string3     additional_area_code;
		string10    additional_telephone;
		string20    practice_hours;
		string50    practice_setting;
		string50    email;
		string3     area_code_fax;
		string10    fax;
		string50    certificate_number;
		string75    continuing_education;
		string30    school_attended1;
		string15    dates_attended1;
		string25    curriculum1;
		string15    degree1;
		string8     graduate_date1;
		string30    school_attended2;
		string15    dates_attended2;
		string25    curriculum2;
		string15    degree2;
		string8     graduate_date2;
		string75    license_specialty;
		string75    secondary_specialty;
		string5     birthplace_cd;
		string25    birthplace;
		string5     race_cd;
		string25    race;
		string80    business_address1;
		string80    business_address2;
		string80    business_address3;
		string80    business_address4;
		string40    business_address_city;
		string2     business_address_state;
		string9     business_address_zipcode;
		string5     business_address_zip5;
		string4     business_address_zip4;
		string8     license_reissue_date;
		string2     reciprocity_state;
	end;
	
	export Layout_Cleaned_Common := record
		unsigned6  	plid;
		Layout_In_Common;
		string5    	title;
		string20 	fname;
		string20 	mname;
		string20 	lname;
		string5    	name_suffix;
		string3    	name_score;
		string5    	former_title;
		string20 	former_fname;
		string20 	former_mname;
		string20 	former_lname;
		string5    	former_suffix;
		string3    	former_score;
		string5    	addtl_title;
		string20 	addtl_fname;
		string20 	addtl_mname;
		string20 	addtl_lname;
		string5    	addtl_suffix;
		string3    	addtl_score;
		string10 	prim_range;
		string2   	predir;
		string28 	prim_name;
		string4    	addr_suffix;
		string2    	postdir;
		string10 	unit_desig;
		string8    	sec_range;
		string25 	p_city_name;
		string25 	v_city_name;
		string2    	st;
		string5    	zip;
		string4    	zip4;
		string4    	cart;
		string1    	cr_sort_sz;
		string4    	lot;
		string1    	lot_order;
		string2    	dpbc;
		string1    	chk_digit;
		string2    	rec_type;
		string2    	ace_fips_st;
		string3    	fips_county;
		//string18	county_name;
		string10 	geo_lat;
		string11 	geo_long;
		string4    	msa;
		string7    	geo_blk;
		string1    	geo_match;
		string4    	err_stat;
		string10 	addtl_prim_range;
		string2   	addtl_predir;
		string28 	addtl_prim_name;
		string4    	addtl_addr_suffix;
		string2    	addtl_postdir;
		string10 	addtl_unit_desig;
		string8    	addtl_sec_range;
		string25 	addtl_p_city_name;
		string25 	addtl_v_city_name;
		string2    	addtl_st;
		string5    	addtl_zip;
		string4    	addtl_zip4;
		string4    	addtl_cart;
		string1    	addtl_cr_sort_sz;
		string4    	addtl_lot;
		string1    	addtl_lot_order;
		string2    	addtl_dpbc;
		string1    	addtl_chk_digit;
		string2    	addtl_rec_type;
		string2    	addtl_ace_fips_st;
		string3    	addtl_fips_county;
		//string18	addtl_county_name;
		string10 	addtl_geo_lat;
		string11 	addtl_geo_long;
		string4    	addtl_msa;
		string7    	addtl_geo_blk;
		string1    	addtl_geo_match;
		string4    	addtl_err_stat;
		string10 	bus_prim_range;
		string2   	bus_predir;
		string28 	bus_prim_name;
		string4    	bus_addr_suffix;
		string2    	bus_postdir;
		string10 	bus_unit_desig;
		string8    	bus_sec_range;
		string25 	bus_p_city_name;
		string25 	bus_v_city_name;
		string2    	bus_st;
		string5    	bus_zip;
		string4    	bus_zip4;
		string4    	bus_cart;
		string1    	bus_cr_sort_sz;
		string4    	bus_lot;
		string1    	bus_lot_order;
		string2    	bus_dpbc;
		string1    	bus_chk_digit;
		string2    	bus_rec_type;
		string2    	bus_ace_fips_st;
		string3    	bus_fips_county;
		//string18	bus_county_name;
		string10 	bus_geo_lat;
		string11 	bus_geo_long;
		string4    	bus_msa;
		string7    	bus_geo_blk;
		string1    	bus_geo_match;
		string4    	bus_err_stat;
	end;


	export Layout_Base_Main := record
		string50    prolic_key;
		string8    	date_first_seen;
		string8     date_last_seen;
		string60    profession_or_board;
		string60    license_type;
		string45    status;
		string20    license_number;
		string20    previous_license_number;
		string60	previous_license_type;
		string8     sex;
		string8     issue_date;
		string8     expiration_date;
		string8     last_renewal_date;
		string50    license_obtained_by;
		string1     board_action_indicator;
		string2     source_st;
		string60    vendor;
		string8     action_record_type;
		string30    action_status;
		string8     action_posting_status_dt;

		string50    misc_occupation;
		string20    misc_practice_hours;
		string50    misc_practice_type;
		string50    misc_email;
		string10    misc_fax;
		string50    certificate_number;
		
		string75    education_continuing_education;
		string30    education_1_school_attended;
		string15    education_1_dates_attended;
		string25    education_1_curriculum;
		string15    education_1_degree;
		string8     education_1_grad_date;
		string30    education_2_school_attended;
		string15    education_2_dates_attended;
		string25    education_2_curriculum;
		string15    education_2_degree;
		string8     education_2_grad_date;
		string75    license_specialty;
		string75    secondary_specialty;
		string5     personal_pob_cd;
		string25    personal_pob_desc;
		string5     personal_race_cd;
		string25    personal_race_desc;
		// string10    status_status_cds;
		// string8     status_effective_dt;
		// string8     status_renewal_desc;
		// string20    status_other_agency;		
       //
	end;
	
	export Layout_Base_Search := record
		string50	prolic_key;
		string8		date_first_seen;
		string8     date_last_seen;
		string100	name;
		string1		business_flag;
		string80    address1;
		string80    address2;
		string80    address3;
		string80    address4;
		string40    city;
		string2     state;
		string9     zipcode;
		string25    county;
		string35    country;
		string10    phone;
		string8     dob;		
		string10    prim_range;
		string2     predir;
		string28    prim_name;
		string4     suffix;
		string2     postdir;
		string10    unit_desig;
		string8     sec_range;
		string25    p_city_name;
		string25    v_city_name;
		string2     st;
		string5     zip;
		string4     zip4;
		string4     cart;
		string1     cr_sort_sz;
		string4     lot;
		string1     lot_order;
		string2     dpbc;
		string1     chk_digit;
		string2     record_type;
		string2     ace_fips_st;
		string3     fips_county;
		string10    geo_lat;
		string11    geo_long;
		string4     msa;
		string7     geo_blk;
		string1     geo_match;
		string4     err_stat;
		string5     title;
		string20    fname;
		string20    mname;
		string20    lname;
		string5     name_suffix;
		string3     pl_score_in;
	end;
	
	export Layout_Base := record
	   unsigned6 prolic_seq_id := 0;
	   prof_license.layout_proflic_out;
		 //DF-24056 CCPA new fields
			unsigned4 global_sid;
			unsigned8 record_sid;

	end;
	
	export Layout_Base_With_Tiers := record
	   unsigned6 	prolic_seq_id := 0;
		 string100	orbit_source	:= '';
		 string50		category1			:= '';
		 string50		category2			:= '';
	   prof_license.layout_prolic_out_with_AID;
	end;	
	
	export Layout_Autokeys := record
	   Layout_Base.prolic_seq_id;
	   unsigned6  did;
	   string9	  best_ssn;
	   unsigned6  bdid;
	   string100  cname;
	   standard.Name name;
	   standard.L_Address.base addr;
		 string8    dob;
	   string10   Phone;
	   unsigned6  zero  := 0;
	   string1    blank := '';
	end;

end;