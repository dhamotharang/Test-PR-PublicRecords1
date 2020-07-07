EXPORT BocaShell_54_Top50_FCRA_Attributes_MACRO(dateyymmdd_curr,dateyymmdd_prev) := functionmacro

Import std, ut;

 lay := RECORD
	// unsigned8 time_ms := 0;
	// STRING30 AccountNumber;
	// risk_indicators.Layout_Boca_Shell;
	// STRING200 errorcode;
		Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;
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
			AMLAttributes, hhid_summary, insurance_phones_summary, address_sources_summary, Virtual_Fraud, liens, rv_scores, fd_scores, inquiryVerification

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
	// utility,
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

bs_cert_curr := dataset('~scoringqa::out::fcra::bocashell_54_historydate_999999_cert_' + dateyymmdd_curr + '_1', lay, thor);

bs_cert_prev := dataset('~scoringqa::out::fcra::bocashell_54_historydate_999999_cert_' + dateyymmdd_prev + '_1', lay,thor);

matched_ds:=join(bs_cert_curr,bs_cert_prev,left.accountnumber=right.accountnumber);

matched_ds_filtered:=matched_ds(accountnumber<>'');


bs_cert:=join(bs_cert_curr,matched_ds_filtered,left.accountnumber=right.accountnumber);

// bweiner::out::tracking::bocashell50::cert_bs_50_fcra_999999_20140519no_edina
// bs_cert := dataset(ut.foreign_prod +  'bweiner::out::tracking::bocashell50::cert_bs_50_fcra_999999_'  + dateyyyymmdd + 'no_edina' , lay, CSV(QUOTE('"')));


pj := project(bs_cert, TRANSFORM(lay1,

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
																	// self := [];
																	));
 


																	 
	// mx := max(pj,(real)pj.source_profile); 
	// mini := min(pj,(real)pj.source_profile); 
	// av := ave(pj,(real)pj.source_profile); ;
	// mx;
	// mini;
	// av;
// choosen(Scoring_Project.mac_profile(pj), all);


/*******************************************************************************************************************************************/
//Address_Verification
/*******************************************************************************************************************************************/	

Addr_Flags_1_dwelltype := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_1_dwelltype', 'Address_Verification-Addr_Flags_1');	
Addr_Flags_1_valid := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_1_valid', 'Address_Verification-Addr_Flags_1');	
Addr_Flags_1_prisonAddr := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_1_prisonAddr', 'Address_Verification-Addr_Flags_1');	
Addr_Flags_1_highRisk := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_1_highRisk', 'Address_Verification-Addr_Flags_1');	
Addr_Flags_1_corpMil := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_1_corpMil', 'Address_Verification-Addr_Flags_1');	
Addr_Flags_1_doNotDeliver := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_1_doNotDeliver', 'Address_Verification-Addr_Flags_1');	
Addr_Flags_1_deliveryStatus := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_1_deliveryStatus', 'Address_Verification-Addr_Flags_1');	
Addr_Flags_1_addressType := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_1_addressType', 'Address_Verification-Addr_Flags_1');	
Addr_Flags_1_dropIndicator := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_1_dropIndicator', 'Address_Verification-Addr_Flags_1');	

Addr_Flags_2_dwelltype := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_2_dwelltype', 'Address_Verification-Addr_Flags_2');	
Addr_Flags_2_valid := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_2_valid', 'Address_Verification-Addr_Flags_2');	
Addr_Flags_2_prisonAddr := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_2_prisonAddr', 'Address_Verification-Addr_Flags_2');	
Addr_Flags_2_highRisk := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_2_highRisk', 'Address_Verification-Addr_Flags_2');	
Addr_Flags_2_corpMil := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_2_corpMil', 'Address_Verification-Addr_Flags_2');	
Addr_Flags_2_doNotDeliver := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_2_doNotDeliver', 'Address_Verification-Addr_Flags_2');	
Addr_Flags_2_deliveryStatus := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_2_deliveryStatus', 'Address_Verification-Addr_Flags_2');	
Addr_Flags_2_addressType := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_2_addressType', 'Address_Verification-Addr_Flags_2');	
Addr_Flags_2_dropIndicator := Scoring_Project.MACRO_distinct_values(pj, 'Addr_Flags_2_dropIndicator', 'Address_Verification-Addr_Flags_2');	

	
inputAddr_dirty := Scoring_Project.MACRO_distinct_values(pj, 'inputAddr_dirty', 'Address_Verification');	
inputAddr_not_verified := Scoring_Project.MACRO_distinct_values(pj, 'inputAddr_not_verified', 'Address_Verification');	
inputAddr_owned_not_occupied := Scoring_Project.MACRO_distinct_values(pj, 'inputAddr_owned_not_occupied', 'Address_Verification');	
inputAddr_non_relative_DID_count := Scoring_Project.MACRO_distinct_values(pj, 'inputAddr_non_relative_DID_count', 'Address_Verification');	
inputAddr_occupancy_index := Scoring_Project.MACRO_distinct_values(pj, 'inputAddr_occupancy_index', 'Address_Verification ');	
currAddr_occupancy_index := Scoring_Project.MACRO_distinct_values(pj, 'currAddr_occupancy_index', 'Address_Verification');	
address_verification_unverified_addr_count := Scoring_Project.MACRO_distinct_values(pj, 'address_verification_unverified_addr_count', 'Address_Verification');	


//Address_History_2
	
// Address_History_2_assessed_value_year 
addr_h2_rc1 := record
string100 field_name := 'Address_History_2_assessed_value_year';
string100 category := 'Address_Verification-Address_History_2';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( (integer)pj.Address_History_2_assessed_value_year = (integer)ut.getdate[1..4] => 'Current Year',
																	(integer)pj.Address_History_2_assessed_value_year < (integer)ut.getdate[1..4] => 'Not Current Year',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Address_History_2_assessed_value_year := table(pj, addr_h2_rc1,MAP( (integer)pj.Address_History_2_assessed_value_year = (integer)ut.getdate[1..4] => 'Current Year',
																																				(integer)pj.Address_History_2_assessed_value_year < (integer)ut.getdate[1..4] => 'Not Current Year',
																																				'UNDEFINED') ,all);	
// Address_History_2_assessed_value_year 
addr_h2_rc2 := record
string100 field_name := 'Address_History_2_built_date';
string100 category := 'Address_Verification-Address_History_2';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( (integer)pj.Address_History_2_built_date = (integer)ut.getdate[1..4] => 'Current Year',
																	(integer)pj.Address_History_2_built_date < (integer)ut.getdate[1..4] => 'Not Current Year',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Address_History_2_built_date := table(pj, addr_h2_rc2,MAP( (integer)pj.Address_History_2_built_date = (integer)ut.getdate[1..4] => 'Current Year',
																																				(integer)pj.Address_History_2_built_date < (integer)ut.getdate[1..4] => 'Not Current Year',
																																				'UNDEFINED') ,all);																													
	
Address_History_2_full_match := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_full_match', 'Address_Verification-Address_History_2');	
Address_History_2_census_education := Scoring_Project.MACRO_Range_12_to_100(pj, 'Address_History_2_census_education', 'Address_Verification-Address_History_2');	
Address_History_2_census_home_value := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_census_home_value', 'Address_Verification-Address_History_2');	
Address_History_2_census_income := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_census_income', 'Address_Verification-Address_History_2');	
Address_History_2_census_age := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_2_census_age', 'Address_Verification-Address_History_2');	
Address_History_2_long := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_long', 'Address_Verification-Address_History_2');	
Address_History_2_lat := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_lat', 'Address_Verification-Address_History_2');	
Address_History_2_geo_blk := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_geo_blk', 'Address_Verification-Address_History_2');	
Address_History_2_county := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_county', 'Address_Verification-Address_History_2');	
Address_History_2_zip5 := Scoring_Project.MACRO_Length(pj, 'Address_History_2_zip5', 'Address_Verification-Address_History_2');	
Address_History_2_st := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_st', 'Address_Verification-Address_History_2');	
Address_History_2_city_name := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_city_name', 'Address_Verification-Address_History_2');	
Address_History_2_sec_range := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_sec_range', 'Address_Verification-Address_History_2');	
Address_History_2_unit_desig := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_unit_desig', 'Address_Verification-Address_History_2');	
Address_History_2_postdir := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_postdir', 'Address_Verification-Address_History_2');	
Address_History_2_addr_suffix := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_addr_suffix', 'Address_Verification-Address_History_2');	
Address_History_2_prim_name := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_prim_name', 'Address_Verification-Address_History_2');	
Address_History_2_predir := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_predir', 'Address_Verification-Address_History_2');	
Address_History_2_prim_range := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_prim_range', 'Address_Verification-Address_History_2');	
Address_History_2_HR_Company := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_HR_Company', 'Address_Verification-Address_History_2');	
Address_History_2_HR_Address := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_HR_Address', 'Address_Verification-Address_History_2');	
Address_History_2_style_code := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_style_code', 'Address_Verification-Address_History_2');	
Address_History_2_parking_no_of_cars := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_2_parking_no_of_cars', 'Address_Verification-Address_History_2');	
Address_History_2_garage_type_code := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_garage_type_code', 'Address_Verification-Address_History_2');	
Address_History_2_no_of_partial_baths := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_no_of_partial_baths', 'Address_Verification-Address_History_2');	
Address_History_2_no_of_baths := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_2_no_of_baths', 'Address_Verification-Address_History_2');	
Address_History_2_no_of_bedrooms := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_2_no_of_bedrooms', 'Address_Verification-Address_History_2');	
Address_History_2_no_of_rooms := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_2_no_of_rooms', 'Address_Verification-Address_History_2');	
Address_History_2_no_of_stories := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_2_no_of_stories', 'Address_Verification-Address_History_2');	
Address_History_2_no_of_buildings := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_2_no_of_buildings', 'Address_Verification-Address_History_2');	
Address_History_2_building_area := Scoring_Project.MACRO_Range_100(pj, 'Address_History_2_building_area', 'Address_Verification-Address_History_2');	
Address_History_2_standardized_land_use_code := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_standardized_land_use_code', 'Address_Verification-Address_History_2');	
Address_History_2_date_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'Address_History_2_date_last_seen', 'Address_Verification-Address_History_2', 1);	
Address_History_2_date_first_seen :=Scoring_Project.Macro_MonthsApart(pj, 'Address_History_2_date_first_seen', 'Address_Verification-Address_History_2', 1);	
Address_History_2_assessed_total_value := Scoring_Project.MACRO_Range_50000(pj, 'Address_History_2_assessed_total_value', 'Address_Verification-Address_History_2');	
Address_History_2_assessed_amount := Scoring_Project.MACRO_Range_50000(pj, 'Address_History_2_assessed_amount', 'Address_Verification-Address_History_2');	
Address_History_2_first_td_due_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Address_History_2_first_td_due_date', 'Address_Verification-Address_History_2', 30);	
Address_History_2_type_financing := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_type_financing', 'Address_Verification-Address_History_2');	
Address_History_2_mortgage_type := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_mortgage_type', 'Address_Verification-Address_History_2');	
Address_History_2_mortgage_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Address_History_2_mortgage_date', 'Address_Verification-Address_History_2', 30);	
Address_History_2_mortgage_amount := Scoring_Project.MACRO_Range_50000(pj, 'Address_History_2_mortgage_amount', 'Address_Verification-Address_History_2');	
Address_History_2_purchase_amount := Scoring_Project.MACRO_Range_50000(pj, 'Address_History_2_purchase_amount', 'Address_Verification-Address_History_2');	
Address_History_2_purchase_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Address_History_2_purchase_date', 'Address_Verification-Address_History_2', 30);	
Address_History_2_NAProp := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_NAProp', 'Address_Verification-Address_History_2');	
Address_History_2_applicant_buy_found := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_applicant_buy_found', 'Address_Verification-Address_History_2');	
Address_History_2_applicant_sale_found := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_applicant_sale_found', 'Address_Verification-Address_History_2');	
Address_History_2_family_buy_found := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_family_buy_found', 'Address_Verification-Address_History_2');	
Address_History_2_family_sale_found := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_family_sale_found', 'Address_Verification-Address_History_2');	
Address_History_2_applicant_sold := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_applicant_sold', 'Address_Verification-Address_History_2');	
Address_History_2_family_sold := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_family_sold', 'Address_Verification-Address_History_2');	
Address_History_2_family_owned := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_family_owned', 'Address_Verification-Address_History_2');	
Address_History_2_occupant_owned := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_occupant_owned', 'Address_Verification-Address_History_2');	
Address_History_2_applicant_owned := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_applicant_owned', 'Address_Verification-Address_History_2');	
Address_History_2_utility_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_utility_sourced', 'Address_Verification-Address_History_2');	
Address_History_2_voter_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_voter_sourced', 'Address_Verification-Address_History_2');	
Address_History_2_dl_sourced :=Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_dl_sourced', 'Address_Verification-Address_History_2');	
Address_History_2_eda_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_eda_sourced', 'Address_Verification-Address_History_2');	
Address_History_2_credit_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_credit_sourced', 'Address_Verification-Address_History_2');	
Address_History_2_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'Address_History_2_sources', 'Address_Verification-Address_History_2');	
Address_History_2_source_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_2_source_count', 'Address_Verification-Address_History_2');	
Address_History_2_fips_fc_index := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_fips_fc_index', 'Address_Verification-Address_History_2');	
Address_History_2_geo11_fc_index := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_geo11_fc_index', 'Address_Verification-Address_History_2');	
Address_History_2_geo12_fc_index := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_geo12_fc_index', 'Address_Verification-Address_History_2');	
Address_History_2_unit_count := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_unit_count', 'Address_Verification-Address_History_2');	
Address_History_2_isBestMatch := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_isBestMatch', 'Address_Verification-Address_History_2');	
Address_History_2_House_Number_match := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_House_Number_match', 'Address_Verification-Address_History_2');	
Address_History_2_address_score :=Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_address_score', 'Address_Verification-Address_History_2');	

// Address_History_1
	
// Address_History_1_assessed_value_year 
addr_h1_rc1 := record
string100 field_name := 'Address_History_1_assessed_value_year';
string100 category := 'Address_Verification-Address_History_1';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( (integer)pj.Address_History_1_assessed_value_year = (integer)ut.getdate[1..4] => 'Current Year',
																	(integer)pj.Address_History_1_assessed_value_year < (integer)ut.getdate[1..4] => 'Not Current Year',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Address_History_1_assessed_value_year := table(pj, addr_h1_rc1,MAP( (integer)pj.Address_History_1_assessed_value_year = (integer)ut.getdate[1..4] => 'Current Year',
																																				(integer)pj.Address_History_1_assessed_value_year < (integer)ut.getdate[1..4] => 'Not Current Year',
																																				'UNDEFINED') ,all);		
																																				



// Address_History_1_assessed_value_year 
addr_h1_rc2 := record
string100 field_name := 'Address_History_1_built_date';
string100 category := 'Address_Verification-Address_History_1';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( (integer)pj.Address_History_1_built_date = (integer)ut.getdate[1..4] => 'Current Year',
																	(integer)pj.Address_History_1_built_date < (integer)ut.getdate[1..4] => 'Not Current Year',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Address_History_1_built_date := table(pj, addr_h1_rc2,MAP( (integer)pj.Address_History_1_built_date = (integer)ut.getdate[1..4] => 'Current Year',
																																				(integer)pj.Address_History_1_built_date < (integer)ut.getdate[1..4] => 'Not Current Year',
																																				'UNDEFINED') ,all);		
																																				
																																				
Address_History_1_full_match := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_full_match', 'Address_Verification-Address_History_1');	
Address_History_1_census_education := Scoring_Project.MACRO_Range_12_to_100(pj, 'Address_History_1_census_education', 'Address_Verification-Address_History_1');	
Address_History_1_census_home_value := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_census_home_value', 'Address_Verification-Address_History_1');	
Address_History_1_census_income := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_census_income', 'Address_Verification-Address_History_1');	
Address_History_1_census_age := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_1_census_age', 'Address_Verification-Address_History_1');	
Address_History_1_long := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_long', 'Address_Verification-Address_History_1');	
Address_History_1_lat := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_lat', 'Address_Verification-Address_History_1');	
Address_History_1_geo_blk := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_geo_blk', 'Address_Verification-Address_History_1');	
Address_History_1_county := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_county', 'Address_Verification-Address_History_1');	
Address_History_1_zip5 := Scoring_Project.MACRO_Length(pj, 'Address_History_1_zip5', 'Address_Verification-Address_History_1');	
Address_History_1_st := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_st', 'Address_Verification-Address_History_1');	
Address_History_1_city_name := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_city_name', 'Address_Verification-Address_History_1');	
Address_History_1_sec_range := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_sec_range', 'Address_Verification-Address_History_1');	
Address_History_1_unit_desig := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_unit_desig', 'Address_Verification-Address_History_1');	
Address_History_1_postdir := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_postdir', 'Address_Verification-Address_History_1');	
Address_History_1_addr_suffix := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_addr_suffix', 'Address_Verification-Address_History_1');	
Address_History_1_prim_name := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_prim_name', 'Address_Verification-Address_History_1');	
Address_History_1_predir := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_predir', 'Address_Verification-Address_History_1');	
Address_History_1_prim_range := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_prim_range', 'Address_Verification-Address_History_1');	
Address_History_1_HR_Company := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_HR_Company', 'Address_Verification-Address_History_1');	
Address_History_1_HR_Address := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_HR_Address', 'Address_Verification-Address_History_1');	
Address_History_1_style_code := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_style_code', 'Address_Verification-Address_History_1');	
Address_History_1_parking_no_of_cars := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_1_parking_no_of_cars', 'Address_Verification-Address_History_1');	
Address_History_1_garage_type_code := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_garage_type_code', 'Address_Verification-Address_History_1');	
Address_History_1_no_of_partial_baths := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_no_of_partial_baths', 'Address_Verification-Address_History_1');	
Address_History_1_no_of_baths := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_1_no_of_baths', 'Address_Verification-Address_History_1');	
Address_History_1_no_of_bedrooms := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_1_no_of_bedrooms', 'Address_Verification-Address_History_1');	
Address_History_1_no_of_rooms := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_1_no_of_rooms', 'Address_Verification-Address_History_1');	
Address_History_1_no_of_stories := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_1_no_of_stories', 'Address_Verification-Address_History_1');	
Address_History_1_no_of_buildings := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_1_no_of_buildings', 'Address_Verification-Address_History_1');	
Address_History_1_building_area := Scoring_Project.MACRO_Range_100(pj, 'Address_History_1_building_area', 'Address_Verification-Address_History_1');	
Address_History_1_standardized_land_use_code := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_standardized_land_use_code', 'Address_Verification-Address_History_1');	
Address_History_1_date_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'Address_History_1_date_last_seen', 'Address_Verification-Address_History_1', 1);	
Address_History_1_date_first_seen :=Scoring_Project.Macro_MonthsApart(pj, 'Address_History_1_date_first_seen', 'Address_Verification-Address_History_1', 1);	
Address_History_1_assessed_total_value := Scoring_Project.MACRO_Range_50000(pj, 'Address_History_1_assessed_total_value', 'Address_Verification-Address_History_1');																								
Address_History_1_assessed_amount := Scoring_Project.MACRO_Range_50000(pj, 'Address_History_1_assessed_amount', 'Address_Verification-Address_History_1');	
Address_History_1_first_td_due_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Address_History_1_first_td_due_date', 'Address_Verification-Address_History_1', 30);	
Address_History_1_type_financing := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_type_financing', 'Address_Verification-Address_History_1');	
Address_History_1_mortgage_type := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_mortgage_type', 'Address_Verification-Address_History_1');	
Address_History_1_mortgage_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Address_History_1_mortgage_date', 'Address_Verification-Address_History_1', 30);	
Address_History_1_mortgage_amount := Scoring_Project.MACRO_Range_50000(pj, 'Address_History_1_mortgage_amount', 'Address_Verification-Address_History_1');	
Address_History_1_purchase_amount := Scoring_Project.MACRO_Range_50000(pj, 'Address_History_1_purchase_amount', 'Address_Verification-Address_History_1');	
Address_History_1_purchase_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Address_History_1_purchase_date', 'Address_Verification-Address_History_1', 30);	
Address_History_1_NAProp := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_NAProp', 'Address_Verification-Address_History_1');	
Address_History_1_applicant_buy_found := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_applicant_buy_found', 'Address_Verification-Address_History_1');	
Address_History_1_applicant_sale_found := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_applicant_sale_found', 'Address_Verification-Address_History_1');	
Address_History_1_family_buy_found := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_family_buy_found', 'Address_Verification-Address_History_1');	
Address_History_1_family_sale_found := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_family_sale_found', 'Address_Verification-Address_History_1');	
Address_History_1_applicant_sold := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_applicant_sold', 'Address_Verification-Address_History_1');	
Address_History_1_family_sold := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_family_sold', 'Address_Verification-Address_History_1');	
Address_History_1_family_owned := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_family_owned', 'Address_Verification-Address_History_1');	
Address_History_1_occupant_owned := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_occupant_owned', 'Address_Verification-Address_History_1');	
Address_History_1_applicant_owned := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_applicant_owned', 'Address_Verification-Address_History_1');	
Address_History_1_utility_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_utility_sourced', 'Address_Verification-Address_History_1');	
Address_History_1_voter_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_voter_sourced', 'Address_Verification-Address_History_1');	
Address_History_1_dl_sourced :=Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_dl_sourced', 'Address_Verification-Address_History_1');	
Address_History_1_eda_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_eda_sourced', 'Address_Verification-Address_History_1');	
Address_History_1_credit_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_credit_sourced', 'Address_Verification-Address_History_1');	
Address_History_1_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'Address_History_1_sources', 'Address_Verification-Address_History_1');	
Address_History_1_source_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'Address_History_1_source_count', 'Address_Verification-Address_History_1');	
Address_History_1_fips_fc_index := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_fips_fc_index', 'Address_Verification-Address_History_1');	
Address_History_1_geo11_fc_index := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_geo11_fc_index', 'Address_Verification-Address_History_1');	
Address_History_1_geo12_fc_index := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_geo12_fc_index', 'Address_Verification-Address_History_1');	
Address_History_1_unit_count := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_unit_count', 'Address_Verification-Address_History_1');	
Address_History_1_isBestMatch := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_isBestMatch', 'Address_Verification-Address_History_1');	
Address_History_1_House_Number_match := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_House_Number_match', 'Address_Verification-Address_History_1');	
Address_History_1_address_score :=Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_address_score', 'Address_Verification-Address_History_1');	

// Input_Address_Information
	
// Input_Address_Information_assessed_value_year 
addr_iai_rc1 := record
string100 field_name := 'Input_Address_Information_assessed_value_year';
string100 category := 'Address_Verification-Input_Address_Information';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( (integer)pj.Input_Address_Information_assessed_value_year = (integer)ut.getdate[1..4] => 'Current Year',
																	(integer)pj.Input_Address_Information_assessed_value_year < (integer)ut.getdate[1..4] => 'Not Current Year',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Input_Address_Information_assessed_value_year := table(pj, addr_iai_rc1,MAP( (integer)pj.Input_Address_Information_assessed_value_year = (integer)ut.getdate[1..4] => 'Current Year',
																																				(integer)pj.Input_Address_Information_assessed_value_year < (integer)ut.getdate[1..4] => 'Not Current Year',
																																				'UNDEFINED') ,all);		
																																				



// Input_Address_Information_assessed_value_year 
addr_iai_rc2 := record
string100 field_name := 'Input_Address_Information_built_date';
string100 category := 'Address_Verification-Input_Address_Information';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( (integer)pj.Input_Address_Information_built_date = (integer)ut.getdate[1..4] => 'Current Year',
																	(integer)pj.Input_Address_Information_built_date < (integer)ut.getdate[1..4] => 'Not Current Year',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Input_Address_Information_built_date := table(pj, addr_iai_rc2,MAP( (integer)pj.Input_Address_Information_built_date = (integer)ut.getdate[1..4] => 'Current Year',
																																				(integer)pj.Input_Address_Information_built_date < (integer)ut.getdate[1..4] => 'Not Current Year',
																																				'UNDEFINED') ,all);		
																																				
																																				
Input_Address_Information_full_match := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_full_match', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_census_education := Scoring_Project.MACRO_Range_12_to_100(pj, 'Input_Address_Information_census_education', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_census_home_value := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_census_home_value', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_census_income := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_census_income', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_census_age := Scoring_Project.MACRO_Range_1_to_10(pj, 'Input_Address_Information_census_age', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_long := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_long', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_lat := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_lat', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_geo_blk := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_geo_blk', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_county := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_county', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_zip5 := Scoring_Project.MACRO_Length(pj, 'Input_Address_Information_zip5', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_st := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_st', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_city_name := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_city_name', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_sec_range := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_sec_range', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_unit_desig := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_unit_desig', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_postdir := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_postdir', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_addr_suffix := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_addr_suffix', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_prim_name := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_prim_name', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_predir := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_predir', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_prim_range := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_prim_range', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_HR_Company := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_HR_Company', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_HR_Address := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_HR_Address', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_style_code := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_style_code', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_parking_no_of_cars := Scoring_Project.MACRO_Range_1_to_10(pj, 'Input_Address_Information_parking_no_of_cars', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_garage_type_code := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_garage_type_code', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_no_of_partial_baths := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_no_of_partial_baths', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_no_of_baths := Scoring_Project.MACRO_Range_1_to_10(pj, 'Input_Address_Information_no_of_baths', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_no_of_bedrooms := Scoring_Project.MACRO_Range_1_to_10(pj, 'Input_Address_Information_no_of_bedrooms', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_no_of_rooms := Scoring_Project.MACRO_Range_1_to_10(pj, 'Input_Address_Information_no_of_rooms', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_no_of_stories := Scoring_Project.MACRO_Range_1_to_10(pj, 'Input_Address_Information_no_of_stories', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_no_of_buildings := Scoring_Project.MACRO_Range_1_to_10(pj, 'Input_Address_Information_no_of_buildings', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_building_area := Scoring_Project.MACRO_Range_100(pj, 'Input_Address_Information_building_area', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_standardized_land_use_code := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_standardized_land_use_code', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_date_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'Input_Address_Information_date_last_seen', 'Address_Verification-Input_Address_Information', 1);	
Input_Address_Information_date_first_seen :=Scoring_Project.Macro_MonthsApart(pj, 'Input_Address_Information_date_first_seen', 'Address_Verification-Input_Address_Information', 1);	
Input_Address_Information_assessed_total_value := Scoring_Project.MACRO_Range_50000(pj, 'Input_Address_Information_assessed_total_value', 'Address_Verification-Input_Address_Information');																								
Input_Address_Information_assessed_amount := Scoring_Project.MACRO_Range_50000(pj, 'Input_Address_Information_assessed_amount', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_first_td_due_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Input_Address_Information_first_td_due_date', 'Address_Verification-Input_Address_Information', 30);	
Input_Address_Information_type_financing := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_type_financing', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_mortgage_type := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_mortgage_type', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_mortgage_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Input_Address_Information_mortgage_date', 'Address_Verification-Input_Address_Information', 30);	
Input_Address_Information_mortgage_amount := Scoring_Project.MACRO_Range_50000(pj, 'Input_Address_Information_mortgage_amount', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_purchase_amount := Scoring_Project.MACRO_Range_50000(pj, 'Input_Address_Information_purchase_amount', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_purchase_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Input_Address_Information_purchase_date', 'Address_Verification-Input_Address_Information', 30);	
Input_Address_Information_NAProp := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_NAProp', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_applicant_buy_found := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_applicant_buy_found', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_applicant_sale_found := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_applicant_sale_found', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_family_buy_found := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_family_buy_found', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_family_sale_found := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_family_sale_found', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_applicant_sold := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_applicant_sold', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_family_sold := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_family_sold', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_family_owned := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_family_owned', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_occupant_owned := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_occupant_owned', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_applicant_owned := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_applicant_owned', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_utility_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_utility_sourced', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_voter_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_voter_sourced', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_dl_sourced :=Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_dl_sourced', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_eda_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_eda_sourced', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_credit_sourced := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_credit_sourced', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'Input_Address_Information_sources', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_source_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'Input_Address_Information_source_count', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_fips_fc_index := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_fips_fc_index', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_geo11_fc_index := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_geo11_fc_index', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_geo12_fc_index := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_geo12_fc_index', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_unit_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'Input_Address_Information_unit_count', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_isBestMatch := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_isBestMatch', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_House_Number_match := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_House_Number_match', 'Address_Verification-Input_Address_Information');	
Input_Address_Information_address_score :=Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_address_score', 'Address_Verification-Input_Address_Information');	


owned_property_total := Scoring_Project.MACRO_Range_1_to_10(pj, 'owned_property_total', 'Address_Verification-owned');	
owned_property_owned_purchase_total := Scoring_Project.MACRO_Range_50000(pj, 'owned_property_owned_purchase_total', 'Address_Verification-owned');	
owned_property_owned_purchase_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'owned_property_owned_purchase_count', 'Address_Verification-owned');	
owned_property_owned_assessed_total := Scoring_Project.MACRO_Range_50000(pj, 'owned_property_owned_assessed_total', 'Address_Verification-owned');	
owned_property_owned_assessed_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'owned_property_owned_assessed_count', 'Address_Verification-owned');	
	
sold_property_total := Scoring_Project.MACRO_Range_1_to_10(pj, 'sold_property_total', 'Address_Verification-sold');	
sold_property_owned_purchase_total := Scoring_Project.MACRO_Range_50000(pj, 'sold_property_owned_purchase_total', 'Address_Verification-sold');	
sold_property_owned_purchase_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'sold_property_owned_purchase_count', 'Address_Verification-sold');	
sold_property_owned_assessed_total := Scoring_Project.MACRO_Range_50000(pj, 'sold_property_owned_assessed_total', 'Address_Verification-sold');	
sold_property_owned_assessed_count :=Scoring_Project.MACRO_Range_1_to_10(pj, 'sold_property_owned_assessed_count', 'Address_Verification-sold');	

	
	
ambiguous_property_total := Scoring_Project.MACRO_distinct_values(pj, 'ambiguous_property_total', 'Address_Verification-ambiguous');	
ambiguous_property_owned_purchase_total := Scoring_Project.MACRO_Range_Dollar(pj, 'ambiguous_property_owned_purchase_total', 'Address_Verification-ambiguous');	
ambiguous_property_owned_purchase_count := Scoring_Project.MACRO_distinct_values(pj, 'ambiguous_property_owned_purchase_count', 'Address_Verification-ambiguous');	
ambiguous_property_owned_assessed_total := Scoring_Project.MACRO_Range_Dollar(pj, 'ambiguous_property_owned_assessed_total', 'Address_Verification-ambiguous');	
ambiguous_property_owned_assessed_count :=Scoring_Project.MACRO_distinct_values(pj, 'ambiguous_property_owned_assessed_count', 'Address_Verification-ambiguous');	

	
prev_purch_date2 := Scoring_Project.Macro_Dates_Within_30(pj, 'prev_purch_date2', 'Address_Verification-Recent_Property_Sales', 30);	
prev_purch_price2 := Scoring_Project.MACRO_Range_50000(pj, 'prev_purch_price2', 'Address_Verification-Recent_Property_Sales');	
sale_date2 := Scoring_Project.Macro_Dates_Within_30(pj, 'sale_date2', 'Address_Verification-Recent_Property_Sales', 30);	
sale_price2 := Scoring_Project.MACRO_Range_50000(pj, 'sale_price2', 'Address_Verification-Recent_Property_Sales');	
prev_purch_date1 := Scoring_Project.Macro_Dates_Within_30(pj, 'prev_purch_date1', 'Address_Verification-Recent_Property_Sales', 30);	
prev_purch_price1 := Scoring_Project.MACRO_Range_50000(pj, 'prev_purch_price1', 'Address_Verification-Recent_Property_Sales');	
sale_date1 := Scoring_Project.Macro_Dates_Within_30(pj, 'sale_date1', 'Address_Verification-Recent_Property_Sales', 30);	
sale_price1 :=Scoring_Project.MACRO_Range_50000(pj, 'sale_price1', 'Address_Verification-Recent_Property_Sales');	

	

activePhone3 := Scoring_Project.MACRO_Length(pj, 'activePhone3', 'Address_Verification');	
edaMatchLevel3 := Scoring_Project.MACRO_distinct_values(pj, 'edaMatchLevel3', 'Address_Verification');	
activePhone2 := Scoring_Project.MACRO_Length(pj, 'activePhone2', 'Address_Verification');	
edaMatchLevel2 := Scoring_Project.MACRO_distinct_values(pj, 'edaMatchLevel2', 'Address_Verification');	
activePhone := Scoring_Project.MACRO_Length(pj, 'activePhone', 'Address_Verification');	
edaMatchLevel := Scoring_Project.MACRO_distinct_values(pj, 'edaMatchLevel', 'Address_Verification');	
addr_type3 := Scoring_Project.MACRO_distinct_values(pj, 'addr_type3', 'Address_Verification');	
addr_type2 := Scoring_Project.MACRO_distinct_values(pj, 'addr_type2', 'Address_Verification');	
addr2addr3score :=Scoring_Project.MACRO_distinct_values(pj, 'addr2addr3score', 'Address_Verification');	
addr1addr3score :=Scoring_Project.MACRO_distinct_values(pj, 'addr1addr3score', 'Address_Verification');	
addr1addr2score :=Scoring_Project.MACRO_distinct_values(pj, 'addr1addr2score', 'Address_Verification');	
distance_h1_2_h2 :=Scoring_Project.MACRO_Range_1_to_10(pj, 'distance_h1_2_h2', 'Address_Verification');	
distance_in_2_h2 :=Scoring_Project.MACRO_Range_1_to_10(pj, 'distance_in_2_h2', 'Address_Verification');	
distance_in_2_h1 :=Scoring_Project.MACRO_Range_1_to_10(pj, 'distance_in_2_h1', 'Address_Verification');		
	

Address_Verification := address_verification_unverified_addr_count + currAddr_occupancy_index + inputAddr_occupancy_index + inputAddr_non_relative_DID_count +
inputAddr_owned_not_occupied + inputAddr_not_verified + inputAddr_dirty + 
Addr_Flags_2_dropIndicator + Addr_Flags_2_addressType + Addr_Flags_2_deliveryStatus + Addr_Flags_2_doNotDeliver + Addr_Flags_2_corpMil +
Addr_Flags_2_highRisk + Addr_Flags_2_prisonAddr + Addr_Flags_2_valid + Addr_Flags_2_dwelltype +
Addr_Flags_1_dropIndicator + Addr_Flags_1_addressType + Addr_Flags_1_deliveryStatus + Addr_Flags_1_doNotDeliver + Addr_Flags_1_corpMil +
Addr_Flags_1_highRisk + Addr_Flags_1_prisonAddr + Addr_Flags_1_valid + Addr_Flags_1_dwelltype +
Address_History_2_assessed_value_year + Address_History_2_full_match + 	Address_History_2_census_education + 	Address_History_2_census_home_value + 
Address_History_2_census_income + Address_History_2_census_age + Address_History_2_long + Address_History_2_lat + Address_History_2_geo_blk + Address_History_2_county +
Address_History_2_zip5 + 	Address_History_2_st + Address_History_2_city_name + Address_History_2_sec_range + Address_History_2_unit_desig + Address_History_2_postdir +
Address_History_2_addr_suffix + Address_History_2_prim_name + Address_History_2_predir + Address_History_2_prim_range + Address_History_2_HR_Company + 
Address_History_2_HR_Address + Address_History_2_style_code + Address_History_2_parking_no_of_cars + 	Address_History_2_garage_type_code + Address_History_2_no_of_partial_baths +
Address_History_2_no_of_baths + Address_History_2_no_of_bedrooms + Address_History_2_no_of_rooms + Address_History_2_no_of_stories + 	Address_History_2_no_of_buildings +
Address_History_2_building_area + Address_History_2_standardized_land_use_code + 	Address_History_2_date_last_seen + 	Address_History_2_date_first_seen +
Address_History_2_assessed_total_value + Address_History_2_built_date + Address_History_2_assessed_amount + Address_History_2_first_td_due_date + 
Address_History_2_type_financing + Address_History_2_mortgage_type + Address_History_2_mortgage_date + Address_History_2_mortgage_amount + Address_History_2_purchase_amount +
Address_History_2_purchase_date + Address_History_2_NAProp + Address_History_2_applicant_buy_found + Address_History_2_applicant_sale_found + Address_History_2_family_buy_found +
Address_History_2_family_sale_found + Address_History_2_applicant_sold + Address_History_2_family_sold + Address_History_2_family_owned + Address_History_2_occupant_owned +
Address_History_2_applicant_owned + Address_History_2_utility_sourced + Address_History_2_voter_sourced + Address_History_2_dl_sourced + Address_History_2_eda_sourced +
Address_History_2_credit_sourced + Address_History_2_sources + Address_History_2_source_count + Address_History_2_fips_fc_index + Address_History_2_geo11_fc_index +
Address_History_2_unit_count + Address_History_2_isBestMatch + Address_History_2_House_Number_match + Address_History_2_address_score +
Address_History_1_assessed_value_year + Address_History_1_full_match + 	Address_History_1_census_education + 	Address_History_1_census_home_value + 
Address_History_1_census_income + Address_History_1_census_age + Address_History_1_long + Address_History_1_lat + Address_History_1_geo_blk + Address_History_1_county +
Address_History_1_zip5 + 	Address_History_1_st + Address_History_1_city_name + Address_History_1_sec_range + Address_History_1_unit_desig + Address_History_1_postdir +
Address_History_1_addr_suffix + Address_History_1_prim_name + Address_History_1_predir + Address_History_1_prim_range + Address_History_1_HR_Company + 
Address_History_1_HR_Address + Address_History_1_style_code + Address_History_1_parking_no_of_cars + 	Address_History_1_garage_type_code + Address_History_1_no_of_partial_baths +
Address_History_1_no_of_baths + Address_History_1_no_of_bedrooms + Address_History_1_no_of_rooms + Address_History_1_no_of_stories + 	Address_History_1_no_of_buildings +
Address_History_1_building_area + Address_History_1_standardized_land_use_code + 	Address_History_1_date_last_seen + 	Address_History_1_date_first_seen +
Address_History_1_assessed_total_value + Address_History_1_built_date + Address_History_1_assessed_amount + Address_History_1_first_td_due_date + 
Address_History_1_type_financing + Address_History_1_mortgage_type + Address_History_1_mortgage_date + Address_History_1_mortgage_amount + Address_History_1_purchase_amount +
Address_History_1_purchase_date + Address_History_1_NAProp + Address_History_1_applicant_buy_found + Address_History_1_applicant_sale_found + Address_History_1_family_buy_found +
Address_History_1_family_sale_found + Address_History_1_applicant_sold + Address_History_1_family_sold + Address_History_1_family_owned + Address_History_1_occupant_owned +
Address_History_1_applicant_owned + Address_History_1_utility_sourced + Address_History_1_voter_sourced + Address_History_1_dl_sourced + Address_History_1_eda_sourced +
Address_History_1_credit_sourced + Address_History_1_sources + Address_History_1_source_count + Address_History_1_fips_fc_index + Address_History_1_geo11_fc_index +
Address_History_1_unit_count + Address_History_1_isBestMatch + Address_History_1_House_Number_match + Address_History_1_address_score +
Input_Address_Information_assessed_value_year + Input_Address_Information_full_match + 	Input_Address_Information_census_education + 	Input_Address_Information_census_home_value + 
Input_Address_Information_census_income + Input_Address_Information_census_age + Input_Address_Information_long + Input_Address_Information_lat + Input_Address_Information_geo_blk + Input_Address_Information_county +
Input_Address_Information_zip5 + 	Input_Address_Information_st + Input_Address_Information_city_name + Input_Address_Information_sec_range + Input_Address_Information_unit_desig + Input_Address_Information_postdir +
Input_Address_Information_addr_suffix + Input_Address_Information_prim_name + Input_Address_Information_predir + Input_Address_Information_prim_range + Input_Address_Information_HR_Company + 
Input_Address_Information_HR_Address + Input_Address_Information_style_code + Input_Address_Information_parking_no_of_cars + 	Input_Address_Information_garage_type_code + Input_Address_Information_no_of_partial_baths +
Input_Address_Information_no_of_baths + Input_Address_Information_no_of_bedrooms + Input_Address_Information_no_of_rooms + Input_Address_Information_no_of_stories + 	Input_Address_Information_no_of_buildings +
Input_Address_Information_building_area + Input_Address_Information_standardized_land_use_code + 	Input_Address_Information_date_last_seen + 	Input_Address_Information_date_first_seen +
Input_Address_Information_assessed_total_value + Input_Address_Information_built_date + Input_Address_Information_assessed_amount + Input_Address_Information_first_td_due_date + 
Input_Address_Information_type_financing + Input_Address_Information_mortgage_type + Input_Address_Information_mortgage_date + Input_Address_Information_mortgage_amount + Input_Address_Information_purchase_amount +
Input_Address_Information_purchase_date + Input_Address_Information_NAProp + Input_Address_Information_applicant_buy_found + Input_Address_Information_applicant_sale_found + Input_Address_Information_family_buy_found +
Input_Address_Information_family_sale_found + Input_Address_Information_applicant_sold + Input_Address_Information_family_sold + Input_Address_Information_family_owned + Input_Address_Information_occupant_owned +
Input_Address_Information_applicant_owned + Input_Address_Information_utility_sourced + Input_Address_Information_voter_sourced + Input_Address_Information_dl_sourced + Input_Address_Information_eda_sourced +
Input_Address_Information_credit_sourced + Input_Address_Information_sources + Input_Address_Information_source_count + Input_Address_Information_fips_fc_index + Input_Address_Information_geo11_fc_index +
Input_Address_Information_unit_count + Input_Address_Information_isBestMatch + Input_Address_Information_House_Number_match + Input_Address_Information_address_score +
ambiguous_property_owned_assessed_count + ambiguous_property_owned_assessed_total + ambiguous_property_owned_purchase_count + ambiguous_property_owned_purchase_total +
ambiguous_property_total +
sold_property_owned_assessed_count + sold_property_owned_assessed_total + sold_property_owned_purchase_count + sold_property_owned_purchase_total +
sold_property_total +
owned_property_owned_assessed_count + owned_property_owned_assessed_total + owned_property_owned_purchase_count + owned_property_owned_purchase_total +
owned_property_total +
prev_purch_date2 + prev_purch_price2 + sale_date2 + sale_price2 + prev_purch_date1 + prev_purch_price1 + sale_date1 + sale_price1 + activePhone3 +
edaMatchLevel3 + activePhone2 + edaMatchLevel2 + activePhone + edaMatchLevel + addr_type3 + addr_type2 + addr2addr3score + addr1addr3score + addr1addr2score +
distance_h1_2_h2 + distance_in_2_h2 + distance_in_2_h1;

