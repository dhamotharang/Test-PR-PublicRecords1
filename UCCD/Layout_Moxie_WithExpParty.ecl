export rec_WithExpParty :=  record
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
	string8   	contrib_num;
	string32  	orig_filing_num;
	string1   	party_type;
	string350 	orig_name;
	string200 	street_address;
	string60  	city;
	string50  	orig_state;
	string15  	zip_code;
	string8   	insert_date;
	string10  	ssn;
	string182 	clean_address;
	string70  	p_name;
	string200 	name;
	
end;