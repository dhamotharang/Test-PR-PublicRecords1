EXPORT Layouts := MODULE
	
//Lerg6 Layout
	EXPORT lerg6Main := RECORD
		string8 	dt_first_reported;
		string8 	dt_last_reported;
		string8 	dt_start;				
		string8 	dt_end;
		string2 	source;
		string10 	lata;
		string30 	lata_name;
		string2 	status;
		string8 	eff_date;
		string6 	eff_time;
		string3 	npa;
		string3 	nxx;
		string1 	block_id;
		string1 	filler1;
		string5 	coc_type;
		string5 	ssc;
		string1 	dind;
		string5 	td_eo;
		string5 	td_at;
		string1 	portable;
		string5 	aocn;
		string1 	filler2;
		string5 	ocn;
		string20 	loc_name;
		string5 	loc;
		string2 	loc_state;
		string20 	rc_abbre;
		string5 	rc_ty;
		string5 	line_fr;
		string5 	line_to;
		string15 	switch;
		string5 	sha_indicator;
		string1 	filler3;
		string5 	test_line_num;
		string2 	test_line_response;
		string8 	test_line_exp_date;
		string6 	test_line_exp_time;
		string2 	blk_1000_pool;
		string10 	rc_lata;
		string1 	filler4;
		string8 	creation_date;
		string6 	creation_time;
		string1 	filler5;
		string8 	e_status_date;
		string6 	e_status_time;
		string1 	filler6;
		string8 	last_modified_date;
		string6 	last_modified_time;
		string1 	filler7;
		boolean 	is_current;
		string5 	os1;
		string5 	os2;
		string5 	os3;
		string5 	os4;
		string5 	os5;
		string5 	os6;
		string5 	os7;
		string5 	os8;
		string5 	os9;
		string5 	os10;
		string5 	os11;
		string5 	os12;
		string5 	os13;
		string5 	os14;
		string5 	os15;
		string5 	os16;
		string5 	os17;
		string5 	os18;
		string5 	os19;
		string5 	os20;
		string5 	os21;
		string5 	os22;
		string5 	os23;
		string5 	os24;
		string5 	os25;
		string80 	notes;
		unsigned4 global_sid;		//CCPA Requirement
		unsigned8 record_sid;		//CCPA Requirement
	END;

//Phones Transaction Layout
	EXPORT Phones_Transaction_Main := RECORD
		string10 	phone;
		string5		source;
		string2		transaction_code;
		unsigned8	transaction_dt;
		string6		transaction_time;
		unsigned8	vendor_first_reported_dt;
		string6		vendor_first_reported_time;
		unsigned8	vendor_last_reported_dt;
		string6		vendor_last_reported_time;
		string3		country_code;
		string2		country_abbr;
		string10 	routing_code;
		string1		dial_type;
		string10 	spid;
		string60 	carrier_name;
		string10 	phone_swap;
		unsigned4 global_sid;		//CCPA Requirement
		unsigned8 record_sid;		//CCPA Requirement
	END;

//Phones Type Layout	
	EXPORT Phones_Type_Main := RECORD
		string10 	phone;
		string5		source;
		unsigned8	vendor_first_reported_dt;
		string6		vendor_first_reported_time;
		unsigned8	vendor_last_reported_dt;
		string6		vendor_last_reported_time;
		string30 	reference_id;
		string3 	reply_code;
		string10 	local_routing_number;
		string6		account_owner;
		string60 	carrier_name;
		string10 	carrier_category;
		string5 	local_area_transport_area;
		string10 	point_code; 
		string1 	serv;
		string1 	line;
		string10 	spid;
		string60	operator_fullname;
		string2		high_risk_indicator;
		string2		prepaid;
		unsigned4 global_sid;		//CCPA Requirement
		unsigned8 record_sid;		//CCPA Requirement
	END;

//Carrier Reference Layout	
	EXPORT sourceRefBase := RECORD
		string8 	dt_first_reported;
		string8 	dt_last_reported;
		string8 	dt_start;			//LERG file received
		string8 	dt_end;
		string8 	ocn;
		string60 	carrier_name;
		string60 	name;
		string1 	serv;
		string1 	line;
		string2 	prepaid;
		string2 	high_risk_indicator;
		unsigned8	activation_dt;
		string5		number_in_service;
		string10 	spid;
		string60 	operator_full_name;
		boolean 	is_current;
		string1 	override_file;
		string1		data_type;
		string2		ocn_state;
		string4		overall_ocn;
		string4		target_ocn;
		string4		overall_target_ocn;
		string25 	ocn_abbr_name;
		string1		rural_lec_indicator;
		string1 	small_ilec_indicator;
		string10 	category;
		string30 	carrier_address1;
		string30 	carrier_address2;
		string15 	carrier_floor;
		string15 	carrier_room;
		string30 	carrier_city;
		string2		carrier_state;
		string9		carrier_zip;
		string10 	carrier_phone;
		string80 	affiliated_to;
		string45 	overall_company;
		string20 	contact_function;
		string60 	contact_name;	
		string30 	contact_title;
		string30 	contact_address1;
		string30 	contact_address2;
		string30 	contact_city;
		string2		contact_state;
		string9		contact_zip;
		string10 	contact_phone;
		string10 	contact_fax;
		string60 	contact_email;
		string70 	contact_information;
		string10 	prim_range;
		string2		predir;
		string28 	prim_name;
		string4		addr_suffix;
		string2		postdir;
		string10 	unit_desig;
		string8		sec_range;
		string25 	p_city_name;
		string25 	v_city_name;
		string2		st;
		string5		z5;
		string4		zip4;
		string4		cart;
		string1		cr_sort_sz;
		string4		lot;
		string1		lot_order;
		string2		dpbc;
		string1		chk_digit;
		string2		rec_type;
		string2		ace_fips_st;
		string3		fips_county;
		string10 	geo_lat;
		string11 	geo_long;
		string4		msa;
		string7		geo_blk;
		string1		geo_match;
		string4		err_stat;
		unsigned8 append_rawaid;
		string5 	address_type;
		string5 	privacy_indicator;
		//string2 country;
	end;

END;