/*******************************************************************************************************************************************/
//acc_logs
/*******************************************************************************************************************************************/
Inquiry_email_ver_ct := Scoring_Project.MACRO_distinct_values(pj, 'Inquiry_email_ver_ct', 'acc_logs');	
Inquiry_phone_ver_ct := Scoring_Project.MACRO_Range_1_to_10(pj, 'Inquiry_phone_ver_ct', 'acc_logs');	
Inquiry_dob_ver_ct := Scoring_Project.MACRO_Range_1_to_10(pj, 'Inquiry_dob_ver_ct', 'acc_logs');	
Inquiry_ssn_ver_ct := Scoring_Project.MACRO_Range_1_to_10(pj, 'Inquiry_ssn_ver_ct', 'acc_logs');	
Inquiry_lname_ver_ct := Scoring_Project.MACRO_Range_1_to_10(pj, 'Inquiry_lname_ver_ct', 'acc_logs');	
Inquiry_fname_ver_ct := Scoring_Project.MACRO_Range_1_to_10(pj, 'Inquiry_fname_ver_ct', 'acc_logs');	
Inquiry_addr_ver_ct := Scoring_Project.MACRO_Range_1_to_10(pj, 'Inquiry_addr_ver_ct', 'acc_logs');	
first_log_date := Scoring_Project.Macro_Dates_Within_30(pj, 'first_log_date', 'acc_logs', 30);	
last_log_date := Scoring_Project.Macro_Dates_Within_30(pj, 'last_log_date', 'acc_logs', 30);	

Inquiries_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'Inquiries_CBDCount01', 'acc_logs-Inquiries');	
Inquiries_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'Inquiries_CBDCountTotal', 'acc_logs-Inquiries');	
Inquiries_Count24 := Scoring_Project.MACRO_Range_1_2_3(pj, 'Inquiries_Count24', 'acc_logs-Inquiries');	
Inquiries_Count12 := Scoring_Project.MACRO_Range_1_2_3(pj, 'Inquiries_Count12', 'acc_logs-Inquiries');	
Inquiries_Count06 := Scoring_Project.MACRO_Range_1_2_3(pj, 'Inquiries_Count06', 'acc_logs-Inquiries');	
Inquiries_Count03 := Scoring_Project.MACRO_Range_1_2_3(pj, 'Inquiries_Count03', 'acc_logs-Inquiries');	
Inquiries_Count01 := Scoring_Project.MACRO_Range_1_2_3(pj, 'Inquiries_Count01', 'acc_logs-Inquiries');	
Inquiries_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'Inquiries_CountWeek', 'acc_logs-Inquiries');	
Inquiries_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'Inquiries_CountDay', 'acc_logs-Inquiries');	
Inquiries_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'Inquiries_CountTotal', 'acc_logs-Inquiries');			

Collection_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'Collection_CBDCount01', 'acc_logs-Collection');	
Collection_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'Collection_CBDCountTotal', 'acc_logs-Collection');	
Collection_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Collection_Count24', 'acc_logs-Collection');	
Collection_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Collection_Count12', 'acc_logs-Collection');	
Collection_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Collection_Count06', 'acc_logs-Collection');	
Collection_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Collection_Count03', 'acc_logs-Collection');	
Collection_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Collection_Count01', 'acc_logs-Collection');	
Collection_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'Collection_CountWeek', 'acc_logs-Collection');	
Collection_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'Collection_CountDay', 'acc_logs-Collection');	
Collection_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'Collection_CountTotal', 'acc_logs-Collection');		

Auto_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'Auto_CBDCount01', 'acc_logs-Auto');	
Auto_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'Auto_CBDCountTotal', 'acc_logs-Auto');	
Auto_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Auto_Count24', 'acc_logs-Auto');	
Auto_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Auto_Count12', 'acc_logs-Auto');	
Auto_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Auto_Count06', 'acc_logs-Auto');	
Auto_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Auto_Count03', 'acc_logs-Auto');	
Auto_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Auto_Count01', 'acc_logs-Auto');	
Auto_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'Auto_CountWeek', 'acc_logs-Auto');	
Auto_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'Auto_CountDay', 'acc_logs-Auto');	
Auto_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'Auto_CountTotal', 'acc_logs-Auto');			

Banking_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'Banking_CBDCount01', 'acc_logs-Banking');	
Banking_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'Banking_CBDCountTotal', 'acc_logs-Banking');	
Banking_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Banking_Count24', 'acc_logs-Banking');	
Banking_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Banking_Count12', 'acc_logs-Banking');	
Banking_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Banking_Count06', 'acc_logs-Banking');	
Banking_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Banking_Count03', 'acc_logs-Banking');	
Banking_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Banking_Count01', 'acc_logs-Banking');	
Banking_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'Banking_CountWeek', 'acc_logs-Banking');	
Banking_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'Banking_CountDay', 'acc_logs-Banking');	
Banking_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'Banking_CountTotal', 'acc_logs-Banking');		

Mortgage_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'Mortgage_CBDCount01', 'acc_logs-Mortgage');	
Mortgage_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'Mortgage_CBDCountTotal', 'acc_logs-Mortgage');	
Mortgage_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Mortgage_Count24', 'acc_logs-Mortgage');	
Mortgage_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Mortgage_Count12', 'acc_logs-Mortgage');	
Mortgage_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Mortgage_Count06', 'acc_logs-Mortgage');	
Mortgage_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Mortgage_Count03', 'acc_logs-Mortgage');	
Mortgage_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Mortgage_Count01', 'acc_logs-Mortgage');	
Mortgage_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'Mortgage_CountWeek', 'acc_logs-Mortgage');	
Mortgage_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'Mortgage_CountDay', 'acc_logs-Mortgage');	
Mortgage_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'Mortgage_CountTotal', 'acc_logs-Mortgage');		

HighRiskCredit_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'HighRiskCredit_CBDCount01', 'acc_logs-HighRiskCredit');	
HighRiskCredit_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'HighRiskCredit_CBDCountTotal', 'acc_logs-HighRiskCredit');	
HighRiskCredit_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'HighRiskCredit_Count24', 'acc_logs-HighRiskCredit');	
HighRiskCredit_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'HighRiskCredit_Count12', 'acc_logs-HighRiskCredit');	
HighRiskCredit_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'HighRiskCredit_Count06', 'acc_logs-HighRiskCredit');	
HighRiskCredit_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'HighRiskCredit_Count03', 'acc_logs-HighRiskCredit');	
HighRiskCredit_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'HighRiskCredit_Count01', 'acc_logs-HighRiskCredit');	
HighRiskCredit_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'HighRiskCredit_CountWeek', 'acc_logs-HighRiskCredit');	
HighRiskCredit_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'HighRiskCredit_CountDay', 'acc_logs-HighRiskCredit');	
HighRiskCredit_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'HighRiskCredit_CountTotal', 'acc_logs-HighRiskCredit');		

Retail_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'Retail_CBDCount01', 'acc_logs-Retail');	
Retail_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'Retail_CBDCountTotal', 'acc_logs-Retail');	
Retail_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Retail_Count24', 'acc_logs-Retail');	
Retail_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Retail_Count12', 'acc_logs-Retail');	
Retail_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Retail_Count06', 'acc_logs-Retail');	
Retail_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Retail_Count03', 'acc_logs-Retail');	
Retail_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Retail_Count01', 'acc_logs-Retail');	
Retail_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'Retail_CountWeek', 'acc_logs-Retail');	
Retail_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'Retail_CountDay', 'acc_logs-Retail');	
Retail_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'Retail_CountTotal', 'acc_logs-Retail');		
	
Communications_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'Communications_CBDCount01', 'acc_logs-Communications');	
Communications_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'Communications_CBDCountTotal', 'acc_logs-Communications');	
Communications_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Communications_Count24', 'acc_logs-Communications');	
Communications_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Communications_Count12', 'acc_logs-Communications');	
Communications_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Communications_Count06', 'acc_logs-Communications');	
Communications_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Communications_Count03', 'acc_logs-Communications');	
Communications_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Communications_Count01', 'acc_logs-Communications');	
Communications_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'Communications_CountWeek', 'acc_logs-Communications');	
Communications_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'Communications_CountDay', 'acc_logs-Communications');	
Communications_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'Communications_CountTotal', 'acc_logs-Communications');	

FraudSearches_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'FraudSearches_Count24', 'acc_logs-FraudSearches');	
FraudSearches_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'FraudSearches_Count12', 'acc_logs-FraudSearches');	
FraudSearches_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'FraudSearches_Count06', 'acc_logs-FraudSearches');	
FraudSearches_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'FraudSearches_Count03', 'acc_logs-FraudSearches');	
FraudSearches_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'FraudSearches_Count01', 'acc_logs-FraudSearches');	
FraudSearches_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'FraudSearches_CountWeek', 'acc_logs-FraudSearches');	
FraudSearches_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'FraudSearches_CountDay', 'acc_logs-FraudSearches');	
FraudSearches_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'FraudSearches_CountTotal', 'acc_logs-FraudSearches');	

Other_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'Other_CBDCount01', 'acc_logs-Other');	
Other_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'Other_CBDCountTotal', 'acc_logs-Other');	
Other_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Other_Count24', 'acc_logs-Other');	
Other_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Other_Count12', 'acc_logs-Other');	
Other_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Other_Count06', 'acc_logs-Other');	
Other_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Other_Count03', 'acc_logs-Other');	
Other_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'Other_Count01', 'acc_logs-Other');	
Other_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'Other_CountWeek', 'acc_logs-Other');	
Other_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'Other_CountDay', 'acc_logs-Other');	
Other_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'Other_CountTotal', 'acc_logs-Other');	

prepaidCards_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'prepaidCards_CBDCount01', 'acc_logs-prepaidCards');	
prepaidCards_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'prepaidCards_CBDCountTotal', 'acc_logs-prepaidCards');	
prepaidCards_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'prepaidCards_Count24', 'acc_logs-prepaidCards');	
prepaidCards_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'prepaidCards_Count12', 'acc_logs-prepaidCards');	
prepaidCards_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'prepaidCards_Count06', 'acc_logs-prepaidCards');	
prepaidCards_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'prepaidCards_Count03', 'acc_logs-prepaidCards');	
prepaidCards_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'prepaidCards_Count01', 'acc_logs-prepaidCards');	
prepaidCards_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'prepaidCards_CountWeek', 'acc_logs-prepaidCards');	
prepaidCards_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'prepaidCards_CountDay', 'acc_logs-prepaidCards');	
prepaidCards_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'prepaidCards_CountTotal', 'acc_logs-prepaidCards');		

QuizProvider_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'QuizProvider_CBDCount01', 'acc_logs-QuizProvider');	
QuizProvider_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'QuizProvider_CBDCountTotal', 'acc_logs-QuizProvider');	
QuizProvider_Count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'QuizProvider_Count24', 'acc_logs-QuizProvider');	
QuizProvider_Count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'QuizProvider_Count12', 'acc_logs-QuizProvider');	
QuizProvider_Count06 := Scoring_Project.MACRO_Range_1_to_10(pj, 'QuizProvider_Count06', 'acc_logs-QuizProvider');	
QuizProvider_Count03 := Scoring_Project.MACRO_Range_1_to_10(pj, 'QuizProvider_Count03', 'acc_logs-QuizProvider');	
QuizProvider_Count01 := Scoring_Project.MACRO_Range_1_to_10(pj, 'QuizProvider_Count01', 'acc_logs-QuizProvider');	
QuizProvider_CountWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'QuizProvider_CountWeek', 'acc_logs-QuizProvider');	
QuizProvider_CountDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'QuizProvider_CountDay', 'acc_logs-QuizProvider');	
QuizProvider_CountTotal := Scoring_Project.MACRO_Range_1_to_10(pj, 'QuizProvider_CountTotal', 'acc_logs-QuizProvider');	

retailPayments_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'retailPayments_CBDCount01', 'acc_logs-retailPayments');	
retailPayments_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'retailPayments_CBDCountTotal', 'acc_logs-retailPayments');	
retailPayments_Count24 := Scoring_Project.MACRO_distinct_values(pj, 'retailPayments_Count24', 'acc_logs-retailPayments');	
retailPayments_Count12 := Scoring_Project.MACRO_distinct_values(pj, 'retailPayments_Count12', 'acc_logs-retailPayments');	
retailPayments_Count06 := Scoring_Project.MACRO_distinct_values(pj, 'retailPayments_Count06', 'acc_logs-retailPayments');	
retailPayments_Count03 := Scoring_Project.MACRO_distinct_values(pj, 'retailPayments_Count03', 'acc_logs-retailPayments');	
retailPayments_Count01 := Scoring_Project.MACRO_distinct_values(pj, 'retailPayments_Count01', 'acc_logs-retailPayments');	
retailPayments_CountWeek := Scoring_Project.MACRO_distinct_values(pj, 'retailPayments_CountWeek', 'acc_logs-retailPayments');	
retailPayments_CountDay := Scoring_Project.MACRO_distinct_values(pj, 'retailPayments_CountDay', 'acc_logs-retailPayments');	
retailPayments_CountTotal := Scoring_Project.MACRO_distinct_values(pj, 'retailPayments_CountTotal', 'acc_logs-retailPayments');	

StudentLoans_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'StudentLoans_CBDCount01', 'acc_logs-StudentLoans');	
StudentLoans_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'StudentLoans_CBDCountTotal', 'acc_logs-StudentLoans');	
StudentLoans_Count24 := Scoring_Project.MACRO_distinct_values(pj, 'StudentLoans_Count24', 'acc_logs-StudentLoans');	
StudentLoans_Count12 := Scoring_Project.MACRO_distinct_values(pj, 'StudentLoans_Count12', 'acc_logs-StudentLoans');	
StudentLoans_Count06 := Scoring_Project.MACRO_distinct_values(pj, 'StudentLoans_Count06', 'acc_logs-StudentLoans');	
StudentLoans_Count03 := Scoring_Project.MACRO_distinct_values(pj, 'StudentLoans_Count03', 'acc_logs-StudentLoans');	
StudentLoans_Count01 := Scoring_Project.MACRO_distinct_values(pj, 'StudentLoans_Count01', 'acc_logs-StudentLoans');	
StudentLoans_CountWeek := Scoring_Project.MACRO_distinct_values(pj, 'StudentLoans_CountWeek', 'acc_logs-StudentLoans');	
StudentLoans_CountDay := Scoring_Project.MACRO_distinct_values(pj, 'StudentLoans_CountDay', 'acc_logs-StudentLoans');	
StudentLoans_CountTotal := Scoring_Project.MACRO_distinct_values(pj, 'StudentLoans_CountTotal', 'acc_logs-StudentLoans');	
	
Utilities_CBDCount01 := Scoring_Project.MACRO_distinct_values(pj, 'Utilities_CBDCount01', 'acc_logs-Utilities');	
Utilities_CBDCountTotal := Scoring_Project.MACRO_distinct_values(pj, 'Utilities_CBDCountTotal', 'acc_logs-Utilities');	
Utilities_Count24 := Scoring_Project.MACRO_distinct_values(pj, 'Utilities_Count24', 'acc_logs-Utilities');	
Utilities_Count12 := Scoring_Project.MACRO_distinct_values(pj, 'Utilities_Count12', 'acc_logs-Utilities');	
Utilities_Count06 := Scoring_Project.MACRO_distinct_values(pj, 'Utilities_Count06', 'acc_logs-Utilities');	
Utilities_Count03 := Scoring_Project.MACRO_distinct_values(pj, 'Utilities_Count03', 'acc_logs-Utilities');	
Utilities_Count01 := Scoring_Project.MACRO_distinct_values(pj, 'Utilities_Count01', 'acc_logs-Utilities');	
Utilities_CountWeek := Scoring_Project.MACRO_distinct_values(pj, 'Utilities_CountWeek', 'acc_logs-Utilities');	
Utilities_CountDay := Scoring_Project.MACRO_distinct_values(pj, 'Utilities_CountDay', 'acc_logs-Utilities');	
Utilities_CountTotal := Scoring_Project.MACRO_distinct_values(pj, 'Utilities_CountTotal', 'acc_logs-Utilities');


Inq_BillGroup_count := Scoring_Project.MACRO_distinct_values(pj, 'Inq_BillGroup_count', 'acc_logs');	
Inq_BillGroup_count01 := Scoring_Project.MACRO_distinct_values(pj, 'Inq_BillGroup_count01', 'acc_logs');	
Inq_BillGroup_count03 := Scoring_Project.MACRO_distinct_values(pj, 'Inq_BillGroup_count03', 'acc_logs');	
Inq_BillGroup_count06 := Scoring_Project.MACRO_distinct_values(pj, 'Inq_BillGroup_count06', 'acc_logs');	
Inq_BillGroup_count12 := Scoring_Project.MACRO_distinct_values(pj, 'Inq_BillGroup_count12', 'acc_logs');	
Inq_BillGroup_count24 := Scoring_Project.MACRO_distinct_values(pj, 'Inq_BillGroup_count24', 'acc_logs');	


inquiryPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryPerADL', 'acc_logs');	
inquirySSNsPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquirySSNsPerADL', 'acc_logs');	
inquiryAddrsPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryAddrsPerADL', 'acc_logs');	
inquiryLnamesPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryLnamesPerADL', 'acc_logs');	
inquiryFnamesPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryFnamesPerADL', 'acc_logs');	
inquiryPhonesPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryPhonesPerADL', 'acc_logs');	
inquiryDOBsPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryDOBsPerADL', 'acc_logs');	


unverifiedSSNsPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'unverifiedSSNsPerADL', 'acc_logs');	
unverifiedAddrsPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'unverifiedAddrsPerADL', 'acc_logs');	
unverifiedPhonesPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'unverifiedPhonesPerADL', 'acc_logs');	
unverifiedDOBsPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'unverifiedDOBsPerADL', 'acc_logs');	
inquiryemailsperADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryemailsperADL', 'acc_logs');		

inquiryPerSSN := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryPerSSN', 'acc_logs');	
inquiryADLsPerSSN := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryADLsPerSSN', 'acc_logs');	
inquiryLNamesPerSSN := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryLNamesPerSSN', 'acc_logs');	
inquiryAddrsPerSSN := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryAddrsPerSSN', 'acc_logs');	
inquiryDOBsPerSSN := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryDOBsPerSSN', 'acc_logs');	

fraudSearchInquiryPerSSN := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerSSN', 'acc_logs');	
fraudSearchInquiryPerSSNYear := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerSSNYear', 'acc_logs');	
fraudSearchInquiryPerSSNMonth := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerSSNMonth', 'acc_logs');	
fraudSearchInquiryPerSSNWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerSSNWeek', 'acc_logs');	
fraudSearchInquiryPerSSNDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerSSNDay', 'acc_logs');	

inquiryPerAddr := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryPerAddr', 'acc_logs');	
inquiryADLsPerAddr := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryADLsPerAddr', 'acc_logs');	
inquiryLNamesPerAddr := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryLNamesPerAddr', 'acc_logs');	
inquirySSNsPerAddr := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquirySSNsPerAddr', 'acc_logs');	

fraudSearchInquiryPerAddr := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerAddr', 'acc_logs');	
fraudSearchInquiryPerAddrYear := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerAddrYear', 'acc_logs');	
fraudSearchInquiryPerAddrMonth := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerAddrMonth', 'acc_logs');	
fraudSearchInquiryPerAddrWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerAddrWeek', 'acc_logs');	
fraudSearchInquiryPerAddrDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerAddrDay', 'acc_logs');	
inquirySuspciousADLsperAddr := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquirySuspciousADLsperAddr', 'acc_logs');	

inquiryPerPhone := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryPerPhone', 'acc_logs');	
inquiryADLsPerPhone := Scoring_Project.MACRO_Range_1_to_10(pj, 'inquiryADLsPerPhone', 'acc_logs');	
fraudSearchInquiryPerPhone := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerPhone', 'acc_logs');	
fraudSearchInquiryPerPhoneYear := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerPhoneYear', 'acc_logs');	

fraudSearchInquiryPerPhoneMonth := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerPhoneMonth', 'acc_logs');	
fraudSearchInquiryPerPhoneWeek := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerPhoneWeek', 'acc_logs');	
fraudSearchInquiryPerPhoneDay := Scoring_Project.MACRO_Range_1_to_10(pj, 'fraudSearchInquiryPerPhoneDay', 'acc_logs');	
inquiryADLsPerEmail := Scoring_Project.MACRO_distinct_values(pj, 'inquiryADLsPerEmail', 'acc_logs');	

	
am_first_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'am_first_seen_date', 'acc_logs-banko', 30);	
am_last_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'am_last_seen_date', 'acc_logs-banko', 30);	
cm_first_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'cm_first_seen_date', 'acc_logs-banko', 30);	
cm_last_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'cm_last_seen_date', 'acc_logs-banko', 30);	
om_first_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'om_first_seen_date', 'acc_logs-banko', 30);	
om_last_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'om_last_seen_date', 'acc_logs-banko', 30);	
	
noncbd_first_log_date := Scoring_Project.Macro_Dates_Within_30(pj, 'noncbd_first_log_date', 'acc_logs-chargeback defender', 30);	
noncbd_last_log_date := Scoring_Project.Macro_Dates_Within_30(pj, 'noncbd_last_log_date', 'acc_logs-chargeback defender', 30);	
cbd_first_log_date := Scoring_Project.Macro_Dates_Within_30(pj, 'cbd_first_log_date', 'acc_logs-chargeback defender', 30);	
cbd_last_log_date := Scoring_Project.Macro_Dates_Within_30(pj, 'cbd_last_log_date', 'acc_logs-chargeback defender', 30);	
cbd_inquiryAddrsPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'cbd_inquiryAddrsPerADL', 'acc_logs-chargeback defender');	
cbd_inquiryADLsPerAddr := Scoring_Project.MACRO_Range_1_to_10(pj, 'cbd_inquiryADLsPerAddr', 'acc_logs-chargeback defender');	
cbd_inquiryPhonesPerADL := Scoring_Project.MACRO_Range_1_to_10(pj, 'cbd_inquiryPhonesPerADL', 'acc_logs-chargeback defender');	

acc_logs := cbd_inquiryPhonesPerADL + cbd_inquiryADLsPerAddr + cbd_inquiryAddrsPerADL + cbd_last_log_date + cbd_first_log_date + noncbd_last_log_date +
noncbd_first_log_date + om_last_seen_date + om_first_seen_date + cm_last_seen_date + cm_first_seen_date + am_last_seen_date + am_first_seen_date + 
inquiryADLsPerEmail + fraudSearchInquiryPerPhoneDay + fraudSearchInquiryPerPhoneWeek + fraudSearchInquiryPerPhoneMonth + fraudSearchInquiryPerPhoneYear +
fraudSearchInquiryPerPhone + inquiryADLsPerPhone + inquiryPerPhone + inquirySuspciousADLsperAddr + fraudSearchInquiryPerAddrDay + fraudSearchInquiryPerAddrWeek +
fraudSearchInquiryPerAddrMonth + fraudSearchInquiryPerAddrYear + fraudSearchInquiryPerAddr + inquirySSNsPerAddr + inquiryLNamesPerAddr + 
inquiryADLsPerAddr + inquiryPerAddr + fraudSearchInquiryPerSSNDay + fraudSearchInquiryPerSSNWeek + fraudSearchInquiryPerSSNMonth + fraudSearchInquiryPerSSNYear + fraudSearchInquiryPerSSN +
inquiryDOBsPerSSN + inquiryAddrsPerSSN + inquiryLNamesPerSSN + inquiryADLsPerSSN + inquiryPerSSN + inquiryemailsperADL + unverifiedDOBsPerADL +
unverifiedPhonesPerADL + unverifiedAddrsPerADL + unverifiedSSNsPerADL + inquiryDOBsPerADL + inquiryPhonesPerADL + inquiryFnamesPerADL +
inquiryLnamesPerADL + inquiryAddrsPerADL + inquirySSNsPerADL + inquiryPerADL + Inq_BillGroup_count24 + Inq_BillGroup_count12 + Inq_BillGroup_count06 +
Inq_BillGroup_count03 + Inq_BillGroup_count01 + Inq_BillGroup_count +
Utilities_CountTotal + 	Utilities_CountDay + Utilities_CountWeek + Utilities_Count01 + Utilities_Count03 + Utilities_Count06 + Utilities_Count12 +
Utilities_Count24 + Utilities_CBDCountTotal + Utilities_CBDCount01 +
StudentLoans_CountTotal + 	StudentLoans_CountDay + StudentLoans_CountWeek + StudentLoans_Count01 + StudentLoans_Count03 + StudentLoans_Count06 + StudentLoans_Count12 +
StudentLoans_Count24 + StudentLoans_CBDCountTotal + StudentLoans_CBDCount01 +
retailPayments_CountTotal + 	retailPayments_CountDay + retailPayments_CountWeek + retailPayments_Count01 + retailPayments_Count03 + retailPayments_Count06 + retailPayments_Count12 +
retailPayments_Count24 + retailPayments_CBDCountTotal + retailPayments_CBDCount01 +
QuizProvider_CountTotal + 	QuizProvider_CountDay + QuizProvider_CountWeek + QuizProvider_Count01 + QuizProvider_Count03 + QuizProvider_Count06 + QuizProvider_Count12 +
QuizProvider_Count24 + QuizProvider_CBDCountTotal + QuizProvider_CBDCount01 +	
prepaidCards_CountTotal + 	prepaidCards_CountDay + prepaidCards_CountWeek + prepaidCards_Count01 + prepaidCards_Count03 + prepaidCards_Count06 + prepaidCards_Count12 +
prepaidCards_Count24 + prepaidCards_CBDCountTotal + prepaidCards_CBDCount01 +	
Other_CountTotal + 	Other_CountDay + Other_CountWeek + Other_Count01 + Other_Count03 + Other_Count06 + Other_Count12 +
Other_Count24 + Other_CBDCountTotal + Other_CBDCount01 +	
FraudSearches_CountTotal + 	FraudSearches_CountDay + FraudSearches_CountWeek + FraudSearches_Count01 + FraudSearches_Count03 + FraudSearches_Count06 + FraudSearches_Count12 +
FraudSearches_Count24 + 	
Communications_CountTotal + 	Communications_CountDay + Communications_CountWeek + Communications_Count01 + Communications_Count03 + Communications_Count06 + Communications_Count12 +
Communications_Count24 + Communications_CBDCountTotal + Communications_CBDCount01 +	
Retail_CountTotal + 	Retail_CountDay + Retail_CountWeek + Retail_Count01 + Retail_Count03 + Retail_Count06 + Retail_Count12 +
Retail_Count24 + Retail_CBDCountTotal + Retail_CBDCount01 +
HighRiskCredit_CountTotal + 	HighRiskCredit_CountDay + HighRiskCredit_CountWeek + HighRiskCredit_Count01 + HighRiskCredit_Count03 + HighRiskCredit_Count06 + HighRiskCredit_Count12 +
HighRiskCredit_Count24 + HighRiskCredit_CBDCountTotal + HighRiskCredit_CBDCount01 +
Mortgage_CountTotal + 	Mortgage_CountDay + Mortgage_CountWeek + Mortgage_Count01 + Mortgage_Count03 + Mortgage_Count06 + Mortgage_Count12 +
Mortgage_Count24 + Mortgage_CBDCountTotal + Mortgage_CBDCount01 +
Banking_CountTotal + 	Banking_CountDay + Banking_CountWeek + Banking_Count01 + Banking_Count03 + Banking_Count06 + Banking_Count12 +
Banking_Count24 + Banking_CBDCountTotal + Banking_CBDCount01 +
Auto_CountTotal + 	Auto_CountDay + Auto_CountWeek + Auto_Count01 + Auto_Count03 + Auto_Count06 + Auto_Count12 + Auto_Count24 + Auto_CBDCountTotal + 
Auto_CBDCount01 +
Collection_CountTotal + 	Collection_CountDay + Collection_CountWeek + Collection_Count01 + Collection_Count03 + Collection_Count06 + Collection_Count12 +
Collection_Count24 + Collection_CBDCountTotal + Collection_CBDCount01 +
Inquiries_CountTotal + 	Inquiries_CountDay + Inquiries_CountWeek + Inquiries_Count01 + Inquiries_Count03 + Inquiries_Count06 + Inquiries_Count12 +
Inquiries_Count24 + Inquiries_CBDCountTotal + Inquiries_CBDCount01 + 
last_log_date + first_log_date + Inquiry_addr_ver_ct + Inquiry_fname_ver_ct + Inquiry_lname_ver_ct + Inquiry_ssn_ver_ct + Inquiry_dob_ver_ct +
Inquiry_phone_ver_ct + Inquiry_email_ver_ct;

/*******************************************************************************************************************************************/
//header_summary	
/*******************************************************************************************************************************************/	

ver_sources_recordcount := Scoring_Project.MACRO_Populating_Value(pj, 'ver_sources_recordcount', 'header_summary');
ver_sources_last_seen_date := Scoring_Project.MACRO_Populating_Value(pj, 'ver_sources_last_seen_date', 'header_summary');
ver_sources_max_first_seen_date := Scoring_Project.MACRO_Populating_Value(pj, 'ver_sources_max_first_seen_date', 'header_summary');
ver_sources_first_seen_date := Scoring_Project.MACRO_Populating_Value(pj, 'ver_sources_first_seen_date', 'header_summary');
ver_sources_NAS := Scoring_Project.MACRO_Parsing_Text(pj, 'ver_sources_NAS', 'header_summary');
ver_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'ver_sources', 'header_summary');
ver_addr_sources_recordcount := Scoring_Project.MACRO_Populating_Value(pj, 'ver_addr_sources_recordcount', 'header_summary');
ver_addr_sources_first_seen_date := Scoring_Project.MACRO_Populating_Value(pj, 'ver_addr_sources_first_seen_date', 'header_summary');
ver_addr_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'ver_addr_sources', 'header_summary');
ver_lname_sources_recordcount := Scoring_Project.MACRO_Populating_Value(pj, 'ver_lname_sources_recordcount', 'header_summary');
ver_lname_sources_first_seen_date := Scoring_Project.MACRO_Populating_Value(pj, 'ver_lname_sources_first_seen_date', 'header_summary');
ver_lname_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'ver_lname_sources', 'header_summary');
ver_fname_sources_recordcount := Scoring_Project.MACRO_Populating_Value(pj, 'ver_fname_sources_recordcount', 'header_summary');
ver_fname_sources_first_seen_date := Scoring_Project.MACRO_Populating_Value(pj, 'ver_fname_sources_first_seen_date', 'header_summary');
ver_fname_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'ver_fname_sources', 'header_summary');


ver_ssn_sources_first_seen_date := Scoring_Project.MACRO_Populating_Value(pj, 'ver_ssn_sources_first_seen_date', 'header_summary');
ver_ssn_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'ver_ssn_sources', 'header_summary');
ver_ssn_sources_recordcount := Scoring_Project.MACRO_Populating_Value(pj, 'ver_ssn_sources_recordcount', 'header_summary');
ver_dob_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'ver_dob_sources', 'header_summary');
ver_dob_sources_recordcount := Scoring_Project.MACRO_Parsing_Text(pj, 'ver_dob_sources_recordcount', 'header_summary');
ver_dob_sources_first_seen_date := Scoring_Project.MACRO_Populating_Value(pj, 'ver_dob_sources_first_seen_date', 'header_summary');
	
streets_on_file := Scoring_Project.MACRO_Populating_Value(pj, 'streets_on_file', 'header_summary');
dobs_on_file := Scoring_Project.MACRO_Populating_Value(pj, 'dobs_on_file', 'header_summary');
ssns_on_file := Scoring_Project.MACRO_Populating_Value(pj, 'ssns_on_file', 'header_summary');
phones_on_file := Scoring_Project.MACRO_Populating_Value(pj, 'phones_on_file', 'header_summary');
ssns_on_file_created12months := Scoring_Project.MACRO_Populating_Value(pj, 'ssns_on_file_created12months', 'header_summary');
dobs_on_file_created12months := Scoring_Project.MACRO_Populating_Value(pj, 'dobs_on_file_created12months', 'header_summary');
streets_on_file_created12months := Scoring_Project.MACRO_Populating_Value(pj, 'streets_on_file_created12months', 'header_summary');
phones_on_file_created12months := Scoring_Project.MACRO_distinct_values(pj, 'phones_on_file_created12months', 'header_summary');
ssn_name_source_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'ssn_name_source_count', 'header_summary');
ssn_addr_source_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'ssn_addr_source_count', 'header_summary');
addr_name_source_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'addr_name_source_count', 'header_summary');
phone_addr_source_count := Scoring_Project.MACRO_distinct_values(pj, 'phone_addr_source_count', 'header_summary');
phone_lname_source_count := Scoring_Project.MACRO_distinct_values(pj, 'phone_lname_source_count', 'header_summary');

header_build_date := Scoring_Project.MACRO_distinct_values(pj, 'header_build_date', 'header_summary');
TN_ssn_nlr := Scoring_Project.MACRO_distinct_values(pj, 'TN_ssn_nlr', 'header_summary');	
EN_ssn_nlr := Scoring_Project.MACRO_distinct_values(pj, 'EN_ssn_nlr', 'header_summary');
EQ_ssn_nlr := Scoring_Project.MACRO_distinct_values(pj, 'EQ_ssn_nlr', 'header_summary');		
TN_did_nlr := Scoring_Project.MACRO_distinct_values(pj, 'TN_did_nlr', 'header_summary');	
EN_did_nlr := Scoring_Project.MACRO_distinct_values(pj, 'EN_did_nlr', 'header_summary');
EQ_did_nlr := Scoring_Project.MACRO_distinct_values(pj, 'EQ_did_nlr', 'header_summary');		

header_summary := ver_sources + ver_sources_NAS + ver_sources_first_seen_date + ver_sources_max_first_seen_date + ver_sources_last_seen_date +
ver_sources_recordcount + ver_addr_sources_recordcount + ver_addr_sources_first_seen_date + ver_addr_sources + ver_lname_sources_recordcount + 
ver_lname_sources_first_seen_date + ver_lname_sources + ver_fname_sources_recordcount + ver_fname_sources_first_seen_date + ver_fname_sources + 
ver_ssn_sources_first_seen_date + ver_ssn_sources + ver_ssn_sources_recordcount + ver_dob_sources + ver_dob_sources_recordcount + ver_dob_sources_first_seen_date +
streets_on_file + dobs_on_file + ssns_on_file + phones_on_file + ssns_on_file_created12months + dobs_on_file_created12months + streets_on_file_created12months +
phones_on_file_created12months + ssn_name_source_count + ssn_addr_source_count + addr_name_source_count + phone_addr_source_count + phone_lname_source_count +
header_build_date + TN_ssn_nlr + EN_ssn_nlr + EQ_ssn_nlr + TN_did_nlr + EN_did_nlr + EQ_did_nlr;

