import Address_Attributes, Business_Risk, BIPV2, BusReg, Business_Risk_BIP, DueDiligence, Corp2, Riskwise, Risk_Indicators, business_header;

/*
	Following Keys being used:
			BusReg.key_busreg_company_linkids.kFetch2
*/

EXPORT getBusRegistration(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
													Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
													BIPV2.mod_sources.iParams linkingOptions) := FUNCTION


	// ---------------- BusReg - Business Registration ------------------
	regBusRaw := BusReg.key_busreg_company_linkids.kFetch2(DueDiligence.Common.GetLinkIDs(indata),
																												 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																												 0, /*ScoreThreshold --> 0 = Give me everything*/
																												 Business_Risk_BIP.Constants.Limit_Default,
																												 Options.KeepLargeBusinesses);
	
	// Add back our Seq numbers
	DueDiligence.Common.AppendSeq(regBusRaw, indata, regBusSeq);

	// Filter out records after our history date.
	regBusFiltRec := DueDiligence.Common.FilterRecords(regBusSeq, dt_first_seen, dt_vendor_first_reported);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	cleanRB_recordDt := DueDiligence.Common.CleanDateFields(regBusFiltRec, record_date);
	cleanRB_dateLastSeen := DueDiligence.Common.CleanDateFields(cleanRB_recordDt, dt_last_seen);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	regBusFilt := cleanRB_dateLastSeen;
	
	//sort current registered business
	regBusSort := SORT(regBusFilt, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), -record_date);
	regBusDedup := DEDUP(regBusSort, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), record_date);
	
	rollForRegBusHit := ROLLUP(regBusDedup, 
															LEFT.seq = RIGHT.seq AND
															LEFT.ultID = RIGHT.ultID AND
															LEFT.orgID = RIGHT.orgID AND
															LEFT.seleID = RIGHT.seleID,
															TRANSFORM({RECORDOF(regBusFilt)},
																				SELF := LEFT;));
	
	addRegBusHit := JOIN(indata, rollForRegBusHit,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																	SELF.BusRegHit := IF(RIGHT.br_id <> 0, TRUE, FALSE);
																	SELF := LEFT;),
												LEFT OUTER);
												
	//retrieve SIC and NAIC codes with dates
	outRegBusSic := DueDiligence.Common.getSicNaicCodes(regBusFilt, RawFields.SIC, TRUE, TRUE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_REGISTRATION);
	outRegBusNaic := DueDiligence.Common.getSicNaicCodes(regBusFilt, RawFields.NAICS, FALSE, TRUE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_REGISTRATION);
	
	allRegBusSicNaic := outRegBusSic + outRegBusNaic;
	sortRegBusRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(allRegBusSicNaic);
		
	addRegBusSicNaic := JOIN(addRegBusHit, sortRegBusRollSicNaic,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.SicNaicSources := LEFT.SicNaicSources + RIGHT.sources;
																			SELF := LEFT;),
														LEFT OUTER);					
	


	// OUTPUT(outRegBusSic, NAMED('outRegBusSic'));
	// OUTPUT(outRegBusNaic, NAMED('outRegBusNaic'));
	// OUTPUT(allRegBusSicNaic, NAMED('allRegBusSicNaic'));
	// OUTPUT(sortRegBusRollSicNaic, NAMED('sortRegBusRollSicNaic'));
	// OUTPUT(addRegBusSicNaic, NAMED('addRegBusSicNaic'));	
	// OUTPUT(projectDateLastSeen, NAMED('projectDateLastSeen'));
	// OUTPUT(dateLastSeenSort, NAMED('dateLastSeenSort'));
	// OUTPUT(rollDateLastSeen, NAMED('rollDateLastSeen'));
	
	RETURN addRegBusSicNaic;
	END;