EXPORT BocaShell_Normalized_Layout(filename) :=  functionmacro


import ut;

 lay := RECORD
	unsigned8 time_ms := 0;
	STRING30 AccountNumber;
	risk_indicators.Layout_Boca_Shell;
	STRING200 errorcode;
END;



lay1 := record
lay - [
Shell_Input,iid, Source_Verification, Available_Sources, Input_Validation, Address_Validation,
 Name_Verification,
			Address_Verification, Other_Address_Info,
			Phone_Verification, 
			SSN_Verification, Velocity_Counters, Infutor, Infutor_Phone,	
			Impulse, BJL, Relatives, Vehicles, Watercraft, Accident_Data, AirCraft, Student, Professional_License, AVM, ConsumerFlags,
			ADL_Shell_Flags, header_summary, advo_input_addr, advo_addr_hist1, advo_addr_hist2, acc_logs, employment, business_header_address_summary,
			email_summary, address_history_summary, addr_risk_summary, addr_risk_summary2, addr_risk_summary3, iBehavior, fdAttributesv2,
			AMLAttributes, hhid_summary, insurance_phones_summary, address_sources_summary, Virtual_Fraud, liens, rv_scores, fd_scores, inquiryVerification,

  // wealth_indicator , reported_dob, dobmatchlevel,	inferred_age, mobility_indicator, lres,	lres2, lres3, addrPop, addrPop2, 
		  // addrPop3, historyDate, addrhist1zip4, addrhist2zip4, gong_ADL_dt_first_seen, gong_ADL_dt_last_seen, total_number_derogs,
	    // date_last_derog, estimated_income,
			// addr_stability, 	uspis_hotlist, 	rhode_island_insufficient_verification, 	Experian_Phone_Verification,
			// attended_college, source_profile, source_profile_index, economic_trajectory, economic_trajectory_index, addrsMilitaryEver, 
			// historyDateTimeStamp, errorcode,

	 // aircraft_build_date , 	// new for Riskview 5.0
// watercraft_build_date ,// new for Riskview 5.0
 // crim_build_date ,		// new for Riskview 5.0
 // proflic_build_date ,			// new for Riskview 5.0
 // property_build_date ,   // new for Riskview 5.0
	utility
	// time_ms,seq, did, truedid, adlcategory

		
			];

//Watercraft
                unsigned1 watercraft_count := 0;
                unsigned1 watercraft_count30 := 0;
                unsigned1 watercraft_count90 := 0;
                unsigned1 watercraft_count180 := 0;
                unsigned1 watercraft_count12 := 0;
                unsigned1 watercraft_count24 := 0;
                unsigned1 watercraft_count36 := 0;
                unsigned1 watercraft_count60 := 0;

						
//	AVM
	string1 Input_Address_Information_avm_land_use_code := '';
	string8 Input_Address_Information_avm_recording_date := '';
	string4 Input_Address_Information_avm_assessed_value_year := '';
	string11 Input_Address_Information_avm_sales_price := '';  
	string11 Input_Address_Information_avm_assessed_total_value := '';
	string11 Input_Address_Information_avm_market_total_value := '';
	unsigned Input_Address_Information_avm_tax_assessment_valuation := 0;
	unsigned Input_Address_Information_avm_price_index_valuation := 0;
	unsigned Input_Address_Information_avm_hedonic_valuation := 0;
	unsigned Input_Address_Information_avm_automated_valuation := 0;	
	unsigned Input_Address_Information_avm_automated_valuation2 := 0;
	unsigned Input_Address_Information_avm_automated_valuation3 := 0;
	unsigned Input_Address_Information_avm_automated_valuation4 := 0;
	unsigned Input_Address_Information_avm_automated_valuation5 := 0;
	unsigned Input_Address_Information_avm_automated_valuation6 := 0;
	unsigned Input_Address_Information_avm_confidence_score := 0;
	unsigned Input_Address_Information_avm_median_fips_level := 0;
	unsigned Input_Address_Information_avm_median_geo11_level := 0;
	unsigned Input_Address_Information_avm_median_geo12_level := 0;				
	
		string1 Address_History_1_avm_land_use_code := '';
	string8 Address_History_1_avm_recording_date := '';
	string4 Address_History_1_avm_assessed_value_year := '';
	string11 Address_History_1_avm_sales_price := '';  
	string11 Address_History_1_avm_assessed_total_value := '';
	string11 Address_History_1_avm_market_total_value := '';
	unsigned Address_History_1_avm_tax_assessment_valuation := 0;
	unsigned Address_History_1_avm_price_index_valuation := 0;
	unsigned Address_History_1_avm_hedonic_valuation := 0;
	unsigned Address_History_1_avm_automated_valuation := 0;	
	unsigned Address_History_1_avm_automated_valuation2 := 0;
	unsigned Address_History_1_avm_automated_valuation3 := 0;
	unsigned Address_History_1_avm_automated_valuation4 := 0;
	unsigned Address_History_1_avm_automated_valuation5 := 0;
	unsigned Address_History_1_avm_automated_valuation6 := 0;
	unsigned Address_History_1_avm_confidence_score := 0;
	unsigned Address_History_1_avm_median_fips_level := 0;
	unsigned Address_History_1_avm_median_geo11_level := 0;
	unsigned Address_History_1_avm_median_geo12_level := 0;
	
			string1 Address_History_2_avm_land_use_code := '';
	string8 Address_History_2_avm_recording_date := '';
	string4 Address_History_2_avm_assessed_value_year := '';
	string11 Address_History_2_avm_sales_price := '';  
	string11 Address_History_2_avm_assessed_total_value := '';
	string11 Address_History_2_avm_market_total_value := '';
	unsigned Address_History_2_avm_tax_assessment_valuation := 0;
	unsigned Address_History_2_avm_price_index_valuation := 0;
	unsigned Address_History_2_avm_hedonic_valuation := 0;
	unsigned Address_History_2_avm_automated_valuation := 0;	
	unsigned Address_History_2_avm_automated_valuation2 := 0;
	unsigned Address_History_2_avm_automated_valuation3 := 0;
	unsigned Address_History_2_avm_automated_valuation4 := 0;
	unsigned Address_History_2_avm_automated_valuation5 := 0;
	unsigned Address_History_2_avm_automated_valuation6 := 0;
	unsigned Address_History_2_avm_confidence_score := 0;
	unsigned Address_History_2_avm_median_fips_level := 0;
	unsigned Address_History_2_avm_median_geo11_level := 0;
	unsigned Address_History_2_avm_median_geo12_level := 0;
	

//ACC_logs
	string8 first_log_date;
	string8 last_log_date;
	integer2	Inquiry_addr_ver_ct;
	integer2 Inquiry_fname_ver_ct;
	integer2 Inquiry_lname_ver_ct;
	integer2 Inquiry_ssn_ver_ct;
	integer2 Inquiry_dob_ver_ct; 
	integer2 Inquiry_phone_ver_ct;
	integer2 Inquiry_email_ver_ct;
	
	// layout_counts Inquiries;
	unsigned2 Inquiries_CountTotal;
	unsigned2 Inquiries_CountDay;
	unsigned2 Inquiries_CountWeek;
	unsigned2 Inquiries_Count01;
	unsigned2 Inquiries_Count03;
	unsigned2 Inquiries_Count06;
	unsigned2 Inquiries_Count12;
	unsigned2 Inquiries_Count24;
	unsigned2 Inquiries_CBDCountTotal;
	unsigned2 Inquiries_CBDCount01;
	
	// layout_counts Collection;
	unsigned2 Collection_CountTotal;
	unsigned2 Collection_CountDay;
	unsigned2 Collection_CountWeek;
	unsigned2 Collection_Count01;
	unsigned2 Collection_Count03;
	unsigned2 Collection_Count06;
	unsigned2 Collection_Count12;
	unsigned2 Collection_Count24;
	unsigned2 Collection_CBDCountTotal;
	unsigned2 Collection_CBDCount01;
	
	// layout_counts Auto;
	unsigned2 Auto_CountTotal;
	unsigned2 Auto_CountDay;
	unsigned2 Auto_CountWeek;
	unsigned2 Auto_Count01;
	unsigned2 Auto_Count03;
	unsigned2 Auto_Count06;
	unsigned2 Auto_Count12;
	unsigned2 Auto_Count24;
	unsigned2 Auto_CBDCountTotal;
	unsigned2 Auto_CBDCount01;	
	
	// layout_counts Banking;
	unsigned2 Banking_CountTotal;
	unsigned2 Banking_CountDay;
	unsigned2 Banking_CountWeek;
	unsigned2 Banking_Count01;
	unsigned2 Banking_Count03;
	unsigned2 Banking_Count06;
	unsigned2 Banking_Count12;
	unsigned2 Banking_Count24;
	unsigned2 Banking_CBDCountTotal;
	unsigned2 Banking_CBDCount01;
	
	// layout_counts Mortgage;
	unsigned2 Mortgage_CountTotal;
	unsigned2 Mortgage_CountDay;
	unsigned2 Mortgage_CountWeek;
	unsigned2 Mortgage_Count01;
	unsigned2 Mortgage_Count03;
	unsigned2 Mortgage_Count06;
	unsigned2 Mortgage_Count12;
	unsigned2 Mortgage_Count24;
	unsigned2 Mortgage_CBDCountTotal;
	unsigned2 Mortgage_CBDCount01;
	
	// layout_counts HighRiskCredit;
	unsigned2 HighRiskCredit_CountTotal;
	unsigned2 HighRiskCredit_CountDay;
	unsigned2 HighRiskCredit_CountWeek;
	unsigned2 HighRiskCredit_Count01;
	unsigned2 HighRiskCredit_Count03;
	unsigned2 HighRiskCredit_Count06;
	unsigned2 HighRiskCredit_Count12;
	unsigned2 HighRiskCredit_Count24;
	unsigned2 HighRiskCredit_CBDCountTotal;
	unsigned2 HighRiskCredit_CBDCount01;
	
	// layout_counts Retail;
	unsigned2 Retail_CountTotal;
	unsigned2 Retail_CountDay;
	unsigned2 Retail_CountWeek;
	unsigned2 Retail_Count01;
	unsigned2 Retail_Count03;
	unsigned2 Retail_Count06;
	unsigned2 Retail_Count12;
	unsigned2 Retail_Count24;
	unsigned2 Retail_CBDCountTotal;
	unsigned2 Retail_CBDCount01;
	
	// layout_counts Communications;
	unsigned2 Communications_CountTotal;
	unsigned2 Communications_CountDay;
	unsigned2 Communications_CountWeek;
	unsigned2 Communications_Count01;
	unsigned2 Communications_Count03;
	unsigned2 Communications_Count06;
	unsigned2 Communications_Count12;
	unsigned2 Communications_Count24;
	unsigned2 Communications_CBDCountTotal;
	unsigned2 Communications_CBDCount01;
	
	// layout_counts - CBDCountTotal - CBDCount01 FraudSearches
		unsigned2 FraudSearches_CountTotal;
	unsigned2 FraudSearches_CountDay;
	unsigned2 FraudSearches_CountWeek;
	unsigned2 FraudSearches_Count01;
	unsigned2 FraudSearches_Count03;
	unsigned2 FraudSearches_Count06;
	unsigned2 FraudSearches_Count12;
	unsigned2 FraudSearches_Count24;

	
	// layout_counts Other;
		unsigned2 Other_CountTotal;
	unsigned2 Other_CountDay;
	unsigned2 Other_CountWeek;
	unsigned2 Other_Count01;
	unsigned2 Other_Count03;
	unsigned2 Other_Count06;
	unsigned2 Other_Count12;
	unsigned2 Other_Count24;
	unsigned2 Other_CBDCountTotal;
	unsigned2 Other_CBDCount01;

// layout_counts prepaidCards    new for shell 5.0
		unsigned2 prepaidCards_CountTotal;
	unsigned2 prepaidCards_CountDay;
	unsigned2 prepaidCards_CountWeek;
	unsigned2 prepaidCards_Count01;
	unsigned2 prepaidCards_Count03;
	unsigned2 prepaidCards_Count06;
	unsigned2 prepaidCards_Count12;
	unsigned2 prepaidCards_Count24;
	unsigned2 prepaidCards_CBDCountTotal;
	unsigned2 prepaidCards_CBDCount01;
	
 	// layout_counts QuizProvider     new for shell 5.0
		unsigned2 QuizProvider_CountTotal;
	unsigned2 QuizProvider_CountDay;
	unsigned2 QuizProvider_CountWeek;
	unsigned2 QuizProvider_Count01;
	unsigned2 QuizProvider_Count03;
	unsigned2 QuizProvider_Count06;
	unsigned2 QuizProvider_Count12;
	unsigned2 QuizProvider_Count24;
	unsigned2 QuizProvider_CBDCountTotal;
	unsigned2 QuizProvider_CBDCount01;
	// layout_counts retailPayments     new for shell 5.0
	
		unsigned2 retailPayments_CountTotal;
	unsigned2 retailPayments_CountDay;
	unsigned2 retailPayments_CountWeek;
	unsigned2 retailPayments_Count01;
	unsigned2 retailPayments_Count03;
	unsigned2 retailPayments_Count06;
	unsigned2 retailPayments_Count12;
	unsigned2 retailPayments_Count24;
	unsigned2 retailPayments_CBDCountTotal;
	unsigned2 retailPayments_CBDCount01;
	
// layout_counts StudentLoans     new for shell 5.0
		unsigned2 StudentLoans_CountTotal;
	unsigned2 StudentLoans_CountDay;
	unsigned2 StudentLoans_CountWeek;
	unsigned2 StudentLoans_Count01;
	unsigned2 StudentLoans_Count03;
	unsigned2 StudentLoans_Count06;
	unsigned2 StudentLoans_Count12;
	unsigned2 StudentLoans_Count24;
	unsigned2 StudentLoans_CBDCountTotal;
	unsigned2 StudentLoans_CBDCount01;
	
// layout_counts Utilities     new for shell 5.0
		unsigned2 Utilities_CountTotal;
	unsigned2 Utilities_CountDay;
	unsigned2 Utilities_CountWeek;
	unsigned2 Utilities_Count01;
	unsigned2 Utilities_Count03;
	unsigned2 Utilities_Count06;
	unsigned2 Utilities_Count12;
	unsigned2 Utilities_Count24;
	unsigned2 Utilities_CBDCountTotal;
	unsigned2 Utilities_CBDCount01;
	
	unsigned2 Inq_BillGroup_count;// new for shell 5.0
	unsigned2 Inq_BillGroup_count01;// new for shell 5.0
	unsigned2 Inq_BillGroup_count03;// new for shell 5.0
	unsigned2 Inq_BillGroup_count06;// new for shell 5.0
	unsigned2 Inq_BillGroup_count12;// new for shell 5.0
	unsigned2 Inq_BillGroup_count24;// new for shell 5.0
	
	// velocity counters per ADL
	unsigned2 inquiryPerADL := 0;
	unsigned2 inquirySSNsPerADL := 0;  
	unsigned2 inquiryAddrsPerADL := 0;
	unsigned2 inquiryLnamesPerADL := 0;
	unsigned2 inquiryFnamesPerADL := 0;
	unsigned2 inquiryPhonesPerADL := 0;
	unsigned2 inquiryDOBsPerADL := 0;
	
	unsigned2 unverifiedSSNsPerADL := 0;  
	unsigned2 unverifiedAddrsPerADL := 0;
	unsigned2 unverifiedPhonesPerADL := 0;
	unsigned2 unverifiedDOBsPerADL := 0;
	
	unsigned2 inquiryemailsperADL := 0;  // new for shell 5.0
	
	// velocity counters per SSN
	unsigned2 inquiryPerSSN := 0;
	unsigned2 inquiryADLsPerSSN := 0;
	unsigned2 inquiryLNamesPerSSN := 0;
	unsigned2 inquiryAddrsPerSSN := 0;
	unsigned2 inquiryDOBsPerSSN := 0;
	
	unsigned2 fraudSearchInquiryPerSSN := 0;
	unsigned2 fraudSearchInquiryPerSSNYear := 0;
	unsigned2 fraudSearchInquiryPerSSNMonth := 0;
	unsigned2 fraudSearchInquiryPerSSNWeek := 0;
	unsigned2 fraudSearchInquiryPerSSNDay := 0;
	
	// velocity counters per Addr
	unsigned2 inquiryPerAddr := 0;
	unsigned2 inquiryADLsPerAddr := 0;
	unsigned2 inquiryLNamesPerAddr := 0;
	unsigned2 inquirySSNsPerAddr := 0;

	unsigned2 fraudSearchInquiryPerAddr := 0;
	unsigned2 fraudSearchInquiryPerAddrYear := 0;
	unsigned2 fraudSearchInquiryPerAddrMonth := 0;
	unsigned2 fraudSearchInquiryPerAddrWeek := 0;
	unsigned2 fraudSearchInquiryPerAddrDay := 0;
	unsigned2 inquirySuspciousADLsperAddr := 0;
	
	// velocity counter per Phone
	unsigned2 inquiryPerPhone := 0;
	unsigned2 inquiryADLsPerPhone := 0;	
	
	unsigned2 fraudSearchInquiryPerPhone := 0;
	unsigned2 fraudSearchInquiryPerPhoneYear := 0;
	unsigned2 fraudSearchInquiryPerPhoneMonth := 0;
	unsigned2 fraudSearchInquiryPerPhoneWeek := 0;
	unsigned2 fraudSearchInquiryPerPhoneDay := 0;
		unsigned2 inquiryADLsPerEmail := 0;	// new for shell 5.0
	
	// banko fields
	string8 am_first_seen_date := '';
	string8 am_last_seen_date := '';
	string8 cm_first_seen_date := '';
	string8 cm_last_seen_date := '';
	string8 om_first_seen_date := '';
	string8 om_last_seen_date := '';
	
	// chargeback defender-specific fields
	string8 noncbd_first_log_date;
	string8 noncbd_last_log_date;
	string8 cbd_first_log_date;
	string8 cbd_last_log_date;
	unsigned2 cbd_inquiryAddrsPerADL  := 0;
	unsigned2 cbd_inquiryADLsPerAddr  := 0;
	unsigned2 cbd_inquiryPhonesPerADL := 0;

// Shell_input
UNSIGNED4 Shell_input_seq;
	UNSIGNED6 Shell_input_DID := 0;  		// moved here from layout_output
	UNSIGNED2 score := 0; 	// moved here from layout_output
	STRING5  title := '';
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5  suffix;
	STRING120 in_streetAddress;
	STRING25 in_city;
	STRING2 in_state;
	STRING5 in_zipCode;
	STRING25 in_country;
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  z5;
	STRING4  zip4;
	STRING10 lat := '';
	STRING11 long := '';
	string3 county := '';
	string7 geo_blk := '';
	STRING1  addr_type;
	STRING4  addr_status;
	STRING25 country;
	STRING9  Shell_input_ssn;
	STRING8  dob;
	STRING3  Shell_input_age;
	STRING20 dl_number := '';
	STRING2 dl_state := '';
	STRING50 email_address := '';
	STRING20 ip_address := '';
	STRING10 Shell_input_phone10;
	STRING10 wphone10;
	STRING100 employer_name := '';
	STRING20 lname_prev := '';

//Utility fields
	qstring50  utili_adl_type; 
	qstring150 utili_adl_dt_first_seen;
	unsigned1 utili_adl_count;
	string8   utili_adl_earliest_dt_first_seen;
	unsigned1 utili_adl_nap;
	qstring50  utili_addr1_type; 
	qstring150 utili_addr1_dt_first_seen;
	unsigned1 utili_addr1_nap;
	qstring50  utili_addr2_type; 
	qstring150 utili_addr2_dt_first_seen;
	unsigned1 utili_addr2_nap;	

//name verification records
	UNSIGNED1 adl_score;
	UNSIGNED1 fname_score;
	UNSIGNED1 lname_score;
	UNSIGNED3 lname_change_date;
	UNSIGNED3 lname_prev_change_date;
	UNSIGNED1 source_count;
	BOOLEAN fname_credit_sourced;
	BOOLEAN lname_credit_sourced;
	BOOLEAN fname_tu_sourced;
	BOOLEAN lname_tu_sourced;
	BOOLEAN fname_eda_sourced;
	STRING2 fname_eda_sourced_type;
	BOOLEAN lname_eda_sourced;
	STRING2 lname_eda_sourced_type;
	BOOLEAN fname_dl_sourced;
	BOOLEAN lname_dl_sourced;
	BOOLEAN fname_voter_sourced;
	BOOLEAN lname_voter_sourced;
	BOOLEAN fname_utility_sourced;
	BOOLEAN lname_utility_sourced;
	UNSIGNED1 age;
	UNSIGNED1 dob_score;
	STRING20 newest_lname;
	UNSIGNED3 newest_lname_dt_first_seen;

//Phone_Verification
	UNSIGNED1 phone_score;
		string8 gong_adl_dt_first_seen_full;
	string8 gong_adl_dt_last_seen_full;
	unsigned2 gong_did_phone_ct;
	unsigned2 gong_did_addr_ct;
	unsigned2 gong_did_first_ct;
	unsigned2 gong_did_last_ct;	
	string50 phone_sources;
		STRING10 telcordia_type;
	BOOLEAN phone_zip_mismatch;
	INTEGER distance;
	BOOLEAN disconnected;
	UNSIGNED1 recent_disconnects;
	BOOLEAN HR_Phone;
	BOOLEAN Corrections;

//Virtual fraud fields
	integer1  hi_risk_ct ;
	integer1  lo_risk_ct ;
	integer1  LexID_phone_hi_risk_ct ;
	integer1  LexID_phone_lo_risk_ct ;
	integer1  AltLexID_Phone_hi_risk_ct ;
	integer1  AltLexID_Phone_lo_risk_ct ;
	integer1  LexID_addr_hi_risk_ct;
	integer1  LexID_addr_lo_risk_ct ;
	integer1  AltLexID_addr_hi_risk_ct ;
	integer1  AltLexID_addr_lo_risk_ct ;
	integer1  LexID_ssn_hi_risk_ct ;
	integer1  LexID_ssn_lo_risk_ct ;
	integer1  AltLexID_ssn_hi_risk_ct ;
	integer1  AltLexID_ssn_lo_risk_ct ;

//Inquiry Verification
		UNSIGNED1 inquiryNAPfirstcount ; 
	UNSIGNED1 inquiryNAPlastcount ; 
	UNSIGNED1 inquiryNAPaddrcount ;  
	UNSIGNED1 inquiryNAPphonecount ; 
	UNSIGNED1 inquiryNAPssncount ;
	UNSIGNED1 inquiryNAPdobcount;
	STRING10 InquiryNAPprim_range ;
	STRING2  InquiryNAPpredir ;
	STRING28 InquiryNAPprim_name ;
	STRING4  InquiryNAPsuffix ;
	STRING2  InquiryNAPpostdir ;
	STRING10 InquiryNAPunit_desig ;
	STRING8  InquiryNAPsec_range ;
	STRING25 InquiryNAPcity ;
	STRING2  InquiryNAPst ;
	STRING5  InquiryNAPz5 ;
	STRING30 InquiryNAPfname ;
	STRING30 InquiryNAPlname ;
	STRING9 InquiryNAPssn ;
	STRING8 InquiryNAPdob ;
	STRING10 InquiryNAPphone ;
	UNSIGNED1 InquiryNAPaddrScore ;
	UNSIGNED1 InquiryNAPfnameScore ;
	UNSIGNED1 InquiryNAPlnameScore ;
	UNSIGNED1 InquiryNAPssnScore ;
	UNSIGNED1 InquiryNAPdobScore ;
	UNSIGNED1 InquiryNAPphoneScore ;

//Input Validation
		BOOLEAN FirstName;
	BOOLEAN LastName;
	BOOLEAN Address;
	BOOLEAN SSN;
	STRING1 SSN_Length;
	BOOLEAN DateOfBirth;
	BOOLEAN Email;
	BOOLEAN IPAddress;
	BOOLEAN HomePhone;
	BOOLEAN WorkPhone;


//fd_scores
	string3 fd3;
	string3 fd6;
	string2 fd_reason1;
  string2 fd_reason2;
  string2 fd_reason3;
  string2 fd_reason4;
	string3 fraudpoint := '';
	string2 reason1FP := '';
	string2 reason2FP := '';
	string2 reason3FP := '';
	string2 reason4FP := '';
	string2 reason5FP := '';
	string2 reason6FP := '';
	string3 fraudpointV2;
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;
	string2 reason1FPV2;
	string2 reason2FPV2;
	string2 reason3FPV2;
	string2 reason4FPV2;
	string2 reason5FPV2;
	string2 reason6FPV2;
	string3 fraudpoint_V3;
	string1 StolenIdentityIndex_V3;
	string1 SyntheticIdentityIndex_V3;
	string1 ManipulatedIdentityIndex_V3;
	string1 VulnerableVictimIndex_V3;
	string1 FriendlyFraudIndex_V3;
	string1 SuspiciousActivityIndex_V3;
	string3 reason1FP_V3;
	string3 reason2FP_V3;
	string3 reason3FP_V3;
	string3 reason4FP_V3;
	string3 reason5FP_V3;
	string3 reason6FP_V3;

//rv_scores
string3 bankcard;
	string3 retail;
	string3 auto;
	string3 telecom;
	string2 rv_reason1;
	string2 rv_reason2;
	string2 rv_reason3;
	string2 rv_reason4;
	string3 bankcardV2;
	string3 retailV2;
	string3 autoV2;
	string3 telecomV2;
	string3 msbV2;
	string3 prescreenV2;
	string2 reason1V2;
	string2 reason2V2;
	string2 reason3V2;
	string2 reason4V2;
	string3 bankcardV3;
	string2 reason1bV3;
	string2 reason2bV3;
	string2 reason3bV3;
	string2 reason4bV3;
	string3 retailV3;
	string2 reason1rV3;
	string2 reason2rV3;
	string2 reason3rV3;
	string2 reason4rV3;
	string3 autoV3;
	string2 reason1aV3;
	string2 reason2aV3;
	string2 reason3aV3;
	string2 reason4aV3;
	string3 telecomV3;
	string2 reason1tV3;
	string2 reason2tV3;
	string2 reason3tV3;
	string2 reason4tV3;
	string3 msbV3;
	string2 reason1mV3;
	string2 reason2mV3;
	string2 reason3mV3;
	string2 reason4mV3;
	string3 prescreenV3;
	string3 bankcardV4;
	string2 reason1bV4;
	string2 reason2bV4;
	string2 reason3bV4;
	string2 reason4bV4;
	string2 reason5bV4;
	string3 retailV4;
	string2 reason1rV4;
	string2 reason2rV4;
	string2 reason3rV4;
	string2 reason4rV4;
	string2 reason5rV4;
	string3 autoV4;
	string2 reason1aV4;
	string2 reason2aV4;
	string2 reason3aV4;
	string2 reason4aV4;
	string2 reason5aV4;
	string3 telecomV4;
	string2 reason1tV4;
	string2 reason2tV4;
	string2 reason3tV4;
	string2 reason4tV4;
	string2 reason5tV4;
	string3 msbV4;
	string2 reason1mV4;
	string2 reason2mV4;
	string2 reason3mV4;
	string2 reason4mV4;
	string2 reason5mV4;
	string3 prescreenV4;

// ADDRESS_Validation
	BOOLEAN USPS_Deliverable;
	STRING10 Dwelling_Type;
	STRING10 Zip_Type;
	BOOLEAN HR_Address;
	STRING100 HR_Company;
	STRING4 Error_Codes;
	BOOLEAN ADDRESS_Validation_Corrections;

//Source_Verification

	unsigned2 EQ_count := 0;
	unsigned2 EN_count := 0;
	unsigned2 TU_count := 0;
	unsigned2 DL_count := 0;
	unsigned2 PR_count := 0;
	unsigned2 V_count := 0;
	unsigned2 EM_count := 0;
	unsigned2 VO_count := 0;
	unsigned2 W_count := 0;
	unsigned2 EM_only_count := 0;	
	unsigned3 adl_EQfs_first_seen := 0;
	unsigned3 adl_en_first_seen := 0;
	unsigned3 adl_TU_first_seen := 0;
	unsigned3 adl_DL_first_seen := 0;
	unsigned3 adl_PR_first_seen := 0;
	unsigned3 adl_V_first_seen := 0;
	unsigned3 adl_EM_first_seen := 0;
	unsigned3 adl_VO_first_seen := 0;
	unsigned3 adl_EM_only_first_seen := 0;
	unsigned3 adl_W_first_seen := 0;	
	unsigned3 adl_EQfs_last_seen := 0;
	unsigned3 adl_en_last_seen :=0;
	unsigned3 adl_TU_last_seen := 0;
	unsigned3 adl_DL_last_seen := 0;
	unsigned3 adl_PR_last_seen := 0;
	unsigned3 adl_V_last_seen := 0;
	unsigned3 adl_EM_last_seen := 0;
	unsigned3 adl_VO_last_seen := 0;
	unsigned3 adl_EM_only_last_seen := 0;
	unsigned3 adl_W_last_seen := 0;	
	// added for nas leveling
	string50 firstnamesources := '';
	string50 lastnamesources := '';
	string50 addrsources := '';
	string50 socssources := '';	
	STRING50 em_only_sources := '';
	unsigned1 num_nonderogs := 0;
	unsigned1 num_nonderogs30 := 0;
	unsigned1 num_nonderogs90 := 0;
	unsigned1 num_nonderogs180 := 0;
	unsigned1 num_nonderogs12 := 0;
	unsigned1 num_nonderogs24 := 0;
	unsigned1 num_nonderogs36 := 0;
	unsigned1 num_nonderogs60 := 0;	

//Available_Sources
	
	BOOLEAN DL;
	BOOLEAN Voter;

//Other_Address_Info

	unsigned2 max_lres;
	unsigned2 avg_lres;
	unsigned1 addrs_last_5years := 0;
	unsigned1 addrs_last_10years := 0;
	unsigned1 addrs_last_15years := 0;
	boolean isPrison := false; // this is a flag to identify if any of your addresses are a prison
	unsigned4 prisonFSdate := 0;	  // new for riskview 5.0
	boolean hist1_isPrison := false;
	boolean hist2_isPrison := false;
	unsigned1 addrs_last30 := 0;
	unsigned1 addrs_last90 := 0;
	unsigned1 addrs_last12 := 0;
	unsigned1 addrs_last24 := 0;
	unsigned1 addrs_last36 := 0;
	unsigned4 date_first_purchase := 0;
	unsigned4 date_most_recent_purchase := 0;
	unsigned1 num_purchase30 := 0;
	unsigned1 num_purchase90 := 0;
	unsigned1 num_purchase180 := 0;
	unsigned1 num_purchase12 := 0;
	unsigned1 num_purchase24 := 0;
	unsigned1 num_purchase36 := 0;
	unsigned1 num_purchase60 := 0;
	unsigned4 date_first_sale := 0; // new for riskview 5.0
	unsigned4 date_most_recent_sale := 0;  
	unsigned1 num_sold30 := 0;
	unsigned1 num_sold90 := 0;
	unsigned1 num_sold180 := 0;
	unsigned1 num_sold12 := 0;
	unsigned1 num_sold24 := 0;
	unsigned1 num_sold36 := 0;
	unsigned1 num_sold60 := 0;
	integer1 unverified_addr_count := 0;// new for shell 5.0

//Aircraft
								unsigned1 aircraft_count := 0;
                unsigned1 aircraft_count30 := 0;
                unsigned1 aircraft_count90 := 0;
                unsigned1 aircraft_count180 := 0;
                unsigned1 aircraft_count12 := 0;
                unsigned1 aircraft_count24 := 0;
                unsigned1 aircraft_count36 := 0;
                unsigned1 aircraft_count60 := 0;
                string8 n_number;          // extra field
                string8 date_first_seen;  
 
 //Student
 string8 STUDENT_DATE_FIRST_SEEN;
	string8 STUDENT_DATE_LAST_SEEN;
	string4 CRRT_CODE;
	string1 ADDRESS_TYPE_CODE;
	string2 STUDENT_AGE;
	string8 DOB_FORMATTED;
	string3 CLASS;
	string25 COLLEGE_NAME;	
	string1 COLLEGE_CODE;
	string1 COLLEGE_TYPE;
	string1 INCOME_LEVEL_CODE;
	string1 FILE_TYPE;
	string1 FILE_TYPE2;
	string2 rec_type;
	string1 COLLEGE_TIER;
	string3 college_major;
	string1 competitive_code;
	string1 school_size_code;
	string1 tuition_code;


//Professional License
boolean professional_license_flag := false;
	string60 license_type := '';
	string100 jobCategory := '';
	string1 plCategory := '';
	unsigned1 proflic_count := 0;
	unsigned date_most_recent := 0;
	unsigned expiration_date := 0;
	unsigned1 proflic_count30 := 0;
	unsigned1 proflic_count90 := 0;
	unsigned1 proflic_count180 := 0;
	unsigned1 proflic_count12 := 0;
	unsigned1 proflic_count24 := 0;
	unsigned1 proflic_count36 := 0;
	unsigned1 proflic_count60 := 0;
	unsigned1 expire_count30 := 0;
	unsigned1 expire_count90 := 0;
	unsigned1 expire_count180 := 0;
	unsigned1 expire_count12 := 0;
	unsigned1 expire_count24 := 0;
	unsigned1 expire_count36 := 0;
	unsigned1 expire_count60 := 0;
	string2 proflic_Source;  // new for shell 5.0
	unsigned2 sanctions_count := 0;// new for shell 5.0
	unsigned4 sanctions_date_first_seen := 0;// new for shell 5.0
	unsigned4 sanctions_date_last_seen := 0;// new for shell 5.0
	string50 most_recent_sanction_type := '';// new for shell 5.0