/*******************************************************************************************************************************************/
//business_header_address_summary	
/*******************************************************************************************************************************************/	
bus_sources_record_cnt := Scoring_Project.MACRO_Populating_Value(pj, 'bus_sources_record_cnt', 'business_header_address_summary');
bus_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'bus_sources', 'business_header_address_summary');
bus_addr_match_cnt := Scoring_Project.MACRO_Range_1_to_10(pj, 'bus_addr_match_cnt', 'business_header_address_summary');
bus_phone_match := Scoring_Project.MACRO_distinct_values(pj, 'bus_phone_match', 'business_header_address_summary');
bus_ssn_match := Scoring_Project.MACRO_distinct_values(pj, 'bus_ssn_match', 'business_header_address_summary');
bus_name_match := Scoring_Project.MACRO_distinct_values(pj, 'bus_name_match', 'business_header_address_summary');
bus_sources_first_seen_dates := Scoring_Project.MACRO_Populating_Value(pj, 'bus_sources_first_seen_dates', 'business_header_address_summary');

business_header_address_summary := 	bus_sources_record_cnt + bus_sources + bus_addr_match_cnt + bus_phone_match + bus_ssn_match +
bus_name_match + bus_sources_first_seen_dates;
/*******************************************************************************************************************************************/
//Watercraft
/*******************************************************************************************************************************************/	
							
watercraft_count60 := Scoring_Project.MACRO_Range_1_to_10(pj, 'watercraft_count60', 'Watercraft');	
watercraft_count36 := Scoring_Project.MACRO_Range_1_to_10(pj, 'watercraft_count36', 'Watercraft');	
watercraft_count24 := Scoring_Project.MACRO_Range_1_to_10(pj, 'watercraft_count24', 'Watercraft');	
watercraft_count12 := Scoring_Project.MACRO_Range_1_to_10(pj, 'watercraft_count12', 'Watercraft');	
watercraft_count180 := Scoring_Project.MACRO_Range_1_to_10(pj, 'watercraft_count180', 'Watercraft');	
watercraft_count90 := Scoring_Project.MACRO_Range_1_to_10(pj, 'watercraft_count90', 'Watercraft');	
watercraft_count30 := Scoring_Project.MACRO_Range_1_to_10(pj, 'watercraft_count30', 'Watercraft');	
watercraft_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'watercraft_count', 'Watercraft');			

Watercraft := watercraft_count + watercraft_count30 + watercraft_count90 + watercraft_count180 + watercraft_count12 + watercraft_count24 +
watercraft_count36 + watercraft_count60;
/*******************************************************************************************************************************************/
// Vehicles
/*******************************************************************************************************************************************/	

// Vehicle1_year_make 
veh_rc1 := record
string100 field_name := 'Vehicle1_year_make';
string100 category := 'Vehicles-Vehicle1';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( pj.Vehicle1_year_make = (integer)ut.getdate[1..4] => 'Current Year',
																	pj.Vehicle1_year_make < (integer)ut.getdate[1..4] => 'Not Current Year',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Vehicle1_year_make := table(pj, veh_rc1,MAP( pj.Vehicle1_year_make = (integer)ut.getdate[1..4] => 'Current Year',
																																				pj.Vehicle1_year_make < (integer)ut.getdate[1..4] => 'Not Current Year',
																																				'UNDEFINED') ,all);		
																																

// Vehicle2_year_make 
veh_rc2 := record
string100 field_name := 'Vehicle2_year_make';
string100 category := 'Vehicles-Vehicle2';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( pj.Vehicle2_year_make = (integer)ut.getdate[1..4] => 'Current Year',
																	pj.Vehicle2_year_make < (integer)ut.getdate[1..4] => 'Not Current Year',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Vehicle2_year_make := table(pj, veh_rc2,MAP( pj.Vehicle2_year_make = (integer)ut.getdate[1..4] => 'Current Year',
																						 pj.Vehicle2_year_make < (integer)ut.getdate[1..4] => 'Not Current Year',
																							'UNDEFINED') ,all);		
																																				
// Vehicle3_year_make 
veh_rc3 := record
string100 field_name := 'Vehicle3_year_make';
string100 category := 'Vehicles-Vehicle3';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( pj.Vehicle3_year_make = (integer)ut.getdate[1..4] => 'Current Year',
																	pj.Vehicle3_year_make < (integer)ut.getdate[1..4] => 'Not Current Year',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Vehicle3_year_make := table(pj, veh_rc3,MAP( pj.Vehicle3_year_make = (integer)ut.getdate[1..4] => 'Current Year',
																				pj.Vehicle3_year_make < (integer)ut.getdate[1..4] => 'Not Current Year',
																				'UNDEFINED') ,all);		

																			
current_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'current_count', 'Vehicles');
historical_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'historical_count', 'Vehicles');

Vehicle3_vin := Scoring_Project.MACRO_Populating_Value(pj, 'Vehicle3_vin', 'Vehicles-Vehicle3');
Vehicle3_title := Scoring_Project.MACRO_distinct_values(pj, 'Vehicle3_title', 'Vehicles-Vehicle3');
Vehicle3_model := Scoring_Project.MACRO_Populating_Value(pj, 'Vehicle3_model', 'Vehicles-Vehicle3');
Vehicle3_make := Scoring_Project.MACRO_Populating_Value(pj, 'Vehicle3_make', 'Vehicles-Vehicle3');

Vehicle2_vin := Scoring_Project.MACRO_Populating_Value(pj, 'Vehicle2_vin', 'Vehicles-Vehicle2');
Vehicle2_title := Scoring_Project.MACRO_distinct_values(pj, 'Vehicle2_title', 'Vehicles-Vehicle2');
Vehicle2_model := Scoring_Project.MACRO_Populating_Value(pj, 'Vehicle2_model', 'Vehicles-Vehicle2');
Vehicle2_make := Scoring_Project.MACRO_Populating_Value(pj, 'Vehicle2_make', 'Vehicles-Vehicle2');

Vehicle1_vin := Scoring_Project.MACRO_Populating_Value(pj, 'Vehicle1_vin', 'Vehicles-Vehicle1');
Vehicle1_title := Scoring_Project.MACRO_distinct_values(pj, 'Vehicle1_title', 'Vehicles-Vehicle1');
Vehicle1_model := Scoring_Project.MACRO_Populating_Value(pj, 'Vehicle1_model', 'Vehicles-Vehicle1');
Vehicle1_make := Scoring_Project.MACRO_Populating_Value(pj, 'Vehicle1_make', 'Vehicles-Vehicle1');

Vehicles := Vehicle1_make + Vehicle1_model + Vehicle1_title + Vehicle1_vin + Vehicle1_year_make + current_count + historical_count +
						Vehicle2_make + Vehicle2_model + Vehicle2_title + Vehicle2_vin + Vehicle2_year_make +
						Vehicle3_make + Vehicle3_model + Vehicle3_title + Vehicle3_vin + Vehicle3_year_make ;

/*******************************************************************************************************************************************/
//Shell_Input
/*******************************************************************************************************************************************/
Shell_input_seq := Scoring_Project.MACRO_Length(pj, 'Shell_input_seq', 'Shell_input');
score := Scoring_Project.MACRO_Range_10(pj, 'score', 'Shell_input');
Shell_input_DID := Scoring_Project.MACRO_Length(pj, 'Shell_input_DID', 'Shell_input');
title := Scoring_Project.MACRO_distinct_values(pj, 'title', 'Shell_input');
fname := Scoring_Project.MACRO_Populating_Value(pj, 'fname', 'Shell_input');
mname := Scoring_Project.MACRO_distinct_values(pj, 'mname', 'Shell_input');
lname := Scoring_Project.MACRO_Populating_Value(pj, 'lname', 'Shell_input');
sec_range := Scoring_Project.MACRO_Populating_Value(pj, 'sec_range', 'Shell_input');

suffix := Scoring_Project.MACRO_distinct_values(pj, 'suffix', 'Shell_input');
in_streetAddress := Scoring_Project.MACRO_Populating_Value(pj, 'in_streetAddress', 'Shell_input');
in_city := Scoring_Project.MACRO_Populating_Value(pj, 'in_city', 'Shell_input');
in_state := Scoring_Project.MACRO_distinct_values(pj, 'in_state', 'Shell_input');
in_zipCode := Scoring_Project.MACRO_Length(pj, 'in_zipCode', 'Shell_input');	
in_country := Scoring_Project.MACRO_distinct_values(pj, 'in_country', 'Shell_input');
prim_range := Scoring_Project.MACRO_Populating_Value(pj, 'prim_range', 'Shell_input');
predir := Scoring_Project.MACRO_distinct_values(pj, 'predir', 'Shell_input');
addr_suffix := Scoring_Project.MACRO_Populating_Value(pj, 'addr_suffix', 'Shell_input');
prim_name := Scoring_Project.MACRO_Populating_Value(pj, 'prim_name', 'Shell_input');
postdir := Scoring_Project.MACRO_distinct_values(pj, 'postdir', 'Shell_input');
unit_desig := Scoring_Project.MACRO_distinct_values(pj, 'unit_desig', 'Shell_input');

p_city_name := Scoring_Project.MACRO_Populating_Value(pj, 'p_city_name', 'Shell_input');
st := Scoring_Project.MACRO_distinct_values(pj, 'st', 'Shell_input');
z5 := Scoring_Project.MACRO_Length(pj, 'z5', 'Shell_input');	
zip4 := Scoring_Project.MACRO_Populating_Value(pj, 'zip4', 'Shell_input');
county := Scoring_Project.MACRO_Populating_Value(pj, 'county', 'Shell_input');
long := Scoring_Project.MACRO_Populating_Value(pj, 'long', 'Shell_input');
lat := Scoring_Project.MACRO_Populating_Value(pj, 'lat', 'Shell_input');	
geo_blk := Scoring_Project.MACRO_Populating_Value(pj, 'geo_blk', 'Shell_input');
addr_type := Scoring_Project.MACRO_Populating_Value(pj, 'addr_type', 'Shell_input');
addr_status := Scoring_Project.MACRO_Populating_Value(pj, 'addr_status', 'Shell_input');	
country := Scoring_Project.MACRO_distinct_values(pj, 'country', 'Shell_input');	
Shell_input_ssn := Scoring_Project.MACRO_Length(pj, 'Shell_input_ssn', 'Shell_input');	
dob := Scoring_Project.Macro_Dates_Within_30(pj, 'dob', 'Shell_input', 30);	
Shell_input_phone10 := Scoring_Project.MACRO_Length(pj, 'Shell_input_phone10', 'Shell_input');	
Shell_input_age := Scoring_Project.MACRO_Inferred_Age(pj, 'Shell_input_age', 'Shell_input');	

lname_prev := Scoring_Project.MACRO_distinct_values(pj, 'lname_prev', 'Shell_input');	
employer_name := Scoring_Project.MACRO_distinct_values(pj, 'employer_name', 'Shell_input');	
wphone10 := Scoring_Project.MACRO_Populating_Value(pj, 'wphone10', 'Shell_input');	
ip_address := Scoring_Project.MACRO_distinct_values(pj, 'ip_address', 'Shell_input');	
email_address := Scoring_Project.MACRO_distinct_values(pj, 'email_address', 'Shell_input');	
dl_state := Scoring_Project.MACRO_distinct_values(pj, 'dl_state', 'Shell_input');	
dl_number := Scoring_Project.MACRO_distinct_values(pj, 'dl_number', 'Shell_input');	

Shell_input := Shell_input_seq + score + Shell_input_DID + title + fname + mname + lname + sec_range + suffix + in_streetAddress + in_city  + in_state +
 in_zipCode + in_country + prim_range + predir + addr_suffix + prim_name + postdir + unit_desig + p_city_name + st + z5 + zip4 + county + long + lat + 
 geo_blk + addr_type + addr_status + country + Shell_input_ssn + dob + Shell_input_phone10 + Shell_input_age + lname_prev + employer_name + wphone10 + 
 ip_address + email_address + dl_state + dl_number;
 
 /*******************************************************************************************************************************************/
//AVM-Input_Address_Information
/*******************************************************************************************************************************************/	

Input_Address_Information_avm_recording_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Input_Address_Information_avm_recording_date', 'AVM-Input_Address_Information', 30);	
Input_Address_Information_avm_land_use_code := Scoring_Project.MACRO_distinct_values(pj, 'Input_Address_Information_avm_land_use_code', 'AVM-Input_Address_Information');	

																																
// Input_Address_Information_avm_assessed_value_year 
rc3 := record
string100 field_name := 'Input_Address_Information_avm_assessed_value_year';
string100 category := 'AVM-Input_Address_Information';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( (integer)pj.Input_Address_Information_avm_assessed_value_year = 2009 => '2009',
																	(integer)pj.Input_Address_Information_avm_assessed_value_year > 2009 => 'after 2009',
																	 (integer)pj.Input_Address_Information_avm_assessed_value_year < 2009 => 'before 2009',
																	  pj.Input_Address_Information_avm_assessed_value_year = '' => 'BLANK',
																		'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Input_Address_Information_avm_assessed_value_year := table(pj, rc3,MAP( (integer)pj.Input_Address_Information_avm_assessed_value_year = 2009 => '2009',
																																(integer)pj.Input_Address_Information_avm_assessed_value_year > 2009 => 'after 2009',
																																(integer)pj.Input_Address_Information_avm_assessed_value_year < 2009 => 'before 2009',
																																 pj.Input_Address_Information_avm_assessed_value_year = '' => 'BLANK',
																																'UNDEFINED') ,all);		
																																
																														


	Input_Address_Information_avm_sales_price := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_sales_price', 'AVM-Input_Address_Information');
	Input_Address_Information_avm_assessed_total_value := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_assessed_total_value', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_market_total_value := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_market_total_value', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_tax_assessment_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_tax_assessment_valuation', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_price_index_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_price_index_valuation', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_hedonic_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_hedonic_valuation', 'AVM-Input_Address_Information');
	Input_Address_Information_avm_automated_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_automated_valuation', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_automated_valuation2 := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_automated_valuation2', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_automated_valuation3 := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_automated_valuation3', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_automated_valuation4 := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_automated_valuation4', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_automated_valuation5 := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_automated_valuation5', 'AVM-Input_Address_Information');
	Input_Address_Information_avm_automated_valuation6 := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_automated_valuation6', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_confidence_score := Scoring_Project.MACRO_Range_10(pj, 'Input_Address_Information_avm_confidence_score', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_median_fips_level := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_median_fips_level', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_median_geo11_level := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_median_geo11_level', 'AVM-Input_Address_Information');	
	Input_Address_Information_avm_median_geo12_level := Scoring_Project.MACRO_Populating_Value(pj, 'Input_Address_Information_avm_median_geo12_level', 'AVM-Input_Address_Information');	

AVM_Input_Address_Information := 	Input_Address_Information_avm_assessed_value_year + Input_Address_Information_avm_median_geo12_level + Input_Address_Information_avm_median_geo11_level +
Input_Address_Information_avm_median_fips_level + Input_Address_Information_avm_confidence_score + Input_Address_Information_avm_automated_valuation6 + 
Input_Address_Information_avm_automated_valuation5 + Input_Address_Information_avm_automated_valuation4 + Input_Address_Information_avm_automated_valuation3 + 
Input_Address_Information_avm_automated_valuation2 + Input_Address_Information_avm_automated_valuation + Input_Address_Information_avm_hedonic_valuation + 
Input_Address_Information_avm_price_index_valuation + Input_Address_Information_avm_tax_assessment_valuation + Input_Address_Information_avm_market_total_value + 
Input_Address_Information_avm_assessed_total_value + Input_Address_Information_avm_sales_price + Input_Address_Information_avm_land_use_code + Input_Address_Information_avm_recording_date;


/*******************************************************************************************************************************************/
//AVM-Address_History_1
/*******************************************************************************************************************************************/	

	Address_History_1_avm_sales_price := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_sales_price', 'AVM-Address_History_1');
	Address_History_1_avm_assessed_total_value := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_assessed_total_value', 'AVM-Address_History_1');	
	Address_History_1_avm_market_total_value := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_market_total_value', 'AVM-Address_History_1');	
	Address_History_1_avm_tax_assessment_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_tax_assessment_valuation', 'AVM-Address_History_1');	
	Address_History_1_avm_price_index_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_price_index_valuation', 'AVM-Address_History_1');	
	Address_History_1_avm_hedonic_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_hedonic_valuation', 'AVM-Address_History_1');
	Address_History_1_avm_automated_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_automated_valuation', 'AVM-Address_History_1');	
	Address_History_1_avm_automated_valuation2 := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_automated_valuation2', 'AVM-Address_History_1');	
	Address_History_1_avm_automated_valuation3 := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_automated_valuation3', 'AVM-Address_History_1');	
	Address_History_1_avm_automated_valuation4 := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_automated_valuation4', 'AVM-Address_History_1');	
	Address_History_1_avm_automated_valuation5 := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_automated_valuation5', 'AVM-Address_History_1');
	Address_History_1_avm_automated_valuation6 := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_automated_valuation6', 'AVM-Address_History_1');	
	Address_History_1_avm_confidence_score := Scoring_Project.MACRO_Range_10(pj, 'Address_History_1_avm_confidence_score', 'AVM-Address_History_1');	
	Address_History_1_avm_median_fips_level := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_median_fips_level', 'AVM-Address_History_1');	
	Address_History_1_avm_median_geo11_level := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_median_geo11_level', 'AVM-Address_History_1');	
	Address_History_1_avm_median_geo12_level := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_1_avm_median_geo12_level', 'AVM-Address_History_1');	

Address_History_1_avm_recording_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Address_History_1_avm_recording_date', 'AVM-Address_History_1', 30);	
Address_History_1_avm_land_use_code := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_1_avm_land_use_code', 'AVM-Address_History_1');	

// Address_History_1_avm_assessed_value_year 
rc2 := record
string100 field_name := 'Address_History_1_avm_assessed_value_year';
string100 category := 'AVM-Address_History_1';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( (integer)pj.Address_History_1_avm_assessed_value_year = 2009 => '2009',
																	(integer)pj.Address_History_1_avm_assessed_value_year > 2009 => 'after 2009',
																	 (integer)pj.Address_History_1_avm_assessed_value_year < 2009 => 'before 2009',
																	  pj.Address_History_1_avm_assessed_value_year = '' => 'BLANK',
																		'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Address_History_1_avm_assessed_value_year := table(pj, rc2,MAP( (integer)pj.Address_History_1_avm_assessed_value_year = 2009 => '2009',
																																(integer)pj.Address_History_1_avm_assessed_value_year > 2009 => 'after 2009',
																																(integer)pj.Address_History_1_avm_assessed_value_year < 2009 => 'before 2009',
																																 pj.Address_History_1_avm_assessed_value_year = '' => 'BLANK',
																																'UNDEFINED') ,all);		
																																
																																

AVM_Address_History_1 := 	Address_History_1_avm_assessed_value_year + Address_History_1_avm_median_geo12_level + Address_History_1_avm_median_geo11_level +
Address_History_1_avm_median_fips_level + Address_History_1_avm_confidence_score + Address_History_1_avm_automated_valuation6 + 
Address_History_1_avm_automated_valuation5 + Address_History_1_avm_automated_valuation4 + Address_History_1_avm_automated_valuation3 + 
Address_History_1_avm_automated_valuation2 + Address_History_1_avm_automated_valuation + Address_History_1_avm_hedonic_valuation + 
Address_History_1_avm_price_index_valuation + Address_History_1_avm_tax_assessment_valuation + Address_History_1_avm_market_total_value + 
Address_History_1_avm_assessed_total_value + Address_History_1_avm_sales_price + Address_History_1_avm_land_use_code + Address_History_1_avm_recording_date;

/*******************************************************************************************************************************************/
//AVM-Address_History_2
/*******************************************************************************************************************************************/	

Address_History_2_avm_recording_date := Scoring_Project.Macro_Dates_Within_30(pj, 'Address_History_2_avm_recording_date', 'AVM-Address_History_2', 30);	
Address_History_2_avm_land_use_code := Scoring_Project.MACRO_distinct_values(pj, 'Address_History_2_avm_land_use_code', 'AVM-Address_History_2');	
	Address_History_2_avm_sales_price := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_sales_price', 'AVM-Address_History_2');
	Address_History_2_avm_assessed_total_value := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_assessed_total_value', 'AVM-Address_History_2');	
	Address_History_2_avm_market_total_value := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_market_total_value', 'AVM-Address_History_2');	
	Address_History_2_avm_tax_assessment_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_tax_assessment_valuation', 'AVM-Address_History_2');	
	Address_History_2_avm_price_index_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_price_index_valuation', 'AVM-Address_History_2');	
	Address_History_2_avm_hedonic_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_hedonic_valuation', 'AVM-Address_History_2');
	Address_History_2_avm_automated_valuation := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_automated_valuation', 'AVM-Address_History_2');	
	Address_History_2_avm_automated_valuation2 := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_automated_valuation2', 'AVM-Address_History_2');	
	Address_History_2_avm_automated_valuation3 := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_automated_valuation3', 'AVM-Address_History_2');	
	Address_History_2_avm_automated_valuation4 := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_automated_valuation4', 'AVM-Address_History_2');	
	Address_History_2_avm_automated_valuation5 := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_automated_valuation5', 'AVM-Address_History_2');
	Address_History_2_avm_automated_valuation6 := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_automated_valuation6', 'AVM-Address_History_2');	
	Address_History_2_avm_confidence_score := Scoring_Project.MACRO_Range_10(pj, 'Address_History_2_avm_confidence_score', 'AVM-Address_History_2');	
	Address_History_2_avm_median_fips_level := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_median_fips_level', 'AVM-Address_History_2');	
	Address_History_2_avm_median_geo11_level := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_median_geo11_level', 'AVM-Address_History_2');	
	Address_History_2_avm_median_geo12_level := Scoring_Project.MACRO_Populating_Value(pj, 'Address_History_2_avm_median_geo12_level', 'AVM-Address_History_2');	



// Address_History_2_avm_assessed_value_year 
rc1 := record
string100 field_name := 'Address_History_2_avm_assessed_value_year';
string100 category := 'AVM-Address_History_2';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( (integer)pj.Address_History_2_avm_assessed_value_year = 2009 => '2009',
																	(integer)pj.Address_History_2_avm_assessed_value_year > 2009 => 'after 2009',
																	 (integer)pj.Address_History_2_avm_assessed_value_year < 2009 => 'before 2009',
																	  pj.Address_History_2_avm_assessed_value_year = '' => 'BLANK',
																		'UNDEFINED');
decimal20_4 frequency := count(group);
end;

Address_History_2_avm_assessed_value_year := table(pj, rc1,MAP( (integer)pj.Address_History_2_avm_assessed_value_year = 2009 => '2009',
																																(integer)pj.Address_History_2_avm_assessed_value_year > 2009 => 'after 2009',
																																(integer)pj.Address_History_2_avm_assessed_value_year < 2009 => 'before 2009',
																																 pj.Address_History_2_avm_assessed_value_year = '' => 'BLANK',
																																'UNDEFINED') ,all);
																																

	

AVM_Address_History_2 := 	Address_History_2_avm_assessed_value_year + Address_History_2_avm_median_geo12_level + Address_History_2_avm_median_geo11_level +
Address_History_2_avm_median_fips_level + Address_History_2_avm_confidence_score + Address_History_2_avm_automated_valuation6 + 
Address_History_2_avm_automated_valuation5 + Address_History_2_avm_automated_valuation4 + Address_History_2_avm_automated_valuation3 + 
Address_History_2_avm_automated_valuation2 + Address_History_2_avm_automated_valuation + Address_History_2_avm_hedonic_valuation + 
Address_History_2_avm_price_index_valuation + Address_History_2_avm_tax_assessment_valuation + Address_History_2_avm_market_total_value + 
Address_History_2_avm_assessed_total_value + Address_History_2_avm_sales_price + Address_History_2_avm_land_use_code + Address_History_2_avm_recording_date;


/*******************************************************************************************************************************************/
//liens
/*******************************************************************************************************************************************/
liens_unreleased_civil_judgment_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_unreleased_civil_judgment_total_amount', 'liens-liens_unreleased_civil_judgment');
liens_unreleased_civil_judgment_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_civil_judgment_most_recent_filing_date', 'liens-liens_unreleased_civil_judgment');
liens_unreleased_civil_judgment_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_civil_judgment_earliest_filing_date', 'liens-liens_unreleased_civil_judgment');
liens_unreleased_civil_judgment_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_civil_judgment_count', 'liens-liens_unreleased_civil_judgment');	
		

liens_released_civil_judgment_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_released_civil_judgment_total_amount', 'liens-liens_released_civil_judgment');
liens_released_civil_judgment_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_civil_judgment_most_recent_filing_date', 'liens-liens_released_civil_judgment');
liens_released_civil_judgment_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_civil_judgment_earliest_filing_date', 'liens-liens_released_civil_judgment');
liens_released_civil_judgment_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_civil_judgment_count', 'liens-liens_released_civil_judgment');	
		

liens_unreleased_federal_tax_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_unreleased_federal_tax_total_amount', 'liens-liens_unreleased_federal_tax');
liens_unreleased_federal_tax_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_federal_tax_most_recent_filing_date', 'liens-liens_unreleased_federal_tax');
liens_unreleased_federal_tax_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_federal_tax_earliest_filing_date', 'liens-liens_unreleased_federal_tax');
liens_unreleased_federal_tax_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_federal_tax_count', 'liens-liens_unreleased_federal_tax');	
	
	
liens_released_federal_tax_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_released_federal_tax_total_amount', 'liens-liens_released_federal_tax');
liens_released_federal_tax_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_federal_tax_most_recent_filing_date', 'liens-liens_released_federal_tax');
liens_released_federal_tax_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_federal_tax_earliest_filing_date', 'liens-liens_released_federal_tax');
liens_released_federal_tax_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_federal_tax_count', 'liens-liens_released_federal_tax');	
	
liens_released_foreclosure_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_released_foreclosure_total_amount', 'liens-liens_released_foreclosure');
liens_released_foreclosure_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_foreclosure_most_recent_filing_date', 'liens-liens_released_foreclosure');
liens_released_foreclosure_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_foreclosure_earliest_filing_date', 'liens-liens_released_foreclosure');
liens_released_foreclosure_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_foreclosure_count', 'liens-liens_released_foreclosure');	
	

liens_unreleased_foreclosure_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_unreleased_foreclosure_total_amount', 'liens-liens_unreleased_foreclosure');
liens_unreleased_foreclosure_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_foreclosure_most_recent_filing_date', 'liens-liens_unreleased_foreclosure');
liens_unreleased_foreclosure_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_foreclosure_earliest_filing_date', 'liens-liens_unreleased_foreclosure');
liens_unreleased_foreclosure_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_foreclosure_count', 'liens-liens_unreleased_foreclosure');	
	

liens_released_suits_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_released_suits_total_amount', 'liens-liens_released_suits');
liens_released_suits_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_suits_most_recent_filing_date', 'liens-liens_released_suits');
liens_released_suits_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_suits_earliest_filing_date', 'liens-liens_released_suits');
liens_released_suits_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_suits_count', 'liens-liens_released_suits');	
	
liens_unreleased_suits_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_unreleased_suits_total_amount', 'liens-liens_unreleased_suits');
liens_unreleased_suits_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_suits_most_recent_filing_date', 'liens-liens_unreleased_suits');
liens_unreleased_suits_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_suits_earliest_filing_date', 'liens-liens_unreleased_suits');
liens_unreleased_suits_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_suits_count', 'liens-liens_unreleased_suits');	
	

liens_released_small_claims_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_released_small_claims_total_amount', 'liens-liens_released_small_claims');
liens_released_small_claims_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_small_claims_most_recent_filing_date', 'liens-liens_released_small_claims');
liens_released_small_claims_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_small_claims_earliest_filing_date', 'liens-liens_released_small_claims');
liens_released_small_claims_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_small_claims_count', 'liens-liens_released_small_claims');	

liens_unreleased_small_claims_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_unreleased_small_claims_total_amount', 'liens-liens_unreleased_small_claims');
liens_unreleased_small_claims_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_small_claims_most_recent_filing_date', 'liens-liens_unreleased_small_claims');
liens_unreleased_small_claims_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_small_claims_earliest_filing_date', 'liens-liens_unreleased_small_claims');
liens_unreleased_small_claims_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_small_claims_count', 'liens-liens_unreleased_small_claims');	
	
	
liens_released_other_tax_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_released_other_tax_total_amount', 'liens-liens_released_other_tax');
liens_released_other_tax_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_other_tax_most_recent_filing_date', 'liens-liens_released_other_tax');
liens_released_other_tax_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_other_tax_earliest_filing_date', 'liens-liens_released_other_tax');
liens_released_other_tax_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_other_tax_count', 'liens-liens_released_other_tax');	
	
	
liens_unreleased_other_tax_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_unreleased_other_tax_total_amount', 'liens-liens_unreleased_other_tax');
liens_unreleased_other_tax_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_other_tax_most_recent_filing_date', 'liens-liens_unreleased_other_tax');
liens_unreleased_other_tax_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_other_tax_earliest_filing_date', 'liens-liens_unreleased_other_tax');
liens_unreleased_other_tax_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_other_tax_count', 'liens-liens_unreleased_other_tax');	
	
liens_released_other_lj_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_released_other_lj_total_amount', 'liens-liens_released_other_lj');
liens_released_other_lj_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_other_lj_most_recent_filing_date', 'liens-liens_released_other_lj');
liens_released_other_lj_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_other_lj_earliest_filing_date', 'liens-liens_released_other_lj');
liens_released_other_lj_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_other_lj_count', 'liens-liens_released_other_lj');

	
liens_unreleased_other_lj_total_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'liens_unreleased_other_lj_total_amount', 'liens-liens_unreleased_other_lj');
liens_unreleased_other_lj_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_other_lj_most_recent_filing_date', 'liens-liens_unreleased_other_lj');
liens_unreleased_other_lj_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_other_lj_earliest_filing_date', 'liens-liens_unreleased_other_lj');
liens_unreleased_other_lj_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_other_lj_count', 'liens-liens_unreleased_other_lj');

	
liens_released_lispendens_total_amount := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_lispendens_total_amount', 'liens-liens_released_lispendens');
liens_released_lispendens_most_recent_filing_date := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_lispendens_most_recent_filing_date', 'liens-liens_released_lispendens');
liens_released_lispendens_earliest_filing_date := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_lispendens_earliest_filing_date', 'liens-liens_released_lispendens');
liens_released_lispendens_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_lispendens_count', 'liens-liens_released_lispendens');

	
liens_unreleased_lispendens_total_amount := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_lispendens_total_amount', 'liens-liens_unreleased_lispendens');
liens_unreleased_lispendens_most_recent_filing_date := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_lispendens_most_recent_filing_date', 'liens-liens_unreleased_lispendens');
liens_unreleased_lispendens_earliest_filing_date := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_lispendens_earliest_filing_date', 'liens-liens_unreleased_lispendens');
liens_unreleased_lispendens_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_lispendens_count', 'liens-liens_unreleased_lispendens');


liens_released_landlord_tenant_total_amount := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_landlord_tenant_total_amount', 'liens-liens_released_landlord_tenant');
liens_released_landlord_tenant_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_landlord_tenant_most_recent_filing_date', 'liens-liens_released_landlord_tenant');
liens_released_landlord_tenant_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_released_landlord_tenant_earliest_filing_date', 'liens-liens_released_landlord_tenant');
liens_released_landlord_tenant_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_landlord_tenant_count', 'liens-liens_released_landlord_tenant');


liens_unreleased_landlord_tenant_total_amount := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_landlord_tenant_total_amount', 'liens-liens_unreleased_landlord_tenant');
liens_unreleased_landlord_tenant_most_recent_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_landlord_tenant_most_recent_filing_date', 'liens-liens_unreleased_landlord_tenant');
liens_unreleased_landlord_tenant_earliest_filing_date := Scoring_Project.MACRO_Populating_Value(pj, 'liens_unreleased_landlord_tenant_earliest_filing_date', 'liens-liens_unreleased_landlord_tenant');
liens_unreleased_landlord_tenant_count := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_landlord_tenant_count', 'liens-liens_unreleased_landlord_tenant');

liens := liens_unreleased_landlord_tenant_count + liens_unreleased_landlord_tenant_earliest_filing_date + liens_unreleased_landlord_tenant_most_recent_filing_date + liens_unreleased_landlord_tenant_total_amount +
liens_released_landlord_tenant_count + liens_released_landlord_tenant_earliest_filing_date + liens_released_landlord_tenant_most_recent_filing_date + liens_released_landlord_tenant_total_amount +
liens_unreleased_lispendens_count + liens_unreleased_lispendens_earliest_filing_date + liens_unreleased_lispendens_most_recent_filing_date + liens_unreleased_lispendens_total_amount + 
liens_released_lispendens_count + liens_released_lispendens_earliest_filing_date + liens_released_lispendens_most_recent_filing_date + liens_released_lispendens_total_amount + 
liens_unreleased_other_lj_count + liens_unreleased_other_lj_earliest_filing_date + liens_unreleased_other_lj_most_recent_filing_date + liens_unreleased_other_lj_total_amount +
liens_released_other_lj_count + liens_released_other_lj_earliest_filing_date + liens_released_other_lj_most_recent_filing_date + liens_released_other_lj_total_amount +
liens_unreleased_other_tax_count + liens_unreleased_other_tax_earliest_filing_date + liens_unreleased_other_tax_most_recent_filing_date + liens_unreleased_other_tax_total_amount +
liens_released_other_tax_count + liens_released_other_tax_earliest_filing_date + liens_released_other_tax_most_recent_filing_date + liens_released_other_tax_total_amount +
liens_unreleased_small_claims_count + liens_unreleased_small_claims_earliest_filing_date + liens_unreleased_small_claims_most_recent_filing_date + liens_unreleased_small_claims_total_amount +
liens_released_small_claims_count + liens_released_small_claims_earliest_filing_date + liens_released_small_claims_most_recent_filing_date + liens_released_small_claims_total_amount +
liens_unreleased_suits_count + liens_unreleased_suits_earliest_filing_date + liens_unreleased_suits_most_recent_filing_date + liens_unreleased_suits_total_amount +
liens_released_suits_count + liens_released_suits_earliest_filing_date + liens_released_suits_most_recent_filing_date + liens_released_suits_total_amount +
liens_unreleased_foreclosure_count + liens_unreleased_foreclosure_earliest_filing_date + liens_unreleased_foreclosure_most_recent_filing_date + liens_unreleased_foreclosure_total_amount +
liens_released_foreclosure_count + liens_released_foreclosure_earliest_filing_date + liens_released_foreclosure_most_recent_filing_date + liens_released_foreclosure_total_amount +
liens_unreleased_federal_tax_count + liens_unreleased_federal_tax_earliest_filing_date + liens_unreleased_federal_tax_most_recent_filing_date + liens_unreleased_federal_tax_total_amount +
liens_released_federal_tax_count + liens_released_federal_tax_earliest_filing_date + liens_released_federal_tax_most_recent_filing_date + liens_released_federal_tax_total_amount +
liens_unreleased_civil_judgment_count + liens_unreleased_civil_judgment_earliest_filing_date + liens_unreleased_civil_judgment_most_recent_filing_date + liens_unreleased_civil_judgment_total_amount +
liens_released_civil_judgment_count + liens_released_civil_judgment_earliest_filing_date + liens_released_civil_judgment_most_recent_filing_date + liens_released_civil_judgment_total_amount ;


/*******************************************************************************************************************************************/
//iid
/*******************************************************************************************************************************************/

CVI := Scoring_Project.MACRO_distinct_values(pj, 'CVI', 'iid');
NAP_Status := Scoring_Project.MACRO_distinct_values(pj, 'NAP_Status', 'iid');
NAP_Type := Scoring_Project.MACRO_distinct_values(pj, 'NAP_Type', 'iid');
NAP_Summary := Scoring_Project.MACRO_distinct_values(pj, 'NAP_Summary', 'iid');
NAS_Summary := Scoring_Project.MACRO_distinct_values(pj, 'NAS_Summary', 'iid');

	DID3 := Scoring_Project.MACRO_Populating_Value(pj, 'DID3', 'iid');
DID2 := Scoring_Project.MACRO_Populating_Value(pj, 'DID2', 'iid');
DIDCount := Scoring_Project.MACRO_distinct_values(pj, 'DIDCount', 'iid');
//// reason6 := Scoring_Project.MACRO_Populating_Value(pj, 'reason6', 'iid');	/************waiting on Ben's answer************/
//// reason5 := Scoring_Project.MACRO_Populating_Value(pj, 'reason5', 'iid');	/************waiting on Ben's answer************/
//// reason4 := Scoring_Project.MACRO_Populating_Value(pj, 'reason4', 'iid');	/************waiting on Ben's answer************/
//// reason3 := Scoring_Project.MACRO_Populating_Value(pj, 'reason3', 'iid');	/************waiting on Ben's answer************/
//// reason2 := Scoring_Project.MACRO_Populating_Value(pj, 'reason2', 'iid');	/************waiting on Ben's answer************/
//// reason1 := Scoring_Project.MACRO_Populating_Value(pj, 'reason1', 'iid');	/************waiting on Ben's answer************/

	did2_criminal_count := Scoring_Project.MACRO_distinct_values(pj, 'did2_criminal_count', 'iid');
DID2_HeaderLastSeen := Scoring_Project.MACRO_Populating_Value(pj, 'DID2_HeaderLastSeen', 'iid');
DID2_HeaderFirstSeen := Scoring_Project.MACRO_Populating_Value(pj, 'DID2_HeaderFirstSeen', 'iid');
DID2_CreditLastSeen := Scoring_Project.MACRO_Populating_Value(pj, 'DID2_CreditLastSeen', 'iid');
DID2_CreditFirstSeen := Scoring_Project.MACRO_Populating_Value(pj, 'DID2_CreditFirstSeen', 'iid');
DID2_SocsSources := Scoring_Project.MACRO_Parsing_Text(pj, 'DID2_SocsSources', 'iid');
DID2_AddrSources := Scoring_Project.MACRO_Parsing_Text(pj, 'DID2_AddrSources', 'iid');
DID2_LNameSources := Scoring_Project.MACRO_Parsing_Text(pj, 'DID2_LNameSources', 'iid');
DID2_FNameSources := Scoring_Project.MACRO_Parsing_Text(pj, 'DID2_FNameSources', 'iid');
DID2_Sources := Scoring_Project.MACRO_Parsing_Text(pj, 'DID2_Sources', 'iid');



	DID3_SocsSources := Scoring_Project.MACRO_distinct_values(pj, 'DID3_SocsSources', 'iid');
