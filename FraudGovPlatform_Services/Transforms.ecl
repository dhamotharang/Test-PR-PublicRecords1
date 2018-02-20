IMPORT Address, CriminalRecords_BatchService, DeathV2_Services, FraudGovPlatform_Services, FraudShared, 
						 FraudShared_Services, iesp, Patriot, risk_indicators;

EXPORT Transforms := MODULE

	EXPORT iesp.fraudgovreport.t_FraudGovDeceased xform_deceased(DeathV2_Services.Layouts.BatchOut l) := TRANSFORM

		SELF.SSN := l.ssn;
		SELF.Name := iesp.ECL2ESP.SetName(l.fname, l.mname, l.lname, l.name_suffix,'');
		SELF.Address := iesp.ECL2ESP.SetAddress('','','','','','','', l.p_city_name,l.st, l.zip, l.zip4,'','', 
																						'', '', stringlib.stringcleanspaces(l.p_city_name + ' ' + 
																						l.st + ' '+ l.zip + l.zip4));
		SELF.DOB := iesp.ECL2ESP.toDatestring8(l.dob8);
		SELF.DOD := iesp.ECL2ESP.toDatestring8(l.dod8);
		SELF.VorPCode := l.vorp_code;
		SELF.MatchCode := l.matchcode;
		SELF.Source := l.death_rec_src;
	END;
	
	EXPORT iesp.fraudgovreport.t_FraudGovOffense xform_offenses(CriminalRecords_BatchService.Layouts.Batch_Out l, 
																																INTEGER c) := TRANSFORM
		SELF.OffenseDescription := CHOOSE(c, l.court_desc_1, l.court_desc_2, l.court_desc_3, l.court_desc_4, 
																																				l.court_desc_5, l.court_desc_6);
		SELF.Offense := CHOOSE(c, l.chg_1,l.chg_2, l.chg_3, l.chg_4, l.chg_5, l.chg_6);
		SELF.OffenseLevel := CHOOSE(c, l.off_lev_1, l.off_lev_2, l.off_lev_3, l.off_lev_4, l.off_lev_5, l.off_lev_6);
																	
		SELF.OffenseDate := iesp.ECL2ESP.toDatestring8(CHOOSE(c, l.off_date_1, l.off_date_2, l.off_date_3, l.off_date_4,
																																	 l.off_date_5, l.off_date_6));
																	
		SELF.OffenseType := CHOOSE(c, l.off_typ_1, l.off_typ_2, l.off_typ_3, l.off_typ_4, l.off_typ_5, l.off_typ_6);	
		SELF.OffenseCode := CHOOSE(c, l.off_code_1, l.off_code_2, l.off_code_3, l.off_code_4, l.off_code_5, l.off_code_6);																																																					 
																																																											 
	END;
	
	EXPORT iesp.fraudgovreport.t_FraudGovCriminal xform_criminal(CriminalRecords_BatchService.Layouts.Batch_Out l,
																																 INTEGER c) := TRANSFORM
		
		SELF.MatchType := l.match_type;
		SELF.StateOrigin := l.state_origin;
		SELF.UniqueId := (STRING)l.did;
		SELF.OffenderKey := l.offender_key;
	
		SELF.SSN := l.ssn;
		SELF.Name := iesp.ECL2ESP.SetName(l.fname, l.mname, l.lname, '', '');
		SELF.DocNumber := l.doc_num;
		SELF.DOB := iesp.ECL2ESP.toDateString8(l.dob);																		
		SELF.Address := iesp.ECL2ESP.setAddress(l.prim_range, l.prim_name, l.addr_suffix, '','','','', l.p_city_name, 
																					  l.st, l.zip5,  '','','', '', '',
																						stringlib.stringcleanspaces(l.p_city_name + ' ' + l.st + ' '+ l.zip5));
		SELF.DataSource := l.datasource;
		
		//****************************************************************
		iesp.fraudgovreport.t_FraudGovCase xform_cases() := TRANSFORM
																																																	
				SELF.County := CHOOSE(c, l.cty_conv_1, l.cty_conv_2, l.cty_conv_3, l.cty_conv_4, l.cty_conv_5, l.cty_conv_6);
				SELF.SentenceDate := iesp.ecl2esp.toDatestring8(CHOOSE(c, l.stc_dt_1, l.stc_dt_2, l.stc_dt_3, l.stc_dt_4,
																																	l.stc_dt_5, l.stc_dt_6));
																																	
				SELF.CaseNumber := CHOOSE(c, l.case_num_1, l.case_num_2, l.case_num_3, l.case_num_4, l.case_num_5, l.case_num_6);
				SELF.NumberOfCounts := CHOOSE(c, l.num_of_counts_1, l.num_of_counts_2, l.num_of_counts_3, l.num_of_counts_4, 
																																	 l.num_of_counts_5, l.num_of_counts_6);
				SELF.Offenses := PROJECT(l, xform_offenses(LEFT, c));
	
		END;
	//****************************************************************
		SELF.Cases := DATASET([xform_cases()]);
		self := [];
	END;
	
	EXPORT iesp.fraudgovreport.t_FraudGovGlobalWatchlist xform_global_watchlist(Patriot.layout_batch_out l,
																																								INTEGER c) := TRANSFORM
																																																					
		SELF.HitNum := l.HitNum;
		SELF.Score := l.score;
		SELF.PartyKey := l.pty_key;
		SELF.Source := l.source;
		SELF.OriginalPartyName := l.orig_pty_name;
		SELF.BlockedCountry := l.blocked_country;		
		
		SELF.Addresses := ROW({CHOOSE(c, l.addr_1, l.addr_2, l.addr_3, l.addr_4, l.addr_5, l.addr_6,
																		 l.addr_7, l.addr_8, l.addr_9, l.addr_10)},
																iesp.share.t_StringArrayItem);
															
		SELF.Remarks := ROW({CHOOSE(c, l.remarks_1, l.remarks_2, l.remarks_3, l.remarks_4, l.remarks_5, l.remarks_6,  
																	 l.remarks_7, l.remarks_8, l.remarks_9, l.remarks_10, l.remarks_11, l.remarks_12, 
																	 l.remarks_13, l.remarks_14, l.remarks_15, l.remarks_16, l.remarks_17, l.remarks_18, 
																	 l.remarks_19, l.remarks_20, l.remarks_21, l.remarks_22, l.remarks_23, l.remarks_24,  
																	 l.remarks_25, l.remarks_26, l.remarks_27, l.remarks_28, l.remarks_29, l.remarks_30)},
																iesp.share.t_StringArrayItem);
																		  
	END;
	
	risk_indicators.layouts.layout_desc_plus_seq xform_codes(risk_indicators.layouts.layout_desc_plus_seq l) := TRANSFORM
			SELF.hri := l.hri;
			SELF.desc := l.desc;
			SELF.seq := 0;
	END;

	EXPORT iesp.fraudgovreport.t_FraudGovRedFlag xform_red_flag(FraudGovPlatform_Services.Layouts.combined_layouts l) := TRANSFORM		
		
		SELF.AddressDiscrepancyCodes := PROJECT(l.address_discrepancy_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.SuspiciousDocumentsCodes := PROJECT(l.suspicious_documents_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.SuspiciousAddressCodes := PROJECT(l.suspicious_address_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.SuspiciousSSNCodes := PROJECT(l.suspicious_ssn_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.SuspiciousDOBCodes := PROJECT(l.suspicious_dob_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.HighRiskAddressCodes := PROJECT(l.high_risk_address_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.SuspiciousPhoneCodes := PROJECT(l.suspicious_phone_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.SSNMultipleLastCodes := PROJECT(l.ssn_multiple_last_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.MissingInputCodes := PROJECT(l.missing_input_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.FraudAlertCodes := PROJECT(l.fraud_alert_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.CreditFreezeCodes := PROJECT(l.credit_freeze_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);
		SELF.IdentityTheftCodes := PROJECT(l.identity_theft_codes, iesp.fraudgovreport.t_FraudGovIndDescPlusSequence);

	END;
	
	EXPORT iesp.fraudgovreport.t_FraudGovVelocityCount xform_velocities(FraudGovPlatform_Services.Layouts.velocities l) := TRANSFORM		
		
		SELF.FoundCount := l.foundCnt;
		SELF.Description := l.description;
		// SELF.PayloadRecords:= PROJECT(l.ds_payload, TRANSFORM(FraudShared.Layouts_Key.Main, SELF := LEFT));
		
	END;
	
	EXPORT FraudGovPlatform_Services.Layouts.red_flag_desc_w_details xnorm_red_flag(FraudGovPlatform_Services.Layouts.combined_layouts l, INTEGER c) := TRANSFORM
																		
		SELF.seq := l.seq;
		SELF.category_weight := c;

		SELF.hri_details := CHOOSE(c,
													PROJECT(L.FRAUD_ALERT_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := 1,
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.IDENTITY_THEFT_ALERT;
															SELF := LEFT)),
																																	
													PROJECT(L.IDENTITY_THEFT_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := 1,
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.IDENTITY_THEFT;
															SELF := LEFT)),
																																															
													PROJECT(l.CREDIT_FREEZE_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := 1,
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.CREDIT_FREEZE_ALERT;
															SELF := LEFT)),
																																			
													PROJECT(L.HIGH_RISK_ADDRESS_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.High_Risk_Address.ADDRESS_INVALID => 1,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.High_Risk_Address.ZIP_IS_POB => 2,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.High_Risk_Address.ADDRESS_IS_TRANSIENT => 3,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.High_Risk_Address.ZIP_IS_CORP_MILITARY => 4,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.High_Risk_Address.ADDRESS_IS_PRISON => 5,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.High_Risk_Address.ZIP_IS_CORP => 6, 
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.High_Risk_Address.ZIP_IS_ARYMILIT => 7,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.High_Risk_Address.ADDRESS_IS_POB => 8,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.HIGH_RISK_ADDRESS;
															SELF := LEFT)),
																																							
													PROJECT(L.SUSPICIOUS_SSN_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_DECEASED => 1,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_INVALID => 2,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_MISKEYED => 3,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_RECENT => 4,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_NOT_FOUND => 5,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_WITHIN_3_YEARS => 6,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_AFTER_5 => 7,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_IS_ITIN => 8,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_SSN.MULTIPLE_SSNS => 9,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.SUSPICIOUS_ADDRESS;
															SELF := LEFT)),
																																						
													PROJECT(l.ADDRESS_DISCREPANCY_CODES, 
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Address_Discrepancy.NAME_AND_SSN_VERIFIED => 1,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_INVALID => 2,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_UNVERIFIED => 3,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_MISKEYED => 4,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_MISMATCH => 5,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_DISCREPANCY => 6, 
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_MISMATCH_SECONDARY_RANGE => 7,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Address_Discrepancy.ZIP_CODE_UNVERIFIED => 8,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.ADDRESS_DISCREPANCY;
															SELF := LEFT)),
																																													
													PROJECT(L.SUSPICIOUS_DOCUMENTS_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Documents.SSN_INVALID => 1,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Documents.DL_INVALID => 2,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Documents.OTHER_DL_FOUND => 3,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Documents.DL_NOT_FOUND => 4,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Documents.DL_MISKEYED => 5,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Documents.DL_UNVERIFIED => 6,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.SUSPICIOUS_DOCUMENTS;
															SELF := LEFT)),		
																																																							
													PROJECT(L.SUSPICIOUS_ADDRESS_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Address.NAME_SSN_VERIFIED => 1,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_INVALID => 2,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_UNVERIFIED => 3,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_MISKEYED => 4,
																									   LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_MISMATCH => 5,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_DISCREPANCY => 6,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_MISMATCH_SECONDARY_RANGE => 7,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Address.ZIP_CODE_UNVERIFIED => 8,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.SUSPICIOUS_ADDRESS;
															SELF := LEFT)),
													
													PROJECT(L.SUSPICIOUS_DOB_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_DOB.SSN_PRIOR_TO_DECEASED => 1,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_DOB.DOB_UNVERIFIED => 2,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_DOB.DOB_MISKEYED => 3,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.SUSPICIOUS_DOB;
															SELF := LEFT)),
						
													PROJECT(L.SUSPICIOUS_PHONE_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_DISCONNECTED => 1,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_INVALID => 2,
																									   LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_IS_PAGER => 3,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_IS_MOBBILE => 4,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_IS_TRANSIENT => 5,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_ZIP_INVALID_COMBO => 6,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_UNVERIFIED => 7,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_MISKEYED => 8,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_ADDR_DISTANT => 9,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_NOT_FOUND => 10,
																									   LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_DIFFERENT => 11,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.SUSPICIOUS_PHONE;
															SELF := LEFT)),
																																																																										
													PROJECT(L.SSN_MULTIPLE_LAST_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.SSN_Multiple_Last.SSN_DIFF_NAMES => 1,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.SSN_Multiple_Last.SSN_SAME_FNAME => 2,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.SSN_Multiple_Last.SSN_DIFF_NAME_ADDR => 3,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.SSN_Multiple_Last.SSN_MULT_IDENT => 4,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.SSN_MULTIPLE_LAST;
															SELF := LEFT)),
																																							
													PROJECT(L.MISSING_INPUT_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Missing_Input.NAME_MISSING => 1,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Missing_Input.ADDR_MISSING => 2,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Missing_Input.SSN_MISSING => 3,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Missing_Input.PHONE_MISSING => 4,
																										 LEFT.hri = FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Codes.Missing_Input.DOB_MISSING => 5,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovPlatform_Services.Constants.Red_Flag_Alerts.Description.MISSING_INPUT;
															SELF := LEFT)));
																																						
		END;
	
END;