IMPORT BatchServices, Corrections;

EXPORT TaxRefundISv3_BatchService_Layouts := MODULE

    export rec_batch_in := record
			BatchServices.Layouts.layout_batch_common_acct; // acctno AKA pre-kettle client_id
      unsigned8 seq      := 0;          // for internal use
			string9   ssn      := '';
			BatchServices.Layouts.layout_batch_common_name;    //common person name fields
			BatchServices.Layouts.layout_batch_common_address; //common address parts fields
      string40  address  := '';                          //unparsed street address
			string8   dob      := '';
      //additional TRISv3 input fields			
      string15  refund_amount := '';
			string45  ip_address    := '';
			string30  filer_type     := ''; 

			// TRIS v3.2 Enhancement : Req # 3.3.1
			string50 	aba_rout_nbr := '';
			string50 	txpy_bank_acct_nbr := '';
			string50 	routing_transit_nbr := '';
			string50 	depositor_account_num := '';
			string45 	device_ini_ip_address := '';
			string45 	device_submit_ip_address := '';
			string50 	email_address := '';
			string50 	prep_id2 := '';
		end;

    export rec_batch_in_wdid := record
      rec_batch_in;
      unsigned6 did; 
			string4  addr_status := ''; // to display hri code 11 in TRIS v3.1
    end; 

    // slimmed output of the bankruptcy batch service
		export rec_bankr_res := record
		  string30  acctno;
			unsigned6 bankr_did;
			string8   date_filed;
			string8   orig_filing_date;
		end;

    // slimmed output of the driver license batch service
		export rec_dl_res := record
		  string30  acctno;
			unsigned6 dl_did;
			unsigned4 lic_issue_date;
		end;

    // slimmed output of the property batch service
		export rec_propdeed_res := record
		  string30  acctno;
			unsigned6 deed_did;
			string8   deed_contract_date;
			string8   deed_recording_date;
		end;

    // slimmed output of the vehicle batch service
		export rec_mvr_res := record
		  string30 acctno;
			unsigned6 mvr_did;
			string8   reg_first_date;
			string8   reg_latest_effective_date;
		end;

    // slimmed output of the voter batch service
 		export rec_voter_res := record
		  string30  acctno;
		  unsigned6 voter_did;
			string8   RegDate;
			string8   LastDateVote;
		end;

		//used this in the normalized version    
		export rec_lien := record
		  STRING30	 	acctno      	:= '';
	    string50 filing_jurisdiction;
      string21 filing_jurisdiction_name;
	    string20 orig_filing_number;
      string30 orig_filing_type;
      string8  orig_filing_date;
      string20 tax_code;
      string11 irs_serial_number;
      string8  release_date;
      string15 amount;
      string1  eviction;
      string8  judg_satisfied_date;
      string8  judg_vacated_date;
      string100 judge;
      string100 filing_status;	
    end;			
		
		export rec_batch_out := record
			rec_batch_in;   //input data (see layout above)
			
      string12  did;  // AKA LexID
			// from ADL best
			string9	  best_ssn;
			string3   possible_age_dob;
			string3   possible_age_ssn_issuance;
			//from AddrBest
			string2   address_outside_of_agency_state; // 'OS' or blank
			string1   Address_Confidence;
			string30  best_fname;
			string30  best_lname;
			string120	best_addr1;
			string30	best_city;
			string2		best_state;
			string5		best_zip;
			string6   date_last_seen; //YYYYMM format
			string6   InputAddrDate;    // YYYYMM format
			string1   MatchedInputAddr; // Y or N
			string6   InputAddrZipDate; // YYYYMM format or YYYYMMDD???
			string1   InputAddrState;   // Y or N

			// TRIS v3.2 Enhancement : Req # 3.1.11 & 3.1.12
			string6			InputAddrFirst_Seen;
			string6   InputAddrLast_Seen;

			//from deceased
			string30  deceased_first_name;
			string30  deceased_last_name;
			string8   DOD; //YYYYMMDD format
			string5   deceased_matchcode; 
			string1   dod_bkr_flag;      // Y or blank
			string1   dod_dl_flag;       // Y or blank
			string1   dod_deed_flag;     // Y or blank
			string1   dod_mvr_flag;      // Y or blank
			string1   dod_voter_flag;    // Y or blank

			//from criminal Department of Corrections (DOC) data based on input SSN
			string2   doc_state_origin;
			string12  doc_sdid;
			string9   doc_ssn_1;
			string30  doc_lname;
			string30  doc_fname;
			string30  doc_mname;
			string10  doc_num;
			string8   doc_dob; //YYYYMMDD format
			Corrections.Layout_Offender.curr_incar_flag;
			Corrections.Layout_Offender.curr_parole_flag;
			Corrections.Layout_Offender.curr_probation_flag;
			string75 off_desc_1_1;
			string50 cur_stat_inm_desc_1;
			string8  in_event_dt_1;
			string8  latest_adm_dt_1;
			string8  sch_rel_dt_1;
			string8  act_rel_dt_1;
			string8  ctl_rel_dt_1;

			//from criminal DOC data based on best SSN
			string2   doc_state_origin_BestSSN;
			string12  doc_sdid_BestSSN;
			string9   doc_ssn_1_BestSSN;
			string30  doc_lname_BestSSN;
			string30  doc_fname_BestSSN;
			string30  doc_mname_BestSSN;
			string10  doc_num_BestSSN;
			string8   doc_dob_BestSSN; //YYYYMMDD format
			string1	  curr_incar_flag_BestSSN;
			string1	  curr_parole_flag_BestSSN;
			string1	  curr_probation_flag_BestSSN;
			string75	off_desc_1_1_BestSSN;
			string50  cur_stat_inm_desc_1_BestSSN;
			string8   in_event_dt_1_BestSSN;
			string8	  latest_adm_dt_1_BestSSN;
			string8	  sch_rel_dt_1_BestSSN;
			string8	  act_rel_dt_1_BestSSN;
			string8	  ctl_rel_dt_1_BestSSN;

			// from High Risk Address service
			string1   InputAddrPrison;  // Y or blank

			// from Relatives, Neighbors & Associates
			string1   InputAddrRel;     // Y or N
			string1   InputRelLastName; // Y or N/blank???

			//from Identity Risk
			string3   VariationSSNCount;   //(0-255)
			string3   DivSSNIdentityCount; //(0-255)
			string2   IDVerSSN;            // Y or N?
			string1   SourcePublicRecord;  // Y or N
			string3   DivSSNLNameCount;    //(0-255)
			string1   IDVerName;           // Y or N

			//from Address Risk
			string2   ValidationAddrProblem; // Y or N?
			string2   InputAddrDwellType;    
			string2   IDVerAddress;          // Y or N?
			string3   DivAddrIdentityCount;  // (0-255)
			string3   DivAddrIdentityCountNew; // (0-255)
			string4   AddrChangeDistance;    // (0-9999)
			string3   InputAddrFelonyCount;  // (0-255)

			string2   ValidationIpProblems;   // -1, 0, 1 or 2 - see Models.Attributes_Master
			string1   IPAddrExceedsInputAddr; // 1 or blank

			// New Input Fields added for TRIS v3.2 Enhancement Project.
			string2   ValidationIpProblems1;   // -1, 0, 1 or 2 
			string1   IPAddrExceedsInputAddr1; // 1 or blank
			string2   ValidationIpProblems2;   // -1, 0, 1 or 2 
			string1   IPAddrExceedsInputAddr2; // 1 or blank
			string2   ValidationIpProblems3;   // -1, 0, 1 or 2 
			string1   IPAddrExceedsInputAddr3; // 1 or blank

			string1   phone_number;           // 1 or blank

			//from FraudPoint 2.0
			string3   score; // (0-999)the higher the score, the better the person.  see FraudPoint custom model

			// from liens & judgments.
			// up to 30 occurrences per req 4.1.49
			// where possible, field info cloned from LiensV2.layout_liens_main_module
			string50 filing_jurisdiction_01; //length per xls/per salt rpt longest is 46; has 2 char state abbrev or full county/court/district name
      string21 filing_jurisdiction_name_01; //length per xls; 
			string20 orig_filing_number_01;
      string30 orig_filing_type_01;
      string8  orig_filing_date_01;    //appears to be in YYYYMMDD format
      string20 tax_code_01;
      string11 irs_serial_number_01;   //length???/per salt rpt longest is 19, but majority are <=10
      string8  release_date_01;        //appears to be in YYYYMMDD format
      string15 amount_01;              //length???/per salt rpt longest is 26 which seems excessive? most are <= 12
      string1  eviction_01;            //length??? 15 in xls, but majority of recs appear to contain N, Y or blank, small amt have 1 digit 0-9
      string8  judg_satisfied_date_01; //appears to be in YYYYMMDD format
      string8  judg_vacated_date_01;   //appears to be in YYYYMMDD format
      string100 judge_01;               //length???/per salt rpt longest is 29
      string100 filing_status_01;       //length???/per salt rpt longest is 65, but majority are <= 26

 			string50 filing_jurisdiction_02;
      string21 filing_jurisdiction_name_02;
	    string20 orig_filing_number_02;
      string30 orig_filing_type_02;
      string8  orig_filing_date_02;
      string20 tax_code_02;
      string11 irs_serial_number_02;
      string8  release_date_02;
      string15 amount_02;
      string1  eviction_02;
      string8  judg_satisfied_date_02;
      string8  judg_vacated_date_02;
      string100 judge_02;
      string100 filing_status_02;	
      
			string50  filing_jurisdiction_03;
      string21  filing_jurisdiction_name_03;
	    string20 orig_filing_number_03;
      string30 orig_filing_type_03;
      string8  orig_filing_date_03;
      string20 tax_code_03;
      string11 irs_serial_number_03;
      string8  release_date_03;
      string15 amount_03;
      string1  eviction_03;
      string8  judg_satisfied_date_03;
      string8  judg_vacated_date_03;
      string100 judge_03;
      string100 filing_status_03;	
      
			string50  filing_jurisdiction_04;
      string21  filing_jurisdiction_name_04;
	    string20 orig_filing_number_04;
      string30 orig_filing_type_04;
      string8  orig_filing_date_04;
      string20 tax_code_04;
      string11 irs_serial_number_04;
      string8  release_date_04;
      string15 amount_04;
      string1  eviction_04;
      string8  judg_satisfied_date_04;
      string8  judg_vacated_date_04;
      string100 judge_04;
      string100 filing_status_04;	
      
			string50 filing_jurisdiction_05;
      string21 filing_jurisdiction_name_05;
	    string20 orig_filing_number_05;
      string30 orig_filing_type_05;
      string8  orig_filing_date_05;
      string20 tax_code_05;
      string11 irs_serial_number_05;
      string8  release_date_05;
      string15 amount_05;
      string1  eviction_05;
      string8  judg_satisfied_date_05;
      string8  judg_vacated_date_05;
      string100 judge_05;
      string100 filing_status_05;	
      
			string50  filing_jurisdiction_06;
      string21  filing_jurisdiction_name_06;
	    string20 orig_filing_number_06;
      string30 orig_filing_type_06;
      string8  orig_filing_date_06;
      string20 tax_code_06;
      string11 irs_serial_number_06;
      string8  release_date_06;
      string15 amount_06;
      string1  eviction_06;
      string8  judg_satisfied_date_06;
      string8  judg_vacated_date_06;
      string100 judge_06;
      string100 filing_status_06;	
      
			string50  filing_jurisdiction_07;
      string21  filing_jurisdiction_name_07;
	    string20 orig_filing_number_07;
      string30 orig_filing_type_07;
      string8  orig_filing_date_07;
      string20 tax_code_07;
      string11 irs_serial_number_07;
      string8  release_date_07;
      string15 amount_07;
      string1  eviction_07;
      string8  judg_satisfied_date_07;
      string8  judg_vacated_date_07;
      string100 judge_07;
      string100 filing_status_07;	

 			string50  filing_jurisdiction_08;
      string21  filing_jurisdiction_name_08;
	    string20 orig_filing_number_08;
      string30 orig_filing_type_08;
      string8  orig_filing_date_08;
      string20 tax_code_08;
      string11 irs_serial_number_08;
      string8  release_date_08;
      string15 amount_08;
      string1  eviction_08;
      string8  judg_satisfied_date_08;
      string8  judg_vacated_date_08;
      string100 judge_08;
      string100 filing_status_08;	

 			string50  filing_jurisdiction_09;
      string21  filing_jurisdiction_name_09;
	    string20 orig_filing_number_09;
      string30 orig_filing_type_09;
      string8  orig_filing_date_09;
      string20 tax_code_09;
      string11 irs_serial_number_09;
      string8  release_date_09;
      string15 amount_09;
      string1  eviction_09;
      string8  judg_satisfied_date_09;
      string8  judg_vacated_date_09;
      string100 judge_09;
      string100 filing_status_09;	

 			string50 filing_jurisdiction_10;
      string21  filing_jurisdiction_name_10;
	    string20 orig_filing_number_10;
      string30 orig_filing_type_10;
      string8  orig_filing_date_10;
      string20 tax_code_10;
      string11 irs_serial_number_10;
      string8  release_date_10;
      string15 amount_10;
      string1  eviction_10;
      string8  judg_satisfied_date_10;
      string8  judg_vacated_date_10;
      string100 judge_10;
      string100 filing_status_10;	

			string50 filing_jurisdiction_11; 
      string21 filing_jurisdiction_name_11; 
      string20 orig_filing_number_11;  
      string30 orig_filing_type_11;    
      string8  orig_filing_date_11;    
      string20 tax_code_11;            
      string11 irs_serial_number_11;   
      string8  release_date_11;        
      string15 amount_11;              
      string1  eviction_11;            
      string8  judg_satisfied_date_11; 
      string8  judg_vacated_date_11;   
      string100 judge_11;              
      string100 filing_status_11;      

      string50 filing_jurisdiction_12;
      string21 filing_jurisdiction_name_12;
      string20 orig_filing_number_12;
      string30 orig_filing_type_12;
      string8  orig_filing_date_12;
      string20 tax_code_12;
      string11 irs_serial_number_12;
      string8  release_date_12;
      string15 amount_12;
      string1  eviction_12;
      string8  judg_satisfied_date_12;
      string8  judg_vacated_date_12;
      string100 judge_12;
      string100 filing_status_12;	

			string50  filing_jurisdiction_13;
      string21  filing_jurisdiction_name_13;
      string20 orig_filing_number_13;
      string30 orig_filing_type_13;
      string8  orig_filing_date_13;
      string20 tax_code_13;
      string11 irs_serial_number_13;
      string8  release_date_13;
      string15 amount_13;
      string1  eviction_13;
      string8  judg_satisfied_date_13;
      string8  judg_vacated_date_13;
      string100 judge_13;
      string100 filing_status_13;	

 			string50  filing_jurisdiction_14;
      string21  filing_jurisdiction_name_14;
      string20 orig_filing_number_14;
      string30 orig_filing_type_14;
      string8  orig_filing_date_14;
      string20 tax_code_14;
      string11 irs_serial_number_14;
      string8  release_date_14;
      string15 amount_14;
      string1  eviction_14;
      string8  judg_satisfied_date_14;
      string8  judg_vacated_date_14;
      string100 judge_14;
      string100 filing_status_14;	

 			string50  filing_jurisdiction_15;
      string21  filing_jurisdiction_name_15;
      string20 orig_filing_number_15;
      string30 orig_filing_type_15;
      string8  orig_filing_date_15;
      string20 tax_code_15;
      string11 irs_serial_number_15;
      string8  release_date_15;
      string15 amount_15;
      string1  eviction_15;
      string8  judg_satisfied_date_15;
      string8  judg_vacated_date_15;
      string100 judge_15;
      string100 filing_status_15;	

      string50  filing_jurisdiction_16;
      string21  filing_jurisdiction_name_16;
      string20 orig_filing_number_16;
      string30 orig_filing_type_16;
      string8  orig_filing_date_16;
      string20 tax_code_16;
      string11 irs_serial_number_16;
      string8  release_date_16;
      string15 amount_16;
      string1  eviction_16;
      string8  judg_satisfied_date_16;
      string8  judg_vacated_date_16;
      string100 judge_16;
      string100 filing_status_16;	

 			string50  filing_jurisdiction_17;
      string21  filing_jurisdiction_name_17;
      string20 orig_filing_number_17;
      string30 orig_filing_type_17;
      string8  orig_filing_date_17;
      string20 tax_code_17;
      string11 irs_serial_number_17;
      string8  release_date_17;
      string15 amount_17;
      string1  eviction_17;
      string8  judg_satisfied_date_17;
      string8  judg_vacated_date_17;
      string100 judge_17;
      string100 filing_status_17;	

			string50  filing_jurisdiction_18;
      string21  filing_jurisdiction_name_18;
      string20 orig_filing_number_18;
      string30 orig_filing_type_18;
      string8  orig_filing_date_18;
      string20 tax_code_18;
      string11 irs_serial_number_18;
      string8  release_date_18;
      string15 amount_18;
      string1  eviction_18;
      string8  judg_satisfied_date_18;
      string8  judg_vacated_date_18;
      string100 judge_18;
      string100 filing_status_18;	

			string50  filing_jurisdiction_19;
      string21  filing_jurisdiction_name_19;
      string20 orig_filing_number_19;
      string30 orig_filing_type_19;
      string8  orig_filing_date_19;
      string20 tax_code_19;
      string11 irs_serial_number_19;
      string8  release_date_19;
      string15 amount_19;
      string1  eviction_19;
      string8  judg_satisfied_date_19;
      string8  judg_vacated_date_19;
      string100 judge_19;
      string100 filing_status_19;	

 			string50 filing_jurisdiction_20;
      string21  filing_jurisdiction_name_20;
      string20 orig_filing_number_20;
      string30 orig_filing_type_20;
      string8  orig_filing_date_20;
      string20 tax_code_20;
      string11 irs_serial_number_20;
      string8  release_date_20;
      string15 amount_20;
      string1  eviction_20;
      string8  judg_satisfied_date_20;
      string8  judg_vacated_date_20;
      string100 judge_20;
      string100 filing_status_20;	
			
      string50 filing_jurisdiction_21; 
      string21 filing_jurisdiction_name_21; 
      string20 orig_filing_number_21;  
      string30 orig_filing_type_21;    
      string8  orig_filing_date_21;    
      string20 tax_code_21;            
      string11 irs_serial_number_21;   
      string8  release_date_21;        
      string15 amount_21;              
      string1  eviction_21;            
      string8  judg_satisfied_date_21; 
      string8  judg_vacated_date_21;   
      string100 judge_21;              
      string100 filing_status_21;      

      string50 filing_jurisdiction_22;
      string21 filing_jurisdiction_name_22;
      string20 orig_filing_number_22;
      string30 orig_filing_type_22;
      string8  orig_filing_date_22;
      string20 tax_code_22;
      string11 irs_serial_number_22;
      string8  release_date_22;
      string15 amount_22;
      string1  eviction_22;
      string8  judg_satisfied_date_22;
      string8  judg_vacated_date_22;
      string100 judge_22;
      string100 filing_status_22;	

 			string50  filing_jurisdiction_23;
      string21  filing_jurisdiction_name_23;
      string20 orig_filing_number_23;
      string30 orig_filing_type_23;
      string8  orig_filing_date_23;
      string20 tax_code_23;
      string11 irs_serial_number_23;
      string8  release_date_23;
      string15 amount_23;
      string1  eviction_23;
      string8  judg_satisfied_date_23;
      string8  judg_vacated_date_23;
      string100 judge_23;
      string100 filing_status_23;	

  		string50  filing_jurisdiction_24;
      string21  filing_jurisdiction_name_24;
      string20 orig_filing_number_24;
      string30 orig_filing_type_24;
      string8  orig_filing_date_24;
      string20 tax_code_24;
      string11 irs_serial_number_24;
      string8  release_date_24;
      string15 amount_24;
      string1  eviction_24;
      string8  judg_satisfied_date_24;
      string8  judg_vacated_date_24;
      string100 judge_24;
      string100 filing_status_24;	

      string50  filing_jurisdiction_25;
      string21  filing_jurisdiction_name_25;
      string20 orig_filing_number_25;
      string30 orig_filing_type_25;
      string8  orig_filing_date_25;
      string20 tax_code_25;
      string11 irs_serial_number_25;
      string8  release_date_25;
      string15 amount_25;
      string1  eviction_25;
      string8  judg_satisfied_date_25;
      string8  judg_vacated_date_25;
      string100 judge_25;
      string100 filing_status_25;	

 			string50  filing_jurisdiction_26;
      string21  filing_jurisdiction_name_26;
      string20 orig_filing_number_26;
      string30 orig_filing_type_26;
      string8  orig_filing_date_26;
      string20 tax_code_26;
      string11 irs_serial_number_26;
      string8  release_date_26;
      string15 amount_26;
      string1  eviction_26;
      string8  judg_satisfied_date_26;
      string8  judg_vacated_date_26;
      string100 judge_26;
      string100 filing_status_26;	

			string50  filing_jurisdiction_27;
      string21  filing_jurisdiction_name_27;
      string20 orig_filing_number_27;
      string30 orig_filing_type_27;
      string8  orig_filing_date_27;
      string20 tax_code_27;
      string11 irs_serial_number_27;
      string8  release_date_27;
      string15 amount_27;
      string1  eviction_27;
      string8  judg_satisfied_date_27;
      string8  judg_vacated_date_27;
      string100 judge_27;
      string100 filing_status_27;	

			string50  filing_jurisdiction_28;
      string21  filing_jurisdiction_name_28;
      string20 orig_filing_number_28;
      string30 orig_filing_type_28;
      string8  orig_filing_date_28;
      string20 tax_code_28;
      string11 irs_serial_number_28;
      string8  release_date_28;
      string15 amount_28;
      string1  eviction_28;
      string8  judg_satisfied_date_28;
      string8  judg_vacated_date_28;
      string100 judge_28;
      string100 filing_status_28;	

 			string50  filing_jurisdiction_29;
      string21  filing_jurisdiction_name_29;
      string20 orig_filing_number_29;
      string30 orig_filing_type_29;
      string8  orig_filing_date_29;
      string20 tax_code_29;
      string11 irs_serial_number_29;
      string8  release_date_29;
      string15 amount_29;
      string1  eviction_29;
      string8  judg_satisfied_date_29;
      string8  judg_vacated_date_29;
      string100 judge_29;
      string100 filing_status_29;	

 			string50 filing_jurisdiction_30;
      string21  filing_jurisdiction_name_30;
      string20 orig_filing_number_30;
      string30 orig_filing_type_30;
      string8  orig_filing_date_30;
      string20 tax_code_30;
      string11 irs_serial_number_30;
      string8  release_date_30;
      string15 amount_30;
      string1  eviction_30;
      string8  judg_satisfied_date_30;
      string8  judg_vacated_date_30;
      string100 judge_30;
      string100 filing_status_30;

			string20 output_status :=''; // Note: Can't use just "output" for 
																	 // field name as listed multiple places in reqs. 
																	 // Contains: Manual Review, Quiz, Diversionary Quiz, 
																	 //	No Quiz, Debt Evasion or Rejected

			unsigned2 Royalty_NAG; // Royalty.RoyaltyNetAcuity.IPData.Royalty_NAG;

			// TRIS v3 2015 enhancement, new field ---v
			string4   BestAddrChangeDistance; // "-1" or 0-9999 // TRIS v3 2015 enhancements req 4.1.10
			// v3.1 with fdn
			boolean fdn_id_risk;
			unsigned1 FDN_Count  := 0;

			string15 risk_status;
			string1 identity_risk;
			string1 address_risk;
			string4 hri_1_code;
			string100 hri_1_desc1;
			string4 hri_2_code;
			string100 hri_2_desc2;

			// New Fields for hri_3_code & hri_4_code added for TRIS v3.2 Enhancement Project.
			string4 hri_3_code;
			string4 hri_4_code;

			unsigned3 derogatory_count;
			unsigned3 asset_count;
			unsigned3 professional_count;

			String25  Suspected_Discrepancy1 ;
			string10  Confidence_that_activity_was_deceitful1;
			string10  Channels1 ;
			string50  Threat1 ;
			string25 Entity_type1 ;
			string25 role1 ;
			string10 Evidence1 ;

			String25  Suspected_Discrepancy2 ;
			string10  Confidence_that_activity_was_deceitful2;
			string10  Channels2;
			string50  Threat2;
			string25 Entity_type2;
			string25 role2;
			string10 Evidence2;

			String25  Suspected_Discrepancy3;
			string10  Confidence_that_activity_was_deceitful3;
			string10  Channels3;
			string50  Threat3;
			string25 Entity_type3;
			string25 role3;
			string10 Evidence3;

			// New Fields added for TRIS v3.2 Enhancement Project.
			string5  edge_country1;
			string10 edge_region1;
			string60 edge_city1;
			string10 edge_conn_speed1;
			string10 edge_latitude1;
			string10 edge_longitude1;
			string10 edge_postal_code1;
			unsigned edge_continent_code1;
			unsigned edge_country_conf1;
			unsigned edge_region_conf1;
			unsigned edge_city_conf1;
			unsigned edge_postal_conf1;
			string200 isp_name1;
			integer  edge_gmt_offset1;
			string70 domain_name1;
			string15 proxy_type1;
			string15 proxy_description1;
			unsigned asn1;
			string200 asn_name1;
			string5  edge_country2;
			string10 edge_region2;
			string60 edge_city2;
			string10 edge_conn_speed2;
			string10 edge_latitude2;
			string10 edge_longitude2;
			string10 edge_postal_code2;
			unsigned edge_continent_code2;
			unsigned edge_country_conf2;
			unsigned edge_region_conf2;
			unsigned edge_city_conf2;
			unsigned edge_postal_conf2;
			string200 isp_name2;
			integer  edge_gmt_offset2;
			string70 domain_name2;
			string15 proxy_type2;
			string15 proxy_description2;
			unsigned asn2;
			string200 asn_name2;
			string5  edge_country3;
			string10 edge_region3;
			string60 edge_city3;
			string10 edge_conn_speed3;
			string10 edge_latitude3;
			string10 edge_longitude3;
			string10 edge_postal_code3;
			unsigned edge_continent_code3;
			unsigned edge_country_conf3;
			unsigned edge_region_conf3;
			unsigned edge_city_conf3;
			unsigned edge_postal_conf3;
			string200 isp_name3;
			integer  edge_gmt_offset3;
			string70 domain_name3;
			string15 proxy_type3;
			string15 proxy_description3;
			unsigned asn3;
			string200 asn_name3;
			string25 Contrib_Risk_Field1;
			string50 Contrib_Risk_Value1;
			string  Contrib_Risk_Attr1;
			string25 Contrib_Risk_Field2;
			string50 Contrib_Risk_Value2;
			string  Contrib_Risk_Attr2;
			string25 Contrib_Risk_Field3;
			string50 Contrib_Risk_Value3;
			string  Contrib_Risk_Attr3;		
		end;
END;
