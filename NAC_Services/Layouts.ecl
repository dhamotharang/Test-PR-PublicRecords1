IMPORT NAC,NAC_V2_Services,batchshare;
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
		STRING6  benefit_month;
		STRING1  benefit_type;
		STRING20 case_identifier;
		STRING20 client_identifier;
		STRING2  benefit_state;
		STRING6  benefit_month_start;
		STRING6  benefit_month_end;
		STRING1  eligibility_status;
	END;
	
	EXPORT batch_in_temp := RECORD(nac_batch_in)
		STRING20	orig_acctno 	:= ''; // [internal]
		Batchshare.Layouts.ShareErrors;
	END;
	
	EXPORT nac_raw_rec := RECORD
		NAC_V2_Services.Layouts.process_layout.acctno;
		STRING20 orig_acctno := '';
		recordof(NAC.Key_SCCM);
		NAC_V2_Services.Layouts.search_layout.isDeepDive;
		STRING6   matchcode := '';
		STRING    twelve_month_history := '';
		UNSIGNED2 lexid_score := 0;
		UNSIGNED2 penalt := 0;
		UNSIGNED2 err_search := 0;
		STRING    err_desc := '';
		BOOLEAN   isBenefitMonthMatch := FALSE;
		BOOLEAN   isBenefitTypeMatch 	:= FALSE;
		BOOLEAN   isEligibleStatusMatch := FALSE;
		BOOLEAN   isFullSSNMatch := FALSE;
		UNSIGNED  rank_order := 100;
		UNSIGNED4 sequence_number := 0;
	END;

	EXPORT hist_roll_rec := RECORD(nac_raw_rec)
		STRING benefit_month_matched := '';
		SET OF STRING6 benefit_month_set := [];
	END;

	EXPORT nac_batch_out := RECORD
		BatchShare.Layouts.ShareAcct;
		//case
		STRING20  case_identifier;
		STRING30  case_last_name;
		STRING25  case_first_name;
		STRING25  case_middle_name;
		STRING2   case_state;
		STRING6   case_benefit_month;
		STRING1   case_benefit_type;
		STRING10  case_phone_1;
		STRING10  case_phone_2;
		STRING256 case_email;
		STRING70  case_physical_address_street_1;
		STRING70  case_physical_address_street_2;
		STRING30  case_physical_address_city;
		STRING2   case_physical_address_state;
		STRING9   case_physical_address_zip;
		STRING70  case_mailing_address_street_1;
		STRING70  case_mailing_address_street_2;
		STRING30  case_mailing_address_city;
		STRING2   case_mailing_address_state;
		STRING9   case_mailing_address_zip;
		STRING3   case_county_parish_code;
		STRING25  case_county_parish_name;
		//client
		STRING20  client_identifier;
		STRING30  client_last_name;
		STRING25  client_first_name;
		STRING25  client_middle_name;
		STRING1   client_gender;
		STRING1   client_race;
		STRING1   client_ethnicity;
		STRING9   client_ssn;
		STRING1   client_ssn_type_indicator;
		STRING8   client_dob;
		STRING1   client_dob_type_indicator;
		STRING1   client_eligible_status_indicator;
		STRING8   client_eligible_status_date;
		STRING10  client_phone;
		STRING256 client_email;
		//contact
		STRING50  contact_name;
		STRING10  contact_phone;
		STRING10  contact_phone_extension;
		STRING256 contact_email;
		//additional fields
		STRING6   matchcode;
		UNSIGNED2 lexid_score;
		STRING100 twelve_month_history;
		STRING20  sequence_number;
		BatchShare.Layouts.ShareErrors;
		STRING    err_desc;
		UNSIGNED2 penalt; //hidden[ecldev]
		UNSIGNED6 did;    //hidden[ecldev]
	END;

END;