DID3_AddrSources := Scoring_Project.MACRO_distinct_values(pj, 'DID3_AddrSources', 'iid');
DID3_LNameSources := Scoring_Project.MACRO_Parsing_Text(pj, 'DID3_LNameSources', 'iid');
DID3_FNameSources := Scoring_Project.MACRO_Parsing_Text(pj, 'DID3_FNameSources', 'iid');
DID3_Sources := Scoring_Project.MACRO_Parsing_Text(pj, 'DID3_Sources', 'iid');
did2_liens_historical_released_count := Scoring_Project.MACRO_distinct_values(pj, 'did2_liens_historical_released_count', 'iid');
did2_liens_recent_released_count := Scoring_Project.MACRO_distinct_values(pj, 'did2_liens_recent_released_count', 'iid');
did2_liens_historical_unreleased_count := Scoring_Project.MACRO_distinct_values(pj, 'did2_liens_historical_unreleased_count', 'iid');
did2_liens_recent_unreleased_count := Scoring_Project.MACRO_distinct_values(pj, 'did2_liens_recent_unreleased_count', 'iid');
did2_felony_count := Scoring_Project.MACRO_distinct_values(pj, 'did2_felony_count', 'iid');


	did3_liens_historical_released_count := Scoring_Project.MACRO_distinct_values(pj, 'did3_liens_historical_released_count', 'iid');
did3_liens_recent_released_count := Scoring_Project.MACRO_distinct_values(pj, 'did3_liens_recent_released_count', 'iid');
did3_liens_historical_unreleased_count := Scoring_Project.MACRO_distinct_values(pj, 'did3_liens_historical_unreleased_count', 'iid');
did3_liens_recent_unreleased_count := Scoring_Project.MACRO_distinct_values(pj, 'did3_liens_recent_unreleased_count', 'iid');
did3_felony_count := Scoring_Project.MACRO_distinct_values(pj, 'did3_felony_count', 'iid');
did3_criminal_count := Scoring_Project.MACRO_distinct_values(pj, 'did3_criminal_count', 'iid');
DID3_HeaderLastSeen := Scoring_Project.MACRO_Populating_Value(pj, 'DID3_HeaderLastSeen', 'iid');
DID3_HeaderFirstSeen := Scoring_Project.MACRO_Populating_Value(pj, 'DID3_HeaderFirstSeen', 'iid');
DID3_CreditLastSeen := Scoring_Project.MACRO_Populating_Value(pj, 'DID3_CreditLastSeen', 'iid');
DID3_CreditFirstSeen := Scoring_Project.MACRO_Populating_Value(pj, 'DID3_CreditFirstSeen', 'iid');

	hphonetypeflag := Scoring_Project.MACRO_distinct_values(pj, 'hphonetypeflag', 'iid');
hriskphoneflag := Scoring_Project.MACRO_distinct_values(pj, 'hriskphoneflag', 'iid');
non_us_ssn := Scoring_Project.MACRO_distinct_values(pj, 'non_us_ssn', 'iid');
PWphonezipflag := Scoring_Project.MACRO_distinct_values(pj, 'PWphonezipflag', 'iid');
phonezipflag := Scoring_Project.MACRO_distinct_values(pj, 'phonezipflag', 'iid');
wphonevalflag := Scoring_Project.MACRO_distinct_values(pj, 'wphonevalflag', 'iid');
hphonevalflag := Scoring_Project.MACRO_distinct_values(pj, 'hphonevalflag', 'iid');
phonevalflag := Scoring_Project.MACRO_distinct_values(pj, 'phonevalflag', 'iid');
wphonetypeflag := Scoring_Project.MACRO_distinct_values(pj, 'wphonetypeflag', 'iid');

	pullidflag := Scoring_Project.MACRO_distinct_values(pj, 'pullidflag', 'iid');
hriskaddrflag := Scoring_Project.MACRO_distinct_values(pj, 'hriskaddrflag', 'iid');
phonever_type := Scoring_Project.MACRO_distinct_values(pj, 'phonever_type', 'iid');
phoneverlevel := Scoring_Project.MACRO_distinct_values(pj, 'phoneverlevel', 'iid');
wphonedissflag := Scoring_Project.MACRO_distinct_values(pj, 'wphonedissflag', 'iid');
phonedissflag := Scoring_Project.MACRO_distinct_values(pj, 'phonedissflag', 'iid');


	PWsocsdobflag := Scoring_Project.MACRO_distinct_values(pj, 'PWsocsdobflag', 'iid');
socsdobflag := Scoring_Project.MACRO_distinct_values(pj, 'socsdobflag', 'iid');
decsflag := Scoring_Project.MACRO_distinct_values(pj, 'decsflag', 'iid');
socsRCISflag := Scoring_Project.MACRO_distinct_values(pj, 'socsRCISflag', 'iid');
PWsocsvalflag := Scoring_Project.MACRO_distinct_values(pj, 'PWsocsvalflag', 'iid');
socsvalflag := Scoring_Project.MACRO_distinct_values(pj, 'socsvalflag', 'iid');


	//// soclstate := Scoring_Project.MACRO_Populating_Value(pj, 'soclstate', 'iid');	/************waiting on Ben's answer************/
		//// soclhighissue := Scoring_Project.MACRO_Populating_Value(pj, 'soclhighissue', 'iid');	/************commented as adviced by Ben on 03/08/2014************/
		//// socllowissue := Scoring_Project.MACRO_Populating_Value(pj, 'socllowissue', 'iid');	/************wcommented as adviced by Ben on 03/08/2014************/
		
	bansflag := Scoring_Project.MACRO_distinct_values(pj, 'bansflag', 'iid');
dwelltype := Scoring_Project.MACRO_distinct_values(pj, 'dwelltype', 'iid');
addrvalflag := Scoring_Project.MACRO_distinct_values(pj, 'addrvalflag', 'iid');
reverse_areacodesplitflag := Scoring_Project.MACRO_distinct_values(pj, 'reverse_areacodesplitflag', 'iid');
// ////altareacode := Scoring_Project.MACRO_Range_100(pj, 'altareacode', 'iid');/************commented as adviced by Ben on 03/08/2014************/
	//// ////areacodesplitdate := Scoring_Project.MACRO_Populating_Value(pj, 'areacodesplitdate', 'iid');	/************commented as adviced by Ben on 03/08/2014************/
	areacodesplitflag := Scoring_Project.MACRO_distinct_values(pj, 'areacodesplitflag', 'iid');
socsverlevel := Scoring_Project.MACRO_distinct_values(pj, 'socsverlevel', 'iid');

	socscount := Scoring_Project.MACRO_distinct_values(pj, 'socscount', 'iid');
wphonecount := Scoring_Project.MACRO_distinct_values(pj, 'wphonecount', 'iid');
// addrcount := Scoring_Project.MACRO_distinct_values(pj, 'addrcount', 'iid');
r8 := record
string100 field_name := 'addrcount';
	string100 category := 'iid';
  string30 distribution_type := 'DISTINCT-VALUE';
  string50 attribute_value := MAP((integer)pj.addrcount  = 00  => '00',
																	(integer)pj.addrcount  = 01  => '01',
																	(integer)pj.addrcount  = 02  => '02',
																	(integer)pj.addrcount  = 03  => '03',
																	(integer)pj.addrcount  = 04  => '04',
																	(integer)pj.addrcount  = 05  => '05',
																	(integer)pj.addrcount  >= 06  => '> 05',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;


addrcount := table(pj,r8,     MAP((integer)pj.addrcount  = 00  => '00',
																	(integer)pj.addrcount  = 01  => '01',
																	(integer)pj.addrcount  = 02  => '02',
																	(integer)pj.addrcount  = 03  => '03',
																	(integer)pj.addrcount  = 04  => '04',
																	(integer)pj.addrcount  = 05  => '05',
																	(integer)pj.addrcount  >= 06  => '> 05',
																	'UNDEFINED'));
																	
lastcount := Scoring_Project.MACRO_Range_5(pj, 'lastcount', 'iid');
firstcount := Scoring_Project.MACRO_Range_5(pj, 'firstcount', 'iid');
sources := Scoring_Project.MACRO_Parsing_Text(pj, 'sources', 'iid');

phoneaddrcount := Scoring_Project.MACRO_distinct_values(pj, 'phoneaddrcount', 'iid');
phonelastcount := Scoring_Project.MACRO_distinct_values(pj, 'phonelastcount', 'iid');
phonefirstcount := Scoring_Project.MACRO_distinct_values(pj, 'phonefirstcount', 'iid');
numelever := Scoring_Project.MACRO_distinct_values(pj, 'numelever', 'iid');

utiliaddr_phonecount := Scoring_Project.MACRO_distinct_values(pj, 'utiliaddr_phonecount', 'iid');
utiliaddr_addrcount := Scoring_Project.MACRO_distinct_values(pj, 'utiliaddr_addrcount', 'iid');
utiliaddr_lastcount := Scoring_Project.MACRO_distinct_values(pj, 'utiliaddr_lastcount', 'iid');
phoneaddr_phonecount := Scoring_Project.MACRO_distinct_values(pj, 'phoneaddr_phonecount', 'iid');
phoneaddr_addrcount := Scoring_Project.MACRO_distinct_values(pj, 'phoneaddr_addrcount', 'iid');
phoneaddr_lastcount := Scoring_Project.MACRO_distinct_values(pj, 'phoneaddr_lastcount', 'iid');
phoneaddr_firstcount := Scoring_Project.MACRO_distinct_values(pj, 'phoneaddr_firstcount', 'iid');
phonephonecount := Scoring_Project.MACRO_distinct_values(pj, 'phonephonecount', 'iid');


	// verlast := Scoring_Project.MACRO_Populating_Value(pj, 'verlast', 'iid');	/************waiting on Ben's answer************/
	// verfirst := Scoring_Project.MACRO_Populating_Value(pj, 'verfirst', 'iid');	/************waiting on Ben's answer************/
	
socsmiskeyflag := Scoring_Project.MACRO_distinct_values(pj, 'socsmiskeyflag', 'iid');
hphonemiskeyflag := Scoring_Project.MACRO_distinct_values(pj, 'hphonemiskeyflag', 'iid');
addrmiskeyflag := Scoring_Project.MACRO_distinct_values(pj, 'addrmiskeyflag', 'iid');
addrcommflag := Scoring_Project.MACRO_distinct_values(pj, 'addrcommflag', 'iid');
	// hrisksic := Scoring_Project.MACRO_Populating_Value(pj, 'hrisksic', 'iid');	/************waiting on Ben's answer************/
	// hrisksicphone := Scoring_Project.MACRO_Populating_Value(pj, 'hrisksicphone', 'iid');	/************waiting on Ben's answer************/
	// hriskcmpy := Scoring_Project.MACRO_Populating_Value(pj, 'hriskcmpy', 'iid');	/************waiting on Ben's answer************/
	// hriskcmpyphone := Scoring_Project.MACRO_Populating_Value(pj, 'hriskcmpyphone', 'iid');	/************waiting on Ben's answer************/
disthphoneaddr := Scoring_Project.MACRO_Range_100(pj, 'disthphoneaddr', 'iid');	


// dirs_suffix := Scoring_Project.MACRO_Populating_Value(pj, 'dirs_suffix', 'iid');	/************waiting on Ben's answer************/	
	// dirs_prim_name := Scoring_Project.MACRO_Populating_Value(pj, 'dirs_prim_name', 'iid');	/************waiting on Ben's answer************/
dirs_predir := Scoring_Project.MACRO_distinct_values(pj, 'dirs_predir', 'iid');
// dirs_prim_range := Scoring_Project.MACRO_Populating_Value(pj, 'dirs_prim_range', 'iid');	/************waiting on Ben's answer************/	
	// dirslast := Scoring_Project.MACRO_Populating_Value(pj, 'dirslast', 'iid');/************waiting on Ben's answer************/	
// dirsfirst := Scoring_Project.MACRO_Populating_Value(pj, 'dirsfirst', 'iid');	/************waiting on Ben's answer************/	
//correctlast := Scoring_Project.MACRO_Populating_Value(pj, 'correctlast', 'iid');	/************waiting on Ben's answer************/	
	// correcthphone := Scoring_Project.MACRO_Populating_Value(pj, 'correcthphone', 'iid');/************waiting on Ben's answer************/	
// correctssn := Scoring_Project.MACRO_Populating_Value(pj, 'correctssn', 'iid');	/************waiting on Ben's answer************/	
// correctdob := Scoring_Project.MACRO_distinct_values(pj, 'correctdob', 'iid');	/************waiting on Ben's answer************/	
distwphoneaddr := Scoring_Project.MACRO_distinct_values(pj, 'distwphoneaddr', 'iid');	
disthphonewphone := Scoring_Project.MACRO_distinct_values(pj, 'disthphonewphone', 'iid');


//utiliphone := Scoring_Project.MACRO_Populating_Value(pj, 'utiliphone', 'iid');	/************waiting on Ben's answer************/	
	dirsaddr_lastscore := Scoring_Project.MACRO_Range_10(pj, 'dirsaddr_lastscore', 'iid');
// dirsaddr_phone := Scoring_Project.MACRO_Populating_Value(pj, 'dirsaddr_phone', 'iid');	/************waiting on Ben's answer************/
// dirscmpy := Scoring_Project.MACRO_Populating_Value(pj, 'dirscmpy', 'iid');	/************waiting on Ben's answer************/	
	// dirszip := Scoring_Project.MACRO_Populating_Value(pj, 'dirszip', 'iid');/************waiting on Ben's answer************/	
// dirsstate := Scoring_Project.MACRO_Populating_Value(pj, 'dirsstate', 'iid');	/************waiting on Ben's answer************/	
// dirscity := Scoring_Project.MACRO_Populating_Value(pj, 'dirscity', 'iid');	/************waiting on Ben's answer************/	
	// dirs_sec_range := Scoring_Project.MACRO_Populating_Value(pj, 'dirs_sec_range', 'iid');/************waiting on Ben's answer************/	
dirs_unit_desig := Scoring_Project.MACRO_distinct_values(pj, 'dirs_unit_desig', 'iid');	
dirs_postdir := Scoring_Project.MACRO_distinct_values(pj, 'dirs_postdir', 'iid');

	cityzipflag := Scoring_Project.MACRO_distinct_values(pj, 'cityzipflag', 'iid');	
statezipflag := Scoring_Project.MACRO_distinct_values(pj, 'statezipflag', 'iid');	
drlcgender := Scoring_Project.MACRO_distinct_values(pj, 'drlcgender', 'iid');	
drlcdob := Scoring_Project.MACRO_distinct_values(pj, 'drlcdob', 'iid');	
drlcsocs := Scoring_Project.MACRO_distinct_values(pj, 'drlcsocs', 'iid');	
drlcmiddle := Scoring_Project.MACRO_distinct_values(pj, 'drlcmiddle', 'iid');
drlclast := Scoring_Project.MACRO_distinct_values(pj, 'drlclast', 'iid');	
drlcfirst := Scoring_Project.MACRO_distinct_values(pj, 'drlcfirst', 'iid');	
drlcsoundx := Scoring_Project.MACRO_distinct_values(pj, 'drlcsoundx', 'iid');	
	drlcvalflag := Scoring_Project.MACRO_distinct_values(pj, 'drlcvalflag', 'iid');	
zipclass := Scoring_Project.MACRO_distinct_values(pj, 'zipclass', 'iid');	
ziptypeflag := Scoring_Project.MACRO_distinct_values(pj, 'ziptypeflag', 'iid');	
phonetype := Scoring_Project.MACRO_distinct_values(pj, 'phonetype', 'iid');	

// chronounit_desig := Scoring_Project.MACRO_Populating_Value(pj, 'chronounit_desig', 'iid');	/************waiting on Ben's answer************/	
	chronopostdir := Scoring_Project.MACRO_distinct_values(pj, 'chronopostdir', 'iid');
//chronosuffix := Scoring_Project.MACRO_Populating_Value(pj, 'chronosuffix', 'iid');	/************waiting on Ben's answer************/
// chronoprim_name := Scoring_Project.MACRO_Populating_Value(pj, 'chronoprim_name', 'iid');	/************waiting on Ben's answer************/	
	c := Scoring_Project.MACRO_distinct_values(pj, 'chronopredir', 'iid');
//chronoprim_range := Scoring_Project.MACRO_Populating_Value(pj, 'chronoprim_range', 'iid');	/************waiting on Ben's answer************/		

	// chrono_sources := Scoring_Project.MACRO_Populating_Value(pj, 'chrono_sources', 'iid');/************waiting on Ben's answer************/
chronoMatchLevel := Scoring_Project.MACRO_distinct_values(pj, 'chronoMatchLevel', 'iid');
	// chronoActivePhone := Scoring_Project.MACRO_Populating_Value(pj, 'chronoActivePhone', 'iid');/************waiting on Ben's answer************/
//chronophone := Scoring_Project.MACRO_Populating_Value(pj, 'chronophone', 'iid');	/************waiting on Ben's answer************/
//chronozip := Scoring_Project.MACRO_Populating_Value(pj, 'chronozip', 'iid');	/************waiting on Ben's answer************/	
	//chronostate := Scoring_Project.MACRO_Populating_Value(pj, 'chronostate', 'iid');/************waiting on Ben's answer************/
// chronocity := Scoring_Project.MACRO_Populating_Value(pj, 'chronocity', 'iid');	/************waiting on Ben's answer************/
// chronosec_range := Scoring_Project.MACRO_Populating_Value(pj, 'chronosec_range', 'iid');	/************waiting on Ben's answer************/		
	
	chrono_addr_flags_dropIndicator := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags_dropIndicator', 'iid-chrono_addr_flags');	
chrono_addr_flags_addressType := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags_addressType', 'iid-chrono_addr_flags');	
chrono_addr_flags_deliveryStatus := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags_deliveryStatus', 'iid-chrono_addr_flags');	
chrono_addr_flags_doNotDeliver := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags_doNotDeliver', 'iid-chrono_addr_flags');	
chrono_addr_flags_corpMil := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags_corpMil', 'iid-chrono_addr_flags');	
chrono_addr_flags_highRisk := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags_highRisk', 'iid-chrono_addr_flags');
chrono_addr_flags_prisonAddr := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags_prisonAddr', 'iid-chrono_addr_flags');	
chrono_addr_flags_valid := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags_valid', 'iid-chrono_addr_flags');	
chrono_addr_flags_dwelltype := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags_dwelltype', 'iid-chrono_addr_flags');

// chronounit_desig2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronounit_desig2', 'iid');	/************waiting on Ben's answer************/	
	chronopostdir2 := Scoring_Project.MACRO_distinct_values(pj, 'chronopostdir2', 'iid');
// chronosuffix2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronosuffix2', 'iid');	/************waiting on Ben's answer************/
// chronoprim_name2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronoprim_name2', 'iid');	/************waiting on Ben's answer************/	
	chronopredir2 := Scoring_Project.MACRO_distinct_values(pj, 'chronopredir2', 'iid');
//chronoprim_range2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronoprim_range2', 'iid');	/************waiting on Ben's answer************/		

	// chrono_sources2 := Scoring_Project.MACRO_Populating_Value(pj, 'chrono_sources2', 'iid');/************waiting on Ben's answer************/
chronoMatchLevel2 := Scoring_Project.MACRO_distinct_values(pj, 'chronoMatchLevel2', 'iid');
	// chronoActivePhone2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronoActivePhone2', 'iid');/************waiting on Ben's answer************/
// chronophone2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronophone2', 'iid');	/************waiting on Ben's answer************/
//chronozip2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronozip2', 'iid');	/************waiting on Ben's answer************/	
	//chronostate2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronostate2', 'iid');/************waiting on Ben's answer************/
//chronocity2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronocity2', 'iid');	/************waiting on Ben's answer************/
//chronosec_range2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronosec_range2', 'iid');	/************waiting on Ben's answer************/	
	
chrono_addr_flags2_dropIndicator := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags2_dropIndicator', 'iid-chrono_addr_flags2');	
chrono_addr_flags2_addressType := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags2_addressType', 'iid-chrono_addr_flags2');	
chrono_addr_flags2_deliveryStatus := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags2_deliveryStatus', 'iid-chrono_addr_flags2');	
chrono_addr_flags2_doNotDeliver := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags2_doNotDeliver', 'iid-chrono_addr_flags2');	
chrono_addr_flags2_corpMil := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags2_corpMil', 'iid-chrono_addr_flags2');	
chrono_addr_flags2_highRisk := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags2_highRisk', 'iid-chrono_addr_flags2');
chrono_addr_flags2_prisonAddr := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags2_prisonAddr', 'iid-chrono_addr_flags2');	
chrono_addr_flags2_valid := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags2_valid', 'iid-chrono_addr_flags2');	
chrono_addr_flags2_dwelltype := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags2_dwelltype', 'iid-chrono_addr_flags2');

// chronoprim_range3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronoprim_range3', 'iid');	/************waiting on Ben's answer************/	
//chronounit_desig3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronounit_desig3', 'iid');	/************waiting on Ben's answer************/	
	chronopostdir3 := Scoring_Project.MACRO_distinct_values(pj, 'chronopostdir3', 'iid');
//chronosuffix3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronosuffix3', 'iid');	/************waiting on Ben's answer************/
//chronoprim_name3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronoprim_name3', 'iid');	/************waiting on Ben's answer************/	
	chronopredir3 := Scoring_Project.MACRO_distinct_values(pj, 'chronopredir3', 'iid');
	
		//chrono_sources3 := Scoring_Project.MACRO_Populating_Value(pj, 'chrono_sources3', 'iid');/************waiting on Ben's answer************/
chronoMatchLevel3 := Scoring_Project.MACRO_distinct_values(pj, 'chronoMatchLevel3', 'iid');
	// chronoActivePhone3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronoActivePhone3', 'iid');/************waiting on Ben's answer************/
//chronophone3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronophone3', 'iid');	/************waiting on Ben's answer************/
//chronozip3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronozip3', 'iid');	/************waiting on Ben's answer************/	
	// chronostate3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronostate3', 'iid');/************waiting on Ben's answer************/
//chronocity3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronocity3', 'iid');	/************waiting on Ben's answer************/
// chronosec_range3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronosec_range3', 'iid');	/************waiting on Ben's answer************/	

	chrono_addr_flags3_dropIndicator := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags3_dropIndicator', 'iid-chrono_addr_flags3');	
chrono_addr_flags3_addressType := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags3_addressType', 'iid-chrono_addr_flags3');	
chrono_addr_flags3_deliveryStatus := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags3_deliveryStatus', 'iid-chrono_addr_flags3');	
chrono_addr_flags3_doNotDeliver := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags3_doNotDeliver', 'iid-chrono_addr_flags3');	
chrono_addr_flags3_corpMil := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags3_corpMil', 'iid-chrono_addr_flags3');	
chrono_addr_flags3_highRisk := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags3_highRisk', 'iid-chrono_addr_flags3');
chrono_addr_flags3_prisonAddr := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags3_prisonAddr', 'iid-chrono_addr_flags3');	
chrono_addr_flags3_valid := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags3_valid', 'iid-chrono_addr_flags3');	
chrono_addr_flags3_dwelltype := Scoring_Project.MACRO_distinct_values(pj, 'chrono_addr_flags3_dwelltype', 'iid-chrono_addr_flags3');

	ssnexists := Scoring_Project.MACRO_distinct_values(pj, 'ssnexists', 'iid');	
firstssnmatch := Scoring_Project.MACRO_distinct_values(pj, 'firstssnmatch', 'iid');	
lastssnmatch2 := Scoring_Project.MACRO_distinct_values(pj, 'lastssnmatch2', 'iid');	
lastssnmatch := Scoring_Project.MACRO_distinct_values(pj, 'lastssnmatch', 'iid');	
altlast2Pop := Scoring_Project.MACRO_distinct_values(pj, 'altlast2Pop', 'iid');	
altlastPop := Scoring_Project.MACRO_distinct_values(pj, 'altlastPop', 'iid');

	// altlast2 := Scoring_Project.MACRO_Populating_Value(pj, 'altlast2', 'iid');/************waiting on Ben's answer************/
// altlast := Scoring_Project.MACRO_Populating_Value(pj, 'altlast', 'iid');	/************waiting on Ben's answer************/
// chronodate_first3 := Scoring_Project.MACRO_Populating_Value(pj, 'chronodate_first3', 'iid');	/************waiting on Ben's answer************/
// chronodate_first2 := Scoring_Project.MACRO_Populating_Value(pj, 'chronodate_first2', 'iid');/************waiting on Ben's answer************/
// chronodate_first := Scoring_Project.MACRO_Populating_Value(pj, 'chronodate_first', 'iid');	/************waiting on Ben's answer************/	
	
combo_suffix := Scoring_Project.MACRO_Populating_Value(pj, 'combo_suffix', 'iid');	/************as suggested by ben on 03/07/2014************/
//combo_prim_name := Scoring_Project.MACRO_Populating_Value(pj, 'combo_prim_name', 'iid');	/************commented as suggested by ben on 03/07/2014************/
//combo_prim_range := Scoring_Project.MACRO_Populating_Value(pj, 'combo_prim_range', 'iid');/************commented as suggested by ben on 03/07/2014************/
//combo_first := Scoring_Project.MACRO_Populating_Value(pj, 'combo_first', 'iid');	/************commented as suggested by ben on 03/07/2014************/
//combo_last := Scoring_Project.MACRO_Populating_Value(pj, 'combo_last', 'iid');	/************commented as suggested by ben on 03/07/2014************/

combo_unit_desig := Scoring_Project.MACRO_distinct_values(pj, 'combo_unit_desig', 'iid');	
combo_postdir := Scoring_Project.MACRO_distinct_values(pj, 'combo_postdir', 'iid');	
combo_ssnscore := Scoring_Project.MACRO_distinct_values(pj, 'combo_ssnscore', 'iid');	
combo_hphonescore := Scoring_Project.MACRO_distinct_values(pj, 'combo_hphonescore', 'iid');	
combo_sec_rangescore := Scoring_Project.MACRO_distinct_values(pj, 'combo_sec_rangescore', 'iid');	
combo_addrscore := Scoring_Project.MACRO_distinct_values(pj, 'combo_addrscore', 'iid');
combo_predir := Scoring_Project.MACRO_distinct_values(pj, 'combo_predir', 'iid');


	combo_lastscore := Scoring_Project.MACRO_Range_10(pj, 'combo_lastscore', 'iid');	
combo_firstscore := Scoring_Project.MACRO_Range_10(pj, 'combo_firstscore', 'iid');	
// combo_cmpy := Scoring_Project.MACRO_Populating_Value(pj, 'combo_cmpy', 'iid');	/************waiting on Ben's answer************/
// combo_dob := Scoring_Project.MACRO_Populating_Value(pj, 'combo_dob', 'iid');	/************waiting on Ben's answer************/
// combo_ssn := Scoring_Project.MACRO_Populating_Value(pj, 'combo_ssn', 'iid');	/************waiting on Ben's answer************/
// combo_hphone := Scoring_Project.MACRO_Populating_Value(pj, 'combo_hphone', 'iid');/************waiting on Ben's answer************/
// combo_zip := Scoring_Project.MACRO_Populating_Value(pj, 'combo_zip', 'iid');	/************waiting on Ben's answer************/
// combo_state := Scoring_Project.MACRO_Populating_Value(pj, 'combo_state', 'iid');	/************waiting on Ben's answer************/
// combo_city := Scoring_Project.MACRO_Populating_Value(pj, 'combo_city', 'iid');	/************waiting on Ben's answer************/
// combo_sec_range := Scoring_Project.MACRO_Populating_Value(pj, 'combo_sec_range', 'iid');/************waiting on Ben's answer************/

	combo_cmpyscore := Scoring_Project.MACRO_distinct_values(pj, 'combo_cmpyscore', 'iid');	
combo_dobscore := Scoring_Project.MACRO_distinct_values(pj, 'combo_dobscore', 'iid');	

	combo_dobcount := Scoring_Project.MACRO_Range_5(pj, 'combo_dobcount', 'iid');	
combo_ssncount := Scoring_Project.MACRO_distinct_values(pj, 'combo_ssncount', 'iid');	
combo_hphonecount := Scoring_Project.MACRO_distinct_values(pj, 'combo_hphonecount', 'iid');	
combo_addrcount := Scoring_Project.MACRO_distinct_values(pj, 'combo_addrcount', 'iid');	
combo_lastcount := Scoring_Project.MACRO_Range_5(pj, 'combo_lastcount', 'iid');	
combo_firstcount := Scoring_Project.MACRO_Range_5(pj, 'combo_firstcount', 'iid');


// watchlist_address := Scoring_Project.MACRO_Populating_Value(pj, 'watchlist_address', 'iid');	/****commented  as suggested by Ben on 03/07/2014*******/
//watchlist_lname := Scoring_Project.MACRO_Populating_Value(pj, 'watchlist_lname', 'iid');	/****commented  as suggested by Ben on 03/07/2014*******/
//watchlist_fname := Scoring_Project.MACRO_Populating_Value(pj, 'watchlist_fname', 'iid');	/****commented  as suggested by Ben on 03/07/2014*******/
watchlist_record_number := Scoring_Project.MACRO_Populating_Value(pj, 'watchlist_record_number', 'iid');	/*********as suggested by Ben on 03/07/2014***********************/
watchlist_table := Scoring_Project.MACRO_distinct_values(pj, 'watchlist_table', 'iid');	
combo_cmpycount := Scoring_Project.MACRO_distinct_values(pj, 'combo_cmpycount', 'iid');	

inputAddrNotMostRecent := Scoring_Project.MACRO_distinct_values(pj, 'inputAddrNotMostRecent', 'iid');	
name_addr_phone := Scoring_Project.MACRO_Populating_Value(pj, 'name_addr_phone', 'iid');	/*********as suggested by Ben on 03/07/2014***********************/
wphonezip := Scoring_Project.MACRO_distinct_values(pj, 'wphonezip', 'iid');	
wphonestate := Scoring_Project.MACRO_distinct_values(pj, 'wphonestate', 'iid');	
wphonecity := Scoring_Project.MACRO_distinct_values(pj, 'wphonecity', 'iid');	
wphoneaddr := Scoring_Project.MACRO_distinct_values(pj, 'wphoneaddr', 'iid');	

	wphonename := Scoring_Project.MACRO_distinct_values(pj, 'wphonename', 'iid');	
//watchlist_entity_name := Scoring_Project.MACRO_Populating_Value(pj, 'watchlist_entity_name', 'iid');/****commented  as suggested by Ben on 03/07/2014*******/
watchlistHit := Scoring_Project.MACRO_distinct_values(pj, 'watchlistHit', 'iid');	
watchlist_zip := Scoring_Project.MACRO_distinct_values(pj, 'watchlist_zip', 'iid');	
watchlist_state := Scoring_Project.MACRO_distinct_values(pj, 'watchlist_state', 'iid');	
watchlist_city := Scoring_Project.MACRO_distinct_values(pj, 'watchlist_city', 'iid');	


	targustype := Scoring_Project.MACRO_distinct_values(pj, 'targustype', 'iid');	
targusgatewayused := Scoring_Project.MACRO_distinct_values(pj, 'targusgatewayused', 'iid');	
DIDdeceasedlast := Scoring_Project.MACRO_Populating_Value(pj, 'DIDdeceasedlast', 'iid');	
DIDdeceasedfirst := Scoring_Project.MACRO_Populating_Value(pj, 'DIDdeceasedfirst', 'iid');	
DIDdeceasedDOB := Scoring_Project.Macro_Dates_Within_30(pj, 'DIDdeceasedDOB', 'iid', 30);	
DIDdeceasedDate := Scoring_Project.Macro_Dates_Within_30(pj, 'DIDdeceasedDate', 'iid', 30);	

DIDdeceased := Scoring_Project.MACRO_distinct_values(pj, 'DIDdeceased', 'iid');	
EverAssocIm := Scoring_Project.MACRO_distinct_values(pj, 'EverAssocIm', 'iid');	
EverAssocITIN := Scoring_Project.MACRO_distinct_values(pj, 'EverAssocITIN', 'iid');	
IsShiptoBilltoDifferent := Scoring_Project.MACRO_distinct_values(pj, 'IsShiptoBilltoDifferent', 'iid');	
verified_DL := Scoring_Project.MACRO_distinct_values(pj, 'verified_DL', 'iid');	
DL_score := Scoring_Project.MACRO_distinct_values(pj, 'DL_score', 'iid');	

dl_exists := Scoring_Project.MACRO_distinct_values(pj, 'dl_exists', 'iid');	
any_DL_found := Scoring_Project.MACRO_distinct_values(pj, 'any_DL_found', 'iid');	
DL_searched := Scoring_Project.MACRO_distinct_values(pj, 'DL_searched', 'iid');	
iid_flags := Scoring_Project.MACRO_distinct_values(pj, 'iid_flags', 'iid');	
BestSSN := Scoring_Project.MACRO_Populating_Value(pj, 'BestSSN', 'iid');	/*********as suggested by Ben on 03/07/2014***********************/
publish_code := Scoring_Project.MACRO_distinct_values(pj, 'publish_code', 'iid');	




iid := cvi + NAP_Status + NAP_Type + NAP_Summary + NAS_Summary + did3 + did2 + didcount + did2_criminal_count + DID2_HeaderLastSeen + DID2_HeaderFirstSeen +
DID2_CreditLastSeen + DID2_CreditFirstSeen + DID2_SocsSources + DID2_AddrSources + DID2_LNameSources + DID2_FNameSources + DID2_Sources + DID3_SocsSources +
DID3_AddrSources + DID3_LNameSources + DID3_FNameSources + DID3_Sources + did2_liens_historical_released_count + did2_liens_recent_released_count + did2_liens_historical_unreleased_count +
did2_liens_recent_unreleased_count + did2_felony_count + did3_liens_historical_released_count + did3_liens_recent_released_count + did3_liens_historical_unreleased_count +
did3_liens_recent_unreleased_count + did3_felony_count + did3_criminal_count + DID3_HeaderLastSeen + DID3_HeaderFirstSeen + DID3_CreditLastSeen + DID3_CreditFirstSeen +
hphonetypeflag + hriskphoneflag + non_us_ssn + PWphonezipflag + phonezipflag + wphonevalflag + hphonevalflag + phonevalflag + wphonetypeflag + pullidflag +
hriskaddrflag + phonever_type + phoneverlevel + wphonedissflag + phonedissflag + PWsocsdobflag + socsdobflag + decsflag + socsRCISflag + PWsocsvalflag + socsvalflag +
bansflag + dwelltype + addrvalflag + reverse_areacodesplitflag +  areacodesplitflag + socsverlevel + socscount + wphonecount + addrcount + lastcount +
firstcount + sources + phoneaddrcount +  phonelastcount + phonefirstcount + numelever + DIDdeceased + EverAssocIm + EverAssocITIN + IsShiptoBilltoDifferent + 
utiliaddr_phonecount + utiliaddr_addrcount + utiliaddr_lastcount + phoneaddr_phonecount + phoneaddr_addrcount + phoneaddr_lastcount + phoneaddr_firstcount +
phonephonecount + socsmiskeyflag + hphonemiskeyflag + addrmiskeyflag + addrcommflag +  disthphoneaddr + dirs_predir + distwphoneaddr + disthphonewphone +
dirs_predir +  disthphonewphone + dirsaddr_lastscore + dirs_unit_desig + dirs_postdir + cityzipflag + statezipflag + drlcgender + drlcdob +
drlcsocs + drlcmiddle + drlclast + drlcfirst + drlcsoundx + drlcvalflag + zipclass + ziptypeflag + phonetype + chronopostdir + chronopostdir + chronoMatchLevel +
chrono_addr_flags_dropIndicator + chrono_addr_flags_addressType + chrono_addr_flags_deliveryStatus + chrono_addr_flags_doNotDeliver + chrono_addr_flags_corpMil +
chrono_addr_flags_highRisk + chrono_addr_flags_prisonAddr + chrono_addr_flags_valid + chrono_addr_flags_dwelltype + chronopostdir2 + chronopredir2 + chronoMatchLevel2 +
chrono_addr_flags2_dropIndicator + chrono_addr_flags2_addressType + chrono_addr_flags2_deliveryStatus + chrono_addr_flags2_doNotDeliver + chrono_addr_flags2_corpMil +
chrono_addr_flags2_highRisk + chrono_addr_flags2_prisonAddr + chrono_addr_flags2_valid + chrono_addr_flags2_dwelltype + chronopostdir3 + 	chronopredir3 +
chronoMatchLevel3 + chrono_addr_flags3_dropIndicator + chrono_addr_flags3_addressType + chrono_addr_flags3_deliveryStatus + chrono_addr_flags3_doNotDeliver + 
chrono_addr_flags3_corpMil + chrono_addr_flags3_highRisk + chrono_addr_flags3_prisonAddr + chrono_addr_flags3_valid + chrono_addr_flags3_dwelltype + 
ssnexists + firstssnmatch + lastssnmatch2 + lastssnmatch + altlast2Pop + altlastPop + combo_suffix + combo_unit_desig + combo_postdir + combo_ssnscore + 
combo_hphonescore + combo_sec_rangescore + combo_addrscore + combo_predir + combo_lastscore + combo_firstscore + combo_cmpyscore + combo_dobscore + combo_dobcount +
combo_ssncount + combo_hphonecount + combo_addrcount + combo_lastcount + combo_firstcount + watchlist_record_number + watchlist_table + combo_cmpycount +
inputAddrNotMostRecent + name_addr_phone + wphonezip + wphonestate + wphonecity + wphoneaddr + wphonename + watchlistHit + watchlist_zip + watchlist_state +
watchlist_city + targustype + targusgatewayused + DIDdeceasedlast + DIDdeceasedfirst + DIDdeceasedDOB + DIDdeceasedDate + verified_DL + DL_score + dl_exists +
any_DL_found + DL_searched + iid_flags + BestSSN + publish_code ;

/*******************************************************************************************************************************************/
//email_summary
/*******************************************************************************************************************************************/
verification_level := Scoring_Project.MACRO_distinct_values(pj, 'verification_level', 'email_summary-reverse_email');	
adls_per_email := Scoring_Project.MACRO_distinct_values(pj, 'adls_per_email', 'email_summary-reverse_email');	
email_summary_ver_sources := Scoring_Project.MACRO_distinct_values(pj, 'email_summary_ver_sources', 'email_summary-reverse_email');	
email_summary_ver_sources_first_seen_date := Scoring_Project.MACRO_distinct_values(pj, 'email_summary_ver_sources_first_seen_date', 'email_summary-reverse_email');	
email_summary_ver_sources_last_seen_date := Scoring_Project.MACRO_distinct_values(pj, 'email_summary_ver_sources_last_seen_date', 'email_summary-reverse_email');	
email_summary_ver_sources_recordcount := Scoring_Project.MACRO_distinct_values(pj, 'email_summary_ver_sources_recordcount', 'email_summary-reverse_email');	

email_ct := Scoring_Project.Macro_Range_5(pj, 'email_ct', 'email_summary');	
email_domain_Free_ct := Scoring_Project.MACRO_Range_1_2_3_4_5(pj, 'email_domain_Free_ct', 'email_summary');	
email_domain_ISP_ct := Scoring_Project.Macro_Range_5(pj, 'email_domain_ISP_ct', 'email_summary');	

email_domain_EDU_ct := Scoring_Project.MACRO_distinct_values(pj, 'email_domain_EDU_ct', 'email_summary');	
email_domain_Corp_ct := Scoring_Project.MACRO_distinct_values(pj, 'email_domain_Corp_ct', 'email_summary');	

email_source_list := Scoring_Project.MACRO_Populating_Value(pj, 'email_source_list', 'email_summary');	/****as suggested by Ben on 03/07/2014*******/
//email_source_ct := Scoring_Project.MACRO_Populating_Value(pj, 'email_source_ct', 'email_summary');	/****commented  as suggested by Ben on 03/07/2014*******/
// email_source_first_seen := Scoring_Project.MACRO_Populating_Value(pj, 'email_source_first_seen', 'email_summary');	/****commented  as suggested by Ben on 03/07/2014*******/

Identity_Email_Verification_Level := Scoring_Project.MACRO_distinct_values(pj, 'Identity_Email_Verification_Level', 'email_summary');	

email_summary := 	verification_level + adls_per_email + email_summary_ver_sources + email_summary_ver_sources_first_seen_date + email_summary_ver_sources_last_seen_date + email_summary_ver_sources_recordcount +
email_ct + email_domain_Free_ct + email_domain_ISP_ct + email_domain_EDU_ct + email_domain_Corp_ct + email_source_list + Identity_Email_Verification_Level;
/*******************************************************************************************************************************************/
//advo_input_addr
/*******************************************************************************************************************************************/

advo_input_addr_Seasonal_Delivery_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_input_addr_Seasonal_Delivery_Indicator', 'advo_input_addr');	
advo_input_addr_Throw_Back_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_input_addr_Throw_Back_Indicator', 'advo_input_addr');	
advo_input_addr_Address_Vacancy_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_input_addr_Address_Vacancy_Indicator', 'advo_input_addr');	
advo_input_addr_Mixed_Address_Usage := Scoring_Project.MACRO_distinct_values(pj, 'advo_input_addr_Mixed_Address_Usage', 'advo_input_addr');	
advo_input_addr_Residential_or_Business_Ind := Scoring_Project.MACRO_distinct_values(pj, 'advo_input_addr_Residential_or_Business_Ind', 'advo_input_addr');	
advo_input_addr_Drop_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_input_addr_Drop_Indicator', 'advo_input_addr');	
advo_input_addr_College_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_input_addr_College_Indicator', 'advo_input_addr');	
advo_input_addr_DND_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_input_addr_DND_Indicator', 'advo_input_addr');	

advo_input_addr := 	advo_input_addr_Seasonal_Delivery_Indicator + advo_input_addr_Throw_Back_Indicator + advo_input_addr_Address_Vacancy_Indicator +
advo_input_addr_Mixed_Address_Usage + advo_input_addr_Residential_or_Business_Ind + advo_input_addr_Drop_Indicator + advo_input_addr_College_Indicator +
advo_input_addr_DND_Indicator;
/*******************************************************************************************************************************************/
//advo_addr_hist1
/*******************************************************************************************************************************************/

advo_addr_hist1_Seasonal_Delivery_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist1_Seasonal_Delivery_Indicator', 'advo_addr_hist1');	
advo_addr_hist1_Throw_Back_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist1_Throw_Back_Indicator', 'advo_addr_hist1');	
advo_addr_hist1_Address_Vacancy_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist1_Address_Vacancy_Indicator', 'advo_addr_hist1');	
advo_addr_hist1_Mixed_Address_Usage := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist1_Mixed_Address_Usage', 'advo_addr_hist1');	
advo_addr_hist1_Residential_or_Business_Ind := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist1_Residential_or_Business_Ind', 'advo_addr_hist1');	
advo_addr_hist1_Drop_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist1_Drop_Indicator', 'advo_addr_hist1');	
advo_addr_hist1_College_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist1_College_Indicator', 'advo_addr_hist1');	
advo_addr_hist1_DND_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist1_DND_Indicator', 'advo_addr_hist1');	

advo_addr_hist1 := advo_addr_hist1_Seasonal_Delivery_Indicator + advo_addr_hist1_Throw_Back_Indicator + advo_addr_hist1_Address_Vacancy_Indicator + 
advo_addr_hist1_Mixed_Address_Usage + advo_addr_hist1_Residential_or_Business_Ind + advo_addr_hist1_Drop_Indicator + advo_addr_hist1_College_Indicator + 
advo_addr_hist1_DND_Indicator;
/*******************************************************************************************************************************************/
//advo_addr_hist2
/*******************************************************************************************************************************************/


advo_addr_hist2_Seasonal_Delivery_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist2_Seasonal_Delivery_Indicator', 'advo_addr_hist2');	
advo_addr_hist2_Throw_Back_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist2_Throw_Back_Indicator', 'advo_addr_hist2');	
advo_addr_hist2_Address_Vacancy_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist2_Address_Vacancy_Indicator', 'advo_addr_hist2');	
advo_addr_hist2_Mixed_Address_Usage := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist2_Mixed_Address_Usage', 'advo_addr_hist2');	
advo_addr_hist2_Residential_or_Business_Ind := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist2_Residential_or_Business_Ind', 'advo_addr_hist2');	
advo_addr_hist2_Drop_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist2_Drop_Indicator', 'advo_addr_hist2');	
advo_addr_hist2_College_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist2_College_Indicator', 'advo_addr_hist2');	
advo_addr_hist2_DND_Indicator := Scoring_Project.MACRO_distinct_values(pj, 'advo_addr_hist2_DND_Indicator', 'advo_addr_hist2');	

advo_addr_hist2 := advo_addr_hist2_Seasonal_Delivery_Indicator + advo_addr_hist2_Throw_Back_Indicator + advo_addr_hist2_Address_Vacancy_Indicator + 
advo_addr_hist2_Mixed_Address_Usage + advo_addr_hist2_Residential_or_Business_Ind + advo_addr_hist2_Drop_Indicator + advo_addr_hist2_College_Indicator + 
advo_addr_hist2_DND_Indicator;

/*******************************************************************************************************************************************/
//SSN_Verification
/*******************************************************************************************************************************************/
other_sourced := Scoring_Project.MACRO_distinct_values(pj, 'other_sourced', 'SSN_Verification');	
bk_sourced := Scoring_Project.MACRO_distinct_values(pj, 'bk_sourced', 'SSN_Verification');	
utility_sourced := Scoring_Project.MACRO_distinct_values(pj, 'utility_sourced', 'SSN_Verification');	
voter_sourced := Scoring_Project.MACRO_distinct_values(pj, 'voter_sourced', 'SSN_Verification');	
tu_sourced := Scoring_Project.MACRO_distinct_values(pj, 'tu_sourced', 'SSN_Verification');	
header_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'header_last_seen', 'SSN_Verification', 2);	/****need to clarify with Nathan*******/
header_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'header_first_seen', 'SSN_Verification', 2);	/****need to clarify with Nathan*******/
header_count := Scoring_Project.MACRO_distinct_values(pj, 'header_count', 'SSN_Verification');	
credit_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'credit_last_seen', 'SSN_Verification', 2);	/****need to clarify with Nathan*******/
credit_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'credit_first_seen', 'SSN_Verification', 2);	/****need to clarify with Nathan*******/
adlPerSSN_count := Scoring_Project.MACRO_Range_100(pj, 'adlPerSSN_count', 'SSN_Verification');	
credit_sourced := Scoring_Project.MACRO_distinct_values(pj, 'credit_sourced', 'SSN_Verification');	
ssn_score := Scoring_Project.MACRO_Range_100(pj, 'ssn_score', 'SSN_Verification');	
namePerSSN_count := Scoring_Project.MACRO_distinct_values(pj, 'namePerSSN_count', 'SSN_Verification');	

