IMPORT CriminalRecords_BatchService, DeathV2_Services, FraudGovPlatform_Services, FraudShared, FraudShared_Services, 
					  iesp, Patriot, risk_indicators;

EXPORT Transforms := MODULE

  //this shared function is not used, it was replaced by functions.getKnownFraudDescriptionFromPayload()	
	SHARED getKnownFraudDescriptionFromPayloadXml(FraudShared_Services.Layouts.Raw_Payload_rec p_rec ) := FUNCTION

    dString1 := '(On: ' + TRIM(p_rec.Event_Date) + ') ';
    dString2 := '(From: '+ TRIM(p_rec.Event_Date) + ' To: ' + TRIM(p_rec.Event_End_Date) + ') ';

    eventDates := IF(p_rec.Event_Date=p_rec.Event_End_Date, dString1, dString2);
    eventType1 := TRIM(' ' + p_rec.Event_Type_1);
    eventType2 := TRIM(' ' + p_rec.Event_Type_2);
    eventType3 := TRIM(' ' + p_rec.Event_Type_3);

				eventType1Desc := TRIM(' ' + FraudGovPlatform_Services.Functions.getKnownFraudCodeDescLookup(p_rec.Event_Type_1));
				eventType2Desc := TRIM(' ' + FraudGovPlatform_Services.Functions.getKnownFraudCodeDescLookup(p_rec.Event_Type_2));
				eventType3Desc := TRIM(' ' + FraudGovPlatform_Services.Functions.getKnownFraudCodeDescLookup(p_rec.Event_Type_3));

    RETURN TRIM(eventDates + eventType1 + eventType1Desc + eventType2 + eventType2Desc + eventType3 + eventType3Desc);
		
  END;

	EXPORT iesp.fraudgovplatform.t_FraudGovDeceased xform_deceased(DeathV2_Services.Layouts.BatchOut l) := TRANSFORM

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
	
	EXPORT iesp.fraudgovplatform.t_FraudGovOffense xform_offenses(CriminalRecords_BatchService.Layouts.Batch_Out l, 
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
	
	EXPORT iesp.fraudgovplatform.t_FraudGovCriminal xform_criminal(CriminalRecords_BatchService.Layouts.Batch_Out l,
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
		iesp.fraudgovplatform.t_FraudGovCase xform_cases() := TRANSFORM
																																																	
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
	
	EXPORT iesp.fraudgovplatform.t_FraudGovGlobalWatchlist xform_global_watchlist(Patriot.layout_batch_out l,
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

	EXPORT iesp.fraudgovplatform.t_FraudGovRedFlag xform_red_flag(FraudGovPlatform_Services.Layouts.combined_layouts l) := TRANSFORM		
		
		SELF.AddressDiscrepancyCodes := PROJECT(l.address_discrepancy_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.SuspiciousDocumentsCodes := PROJECT(l.suspicious_documents_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.SuspiciousAddressCodes := PROJECT(l.suspicious_address_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.SuspiciousSSNCodes := PROJECT(l.suspicious_ssn_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.SuspiciousDOBCodes := PROJECT(l.suspicious_dob_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.HighRiskAddressCodes := PROJECT(l.high_risk_address_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.SuspiciousPhoneCodes := PROJECT(l.suspicious_phone_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.SSNMultipleLastCodes := PROJECT(l.ssn_multiple_last_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.MissingInputCodes := PROJECT(l.missing_input_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.FraudAlertCodes := PROJECT(l.fraud_alert_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.CreditFreezeCodes := PROJECT(l.credit_freeze_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);
		SELF.IdentityTheftCodes := PROJECT(l.identity_theft_codes, iesp.fraudgovplatform.t_FraudGovIndDescPlusSequence);

	END;
	
	EXPORT iesp.fraudgovplatform.t_FraudGovVelocityCount xform_velocities(FraudGovPlatform_Services.Layouts.velocities l) := TRANSFORM		
		
		SELF.FoundCount := l.foundCnt;
		SELF.Description := l.description;
		// SELF.PayloadRecords:= PROJECT(l.ds_payload, TRANSFORM(FraudShared.Layouts_Key.Main, SELF := LEFT));
		
	END;
	
	EXPORT iesp.fraudgovplatform.t_FraudGovKnownRisk xform_known_frauds(FraudGovPlatform_Services.Layouts.KnownFrauds_rec l) := TRANSFORM		
    SELF.KnownRiskReasons := PROJECT(l.payload, TRANSFORM({iesp.share.t_StringArrayItem}, SELF.value := FraudGovPlatform_Services.Functions.getKnownFraudDescriptionFromPayload(LEFT.event_date,LEFT.event_end_date, LEFT.event_type_1, LEFT.event_type_2, LEFT.event_type_3)));		
		SELF.KnownRiskCount := COUNT(l.payload);
		// SELF.PayloadRecords := PROJECT(l.payload, TRANSFORM(FraudShared.Layouts_Key.Main, SELF := LEFT));

	END;
	
END;