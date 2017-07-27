export REC_WithExpEvent := record


    string1 	record_type;  //current/historical
	string2	ucc_vendor;
	string8	ucc_process_date;		
	string1	processing_rule;		
	string50	ucc_key;
	string20	event_key;		
	string8	event_action_cd;
	string60	event_action_desc;		
	string2	file_state;
	string8	contrib_num1;
	string32	orig_filing_num;
	string8	filing_type;
	string60	filing_type_desc;
	string32	document_num;
	string8	filing_date;
	string8	orig_filing_date;
	string25	filed_place;
	string60	filed_place_desc;
	string1 isDirect;
end;