//AML Attributes
	STRING2 IndCitizenshipIndex;
	STRING2 IndMobilityIndex;
	STRING2 IndLegalEventsIndex;
	STRING2 IndAccesstoFundsIndex;
	STRING2 IndBusinessAssocationIndex;
	STRING2 IndHighValueAssetIndex;
	STRING2 IndGeographicIndex;
	STRING2 IndAssociatesIndex;
	STRING2 IndAgeRange;
	STRING3 IndAMLNegativeNews90;
  STRING3 IndAMLNegativeNews24;
	STRING2 BusValidityIndex;
	STRING2 BusStabilityIndex;
	STRING2 BusLegalEventsIndex;
	STRING2 BusAccesstoFundsIndex;
	STRING2 BusGeographicIndex;
	STRING2 BusAssociatesIndex;
	STRING2 BusIndustryRiskIndex;
	STRING3 BusAMLNegativeNews90;
  STRING3 BusAMLNegativeNews24;

//hhid summary
	unsigned6 hhid;
	unsigned1 hh_members_ct := 0;  //Total number of household members
	unsigned1 hh_property_owners_ct := 0;  //Total number of household members shown to own property
	unsigned1 hh_age_65_plus := 0;  //Total number of household members aged 65 and up
	unsigned1 hh_age_31_to_65 := 0;  //Total number of household members aged 30 to 65
	unsigned1 hh_age_18_to_30 := 0;  //Total number of household members aged 18 to 30
	unsigned1 hh_age_lt18 := 0;  //Total number of household members less than 18
	unsigned1 hh_collections_ct := 0;  //Total number of household members with collection inquiry activity
	unsigned1 hh_workers_paw := 0;  //Total number of household members with a People at Work record
	unsigned1 hh_payday_loan_users := 0;  //Total number of household members with payday loan activity on file (Impulse)
	unsigned1 hh_members_w_derog := 0;  //Total number of household members with derogatory public records
	unsigned1 hh_tot_derog := 0;  //Total number of derogatory public records for the entire household
	unsigned1 hh_bankruptcies := 0;  //Total number of household members with a bankruptcy on file
	unsigned1 hh_lienholders := 0;  //Total number of household members with any lien record
	unsigned1 hh_prof_license_holders := 0;  //Total number of household members with a professional license
	unsigned1 hh_criminals := 0;  //Total number of criminals in the household
	unsigned1 hh_college_attendees := 0;  //Total number of household members with evidence of college attendance

//insurance phones summary
	string2 Insurance_Phone_Verification;
	boolean insurance_phones_phone_hit;
	boolean insurance_phones_phonesearch_didmatch;
	boolean insurance_phones_did_hit;
	boolean insurance_phones_didsearch_phonematch;

//address sources summary
	string100 input_addr_sources := '';
	string200 input_addr_sources_first_seen_date := '';
	string100 input_addr_sources_recordcount := '';
	string100 current_addr_sources := '';
	string200 current_addr_sources_first_seen_date := '';
	string100 current_addr_sources_recordcount := '';
	string100 previous_addr_sources := '';
	string200 previous_addr_sources_first_seen_date := '';
	string100 previous_addr_sources_recordcount := '';

//fdattributesv2
	string2	IdentityRiskLevel	;
	string2	IDVerRiskLevel	;
	string2	IDVerAddressNotCurrent	;
	string2	SourceRiskLevel	;
	string2	VariationRiskLevel	;
	string3	VariationMSourcesSSNCount	;
	string3	VariationMSourcesSSNUnrelCount	;
	string3	VariationDOBCount	;
	string3	VariationDOBCountNew	;
	string2	SearchVelocityRiskLevel	;
	string3	SearchCountWeek	;
	string3	SearchCountDay	;
	string3	SearchUnverifiedSSNCountYear	;
	string3	SearchUnverifiedAddrCountYear	;
	string3	SearchUnverifiedDOBCountYear	;
	string3	SearchUnverifiedPhoneCountYear	;
	string3	SearchFraudSearchCount	;
	string3	SearchFraudSearchCountYear	;
	string3	SearchFraudSearchCountMonth	;
	string3	SearchFraudSearchCountWeek	;
	string3	SearchFraudSearchCountDay	;
	string3	SearchLocateSearchCountWeek	;
	string3	SearchLocateSearchCountDay	;
	string2	AssocRiskLevel	;
	string3	AssocSuspicousIdentitiesCount	;
	string3	AssocCreditBureauOnlyCount	;
	string3	AssocCreditBureauOnlyCountNew	;
	string3	AssocCreditBureauOnlyCountMonth	;
	string2	ValidationRiskLevel	;
	string2	CorrelationRiskLevel	;
	string3	CorrelationSSNNameCount	;
	string3	CorrelationSSNAddrCount	;
	string3	CorrelationAddrNameCount	;
	string3	CorrelationAddrPhoneCount	;
	string3	CorrelationPhoneLastNameCount	;
	string2	DivRiskLevel	;
	string3	DivSSNIdentityMSourceUrelCount	;
	string3	DivAddrSuspIdentityCountNew	;
	string3	DivSearchAddrSuspIdentityCount	;
	string2	SearchComponentRiskLevel	;
	string3	SearchSSNSearchCount	;
	string3	SearchSSNSearchCountMonth	;
	string3	SearchSSNSearchCountWeek	;
	string3	SearchSSNSearchCountDay	;
	string3	SearchAddrSearchCount	;
	string3	SearchAddrSearchCountMonth	;
	string3	SearchAddrSearchCountWeek	;
	string3	SearchAddrSearchCountDay	;
	string3	SearchPhoneSearchCount	;
	string3	SearchPhoneSearchCountMonth	;
	string3	SearchPhoneSearchCountWeek	;
	string3	SearchPhoneSearchCountDay	;
	string2	ComponentCharRiskLevel	;
	string2	InputAddrActivePhoneList	;
	string11	AddrChangeIncomeDiff	;
	string11	AddrChangeValueDiff	;
	string4	AddrChangeCrimeDiff	;
	string2	AddrChangeEconTrajectory	;
	string2	AddrChangeEconTrajectoryIndex	;
	string2	CurrAddrActivePhoneList	;
	string10	CurrAddrMedianIncome	;
	string10	CurrAddrMedianValue	;
	string3	CurrAddrMurderIndex	;
	string3	CurrAddrCarTheftIndex	;
	string3	CurrAddrBurglaryIndex	;
	string3	CurrAddrCrimeIndex	;
	string3	PrevAddrAgeOldest	;
	string3	PrevAddrLenOfRes	;
	string2	PrevAddrDwellType	;
	string2	PrevAddrStatus	;
	string2	PrevAddrOccupantOwned	;
	string10	PrevAddrMedianIncome	;
	string10	PrevAddrMedianValue	;
	string3	PrevAddrMurderIndex	;
	string3	PrevAddrCarTheftIndex	;
	string3	PrevAddrBurglaryIndex	;
	string3	PrevAddrCrimeIndex	;

//iBehavior
	string8		Cnsmr_date_first_seen;
	string8		Cnsmr_date_last_seen;
	string8		First_Order_Date;
	string8		Last_Order_Date;
	string3		number_of_sources;
	string4		Average_Days_Between_Orders;
	string9		Average_Amount_Per_Order;
	string9		Total_Dollars;
	string4		Total_Number_of_Orders;
	string9		Offline_Average_Amount_Per_Order;
	string9		Offline_Dollars;
	string4		Offline_Orders;
	string9		Online_Average_Amount_Per_Order;
	string9		Online_Dollars;
	string4		Online_Orders;
	string9		Retail_Average_Amount_Per_Order;
	string9		Retail_Dollars;
	string4		Retail_Orders;
	
//addr_risk_summary3	
	unsigned2 ar3_occupants_1yr;
	unsigned2 ar3_turnover_1yr_in;
	unsigned2 ar3_turnover_1yr_out;
	unsigned2 ar3_N_Vacant_Properties;
	unsigned2	ar3_N_Business_Count;
	unsigned2 ar3_N_SFD_Count;
	unsigned2 ar3_N_MFD_Count;
	unsigned4 ar3_N_ave_building_age;
	unsigned4 ar3_N_ave_purchase_amount;
	unsigned4 ar3_N_ave_mortgage_amount;
	unsigned4 ar3_N_ave_assessed_amount;
	unsigned8 ar3_N_ave_building_area;
	unsigned8	ar3_N_ave_price_per_sf;
	unsigned8 ar3_N_ave_no_of_stories_count;
	unsigned8 ar3_N_ave_no_of_rooms_count;
	unsigned8 ar3_N_ave_no_of_bedrooms_count;
	unsigned8 ar3_N_ave_no_of_baths_count;

//addr_risk_summary2
	unsigned2 ar2_occupants_1yr;
	unsigned2 ar2_turnover_1yr_in;
	unsigned2 ar2_turnover_1yr_out;
	unsigned2 ar2_N_Vacant_Properties;
	unsigned2	ar2_N_Business_Count;
	unsigned2 ar2_N_SFD_Count;
	unsigned2 ar2_N_MFD_Count;
	unsigned4 ar2_N_ave_building_age;
	unsigned4 ar2_N_ave_purchase_amount;
	unsigned4 ar2_N_ave_mortgage_amount;
	unsigned4 ar2_N_ave_assessed_amount;
	unsigned8 ar2_N_ave_building_area;
	unsigned8	ar2_N_ave_price_per_sf;
	unsigned8 ar2_N_ave_no_of_stories_count;
	unsigned8 ar2_N_ave_no_of_rooms_count;
	unsigned8 ar2_N_ave_no_of_bedrooms_count;
	unsigned8 ar2_N_ave_no_of_baths_count;
	
//addr_risk_summary
	unsigned2 occupants_1yr;
	unsigned2 turnover_1yr_in;
	unsigned2 turnover_1yr_out;
	unsigned2 N_Vacant_Properties;
	unsigned2	N_Business_Count;
	unsigned2 N_SFD_Count;
	unsigned2 N_MFD_Count;
	unsigned4 N_ave_building_age;
	unsigned4 N_ave_purchase_amount;
	unsigned4 N_ave_mortgage_amount;
	unsigned4 N_ave_assessed_amount;
	unsigned8 N_ave_building_area;
	unsigned8	N_ave_price_per_sf;
	unsigned8 N_ave_no_of_stories_count;
	unsigned8 N_ave_no_of_rooms_count;
	unsigned8 N_ave_no_of_bedrooms_count;
	unsigned8 N_ave_no_of_baths_count;	


//address_history_summary
	boolean address_history_advo_college_hit := false;
	integer2 unique_addr_cnt := 1;
	integer2 avg_mo_per_addr := 0;
	integer2 addr_count2 := 0;
	integer2 addr_count3 := 0;
	integer2 addr_count6 := 0;
	integer2 addr_count10 := 0;
	integer2 lres_2mo_count := 0;
	integer2 lres_6mo_count := 0;
	integer2 lres_12mo_count := 0;
	integer2 hist_addr_match := 0;
	unsigned3 input_addr_first_seen := 0;
	unsigned3 input_addr_last_seen := 0;
	boolean address_history_college_evidence := false;	

//employment
	qstring100 company_title;  // most recent company title
	unsigned4 emp_First_seen_date := 0;  //(non-dead businesses)
	unsigned2 Business_ct := 0;  // number of different BDIDs worked for
	unsigned2 Dead_business_ct := 0;  // number of different BDIDs worked for that are dead
	unsigned2 Business_active_phone_ct := 0; // number of active business phones
	unsigned2 Source_ct	:= 0;  // number of different PAW sources appeared on	

//Velocity_Counters
	// counts per ADL
	unsigned1 ssns_per_adl := 0;
	unsigned1 addrs_per_adl := 0;
	unsigned1 phones_per_adl := 0;
	unsigned1 dobs_per_adl := 0; 															// new for fraudpoint 2.0
	unsigned1 ssns_per_adl_created_6months := 0;
	unsigned1 addrs_per_adl_created_6months := 0;
	unsigned1 phones_per_adl_created_6months := 0;
	unsigned1 dobs_per_adl_created_6months := 0; 							// new for fraudpoint 2.0
	unsigned1 ssns_per_adl_seen_18months := 0;
	unsigned1 ssns_per_adl_multiple_use := 0; 								// new for fraudpoint 2.0 
	unsigned1 ssns_per_adl_multiple_use_non_relative := 0;  	// new for fraudpoint 2.0
	unsigned1 lnames_per_adl := 0;
	unsigned1 lnames_per_adl30 := 0;	
	unsigned1 lnames_per_adl90 := 0;
	unsigned1 lnames_per_adl180 := 0;
	unsigned1 lnames_per_adl12 := 0;
	unsigned1 lnames_per_adl24 := 0;
	unsigned1 lnames_per_adl36 := 0;
	unsigned1 lnames_per_adl60 := 0;
	unsigned1 invalid_ssns_per_adl := 0;
	unsigned1 invalid_phones_per_adl := 0;
	unsigned1 invalid_addrs_per_adl := 0;
	unsigned1 invalid_ssns_per_adl_created_6months := 0;
	unsigned1 invalid_phones_per_adl_created_6months := 0;
	unsigned1 invalid_addrs_per_adl_created_6months := 0;
	unsigned1 dl_addrs_per_adl := 0;
	unsigned1 vo_addrs_per_adl := 0;
	unsigned1 pl_addrs_per_adl := 0;


	// counts per SSN	
	unsigned1 addrs_per_ssn := 0; 
	unsigned1 adls_per_ssn_created_6months := 0;	
	unsigned1 addrs_per_ssn_created_6months := 0;
	unsigned1 adls_per_ssn_seen_18months := 0;	
	unsigned1 lnames_per_ssn := 0;  													// new for fraudpoint 2.0
	unsigned1 lnames_per_ssn_created_6months := 0;  					// new for fraudpoint 2.0
	unsigned1 addrs_per_ssn_multiple_use := 0;  							// new for fraudpoint 2.0
	unsigned1 adls_per_ssn_multiple_use := 0;  								// new for fraudpoint 2.0
	unsigned1 adls_per_ssn_multiple_use_non_relative := 0;  	// new for fraudpoint 2.0
	
	// counts per Address
	unsigned1 adls_per_addr := 0;
	unsigned1 ssns_per_addr := 0;
	unsigned1 phones_per_addr := 0;
	unsigned1 adls_per_addr_current := 0;		// new for shell 5.0
	unsigned1 ssns_per_addr_current := 0;		// new for shell 5.0
	unsigned1 phones_per_addr_current := 0;	// new for shell 5.0
	
	unsigned1 adls_per_addr_created_6months := 0;
	unsigned1 ssns_per_addr_created_6months := 0;
	unsigned1 phones_per_addr_created_6months := 0;
	unsigned1 adls_per_addr_multiple_use := 0;  							// new for fraudpoint 2.0
	unsigned1 ssns_per_addr_multiple_use := 0;  							// new for fraudpoint 2.0
	unsigned1 phones_per_addr_multiple_use := 0;  						// new for fraudpoint 2.0
	unsigned1 suspicious_adls_per_addr_created_6months := 0;  // new for fraudpoint 2.0
	
	// counts per phone
	unsigned1 adls_per_phone := 0; 
	unsigned1 adls_per_phone_current := 0; // new for shell 5.0
	unsigned1 adls_per_phone_created_6months := 0;
	unsigned1 adls_per_phone_multiple_use := 0;  							// new for fraudpoint 2.0
	unsigned1 addrs_per_phone := 0;  													// new for fraudpoint 2.0
	unsigned1 addrs_per_phone_created_6months := 0;  	


//Infutor
	unsigned4 infutor_date_first_seen;
	unsigned4 infutor_date_last_seen;
	unsigned1 infutor_nap;
	
//Infutor_phone
	unsigned4 Infutor_Phone_infutor_date_first_seen;
	unsigned4 Infutor_Phone_infutor_date_last_seen;
	unsigned1 Infutor_Phone_infutor_nap;	

//Impulse
	unsigned2 imp_count;
	unsigned4 first_seen_date;
	unsigned4 last_seen_date;
	string50 siteid;
	unsigned2 count30;
	unsigned2 count90;
	unsigned2 count180;
	unsigned2 count12;
	unsigned2 count24;
	unsigned2 count36;
	unsigned2 count60;
	unsigned5 annual_income;	
	

//BJL
BOOLEAN bankrupt := false;
	UNSIGNED4 date_last_seen := 0;
	STRING1 filing_type := '';
	STRING35 disposition := '';	
	UNSIGNED1 filing_count := 0;
	UNSIGNED1 bk_recent_count := 0;
	UNSIGNED1 bk_dismissed_recent_count := 0;
	UNSIGNED1 bk_dismissed_historical_count := 0;
	UNSIGNED1 bk_disposed_recent_count := 0;
	UNSIGNED1 bk_disposed_historical_count := 0;
	UNSIGNED1 bk_count30 := 0;
	UNSIGNED1 bk_count90 := 0;
	UNSIGNED1 bk_count180 := 0;
	UNSIGNED1 bk_count12 := 0;
	UNSIGNED1 bk_count24 := 0;
	UNSIGNED1 bk_count36 := 0;
	UNSIGNED1 bk_count60 := 0;
	STRING3   bk_chapter := '';
	
	UNSIGNED1 liens_recent_unreleased_count := 0;
	UNSIGNED1 liens_historical_unreleased_count := 0;
	UNSIGNED1 liens_unreleased_count30 := 0;
	UNSIGNED1 liens_unreleased_count90 := 0;
	UNSIGNED1 liens_unreleased_count180 := 0;
	UNSIGNED1 liens_unreleased_count12 := 0;
	UNSIGNED1 liens_unreleased_count24 := 0;
	UNSIGNED1 liens_unreleased_count36 := 0;
	UNSIGNED1 liens_unreleased_count60 := 0;
	string8 last_liens_unreleased_date := '';
	
	UNSIGNED1 liens_recent_released_count := 0;
	UNSIGNED1 liens_historical_released_count := 0;
	UNSIGNED1 liens_released_count30 := 0;
	UNSIGNED1 liens_released_count90 := 0;
	UNSIGNED1 liens_released_count180 := 0;
	UNSIGNED1 liens_released_count12 := 0;
	UNSIGNED1 liens_released_count24 := 0;
	UNSIGNED1 liens_released_count36 := 0;
	UNSIGNED1 liens_released_count60 := 0;
	UNSIGNED4 last_liens_released_date := 0;
	
	UNSIGNED1 criminal_count := 0;
	UNSIGNED1 criminal_count30 := 0;
	UNSIGNED1 criminal_count90 := 0;
	UNSIGNED1 criminal_count180 := 0;
	UNSIGNED1 criminal_count12 := 0;
	UNSIGNED1 criminal_count24 := 0;
	UNSIGNED1 criminal_count36 := 0;
	UNSIGNED1 criminal_count60 := 0;
	UNSIGNED4 last_criminal_date := 0;
	UNSIGNED1 felony_count := 0;
	UNSIGNED4 last_felony_date := 0;
	
	UNSIGNED1 nonfelony_criminal_count12 := 0;  // added for riskview attributes 5.0, populated only in FCRA shell
	UNSIGNED4 last_nonfelony_criminal_date := 0; // added for riskview attributes 5.0, populated only in FCRA shell
	
	UNSIGNED1 eviction_recent_unreleased_count := 0;
	UNSIGNED1 eviction_historical_unreleased_count := 0;
	UNSIGNED1 eviction_recent_released_count := 0;
	UNSIGNED1 eviction_historical_released_count := 0;
	UNSIGNED1 eviction_count := 0;
	UNSIGNED1 eviction_count30 := 0;
	UNSIGNED1 eviction_count90 := 0;
	UNSIGNED1 eviction_count180 := 0;
	UNSIGNED1 eviction_count12 := 0;
	UNSIGNED1 eviction_count24 := 0;
	UNSIGNED1 eviction_count36 := 0;
	UNSIGNED1 eviction_count60 := 0;
	UNSIGNED4 last_eviction_date := 0;	
	UNSIGNED1 arrests_count := 0;
	UNSIGNED1 arrests_count30 := 0;
	UNSIGNED1 arrests_count90 := 0;
	UNSIGNED1 arrests_count180 := 0;
	UNSIGNED1 arrests_count12 := 0;
	UNSIGNED1 arrests_count24 := 0;
	UNSIGNED1 arrests_count36 := 0;
	UNSIGNED1 arrests_count60 := 0;
	UNSIGNED4 date_last_arrest := 0;
	BOOLEAN foreclosure_flag := false;
	STRING8 last_foreclosure_date := '';

//Relatives
UNSIGNED1 relative_count;
	UNSIGNED1 relative_bankrupt_count;
	UNSIGNED1 relative_criminal_count;
	UNSIGNED1 relative_criminal_total;
	UNSIGNED1 relative_felony_count;
	UNSIGNED1 relative_felony_total;
	UNSIGNED1 criminal_relative_within25miles;
	UNSIGNED1 criminal_relative_within100miles;
	UNSIGNED1 criminal_relative_within500miles;
	UNSIGNED1 criminal_relative_withinOther;
	
	UNSIGNED1 owned_relatives_property_count;
	UNSIGNED1 owned_relatives_property_total;
	UNSIGNED5 owned_relatives_property_owned_purchase_total;
	UNSIGNED2 owned_relatives_property_owned_purchase_count;
	UNSIGNED5 owned_relatives_property_owned_assessed_total;
	UNSIGNED2 owned_relatives_property_owned_assessed_count;
	
	UNSIGNED1 sold_relatives_property_count;
	UNSIGNED1 sold_relatives_property_total;
	UNSIGNED5 sold_relatives_property_owned_purchase_total;
	UNSIGNED2 sold_relatives_property_owned_purchase_count;
	UNSIGNED5 sold_relatives_property_owned_assessed_total;
	UNSIGNED2 sold_relatives_property_owned_assessed_count;
	
	UNSIGNED1 ambiguous_relatives_property_count;
	UNSIGNED1 ambiguous_relatives_property_total;
	UNSIGNED5 ambiguous_relatives_property_owned_purchase_total;
	UNSIGNED2 ambiguous_relatives_property_owned_purchase_count;
	UNSIGNED5 ambiguous_relatives_property_owned_assessed_total;
	UNSIGNED2 ambiguous_relatives_property_owned_assessed_count;
	
	UNSIGNED1 relative_within25miles_count;
	UNSIGNED1 relative_within100miles_count;
	UNSIGNED1 relative_within500miles_count;
	UNSIGNED1 relative_withinOther_count;
	UNSIGNED1 relative_incomeUnder25_count;
	UNSIGNED1 relative_incomeUnder50_count;
	UNSIGNED1 relative_incomeUnder75_count;
	UNSIGNED1 relative_incomeUnder100_count;
	UNSIGNED1 relative_incomeOver100_count;
	UNSIGNED1 relative_homeUnder50_count;
	UNSIGNED1 relative_homeUnder100_count;
	UNSIGNED1 relative_homeUnder150_count;
	UNSIGNED1 relative_homeUnder200_count;
	UNSIGNED1 relative_homeUnder300_count;
	UNSIGNED1 relative_homeUnder500_count;
	UNSIGNED1 relative_homeOver500_count;
	UNSIGNED1 relative_educationUnder8_count;
	UNSIGNED1 relative_educationUnder12_count;
	UNSIGNED1 relative_educationOver12_count;
	UNSIGNED1 relative_ageUnder20_count;
	UNSIGNED1 relative_ageUnder30_count;
	UNSIGNED1 relative_ageUnder40_count;
	UNSIGNED1 relative_ageUnder50_count;
	UNSIGNED1 relative_ageUnder60_count;
	UNSIGNED1 relative_ageUnder70_count;
	UNSIGNED1 relative_ageOver70_count;
	unsigned1 relative_vehicle_owned_count;
	unsigned1 relatives_at_input_address;
	unsigned1 relative_suspicious_identities_count;
	unsigned1 relative_bureau_only_count;
	unsigned1 relative_bureau_only_count_created_1month;
	unsigned1 relative_bureau_only_count_created_6months;	

//ConsumerFlags	
boolean corrected_flag;
	boolean consumer_statement_flag;
	boolean dispute_flag;
	boolean security_freeze;
	boolean security_alert;
	boolean negative_alert;
	boolean id_theft_flag;	

//ADL_Shell_Flags
	integer1 in_addrpop := 0;  // was address populated on input from consumer
	integer1 in_hphnpop := 0;	// was hphone populated on input from consumer
	integer1 in_ssnpop := 0;		// was ssn populated on input from consumer
	integer1 in_dobpop := 0;		// was dob populated on input from consumer
	integer1 adl_addr := 0;  	// what do we know from the ADL search
	integer1 adl_hphn := 0;		// what do we know from the ADL search
	integer1 adl_ssn := 0;			// what do we know from the ADL search
	integer1 adl_dob := 0;			// what do we know from the ADL search
	integer1 in_addrpop_found := 0;	// was ssn populated on input from consumer and matched one of our database addresses
	integer1 in_hphnpop_found := 0;	// was hphone populated on input from consumer and matched one of our database phones

//Accident_Data
	unsigned1 acc_num_accidents;
	unsigned acc_dmgamtaccidents;
	unsigned acc_datelastaccident;
	unsigned acc_dmgamtlastaccident;
	unsigned1 acc_numaccidents30;
	unsigned1 acc_numaccidents90;
	unsigned1 acc_numaccidents180;
	unsigned1 acc_numaccidents12;
	unsigned1 acc_numaccidents24;
	unsigned1 acc_numaccidents36;
	unsigned1 acc_numaccidents60;
	
	unsigned1 atfault_num_accidents;
	unsigned atfault_dmgamtaccidents;
	unsigned atfault_datelastaccident;
	unsigned atfault_dmgamtlastaccident;
	unsigned1 atfault_numaccidents30;
	unsigned1 atfault_numaccidents90;
	unsigned1 atfault_numaccidents180;
	unsigned1 atfault_numaccidents12;
	unsigned1 atfault_numaccidents24;
	unsigned1 atfault_numaccidents36;
	unsigned1 atfault_numaccidents60;
	
	unsigned1 atfaultda_num_accidents;
	unsigned atfaultda_dmgamtaccidents;
	unsigned atfaultda_datelastaccident;
	unsigned atfaultda_dmgamtlastaccident;
	unsigned1 atfaultda_numaccidents30;
	unsigned1 atfaultda_numaccidents90;
	unsigned1 atfaultda_numaccidents180;
	unsigned1 atfaultda_numaccidents12;
	unsigned1 atfaultda_numaccidents24;
	unsigned1 atfaultda_numaccidents36;
	unsigned1 atfaultda_numaccidents60;


//SSN_Verification
	UNSIGNED1 ssn_score;
	UNSIGNED2 namePerSSN_count;
	UNSIGNED2 adlPerSSN_count;
	BOOLEAN credit_sourced;
	UNSIGNED3 credit_first_seen;
	UNSIGNED3 credit_last_seen;
	UNSIGNED1 header_count;
	UNSIGNED3 header_first_seen;
	UNSIGNED3 header_last_seen;
	BOOLEAN tu_sourced;
	BOOLEAN voter_sourced;
	BOOLEAN utility_sourced;
	BOOLEAN bk_sourced;
	BOOLEAN other_sourced;
	
// SSN_Verification	----Validation
	BOOLEAN deceased;
	unsigned4 deceasedDate;
	BOOLEAN valid;
	BOOLEAN issued;
	UNSIGNED4 high_issue_date;
	UNSIGNED4 low_issue_date;
	STRING2 issue_state;
	UNSIGNED1 dob_mismatch;
	string1 inputsocscharflag := '';
	string3 inputsocscode;
	
//advo_input_addr
	string1		advo_input_addr_Address_Vacancy_Indicator		;
	string1		advo_input_addr_Throw_Back_Indicator			;
	string1		advo_input_addr_Seasonal_Delivery_Indicator		;
	string1		advo_input_addr_DND_Indicator					;
	string1		advo_input_addr_College_Indicator				;
	string1		advo_input_addr_Drop_Indicator					;
	string1		advo_input_addr_Residential_or_Business_Ind		;
	string1		advo_input_addr_Mixed_Address_Usage				;
	//advo_addr_hist1
	string1		advo_addr_hist1_Address_Vacancy_Indicator		;
	string1		advo_addr_hist1_Throw_Back_Indicator			;
	string1		advo_addr_hist1_Seasonal_Delivery_Indicator		;
	string1		advo_addr_hist1_DND_Indicator					;
	string1		advo_addr_hist1_College_Indicator				;
	string1		advo_addr_hist1_Drop_Indicator					;
	string1		advo_addr_hist1_Residential_or_Business_Ind		;
	string1		advo_addr_hist1_Mixed_Address_Usage				;
	//advo_addr_hist2
	string1		advo_addr_hist2_Address_Vacancy_Indicator		;
	string1		advo_addr_hist2_Throw_Back_Indicator			;
	string1		advo_addr_hist2_Seasonal_Delivery_Indicator		;
	string1		advo_addr_hist2_DND_Indicator					;
	string1		advo_addr_hist2_College_Indicator				;
	string1		advo_addr_hist2_Drop_Indicator					;
	string1		advo_addr_hist2_Residential_or_Business_Ind		;
	string1		advo_addr_hist2_Mixed_Address_Usage				;

//email_summary
	integer email_ct := 0;
	integer email_domain_Free_ct := 0;
	integer email_domain_ISP_ct := 0;
	integer email_domain_EDU_ct := 0;
	integer email_domain_Corp_ct := 0;
	qstring50 email_source_list := '';
	qstring50 email_source_ct := '';
	qstring100 email_source_first_seen := '';
	string2 Identity_Email_Verification_Level := '';  // new field for 5.0
			//reverse_email
	string2 verification_level := ''; // -1 through 8																// new field for 5.0
	integer adls_per_email := 0;  // number of unique ADLs per email address				// new field for 5.0
	qstring100 email_summary_ver_sources := '';																											// new field for 5.0
	qstring200 email_summary_ver_sources_first_seen_date := '';																		// new field for 5.0
	qstring200 email_summary_ver_sources_last_seen_date := '';																		// new field for 5.0
	qstring100 email_summary_ver_sources_recordcount := '';																				// new field for 5.0
	


//iid
INTEGER1 NAS_Summary;
	INTEGER1 NAP_Summary;
	STRING1 NAP_Type;
	STRING1 NAP_Status;
	INTEGER1 CVI;
	// base reason codes to be used in custom scores
	string2 reason1 := '';
	string2 reason2 := '';
	string2 reason3 := '';
	string2 reason4 := '';
	string2 reason5 := '';
	string2 reason6 := '';
	unsigned1 DIDCount := 0;	// - The total number of DIDs found	
	unsigned6 DID2 := 0;	// - The second DID returned from the DID Append
	unsigned6 DID3 := 0;	// - The third DID returned from the DID Append
	STRING50 DID2_Sources := '';	// - RC_Sources for DID2
	STRING50 DID2_FNameSources := '';	// - FName_Sources for DID2
	STRING50 DID2_LNameSources := '';	// - LName_Sources for DID2
	STRING50 DID2_AddrSources := '';	// - Addr_Sources for DID2
	STRING50 DID2_SocsSources := '';	// - SSN_Sources for DID2
	unsigned3 DID2_CreditFirstSeen := 0;	// - Credit_First_Seen for DID2
	unsigned3 DID2_CreditLastSeen := 0;	// - Credit_Last_Seen for DID2
	unsigned3 DID2_HeaderFirstSeen := 0;	// - Header_First_Seen for DID2
	unsigned3 DID2_HeaderLastSeen := 0;	// - Header_Last_Seen for DID2
	unsigned1 did2_criminal_count;
	unsigned1 did2_felony_count;
	unsigned1 did2_liens_recent_unreleased_count;
	unsigned1 did2_liens_historical_unreleased_count;
	unsigned1 did2_liens_recent_released_count;
	unsigned1 did2_liens_historical_released_count;
	STRING50 DID3_Sources := '';	// - RC_Sources for DID3
	STRING50 DID3_FNameSources := '';	//  FName_Sources for DID3
	STRING50 DID3_LNameSources := '';	// - LName_Sources for DID3
	STRING50 DID3_AddrSources := '';	// - Addr_Sources for DID3
	STRING50 DID3_SocsSources := '';	// - SSN_Sources for DID3
	unsigned3 DID3_CreditFirstSeen := 0;	//  - Credit_First_Seen for DID3
	unsigned3 DID3_CreditLastSeen := 0;	// - Credit_Last_Seen for DID3
	unsigned3 DID3_HeaderFirstSeen := 0;	// - Header_First_Seen for DID3
	unsigned3 DID3_HeaderLastSeen := 0;	// - Header_Last_Seen for DID3
	unsigned1 did3_criminal_count;
	unsigned1 did3_felony_count;
	unsigned1 did3_liens_recent_unreleased_count;
	unsigned1 did3_liens_historical_unreleased_count;
	unsigned1 did3_liens_recent_released_count;
	unsigned1 did3_liens_historical_released_count;
	// fields to support reason code and follow-up action calculations
	boolean non_us_ssn := false;
	STRING1 hriskphoneflag := '';
	STRING1 hphonetypeflag := '';	 // pw hriskphoneflag
	STRING1 wphonetypeflag := '';  
	STRING1 phonevalflag := '';  
	STRING1 hphonevalflag := '';  // pw phonevalflag
	STRING1 wphonevalflag := '';
	STRING1 phonezipflag := '';
	STRING1 PWphonezipflag := '';  // pw phonezipflag
	BOOLEAN phonedissflag := false;
	BOOLEAN wphonedissflag := false;
	UNSIGNED1 phoneverlevel := 0;
	STRING1 phonever_type := '';
	STRING1 hriskaddrflag := '';
	STRING1 pullidflag := '';
	STRING1 decsflag := '';
	STRING1 socsdobflag := '';
	STRING1 PWsocsdobflag := '';
	STRING1 socsvalflag := '';
	STRING1 PWsocsvalflag := '';
	STRING1 socsRCISflag := '';
	STRING8 socllowissue := '';
	STRING8 soclhighissue := '';
	STRING2 soclstate := '';
	UNSIGNED1 socsverlevel := 0;
	STRING1 areacodesplitflag := '';
	STRING8 areacodesplitdate := '';
	STRING3 altareacode := '';
	STRING1 reverse_areacodesplitflag := '';
	STRING1 addrvalflag := '';
	STRING1 dwelltype := '';
	STRING1 bansflag := '';
