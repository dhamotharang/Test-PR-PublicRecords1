﻿IMPORT BankruptcyV3_Services, BankruptcyV3, BIPV2, FFD;


export layout_BankruptcyV3_Batch_out := RECORD
  unsigned        SequenceNumber :=0; //FCRA FFD
	STRING30				matchcode := '';
	STRING30 				acctno;
	BIPV2.IDlayouts.l_key_ids_bare;
	
	BankruptcyV3_Services.layouts.layout_rollup 
		and not [debtors, matched_party, attorneys, trustee, comment_history, status_history, docket_history, StatementIds, isDisputed];
	
	STRING1					method_dismiss;
	STRING20				case_status;
	
	// debtor names
	STRING2 				debtor_1_type;
	STRING50				debtor_1_orig_name;
	STRING50 				debtor_1_orig_lname;
	STRING50 				debtor_1_orig_fname;
	STRING30 				debtor_1_orig_mname;
	STRING5 				debtor_1_orig_name_suffix;
	STRING50 				debtor_1_cname;
	STRING50 				debtor_1_lname;
	STRING50 				debtor_1_fname;
	STRING30 				debtor_1_mname;
	STRING5 				debtor_1_name_suffix;

	STRING2	 				debtor_2_type;
	STRING50				debtor_2_orig_name;
	STRING50 				debtor_2_orig_lname;
	STRING50 				debtor_2_orig_fname;
	STRING30 				debtor_2_orig_mname;
	STRING5 				debtor_2_orig_name_suffix;
	STRING50 				debtor_2_cname;
	STRING50 				debtor_2_lname;
	STRING50 				debtor_2_fname;
	STRING30				debtor_2_mname;
	STRING5 				debtor_2_name_suffix;

	STRING2 				debtor_3_type;			
	STRING50				debtor_3_orig_name;
	STRING50 				debtor_3_orig_lname;
	STRING50 				debtor_3_orig_fname;
	STRING30 				debtor_3_orig_mname;
	STRING5 				debtor_3_orig_name_suffix;
	STRING50 				debtor_3_cname;
	STRING50 				debtor_3_lname;
	STRING50 				debtor_3_fname;
	STRING30 				debtor_3_mname;
	STRING5 				debtor_3_name_suffix;
			
	STRING2 				debtor_4_type;
	STRING50				debtor_4_orig_name;
	STRING50 				debtor_4_orig_lname;
	STRING50 				debtor_4_orig_fname;
	STRING30 				debtor_4_orig_mname;
	STRING5 				debtor_4_orig_name_suffix;
	STRING50 				debtor_4_cname;
	STRING50 				debtor_4_lname;
	STRING50 				debtor_4_fname;
	STRING30 				debtor_4_mname;
	STRING5 				debtor_4_name_suffix;
	
	STRING2 				debtor_5_type;
	STRING50				debtor_5_orig_name;
	STRING50 				debtor_5_orig_lname;
	STRING50 				debtor_5_orig_fname;
	STRING30 				debtor_5_orig_mname;
	STRING5 				debtor_5_orig_name_suffix;
	STRING50 				debtor_5_cname;
	STRING50 				debtor_5_lname;
	STRING50 				debtor_5_fname;
	STRING30 				debtor_5_mname;
	STRING5 				debtor_5_name_suffix;

	// debtor address
	STRING80				debtor_orig_addr1;
	STRING80				debtor_orig_addr2;
	STRING80				debtor_orig_city;
	STRING2					debtor_orig_st;
	STRING5					debtor_orig_zip5;
	STRING4					debtor_orig_zip4;
	STRING10        		debtor_prim_range;
	STRING2         		debtor_predir;		
	STRING28        		debtor_prim_name;
	STRING4         		debtor_addr_suffix;
	STRING2         		debtor_postdir;
	STRING10        		debtor_unit_desig;
	STRING8         		debtor_sec_range;
	STRING25        		debtor_p_city_name;
	STRING25        		debtor_v_city_name;
	STRING2         		debtor_st;
	STRING5         		debtor_zip;
	STRING4         		debtor_zip4;
	STRING10				debtor_phone;
	STRING4					debtor_phone_tz;
	
	// debtors extras
	STRING1					debtor_type_1;
	STRING12				debtor_did;
	STRING12				debtor_bdid;
	STRING9					debtor_app_ssn;
	STRING9					debtor_ssn;
	STRING9					debtor_app_tax_id;
	STRING9					debtor_tax_id;
	STRING3					debtor_chapter;
	STRING1					debtor_corp_flag;
	STRING35				debtor_disposition;
	STRING3					debtor_pro_se_ind;
	STRING8					debtor_converted_date;
	STRING12				debtor_caseid;
	STRING12				debtor_defendantid;
	STRING12				debtor_recid;
	STRING1					debtor_filing_type;
	STRING1					debtor_business_flag;
	STRING8					debtor_discharged;
	STRING30				debtor_orig_county;
	STRING1					debtor_ssnsrc;
	STRING35				debtor_srcdesc;
	STRING9					debtor_ssnmatch;
	STRING35				debtor_srcmtchdesc;
	STRING1					debtor_ssnmsrc;
	STRING1					debtor_screen;
	STRING35				debtor_screendesc;
	STRING2					debtor_dcode;
	STRING35				debtor_dcodedesc;
	STRING3					debtor_disptype;
	STRING35				debtor_disptypedesc;
	STRING3					debtor_dispreason;
	STRING8					debtor_statusdate;
	STRING8					debtor_holdcase;
	STRING8					debtor_datevacated;
	STRING8					debtor_datetransferred;
	STRING12				debtor_activityreceipt;
	
	STRING10				debtor_withdrawnid;
	STRING8					debtor_withdrawndate;
	STRING8					debtor_withdrawndispositiondate;
	STRING35				debtor_withdrawndisposition;
	// STRING debtor_person_filter_id;
	
	// matched party
	STRING2 				matched_party_type;
	STRING50 				matched_party_orig_name;
	STRING50 				matched_party_orig_lname;
	STRING50 				matched_party_orig_fname;
	STRING30 				matched_party_orig_mname;
	STRING5 				matched_party_orig_name_suffix;
	STRING50 				matched_party_cname;
	STRING50 				matched_party_lname;
	STRING50 				matched_party_fname;
	STRING30				matched_party_mname;
	STRING80				matched_party_orig_addr1;
	STRING80				matched_party_orig_addr2;
	STRING80				matched_party_orig_city;
	STRING2					matched_party_orig_st;
	STRING5					matched_party_orig_zip5;
	STRING4					matched_party_orig_zip4;
	STRING10        		matched_party_prim_range;
	STRING2         		matched_party_predir;		
	STRING28        		matched_party_prim_name;
	STRING4         		matched_party_addr_suffix;
	STRING2         		matched_party_postdir;
	STRING10        		matched_party_unit_desig;
	STRING8         		matched_party_sec_range;
	STRING25        		matched_party_p_city_name;
	STRING25        		matched_party_v_city_name;
	STRING2         		matched_party_st;
	STRING5         		matched_party_zip;
	STRING4         		matched_party_zip4;
			
	// attorney
	STRING2 				atty_party_type_1;
	STRING12				atty_did;
	STRING12				atty_bdid;
	STRING9					atty_app_ssn;
	STRING9					atty_ssn;
	STRING9					atty_app_tax_id;
	STRING9					atty_tax_id;
			
	STRING50				atty_1_orig_name;
	STRING50 				atty_1_orig_lname;
	STRING50 				atty_1_orig_fname;
	STRING30 				atty_1_orig_mname;
	STRING5 				atty_1_orig_name_suffix;
	STRING50 				atty_1_cname;
	STRING50 				atty_1_lname;
	STRING50 				atty_1_fname;
	STRING30				atty_1_mname;
	STRING5					atty_1_name_suffix;
	STRING80				atty_1_orig_addr1;
	STRING80				atty_1_orig_addr2;
	STRING80				atty_1_orig_city;
	STRING2					atty_1_orig_st;
	STRING5					atty_1_orig_zip5;
	STRING4					atty_1_orig_zip4;
	STRING10        		atty_1_prim_range;
	STRING2         		atty_1_predir;		
	STRING28       			atty_1_prim_name;
	STRING4         		atty_1_addr_suffix;
	STRING2         		atty_1_postdir;
	STRING10        		atty_1_unit_desig;
	STRING8         		atty_1_sec_range;
	STRING25        		atty_1_p_city_name;
	STRING25        		atty_1_v_city_name;
	STRING2         		atty_1_st;
	STRING5         		atty_1_zip;
	STRING4         		atty_1_zip4;
	STRING10   				atty_1_phone; 
	STRING4	 				atty_1_phone_tz;
	STRING10				atty_1_fax;
	STRING250				atty_1_email;
			
	STRING50				atty_2_orig_name;
	STRING50 				atty_2_orig_lname;
	STRING50 				atty_2_orig_fname;
	STRING30 				atty_2_orig_mname;
	STRING5 				atty_2_orig_name_suffix;
	STRING50 				atty_2_cname;
	STRING50 				atty_2_lname;
	STRING50 				atty_2_fname;
	STRING30				atty_2_mname;
	STRING5					atty_2_name_suffix;
	STRING80				atty_2_orig_addr1;
	STRING80				atty_2_orig_addr2;
	STRING80				atty_2_orig_city;
	STRING2					atty_2_orig_st;
	STRING5					atty_2_orig_zip5;
	STRING4					atty_2_orig_zip4;
	STRING10        		atty_2_prim_range;
	STRING2         		atty_2_predir;		
	STRING28        		atty_2_prim_name;
	STRING4         		atty_2_addr_suffix;
	STRING2         		atty_2_postdir;
	STRING10        		atty_2_unit_desig;
	STRING8         		atty_2_sec_range;
	STRING25        		atty_2_p_city_name;
	STRING25        		atty_2_v_city_name;
	STRING2         		atty_2_st;
	STRING5         		atty_2_zip;
	STRING4         		atty_2_zip4;
	STRING10   				atty_2_phone; 
	STRING4	 				atty_2_phone_tz;
	STRING10				atty_2_fax;
	STRING250				atty_2_email;
			
	// trustee
	STRING12 				trustee_did;
	STRING12				trustee_id;
	STRING9					trustee_app_ssn;
	STRING50				trustee_name;
	STRING5					trustee_title;
	STRING20				trustee_fname;
	STRING20				trustee_mname;
	STRING20				trustee_lname;
	STRING5					trustee_name_suffix;
	STRING3					trustee_name_score;
	STRING90				trustee_orig_addr;
	STRING25				trustee_orig_city;
	STRING2					trustee_orig_st;
	STRING5					trustee_orig_zip;
	STRING4					trustee_orig_zip4;
	STRING10        		trustee_prim_range;
	STRING2         		trustee_predir;
	STRING28        		trustee_prim_name;
	STRING4         		trustee_addr_suffix;
	STRING2         		trustee_postdir;
	STRING10        		trustee_unit_desig;
	STRING8         		trustee_sec_range;
	STRING25        		trustee_p_city_name;
	STRING25        		trustee_v_city_name;
	STRING2         		trustee_st;
	STRING5         		trustee_zip;
	STRING4         		trustee_zip4;
	STRING4         		trustee_cart;
	STRING1         		trustee_cr_sort_sz;
	STRING4         		trustee_lot;
	STRING1        			trustee_lot_order;
	STRING2         		trustee_dbpc;
	STRING1         		trustee_chk_digit;
	STRING2         		trustee_rec_type;
	STRING5         		trustee_county;
	STRING10        		trustee_geo_lat;
	STRING11        		trustee_geo_long;
	STRING4         		trustee_msa;
	STRING7         		trustee_geo_blk;
	STRING1         		trustee_geo_match;
	STRING4         		trustee_err_stat;
	STRING10 				trustee_phone;
		
	// court
	string10				moxie_court;
	string35				court_addr;
	string20				court_city;
	string2					court_st;
	string5					court_zip;
	string10 				court_phone;
	string40				court_district;
	string20				court_cfiled;
	string5					boca_court;
	unsigned5				c3courtid;
	string35				court_addr2;
	string10				court_fax;
	string3					courtid;
	string2					court_div;
	string7					hoganID;
	string4					court;
	string1					court_active;
			
	// status history
	STRING8					status_1_date;
	STRING30				status_1_type;
	STRING8					status_2_date;
	STRING30				status_2_type;
	STRING8					status_3_date;
	STRING30				status_3_type;
	STRING8					status_4_date;
	STRING30 				status_4_type;
	STRING8					status_5_date;
	STRING30 				status_5_type;
	STRING8					status_6_date;
	STRING30				status_6_type;
			
	// comment history
	STRING8					comment_1_fdate;
	STRING30				comment_1_desc;
	STRING8					comment_2_fdate;
	STRING30				comment_2_desc;
	STRING8					comment_3_fdate;
	STRING30				comment_3_desc;
	STRING8					comment_4_fdate;
	STRING30				comment_4_desc;
	STRING8					comment_5_fdate;
	STRING30				comment_5_desc;
	STRING8					comment_6_fdate;
	STRING30				comment_6_desc;
	FFD.Layouts.ConsumerFlags;
END;