
IMPORT BatchDatasets, BatchShare, doxie_crs, DriversV2_Services, VehicleV2_Services, 
       VotersV2_Services, WatercraftV2_Services;

EXPORT Layouts := MODULE

// ================[ FOR TEST HARNESS ]================

	EXPORT batch_in_raw := RECORD
		STRING acctno := '';
		STRING ssn    := '';
		STRING dob    := '';
		STRING name   := '';
		STRING addr   := '';
		STRING city   := '';
		STRING state  := '';
		STRING zip    := '';
	END;

// ================[ INPUT ]================

	EXPORT batch_in := RECORD(BatchDatasets.Layouts.batch_in)
		STRING50 record_err_msg := '';
		BOOLEAN is_rejected_rec := FALSE;
		string20	orig_acctno 	:= ''; // [internal]
		Batchshare.Layouts.ShareErrors;	
	END;
	
// ================[ OUTPUT ]================

	EXPORT rec_instantid := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING50  identity_verification_nas; // 4.1.7... / Step 1 (Instant ID)
		STRING4  hri_1_indicator;
		STRING100 hri_1_description;
		STRING4  hri_2_indicator;
		STRING100 hri_2_description;
		STRING4  hri_3_indicator;
		STRING100 hri_3_description;
		STRING4  hri_4_indicator;
		STRING100 hri_4_description;
		STRING4  hri_5_indicator;
		STRING100 hri_5_description;
		STRING4  hri_6_indicator;
		STRING100 hri_6_description;
		STRING8  verified_dob;	
	END;
	
	EXPORT rec_adl_best := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING20 LexID;
		STRING9 best_ssn;                  // 4.1.8 / Step 2 (ADL Best)
	END;
	
	EXPORT rec_deceased := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING8  deceased_date_of_death_SN; // 4.1.10... / Step 4 (Deceased)
		STRING8  deceased_DOB_SN;
		STRING30 deceased_match_code_SN;
		STRING15 deceased_first_name_SN;
		STRING20 deceased_last_name_SN;	
	END;

	EXPORT rec_dept_of_corr := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING2  doc_state_origin;          // 4.1.9 / Step 3 (Department of Correction)
		STRING20 doc_sdid;
		STRING9  doc_ssn_1;
		STRING30 doc_lname;
		STRING30 doc_fname;
		STRING30 doc_mname;
		STRING10 doc_doc_num;
		STRING8  doc_dob;
		STRING1  curr_incar_flag;
		STRING1  curr_probation_flag;
		STRING1  curr_parole_flag;
		STRING1  sch_rel_dt;	
	END;
	
	EXPORT rec_criminal := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING9  ssn;                       // 4.1.11 / Step 5 (Criminal Felony)
		STRING30 lname;
		STRING30 fname;
		STRING30 mname;
		STRING10 doc_num;
		STRING8  dob;
		STRING45 datasource;
		STRING28 prim_range;
		STRING2  predir;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  postdir;
		STRING10 unit_desig;
		STRING8  sec_range;
		STRING25 p_city_name;
		STRING25 v_city_name;
		STRING5  st;
		STRING5  zip5;
		STRING4  zip4;
		STRING8  process_date;
		STRING35 case_num_1;
		STRING31 chg_1;
		STRING75 off_desc_1_1;
		STRING50 off_desc_2_1;
		STRING2  add_off_cd_1;
		STRING30 add_off_desc_1;
		STRING1  off_typ_1;
		STRING2  off_lev_1;
		STRING35 case_num_2;
		STRING31 chg_2;
		STRING75 off_desc_1_2;
		STRING50 off_desc_2_2;
		STRING2  add_off_cd_2;
		STRING30 add_off_desc_2;
		STRING1  off_typ_2;
		STRING2  off_lev_2;
		STRING35 case_num_3;
		STRING31 chg_3;
		STRING75 off_desc_1_3;
		STRING50 off_desc_2_3;
		STRING2  add_off_cd_3;
		STRING30 add_off_desc_3;
		STRING1  off_typ_3;
		STRING2  off_lev_3;
		STRING35 case_num_4;
		STRING31 chg_4;
		STRING75 off_desc_1_4;
		STRING50 off_desc_2_4;
		STRING2  add_off_cd_4;
		STRING30 add_off_desc_4;
		STRING1  off_typ_4;
		STRING2  off_lev_4;
		STRING35 case_num_5;
		STRING31 chg_5;
		STRING75 off_desc_1_5;
		STRING50 off_desc_2_5;
		STRING2  add_off_cd_5;
		STRING30 add_off_desc_5;
		STRING1  off_typ_5;
		STRING2  off_lev_5;
		STRING35 case_num_6;
		STRING31 chg_6;
		STRING75 off_desc_1_6;
		STRING50 off_desc_2_6;
		STRING2  add_off_cd_6;
		STRING30 add_off_desc_6;
		STRING1  off_typ_6;
		STRING2  off_lev_6;	
	END;
	
	EXPORT rec_DOC_and_Criminal := RECORD
		rec_dept_of_corr;
		rec_criminal AND NOT acctno;
	END;
	
	EXPORT rec_best_addr := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING1  address_1_outside_Home_state_flag; // 4.1.13... / Step 7 (Best Address with Dedup)
		STRING20 name_first_1;
		STRING20 name_last_1;
		STRING70 best_address_1;
		STRING25 best_city_1;
		STRING2  best_state_1;
		STRING10 best_zip_1;
		STRING6  date_first_seen_1;
		STRING6  date_last_seen_1;
		STRING1  address_confidence_1;
		STRING1  ncoa_addr;          // not populated in this service
		STRING1  prop_owner_addr_1;  
		STRING1  address_2_outside_home_state_flag;
		STRING20 name_first_2;
		STRING20 name_last_2;
		STRING70 best_address_2;
		STRING25 best_city_2;
		STRING2  best_state_2;
		STRING10 best_zip_2;
		STRING6  date_first_seen_2;
		STRING6  date_last_seen_2;
		STRING1  address_confidence_2;
		STRING1  prop_owner_addr_2;	
	END;

	EXPORT rec_driver_lic := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING24 dl_number;        // 4.1.14 / Step 8 (Driver License)
		STRING2  dl_state;
		STRING8  dl_issue_date;
	END;
	
	EXPORT rec_voter := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING70 voter_address;    // 4.1.15 / Step 9 (Voter Registration)
		STRING25 voter_city;
		STRING2  voter_state;
		STRING10 voter_zip;
		STRING8  voter_reg_date;	
	END;
	
	EXPORT rec_property := RECORD    // 4.1.16... / Step 10 (Property)
		BatchShare.Layouts.ShareAcct;
		STRING12 property_value := '0'; // Total Property Value of ALL property(ies) the input subject currently owns 
		STRING5  property_owned := '0'; // Total number of properties the Input subject currently owns 
		// -----[ Property 1 ]-----
		STRING1  prop_owner_1;         // 0 (zero) - Individual Owns Property 1
		STRING1  prop_sold_1;          // S - Individual Sold Property 1
		STRING70 property_address_1;   // Property Address 1 found
		STRING25 property_city_1;      // Property City found Property Address found
		STRING2  property_state_1;     // Property State found
		STRING10 property_zip_1;       // Property Zip found 
		STRING12 total_value_1;        // Total Value of Property
		STRING8  sale_date_1;          // Sale Date
		STRING12 sale_price_1;         // Sale Price
		STRING90 name_seller_1;        // Name of Seller
		STRING12 mortgage_amount_1;    // Mortgage amount
		STRING12 assess_value_1;       // Assessed value
		STRING12 total_market_value_1; // Total market value
		STRING8  recording_date_1;     // Recording date
		// -----[ Property 2 ]-----
		STRING1  prop_owner_2;
		STRING1  prop_sold_2;
		STRING70 property_address_2;
		STRING25 property_city_2;
		STRING2  property_state_2;
		STRING10 property_zip_2;
		STRING12 total_value_2;
		STRING8  sale_date_2;
		STRING12 sale_price_2;
		STRING90 name_seller_2;
		STRING12 mortgage_amount_2;
		STRING12 assess_value_2;
		STRING12 total_market_value_2;
		STRING8  recording_date_2;
		// -----[ Property 3 ]-----
		STRING1  prop_owner_3;
		STRING1  prop_sold_3;
		STRING70 property_address_3;
		STRING25 property_city_3;
		STRING2  property_state_3;
		STRING10 property_zip_3;
		STRING12 total_value_3;
		STRING8  sale_date_3;
		STRING12 sale_price_3;
		STRING90 name_seller_3;
		STRING12 mortgage_amount_3;
		STRING12 assess_value_3;
		STRING12 total_market_value_3;
		STRING8  recording_date_3;
	END;

	EXPORT rec_vehicle := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING20 reg_1_firstname;    // 4.1.17 ( and 4.1.17.1?) / Step 11 (RT-MVR2)
		STRING20 reg_1_lastname;
		STRING36 mvr_make_1;
		STRING36 mvr_model_1;
		STRING4  mvr_year_1;
		STRING8  mvr_reg_date_1;
		STRING70 lienholder_1;
		STRING20 reg_2_firstname;
		STRING20 reg_2_lastname;
		STRING36 mvr_make_2;
		STRING36 mvr_model_2;
		STRING4  mvr_year_2;
		STRING8  mvr_reg_date_2;
		STRING70 lienholder_2;
		STRING20 reg_3_firstname;
		STRING20 reg_3_lastname;
		STRING36 mvr_make_3;
		STRING36 mvr_model_3;
		STRING4  mvr_year_3;
		STRING8  mvr_reg_date_3;
		STRING70 lienholder_3;		
	END;
	
	EXPORT batch_out := RECORD
		BatchShare.Layouts.ShareAcct;
		rec_adl_best     AND NOT acctno; // 4.1.8     / Step 2 (ADL Best)
		rec_instantid    AND NOT acctno; // 4.1.7...  / Step 1 (Instant ID)
		rec_dept_of_corr AND NOT acctno; // 4.1.9     / Step 3 (Department of Correction)
		rec_deceased     AND NOT acctno; // 4.1.10... / Step 4 (Deceased)
		rec_criminal     AND NOT acctno; // 4.1.11    / Step 5 (Criminal Felony)
		rec_best_addr    AND NOT acctno; // 4.1.13... / Step 7 (Best Address with Dedup)
		rec_driver_lic   AND NOT acctno; // 4.1.14    / Step 8 (Driver License)
		rec_voter        AND NOT acctno; // 4.1.15    / Step 9 (Voter Registration)
		rec_property     AND NOT acctno; // 4.1.16... / Step 10 (Property)
		rec_vehicle      AND NOT acctno; // 4.1.17 ( and 4.1.17.1?) / Step 11 (RT-MVR2)

		// Flags:
		STRING1  deceased_Flag;      // 4.1.10... / Step 4 (Deceased); if deceased then 'X'
		STRING1  incarceration_Flag; // 4.1.9     / Step 3 (Dept. of Correction); if incarcerated then 'I'		
		STRING2  sex_offender;       // 4.1.12    / Step 6 (Sex Offender); if sex offender then 'SO'
		STRING1  property_flag;      // 4.1.16.7  / Step 10 (Property); if property owned or sold then 'Y'
		STRING1  mvr_flag;           // 4.1.17.2  / Step 11 (RT-MVR2); if >= 1 MVR record then 'C'
		STRING1  aircraft_flag;      // 4.1.19    / Step 13 (Aircraft); if active/current then 'P'
		STRING1  watercraft_flag;    // 4.1.18    / Step 12 (Watercraft); if watercraft owned then 'W'	
		
		// For errors:
		Batchshare.Layouts.ShareErrors;
	END;


	// =========================== INTERMEDIATE LAYOUTS ===========================
	
	EXPORT layout_RT_mvr_raw := RECORD
		VehicleV2_Services.Layouts_RTBatch_V2.rec_V2 AND NOT acctno;
		VehicleV2_Services.Layouts_RTBatch_V2.rec_out;
	END;
	
END;