// SSN_Verification	----Validation
	
	inputsocscode := Scoring_Project.MACRO_distinct_values(pj, 'inputsocscode', 'SSN_Verification-Validation');
inputsocscharflag := Scoring_Project.MACRO_distinct_values(pj, 'inputsocscharflag', 'SSN_Verification-Validation');
dob_mismatch := Scoring_Project.MACRO_Range_5(pj, 'dob_mismatch', 'SSN_Verification-Validation');
// issue_state := Scoring_Project.MACRO_Populating_Value(pj, 'issue_state', 'SSN_Verification-Validation');/****need to modify as per nathan's reqs*******/
//////low_issue_date := Scoring_Project.MACRO_Populating_Value(pj, 'low_issue_date', 'SSN_Verification-Validation');/****commented as suggested by Ben on 03/07/2014*******/
////// high_issue_date := Scoring_Project.MACRO_Populating_Value(pj, 'high_issue_date', 'SSN_Verification-Validation');/****commented  as suggested by Ben on 03/07/2014*******/
issued := Scoring_Project.MACRO_distinct_values(pj, 'issued', 'SSN_Verification-Validation');
valid := Scoring_Project.MACRO_distinct_values(pj, 'valid', 'SSN_Verification-Validation');
deceasedDate := Scoring_Project.Macro_Dates_Within_30(pj, 'deceasedDate', 'SSN_Verification-Validation', 60);/****waiting for Ben's review*******/

deceased := Scoring_Project.MACRO_distinct_values(pj, 'deceased', 'SSN_Verification-Validation');	

SSN_Verification := deceased +  valid + issued +  dob_mismatch + inputsocscharflag + header_last_seen + header_first_seen + credit_last_seen + credit_first_seen +
inputsocscode + namePerSSN_count + ssn_score + credit_sourced + adlPerSSN_count + header_count + tu_sourced + voter_sourced + utility_sourced + bk_sourced + other_sourced +
deceasedDate;

/*******************************************************************************************************************************************/
//Accident_Data
/*******************************************************************************************************************************************/
acc_numaccidents60 := Scoring_Project.MACRO_distinct_values(pj, 'acc_numaccidents60', 'Accident_Data-acc');
acc_numaccidents36 := Scoring_Project.MACRO_distinct_values(pj, 'acc_numaccidents36', 'Accident_Data-acc');
acc_numaccidents24 := Scoring_Project.MACRO_distinct_values(pj, 'acc_numaccidents24', 'Accident_Data-acc');
acc_numaccidents12 := Scoring_Project.MACRO_distinct_values(pj, 'acc_numaccidents12', 'Accident_Data-acc');
acc_numaccidents180 := Scoring_Project.MACRO_distinct_values(pj, 'acc_numaccidents180', 'Accident_Data-acc');
acc_numaccidents90 := Scoring_Project.MACRO_distinct_values(pj, 'acc_numaccidents90', 'Accident_Data-acc');
acc_numaccidents30 := Scoring_Project.MACRO_distinct_values(pj, 'acc_numaccidents30', 'Accident_Data-acc');
acc_dmgamtlastaccident := Scoring_Project.MACRO_Range_Dollar(pj, 'acc_dmgamtlastaccident', 'Accident_Data-acc');
acc_datelastaccident := Scoring_Project.Macro_Dates_Within_30(pj, 'acc_datelastaccident', 'Accident_Data-acc', 30);/****need to modify as per nathan's reqs*******/
acc_dmgamtaccidents := Scoring_Project.MACRO_Range_Dollar(pj, 'acc_dmgamtaccidents', 'Accident_Data-acc');	
acc_num_accidents := Scoring_Project.MACRO_distinct_values(pj, 'acc_num_accidents', 'Accident_Data-acc');	

atfault_numaccidents60 := Scoring_Project.MACRO_distinct_values(pj, 'atfault_numaccidents60', 'Accident_Data-atfault');
atfault_numaccidents36 := Scoring_Project.MACRO_distinct_values(pj, 'atfault_numaccidents36', 'Accident_Data-atfault');
atfault_numaccidents24 := Scoring_Project.MACRO_distinct_values(pj, 'atfault_numaccidents24', 'Accident_Data-atfault');
atfault_numaccidents12 := Scoring_Project.MACRO_distinct_values(pj, 'atfault_numaccidents12', 'Accident_Data-atfault');
atfault_numaccidents180 := Scoring_Project.MACRO_distinct_values(pj, 'atfault_numaccidents180', 'Accident_Data-atfault');
atfault_numaccidents90 := Scoring_Project.MACRO_distinct_values(pj, 'atfault_numaccidents90', 'Accident_Data-atfault');
atfault_numaccidents30 := Scoring_Project.MACRO_distinct_values(pj, 'atfault_numaccidents30', 'Accident_Data-atfault');
atfault_dmgamtlastaccident := Scoring_Project.MACRO_Range_Dollar(pj, 'atfault_dmgamtlastaccident', 'Accident_Data-atfault');
atfault_datelastaccident := Scoring_Project.Macro_Dates_Within_30(pj, 'atfault_datelastaccident', 'Accident_Data-atfault', 30);/****need to modify as per nathan's reqs*******/
atfault_dmgamtaccidents := Scoring_Project.MACRO_Range_Dollar(pj, 'atfault_dmgamtaccidents', 'Accident_Data-atfault');	
atfault_num_accidents := Scoring_Project.MACRO_distinct_values(pj, 'atfault_num_accidents', 'Accident_Data-atfault');		

atfaultda_numaccidents60 := Scoring_Project.MACRO_distinct_values(pj, 'atfaultda_numaccidents60', 'Accident_Data-atfaultda');
atfaultda_numaccidents36 := Scoring_Project.MACRO_distinct_values(pj, 'atfaultda_numaccidents36', 'Accident_Data-atfaultda');
atfaultda_numaccidents24 := Scoring_Project.MACRO_distinct_values(pj, 'atfaultda_numaccidents24', 'Accident_Data-atfaultda');
atfaultda_numaccidents12 := Scoring_Project.MACRO_distinct_values(pj, 'atfaultda_numaccidents12', 'Accident_Data-atfaultda');
atfaultda_numaccidents180 := Scoring_Project.MACRO_distinct_values(pj, 'atfaultda_numaccidents180', 'Accident_Data-atfaultda');
atfaultda_numaccidents90 := Scoring_Project.MACRO_distinct_values(pj, 'atfaultda_numaccidents90', 'Accident_Data-atfaultda');
atfaultda_numaccidents30 := Scoring_Project.MACRO_distinct_values(pj, 'atfaultda_numaccidents30', 'Accident_Data-atfaultda');
atfaultda_dmgamtlastaccident := Scoring_Project.MACRO_Range_Dollar(pj, 'atfaultda_dmgamtlastaccident', 'Accident_Data-atfaultda');
atfaultda_datelastaccident := Scoring_Project.Macro_Dates_Within_30(pj, 'atfaultda_datelastaccident', 'Accident_Data-atfaultda', 30);/****need to modify as per nathan's reqs*******/
atfaultda_dmgamtaccidents := Scoring_Project.MACRO_Range_Dollar(pj, 'atfaultda_dmgamtaccidents', 'Accident_Data-atfaultda');	
atfaultda_num_accidents := Scoring_Project.MACRO_distinct_values(pj, 'atfaultda_num_accidents', 'Accident_Data-atfaultda');	

Accident_Data := acc_numaccidents60 + acc_numaccidents36 + acc_numaccidents24 + acc_numaccidents12 + acc_numaccidents180 + acc_numaccidents90 + acc_numaccidents30 +
acc_dmgamtlastaccident + acc_dmgamtaccidents + acc_num_accidents + atfault_numaccidents60 + atfault_numaccidents36 + atfault_numaccidents24 + atfault_numaccidents12 +
atfault_numaccidents180 + atfault_numaccidents90 + atfault_numaccidents30 + atfault_dmgamtlastaccident + atfault_datelastaccident + atfault_dmgamtaccidents + atfault_num_accidents +
atfaultda_numaccidents60 + atfaultda_numaccidents36 + atfaultda_numaccidents24 + atfaultda_numaccidents12 + atfaultda_numaccidents180 + atfaultda_numaccidents90 +
atfaultda_numaccidents30 + atfaultda_dmgamtlastaccident +  atfaultda_num_accidents + atfaultda_dmgamtaccidents + atfaultda_datelastaccident + acc_datelastaccident ;
/*******************************************************************************************************************************************/
//ConsumerFlags	
/*******************************************************************************************************************************************/
id_theft_flag := Scoring_Project.MACRO_distinct_values(pj, 'id_theft_flag', 'ConsumerFlags');
negative_alert := Scoring_Project.MACRO_distinct_values(pj, 'negative_alert', 'ConsumerFlags');
security_alert := Scoring_Project.MACRO_distinct_values(pj, 'security_alert', 'ConsumerFlags');
security_freeze := Scoring_Project.MACRO_distinct_values(pj, 'security_freeze', 'ConsumerFlags');
dispute_flag := Scoring_Project.MACRO_distinct_values(pj, 'dispute_flag', 'ConsumerFlags');
consumer_statement_flag := Scoring_Project.MACRO_distinct_values(pj, 'consumer_statement_flag', 'ConsumerFlags');
corrected_flag := Scoring_Project.MACRO_distinct_values(pj, 'corrected_flag', 'ConsumerFlags');
ConsumerFlags := id_theft_flag + negative_alert + security_alert + security_freeze + dispute_flag + consumer_statement_flag + corrected_flag;
/*******************************************************************************************************************************************/
//ADL_Shell_Flags
/*******************************************************************************************************************************************/

in_hphnpop_found := Scoring_Project.MACRO_distinct_values(pj, 'in_hphnpop_found', 'ADL_Shell_Flags');
in_addrpop_found := Scoring_Project.MACRO_distinct_values(pj, 'in_addrpop_found', 'ADL_Shell_Flags');
adl_dob := Scoring_Project.MACRO_distinct_values(pj, 'adl_dob', 'ADL_Shell_Flags');
adl_ssn := Scoring_Project.MACRO_distinct_values(pj, 'adl_ssn', 'ADL_Shell_Flags');
adl_hphn := Scoring_Project.MACRO_distinct_values(pj, 'adl_hphn', 'ADL_Shell_Flags');
adl_addr := Scoring_Project.MACRO_distinct_values(pj, 'adl_addr', 'ADL_Shell_Flags');
in_dobpop := Scoring_Project.MACRO_distinct_values(pj, 'in_dobpop', 'ADL_Shell_Flags');
in_ssnpop := Scoring_Project.MACRO_distinct_values(pj, 'in_ssnpop', 'ADL_Shell_Flags');
in_hphnpop := Scoring_Project.MACRO_distinct_values(pj, 'in_hphnpop', 'ADL_Shell_Flags');
in_addrpop := Scoring_Project.MACRO_distinct_values(pj, 'in_addrpop', 'ADL_Shell_Flags');

ADL_Shell_Flags := in_hphnpop_found + in_addrpop_found + adl_dob + adl_ssn + adl_hphn + adl_addr + in_dobpop + in_ssnpop + in_hphnpop + in_addrpop;
/*******************************************************************************************************************************************/
//Relatives
/*******************************************************************************************************************************************/
criminal_relative_withinOther := Scoring_Project.MACRO_distinct_values(pj, 'criminal_relative_withinOther', 'Relatives');
criminal_relative_within500miles := Scoring_Project.MACRO_distinct_values(pj, 'criminal_relative_within500miles', 'Relatives');
criminal_relative_within100miles := Scoring_Project.MACRO_distinct_values(pj, 'criminal_relative_within100miles', 'Relatives');
criminal_relative_within25miles := Scoring_Project.MACRO_distinct_values(pj, 'criminal_relative_within25miles', 'Relatives');
relative_felony_total := Scoring_Project.MACRO_distinct_values(pj, 'relative_felony_total', 'Relatives');
relative_felony_count := Scoring_Project.MACRO_distinct_values(pj, 'relative_felony_count', 'Relatives');
relative_criminal_total := Scoring_Project.MACRO_distinct_values(pj, 'relative_criminal_total', 'Relatives');
relative_criminal_count := Scoring_Project.MACRO_distinct_values(pj, 'relative_criminal_count', 'Relatives');
relative_bankrupt_count := Scoring_Project.MACRO_distinct_values(pj, 'relative_bankrupt_count', 'Relatives');
relative_count := Scoring_Project.MACRO_distinct_values(pj, 'relative_count', 'Relatives');
	
owned_relatives_property_owned_assessed_count := Scoring_Project.MACRO_Range_5(pj, 'owned_relatives_property_owned_assessed_count', 'Relatives-Owned');
owned_relatives_property_owned_assessed_total := Scoring_Project.MACRO_Range_Dollar(pj, 'owned_relatives_property_owned_assessed_total', 'Relatives-Owned');
owned_relatives_property_owned_purchase_count := Scoring_Project.MACRO_Range_5(pj, 'owned_relatives_property_owned_purchase_count', 'Relatives-Owned');
owned_relatives_property_owned_purchase_total := Scoring_Project.MACRO_Range_Dollar(pj, 'owned_relatives_property_owned_purchase_total', 'Relatives-Owned');
owned_relatives_property_total := Scoring_Project.MACRO_Range_5(pj, 'owned_relatives_property_total', 'Relatives-Owned');
owned_relatives_property_count := Scoring_Project.MACRO_Range_5(pj, 'owned_relatives_property_count', 'Relatives-Owned');


sold_relatives_property_owned_assessed_count := Scoring_Project.MACRO_Range_5(pj, 'sold_relatives_property_owned_assessed_count', 'Relatives-Sold');
sold_relatives_property_owned_assessed_total := Scoring_Project.MACRO_Range_Dollar(pj, 'sold_relatives_property_owned_assessed_total', 'Relatives-Sold');
sold_relatives_property_owned_purchase_count := Scoring_Project.MACRO_Range_5(pj, 'sold_relatives_property_owned_purchase_count', 'Relatives-Sold');
sold_relatives_property_owned_purchase_total := Scoring_Project.MACRO_Range_Dollar(pj, 'sold_relatives_property_owned_purchase_total', 'Relatives-Sold');
sold_relatives_property_total := Scoring_Project.MACRO_Range_5(pj, 'sold_relatives_property_total', 'Relatives-Sold');
sold_relatives_property_count := Scoring_Project.MACRO_Range_5(pj, 'sold_relatives_property_count', 'Relatives-Sold');

	relative_withinOther_count := Scoring_Project.MACRO_Range_10(pj, 'relative_withinOther_count', 'Relatives');
relative_within500miles_count := Scoring_Project.MACRO_Range_5(pj, 'relative_within500miles_count', 'Relatives');
relative_within100miles_count := Scoring_Project.MACRO_Range_5(pj, 'relative_within100miles_count', 'Relatives');
relative_within25miles_count := Scoring_Project.MACRO_Range_5(pj, 'relative_within25miles_count', 'Relatives');

ambiguous_relatives_property_owned_assessed_count := Scoring_Project.MACRO_distinct_values(pj, 'ambiguous_relatives_property_owned_assessed_count', 'Relatives-Ambiguous');
ambiguous_relatives_property_owned_assessed_total := Scoring_Project.MACRO_distinct_values(pj, 'ambiguous_relatives_property_owned_assessed_total', 'Relatives-Ambiguous');
ambiguous_relatives_property_owned_purchase_count := Scoring_Project.MACRO_distinct_values(pj, 'ambiguous_relatives_property_owned_purchase_count', 'Relatives-Ambiguous');
ambiguous_relatives_property_owned_purchase_total := Scoring_Project.MACRO_distinct_values(pj, 'ambiguous_relatives_property_owned_purchase_total', 'Relatives-Ambiguous');
ambiguous_relatives_property_total := Scoring_Project.MACRO_distinct_values(pj, 'ambiguous_relatives_property_total', 'Relatives-Ambiguous');
ambiguous_relatives_property_count := Scoring_Project.MACRO_distinct_values(pj, 'ambiguous_relatives_property_count', 'Relatives-Ambiguous');


	relative_educationUnder12_count := Scoring_Project.MACRO_Range_5(pj, 'relative_educationUnder12_count', 'Relatives');
relative_educationUnder8_count := Scoring_Project.MACRO_Range_5(pj, 'relative_educationUnder8_count', 'Relatives');
relative_homeOver500_count := Scoring_Project.MACRO_Range_5(pj, 'relative_homeOver500_count', 'Relatives');
relative_homeUnder500_count := Scoring_Project.MACRO_Range_5(pj, 'relative_homeUnder500_count', 'Relatives');
relative_homeUnder300_count := Scoring_Project.MACRO_Range_5(pj, 'relative_homeUnder300_count', 'Relatives');
relative_homeUnder200_count := Scoring_Project.MACRO_Range_5(pj, 'relative_homeUnder200_count', 'Relatives');
relative_homeUnder150_count := Scoring_Project.MACRO_Range_5(pj, 'relative_homeUnder150_count', 'Relatives');
relative_homeUnder100_count := Scoring_Project.MACRO_Range_5(pj, 'relative_homeUnder100_count', 'Relatives');
relative_homeUnder50_count := Scoring_Project.MACRO_Range_5(pj, 'relative_homeUnder50_count', 'Relatives');
relative_incomeOver100_count := Scoring_Project.MACRO_Range_5(pj, 'relative_incomeOver100_count', 'Relatives');
relative_incomeUnder100_count := Scoring_Project.MACRO_Range_5(pj, 'relative_incomeUnder100_count', 'Relatives');
relative_incomeUnder75_count := Scoring_Project.MACRO_Range_5(pj, 'relative_incomeUnder75_count', 'Relatives');
 relative_incomeUnder50_count := Scoring_Project.MACRO_Range_5(pj, 'relative_incomeUnder50_count', 'Relatives');
relative_incomeUnder25_count := Scoring_Project.MACRO_Range_5(pj, 'relative_incomeUnder25_count', 'Relatives');

	
	relative_bureau_only_count_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'relative_bureau_only_count_created_6months', 'Relatives');
relative_bureau_only_count_created_1month := Scoring_Project.MACRO_distinct_values(pj, 'relative_bureau_only_count_created_1month', 'Relatives');
relative_bureau_only_count := Scoring_Project.MACRO_Range_10(pj, 'relative_bureau_only_count', 'Relatives');
relative_suspicious_identities_count := Scoring_Project.MACRO_Range_10(pj, 'relative_suspicious_identities_count', 'Relatives');
relatives_at_input_address := Scoring_Project.MACRO_Range_10(pj, 'relatives_at_input_address', 'Relatives');
relative_vehicle_owned_count := Scoring_Project.MACRO_Range_5(pj, 'relative_vehicle_owned_count', 'Relatives');
relative_ageOver70_count := Scoring_Project.MACRO_distinct_values(pj, 'relative_ageOver70_count', 'Relatives');
relative_ageUnder70_count := Scoring_Project.MACRO_Range_5(pj, 'relative_ageUnder70_count', 'Relatives');
relative_ageUnder60_count := Scoring_Project.MACRO_Range_5(pj, 'relative_ageUnder60_count', 'Relatives');
relative_ageUnder50_count := Scoring_Project.MACRO_Range_5(pj, 'relative_ageUnder50_count', 'Relatives');
relative_ageUnder40_count := Scoring_Project.MACRO_Range_5(pj, 'relative_ageUnder40_count', 'Relatives');
relative_ageUnder30_count := Scoring_Project.MACRO_Range_5(pj, 'relative_ageUnder30_count', 'Relatives');
relative_ageUnder20_count := Scoring_Project.MACRO_Range_5(pj, 'relative_ageUnder20_count', 'Relatives');
relative_educationOver12_count := Scoring_Project.MACRO_Range_5(pj, 'relative_educationOver12_count', 'Relatives');

Relatives := criminal_relative_withinOther + criminal_relative_within500miles + criminal_relative_within100miles + criminal_relative_within25miles + relative_felony_total + 
relative_felony_count + relative_criminal_total + relative_criminal_count + relative_bankrupt_count + relative_count + owned_relatives_property_owned_assessed_count + 
owned_relatives_property_owned_assessed_total + owned_relatives_property_owned_purchase_count + owned_relatives_property_owned_purchase_total + owned_relatives_property_total +
owned_relatives_property_count + sold_relatives_property_owned_assessed_count + sold_relatives_property_owned_assessed_total + sold_relatives_property_owned_purchase_count +
sold_relatives_property_owned_purchase_total + sold_relatives_property_total + sold_relatives_property_count + relative_withinOther_count + relative_within500miles_count + 
relative_within100miles_count + relative_within25miles_count + ambiguous_relatives_property_owned_assessed_count + ambiguous_relatives_property_owned_assessed_total +
ambiguous_relatives_property_owned_purchase_count + ambiguous_relatives_property_owned_purchase_total + ambiguous_relatives_property_total + ambiguous_relatives_property_count +
relative_educationUnder12_count + relative_educationUnder8_count + relative_homeOver500_count + relative_homeUnder500_count + relative_homeUnder300_count + relative_homeUnder200_count +
relative_homeUnder150_count + relative_homeUnder100_count + relative_homeUnder50_count + relative_incomeOver100_count + relative_incomeUnder100_count + relative_incomeUnder75_count +
relative_incomeUnder50_count + relative_incomeUnder25_count + relative_bureau_only_count_created_6months + relative_bureau_only_count_created_1month + relative_bureau_only_count +
relative_suspicious_identities_count + relatives_at_input_address + relative_vehicle_owned_count + relative_ageOver70_count + relative_ageUnder70_count + relative_ageUnder60_count +
relative_ageUnder50_count + relative_ageUnder40_count + relative_ageUnder30_count + relative_ageUnder20_count + relative_educationOver12_count ;

/*******************************************************************************************************************************************/
//bjl
/*******************************************************************************************************************************************/
date_last_seen := Scoring_Project.MACRO_Populating_Value(pj, 'date_last_seen', 'bjl');/**************need to modify as per Nathan's reqs**********************/
filing_type := Scoring_Project.MACRO_distinct_values(pj, 'filing_type', 'bjl');
bankrupt := Scoring_Project.MACRO_distinct_values(pj, 'bankrupt', 'bjl');
bk_disposed_recent_count := Scoring_Project.MACRO_distinct_values(pj, 'bk_disposed_recent_count', 'bjl');
bk_dismissed_historical_count := Scoring_Project.MACRO_distinct_values(pj, 'bk_dismissed_historical_count', 'bjl');
bk_dismissed_recent_count := Scoring_Project.MACRO_distinct_values(pj, 'bk_dismissed_recent_count', 'bjl');
bk_recent_count := Scoring_Project.MACRO_distinct_values(pj, 'bk_recent_count', 'bjl');
filing_count := Scoring_Project.MACRO_Range_1_2_3(pj, 'filing_count', 'bjl');
disposition := Scoring_Project.MACRO_distinct_values(pj, 'disposition', 'bjl');
bk_chapter := Scoring_Project.MACRO_distinct_values(pj, 'bk_chapter', 'bjl');
bk_count60 := Scoring_Project.MACRO_distinct_values(pj, 'bk_count60', 'bjl');
bk_count36 := Scoring_Project.MACRO_distinct_values(pj, 'bk_count36', 'bjl');
bk_count24 := Scoring_Project.MACRO_distinct_values(pj, 'bk_count24', 'bjl');
bk_count12 := Scoring_Project.MACRO_distinct_values(pj, 'bk_count12', 'bjl');
bk_count180 := Scoring_Project.MACRO_distinct_values(pj, 'bk_count180', 'bjl');
bk_count90 := Scoring_Project.MACRO_distinct_values(pj, 'bk_count90', 'bjl');
bk_count30 := Scoring_Project.MACRO_distinct_values(pj, 'bk_count30', 'bjl');
bk_disposed_historical_count := Scoring_Project.MACRO_distinct_values(pj, 'bk_disposed_historical_count', 'bjl');
liens_recent_unreleased_count := Scoring_Project.MACRO_Range_1_2(pj, 'liens_recent_unreleased_count', 'bjl');

liens_historical_unreleased_count := Scoring_Project.MACRO_Range_1_2_3(pj, 'liens_historical_unreleased_count', 'bjl');
liens_unreleased_count30 := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_count30', 'bjl');
liens_unreleased_count90 := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_count90', 'bjl');
liens_unreleased_count180 := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_count180', 'bjl');
liens_unreleased_count12 := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_count12', 'bjl');
liens_unreleased_count24 := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_count24', 'bjl');
liens_unreleased_count36 := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_count36', 'bjl');
	liens_unreleased_count60 := Scoring_Project.MACRO_distinct_values(pj, 'liens_unreleased_count60', 'bjl');
last_liens_unreleased_date := Scoring_Project.Macro_Dates_Within_30(pj, 'last_liens_unreleased_date', 'bjl', 30);/**************need to modify as per Nathan's reqs**********************/
liens_recent_released_count := Scoring_Project.MACRO_Range_1_2(pj, 'liens_recent_released_count', 'bjl');
liens_historical_released_count := Scoring_Project.MACRO_Range_1_2_3(pj, 'liens_historical_released_count', 'bjl');
liens_released_count30 := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_count30', 'bjl');
liens_released_count90 := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_count90', 'bjl');
liens_released_count180 := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_count180', 'bjl');
liens_released_count12 := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_count12', 'bjl');
liens_released_count24 := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_count24', 'bjl');
liens_released_count36 := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_count36', 'bjl');
	liens_released_count60 := Scoring_Project.MACRO_distinct_values(pj, 'liens_released_count60', 'bjl');
last_liens_released_date := Scoring_Project.Macro_Dates_Within_30(pj, 'last_liens_released_date', 'bjl', 30);/**************need to modify as per Nathan's reqs**********************/
// criminal_count := Scoring_Project.MACRO_Range_1_to_10(pj, 'criminal_count', 'bjl');

r10 := record
string100 field_name := 'criminal_count';
	string100 category := 'bjl';
  string30 distribution_type := 'DISTINCT-VALUE';
  string50 attribute_value := MAP((integer)pj.criminal_count  = 00  => '00',
																	(integer)pj.criminal_count  = 01  => '01',
																	(integer)pj.criminal_count  = 02  => '02',
																	(integer)pj.criminal_count  = 03  => '03',
																	(integer)pj.criminal_count  = 04  => '04',
																	(integer)pj.criminal_count  = 05  => '05',
																	(integer)pj.criminal_count  = 06  => '06',
																	(integer)pj.criminal_count  = 07  => '07',
																	(integer)pj.criminal_count  = 08  => '08',
																	(integer)pj.criminal_count  >= 08  => '> 08',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;


criminal_count := table(pj,r10, MAP((integer)pj.criminal_count  = 00  => '00',
																	(integer)pj.criminal_count  = 01  => '01',
																	(integer)pj.criminal_count  = 02  => '02',
																	(integer)pj.criminal_count  = 03  => '03',
																	(integer)pj.criminal_count  = 04  => '04',
																	(integer)pj.criminal_count  = 05  => '05',
																	(integer)pj.criminal_count  = 06  => '06',
																	(integer)pj.criminal_count  = 07  => '07',
																	(integer)pj.criminal_count  = 08  => '08',
																	(integer)pj.criminal_count  > 08  => '> 08',
																	'UNDEFINED'));
																	
criminal_count60 := Scoring_Project.MACRO_distinct_values(pj, 'criminal_count60', 'bjl');
criminal_count36 := Scoring_Project.MACRO_distinct_values(pj, 'criminal_count36', 'bjl');
criminal_count24 := Scoring_Project.MACRO_distinct_values(pj, 'criminal_count24', 'bjl');
criminal_count12 := Scoring_Project.MACRO_distinct_values(pj, 'criminal_count12', 'bjl');
criminal_count180 := Scoring_Project.MACRO_distinct_values(pj, 'criminal_count180', 'bjl');
	criminal_count90 := Scoring_Project.MACRO_distinct_values(pj, 'criminal_count90', 'bjl');
	criminal_count30 := Scoring_Project.MACRO_distinct_values(pj, 'criminal_count30', 'bjl');
eviction_historical_released_count := Scoring_Project.MACRO_distinct_values(pj, 'eviction_historical_released_count', 'bjl');
eviction_recent_released_count := Scoring_Project.MACRO_distinct_values(pj, 'eviction_recent_released_count', 'bjl');
eviction_historical_unreleased_count := Scoring_Project.MACRO_distinct_values(pj, 'eviction_historical_unreleased_count', 'bjl');


eviction_recent_unreleased_count := Scoring_Project.MACRO_distinct_values(pj, 'eviction_recent_unreleased_count', 'bjl');
last_nonfelony_criminal_date := Scoring_Project.MACRO_distinct_values(pj, 'last_nonfelony_criminal_date', 'bjl');
	nonfelony_criminal_count12 := Scoring_Project.MACRO_distinct_values(pj, 'nonfelony_criminal_count12', 'bjl');
last_felony_date := Scoring_Project.Macro_Dates_Within_30(pj, 'last_felony_date', 'bjl', 30);/**************need to modify as per Nathan's reqs**********************/
felony_count := Scoring_Project.MACRO_Range_1_2_3(pj, 'felony_count', 'bjl');
last_criminal_date := Scoring_Project.Macro_Dates_Within_30(pj, 'last_criminal_date', 'bjl', 30);/**************need to modify as per Nathan's reqs**********************/
	last_foreclosure_date := Scoring_Project.MACRO_Populating_Value(pj, 'last_foreclosure_date', 'bjl');
foreclosure_flag := Scoring_Project.MACRO_distinct_values(pj, 'foreclosure_flag', 'bjl');
date_last_arrest := Scoring_Project.Macro_Dates_Within_30(pj, 'date_last_arrest', 'bjl', 30);/**************need to modify as per Nathan's reqs**********************/
arrests_count60 := Scoring_Project.MACRO_distinct_values(pj, 'arrests_count60', 'bjl');
arrests_count36 := Scoring_Project.MACRO_distinct_values(pj, 'arrests_count36', 'bjl');
arrests_count24 := Scoring_Project.MACRO_distinct_values(pj, 'arrests_count24', 'bjl');
arrests_count12 := Scoring_Project.MACRO_distinct_values(pj, 'arrests_count12', 'bjl');
arrests_count180 := Scoring_Project.MACRO_distinct_values(pj, 'arrests_count180', 'bjl');
	arrests_count90 := Scoring_Project.MACRO_distinct_values(pj, 'arrests_count90', 'bjl');
arrests_count30 := Scoring_Project.MACRO_distinct_values(pj, 'arrests_count30', 'bjl');
arrests_count := Scoring_Project.MACRO_distinct_values(pj, 'arrests_count', 'bjl');
last_eviction_date := Scoring_Project.Macro_Dates_Within_30(pj, 'last_eviction_date', 'bjl', 30);/**************need to modify as per Nathan's reqs**********************/
eviction_count60 := Scoring_Project.MACRO_Range_1_2_3(pj, 'eviction_count60', 'bjl');
eviction_count36 := Scoring_Project.MACRO_Range_1_2_3(pj, 'eviction_count36', 'bjl');
eviction_count24 := Scoring_Project.MACRO_Range_1_2_3(pj, 'eviction_count24', 'bjl');
eviction_count12 := Scoring_Project.MACRO_Range_1_2_3(pj, 'eviction_count12', 'bjl');
eviction_count180 := Scoring_Project.MACRO_Range_1_2_3(pj, 'eviction_count180', 'bjl');
eviction_count90 := Scoring_Project.MACRO_Range_1_2_3(pj, 'eviction_count90', 'bjl');
eviction_count30 := Scoring_Project.MACRO_distinct_values(pj, 'eviction_count30', 'bjl');
eviction_count := Scoring_Project.MACRO_Range_1_2_3(pj, 'eviction_count', 'bjl');

bjl := eviction_count + eviction_count30 + eviction_count90 + eviction_count180 + eviction_count12 + eviction_count24 +  eviction_count36 + eviction_count60 +
last_eviction_date + arrests_count + arrests_count30 + arrests_count90 + arrests_count180 + arrests_count12 + arrests_count24 + arrests_count36 + arrests_count60 +
date_last_arrest + foreclosure_flag + last_foreclosure_date + last_criminal_date + felony_count + last_felony_date + nonfelony_criminal_count12 + last_nonfelony_criminal_date +
eviction_recent_unreleased_count + eviction_historical_unreleased_count + eviction_recent_released_count + eviction_historical_released_count + criminal_count30 + criminal_count90 + criminal_count180 +
criminal_count12 + criminal_count24 + criminal_count36 + criminal_count60 + criminal_count + last_liens_released_date + liens_released_count60 + liens_released_count36 +
liens_released_count24 + liens_released_count12 + liens_released_count180 + liens_released_count90 + liens_released_count30 + liens_historical_released_count + 
liens_recent_released_count + last_liens_unreleased_date + liens_unreleased_count60 + liens_unreleased_count36 + liens_unreleased_count24 + liens_unreleased_count12 +
liens_unreleased_count180 + liens_unreleased_count90 + liens_unreleased_count30 + liens_historical_unreleased_count + liens_recent_unreleased_count + bk_disposed_historical_count +
bk_count30 + bk_count90 + bk_count180 + bk_count12 + bk_count24 + bk_count36 + bk_count60 + bk_chapter + disposition + filing_count + bk_recent_count + bk_dismissed_recent_count +
bk_dismissed_historical_count + bk_disposed_recent_count + bankrupt + filing_type + date_last_seen;

/*******************************************************************************************************************************************/
//Infutor
/*******************************************************************************************************************************************/
infutor_date_first_seen := Scoring_Project.Macro_Dates_Within_30(pj, 'infutor_date_first_seen', 'Infutor', 30);
infutor_date_last_seen := Scoring_Project.Macro_Dates_Within_30(pj, 'infutor_date_last_seen', 'Infutor', 30);
infutor_nap := Scoring_Project.MACRO_distinct_values(pj, 'infutor_nap', 'Infutor');

Infutor := infutor_date_first_seen + infutor_date_last_seen + infutor_nap;

/*******************************************************************************************************************************************/
//Infutor_Phone
/*******************************************************************************************************************************************/
Infutor_Phone_infutor_date_first_seen := Scoring_Project.Macro_Dates_Within_30(pj, 'Infutor_Phone_infutor_date_first_seen', 'Infutor_phone', 30);
Infutor_Phone_infutor_date_last_seen := Scoring_Project.Macro_Dates_Within_30(pj, 'Infutor_Phone_infutor_date_last_seen', 'Infutor_phone', 30);
Infutor_Phone_infutor_nap := Scoring_Project.MACRO_distinct_values(pj, 'Infutor_Phone_infutor_nap', 'Infutor_phone');

Infutor_Phone := Infutor_Phone_infutor_date_first_seen + Infutor_Phone_infutor_date_last_seen + Infutor_Phone_infutor_nap;

/*******************************************************************************************************************************************/
//Impulse
/*******************************************************************************************************************************************/
annual_income := Scoring_Project.MACRO_Range_Dollar(pj, 'annual_income', 'Impulse');
count60 := Scoring_Project.MACRO_distinct_values(pj, 'count60', 'Impulse');
count36 := Scoring_Project.MACRO_distinct_values(pj, 'count36', 'Impulse');
count24 := Scoring_Project.MACRO_distinct_values(pj, 'count24', 'Impulse');
count12 := Scoring_Project.MACRO_distinct_values(pj, 'count12', 'Impulse');;
count180 := Scoring_Project.MACRO_distinct_values(pj, 'count180', 'Impulse');
count90 := Scoring_Project.MACRO_distinct_values(pj, 'count90', 'Impulse');
count30 := Scoring_Project.MACRO_distinct_values(pj, 'count30', 'Impulse');

/////////siteid := Scoring_Project.MACRO_Populating_Value(pj, 'siteid', 'Impulse');/****commented  as suggested by Ben on 03/07/2014*******/

first_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'first_seen_date', 'Impulse', 30);
last_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'last_seen_date', 'Impulse', 30);
imp_count := Scoring_Project.MACRO_Range_1_2_3(pj, 'imp_count', 'Impulse');


