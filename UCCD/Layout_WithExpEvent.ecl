export Layout_WithExpEvent := record

	string1 	record_type;  //current/historical


	string2	ucc_vendor;
	string8	ucc_process_date;
			
	string1	processing_rule;
			
	string50	ucc_key;
	string20	event_key;
			
	string8	event_action_cd;
	string60	event_action_desc;
			
	string2	file_state;
	//string1	rec_code;  		// not mapped
	string8	contrib_num1;
	//string8	contrib_num2; 		// not mapped
	//string8	contrib_num3; 		// not mapped
	//string4	value_2900; 		// not mapped
	string32	orig_filing_num;
	//string1	experian_rec_type; 	// not mapped
	string8	filing_type;
	string60	filing_type_desc;
	string32	document_num;
	string8	filing_date;
	string8	orig_filing_date;
	//string25 collateral_code; 	// not mapped
	//string50 fk_debtor_orig_st;	// not mapped
	//string9	fk_filing_seq_num; 	// not mapped
	string25	filed_place;
	string60	filed_place_desc;
	//string1	debtor_change; 	// not mapped
	//string1	secured_change; 	// not mapped
	
	boolean isDirect;
end;