import riskwise, header, risk_indicators, iesp;

EXPORT Layout_BocaShell_BtSt := MODULE

	export AdditionalInquiryInsights := record
		integer btst_cbd_ids_per_bt_id_ct := -1 ;
		integer btst_cbd_ids_per_st_id_ct  := -1 ;
	end ;

	export AdditionalCommercialInsights := record
		integer btst_bt_bip_addr_ct := -1;
		integer btst_st_bip_addr_ct := -1;
		boolean btst_bt_addr_bip_match := false;
		boolean btst_st_addr_bip_match := false ;
	end ;

	export econ_traj := record
		unsigned4 seq; //bt seq
		string ST_addr_addr_type;
		unsigned ST_Addr_avm_automated_valuation; // le.avm.address_history_1.avm_automated_valuation; //        AVM: Overall Valuation
		unsigned 	ST_Addr_avm_med_fips; // le.avm.address_history_1.avm_median_fips_level; //                   AVM: Median AVM for County
		unsigned 	ST_Addr_avm_med_geo11; // le.avm.address_history_1.avm_median_geo11_level; //                AVM: Median AVM for Census Tract
		unsigned 	ST_Addr_avm_med_geo12; // le.avm.address_history_1.avm_median_geo12_level;  //                  AVM: Median AVM for Census Block
		unsigned 	ST_Addr_market_total_value; // le.address_verification.address_history_1.assessed_amount; //             Address Market Value Amount
		boolean	ST_Addr_pop; // if(trim(le.address_verification.address_history_1.zip5) <> '', 1, 0); //                           Address Populated Indicator

		string	BT_Addr_addr_type; // le.address_verification.addr_type3;  //                      Address Type Indicator from Address Standardization
		unsigned	BT_Addr_avm_automated_valuation; // le.avm.address_history_2.avm_automated_valuation; //        AVM: Overall Valuation
		unsigned	BT_Addr_market_total_value; // le.address_verification.address_history_2.assessed_amount; //            Address Market Value Amount
		boolean	BT_Addr_pop; // if(trim(le.address_verification.address_history_2.zip5) <> '', 1, 0);  // Address Populated Indicator
		unsigned	BT_Addr_avm_med_fips; // le.avm.address_history_2.avm_median_fips_level; //                   AVM: Median AVM for County
		unsigned	BT_Addr_avm_med_geo11; // le.avm.address_history_2.avm_median_geo11_level; //                 AVM: Median AVM for Census Tract
		unsigned	BT_Addr_avm_med_geo12; // le.avm.address_history_2.avm_median_geo12_level; //  
				
		unsigned ST_addrs_5yr;  // added 2/13/2015
					// unsigned4 reported_dob;  // added 2/13/2015
					
		integer economic_trajectory;
		integer economic_trajectory_index;
		
		unsigned3 historydate;
		unsigned4 reported_dob;
		
	end;

  export relative_rec := record
		string15 btst_association_type := '';
		string10 btst_association_confidence := '';
		integer2 btst_cohabit_cnt := 0;
		unsigned2 btst_overlap_mths := 0;
		boolean btst_any_lname_match := false;
		boolean btst_any_phone_match  := false;
		boolean btst_early_lname_match := false;
		boolean btst_curr_lname_match := false;
		boolean btst_mixed_lname_match := false;
		boolean btst_personal_association := false;
		boolean btst_business_association := false;
		boolean btst_other_association := false;
		unsigned1 btst_st_relation_to_bt := 0;
		string1 btst_st_associate_or_relative := '';
		boolean btst_st_isbusiness := false;	
	end;
 
	export prop_rec := record
		unsigned4 seq;
		UNSIGNED6 did;
		string12 ln_fares_id;	
		integer btst_property_deeds_in_common;
		unsigned3 historydate;
	end;

	export deedSlimRec := record
		prop_rec;
		string10 clean_pr;
		string28 clean_pn;
		string8 clean_sr;
		string5 clean_z5;
	end;
 	
  export input_Scores_values :=record
		string20 DeviceProvider1_value := '';//KountScore
		string20 DeviceProvider2_value := '';//TmxScore
		string20 DeviceProvider3_value := '';//lovationScore
		string20 DeviceProvider4_value := '';//Para41Score
		string20 btst_order_type := '';
	end;

  export input_Scores :=record
		unsigned4 seq := 0;
		input_Scores_values;	
	end;
	
	export BTST_input := record
		Risk_Indicators.Layout_Input;
		string20 typeOfOrder := '';
		input_Scores_values;
	end;

	export RelationShipModel := record
		unsigned4 seq := 0;
		integer btst_relationship_index_v1   := 0;               
		integer btst_relationship_index_v2   := 0; 	
	end;



	export BTST_Fields := record

		string20 btst_DeviceProvider1_score     := '';     
		string20 btst_DeviceProvider2_score       := '';      
		string20 btst_DeviceProvider3_score  := '';         
		string20 btst_DeviceProvider4_score    := '';       
		integer btst_cbd_inq_ver_count       := 0;
		integer st_addr_is_bt_business_addr ; 
		integer btst_economic_trajectory     := 0;
		AdditionalInquiryInsights;	
		AdditionalCommercialInsights;
		//CBD 5.0 Appendix A
		unsigned2 btst_did_summary            := 0;   
		relative_rec ;
		integer btst_businesses_in_common   := 0;   
		integer btst_property_deeds_in_common	 := 0;   
		integer btst_addrs_in_common        := 0;            
		integer btst_owned_addrs_in_common  := 0;            
		integer btst_lres_in_common         := 0;             
		integer btst_addr_dists_in_common   := 0;             
		integer btst_addr_states_in_common  := 0;             
		integer btst_phones_in_common       := 0;             
		integer btst_landlines_in_common    := 0;             
		integer btst_cellphones_in_common   := 0;             
		integer btst_last_names_in_common   := 0;             
		integer btst_emails_in_common       := 0;             
		integer btst_free_emails_in_common  := 0;             
		integer btst_isp_emails_in_common   := 0;             
		integer btst_edu_emails_in_common   := 0;            
		integer btst_corp_emails_in_common  := 0;             
		integer bt_phone_found_on_st_inq_count       := 0;
		integer bt_addr_found_on_st_inq_count             := 0;
		integer bt_ssn_found_on_st_inq_count              := 0;
		integer st_phone_found_on_bt_inq_count            := 0;
		integer st_addr_found_on_bt_inq_count             := 0;
		integer st_ssn_found_on_bt_inq_count              := 0;
		integer bt_phone_found_on_st_inq_auto_count       := 0;
		integer bt_addr_found_on_st_inq_auto_count        := 0;
		integer bt_ssn_found_on_st_inq_auto_count         := 0;
		integer st_phone_found_on_bt_inq_auto_count       := 0;
		integer st_addr_found_on_bt_inq_auto_count        := 0;
		integer st_ssn_found_on_bt_inq_auto_count         := 0;
		integer bt_phone_found_on_st_inq_banking_count    := 0;
		integer bt_addr_found_on_st_inq_banking_count     := 0;
		integer bt_ssn_found_on_st_inq_banking_count      := 0;
		integer st_phone_found_on_bt_inq_banking_count    := 0;
		integer st_addr_found_on_bt_inq_banking_count     := 0;
		integer st_ssn_found_on_bt_inq_banking_count      := 0;
		integer bt_phone_found_on_st_inq_Collection_count := 0;
		integer bt_addr_found_on_st_inq_Collection_count := 0;
		integer bt_ssn_found_on_st_inq_Collection_count  := 0;
		integer st_phone_found_on_bt_inq_Collection_count:= 0;
		integer st_addr_found_on_bt_inq_Collection_count:= 0;
		integer st_ssn_found_on_bt_inq_Collection_count := 0;
		integer bt_phone_found_on_st_inq_Mortgage_count := 0;
		integer bt_addr_found_on_st_inq_Mortgage_count  := 0;
		integer bt_ssn_found_on_st_inq_Mortgage_count   := 0;
		integer st_phone_found_on_bt_inq_Mortgage_count := 0;
		integer st_addr_found_on_bt_inq_Mortgage_count  := 0;
		integer st_ssn_found_on_bt_inq_Mortgage_count   := 0;
		integer bt_phone_found_on_st_inq_HighRiskCredit_count:= 0; 
		integer bt_addr_found_on_st_inq_HighRiskCredit_count := 0;
		integer bt_ssn_found_on_st_inq_HighRiskCredit_count  := 0;
		integer st_phone_found_on_bt_inq_HighRiskCredit_count:= 0;
		integer st_addr_found_on_bt_inq_HighRiskCredit_count := 0;
		integer st_ssn_found_on_bt_inq_HighRiskCredit_count  := 0;
		integer bt_phone_found_on_st_inq_Retail_count        := 0;
		integer bt_addr_found_on_st_inq_Retail_count					:= 0;
		integer bt_ssn_found_on_st_inq_Retail_count          := 0;
		integer st_phone_found_on_bt_inq_Retail_count        := 0;
		integer st_addr_found_on_bt_inq_Retail_count         := 0;
		integer st_ssn_found_on_bt_inq_Retail_count          := 0;
		integer bt_phone_found_on_st_inq_Communications_count:= 0;
		integer bt_addr_found_on_st_inq_Communications_count := 0;
		integer bt_ssn_found_on_st_inq_Communications_count  := 0;
		integer st_phone_found_on_bt_inq_Communications_count:= 0;
		integer st_addr_found_on_bt_inq_Communications_count  := 0;
		integer st_ssn_found_on_bt_inq_Communications_count   := 0;
		integer bt_phone_found_on_st_inq_Other_count          := 0;
		integer bt_addr_found_on_st_inq_Other_count           := 0;
		integer bt_ssn_found_on_st_inq_Other_count            := 0;
		integer st_phone_found_on_bt_inq_Other_count          := 0;
		integer st_addr_found_on_bt_inq_Other_count           := 0;
		integer st_ssn_found_on_bt_inq_Other_count            := 0;
		integer bt_phone_found_on_st_inq_prepaidCards_count   := 0;
		integer bt_addr_found_on_st_inq_prepaidCards_count    := 0;
		integer bt_ssn_found_on_st_inq_prepaidCards_count     := 0;
		integer st_phone_found_on_bt_inq_prepaidCards_count   := 0;
		integer st_addr_found_on_bt_inq_prepaidCards_count    := 0;
		integer st_ssn_found_on_bt_inq_prepaidCards_count     := 0;
		integer bt_phone_found_on_st_inq_QuizProvider_count   := 0;
		integer bt_addr_found_on_st_inq_QuizProvider_count    := 0;
		integer bt_ssn_found_on_st_inq_QuizProvider_count     := 0;
		integer st_phone_found_on_bt_inq_QuizProvider_count   := 0;
		integer st_addr_found_on_bt_inq_QuizProvider_count    := 0;
		integer st_ssn_found_on_bt_inq_QuizProvider_count     := 0;
		integer bt_phone_found_on_st_inq_retailPayments_count := 0;
		integer bt_addr_found_on_st_inq_retailPayments_count:= 0;
		integer bt_ssn_found_on_st_inq_retailPayments_count   := 0;
		integer st_phone_found_on_bt_inq_retailPayments_count:= 0;
		integer st_addr_found_on_bt_inq_retailPayments_count := 0;
		integer st_ssn_found_on_bt_inq_retailPayments_count  := 0;
		integer bt_phone_found_on_st_inq_StudentLoans_count  := 0;
		integer bt_addr_found_on_st_inq_StudentLoans_count   := 0;
		integer bt_ssn_found_on_st_inq_StudentLoans_count    := 0;
		integer st_phone_found_on_bt_inq_StudentLoans_count  := 0;
		integer st_addr_found_on_bt_inq_StudentLoans_count   := 0;
		integer st_ssn_found_on_bt_inq_StudentLoans_count    := 0;
		integer bt_phone_found_on_st_inq_Utilities_count     := 0;
		integer bt_addr_found_on_st_inq_Utilities_count      := 0;
		integer bt_ssn_found_on_st_inq_Utilities_count       := 0;
		integer st_phone_found_on_bt_inq_Utilities_count     := 0;
		integer st_addr_found_on_bt_inq_Utilities_count      := 0;
		integer st_ssn_found_on_bt_inq_Utilities_count       := 0;

		integer btst_schools_in_common       := 0;    
		RelationShipModel - seq;
		string btst_order_type;
	end;

	export Layout_Int_For_Codes := RECORD
		integer bt_inq_count_day := 0;
		integer st_inq_count_day := 0;
		integer bt_inq_count_week := 0;
		integer st_inq_count_week := 0;
		string nf_seg_fraudpoint_3_0_BT := '';
		string nf_seg_fraudpoint_3_0_ST := '';
		string nf_seg_fraudpoint_3_0 := '';
	end;
	
	export Layout_OutputWithInt := RECORD
		Risk_Indicators.Layout_Output;
		Layout_Int_For_Codes;
		Btst_Fields; 
	end;

	export layout_OSMain_wAcct := record
		iesp.orderscore.t_OrderScoreResult Result;
		unsigned4 seq;
		string30 AccountNumber;
	end;

	export layout_OSOut_wAcct := record
		iesp.orderscore.t_OrderScoreResponse;
		string30 AccountNumber;
	end;

end;