Impulse := annual_income + count60 + count36 + count24 + count12 + count180 + count90 + count30 + first_seen_date + last_seen_date + imp_count;
/*******************************************************************************************************************************************/
//Velocity_Counters
/*******************************************************************************************************************************************/
addrs_per_phone_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'addrs_per_phone_created_6months', 'Velocity_Counters');
addrs_per_phone := Scoring_Project.MACRO_distinct_values(pj, 'addrs_per_phone', 'Velocity_Counters');
adls_per_phone_multiple_use := Scoring_Project.MACRO_distinct_values(pj, 'adls_per_phone_multiple_use', 'Velocity_Counters');
adls_per_phone_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'adls_per_phone_created_6months', 'Velocity_Counters');
adls_per_phone_current := Scoring_Project.MACRO_distinct_values(pj, 'adls_per_phone_current', 'Velocity_Counters');
adls_per_phone := Scoring_Project.MACRO_distinct_values(pj, 'adls_per_phone', 'Velocity_Counters');
suspicious_adls_per_addr_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'suspicious_adls_per_addr_created_6months', 'Velocity_Counters');
phones_per_addr_multiple_use := Scoring_Project.MACRO_Range_5(pj, 'phones_per_addr_multiple_use', 'Velocity_Counters');
ssns_per_addr_multiple_use := Scoring_Project.MACRO_Range_100(pj, 'ssns_per_addr_multiple_use', 'Velocity_Counters');
adls_per_addr_multiple_use := Scoring_Project.MACRO_Range_100(pj, 'adls_per_addr_multiple_use', 'Velocity_Counters');
phones_per_addr_created_6months := Scoring_Project.MACRO_Range_5(pj, 'phones_per_addr_created_6months', 'Velocity_Counters');
ssns_per_addr_created_6months := Scoring_Project.MACRO_Range_5(pj, 'ssns_per_addr_created_6months', 'Velocity_Counters');
adls_per_addr_created_6months := Scoring_Project.MACRO_Range_5(pj, 'adls_per_addr_created_6months', 'Velocity_Counters');
phones_per_addr_current := Scoring_Project.MACRO_Range_5(pj, 'phones_per_addr_current', 'Velocity_Counters');
ssns_per_addr_current := Scoring_Project.MACRO_Range_5(pj, 'ssns_per_addr_current', 'Velocity_Counters');
adls_per_addr_current := Scoring_Project.MACRO_Range_5(pj, 'adls_per_addr_current', 'Velocity_Counters');
phones_per_addr := Scoring_Project.MACRO_Range_5(pj, 'phones_per_addr', 'Velocity_Counters');
ssns_per_addr := Scoring_Project.MACRO_Range_50(pj, 'ssns_per_addr', 'Velocity_Counters');
adls_per_addr := Scoring_Project.MACRO_Range_50(pj, 'adls_per_addr', 'Velocity_Counters');
adls_per_ssn_multiple_use_non_relative := Scoring_Project.MACRO_Range_10(pj, 'adls_per_ssn_multiple_use_non_relative', 'Velocity_Counters');
adls_per_ssn_multiple_use := Scoring_Project.MACRO_Range_50(pj, 'adls_per_ssn_multiple_use', 'Velocity_Counters');
addrs_per_ssn_multiple_use := Scoring_Project.MACRO_Range_50(pj, 'addrs_per_ssn_multiple_use', 'Velocity_Counters');
lnames_per_ssn_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'lnames_per_ssn_created_6months', 'Velocity_Counters');
lnames_per_ssn := Scoring_Project.MACRO_Range_10(pj, 'lnames_per_ssn', 'Velocity_Counters');
adls_per_ssn_seen_18months := Scoring_Project.MACRO_Range_50(pj, 'adls_per_ssn_seen_18months', 'Velocity_Counters');
addrs_per_ssn_created_6months := Scoring_Project.MACRO_Range_5(pj, 'addrs_per_ssn_created_6months', 'Velocity_Counters');	
adls_per_ssn_created_6months := Scoring_Project.MACRO_Range_5(pj, 'adls_per_ssn_created_6months', 'Velocity_Counters');
addrs_per_ssn := Scoring_Project.MACRO_Range_50(pj, 'addrs_per_ssn', 'Velocity_Counters');	
pl_addrs_per_adl := Scoring_Project.MACRO_distinct_values(pj, 'pl_addrs_per_adl', 'Velocity_Counters');
vo_addrs_per_adl := Scoring_Project.MACRO_distinct_values(pj, 'vo_addrs_per_adl', 'Velocity_Counters');
dl_addrs_per_adl := Scoring_Project.MACRO_distinct_values(pj, 'dl_addrs_per_adl', 'Velocity_Counters');
invalid_addrs_per_adl_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'invalid_addrs_per_adl_created_6months', 'Velocity_Counters');
invalid_phones_per_adl_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'invalid_phones_per_adl_created_6months', 'Velocity_Counters');
invalid_ssns_per_adl_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'invalid_ssns_per_adl_created_6months', 'Velocity_Counters');
invalid_addrs_per_adl := Scoring_Project.MACRO_Range_5(pj, 'invalid_addrs_per_adl', 'Velocity_Counters');
invalid_phones_per_adl := Scoring_Project.MACRO_distinct_values(pj, 'invalid_phones_per_adl', 'Velocity_Counters');
invalid_ssns_per_adl := Scoring_Project.MACRO_distinct_values(pj, 'invalid_ssns_per_adl', 'Velocity_Counters');
lnames_per_adl60 := Scoring_Project.MACRO_distinct_values(pj, 'lnames_per_adl60', 'Velocity_Counters');
lnames_per_adl36 := Scoring_Project.MACRO_distinct_values(pj, 'lnames_per_adl36', 'Velocity_Counters');
lnames_per_adl24 := Scoring_Project.MACRO_distinct_values(pj, 'lnames_per_adl24', 'Velocity_Counters');
lnames_per_adl12 := Scoring_Project.MACRO_distinct_values(pj, 'lnames_per_adl12', 'Velocity_Counters');
	lnames_per_adl180 := Scoring_Project.MACRO_distinct_values(pj, 'lnames_per_adl180', 'Velocity_Counters');
lnames_per_adl90 := Scoring_Project.MACRO_distinct_values(pj, 'lnames_per_adl90', 'Velocity_Counters');
lnames_per_adl30 := Scoring_Project.MACRO_distinct_values(pj, 'lnames_per_adl30', 'Velocity_Counters');
lnames_per_adl := Scoring_Project.MACRO_Range_5(pj, 'lnames_per_adl', 'Velocity_Counters');
ssns_per_adl_multiple_use_non_relative := Scoring_Project.MACRO_Range_5(pj, 'ssns_per_adl_multiple_use_non_relative', 'Velocity_Counters');
ssns_per_adl_multiple_use := Scoring_Project.MACRO_distinct_values(pj, 'ssns_per_adl_multiple_use', 'Velocity_Counters');
ssns_per_adl_seen_18months := Scoring_Project.MACRO_distinct_values(pj, 'ssns_per_adl_seen_18months', 'Velocity_Counters');
dobs_per_adl_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'dobs_per_adl_created_6months', 'Velocity_Counters');
phones_per_adl_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'phones_per_adl_created_6months', 'Velocity_Counters');
addrs_per_adl_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'addrs_per_adl_created_6months', 'Velocity_Counters');
ssns_per_adl_created_6months := Scoring_Project.MACRO_distinct_values(pj, 'ssns_per_adl_created_6months', 'Velocity_Counters');
	dobs_per_adl := Scoring_Project.MACRO_distinct_values(pj, 'dobs_per_adl', 'Velocity_Counters');
phones_per_adl := Scoring_Project.MACRO_distinct_values(pj, 'phones_per_adl', 'Velocity_Counters');
addrs_per_adl := Scoring_Project.MACRO_addrs_per_adl(pj, 'addrs_per_adl', 'Velocity_Counters');
ssns_per_adl := Scoring_Project.MACRO_Range_1_2_3_4(pj, 'ssns_per_adl', 'Velocity_Counters');

Velocity_Counters := addrs_per_phone_created_6months + addrs_per_phone + adls_per_phone_multiple_use + adls_per_phone_created_6months + adls_per_phone_current +
adls_per_phone + suspicious_adls_per_addr_created_6months + phones_per_addr_multiple_use + ssns_per_addr_multiple_use + adls_per_addr_multiple_use + phones_per_addr_created_6months +
ssns_per_addr_created_6months + adls_per_addr_created_6months + phones_per_addr_current + ssns_per_addr_current + adls_per_addr_current + phones_per_addr +
ssns_per_addr + adls_per_addr + adls_per_ssn_multiple_use_non_relative + adls_per_ssn_multiple_use + addrs_per_ssn_multiple_use + lnames_per_ssn_created_6months + 
lnames_per_ssn + adls_per_ssn_seen_18months + addrs_per_ssn_created_6months + adls_per_ssn_created_6months + addrs_per_ssn + pl_addrs_per_adl + vo_addrs_per_adl +
dl_addrs_per_adl + invalid_addrs_per_adl_created_6months + invalid_phones_per_adl_created_6months + invalid_ssns_per_adl_created_6months + invalid_addrs_per_adl +
invalid_phones_per_adl + invalid_ssns_per_adl + lnames_per_adl60 + lnames_per_adl36 + lnames_per_adl24 + lnames_per_adl12 + lnames_per_adl180 + lnames_per_adl90 +
lnames_per_adl30 + lnames_per_adl + ssns_per_adl_multiple_use_non_relative + ssns_per_adl_multiple_use + ssns_per_adl_seen_18months + dobs_per_adl_created_6months + 
phones_per_adl_created_6months + addrs_per_adl_created_6months + ssns_per_adl_created_6months + dobs_per_adl + phones_per_adl + addrs_per_adl + ssns_per_adl ;

/*******************************************************************************************************************************************/
//Employment
/*******************************************************************************************************************************************/
Source_ct := Scoring_Project.MACRO_Range_10(pj, 'Source_ct', 'Employment' );
Business_active_phone_ct := Scoring_Project.MACRO_Range_1_2_3(pj, 'Business_active_phone_ct', 'Employment'  );
Dead_business_ct := Scoring_Project.MACRO_Range_1_2(pj, 'Dead_business_ct', 'Employment'  );
Business_ct := Scoring_Project.MACRO_Range_10(pj, 'Business_ct', 'Employment'  );
emp_First_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'emp_First_seen_date', 'Employment' , 30 );//added emp to the field name as Impulse group has the same field
company_title := Scoring_Project.MACRO_Populating_Value(pj, 'company_title', 'Employment'  );

Employment := Source_ct + Business_active_phone_ct + Dead_business_ct + Business_ct + emp_First_seen_date + company_title;

/*******************************************************************************************************************************************/
//address_history_summary----------------
/*******************************************************************************************************************************************/
address_history_college_evidence := Scoring_Project.MACRO_distinct_values(pj, 'address_history_college_evidence', 'address_history_summary' );
input_addr_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'input_addr_last_seen', 'address_history_summary', 1 );
input_addr_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'input_addr_first_seen', 'address_history_summary', 1 );
hist_addr_match := Scoring_Project.MACRO_distinct_values(pj, 'hist_addr_match', 'address_history_summary' );
lres_12mo_count := Scoring_Project.MACRO_distinct_values(pj, 'lres_12mo_count', 'address_history_summary' );
lres_6mo_count := Scoring_Project.MACRO_distinct_values(pj, 'lres_6mo_count', 'address_history_summary' );
lres_2mo_count := Scoring_Project.MACRO_distinct_values(pj, 'lres_2mo_count', 'address_history_summary' );
addr_count10 := Scoring_Project.MACRO_distinct_values(pj, 'addr_count10', 'address_history_summary' );
addr_count6 := Scoring_Project.MACRO_distinct_values(pj, 'addr_count6', 'address_history_summary' );
addr_count3 := Scoring_Project.MACRO_distinct_values(pj, 'addr_count3', 'address_history_summary' );
addr_count2 := Scoring_Project.MACRO_distinct_values(pj, 'addr_count2', 'address_history_summary' );
avg_mo_per_addr := Scoring_Project.MACRO_Range_12_to_100(pj, 'avg_mo_per_addr', 'address_history_summary' );
// unique_addr_cnt := Scoring_Project.MACRO_Range_10(pj, 'unique_addr_cnt', 'address_history_summary' );

r1 := record
string100 field_name := 'unique_addr_cnt';
	string100 category := 'address_history_summary';
  string30 distribution_type := 'RANGE';
  string50 attribute_value := MAP((integer)pj.unique_addr_cnt  between 01  and 05  => '01 to 05',
																	(integer)pj.unique_addr_cnt between 06  and 10  => '06 to 10',
																	(integer)pj.unique_addr_cnt between 11  and 15  => '11 to 15',
																	(integer)pj.unique_addr_cnt >= 16 => '> 15',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;


unique_addr_cnt := table(pj,r1,MAP((integer)pj.unique_addr_cnt  between 01  and 05  => '01 to 05',
																	(integer)pj.unique_addr_cnt between 06  and 10  => '06 to 10',
																	(integer)pj.unique_addr_cnt between 11  and 15  => '11 to 15',
																	(integer)pj.unique_addr_cnt >= 16 => '> 15',
																	'UNDEFINED'));

address_history_summary := address_history_college_evidence + input_addr_last_seen + input_addr_first_seen + hist_addr_match + lres_12mo_count + lres_6mo_count + 
lres_2mo_count + addr_count10 + addr_count6 + addr_count3 + addr_count2 + avg_mo_per_addr + unique_addr_cnt ;
/*******************************************************************************************************************************************/
//addr_risk_summary----------------WAITING for nathan's confirmation
/*******************************************************************************************************************************************/
N_ave_no_of_baths_count := Scoring_Project.MACRO_Range_100(pj, 'N_ave_no_of_baths_count', 'addr_risk_summary');
N_ave_no_of_bedrooms_count := Scoring_Project.MACRO_Range_100(pj, 'N_ave_no_of_bedrooms_count', 'addr_risk_summary');
N_ave_no_of_rooms_count := Scoring_Project.MACRO_Populating_Value(pj, 'N_ave_no_of_rooms_count', 'addr_risk_summary');
N_ave_no_of_stories_count := Scoring_Project.MACRO_Range_10(pj, 'N_ave_no_of_stories_count', 'addr_risk_summary');
N_ave_price_per_sf := Scoring_Project.MACRO_Range_Dollar(pj, 'N_ave_price_per_sf', 'addr_risk_summary');
N_ave_building_area := Scoring_Project.MACRO_Range_Dollar(pj, 'N_ave_building_area', 'addr_risk_summary');
N_ave_assessed_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'N_ave_assessed_amount', 'addr_risk_summary');
N_ave_mortgage_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'N_ave_mortgage_amount', 'addr_risk_summary');
N_ave_purchase_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'N_ave_purchase_amount', 'addr_risk_summary');
N_ave_building_age := Scoring_Project.MACRO_Populating_Value(pj, 'N_ave_building_age', 'addr_risk_summary');
N_MFD_Count := Scoring_Project.MACRO_Populating_Value(pj, 'N_MFD_Count', 'addr_risk_summary');
N_SFD_Count := Scoring_Project.MACRO_Populating_Value(pj, 'N_SFD_Count', 'addr_risk_summary');
N_Business_Count := Scoring_Project.MACRO_Range_100(pj, 'N_Business_Count', 'addr_risk_summary');
N_Vacant_Properties := Scoring_Project.MACRO_Range_10(pj, 'N_Vacant_Properties', 'addr_risk_summary');
turnover_1yr_out := Scoring_Project.MACRO_Populating_Value(pj, 'turnover_1yr_out', 'addr_risk_summary');
turnover_1yr_in := Scoring_Project.MACRO_Populating_Value(pj, 'turnover_1yr_in', 'addr_risk_summary');
occupants_1yr := Scoring_Project.MACRO_Populating_Value(pj, 'occupants_1yr', 'addr_risk_summary');

addr_risk_summary := N_ave_no_of_baths_count + N_ave_no_of_bedrooms_count + N_ave_no_of_rooms_count + N_ave_no_of_stories_count + N_ave_price_per_sf +
N_ave_building_area + N_ave_assessed_amount + N_ave_mortgage_amount + N_ave_purchase_amount + N_ave_building_age + N_MFD_Count + N_SFD_Count + N_Business_Count +
N_Vacant_Properties + turnover_1yr_out + turnover_1yr_in + occupants_1yr;
/*******************************************************************************************************************************************/
//addr_risk_summary2----------------WAITING for nathan's confirmation
/*******************************************************************************************************************************************/
ar2_N_ave_no_of_baths_count := Scoring_Project.MACRO_Range_100(pj, 'ar2_N_ave_no_of_baths_count', 'addr_risk_summary2');
ar2_N_ave_no_of_bedrooms_count := Scoring_Project.MACRO_Range_100(pj, 'ar2_N_ave_no_of_bedrooms_count', 'addr_risk_summary2');
ar2_N_ave_no_of_rooms_count := Scoring_Project.MACRO_Populating_Value(pj, 'ar2_N_ave_no_of_rooms_count', 'addr_risk_summary2');
ar2_N_ave_no_of_stories_count := Scoring_Project.MACRO_Range_10(pj, 'ar2_N_ave_no_of_stories_count', 'addr_risk_summary2');
ar2_N_ave_price_per_sf := Scoring_Project.MACRO_Range_Dollar(pj, 'ar2_N_ave_price_per_sf', 'addr_risk_summary2');/********as suggested by ben on 03/07/2014********/
ar2_N_ave_building_area := Scoring_Project.MACRO_Range_Dollar(pj, 'ar2_N_ave_building_area', 'addr_risk_summary2');/********as suggested by ben on 03/07/2014********/
ar2_N_ave_assessed_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'ar2_N_ave_assessed_amount', 'addr_risk_summary2');
ar2_N_ave_mortgage_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'ar2_N_ave_mortgage_amount', 'addr_risk_summary2');
ar2_N_ave_purchase_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'ar2_N_ave_purchase_amount', 'addr_risk_summary2');
ar2_N_ave_building_age := Scoring_Project.MACRO_Populating_Value(pj, 'ar2_N_ave_building_age', 'addr_risk_summary2');
ar2_N_MFD_Count := Scoring_Project.MACRO_Populating_Value(pj, 'ar2_N_MFD_Count', 'addr_risk_summary2');
ar2_N_SFD_Count := Scoring_Project.MACRO_Populating_Value(pj, 'ar2_N_SFD_Count', 'addr_risk_summary2');
ar2_N_Business_Count := Scoring_Project.MACRO_Range_100(pj, 'ar2_N_Business_Count', 'addr_risk_summary2');
ar2_N_Vacant_Properties := Scoring_Project.MACRO_Range_10(pj, 'ar2_N_Vacant_Properties', 'addr_risk_summary2');
ar2_turnover_1yr_out := Scoring_Project.MACRO_Populating_Value(pj, 'ar2_turnover_1yr_out', 'addr_risk_summary2');
ar2_turnover_1yr_in := Scoring_Project.MACRO_Populating_Value(pj, 'ar2_turnover_1yr_in', 'addr_risk_summary2');
ar2_occupants_1yr := Scoring_Project.MACRO_Populating_Value(pj, 'ar2_occupants_1yr', 'addr_risk_summary2');

addr_risk_summary2 := ar2_N_ave_no_of_baths_count + ar2_N_ave_no_of_bedrooms_count + ar2_N_ave_no_of_rooms_count + ar2_N_ave_no_of_stories_count + ar2_N_ave_price_per_sf +
ar2_N_ave_building_area + ar2_N_ave_assessed_amount + ar2_N_ave_mortgage_amount + ar2_N_ave_purchase_amount + ar2_N_ave_building_age + ar2_N_MFD_Count + ar2_N_SFD_Count +
ar2_N_Business_Count + ar2_N_Vacant_Properties + ar2_turnover_1yr_out + ar2_turnover_1yr_in + ar2_occupants_1yr;
/*******************************************************************************************************************************************/
//addr_risk_summary3
/*******************************************************************************************************************************************/
ar3_N_ave_no_of_baths_count := Scoring_Project.MACRO_Populating_Value(pj, 'ar3_N_ave_no_of_baths_count', 'addr_risk_summary3');
ar3_N_ave_no_of_bedrooms_count := Scoring_Project.MACRO_Range_Dollar(pj, 'ar3_N_ave_no_of_bedrooms_count', 'addr_risk_summary3');
ar3_N_ave_no_of_rooms_count := Scoring_Project.MACRO_Range_Dollar(pj, 'ar3_N_ave_no_of_rooms_count', 'addr_risk_summary3');
ar3_N_ave_no_of_stories_count := Scoring_Project.MACRO_Populating_Value(pj, 'ar3_N_ave_no_of_stories_count', 'addr_risk_summary3');
ar3_N_ave_price_per_sf := Scoring_Project.MACRO_Range_Dollar(pj, 'ar3_N_ave_price_per_sf', 'addr_risk_summary3');
ar3_N_ave_building_area := Scoring_Project.MACRO_Range_Dollar(pj, 'ar3_N_ave_building_area', 'addr_risk_summary3');
ar3_N_ave_assessed_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'ar3_N_ave_assessed_amount', 'addr_risk_summary3');
ar3_N_ave_mortgage_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'ar3_N_ave_mortgage_amount', 'addr_risk_summary3');
ar3_N_ave_purchase_amount := Scoring_Project.MACRO_Range_Dollar(pj, 'ar3_N_ave_purchase_amount', 'addr_risk_summary3');
ar3_N_ave_building_age := Scoring_Project.MACRO_Populating_Value(pj, 'ar3_N_ave_building_age', 'addr_risk_summary3');
ar3_N_MFD_Count := Scoring_Project.MACRO_Range_Dollar(pj, 'ar3_N_MFD_Count', 'addr_risk_summary3');
ar3_N_SFD_Count := Scoring_Project.MACRO_Range_Dollar(pj, 'ar3_N_SFD_Count', 'addr_risk_summary3');
ar3_N_Business_Count := Scoring_Project.MACRO_Range_100(pj, 'ar3_N_Business_Count', 'addr_risk_summary3');
ar3_N_Vacant_Properties := Scoring_Project.MACRO_Range_10(pj, 'ar3_N_Vacant_Properties', 'addr_risk_summary3');
ar3_turnover_1yr_out := Scoring_Project.MACRO_Populating_Value(pj, 'ar3_turnover_1yr_out', 'addr_risk_summary3');
ar3_turnover_1yr_in := Scoring_Project.MACRO_Populating_Value(pj, 'ar3_turnover_1yr_in', 'addr_risk_summary3');
ar3_occupants_1yr := Scoring_Project.MACRO_Populating_Value(pj, 'ar3_occupants_1yr', 'addr_risk_summary3');

addr_risk_summary3 := ar3_N_ave_no_of_baths_count + ar3_N_ave_no_of_bedrooms_count + ar3_N_ave_no_of_rooms_count + ar3_N_ave_no_of_stories_count + ar3_N_ave_price_per_sf +
ar3_N_ave_building_area + ar3_N_ave_assessed_amount + ar3_N_ave_mortgage_amount + ar3_N_ave_purchase_amount + ar3_N_ave_building_age + ar3_N_MFD_Count + ar3_N_SFD_Count +
ar3_N_Business_Count + ar3_N_Vacant_Properties + ar3_turnover_1yr_out + ar3_turnover_1yr_in + ar3_occupants_1yr;
/*******************************************************************************************************************************************/
//iBehavior
/*******************************************************************************************************************************************/
Retail_Orders := Scoring_Project.MACRO_Populating_Value(pj, 'Retail_Orders', 'iBehavior');
Retail_Dollars := Scoring_Project.MACRO_Range_Dollar(pj, 'Retail_Dollars', 'iBehavior');
Retail_Average_Amount_Per_Order := Scoring_Project.MACRO_Range_Dollar(pj, 'Retail_Average_Amount_Per_Order', 'iBehavior');
Online_Orders := Scoring_Project.MACRO_Populating_Value(pj, 'Online_Orders', 'iBehavior');
Online_Dollars := Scoring_Project.MACRO_Range_Dollar(pj, 'Online_Dollars', 'iBehavior');
Online_Average_Amount_Per_Order := Scoring_Project.MACRO_Range_Dollar(pj, 'Online_Average_Amount_Per_Order', 'iBehavior');
Offline_Orders := Scoring_Project.MACRO_Populating_Value(pj, 'Offline_Orders', 'iBehavior');
Offline_Dollars := Scoring_Project.MACRO_Range_Dollar(pj, 'Offline_Dollars', 'iBehavior');
Offline_Average_Amount_Per_Order := Scoring_Project.MACRO_Range_Dollar(pj, 'Offline_Average_Amount_Per_Order', 'iBehavior');
Total_Number_of_Orders := Scoring_Project.MACRO_Populating_Value(pj, 'Total_Number_of_Orders', 'iBehavior');
Total_Dollars := Scoring_Project.MACRO_Range_Dollar(pj, 'Total_Dollars', 'iBehavior');
Average_Amount_Per_Order := Scoring_Project.MACRO_Range_Dollar(pj, 'Average_Amount_Per_Order', 'iBehavior');
Average_Days_Between_Orders := Scoring_Project.MACRO_Range_100(pj, 'Average_Days_Between_Orders', 'iBehavior');
// number_of_sources := Scoring_Project.MACRO_Range_10(pj, 'number_of_sources', 'iBehavior');

