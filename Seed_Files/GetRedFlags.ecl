import risk_indicators, riskwise;

export GetRedFlags(DATASET (risk_indicators.layout_input) input, string20 TestDataTableName) := 

FUNCTION

	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	combined_layouts := record
		unsigned seq;
		riskwise.layouts.red_flags_online_layout;
		riskwise.layouts.red_flags_batch_layout;
	end;


	// Add Red Flags data
	combined_layouts Add_RedFlags(input Le, Key_redflags ri)
		:=Transform	
	
		self.seq := le.seq;	
		
		//address_discrepancy;
		adc := dataset([{ri.address_discrepancy_rc1,ri.address_discrepancy_desc1},
						{ri.address_discrepancy_rc2,ri.address_discrepancy_desc2},
						{ri.address_discrepancy_rc3,ri.address_discrepancy_desc3},
						{ri.address_discrepancy_rc4,ri.address_discrepancy_desc4}],risk_indicators.Layout_Desc);
		risk_indicators.mac_add_sequence(adc, adc_with_seq);	
		self.ADDRESS_DISCREPANCY_CODES := adc_with_seq(hri <>'' or desc <> '');
		
		//suspicious_documents;
		sdc := dataset([{ri.suspicious_documents_rc1,ri.suspicious_documents_desc1},
						{ri.suspicious_documents_rc2,ri.suspicious_documents_desc2},
						{ri.suspicious_documents_rc3,ri.suspicious_documents_desc3},
						{ri.suspicious_documents_rc4,ri.suspicious_documents_desc4}],risk_indicators.Layout_Desc);		
		risk_indicators.mac_add_sequence(sdc, sdc_with_seq);
		self.SUSPICIOUS_DOCUMENTS_CODES := sdc_with_seq(hri <>'' or desc <> '');
		
		//suspicious_address;
		sac := dataset([{ri.suspicious_address_rc1,ri.suspicious_address_desc1},
						{ri.suspicious_address_rc2,ri.suspicious_address_desc2},
						{ri.suspicious_address_rc3,ri.suspicious_address_desc3},
						{ri.suspicious_address_rc4,ri.suspicious_address_desc4}],risk_indicators.Layout_Desc);		
		risk_indicators.mac_add_sequence(sac, sac_with_seq);
		self.SUSPICIOUS_ADDRESS_CODES 	:= sac_with_seq(hri <>'' or desc <> '');
		
		//suspicious_ssn;
		ssc := dataset([{ri.suspicious_ssn_rc1,ri.suspicious_ssn_desc1},
						{ri.suspicious_ssn_rc2,ri.suspicious_ssn_desc2},
						{ri.suspicious_ssn_rc3,ri.suspicious_ssn_desc3},
						{ri.suspicious_ssn_rc4,ri.suspicious_ssn_desc4}],risk_indicators.Layout_Desc);		
		
		risk_indicators.mac_add_sequence(ssc, ssc_with_seq);
		self.SUSPICIOUS_SSN_CODES		:= ssc_with_seq(hri <>'' or desc <> '');
		
		//suspicious_dob;
		sdobc := dataset([{ri.suspicious_dob_rc1,ri.suspicious_dob_desc1},
						  {ri.suspicious_dob_rc2,ri.suspicious_dob_desc2},
						  {ri.suspicious_dob_rc3,ri.suspicious_dob_desc3},
						  {ri.suspicious_dob_rc4,ri.suspicious_dob_desc4}],risk_indicators.Layout_Desc);			
		                                                 
		risk_indicators.mac_add_sequence(sdobc, sdobc_with_seq);
		self.SUSPICIOUS_DOB_CODES		:= sdobc_with_seq(hri <>'' or desc <> '');
		
		//high_risk_address;
		hrac := dataset([{ri.high_risk_address_rc1,ri.high_risk_address_desc1},
						  {ri.high_risk_address_rc2,ri.high_risk_address_desc2},
						  {ri.high_risk_address_rc3,ri.high_risk_address_desc3},
						  {ri.high_risk_address_rc4,ri.high_risk_address_desc4}],risk_indicators.Layout_Desc);	
		risk_indicators.mac_add_sequence(hrac, hrac_with_seq);				  
		self.HIGH_RISK_ADDRESS_CODES	:= hrac_with_seq(hri <>'' or desc <> '');
		
		//suspicious_phone;
		spc := dataset([{ri.suspicious_phone_rc1,ri.suspicious_phone_desc1},
						{ri.suspicious_phone_rc2,ri.suspicious_phone_desc2},
						{ri.suspicious_phone_rc3,ri.suspicious_phone_desc3},
						{ri.suspicious_phone_rc4,ri.suspicious_phone_desc4}],risk_indicators.Layout_Desc);
		risk_indicators.mac_add_sequence(spc, spc_with_seq);				                          
		self.SUSPICIOUS_PHONE_CODES		:= spc_with_seq(hri <>'' or desc <> '');

		// string1 ssn_multiple_last;
		smlc := dataset([{ri.ssn_multiple_last_rc1,ri.ssn_multiple_last_desc1},
						 {ri.ssn_multiple_last_rc2,ri.ssn_multiple_last_desc2},
						 {ri.ssn_multiple_last_rc3,ri.ssn_multiple_last_desc3},
						 {ri.ssn_multiple_last_rc4,ri.ssn_multiple_last_desc4}],risk_indicators.Layout_Desc);
		risk_indicators.mac_add_sequence(smlc, smlc_with_seq);				                           
		self.SSN_MULTIPLE_LAST_CODES	:= smlc_with_seq(hri <>'' or desc <> '');

		//missing_input;
		sic := dataset([{ri.missing_input_rc1,ri.missing_input_desc1},
						{ri.missing_input_rc2,ri.missing_input_desc2},
						{ri.missing_input_rc3,ri.missing_input_desc3},
						{ri.missing_input_rc4,ri.missing_input_desc4}],risk_indicators.Layout_Desc);
		risk_indicators.mac_add_sequence(sic, sic_with_seq);						
		self.MISSING_INPUT_CODES		:= sic_with_seq(hri <>'' or desc <> '');
		
		fraud_alert_codes := dataset([{ri.fraud_alert_rc1,ri.fraud_alert_desc1},
						{ri.fraud_alert_rc2,ri.fraud_alert_desc2},
						{ri.fraud_alert_rc3,ri.fraud_alert_desc3},
						{ri.fraud_alert_rc4,ri.fraud_alert_desc4}],risk_indicators.Layout_Desc);
		risk_indicators.mac_add_sequence(fraud_alert_codes, fraud_alert_codes_with_seq);						
		self.FRAUD_ALERT_CODES		:= fraud_alert_codes_with_seq(hri <>'' or desc <> '');
		
		credit_freeze_codes := dataset([{ri.credit_freeze_rc1,ri.credit_freeze_desc1},
						{ri.credit_freeze_rc2,ri.credit_freeze_desc2},
						{ri.credit_freeze_rc3,ri.credit_freeze_desc3},
						{ri.credit_freeze_rc4,ri.credit_freeze_desc4}],risk_indicators.Layout_Desc);
		risk_indicators.mac_add_sequence(credit_freeze_codes, credit_freeze_codes_with_seq);						
		self.CREDIT_FREEZE_CODES		:= credit_freeze_codes_with_seq(hri <>'' or desc <> '');
		
		identity_theft_codes := dataset([{ri.identity_theft_rc1,ri.identity_theft_desc1},
						{ri.identity_theft_rc2,ri.identity_theft_desc2},
						{ri.identity_theft_rc3,ri.identity_theft_desc3},
						{ri.identity_theft_rc4,ri.identity_theft_desc4}],risk_indicators.Layout_Desc);
		risk_indicators.mac_add_sequence(identity_theft_codes, identity_theft_codes_with_seq);						
		self.IDENTITY_THEFT_CODES		:= identity_theft_codes_with_seq(hri <>'' or desc <> '');
		
		self := [];	
		
	END; 
	
	// Join the input data to the red flags key
	WithRedFlags := Join(input, Key_redflags,  
													keyed(right.dataset_name=Test_Data_Table_Name) and 
													keyed(right.hashvalue=Seed_Files.Hash_InstantID((string20)left.fname,(string20)left.lname,
																																					(string9)left.ssn,Risk_Indicators.nullstring,
																																					(string5)left.in_zipCode,(string10)left.phone10,Risk_Indicators.nullstring)), 
											Add_RedFlags(LEFT, RIGHT), LEFT OUTER, KEEP(1));
	
  RETURN WithRedFlags;
	
END;
