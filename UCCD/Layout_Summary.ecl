export Layout_Summary := RECORD
	string50  ucc_key;
	STRING2  ucc_state_origin;
	STRING32 ucc_filing_num;
	
string2   ucc_vendor;
string8   ucc_process_date;
string1   processing_rule;
string8   ucc_filing_type_cd;
string60  ucc_filing_type_desc;
string8   ucc_exp_date;
string8   ucc_term_date;
string8   ucc_life;
string30  ucc_life_units_desc;
string60  ucc_status_desc;
	
	STRING4  filing_count := '';      // Unique filing events (file_state, orig_filing_num,
																		// filing_date, filing type
	STRING4  document_count := '';    // Unique document events (file_state, orig_filing_num,
																		// filing_date, filing type, document_num
	STRING3  debtor_count := '';      // Current debtor parties
	STRING3  secured_count := '';     // Current secured and assignee parties
	STRING25 collateral_code := '';   // Current collateral code
END;