IMPORT Business_Risk, BIPV2, Business_Risk_BIP, DueDiligence, Corp2, business_header, STD, UT;

/*
	Following Keys being used:
			Corp2.Key_LinkIDs.Corp.kfetch2
			Corp2.keys().cont.CorpKey.qa
*/

EXPORT getBusSOSDetail(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
												Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
												BIPV2.mod_sources.iParams linkingOptions,
												BOOLEAN includeReportData) := FUNCTION

	//add linked businesses
	linkedBus := DueDiligence.Common.getLinkedBusinesses(indata);
	
	allBusinesses := indata + linkedBus;

	// ---------------[ Corporate Filings (SoS) Data ]----------------		
	corpFilingsRaw := Corp2.Key_LinkIDs.Corp.kfetch2(DueDiligence.Common.GetLinkIDs(allBusinesses),
																										 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																										 0, // ScoreThreshold --> 0 = Give me everything
																										 Business_Risk_BIP.Constants.Limit_Default,
																										 Options.KeepLargeBusinesses);

	// Add back to Corp Filings our Seq numbers.
	corpFilingsSeq := DueDiligence.Common.AppendSeq(corpFilingsRaw, indata, TRUE);
		
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	corpFilingsCleanDate := DueDiligence.Common.CleanDatasetDateFields(corpFilingsSeq, 'dt_first_seen, dt_vendor_first_reported, corp_inc_date, corp_filing_date, dt_last_seen');
	
	// Filter out records after our history date.
	corpFilingsFilt := DueDiligence.Common.FilterRecords(corpFilingsCleanDate, dt_first_seen, dt_vendor_first_reported);
	
	//get incorporation date
	incDateSort := SORT(corpFilingsFilt(corp_inc_date <> 0), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_inc_date);
	incDateDedup := DEDUP(incDateSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	addIncDate := JOIN(indata, incDateDedup,
											LEFT.seq = RIGHT.seq AND
											LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
											LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
											LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
											TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																SELF.SOSIncorporationDate := (UNSIGNED)RIGHT.corp_inc_date;
																SELF := LEFT;),
											LEFT OUTER);
											
	//has corporation ever filed	
	corpFilingDateSort := SORT(corpFilingsFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_filing_date);
	corpFilingDateDedup := DEDUP(corpFilingDateSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_filing_date);
	
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
	
	//get sos address location count - should only have 1 address associated with proxID
	filtAddrLoc := corpFilingsFilt(corp_addr1_prim_name != DueDiligence.Constants.EMPTY AND REGEXFIND(DueDiligence.Constants.NOT_PO_ADDRESS_EXPRESSION, TRIM(corp_addr1_prim_name), NOCASE));
	corpAddrLocSort := SORT(filtAddrLoc, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop4Linkids()));
	corpAddrLocDedup := DEDUP(corpAddrLocSort, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop4Linkids()));

	corpAddrLocCount := TABLE(corpAddrLocDedup, {seq, ultID, UNSIGNED3 addrLocCount := COUNT(GROUP)}, seq, ultID);		
	
	addBusnLocCnt := JOIN(addEverFiled, corpAddrLocCount, 
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
												LEFT.relatedDegree = DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE,
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
															SELF.SOSAddrLocationCount := RIGHT.addrLocCount;
															SELF := LEFT;),
												LEFT OUTER);
																						
	//retrieve SIC and NAIC codes with dates
	outCorpSic := DueDiligence.Common.getSicNaicCodes(corpFilingsFilt, corp_sic_code, TRUE, TRUE, dt_first_seen, dt_last_seen);
	outCorpNaic := DueDiligence.Common.getSicNaicCodes(corpFilingsFilt, corp_naic_code, FALSE, TRUE, dt_first_seen, dt_last_seen);
	
	allCorpSicNaic := outCorpSic + outCorpNaic;
	sortCorpRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(addBusnLocCnt, allCorpSicNaic);
		
	addCorpSicNaic := JOIN(addBusnLocCnt, sortCorpRollSicNaic,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.SicNaicSources := RIGHT.sources;
																		SELF := LEFT;),
													LEFT OUTER);												
													
	//determine latest status and dates
	projectDates := PROJECT(corpFilingsFilt, TRANSFORM({UNSIGNED4 lastReinstateDate, BOOLEAN otherStatusExists, BOOLEAN dissolvedExists, BOOLEAN inactiveExists, Boolean suspendedExists, BOOLEAN allDissolveInactiveSuspended, BOOLEAN activeExists, BOOLEAN sosFilingExists, {RECORDOF(corpFilingsFilt)}},
																											corpStatusDescUC := STD.Str.ToUpperCase(LEFT.corp_status_desc);
																											corpStatusCd := MAP(business_header.is_ActiveCorp(LEFT.record_type, LEFT.corp_status_cd, LEFT.corp_status_desc) => DueDiligence.Constants.CORP_STATUS_ACTIVE,
																																					STD.Str.Find(CorpStatusDescUC, 'GOOD STANDING', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_ACTIVE,
																																					STD.Str.Find(CorpStatusDescUC, 'INACTIVE', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_INACTIVE,
																																					STD.Str.Find(CorpStatusDescUC, 'DISSOLV', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_DISSOLVED,
																																					STD.Str.Find(CorpStatusDescUC, 'DISSOLUTION', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_DISSOLVED,
																																					STD.Str.Find(CorpStatusDescUC, 'REINSTAT', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_REINSTATE,
																																					STD.Str.Find(CorpStatusDescUC, 'SUSPEN', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_SUSPEND,
																																					DueDiligence.Constants.COPR_STATUS_OTHER);
										
																												SELF.lastReinstateDate := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_REINSTATE, LEFT.dt_last_seen, DueDiligence.Constants.NUMERIC_ZERO);
																												SELF.activeExists := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_ACTIVE, TRUE, FALSE);
																												SELF.dissolvedExists := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_DISSOLVED, TRUE, FALSE);
																												SELF.inactiveExists := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_INACTIVE, TRUE, FALSE);
																												SELF.suspendedExists := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_SUSPEND, TRUE, FALSE);
																												SELF.allDissolveInactiveSuspended := IF(corpStatusCd IN [DueDiligence.Constants.CORP_STATUS_DISSOLVED, DueDiligence.Constants.CORP_STATUS_INACTIVE, DueDiligence.Constants.CORP_STATUS_SUSPEND], TRUE, FALSE);
																												SELF.otherStatusExists := IF(corpStatusCd = DueDiligence.Constants.COPR_STATUS_OTHER, TRUE, FALSE);
																												SELF.sosFilingExists := TRUE;
																												SELF := LEFT;));
																																
	lastSeenSort := SORT(projectDates, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, -dt_last_seen);
	
	rollLastSeen := ROLLUP(lastSeenSort,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,
													TRANSFORM({RECORDOF(LEFT)},
																		SELF.lastReinstateDate := MAX(LEFT.lastReinstateDate, RIGHT.lastReinstateDate);
																		SELF.activeExists := LEFT.activeExists OR RIGHT.activeExists;
																		SELF.dissolvedExists :=LEFT.dissolvedExists OR RIGHT.dissolvedExists;
																		SELF.inactiveExists := LEFT.inactiveExists OR RIGHT.inactiveExists;
																		SELF.suspendedExists := LEFT.suspendedExists OR RIGHT.suspendedExists;
																		SELF.allDissolveInactiveSuspended := LEFT.allDissolveInactiveSuspended AND RIGHT.allDissolveInactiveSuspended;
																		SELF.otherStatusExists := LEFT.otherStatusExists OR RIGHT.otherStatusExists;
																		SELF.sosFilingExists := LEFT.sosFilingExists OR RIGHT.sosFilingExists;
																		SELF := LEFT;));

	addSosStatusDates := JOIN(addCorpSicNaic, rollLastSeen,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.sosAllDissolveInactiveSuspend := RIGHT.allDissolveInactiveSuspended;
																			SELF.sosHasAtleastOneDissolvedFiling := RIGHT.dissolvedExists;					
																			SELF.sosHasAtleastOneInactiveFiling := RIGHT.inactiveExists;					
																			SELF.sosHasAtleastOneSuspendedFiling := RIGHT.suspendedExists;					
																			SELF.sosHasAtleastOneActiveFiling := RIGHT.activeExists;
																			SELF.sosHasAtleastOneOtherStatusFiling := RIGHT.otherStatusExists;
																			SELF.sosLastReinstateDate := RIGHT.lastReinstateDate;
																			SELF.sosFilingExists := RIGHT.sosFilingExists;
																			SELF := LEFT;),
														LEFT OUTER);

															
	//is the business incorporated in a state with loose incorporation laws
	projectLooseLaws := PROJECT(corpFilingsFilt, TRANSFORM({BOOLEAN looseLawState, RECORDOF(LEFT)}, 
																													SELF.looseLawState := LEFT.corp_inc_state IN DueDiligence.Constants.STATES_WITH_LOOSE_INCORPORATION_LAWS;
																													SELF := LEFT;
																													SELF := [];));
	
	sortLooseLaws := SORT(projectLooseLaws, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	rollLooseLaws := ROLLUP(sortLooseLaws,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,
													TRANSFORM({RECORDOF(LEFT)},
																			SELF.looseLawState := LEFT.looseLawState OR RIGHT.looseLawState;
																			SELF := LEFT;));
																			
	addIncLooseLaws := JOIN(addSosStatusDates, rollLooseLaws,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.incorpWithLooseLaws := LEFT.incorpWithLooseLaws OR RIGHT.looseLawState;
																		SELF := LEFT;),
													LEFT OUTER);
													


	//get all registered agent information
	sosAgent := corpFilingsFilt((corp_ra_cname1 <> DueDiligence.Constants.EMPTY OR corp_ra_lname1 <> DueDiligence.Constants.EMPTY) AND corp_ra_prim_name <> DueDiligence.Constants.EMPTY);
	sortSosAgent := SORT(sosAgent, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_ra_prim_range, corp_ra_predir, corp_ra_prim_name, corp_ra_addr_suffix, corp_ra_postdir, corp_ra_zip5, dt_first_seen);

	rollSosAgent := ROLLUP(sortSosAgent,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID AND
													LEFT.corp_ra_prim_range = RIGHT.corp_ra_prim_range AND
													LEFT.corp_ra_predir = RIGHT.corp_ra_predir AND
													LEFT.corp_ra_prim_name = RIGHT.corp_ra_prim_name AND
													LEFT.corp_ra_addr_suffix = RIGHT.corp_ra_addr_suffix AND
													LEFT.corp_ra_postdir = RIGHT.corp_ra_postdir AND
													LEFT.corp_ra_zip5 = RIGHT.corp_ra_zip5,
													TRANSFORM({RECORDOF(LEFT)},
																		 SELF.dt_last_seen := MAX(LEFT.dt_last_seen, RIGHT.dt_last_seen);
																		 SELF := LEFT;));
	
	projectSosAgent := PROJECT(rollSosAgent, TRANSFORM(DueDiligence.LayoutsInternal.Agent,
																											SELF.agent.source := DueDiligence.Constants.SOURCE_BUSINESS_CORP;
																											SELF.agent.prim_range := LEFT.corp_ra_prim_range;
																											SELF.agent.predir := LEFT.corp_ra_predir;
																											SELF.agent.prim_name := LEFT.corp_ra_prim_name;
																											SELF.agent.addr_suffix := LEFT.corp_ra_addr_suffix;
																											SELF.agent.postdir := LEFT.corp_ra_postdir;
																											SELF.agent.unit_desig := LEFT.corp_ra_unit_desig;
																											SELF.agent.sec_range := LEFT.corp_ra_sec_range;
																											SELF.agent.city := LEFT.corp_ra_v_city_name;
																											SELF.agent.state := LEFT.corp_ra_state;
																											SELF.agent.zip5 := LEFT.corp_ra_zip5;
																											SELF.agent.zip4 := LEFT.corp_ra_zip4;
																											SELF.agent.fullName := LEFT.corp_ra_cname1;
																											SELF.agent.firstName := LEFT.corp_ra_fname1;
																											SELF.agent.lastName := LEFT.corp_ra_lname1;
																											SELF.agent.dateFirstSeen := LEFT.dt_first_seen;
																											SELF.agent.dateLastSeen := LEFT.dt_last_seen;
																											SELF := LEFT;
																											SELF := [];));
																											
																											
	addAgents := DueDiligence.Common.AddAgents(projectSosAgent, addIncLooseLaws); 			
	
	

	// OUTPUT(indata, NAMED('indata'));
	// OUTPUT(linkedBus, NAMED('linkedBus'));
	// OUTPUT(allBusinesses, NAMED('allBusinesses'));
	// OUTPUT(corpFilingsRaw, NAMED('corpFilingsRaw'));
	// OUTPUT(corpFilingsSeq, NAMED('corpFilingsSeq'));
	// OUTPUT(corpFilingsFilt, NAMED('corpFilingsFilt'));

	// OUTPUT(incDateSort, NAMED('incDateSort'));
	// OUTPUT(incDateDedup, NAMED('incDateDedup'));
	// OUTPUT(addIncDate, NAMED('addIncDate'));
	
	// OUTPUT(filtAddrLoc, NAMED('filtAddrLoc'));
	// OUTPUT(corpAddrLocCount, NAMED('corpAddrLocCount'));
	// OUTPUT(addBusnLocCnt, NAMED('addBusnLocCnt'));
	
	// OUTPUT(projectDates, NAMED('projectDates'));
	// OUTPUT(lastSeenSort, NAMED('lastSeenSort'));
	// OUTPUT(rollLastSeen, NAMED('rollLastSeen'));
	// OUTPUT(addSosStatusDates, NAMED('addSosStatusDates'));

	// OUTPUT(projectLooseLaws, NAMED('projectLooseLaws'));
	// OUTPUT(rollLooseLaws, NAMED('rollLooseLaws'));
	// OUTPUT(addIncLooseLaws, NAMED('addIncLooseLaws'));

	// OUTPUT(sosAgent, NAMED('sosAgent'));	
	// OUTPUT(sortSosAgent, NAMED('sortSosAgent'));
	// OUTPUT(rollSosAgent, NAMED('rollSosAgent'));

	// OUTPUT(addAgents, NAMED('addAgentsSOS'));
	
	
		
	RETURN addAgents;
END;


  