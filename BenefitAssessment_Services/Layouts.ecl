import BankruptcyV3, Batchshare, BatchServices, BenefitAssessment_Services, CriminalRecords_BatchService, doxie, 
			 doxie_files, faa, fcra, iesp, LiensV2, LN_PropertyV2, LN_PropertyV2_Services, marriage_divorce_v2_Services,
	     Prof_LicenseV2, paw, Risk_Indicators, SexOffender, SexOffender_Services, watercraft;

EXPORT Layouts := MODULE

		EXPORT Batch_In := RECORD
				BatchShare.Layouts.ShareAcct;
				BatchShare.Layouts.ShareDid;
				BatchShare.Layouts.ShareName;
				BatchShare.Layouts.ShareAddress;
				BatchShare.Layouts.SharePII;
				string2 INPUT_STATE := '';
				string10  	homephone := '';
				string10  	workphone := '';
		END;
	
		EXPORT Batch_In_plus := RECORD
				Batch_In.acctno;
				Batch_In.did; 
				TYPEOF(Batch_In.name_first) 	Input_Name_First;
				TYPEOF(Batch_In.name_middle) 	Input_Name_Middle;
				TYPEOF(Batch_In.name_last) 		Input_Name_Last;
				Batch_In.name_suffix;
				Batch_In.addr;
				TYPEOF(Batch_In.prim_range) 	Input_Prim_Range;
				TYPEOF(Batch_In.predir) 			Input_predir;
				TYPEOF(Batch_In.prim_name) 		Input_Prim_Name;
				TYPEOF(Batch_In.addr_suffix) 	Input_addr_suffix;
				TYPEOF(Batch_In.postdir) 			Input_postdir;
				TYPEOF(Batch_In.unit_desig) 	Input_unit_desig;
				TYPEOF(Batch_In.sec_range) 		Input_Sec_Range;
				TYPEOF(Batch_In.p_city_name) 	Input_p_city_name;
				TYPEOF(Batch_In.st) 					Input_st;
				TYPEOF(Batch_In.z5) 					Input_z5;
				TYPEOF(Batch_In.ssn) 					Input_ssn;
				TYPEOF(Batch_In.dob) 					Input_dob;	
				Batch_In.INPUT_STATE;
				Batch_In.homephone;
				Batch_In.workphone;
				BatchShare.Layouts.ShareErrors;
		END;

		EXPORT Batch_In_Shared := RECORD
				Batch_In;
				BatchShare.Layouts.ShareErrors;
		END;
		
		EXPORT layout_dec := RECORD
				string2		DeceasedMatchCode;
				string20	DeceasedFirstName;
				string20	DeceasedLastName;
				string8		DeceasedDOB;
				string8		DeceasedDOD;
		END;
		
		EXPORT layout_incr := RECORD	
				BatchShare.Layouts.ShareAcct;
				TYPEOF(CriminalRecords_BatchService.Layouts.batch_pii_out.incarceration_flag) Incarcerated_Flag;
				CriminalRecords_BatchService.Layouts.batch_pii_out.INCR_state_origin;
				CriminalRecords_BatchService.Layouts.batch_pii_out.INCR_doc_num;
				CriminalRecords_BatchService.Layouts.batch_pii_out.INCR_dob;
				CriminalRecords_BatchService.Layouts.batch_pii_out.INCR_ssn;
				CriminalRecords_BatchService.Layouts.batch_pii_out.event_dt;
				CriminalRecords_BatchService.Layouts.batch_pii_out.punishment_type;
				CriminalRecords_BatchService.Layouts.batch_pii_out.sent_length;
				CriminalRecords_BatchService.Layouts.batch_pii_out.sent_length_desc;
				CriminalRecords_BatchService.Layouts.batch_pii_out.cur_stat_inm_desc;
				CriminalRecords_BatchService.Layouts.batch_pii_out.cur_loc_inm;
				CriminalRecords_BatchService.Layouts.batch_pii_out.cur_loc_sec;
				CriminalRecords_BatchService.Layouts.batch_pii_out.latest_adm_dt;
				CriminalRecords_BatchService.Layouts.batch_pii_out.sch_rel_dt;
				CriminalRecords_BatchService.Layouts.batch_pii_out.act_rel_dt;
				CriminalRecords_BatchService.Layouts.batch_pii_out.ctl_rel_dt;
				TYPEOF(CriminalRecords_BatchService.Layouts.batch_pii_out.match_type)	INCR_match_code;
				CriminalRecords_BatchService.Layouts.batch_pii_out.INCR_fname;	//INCR_fname1; 
				CriminalRecords_BatchService.Layouts.batch_pii_out.INCR_lname;	//INCR_lname1; 			
		END;
	
		EXPORT Layout_SSN := RECORD
			RECORDOF(Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA);	
			UNSIGNED6 did;
		END;

		EXPORT layout_sofr := RECORD
			BatchShare.Layouts.ShareAcct;
			String1 SOFR_Flag := '';
			TYPEOF(SexOffender_Services.Layouts.batch_out.first_name) SOFR_fname;         
			TYPEOF(SexOffender_Services.Layouts.batch_out.middle_name) SOFR_mname;
			TYPEOF(SexOffender_Services.Layouts.batch_out.last_name) SOFR_lname;
			TYPEOF(SexOffender_Services.Layouts.batch_out.name_suffix) SOFR_suffix;
			SexOffender_Services.Layouts.batch_out.address_1;
			SexOffender_Services.Layouts.batch_out.address_2;
			SexOffender_Services.Layouts.batch_out.address_3;
			SexOffender_Services.Layouts.batch_out.date_last_seen ;
			TYPEOF(SexOffender.Layout_Out_Main.reg_date_1) SOFR_reg_date_1;
			TYPEOF(SexOffender.Layout_Out_Main.reg_date_2) SOFR_reg_date_2;
			TYPEOF(SexOffender.Layout_Out_Main.reg_date_3) SOFR_reg_date_3;
			TYPEOF(SexOffender.Layout_Out_Main.offender_status) SOFR_status;
			TYPEOF(SexOffender.Layout_Out_Main.offender_category) SOFR_category;
			TYPEOF(SexOffender.Layout_Out_Main.risk_level_code) SOFR_risk_level_desc;
			TYPEOF(SexOffender.Layout_Out_Main.registration_type) SOFR_reg_type;	
			SexOffender_Services.Layouts.batch_out.ssn ;
			SexOffender_Services.Layouts.batch_out.sex;
			SexOffender_Services.Layouts.batch_out.dob;
			SexOffender_Services.Layouts.batch_out.hair_color ;
			SexOffender_Services.Layouts.batch_out.eye_color;
			SexOffender_Services.Layouts.batch_out.scars;
			SexOffender_Services.Layouts.batch_out.height;
			SexOffender_Services.Layouts.batch_out.weight;
			SexOffender_Services.Layouts.batch_out.race;
			SexOffender_Services.Layouts.batch_out.offender_id;
			SexOffender_Services.Layouts.batch_out.state_of_origin;
			SexOffender_Services.Layouts.batch_out.offense_1;
			SexOffender_Services.Layouts.batch_out.conviction_place_1 ;
			SexOffender_Services.Layouts.batch_out.conviction_date_1;
			SexOffender_Services.Layouts.batch_out.victim_minor_1;
			SexOffender_Services.Layouts.batch_out.conviction_jurisdiction_1;
			SexOffender_Services.Layouts.batch_out.court_case_number_1;
			SexOffender_Services.Layouts.batch_out.offense_date_1;
			SexOffender_Services.Layouts.batch_out.offense_2;
			SexOffender_Services.Layouts.batch_out.conviction_place_2 ;
			SexOffender_Services.Layouts.batch_out.conviction_date_2;
			SexOffender_Services.Layouts.batch_out.victim_minor_2;	
			SexOffender_Services.Layouts.batch_out.conviction_jurisdiction_2;
			SexOffender_Services.Layouts.batch_out.court_case_number_2;
			SexOffender_Services.Layouts.batch_out.offense_date_2;
			SexOffender_Services.Layouts.batch_out.offense_3;
			SexOffender_Services.Layouts.batch_out.conviction_place_3 ;
			SexOffender_Services.Layouts.batch_out.conviction_date_3;
			SexOffender_Services.Layouts.batch_out.victim_minor_3;	
			SexOffender_Services.Layouts.batch_out.conviction_jurisdiction_3;
			SexOffender_Services.Layouts.batch_out.court_case_number_3;
			SexOffender_Services.Layouts.batch_out.offense_date_3;
			SexOffender_Services.Layouts.batch_out.offense_4;
			SexOffender_Services.Layouts.batch_out.conviction_place_4 ;
			SexOffender_Services.Layouts.batch_out.conviction_date_4;
			SexOffender_Services.Layouts.batch_out.victim_minor_4;	
			SexOffender_Services.Layouts.batch_out.conviction_jurisdiction_4;
			SexOffender_Services.Layouts.batch_out.court_case_number_4;
			SexOffender_Services.Layouts.batch_out.offense_date_4;
			SexOffender_Services.Layouts.batch_out.offense_5;
			SexOffender_Services.Layouts.batch_out.conviction_place_5 ;
			SexOffender_Services.Layouts.batch_out.conviction_date_5;
			SexOffender_Services.Layouts.batch_out.victim_minor_5;	
			SexOffender_Services.Layouts.batch_out.conviction_jurisdiction_5;
			SexOffender_Services.Layouts.batch_out.court_case_number_5;
			SexOffender_Services.Layouts.batch_out.offense_date_5;
			SexOffender_Services.Layouts.batch_out.offense_6;   
			SexOffender_Services.Layouts.batch_out.conviction_place_6;
			SexOffender_Services.Layouts.batch_out.conviction_date_6;
			SexOffender_Services.Layouts.batch_out.victim_minor_6;	
			SexOffender_Services.Layouts.batch_out.conviction_jurisdiction_6;
			SexOffender_Services.Layouts.batch_out.court_case_number_6;
			SexOffender_Services.Layouts.batch_out.offense_date_6;
			SexOffender_Services.Layouts.batch_out.prim_range;
			SexOffender_Services.Layouts.batch_out.predir;
			SexOffender_Services.Layouts.batch_out.prim_name;
			SexOffender_Services.Layouts.batch_out.addr_suffix;
			SexOffender_Services.Layouts.batch_out.postdir;
			SexOffender_Services.Layouts.batch_out.unit_desig;
			SexOffender_Services.Layouts.batch_out.sec_range;
			SexOffender_Services.Layouts.batch_out.p_city_name;
			SexOffender_Services.Layouts.batch_out.v_city_name;
			TYPEOF(SexOffender_Services.Layouts.batch_out.st) state;
			TYPEOF(SexOffender_Services.Layouts.batch_out.zip5) zip;
		END;
	
		EXPORT layout_dec_crim_sofr := record
				Batch_In_plus;
				layout_dec;
				RECORDOF(layout_incr) AND NOT[acctno];	
				RECORDOF(layout_sofr) AND NOT[acctno];
		END;		

	SHARED keys_deeds := LN_PropertyV2.key_deed_fid();
	SHARED keys_assmt := LN_PropertyV2.key_assessor_fid();
	SHARED keys_search := LN_PropertyV2.key_search_fid();

	EXPORT rec_inputWithSearchID :=	RECORD
		layout_dec_crim_sofr;
		TYPEOF(Batch_In.did) search_did;
	END;

	EXPORT rec_propFidsOnInput := RECORD
		Batch_In_Plus; 
		LN_PropertyV2_Services.layouts.search_fid;
	END;

	EXPORT rec_propOutWithAcctno := RECORD
		LN_PropertyV2_Services.layouts.combined.widest; 
		Batch_In.acctno;		
	END;
	
	SHARED prop_curr_main := RECORD
		STRING12 Record_Type:= ''; 
		STRING100 Property_address := ''; 
		TYPEOF(keys_search.zip) Property_Zip := '';
		STRING80 Owner_Name1 := ''; 
		STRING80 Owner_Name2 := ''; 
		STRING80 Seller_name1 := ''; 
		STRING80 Seller_name2 := ''; 
		TYPEOF(keys_assmt.sale_date) Sale_Date := '';
		STRING11 Total_Value:= '';
		TYPEOF(keys_deeds.sales_price) Sale_Amount := '';
		TYPEOF(keys_assmt.assessed_total_value) Assess_Value := '';
		TYPEOF(keys_assmt.market_total_value) Market_Value := '';
		TYPEOF(keys_assmt.mortgage_loan_amount) Mortgage_amount := '';
		STRING11 Total_Property_Value:= '';
		TYPEOF(keys_deeds.recording_date) recording_date := '';
		TYPEOF(keys_assmt.tax_year) Tax_Year := '';
		STRING76 Land_Usage := '';
		STRING70 Document_Type := '';	
		STRING8 sortby_date := '';
		
		BatchServices.layout_Property_Batch_out -[acctno, err_addr, err_search, error_code, matchcodes, 
																						  ln_fares_id, fid_type, fid_type_desc, vendor_source_flag, 
																							vendor_source_desc,
																							// The fields below cannot be returned because
																							// they are not modifiable per FCRA.
																							penalt, assess_prop_addr_match_code, 
																							assess_mail_addr_match_code,
																							assess_ownr_addr_match_code, 
																							deed_prop_addr_match_code,  
																							deed_buyr_addr_match_code, 
																							deed_sell_addr_match_code,
																							deed_mortgage_deed_type_desc, 
																							deed_mortgage_term_code_desc, 
																							deed_mortgage_term, deed_iris_apn, 
																							deed_mortgage_date,
																							deed_building_square_feet, 
																							deed_foreclosure_desc, 
																							deed_refi_flag_desc, 
																							deed_equity_flag_desc, 
																							assess_living_square_feet, 
																							assess_iris_apn,
																							assess_addl_legal, 
																							assess_calculated_land_value, 
																							assess_calculated_improvement_value,
																							assess_calculated_total_value,       
																							assess_adjusted_gross_square_feet,   
																							assess_pool_indicator,                       
																							assess_frame_desc, 
																							assess_electric_energy_desc,
																							assess_condition_desc
																							];
	END;
	
	SHARED prop_current_main := RECORD
		STRING1 Property_Owned_OOS := '';
		STRING1 Property_Owned := '';
	END;
	
	// The fields for the "Current" property records are separated into two separate 
	// layouts (curr_main & current_main) so that the BatchShare.MAC_ExpandLayout.Generate 
	// macro can be used to expand the fields and add the appropriate prefix to the field names.
	SHARED prop_curr_main_flat := RECORD
		BatchShare.MAC_ExpandLayout.Generate(prop_curr_main, 
																				 'curr_', 
																				 BenefitAssessment_Services.Constants.max_property_return_count);
																				 
		BatchShare.MAC_ExpandLayout.Generate(prop_current_main, 
																				 'current_',
																				 BenefitAssessment_Services.Constants.max_property_return_count);
	END;
	
	EXPORT prop_curr_flat := RECORD
		BatchShare.MAC_ExpandLayout.EchoIn(prop_curr_main, 'Curr_');
		BatchShare.MAC_ExpandLayout.EchoIn(prop_current_main, 'Current_');
	END;
	
	EXPORT prop_flat_rec := RECORD
		Batch_In.acctno;
		TYPEOF(keys_assmt.ln_fares_id) ln_fares_id := '';	
		RECORDOF(prop_curr_flat);
		STRING80 buyer_name1 := ''; 
		STRING80 buyer_name2 := ''; 
		STRING9 ossn1 :='';
		STRING9 ossn2 := '';
		STRING9 bssn1 :='';
		STRING9 bssn2 := '';
		STRING20 ofname1 := '';
		STRING20 ofname2 := '';
		STRING20 olname1 := '';
		STRING20 olname2 := '';			
	END;	
	
	SHARED prop_prior_main := RECORD
		STRING12 Record_Type:= ''; 
		STRING100 Property_address := ''; 
		TYPEOF(keys_search.zip) Property_Zip := '';
		STRING80 Owner_Name1 := ''; 
		STRING80 Owner_Name2 := ''; 
		STRING80 Seller_name1 := ''; 
		STRING80 Seller_name2 := ''; 
		TYPEOF(keys_assmt.sale_date) Sale_Date := '';
		STRING11 Total_Value:= '';
		TYPEOF(keys_deeds.sales_price) Sale_Amount := '';
		TYPEOF(keys_assmt.assessed_total_value) Assess_Value := '';
		TYPEOF(keys_assmt.market_total_value) Market_Value := '';
		TYPEOF(keys_assmt.mortgage_loan_amount) Mortgage_amount := '';
		STRING11 Total_Property_Value:= '';
		TYPEOF(keys_deeds.recording_date) recording_date := '';
		TYPEOF(keys_assmt.tax_year) Tax_Year := '';
		STRING76 Land_Usage := '';
		STRING70 Document_Type := '';	
		STRING1 Property_Owned_OOS := '';
		STRING8 sortby_date := '';  
		
		BatchServices.layout_Property_Batch_out -[acctno, err_addr, err_search, error_code, matchcodes, 
																						  ln_fares_id, fid_type, fid_type_desc, vendor_source_flag, 
																							vendor_source_desc,
																							// The fields below cannot be returned because
																							// they are not modifiable per FCRA.
																							penalt, assess_prop_addr_match_code, 
																							assess_mail_addr_match_code,
																							assess_ownr_addr_match_code, 
																							deed_prop_addr_match_code,  
																							deed_buyr_addr_match_code, 
																							deed_sell_addr_match_code,
																							deed_mortgage_deed_type_desc, 
																							deed_mortgage_term_code_desc, 
																							deed_mortgage_term, deed_iris_apn, 
																							deed_mortgage_date,
																							deed_building_square_feet, 
																							deed_foreclosure_desc, 
																							deed_refi_flag_desc, 
																							deed_equity_flag_desc, 
																							assess_living_square_feet, 
																							assess_iris_apn,
																							assess_addl_legal, 
																							assess_calculated_land_value, 
																							assess_calculated_improvement_value,
																							assess_calculated_total_value,       
																							assess_adjusted_gross_square_feet,   
																							assess_pool_indicator,                       
																							assess_frame_desc, 
																							assess_electric_energy_desc,
																							assess_condition_desc];
	END;
	
	SHARED prop_recent_main := RECORD
		STRING1 Property_Transfer := '';
	END;
	
	// The fields for the "Prior" property records are separated into two separate 
	// layouts (prior_main & recent_main) so that the BatchShare.MAC_ExpandLayout.Generate 
	// macro can be used to expand the fields and add the appropriate prefix to the field names.
	// (similar to the way the "Current" layout is formatted.) 
	SHARED prop_prior_main_flat := RECORD
		BatchShare.MAC_ExpandLayout.Generate(prop_prior_main, 
																				 'prior_', 
																				 BenefitAssessment_Services.Constants.max_property_return_count);
		
		BatchShare.MAC_ExpandLayout.Generate(prop_recent_main, 
																				 'recent_', 
																				 BenefitAssessment_Services.Constants.max_property_return_count);	
	END;
	
	EXPORT prop_prior_flat := RECORD
		BatchShare.MAC_ExpandLayout.EchoIn(prop_prior_main, 'Prior_');
		BatchShare.MAC_ExpandLayout.EchoIn(prop_recent_main, 'Recent_');
	END;
	
	EXPORT prop_flat_Prior_rec := RECORD
		Batch_In.acctno;
		TYPEOF(keys_assmt.ln_fares_id) ln_fares_id;	
		RECORDOF(prop_prior_flat);
		STRING80 buyer_name1 := ''; 
		STRING80 buyer_name2 := ''; 
		STRING9 ossn1 :='';
		STRING9 ossn2 := '';
		STRING9 bssn1 :='';
		STRING9 bssn2 := '';
		STRING20 ofname1 := '';
		STRING20 ofname2 := '';
		STRING20 olname1 := '';
		STRING20 olname2 := '';		
	END;	
		
	EXPORT rec_propOwnerOnInput := RECORD
		LN_PropertyV2_Services.layouts.search_fid;
		layout_dec_crim_sofr;		
		RECORDOF(prop_curr_flat);
	END;	

	EXPORT rec_propSellerOnInput := RECORD
		LN_PropertyV2_Services.layouts.search_fid;
		layout_dec_crim_sofr;		
		RECORDOF(prop_prior_flat);
	END;
	
	SHARED prop_main := RECORD
		prop_curr_flat;
		prop_prior_flat;
	END;
	
	EXPORT prop_with_acctno := RECORD
		Batch_In.acctno;
		prop_main;
	END;
	
	SHARED prop_flat := RECORD
		prop_curr_main_flat;
		prop_prior_main_flat;															 
		UNSIGNED1 curr_prop_cnt :=   ''; //max of 5
	END;
	
	EXPORT prop_curr_w_acctno := RECORD
		Batch_In.acctno;
		RECORDOF(prop_curr_flat);
	END;
	
	EXPORT prop_prior_w_acctno := RECORD
		Batch_In.acctno;
		RECORDOF(prop_prior_flat);	
	END;
			
	//************** Professional licenses - pl******************
	
	pl_full := RECORD
		recordof(Prof_LicenseV2.Key_Proflic_Did (true));
	END;
	
	EXPORT pl_main:= RECORD
		TYPEOF(pl_full.date_first_seen) date_first_seen;
		TYPEOF(pl_full.date_last_seen) date_last_seen;
		TYPEOF(pl_full.profession_or_board) profession_or_board;
		TYPEOF(pl_full.license_type) license_type;
		TYPEOF(pl_full.status) status;
		TYPEOF(pl_full.orig_license_number) orig_license_number;
		TYPEOF(pl_full.license_number) license_number;
		TYPEOF(pl_full.previous_license_number) previous_license_number;
		TYPEOF(pl_full.previous_license_type) previous_license_type;
		TYPEOF(pl_full.company_name) company_name;
		TYPEOF(pl_full.orig_name) orig_name;
		TYPEOF(pl_full.orig_former_name) orig_former_name;
		TYPEOF(pl_full.orig_addr_1) orig_addr_1;
		TYPEOF(pl_full.orig_addr_2) orig_addr_2;
		TYPEOF(pl_full.orig_addr_3) orig_addr_3;
		TYPEOF(pl_full.orig_addr_4) orig_addr_4;
		TYPEOF(pl_full.orig_city) orig_city;
		TYPEOF(pl_full.orig_st) orig_st;
		TYPEOF(pl_full.orig_zip) orig_zip;
		TYPEOF(pl_full.county_str) county_str;
		TYPEOF(pl_full.country_str) country_str;
		TYPEOF(pl_full.business_flag) business_flag;
		TYPEOF(pl_full.issue_date) issue_date;
		TYPEOF(pl_full.expiration_date) expiration_date;
		TYPEOF(pl_full.last_renewal_date) last_renewal_date;
		TYPEOF(pl_full.license_obtained_by) license_obtained_by;
		TYPEOF(pl_full.board_action_indicator) board_action_indicator;
		TYPEOF(pl_full.source_st) source_st;
		TYPEOF(pl_full.vendor) vendor;
	END;
	
	EXPORT prof_lic_with_acctno := RECORD
		Batch_In.acctno;
		pl_main;
	END;
	
	EXPORT prof_lic_flat := RECORD
		BatchShare.MAC_ExpandLayout.Generate(pl_main);
	END;
	
	//************** People At Work - paw ***************
	
	paw_full := RECORD
		recordof(paw.Key_DID_FCRA);
	END;
	
	EXPORT paw_main:= RECORD
		TYPEOF(paw_full.company_name) company_name;
		TYPEOF(paw_full.company_prim_range) company_prim_range;
		TYPEOF(paw_full.company_predir) company_predir;
		TYPEOF(paw_full.company_prim_name) company_prim_name;
		TYPEOF(paw_full.company_addr_suffix) company_addr_suffix;
		TYPEOF(paw_full.company_postdir) company_postdir;
		TYPEOF(paw_full.company_unit_desig) company_unit_desig;
		TYPEOF(paw_full.company_sec_range) company_sec_range;
		TYPEOF(paw_full.company_city) company_city;
		TYPEOF(paw_full.company_state) company_state;
		TYPEOF(paw_full.company_zip) company_zip;
		TYPEOF(paw_full.company_zip4) company_zip4;
		TYPEOF(paw_full.company_title) company_title;
		TYPEOF(paw_full.company_department) company_department;
		TYPEOF(paw_full.company_phone) company_phone;
		TYPEOF(paw_full.company_fein) company_fein;
		TYPEOF(paw_full.title) title;
		TYPEOF(paw_full.fname) fname;
		TYPEOF(paw_full.mname) mname;
		TYPEOF(paw_full.lname) lname;
		TYPEOF(paw_full.name_suffix) name_suffix;
		TYPEOF(paw_full.prim_range) prim_range;
		TYPEOF(paw_full.predir) predir;
		TYPEOF(paw_full.prim_name) prim_name;
		TYPEOF(paw_full.addr_suffix) addr_suffix;
		TYPEOF(paw_full.postdir) postdir;
		TYPEOF(paw_full.unit_desig) unit_desig;
		TYPEOF(paw_full.sec_range) sec_range;
		TYPEOF(paw_full.city) city;
		TYPEOF(paw_full.state) state;
		TYPEOF(paw_full.zip) zip;
		TYPEOF(paw_full.zip4) zip4;
		TYPEOF(paw_full.county) county;
		TYPEOF(paw_full.msa) msa;
		TYPEOF(paw_full.geo_lat) geo_lat;
		TYPEOF(paw_full.geo_long) geo_long;
		TYPEOF(paw_full.dt_first_seen) dt_first_seen;
		TYPEOF(paw_full.dt_last_seen) dt_last_seen;
		TYPEOF(paw_full.record_type) record_type;
	END;
	
	EXPORT paw_with_acctno := RECORD
		Batch_In.acctno;
		paw_main;
	END;
	
	EXPORT paw_flat := RECORD
		BatchShare.MAC_ExpandLayout.Generate(paw_main);
	END;
	
	//************** watercraft owners - wc **************
	
	wc_full := RECORD
		recordof(watercraft.key_watercraft_sid(true));
	END;
	
	EXPORT wc_main:= RECORD
		TYPEOF(wc_full.date_first_seen) date_first_seen;
		TYPEOF(wc_full.date_last_seen) date_last_seen;
		TYPEOF(wc_full.state_origin) state_origin;
		TYPEOF(wc_full.orig_name) orig_name;
		TYPEOF(wc_full.orig_name_type_code) orig_name_type_code;
		TYPEOF(wc_full.orig_name_type_description) orig_name_type_description;
		TYPEOF(wc_full.orig_name_first) orig_name_first;
		TYPEOF(wc_full.orig_name_middle) orig_name_middle;
		TYPEOF(wc_full.orig_name_last) orig_name_last;
		TYPEOF(wc_full.orig_name_suffix) orig_name_suffix;
		TYPEOF(wc_full.orig_address_1) orig_address_1;
		TYPEOF(wc_full.orig_address_2) orig_address_2;
		TYPEOF(wc_full.orig_city) orig_city;
		TYPEOF(wc_full.orig_state) orig_state;
		TYPEOF(wc_full.orig_zip) orig_zip;
		TYPEOF(wc_full.orig_fips) orig_fips;
		TYPEOF(wc_full.orig_province) orig_province;
		TYPEOF(wc_full.orig_country) orig_country;
		TYPEOF(wc_full.title) title;
		TYPEOF(wc_full.fname) fname;
		TYPEOF(wc_full.mname) mname;
		TYPEOF(wc_full.lname) lname;
		TYPEOF(wc_full.name_suffix) name_suffix;
		TYPEOF(wc_full.company_name) company_name;
		TYPEOF(wc_full.prim_range) prim_range;
		TYPEOF(wc_full.predir) predir;
		TYPEOF(wc_full.prim_name) prim_name;
		TYPEOF(wc_full.suffix) suffix;
		TYPEOF(wc_full.postdir) postdir;
		TYPEOF(wc_full.unit_desig) unit_desig;
		TYPEOF(wc_full.sec_range) sec_range;
		TYPEOF(wc_full.p_city_name) p_city_name;
		TYPEOF(wc_full.v_city_name) v_city_name;
		TYPEOF(wc_full.st) st;
		TYPEOF(wc_full.zip5) zip5;
		TYPEOF(wc_full.zip4) zip4;
		TYPEOF(wc_full.county) county;
	END;
	
	EXPORT wc_with_acctno := RECORD
		Batch_In.acctno;
		wc_main;
	END;
	
	EXPORT wc_flat := RECORD
		BatchShare.MAC_ExpandLayout.Generate(wc_main);
	END;
	
	//************** aircraft owners - ac ****************
	
	ac_full := RECORD
		recordof(faa.key_aircraft_id(true));
	END;
	
	EXPORT ac_main:= RECORD
		TYPEOF(ac_full.date_first_seen) date_first_seen;
		TYPEOF(ac_full.date_last_seen) date_last_seen;
		TYPEOF(ac_full.current_flag) current_flag;
		TYPEOF(ac_full.n_number) n_number;
		TYPEOF(ac_full.serial_number) serial_number;
		TYPEOF(ac_full.mfr_mdl_code) mfr_mdl_code;
		TYPEOF(ac_full.eng_mfr_mdl) eng_mfr_mdl;
		TYPEOF(ac_full.year_mfr) year_mfr;
		TYPEOF(ac_full.type_registrant) type_registrant;
		TYPEOF(ac_full.name) name;
		TYPEOF(ac_full.street) street;
		TYPEOF(ac_full.street2) street2;
		TYPEOF(ac_full.city) city;
		TYPEOF(ac_full.state) state;
		TYPEOF(ac_full.zip_code) zip_code;
		TYPEOF(ac_full.region) region;
		TYPEOF(ac_full.orig_county) orig_county;
		TYPEOF(ac_full.country) country;
		TYPEOF(ac_full.last_action_date) last_action_date;
		TYPEOF(ac_full.cert_issue_date) cert_issue_date;
		TYPEOF(ac_full.certification) certification;
		TYPEOF(ac_full.type_aircraft) type_aircraft;
		TYPEOF(ac_full.type_engine) type_engine;
		TYPEOF(ac_full.status_code) status_code;
		TYPEOF(ac_full.mode_s_code) mode_s_code;
		TYPEOF(ac_full.fract_owner) fract_owner;
		TYPEOF(ac_full.aircraft_mfr_name) aircraft_mfr_name;
		TYPEOF(ac_full.model_name) model_name;
	END;
	
	EXPORT ac_with_acctno := RECORD
		Batch_In.acctno;
		ac_main;
	END;
	
	EXPORT ac_flat := RECORD
		BatchShare.MAC_ExpandLayout.Generate(ac_main);
	END;
	
	//************** bankruptcy - b **************
	
	b_full := RECORD
		recordof(BankruptcyV3.key_bankruptcyV3_main_full(true));
	END;
	
	EXPORT b_main:= RECORD
		TYPEOF(b_full.court_code) court_code;
		TYPEOF(b_full.court_name) court_name;
		TYPEOF(b_full.court_location) court_location;
		TYPEOF(b_full.case_number) case_number;
		TYPEOF(b_full.orig_case_number) orig_case_number;
		TYPEOF(b_full.date_filed) date_filed;
		TYPEOF(b_full.filing_status) filing_status;
		TYPEOF(b_full.orig_chapter) orig_chapter;
		TYPEOF(b_full.orig_filing_date) orig_filing_date;
		TYPEOF(b_full.assets_no_asset_indicator) assets_no_asset_indicator;
		TYPEOF(b_full.filer_type) filer_type;
		TYPEOF(b_full.judge_name) judge_name;
		TYPEOF(b_full.judges_identification) judges_identification;
		TYPEOF(b_full.filing_jurisdiction) filing_jurisdiction;
		TYPEOF(b_full.assets) assets;
		TYPEOF(b_full.liabilities) liabilities;
		TYPEOF(b_full.casetype) casetype;
		TYPEOF(b_full.assoccode) assoccode;
		TYPEOF(b_full.splitcase) splitcase;
		TYPEOF(b_full.filedinerror) filedinerror;
		TYPEOF(b_full.reopen_date) reopen_date;
		TYPEOF(b_full.case_closing_date) case_closing_date;
		TYPEOF(b_full.datereclosed) datereclosed;
		TYPEOF(b_full.caseid) caseid;
	END;
	
	EXPORT b_with_acctno := RECORD
		Batch_In.acctno;
		unsigned6 debtor_did;
		b_main;
	END;
	
	EXPORT b_flat := RECORD
		BatchShare.MAC_ExpandLayout.Generate(b_main);
	END;
	
	//************** marriage/divorce - md *************
	
	md_full := RECORD
		marriage_divorce_v2_Services.layouts.batch_out;
	END;
	
	EXPORT md_main:= RECORD
		TYPEOF(md_full.filing_type) filing_type;
		TYPEOF(md_full.filing_number) filing_number;
		TYPEOF(md_full.process_date) process_date;
		TYPEOF(md_full.state_origin) state_origin;
		string3 which_party;
		TYPEOF(md_full.party1_type) party_type;
		TYPEOF(md_full.party1_name_fmt) party_name_fmt;
		TYPEOF(md_full.party1_orig_name) party_orig_name;
		TYPEOF(md_full.party1_orig_name_alias) party_orig_name_alias;
		TYPEOF(md_full.party1_dob) party_dob;
		TYPEOF(md_full.party1_residence_address1) party_residence_address1;
		TYPEOF(md_full.party1_residence_city) party_residence_city;
		TYPEOF(md_full.party1_residence_state) party_residence_state;
		TYPEOF(md_full.party1_orig_zip) party_orig_zip;
		TYPEOF(md_full.party1_residence_county) party_residence_county;
		TYPEOF(md_full.party1_times_married) party_times_married;
		TYPEOF(md_full.marriage_dt) marriage_dt;
		TYPEOF(md_full.marriage_months_duration) marriage_months_duration;
		TYPEOF(md_full.divorce_dt) divorce_dt;
		TYPEOF(md_full.divorce_grounds) divorce_grounds;
		TYPEOF(md_full.number_children) number_children;
	END;

	EXPORT md_with_acctno := RECORD
		Batch_In.acctno;
		unsigned6 party_did;
		md_main;
	END;
	
	EXPORT md_flat := RECORD
		BatchShare.MAC_ExpandLayout.Generate(md_main);
	END;
	
	//************** liens - l *************
	
	l_full := RECORD
		LiensV2.layout_liens_party;
	END;
	
	EXPORT l_main:= RECORD
		string orig_filing_date;
		TYPEOF(l_full.orig_name) orig_name;
		TYPEOF(l_full.orig_lname) orig_lname;
		TYPEOF(l_full.orig_fname) orig_fname;
		TYPEOF(l_full.orig_mname) orig_mname;
		TYPEOF(l_full.orig_suffix) orig_suffix;
		TYPEOF(l_full.fname) fname;
		TYPEOF(l_full.mname) mname;
		TYPEOF(l_full.lname) lname;
		TYPEOF(l_full.name_suffix) name_suffix;
		TYPEOF(l_full.cname) cname;
		TYPEOF(l_full.orig_address1) orig_address1;
		TYPEOF(l_full.orig_address2) orig_address2;
		TYPEOF(l_full.orig_city) orig_city;
		TYPEOF(l_full.orig_state) orig_state;
		TYPEOF(l_full.orig_zip5) orig_zip5;
		TYPEOF(l_full.orig_zip4) orig_zip4;
		TYPEOF(l_full.orig_county) orig_county;
		TYPEOF(l_full.orig_country) orig_country;
		TYPEOF(l_full.prim_range) prim_range;
		TYPEOF(l_full.predir) predir;
		TYPEOF(l_full.prim_name) prim_name;
		TYPEOF(l_full.addr_suffix) addr_suffix;
		TYPEOF(l_full.postdir) postdir;
		TYPEOF(l_full.unit_desig) unit_desig;
		TYPEOF(l_full.sec_range) sec_range;
		TYPEOF(l_full.p_city_name) p_city_name;
		TYPEOF(l_full.v_city_name) v_city_name;
		TYPEOF(l_full.st) st;
		TYPEOF(l_full.zip) zip;
		TYPEOF(l_full.zip4) zip4;
		TYPEOF(l_full.rec_type) rec_type;
		TYPEOF(l_full.county) county;
		TYPEOF(l_full.name_type) name_type;
		TYPEOF(l_full.date_vendor_first_reported) date_vendor_first_reported;
		TYPEOF(l_full.date_vendor_last_reported ) date_vendor_last_reported;
	END;

	EXPORT l_with_acctno := RECORD
		Batch_In.acctno;
		unsigned6 debtor_did;
		l_main;
	END;
	
	EXPORT l_flat := RECORD
		BatchShare.MAC_ExpandLayout.Generate(l_main);
	END;
	
	//***************************

	EXPORT tmp_dec_crim_sofr_prop := RECORD, MAXLENGTH(20000)
		layout_dec_crim_sofr;
		prop_with_acctno;
	END;
		
	SHARED offender_key 	:= doxie_files.Key_Offenders_OffenderKey();
		
	EXPORT layout_crimderog := RECORD, MAXLENGTH(20000)
			string1 CRIM_Flag := ''; 
			string10 CRIM_doc_num:= '';
			string30 CRIM_lname:= '';
			string30 CRIM_fname:= '';
			string30 CRIM_mname:= '';
			string9  CRIM_ssn:= '';
			string8  CRIM_dob:= '';
			qstring10 CRIM_prim_range:= '';
			string2   CRIM_predir:= '';
			qstring28 CRIM_prim_name:= '';
			qstring4  CRIM_addr_suffix:= '';
			string2   CRIM_postdir:= '';
			qstring10 CRIM_unit_desig:= '';
			qstring8  CRIM_sec_range:= '';
			qstring25 CRIM_p_city_name:= '';
			qstring25 CRIM_v_city_name:= '';
			string2   CRIM_st:= '';
			qstring5  CRIM_zip5:= '';
			qstring4  CRIM_zip4:= '';
			string1  data_type:= '';
			string2 state_origin:= '';
			string8	process_date:= ''; 
			string35	case_num_1:= '';
			string40	court_desc_1:= '';		
			string8	off_date_1:= '';
			string20	off_code_1:= '';
			string31	chg_1:= '';
			string3	num_of_counts_1:= '';
			string75	off_desc_1_1:= '';
			string50	off_desc_2_1:= '';
			string1	off_typ_1:= '';
			string2	off_lev_1:= '';
			string30	cty_conv_1:= '';
			string8	stc_dt_1:= '';
	END;	
		
	EXPORT layout_familycomp	:= RECORD
		string20 	current_addr_fname;
		string20	current_addr_mname;
		string20	current_addr_lname;
		string5 	current_addr_suffix;
		string120	current_addr;
		string30	current_addr_city;
		string2		current_addr_st;
		string5		current_addr_zip;
		string8		current_addr_first_seen;
		string8		current_addr_last_seen;
		string3 months_at_addr; //???
		string1		match_input_addr;
		string3		current_addr_oos;
		STRING2 num_adults_input_addr;
		string20	adult_fname1;
		string20	adult_lname1;
		string20	adult_fname2;
		string20	adult_lname2;
		string20	adult_fname3;
		string20	adult_lname3;
		string20	adult_fname4;
		string20	adult_lname4;
		string20	adult_fname5;
		string20	adult_lname5;
		string20	adult_fname6;
		string20	adult_lname6;
		string20	adult_fname7;
		string20	adult_lname7;
		string20	adult_fname8;
		string20	adult_lname8;
		string20	adult_fname9;
		string20	adult_lname9;
		string20	adult_fname10;
		string20	adult_lname10;
	END;
	
	EXPORT additional_indicators_rec := RECORD
		prof_lic_flat;
		paw_flat;
		wc_flat;
		ac_flat;
		b_flat;
		md_flat;
		// The liens & judgments section is being removed from the response for project JULI.
		// Just commenting it out in case we need to add it back later.
		// l_flat;
	END;
		
	EXPORT temp_cumulative_rec := RECORD
		layout_dec_crim_sofr;
		prop_flat;
		additional_indicators_rec;
		layout_crimderog;
	END;
	
	EXPORT layout_batch_out_plus := RECORD
		Batch_In_plus;
		layout_dec;
		RECORDOF(layout_incr) AND NOT[acctno];	
		RECORDOF(layout_sofr) AND NOT[acctno];
		prop_flat;
		additional_indicators_rec;
		layout_crimderog;
		layout_familycomp;
	END;

	EXPORT Addr_info := RECORD 
		BatchShare.Layouts.ShareAcct;
		recordof(doxie.Key_FCRA_Header_Address);
		integer dids_per_addr := 1;
	END;	

	EXPORT layout_batch_out := RECORD, MAXLENGTH(20000)
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		layout_dec;
		RECORDOF(layout_incr) AND NOT[acctno];	
		RECORDOF(layout_sofr) AND NOT[acctno];
		RECORDOF(prop_flat);
		additional_indicators_rec;
		RECORDOF(layout_crimderog) AND NOT[process_date, CRIM_Flag];
		layout_familycomp;
		BatchShare.Layouts.ShareErrors;
	END;
	
  EXPORT	layout_batch_out_seq := record
		integer seq;
		layout_batch_out;
	END;	
	
// used for property record normalization, reading flat batch output into individual property records.			
  EXPORT norm_prop_rec := record
			integer seq;
			iesp.benefitassessment_fcra.t_FcraBenefitAssessPropertyRecord;
	END;	
	
end;