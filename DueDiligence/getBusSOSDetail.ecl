import Address_Attributes, Business_Risk, BIPV2, BusReg, Business_Risk_BIP, DueDiligence, Corp2, Riskwise, Risk_Indicators, business_header;

/*
	Following Keys being used:
			Corp2.Key_LinkIDs.Corp.kfetch2
*/

EXPORT getBusSOSDetail(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
												Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
												BIPV2.mod_sources.iParams linkingOptions) := FUNCTION


	// ---------------[ Corporate Filings (SoS) Data ]----------------		
	corpFilings_raw := Corp2.Key_LinkIDs.Corp.kfetch2(DueDiligence.Common.GetLinkIDs(indata),
																										 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																										 0, // ScoreThreshold --> 0 = Give me everything
																										 Business_Risk_BIP.Constants.Limit_Default,
																										 Options.KeepLargeBusinesses);

	// Add back to Corp Filings our Seq numbers.
	DueDiligence.Common.AppendSeq(corpFilings_raw, indata, corpFilings_seq);
	
	// Filter out records after our history date.
	corpFilingsFiltRecs := DueDiligence.Common.FilterRecords(corpFilings_seq, dt_first_seen, dt_vendor_first_reported);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	clean_corpIncDt := DueDiligence.Common.CleanDateFields(corpFilingsFiltRecs, corp_inc_date);
	clean_corpFilingDt := DueDiligence.Common.CleanDateFields(clean_corpIncDt, corp_filing_date);
	clean_dateLastSeen := DueDiligence.Common.CleanDateFields(clean_corpFilingDt, dt_last_seen);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	corpFilingsFilt := clean_dateLastSeen;
	
	//get incorporation date
	incDateSort := SORT(corpFilingsFilt, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), corp_inc_date);
	incDateDedup := DEDUP(incDateSort, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), corp_inc_date);
	
	rollForIncDates := ROLLUP(incDateDedup, 
														LEFT.seq = RIGHT.seq AND
														LEFT.ultID = RIGHT.ultID AND
														LEFT.orgID = RIGHT.orgID AND
														LEFT.seleID = RIGHT.seleID,
														TRANSFORM({RECORDOF(corpFilingsFilt)},
																			SELF.corp_inc_date := IF((UNSIGNED)LEFT.corp_inc_date = 0, MAX(LEFT.corp_inc_date, RIGHT.corp_inc_date), MIN(LEFT.corp_inc_date, RIGHT.corp_inc_date));
																			SELF := LEFT;));
	
	addIncDate := JOIN(indata, rollForIncDates,
											LEFT.seq = RIGHT.seq AND
											LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
											LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
											LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
											TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																SELF.SOSIncorporationDate := (UNSIGNED)RIGHT.corp_inc_date;
																SELF := LEFT;),
											LEFT OUTER);
											
	//has corporation ever filed	
	corpFilingDateSort := SORT(corpFilingsFilt, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), corp_filing_date);
	corpFilingDateDedup := DEDUP(corpFilingDateSort, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), corp_filing_date);
	
	rollForCorpFilingDate := ROLLUP(corpFilingDateDedup, 
																	LEFT.seq = RIGHT.seq AND
																	LEFT.ultID = RIGHT.ultID AND
																	LEFT.orgID = RIGHT.orgID AND
																	LEFT.seleID = RIGHT.seleID,
																	TRANSFORM({RECORDOF(corpFilingsFilt)},
																						SELF.corp_filing_date := MAX(LEFT.corp_filing_date, RIGHT.corp_filing_date);
																						SELF := LEFT;));
	
	addEverFiled := JOIN(addIncDate, rollForCorpFilingDate,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																	SELF.filingDate := (UNSIGNED)RIGHT.corp_filing_date;
																	SELF.NoSOSFilingEver := IF((UNSIGNED)RIGHT.corp_filing_date > 0, FALSE, TRUE); //if a filing date is populated, corp filed at one point
																	SELF := LEFT;),
												LEFT OUTER);
	
	//get sos address location count
	corpAddrLocSort := DEDUP(SORT(corpFilingsFilt(corp_addr1_prim_name != '' AND corp_addr1_prim_name[1..6] != 'PO BOX'), seq, DueDiligence.Constants.mac_ListTop4Linkids()), 
													seq, DueDiligence.Constants.mac_ListTop4Linkids());

	corpAddrLocCount := TABLE(UNGROUP(corpAddrLocSort), {seq, ultID, orgID, seleID, unsigned3 addrLocCount := count(group)}, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()));		
	
	addBusnLocCnt := JOIN(addEverFiled, corpAddrLocCount, 
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
															SELF.SOSAddrLocationCount := RIGHT.addrLocCount,
															SELF  := LEFT),
												LEFT OUTER);
																								
	//retrieve SIC and NAIC codes with dates
	outCorpSic := DueDiligence.Common.getSicNaicCodes(corpFilingsFilt, corp_sic_code, TRUE, TRUE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_CORP);
	outCorpNaic := DueDiligence.Common.getSicNaicCodes(corpFilingsFilt, corp_naic_code, FALSE, TRUE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_CORP);
	
	allCorpSicNaic := outCorpSic + outCorpNaic;
	sortCorpRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(allCorpSicNaic);
		
	addCorpSicNaic := JOIN(addBusnLocCnt, sortCorpRollSicNaic,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.SicNaicSources := LEFT.SicNaicSources + RIGHT.sources;
																		SELF := LEFT;),
													LEFT OUTER);												