r2 := record
string100 field_name := 'number_of_sources';
	string100 category := 'iBehavior';
  string30 distribution_type := 'RANGE';
  string50 attribute_value := MAP((integer)pj.number_of_sources  between 01  and 05  => '01 to 05',
																	(integer)pj.number_of_sources between 06  and 10  => '06 to 10',
																	(integer)pj.number_of_sources >= 11 => '> 10',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;


number_of_sources := table(pj,r2,MAP((integer)pj.number_of_sources  between 01  and 05  => '01 to 05',
																	(integer)pj.number_of_sources between 06  and 10  => '06 to 10',
																	(integer)pj.number_of_sources >= 11 => '> 10',
																	'UNDEFINED'));
																	
																	
Last_Order_Date := Scoring_Project.Macro_Dates_Within_30(pj, 'Last_Order_Date', 'iBehavior', 30);
First_Order_Date := Scoring_Project.Macro_Dates_Within_30(pj, 'First_Order_Date', 'iBehavior', 30);
Cnsmr_date_last_seen := Scoring_Project.Macro_Dates_Within_30(pj, 'Cnsmr_date_last_seen', 'iBehavior', 30);
Cnsmr_date_first_seen := Scoring_Project.Macro_Dates_Within_30(pj, 'Cnsmr_date_first_seen', 'iBehavior', 30);


iBehavior := Retail_Orders + Retail_Dollars + Retail_Average_Amount_Per_Order + Online_Orders + Online_Dollars + Online_Average_Amount_Per_Order + Offline_Orders +
Offline_Dollars + Offline_Average_Amount_Per_Order + Total_Number_of_Orders + Total_Dollars + Average_Amount_Per_Order + Average_Days_Between_Orders + number_of_sources + 
Last_Order_Date + First_Order_Date + Cnsmr_date_last_seen + Cnsmr_date_first_seen;

/*******************************************************************************************************************************************/
//fdAttributesv2
/*******************************************************************************************************************************************/

SourceRiskLevel := Scoring_Project.MACRO_distinct_values(pj, 'SourceRiskLevel', 'fdAttributesv2');
IDVerAddressNotCurrent := Scoring_Project.MACRO_distinct_values(pj, 'IDVerAddressNotCurrent', 'fdAttributesv2');
IDVerRiskLevel := Scoring_Project.MACRO_distinct_values(pj, 'IDVerRiskLevel', 'fdAttributesv2');
IdentityRiskLevel := Scoring_Project.MACRO_distinct_values(pj, 'IdentityRiskLevel', 'fdAttributesv2');
VariationRiskLevel := Scoring_Project.MACRO_distinct_values(pj, 'VariationRiskLevel', 'fdAttributesv2');
VariationMSourcesSSNCount := Scoring_Project.MACRO_distinct_values(pj, 'VariationMSourcesSSNCount', 'fdAttributesv2');
VariationDOBCountNew := Scoring_Project.MACRO_distinct_values(pj, 'VariationDOBCountNew', 'fdAttributesv2');
VariationMSourcesSSNUnrelCount := Scoring_Project.MACRO_distinct_values(pj, 'VariationMSourcesSSNUnrelCount', 'fdAttributesv2');
VariationDOBCount := Scoring_Project.MACRO_distinct_values(pj, 'VariationDOBCount', 'fdAttributesv2');

AssocSuspicousIdentitiesCount := Scoring_Project.MACRO_Range_10(pj, 'AssocSuspicousIdentitiesCount', 'fdAttributesv2');
DivSSNIdentityMSourceUrelCount := Scoring_Project.MACRO_Range_10(pj, 'DivSSNIdentityMSourceUrelCount', 'fdAttributesv2');
SearchSSNSearchCount := Scoring_Project.MACRO_Range_10(pj, 'SearchSSNSearchCount', 'fdAttributesv2');
SearchAddrSearchCount := Scoring_Project.MACRO_Range_10(pj, 'SearchAddrSearchCount', 'fdAttributesv2');
SearchPhoneSearchCount := Scoring_Project.MACRO_Range_10(pj, 'SearchPhoneSearchCount', 'fdAttributesv2');


AddrChangeIncomeDiff := Scoring_Project.MACRO_Range_100000(pj, 'AddrChangeIncomeDiff', 'fdAttributesv2');
AddrChangeValueDiff := Scoring_Project.MACRO_Range_100000(pj, 'AddrChangeValueDiff', 'fdAttributesv2');

//// AddrChangeEconTrajectory 
rc := record
string100 field_name := 'AddrChangeEconTrajectory';
string100 category := 'fdAttributesv2';
string30 distribution_type := 'DISTINCT-VALUE';
STRING50 attribute_value := MAP( pj.AddrChangeEconTrajectory = '-1' => '-1',
																		pj.AddrChangeEconTrajectory[1..1] > pj.AddrChangeEconTrajectory[2..2] => 'Move Up in Value',
																		pj.AddrChangeEconTrajectory[1..1] < pj.AddrChangeEconTrajectory[2..2] => 'Move down in Value',
																		pj.AddrChangeEconTrajectory[1..1] = pj.AddrChangeEconTrajectory[2..2] => 'Same Value',
																		'Unknown');
decimal20_4 frequency := count(group);
end;

AddrChangeEconTrajectory := table(pj, rc,MAP( pj.AddrChangeEconTrajectory = '-1' => '-1',
																		pj.AddrChangeEconTrajectory[1..1] > pj.AddrChangeEconTrajectory[2..2] => 'Move Up in Value',
																		pj.AddrChangeEconTrajectory[1..1] < pj.AddrChangeEconTrajectory[2..2] => 'Move down in Value',
																		pj.AddrChangeEconTrajectory[1..1] = pj.AddrChangeEconTrajectory[2..2] => 'Same Value',
																		'Unknown') ,all);
																		
																
SearchFraudSearchCountMonth := Scoring_Project.MACRO_distinct_values(pj, 'SearchFraudSearchCountMonth', 'fdAttributesv2');
SearchUnverifiedPhoneCountYear := Scoring_Project.MACRO_distinct_values(pj, 'SearchUnverifiedPhoneCountYear', 'fdAttributesv2');
SearchUnverifiedDOBCountYear := Scoring_Project.MACRO_distinct_values(pj, 'SearchUnverifiedDOBCountYear', 'fdAttributesv2');
SearchUnverifiedAddrCountYear := Scoring_Project.MACRO_distinct_values(pj, 'SearchUnverifiedAddrCountYear', 'fdAttributesv2');
SearchUnverifiedSSNCountYear := Scoring_Project.MACRO_distinct_values(pj, 'SearchUnverifiedSSNCountYear', 'fdAttributesv2');
SearchCountDay := Scoring_Project.MACRO_distinct_values(pj, 'SearchCountDay', 'fdAttributesv2');
SearchCountWeek := Scoring_Project.MACRO_distinct_values(pj, 'SearchCountWeek', 'fdAttributesv2');
SearchVelocityRiskLevel := Scoring_Project.MACRO_distinct_values(pj, 'SearchVelocityRiskLevel', 'fdAttributesv2');

SearchFraudSearchCountYear := Scoring_Project.MACRO_Range_10(pj, 'SearchFraudSearchCountYear', 'fdAttributesv2');
CorrelationAddrNameCount := Scoring_Project.MACRO_Range_10(pj, 'CorrelationAddrNameCount', 'fdAttributesv2');
CorrelationSSNAddrCount := Scoring_Project.MACRO_Range_10(pj, 'CorrelationSSNAddrCount', 'fdAttributesv2');
AssocCreditBureauOnlyCount := Scoring_Project.MACRO_Range_10(pj, 'AssocCreditBureauOnlyCount', 'fdAttributesv2');
SearchFraudSearchCount := Scoring_Project.MACRO_Range_10(pj, 'SearchFraudSearchCount', 'fdAttributesv2');

CorrelationRiskLevel := Scoring_Project.MACRO_Range_25(pj, 'CorrelationRiskLevel', 'fdAttributesv2');
ValidationRiskLevel := Scoring_Project.MACRO_Range_25(pj, 'ValidationRiskLevel', 'fdAttributesv2');
AssocCreditBureauOnlyCountMonth := Scoring_Project.MACRO_Range_25(pj, 'AssocCreditBureauOnlyCountMonth', 'fdAttributesv2');
AssocCreditBureauOnlyCountNew := Scoring_Project.MACRO_Range_25(pj, 'AssocCreditBureauOnlyCountNew', 'fdAttributesv2');

CorrelationSSNNameCount := Scoring_Project.MACRO_Range_25(pj, 'CorrelationSSNNameCount', 'fdAttributesv2');
PrevAddrCrimeIndex := Scoring_Project.MACRO_Range_25(pj, 'PrevAddrCrimeIndex', 'fdAttributesv2');
PrevAddrBurglaryIndex := Scoring_Project.MACRO_Range_25(pj, 'PrevAddrBurglaryIndex', 'fdAttributesv2');
PrevAddrCarTheftIndex := Scoring_Project.MACRO_Range_25(pj, 'PrevAddrCarTheftIndex', 'fdAttributesv2');
PrevAddrMurderIndex := Scoring_Project.MACRO_Range_25(pj, 'PrevAddrMurderIndex', 'fdAttributesv2');
CurrAddrCrimeIndex := Scoring_Project.MACRO_Range_25(pj, 'CurrAddrCrimeIndex', 'fdAttributesv2');
CurrAddrBurglaryIndex := Scoring_Project.MACRO_Range_25(pj, 'CurrAddrBurglaryIndex', 'fdAttributesv2');
CurrAddrCarTheftIndex := Scoring_Project.MACRO_Range_25(pj, 'CurrAddrCarTheftIndex', 'fdAttributesv2');
CurrAddrMurderIndex := Scoring_Project.MACRO_Range_25(pj, 'CurrAddrMurderIndex', 'fdAttributesv2');
AddrChangeCrimeDiff := Scoring_Project.MACRO_Range_25(pj, 'AddrChangeCrimeDiff', 'fdAttributesv2');

PrevAddrMedianValue := Scoring_Project.MACRO_Range_100000(pj, 'PrevAddrMedianValue', 'fdAttributesv2');
PrevAddrMedianIncome := Scoring_Project.MACRO_Range_50000(pj, 'PrevAddrMedianIncome', 'fdAttributesv2');
CurrAddrMedianValue := Scoring_Project.MACRO_Range_100000(pj, 'CurrAddrMedianValue', 'fdAttributesv2');
CurrAddrMedianIncome := Scoring_Project.MACRO_Range_50000(pj, 'CurrAddrMedianIncome', 'fdAttributesv2');

AssocRiskLevel := Scoring_Project.MACRO_distinct_values(pj, 'AssocRiskLevel', 'fdAttributesv2');
SearchLocateSearchCountDay := Scoring_Project.MACRO_distinct_values(pj, 'SearchLocateSearchCountDay', 'fdAttributesv2');
SearchLocateSearchCountWeek := Scoring_Project.MACRO_distinct_values(pj, 'SearchLocateSearchCountWeek', 'fdAttributesv2');
SearchFraudSearchCountDay := Scoring_Project.MACRO_distinct_values(pj, 'SearchFraudSearchCountDay', 'fdAttributesv2');
SearchFraudSearchCountWeek := Scoring_Project.MACRO_distinct_values(pj, 'SearchFraudSearchCountWeek', 'fdAttributesv2');

SearchComponentRiskLevel := Scoring_Project.MACRO_distinct_values(pj, 'SearchComponentRiskLevel', 'fdAttributesv2');
DivSearchAddrSuspIdentityCount := Scoring_Project.MACRO_distinct_values(pj, 'DivSearchAddrSuspIdentityCount', 'fdAttributesv2');
DivAddrSuspIdentityCountNew := Scoring_Project.MACRO_distinct_values(pj, 'DivAddrSuspIdentityCountNew', 'fdAttributesv2');
DivRiskLevel := Scoring_Project.MACRO_distinct_values(pj, 'DivRiskLevel', 'fdAttributesv2');
CorrelationPhoneLastNameCount := Scoring_Project.MACRO_distinct_values(pj, 'CorrelationPhoneLastNameCount', 'fdAttributesv2');
CorrelationAddrPhoneCount := Scoring_Project.MACRO_distinct_values(pj, 'CorrelationAddrPhoneCount', 'fdAttributesv2');
PrevAddrOccupantOwned := Scoring_Project.MACRO_distinct_values(pj, 'PrevAddrOccupantOwned', 'fdAttributesv2');
PrevAddrStatus := Scoring_Project.MACRO_distinct_values(pj, 'PrevAddrStatus', 'fdAttributesv2');
PrevAddrDwellType := Scoring_Project.MACRO_distinct_values(pj, 'PrevAddrDwellType', 'fdAttributesv2');
CurrAddrActivePhoneList := Scoring_Project.MACRO_distinct_values(pj, 'CurrAddrActivePhoneList', 'fdAttributesv2');
AddrChangeEconTrajectoryIndex := Scoring_Project.MACRO_distinct_values(pj, 'AddrChangeEconTrajectoryIndex', 'fdAttributesv2');
InputAddrActivePhoneList := Scoring_Project.MACRO_distinct_values(pj, 'InputAddrActivePhoneList', 'fdAttributesv2');
ComponentCharRiskLevel := Scoring_Project.MACRO_distinct_values(pj, 'ComponentCharRiskLevel', 'fdAttributesv2');
SearchPhoneSearchCountDay := Scoring_Project.MACRO_distinct_values(pj, 'SearchPhoneSearchCountDay', 'fdAttributesv2');
SearchPhoneSearchCountWeek := Scoring_Project.MACRO_distinct_values(pj, 'SearchPhoneSearchCountWeek', 'fdAttributesv2');
SearchPhoneSearchCountMonth := Scoring_Project.MACRO_distinct_values(pj, 'SearchPhoneSearchCountMonth', 'fdAttributesv2');
SearchAddrSearchCountDay := Scoring_Project.MACRO_distinct_values(pj, 'SearchAddrSearchCountDay', 'fdAttributesv2');
SearchAddrSearchCountWeek := Scoring_Project.MACRO_distinct_values(pj, 'SearchAddrSearchCountWeek', 'fdAttributesv2');
SearchAddrSearchCountMonth := Scoring_Project.MACRO_distinct_values(pj, 'SearchAddrSearchCountMonth', 'fdAttributesv2');
	SearchSSNSearchCountDay := Scoring_Project.MACRO_distinct_values(pj, 'SearchSSNSearchCountDay', 'fdAttributesv2');
SearchSSNSearchCountWeek := Scoring_Project.MACRO_distinct_values(pj, 'SearchSSNSearchCountWeek', 'fdAttributesv2');
SearchSSNSearchCountMonth := Scoring_Project.MACRO_distinct_values(pj, 'SearchSSNSearchCountMonth', 'fdAttributesv2');

PrevAddrLenOfRes := Scoring_Project.MACRO_Range_100(pj, 'PrevAddrLenOfRes', 'fdAttributesv2');
PrevAddrAgeOldest := Scoring_Project.MACRO_Range_100(pj, 'PrevAddrAgeOldest', 'fdAttributesv2');

fdAttributesv2 := SourceRiskLevel + IDVerAddressNotCurrent + IDVerRiskLevel + IdentityRiskLevel + VariationRiskLevel + VariationMSourcesSSNCount + 
VariationDOBCountNew + VariationMSourcesSSNUnrelCount + VariationDOBCount + AssocSuspicousIdentitiesCount + DivSSNIdentityMSourceUrelCount + SearchSSNSearchCount +
SearchAddrSearchCount + SearchPhoneSearchCount + AddrChangeIncomeDiff + AddrChangeValueDiff + AddrChangeEconTrajectory + SearchFraudSearchCountMonth + 
SearchUnverifiedPhoneCountYear + SearchUnverifiedDOBCountYear + SearchUnverifiedAddrCountYear + SearchUnverifiedSSNCountYear + SearchCountDay + SearchCountWeek +
SearchVelocityRiskLevel + SearchFraudSearchCountYear + CorrelationAddrNameCount + CorrelationSSNAddrCount + AssocCreditBureauOnlyCount + SearchFraudSearchCount +
CorrelationRiskLevel + ValidationRiskLevel + AssocCreditBureauOnlyCountMonth + AssocCreditBureauOnlyCountNew + CorrelationSSNNameCount + PrevAddrCrimeIndex + 
PrevAddrBurglaryIndex + PrevAddrCarTheftIndex + PrevAddrMurderIndex + CurrAddrCrimeIndex + CurrAddrBurglaryIndex + CurrAddrCarTheftIndex + CurrAddrMurderIndex +
AddrChangeCrimeDiff + PrevAddrMedianValue + PrevAddrMedianIncome + CurrAddrMedianValue + CurrAddrMedianIncome + AssocRiskLevel + SearchLocateSearchCountDay + 
SearchLocateSearchCountWeek + SearchFraudSearchCountDay + SearchFraudSearchCountWeek + SearchComponentRiskLevel + DivSearchAddrSuspIdentityCount + DivAddrSuspIdentityCountNew +
DivRiskLevel + CorrelationPhoneLastNameCount + CorrelationAddrPhoneCount + PrevAddrOccupantOwned + PrevAddrStatus + PrevAddrDwellType + CurrAddrActivePhoneList +
AddrChangeEconTrajectoryIndex + InputAddrActivePhoneList + ComponentCharRiskLevel + SearchPhoneSearchCountDay + SearchPhoneSearchCountWeek + SearchPhoneSearchCountMonth +
SearchAddrSearchCountDay + SearchAddrSearchCountWeek + SearchAddrSearchCountMonth + SearchSSNSearchCountDay + SearchSSNSearchCountWeek + SearchSSNSearchCountMonth +
PrevAddrLenOfRes + PrevAddrAgeOldest;
/*******************************************************************************************************************************************/
//address_sources_summary
/*******************************************************************************************************************************************/

previous_addr_sources_recordcount := Scoring_Project.MACRO_Parsing_Text(pj, 'previous_addr_sources_recordcount', 'address_sources_summary');
previous_addr_sources_first_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'previous_addr_sources_first_seen_date', 'address_sources_summary', 30);//waiting for Ben's confirmation
previous_addr_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'previous_addr_sources', 'address_sources_summary');
current_addr_sources_recordcount := Scoring_Project.MACRO_Parsing_Text(pj, 'current_addr_sources_recordcount', 'address_sources_summary');
current_addr_sources_first_seen_date := Scoring_Project.Macro_Dates_Within_30(pj, 'current_addr_sources_first_seen_date', 'address_sources_summary', 30);//waiting for Ben's confirmation
current_addr_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'current_addr_sources', 'address_sources_summary');
input_addr_sources_recordcount := Scoring_Project.MACRO_Parsing_Text(pj, 'input_addr_sources_recordcount', 'address_sources_summary');
input_addr_sources_first_seen_date := Scoring_Project.MACRO_Parsing_Text(pj, 'input_addr_sources_first_seen_date', 'address_sources_summary');//waiting for Ben's confirmation
input_addr_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'input_addr_sources', 'address_sources_summary');

address_sources_summary := previous_addr_sources_recordcount + previous_addr_sources_first_seen_date + previous_addr_sources + current_addr_sources_recordcount +
current_addr_sources_first_seen_date + current_addr_sources + input_addr_sources_recordcount + input_addr_sources_first_seen_date + input_addr_sources;
/*******************************************************************************************************************************************/
//insurance_phones_summary
/*******************************************************************************************************************************************/
Insurance_Phone_Verification := Scoring_Project.MACRO_distinct_values(pj, 'Insurance_Phone_Verification', 'insurance_phones_summary');
insurance_phones_phone_hit := Scoring_Project.MACRO_distinct_values(pj, 'insurance_phones_phone_hit', 'insurance_phones_summary');
insurance_phones_phonesearch_didmatch := Scoring_Project.MACRO_distinct_values(pj, 'insurance_phones_phonesearch_didmatch', 'insurance_phones_summary');
insurance_phones_did_hit := Scoring_Project.MACRO_distinct_values(pj, 'insurance_phones_did_hit', 'insurance_phones_summary');
insurance_phones_didsearch_phonematch := Scoring_Project.MACRO_distinct_values(pj, 'insurance_phones_didsearch_phonematch', 'insurance_phones_summary');

insurance_phones_summary := Insurance_Phone_Verification + insurance_phones_phone_hit + insurance_phones_phonesearch_didmatch + insurance_phones_did_hit + 
insurance_phones_didsearch_phonematch;

/*******************************************************************************************************************************************/
//hhid_summary
/*******************************************************************************************************************************************/
hh_college_attendees := Scoring_Project.MACRO_distinct_values(pj, 'hh_college_attendees', 'hhid_summary');
hh_criminals := Scoring_Project.MACRO_distinct_values(pj, 'hh_criminals', 'hhid_summary');
hh_prof_license_holders := Scoring_Project.MACRO_distinct_values(pj, 'hh_prof_license_holders', 'hhid_summary');
hh_lienholders := Scoring_Project.MACRO_distinct_values(pj, 'hh_lienholders', 'hhid_summary');
hh_bankruptcies := Scoring_Project.MACRO_distinct_values(pj, 'hh_bankruptcies', 'hhid_summary');
hh_tot_derog := Scoring_Project.MACRO_distinct_values(pj, 'hh_tot_derog', 'hhid_summary');
hh_members_w_derog := Scoring_Project.MACRO_distinct_values(pj, 'hh_members_w_derog', 'hhid_summary');
hh_payday_loan_users := Scoring_Project.MACRO_distinct_values(pj, 'hh_payday_loan_users', 'hhid_summary');
hh_workers_paw := Scoring_Project.MACRO_distinct_values(pj, 'hh_workers_paw', 'hhid_summary');
hh_collections_ct := Scoring_Project.MACRO_distinct_values(pj, 'hh_collections_ct', 'hhid_summary');
hh_age_lt18 := Scoring_Project.MACRO_distinct_values(pj, 'hh_age_lt18', 'hhid_summary');
hh_age_18_to_30 := Scoring_Project.MACRO_distinct_values(pj, 'hh_age_18_to_30', 'hhid_summary');
hh_age_31_to_65 := Scoring_Project.MACRO_distinct_values(pj, 'hh_age_31_to_65', 'hhid_summary');
hh_age_65_plus := Scoring_Project.MACRO_distinct_values(pj, 'hh_age_65_plus', 'hhid_summary');
hh_property_owners_ct := Scoring_Project.MACRO_distinct_values(pj, 'hh_property_owners_ct', 'hhid_summary');
hh_members_ct := Scoring_Project.MACRO_distinct_values(pj, 'hh_members_ct', 'hhid_summary');
hhid := Scoring_Project.MACRO_Length(pj, 'hhid', 'hhid_summary');

hhid_summary := hh_college_attendees + hh_criminals + hh_prof_license_holders + hh_lienholders + hh_bankruptcies + hh_tot_derog + hh_members_w_derog + 
hh_payday_loan_users + hh_workers_paw + hh_collections_ct + hh_age_lt18 + hh_age_18_to_30 + hh_age_31_to_65 + hh_age_65_plus + hh_property_owners_ct + 
hh_members_ct + hhid;
/*******************************************************************************************************************************************/
//AMLAttributes
/*******************************************************************************************************************************************/
IndCitizenshipIndex := Scoring_Project.MACRO_distinct_values(pj, 'IndCitizenshipIndex', 'AMLAttributes');
IndMobilityIndex := Scoring_Project.MACRO_distinct_values(pj, 'IndMobilityIndex', 'AMLAttributes');
IndLegalEventsIndex := Scoring_Project.MACRO_distinct_values(pj, 'IndLegalEventsIndex', 'AMLAttributes');
IndAccesstoFundsIndex := Scoring_Project.MACRO_distinct_values(pj, 'IndAccesstoFundsIndex', 'AMLAttributes');
IndBusinessAssocationIndex := Scoring_Project.MACRO_distinct_values(pj, 'IndBusinessAssocationIndex', 'AMLAttributes');
IndHighValueAssetIndex := Scoring_Project.MACRO_distinct_values(pj, 'IndHighValueAssetIndex', 'AMLAttributes');
IndGeographicIndex := Scoring_Project.MACRO_distinct_values(pj, 'IndGeographicIndex', 'AMLAttributes');
IndAssociatesIndex := Scoring_Project.MACRO_distinct_values(pj, 'IndAssociatesIndex', 'AMLAttributes');
IndAgeRange := Scoring_Project.MACRO_distinct_values(pj, 'IndAgeRange', 'AMLAttributes');
IndAMLNegativeNews90 := Scoring_Project.MACRO_distinct_values(pj, 'IndAMLNegativeNews90', 'AMLAttributes');
IndAMLNegativeNews24 := Scoring_Project.MACRO_distinct_values(pj, 'IndAMLNegativeNews24', 'AMLAttributes');
BusValidityIndex := Scoring_Project.MACRO_distinct_values(pj, 'BusValidityIndex', 'AMLAttributes');
BusStabilityIndex := Scoring_Project.MACRO_distinct_values(pj, 'BusStabilityIndex', 'AMLAttributes');
BusLegalEventsIndex := Scoring_Project.MACRO_distinct_values(pj, 'BusLegalEventsIndex', 'AMLAttributes');
BusAccesstoFundsIndex := Scoring_Project.MACRO_distinct_values(pj, 'BusAccesstoFundsIndex', 'AMLAttributes');
BusGeographicIndex := Scoring_Project.MACRO_distinct_values(pj, 'BusGeographicIndex', 'AMLAttributes');
BusAssociatesIndex := Scoring_Project.MACRO_distinct_values(pj, 'BusAssociatesIndex', 'AMLAttributes');
BusIndustryRiskIndex := Scoring_Project.MACRO_distinct_values(pj, 'BusIndustryRiskIndex', 'AMLAttributes');
BusAMLNegativeNews90 := Scoring_Project.MACRO_distinct_values(pj, 'BusAMLNegativeNews90', 'AMLAttributes');
BusAMLNegativeNews24 := Scoring_Project.MACRO_distinct_values(pj, 'BusAMLNegativeNews24', 'AMLAttributes');

AMLAttributes := IndCitizenshipIndex + IndMobilityIndex + IndLegalEventsIndex + IndAccesstoFundsIndex + IndBusinessAssocationIndex + IndHighValueAssetIndex +
IndGeographicIndex + IndAssociatesIndex + IndAgeRange + IndAMLNegativeNews90 + IndAMLNegativeNews24 + BusValidityIndex + BusStabilityIndex + BusLegalEventsIndex +
BusAccesstoFundsIndex + BusGeographicIndex + BusAssociatesIndex + BusIndustryRiskIndex + BusAMLNegativeNews90 + BusAMLNegativeNews24;
/*******************************************************************************************************************************************/
//Professional_License
/*******************************************************************************************************************************************/	
most_recent_sanction_type := Scoring_Project.MACRO_distinct_values(pj, 'most_recent_sanction_type', 'Professional_License');
sanctions_date_last_seen := Scoring_Project.MACRO_distinct_values(pj, 'sanctions_date_last_seen', 'Professional_License');
sanctions_date_first_seen := Scoring_Project.MACRO_distinct_values(pj, 'sanctions_date_first_seen', 'Professional_License');
sanctions_count := Scoring_Project.MACRO_distinct_values(pj, 'sanctions_count', 'Professional_License');
proflic_Source := Scoring_Project.MACRO_distinct_values(pj, 'proflic_Source', 'Professional_License');
expire_count60 := Scoring_Project.MACRO_distinct_values(pj, 'expire_count60', 'Professional_License');
expire_count36 := Scoring_Project.MACRO_distinct_values(pj, 'expire_count36', 'Professional_License');
expire_count24 := Scoring_Project.MACRO_distinct_values(pj, 'expire_count24', 'Professional_License');
expire_count12 := Scoring_Project.MACRO_distinct_values(pj, 'expire_count12', 'Professional_License');
expire_count180 := Scoring_Project.MACRO_distinct_values(pj, 'expire_count180', 'Professional_License');
expire_count90 := Scoring_Project.MACRO_distinct_values(pj, 'expire_count90', 'Professional_License');
expire_count30 := Scoring_Project.MACRO_distinct_values(pj, 'expire_count30', 'Professional_License');
proflic_count60 := Scoring_Project.MACRO_distinct_values(pj, 'proflic_count60', 'Professional_License');
proflic_count36 := Scoring_Project.MACRO_distinct_values(pj, 'proflic_count36', 'Professional_License');
proflic_count24 := Scoring_Project.MACRO_distinct_values(pj, 'proflic_count24', 'Professional_License');
proflic_count12 := Scoring_Project.MACRO_distinct_values(pj, 'proflic_count12', 'Professional_License');
proflic_count180 := Scoring_Project.MACRO_distinct_values(pj, 'proflic_count180', 'Professional_License');
proflic_count90 := Scoring_Project.MACRO_distinct_values(pj, 'proflic_count90', 'Professional_License');
proflic_count30 := Scoring_Project.MACRO_distinct_values(pj, 'proflic_count30', 'Professional_License');
expiration_date := Scoring_Project.Macro_Dates_Within_30(pj, 'expiration_date', 'Professional_License', 30);//clarify with nathan
date_most_recent := Scoring_Project.Macro_Dates_Within_30(pj, 'date_most_recent', 'Professional_License', 30);
proflic_count := Scoring_Project.MACRO_distinct_values(pj, 'proflic_count', 'Professional_License');
plCategory := Scoring_Project.MACRO_distinct_values(pj, 'plCategory', 'Professional_License');
jobCategory := Scoring_Project.MACRO_Populating_Value(pj, 'jobCategory', 'Professional_License');
professional_license_flag := Scoring_Project.MACRO_distinct_values(pj, 'professional_license_flag', 'Professional_License');
license_type := Scoring_Project.MACRO_Populating_Value(pj, 'license_type', 'Professional_License');

Professional_License := license_type + professional_license_flag + jobCategory + plCategory + proflic_count + date_most_recent + expiration_date + proflic_count30 +
proflic_count90 + proflic_count180 + proflic_count12 + proflic_count24 + proflic_count36 + proflic_count60 + expire_count30 + expire_count90 + expire_count180 +
expire_count12 + expire_count24 + expire_count36 + expire_count60 + proflic_Source + sanctions_count + sanctions_date_first_seen + sanctions_date_last_seen + most_recent_sanction_type;
/*******************************************************************************************************************************************/
//Student
/*******************************************************************************************************************************************/	

tuition_code := Scoring_Project.MACRO_distinct_values(pj, 'tuition_code', 'Student');								
school_size_code := Scoring_Project.MACRO_distinct_values(pj, 'school_size_code', 'Student');	
competitive_code := Scoring_Project.MACRO_distinct_values(pj, 'competitive_code', 'Student');	
college_major := Scoring_Project.MACRO_distinct_values(pj, 'college_major', 'Student');	

COLLEGE_TIER := Scoring_Project.MACRO_distinct_values(pj, 'college_tier', 'Student');	
rec_type := Scoring_Project.MACRO_distinct_values(pj, 'rec_type', 'Student');	
FILE_TYPE2 := Scoring_Project.MACRO_distinct_values(pj, 'file_type2', 'Student');	
FILE_TYPE := Scoring_Project.MACRO_distinct_values(pj, 'file_type', 'Student');	
COLLEGE_CODE := Scoring_Project.MACRO_distinct_values(pj, 'college_code', 'Student');	
COLLEGE_NAME := Scoring_Project.MACRO_Populating_Value(pj, 'college_name', 'Student');	
CLASS := Scoring_Project.MACRO_Populating_Value(pj, 'class', 'Student');	
CRRT_CODE := Scoring_Project.MACRO_Populating_Value(pj, 'crrt_code', 'Student');	
INCOME_LEVEL_CODE := Scoring_Project.MACRO_distinct_values(pj, 'income_level_code', 'Student');	
COLLEGE_TYPE := Scoring_Project.MACRO_distinct_values(pj, 'college_type', 'Student');	
ADDRESS_TYPE_CODE := Scoring_Project.MACRO_distinct_values(pj, 'address_type_code', 'Student');	
STUDENT_AGE := Scoring_Project.MACRO_Range_10(pj, 'student_age', 'Student');	
DOB_FORMATTED := Scoring_Project.Macro_Dates_Within_30(pj, 'dob_formatted', 'Student', 30);
STUDENT_DATE_FIRST_SEEN := Scoring_Project.Macro_Dates_Within_30(pj, 'student_date_first_seen', 'Student', 30);
STUDENT_DATE_LAST_SEEN := Scoring_Project.Macro_Dates_Within_30(pj, 'student_date_last_seen', 'Student', 30);

Student := STUDENT_DATE_LAST_SEEN + STUDENT_DATE_FIRST_SEEN + DOB_FORMATTED + STUDENT_AGE + ADDRESS_TYPE_CODE + COLLEGE_TYPE + INCOME_LEVEL_CODE + CRRT_CODE + CLASS +
COLLEGE_NAME + COLLEGE_CODE + COLLEGE_TYPE + INCOME_LEVEL_CODE + FILE_TYPE + FILE_TYPE2 + rec_type + COLLEGE_TIER + college_major + competitive_code + 
school_size_code + tuition_code;

/*******************************************************************************************************************************************/
//Aircraft
/*******************************************************************************************************************************************/	

aircraft_count := Scoring_Project.MACRO_distinct_values(pj, 'aircraft_count', 'Aircraft');								
aircraft_count30 := Scoring_Project.MACRO_distinct_values(pj, 'aircraft_count30', 'Aircraft');				
aircraft_count90 := Scoring_Project.MACRO_distinct_values(pj, 'aircraft_count90', 'Aircraft');				
aircraft_count180 := Scoring_Project.MACRO_distinct_values(pj, 'aircraft_count180', 'Aircraft');				
aircraft_count12 := Scoring_Project.MACRO_distinct_values(pj, 'aircraft_count12', 'Aircraft');				
aircraft_count24 := Scoring_Project.MACRO_distinct_values(pj, 'aircraft_count24', 'Aircraft');				
aircraft_count36 := Scoring_Project.MACRO_distinct_values(pj, 'aircraft_count36', 'Aircraft');				
aircraft_count60 := Scoring_Project.MACRO_distinct_values(pj, 'aircraft_count60', 'Aircraft');				
n_number := Scoring_Project.MACRO_distinct_values(pj, 'n_number', 'Aircraft');				
date_first_seen := Scoring_Project.MACRO_distinct_values(pj, 'date_first_seen', 'Aircraft');				

Aircraft := aircraft_count + aircraft_count30 + aircraft_count90 + aircraft_count180 + aircraft_count12 + aircraft_count24 + aircraft_count36 + aircraft_count60 +
n_number + date_first_seen;
/*******************************************************************************************************************************************/
//Other_Address_Info
/*******************************************************************************************************************************************/	
unverified_addr_count := Scoring_Project.MACRO_distinct_values(pj, 'unverified_addr_count', 'Other_Address_Info');
num_sold60 := Scoring_Project.MACRO_distinct_values(pj, 'num_sold60', 'Other_Address_Info');
num_sold36 := Scoring_Project.MACRO_distinct_values(pj, 'num_sold36', 'Other_Address_Info');
num_sold24 := Scoring_Project.MACRO_distinct_values(pj, 'num_sold24', 'Other_Address_Info');
num_sold12 := Scoring_Project.MACRO_distinct_values(pj, 'num_sold12', 'Other_Address_Info');
num_sold180 := Scoring_Project.MACRO_distinct_values(pj, 'num_sold180', 'Other_Address_Info');
num_sold90 := Scoring_Project.MACRO_distinct_values(pj, 'num_sold90', 'Other_Address_Info');
num_sold30 := Scoring_Project.MACRO_distinct_values(pj, 'num_sold30', 'Other_Address_Info');
num_purchase60 := Scoring_Project.MACRO_distinct_values(pj, 'num_purchase60', 'Other_Address_Info');
num_purchase36 := Scoring_Project.MACRO_distinct_values(pj, 'num_purchase36', 'Other_Address_Info');
num_purchase24 := Scoring_Project.MACRO_distinct_values(pj, 'num_purchase24', 'Other_Address_Info');
num_purchase12 := Scoring_Project.MACRO_distinct_values(pj, 'num_purchase12', 'Other_Address_Info');
num_purchase180 := Scoring_Project.MACRO_distinct_values(pj, 'num_purchase180', 'Other_Address_Info');
num_purchase90 := Scoring_Project.MACRO_distinct_values(pj, 'num_purchase90', 'Other_Address_Info');
num_purchase30 := Scoring_Project.MACRO_distinct_values(pj, 'num_purchase30', 'Other_Address_Info');
addrs_last36 := Scoring_Project.MACRO_distinct_values(pj, 'addrs_last36', 'Other_Address_Info');
addrs_last24 := Scoring_Project.MACRO_distinct_values(pj, 'addrs_last24', 'Other_Address_Info');
addrs_last12 := Scoring_Project.MACRO_distinct_values(pj, 'addrs_last12', 'Other_Address_Info');
addrs_last90 := Scoring_Project.MACRO_distinct_values(pj, 'addrs_last90', 'Other_Address_Info');
addrs_last30 := Scoring_Project.MACRO_distinct_values(pj, 'addrs_last30', 'Other_Address_Info');
hist2_isPrison := Scoring_Project.MACRO_distinct_values(pj, 'hist2_isPrison', 'Other_Address_Info');
hist1_isPrison := Scoring_Project.MACRO_distinct_values(pj, 'hist1_isPrison', 'Other_Address_Info');
prisonFSdate := Scoring_Project.MACRO_distinct_values(pj, 'prisonFSdate', 'Other_Address_Info');
isPrison := Scoring_Project.MACRO_distinct_values(pj, 'isPrison', 'Other_Address_Info');
// addrs_last_5years := Scoring_Project.MACRO_distinct_values(pj, 'addrs_last_5years', 'Other_Address_Info');

r7 := record
string100 field_name := 'addrs_last_5years';
	string100 category := 'Other_Address_Info';
  string30 distribution_type := 'DISTINCT-VALUE';
  string50 attribute_value := MAP((integer)pj.addrs_last_5years  = 00  => '00',
																	(integer)pj.addrs_last_5years  = 01  => '01',
																	(integer)pj.addrs_last_5years  = 02  => '02',
																	(integer)pj.addrs_last_5years  = 03  => '03',
																	(integer)pj.addrs_last_5years  = 04  => '04',
																	(integer)pj.addrs_last_5years  = 05  => '05',
																	(integer)pj.addrs_last_5years  = 06  => '06',
																	(integer)pj.addrs_last_5years  >= 07  => '> 06',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;


addrs_last_5years := table(pj,r7,MAP((integer)pj.addrs_last_5years  = 00  => '00',
																	(integer)pj.addrs_last_5years  = 01  => '01',
																	(integer)pj.addrs_last_5years  = 02  => '02',
																	(integer)pj.addrs_last_5years  = 03  => '03',
																	(integer)pj.addrs_last_5years  = 04  => '04',
																	(integer)pj.addrs_last_5years  = 05  => '05',
																	(integer)pj.addrs_last_5years  = 06  => '06',
																	(integer)pj.addrs_last_5years  >= 07  => '> 06',
																	'UNDEFINED'));
																	
// addrs_last_10years := Scoring_Project.MACRO_distinct_values(pj, 'addrs_last_10years', 'Other_Address_Info');

r6 := record
string100 field_name := 'addrs_last_10years';
	string100 category := 'Other_Address_Info';
  string30 distribution_type := 'DISTINCT-VALUE';
  string50 attribute_value := MAP((integer)pj.addrs_last_10years  = 00  => '00',
																	(integer)pj.addrs_last_10years  = 01  => '01',
																	(integer)pj.addrs_last_10years  = 02  => '02',
																	(integer)pj.addrs_last_10years  = 03  => '03',
																	(integer)pj.addrs_last_10years  = 04  => '04',
																	(integer)pj.addrs_last_10years  = 05  => '05',
																	(integer)pj.addrs_last_10years  = 06  => '06',
																	(integer)pj.addrs_last_10years  = 07  => '07',
																	(integer)pj.addrs_last_10years  >= 08  => '> 07',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;


addrs_last_10years := table(pj,r6,MAP((integer)pj.addrs_last_10years  = 00  => '00',
																	(integer)pj.addrs_last_10years  = 01  => '01',
																	(integer)pj.addrs_last_10years  = 02  => '02',
																	(integer)pj.addrs_last_10years  = 03  => '03',
																	(integer)pj.addrs_last_10years  = 04  => '04',
																	(integer)pj.addrs_last_10years  = 05  => '05',
																	(integer)pj.addrs_last_10years  = 06  => '06',
																	(integer)pj.addrs_last_10years  = 07  => '07',
																	(integer)pj.addrs_last_10years  >= 08  => '> 07',
																	'UNDEFINED'));
																	
addrs_last_15years := Scoring_Project.MACRO_distinct_values(pj, 'addrs_last_15years', 'Other_Address_Info');
max_lres := Scoring_Project.MACRO_Range_100(pj, 'max_lres', 'Other_Address_Info');
avg_lres := Scoring_Project.MACRO_Range_100(pj, 'avg_lres', 'Other_Address_Info');

date_most_recent_sale := Scoring_Project.Macro_Dates_Within_30(pj, 'date_most_recent_sale', 'Other_Address_Info', 30);					
date_first_sale := Scoring_Project.Macro_Dates_Within_30(pj, 'date_first_sale', 'Other_Address_Info', 30);
date_most_recent_purchase := Scoring_Project.Macro_Dates_Within_30(pj, 'date_most_recent_purchase', 'Other_Address_Info', 30);
date_first_purchase := Scoring_Project.Macro_Dates_Within_30(pj, 'date_first_purchase', 'Other_Address_Info', 30);

Other_Address_Info := date_first_purchase + date_most_recent_purchase + date_first_sale + date_most_recent_sale + avg_lres + max_lres + addrs_last_15years + 
addrs_last_10years + addrs_last_5years + isPrison + prisonFSdate + hist1_isPrison + hist2_isPrison + addrs_last30 + addrs_last90 + addrs_last12 + addrs_last24 +
addrs_last36 + num_purchase30 + num_purchase90 + num_purchase180 + num_purchase12 + num_purchase24 + num_purchase36 + num_purchase60 + num_sold30 + num_sold90 +
num_sold180 + num_sold12 + num_sold24 + num_sold36 + num_sold60 + unverified_addr_count;
/*******************************************************************************************************************************************/
//Available_Sources
/*******************************************************************************************************************************************/	
	DL := Scoring_Project.MACRO_distinct_values(pj, 'DL', 'Available_Sources');
Voter := Scoring_Project.MACRO_distinct_values(pj, 'Voter', 'Available_Sources');
	
Available_Sources := DL + voter; 
/*******************************************************************************************************************************************/
//Source_Verification
/*******************************************************************************************************************************************/	
	
num_nonderogs60 := Scoring_Project.MACRO_distinct_values(pj, 'num_nonderogs60', 'Source_Verification');
num_nonderogs36 := Scoring_Project.MACRO_distinct_values(pj, 'num_nonderogs36', 'Source_Verification');
num_nonderogs24 := Scoring_Project.MACRO_distinct_values(pj, 'num_nonderogs24', 'Source_Verification');
num_nonderogs12 := Scoring_Project.MACRO_distinct_values(pj, 'num_nonderogs12', 'Source_Verification');
num_nonderogs180 := Scoring_Project.MACRO_distinct_values(pj, 'num_nonderogs180', 'Source_Verification');
num_nonderogs90 := Scoring_Project.MACRO_distinct_values(pj, 'num_nonderogs90', 'Source_Verification');
num_nonderogs30 := Scoring_Project.MACRO_distinct_values(pj, 'num_nonderogs30', 'Source_Verification');
// num_nonderogs := Scoring_Project.MACRO_distinct_values(pj, 'num_nonderogs', 'Source_Verification');
r3 := record
string100 field_name := 'num_nonderogs';
	string100 category := 'Source_Verification';
  string30 distribution_type := 'RANGE';
  string50 attribute_value := MAP((integer)pj.num_nonderogs  = 00  => '00',
																	(integer)pj.num_nonderogs  between 01  and 04  => '01 to 04',
																	(integer)pj.num_nonderogs  = 05  => '05',
																	(integer)pj.num_nonderogs  = 06  => '06',
																	(integer)pj.num_nonderogs  = 07  => '07',
																	(integer)pj.num_nonderogs  = 08  => '08',
																	(integer)pj.num_nonderogs  = 09  => '09',
																	(integer)pj.num_nonderogs  = 10  => '10',
																	(integer)pj.num_nonderogs  = 11  => '11',
																	(integer)pj.num_nonderogs  = 12  => '12',
																	(integer)pj.num_nonderogs  >= 13  => '> 12',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;


num_nonderogs := table(pj,r3,MAP((integer)pj.num_nonderogs  = 00  => '00',
																	(integer)pj.num_nonderogs  between 01  and 04  => '01 to 04',
																	(integer)pj.num_nonderogs  = 05  => '05',
																	(integer)pj.num_nonderogs  = 06  => '06',
																	(integer)pj.num_nonderogs  = 07  => '07',
																	(integer)pj.num_nonderogs  = 08  => '08',
																	(integer)pj.num_nonderogs  = 09  => '09',
																	(integer)pj.num_nonderogs  = 10  => '10',
																	(integer)pj.num_nonderogs  = 11  => '11',
																	(integer)pj.num_nonderogs  = 12  => '12',
																	(integer)pj.num_nonderogs  >= 13  => '> 12',
																	'UNDEFINED'));
em_only_sources := Scoring_Project.MACRO_Parsing_Text(pj, 'em_only_sources', 'Source_Verification');
socssources := Scoring_Project.MACRO_Parsing_Text(pj, 'socssources', 'Source_Verification');// parsed these fields as per Nathan's request
addrsources := Scoring_Project.MACRO_Parsing_Text(pj, 'addrsources', 'Source_Verification');
lastnamesources := Scoring_Project.MACRO_Parsing_Text(pj, 'lastnamesources', 'Source_Verification');
firstnamesources := Scoring_Project.MACRO_Parsing_Text(pj, 'firstnamesources', 'Source_Verification');

//as the below listed are all 6 digit fields yyyymm, we are determing how many months old is the date...last parameter in the macro is the offset
adl_W_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_W_last_seen', 'Source_Verification', 1);						//Date fields
adl_EM_only_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_EM_only_last_seen', 'Source_Verification', 1);	
adl_VO_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_VO_last_seen', 'Source_Verification', 1);	
adl_EM_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_EM_last_seen', 'Source_Verification', 1);	
adl_V_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_V_last_seen', 'Source_Verification', 1);	
adl_PR_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_PR_last_seen', 'Source_Verification', 1);	
adl_DL_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_DL_last_seen', 'Source_Verification', 1);	
adl_TU_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_TU_last_seen', 'Source_Verification', 1);	
adl_en_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_en_last_seen', 'Source_Verification', 1);	
adl_EQfs_last_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_EQfs_last_seen', 'Source_Verification', 1);	
adl_W_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_W_first_seen', 'Source_Verification', 1);	
adl_EM_only_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_EM_only_first_seen', 'Source_Verification', 1);	//date fields
adl_VO_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_VO_first_seen', 'Source_Verification', 1);	
adl_EM_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_EM_first_seen', 'Source_Verification', 1);	
adl_V_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_V_first_seen', 'Source_Verification', 1);	
adl_PR_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_PR_first_seen', 'Source_Verification', 1);	
adl_DL_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_DL_first_seen', 'Source_Verification', 1);	
adl_TU_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_TU_first_seen', 'Source_Verification', 1);	
adl_en_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_en_first_seen', 'Source_Verification', 1);	
adl_EQfs_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'adl_EQfs_first_seen', 'Source_Verification', 1);

EM_only_count := Scoring_Project.MACRO_distinct_values(pj, 'EM_only_count', 'Source_Verification');
W_count := Scoring_Project.MACRO_distinct_values(pj, 'W_count', 'Source_Verification');
VO_count := Scoring_Project.MACRO_distinct_values(pj, 'VO_count', 'Source_Verification');
EM_count := Scoring_Project.MACRO_distinct_values(pj, 'EM_count', 'Source_Verification');
V_count := Scoring_Project.MACRO_distinct_values(pj, 'V_count', 'Source_Verification');
PR_count := Scoring_Project.MACRO_distinct_values(pj, 'PR_count', 'Source_Verification');
DL_count := Scoring_Project.MACRO_distinct_values(pj, 'DL_count', 'Source_Verification');

EQ_count := Scoring_Project.MACRO_Range_10(pj, 'EQ_count', 'Source_Verification');
EN_count := Scoring_Project.MACRO_Range_10(pj, 'EN_count', 'Source_Verification');
TU_count := Scoring_Project.MACRO_Range_10(pj, 'TU_count', 'Source_Verification');

Source_Verification := EQ_count + EN_count + TU_count + DL_count + PR_count + V_count + em_count + vo_count + w_count + em_only_count + adl_EQfs_first_seen +
adl_en_first_seen + adl_TU_first_seen +  adl_DL_first_seen + adl_PR_first_seen + adl_V_first_seen + adl_EM_first_seen + adl_VO_first_seen + adl_EM_only_first_seen +
adl_W_first_seen + adl_EQfs_last_seen + adl_en_last_seen + adl_TU_last_seen + adl_DL_last_seen + adl_PR_last_seen + adl_V_last_seen + adl_EM_last_seen +
adl_VO_last_seen + adl_EM_only_last_seen + adl_W_last_seen + firstnamesources + lastnamesources + addrsources + socssources + em_only_sources + num_nonderogs +
num_nonderogs30 + num_nonderogs90 + num_nonderogs180 + num_nonderogs12 + num_nonderogs24 + num_nonderogs36 + num_nonderogs60;
/*******************************************************************************************************************************************/
//Address_Validation
/*******************************************************************************************************************************************/	


USPS_Deliverable := Scoring_Project.MACRO_distinct_values(pj, 'USPS_Deliverable', 'Address_Validation');
Dwelling_Type := Scoring_Project.MACRO_distinct_values(pj, 'Dwelling_Type', 'Address_Validation');
Zip_Type := Scoring_Project.MACRO_distinct_values(pj, 'Zip_Type', 'Address_Validation');
HR_Address := Scoring_Project.MACRO_distinct_values(pj, 'HR_Address', 'Address_Validation');
HR_Company := Scoring_Project.MACRO_distinct_values(pj, 'HR_Company', 'Address_Validation');
Error_Codes := Scoring_Project.MACRO_distinct_values(pj, 'Error_Codes', 'Address_Validation');//tricky field...has many error codes
ADDRESS_Validation_Corrections := Scoring_Project.MACRO_distinct_values(pj, 'ADDRESS_Validation_Corrections', 'Address_Validation');

Address_Validation := USPS_Deliverable + Dwelling_Type + Zip_Type + HR_Address + HR_Company + Error_Codes + ADDRESS_Validation_Corrections;
/*******************************************************************************************************************************************/
//rv_scores
/*******************************************************************************************************************************************/	
prescreenV4 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'prescreenV4', 'rv_scores');
reason5mV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason5mV4', 'rv_scores');
reason4mV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason4mV4', 'rv_scores');
reason3mV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason3mV4', 'rv_scores');
reason2mV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason2mV4', 'rv_scores');
reason1mV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason1mV4', 'rv_scores');
msbV4 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'msbV4', 'rv_scores');
reason5tV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason5tV4', 'rv_scores');
reason4tV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason4tV4', 'rv_scores');
reason3tV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason3tV4', 'rv_scores');
reason2tV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason2tV4', 'rv_scores');
reason1tV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason1tV4', 'rv_scores'); //ALL THESE ARE POPULATED AS BLANKS AS ON Feb 24, 2014
telecomV4 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'telecomV4', 'rv_scores');
reason5aV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason5aV4', 'rv_scores');
reason4aV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason4aV4', 'rv_scores');
reason3aV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason3aV4', 'rv_scores');
reason2aV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason2aV4', 'rv_scores');
reason1aV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason1aV4', 'rv_scores');
autoV4  :=    Scoring_Project.MACRO_Get_Score_Bin(pj, 'autoV4', 'rv_scores');
reason5rV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason5rV4', 'rv_scores');
reason4rV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason4rV4', 'rv_scores');
reason3rV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason3rV4', 'rv_scores');
reason2rV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason2rV4', 'rv_scores');
reason1rV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason1rV4', 'rv_scores');
retailV4 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'retailV4', 'rv_scores');
reason5bV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason5bV4', 'rv_scores');
reason4bV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason4bV4', 'rv_scores');
reason3bV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason3bV4', 'rv_scores');
reason2bV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason2bV4', 'rv_scores');
reason1bV4 := Scoring_Project.MACRO_distinct_values(pj, 'reason1bV4', 'rv_scores');
bankcardV4 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'bankcardV4', 'rv_scores');
prescreenV3 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'prescreenV3', 'rv_scores');
reason4mV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason4mV3', 'rv_scores');
reason3mV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason3mV3', 'rv_scores');
reason2mV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason2mV3', 'rv_scores');
reason1mV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason1mV3', 'rv_scores');
msbV3 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'msbV3', 'rv_scores');
reason4tV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason4tV3', 'rv_scores');
reason3tV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason3tV3', 'rv_scores');
reason2tV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason2tV3', 'rv_scores');
reason1tV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason1tV3', 'rv_scores'); //ALL THESE ARE POPULATED AS BLANKS AS ON Feb 24, 2014
telecomV3 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'telecomV3', 'rv_scores');
reason4aV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason4aV3', 'rv_scores');
reason3aV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason3aV3', 'rv_scores');
reason2aV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason2aV3', 'rv_scores');
reason1aV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason1aV3', 'rv_scores');
autoV3 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'autoV3', 'rv_scores');
reason4rV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason4rV3', 'rv_scores');
reason3rV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason3rV3', 'rv_scores');
reason2rV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason2rV3', 'rv_scores');
reason1rV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason1rV3', 'rv_scores');
retailV3 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'retailV3', 'rv_scores');
reason4bV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason4bV3', 'rv_scores');
reason3bV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason3bV3', 'rv_scores');
reason2bV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason2bV3', 'rv_scores');
reason1bV3 := Scoring_Project.MACRO_distinct_values(pj, 'reason1bV3', 'rv_scores');
bankcardV3 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'bankcardV3', 'rv_scores');
reason4V2 := Scoring_Project.MACRO_distinct_values(pj, 'reason4V2', 'rv_scores');
reason3V2 := Scoring_Project.MACRO_distinct_values(pj, 'reason3V2', 'rv_scores');
reason2V2 := Scoring_Project.MACRO_distinct_values(pj, 'reason2V2', 'rv_scores');
reason1V2 := Scoring_Project.MACRO_distinct_values(pj, 'reason1V2', 'rv_scores');
prescreenV2 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'prescreenV2', 'rv_scores'); //ALL THESE ARE POPULATED AS BLANKS AS ON Feb 24, 2014
msbV2 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'msbV2', 'rv_scores');
telecomV2 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'telecomV2', 'rv_scores');
autoV2 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'autoV2', 'rv_scores');
retailV2 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'retailV2', 'rv_scores');
bankcardV2 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'bankcardV2', 'rv_scores');
rv_reason4 := Scoring_Project.MACRO_distinct_values(pj, 'rv_reason4', 'rv_scores');//added rv_ to the field names as the same fields are repated in iid and fd_Scores
rv_reason3 := Scoring_Project.MACRO_distinct_values(pj, 'rv_reason3', 'rv_scores');//added rv_ to the field names as the same fields are repated in iid and fd_Scores
rv_reason2 := Scoring_Project.MACRO_distinct_values(pj, 'rv_reason2', 'rv_scores');//added rv_ to the field names as the same fields are repated in iid and fd_Scores
rv_reason1 := Scoring_Project.MACRO_distinct_values(pj, 'rv_reason1', 'rv_scores');//added rv_ to the field names as the same fields are repated in iid and fd_Scores
telecom := Scoring_Project.MACRO_Get_Score_Bin(pj, 'telecom', 'rv_scores');
auto := Scoring_Project.MACRO_Get_Score_Bin(pj, 'auto', 'rv_scores');
retail := Scoring_Project.MACRO_Get_Score_Bin(pj, 'retail', 'rv_scores');
bankcard := Scoring_Project.MACRO_Get_Score_Bin(pj, 'bankcard', 'rv_scores');

