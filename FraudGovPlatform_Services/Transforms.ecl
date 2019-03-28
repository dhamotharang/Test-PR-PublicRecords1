IMPORT Address, CriminalRecords_BatchService, DeathV2_Services, FraudGovPlatform_Services, FraudShared_Services, iesp, Patriot, risk_indicators, STD;

EXPORT Transforms := MODULE
	
	SHARED FraudGovConst := FraudGovPlatform_Services.Constants;
	SHARED Fragment_Types_const := FraudGovConst.Fragment_Types;	

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
	
	EXPORT iesp.fraudgovreport.t_FraudGovVelocity xform_velocities(FraudGovPlatform_Services.Layouts.velocities l) := TRANSFORM		
		
		SELF.FoundCount := l.foundCnt;
		SELF.Description := l.description;
	END;
	
	EXPORT FraudGovPlatform_Services.Layouts.red_flag_desc_w_details xnorm_red_flag(FraudGovPlatform_Services.Layouts.combined_layouts l, INTEGER c) := TRANSFORM
																		
		SELF.seq := l.seq;
		SELF.category_weight := c;

		SELF.hri_details := CHOOSE(c,
													PROJECT(L.FRAUD_ALERT_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := 1,
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.IDENTITY_THEFT_ALERT;
															SELF := LEFT)),
																																	
													PROJECT(L.IDENTITY_THEFT_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := 1,
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.IDENTITY_THEFT;
															SELF := LEFT)),
																																															
													PROJECT(l.CREDIT_FREEZE_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := 1,
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.CREDIT_FREEZE_ALERT;
															SELF := LEFT)),
																																			
													PROJECT(L.HIGH_RISK_ADDRESS_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.High_Risk_Address.ADDRESS_INVALID => 1,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.High_Risk_Address.ZIP_IS_POB => 2,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.High_Risk_Address.ADDRESS_IS_TRANSIENT => 3,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.High_Risk_Address.ZIP_IS_CORP_MILITARY => 4,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.High_Risk_Address.ADDRESS_IS_PRISON => 5,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.High_Risk_Address.ZIP_IS_CORP => 6, 
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.High_Risk_Address.ZIP_IS_ARYMILIT => 7,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.High_Risk_Address.ADDRESS_IS_POB => 8,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.HIGH_RISK_ADDRESS;
															SELF := LEFT)),
																																							
													PROJECT(L.SUSPICIOUS_SSN_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_DECEASED => 1,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_INVALID => 2,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_MISKEYED => 3,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_RECENT => 4,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_NOT_FOUND => 5,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_WITHIN_3_YEARS => 6,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_AFTER_5 => 7,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_SSN.SSN_IS_ITIN => 8,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_SSN.MULTIPLE_SSNS => 9,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.SUSPICIOUS_ADDRESS;
															SELF := LEFT)),
																																						
													PROJECT(l.ADDRESS_DISCREPANCY_CODES, 
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Address_Discrepancy.NAME_AND_SSN_VERIFIED => 1,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_INVALID => 2,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_UNVERIFIED => 3,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_MISKEYED => 4,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_MISMATCH => 5,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_DISCREPANCY => 6, 
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Address_Discrepancy.ADDRESS_MISMATCH_SECONDARY_RANGE => 7,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Address_Discrepancy.ZIP_CODE_UNVERIFIED => 8,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.ADDRESS_DISCREPANCY;
															SELF := LEFT)),
																																													
													PROJECT(L.SUSPICIOUS_DOCUMENTS_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Documents.SSN_INVALID => 1,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Documents.DL_INVALID => 2,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Documents.OTHER_DL_FOUND => 3,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Documents.DL_NOT_FOUND => 4,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Documents.DL_MISKEYED => 5,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Documents.DL_UNVERIFIED => 6,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.SUSPICIOUS_DOCUMENTS;
															SELF := LEFT)),		
																																																							
													PROJECT(L.SUSPICIOUS_ADDRESS_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Address.NAME_SSN_VERIFIED => 1,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_INVALID => 2,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_UNVERIFIED => 3,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_MISKEYED => 4,
																									   LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_MISMATCH => 5,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_DISCREPANCY => 6,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Address.ADDRESS_MISMATCH_SECONDARY_RANGE => 7,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Address.ZIP_CODE_UNVERIFIED => 8,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.SUSPICIOUS_ADDRESS;
															SELF := LEFT)),
													
													PROJECT(L.SUSPICIOUS_DOB_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_DOB.SSN_PRIOR_TO_DECEASED => 1,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_DOB.DOB_UNVERIFIED => 2,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_DOB.DOB_MISKEYED => 3,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.SUSPICIOUS_DOB;
															SELF := LEFT)),
						
													PROJECT(L.SUSPICIOUS_PHONE_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_DISCONNECTED => 1,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_INVALID => 2,
																									   LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_IS_PAGER => 3,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_IS_MOBBILE => 4,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_IS_TRANSIENT => 5,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_ZIP_INVALID_COMBO => 6,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_UNVERIFIED => 7,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_MISKEYED => 8,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_ADDR_DISTANT => 9,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_NOT_FOUND => 10,
																									   LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Suspicious_Phone.PHONE_DIFFERENT => 11,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.SUSPICIOUS_PHONE;
															SELF := LEFT)),
																																																																										
													PROJECT(L.SSN_MULTIPLE_LAST_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.SSN_Multiple_Last.SSN_DIFF_NAMES => 1,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.SSN_Multiple_Last.SSN_SAME_FNAME => 2,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.SSN_Multiple_Last.SSN_DIFF_NAME_ADDR => 3,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.SSN_Multiple_Last.SSN_MULT_IDENT => 4,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.SSN_MULTIPLE_LAST;
															SELF := LEFT)),
																																							
													PROJECT(L.MISSING_INPUT_CODES,
														TRANSFORM(FraudGovPlatform_Services.Layouts.red_flag_desc,
															SELF.hri_weight := MAP(LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Missing_Input.NAME_MISSING => 1,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Missing_Input.ADDR_MISSING => 2,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Missing_Input.SSN_MISSING => 3,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Missing_Input.PHONE_MISSING => 4,
																										 LEFT.hri = FraudGovConst.Red_Flag_Alerts.Codes.Missing_Input.DOB_MISSING => 5,
																										 0),
															SELF.desc := TRIM(LEFT.desc) + ' - ' + FraudGovConst.Red_Flag_Alerts.Description.MISSING_INPUT;
															SELF := LEFT)));
																																						
	END;

	EXPORT iesp.fraudgovreport.t_FraudGovTimelineDetails xform_timeline_details(FraudShared_Services.Layouts.Raw_Payload_rec L) := TRANSFORM
		
		ds_home_phone := IF(L.clean_phones.phone_number <> '',
												ROW({FraudGovConst.PHONE_TYPE.PHONE_TYPE_HOME, L.clean_phones.phone_number, L.phone_risk_code}, iesp.fraudgovreport.t_FraudGovPhoneInfo), 
												ROW([], iesp.fraudgovreport.t_FraudGovPhoneInfo)
												);
		ds_cell_phone := IF(L.clean_phones.cell_phone <> '', 
												ROW({FraudGovConst.PHONE_TYPE.PHONE_TYPE_CELL, L.clean_phones.cell_phone, L.cell_phone_risk_code}, iesp.fraudgovreport.t_FraudGovPhoneInfo), 
												ROW([], iesp.fraudgovreport.t_FraudGovPhoneInfo)
												);
		ds_work_phone := IF(L.clean_phones.work_phone <> '',
												ROW({FraudGovConst.PHONE_TYPE.PHONE_TYPE_WORK, L.clean_phones.work_phone, L.work_phone_risk_code}, iesp.fraudgovreport.t_FraudGovPhoneInfo), 
												ROW([], iesp.fraudgovreport.t_FraudGovPhoneInfo)
												);

		ds_phones := (ds_home_phone + ds_cell_phone + ds_work_phone)(PhoneNumber <> '');
	
		reported_date_time := L.reported_date + ' ' + L.reported_time;

		SELF.IsRecentActivity := False; // Y Means its a deltabase record, N means its coming from contributory records. 
		SELF.FileType  := L.classification_permissible_use_access.file_type; //1 -> Identity Transaction, 3-> Known Risk.
		SELF.GlobalCompanyId := L.classification_permissible_use_access.gc_id;
		SELF.TransactionId := L.transaction_id;
		SELF.HouseholdId := L.household_id;
		SELF.DeceitfulConfidenceId := L.classification_Activity.Confidence_that_activity_was_deceitful_id;
		SELF.CustomerPersonId := L.customer_person_id;
		SELF.CustomerEventId := L.customer_event_id;
		SELF.ReportedDateTime :=  iesp.ECL2ESP.toTimeStamp(reported_date_time);
		SELF.ReportedBy := L.reported_by;
		SELF.EventDate := iesp.ECL2ESP.toDatestring8(L.event_date);
		SELF.EventEndDate := iesp.ECL2ESP.toDatestring8(L.event_end_date);
		SELF.EventLocation := L.event_location;
		SELF.EventType1 := L.event_type_1;
		SELF.EventType2 := L.event_type_2;
		SELF.EventType3 := L.event_type_3;
		SELF.IndustryTypeDescription := L.classification_permissible_use_access.ind_type_description;
		SELF.ActivityReason := L.reason_description;
		SELF.StartDate := iesp.ECL2ESP.toDatestring8(L.start_date);
		SELF.EndDate := iesp.ECL2ESP.toDatestring8(L.end_date);
		SELF.UniqueId := (string) L.did;
		SELF.Name := iesp.ECL2ESP.SetName(L.cleaned_name.fname, L.cleaned_name.mname, L.cleaned_name.lname, L.cleaned_name.name_suffix,
																			L.cleaned_name.title, '');
		SELF.SSN := L.ssn;
		SELF.DOB := iesp.ECL2ESP.toDatestring8(L.dob);
		SELF.AddressType := L.address_type;
		SELF.PhysicalAddress := iesp.ECL2ESP.SetAddress(L.clean_address.prim_name, L.clean_address.prim_range, L.clean_address.predir, L.clean_address.postdir, 
																										L.clean_address.addr_suffix, L.clean_address.unit_desig, L.clean_address.sec_range, 
																										L.clean_address.p_city_name, L.clean_address.st, L.clean_address.zip, L.clean_address.zip4, 
																										'', '', L.address_1, L.address_2,'');
		SELF.MailingAddress := iesp.ECL2ESP.SetAddress(L.additional_address.clean_address.prim_name, L.additional_address.clean_address.prim_range, L.additional_address.clean_address.predir, L.additional_address.clean_address.postdir, 
																										L.additional_address.clean_address.addr_suffix, L.additional_address.clean_address.unit_desig, L.additional_address.clean_address.sec_range, 
																										L.additional_address.clean_address.p_city_name, L.additional_address.clean_address.st, L.additional_address.clean_address.zip, L.additional_address.clean_address.zip4, 
																										'', '', L.additional_address.street_1, L.additional_address.street_2,'');
		SELF.County := L.county;
		SELF.Phones := ds_phones;
		SELF.EmailAddress := L.email_address;
		SELF.DriversLicense.DriversLicenseNumber := L.drivers_license;
		SELF.DriversLicense.DriversLicenseState := L.drivers_license_state;
		SELF.BankInformation1.BankRoutingNumber := L.bank_routing_number_1; 
		SELF.BankInformation1.BankAccountNumber := L.bank_account_number_1;
		SELF.BankInformation2.BankRoutingNumber := L.bank_routing_number_2;  
		SELF.BankInformation2.BankAccountNumber := L.bank_account_number_2;
		SELF.Ethnicity := L.ethnicity;
		SELF.Race := L.race;
		SELF.HeadOfHouseholdIndicator := L.head_of_household_indicator;
		SELF.RelationshipIndicator := L.relationship_indicator;
		SELF.IpAddress := L.ip_address;
		SELF.DeviceId := L.device_id;
		SELF.AmountPaid := L.amount_paid;
		SELF.NameRiskCode := L.name_risk_code;
		SELF.SSNRiskCode := L.ssn_risk_code;
		SELF.DOBRiskCode := L.dob_risk_code;
		SELF.PhysicalAddressRiskCode := L.physical_address_risk_code;
		SELF.MailingAddressRiskCode := L.mailing_address_risk_code;
		SELF.EmailAddressRiskCode := L.email_address_risk_code;
		SELF.DriversLicenseRiskCode := L.drivers_license_risk_code;
		SELF.BankAccount1RiskCode := L.bank_account_1_risk_code;
		SELF.BankAccount2RiskCode := L.bank_account_2_risk_code;
		SELF.IPAddressFraudCode := L.ip_address_fraud_code;
		SELF.DeviceRiskCode := L.device_risk_code;
		SELF.GeoLocation.Latitude := L.clean_address.geo_lat;
		SELF.GeoLocation.Longitude := L.clean_address.geo_long;
	END;

	EXPORT FraudGovPlatform_Services.Layouts.entity_information_recs xform_elements_Information(FraudGovPlatform_Services.Layouts.fragment_w_value_recs L,
																																														FraudShared_Services.Layouts.Raw_Payload_rec R) := TRANSFORM

		SELF.UniqueId := IF(L.fragment = Fragment_Types_const.PERSON_FRAGMENT, (string) R.did, '');
		SELF.SSN := IF(L.fragment = Fragment_Types_const.SSN_FRAGMENT, R.ssn, '');
		SELF.Phone10 := IF(L.fragment = Fragment_Types_const.PHONE_FRAGMENT, 
												IF(R.clean_phones.phone_number <> '', R.clean_phones.phone_number,R.clean_phones.cell_phone), 
										'');
		SELF.IpAddress := IF(L.fragment = Fragment_Types_const.IP_ADDRESS_FRAGMENT, R.ip_address, '');
		SELF.DeviceId := IF(L.fragment = Fragment_Types_const.DEVICE_ID_FRAGMENT, R.device_id, '');
		SELF.Name := IF(L.fragment = Fragment_Types_const.NAME_FRAGMENT, 
											iesp.ECL2ESP.SetName(	R.cleaned_name.fname,
																						R.cleaned_name.mname,
																						R.cleaned_name.lname,
																						R.cleaned_name.name_suffix,
																						R.cleaned_name.title,), 
											ROW([], iesp.share.t_Name));
		SELF.Address := IF(L.fragment = Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT, 
												iesp.ECL2ESP.SetAddress(R.clean_address.prim_name, 
																								R.clean_address.prim_range, 
																								R.clean_address.predir,
																								R.clean_address.postdir,
																								R.clean_address.addr_suffix, 
																								R.clean_address.unit_desig, 
																								R.clean_address.sec_range, 
																								R.clean_address.p_city_name,
																								R.clean_address.st, 
																								R.clean_address.zip, 
																								R.clean_address.zip4, 
																								'', 
																								'', 
																								R.address_1,
																								R.address_2), 
												ROW([], iesp.share.t_Address));
		SELF.GeoLocation.Latitude := IF(L.fragment = Fragment_Types_const.GEOLOCATION_FRAGMENT, R.clean_address.geo_lat, '');
		SELF.GeoLocation.Longitude := IF(L.fragment = Fragment_Types_const.GEOLOCATION_FRAGMENT, R.clean_address.geo_long, '');
		SELF.BankInformation.BankRoutingNumber := IF(L.fragment = Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT, R.bank_routing_number_1, '');
		SELF.BankInformation.BankAccountNumber := IF(L.fragment = Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT, R.bank_account_number_1, '');
		SELF.DriversLicense.DriversLicenseState := IF(L.fragment = Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT, R.drivers_license_state, '');
		SELF.DriversLicense.DriversLicenseNumber := IF(L.fragment = Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT, R.drivers_license, '');
		SELF := L;
		SELF := [];
	END;
		
		EXPORT FraudGovPlatform_Services.Layouts.Layout_delta_filter xform_getDeltabaseQueryParams(FraudShared_Services.Layouts.BatchInExtended_rec L) := TRANSFORM
					SELF.ssn := L.ssn;
					SELF.dob := L.DOB;
					SELF.lex_id := L.did;
					SELF.name_first := L.name_first;
					SELF.name_middle := L.name_middle;
					SELF.name_last := L.name_last;
					// If StreetAddress is empty, then use the parsed address fields
					SELF.physical_address := IF(L.addr = '',
											Address.Addr1FromComponents(L.prim_range, 
													L.predir,
													L.prim_name, L.addr_suffix,
													L.postdir,'',	''),
											STD.Str.CleanSpaces(L.addr));
					SELF.physical_city := L.p_city_name;
					SELF.physical_state := L.st;
					SELF.physical_zip := L.z5;
					SELF.mailing_address := IF(L.mailing_addr = '',
											Address.Addr1FromComponents(L.mailing_prim_range, 
													L.mailing_predir,
													L.mailing_prim_name, L.mailing_addr_suffix,
													L.mailing_postdir,'',''),
											STD.Str.CleanSpaces(L.mailing_addr));
					SELF.mailing_city := L.mailing_p_city_name;
					SELF.mailing_state := L.mailing_st;
					SELF.mailing_zip := L.mailing_z5;
					SELF.phone := L.phoneno;
					SELF.email_address := L.email_address;
					SELF.ip_address := L.ip_address;
					SELF.device_id := L.device_id;
					SELF.bank_account_number := L.bank_account_number;
					SELF.dl_state := L.dl_state;
					SELF.dl_number := L.dl_number;
					SELF.geo_lat := L.geo_lat;
					SELF.geo_long := L.geo_long;
					
					//Date in DB is stored as YYYYMMDDhhmmss but the environment variable only has YYYYMMDD, so addedd hhmmss
					//Also added failsafe...if we can't get the environment variable, we default it to yesterday
					SELF.date_added := (INTEGER)(thorlib.getenv(FraudGovPlatform_Services.Constants.FRAUDGOV_BUILD_ENV_VARIABLE,
																											(STRING)FraudGovPlatform_Services.Utilities.Yesterday)[1..8] + '000000');

				END;
	
END;