// This section purely support Boca Shell
	STRING50 sources := '';
	UNSIGNED2 firstcount := 0;
	UNSIGNED2 lastcount := 0;
	UNSIGNED2 addrcount := 0;
	UNSIGNED2 wphonecount := 0;
	UNSIGNED2 socscount := 0;
	UNSIGNED2 numelever := 0;
	UNSIGNED2 phonefirstcount := 0;	// added for fname_eda_sourced_type testing
	UNSIGNED2 phonelastcount := 0;
	UNSIGNED2 phoneaddrcount := 0;
	UNSIGNED2 phonephonecount := 0;
	UNSIGNED2 phoneaddr_firstcount := 0;	// added for lname_eda_sourced_type testing
	UNSIGNED2 phoneaddr_lastcount := 0;
	UNSIGNED2 phoneaddr_addrcount := 0;
	UNSIGNED2 phoneaddr_phonecount := 0;
	UNSIGNED2 utiliaddr_lastcount := 0;
	UNSIGNED2 utiliaddr_addrcount := 0;
	UNSIGNED2 utiliaddr_phonecount := 0;
	STRING15 verfirst := '';
	STRING20 verlast := '';
	BOOLEAN socsmiskeyflag := false;
	BOOLEAN hphonemiskeyflag := false;
	BOOLEAN addrmiskeyflag := false;
	STRING1 addrcommflag := '';
	STRING6 hrisksic := '';
	STRING6 hrisksicphone := '';
	STRING30 hriskcmpy := '';
	STRING30 hriskcmpyphone := '';
	UNSIGNED3 disthphoneaddr := 0;
	UNSIGNED3 disthphonewphone := 0;
	UNSIGNED3 distwphoneaddr := 0;
	STRING8 correctdob := '';
	STRING9 correctssn := '';
	STRING10 correcthphone := '';
	STRING20 correctlast := '';
	STRING15 dirsfirst := '';
	STRING20 dirslast := '';
	string10 dirs_prim_range := '';
	string2  dirs_predir:= '';
	string28 dirs_prim_name:= '';
	string4  dirs_suffix:= '';
	string2  dirs_postdir:= '';
	string10 dirs_unit_desig:= '';
	string8  dirs_sec_range:= '';
	STRING30 dirscity := '';
	STRING2 dirsstate := '';
	STRING9 dirszip := '';
	STRING50 dirscmpy := '';
	STRING10 dirsaddr_phone := '';
	UNSIGNED1 dirsaddr_lastscore := 0;	
	STRING10 utiliphone := '';
	STRING1 phonetype := '';
	STRING1 ziptypeflag := '';  
	string1 zipclass := '';
	STRING2 drlcvalflag := '';
	STRING1 drlcsoundx := '';  // all these drlc soundex fields are actually flags
	STRING1 drlcfirst := '';
	STRING1 drlclast := '';
	STRING1 drlcmiddle := '';
	STRING1 drlcsocs := '';
	STRING1 drlcdob := '';
	STRING1 drlcgender := '';
	STRING1 statezipflag := '';
	STRING1 cityzipflag := '';
	
	string10 chronoprim_range := '';
	string2  chronopredir:= '';
	string28 chronoprim_name:= '';
	string4  chronosuffix:= '';
	string2  chronopostdir:= '';
	string10 chronounit_desig:= '';
	string8  chronosec_range:= '';
	STRING30 chronocity := '';
	STRING2 chronostate := '';
	STRING9 chronozip := '';
	STRING10 chronophone := '';
	UNSIGNED5 chronoActivePhone := 0;
	UNSIGNED1 chronoMatchLevel := 0;
	STRING50 chrono_sources := '';
	
// Risk_Indicators.Layouts.Layout_Addr_Flags chrono_addr_flags;

	string1 chrono_addr_flags_dwelltype := '';
	string1 chrono_addr_flags_valid := '';
	string1 chrono_addr_flags_prisonAddr := '';
	string1 chrono_addr_flags_highRisk := '';
	string1 chrono_addr_flags_corpMil := '';
	string1 chrono_addr_flags_doNotDeliver := '';
	string1 chrono_addr_flags_deliveryStatus := '';
	string1 chrono_addr_flags_addressType := '';
	string1 chrono_addr_flags_dropIndicator := '';
	
	string10 chronoprim_range2 := '';
	string2  chronopredir2 := '';
	string28 chronoprim_name2 := '';
	string4  chronosuffix2 := '';
	string2  chronopostdir2 := '';
	string10 chronounit_desig2 := '';
	string8  chronosec_range2 := '';
	STRING30 chronocity2 := '';
	STRING2 chronostate2 := '';
	STRING9 chronozip2 := '';
	STRING10 chronophone2 := '';
	UNSIGNED5 chronoActivePhone2 := 0;
	UNSIGNED1 chronoMatchLevel2 := 0;
	STRING50 chrono_sources2 := '';
	
	// Risk_Indicators.Layouts.Layout_Addr_Flags chrono_addr_flags2;
	
	string1 chrono_addr_flags2_dwelltype := '';
	string1 chrono_addr_flags2_valid := '';
	string1 chrono_addr_flags2_prisonAddr := '';
	string1 chrono_addr_flags2_highRisk := '';
	string1 chrono_addr_flags2_corpMil := '';
	string1 chrono_addr_flags2_doNotDeliver := '';
	string1 chrono_addr_flags2_deliveryStatus := '';
	string1 chrono_addr_flags2_addressType := '';
	string1 chrono_addr_flags2_dropIndicator := '';

	string10 chronoprim_range3 := '';
	string2  chronopredir3 := '';
	string28 chronoprim_name3 := '';
	string4  chronosuffix3 := '';
	string2  chronopostdir3 := '';
	string10 chronounit_desig3 := '';
	string8  chronosec_range3 := '';
	STRING30 chronocity3 := '';
	STRING2 chronostate3 := '';
	STRING9 chronozip3 := '';
	STRING10 chronophone3 := '';
	UNSIGNED5 chronoActivePhone3 := 0;
	UNSIGNED1 chronoMatchLevel3 := 0;
		STRING50 chrono_sources3 := '';
	
	//Risk_Indicators.Layouts.Layout_Addr_Flags chrono_addr_flags3;

	string1 chrono_addr_flags3_dwelltype := '';
	string1 chrono_addr_flags3_valid := '';
	string1 chrono_addr_flags3_prisonAddr := '';
	string1 chrono_addr_flags3_highRisk := '';
	string1 chrono_addr_flags3_corpMil := '';
	string1 chrono_addr_flags3_doNotDeliver := '';
	string1 chrono_addr_flags3_deliveryStatus := '';
	string1 chrono_addr_flags3_addressType := '';
	string1 chrono_addr_flags3_dropIndicator := '';

	
	UNSIGNED3 chronodate_first := 0;
	UNSIGNED3 chronodate_first2 := 0;
	UNSIGNED3 chronodate_first3 := 0;
	STRING20 altlast := '';
	STRING20 altlast2 := '';
	boolean altlastPop := false;
	boolean altlast2Pop := false;
	BOOLEAN lastssnmatch := true;
	BOOLEAN lastssnmatch2 := true;
	BOOLEAN firstssnmatch := true;
	BOOLEAN ssnexists := true;
	STRING15 combo_first := '';
	STRING20 combo_last := '';
	string10 combo_prim_range := '';
	string2  combo_predir:= '';
	string28 combo_prim_name:= '';
	string4  combo_suffix:= '';
	string2  combo_postdir:= '';
	string10 combo_unit_desig:= '';
	string8  combo_sec_range:= '';
	STRING30 combo_city := '';
	STRING2 combo_state := '';
	STRING9 combo_zip := '';
	STRING10 combo_hphone := '';
	STRING9 combo_ssn := '';
	STRING8 combo_dob := '';
	STRING50 combo_cmpy := '';
	UNSIGNED1 combo_firstscore := 0;
	UNSIGNED1 combo_lastscore := 0;
	UNSIGNED1 combo_addrscore := 0;
	UNSIGNED1 combo_sec_rangescore := 0;
	UNSIGNED1 combo_hphonescore := 0;
	UNSIGNED1 combo_ssnscore := 0;
	UNSIGNED1 combo_dobscore := 0;
	UNSIGNED1 combo_cmpyscore := 0;
	UNSIGNED1 combo_firstcount := 0;
	UNSIGNED1 combo_lastcount := 0;
	UNSIGNED1 combo_addrcount := 0;
	UNSIGNED1 combo_hphonecount := 0;
	UNSIGNED1 combo_ssncount := 0;
	UNSIGNED1 combo_dobcount := 0;
	UNSIGNED1 combo_cmpycount := 0;
	STRING60 watchlist_table := '';
	STRING10 watchlist_record_number := '';
	STRING20 watchlist_fname := '';
	STRING20 watchlist_lname := '';
	STRING50 watchlist_address := '';
	STRING30 watchlist_city := '';
	STRING2 watchlist_state := '';
	STRING9 watchlist_zip := '';
	BOOLEAN watchlistHit := false;
	STRING50 watchlist_entity_name := '';
	STRING30 wphonename := '';
	STRING50 wphoneaddr := '';
	STRING30 wphonecity := '';
	STRING2 wphonestate := '';
	STRING9 wphonezip := '';
	string10 name_addr_phone := '';
	boolean inputAddrNotMostRecent := false;
	string1 publish_code := '';
	string9 BestSSN := '';
	unsigned8 iid_flags := 0;
	boolean DL_searched := false;
	boolean any_DL_found := false;
	boolean dl_exists := false;
	unsigned1 DL_score := 255;
	string20 verified_DL := '';
	boolean IsShiptoBilltoDifferent := false;	// used for CBD check
	boolean EverAssocITIN := false;	// used for AML
	boolean EverAssocIm := false;		// used for AML
	BOOLEAN DIDdeceased := false;
	UNSIGNED4 DIDdeceasedDate := 0;
	UNSIGNED4 DIDdeceasedDOB := 0;
	STRING15 DIDdeceasedfirst := '';
	STRING20 DIDdeceasedlast := '';
	boolean targusgatewayused := false;
	string2 targustype := ''; // defined in Phones.Constants.TargusType

//liens

		unsigned1 liens_unreleased_civil_judgment_count;
	unsigned4 liens_unreleased_civil_judgment_earliest_filing_date;
	unsigned4 liens_unreleased_civil_judgment_most_recent_filing_date;
	unsigned liens_unreleased_civil_judgment_total_amount;
	
			unsigned1 liens_released_civil_judgment_count;
	unsigned4 liens_released_civil_judgment_earliest_filing_date;
	unsigned4 liens_released_civil_judgment_most_recent_filing_date;
	unsigned liens_released_civil_judgment_total_amount;
	
		unsigned1 liens_released_foreclosure_count;
	unsigned4 liens_released_foreclosure_earliest_filing_date;
	unsigned4 liens_released_foreclosure_most_recent_filing_date;
	unsigned liens_released_foreclosure_total_amount;
	
		unsigned1 liens_unreleased_federal_tax_count;
	unsigned4 liens_unreleased_federal_tax_earliest_filing_date;
	unsigned4 liens_unreleased_federal_tax_most_recent_filing_date;
	unsigned liens_unreleased_federal_tax_total_amount;
	
		unsigned1 liens_released_federal_tax_count;
	unsigned4 liens_released_federal_tax_earliest_filing_date;
	unsigned4 liens_released_federal_tax_most_recent_filing_date;
	unsigned liens_released_federal_tax_total_amount;
	
		unsigned1 liens_unreleased_foreclosure_count;
	unsigned4 liens_unreleased_foreclosure_earliest_filing_date;
	unsigned4 liens_unreleased_foreclosure_most_recent_filing_date;
	unsigned liens_unreleased_foreclosure_total_amount;

		unsigned1 liens_released_suits_count;
	unsigned4 liens_released_suits_earliest_filing_date;
	unsigned4 liens_released_suits_most_recent_filing_date;
	unsigned liens_released_suits_total_amount;
	
	
		unsigned1 liens_unreleased_suits_count;
	unsigned4 liens_unreleased_suits_earliest_filing_date;
	unsigned4 liens_unreleased_suits_most_recent_filing_date;
	unsigned liens_unreleased_suits_total_amount;
	
	
		unsigned1 liens_released_small_claims_count;
	unsigned4 liens_released_small_claims_earliest_filing_date;
	unsigned4 liens_released_small_claims_most_recent_filing_date;
	unsigned liens_released_small_claims_total_amount;
	
	
		unsigned1 liens_unreleased_small_claims_count;
	unsigned4 liens_unreleased_small_claims_earliest_filing_date;
	unsigned4 liens_unreleased_small_claims_most_recent_filing_date;
	unsigned liens_unreleased_small_claims_total_amount;
	
	
		unsigned1 liens_released_other_tax_count;
	unsigned4 liens_released_other_tax_earliest_filing_date;
	unsigned4 liens_released_other_tax_most_recent_filing_date;
	unsigned liens_released_other_tax_total_amount;
	
	unsigned1 liens_unreleased_other_tax_count;
	unsigned4 liens_unreleased_other_tax_earliest_filing_date;
	unsigned4 liens_unreleased_other_tax_most_recent_filing_date;
	unsigned liens_unreleased_other_tax_total_amount;
	
	
		unsigned1 liens_released_other_lj_count;
	unsigned4 liens_released_other_lj_earliest_filing_date;
	unsigned4 liens_released_other_lj_most_recent_filing_date;
	unsigned liens_released_other_lj_total_amount;
	
	
		unsigned1 liens_unreleased_other_lj_count;
	unsigned4 liens_unreleased_other_lj_earliest_filing_date;
	unsigned4 liens_unreleased_other_lj_most_recent_filing_date;
	unsigned liens_unreleased_other_lj_total_amount;
	
	
		unsigned1 liens_released_lispendens_count;
	unsigned4 liens_released_lispendens_earliest_filing_date;
	unsigned4 liens_released_lispendens_most_recent_filing_date;
	unsigned liens_released_lispendens_total_amount;
	
	
		unsigned1 liens_unreleased_lispendens_count;
	unsigned4 liens_unreleased_lispendens_earliest_filing_date;
	unsigned4 liens_unreleased_lispendens_most_recent_filing_date;
	unsigned liens_unreleased_lispendens_total_amount;
	
		unsigned1 liens_released_landlord_tenant_count;
	unsigned4 liens_released_landlord_tenant_earliest_filing_date;
	unsigned4 liens_released_landlord_tenant_most_recent_filing_date;
	unsigned liens_released_landlord_tenant_total_amount;
	
		unsigned1 liens_unreleased_landlord_tenant_count;
	unsigned4 liens_unreleased_landlord_tenant_earliest_filing_date;
	unsigned4 liens_unreleased_landlord_tenant_most_recent_filing_date;
	unsigned liens_unreleased_landlord_tenant_total_amount;

//Vehicles
UNSIGNED1 current_count;
UNSIGNED1 historical_count;
UNSIGNED2 Vehicle1_year_make;
STRING10 Vehicle1_make;		// TODO: type
STRING10 Vehicle1_model;	// TODO: type
BOOLEAN Vehicle1_title;
STRING25 Vehicle1_vin;
UNSIGNED2 Vehicle2_year_make;
STRING10 Vehicle2_make;		// TODO: type
STRING10 Vehicle2_model;	// TODO: type
BOOLEAN Vehicle2_title;
STRING25 Vehicle2_vin;
UNSIGNED2 Vehicle3_year_make;
STRING10 Vehicle3_make;		// TODO: type
STRING10 Vehicle3_model;	// TODO: type
BOOLEAN Vehicle3_title;
STRING25 Vehicle3_vin;


//header_summary
	qstring100 ver_sources := '';
	qstring100 ver_sources_NAS := '';  
	qstring200 ver_sources_first_seen_date := '';
	qstring200 ver_sources_max_first_seen_date := '';
	qstring200 ver_sources_last_seen_date := '';
	qstring100 ver_sources_recordcount := '';	
	qstring100 ver_fname_sources := '';
	qstring200 ver_fname_sources_first_seen_date := '';
	qstring100 ver_fname_sources_recordcount := '';	
	qstring100 ver_lname_sources := '';
	qstring200 ver_lname_sources_first_seen_date := '';
	qstring100 ver_lname_sources_recordcount := '';	
	qstring100 ver_addr_sources := '';
	qstring200 ver_addr_sources_first_seen_date := '';
	qstring100 ver_addr_sources_recordcount := '';	
	qstring100 ver_ssn_sources := '';
	qstring200 ver_ssn_sources_first_seen_date := '';
	qstring100 ver_ssn_sources_recordcount := '';		
	qstring100 ver_dob_sources := '';
	qstring200 ver_dob_sources_first_seen_date := '';
	qstring100 ver_dob_sources_recordcount := '';	
	qstring100 ssns_on_file := ''; // storing this internally for fraud velocity counters in shell version 5
	qstring100 dobs_on_file := '';
	qstring1200 streets_on_file := ''; 
	qstring120 phones_on_file := ''; 	
	qstring100 ssns_on_file_created12months := ''; 
	qstring100 dobs_on_file_created12months := '';
	qstring1200 streets_on_file_created12months := ''; 
	qstring120 phones_on_file_created12months := ''; 	
	unsigned2 ssn_name_source_count := 0;
	unsigned2 ssn_addr_source_count := 0;
	unsigned2 addr_name_source_count := 0;
	unsigned2 phone_addr_source_count := 0;
	unsigned2 phone_lname_source_count := 0;	
	boolean EQ_did_nlr := false;	// no longer reported by Bureau flags
	boolean EN_did_nlr := false;
	boolean TN_did_nlr := false;	
	boolean EQ_ssn_nlr := false;
	boolean EN_ssn_nlr := false;
	boolean TN_ssn_nlr := false;
	unsigned3 header_build_date;
	
//business_header_address_summary	
	integer bus_addr_match_cnt := 0;
	qstring100 bus_sources := '';
	qstring100 bus_sources_record_cnt :='';
	qstring200 bus_sources_first_seen_dates := '';
	integer bus_name_match := 0;
	integer bus_ssn_match := 0;
	integer bus_phone_match := 0;
	
//Address_Verification
	// Layouts.Layout_Address_Informationv3 Input_Address_Information;
		// same as v2 but with standardized_land_use_code, garage_type_code and style_code set to fixed lengths
		UNSIGNED3 Input_Address_Information_address_score;
	BOOLEAN Input_Address_Information_House_Number_match;
	BOOLEAN Input_Address_Information_isBestMatch;
	UNSIGNED4 Input_Address_Information_unit_count;
	decimal5_2 Input_Address_Information_geo12_fc_index;
	decimal5_2 Input_Address_Information_geo11_fc_index;
	decimal5_2 Input_Address_Information_fips_fc_index;
	UNSIGNED1 Input_Address_Information_source_count;
	string50 Input_Address_Information_sources;
	BOOLEAN Input_Address_Information_credit_sourced;
	BOOLEAN Input_Address_Information_eda_sourced;
	BOOLEAN Input_Address_Information_dl_sourced;
	BOOLEAN Input_Address_Information_voter_sourced;
	BOOLEAN Input_Address_Information_utility_sourced;
	BOOLEAN Input_Address_Information_applicant_owned;
	BOOLEAN Input_Address_Information_occupant_owned;
	BOOLEAN Input_Address_Information_family_owned;
	BOOLEAN Input_Address_Information_family_sold;
	BOOLEAN Input_Address_Information_applicant_sold;
	BOOLEAN Input_Address_Information_family_sale_found;
	BOOLEAN Input_Address_Information_family_buy_found;
	BOOLEAN Input_Address_Information_applicant_sale_found;
	BOOLEAN Input_Address_Information_applicant_buy_found;
	UNSIGNED1 Input_Address_Information_NAProp;
	UNSIGNED4 Input_Address_Information_purchase_date;
	UNSIGNED4 Input_Address_Information_built_date;
	UNSIGNED4 Input_Address_Information_purchase_amount;
	UNSIGNED4 Input_Address_Information_mortgage_amount;
	UNSIGNED4 Input_Address_Information_mortgage_date;
	string5   Input_Address_Information_mortgage_type;	
	string4   Input_Address_Information_type_financing;	
	string8   Input_Address_Information_first_td_due_date;	
	UNSIGNED4 Input_Address_Information_assessed_amount;
	UNSIGNED4 Input_Address_Information_assessed_total_value;
	UNSIGNED4 Input_Address_Information_date_first_seen;
	UNSIGNED4 Input_Address_Information_date_last_seen;
	string4 Input_Address_Information_standardized_land_use_code;
	unsigned Input_Address_Information_building_area ;
	unsigned Input_Address_Information_no_of_buildings ;
	unsigned Input_Address_Information_no_of_stories ;
	unsigned Input_Address_Information_no_of_rooms ;
	unsigned Input_Address_Information_no_of_bedrooms ;
	unsigned Input_Address_Information_no_of_baths;
	unsigned Input_Address_Information_no_of_partial_baths ;
	string3 Input_Address_Information_garage_type_code;
	unsigned Input_Address_Information_parking_no_of_cars;
	string5 Input_Address_Information_style_code;
	string4	Input_Address_Information_assessed_value_year;
	BOOLEAN Input_Address_Information_HR_Address;
	STRING100 Input_Address_Information_HR_Company;
	string10 Input_Address_Information_prim_range ;
	string2  Input_Address_Information_predir ;
	string28 Input_Address_Information_prim_name ;
	string4  Input_Address_Information_addr_suffix ;
	string2  Input_Address_Information_postdir ;
	string10 Input_Address_Information_unit_desig ;
	string8  Input_Address_Information_sec_range ;
	string25 Input_Address_Information_city_name ;
	string2  Input_Address_Information_st ;
	string5  Input_Address_Information_zip5 ;
	string3 Input_Address_Information_county;
	string7 Input_Address_Information_geo_blk;
	STRING10 Input_Address_Information_lat := '';
	STRING11 Input_Address_Information_long := '';
	string5  Input_Address_Information_census_age;// Layout_Census;
	string9  Input_Address_Information_census_income;// Layout_Census;
	string9  Input_Address_Information_census_home_value;// Layout_Census;
	string5  Input_Address_Information_census_education;// Layout_Census;
	boolean  Input_Address_Information_full_match;// Layout_Census;
	

		UNSIGNED1 owned_property_total;//	Layout_Applicant_Property_values;
	UNSIGNED5 owned_property_owned_purchase_total;//	Layout_Applicant_Property_values;
	UNSIGNED2 owned_property_owned_purchase_count;//	Layout_Applicant_Property_values;
	UNSIGNED5 owned_property_owned_assessed_total;//	Layout_Applicant_Property_values;
	UNSIGNED2 owned_property_owned_assessed_count;//	Layout_Applicant_Property_values;
	
	UNSIGNED1 sold_property_total;//	Layout_Applicant_Property_values;
	UNSIGNED5 sold_property_owned_purchase_total;//	Layout_Applicant_Property_values;
	UNSIGNED2 sold_property_owned_purchase_count;//	Layout_Applicant_Property_values;
	UNSIGNED5 sold_property_owned_assessed_total;//	Layout_Applicant_Property_values;
	UNSIGNED2 sold_property_owned_assessed_count;//	Layout_Applicant_Property_values;
	
	UNSIGNED1 ambiguous_property_total;//	Layout_Applicant_Property_values;
	UNSIGNED5 ambiguous_property_owned_purchase_total;//	Layout_Applicant_Property_values;
	UNSIGNED2 ambiguous_property_owned_purchase_count;//	Layout_Applicant_Property_values;
	UNSIGNED5 ambiguous_property_owned_assessed_total;//	Layout_Applicant_Property_values;
	UNSIGNED2 ambiguous_property_owned_assessed_count;//	Layout_Applicant_Property_values;

	
	
		unsigned sale_price1;//Layouts.Layout_Recent_Property_Sales Recent_Property_Sales;
	unsigned sale_date1;	//Layouts.Layout_Recent_Property_Sales Recent_Property_Sales;
	unsigned prev_purch_price1;//Layouts.Layout_Recent_Property_Sales Recent_Property_Sales;
	unsigned prev_purch_date1;//Layouts.Layout_Recent_Property_Sales Recent_Property_Sales;
	unsigned sale_price2;//Layouts.Layout_Recent_Property_Sales Recent_Property_Sales;
	unsigned sale_date2;//Layouts.Layout_Recent_Property_Sales Recent_Property_Sales;
	unsigned prev_purch_price2;//Layouts.Layout_Recent_Property_Sales Recent_Property_Sales;
	unsigned prev_purch_date2;//Layouts.Layout_Recent_Property_Sales Recent_Property_Sales;
	
	
	INTEGER distance_in_2_h1;
	INTEGER distance_in_2_h2;
	INTEGER distance_h1_2_h2;
	unsigned1 addr1addr2score;
	unsigned1 addr1addr3score;
	unsigned1 addr2addr3score;
	STRING1 addr_type2;
	STRING1 addr_type3;
	UNSIGNED1 edaMatchLevel;
	UNSIGNED5 activePhone;
	UNSIGNED1 edaMatchLevel2;
	UNSIGNED5 activePhone2;
	UNSIGNED1 edaMatchLevel3;
	UNSIGNED5 activePhone3;
	
	// Layouts.Layout_Address_Informationv3 Address_History_1;
	
		UNSIGNED3 Address_History_1_address_score;
	BOOLEAN Address_History_1_House_Number_match;
	BOOLEAN Address_History_1_isBestMatch;
	UNSIGNED4 Address_History_1_unit_count;
	decimal5_2 Address_History_1_geo12_fc_index;
	decimal5_2 Address_History_1_geo11_fc_index;
	decimal5_2 Address_History_1_fips_fc_index;
	UNSIGNED1 Address_History_1_source_count;
	string50 Address_History_1_sources;
	BOOLEAN Address_History_1_credit_sourced;
	BOOLEAN Address_History_1_eda_sourced;
	BOOLEAN Address_History_1_dl_sourced;
	BOOLEAN Address_History_1_voter_sourced;
	BOOLEAN Address_History_1_utility_sourced;
	BOOLEAN Address_History_1_applicant_owned;
	BOOLEAN Address_History_1_occupant_owned;
	BOOLEAN Address_History_1_family_owned;
	BOOLEAN Address_History_1_family_sold;
	BOOLEAN Address_History_1_applicant_sold;
	BOOLEAN Address_History_1_family_sale_found;
	BOOLEAN Address_History_1_family_buy_found;
	BOOLEAN Address_History_1_applicant_sale_found;
	BOOLEAN Address_History_1_applicant_buy_found;
	UNSIGNED1 Address_History_1_NAProp;
	UNSIGNED4 Address_History_1_purchase_date;
	UNSIGNED4 Address_History_1_built_date;
	UNSIGNED4 Address_History_1_purchase_amount;
	UNSIGNED4 Address_History_1_mortgage_amount;
	UNSIGNED4 Address_History_1_mortgage_date;
	string5   Address_History_1_mortgage_type;	
	string4   Address_History_1_type_financing;	
	string8   Address_History_1_first_td_due_date;	
	UNSIGNED4 Address_History_1_assessed_amount;
	UNSIGNED4 Address_History_1_assessed_total_value;
	UNSIGNED4 Address_History_1_date_first_seen;
	UNSIGNED4 Address_History_1_date_last_seen;
	string4 Address_History_1_standardized_land_use_code;
	unsigned Address_History_1_building_area ;
	unsigned Address_History_1_no_of_buildings ;
	unsigned Address_History_1_no_of_stories ;
	unsigned Address_History_1_no_of_rooms ;
	unsigned Address_History_1_no_of_bedrooms ;
	unsigned Address_History_1_no_of_baths;
	unsigned Address_History_1_no_of_partial_baths ;
	string3 Address_History_1_garage_type_code;
	unsigned Address_History_1_parking_no_of_cars;
	string5 Address_History_1_style_code;
	string4	Address_History_1_assessed_value_year;
	BOOLEAN Address_History_1_HR_Address;
	STRING100 Address_History_1_HR_Company;
	string10 Address_History_1_prim_range ;
	string2  Address_History_1_predir ;
	string28 Address_History_1_prim_name ;
	string4  Address_History_1_addr_suffix ;
	string2  Address_History_1_postdir ;
	string10 Address_History_1_unit_desig ;
	string8  Address_History_1_sec_range ;
	string25 Address_History_1_city_name ;
	string2  Address_History_1_st ;
	string5  Address_History_1_zip5 ;
	string3 Address_History_1_county;
	string7 Address_History_1_geo_blk;
	STRING10 Address_History_1_lat := '';
	STRING11 Address_History_1_long := '';
	string5  Address_History_1_census_age;// Layout_Census;
	string9  Address_History_1_census_income;// Layout_Census;
	string9  Address_History_1_census_home_value;// Layout_Census;
	string5  Address_History_1_census_education;// Layout_Census;
	boolean  Address_History_1_full_match;// Layout_Census;
	
	// Layouts.Layout_Address_Informationv3 Address_History_2;
		UNSIGNED3 Address_History_2_address_score;
	BOOLEAN Address_History_2_House_Number_match;
	BOOLEAN Address_History_2_isBestMatch;
	UNSIGNED4 Address_History_2_unit_count;
	decimal5_2 Address_History_2_geo12_fc_index;
	decimal5_2 Address_History_2_geo11_fc_index;
	decimal5_2 Address_History_2_fips_fc_index;
	UNSIGNED1 Address_History_2_source_count;
	string50 Address_History_2_sources;
	BOOLEAN Address_History_2_credit_sourced;
	BOOLEAN Address_History_2_eda_sourced;
	BOOLEAN Address_History_2_dl_sourced;
	BOOLEAN Address_History_2_voter_sourced;
	BOOLEAN Address_History_2_utility_sourced;
	BOOLEAN Address_History_2_applicant_owned;
	BOOLEAN Address_History_2_occupant_owned;
	BOOLEAN Address_History_2_family_owned;
	BOOLEAN Address_History_2_family_sold;
	BOOLEAN Address_History_2_applicant_sold;
	BOOLEAN Address_History_2_family_sale_found;
	BOOLEAN Address_History_2_family_buy_found;
	BOOLEAN Address_History_2_applicant_sale_found;
	BOOLEAN Address_History_2_applicant_buy_found;
	UNSIGNED1 Address_History_2_NAProp;
	UNSIGNED4 Address_History_2_purchase_date;
	UNSIGNED4 Address_History_2_built_date;
	UNSIGNED4 Address_History_2_purchase_amount;
	UNSIGNED4 Address_History_2_mortgage_amount;
	UNSIGNED4 Address_History_2_mortgage_date;
	string5   Address_History_2_mortgage_type;	
	string4   Address_History_2_type_financing;	
	string8   Address_History_2_first_td_due_date;	
	UNSIGNED4 Address_History_2_assessed_amount;
	UNSIGNED4 Address_History_2_assessed_total_value;
	UNSIGNED4 Address_History_2_date_first_seen;
	UNSIGNED4 Address_History_2_date_last_seen;
	string4 Address_History_2_standardized_land_use_code;
	unsigned Address_History_2_building_area ;
	unsigned Address_History_2_no_of_buildings ;
	unsigned Address_History_2_no_of_stories ;
	unsigned Address_History_2_no_of_rooms ;
	unsigned Address_History_2_no_of_bedrooms ;
	unsigned Address_History_2_no_of_baths;
	unsigned Address_History_2_no_of_partial_baths ;
	string3 Address_History_2_garage_type_code;
	unsigned Address_History_2_parking_no_of_cars;
	string5 Address_History_2_style_code;
	string4	Address_History_2_assessed_value_year;
	BOOLEAN Address_History_2_HR_Address;
	STRING100 Address_History_2_HR_Company;
	string10 Address_History_2_prim_range ;
	string2  Address_History_2_predir ;
	string28 Address_History_2_prim_name ;
	string4  Address_History_2_addr_suffix ;
	string2  Address_History_2_postdir ;
	string10 Address_History_2_unit_desig ;
	string8  Address_History_2_sec_range ;
	string25 Address_History_2_city_name ;
	string2  Address_History_2_st ;
	string5  Address_History_2_zip5 ;
	string3 Address_History_2_county;
	string7 Address_History_2_geo_blk;
	STRING10 Address_History_2_lat := '';
	STRING11 Address_History_2_long := '';
	string5  Address_History_2_census_age;// Layout_Census;
	string9  Address_History_2_census_income;// Layout_Census;
	string9  Address_History_2_census_home_value;// Layout_Census;
	string5  Address_History_2_census_education;// Layout_Census;
	boolean  Address_History_2_full_match;// Layout_Census;

	// Layouts.Layout_Addr_Flags Addr_Flags_1;
		string1 Addr_Flags_1_dwelltype := '';
	string1 Addr_Flags_1_valid := '';
	string1 Addr_Flags_1_prisonAddr := '';
	string1 Addr_Flags_1_highRisk := '';
	string1 Addr_Flags_1_corpMil := '';
	string1 Addr_Flags_1_doNotDeliver := '';
	string1 Addr_Flags_1_deliveryStatus := '';
	string1 Addr_Flags_1_addressType := '';
	string1 Addr_Flags_1_dropIndicator := '';
	
	// Layouts.Layout_Addr_Flags Addr_Flags_2;
		string1 Addr_Flags_2_dwelltype := '';
	string1 Addr_Flags_2_valid := '';
	string1 Addr_Flags_2_prisonAddr := '';
	string1 Addr_Flags_2_highRisk := '';
	string1 Addr_Flags_2_corpMil := '';
	string1 Addr_Flags_2_doNotDeliver := '';
	string1 Addr_Flags_2_deliveryStatus := '';
	string1 Addr_Flags_2_addressType := '';
	string1 Addr_Flags_2_dropIndicator := '';
	
	boolean inputAddr_dirty := false;
	boolean inputAddr_not_verified := false;
	boolean inputAddr_owned_not_occupied := false;
	integer1 inputAddr_non_relative_DID_count := 0;
	integer1 inputAddr_occupancy_index := 0;
	integer1 currAddr_occupancy_index := 0;
	integer1 address_verification_unverified_addr_count := 0;
	
