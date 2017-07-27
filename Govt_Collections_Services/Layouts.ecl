
IMPORT BatchShare;

EXPORT Layouts := MODULE

	EXPORT batch_in_raw := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING11 ssn;
		STRING10 dob;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress - [county_name];
		BatchShare.Layouts.ShareAddressNCOA - [NCOA_county_name];
	END;
	
	EXPORT batch_in := RECORD
		batch_in_raw;
		BatchShare.Layouts.ShareErrors;
		STRING20 orig_acctno;
		STRING50 record_err_msg;
		BOOLEAN  is_rejected_rec;
	END;
	
	EXPORT best_address := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING100 best_addr1;
		STRING25  best_city;		
		STRING2   best_state;		
		STRING5   best_zip;
		STRING8   date_last_seen;		
		STRING8   input_addr_date;
	END;

	EXPORT best_address_full := RECORD
		best_address;
		STRING10 best_prim_range  := '';
		STRING2  best_predir      := '';
		STRING28 best_prim_name   := '';
		STRING4  best_addr_suffix := '';
		STRING2  best_postdir     := '';
		STRING10 best_unit_desig  := '';
		STRING8  best_sec_range   := '';
		STRING25 best_p_city_name := '';
		STRING2  best_st          := '';
		STRING5  best_z5      		:= '';
		STRING4  best_zip4        := '';
		STRING18 best_county_name := '';
		BOOLEAN input_is_best_addr := FALSE;
		STRING  best_addr_matchcodes := ''; 
	END;
	
	EXPORT best_ssn := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING9 best_ssn;
	END;

	EXPORT best_ssn_full := RECORD
		best_ssn;
		BOOLEAN input_is_best_ssn := FALSE;
		BOOLEAN best_ssn_is_poss_shared := FALSE;
		BOOLEAN best_ssn_is_rel_linked := FALSE;
	END;

	EXPORT batch_debtors := RECORD
		STRING20 	Property_Debtor_2_Best_fname;
		STRING20 	Property_Debtor_2_Best_lname;
		STRING100	Property_Debtor_2_Best_addr1;
		STRING50 	Property_Debtor_2_Best_city;
		STRING2 	Property_Debtor_2_Best_state;
		STRING5 	Property_Debtor_2_Best_zip;
		STRING10 	Property_Debtor_2_Phone_number_1;
		STRING10 	Property_Debtor_2_Phone_number_2;
		STRING10 	Property_Debtor_2_Phone_number_3;
		STRING20 	Property_Debtor_3_Best_fname;
		STRING20 	Property_Debtor_3_Best_lname;
		STRING100 Property_Debtor_3_Best_addr1;
		STRING50 	Property_Debtor_3_Best_city;
		STRING2 	Property_Debtor_3_Best_state;
		STRING5 	Property_Debtor_3_Best_zip;
		STRING10 	Property_Debtor_3_Phone_number_1;
		STRING10 	Property_Debtor_3_Phone_number_2;
		STRING10 	Property_Debtor_3_Phone_number_3;
		STRING20 	Property_Debtor_4_Best_fname;
		STRING20 	Property_Debtor_4_Best_lname;
		STRING100 Property_Debtor_4_Best_addr1;
		STRING50 	Property_Debtor_4_Best_city;
		STRING2 	Property_Debtor_4_Best_state;
		STRING5 	Property_Debtor_4_Best_zip;
		STRING10 	Property_Debtor_4_Phone_number_1;
		STRING10 	Property_Debtor_4_Phone_number_2;
		STRING10 	Property_Debtor_4_Phone_number_3;
	END;

	EXPORT batch_working := RECORD 
		batch_in;
		STRING8   conf_score;	
		STRING100 conf_score_desc;
		STRING20  best_fname;		
		STRING20  best_mname;
		STRING20  best_lname;	
		BOOLEAN		input_is_best_ssn;
		BOOLEAN   is_fuzzy_fname_match;
		BOOLEAN   is_fuzzy_lname_match;
		BOOLEAN 	is_fuzzy_full_name_match;
		STRING1   SSN_match;			 
		STRING1   FN_LN_match;     
		STRING1   Address_match;
		
		STRING1   poss_shared_ssn;
		STRING2   HRI_code;
		STRING50  HRI_desc;
		STRING60  aka_1;			
		STRING60  aka_2;			
		STRING60  aka_3;			
		best_address_full AND NOT [acctno];	// in batch_out, below, we display best_address, not best_address_full.
		STRING2   addr_in_out_of_home_state;
		BOOLEAN   input_is_hist_addr;
		best_ssn_full AND NOT [acctno];
		STRING9   expanded_ssn;
		STRING10  phone_number_1;		
		STRING10  phone_number_2;		
		STRING10  phone_number_3;		
		STRING20  lex_id;
		STRING1   deceased_indicator;
		STRING8   dod;
		STRING20  deceased_matchcode;
		STRING100 dl_addr1;		
		STRING25  dl_city;			
		STRING2   dl_st;			
		STRING5   dl_zip;			
		STRING8   dl_exp_date;
		batch_debtors;
	END;

	EXPORT batch_working_plus_seq := RECORD
		INTEGER seq := 0;
		batch_working;
	END;
	
	EXPORT PropertySubject := RECORD
		STRING20 	acctno;
		STRING 		PropertySubject_did;
		STRING20	PropertySubject_fname;
		STRING20 	PropertySubject_lname;
		STRING9		PropertySubject_ssn;
	END;

	EXPORT batch_out := RECORD 
		batch_in_raw - [NCOA_Prim_range, NCOA_Predir, NCOA_Prim_name, NCOA_addr_Suffix, NCOA_Postdir, 
									  NCOA_Unit_desig, NCOA_Sec_range, NCOA_Addr2];
		STRING8   conf_score;	
		STRING100 conf_score_desc;	
		STRING20  best_fname;		
		STRING20  best_lname;	
		STRING1   poss_shared_ssn;
		STRING1 	SSN_match;
		STRING1 	FN_LN_match;
		STRING1 	Address_match;
		
		STRING2   HRI_code;
		STRING50  HRI_desc;
		STRING60  aka_1;			
		STRING60  aka_2;			
		STRING60  aka_3;			
		best_address AND NOT [acctno];		
		STRING2   addr_in_out_of_home_state;
		best_ssn AND NOT [acctno];
		STRING9   expanded_ssn;
		STRING10  phone_number_1;		
		STRING10  phone_number_2;		
		STRING10  phone_number_3;		
		STRING20  lex_id;
		STRING1   deceased_indicator;
		STRING8   dod;
		STRING20  deceased_matchcode;
		STRING100 dl_addr1;		
		STRING25  dl_city;			
		STRING2   dl_st;			
		STRING5   dl_zip;			
		STRING8   dl_exp_date;
		batch_debtors;
		STRING50  record_err_msg;
		BOOLEAN   is_rejected_rec;
		BatchShare.Layouts.ShareErrors;
	END;

END;