/*													
	//determine latest status and dates
	projectDates := PROJECT(corpFilingsFilt, TRANSFORM({UNSIGNED4 lastSeenDate, UNSIGNED4 lastReinstateDate, UNSIGNED4 lastDissolvedDate, UNSIGNED4 lastSuspensionDate, UNSIGNED4 firstSeenDate, STRING1 lastStatusCode, {RECORDOF(corpFilingsFilt)}},
																											corpStatusDescUC := stringlib.StringToUpperCase(LEFT.corp_status_desc);
																											corpStatusCd := MAP(business_header.is_ActiveCorp(LEFT.record_type, LEFT.corp_status_cd, LEFT.corp_status_desc) => DueDiligence.Constants.CORP_STATUS_ACTIVE,
																																					stringlib.stringfind(CorpStatusDescUC, 'GOOD STANDING', 1) != 0 => DueDiligence.Constants.CORP_STATUS_ACTIVE,
																																					stringlib.stringfind(CorpStatusDescUC, 'INACTIVE', 1) != 0 => DueDiligence.Constants.CORP_STATUS_INACTIVE,
																																					stringlib.stringfind(CorpStatusDescUC, 'DISSOLV', 1) != 0 => DueDiligence.Constants.CORP_STATUS_DISSOLVED,
																																					stringlib.stringfind(CorpStatusDescUC, 'DISSOLUTION', 1) != 0 => DueDiligence.Constants.CORP_STATUS_DISSOLVED,
																																					stringlib.stringfind(CorpStatusDescUC, 'REINSTAT', 1) != 0 => DueDiligence.Constants.CORP_STATUS_REINSTATE,
																																					stringlib.stringfind(CorpStatusDescUC, 'SUSPEN', 1) != 0 => DueDiligence.Constants.CORP_STATUS_SUSPEND,
																																					DueDiligence.Constants.COPR_STATUS_UNKNOWN);
										
																													
																												SELF.lastStatusCode := corpStatusCd;
																												SELF.lastDissolvedDate := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_DISSOLVED, LEFT.dt_last_seen, 0);
																												SELF.lastReinstateDate := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_REINSTATE, LEFT.dt_last_seen, 0);
																												SELF.lastSuspensionDate := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_SUSPEND, LEFT.dt_last_seen, 0);
																												SELF.lastSeenDate := LEFT.dt_last_seen;
																												SELF.firstSeenDate := LEFT.dt_first_seen;
																												SELF := LEFT;));
																																
	lastSeenSort := SORT(projectDates, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), corp_sos_charter_nbr, -dt_last_seen);
	
	rollLastSeen := ROLLUP(lastSeenSort,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID AND
													LEFT.corp_sos_charter_nbr = RIGHT.corp_sos_charter_nbr,
													TRANSFORM({RECORDOF(projectDates)},
																		SELF.lastStatusCode := LEFT.lastStatusCode;
																		//SELF.firstSeenDate := IF(LEFT.dt_first_seen = 0, MAX(LEFT.dt_first_seen, RIGHT.dt_first_seen), MIN(LEFT.dt_first_seen, RIGHT.dt_first_seen));
																		SELF.lastDissolvedDate := MAX(LEFT.lastDissolvedDate, RIGHT.lastDissolvedDate);
																		SELF.lastReinstateDate := MAX(LEFT.lastReinstateDate, RIGHT.lastReinstateDate);
																		SELF.lastSeenDate := MAX(LEFT.dt_last_seen, RIGHT.dt_last_seen);
																		SELF.lastSuspensionDate := MAX(LEFT.lastSuspensionDate, RIGHT.lastSuspensionDate);
																		SELF := LEFT;));
													
	firstSeenSort := SORT(projectDates, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), dt_first_seen);
	
	rollFirstSeen := ROLLUP(firstSeenSort,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID AND
													LEFT.corp_sos_charter_nbr = RIGHT.corp_sos_charter_nbr,
													TRANSFORM({RECORDOF(projectDates)},
																		SELF.firstSeenDate := IF(LEFT.dt_first_seen = 0, MAX(LEFT.dt_first_seen, RIGHT.dt_first_seen), MIN(LEFT.dt_first_seen, RIGHT.dt_first_seen));
																		// SELF.lastDissolvedDate := MAX(LEFT.lastDissolvedDate, RIGHT.lastDissolvedDate);
																		// SELF.lastReinstateDate := MAX(LEFT.lastReinstateDate, RIGHT.lastReinstateDate);
																		// SELF.lastSeenDate := MAX(LEFT.dt_last_seen, RIGHT.dt_last_seen);
																		// SELF.lastSuspensionDate := MAX(LEFT.lastSuspensionDate, RIGHT.lastSuspensionDate);
																		SELF := LEFT;));	
	
	
	latestStatusInfo := JOIN(rollLastSeen, rollFirstSeen,
														LEFT.seq = RIGHT.seq AND
														LEFT.ultID = RIGHT.ultID AND
														LEFT.orgID = RIGHT.orgID AND
														LEFT.seleID = RIGHT.seleID AND
														LEFT.corp_sos_charter_nbr = RIGHT.corp_sos_charter_nbr,
														TRANSFORM({RECORDOF(projectDates)},
																				SELF.firstSeenDate := RIGHT.firstSeenDate;
																				SELF := LEFT;));

	
	
	*/
	
	
	
	//has latest sos filing had an address, contact, or business change
	
	
	
	
	
	
	
	
	
	
	
	
	
	//add back all ids that did not have SOS record
	addSOS := JOIN(indata, addCorpSicNaic, 
									LEFT.seq = RIGHT.seq AND
									LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND
									LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND
									LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID,		
									TRANSFORM(DueDiligence.Layouts.Busn_Internal,
													SELF.SOSAddrLocationCount := RIGHT.SOSAddrLocationCount,
													SELF.CorpStateCount := RIGHT.CorpStateCount,
													SELF.addressChangeSOS := RIGHT.addressChangeSOS,
													SELF.lastCorpStatus := RIGHT.lastCorpStatus,
													SELF.NoSOSFilingEver := RIGHT.NoSOSFilingEver,
													SELF.filingDate := RIGHT.filingDate,
													SELF.lastReinstatDate := RIGHT.lastReinstatDate,
													SELF.lastDissolvedDate := RIGHT.lastDissolvedDate,
													SELF.SOSIncorporationDate := RIGHT.SOSIncorporationDate,
													SELF.SOSLastReported := RIGHT.SOSLastReported,
													SELF.contactChangeSOS := RIGHT.contactChangeSOS,
													SELF.BusnNameChangeSOS := RIGHT.BusnNameChangeSOS,
													SELF.SICNAICSources := RIGHT.SICNAICSources,
													SELF  := LEFT),
										LEFT OUTER);
													

	sortBusSOS := SORT(addSOS, seq, relatedDegree);
	rolledBusSOS := ROLLUP(sortBusSOS,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.SOSAddrLocationCount := LEFT.SOSAddrLocationCount + RIGHT.SOSAddrLocationCount; //add both inquired and linked bus counts to inquired bus
																			SELF := LEFT;));


	

	// OUTPUT(CorpFilings_raw, NAMED('CorpFilings_raw'));
	// OUTPUT(CorpFilings_seq, NAMED('CorpFilings_seq'));
	// OUTPUT(corpFilingsFilt, NAMED('corpFilingsFilt'));

	// OUTPUT(incDateSort, NAMED('incDateSort'));
	// OUTPUT(incDateDedup, NAMED('incDateDedup'));
	// OUTPUT(rollForIncDates, NAMED('rollForIncDates'));
	// OUTPUT(addIncDate, NAMED('addIncDate'));
	
	// OUTPUT(projectDates, NAMED('projectDates'));
	// OUTPUT(lastSeenSort, NAMED('lastSeenSort'));
	// OUTPUT(rollLastSeen, NAMED('rollLastSeen'));
	// OUTPUT(rollFirstSeen, NAMED('rollFirstSeen'));
	// OUTPUT(latestStatusInfo, NAMED('latestStatusInfo'));

	
		
	RETURN rolledBusSOS;
END;


  