IMPORT BatchShare, BIPV2, CriminalRecords_BatchService, DeathV2_Services, FraudShared, FraudShared_Services, 
			 iesp, patriot, risk_indicators, riskwise, royalty;

EXPORT Layouts := MODULE

	EXPORT Velocities := RECORD
			BatchShare.Layouts.ShareAcct;
			INTEGER foundCnt;
			STRING description;
			DATASET(FraudShared.Layouts_Key.Main) ds_payload;
	END;

	EXPORT KnownFrauds_rec := RECORD
			BatchShare.Layouts.ShareAcct;
			DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) payload;
	END;

	EXPORT BatchOut_risk := RECORD
			unsigned2 risk_score := 0;	// 0 - 100
			string6   risk_level := '';	// High, Medium, Low
			string1   identity_resolved := '';	// Y or N
			unsigned6 LexID := 0;
	END;

	EXPORT combined_layouts := RECORD
			UNSIGNED seq;
			riskwise.layouts.red_flags_online_layout;
			riskwise.layouts.red_flags_batch_layout;
	END;	

  EXPORT BatchOut_rec := RECORD  // This is Final Batch Output.
    UNSIGNED4 seq; 
    BatchShare.Layouts.ShareAcct;              
    BatchOut_risk;
    UNSIGNED4 identity_activities_cnt := 0;
    UNSIGNED2 velocity_exceeded_cnt := 0;
    STRING100 velocity_exceeded_reason1;
    STRING100 velocity_exceeded_reason2;
    STRING100 velocity_exceeded_reason3;
    
		 unsigned4 known_risks_cnt := 0;            
    string100 known_risk_reason1 := '';
    string100 known_risk_reason2 := '';
    string100 known_risk_reason3 := '';
    string100 Known_risk_reason4 := '';
    string100 Known_risk_reason5 := '';				
  END;
	
	EXPORT Layout_InstandID_NuGenExt := record
			risk_indicators.Layout_InstandID_NuGen;
			Royalty.RoyaltyNetAcuity.IPData.Royalty_NAG;
			boolean insurance_dl_used;
	end;

 SHARED Batch_out_pre_rec := RECORD
		BatchOut_risk;    
		BatchShare.Layouts.ShareAcct;
		FraudShared_Services.Layouts.BatchIn_rec batchin_rec;
		DATASET(DeathV2_Services.layouts.BatchOut) childRecs_Death;
		DATASET(CriminalRecords_BatchService.Layouts.batch_out) childRecs_Criminal;
		DATASET(combined_layouts) childRecs_RedFlag;
		DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) childRecs_fdn;
		DATASET(Patriot.layout_batch_out) childRecs_Patriot;
		DATASET(Layout_InstandID_NuGenExt) childRecs_ciid;
		DATASET(Velocities) childRecs_Velocities;
  END;
	
	EXPORT Batch_out_pre_w_raw := RECORD
		Batch_out_pre_rec;
		DATASET(KnownFrauds_rec) childRecs_KnownFrauds_raw;
  END;

	EXPORT red_flag_in := RECORD
			risk_indicators.Layout_Batch_In;
			STRING20 HistoryDateTimeStamp := '';
			STRING6 Gender := '';
			STRING44 PassportUpperLine := '';
			STRING44 PassportLowerLine := '';
			// fields below requested by Deni/Mike to be added for fraudpoint 2.0, even though we do nothing with them
			STRING5 Grade := '';
			STRING16 Channel := '';
			STRING8 Income := '';
			STRING16 OwnOrRent := '';
			STRING16 LocationIdentifier := '';
			STRING16 OtherApplicationIdentifier := '';
			STRING16 OtherApplicationIdentifier2 := '';
			STRING16 OtherApplicationIdentifier3 := '';
			STRING8 DateofApplication := '';
			STRING8 TimeofApplication := '';
			STRING50 email := '';
			STRING64 custom_input1 := '';
			STRING64 custom_input2 := '';
			STRING64 custom_input3 := '';
			STRING64 custom_input4 := '';
			STRING64 custom_input5 := '';
			STRING64 custom_input6 := '';
			STRING64 custom_input7 := '';
			STRING64 custom_input8 := '';
			STRING64 custom_input9 := '';
			STRING64 custom_input10 := '';
			STRING64 custom_input11 := '';
			STRING64 custom_input12 := '';
			STRING64 custom_input13 := '';
			STRING64 custom_input14 := '';
			STRING64 custom_input15 := '';
			STRING64 custom_input16 := '';
			STRING64 custom_input17 := '';
			STRING64 custom_input18 := '';
			STRING64 custom_input19 := '';
			STRING64 custom_input20 := '';
			STRING64 custom_input21 := '';
			STRING64 custom_input22 := '';
			STRING64 custom_input23 := '';
			STRING64 custom_input24 := '';
			STRING64 custom_input25 := '';
			STRING120 UnparsedFullName2;
			STRING30  Name_First2;
			STRING30  Name_Middle2;
			STRING30  Name_Last2;
			STRING5   Name_Suffix2;
			STRING65  Street_Addr2;
			STRING10  Prim_Range2;
			STRING2   Predir2;
			STRING28  Prim_Name2;
			STRING4   Suffix2;
			STRING2   Postdir2;
			STRING10  Unit_Desig2;
			STRING8   Sec_Range2;
			STRING25  p_City_name2;
			STRING2   St2;
			STRING5   Z52;
			STRING10  Home_Phone2;	
	END;

	EXPORT red_flag_desc := RECORD
			STRING5 hri;
			STRING desc;
			INTEGER hri_weight;
	END;

	EXPORT red_flag_desc_w_details := RECORD
			UNSIGNED seq := 0;
			INTEGER category_weight;
			DATASET(red_flag_desc) hri_details;
	END;

	EXPORT red_flag_desc_w_cat_weight := RECORD
			UNSIGNED seq := 0;
			red_flag_desc;
			INTEGER category_weight;
	END;
	
	EXPORT instantId_in := RECORD
	 BatchShare.Layouts.ShareAcct;
	 Risk_Indicators.Layout_Input;
		STRING10 home_phone;
		STRING10 work_phone;
		STRING100 street_addr;
		UNSIGNED3 HistoryDateYYYYMM;
		STRING UnparsedFullName;
		STRING20 name_first;
		STRING20 name_middle;
		STRING20 name_last;
		STRING5  name_suffix;
		STRING25 ip_addr;
		STRING50 email;
		STRING PassportUpperLine;
		STRING PassportLowerLine;
		STRING gender;
	END;

	EXPORT LOG_Deltabase_Layout_Record := Record
		STRING20 gc_id;
		STRING50 cust_transaction_id;
		STRING10 cust_transaction_date;
		STRING20 case_id;
		STRING20 client_uid;
		STRING20 program_name;
		STRING100 inquiry_reason;
		STRING100 inquiry_source;
		STRING3 customer_county_code;
		STRING2 customer_state;
		STRING1 customer_vertical_code;
		STRING10 ssn;
		STRING10 dob;
		UNSIGNED6 lex_id;
		STRING100 name_full;
		STRING50 name_prefix;
		STRING100 name_first;
		STRING60 name_middle;
		STRING100 name_last;
		STRING6 name_suffix;
		STRING200 full_address;
		STRING150 physical_address;
		STRING30 physical_city;
		STRING10 physical_state;
		STRING10 physical_zip;
		STRING3 physical_county;
		STRING15 mailing_address;
		STRING30 mailing_city;
		STRING2 mailing_state;
		STRING5 mailing_zip;
		STRING3 mailing_county;
		STRING10 phone;
		BIPV2.IDlayouts.l_xlink_ids.UltID;
		BIPV2.IDlayouts.l_xlink_ids.OrgID;
		BIPV2.IDlayouts.l_xlink_ids.SeleID;
		STRING10 tin;
		STRING256 email_address;
		UNSIGNED6 appendedproviderid;
		UNSIGNED6 lnpid;
		STRING10 npi;
		STRING25 ip_address;
		STRING50 device_id;
		STRING12 professional_id;
		STRING20 bank_routing_number;
		STRING20 bank_account_number;
		STRING2 dl_state;
		STRING25 dl_number;
		STRING10 geo_lat;
		STRING11 geo_long;
		UNSIGNED8 date_added;
	END;

	EXPORT LOG_Deltabase_Layout := RECORD
		DATASET(LOG_Deltabase_Layout_Record) Records {XPATH('Records/Rec'), MAXCOUNT(1)};
	END;
				
	EXPORT Layout_delta_filter := RECORD
		STRING10 ssn;
		STRING10 dob;
		UNSIGNED6 lex_id;
		STRING100 name_first;
		STRING60 name_middle;
		STRING100 name_last;
		STRING150 physical_address;
		STRING30 physical_city;
		STRING10 physical_state;
		STRING10 physical_zip;
		STRING15 mailing_address;
		STRING30 mailing_city;
		STRING2 mailing_state;
		STRING5 mailing_zip;
		STRING10 phone;
		STRING25 ip_address;
		STRING50 device_id;
		STRING20 bank_account_number;
		STRING2 dl_state;
		STRING25 dl_number;
		STRING10 geo_lat;
		STRING11 geo_long;
		UNSIGNED8 date_added;
	END;
	
	EXPORT response_deltabase_layout := RECORD                         
		DATASET(LOG_Deltabase_Layout_Record) deltaFields {XPATH('Records/Rec')};
		STRING  RecsReturned {XPATH('RecsReturned')};
		INTEGER responsetime {XPATH('Latency')};
	END;	

	EXPORT fragment_w_value_recs := RECORD
		FraudShared_Services.layouts.layout_velocity_in;
		STRING100 fragment_value;
		UNSIGNED3 file_type;
		UNSIGNED4	LastActivityDate := 0;
		UNSIGNED4	LastKnownRiskDate := 0;
	END;
	
	EXPORT elementNidentity_uid_recs := RECORD
		STRING20 acctno;
		STRING60 entity_name;
		STRING100 entity_value;
		UNSIGNED8 record_id;	
		STRING70 tree_uid := '';
		STRING70 entity_context_uid := '';
	END;

	EXPORT elementNidentity_score_recs := RECORD
		fragment_w_value_recs;
		string70 AnalyticsRecordId;
		unsigned1 score;
		string100 ClusterName;
		unsigned1 NumberOfClusters;
		unsigned1 NumberOfIdentities;
		DATASET(iesp.share.t_NameValuePair) NVPs;
	END;

	EXPORT kel_filter_rec := RECORD
			INTEGER gc_id;
			INTEGER ind_type;
			elementNidentity_uid_recs element;
	END;
	
	EXPORT entity_information_recs := RECORD
		STRING60 fragment;
		STRING100 fragment_value;
		iesp.fraudgovsearch.t_FraudGovSearchElementInformation;
	END;	

END;