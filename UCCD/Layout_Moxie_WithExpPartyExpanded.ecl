export Layout_WithExpPartyExpanded_Moxie := record

	string1   	record_type; 		 // current/historical
	string1   	isDirect;
	
	string2   	ucc_vendor;
	string8   	ucc_process_date;
				
	string50  	ucc_key;
	string20  	event_key;
	string20  	party_key;
	string20  	collateral_key;
				
	string8   	party_status_cd;
	string60  	party_status_desc;
	string8   	party_address1_type_cd;
	string60  	party_address1_type_desc;
				
	string12  	bdid;
	string12	did;
	string2   	file_state;
	//string1 	rec_code; 		 // not mapped
	string8   	contrib_num;
	//string4 	value_2900; 		 // not mapped
	string32  	orig_filing_num;
	//string1 	experian_rec_type; 	 // not mapped
	string1   	party_type;
	string350 	orig_name;
	string200 	street_address;
	string60  	city;
	string50  	orig_state;
	string15  	zip_code;
	string8   	insert_date;
	//string1  	filed_code; 		 // not mapped
	//string15 	filed_place; 		 // not mapped
	string10  	ssn;
	string10    prim_range;
	string2     predir;
	string28    prim_name;
	string4     addr_suffix;
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
	string2     dbpc;
	string1     chk_digit;
	string2     rec_type;
	string2     fips_st;
	string3     fips_county;
	string10    geo_lat;
	string11    geo_long;
	string4     msa;
	string7     geo_blk;
	string1     geo_match;
	string4     err_stat;
	string5  	title;
	string20 	fname;
	string20 	mname;
	string20 	lname;
	string5  	name_suffix;
	string200 	name;
	//string8  	fk_orig_filing_date; // not mapped
	//string18 	fk_document_num; 	 // not mapped
	//string4  	fk_filing_type; 	 // not mapped
	//string8  	fk_filing_date; 	 // not mapped
	//string50 	fk_debtor_orig_st; 	 // not mapped
	//string9  	fk_filing_seq_num; 	 // not mapped
	//string1  	event_flag; 		 // not mapped
	//string1  	current_flag; 		 // not mapped
end;