rv_scores := prescreenV4 + reason5mV4 + reason4mV4 + reason3mV4 + reason2mV4 + reason1mV4 + msbV4 + reason5tV4 + reason4tV4 + reason3tV4 + reason2tV4 + reason1tV4 +
telecomV4 + reason5aV4 + reason4aV4 + reason3aV4 + reason2aV4 + reason1aV4 + autoV4 + reason5rV4 + reason4rV4 + reason3rV4 + reason2rV4 + reason1rV4 + retailV4 +
reason5bV4 + reason4bV4 + reason3bV4 + reason2bV4 + reason1bV4 + bankcardV4 + prescreenV3 + reason4mV3 + reason3mV3 + reason2mV3 + reason1mV3 + msbV3 + reason4tV3 +
reason3tV3 + reason2tV3 + reason1tV3 + telecomV3 + reason4aV3 + reason3aV3 + reason2aV3 + reason1aV3 + autoV3 + reason4rV3 + reason3rV3 + reason2rV3 + reason1rV3 +
retailV3 + reason4bV3 + reason3bV3 + reason2bV3 + reason1bV3 + bankcardV3 + reason4V2 + reason3V2 + reason2V2 + reason1V2 + prescreenV2 + msbV2 + telecomV2 +
autoV2 + retailV2 + bankcardV2 + rv_reason4 + rv_reason3 + rv_reason2 + rv_reason1 + telecom + auto + retail + bankcard;
/*******************************************************************************************************************************************/
//fd_scores
/*******************************************************************************************************************************************/	
fraudpoint_V3 := Scoring_Project.MACRO_distinct_values(pj, 'fraudpoint_V3', 'fd_scores');
StolenIdentityIndex_V3 := Scoring_Project.MACRO_distinct_values(pj, 'StolenIdentityIndex_V3', 'fd_scores');
SyntheticIdentityIndex_V3 := Scoring_Project.MACRO_distinct_values(pj, 'SyntheticIdentityIndex_V3', 'fd_scores');   //ALL THESE ARE POPULATED AS BLANKS AS ON Feb 24, 2014
ManipulatedIdentityIndex_V3 := Scoring_Project.MACRO_distinct_values(pj, 'ManipulatedIdentityIndex_V3', 'fd_scores');
VulnerableVictimIndex_V3 := Scoring_Project.MACRO_distinct_values(pj, 'VulnerableVictimIndex_V3', 'fd_scores');
FriendlyFraudIndex_V3 := Scoring_Project.MACRO_distinct_values(pj, 'FriendlyFraudIndex_V3', 'fd_scores');
SuspiciousActivityIndex_V3 := Scoring_Project.MACRO_distinct_values(pj, 'SuspiciousActivityIndex_V3', 'fd_scores');
reason1FP_V3 := Scoring_Project.MACRO_distinct_values(pj, 'reason1FP_V3', 'fd_scores');
reason2FP_V3 := Scoring_Project.MACRO_distinct_values(pj, 'reason2FP_V3', 'fd_scores');
reason3FP_V3 := Scoring_Project.MACRO_distinct_values(pj, 'reason3FP_V3', 'fd_scores');
reason4FP_V3 := Scoring_Project.MACRO_distinct_values(pj, 'reason4FP_V3', 'fd_scores');
reason5FP_V3 := Scoring_Project.MACRO_distinct_values(pj, 'reason5FP_V3', 'fd_scores');
reason6FP_V3 := Scoring_Project.MACRO_distinct_values(pj, 'reason6FP_V3', 'fd_scores');
StolenIdentityIndex := Scoring_Project.MACRO_distinct_values(pj, 'StolenIdentityIndex', 'fd_scores');
SyntheticIdentityIndex := Scoring_Project.MACRO_distinct_values(pj, 'SyntheticIdentityIndex', 'fd_scores');

ManipulatedIdentityIndex := Scoring_Project.MACRO_distinct_values(pj, 'ManipulatedIdentityIndex', 'fd_scores'); //  THESE fields have some values
VulnerableVictimIndex := Scoring_Project.MACRO_distinct_values(pj, 'VulnerableVictimIndex', 'fd_scores');
FriendlyFraudIndex := Scoring_Project.MACRO_distinct_values(pj, 'FriendlyFraudIndex', 'fd_scores');
SuspiciousActivityIndex := Scoring_Project.MACRO_distinct_values(pj, 'SuspiciousActivityIndex', 'fd_scores');
reason1FPV2 := Scoring_Project.MACRO_distinct_values(pj, 'reason1FPV2', 'fd_scores');
reason2FPV2 := Scoring_Project.MACRO_distinct_values(pj, 'reason2FPV2', 'fd_scores');
reason3FPV2 := Scoring_Project.MACRO_distinct_values(pj, 'reason3FPV2', 'fd_scores');
reason4FPV2 := Scoring_Project.MACRO_distinct_values(pj, 'reason4FPV2', 'fd_scores');
reason5FPV2 := Scoring_Project.MACRO_distinct_values(pj, 'reason5FPV2', 'fd_scores');
reason6FPV2 := Scoring_Project.MACRO_distinct_values(pj, 'reason6FPV2', 'fd_scores');
reason1FP := Scoring_Project.MACRO_distinct_values(pj, 'reason1FP', 'fd_scores');
reason2FP := Scoring_Project.MACRO_distinct_values(pj, 'reason2FP', 'fd_scores');
reason3FP := Scoring_Project.MACRO_distinct_values(pj, 'reason3FP', 'fd_scores');
reason4FP := Scoring_Project.MACRO_distinct_values(pj, 'reason4FP', 'fd_scores');
reason5FP := Scoring_Project.MACRO_distinct_values(pj, 'reason5FP', 'fd_scores');
reason6FP := Scoring_Project.MACRO_distinct_values(pj, 'reason6FP', 'fd_scores');
fd_reason1 := Scoring_Project.MACRO_distinct_values(pj, 'fd_reason1', 'fd_scores');//added fd_ to the field names as the same fields are repated in iid and fd_Scores
fd_reason2 := Scoring_Project.MACRO_distinct_values(pj, 'fd_reason2', 'fd_scores');//added fd_ to the field names as the same fields are repated in iid and fd_Scores
fd_reason3 := Scoring_Project.MACRO_distinct_values(pj, 'fd_reason3', 'fd_scores');//added fd_ to the field names as the same fields are repated in iid and fd_Scores
fd_reason4 := Scoring_Project.MACRO_distinct_values(pj, 'fd_reason4', 'fd_scores');//added fd_ to the field names as the same fields are repated in iid and fd_Scores
fraudpointV2 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'fraudpointV2', 'fd_scores');
fraudpoint := Scoring_Project.MACRO_Get_Score_Bin(pj, 'fraudpoint', 'fd_scores');
fd6 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'fd6', 'fd_scores');
fd3 := Scoring_Project.MACRO_Get_Score_Bin(pj, 'fd3', 'fd_scores');

fd_scores := fd3 + fd6 + fraudpoint + fraudpointV2 + fd_reason4 + fd_reason3 + fd_reason2 + fd_reason1 + reason6FP + reason5FP + reason4FP + reason3FP + reason2FP +
reason1FP + reason6FPV2 + reason5FPV2 + reason4FPV2 + reason3FPV2 + reason2FPV2 + reason1FPV2 + SuspiciousActivityIndex + FriendlyFraudIndex + VulnerableVictimIndex +
ManipulatedIdentityIndex + SyntheticIdentityIndex + StolenIdentityIndex + reason6FP_V3 + reason5FP_V3 + reason4FP_V3 + reason3FP_V3 + reason2FP_V3 + reason1FP_V3 +
reason1FP_V3 + SuspiciousActivityIndex_V3 + FriendlyFraudIndex_V3 + VulnerableVictimIndex_V3 + ManipulatedIdentityIndex_V3 + SyntheticIdentityIndex_V3 +  
StolenIdentityIndex_V3 + fraudpoint_V3 ;
/*******************************************************************************************************************************************/
//Input_Validation
/*******************************************************************************************************************************************/	
FirstName := Scoring_Project.MACRO_distinct_values(pj, 'FirstName', 'Input_Validation');
LastName := Scoring_Project.MACRO_distinct_values(pj, 'LastName','Input_Validation');
Address := Scoring_Project.MACRO_distinct_values(pj, 'Address','Input_Validation');
SSN := Scoring_Project.MACRO_distinct_values(pj, 'SSN','Input_Validation');
SSN_Length := Scoring_Project.MACRO_distinct_values(pj, 'SSN_Length','Input_Validation');
DateOfBirth := Scoring_Project.MACRO_distinct_values(pj, 'DateOfBirth','Input_Validation');
Email := Scoring_Project.MACRO_distinct_values(pj, 'Email','Input_Validation');
IPAddress := Scoring_Project.MACRO_distinct_values(pj, 'IPAddress','Input_Validation');
HomePhone := Scoring_Project.MACRO_distinct_values(pj, 'HomePhone','Input_Validation');
WorkPhone := Scoring_Project.MACRO_distinct_values(pj, 'WorkPhone','Input_Validation');

Input_Validation := FirstName + LastName + Address + SSN + SSN_Length + DateOfBirth + Email + IPAddress + HomePhone + WorkPhone;

/*******************************************************************************************************************************************/
//new fields where values are set to ' '.......code needs to be modified later once the values are populated
/*******************************************************************************************************************************************/
//inquiryVerification
/*******************************************************************************************************************************************/
InquiryNAPfnameScore := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPfnameScore', 'inquiryVerification');
InquiryNAPlnameScore := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPlnameScore', 'inquiryVerification');
InquiryNAPssnScore := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPssnScore', 'inquiryVerification');
InquiryNAPdobScore := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPdobScore', 'inquiryVerification');
InquiryNAPphoneScore := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPphoneScore', 'inquiryVerification');
InquiryNAPaddrScore := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPaddrScore', 'inquiryVerification');
InquiryNAPphone := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPphone', 'inquiryVerification');
InquiryNAPdob := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPdob', 'inquiryVerification');
InquiryNAPlname := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPlname', 'inquiryVerification');
InquiryNAPfname := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPfname', 'inquiryVerification');
InquiryNAPssn := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPssn', 'inquiryVerification');
InquiryNAPz5 := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPz5', 'inquiryVerification');
InquiryNAPst := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPst', 'inquiryVerification');
InquiryNAPcity := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPcity', 'inquiryVerification');
InquiryNAPsec_range := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPsec_range', 'inquiryVerification');
InquiryNAPunit_desig := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPunit_desig', 'inquiryVerification');
InquiryNAPpostdir := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPpostdir', 'inquiryVerification');
InquiryNAPsuffix := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPsuffix', 'inquiryVerification');
InquiryNAPprim_name := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPprim_name', 'inquiryVerification');
InquiryNAPpredir := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPpredir', 'inquiryVerification');
InquiryNAPprim_range := Scoring_Project.MACRO_distinct_values(pj, 'InquiryNAPprim_range', 'inquiryVerification');
inquiryNAPdobcount := Scoring_Project.MACRO_distinct_values(pj, 'inquiryNAPdobcount', 'inquiryVerification');
inquiryNAPssncount := Scoring_Project.MACRO_distinct_values(pj, 'inquiryNAPssncount', 'inquiryVerification');
inquiryNAPphonecount := Scoring_Project.MACRO_distinct_values(pj, 'inquiryNAPphonecount', 'inquiryVerification');
inquiryNAPaddrcount := Scoring_Project.MACRO_distinct_values(pj, 'inquiryNAPaddrcount', 'inquiryVerification');
inquiryNAPlastcount := Scoring_Project.MACRO_distinct_values(pj, 'inquiryNAPlastcount', 'inquiryVerification');
inquiryNAPfirstcount := Scoring_Project.MACRO_distinct_values(pj, 'inquiryNAPfirstcount', 'inquiryVerification');

inquiryVerification := inquiryNAPfirstcount + inquiryNAPlastcount + inquiryNAPaddrcount + inquiryNAPphonecount + inquiryNAPssncount + inquiryNAPdobcount +
InquiryNAPprim_range + InquiryNAPpredir + InquiryNAPprim_name + InquiryNAPsuffix + InquiryNAPpostdir + InquiryNAPunit_desig + InquiryNAPsec_range + InquiryNAPcity +
InquiryNAPst + InquiryNAPz5 + InquiryNAPssn + InquiryNAPfname + InquiryNAPlname + InquiryNAPdob + InquiryNAPphone +  InquiryNAPaddrScore + InquiryNAPphoneScore +
InquiryNAPdobScore + InquiryNAPssnScore + InquiryNAPlnameScore + InquiryNAPfnameScore;

/*******************************************************************************************************************************************/
//Virtual_Fraud
/*******************************************************************************************************************************************/
//new fields where values are set to ' '.......code needs to be modified later once the values are populated
/*******************************************************************************************************************************************/

hi_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'hi_risk_ct', 'Virtual_Fraud'); // new for Riskview 5.0
lo_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'lo_risk_ct', 'Virtual_Fraud');// new for Riskview 5.0
LexID_phone_hi_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'LexID_phone_hi_risk_ct', 'Virtual_Fraud'); // new for Riskview 5.0
LexID_phone_lo_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'LexID_phone_lo_risk_ct', 'Virtual_Fraud'); // new for Riskview 5.0
AltLexID_Phone_hi_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'AltLexID_Phone_hi_risk_ct', 'Virtual_Fraud'); // new for Riskview 5.0
AltLexID_Phone_lo_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'AltLexID_Phone_lo_risk_ct', 'Virtual_Fraud'); // new for Riskview 5.0
LexID_addr_hi_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'LexID_addr_hi_risk_ct', 'Virtual_Fraud'); // new for Riskview 5.0
LexID_addr_lo_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'LexID_addr_lo_risk_ct', 'Virtual_Fraud'); // new for Riskview 5.0
AltLexID_addr_hi_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'AltLexID_addr_hi_risk_ct', 'Virtual_Fraud'); // new for Riskview 5.0
AltLexID_addr_lo_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'AltLexID_addr_lo_risk_ct', 'Virtual_Fraud'); // new for Riskview 5.0
LexID_ssn_hi_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'LexID_ssn_hi_risk_ct', 'Virtual_Fraud');// new for Riskview 5.0
LexID_ssn_lo_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'LexID_ssn_lo_risk_ct', 'Virtual_Fraud');// new for Riskview 5.0
AltLexID_ssn_hi_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'AltLexID_ssn_hi_risk_ct', 'Virtual_Fraud');// new for Riskview 5.0
AltLexID_ssn_lo_risk_ct := Scoring_Project.MACRO_distinct_values(pj, 'AltLexID_ssn_lo_risk_ct', 'Virtual_Fraud'); // new for Riskview 5.0

Virtual_Fraud := hi_risk_ct + lo_risk_ct + LexID_phone_hi_risk_ct + LexID_phone_lo_risk_ct + AltLexID_Phone_hi_risk_ct + AltLexID_Phone_lo_risk_ct + 
LexID_addr_hi_risk_ct + LexID_addr_lo_risk_ct + AltLexID_addr_hi_risk_ct + AltLexID_addr_lo_risk_ct + LexID_ssn_hi_risk_ct + LexID_ssn_lo_risk_ct +
AltLexID_ssn_hi_risk_ct + AltLexID_ssn_lo_risk_ct ;


/*******************************************************************************************************************************************/
//Phone_Verification
/*******************************************************************************************************************************************/
phone_score := Scoring_Project.MACRO_distinct_values(pj, 'phone_score', 'Phone_Verification');
phone_sources := Scoring_Project.MACRO_distinct_values(pj, 'phone_sources', 'Phone_Verification');
telcordia_type := Scoring_Project.MACRO_distinct_values(pj, 'telcordia_type', 'Phone_Verification');
phone_zip_mismatch := Scoring_Project.MACRO_distinct_values(pj, 'phone_zip_mismatch', 'Phone_Verification');
distance := Scoring_Project.MACRO_distinct_values(pj, 'distance', 'Phone_Verification');
disconnected := Scoring_Project.MACRO_distinct_values(pj, 'disconnected', 'Phone_Verification');
recent_disconnects := Scoring_Project.MACRO_Range_10(pj, 'recent_disconnects', 'Phone_Verification');
HR_Phone := Scoring_Project.MACRO_distinct_values(pj, 'HR_Phone', 'Phone_Verification');
Corrections := Scoring_Project.MACRO_distinct_values(pj, 'Corrections', 'Phone_Verification');
gong_adl_dt_last_seen_full := Scoring_Project.Macro_Dates_Within_30(pj, 'gong_adl_dt_last_seen_full', 'Phone_Verification', 30);
gong_did_addr_ct := Scoring_Project.MACRO_distinct_values(pj, 'gong_did_addr_ct', 'Phone_Verification');//waiting for Nathan's response
gong_did_phone_ct := Scoring_Project.MACRO_Range_1_2_3(pj, 'gong_did_phone_ct', 'Phone_Verification');//waiting for Nathan's response
gong_did_first_ct := Scoring_Project.MACRO_distinct_values(pj, 'gong_did_first_ct', 'Phone_Verification');
gong_did_last_ct := Scoring_Project.MACRO_distinct_values(pj, 'gong_did_last_ct', 'Phone_Verification');
gong_adl_dt_first_seen_full := Scoring_Project.Macro_Dates_Within_30(pj, 'gong_adl_dt_first_seen_full', 'Phone_Verification', 30);

Phone_Verification := phone_score + phone_sources + telcordia_type + phone_zip_mismatch + distance + disconnected + recent_disconnects + HR_Phone +
Corrections + gong_adl_dt_last_seen_full + gong_did_addr_ct + gong_did_phone_ct + gong_did_first_ct + gong_did_last_ct + gong_adl_dt_first_seen_full;

/*******************************************************************************************************************************************/
//Name_Verification
/*******************************************************************************************************************************************/
fname_credit_sourced := Scoring_Project.MACRO_distinct_values(pj, 'fname_credit_sourced', 'Name_Verification');
lname_credit_sourced := Scoring_Project.MACRO_distinct_values(pj, 'lname_credit_sourced', 'Name_Verification');
fname_tu_sourced := Scoring_Project.MACRO_distinct_values(pj, 'fname_tu_sourced', 'Name_Verification');
lname_tu_sourced := Scoring_Project.MACRO_distinct_values(pj, 'lname_tu_sourced', 'Name_Verification');
fname_eda_sourced := Scoring_Project.MACRO_distinct_values(pj, 'fname_eda_sourced', 'Name_Verification');
lname_eda_sourced := Scoring_Project.MACRO_distinct_values(pj, 'lname_eda_sourced', 'Name_Verification');
fname_eda_sourced_type := Scoring_Project.MACRO_distinct_values(pj, 'fname_eda_sourced_type', 'Name_Verification');
lname_eda_sourced_type := Scoring_Project.MACRO_distinct_values(pj, 'lname_eda_sourced_type', 'Name_Verification');
fname_dl_sourced := Scoring_Project.MACRO_distinct_values(pj, 'fname_dl_sourced', 'Name_Verification');
lname_dl_sourced := Scoring_Project.MACRO_distinct_values(pj, 'lname_dl_sourced', 'Name_Verification');
fname_voter_sourced := Scoring_Project.MACRO_distinct_values(pj, 'fname_voter_sourced', 'Name_Verification');
lname_voter_sourced := Scoring_Project.MACRO_distinct_values(pj, 'lname_voter_sourced', 'Name_Verification');
fname_utility_sourced := Scoring_Project.MACRO_distinct_values(pj, 'fname_utility_sourced', 'Name_Verification');
lname_utility_sourced := Scoring_Project.MACRO_distinct_values(pj, 'lname_utility_sourced', 'Name_Verification');
age := Scoring_Project.MACRO_Inferred_Age(pj, 'age','Name_Verification');
source_count := Scoring_Project.MACRO_Range_10(pj, 'source_count','Name_Verification');
fname_score := Scoring_Project.MACRO_Range_50(pj, 'fname_score','Name_Verification');
lname_score := Scoring_Project.MACRO_Range_50(pj, 'lname_score','Name_Verification');
adl_score := Scoring_Project.MACRO_Range_50(pj, 'adl_score','Name_Verification');
dob_score := Scoring_Project.MACRO_Range_50(pj, 'dob_score','Name_Verification');
newest_lname_dt_first_seen := Scoring_Project.Macro_MonthsApart(pj, 'newest_lname_dt_first_seen','Name_Verification', 1);
lname_change_date := Scoring_Project.Macro_MonthsApart(pj, 'lname_change_date','Name_Verification', 1);
lname_prev_change_date := Scoring_Project.Macro_MonthsApart(pj, 'lname_prev_change_date','Name_Verification', 1);
newest_lname := Scoring_Project.MACRO_Length(pj, 'newest_lname','Name_Verification');

Name_Verification := fname_credit_sourced + lname_credit_sourced + fname_tu_sourced + lname_tu_sourced + fname_eda_sourced + lname_eda_sourced +
fname_eda_sourced_type + lname_eda_sourced_type + fname_dl_sourced + lname_dl_sourced + fname_voter_sourced + lname_voter_sourced + fname_utility_sourced +
lname_utility_sourced + age + source_count + fname_score + lname_score + adl_score + dob_score + newest_lname_dt_first_seen + lname_change_date + 
lname_prev_change_date + newest_lname;

/******************************************************************************************************************************************************/
//Utility
/*******************************************************************************************************************************************************/

utili_adl_count := Scoring_Project.MACRO_distinct_values(pj, 'utili_adl_count', 'Utility');
utili_adl_nap := Scoring_Project.MACRO_distinct_values(pj, 'utili_adl_nap', 'Utility');
utili_adl_type := Scoring_Project.MACRO_distinct_values(pj, 'utili_adl_type', 'Utility');
utili_addr1_nap := Scoring_Project.MACRO_distinct_values(pj, 'utili_addr1_nap', 'Utility');
utili_addr2_nap := Scoring_Project.MACRO_distinct_values(pj, 'utili_addr2_nap', 'Utility');
utili_addr1_type := Scoring_Project.MACRO_distinct_values(pj, 'utili_addr1_type', 'Utility');
utili_addr2_type := Scoring_Project.MACRO_distinct_values(pj, 'utili_addr2_type', 'Utility');
	utili_adl_earliest_dt_first_seen := Scoring_Project.MACRO_Length(pj, 'utili_adl_earliest_dt_first_seen', 'Utility');
	//// utili_adl_dt_first_seen := Scoring_Project.MACRO_Length(pj, 'utili_adl_dt_first_seen', 'Utility');/*******need to talk to Ben(multiple dates for single row)***********/
	//// utili_addr1_dt_first_seen := Scoring_Project.MACRO_Length(pj, 'utili_addr1_dt_first_seen', 'Utility');/*******need to talk to Ben(multiple dates for single row)***********/
	//// utili_addr2_dt_first_seen := Scoring_Project.MACRO_Length(pj, 'utili_addr2_dt_first_seen', 'Utility');/*******need to talk to Ben(multiple dates for single row)***********/

Utility := utili_adl_count + utili_adl_nap + utili_adl_type + utili_addr1_nap + utili_addr2_nap + utili_addr1_type + utili_addr2_type + utili_adl_earliest_dt_first_seen;
/*******************************************************************************************************************************************************/

addr_stability := Scoring_Project.MACRO_distinct_values(pj, 'addr_stability', 'addr_stability');
uspis_hotlist := Scoring_Project.MACRO_distinct_values(pj, 'uspis_hotlist', 'uspis_hotlist');
rhode_island_insufficient_verification := Scoring_Project.MACRO_distinct_values(pj, 'rhode_island_insufficient_verification', 'rhode_island_insufficient_verification');
Experian_Phone_Verification := Scoring_Project.MACRO_distinct_values(pj, 'Experian_Phone_Verification', 'Experian_Phone_Verification');
attended_college := Scoring_Project.MACRO_distinct_values(pj, 'attended_college', 'attended_college');
 source_profile := Scoring_Project.MACRO_Range_10(pj, 'source_profile', 'source_profile');//it has decimal values
 source_profile_index := Scoring_Project.MACRO_distinct_values(pj, 'source_profile_index', 'source_profile_index');
 economic_trajectory := Scoring_Project.MACRO_distinct_values(pj, 'economic_trajectory',  'economic_trajectory');
 economic_trajectory_index := Scoring_Project.MACRO_distinct_values(pj, 'economic_trajectory_index', 'economic_trajectory_index');
 addrsMilitaryEver := Scoring_Project.MACRO_distinct_values(pj, 'addrsMilitaryEver', 'addrsMilitaryEver');

estimated_income := Scoring_Project.MACRO_Range_Estimated_Income(pj, 'estimated_income', 'estimated_income');
inferred_age := Scoring_Project.MACRO_Inferred_Age(pj, 'inferred_age', 'inferred_age');

r4 := record
string100 field_name := 'lres';
	string100 category := 'lres';
  string30 distribution_type := 'RANGE';
  string50 attribute_value := MAP((integer)pj.lres = 0  => '000',
																	(integer)pj.lres between 001 and 100  => '001 to 100',
																	(integer)pj.lres between 101 and 200  => '101 to 200',
																	(integer)pj.lres between 201 and 300  => '201 to 300',
																	(integer)pj.lres between 301 and 400  => '301 to 400',
																	(integer)pj.lres >= 401 => '> 400',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;


lres := table(pj,r4, MAP((integer)pj.lres = 0  => '000',
																	(integer)pj.lres between 001 and 100  => '001 to 100',
																	(integer)pj.lres between 101 and 200  => '101 to 200',
																	(integer)pj.lres between 201 and 300  => '201 to 300',
																	(integer)pj.lres between 301 and 400  => '301 to 400',
																	(integer)pj.lres >= 401 => '> 400',
																	'UNDEFINED'));
																	
																	
lres2 := Scoring_Project.MACRO_Range_100(pj, 'lres2', 'lres2');
lres3 := Scoring_Project.MACRO_Range_100(pj, 'lres3', 'lres3');
did := Scoring_Project.MACRO_Length(pj, 'did', 'did');
reported_dob := Scoring_Project.Macro_Dates_Within_30(pj, 'reported_dob', 'reported_dob', 30);
addrhist1zip4 := Scoring_Project.MACRO_Length(pj, 'addrhist1zip4','addrhist1zip4');
addrhist2zip4 := Scoring_Project.MACRO_Length(pj, 'addrhist2zip4', 'addrhist2zip4');

gong_ADL_dt_first_seen := Scoring_Project.Macro_Dates_Within_30(pj, 'gong_ADL_dt_first_seen','gong_ADL_dt_first_seen', 30);
gong_ADL_dt_last_seen := Scoring_Project.Macro_Dates_Within_30(pj, 'gong_ADL_dt_last_seen','gong_ADL_dt_last_seen', 30);
date_last_derog := Scoring_Project.Macro_Dates_Within_30(pj, 'date_last_derog', 'date_last_derog', 30);
	

truedid := Scoring_Project.MACRO_distinct_values(pj, 'truedid', 'truedid');
 adlcategory := Scoring_Project.MACRO_Length(pj, 'adlcategory', 'adlcategory');
 dobmatchlevel := Scoring_Project.MACRO_distinct_values(pj, 'dobmatchlevel',  'dobmatchlevel');
wealth_indicator := Scoring_Project.MACRO_distinct_values(pj, 'wealth_indicator', 'wealth_indicator');
mobility_indicator := Scoring_Project.MACRO_distinct_values(pj, 'mobility_indicator', 'mobility_indicator');
addrPop := Scoring_Project.MACRO_distinct_values(pj, 'addrPop', 'addrPop');
addrPop2 := Scoring_Project.MACRO_distinct_values(pj, 'addrPop2', 'addrPop2');
addrPop3 := Scoring_Project.MACRO_distinct_values(pj, 'addrPop3', 'addrPop3');
total_number_derogs := Scoring_Project.MACRO_distinct_values(pj, 'total_number_derogs', 'total_number_derogs');

aircraft_build_date := Scoring_Project.MACRO_distinct_values(pj, 'aircraft_build_date', 'aircraft_build_date'); // new for Riskview 5.0
watercraft_build_date := Scoring_Project.MACRO_distinct_values(pj, 'watercraft_build_date', 'watercraft_build_date'); // new for Riskview 5.0
crim_build_date := Scoring_Project.MACRO_distinct_values(pj, 'crim_build_date', 'crim_build_date'); // new for Riskview 5.0
proflic_build_date := Scoring_Project.MACRO_distinct_values(pj, 'proflic_build_date', 'proflic_build_date'); // new for Riskview 5.0
property_build_date := Scoring_Project.MACRO_distinct_values(pj, 'property_build_date','property_build_date'); // new for Riskview 5.0



fields_sum := truedid + 
dob + 
nap_summary + 
bansflag + 
addrcount + 
ver_sources + 
ver_sources_first_seen_date + 
ver_sources_last_seen_date + 
ver_sources_recordcount + 
address + 
ssn_length + 
dateofbirth + 
homephone + 
age + 
input_address_information_isbestmatch + 
lres + 
input_address_information_avm_automated_valuation + 
input_address_information_naprop + 
addrpop + 
owned_property_total + 
distance_in_2_h1 + 
address_history_1_avm_automated_valuation + 
address_history_2_avm_automated_valuation + 
addrs_last_5years + 
addrs_last_10years + 
unique_addr_cnt + 
gong_adl_dt_first_seen_full + 
gong_did_phone_ct + 
ssns_per_adl + 
addrs_per_adl + 
adlperssn_count + 
inquiries_counttotal + 
inquiries_count01 + 
inquiries_count03 + 
inquiries_count06 + 
inquiries_count12 + 
inquiries_count24 + 
number_of_sources + 
average_amount_per_order + 
total_dollars + 
total_number_of_orders + 
offline_dollars + 
online_dollars + 
retail_dollars + 
first_seen_date + 
dead_business_ct + 
business_active_phone_ct + 
infutor_nap + 
imp_count + 
last_seen_date + 
email_domain_free_ct + 
email_source_list + 
eviction_count + 
eviction_count90 + 
eviction_count180 + 
eviction_count12 + 
eviction_count24 + 
eviction_count36 + 
eviction_count60 + 
num_nonderogs + 
bankrupt + 
disposition + 
filing_count + 
bk_recent_count + 
liens_recent_unreleased_count + 
liens_historical_unreleased_count + 
liens_recent_released_count + 
liens_historical_released_count + 
criminal_count + 
felony_count + 
Student_age + 
college_code + 
college_type + 
college_tier + 
wealth_indicator + 
Shell_input_age + 
inferred_age + 
reported_dob + 
estimated_income ;


 res := output(fields_sum,,'~scoring_project::Top50_bocashell_54_FCRA_attributes_stats_' + dateyymmdd_curr, thor, overwrite);
 
 
 return res;

endmacro;