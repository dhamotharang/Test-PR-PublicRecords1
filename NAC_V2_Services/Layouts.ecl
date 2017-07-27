IMPORT NAC_V2,STD,iesp,BatchShare;
EXPORT Layouts := MODULE

	EXPORT nac_batch_in := RECORD
		BatchShare.Layouts.ShareAcct; //STRING20 acctno
		STRING30 name_last;
		STRING25 name_first;
		STRING25 name_middle;
		STRING5  name_suffix;
		STRING70 address1_addr1;
		STRING70 address1_addr2;
		STRING30 address1_city;
		STRING2  address1_state;
		STRING9  address1_zip;
		STRING70 address2_addr1;
		STRING70 address2_addr2;
		STRING30 address2_city;
		STRING2  address2_state;
		STRING9  address2_zip;
		BatchShare.Layouts.SharePII; // STRING9  ssn;  STRING8  dob;
		STRING1  program_code;  //(S,D,T,M,P,C,I,N,H,U,W,V)
		STRING1  eligibility_range_type;
		STRING8  eligibility_start;
		STRING8  eligibility_END;
		STRING20 case_identifier;
		STRING20 client_identifier;
		// Although we can't actually set the default at the roxie layer,
		//the following 2 fields are set to TRUE at the batch input layer
		BOOLEAN  IncludeEligibilityHistory := TRUE;
		BOOLEAN  IncludeInterstateAllPrograms := TRUE;
	END;

	EXPORT batch_in_temp := RECORD(nac_batch_in)
		STRING20	orig_acctno 	:= ''; // [internal]
		Batchshare.Layouts.ShareErrors;
	END;

	// Used by both batch and search service
	EXPORT process_layout := RECORD
		UNSIGNED acctno; // [internal] for ordered processing
		STRING20 orig_acctno := '';
		STRING   name_last;
		STRING   name_first;
		STRING   name_middle;
		STRING   name_suffix;
		STRING   name_first_pref;
		STRING   name_first_pref_new;
		STRING   orig_name_last;
		STRING   orig_name_first;
		STRING   addr1_prim_range;
		STRING   addr1_predir;
		STRING   addr1_prim_name;
		STRING   addr1_suffix;
		STRING   addr1_postdir;
		STRING   addr1_sec_range;
		STRING   addr1_city;
		STRING   addr1_state;
		STRING   addr1_zip;
		STRING   addr2_prim_range;
		STRING   addr2_predir;
		STRING   addr2_prim_name;
		STRING   addr2_suffix;
		STRING   addr2_postdir;
		STRING   addr2_sec_range;
		STRING   addr2_city;
		STRING   addr2_state;
		STRING   addr2_zip;
		BOOLEAN  hasCityStateInput;
		BOOLEAN  hasZipInput;
		// We purposely do NOT make the SSN a string9 in this layout
		//since its not defined as such in the NAC1 iesp.nac_search
    STRING  SSN;
		STRING  DOB;
		STRING1 in_program_code; //NAC1-(S,D), NAC2-(S,D,T,M,P,C,I,N,H,U,W,V)
		STRING1 in_eligibility_period_type:=''; //(M,D)
		STD.Date.Date_t in_eligibility_start:=0;
		STD.Date.Date_t in_eligibility_end:=0;
		STRING20 case_identifier;
		STRING20 client_identifier;
		BOOLEAN  IncludeEligibilityHistory:=false;
		BOOLEAN  IncludeInterstateAllPrograms:=false;
		UNSIGNED2 error_code;
		// Nac1 backwards compatibility
		STRING benefit_month:='';
		STRING benefit_month_start:='';
		STRING benefit_month_end:='';
		STRING benefit_state:='';
		STRING eligibility_status:='';
	END;

	EXPORT search_layout := RECORD
		UNSIGNED acctno; // [internal] for ordered processing
		BOOLEAN isDeepDive;
		UNSIGNED6 did;
		process_layout.case_identifier;
		process_layout.client_identifier;
		STRING2 state;
	END;

	EXPORT nac_raw_rec := RECORD
		UNSIGNED acctno; // [internal] for ordered processing
		STRING20 orig_acctno := '';
		RECORDOF(NAC_V2.key_SC);
		search_layout.isDeepDive;
		STRING6   matchcode := '';
		STRING    match_history_period:='';
		UNSIGNED2 lexid_score := 0;
		UNSIGNED2 penalt := 0;
		UNSIGNED2 err_search := 0;
		STRING    err_desc := '';
		BOOLEAN   isHit := false;
		BOOLEAN   isFullSSNMatch := false;
		UNSIGNED  rank_order := 100;
		UNSIGNED4 sequence_number := 0;
		STRING3   client_exception_reason_code:='';
		STRING50  client_exception_comment:='';
		STRING1   in_ProgramCode:='';
		STRING20  in_ClientIdentifier:='';
		// Nac1
		STRING6   nac1_in_month:='';
		STRING6   nac1_in_start_month:='';
		STRING6   nac1_in_end_month:='';
		BOOLEAN   isBenefitTypeMatch:=false;
		BOOLEAN   isEligibleStatusMatch:=false;
	END;

	//search match denormalize layout1
	EXPORT histTempRec:=RECORD(iesp.nac2_search.t_NAC2MatchInnerHistory)
		STRING20 clientidentifier;
		STRING2  programstate;
		STRING1  programcode;
	END;
	//search match denormalize layout2
	EXPORT denormRec := RECORD(nac_raw_rec)
		DATASET(histTempRec) MatchInnerHistories := DATASET([],histTempRec);
	END;

	EXPORT nac_batch_out := RECORD
		BatchShare.Layouts.ShareAcct; //STRING20 acctno
		STRING4   nac_groupID;
		STRING30  case_last_name;
		STRING25  case_first_name;
		STRING25  case_middle_name;
		STRING5   case_suffix_name;
		STRING20  case_identifier;
		STRING2   case_program_state;
		STRING1   case_program_code;
		STRING10  case_phone_1;
		STRING10  case_phone_2;
		STRING256 case_email;
		STRING70  case_physical_address_street_1;
		STRING70  case_physical_address_street_2;
		STRING30  case_physical_address_city;
		STRING2   case_physical_address_state;
		STRING9   case_physical_address_zip;
		STRING1   case_physical_address_category;
		STRING70  case_mailing_address_street_1;
		STRING70  case_mailing_address_street_2;
		STRING30  case_mailing_address_city;
		STRING2   case_mailing_address_state;
		STRING9   case_mailing_address_zip;
		STRING1   case_mailing_address_category;
		STRING3   case_county_parish_code;
		STRING25  case_county_parish_name;
		STRING10  case_monthly_allotment;
		STRING3   case_region_code;
		STRING30  client_last_name;
		STRING25  client_first_name;
		STRING25  client_middle_name;
		STRING5   client_suffix_name;
		STRING20  client_identifier;
		STRING1   client_gender;
		STRING1   client_race;
		STRING1   client_ethnicity;
		STRING10  client_phone;
		STRING256 client_email;
		STRING9   client_ssn;
		STRING1   client_ssn_type_indicator;
		STRING8   client_dob;
		STRING1   client_dob_type_indicator;
		STRING10  client_monthly_allotment;
		STRING1   client_hoh_indicator;
		STRING1   client_abawd_indicator;
		STRING1   client_relationship_indicator;
		STRING20  client_certificate_id_type;
		STRING5   client_historical_benefit_count;
		STRING3   client_exception_reason_code:='';
		STRING50  client_exception_comment:='';
		STRING50  state_contact_name;
		STRING10  state_contact_phone;
		STRING10  state_contact_phone_extension;
		STRING256 state_contact_email;
		STRING1   eligibility_status_indicator;
		STRING8   eligibility_status_date;
		STRING1   eligibility_period_type;
		STRING8   eligibility_period_start_raw;
		STRING8   eligibility_period_end_raw;
		UNSIGNED4 eligibility_period_total_count_days;
		UNSIGNED4 eligibility_period_total_count_months;
		STRING200 match_history_period;
		STRING10  matchcode;
		UNSIGNED2 lexid_score;
		UNSIGNED4 sequence_number;
		STRING8   error_code;
		STRING100 error_desc;
		UNSIGNED6 lexid;    //hidden[ecldev]
		UNSIGNED2 _penalty; //hidden[ecldev]
	END;

END;