end;


// bs_cert := dataset(filename, lay, CSV(QUOTE('"')));

// bs_cert_choosen := choosen(filename, 10);
bs_cert_choosen := filename;

pj := project(bs_cert_choosen, TRANSFORM(lay1,

//business_header_address_summary
																	self.bus_addr_match_cnt := left.business_header_address_summary.bus_addr_match_cnt;
																	self.bus_sources := left.business_header_address_summary.bus_sources;
																	self.bus_sources_record_cnt := left.business_header_address_summary.bus_sources_record_cnt;
																	self.bus_sources_first_seen_dates := left.business_header_address_summary.bus_sources_first_seen_dates;
																	self.bus_name_match := left.business_header_address_summary.bus_name_match;
																	self.bus_ssn_match := left.business_header_address_summary.bus_ssn_match;
																	self.bus_phone_match := left.business_header_address_summary.bus_phone_match;

//header_summary
																	self.header_build_date := left.header_summary.header_build_date;
																	self.TN_ssn_nlr := left.header_summary.TN_ssn_nlr;
																	self.EN_ssn_nlr := left.header_summary.EN_ssn_nlr;
																	self.EQ_ssn_nlr := left.header_summary.EQ_ssn_nlr;
																	self.TN_did_nlr := left.header_summary.TN_did_nlr;
																	self.EN_did_nlr := left.header_summary.EN_did_nlr;
																	self.EQ_did_nlr := left.header_summary.EQ_did_nlr;
																	self.phone_lname_source_count := left.header_summary.phone_lname_source_count;
																	self.phone_addr_source_count := left.header_summary.phone_addr_source_count;																	
																	self.addr_name_source_count := left.header_summary.addr_name_source_count;
																	self.ssn_addr_source_count := left.header_summary.ssn_addr_source_count;
																	self.ssn_name_source_count := left.header_summary.ssn_name_source_count;
																	self.phones_on_file_created12months := left.header_summary.phones_on_file_created12months;
																	self.streets_on_file_created12months := left.header_summary.streets_on_file_created12months;
																	self.dobs_on_file_created12months := left.header_summary.dobs_on_file_created12months;
																	self.ssns_on_file_created12months := left.header_summary.ssns_on_file_created12months;
																	self.phones_on_file := left.header_summary.phones_on_file;
																	self.streets_on_file := left.header_summary.streets_on_file;		
																	self.dobs_on_file := left.header_summary.dobs_on_file;
																	self.ssns_on_file := left.header_summary.ssns_on_file;
																	self.ver_dob_sources_recordcount := left.header_summary.ver_dob_sources_recordcount;
																	self.ver_dob_sources_first_seen_date := left.header_summary.ver_dob_sources_first_seen_date;
																	self.ver_dob_sources := left.header_summary.ver_dob_sources;
																	self.ver_ssn_sources_recordcount := left.header_summary.ver_ssn_sources_recordcount;
																	self.ver_ssn_sources_first_seen_date := left.header_summary.ver_ssn_sources_first_seen_date;
																	self.ver_ssn_sources := left.header_summary.ver_ssn_sources;
																	self.ver_addr_sources_recordcount := left.header_summary.ver_addr_sources_recordcount;																	
																	self.ver_addr_sources_first_seen_date := left.header_summary.ver_addr_sources_first_seen_date;
																	self.ver_addr_sources := left.header_summary.ver_addr_sources;
																	self.ver_lname_sources_recordcount := left.header_summary.ver_lname_sources_recordcount;
																	self.ver_lname_sources_first_seen_date := left.header_summary.ver_lname_sources_first_seen_date;
																	self.ver_lname_sources := left.header_summary.ver_lname_sources;
																	self.ver_fname_sources_recordcount := left.header_summary.ver_fname_sources_recordcount;
																	self.ver_fname_sources_first_seen_date := left.header_summary.ver_fname_sources_first_seen_date;
																	self.ver_fname_sources := left.header_summary.ver_fname_sources;
																	self.ver_sources_recordcount := left.header_summary.ver_sources_recordcount;																	
																	self.ver_sources_last_seen_date := left.header_summary.ver_sources_last_seen_date;
																	self.ver_sources_max_first_seen_date := left.header_summary.ver_sources_max_first_seen_date;
																	self.ver_sources_first_seen_date := left.header_summary.ver_sources_first_seen_date;
																	self.ver_sources_NAS := left.header_summary.ver_sources_NAS;
																	self.ver_sources := left.header_summary.ver_sources;


//Vehicle
																		self.Vehicle3_vin := left.Vehicles.Vehicle3.vin;
																	self.Vehicle3_title := left.Vehicles.Vehicle3.title;
																	self.Vehicle3_model := left.Vehicles.Vehicle3.model;
																	self.Vehicle3_make := left.Vehicles.Vehicle3.make;
																	self.Vehicle3_year_make := left.Vehicles.Vehicle3.year_make;																	
																	self.Vehicle2_vin := left.Vehicles.Vehicle2.vin;
																	self.Vehicle2_title := left.Vehicles.Vehicle2.title;
																	self.Vehicle2_model := left.Vehicles.Vehicle2.model;
																	self.Vehicle2_make := left.Vehicles.Vehicle2.make;
																	self.Vehicle2_year_make := left.Vehicles.Vehicle2.year_make;																	
																	self.Vehicle1_vin := left.Vehicles.Vehicle1.vin;
																	self.Vehicle1_title := left.Vehicles.Vehicle1.title;
																	self.Vehicle1_model := left.Vehicles.Vehicle1.model;
																	self.Vehicle1_make := left.Vehicles.Vehicle1.make;
																	self.Vehicle1_year_make := left.Vehicles.Vehicle1.year_make;																	
																	self.current_count := left.Vehicles.current_count;
																	self.historical_count := left.Vehicles.historical_count;
																	
//Shell_input
																		self.lname_prev := left.Shell_input.lname_prev;
																	self.employer_name := left.Shell_input.employer_name;
																	self.wphone10 := left.Shell_input.wphone10;
																	self.Shell_input_phone10 := left.Shell_input.phone10;
																	self.ip_address := left.Shell_input.ip_address;
																	self.email_address := left.Shell_input.email_address;
																	self.dl_state := left.Shell_input.dl_state;
																	self.dl_number := left.Shell_input.dl_number;
																	self.Shell_input_age := left.Shell_input.age;
																	
																	self.dob := left.Shell_input.dob;
																	self.Shell_input_ssn := left.Shell_input.ssn;
																	self.country := left.Shell_input.country;
																	self.addr_status := left.Shell_input.addr_status;
																	self.addr_type := left.Shell_input.addr_type;
																	self.geo_blk := left.Shell_input.geo_blk;
																	self.county := left.Shell_input.county;
																	self.long := left.Shell_input.long;
																	self.lat := left.Shell_input.lat;

																	self.zip4 := left.Shell_input.zip4;
																	self.z5 := left.Shell_input.z5;
																	self.st := left.Shell_input.st;
																	self.p_city_name := left.Shell_input.p_city_name;
																	self.sec_range := left.Shell_input.sec_range;
																	self.unit_desig := left.Shell_input.unit_desig;
																	self.postdir := left.Shell_input.postdir;
																	self.addr_suffix := left.Shell_input.addr_suffix;
																	
																	self.prim_name := left.Shell_input.prim_name;
																	self.predir := left.Shell_input.predir;
																	self.prim_range := left.Shell_input.prim_range;
																	self.in_country := left.Shell_input.in_country;
																	self.in_zipCode := left.Shell_input.in_zipCode;
																	self.in_state := left.Shell_input.in_state;
																	self.in_city := left.Shell_input.in_city;
																	self.in_streetAddress := left.Shell_input.in_streetAddress;
																	self.suffix := left.Shell_input.suffix;
																	
																	self.lname := left.Shell_input.lname;
																	self.mname := left.Shell_input.mname;
																	self.fname := left.Shell_input.fname;
																	self.title := left.Shell_input.title;
																	self.score := left.Shell_input.score;
																	self.Shell_input_DID := left.Shell_input.DID;
																	self.Shell_input_seq := left.Shell_input.seq;
	
	
//acc_logs

																	self.Inquiry_email_ver_ct := left.acc_logs.Inquiry_email_ver_ct;
																	self.Inquiry_phone_ver_ct := left.acc_logs.Inquiry_phone_ver_ct;
																	self.Inquiry_dob_ver_ct := left.acc_logs.Inquiry_dob_ver_ct;
																	self.Inquiry_ssn_ver_ct := left.acc_logs.Inquiry_ssn_ver_ct;
																	self.Inquiry_lname_ver_ct := left.acc_logs.Inquiry_lname_ver_ct;
																	self.Inquiry_fname_ver_ct := left.acc_logs.Inquiry_fname_ver_ct;
																	self.Inquiry_addr_ver_ct := left.acc_logs.Inquiry_addr_ver_ct;
																	self.last_log_date := left.acc_logs.last_log_date;											
																	self.first_log_date := left.acc_logs.first_log_date;
		
																	self.cbd_inquiryPhonesPerADL := left.acc_logs.cbd_inquiryPhonesPerADL;
																	self.cbd_inquiryADLsPerAddr := left.acc_logs.cbd_inquiryADLsPerAddr;
																	self.cbd_inquiryAddrsPerADL := left.acc_logs.cbd_inquiryAddrsPerADL;
																	self.cbd_last_log_date := left.acc_logs.cbd_last_log_date;
																	self.cbd_first_log_date := left.acc_logs.cbd_first_log_date;
																	self.noncbd_last_log_date := left.acc_logs.noncbd_last_log_date;
																	self.noncbd_first_log_date := left.acc_logs.noncbd_first_log_date;
																	self.om_last_seen_date := left.acc_logs.om_last_seen_date;											
																	self.om_first_seen_date := left.acc_logs.om_first_seen_date;
																	self.cm_last_seen_date := left.acc_logs.cm_last_seen_date;
																	self.cm_first_seen_date := left.acc_logs.cm_first_seen_date;
																	self.am_last_seen_date := left.acc_logs.am_last_seen_date;
																	self.am_first_seen_date := left.acc_logs.am_first_seen_date;
																	self.inquiryADLsPerEmail := left.acc_logs.inquiryADLsPerEmail;
																	self.fraudSearchInquiryPerPhoneDay := left.acc_logs.fraudSearchInquiryPerPhoneDay;
																	self.fraudSearchInquiryPerPhoneWeek := left.acc_logs.fraudSearchInquiryPerPhoneWeek;
																	self.fraudSearchInquiryPerPhoneMonth := left.acc_logs.fraudSearchInquiryPerPhoneMonth;
																	self.fraudSearchInquiryPerPhoneYear := left.acc_logs.fraudSearchInquiryPerPhoneYear;
																	self.fraudSearchInquiryPerPhone := left.acc_logs.fraudSearchInquiryPerPhone;
																	self.inquiryADLsPerPhone := left.acc_logs.inquiryADLsPerPhone;
																	self.inquiryPerPhone := left.acc_logs.inquiryPerPhone;
																	self.inquirySuspciousADLsperAddr := left.acc_logs.inquirySuspciousADLsperAddr;
																	self.fraudSearchInquiryPerAddrDay := left.acc_logs.fraudSearchInquiryPerAddrDay;
																	self.fraudSearchInquiryPerAddrWeek := left.acc_logs.fraudSearchInquiryPerAddrWeek;											
																	self.fraudSearchInquiryPerAddrMonth := left.acc_logs.fraudSearchInquiryPerAddrMonth;
																	self.fraudSearchInquiryPerAddrYear := left.acc_logs.fraudSearchInquiryPerAddrYear;
																	self.fraudSearchInquiryPerAddr := left.acc_logs.fraudSearchInquiryPerAddr;
																	self.inquirySSNsPerAddr := left.acc_logs.inquirySSNsPerAddr;
																	self.inquiryLNamesPerAddr := left.acc_logs.inquiryLNamesPerAddr;
																	self.inquiryADLsPerAddr := left.acc_logs.inquiryADLsPerAddr;
																	self.inquiryPerAddr := left.acc_logs.inquiryPerAddr;										
																	self.fraudSearchInquiryPerSSNDay := left.acc_logs.fraudSearchInquiryPerSSNDay;
																	self.fraudSearchInquiryPerSSNWeek := left.acc_logs.fraudSearchInquiryPerSSNWeek;
																	self.fraudSearchInquiryPerSSNMonth := left.acc_logs.fraudSearchInquiryPerSSNMonth;
																	self.fraudSearchInquiryPerSSNYear := left.acc_logs.fraudSearchInquiryPerSSNYear;
																	self.fraudSearchInquiryPerSSN := left.acc_logs.fraudSearchInquiryPerSSN;
																	self.inquiryDOBsPerSSN := left.acc_logs.inquiryDOBsPerSSN;
																	self.inquiryAddrsPerSSN := left.acc_logs.inquiryAddrsPerSSN;
																	self.inquiryLNamesPerSSN := left.acc_logs.inquiryLNamesPerSSN;											
																	self.inquiryADLsPerSSN := left.acc_logs.inquiryADLsPerSSN;
																	self.inquiryPerSSN := left.acc_logs.inquiryPerSSN;
																	self.inquiryemailsperADL := left.acc_logs.inquiryemailsperADL;
																	self.unverifiedDOBsPerADL := left.acc_logs.unverifiedDOBsPerADL;
																	self.unverifiedPhonesPerADL := left.acc_logs.unverifiedPhonesPerADL;
																	self.unverifiedAddrsPerADL := left.acc_logs.unverifiedAddrsPerADL;
																	self.unverifiedSSNsPerADL := left.acc_logs.unverifiedSSNsPerADL;	
																	self.inquiryDOBsPerADL := left.acc_logs.inquiryDOBsPerADL;
																	self.inquiryPhonesPerADL := left.acc_logs.inquiryPhonesPerADL;
																	self.inquiryFnamesPerADL := left.acc_logs.inquiryFnamesPerADL;
																	self.inquiryLnamesPerADL := left.acc_logs.inquiryLnamesPerADL;
																	self.inquiryAddrsPerADL := left.acc_logs.inquiryAddrsPerADL;
																	self.inquirySSNsPerADL := left.acc_logs.inquirySSNsPerADL;
																	self.inquiryPerADL := left.acc_logs.inquiryPerADL;
																	self.Inq_BillGroup_count24 := left.acc_logs.Inq_BillGroup_count24;											
																	self.Inq_BillGroup_count12 := left.acc_logs.Inq_BillGroup_count12;
																	self.Inq_BillGroup_count06 := left.acc_logs.Inq_BillGroup_count06;
																	self.Inq_BillGroup_count03 := left.acc_logs.Inq_BillGroup_count03;
																	self.Inq_BillGroup_count01 := left.acc_logs.Inq_BillGroup_count01;
																	self.Inq_BillGroup_count := left.acc_logs.Inq_BillGroup_count;
																	
																	self.Utilities_CBDCount01 := left.acc_logs.Utilities.CBDCount01;
																	self.Utilities_CBDCountTotal := left.acc_logs.Utilities.CBDCountTotal;
																	self.Utilities_Count24 := left.acc_logs.Utilities.Count24;
																	self.Utilities_Count12 := left.acc_logs.Utilities.Count12;
																	self.Utilities_Count06 := left.acc_logs.Utilities.Count06;
																	self.Utilities_Count03 := left.acc_logs.Utilities.Count03;
																	self.Utilities_Count01 := left.acc_logs.Utilities.Count01;
																	self.Utilities_CountWeek := left.acc_logs.Utilities.CountWeek;
																	self.Utilities_CountDay := left.acc_logs.Utilities.CountDay;
																	self.Utilities_CountTotal := left.acc_logs.Utilities.CountTotal;
																	
																	self.StudentLoans_CBDCount01 := left.acc_logs.StudentLoans.CBDCount01;
																	self.StudentLoans_CBDCountTotal := left.acc_logs.StudentLoans.CBDCountTotal;
																	self.StudentLoans_Count24 := left.acc_logs.StudentLoans.Count24;
																	self.StudentLoans_Count12 := left.acc_logs.StudentLoans.Count12;
																	self.StudentLoans_Count06 := left.acc_logs.StudentLoans.Count06;
																	self.StudentLoans_Count03 := left.acc_logs.StudentLoans.Count03;
																	self.StudentLoans_Count01 := left.acc_logs.StudentLoans.Count01;
																	self.StudentLoans_CountWeek := left.acc_logs.StudentLoans.CountWeek;
																	self.StudentLoans_CountDay := left.acc_logs.StudentLoans.CountDay;
																	self.StudentLoans_CountTotal := left.acc_logs.StudentLoans.CountTotal;
													
																	
																	self.retailPayments_CBDCount01 := left.acc_logs.retailPayments.CBDCount01;
																	self.retailPayments_CBDCountTotal := left.acc_logs.retailPayments.CBDCountTotal;
																	self.retailPayments_Count24 := left.acc_logs.retailPayments.Count24;
																	self.retailPayments_Count12 := left.acc_logs.retailPayments.Count12;
																	self.retailPayments_Count06 := left.acc_logs.retailPayments.Count06;
																	self.retailPayments_Count03 := left.acc_logs.retailPayments.Count03;
																	self.retailPayments_Count01 := left.acc_logs.retailPayments.Count01;
																	self.retailPayments_CountWeek := left.acc_logs.retailPayments.CountWeek;
																	self.retailPayments_CountDay := left.acc_logs.retailPayments.CountDay;
																	self.retailPayments_CountTotal := left.acc_logs.retailPayments.CountTotal;
																	
																	self.QuizProvider_CBDCount01 := left.acc_logs.QuizProvider.CBDCount01;
																	self.QuizProvider_CBDCountTotal := left.acc_logs.QuizProvider.CBDCountTotal;
																	self.QuizProvider_Count24 := left.acc_logs.QuizProvider.Count24;
																	self.QuizProvider_Count12 := left.acc_logs.QuizProvider.Count12;
																	self.QuizProvider_Count06 := left.acc_logs.QuizProvider.Count06;
																	self.QuizProvider_Count03 := left.acc_logs.QuizProvider.Count03;
																	self.QuizProvider_Count01 := left.acc_logs.QuizProvider.Count01;
																	self.QuizProvider_CountWeek := left.acc_logs.QuizProvider.CountWeek;
																	self.QuizProvider_CountDay := left.acc_logs.QuizProvider.CountDay;
																	self.QuizProvider_CountTotal := left.acc_logs.QuizProvider.CountTotal;
																	
																	self.prepaidCards_CBDCount01 := left.acc_logs.prepaidCards.CBDCount01;
																	self.prepaidCards_CBDCountTotal := left.acc_logs.prepaidCards.CBDCountTotal;
																	self.prepaidCards_Count24 := left.acc_logs.prepaidCards.Count24;
																	self.prepaidCards_Count12 := left.acc_logs.prepaidCards.Count12;
																	self.prepaidCards_Count06 := left.acc_logs.prepaidCards.Count06;
																	self.prepaidCards_Count03 := left.acc_logs.prepaidCards.Count03;
																	self.prepaidCards_Count01 := left.acc_logs.prepaidCards.Count01;
																	self.prepaidCards_CountWeek := left.acc_logs.prepaidCards.CountWeek;
																	self.prepaidCards_CountDay := left.acc_logs.prepaidCards.CountDay;
																	self.prepaidCards_CountTotal := left.acc_logs.prepaidCards.CountTotal;


																  self.Other_CBDCount01 := left.acc_logs.Other.CBDCount01;
																	self.Other_CBDCountTotal := left.acc_logs.Other.CBDCountTotal;
																	self.Other_Count24 := left.acc_logs.Other.Count24;
																	self.Other_Count12 := left.acc_logs.Other.Count12;
																	self.Other_Count06 := left.acc_logs.Other.Count06;
																	self.Other_Count03 := left.acc_logs.Other.Count03;
																	self.Other_Count01 := left.acc_logs.Other.Count01;
																	self.Other_CountWeek := left.acc_logs.Other.CountWeek;
																	self.Other_CountDay := left.acc_logs.Other.CountDay;
																	self.Other_CountTotal := left.acc_logs.Other.CountTotal;
																	
																	self.FraudSearches_Count24 := left.acc_logs.FraudSearches.Count24;
																	self.FraudSearches_Count12 := left.acc_logs.FraudSearches.Count12;
																	self.FraudSearches_Count06 := left.acc_logs.FraudSearches.Count06;
																	self.FraudSearches_Count03 := left.acc_logs.FraudSearches.Count03;
																	self.FraudSearches_Count01 := left.acc_logs.FraudSearches.Count01;
																	self.FraudSearches_CountWeek := left.acc_logs.FraudSearches.CountWeek;
																	self.FraudSearches_CountDay := left.acc_logs.FraudSearches.CountDay;
																	self.FraudSearches_CountTotal := left.acc_logs.FraudSearches.CountTotal;
																	
																	 self.Communications_CBDCount01 := left.acc_logs.Communications.CBDCount01;
																	self.Communications_CBDCountTotal := left.acc_logs.Communications.CBDCountTotal;
																	self.Communications_Count24 := left.acc_logs.Communications.Count24;
																	self.Communications_Count12 := left.acc_logs.Communications.Count12;
																	self.Communications_Count06 := left.acc_logs.Communications.Count06;
																	self.Communications_Count03 := left.acc_logs.Communications.Count03;
																	self.Communications_Count01 := left.acc_logs.Communications.Count01;
																	self.Communications_CountWeek := left.acc_logs.Communications.CountWeek;
																	self.Communications_CountDay := left.acc_logs.Communications.CountDay;
																	self.Communications_CountTotal := left.acc_logs.Communications.CountTotal;
																	
																	 self.Retail_CBDCount01 := left.acc_logs.Retail.CBDCount01;
																	self.Retail_CBDCountTotal := left.acc_logs.Retail.CBDCountTotal;
																	self.Retail_Count24 := left.acc_logs.Retail.Count24;
																	self.Retail_Count12 := left.acc_logs.Retail.Count12;
																	self.Retail_Count06 := left.acc_logs.Retail.Count06;
																	self.Retail_Count03 := left.acc_logs.Retail.Count03;
																	self.Retail_Count01 := left.acc_logs.Retail.Count01;
																	self.Retail_CountWeek := left.acc_logs.Retail.CountWeek;
																	self.Retail_CountDay := left.acc_logs.Retail.CountDay;
																	self.Retail_CountTotal := left.acc_logs.Retail.CountTotal;
																	
																	self.Inquiries_CBDCount01 := left.acc_logs.Inquiries.CBDCount01;
																	self.Inquiries_CBDCountTotal := left.acc_logs.Inquiries.CBDCountTotal;
																	self.Inquiries_Count24 := left.acc_logs.Inquiries.Count24;
																	self.Inquiries_Count12 := left.acc_logs.Inquiries.Count12;
																	self.Inquiries_Count06 := left.acc_logs.Inquiries.Count06;
																	self.Inquiries_Count03 := left.acc_logs.Inquiries.Count03;
																	self.Inquiries_Count01 := left.acc_logs.Inquiries.Count01;
																	self.Inquiries_CountWeek := left.acc_logs.Inquiries.CountWeek;
																	self.Inquiries_CountDay := left.acc_logs.Inquiries.CountDay;
																	self.Inquiries_CountTotal := left.acc_logs.Inquiries.CountTotal;
																	
																	 self.Collection_CBDCount01 := left.acc_logs.Collection.CBDCount01;
																	self.Collection_CBDCountTotal := left.acc_logs.Collection.CBDCountTotal;
																	self.Collection_Count24 := left.acc_logs.Collection.Count24;
																	self.Collection_Count12 := left.acc_logs.Collection.Count12;
																	self.Collection_Count06 := left.acc_logs.Collection.Count06;
																	self.Collection_Count03 := left.acc_logs.Collection.Count03;
																	self.Collection_Count01 := left.acc_logs.Collection.Count01;
																	self.Collection_CountWeek := left.acc_logs.Collection.CountWeek;
																	self.Collection_CountDay := left.acc_logs.Collection.CountDay;
																	self.Collection_CountTotal := left.acc_logs.Collection.CountTotal;
																	
																	self.Auto_CBDCount01 := left.acc_logs.Auto.CBDCount01;
																	self.Auto_CBDCountTotal := left.acc_logs.Auto.CBDCountTotal;
																	self.Auto_Count24 := left.acc_logs.Auto.Count24;
																	self.Auto_Count12 := left.acc_logs.Auto.Count12;
																	self.Auto_Count06 := left.acc_logs.Auto.Count06;
																	self.Auto_Count03 := left.acc_logs.Auto.Count03;
																	self.Auto_Count01 := left.acc_logs.Auto.Count01;
																	self.Auto_CountWeek := left.acc_logs.Auto.CountWeek;
																	self.Auto_CountDay := left.acc_logs.Auto.CountDay;
																	self.Auto_CountTotal := left.acc_logs.Auto.CountTotal;
																	
																	 self.Banking_CBDCount01 := left.acc_logs.Banking.CBDCount01;
																	self.Banking_CBDCountTotal := left.acc_logs.Banking.CBDCountTotal;
																	self.Banking_Count24 := left.acc_logs.Banking.Count24;
																	self.Banking_Count12 := left.acc_logs.Banking.Count12;
																	self.Banking_Count06 := left.acc_logs.Banking.Count06;
																	self.Banking_Count03 := left.acc_logs.Banking.Count03;
																	self.Banking_Count01 := left.acc_logs.Banking.Count01;
																	self.Banking_CountWeek := left.acc_logs.Banking.CountWeek;
																	self.Banking_CountDay := left.acc_logs.Banking.CountDay;
																	self.Banking_CountTotal := left.acc_logs.Banking.CountTotal;
																	
																	self.Mortgage_CBDCount01 := left.acc_logs.Mortgage.CBDCount01;
																	self.Mortgage_CBDCountTotal := left.acc_logs.Mortgage.CBDCountTotal;
																	self.Mortgage_Count24 := left.acc_logs.Mortgage.Count24;
																	self.Mortgage_Count12 := left.acc_logs.Mortgage.Count12;
																	self.Mortgage_Count06 := left.acc_logs.Mortgage.Count06;
																	self.Mortgage_Count03 := left.acc_logs.Mortgage.Count03;
																	self.Mortgage_Count01 := left.acc_logs.Mortgage.Count01;
																	self.Mortgage_CountWeek := left.acc_logs.Mortgage.CountWeek;
																	self.Mortgage_CountDay := left.acc_logs.Mortgage.CountDay;
																	self.Mortgage_CountTotal := left.acc_logs.Mortgage.CountTotal;
																	
																	 self.HighRiskCredit_CBDCount01 := left.acc_logs.HighRiskCredit.CBDCount01;
																	self.HighRiskCredit_CBDCountTotal := left.acc_logs.HighRiskCredit.CBDCountTotal;
																	self.HighRiskCredit_Count24 := left.acc_logs.HighRiskCredit.Count24;
																	self.HighRiskCredit_Count12 := left.acc_logs.HighRiskCredit.Count12;
																	self.HighRiskCredit_Count06 := left.acc_logs.HighRiskCredit.Count06;
																	self.HighRiskCredit_Count03 := left.acc_logs.HighRiskCredit.Count03;
																	self.HighRiskCredit_Count01 := left.acc_logs.HighRiskCredit.Count01;
																	self.HighRiskCredit_CountWeek := left.acc_logs.HighRiskCredit.CountWeek;
																	self.HighRiskCredit_CountDay := left.acc_logs.HighRiskCredit.CountDay;
																	self.HighRiskCredit_CountTotal := left.acc_logs.HighRiskCredit.CountTotal;
																	
	

//AVM
																	self.Address_History_2_avm_median_geo12_level := left.AVM.Address_History_2.avm_median_geo12_level;
																	self.Address_History_2_avm_median_geo11_level := left.AVM.Address_History_2.avm_median_geo11_level;
																	self.Address_History_2_avm_median_fips_level := left.AVM.Address_History_2.avm_median_fips_level;
																	self.Address_History_2_avm_confidence_score := left.AVM.Address_History_2.avm_confidence_score;
																	self.Address_History_2_avm_automated_valuation6 := left.AVM.Address_History_2.avm_automated_valuation6;
																	self.Address_History_2_avm_automated_valuation5 := left.AVM.Address_History_2.avm_automated_valuation5;
																	self.Address_History_2_avm_automated_valuation4 := left.AVM.Address_History_2.avm_automated_valuation4;
																	self.Address_History_2_avm_automated_valuation3 := left.AVM.Address_History_2.avm_automated_valuation3;
																	self.Address_History_2_avm_automated_valuation2 := left.AVM.Address_History_2.avm_automated_valuation2;
																	self.Address_History_2_avm_automated_valuation := left.AVM.Address_History_2.avm_automated_valuation;
																	self.Address_History_2_avm_price_index_valuation := left.AVM.Address_History_2.avm_price_index_valuation;
																	self.Address_History_2_avm_hedonic_valuation := left.AVM.Address_History_2.avm_hedonic_valuation;
																	self.Address_History_2_avm_tax_assessment_valuation := left.AVM.Address_History_2.avm_tax_assessment_valuation;
																	self.Address_History_2_avm_market_total_value := left.AVM.Address_History_2.avm_market_total_value;
																	self.Address_History_2_avm_assessed_total_value := left.AVM.Address_History_2.avm_assessed_total_value;
																	self.Address_History_2_avm_sales_price := left.AVM.Address_History_2.avm_sales_price;
																	self.Address_History_2_avm_assessed_value_year := left.AVM.Address_History_2.avm_assessed_value_year;
																	self.Address_History_2_avm_recording_date := left.AVM.Address_History_2.avm_recording_date;
																	self.Address_History_2_avm_land_use_code := left.AVM.Address_History_2.avm_land_use_code;
																	
																	self.Address_History_1_avm_median_geo12_level := left.AVM.Address_History_1.avm_median_geo12_level;
																	self.Address_History_1_avm_median_geo11_level := left.AVM.Address_History_1.avm_median_geo11_level;
																	self.Address_History_1_avm_median_fips_level := left.AVM.Address_History_1.avm_median_fips_level;
																	self.Address_History_1_avm_confidence_score := left.AVM.Address_History_1.avm_confidence_score;
																	self.Address_History_1_avm_automated_valuation6 := left.AVM.Address_History_1.avm_automated_valuation6;
																	self.Address_History_1_avm_automated_valuation5 := left.AVM.Address_History_1.avm_automated_valuation5;
																	self.Address_History_1_avm_automated_valuation4 := left.AVM.Address_History_1.avm_automated_valuation4;
																	self.Address_History_1_avm_automated_valuation3 := left.AVM.Address_History_1.avm_automated_valuation3;
																	self.Address_History_1_avm_automated_valuation2 := left.AVM.Address_History_1.avm_automated_valuation2;
																	self.Address_History_1_avm_automated_valuation := left.AVM.Address_History_1.avm_automated_valuation;
																	self.Address_History_1_avm_price_index_valuation := left.AVM.Address_History_1.avm_price_index_valuation;
																	self.Address_History_1_avm_hedonic_valuation := left.AVM.Address_History_1.avm_hedonic_valuation;
																	self.Address_History_1_avm_tax_assessment_valuation := left.AVM.Address_History_1.avm_tax_assessment_valuation;
																	self.Address_History_1_avm_market_total_value := left.AVM.Address_History_1.avm_market_total_value;
																	self.Address_History_1_avm_assessed_total_value := left.AVM.Address_History_1.avm_assessed_total_value;
																	self.Address_History_1_avm_sales_price := left.AVM.Address_History_1.avm_sales_price;
																	self.Address_History_1_avm_assessed_value_year := left.AVM.Address_History_1.avm_assessed_value_year;
																	self.Address_History_1_avm_recording_date := left.AVM.Address_History_1.avm_recording_date;
																	self.Address_History_1_avm_land_use_code := left.AVM.Address_History_1.avm_land_use_code;
																	
																	self.Input_Address_Information_avm_median_geo12_level := left.AVM.Input_Address_Information.avm_median_geo12_level;
																	self.Input_Address_Information_avm_median_geo11_level := left.AVM.Input_Address_Information.avm_median_geo11_level;
																	self.Input_Address_Information_avm_median_fips_level := left.AVM.Input_Address_Information.avm_median_fips_level;
																	self.Input_Address_Information_avm_confidence_score := left.AVM.Input_Address_Information.avm_confidence_score;
																	self.Input_Address_Information_avm_automated_valuation6 := left.AVM.Input_Address_Information.avm_automated_valuation6;
																	self.Input_Address_Information_avm_automated_valuation5 := left.AVM.Input_Address_Information.avm_automated_valuation5;
																	self.Input_Address_Information_avm_automated_valuation4 := left.AVM.Input_Address_Information.avm_automated_valuation4;
																	self.Input_Address_Information_avm_automated_valuation3 := left.AVM.Input_Address_Information.avm_automated_valuation3;
																	self.Input_Address_Information_avm_automated_valuation2 := left.AVM.Input_Address_Information.avm_automated_valuation2;
																	self.Input_Address_Information_avm_automated_valuation := left.AVM.Input_Address_Information.avm_automated_valuation;
																	self.Input_Address_Information_avm_price_index_valuation := left.AVM.Input_Address_Information.avm_price_index_valuation;
																	self.Input_Address_Information_avm_hedonic_valuation := left.AVM.Input_Address_Information.avm_hedonic_valuation;
																	self.Input_Address_Information_avm_tax_assessment_valuation := left.AVM.Input_Address_Information.avm_tax_assessment_valuation;
																	self.Input_Address_Information_avm_market_total_value := left.AVM.Input_Address_Information.avm_market_total_value;
																	self.Input_Address_Information_avm_assessed_total_value := left.AVM.Input_Address_Information.avm_assessed_total_value;
																	self.Input_Address_Information_avm_sales_price := left.AVM.Input_Address_Information.avm_sales_price;
																	self.Input_Address_Information_avm_assessed_value_year := left.AVM.Input_Address_Information.avm_assessed_value_year;
																	self.Input_Address_Information_avm_recording_date := left.AVM.Input_Address_Information.avm_recording_date;
																	self.Input_Address_Information_avm_land_use_code := left.AVM.Input_Address_Information.avm_land_use_code;

															
//watercraft
																	self.watercraft_count60 := left.watercraft.watercraft_count60;
																	self.watercraft_count36 := left.watercraft.watercraft_count36;
																	self.watercraft_count24 := left.watercraft.watercraft_count24;
																	self.watercraft_count12 := left.watercraft.watercraft_count12;
																	self.watercraft_count180 := left.watercraft.watercraft_count180;
																	self.watercraft_count90 := left.watercraft.watercraft_count90;
																	self.watercraft_count30 := left.watercraft.watercraft_count30;
																	self.watercraft_count := left.watercraft.watercraft_count;																	
//liens
																	self.liens_unreleased_landlord_tenant_count := left.liens.liens_unreleased_landlord_tenant.count;
																	self.liens_unreleased_landlord_tenant_earliest_filing_date := left.liens.liens_unreleased_landlord_tenant.earliest_filing_date;
																	self.liens_unreleased_landlord_tenant_most_recent_filing_date := left.liens.liens_unreleased_landlord_tenant.most_recent_filing_date;
																	self.liens_unreleased_landlord_tenant_total_amount := left.liens.liens_unreleased_landlord_tenant.total_amount;
																	
																	self.liens_released_landlord_tenant_count := left.liens.liens_released_landlord_tenant.count;
																	self.liens_released_landlord_tenant_earliest_filing_date := left.liens.liens_released_landlord_tenant.earliest_filing_date;
																	self.liens_released_landlord_tenant_most_recent_filing_date := left.liens.liens_released_landlord_tenant.most_recent_filing_date;
																	self.liens_released_landlord_tenant_total_amount := left.liens.liens_released_landlord_tenant.total_amount;

																	self.liens_unreleased_lispendens_count := left.liens.liens_unreleased_lispendens.count;
																	self.liens_unreleased_lispendens_earliest_filing_date := left.liens.liens_unreleased_lispendens.earliest_filing_date;
																	self.liens_unreleased_lispendens_most_recent_filing_date := left.liens.liens_unreleased_lispendens.most_recent_filing_date;
																	self.liens_unreleased_lispendens_total_amount := left.liens.liens_unreleased_lispendens.total_amount;
																	
																	self.liens_released_lispendens_count := left.liens.liens_released_lispendens.count;
																	self.liens_released_lispendens_earliest_filing_date := left.liens.liens_released_lispendens.earliest_filing_date;
																	self.liens_released_lispendens_most_recent_filing_date := left.liens.liens_released_lispendens.most_recent_filing_date;
																	self.liens_released_lispendens_total_amount := left.liens.liens_released_lispendens.total_amount;
																	
																	self.liens_unreleased_other_lj_count := left.liens.liens_unreleased_other_lj.count;
																	self.liens_unreleased_other_lj_earliest_filing_date := left.liens.liens_unreleased_other_lj.earliest_filing_date;
																	self.liens_unreleased_other_lj_most_recent_filing_date := left.liens.liens_unreleased_other_lj.most_recent_filing_date;
																	self.liens_unreleased_other_lj_total_amount := left.liens.liens_unreleased_other_lj.total_amount;		
																	
																	self.liens_released_other_lj_count := left.liens.liens_released_other_lj.count;
																	self.liens_released_other_lj_earliest_filing_date := left.liens.liens_released_other_lj.earliest_filing_date;
																	self.liens_released_other_lj_most_recent_filing_date := left.liens.liens_released_other_lj.most_recent_filing_date;
																	self.liens_released_other_lj_total_amount := left.liens.liens_released_other_lj.total_amount;		
																	
																	self.liens_unreleased_other_tax_count := left.liens.liens_unreleased_other_tax.count;
																	self.liens_unreleased_other_tax_earliest_filing_date := left.liens.liens_unreleased_other_tax.earliest_filing_date;
																	self.liens_unreleased_other_tax_most_recent_filing_date := left.liens.liens_unreleased_other_tax.most_recent_filing_date;
																	self.liens_unreleased_other_tax_total_amount := left.liens.liens_unreleased_other_tax.total_amount;	
																	
																	self.liens_released_other_tax_count := left.liens.liens_released_other_tax.count;
																	self.liens_released_other_tax_earliest_filing_date := left.liens.liens_released_other_tax.earliest_filing_date;
																	self.liens_released_other_tax_most_recent_filing_date := left.liens.liens_released_other_tax.most_recent_filing_date;
																	self.liens_released_other_tax_total_amount := left.liens.liens_released_other_tax.total_amount;		
																	
																	self.liens_unreleased_small_claims_count := left.liens.liens_unreleased_small_claims.count;
																	self.liens_unreleased_small_claims_earliest_filing_date := left.liens.liens_unreleased_small_claims.earliest_filing_date;
																	self.liens_unreleased_small_claims_most_recent_filing_date := left.liens.liens_unreleased_small_claims.most_recent_filing_date;
																	self.liens_unreleased_small_claims_total_amount := left.liens.liens_unreleased_small_claims.total_amount;	
																	
																	self.liens_released_small_claims_count := left.liens.liens_released_small_claims.count;
																	self.liens_released_small_claims_earliest_filing_date := left.liens.liens_released_small_claims.earliest_filing_date;
																	self.liens_released_small_claims_most_recent_filing_date := left.liens.liens_released_small_claims.most_recent_filing_date;
																	self.liens_released_small_claims_total_amount := left.liens.liens_released_small_claims.total_amount;		
																																		
																	self.liens_unreleased_suits_count := left.liens.liens_unreleased_suits.count;
																	self.liens_unreleased_suits_earliest_filing_date := left.liens.liens_unreleased_suits.earliest_filing_date;
																	self.liens_unreleased_suits_most_recent_filing_date := left.liens.liens_unreleased_suits.most_recent_filing_date;
																	self.liens_unreleased_suits_total_amount := left.liens.liens_unreleased_suits.total_amount;	
																	
																	self.liens_released_suits_count := left.liens.liens_released_suits.count;
																	self.liens_released_suits_earliest_filing_date := left.liens.liens_released_suits.earliest_filing_date;
																	self.liens_released_suits_most_recent_filing_date := left.liens.liens_released_suits.most_recent_filing_date;
																	self.liens_released_suits_total_amount := left.liens.liens_released_suits.total_amount;		
																	
																	self.liens_unreleased_foreclosure_count := left.liens.liens_unreleased_foreclosure.count;
																	self.liens_unreleased_foreclosure_earliest_filing_date := left.liens.liens_unreleased_foreclosure.earliest_filing_date;
																	self.liens_unreleased_foreclosure_most_recent_filing_date := left.liens.liens_unreleased_foreclosure.most_recent_filing_date;
																	self.liens_unreleased_foreclosure_total_amount := left.liens.liens_unreleased_foreclosure.total_amount;		
																	
																	self.liens_released_foreclosure_count := left.liens.liens_released_foreclosure.count;
																	self.liens_released_foreclosure_earliest_filing_date := left.liens.liens_released_foreclosure.earliest_filing_date;
																	self.liens_released_foreclosure_most_recent_filing_date := left.liens.liens_released_foreclosure.most_recent_filing_date;
																	self.liens_released_foreclosure_total_amount := left.liens.liens_released_foreclosure.total_amount;		
																	
																	self.liens_unreleased_federal_tax_count := left.liens.liens_unreleased_federal_tax.count;
																	self.liens_unreleased_federal_tax_earliest_filing_date := left.liens.liens_unreleased_federal_tax.earliest_filing_date;
																	self.liens_unreleased_federal_tax_most_recent_filing_date := left.liens.liens_unreleased_federal_tax.most_recent_filing_date;
																	self.liens_unreleased_federal_tax_total_amount := left.liens.liens_unreleased_federal_tax.total_amount;		
																	
																	self.liens_released_federal_tax_count := left.liens.liens_released_federal_tax.count;
																	self.liens_released_federal_tax_earliest_filing_date := left.liens.liens_released_federal_tax.earliest_filing_date;
																	self.liens_released_federal_tax_most_recent_filing_date := left.liens.liens_released_federal_tax.most_recent_filing_date;
																	self.liens_released_federal_tax_total_amount := left.liens.liens_released_federal_tax.total_amount;	
																	
																	self.liens_unreleased_civil_judgment_count := left.liens.liens_unreleased_civil_judgment.count;
																	self.liens_unreleased_civil_judgment_earliest_filing_date := left.liens.liens_unreleased_civil_judgment.earliest_filing_date;
																	self.liens_unreleased_civil_judgment_most_recent_filing_date := left.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
																	self.liens_unreleased_civil_judgment_total_amount := left.liens.liens_unreleased_civil_judgment.total_amount;	
																	
																	
																	self.liens_released_civil_judgment_count := left.liens.liens_released_civil_judgment.count;
																	self.liens_released_civil_judgment_earliest_filing_date := left.liens.liens_released_civil_judgment.earliest_filing_date;
																	self.liens_released_civil_judgment_most_recent_filing_date := left.liens.liens_released_civil_judgment.most_recent_filing_date;
																	self.liens_released_civil_judgment_total_amount := left.liens.liens_released_civil_judgment.total_amount;	

//iid
																		self.CVI := left.iid.CVI;
																	self.NAP_Status := left.iid.NAP_Status;
																	self.NAP_Type := left.iid.NAP_Type;
																	self.NAP_Summary := left.iid.NAP_Summary;
																	self.NAS_Summary := left.iid.NAS_Summary;
																	self.targustype := left.iid.targustype;
																	self.targusgatewayused := left.iid.targusgatewayused;
																	self.DIDdeceasedlast := left.iid.DIDdeceasedlast;
																	self.DIDdeceasedfirst := left.iid.DIDdeceasedfirst;
																	self.DIDdeceasedDOB := left.iid.DIDdeceasedDOB;
																	self.DIDdeceasedDate := left.iid.DIDdeceasedDate;
																	self.DIDdeceased := left.iid.DIDdeceased;		
																	self.wphonecity := left.iid.wphonecity;
																	self.wphoneaddr := left.iid.wphoneaddr;
																	self.wphonename := left.iid.wphonename;
																	self.watchlist_entity_name := left.iid.watchlist_entity_name;
																	self.watchlistHit := left.iid.watchlistHit;
																	self.watchlist_zip := left.iid.watchlist_zip;
																	self.watchlist_state := left.iid.watchlist_state;
																	self.watchlist_city := left.iid.watchlist_city;
																	self.watchlist_address := left.iid.watchlist_address;
																	self.watchlist_lname := left.iid.watchlist_lname;
																	self.watchlist_fname := left.iid.watchlist_fname;																
																	self.watchlist_record_number := left.iid.watchlist_record_number;
																	self.watchlist_table := left.iid.watchlist_table;	
																	self.EverAssocIm := left.iid.EverAssocIm;
																	self.EverAssocITIN := left.iid.EverAssocITIN;
																	self.IsShiptoBilltoDifferent := left.iid.IsShiptoBilltoDifferent;
																	self.verified_DL := left.iid.verified_DL;
																	self.DL_score := left.iid.DL_score;
																	self.dl_exists := left.iid.dl_exists;
																	self.any_DL_found := left.iid.any_DL_found;
																	self.DL_searched := left.iid.DL_searched;
																	self.iid_flags := left.iid.iid_flags;
																	self.BestSSN := left.iid.BestSSN;
																	self.publish_code := left.iid.publish_code;																
																	self.inputAddrNotMostRecent := left.iid.inputAddrNotMostRecent;
																	self.name_addr_phone := left.iid.name_addr_phone;
																	self.wphonezip := left.iid.wphonezip;
																	self.wphonestate := left.iid.wphonestate;
																  self.combo_cmpycount := left.iid.combo_cmpycount;
																	self.combo_dobcount := left.iid.combo_dobcount;
																	self.combo_ssncount := left.iid.combo_ssncount;
																	self.combo_hphonecount := left.iid.combo_hphonecount;
																	self.combo_addrcount := left.iid.combo_addrcount;
																	self.combo_lastcount := left.iid.combo_lastcount;
																	self.combo_firstcount := left.iid.combo_firstcount;
																	self.combo_cmpyscore := left.iid.combo_cmpyscore;
																	self.combo_dobscore := left.iid.combo_dobscore;
																	self.combo_ssnscore := left.iid.combo_ssnscore;
																	self.combo_hphonescore := left.iid.combo_hphonescore;
																	self.combo_sec_rangescore := left.iid.combo_sec_rangescore;		
																	self.combo_addrscore := left.iid.combo_addrscore;
																	self.combo_lastscore := left.iid.combo_lastscore;																	
																	self.combo_firstscore := left.iid.combo_firstscore;
																	self.combo_cmpy := left.iid.combo_cmpy;
																	self.combo_dob := left.iid.combo_dob;
																	self.combo_ssn := left.iid.combo_ssn;
																	self.combo_hphone := left.iid.combo_hphone;
																	self.combo_zip := left.iid.combo_zip;
																	self.combo_state := left.iid.combo_state;
																	self.combo_city := left.iid.combo_city;
																	self.combo_sec_range := left.iid.combo_sec_range;																
																	self.combo_unit_desig := left.iid.combo_unit_desig;
																	self.combo_postdir := left.iid.combo_postdir;	
																	self.combo_suffix := left.iid.combo_suffix;
																	self.combo_prim_name := left.iid.combo_prim_name;
																	self.combo_predir := left.iid.combo_predir;
																	self.combo_prim_range := left.iid.combo_prim_range;
																	self.combo_last := left.iid.combo_last;
																	self.combo_first := left.iid.combo_first;
																	self.ssnexists := left.iid.ssnexists;
																	self.firstssnmatch := left.iid.firstssnmatch;
																	self.lastssnmatch2 := left.iid.lastssnmatch2;
																	self.lastssnmatch := left.iid.lastssnmatch;
																	self.altlast2Pop := left.iid.altlast2Pop;																
																	self.altlastPop := left.iid.altlastPop;
																	self.altlast2 := left.iid.altlast2;
																	self.altlast := left.iid.altlast;
																	self.chronodate_first3 := left.iid.chronodate_first3;
																	self.chronodate_first2 := left.iid.chronodate_first2;
																	self.chronodate_first := left.iid.chronodate_first;
																		
	//chrono_addr_flags3
																	self.chrono_addr_flags3_dropIndicator := left.iid.chrono_addr_flags3.dropIndicator;
																	self.chrono_addr_flags3_addressType := left.iid.chrono_addr_flags3.addressType;
																	self.chrono_addr_flags3_deliveryStatus := left.iid.chrono_addr_flags3.deliveryStatus;
																	self.chrono_addr_flags3_doNotDeliver := left.iid.chrono_addr_flags3.doNotDeliver;
																	self.chrono_addr_flags3_corpMil := left.iid.chrono_addr_flags3.corpMil;
																	self.chrono_addr_flags3_highRisk := left.iid.chrono_addr_flags3.highRisk;
																	self.chrono_addr_flags3_prisonAddr := left.iid.chrono_addr_flags3.prisonAddr;
																	self.chrono_addr_flags3_valid := left.iid.chrono_addr_flags3.valid;
																	self.chrono_addr_flags3_dwelltype := left.iid.chrono_addr_flags3.dwelltype;

																	self.chrono_sources3 := left.iid.chrono_sources3;
																	self.chronoMatchLevel3 := left.iid.chronoMatchLevel3;
																	self.chronoActivePhone3 := left.iid.chronoActivePhone3;
																	self.chronophone3 := left.iid.chronophone3;
																	self.chronozip3 := left.iid.chronozip3;
																	self.chronostate3 := left.iid.chronostate3;
																	self.chronocity3 := left.iid.chronocity3;
																	self.chronosec_range3 := left.iid.chronosec_range3;																
																	self.chronounit_desig3 := left.iid.chronounit_desig3;
																	self.chronopostdir3 := left.iid.chronopostdir3;
																	self.chronosuffix3 := left.iid.chronosuffix3;
																	self.chronoprim_name3 := left.iid.chronoprim_name3;
																	self.chronopredir3 := left.iid.chronopredir3;
																	self.chronoprim_range3 := left.iid.chronoprim_range3;
		
	//chrono_addr_flags2
																	self.chrono_addr_flags2_dropIndicator := left.iid.chrono_addr_flags2.dropIndicator;
																	self.chrono_addr_flags2_addressType := left.iid.chrono_addr_flags2.addressType;
																	self.chrono_addr_flags2_deliveryStatus := left.iid.chrono_addr_flags2.deliveryStatus;
																	self.chrono_addr_flags2_doNotDeliver := left.iid.chrono_addr_flags2.doNotDeliver;
																	self.chrono_addr_flags2_corpMil := left.iid.chrono_addr_flags2.corpMil;
																	self.chrono_addr_flags2_highRisk := left.iid.chrono_addr_flags2.highRisk;
																	self.chrono_addr_flags2_prisonAddr := left.iid.chrono_addr_flags2.prisonAddr;
																	self.chrono_addr_flags2_valid := left.iid.chrono_addr_flags2.valid;
																	self.chrono_addr_flags2_dwelltype := left.iid.chrono_addr_flags2.dwelltype;	
																	
																	self.chrono_sources2 := left.iid.chrono_sources2;
																	self.chronoMatchLevel2 := left.iid.chronoMatchLevel2;
																	self.chronoActivePhone2 := left.iid.chronoActivePhone2;
																	self.chronophone2 := left.iid.chronophone2;
																	self.chronozip2 := left.iid.chronozip2;
																	self.chronostate2 := left.iid.chronostate2;
																	self.chronocity2 := left.iid.chronocity2;
																	self.chronosec_range2 := left.iid.chronosec_range2;																
																	self.chronounit_desig2 := left.iid.chronounit_desig2;
																	self.chronopostdir2 := left.iid.chronopostdir2;
																	self.chronosuffix2 := left.iid.chronosuffix2;
																	self.chronoprim_name2 := left.iid.chronoprim_name2;
																	self.chronopredir2 := left.iid.chronopredir2;
																	self.chronoprim_range2 := left.iid.chronoprim_range2;
	//chrono_addr_flags
																	self.chrono_addr_flags_dropIndicator := left.iid.chrono_addr_flags.dropIndicator;
																	self.chrono_addr_flags_addressType := left.iid.chrono_addr_flags.addressType;
																	self.chrono_addr_flags_deliveryStatus := left.iid.chrono_addr_flags.deliveryStatus;
																	self.chrono_addr_flags_doNotDeliver := left.iid.chrono_addr_flags.doNotDeliver;
																	self.chrono_addr_flags_corpMil := left.iid.chrono_addr_flags.corpMil;
																	self.chrono_addr_flags_highRisk := left.iid.chrono_addr_flags.highRisk;
																	self.chrono_addr_flags_prisonAddr := left.iid.chrono_addr_flags.prisonAddr;
																	self.chrono_addr_flags_valid := left.iid.chrono_addr_flags.valid;
																	self.chrono_addr_flags_dwelltype := left.iid.chrono_addr_flags.dwelltype;	
																	
																	self.chrono_sources := left.iid.chrono_sources;
																	self.chronoMatchLevel := left.iid.chronoMatchLevel;
																	self.chronoActivePhone := left.iid.chronoActivePhone;
																	self.chronophone := left.iid.chronophone;
																	self.chronozip := left.iid.chronozip;
																	self.chronostate := left.iid.chronostate;
																	self.chronocity := left.iid.chronocity;
																	self.chronosec_range := left.iid.chronosec_range;																
																	self.chronounit_desig := left.iid.chronounit_desig;
																	self.chronopostdir := left.iid.chronopostdir;
																	self.chronosuffix := left.iid.chronosuffix;
																	self.chronoprim_name := left.iid.chronoprim_name;
																	self.chronopredir := left.iid.chronopredir;
																	self.chronoprim_range := left.iid.chronoprim_range;
	
																	self.cityzipflag := left.iid.cityzipflag;
																	self.statezipflag := left.iid.statezipflag;
																	self.drlcgender := left.iid.drlcgender;
																	self.drlcdob := left.iid.drlcdob;		
																	self.drlcsocs := left.iid.drlcsocs;
																	self.drlcmiddle := left.iid.drlcmiddle;																	
																	self.drlclast := left.iid.drlclast;
																	self.drlcfirst := left.iid.drlcfirst;
																	self.drlcsoundx := left.iid.drlcsoundx;
																	self.drlcvalflag := left.iid.drlcvalflag;
																	self.zipclass := left.iid.zipclass;
																	self.ziptypeflag := left.iid.ziptypeflag;
																	self.phonetype := left.iid.phonetype;
																	self.utiliphone := left.iid.utiliphone;
																	self.dirsaddr_lastscore := left.iid.dirsaddr_lastscore;																
																	self.dirsaddr_phone := left.iid.dirsaddr_phone;
																	self.dirscmpy := left.iid.dirscmpy;	
																	self.dirszip := left.iid.dirszip;
																	self.dirsstate := left.iid.dirsstate;
																	self.dirscity := left.iid.dirscity;
																	self.dirs_sec_range := left.iid.dirs_sec_range;
																	self.dirs_unit_desig := left.iid.dirs_unit_desig;
																	self.dirs_postdir := left.iid.dirs_postdir;
																	self.dirs_suffix := left.iid.dirs_suffix;
																	self.dirs_prim_name := left.iid.dirs_prim_name;
																	self.dirs_predir := left.iid.dirs_predir;
																	self.dirs_prim_range := left.iid.dirs_prim_range;
																	self.dirslast := left.iid.dirslast;																
																	self.dirsfirst := left.iid.dirsfirst;
																	self.correctlast := left.iid.correctlast;
																	self.correcthphone := left.iid.correcthphone;
																	self.correctssn := left.iid.correctssn;
																	self.correctdob := left.iid.correctdob;
																	
																	self.distwphoneaddr := left.iid.distwphoneaddr;
																	self.disthphonewphone := left.iid.disthphonewphone;
																	self.disthphoneaddr := left.iid.disthphoneaddr;
																	self.hriskcmpyphone := left.iid.hriskcmpyphone;		
																	self.hriskcmpy := left.iid.hriskcmpy;
																	self.hrisksicphone := left.iid.hrisksicphone;																	
																	self.hrisksic := left.iid.hrisksic;
																	self.addrcommflag := left.iid.addrcommflag;
																	self.addrmiskeyflag := left.iid.addrmiskeyflag;
																	self.hphonemiskeyflag := left.iid.hphonemiskeyflag;
																	self.socsmiskeyflag := left.iid.socsmiskeyflag;
																	self.verlast := left.iid.verlast;
																	self.verfirst := left.iid.verfirst;
																	self.utiliaddr_phonecount := left.iid.utiliaddr_phonecount;																
																	self.utiliaddr_addrcount := left.iid.utiliaddr_addrcount;
																	self.utiliaddr_lastcount := left.iid.utiliaddr_lastcount;	
																	self.phoneaddr_phonecount := left.iid.phoneaddr_phonecount;
																	self.phoneaddr_addrcount := left.iid.phoneaddr_addrcount;
																	self.phoneaddr_lastcount := left.iid.phoneaddr_lastcount;
																	self.phoneaddr_firstcount := left.iid.phoneaddr_firstcount;
																	self.phonephonecount := left.iid.phonephonecount;
																	self.phoneaddrcount := left.iid.phoneaddrcount;
																	self.phonelastcount := left.iid.phonelastcount;
																	self.phonefirstcount := left.iid.phonefirstcount;
																	self.numelever := left.iid.numelever;
																	self.socscount := left.iid.socscount;
																	self.wphonecount := left.iid.wphonecount;																
																	self.addrcount := left.iid.addrcount;
																	self.lastcount := left.iid.lastcount;
																	self.firstcount := left.iid.firstcount;
																	self.sources := left.iid.sources;

	// fields to support reason code and follow-up action calculations
																	self.bansflag := left.iid.bansflag;
																	self.dwelltype := left.iid.dwelltype;
																	self.addrvalflag := left.iid.addrvalflag;
																	self.reverse_areacodesplitflag := left.iid.reverse_areacodesplitflag;		
																	self.altareacode := left.iid.altareacode;
																	self.areacodesplitdate := left.iid.areacodesplitdate;																	
																	self.areacodesplitflag := left.iid.areacodesplitflag;
																	self.socsverlevel := left.iid.socsverlevel;
																	self.soclstate := left.iid.soclstate;
																	self.soclhighissue := left.iid.soclhighissue;
																	self.socllowissue := left.iid.socllowissue;
																	self.socsRCISflag := left.iid.socsRCISflag;
																	self.PWsocsvalflag := left.iid.PWsocsvalflag;
																	self.socsvalflag := left.iid.socsvalflag;
																	self.PWsocsdobflag := left.iid.PWsocsdobflag;																
																	self.socsdobflag := left.iid.socsdobflag;
																	self.decsflag := left.iid.decsflag;	
																	self.pullidflag := left.iid.pullidflag;
																	self.hriskaddrflag := left.iid.hriskaddrflag;
																	self.phonever_type := left.iid.phonever_type;
																	self.phoneverlevel := left.iid.phoneverlevel;
																	self.wphonedissflag := left.iid.wphonedissflag;
																	self.phonedissflag := left.iid.phonedissflag;
																	self.PWphonezipflag := left.iid.PWphonezipflag;
																	self.phonezipflag := left.iid.phonezipflag;
																	self.wphonevalflag := left.iid.wphonevalflag;
																	self.hphonevalflag := left.iid.hphonevalflag;
																	self.phonevalflag := left.iid.phonevalflag;																
																	self.wphonetypeflag := left.iid.wphonetypeflag;
																	self.hphonetypeflag := left.iid.hphonetypeflag;
																	self.hriskphoneflag := left.iid.hriskphoneflag;
																	self.non_us_ssn := left.iid.non_us_ssn;	
																
																	self.did3_liens_historical_released_count := left.iid.did3_liens_historical_released_count;
																	self.did3_liens_recent_released_count := left.iid.did3_liens_recent_released_count;
																	self.did3_liens_historical_unreleased_count := left.iid.did3_liens_historical_unreleased_count;
																	self.did3_liens_recent_unreleased_count := left.iid.did3_liens_recent_unreleased_count;		
																	self.did3_felony_count := left.iid.did3_felony_count;
																	self.did3_criminal_count := left.iid.did3_criminal_count;																	
																	self.DID3_HeaderLastSeen := left.iid.DID3_HeaderLastSeen;
																	self.DID3_HeaderFirstSeen := left.iid.DID3_HeaderFirstSeen;
																	self.DID3_CreditLastSeen := left.iid.DID3_CreditLastSeen;
																	self.DID3_CreditFirstSeen := left.iid.DID3_CreditFirstSeen;
																	self.DID3_SocsSources := left.iid.DID3_SocsSources;
																	self.DID3_LNameSources := left.iid.DID3_LNameSources;
																	self.DID3_FNameSources := left.iid.DID3_FNameSources;
																	self.DID3_Sources := left.iid.DID3_Sources;
																	self.did2_liens_historical_released_count := left.iid.did2_liens_historical_released_count;																
																	self.did2_liens_recent_released_count := left.iid.did2_liens_recent_released_count;
																	self.did2_liens_historical_unreleased_count := left.iid.did2_liens_historical_unreleased_count;	
																	self.did2_liens_recent_unreleased_count := left.iid.did2_liens_recent_unreleased_count;
																	self.did2_felony_count := left.iid.did2_felony_count;
																	self.did2_criminal_count := left.iid.did2_criminal_count;
																	self.DID2_HeaderLastSeen := left.iid.DID2_HeaderLastSeen;
																	self.DID2_HeaderFirstSeen := left.iid.DID2_HeaderFirstSeen;
																	self.DID2_CreditLastSeen := left.iid.DID2_CreditLastSeen;
																	self.DID2_CreditFirstSeen := left.iid.DID2_CreditFirstSeen;
																	self.DID2_SocsSources := left.iid.DID2_SocsSources;
																	self.DID2_AddrSources := left.iid.DID2_AddrSources;
																	self.DID2_LNameSources := left.iid.DID2_LNameSources;
																	self.DID2_FNameSources := left.iid.DID2_FNameSources;																
																	self.DID2_Sources := left.iid.DID2_Sources;
																	self.DID3 := left.iid.DID3;
																	self.DID2 := left.iid.DID2;
																	self.DIDCount := left.iid.DIDCount;
																	self.reason6 := left.iid.reason6;																		
																	self.reason5 := left.iid.reason5;
																	self.reason4 := left.iid.reason4;
																	self.reason3 := left.iid.reason3;
																	self.reason2 := left.iid.reason2;
																	self.reason1 := left.iid.reason1;	

//email_summary
																	self.email_summary_ver_sources_recordcount := left.email_summary.reverse_email.ver_sources_recordcount;
																	self.email_summary_ver_sources_last_seen_date := left.email_summary.reverse_email.ver_sources_last_seen_date;
																	self.email_summary_ver_sources_first_seen_date := left.email_summary.reverse_email.ver_sources_first_seen_date;
																	self.email_summary_ver_sources := left.email_summary.reverse_email.ver_sources;
																	self.adls_per_email := left.email_summary.reverse_email.adls_per_email;
																	self.verification_level := left.email_summary.reverse_email.verification_level;
																	
																	self.Identity_Email_Verification_Level := left.email_summary.Identity_Email_Verification_Level;
																	self.email_source_first_seen := left.email_summary.email_source_first_seen;
																	self.email_source_ct := left.email_summary.email_source_ct;
																	self.email_source_list := left.email_summary.email_source_list;
																	self.email_domain_Corp_ct := left.email_summary.email_domain_Corp_ct;
																	self.email_domain_EDU_ct := left.email_summary.email_domain_EDU_ct;
																	self.email_domain_ISP_ct := left.email_summary.email_domain_ISP_ct;
																	self.email_domain_Free_ct := left.email_summary.email_domain_Free_ct;
																	self.email_ct := left.email_summary.email_ct;




//advo_addr_hist2
																	self.advo_addr_hist2_Mixed_Address_Usage := left.advo_addr_hist2.Mixed_Address_Usage;
																	self.advo_addr_hist2_Residential_or_Business_Ind := left.advo_addr_hist2.Residential_or_Business_Ind;
																	self.advo_addr_hist2_Drop_Indicator := left.advo_addr_hist2.Drop_Indicator;
																	self.advo_addr_hist2_College_Indicator := left.advo_addr_hist2.College_Indicator;
																	self.advo_addr_hist2_DND_Indicator := left.advo_addr_hist2.DND_Indicator;
																	self.advo_addr_hist2_Seasonal_Delivery_Indicator := left.advo_addr_hist2.Seasonal_Delivery_Indicator;
																	self.advo_addr_hist2_Throw_Back_Indicator := left.advo_addr_hist2.Throw_Back_Indicator;
																	self.advo_addr_hist2_Address_Vacancy_Indicator := left.advo_addr_hist2.Address_Vacancy_Indicator;
//advo_addr_hist2
																	self.advo_addr_hist1_Mixed_Address_Usage := left.advo_addr_hist1.Mixed_Address_Usage;
																	self.advo_addr_hist1_Residential_or_Business_Ind := left.advo_addr_hist1.Residential_or_Business_Ind;
																	self.advo_addr_hist1_Drop_Indicator := left.advo_addr_hist1.Drop_Indicator;
																	self.advo_addr_hist1_College_Indicator := left.advo_addr_hist1.College_Indicator;
																	self.advo_addr_hist1_DND_Indicator := left.advo_addr_hist1.DND_Indicator;
																	self.advo_addr_hist1_Seasonal_Delivery_Indicator := left.advo_addr_hist1.Seasonal_Delivery_Indicator;
																	self.advo_addr_hist1_Throw_Back_Indicator := left.advo_addr_hist1.Throw_Back_Indicator;
																	self.advo_addr_hist1_Address_Vacancy_Indicator := left.advo_addr_hist1.Address_Vacancy_Indicator;

//advo_input_addr
																	self.advo_input_addr_Mixed_Address_Usage := left.advo_input_addr.Mixed_Address_Usage;
																	self.advo_input_addr_Residential_or_Business_Ind := left.advo_input_addr.Residential_or_Business_Ind;
																	self.advo_input_addr_Drop_Indicator := left.advo_input_addr.Drop_Indicator;
																	self.advo_input_addr_College_Indicator := left.advo_input_addr.College_Indicator;
																	self.advo_input_addr_DND_Indicator := left.advo_input_addr.DND_Indicator;
																	self.advo_input_addr_Seasonal_Delivery_Indicator := left.advo_input_addr.Seasonal_Delivery_Indicator;
																	self.advo_input_addr_Throw_Back_Indicator := left.advo_input_addr.Throw_Back_Indicator;
																	self.advo_input_addr_Address_Vacancy_Indicator := left.advo_input_addr.Address_Vacancy_Indicator;
																	

//SSN_Verification
																	self.other_sourced := left.SSN_Verification.other_sourced;
																	self.bk_sourced := left.SSN_Verification.bk_sourced;
																	self.utility_sourced := left.SSN_Verification.utility_sourced;
																	self.voter_sourced := left.SSN_Verification.voter_sourced;
																	self.tu_sourced := left.SSN_Verification.tu_sourced;
																	self.header_last_seen := left.SSN_Verification.header_last_seen;
																	self.header_first_seen := left.SSN_Verification.header_first_seen;
																	self.header_count := left.SSN_Verification.header_count;
																	self.credit_last_seen := left.SSN_Verification.credit_last_seen;
																	self.credit_first_seen := left.SSN_Verification.credit_first_seen;
																	self.credit_sourced := left.SSN_Verification.credit_sourced;
																	self.adlPerSSN_count := left.SSN_Verification.adlPerSSN_count;
																	self.namePerSSN_count := left.SSN_Verification.namePerSSN_count;
																	self.ssn_score := left.SSN_Verification.ssn_score;															
																																
																	self.inputsocscode := left.SSN_Verification.Validation.inputsocscode;
																	self.inputsocscharflag := left.SSN_Verification.Validation.inputsocscharflag;
																	self.dob_mismatch := left.SSN_Verification.Validation.dob_mismatch;
																	self.issue_state := left.SSN_Verification.Validation.issue_state;
																	self.low_issue_date := left.SSN_Verification.Validation.low_issue_date;
																	self.high_issue_date := left.SSN_Verification.Validation.high_issue_date;
																	self.issued := left.SSN_Verification.Validation.issued;
																	self.valid := left.SSN_Verification.Validation.valid;
																	self.deceasedDate := left.SSN_Verification.Validation.deceasedDate;
																	self.deceased := left.SSN_Verification.Validation.deceased;


//Accident_Data
																	self.atfaultda_numaccidents60 := left.Accident_Data.atfaultda.numaccidents60;
																	self.atfaultda_numaccidents36 := left.Accident_Data.atfaultda.numaccidents36;
																	self.atfaultda_numaccidents24 := left.Accident_Data.atfaultda.numaccidents24;
																	self.atfaultda_numaccidents12 := left.Accident_Data.atfaultda.numaccidents12;
																	self.atfaultda_numaccidents180 := left.Accident_Data.atfaultda.numaccidents180;
																	self.atfaultda_numaccidents90 := left.Accident_Data.atfaultda.numaccidents90;
																	self.atfaultda_numaccidents30 := left.Accident_Data.atfaultda.numaccidents30;
																	self.atfaultda_dmgamtlastaccident := left.Accident_Data.atfaultda.dmgamtlastaccident;
																	self.atfaultda_datelastaccident := left.Accident_Data.atfaultda.datelastaccident;
																	self.atfaultda_dmgamtaccidents := left.Accident_Data.atfaultda.dmgamtaccidents;
																	self.atfaultda_num_accidents := left.Accident_Data.atfaultda.num_accidents;
																	
																	self.atfault_numaccidents60 := left.Accident_Data.atfault.numaccidents60;
																	self.atfault_numaccidents36 := left.Accident_Data.atfault.numaccidents36;
																	self.atfault_numaccidents24 := left.Accident_Data.atfault.numaccidents24;
																	self.atfault_numaccidents12 := left.Accident_Data.atfault.numaccidents12;
																	self.atfault_numaccidents180 := left.Accident_Data.atfault.numaccidents180;
																	self.atfault_numaccidents90 := left.Accident_Data.atfault.numaccidents90;
																	self.atfault_numaccidents30 := left.Accident_Data.atfault.numaccidents30;
																	self.atfault_dmgamtlastaccident := left.Accident_Data.atfault.dmgamtlastaccident;
																	self.atfault_datelastaccident := left.Accident_Data.atfault.datelastaccident;
																	self.atfault_dmgamtaccidents := left.Accident_Data.atfault.dmgamtaccidents;
																	self.atfault_num_accidents := left.Accident_Data.atfault.num_accidents;
																	
																	self.acc_numaccidents60 := left.Accident_Data.acc.numaccidents60;
																	self.acc_numaccidents36 := left.Accident_Data.acc.numaccidents36;
																	self.acc_numaccidents24 := left.Accident_Data.acc.numaccidents24;
																	self.acc_numaccidents12 := left.Accident_Data.acc.numaccidents12;
																	self.acc_numaccidents180 := left.Accident_Data.acc.numaccidents180;
																	self.acc_numaccidents90 := left.Accident_Data.acc.numaccidents90;
																	self.acc_numaccidents30 := left.Accident_Data.acc.numaccidents30;
																	self.acc_dmgamtlastaccident := left.Accident_Data.acc.dmgamtlastaccident;
																	self.acc_datelastaccident := left.Accident_Data.acc.datelastaccident;
																	self.acc_dmgamtaccidents := left.Accident_Data.acc.dmgamtaccidents;
																	self.acc_num_accidents := left.Accident_Data.acc.num_accidents;
																
																


//ConsumerFlags
																	self.id_theft_flag := left.ConsumerFlags.id_theft_flag;
																	self.negative_alert := left.ConsumerFlags.negative_alert;
																	self.security_alert := left.ConsumerFlags.security_alert;
																	self.security_freeze := left.ConsumerFlags.security_freeze;
																	self.dispute_flag := left.ConsumerFlags.dispute_flag;
																	self.consumer_statement_flag := left.ConsumerFlags.consumer_statement_flag;
																	self.corrected_flag := left.ConsumerFlags.corrected_flag;


//ADL_Shell_Flags
																	self.in_hphnpop_found := left.ADL_Shell_Flags.in_hphnpop_found;
																	self.in_addrpop_found := left.ADL_Shell_Flags.in_addrpop_found;
																	self.adl_dob := left.ADL_Shell_Flags.adl_dob;
																	self.adl_ssn := left.ADL_Shell_Flags.adl_ssn;
																	self.adl_hphn := left.ADL_Shell_Flags.adl_hphn;
																	self.adl_addr := left.ADL_Shell_Flags.adl_addr;
																	self.in_dobpop := left.ADL_Shell_Flags.in_dobpop;
																	self.in_ssnpop := left.ADL_Shell_Flags.in_ssnpop;
																	self.in_hphnpop := left.ADL_Shell_Flags.in_hphnpop;
																	self.in_addrpop := left.ADL_Shell_Flags.in_addrpop;


//Relatives

																	self.relative_bureau_only_count_created_6months := left.Relatives.relative_bureau_only_count_created_6months;
																	self.relative_bureau_only_count_created_1month := left.Relatives.relative_bureau_only_count_created_1month;
																	self.relative_bureau_only_count := left.Relatives.relative_bureau_only_count;
																	self.relative_suspicious_identities_count := left.Relatives.relative_suspicious_identities_count;
																	self.relatives_at_input_address := left.Relatives.relatives_at_input_address;
																	self.relative_vehicle_owned_count := left.Relatives.relative_vehicle_owned_count;
																	self.relative_ageOver70_count := left.Relatives.relative_ageOver70_count;
																	self.relative_ageUnder70_count := left.Relatives.relative_ageUnder70_count;
																	self.relative_ageUnder60_count := left.Relatives.relative_ageUnder60_count;
																	self.relative_ageUnder50_count := left.Relatives.relative_ageUnder50_count;
																	self.relative_ageUnder40_count := left.Relatives.relative_ageUnder40_count;
																	self.relative_ageUnder30_count := left.Relatives.relative_ageUnder30_count;
																	self.relative_ageUnder20_count := left.Relatives.relative_ageUnder20_count;
																	self.relative_educationOver12_count := left.Relatives.relative_educationOver12_count;
																	self.relative_educationUnder12_count := left.Relatives.relative_educationUnder12_count;
																	self.relative_educationUnder8_count := left.Relatives.relative_educationUnder8_count;
																	self.relative_homeOver500_count := left.Relatives.relative_homeOver500_count;
																	self.relative_homeUnder500_count := left.Relatives.relative_homeUnder500_count;
																	self.relative_homeUnder300_count := left.Relatives.relative_homeUnder300_count;
																	self.relative_homeUnder200_count := left.Relatives.relative_homeUnder200_count;
																	self.relative_homeUnder150_count := left.Relatives.relative_homeUnder150_count;
																	self.relative_homeUnder100_count := left.Relatives.relative_homeUnder100_count;
																	self.relative_homeUnder50_count := left.Relatives.relative_homeUnder50_count;
																	self.relative_incomeOver100_count := left.Relatives.relative_incomeOver100_count;
																  self.relative_incomeUnder100_count := left.Relatives.relative_incomeUnder100_count;
																	self.relative_incomeUnder75_count := left.Relatives.relative_incomeUnder75_count;
																	self.relative_incomeUnder50_count := left.Relatives.relative_incomeUnder50_count;
																	self.relative_incomeUnder25_count := left.Relatives.relative_incomeUnder25_count;
																	self.relative_withinOther_count := left.Relatives.relative_withinOther_count;
																	self.relative_within500miles_count := left.Relatives.relative_within500miles_count;
																	self.relative_within100miles_count := left.Relatives.relative_within100miles_count;
																	self.relative_within25miles_count := left.Relatives.relative_within25miles_count;
																	
																	self.relative_count := left.Relatives.relative_count;
																	self.relative_bankrupt_count := left.Relatives.relative_bankrupt_count;
																	self.relative_criminal_count := left.Relatives.relative_criminal_count;
																	self.relative_criminal_total := left.Relatives.relative_criminal_total;
																  self.relative_felony_count := left.Relatives.relative_felony_count;
																	self.relative_felony_total := left.Relatives.relative_felony_total;
																	self.criminal_relative_within25miles := left.Relatives.criminal_relative_within25miles;
																	self.criminal_relative_within100miles := left.Relatives.criminal_relative_within100miles;
																	self.criminal_relative_within500miles := left.Relatives.criminal_relative_within500miles;
																	self.criminal_relative_withinOther := left.Relatives.criminal_relative_withinOther;																																
																	
																	self.ambiguous_relatives_property_owned_assessed_count := left.Relatives.ambiguous.relatives_property_owned_assessed_count;
																	self.ambiguous_relatives_property_owned_assessed_total := left.Relatives.ambiguous.relatives_property_owned_assessed_total;
																	self.ambiguous_relatives_property_owned_purchase_count := left.Relatives.ambiguous.relatives_property_owned_purchase_count;
																	self.ambiguous_relatives_property_owned_purchase_total := left.Relatives.ambiguous.relatives_property_owned_purchase_total;
																	self.ambiguous_relatives_property_total := left.Relatives.ambiguous.relatives_property_total;
																	self.ambiguous_relatives_property_count := left.Relatives.ambiguous.relatives_property_count;
														
																	self.sold_relatives_property_owned_assessed_count := left.Relatives.sold.relatives_property_owned_assessed_count;
																	self.sold_relatives_property_owned_assessed_total := left.Relatives.sold.relatives_property_owned_assessed_total;
																	self.sold_relatives_property_owned_purchase_count := left.Relatives.sold.relatives_property_owned_purchase_count;
																	self.sold_relatives_property_owned_purchase_total := left.Relatives.sold.relatives_property_owned_purchase_total;
																	self.sold_relatives_property_total := left.Relatives.sold.relatives_property_total;
																	self.sold_relatives_property_count := left.Relatives.sold.relatives_property_count;
																	
																	self.owned_relatives_property_owned_assessed_count := left.Relatives.owned.relatives_property_owned_assessed_count;
																	self.owned_relatives_property_owned_assessed_total := left.Relatives.owned.relatives_property_owned_assessed_total;
																	self.owned_relatives_property_owned_purchase_count := left.Relatives.owned.relatives_property_owned_purchase_count;
																	self.owned_relatives_property_owned_purchase_total := left.Relatives.owned.relatives_property_owned_purchase_total;
																	self.owned_relatives_property_total := left.Relatives.owned.relatives_property_total;
																	self.owned_relatives_property_count := left.Relatives.owned.relatives_property_count;

//BJL
																	self.last_foreclosure_date := left.BJL.last_foreclosure_date;
																	self.foreclosure_flag := left.BJL.foreclosure_flag;
																	self.date_last_arrest := left.BJL.date_last_arrest;
																	self.arrests_count60 := left.BJL.arrests_count60;
																	self.arrests_count36 := left.BJL.arrests_count36;
																	self.arrests_count24 := left.BJL.arrests_count24;
																	self.arrests_count12 := left.BJL.arrests_count12;
																	self.arrests_count180 := left.BJL.arrests_count180;
																	self.arrests_count90 := left.BJL.arrests_count90;
																	self.arrests_count30 := left.BJL.arrests_count30;
																	self.arrests_count := left.BJL.arrests_count;
																	self.last_eviction_date := left.BJL.last_eviction_date;
																	self.eviction_count60 := left.BJL.eviction_count60;
																	self.eviction_count36 := left.BJL.eviction_count36;
																	self.eviction_count24 := left.BJL.eviction_count24;
																	self.eviction_count12 := left.BJL.eviction_count12;
																	self.eviction_count180 := left.BJL.eviction_count180;
																	self.eviction_count90 := left.BJL.eviction_count90;
																	self.eviction_count30 := left.BJL.eviction_count30;
																	self.eviction_count := left.BJL.eviction_count;
																	self.eviction_historical_released_count := left.BJL.eviction_historical_released_count;
																	self.eviction_recent_released_count := left.BJL.eviction_recent_released_count;
																	self.eviction_historical_unreleased_count := left.BJL.eviction_historical_unreleased_count;
																	self.eviction_recent_unreleased_count := left.BJL.eviction_recent_unreleased_count;
													
																	self.last_nonfelony_criminal_date := left.BJL.last_nonfelony_criminal_date;
																	self.nonfelony_criminal_count12 := left.BJL.nonfelony_criminal_count12;
																	self.last_felony_date := left.BJL.last_felony_date;
																	self.felony_count := left.BJL.felony_count;
																  self.last_criminal_date := left.BJL.last_criminal_date;
																	self.criminal_count60 := left.BJL.criminal_count60;
																	self.criminal_count36 := left.BJL.criminal_count36;
																	self.criminal_count24 := left.BJL.criminal_count24;
																	self.criminal_count12 := left.BJL.criminal_count12;
																	self.criminal_count180 := left.BJL.criminal_count180;
																	self.criminal_count90 := left.BJL.criminal_count90;
																	self.criminal_count30 := left.BJL.criminal_count30;
																	self.criminal_count := left.BJL.criminal_count;

																	self.last_liens_released_date := left.BJL.last_liens_released_date;
																	self.liens_released_count60 := left.BJL.liens_released_count60;
																	self.liens_released_count36 := left.BJL.liens_released_count36;
																	self.liens_released_count24 := left.BJL.liens_released_count24;
																	self.liens_released_count12 := left.BJL.liens_released_count12;
																	self.liens_released_count180 := left.BJL.liens_released_count180;
																	self.liens_released_count90 := left.BJL.liens_released_count90;
																	self.liens_released_count30 := left.BJL.liens_released_count30;
																	self.liens_historical_released_count := left.BJL.liens_historical_released_count;
																	self.liens_recent_released_count := left.BJL.liens_recent_released_count;
																	
																	self.last_liens_unreleased_date := left.BJL.last_liens_unreleased_date;
																	self.liens_unreleased_count60 := left.BJL.liens_unreleased_count60;
																	self.liens_unreleased_count36 := left.BJL.liens_unreleased_count36;
																	self.liens_unreleased_count24 := left.BJL.liens_unreleased_count24;
																	self.liens_unreleased_count12 := left.BJL.liens_unreleased_count12;
																	self.liens_unreleased_count180 := left.BJL.liens_unreleased_count180;
																	self.liens_unreleased_count90 := left.BJL.liens_unreleased_count90;
																	self.liens_unreleased_count30 := left.BJL.liens_unreleased_count30;
																	self.liens_historical_unreleased_count := left.BJL.liens_historical_unreleased_count;
																	self.liens_recent_unreleased_count := left.BJL.liens_recent_unreleased_count;
																	
																	self.bk_chapter := left.BJL.bk_chapter;
																	self.bk_count60 := left.BJL.bk_count60;
																	self.bk_count36 := left.BJL.bk_count36;
																	self.bk_count24 := left.BJL.bk_count24;
																	self.bk_count12 := left.BJL.bk_count12;
																	self.bk_count180 := left.BJL.bk_count180;
																	self.bk_count90 := left.BJL.bk_count90;
																	self.bk_count30 := left.BJL.bk_count30;
																	self.bk_disposed_historical_count := left.BJL.bk_disposed_historical_count;
																	self.bk_disposed_recent_count := left.BJL.bk_disposed_recent_count;
																	self.bk_dismissed_historical_count := left.BJL.bk_dismissed_historical_count;
																	self.bk_dismissed_recent_count := left.BJL.bk_dismissed_recent_count;
																	self.bk_recent_count := left.BJL.bk_recent_count;
																	self.filing_count := left.BJL.filing_count;
																	self.disposition := left.BJL.disposition;
																	self.filing_type := left.BJL.filing_type;
																	self.date_last_seen := left.BJL.date_last_seen;
																	self.bankrupt := left.BJL.bankrupt;
	

//Impulse
																	self.annual_income := left.Impulse.annual_income;
																	self.count60 := left.Impulse.count60;
																	self.count36 := left.Impulse.count36;
																	self.count24 := left.Impulse.count24;
																	self.count12 := left.Impulse.count12;
																	self.count180 := left.Impulse.count180;
																	self.count90 := left.Impulse.count90;
																	self.count30 := left.Impulse.count30;
																	self.siteid := left.Impulse.siteid;
																	self.last_seen_date := left.Impulse.last_seen_date;
																	self.first_seen_date := left.Impulse.first_seen_date;
																	self.imp_count := left.Impulse.count;
																	
//Infutor
																	self.infutor_date_first_seen := left.Infutor.infutor_date_first_seen;
																	self.infutor_date_last_seen := left.Infutor.infutor_date_last_seen;
																	self.infutor_nap := left.Infutor.infutor_nap;

//Infutor_Phone
																	self.Infutor_Phone_infutor_date_first_seen := left.Infutor_Phone.infutor_date_first_seen;
																	self.Infutor_Phone_infutor_date_last_seen := left.Infutor_Phone.infutor_date_last_seen;
																	self.Infutor_Phone_infutor_nap := left.Infutor_Phone.infutor_nap;																	

//Velocity_Counters
																	self.adls_per_phone := left.Velocity_Counters.adls_per_phone;
																	self.adls_per_phone_current := left.Velocity_Counters.adls_per_phone_current;
																	self.adls_per_phone_created_6months := left.Velocity_Counters.adls_per_phone_created_6months;
																	self.adls_per_phone_multiple_use := left.Velocity_Counters.adls_per_phone_multiple_use;
																	self.addrs_per_phone := left.Velocity_Counters.addrs_per_phone;
																	self.addrs_per_phone_created_6months := left.Velocity_Counters.addrs_per_phone_created_6months;
																	self.suspicious_adls_per_addr_created_6months := left.Velocity_Counters.suspicious_adls_per_addr_created_6months;
																	self.phones_per_addr_multiple_use := left.Velocity_Counters.phones_per_addr_multiple_use;
																	self.ssns_per_addr_multiple_use := left.Velocity_Counters.ssns_per_addr_multiple_use;
																	self.adls_per_addr_multiple_use := left.Velocity_Counters.adls_per_addr_multiple_use;
																	self.phones_per_addr_created_6months := left.Velocity_Counters.phones_per_addr_created_6months;
																	self.ssns_per_addr_created_6months := left.Velocity_Counters.ssns_per_addr_created_6months;
																	self.adls_per_addr_created_6months := left.Velocity_Counters.adls_per_addr_created_6months;
																	self.phones_per_addr_current := left.Velocity_Counters.phones_per_addr_current;
																	self.ssns_per_addr_current := left.Velocity_Counters.ssns_per_addr_current;
																	self.adls_per_addr_current := left.Velocity_Counters.adls_per_addr_current;
																	self.phones_per_addr := left.Velocity_Counters.phones_per_addr;
																	self.ssns_per_addr := left.Velocity_Counters.ssns_per_addr;
																	self.adls_per_addr := left.Velocity_Counters.adls_per_addr;
																	self.adls_per_ssn_multiple_use_non_relative := left.Velocity_Counters.adls_per_ssn_multiple_use_non_relative;
																	self.adls_per_ssn_multiple_use := left.Velocity_Counters.adls_per_ssn_multiple_use;
																	self.addrs_per_ssn_multiple_use := left.Velocity_Counters.addrs_per_ssn_multiple_use;
																	self.lnames_per_ssn_created_6months := left.Velocity_Counters.lnames_per_ssn_created_6months;
																	self.lnames_per_ssn := left.Velocity_Counters.lnames_per_ssn;
																	self.adls_per_ssn_seen_18months := left.Velocity_Counters.adls_per_ssn_seen_18months;
																	self.addrs_per_ssn_created_6months := left.Velocity_Counters.addrs_per_ssn_created_6months;
																	self.adls_per_ssn_created_6months := left.Velocity_Counters.adls_per_ssn_created_6months;
																	self.addrs_per_ssn := left.Velocity_Counters.addrs_per_ssn;
																  self.pl_addrs_per_adl := left.Velocity_Counters.pl_addrs_per_adl;
																	self.vo_addrs_per_adl := left.Velocity_Counters.vo_addrs_per_adl;
																	self.dl_addrs_per_adl := left.Velocity_Counters.dl_addrs_per_adl;
																	self.invalid_addrs_per_adl_created_6months := left.Velocity_Counters.invalid_addrs_per_adl_created_6months;
																	self.invalid_phones_per_adl_created_6months := left.Velocity_Counters.invalid_phones_per_adl_created_6months;
																	self.invalid_ssns_per_adl_created_6months := left.Velocity_Counters.invalid_ssns_per_adl_created_6months;
																	self.invalid_addrs_per_adl := left.Velocity_Counters.invalid_addrs_per_adl;
																	self.invalid_phones_per_adl := left.Velocity_Counters.invalid_phones_per_adl;
																	self.invalid_ssns_per_adl := left.Velocity_Counters.invalid_ssns_per_adl;
																	self.lnames_per_adl60 := left.Velocity_Counters.lnames_per_adl60;
																	self.lnames_per_adl36 := left.Velocity_Counters.lnames_per_adl36;
																	self.lnames_per_adl24 := left.Velocity_Counters.lnames_per_adl24;
																	self.lnames_per_adl12 := left.Velocity_Counters.lnames_per_adl12;
																	self.lnames_per_adl180 := left.Velocity_Counters.lnames_per_adl180;
																	self.lnames_per_adl90 := left.Velocity_Counters.lnames_per_adl90;
																	self.lnames_per_adl30 := left.Velocity_Counters.lnames_per_adl30;
																	self.lnames_per_adl := left.Velocity_Counters.lnames_per_adl;
																	self.ssns_per_adl_multiple_use_non_relative := left.Velocity_Counters.ssns_per_adl_multiple_use_non_relative;
																	self.ssns_per_adl_multiple_use := left.Velocity_Counters.ssns_per_adl_multiple_use;
																	self.ssns_per_adl_seen_18months := left.Velocity_Counters.ssns_per_adl_seen_18months;
																	self.dobs_per_adl_created_6months := left.Velocity_Counters.dobs_per_adl_created_6months;
																	self.phones_per_adl_created_6months := left.Velocity_Counters.phones_per_adl_created_6months;
																	self.addrs_per_adl_created_6months := left.Velocity_Counters.addrs_per_adl_created_6months;
																	self.ssns_per_adl_created_6months := left.Velocity_Counters.ssns_per_adl_created_6months;
																	self.dobs_per_adl := left.Velocity_Counters.dobs_per_adl;
																	self.phones_per_adl := left.Velocity_Counters.phones_per_adl;
																	self.addrs_per_adl := left.Velocity_Counters.addrs_per_adl;
																	self.ssns_per_adl := left.Velocity_Counters.ssns_per_adl;

//employment
																	self.company_title := left.employment.company_title;
																	self.emp_First_seen_date := left.employment.First_seen_date;
																	self.Business_ct := left.employment.Business_ct;
																	self.Dead_business_ct := left.employment.Dead_business_ct;
																	self.Business_active_phone_ct := left.employment.Business_active_phone_ct;
																	self.Source_ct := left.employment.Source_ct;

//address_history_summary
																	self.address_history_college_evidence := left.address_history_summary.address_history_college_evidence;
																	self.input_addr_last_seen := left.address_history_summary.input_addr_last_seen;
																	self.input_addr_first_seen := left.address_history_summary.input_addr_first_seen;
																	self.hist_addr_match := left.address_history_summary.hist_addr_match;
																	self.lres_12mo_count := left.address_history_summary.lres_12mo_count;
																	self.lres_6mo_count := left.address_history_summary.lres_6mo_count;
																	self.lres_2mo_count := left.address_history_summary.lres_2mo_count;
																	self.addr_count10 := left.address_history_summary.addr_count10;
																	self.addr_count6 := left.address_history_summary.addr_count6;
																	self.addr_count3 := left.address_history_summary.addr_count3;
																	self.addr_count2 := left.address_history_summary.addr_count2;
																	self.avg_mo_per_addr := left.address_history_summary.avg_mo_per_addr;
																	self.unique_addr_cnt := left.address_history_summary.unique_addr_cnt;
																	self.address_history_advo_college_hit := left.address_history_summary.address_history_advo_college_hit;
																	

//addr_risk_summary	
																	self.N_ave_no_of_baths_count := left.addr_risk_summary.N_ave_no_of_baths_count;
																	self.N_ave_no_of_bedrooms_count := left.addr_risk_summary.N_ave_no_of_bedrooms_count;
																	self.N_ave_no_of_rooms_count := left.addr_risk_summary.N_ave_no_of_rooms_count;
																	self.N_ave_no_of_stories_count := left.addr_risk_summary.N_ave_no_of_stories_count;
																	self.N_ave_price_per_sf := left.addr_risk_summary.N_ave_price_per_sf;
																	self.N_ave_building_area := left.addr_risk_summary.N_ave_building_area;
																	self.N_ave_assessed_amount := left.addr_risk_summary.N_ave_assessed_amount;
																	self.N_ave_mortgage_amount := left.addr_risk_summary.N_ave_mortgage_amount;
																	self.N_ave_purchase_amount := left.addr_risk_summary.N_ave_purchase_amount;
																	self.N_ave_building_age := left.addr_risk_summary.N_ave_building_age;
																	self.N_MFD_Count := left.addr_risk_summary.N_MFD_Count;
																	self.N_SFD_Count := left.addr_risk_summary.N_SFD_Count;
																	self.N_Business_Count := left.addr_risk_summary.N_Business_Count;
																	self.N_Vacant_Properties := left.addr_risk_summary.N_Vacant_Properties;
																	self.turnover_1yr_out := left.addr_risk_summary.turnover_1yr_out;
																	self.turnover_1yr_in := left.addr_risk_summary.turnover_1yr_in;
																	self.occupants_1yr := left.addr_risk_summary.occupants_1yr ;
																	
//addr_risk_summary2	
																	self.ar2_N_ave_no_of_baths_count := left.addr_risk_summary2.N_ave_no_of_baths_count;
																	self.ar2_N_ave_no_of_bedrooms_count := left.addr_risk_summary2.N_ave_no_of_bedrooms_count;
																	self.ar2_N_ave_no_of_rooms_count := left.addr_risk_summary2.N_ave_no_of_rooms_count;
																	self.ar2_N_ave_no_of_stories_count := left.addr_risk_summary2.N_ave_no_of_stories_count;
																	self.ar2_N_ave_price_per_sf := left.addr_risk_summary2.N_ave_price_per_sf;
																	self.ar2_N_ave_building_area := left.addr_risk_summary2.N_ave_building_area;
																	self.ar2_N_ave_assessed_amount := left.addr_risk_summary2.N_ave_assessed_amount;
																	self.ar2_N_ave_mortgage_amount := left.addr_risk_summary2.N_ave_mortgage_amount;
																	self.ar2_N_ave_purchase_amount := left.addr_risk_summary2.N_ave_purchase_amount;
																	self.ar2_N_ave_building_age := left.addr_risk_summary2.N_ave_building_age;
																	self.ar2_N_MFD_Count := left.addr_risk_summary2.N_MFD_Count;
																	self.ar2_N_SFD_Count := left.addr_risk_summary2.N_SFD_Count;
																	self.ar2_N_Business_Count := left.addr_risk_summary2.N_Business_Count;
																	self.ar2_N_Vacant_Properties := left.addr_risk_summary2.N_Vacant_Properties;
																	self.ar2_turnover_1yr_out := left.addr_risk_summary2.turnover_1yr_out;
																	self.ar2_turnover_1yr_in := left.addr_risk_summary2.turnover_1yr_in;
																	self.ar2_occupants_1yr := left.addr_risk_summary2.occupants_1yr ;

//addr_risk_summary3	
																	self.ar3_N_ave_no_of_baths_count := left.addr_risk_summary3.N_ave_no_of_baths_count;
																	self.ar3_N_ave_no_of_bedrooms_count := left.addr_risk_summary3.N_ave_no_of_bedrooms_count;
																	self.ar3_N_ave_no_of_rooms_count := left.addr_risk_summary3.N_ave_no_of_rooms_count;
																	self.ar3_N_ave_no_of_stories_count := left.addr_risk_summary3.N_ave_no_of_stories_count;
																	self.ar3_N_ave_price_per_sf := left.addr_risk_summary3.N_ave_price_per_sf;
																	self.ar3_N_ave_building_area := left.addr_risk_summary3.N_ave_building_area;
																	self.ar3_N_ave_assessed_amount := left.addr_risk_summary3.N_ave_assessed_amount;
																	self.ar3_N_ave_mortgage_amount := left.addr_risk_summary3.N_ave_mortgage_amount;
																	self.ar3_N_ave_purchase_amount := left.addr_risk_summary3.N_ave_purchase_amount;
																	self.ar3_N_ave_building_age := left.addr_risk_summary3.N_ave_building_age;
																	self.ar3_N_MFD_Count := left.addr_risk_summary3.N_MFD_Count;
																	self.ar3_N_SFD_Count := left.addr_risk_summary3.N_SFD_Count;
																	self.ar3_N_Business_Count := left.addr_risk_summary3.N_Business_Count;
																	self.ar3_N_Vacant_Properties := left.addr_risk_summary3.N_Vacant_Properties;
																	self.ar3_turnover_1yr_out := left.addr_risk_summary3.turnover_1yr_out;
																	self.ar3_turnover_1yr_in := left.addr_risk_summary3.turnover_1yr_in;
																	self.ar3_occupants_1yr := left.addr_risk_summary3.occupants_1yr ;
																	

//iBehavior
																	self.Retail_Orders := left.iBehavior.Retail_Orders;
																	self.Retail_Dollars := left.iBehavior.Retail_Dollars;
																	self.Retail_Average_Amount_Per_Order := left.iBehavior.Retail_Average_Amount_Per_Order;
																	self.Online_Orders := left.iBehavior.Online_Orders;
																	self.Online_Dollars := left.iBehavior.Online_Dollars;
																	self.Online_Average_Amount_Per_Order := left.iBehavior.Online_Average_Amount_Per_Order;
																	self.Offline_Orders := left.iBehavior.Offline_Orders;
																	self.Offline_Dollars := left.iBehavior.Offline_Dollars;
																	self.Offline_Average_Amount_Per_Order := left.iBehavior.Offline_Average_Amount_Per_Order;
																	self.Total_Number_of_Orders := left.iBehavior.Total_Number_of_Orders;
																	self.Total_Dollars := left.iBehavior.Total_Dollars;
																	self.Average_Amount_Per_Order := left.iBehavior.Average_Amount_Per_Order;
																	self.Average_Days_Between_Orders := left.iBehavior.Average_Days_Between_Orders;
																	self.number_of_sources := left.iBehavior.number_of_sources;
																	self.Last_Order_Date := left.iBehavior.Last_Order_Date;
																	self.First_Order_Date := left.iBehavior.First_Order_Date;
																	self.Cnsmr_date_last_seen := left.iBehavior.Cnsmr_date_last_seen ;
																	self.Cnsmr_date_first_seen := left.iBehavior.Cnsmr_date_first_seen;
																																		

//fdAttributesv2
																	self.PrevAddrCrimeIndex := left.fdAttributesv2.PrevAddrCrimeIndex;
																	self.PrevAddrBurglaryIndex := left.fdAttributesv2.PrevAddrBurglaryIndex;
																	self.PrevAddrCarTheftIndex := left.fdAttributesv2.PrevAddrCarTheftIndex;
																	self.PrevAddrMurderIndex := left.fdAttributesv2.PrevAddrMurderIndex;
																	self.PrevAddrMedianValue := left.fdAttributesv2.PrevAddrMedianValue;
																	self.PrevAddrMedianIncome := left.fdAttributesv2.PrevAddrMedianIncome;
																	self.PrevAddrOccupantOwned := left.fdAttributesv2.PrevAddrOccupantOwned;
																	self.PrevAddrStatus := left.fdAttributesv2.PrevAddrStatus;
																	self.PrevAddrDwellType := left.fdAttributesv2.PrevAddrDwellType;
																	self.PrevAddrLenOfRes := left.fdAttributesv2.PrevAddrLenOfRes;
																	self.PrevAddrAgeOldest := left.fdAttributesv2.PrevAddrAgeOldest;
																	self.CurrAddrCrimeIndex := left.fdAttributesv2.CurrAddrCrimeIndex;
																	self.CurrAddrBurglaryIndex := left.fdAttributesv2.CurrAddrBurglaryIndex;
																	self.CurrAddrCarTheftIndex := left.fdAttributesv2.CurrAddrCarTheftIndex;
																	self.CurrAddrMurderIndex := left.fdAttributesv2.CurrAddrMurderIndex;
																	self.CurrAddrMedianValue := left.fdAttributesv2.CurrAddrMedianValue;
																	self.CurrAddrMedianIncome := left.fdAttributesv2.CurrAddrMedianIncome ;
																	self.CurrAddrActivePhoneList := left.fdAttributesv2.CurrAddrActivePhoneList;
																	self.AddrChangeEconTrajectoryIndex := left.fdAttributesv2.AddrChangeEconTrajectoryIndex;
																	self.AddrChangeEconTrajectory := left.fdAttributesv2.AddrChangeEconTrajectory ;
																	self.AddrChangeCrimeDiff := left.fdAttributesv2.AddrChangeCrimeDiff ;
																	self.AddrChangeValueDiff := left.fdAttributesv2.AddrChangeValueDiff;
																	self.AddrChangeIncomeDiff := left.fdAttributesv2.AddrChangeIncomeDiff;
																	self.InputAddrActivePhoneList := left.fdAttributesv2.InputAddrActivePhoneList;
																	self.ComponentCharRiskLevel := left.fdAttributesv2.ComponentCharRiskLevel;
																	self.SearchPhoneSearchCountDay := left.fdAttributesv2.SearchPhoneSearchCountDay;
																	self.SearchPhoneSearchCountWeek := left.fdAttributesv2.SearchPhoneSearchCountWeek;
																	self.SearchPhoneSearchCountMonth := left.fdAttributesv2.SearchPhoneSearchCountMonth;
																	self.SearchPhoneSearchCount := left.fdAttributesv2.SearchPhoneSearchCount;
																	self.SearchAddrSearchCountDay := left.fdAttributesv2.SearchAddrSearchCountDay;
																	self.SearchAddrSearchCountWeek := left.fdAttributesv2.SearchAddrSearchCountWeek ;
																	self.SearchAddrSearchCountMonth := left.fdAttributesv2.SearchAddrSearchCountMonth;
																	self.SearchAddrSearchCount := left.fdAttributesv2.SearchAddrSearchCount ;
																	self.SearchSSNSearchCountDay := left.fdAttributesv2.SearchSSNSearchCountDay ;
																	self.SearchSSNSearchCountWeek := left.fdAttributesv2.SearchSSNSearchCountWeek;
																	self.SearchSSNSearchCountMonth := left.fdAttributesv2.SearchSSNSearchCountMonth;
																	self.SearchSSNSearchCount := left.fdAttributesv2.SearchSSNSearchCount;
																	self.SearchComponentRiskLevel := left.fdAttributesv2.SearchComponentRiskLevel;
																	self.DivSearchAddrSuspIdentityCount := left.fdAttributesv2.DivSearchAddrSuspIdentityCount;
																	self.DivAddrSuspIdentityCountNew := left.fdAttributesv2.DivAddrSuspIdentityCountNew;
																	self.DivSSNIdentityMSourceUrelCount := left.fdAttributesv2.DivSSNIdentityMSourceUrelCount;
																	self.DivRiskLevel := left.fdAttributesv2.DivRiskLevel;
																	self.CorrelationPhoneLastNameCount := left.fdAttributesv2.CorrelationPhoneLastNameCount ;
																	self.CorrelationAddrPhoneCount := left.fdAttributesv2.CorrelationAddrPhoneCount;
																	self.CorrelationAddrNameCount := left.fdAttributesv2.CorrelationAddrNameCount;
																	self.CorrelationSSNAddrCount := left.fdAttributesv2.CorrelationSSNAddrCount ;
																	self.CorrelationSSNNameCount := left.fdAttributesv2.CorrelationSSNNameCount ;
																	self.CorrelationRiskLevel := left.fdAttributesv2.CorrelationRiskLevel;
																	self.ValidationRiskLevel := left.fdAttributesv2.ValidationRiskLevel ;
																	self.AssocCreditBureauOnlyCountMonth := left.fdAttributesv2.AssocCreditBureauOnlyCountMonth;
																	self.AssocCreditBureauOnlyCountNew := left.fdAttributesv2.AssocCreditBureauOnlyCountNew;
																	self.AssocCreditBureauOnlyCount := left.fdAttributesv2.AssocCreditBureauOnlyCount ;
																	self.AssocSuspicousIdentitiesCount := left.fdAttributesv2.AssocSuspicousIdentitiesCount ;
																	self.AssocRiskLevel := left.fdAttributesv2.AssocRiskLevel;
																	self.SearchLocateSearchCountDay := left.fdAttributesv2.SearchLocateSearchCountDay;
																	self.SearchLocateSearchCountWeek := left.fdAttributesv2.SearchLocateSearchCountWeek;
																	self.SearchFraudSearchCountDay := left.fdAttributesv2.SearchFraudSearchCountDay;
																	self.SearchFraudSearchCountWeek := left.fdAttributesv2.SearchFraudSearchCountWeek;
																	self.SearchFraudSearchCountMonth := left.fdAttributesv2.SearchFraudSearchCountMonth;
																	self.SearchFraudSearchCountYear := left.fdAttributesv2.SearchFraudSearchCountYear;
																	self.SearchFraudSearchCount := left.fdAttributesv2.SearchFraudSearchCount;
																	self.SearchUnverifiedPhoneCountYear := left.fdAttributesv2.SearchUnverifiedPhoneCountYear;
																	self.SearchUnverifiedDOBCountYear := left.fdAttributesv2.SearchUnverifiedDOBCountYear ;
																	self.SearchUnverifiedAddrCountYear := left.fdAttributesv2.SearchUnverifiedAddrCountYear;
																	self.SearchUnverifiedSSNCountYear := left.fdAttributesv2.SearchUnverifiedSSNCountYear ;
																	self.SearchCountDay := left.fdAttributesv2.SearchCountDay ;
																	self.SearchCountWeek := left.fdAttributesv2.SearchCountWeek;
																	self.SearchVelocityRiskLevel := left.fdAttributesv2.SearchVelocityRiskLevel;
																	self.VariationDOBCountNew := left.fdAttributesv2.VariationDOBCountNew;
																	self.VariationDOBCount := left.fdAttributesv2.VariationDOBCount;
																	self.VariationMSourcesSSNUnrelCount := left.fdAttributesv2.VariationMSourcesSSNUnrelCount;
																	self.VariationMSourcesSSNCount := left.fdAttributesv2.VariationMSourcesSSNCount;
																	self.VariationRiskLevel := left.fdAttributesv2.VariationRiskLevel;
																	self.SourceRiskLevel := left.fdAttributesv2.SourceRiskLevel;
																	self.IDVerAddressNotCurrent := left.fdAttributesv2.IDVerAddressNotCurrent ;
																	self.IDVerRiskLevel := left.fdAttributesv2.IDVerRiskLevel;
																	self.IdentityRiskLevel := left.fdAttributesv2.IdentityRiskLevel;
																		

//address_sources_summary
																	self.previous_addr_sources_recordcount := left.address_sources_summary.previous_addr_sources_recordcount;
																	self.previous_addr_sources_first_seen_date := left.address_sources_summary.previous_addr_sources_first_seen_date;
																	self.previous_addr_sources := left.address_sources_summary.previous_addr_sources;
																	self.current_addr_sources_recordcount := left.address_sources_summary.current_addr_sources_recordcount;
																	self.current_addr_sources_first_seen_date := left.address_sources_summary.current_addr_sources_first_seen_date;
																	self.current_addr_sources := left.address_sources_summary.current_addr_sources;
																	self.input_addr_sources_first_seen_date := left.address_sources_summary.input_addr_sources_first_seen_date;
																	self.input_addr_sources := left.address_sources_summary.input_addr_sources;
																	self.input_addr_sources_recordcount := left.address_sources_summary.input_addr_sources_recordcount;
																	

//insurance_phones_summary
																	self.Insurance_Phone_Verification := left.insurance_phones_summary.Insurance_Phone_Verification;
																	self.insurance_phones_phone_hit := left.insurance_phones_summary.insurance_phones_phone_hit;
																	self.insurance_phones_phonesearch_didmatch := left.insurance_phones_summary.insurance_phones_phonesearch_didmatch;
																	self.insurance_phones_did_hit := left.insurance_phones_summary.insurance_phones_did_hit;
																	self.insurance_phones_didsearch_phonematch := left.insurance_phones_summary.insurance_phones_didsearch_phonematch;


//hhid summary
																	self.hh_college_attendees := left.hhid_summary.hh_college_attendees;
																	self.hh_criminals := left.hhid_summary.hh_criminals;
																	self.hh_prof_license_holders := left.hhid_summary.hh_prof_license_holders;
																	self.hh_lienholders := left.hhid_summary.hh_lienholders;
																	self.hh_bankruptcies := left.hhid_summary.hh_bankruptcies;
																	self.hh_tot_derog := left.hhid_summary.hh_tot_derog;
																	self.hh_members_w_derog := left.hhid_summary.hh_members_w_derog;
																	self.hh_payday_loan_users := left.hhid_summary.hh_payday_loan_users;
																	self.hh_workers_paw := left.hhid_summary.hh_workers_paw;
																	self.hh_collections_ct := left.hhid_summary.hh_collections_ct;
																	self.hh_age_lt18 := left.hhid_summary.hh_age_lt18;
																	self.hh_age_18_to_30 := left.hhid_summary.hh_age_18_to_30;
																	self.hh_age_31_to_65 := left.hhid_summary.hh_age_31_to_65;
																	self.hh_age_65_plus := left.hhid_summary.hh_age_65_plus;
																	self.hh_property_owners_ct := left.hhid_summary.hh_property_owners_ct;
																	self.hh_members_ct := left.hhid_summary.hh_members_ct;
																	self.hhid := left.hhid_summary.hhid;

//AMLAttributes
																	self.BusAMLNegativeNews24 := left.AMLAttributes.BusAMLNegativeNews24;
																	self.BusAMLNegativeNews90 := left.AMLAttributes.BusAMLNegativeNews90;
																	self.BusIndustryRiskIndex := left.AMLAttributes.BusIndustryRiskIndex;
																	self.BusAssociatesIndex := left.AMLAttributes.BusAssociatesIndex;
																	self.BusGeographicIndex := left.AMLAttributes.BusGeographicIndex;
																	self.BusAccesstoFundsIndex := left.AMLAttributes.BusAccesstoFundsIndex;
																	self.BusLegalEventsIndex := left.AMLAttributes.BusLegalEventsIndex;
																	self.BusStabilityIndex := left.AMLAttributes.BusStabilityIndex;
																	self.BusValidityIndex := left.AMLAttributes.BusValidityIndex;
																	self.IndAMLNegativeNews24 := left.AMLAttributes.IndAMLNegativeNews24;
																	self.IndAMLNegativeNews90 := left.AMLAttributes.IndAMLNegativeNews90;
																	self.IndAgeRange := left.AMLAttributes.IndAgeRange;
																	self.IndAssociatesIndex := left.AMLAttributes.IndAssociatesIndex;
																	self.IndGeographicIndex := left.AMLAttributes.IndGeographicIndex;
																	self.IndHighValueAssetIndex := left.AMLAttributes.IndHighValueAssetIndex;
																	self.IndBusinessAssocationIndex := left.AMLAttributes.IndBusinessAssocationIndex;
																	self.IndAccesstoFundsIndex := left.AMLAttributes.IndAccesstoFundsIndex;
																	self.IndLegalEventsIndex := left.AMLAttributes.IndLegalEventsIndex;
																	self.IndMobilityIndex := left.AMLAttributes.IndMobilityIndex;
																	self.IndCitizenshipIndex := left.AMLAttributes.IndCitizenshipIndex;

//Professional_License
																	self.most_recent_sanction_type := left.Professional_License.most_recent_sanction_type;
																	self.sanctions_date_last_seen := left.Professional_License.sanctions_date_last_seen;
																	self.sanctions_date_first_seen := left.Professional_License.sanctions_date_first_seen;
																	self.sanctions_count := left.Professional_License.sanctions_count;
																	self.proflic_Source := left.Professional_License.proflic_Source;
																	self.expire_count60 := left.Professional_License.expire_count60;
																	self.expire_count36 := left.Professional_License.expire_count36;
																	self.expire_count24 := left.Professional_License.expire_count24;
																	self.expire_count12 := left.Professional_License.expire_count12;
																	self.expire_count180 := left.Professional_License.expire_count180;
																	self.expire_count90 := left.Professional_License.expire_count90;
																	self.expire_count30 := left.Professional_License.expire_count30;
																	self.proflic_count60 := left.Professional_License.proflic_count60;
																	self.proflic_count36 := left.Professional_License.proflic_count36;
																	self.proflic_count24 := left.Professional_License.proflic_count24;
																	self.proflic_count12 := left.Professional_License.proflic_count12;
																	self.proflic_count180 := left.Professional_License.proflic_count180;
																	self.proflic_count90 := left.Professional_License.proflic_count90;
																	self.proflic_count30 := left.Professional_License.proflic_count30;
																	self.expiration_date := left.Professional_License.expiration_date;
																	self.date_most_recent := left.Professional_License.date_most_recent;
																	self.proflic_count := left.Professional_License.proflic_count;
																	self.plCategory := left.Professional_License.plCategory;
																	self.jobCategory := left.Professional_License.jobCategory;
																	self.license_type := left.Professional_License.license_type;
																	self.professional_license_flag := left.Professional_License.professional_license_flag;


//Student
																	self.tuition_code := left.Student.tuition_code;
																	self.school_size_code := left.Student.school_size_code;
																	self.competitive_code := left.Student.competitive_code;
																	self.college_major := left.Student.college_major;
																	self.COLLEGE_TIER := left.Student.COLLEGE_TIER;
																	self.rec_type := left.Student.rec_type;
																	self.FILE_TYPE2 := left.Student.FILE_TYPE2;
																	self.FILE_TYPE := left.Student.FILE_TYPE;
																	self.INCOME_LEVEL_CODE := left.Student.INCOME_LEVEL_CODE;
																	self.COLLEGE_TYPE := left.Student.COLLEGE_TYPE;
																	self.COLLEGE_CODE := left.Student.COLLEGE_CODE;
																	self.COLLEGE_NAME := left.Student.COLLEGE_NAME;
																	self.CLASS := left.Student.CLASS;
																	self.DOB_FORMATTED := left.Student.DOB_FORMATTED;
																	self.STUDENT_AGE := left.Student.AGE;
																	self.ADDRESS_TYPE_CODE := left.Student.ADDRESS_TYPE_CODE;
																	self.CRRT_CODE := left.Student.CRRT_CODE;
																	self.STUDENT_DATE_LAST_SEEN := left.Student.DATE_LAST_SEEN;
																	self.STUDENT_DATE_FIRST_SEEN := left.Student.DATE_FIRST_SEEN;


//Aircraft
																	self.aircraft_count := left.AirCraft.aircraft_count;
																	self.aircraft_count30 := left.AirCraft.aircraft_count30;
																	self.aircraft_count90 := left.AirCraft.aircraft_count90;
																	self.aircraft_count180 := left.AirCraft.aircraft_count180;
																	self.aircraft_count12 := left.AirCraft.aircraft_count12;
																	self.aircraft_count24 := left.AirCraft.aircraft_count24;
																	self.aircraft_count36 := left.AirCraft.aircraft_count36;
																	self.aircraft_count60 := left.AirCraft.aircraft_count60;
																	self.n_number := left.AirCraft.n_number;
																	self.date_first_seen := left.AirCraft.date_first_seen;

//Other_Address_Info
																		self.unverified_addr_count := left.Other_Address_Info.unverified_addr_count;
																	self.num_sold60 := left.Other_Address_Info.num_sold60;
																	self.num_sold36 := left.Other_Address_Info.num_sold36;
																	self.num_sold24 := left.Other_Address_Info.num_sold24;
																	self.num_sold12 := left.Other_Address_Info.num_sold12;
																	self.num_sold180 := left.Other_Address_Info.num_sold180;
																	self.num_sold90 := left.Other_Address_Info.num_sold90;
																	self.num_sold30 := left.Other_Address_Info.num_sold30;
																	self.date_most_recent_sale := left.Other_Address_Info.date_most_recent_sale;
																	self.date_first_sale := left.Other_Address_Info.date_first_sale;
																	self.num_purchase60 := left.Other_Address_Info.num_purchase60;
																	self.num_purchase36 := left.Other_Address_Info.num_purchase36;
																	self.num_purchase24 := left.Other_Address_Info.num_purchase24;
																	self.num_purchase12 := left.Other_Address_Info.num_purchase12;
																	self.num_purchase180 := left.Other_Address_Info.num_purchase180;
																	self.num_purchase90 := left.Other_Address_Info.num_purchase90;
																	self.num_purchase30 := left.Other_Address_Info.num_purchase30 ;
																	self.date_most_recent_purchase := left.Other_Address_Info.date_most_recent_purchase;
																	self.date_first_purchase := left.Other_Address_Info.date_first_purchase;
																	self.addrs_last36 := left.Other_Address_Info.addrs_last36 ;
																	self.addrs_last24 := left.Other_Address_Info.addrs_last24 ;
																	self.addrs_last12 := left.Other_Address_Info.addrs_last12;
																	self.addrs_last90 := left.Other_Address_Info.addrs_last90;
																	self.addrs_last30 := left.Other_Address_Info.addrs_last30;
																	self.hist2_isPrison := left.Other_Address_Info.hist2_isPrison;
																	self.hist1_isPrison := left.Other_Address_Info.hist1_isPrison;
																	self.prisonFSdate := left.Other_Address_Info.prisonFSdate;
																	self.isPrison := left.Other_Address_Info.isPrison;
																	self.addrs_last_15years := left.Other_Address_Info.addrs_last_15years;
																	self.addrs_last_10years := left.Other_Address_Info.addrs_last_10years;
																	self.addrs_last_5years := left.Other_Address_Info.addrs_last_5years ;
																	self.avg_lres := left.Other_Address_Info.avg_lres;
																	self.max_lres := left.Other_Address_Info.max_lres ;


//Available_Sources
																	self.DL := left.Available_Sources.DL;
																	self.Voter := left.Available_Sources.Voter;

//Source Verification
																	self.num_nonderogs60 := left.Source_Verification.num_nonderogs60;
																	self.num_nonderogs36 := left.Source_Verification.num_nonderogs36;
																	self.num_nonderogs24 := left.Source_Verification.num_nonderogs24;
																	self.num_nonderogs12 := left.Source_Verification.num_nonderogs12;
																	self.num_nonderogs180 := left.Source_Verification.num_nonderogs180;
																	self.num_nonderogs90 := left.Source_Verification.num_nonderogs90;
																	self.num_nonderogs30 := left.Source_Verification.num_nonderogs30;
																	self.num_nonderogs := left.Source_Verification.num_nonderogs;
																	self.em_only_sources := left.Source_Verification.em_only_sources;
																	self.socssources := left.Source_Verification.socssources;
																	self.addrsources := left.Source_Verification.addrsources;
																	self.lastnamesources := left.Source_Verification.lastnamesources;
																	self.firstnamesources := left.Source_Verification.firstnamesources;
																	self.adl_W_last_seen := left.Source_Verification.adl_W_last_seen;
																	self.adl_EM_only_last_seen := left.Source_Verification.adl_EM_only_last_seen;
																	self.adl_VO_last_seen := left.Source_Verification.adl_VO_last_seen;
																	self.adl_EM_last_seen := left.Source_Verification.adl_EM_last_seen ;
																	self.adl_V_last_seen := left.Source_Verification.adl_V_last_seen;
																	self.adl_PR_last_seen := left.Source_Verification.adl_PR_last_seen;
																	self.adl_DL_last_seen := left.Source_Verification.adl_DL_last_seen ;
																	self.adl_TU_last_seen := left.Source_Verification.adl_TU_last_seen ;
																	self.adl_en_last_seen := left.Source_Verification.adl_en_last_seen;
																	self.adl_EQfs_last_seen := left.Source_Verification.adl_EQfs_last_seen;
																	self.adl_W_first_seen := left.Source_Verification.adl_W_first_seen;
																	self.adl_EM_only_first_seen := left.Source_Verification.adl_EM_only_first_seen;
																	self.adl_VO_first_seen := left.Source_Verification.adl_VO_first_seen;
																	self.adl_EM_first_seen := left.Source_Verification.adl_EM_first_seen;
																	self.adl_V_first_seen := left.Source_Verification.adl_V_first_seen;
																	self.adl_PR_first_seen := left.Source_Verification.adl_PR_first_seen;
																	self.adl_DL_first_seen := left.Source_Verification.adl_DL_first_seen;
																	self.adl_TU_first_seen := left.Source_Verification.adl_TU_first_seen ;
																	self.adl_en_first_seen := left.Source_Verification.adl_en_first_seen;
																	self.adl_EQfs_first_seen := left.Source_Verification.adl_EQfs_first_seen ;
																	self.EM_only_count := left.Source_Verification.EM_only_count ;
																	self.W_count := left.Source_Verification.W_count;
																	self.VO_count := left.Source_Verification.VO_count;
																	self.EM_count := left.Source_Verification.EM_count;
																	self.V_count := left.Source_Verification.V_count;
																	self.PR_count := left.Source_Verification.PR_count;
																	self.DL_count := left.Source_Verification.DL_count;
																	self.TU_count := left.Source_Verification.TU_count;
																	self.EN_count := left.Source_Verification.EN_count;
																	self.EQ_count := left.Source_Verification.EQ_count ;
																	

//Address validation
																  self.USPS_Deliverable := left.Address_Validation.USPS_Deliverable;
																	self.Dwelling_Type := left.Address_Validation.Dwelling_Type;
																	self.Zip_Type := left.Address_Validation.Zip_Type;
																	self.HR_Address := left.Address_Validation.HR_Address;
																	self.HR_Company := left.Address_Validation.HR_Company;
																	self.Error_Codes := left.Address_Validation.Error_Codes;
																	self.ADDRESS_Validation_Corrections := left.Address_Validation.Corrections;

//RV SCORES																
																	self.prescreenV4 := left.rv_scores.prescreenV4;
																	self.reason5mV4 := left.rv_scores.reason5mV4;
																	self.reason4mV4 := left.rv_scores.reason4mV4;
																	self.reason3mV4 := left.rv_scores.reason3mV4;
																	self.reason2mV4 := left.rv_scores.reason2mV4;
																	self.reason1mV4 := left.rv_scores.reason1mV4;
																	self.msbV4 := left.rv_scores.msbV4;
																	self.reason5tV4 := left.rv_scores.reason5tV4;
																	self.reason4tV4 := left.rv_scores.reason4tV4;
																	self.reason3tV4 := left.rv_scores.reason3tV4;
																	self.reason2tV4 := left.rv_scores.reason2tV4;
																	self.reason1tV4 := left.rv_scores.reason1tV4;
																	self.telecomV4 := left.rv_scores.telecomV4;
																	self.reason5aV4 := left.rv_scores.reason5aV4;
																	self.reason4aV4 := left.rv_scores.reason4aV4;
																	self.reason3aV4 := left.rv_scores.reason3aV4;
																	self.reason2aV4 := left.rv_scores.reason2aV4 ;
																	self.reason1aV4 := left.rv_scores.reason1aV4;
																	self.autoV4 := left.rv_scores.autoV4;
																	self.reason5rV4 := left.rv_scores.reason5rV4 ;
																	self.reason4rV4 := left.rv_scores.reason4rV4 ;
																	self.reason3rV4 := left.rv_scores.reason3rV4;
																	self.reason2rV4 := left.rv_scores.reason2rV4;
																	self.reason1rV4 := left.rv_scores.reason1rV4;
																	self.retailV4 := left.rv_scores.retailV4;
																	self.reason5bV4 := left.rv_scores.reason5bV4;
																	self.reason4bV4 := left.rv_scores.reason4bV4;
																	self.reason3bV4 := left.rv_scores.reason3bV4;
																	self.reason2bV4 := left.rv_scores.reason2bV4;
																	self.reason1bV4 := left.rv_scores.reason1bV4;
																	self.bankcardV4 := left.rv_scores.bankcardV4 ;
																	self.prescreenV3 := left.rv_scores.prescreenV3;
																	self.reason4mV3 := left.rv_scores.reason4mV3 ;
																	self.reason3mV3 := left.rv_scores.reason3mV3 ;
																	self.reason2mV3 := left.rv_scores.reason2mV3;
																	self.reason1mV3 := left.rv_scores.reason1mV3;
																	self.msbV3 := left.rv_scores.msbV3;
																	self.reason4tV3 := left.rv_scores.reason4tV3;
																	self.reason3tV3 := left.rv_scores.reason3tV3;
																	self.reason2tV3 := left.rv_scores.reason2tV3;
																	self.reason1tV3 := left.rv_scores.reason1tV3;
																	self.telecomV3 := left.rv_scores.telecomV3;
																	self.reason4aV3 := left.rv_scores.reason4aV3 ;
																	self.reason3aV3 := left.rv_scores.reason3aV3;
																	self.reason2aV3 := left.rv_scores.reason2aV3;
																	self.reason1aV3 := left.rv_scores.reason1aV3 ;
																	self.autoV3 := left.rv_scores.autoV3 ;
																	self.reason4rV3 := left.rv_scores.reason4rV3;
																	self.reason3rV3 := left.rv_scores.reason3rV3;
																	self.reason2rV3 := left.rv_scores.reason2rV3;
																	self.reason1rV3 := left.rv_scores.reason1rV3;
																	self.retailV3 := left.rv_scores.retailV3;
																	self.reason4bV3 := left.rv_scores.reason4bV3 ;
																	self.reason3bV3 := left.rv_scores.reason3bV3;
																	self.reason2bV3 := left.rv_scores.reason2bV3;
																	self.reason1bV3 := left.rv_scores.reason1bV3 ;
																	self.bankcardV3 := left.rv_scores.bankcardV3 ;
																	self.reason4V2 := left.rv_scores.reason4V2;
																	self.reason3V2 := left.rv_scores.reason3V2;
																	self.reason2V2 := left.rv_scores.reason2V2;
																	self.reason1V2 := left.rv_scores.reason1V2;
																	self.prescreenV2 := left.rv_scores.prescreenV2;
																	self.msbV2 := left.rv_scores.msbV2 ;
																	self.telecomV2 := left.rv_scores.telecomV2;
																	self.autoV2 := left.rv_scores.autoV2;
																	self.retailV2 := left.rv_scores.retailV2 ;
																	self.bankcardV2 := left.rv_scores.bankcardV2 ;
																	self.rv_reason4 := left.rv_scores.reason4;
																	self.rv_reason3 := left.rv_scores.reason3;
																	self.rv_reason2 := left.rv_scores.reason2;
																	self.rv_reason1 := left.rv_scores.reason1;
																	self.telecom := left.rv_scores.telecom;
																	self.auto := left.rv_scores.auto ;
																	self.retail := left.rv_scores.retail;
																	self.bankcard := left.rv_scores.bankcard;

//FD Scores
																	self.reason6FP_V3 := left.fd_scores.reason6FP_V3;
																	self.reason5FP_V3 := left.fd_scores.reason5FP_V3;
																	self.reason4FP_V3 := left.fd_scores.reason4FP_V3;
																	self.reason3FP_V3 := left.fd_scores.reason3FP_V3;
																	self.reason2FP_V3 := left.fd_scores.reason2FP_V3;
																	self.reason1FP_V3 := left.fd_scores.reason1FP_V3;
																	self.SuspiciousActivityIndex_V3 := left.fd_scores.SuspiciousActivityIndex_V3;
																	self.FriendlyFraudIndex_V3 := left.fd_scores.FriendlyFraudIndex_V3;
																	self.VulnerableVictimIndex_V3 := left.fd_scores.VulnerableVictimIndex_V3;
																	self.ManipulatedIdentityIndex_V3 := left.fd_scores.ManipulatedIdentityIndex_V3;
																	self.SyntheticIdentityIndex_V3 := left.fd_scores.SyntheticIdentityIndex_V3;
																	self.StolenIdentityIndex_V3 := left.fd_scores.StolenIdentityIndex_V3;
																	self.fraudpoint_V3 := left.fd_scores.fraudpoint_V3;
																	self.reason6FPV2 := left.fd_scores.reason6FPV2;
																	self.reason5FPV2 := left.fd_scores.reason5FPV2;
																	self.reason4FPV2 := left.fd_scores.reason4FPV2;
																	self.reason3FPV2 := left.fd_scores.reason3FPV2 ;
																	self.reason2FPV2 := left.fd_scores.reason2FPV2;
																	self.reason1FPV2 := left.fd_scores.reason1FPV2;
																	self.SuspiciousActivityIndex := left.fd_scores.SuspiciousActivityIndex ;
																	self.FriendlyFraudIndex := left.fd_scores.FriendlyFraudIndex ;
																	self.VulnerableVictimIndex := left.fd_scores.VulnerableVictimIndex;
																	self.ManipulatedIdentityIndex := left.fd_scores.ManipulatedIdentityIndex;
																	self.SyntheticIdentityIndex := left.fd_scores.SyntheticIdentityIndex;
																	self.StolenIdentityIndex := left.fd_scores.StolenIdentityIndex;
																	self.fraudpointV2 := left.fd_scores.fraudpointV2;
																	self.reason6FP := left.fd_scores.reason6FP;
																		self.reason5FP := left.fd_scores.reason5FP;
																	self.reason4FP := left.fd_scores.reason4FP;
																	self.reason3FP := left.fd_scores.reason3FP;
																	self.reason2FP := left.fd_scores.reason2FP ;
																	self.reason1FP := left.fd_scores.reason1FP;
																	self.fraudpoint := left.fd_scores.fraudpoint;
																	self.fd_reason4 := left.fd_scores.reason4 ;
																	self.fd_reason3 := left.fd_scores.reason3 ;
																	self.fd_reason2 := left.fd_scores.reason2;
																	self.fd_reason1 := left.fd_scores.reason1;
																	self.fd6 := left.fd_scores.fd6;
																	self.fd3 := left.fd_scores.fd3;
																	
																	
																	
	//Input Validation
																	self.FirstName := left.Input_Validation.FirstName;
																	self.LastName := left.Input_Validation.LastName;
																	self.Address := left.Input_Validation.Address;
																	self.SSN := left.Input_Validation.SSN;
																	self.SSN_Length := left.Input_Validation.SSN_Length;
																	self.DateOfBirth := left.Input_Validation.DateOfBirth;
																	self.Email := left.Input_Validation.Email;
																	self.IPAddress := left.Input_Validation.IPAddress;
																	self.HomePhone := left.Input_Validation.HomePhone;
																	self.WorkPhone := left.Input_Validation.WorkPhone;
																	
//inquiry verification																																
																  self.inquiryNAPphonecount := left.inquiryVerification.inquiryNAPphonecount;
																	self.InquiryNAPphoneScore := left.inquiryVerification.InquiryNAPphoneScore;
																	self.InquiryNAPdobScore := left.inquiryVerification.InquiryNAPdobScore;
																	self.InquiryNAPssnScore := left.inquiryVerification.InquiryNAPssnScore;
																	self.InquiryNAPlnameScore := left.inquiryVerification.InquiryNAPlnameScore;
																	self.InquiryNAPfnameScore := left.inquiryVerification.InquiryNAPfnameScore;
																	self.InquiryNAPaddrScore := left.inquiryVerification.InquiryNAPaddrScore;
																	self.InquiryNAPphone := left.inquiryVerification.InquiryNAPphone;
																	self.InquiryNAPdob := left.inquiryVerification.InquiryNAPdob;
																	self.InquiryNAPssn := left.inquiryVerification.InquiryNAPssn;
																	self.InquiryNAPlname := left.inquiryVerification.InquiryNAPlname;
																	self.InquiryNAPfname := left.inquiryVerification.InquiryNAPfname;
																	self.InquiryNAPz5 := left.inquiryVerification.InquiryNAPz5;
																	self.InquiryNAPst := left.inquiryVerification.InquiryNAPst;
																	self.InquiryNAPcity := left.inquiryVerification.InquiryNAPcity;
																	self.InquiryNAPsec_range := left.inquiryVerification.InquiryNAPsec_range;
																	self.InquiryNAPunit_desig := left.inquiryVerification.InquiryNAPunit_desig ;
																	self.InquiryNAPpostdir := left.inquiryVerification.InquiryNAPpostdir;
																	self.InquiryNAPsuffix := left.inquiryVerification.InquiryNAPsuffix;
																	self.InquiryNAPprim_name := left.inquiryVerification.InquiryNAPprim_name ;
																	self.InquiryNAPpredir := left.inquiryVerification.InquiryNAPpredir ;
																	self.InquiryNAPprim_range := left.inquiryVerification.InquiryNAPprim_range;
																	self.inquiryNAPdobcount := left.inquiryVerification.inquiryNAPdobcount;
																	self.inquiryNAPssncount := left.inquiryVerification.inquiryNAPssncount;
																	self.inquiryNAPlastcount := left.inquiryVerification.inquiryNAPlastcount;
																	self.inquiryNAPaddrcount := left.inquiryVerification.inquiryNAPaddrcount;
																	self.inquiryNAPfirstcount := left.inquiryVerification.inquiryNAPfirstcount;
																	
	// virtual fraud
																	self.hi_risk_ct := left.Virtual_Fraud.hi_risk_ct;
																	self.lo_risk_ct := left.Virtual_Fraud.lo_risk_ct;
																	self.LexID_phone_hi_risk_ct := left.Virtual_Fraud.LexID_phone_hi_risk_ct ;
																	self.LexID_phone_lo_risk_ct := left.Virtual_Fraud.LexID_phone_lo_risk_ct ;
																	self.AltLexID_Phone_hi_risk_ct := left.Virtual_Fraud.AltLexID_Phone_hi_risk_ct;
																	self.AltLexID_Phone_lo_risk_ct := left.Virtual_Fraud.AltLexID_Phone_lo_risk_ct;
																	self.LexID_addr_hi_risk_ct := left.Virtual_Fraud.LexID_addr_hi_risk_ct;
																	self.LexID_addr_lo_risk_ct := left.Virtual_Fraud.LexID_addr_lo_risk_ct ;
																	self.AltLexID_addr_hi_risk_ct := left.Virtual_Fraud.AltLexID_addr_hi_risk_ct;
																	self.AltLexID_addr_lo_risk_ct := left.Virtual_Fraud.AltLexID_addr_lo_risk_ct;
																	self.LexID_ssn_hi_risk_ct := left.Virtual_Fraud.LexID_ssn_hi_risk_ct;
																	self.LexID_ssn_lo_risk_ct := left.Virtual_Fraud.LexID_ssn_lo_risk_ct;
																	self.AltLexID_ssn_hi_risk_ct := left.Virtual_Fraud.AltLexID_ssn_hi_risk_ct;
																	self.AltLexID_ssn_lo_risk_ct := left.Virtual_Fraud.AltLexID_ssn_lo_risk_ct;
	// utility
																	self.utili_adl_type := left.utility.utili_adl_type;
																	self.utili_adl_dt_first_seen := left.utility.utili_adl_dt_first_seen;
																	self.utili_adl_count := left.utility.utili_adl_count ;
																	self.utili_adl_earliest_dt_first_seen := left.utility.utili_adl_earliest_dt_first_seen ;
																	self.utili_adl_nap := left.utility.utili_adl_nap;
																	self.utili_addr1_type := left.utility.utili_addr1_type;
																	self.utili_addr1_dt_first_seen := left.utility.utili_addr1_dt_first_seen;
																	self.utili_addr1_nap := left.utility.utili_addr1_nap ;
																	self.utili_addr2_type := left.utility.utili_addr2_type;
																	self.utili_addr2_dt_first_seen := left.utility.utili_addr2_dt_first_seen;
																	self.utili_addr2_nap := left.utility.utili_addr2_nap;
// name verification
																	self.adl_score := left.Name_Verification.adl_score;
																	self.fname_score := left.Name_Verification.fname_score;
																	self.lname_score := left.Name_Verification.lname_score;
																	self.lname_change_date := left.Name_Verification.lname_change_date;
																	self.lname_prev_change_date := left.Name_Verification.lname_prev_change_date;
																	self.source_count := left.Name_Verification.source_count;
																	self.fname_credit_sourced := left.Name_Verification.fname_credit_sourced;
																	self.lname_credit_sourced := left.Name_Verification.lname_credit_sourced;
																	self.fname_tu_sourced := left.Name_Verification.fname_tu_sourced;
																	self.lname_tu_sourced := left.Name_Verification.lname_tu_sourced;
																	self.fname_eda_sourced := left.Name_Verification.fname_eda_sourced;
																	self.fname_eda_sourced_type := left.Name_Verification.fname_eda_sourced_type;
																	self.lname_eda_sourced := left.Name_Verification.lname_eda_sourced;
																	self.lname_eda_sourced_type := left.Name_Verification.lname_eda_sourced_type;
																	self.fname_dl_sourced := left.Name_Verification.fname_dl_sourced;
																	self.fname_voter_sourced := left.Name_Verification.fname_voter_sourced;
																	self.fname_utility_sourced := left.Name_Verification.fname_utility_sourced ;
																	self.lname_dl_sourced := left.Name_Verification.lname_dl_sourced;
																	self.lname_voter_sourced := left.Name_Verification.lname_voter_sourced;
																	self.lname_utility_sourced := left.Name_Verification.lname_utility_sourced ;
																	self.age := left.Name_Verification.age ;
																	self.dob_score := left.Name_Verification.dob_score;
																	self.newest_lname := left.Name_Verification.newest_lname;
																	self.newest_lname_dt_first_seen := left.Name_Verification.newest_lname_dt_first_seen;
// phone verification
																	self.phone_score := left.phone_verification.phone_score ;
																	self.phone_sources := left.phone_verification.phone_sources ;
																	self.telcordia_type := left.phone_verification.telcordia_type;
																	self.phone_zip_mismatch := left.phone_verification.phone_zip_mismatch ;
																	self.distance := left.phone_verification.distance ;
																	self.disconnected := left.phone_verification.disconnected ;
																	self.recent_disconnects := left.phone_verification.recent_disconnects;
																	self.HR_Phone := left.phone_verification.HR_Phone ;
																	self.Corrections := left.phone_verification.Corrections ;
																	self.gong_adl_dt_first_seen_full := left.phone_verification.gong_did.gong_adl_dt_first_seen_full;
																  self.gong_adl_dt_last_seen_full := left.phone_verification.gong_did.gong_adl_dt_last_seen_full;
																	self.gong_did_phone_ct := left.phone_verification.gong_did.gong_did_phone_ct ;
																	self.gong_did_addr_ct := left.phone_verification.gong_did.gong_did_addr_ct ;
																	self.gong_did_first_ct := left.phone_verification.gong_did.gong_did_first_ct ;
																	self.gong_did_last_ct := left.phone_verification.gong_did.gong_did_last_ct ;
//Address_Verification
																	self.address_verification_unverified_addr_count := left.Address_Verification.unverified_addr_count;
																	self.currAddr_occupancy_index := left.Address_Verification.currAddr_occupancy_index;
																	self.inputAddr_occupancy_index := left.Address_Verification.inputAddr_occupancy_index;
																	self.inputAddr_non_relative_DID_count := left.Address_Verification.inputAddr_non_relative_DID_count;
																	self.inputAddr_owned_not_occupied := left.Address_Verification.inputAddr_owned_not_occupied;
																	self.inputAddr_not_verified := left.Address_Verification.inputAddr_not_verified;
																	self.inputAddr_dirty := left.Address_Verification.inputAddr_dirty;
																	
																	self.Addr_Flags_2_dropIndicator := left.Address_Verification.Addr_Flags_2.dropIndicator;
																	self.Addr_Flags_2_addressType := left.Address_Verification.Addr_Flags_2.addressType;
																	self.Addr_Flags_2_deliveryStatus := left.Address_Verification.Addr_Flags_2.deliveryStatus;
																	self.Addr_Flags_2_doNotDeliver := left.Address_Verification.Addr_Flags_2.doNotDeliver;
																	self.Addr_Flags_2_corpMil := left.Address_Verification.Addr_Flags_2.corpMil;
																	self.Addr_Flags_2_highRisk := left.Address_Verification.Addr_Flags_2.highRisk;
																	self.Addr_Flags_2_prisonAddr := left.Address_Verification.Addr_Flags_2.prisonAddr;
																	self.Addr_Flags_2_valid := left.Address_Verification.Addr_Flags_2.valid;
																	self.Addr_Flags_2_dwelltype := left.Address_Verification.Addr_Flags_2.dwelltype;
																	
																	self.Addr_Flags_1_dropIndicator := left.Address_Verification.Addr_Flags_1.dropIndicator;
																	self.Addr_Flags_1_addressType := left.Address_Verification.Addr_Flags_1.addressType;
																	self.Addr_Flags_1_deliveryStatus := left.Address_Verification.Addr_Flags_1.deliveryStatus;
																	self.Addr_Flags_1_doNotDeliver := left.Address_Verification.Addr_Flags_1.doNotDeliver;
																	self.Addr_Flags_1_corpMil := left.Address_Verification.Addr_Flags_1.corpMil;
																	self.Addr_Flags_1_highRisk := left.Address_Verification.Addr_Flags_1.highRisk;
																	self.Addr_Flags_1_prisonAddr := left.Address_Verification.Addr_Flags_1.prisonAddr;
																	self.Addr_Flags_1_valid := left.Address_Verification.Addr_Flags_1.valid;
																	self.Addr_Flags_1_dwelltype := left.Address_Verification.Addr_Flags_1.dwelltype;
																	
																	self.Address_History_2_address_score := left.Address_Verification.Address_History_2.address_score;
																	self.Address_History_2_House_Number_match := left.Address_Verification.Address_History_2.House_Number_match;
																	self.Address_History_2_isBestMatch := left.Address_Verification.Address_History_2.isBestMatch;
																	self.Address_History_2_unit_count := left.Address_Verification.Address_History_2.unit_count;
																	self.Address_History_2_geo12_fc_index := left.Address_Verification.Address_History_2.geo12_fc_index;
																	self.Address_History_2_geo11_fc_index := left.Address_Verification.Address_History_2.geo11_fc_index;
																	self.Address_History_2_fips_fc_index := left.Address_Verification.Address_History_2.fips_fc_index;
																	self.Address_History_2_source_count := left.Address_Verification.Address_History_2.source_count;
																	self.Address_History_2_sources := left.Address_Verification.Address_History_2.sources;
																	self.Address_History_2_credit_sourced := left.Address_Verification.Address_History_2.credit_sourced;
																	self.Address_History_2_eda_sourced := left.Address_Verification.Address_History_2.eda_sourced;
																	self.Address_History_2_dl_sourced := left.Address_Verification.Address_History_2.dl_sourced;
																	self.Address_History_2_voter_sourced := left.Address_Verification.Address_History_2.voter_sourced;
																	self.Address_History_2_utility_sourced := left.Address_Verification.Address_History_2.utility_sourced;																	
																	self.Address_History_2_applicant_owned := left.Address_Verification.Address_History_2.applicant_owned;
																	self.Address_History_2_occupant_owned := left.Address_Verification.Address_History_2.occupant_owned;
																	self.Address_History_2_family_owned := left.Address_Verification.Address_History_2.family_owned;
																	self.Address_History_2_family_sold := left.Address_Verification.Address_History_2.family_sold;
																	self.Address_History_2_applicant_sold := left.Address_Verification.Address_History_2.applicant_sold;
																	self.Address_History_2_family_sale_found := left.Address_Verification.Address_History_2.family_sale_found;
																	self.Address_History_2_family_buy_found := left.Address_Verification.Address_History_2.family_buy_found;
																	self.Address_History_2_applicant_sale_found := left.Address_Verification.Address_History_2.applicant_sale_found;
																	self.Address_History_2_applicant_buy_found := left.Address_Verification.Address_History_2.applicant_buy_found;
																	self.Address_History_2_NAProp := left.Address_Verification.Address_History_2.NAProp;
																	self.Address_History_2_purchase_date := left.Address_Verification.Address_History_2.purchase_date;
																	self.Address_History_2_built_date := left.Address_Verification.Address_History_2.built_date;
																	self.Address_History_2_purchase_amount := left.Address_Verification.Address_History_2.purchase_amount;
																	self.Address_History_2_mortgage_amount := left.Address_Verification.Address_History_2.mortgage_amount;																	
																	self.Address_History_2_mortgage_date := left.Address_Verification.Address_History_2.mortgage_date;
																	self.Address_History_2_mortgage_type := left.Address_Verification.Address_History_2.mortgage_type;
																	self.Address_History_2_type_financing := left.Address_Verification.Address_History_2.type_financing;
																	self.Address_History_2_first_td_due_date := left.Address_Verification.Address_History_2.first_td_due_date;
																	self.Address_History_2_assessed_amount := left.Address_Verification.Address_History_2.assessed_amount;
																	self.Address_History_2_assessed_total_value := left.Address_Verification.Address_History_2.assessed_total_value;
																	self.Address_History_2_date_first_seen := left.Address_Verification.Address_History_2.date_first_seen;
																	self.Address_History_2_date_last_seen := left.Address_Verification.Address_History_2.date_last_seen;
																	self.Address_History_2_standardized_land_use_code := left.Address_Verification.Address_History_2.standardized_land_use_code;
																	self.Address_History_2_building_area := left.Address_Verification.Address_History_2.building_area;
																	self.Address_History_2_no_of_buildings := left.Address_Verification.Address_History_2.no_of_buildings;
																	self.Address_History_2_no_of_stories := left.Address_Verification.Address_History_2.no_of_stories;
																	self.Address_History_2_no_of_rooms := left.Address_Verification.Address_History_2.no_of_rooms;
																	self.Address_History_2_no_of_bedrooms := left.Address_Verification.Address_History_2.no_of_bedrooms;																	
																	self.Address_History_2_no_of_baths := left.Address_Verification.Address_History_2.no_of_baths;
																	self.Address_History_2_no_of_partial_baths := left.Address_Verification.Address_History_2.no_of_partial_baths;
																	self.Address_History_2_garage_type_code := left.Address_Verification.Address_History_2.garage_type_code;
																	self.Address_History_2_parking_no_of_cars := left.Address_Verification.Address_History_2.parking_no_of_cars;
																	self.Address_History_2_style_code := left.Address_Verification.Address_History_2.style_code;
																	self.Address_History_2_assessed_value_year := left.Address_Verification.Address_History_2.assessed_value_year;
																	self.Address_History_2_HR_Address := left.Address_Verification.Address_History_2.HR_Address;
																	self.Address_History_2_HR_Company := left.Address_Verification.Address_History_2.HR_Company;
																	self.Address_History_2_prim_range := left.Address_Verification.Address_History_2.prim_range;
																	self.Address_History_2_predir := left.Address_Verification.Address_History_2.predir;
																	self.Address_History_2_prim_name := left.Address_Verification.Address_History_2.prim_name;
																	self.Address_History_2_addr_suffix := left.Address_Verification.Address_History_2.addr_suffix;
																	self.Address_History_2_postdir := left.Address_Verification.Address_History_2.postdir;
																	self.Address_History_2_unit_desig := left.Address_Verification.Address_History_2.unit_desig;																	
																	self.Address_History_2_sec_range := left.Address_Verification.Address_History_2.sec_range;
																	self.Address_History_2_city_name := left.Address_Verification.Address_History_2.city_name;
																	self.Address_History_2_st := left.Address_Verification.Address_History_2.st;
																	self.Address_History_2_zip5 := left.Address_Verification.Address_History_2.zip5;
																	self.Address_History_2_county := left.Address_Verification.Address_History_2.county;
																	self.Address_History_2_geo_blk := left.Address_Verification.Address_History_2.geo_blk;
																	self.Address_History_2_lat := left.Address_Verification.Address_History_2.lat;
																	self.Address_History_2_long := left.Address_Verification.Address_History_2.long;
																	self.Address_History_2_census_age := left.Address_Verification.Address_History_2.census_age;
																	self.Address_History_2_census_income := left.Address_Verification.Address_History_2.census_income;
																	self.Address_History_2_census_home_value := left.Address_Verification.Address_History_2.census_home_value;
																	self.Address_History_2_census_education := left.Address_Verification.Address_History_2.census_education;
																	self.Address_History_2_full_match := left.Address_Verification.Address_History_2.full_match;
																	
																	self.Address_History_1_address_score := left.Address_Verification.Address_History_1.address_score;
																	self.Address_History_1_House_Number_match := left.Address_Verification.Address_History_1.House_Number_match;
																	self.Address_History_1_isBestMatch := left.Address_Verification.Address_History_1.isBestMatch;
																	self.Address_History_1_unit_count := left.Address_Verification.Address_History_1.unit_count;
																	self.Address_History_1_geo12_fc_index := left.Address_Verification.Address_History_1.geo12_fc_index;
																	self.Address_History_1_geo11_fc_index := left.Address_Verification.Address_History_1.geo11_fc_index;
																	self.Address_History_1_fips_fc_index := left.Address_Verification.Address_History_1.fips_fc_index;
																	self.Address_History_1_source_count := left.Address_Verification.Address_History_1.source_count;
																	self.Address_History_1_sources := left.Address_Verification.Address_History_1.sources;
																	self.Address_History_1_credit_sourced := left.Address_Verification.Address_History_1.credit_sourced;
																	self.Address_History_1_eda_sourced := left.Address_Verification.Address_History_1.eda_sourced;
																	self.Address_History_1_dl_sourced := left.Address_Verification.Address_History_1.dl_sourced;
																	self.Address_History_1_voter_sourced := left.Address_Verification.Address_History_1.voter_sourced;
																	self.Address_History_1_utility_sourced := left.Address_Verification.Address_History_1.utility_sourced;																	
																	self.Address_History_1_applicant_owned := left.Address_Verification.Address_History_1.applicant_owned;
																	self.Address_History_1_occupant_owned := left.Address_Verification.Address_History_1.occupant_owned;
																	self.Address_History_1_family_owned := left.Address_Verification.Address_History_1.family_owned;
																	self.Address_History_1_family_sold := left.Address_Verification.Address_History_1.family_sold;
																	self.Address_History_1_applicant_sold := left.Address_Verification.Address_History_1.applicant_sold;
																	self.Address_History_1_family_sale_found := left.Address_Verification.Address_History_1.family_sale_found;
																	self.Address_History_1_family_buy_found := left.Address_Verification.Address_History_1.family_buy_found;
																	self.Address_History_1_applicant_sale_found := left.Address_Verification.Address_History_1.applicant_sale_found;
																	self.Address_History_1_applicant_buy_found := left.Address_Verification.Address_History_1.applicant_buy_found;
																	self.Address_History_1_NAProp := left.Address_Verification.Address_History_1.NAProp;
																	self.Address_History_1_purchase_date := left.Address_Verification.Address_History_1.purchase_date;
																	self.Address_History_1_built_date := left.Address_Verification.Address_History_1.built_date;
																	self.Address_History_1_purchase_amount := left.Address_Verification.Address_History_1.purchase_amount;
																	self.Address_History_1_mortgage_amount := left.Address_Verification.Address_History_1.mortgage_amount;																	
																	self.Address_History_1_mortgage_date := left.Address_Verification.Address_History_1.mortgage_date;
																	self.Address_History_1_mortgage_type := left.Address_Verification.Address_History_1.mortgage_type;
																	self.Address_History_1_type_financing := left.Address_Verification.Address_History_1.type_financing;
																	self.Address_History_1_first_td_due_date := left.Address_Verification.Address_History_1.first_td_due_date;
																	self.Address_History_1_assessed_amount := left.Address_Verification.Address_History_1.assessed_amount;
																	self.Address_History_1_assessed_total_value := left.Address_Verification.Address_History_1.assessed_total_value;
																	self.Address_History_1_date_first_seen := left.Address_Verification.Address_History_1.date_first_seen;
																	self.Address_History_1_date_last_seen := left.Address_Verification.Address_History_1.date_last_seen;
																	self.Address_History_1_standardized_land_use_code := left.Address_Verification.Address_History_1.standardized_land_use_code;
																	self.Address_History_1_building_area := left.Address_Verification.Address_History_1.building_area;
																	self.Address_History_1_no_of_buildings := left.Address_Verification.Address_History_1.no_of_buildings;
																	self.Address_History_1_no_of_stories := left.Address_Verification.Address_History_1.no_of_stories;
																	self.Address_History_1_no_of_rooms := left.Address_Verification.Address_History_1.no_of_rooms;
																	self.Address_History_1_no_of_bedrooms := left.Address_Verification.Address_History_1.no_of_bedrooms;																	
																	self.Address_History_1_no_of_baths := left.Address_Verification.Address_History_1.no_of_baths;
																	self.Address_History_1_no_of_partial_baths := left.Address_Verification.Address_History_1.no_of_partial_baths;
																	self.Address_History_1_garage_type_code := left.Address_Verification.Address_History_1.garage_type_code;
																	self.Address_History_1_parking_no_of_cars := left.Address_Verification.Address_History_1.parking_no_of_cars;
																	self.Address_History_1_style_code := left.Address_Verification.Address_History_1.style_code;
																	self.Address_History_1_assessed_value_year := left.Address_Verification.Address_History_1.assessed_value_year;
																	self.Address_History_1_HR_Address := left.Address_Verification.Address_History_1.HR_Address;
																	self.Address_History_1_HR_Company := left.Address_Verification.Address_History_1.HR_Company;
																	self.Address_History_1_prim_range := left.Address_Verification.Address_History_1.prim_range;
																	self.Address_History_1_predir := left.Address_Verification.Address_History_1.predir;
																	self.Address_History_1_prim_name := left.Address_Verification.Address_History_1.prim_name;
																	self.Address_History_1_addr_suffix := left.Address_Verification.Address_History_1.addr_suffix;
																	self.Address_History_1_postdir := left.Address_Verification.Address_History_1.postdir;
																	self.Address_History_1_unit_desig := left.Address_Verification.Address_History_1.unit_desig;																	
																	self.Address_History_1_sec_range := left.Address_Verification.Address_History_1.sec_range;
																	self.Address_History_1_city_name := left.Address_Verification.Address_History_1.city_name;
																	self.Address_History_1_st := left.Address_Verification.Address_History_1.st;
																	self.Address_History_1_zip5 := left.Address_Verification.Address_History_1.zip5;
																	self.Address_History_1_county := left.Address_Verification.Address_History_1.county;
																	self.Address_History_1_geo_blk := left.Address_Verification.Address_History_1.geo_blk;
																	self.Address_History_1_lat := left.Address_Verification.Address_History_1.lat;
																	self.Address_History_1_long := left.Address_Verification.Address_History_1.long;
																	self.Address_History_1_census_age := left.Address_Verification.Address_History_1.census_age;
																	self.Address_History_1_census_income := left.Address_Verification.Address_History_1.census_income;
																	self.Address_History_1_census_home_value := left.Address_Verification.Address_History_1.census_home_value;
																	self.Address_History_1_census_education := left.Address_Verification.Address_History_1.census_education;
																	self.Address_History_1_full_match := left.Address_Verification.Address_History_1.full_match;
																	
																	self.Input_Address_Information_address_score := left.Address_Verification.Input_Address_Information.address_score;
																	self.Input_Address_Information_House_Number_match := left.Address_Verification.Input_Address_Information.House_Number_match;
																	self.Input_Address_Information_isBestMatch := left.Address_Verification.Input_Address_Information.isBestMatch;
																	self.Input_Address_Information_unit_count := left.Address_Verification.Input_Address_Information.unit_count;
																	self.Input_Address_Information_geo12_fc_index := left.Address_Verification.Input_Address_Information.geo12_fc_index;
																	self.Input_Address_Information_geo11_fc_index := left.Address_Verification.Input_Address_Information.geo11_fc_index;
																	self.Input_Address_Information_fips_fc_index := left.Address_Verification.Input_Address_Information.fips_fc_index;
																	self.Input_Address_Information_source_count := left.Address_Verification.Input_Address_Information.source_count;
																	self.Input_Address_Information_sources := left.Address_Verification.Input_Address_Information.sources;
																	self.Input_Address_Information_credit_sourced := left.Address_Verification.Input_Address_Information.credit_sourced;
																	self.Input_Address_Information_eda_sourced := left.Address_Verification.Input_Address_Information.eda_sourced;
																	self.Input_Address_Information_dl_sourced := left.Address_Verification.Input_Address_Information.dl_sourced;
																	self.Input_Address_Information_voter_sourced := left.Address_Verification.Input_Address_Information.voter_sourced;
																	self.Input_Address_Information_utility_sourced := left.Address_Verification.Input_Address_Information.utility_sourced;																	
																	self.Input_Address_Information_applicant_owned := left.Address_Verification.Input_Address_Information.applicant_owned;
																	self.Input_Address_Information_occupant_owned := left.Address_Verification.Input_Address_Information.occupant_owned;
																	self.Input_Address_Information_family_owned := left.Address_Verification.Input_Address_Information.family_owned;
																	self.Input_Address_Information_family_sold := left.Address_Verification.Input_Address_Information.family_sold;
																	self.Input_Address_Information_applicant_sold := left.Address_Verification.Input_Address_Information.applicant_sold;
																	self.Input_Address_Information_family_sale_found := left.Address_Verification.Input_Address_Information.family_sale_found;
																	self.Input_Address_Information_family_buy_found := left.Address_Verification.Input_Address_Information.family_buy_found;
																	self.Input_Address_Information_applicant_sale_found := left.Address_Verification.Input_Address_Information.applicant_sale_found;
																	self.Input_Address_Information_applicant_buy_found := left.Address_Verification.Input_Address_Information.applicant_buy_found;
																	self.Input_Address_Information_NAProp := left.Address_Verification.Input_Address_Information.NAProp;
																	self.Input_Address_Information_purchase_date := left.Address_Verification.Input_Address_Information.purchase_date;
																	self.Input_Address_Information_built_date := left.Address_Verification.Input_Address_Information.built_date;
																	self.Input_Address_Information_purchase_amount := left.Address_Verification.Input_Address_Information.purchase_amount;
																	self.Input_Address_Information_mortgage_amount := left.Address_Verification.Input_Address_Information.mortgage_amount;																	
																	self.Input_Address_Information_mortgage_date := left.Address_Verification.Input_Address_Information.mortgage_date;
																	self.Input_Address_Information_mortgage_type := left.Address_Verification.Input_Address_Information.mortgage_type;
																	self.Input_Address_Information_type_financing := left.Address_Verification.Input_Address_Information.type_financing;
																	self.Input_Address_Information_first_td_due_date := left.Address_Verification.Input_Address_Information.first_td_due_date;
																	self.Input_Address_Information_assessed_amount := left.Address_Verification.Input_Address_Information.assessed_amount;
																	self.Input_Address_Information_assessed_total_value := left.Address_Verification.Input_Address_Information.assessed_total_value;
																	self.Input_Address_Information_date_first_seen := left.Address_Verification.Input_Address_Information.date_first_seen;
																	self.Input_Address_Information_date_last_seen := left.Address_Verification.Input_Address_Information.date_last_seen;
																	self.Input_Address_Information_standardized_land_use_code := left.Address_Verification.Input_Address_Information.standardized_land_use_code;
																	self.Input_Address_Information_building_area := left.Address_Verification.Input_Address_Information.building_area;
																	self.Input_Address_Information_no_of_buildings := left.Address_Verification.Input_Address_Information.no_of_buildings;
																	self.Input_Address_Information_no_of_stories := left.Address_Verification.Input_Address_Information.no_of_stories;
																	self.Input_Address_Information_no_of_rooms := left.Address_Verification.Input_Address_Information.no_of_rooms;
																	self.Input_Address_Information_no_of_bedrooms := left.Address_Verification.Input_Address_Information.no_of_bedrooms;																	
																	self.Input_Address_Information_no_of_baths := left.Address_Verification.Input_Address_Information.no_of_baths;
																	self.Input_Address_Information_no_of_partial_baths := left.Address_Verification.Input_Address_Information.no_of_partial_baths;
																	self.Input_Address_Information_garage_type_code := left.Address_Verification.Input_Address_Information.garage_type_code;
																	self.Input_Address_Information_parking_no_of_cars := left.Address_Verification.Input_Address_Information.parking_no_of_cars;
																	self.Input_Address_Information_style_code := left.Address_Verification.Input_Address_Information.style_code;
																	self.Input_Address_Information_assessed_value_year := left.Address_Verification.Input_Address_Information.assessed_value_year;
																	self.Input_Address_Information_HR_Address := left.Address_Verification.Input_Address_Information.HR_Address;
																	self.Input_Address_Information_HR_Company := left.Address_Verification.Input_Address_Information.HR_Company;
																	self.Input_Address_Information_prim_range := left.Address_Verification.Input_Address_Information.prim_range;
																	self.Input_Address_Information_predir := left.Address_Verification.Input_Address_Information.predir;
																	self.Input_Address_Information_prim_name := left.Address_Verification.Input_Address_Information.prim_name;
																	self.Input_Address_Information_addr_suffix := left.Address_Verification.Input_Address_Information.addr_suffix;
																	self.Input_Address_Information_postdir := left.Address_Verification.Input_Address_Information.postdir;
																	self.Input_Address_Information_unit_desig := left.Address_Verification.Input_Address_Information.unit_desig;																	
																	self.Input_Address_Information_sec_range := left.Address_Verification.Input_Address_Information.sec_range;
																	self.Input_Address_Information_city_name := left.Address_Verification.Input_Address_Information.city_name;
																	self.Input_Address_Information_st := left.Address_Verification.Input_Address_Information.st;
																	self.Input_Address_Information_zip5 := left.Address_Verification.Input_Address_Information.zip5;
																	self.Input_Address_Information_county := left.Address_Verification.Input_Address_Information.county;
																	self.Input_Address_Information_geo_blk := left.Address_Verification.Input_Address_Information.geo_blk;
																	self.Input_Address_Information_lat := left.Address_Verification.Input_Address_Information.lat;
																	self.Input_Address_Information_long := left.Address_Verification.Input_Address_Information.long;
																	self.Input_Address_Information_census_age := left.Address_Verification.Input_Address_Information.census_age;
																	self.Input_Address_Information_census_income := left.Address_Verification.Input_Address_Information.census_income;
																	self.Input_Address_Information_census_home_value := left.Address_Verification.Input_Address_Information.census_home_value;
																	self.Input_Address_Information_census_education := left.Address_Verification.Input_Address_Information.census_education;
																	self.Input_Address_Information_full_match := left.Address_Verification.Input_Address_Information.full_match;
																	
																	self.owned_property_total := left.Address_Verification.owned.property_total;
																	self.owned_property_owned_purchase_total := left.Address_Verification.owned.property_owned_purchase_total;
																	self.owned_property_owned_purchase_count := left.Address_Verification.owned.property_owned_purchase_count;
																	self.owned_property_owned_assessed_total := left.Address_Verification.owned.property_owned_assessed_total;
																	self.owned_property_owned_assessed_count := left.Address_Verification.owned.property_owned_assessed_count;
																	
																	self.sold_property_total := left.Address_Verification.sold.property_total;
																	self.sold_property_owned_purchase_total := left.Address_Verification.sold.property_owned_purchase_total;
																	self.sold_property_owned_purchase_count := left.Address_Verification.sold.property_owned_purchase_count;
																	self.sold_property_owned_assessed_total := left.Address_Verification.sold.property_owned_assessed_total;
																	self.sold_property_owned_assessed_count := left.Address_Verification.sold.property_owned_assessed_count;
																	
																	self.ambiguous_property_total := left.Address_Verification.ambiguous.property_total;
																	self.ambiguous_property_owned_purchase_total := left.Address_Verification.ambiguous.property_owned_purchase_total;
																	self.ambiguous_property_owned_purchase_count := left.Address_Verification.ambiguous.property_owned_purchase_count;
																	self.ambiguous_property_owned_assessed_total := left.Address_Verification.ambiguous.property_owned_assessed_total;
																	self.ambiguous_property_owned_assessed_count := left.Address_Verification.ambiguous.property_owned_assessed_count;
																	
																	self.sale_price1 := left.Address_Verification.Recent_Property_Sales.sale_price1;
																	self.sale_date1 := left.Address_Verification.Recent_Property_Sales.sale_date1;
																	self.prev_purch_price1 := left.Address_Verification.Recent_Property_Sales.prev_purch_price1;
																	self.prev_purch_date1 := left.Address_Verification.Recent_Property_Sales.prev_purch_date1;
																	self.sale_price2 := left.Address_Verification.Recent_Property_Sales.sale_price2;																	
																	self.sale_date2 := left.Address_Verification.Recent_Property_Sales.sale_date2;
																	self.prev_purch_price2 := left.Address_Verification.Recent_Property_Sales.prev_purch_price2;
																	self.prev_purch_date2 := left.Address_Verification.Recent_Property_Sales.prev_purch_date2;	
																	
																	self.distance_in_2_h1 := left.Address_Verification.distance_in_2_h1;
																	self.distance_in_2_h2 := left.Address_Verification.distance_in_2_h2;
																	self.distance_h1_2_h2 := left.Address_Verification.distance_h1_2_h2;
																	self.addr1addr2score := left.Address_Verification.addr1addr2score;
																	self.addr1addr3score := left.Address_Verification.addr1addr3score;
																	self.addr2addr3score := left.Address_Verification.addr2addr3score;
																	self.addr_type2 := left.Address_Verification.addr_type2;
																	self.addr_type3 := left.Address_Verification.addr_type3;
																	self.edaMatchLevel := left.Address_Verification.edaMatchLevel;
																	self.activePhone := left.Address_Verification.activePhone;
																	self.edaMatchLevel2 := left.Address_Verification.edaMatchLevel2;
																	self.activePhone2 := left.Address_Verification.activePhone2;
																	self.edaMatchLevel3 := left.Address_Verification.edaMatchLevel3;
																	self.activePhone3 := left.Address_Verification.activePhone3;																	
													
																	self := left;
																	self := [];
																	));
 
return pj;

endmacro;