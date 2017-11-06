﻿IMPORT Business_Risk, BIPV2, Business_Risk_BIP, DueDiligence, Corp2, business_header, STD, UT;

/*
	Following Keys being used:
			Corp2.Key_LinkIDs.Corp.kfetch2
			Corp2.keys().cont.CorpKey.qa
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
	filtAddrLoc := corpFilingsFilt(corp_addr1_prim_name != '' AND corp_addr1_prim_name[1..6] != 'PO BOX');
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
													
	//determine latest status and dates
	projectDates := PROJECT(corpFilingsFilt, TRANSFORM({UNSIGNED4 lastReinstateDate, BOOLEAN otherStatusExists, BOOLEAN dissolvedExists, BOOLEAN inactiveExists, Boolean suspendedExists, BOOLEAN allDissolveInactiveSuspended, BOOLEAN activeExists, BOOLEAN sosFilingExists, {RECORDOF(corpFilingsFilt)}},
																											corpStatusDescUC := STD.Str.ToUpperCase(LEFT.corp_status_desc);
																											corpStatusCd := MAP(business_header.is_ActiveCorp(LEFT.record_type, LEFT.corp_status_cd, LEFT.corp_status_desc) => DueDiligence.Constants.CORP_STATUS_ACTIVE,
																																					STD.Str.Find(CorpStatusDescUC, 'GOOD STANDING', 1) != 0 => DueDiligence.Constants.CORP_STATUS_ACTIVE,
																																					STD.Str.Find(CorpStatusDescUC, 'INACTIVE', 1) != 0 => DueDiligence.Constants.CORP_STATUS_INACTIVE,
																																					STD.Str.Find(CorpStatusDescUC, 'DISSOLV', 1) != 0 => DueDiligence.Constants.CORP_STATUS_DISSOLVED,
																																					STD.Str.Find(CorpStatusDescUC, 'DISSOLUTION', 1) != 0 => DueDiligence.Constants.CORP_STATUS_DISSOLVED,
																																					STD.Str.Find(CorpStatusDescUC, 'REINSTAT', 1) != 0 => DueDiligence.Constants.CORP_STATUS_REINSTATE,
																																					STD.Str.Find(CorpStatusDescUC, 'SUSPEN', 1) != 0 => DueDiligence.Constants.CORP_STATUS_SUSPEND,
																																					DueDiligence.Constants.COPR_STATUS_OTHER);
										
																												SELF.lastReinstateDate := IF(corpStatusCd = DueDiligence.Constants.CORP_STATUS_REINSTATE, LEFT.dt_last_seen, 0);
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

	//has a business name or address change within the last year
	businessWithinOneYear := corpFilingsFilt(DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)dt_last_seen, (STRING)historyDate) <= ut.DaysInNYears(1));		
	
	sortPopBusAddresses := SORT(businessWithinOneYear(corp_addr1_prim_name <> ''), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, corp_addr1_prim_range, 
																corp_addr1_predir, corp_addr1_prim_name, corp_addr1_addr_suffix, corp_addr1_postdir, corp_addr1_unit_desig, corp_addr1_sec_range, 
																corp_addr1_v_city_name, corp_addr1_state, corp_addr1_zip5, corp_addr1_zip4);

	uniquePopBusAddresses := TABLE(sortPopBusAddresses, {BOOLEAN nameChg := FALSE, BOOLEAN addrChg := FALSE, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), 
																												corp_sos_charter_nbr, UNSIGNED nameCount := 0, UNSIGNED addrCount := COUNT(GROUP)},  
																	seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, corp_addr1_prim_range, corp_addr1_predir, 
																	corp_addr1_prim_name, corp_addr1_addr_suffix, corp_addr1_postdir, corp_addr1_unit_desig, corp_addr1_sec_range, 
																	corp_addr1_v_city_name, corp_addr1_state, corp_addr1_zip5, corp_addr1_zip4);
	
	sortPopBusName := SORT(businessWithinOneYear, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, corp_legal_name);
	
	uniquePopBusName := TABLE(sortPopBusName, {BOOLEAN nameChg := FALSE, BOOLEAN addrChg := FALSE, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), 
																							corp_sos_charter_nbr, UNSIGNED nameCount := COUNT(GROUP), UNSIGNED addrCount := 0}, 
														seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, corp_legal_name);

	combineBusiness := SORT(uniquePopBusAddresses + uniquePopBusName, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, nameCount, addrCount);
	
	rollBusCounts := ROLLUP(combineBusiness,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID AND 
													LEFT.corp_sos_charter_nbr = RIGHT.corp_sos_charter_nbr,
													TRANSFORM({RECORDOF(LEFT)},
																			SELF.nameChg := LEFT.nameChg OR (LEFT.nameCount > 0 AND RIGHT.nameCount > 0);
																			SELF.addrChg := LEFT.addrChg OR (LEFT.addrCount > 0 AND RIGHT.addrCount > 0);
																			SELF.nameCount := LEFT.nameCount + RIGHT.nameCount;
																			SELF.addrCount := LEFT.addrCount + RIGHT.addrCount;
																			SELF := LEFT;));

	rollBusChanges := ROLLUP(rollBusCounts,
														LEFT.seq = RIGHT.seq AND
														LEFT.ultID = RIGHT.ultID AND
														LEFT.orgID = RIGHT.orgID AND
														LEFT.seleID = RIGHT.seleID,
														TRANSFORM({RECORDOF(LEFT)},
																			SELF.addrChg := LEFT.addrChg OR RIGHT.addrChg;																															
																			SELF.nameChg := LEFT.nameChg OR RIGHT.nameChg;
																			SELF := LEFT;));
	
	addBusAddrNameChanges := JOIN(addSosStatusDates, rollBusChanges,
																LEFT.seq = RIGHT.seq AND
																LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
																TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																					SELF.sosBusNameChange := RIGHT.nameChg;
																					SELF.sosBusAddressChange := RIGHT.addrChg;
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
																			
	addIncLooseLaws := JOIN(addBusAddrNameChanges, rollLooseLaws,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.incorpWithLooseLaws := LEFT.incorpWithLooseLaws OR RIGHT.looseLawState;
																		SELF := LEFT;),
													LEFT OUTER);
													

	
	
	//get contact information linked to corp keys
	contactsRaw := JOIN(corpFilingsFilt, Corp2.keys().cont.CorpKey.qa,
											KEYED(LEFT.corp_key = RIGHT.corp_key) AND
											KEYED(LEFT.record_type = RIGHT.record_type) AND
											LEFT.ultID = RIGHT.ultID AND
											LEFT.orgID = RIGHT.orgID AND
											LEFT.seleID = RIGHT.seleID,
											TRANSFORM({UNSIGNED4 uniqueID, RECORDOF(RIGHT)},
																	SELF.uniqueID := LEFT.seq;
																	SELF := RIGHT;),
											ATMOST(100));
																
	// Add back to Corp Filings our Seq numbers.
	DueDiligence.Common.AppendSeq(contactsRaw, indata, contactsRaw_seq);
	
	// Filter out records after our history date.
	contactFiltRecs := DueDiligence.Common.FilterRecords(contactsRaw_seq, dt_first_seen, dt_vendor_first_reported);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	clean_contactDateLastSeen := DueDiligence.Common.CleanDateFields(contactFiltRecs, dt_last_seen);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	contactFilt := clean_contactDateLastSeen;	
	
	contacts := contactFilt(cont_type_cd = DueDiligence.Constants.CONTACT_TYPE_CONTACT);
	
	//has contact name or address change within the last year
	contactWithinOneYear := contacts(DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)dt_last_seen, (STRING)historyDate) <= ut.DaysInNYears(1));	
	
	sortPopContAddresses := SORT(contactWithinOneYear(cont_prim_name <> ''), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, cont_prim_range, 
																cont_predir, cont_prim_name, cont_addr_suffix, cont_postdir, cont_unit_desig, cont_sec_range, 
																cont_v_city_name, cont_state, cont_zip5, cont_zip4);

	uniquePopContAddresses := TABLE(sortPopContAddresses, {BOOLEAN nameChg := FALSE, BOOLEAN addrChg := FALSE, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), 
																													corp_sos_charter_nbr, UNSIGNED nameCount := 0, UNSIGNED addrCount := COUNT(GROUP)},  
																	seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, cont_prim_range, 
																cont_predir, cont_prim_name, cont_addr_suffix, cont_postdir, cont_unit_desig, cont_sec_range, 
																cont_v_city_name, cont_state, cont_zip5, cont_zip4);
																
	sortPopContName := SORT(contactWithinOneYear, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, cont_fname, cont_mname, cont_lname);

	uniquePopContName := TABLE(sortPopContAddresses, {BOOLEAN nameChg := FALSE, BOOLEAN addrChg := FALSE, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), 
																													corp_sos_charter_nbr, UNSIGNED nameCount := COUNT(GROUP), UNSIGNED addrCount := 0},  
															seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), cont_fname, cont_mname, cont_lname, corp_sos_charter_nbr);
																	
	combineContacts := SORT(uniquePopContAddresses + uniquePopContName, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, nameCount, addrCount);																
	
	rollContCounts := ROLLUP(combineContacts,
														LEFT.seq = RIGHT.seq AND
														LEFT.ultID = RIGHT.ultID AND
														LEFT.orgID = RIGHT.orgID AND
														LEFT.seleID = RIGHT.seleID AND 
														LEFT.corp_sos_charter_nbr = RIGHT.corp_sos_charter_nbr,
														TRANSFORM({RECORDOF(LEFT)},
																				SELF.nameChg := LEFT.nameChg OR (LEFT.nameCount > 0 AND RIGHT.nameCount > 0);
																				SELF.addrChg := LEFT.addrChg OR (LEFT.addrCount > 0 AND RIGHT.addrCount > 0);
																				SELF.nameCount := LEFT.nameCount + RIGHT.nameCount;
																				SELF.addrCount := LEFT.addrCount + RIGHT.addrCount;
																				SELF := LEFT;));
	
	rollContChanges := ROLLUP(rollContCounts,
														LEFT.seq = RIGHT.seq AND
														LEFT.ultID = RIGHT.ultID AND
														LEFT.orgID = RIGHT.orgID AND
														LEFT.seleID = RIGHT.seleID,
														TRANSFORM({RECORDOF(LEFT)},
																			SELF.addrChg := LEFT.addrChg OR RIGHT.addrChg;
																			SELF.nameChg := LEFT.nameChg OR RIGHT.nameChg;
																			SELF := LEFT;));
	
	addContactAddrNameChanges := JOIN(addIncLooseLaws, rollContChanges,
																		LEFT.seq = RIGHT.seq AND
																		LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																		LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																		LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
																		TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																							SELF.sosContactNameChange := RIGHT.addrChg;
																							SELF.sosContactAddressChange := RIGHT.nameChg;
																							SELF := LEFT;),
																		LEFT OUTER);													





	//get all registered agent information
	sosAgent := corpFilingsFilt((corp_ra_cname1 <> '' OR corp_ra_lname1 <> '') AND corp_ra_prim_name <> '');
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
	
	projectSosAgent := PROJECT(rollSosAgent, TRANSFORM(DueDiligence.LayoutsInternal.AgentLayout,
																											SELF.ultID := LEFT.ultID;
																											SELF.orgID := LEFT.orgID;
																											SELF.seleID := LEFT.seleID;
																											SELF.proxID := LEFT.proxID;
																											SELF.powID := LEFT.powID;
																											SELF.agents := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.LayoutAgent,
																																															SELF.source := DueDiligence.Constants.SOURCE_BUSINESS_CORP;
																																															SELF.prim_range := LEFT.corp_ra_prim_range;
																																															SELF.predir := LEFT.corp_ra_predir;
																																															SELF.prim_name := LEFT.corp_ra_prim_name;
																																															SELF.addr_suffix := LEFT.corp_ra_addr_suffix;
																																															SELF.postdir := LEFT.corp_ra_postdir;
																																															SELF.unit_desig := LEFT.corp_ra_unit_desig;
																																															SELF.sec_range := LEFT.corp_ra_sec_range;
																																															SELF.city := LEFT.corp_ra_v_city_name;
																																															SELF.state := LEFT.corp_ra_state;
																																															SELF.zip5 := LEFT.corp_ra_zip5;
																																															SELF.zip4 := LEFT.corp_ra_zip4;
																																															SELF.fullName := LEFT.corp_ra_cname1;
																																															SELF.firstName := LEFT.corp_ra_fname1;
																																															SELF.lastName := LEFT.corp_ra_lname1;
																																															SELF.dateFirstSeen := LEFT.dt_first_seen;
																																															SELF.dateLastSeen := LEFT.dt_last_seen;
																																															SELF := [];));
																											SELF := LEFT;
																											SELF := [];));
																											
	rollAgents := ROLLUP(projectSosAgent,
												LEFT.seq = RIGHT.seq AND
												LEFT.ultID = RIGHT.ultID AND
												LEFT.orgID = RIGHT.orgID AND
												LEFT.seleID = RIGHT.seleID,
												TRANSFORM(DueDiligence.LayoutsInternal.AgentLayout,
																	SELF.agents := LEFT.agents + RIGHT.agents;
																	SELF := LEFT;));
																	
	addRegisteredAgents := JOIN(addContactAddrNameChanges, rollAgents,
															LEFT.seq = RIGHT.seq AND
															LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
															LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
															LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
															TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																				SELF.registeredAgentExists := LEFT.registeredAgentExists OR EXISTS(RIGHT.agents);
																				SELF.registeredAgents := LEFT.registeredAgents + RIGHT.agents;
																				SELF := LEFT;),
															LEFT OUTER);
																																																		

	
		

	// OUTPUT(CorpFilings_raw, NAMED('CorpFilings_raw'));
	// OUTPUT(CorpFilings_seq, NAMED('CorpFilings_seq'));
	// OUTPUT(corpFilingsFilt, NAMED('corpFilingsFilt'));

	// OUTPUT(incDateSort, NAMED('incDateSort'));
	// OUTPUT(incDateDedup, NAMED('incDateDedup'));
	// OUTPUT(addIncDate, NAMED('addIncDate'));
	
	// OUTPUT(corpAddrLocCount, NAMED('corpAddrLocCount'));
	// OUTPUT(addBusnLocCnt, NAMED('addBusnLocCnt'));
	
	// OUTPUT(projectDates, NAMED('projectDates'));
	// OUTPUT(lastSeenSort, NAMED('lastSeenSort'));
	// OUTPUT(lastSeenDedup, NAMED('lastSeenDedup'));
	// OUTPUT(rollLastSeen, NAMED('rollLastSeen'));
	// OUTPUT(addSosStatusDates, NAMED('addSosStatusDates'));
	
	// OUTPUT(businessWithinOneYear, NAMED('businessWithinOneYear'));
	// OUTPUT(sortPopBusAddresses, NAMED('sortPopBusAddresses'));
	// OUTPUT(uniquePopBusAddresses, NAMED('uniquePopBusAddresses'));
	// OUTPUT(sortPopBusName, NAMED('sortPopBusName'));
	// OUTPUT(uniquePopBusName, NAMED('uniquePopBusName'));
	// OUTPUT(combineBusiness, NAMED('combineBusiness'));
	// OUTPUT(rollCounts, NAMED('rollCounts'));
	// OUTPUT(addBusAddrNameChanges, NAMED('addBusAddrNameChanges'));

	// OUTPUT(projectLooseLaws, NAMED('projectLooseLaws'));
	// OUTPUT(rollLooseLaws, NAMED('rollLooseLaws'));
	// OUTPUT(addIncLooseLaws, NAMED('addIncLooseLaws'));
	
	// OUTPUT(contactsRaw, NAMED('contactsRaw'));
	// OUTPUT(contactsRaw_seq, NAMED('contactsRaw_seq'));
	// OUTPUT(contactFiltRecs, NAMED('contactFiltRecs'));
	// OUTPUT(contactFilt, NAMED('contactFilt'));
	
	// OUTPUT(contactWithinOneYear, NAMED('contactWithinOneYear'));
	// OUTPUT(sortPopContAddresses, NAMED('sortPopContAddresses'));
	// OUTPUT(uniquePopContAddresses, NAMED('uniquePopContAddresses'));
	// OUTPUT(sortPopContName, NAMED('sortPopContName'));
	// OUTPUT(uniquePopContName, NAMED('uniquePopContName'));
	// OUTPUT(combineContacts, NAMED('combineContacts'));
	// OUTPUT(rollContCounts, NAMED('rollContCounts'));
	// OUTPUT(rollContChanges, NAMED('rollContChanges'));
	// OUTPUT(addContactAddrNameChanges, NAMED('addContactAddrNameChanges'));
	
	// OUTPUT(sosAgent, NAMED('sosAgent'));	
	// OUTPUT(sortSosAgent, NAMED('sortSosAgent'));
	// OUTPUT(rollSosAgent, NAMED('rollSosAgent'));
	// OUTPUT(projectSosAgent, NAMED('projectSosAgent'));
	// OUTPUT(rollAgents, NAMED('rollAgents'));
	// OUTPUT(addRegisteredAgents, NAMED('addRegisteredAgents'));
	
	
		
	RETURN addRegisteredAgents;
END;


  