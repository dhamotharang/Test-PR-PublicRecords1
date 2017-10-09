IMPORT Address_Attributes, Business_Risk, BIPV2, BusReg, Business_Risk_BIP, DueDiligence, Corp2, Riskwise, Risk_Indicators, business_header, TopBusiness_Services, Corp2_services;

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
	incDateSort := SORT(corpFilingsFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_inc_date);
	incDateDedup := DEDUP(incDateSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_inc_date);
	
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
	
	//get sos address location count
	corpAddrLocSort := DEDUP(SORT(corpFilingsFilt(corp_addr1_prim_name != '' AND corp_addr1_prim_name[1..6] != 'PO BOX'), seq, #EXPAND(BIPV2.IDmacros.mac_ListTop4Linkids())), 
													seq, #EXPAND(BIPV2.IDmacros.mac_ListTop4Linkids()));

	corpAddrLocCount := TABLE(UNGROUP(corpAddrLocSort), {seq, ultID, orgID, seleID, unsigned3 addrLocCount := count(group)}, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));		
	
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
													
	//determine latest status and dates
	projectDates := PROJECT(corpFilingsFilt, TRANSFORM({UNSIGNED4 lastReinstateDate, BOOLEAN otherStatusExists, BOOLEAN dissolvedExists, BOOLEAN inactiveExists, Boolean suspendedExists, BOOLEAN allDissolveInactiveSuspended, BOOLEAN activeExists, BOOLEAN sosFilingExists, {RECORDOF(corpFilingsFilt)}},
																											corpStatusDescUC := stringlib.StringToUpperCase(LEFT.corp_status_desc);
																											corpStatusCd := MAP(business_header.is_ActiveCorp(LEFT.record_type, LEFT.corp_status_cd, LEFT.corp_status_desc) => DueDiligence.Constants.CORP_STATUS_ACTIVE,
																																					stringlib.stringfind(CorpStatusDescUC, 'GOOD STANDING', 1) != 0 => DueDiligence.Constants.CORP_STATUS_ACTIVE,
																																					stringlib.stringfind(CorpStatusDescUC, 'INACTIVE', 1) != 0 => DueDiligence.Constants.CORP_STATUS_INACTIVE,
																																					stringlib.stringfind(CorpStatusDescUC, 'DISSOLV', 1) != 0 => DueDiligence.Constants.CORP_STATUS_DISSOLVED,
																																					stringlib.stringfind(CorpStatusDescUC, 'DISSOLUTION', 1) != 0 => DueDiligence.Constants.CORP_STATUS_DISSOLVED,
																																					stringlib.stringfind(CorpStatusDescUC, 'REINSTAT', 1) != 0 => DueDiligence.Constants.CORP_STATUS_REINSTATE,
																																					stringlib.stringfind(CorpStatusDescUC, 'SUSPEN', 1) != 0 => DueDiligence.Constants.CORP_STATUS_SUSPEND,
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
													TRANSFORM({RECORDOF(lastSeenSort)},
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

	//has latest sos filing had a business name or address change
	sortLatestChanges := SORT(corpFilingsFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, -dt_last_seen);
	dedupLatestChanges := DEDUP(sortLatestChanges, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_sos_charter_nbr, KEEP 2);
	
	projectBusLatestChanges := PROJECT(dedupLatestChanges, TRANSFORM({BOOLEAN busAdrChg, BOOLEAN busNameChg, {RECORDOF(dedupLatestChanges)}}, SELF := LEFT; SELF := [];));
	
	rollBusLatestChanges := ROLLUP(projectBusLatestChanges,
																	LEFT.seq = RIGHT.seq AND
																	LEFT.ultID = RIGHT.ultID AND
																	LEFT.orgID = RIGHT.orgID AND
																	LEFT.seleID = RIGHT.seleID AND
																	LEFT.corp_sos_charter_nbr = RIGHT.corp_sos_charter_nbr,
																	TRANSFORM({RECORDOF(projectBusLatestChanges)},
																						SELF.busAdrChg := LEFT.corp_addr1_prim_range <> RIGHT.corp_addr1_prim_range OR
																															LEFT.corp_addr1_predir <> RIGHT.corp_addr1_predir OR
																															LEFT.corp_addr1_prim_name <> RIGHT.corp_addr1_prim_name OR
																															LEFT.corp_addr1_addr_suffix <> RIGHT.corp_addr1_addr_suffix OR
																															LEFT.corp_addr1_postdir <> RIGHT.corp_addr1_postdir OR
																															LEFT.corp_addr1_unit_desig <> RIGHT.corp_addr1_unit_desig OR
																															LEFT.corp_addr1_sec_range <> RIGHT.corp_addr1_sec_range OR
																															LEFT.corp_addr1_v_city_name	<> RIGHT.corp_addr1_v_city_name OR
																															LEFT.corp_addr1_state <> RIGHT.corp_addr1_state OR
																															LEFT.corp_addr1_zip5 <> RIGHT.corp_addr1_zip5 OR
																															LEFT.corp_addr1_zip4 <> RIGHT.corp_addr1_zip4;
																															
																						SELF.busNameChg := LEFT.corp_legal_name <> RIGHT.corp_legal_name;
																						SELF := LEFT;));
																				
	rollBusLatestChangesByID := ROLLUP(rollBusLatestChanges,
																			LEFT.seq = RIGHT.seq AND
																			LEFT.ultID = RIGHT.ultID AND
																			LEFT.orgID = RIGHT.orgID AND
																			LEFT.seleID = RIGHT.seleID,
																			TRANSFORM({RECORDOF(rollBusLatestChanges)},
																								SELF.busAdrChg := LEFT.busAdrChg OR RIGHT.busAdrChg;
																								SELF.busNameChg := LEFT.busNameChg OR RIGHT.busNameChg;
																								SELF := LEFT;));
	
	addBusAddrNameChanges := JOIN(addSosStatusDates, rollBusLatestChangesByID,
																LEFT.seq = RIGHT.seq AND
																LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
																TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																					SELF.sosBusNameChange := RIGHT.busNameChg;
																					SELF.sosBusAddressChange := RIGHT.busAdrChg;
																					SELF := LEFT;),
																LEFT OUTER);


	//has latest sos filing had a contact name or address change
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
																				
	sortContacts := SORT(contactFilt(cont_type_cd = DueDiligence.Constants.CONTACT_TYPE_CONTACT), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_key, -dt_last_seen);
	dedupContacts := DEDUP(sortContacts, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), corp_key, keep 2);
	
	projectContacts := PROJECT(dedupContacts, TRANSFORM({BOOLEAN contactAdrChg, BOOLEAN contactNameChg, {RECORDOF(dedupContacts)}}, SELF := LEFT; SELF := [];));
	
	rollContactChanges := ROLLUP(projectContacts,
																LEFT.seq = RIGHT.seq AND
																LEFT.ultID = RIGHT.ultID AND
																LEFT.orgID = RIGHT.orgID AND
																LEFT.seleID = RIGHT.seleID AND
																LEFT.corp_key = RIGHT.corp_key,
																TRANSFORM({RECORDOF(projectContacts)},																				
																				SELF.contactAdrChg := LEFT.cont_prim_range <> RIGHT.cont_prim_range OR
																															LEFT.cont_predir <> RIGHT.cont_predir OR
																															LEFT.cont_prim_name <> RIGHT.cont_prim_name OR
																															LEFT.cont_addr_suffix <> RIGHT.cont_addr_suffix OR
																															LEFT.cont_postdir <> RIGHT.cont_postdir OR
																															LEFT.cont_unit_desig <> RIGHT.cont_unit_desig OR
																															LEFT.cont_sec_range <> RIGHT.cont_sec_range OR
																															LEFT.cont_v_city_name	<> RIGHT.cont_v_city_name OR
																															LEFT.cont_state <> RIGHT.cont_state OR
																															LEFT.cont_zip5 <> RIGHT.cont_zip5 OR
																															LEFT.cont_zip4 <> RIGHT.cont_zip4;
																				
																				SELF.contactNameChg := LEFT.cont_fname <> RIGHT.cont_fname OR
																															 LEFT.cont_mname <> RIGHT.cont_mname OR
																															 LEFT.cont_lname <> RIGHT.cont_lname;
																				SELF := LEFT;));
	
	rollContactsByID := ROLLUP(rollContactChanges,
															LEFT.seq = RIGHT.seq AND
															LEFT.ultID = RIGHT.ultID AND
															LEFT.orgID = RIGHT.orgID AND
															LEFT.seleID = RIGHT.seleID,
															TRANSFORM({RECORDOF(rollContactChanges)},
																				SELF.contactAdrChg := LEFT.contactAdrChg OR RIGHT.contactAdrChg;
																				SELF.contactNameChg := LEFT.contactNameChg OR RIGHT.contactNameChg;
																				SELF := LEFT;));
	
	addContactAddrNameChanges := JOIN(addBusAddrNameChanges, rollContactsByID,
																		LEFT.seq = RIGHT.seq AND
																		LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																		LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																		LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
																		TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																							SELF.sosContactNameChange := RIGHT.contactAdrChg;
																							SELF.sosContactAddressChange := RIGHT.contactNameChg;
																							SELF := LEFT;),
																		LEFT OUTER);
	



	//add back all ids that did not have SOS record
	addSOS := JOIN(indata, addContactAddrNameChanges, 
									LEFT.seq = RIGHT.seq AND
									LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND
									LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND
									LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID,		
									TRANSFORM(DueDiligence.Layouts.Busn_Internal,
													SELF.SOSAddrLocationCount := RIGHT.SOSAddrLocationCount;
													SELF.NoSOSFilingEver := RIGHT.NoSOSFilingEver;
													SELF.filingDate := RIGHT.filingDate;
													SELF.SOSIncorporationDate := RIGHT.SOSIncorporationDate;
													SELF.SICNAICSources := RIGHT.SICNAICSources;
													SELF.sosFilingExists := RIGHT.sosFilingExists;
													SELF.sosAllDissolveInactiveSuspend := RIGHT.sosAllDissolveInactiveSuspend;
													SELF.sosHasAtleastOneDissolvedFiling := RIGHT.sosHasAtleastOneDissolvedFiling;					
													SELF.sosHasAtleastOneInactiveFiling := RIGHT.sosHasAtleastOneInactiveFiling;					
													SELF.sosHasAtleastOneSuspendedFiling := RIGHT.sosHasAtleastOneSuspendedFiling;
													SELF.sosHasAtleastOneOtherStatusFiling := RIGHT.sosHasAtleastOneOtherStatusFiling;
													SELF.sosHasAtleastOneActiveFiling := RIGHT.sosHasAtleastOneActiveFiling;
													SELF.sosLastReinstateDate := RIGHT.sosLastReinstateDate;
													SELF.sosBusNameChange := RIGHT.sosBusNameChange;
													SELF.sosBusAddressChange := RIGHT.sosBusAddressChange;
													SELF.sosContactNameChange := RIGHT.sosContactNameChange;
													SELF.sosContactAddressChange := RIGHT.sosContactAddressChange;
													SELF  := LEFT;),
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
	// OUTPUT(lastSeenDedup, NAMED('lastSeenDedup'));
	// OUTPUT(rollLastSeen, NAMED('rollLastSeen'));
	// OUTPUT(addSosStatusDates, NAMED('addSosStatusDates'));
	
	// OUTPUT(sortBusLatestChanges, NAMED('sortLatestChanges'));
	// OUTPUT(dedupBusLatestChanges, NAMED('dedupLatestChanges'));
	// OUTPUT(projectBusLatestChanges, NAMED('projectLatestChanges'));
	// OUTPUT(rollBusLatestChanges, NAMED('rollLatestChanges'));
	// OUTPUT(rollBusLatestChangesByID, NAMED('rollLatestChangesByID'));
	// OUTPUT(adddBusAddrNameChanges, NAMED('addAddrNameChanges'));
	
	// OUTPUT(contactsRaw, NAMED('contactsRaw'));
	// OUTPUT(contactsRaw_seq, NAMED('contactsRaw_seq'));
	// OUTPUT(contactFiltRecs, NAMED('contactFiltRecs'));
	// OUTPUT(contactFilt, NAMED('contactFilt'));
	// OUTPUT(sortContacts, NAMED('sortContacts'));
	// OUTPUT(dedupContacts, NAMED('dedupContacts'));
	// OUTPUT(rollContactChanges, NAMED('rollContactChanges'));
	// OUTPUT(rollContactsByID, NAMED('rollContactsByID'));
	// OUTPUT(addContactAddrNameChanges, NAMED('addContactAddrNameChanges'));
	
		
	RETURN rolledBusSOS;
END;


  