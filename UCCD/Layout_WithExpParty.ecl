export Layout_WithExpParty :=  record
	string1   	record_type; 		 // current/historical
	boolean   	isDirect;
	
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
	string12		did;
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
	string182 	clean_address;
	string70  	p_name;
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