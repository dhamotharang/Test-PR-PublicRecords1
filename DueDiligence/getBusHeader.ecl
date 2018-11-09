IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

/*
	Following Keys being used: 
			BIPV2.Key_BH_Linking_Ids.kFetch2
*/

EXPORT getBusHeader(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
													Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
													BIPV2.mod_sources.iParams linkingOptions,
													BOOLEAN includeReportData) := FUNCTION
	
	//add linked businesses
	linkedBus := DueDiligence.Common.getLinkedBusinesses(indata);
	
	allBusinesses := indata + linkedBus;	
	
	busHeaderRaw := BIPV2.Key_BH_Linking_Ids.kFetch2(DueDiligence.Common.GetLinkIDs(allBusinesses),
																							Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE, /* dnbFullRemove */
																							TRUE, /* bypassContactSuppression */
																							Options.KeepLargeBusinesses)(source NOT IN DueDiligence.Constants.EXCLUDE_SOURCES);
														
	
	// Add back our Seq numbers.
	busHeaderSeq := DueDiligence.Common.AppendSeq(busHeaderRaw, indata, TRUE);

	// Filter out records after our history date.
	busHeaderFiltRecs := DueDiligence.Common.FilterRecords(busHeaderSeq, dt_first_seen, dt_vendor_first_reported);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	clean_dtLastSeen := DueDiligence.Common.CleanDateFields(busHeaderFiltRecs, dt_last_seen);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	busHeaderFilt := clean_dtLastSeen;
	
	//get date first seen and date last seen
	sortByDates := SORT(busHeaderFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), dt_first_seen, dt_last_seen);
		
	rollForDates := ROLLUP(sortByDates, 
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,
													TRANSFORM({RECORDOF(busHeaderFilt)},
																		SELF.dt_first_seen := IF(LEFT.dt_first_seen = 0, MAX(LEFT.dt_first_seen, RIGHT.dt_first_seen), MIN(LEFT.dt_first_seen, RIGHT.dt_first_seen));
																		SELF.dt_last_seen := MAX(LEFT.dt_last_seen, RIGHT.dt_last_seen);
																		SELF := LEFT;));
	
	addBusHdrDtSeen := JOIN(indata, rollForDates,
																LEFT.seq = RIGHT.seq AND
																LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
																TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																					SELF.BusnHdrDtFirstSeen := RIGHT.dt_first_seen;
																					SELF.BusnHdrDtLastSeen := right.dt_last_seen,
																					SELF := LEFT;),
																LEFT OUTER);
	
	//get populated sources
	dedupSortBusHeaderSource := DEDUP(SORT(busHeaderFilt(source != DueDiligence.Constants.EMPTY), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), source),
															 seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), source);

	hdrSrcTable := TABLE(dedupSortBusHeaderSource, {seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), SrcCount := COUNT(GROUP)}, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	addHdrSrcCnt := JOIN(addBusHdrDtSeen, hdrSrcTable,
											 LEFT.seq = RIGHT.seq AND
											 LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
											 LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
											 LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
											 TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																	SELF.srcCount := RIGHT.srcCount;
																	SELF := LEFT),
											 LEFT OUTER);
	
	//get credit sources
	creditSrcTable := TABLE(busHeaderFilt(source IN DueDiligence.Constants.CREDIT_SOURCES), {seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), crdSrcCnt := COUNT(GROUP)}, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

	addCreditSrcCnt := JOIN(addHdrSrcCnt, creditSrcTable,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.creditSrcCnt := RIGHT.crdSrcCnt;
																		SELF := LEFT),
													LEFT OUTER);

	//get shell header source counts
	shellSrcTable := TABLE(busHeaderFilt(source IN DueDiligence.Constants.BUS_SHELL_SOURCES), {seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), shellSrcCnt := COUNT(GROUP)}, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

	addShellSrcCnt := JOIN(addCreditSrcCnt, shellSrcTable,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.shellHdrSrcCnt := RIGHT.shellSrcCnt;
																		SELF := LEFT),
													LEFT OUTER);
													
	//get business header address count
	filterAddr := busHeaderFilt(prim_name != DueDiligence.Constants.EMPTY AND REGEXFIND(DueDiligence.Constants.NOT_PO_ADDRESS_EXPRESSION, TRIM(prim_name), NOCASE));
	sortBusHdrAddr := SORT(filterAddr, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop4Linkids()));
	dedupSortBusHdrAddr := DEDUP(sortBusHdrAddr, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop4Linkids()));
	
	hdrAddrTable := TABLE(dedupSortBusHdrAddr, {seq, ultID, addrCount := COUNT(GROUP)}, seq, ultID);
	
	addHdrAddrCount := JOIN(addShellSrcCnt, hdrAddrTable,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.relatedDegree = DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.hdAddrCount := RIGHT.addrCount;
																		SELF := LEFT;),
													LEFT OUTER);
													
	//get business header state count
	busHdrStates := DEDUP(SORT(busHeaderFilt(prim_name != DueDiligence.Constants.EMPTY AND st <> DueDiligence.Constants.EMPTY), seq, #EXPAND(BIPV2.IDmacros.mac_ListTop4Linkids()), st), seq, #EXPAND(BIPV2.IDmacros.mac_ListTop4Linkids()), st);

	hdrStateTable := TABLE(busHdrStates, {seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), stateCount := COUNT(GROUP)}, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

	addHdrStateCount := JOIN(addHdrAddrCount, hdrStateTable,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.hdStateCount := RIGHT.stateCount;
																			SELF := LEFT;),
														LEFT OUTER);
														
	//get the business structure
	sortByLastSeen := SORT(busHeaderFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -dt_last_seen);

	rollForStructure := ROLLUP(sortByLastSeen,
															LEFT.seq = RIGHT.seq AND
															LEFT.ultID = RIGHT.ultID AND
															LEFT.orgID = RIGHT.orgID AND
															LEFT.seleID = RIGHT.seleID,
															TRANSFORM({RECORDOF(busHeaderFilt)},
																				SELF.company_org_structure_derived := IF(LEFT.company_org_structure_derived = DueDiligence.Constants.EMPTY, RIGHT.company_org_structure_derived, LEFT.company_org_structure_derived);
																				SELF := LEFT;));

	addStructure := JOIN(addHdrStateCount, rollForStructure,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.hdBusnType := RIGHT.company_org_structure_derived;
																			SELF := LEFT;),
														LEFT OUTER);
	
	//retrieve SIC and NAIC codes with dates
	//SIC
	outSic1 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_sic_code1, TRUE, TRUE, dt_first_seen, dt_last_seen, source);
	outSic2 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_sic_code2, TRUE, FALSE, dt_first_seen, dt_last_seen, source);
	outSic3 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_sic_code3, TRUE, FALSE, dt_first_seen, dt_last_seen, source);
	outSic4 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_sic_code4, TRUE, FALSE, dt_first_seen, dt_last_seen, source);
	outSic5 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_sic_code5, TRUE, FALSE, dt_first_seen, dt_last_seen, source);

	// NAIC
	outNaic1 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_naics_code1, FALSE, TRUE, dt_first_seen, dt_last_seen, source);
	outNaic2 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_naics_code2, FALSE, FALSE, dt_first_seen, dt_last_seen, source);
	outNaic3 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_naics_code3, FALSE, FALSE, dt_first_seen, dt_last_seen, source);
	outNaic4 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_naics_code4, FALSE, FALSE, dt_first_seen, dt_last_seen, source);
	outNaic5 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_naics_code5, FALSE, FALSE, dt_first_seen, dt_last_seen, source);
	
	allSicNaic := outSic1 + outSic2 + outSic3 + outSic4 + outSic5 + outNaic1 + outNaic2 + outNaic3 + outNaic4 + outNaic5;
	sortRollSicNaic := DueDiligence.Common.rollSicNaicBySeqAndBIP(allSicNaic);
		
	addSicNaic := JOIN(addStructure, sortRollSicNaic,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.SicNaicSources := LEFT.SicNaicSources + RIGHT.sources;
																			SELF := LEFT;),
														LEFT OUTER);
	
	//get the date we first saw the cleaned input address
	sortFirstSeenAddr := SORT(busHeaderFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), 
														prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, v_city_name, st, zip, zip4, dt_first_seen, dt_vendor_first_reported);
	dedupFirstSeenAddr := DEDUP(sortFirstSeenAddr, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), 
															prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, v_city_name, st, zip, zip4);
	
	findMatchAddr := JOIN(indata, dedupFirstSeenAddr,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
												TRANSFORM({BOOLEAN inputAddrMatch, UNSIGNED addressScore, UNSIGNED dateFirstSeen, RECORDOF(LEFT)},
																	addrScore := DueDiligence.Common.getAddressScore(LEFT.busn_info.address.prim_range,
																																										LEFT.busn_info.address.prim_name,
																																										LEFT.busn_info.address.sec_range,
																																										RIGHT.prim_range,
																																										RIGHT.prim_name,
																																										RIGHT.sec_range);
																	SELF.addressScore := addrScore;
																	SELF.inputAddrMatch := addrScore BETWEEN DueDiligence.Constants.MIN_ADDRESS_SCORE AND DueDiligence.Constants.MAX_ADDRESS_SCORE;
																	SELF.dateFirstSeen := IF(RIGHT.dt_first_seen = 0, RIGHT.dt_vendor_first_reported, RIGHT.dt_first_seen);
																	SELF := LEFT;));
																	
	sortTopMatch := SORT(findMatchAddr(inputAddrMatch), seq, #EXPAND(DueDiligence.Constants.mac_ListTop3Linkids()), -addressScore);
	dedupTopMatch := DEDUP(sortTopMatch, seq, #EXPAND(DueDiligence.Constants.mac_ListTop3Linkids()));

	addAddrFirstSeen := JOIN(addSicNaic, dedupTopMatch,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.firstReportedAtInputAddress := RIGHT.dateFirstSeen;
																			SELF.inputAddressVerified := LEFT.inputAddressProvided AND LEFT.fullInputAddressProvided AND RIGHT.inputAddrMatch;
																			SELF := LEFT;),
														LEFT OUTER);
	
	//determine if the business has no fein
	sortFein := SORT(busHeaderFilt, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	rollFein := ROLLUP(sortFein, 
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,
													TRANSFORM({RECORDOF(sortFein)},
																		SELF.company_fein := (STRING)MAX((UNSIGNED)LEFT.company_fein, (UNSIGNED)RIGHT.company_fein);
																		SELF := LEFT;));
																		
	addNoFein := JOIN(addAddrFirstSeen, rollFein,
											LEFT.seq = RIGHT.seq AND
											LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
											LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
											LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
											TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																SELF.NoFein := (UNSIGNED)RIGHT.company_fein = 0 AND LEFT.busn_info.fein = DueDiligence.Constants.EMPTY;
																SELF := LEFT;),
											LEFT OUTER);
											
	//is the business incorporated in a state with loose incorporation laws
	projectLooseLaws := PROJECT(busHeaderFilt, TRANSFORM({RECORDOF(LEFT), BOOLEAN looseLawState}, 
																													SELF.looseLawState := LEFT.company_inc_state IN DueDiligence.Constants.STATES_WITH_LOOSE_INCORPORATION_LAWS;
																													SELF := LEFT;));
	
	sortLooseLaws := SORT(projectLooseLaws, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	rollLooseLaws := ROLLUP(sortLooseLaws,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,
													TRANSFORM({RECORDOF(LEFT)},
																			SELF.looseLawState := LEFT.looseLawState OR RIGHT.looseLawState;
																			SELF := LEFT;));
																			
	addIncLooseLaws := JOIN(addNoFein, rollLooseLaws,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.incorpWithLooseLaws := LEFT.incorpWithLooseLaws OR RIGHT.looseLawState;
																		SELF := LEFT;),
													LEFT OUTER);										
											
	//get the first seen date from no credit source
	nonCreditFrstSeenSort := SORT(busHeaderFilt(source NOT IN DueDiligence.Constants.CREDIT_SOURCES and dt_first_seen <> 0), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), dt_first_seen);
	nonCreditFirstSeenDedup := DEDUP(nonCreditFrstSeenSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

	addNonCreditFirstSeen := JOIN(addIncLooseLaws, nonCreditFirstSeenDedup,
																LEFT.seq = RIGHT.seq AND
																LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
																TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.busnHdrDtFirstSeenNonCredit := RIGHT.dt_first_seen;
																			SELF := LEFT;),
																LEFT OUTER);
																
	//get all unique powids tied to the seleid
	uniquePows := TABLE(busHeaderFilt, {seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), powID}, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), powid);
	
	uniquePowsPro := PROJECT(uniquePows, TRANSFORM({SET upows, RECORDOF(LEFT)},
																									SELF.upows := SET(uniquePows(seq = LEFT.seq AND ultID = LEFT.ultID AND orgID = LEFT.orgID AND seleID = LEFT.seleID), powID);
																									SELF := LEFT;));																						

	uniquePowsSort := SORT(uniquePowsPro, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	uniquePowsDedup := DEDUP(uniquePowsPro, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

	addUniquePows := JOIN(addNonCreditFirstSeen, uniquePowsDedup,
								LEFT.seq = RIGHT.seq AND
								LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
								LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
								LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
								TRANSFORM(DueDiligence.Layouts.Busn_Internal,
											SELF.setUniquePowIDs := RIGHT.upows;
											SELF := LEFT;),
								LEFT OUTER);

	notFoundInHeader := JOIN(addUniquePows, busHeaderFilt,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
														TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, BOOLEAN notFound},
																			SELF.seq := LEFT.seq;
																			SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																			SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																			SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																			SELF.notFound := TRUE;
																			SELF := [];),
														LEFT ONLY);
														
	addNotFound := JOIN(addUniquePows, notFoundInHeader,
											LEFT.seq = RIGHT.seq AND
											LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
											LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
											LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
											TRANSFORM(DueDiligence.Layouts.Busn_Internal,
														SELF.notFoundInHeader := RIGHT.notFound;
														SELF := LEFT;),
											LEFT OUTER);
		

	
																		

	// OUTPUT(indata, NAMED('indata'));
	// OUTPUT(busHeaderRaw, NAMED('busHeaderRaw'));
	// OUTPUT(busHeaderSeq, NAMED('busHeaderSeq'));
	// OUTPUT(busHeaderFilt, NAMED('busHeaderFilt'));
	
	// OUTPUT(rollForDates, NAMED('rollForDates'));
	// OUTPUT(clean_dtLastSeen, NAMED('clean_dtLastSeen'));
	// OUTPUT(sortByDates, NAMED('sortByDates'));
	// OUTPUT(addBusHdrDtSeen, NAMED('addBusHdrDtSeen'));
	// OUTPUT(hdrSrcTable, NAMED('hdrSrcTable'));
	// OUTPUT(creditSrcTable, NAMED('creditSrcTable'));
	// OUTPUT(addShellSrcCnt, NAMED('addShellSrcCnt'));
	
	// OUTPUT(sortBusHdrAddr, NAMED('sortBusHdrAddr'));
	// OUTPUT(dedupSortBusHdrAddr, NAMED('dedupSortBusHdrAddr'));
	// OUTPUT(filterAddr, NAMED('filterAddr'));
	// OUTPUT(HdrAddrTable, NAMED('HdrAddrTable'));
	// OUTPUT(addHdrAddrCount, NAMED('addHdrAddrCount'));
	
	// OUTPUT(busHdrStates, NAMED('busHdrStates'));
	// OUTPUT(hdrStateTable, NAMED('hdrStateTable')); 
	// OUTPUT(addHdrStateCount, NAMED('addHdrStateCount'));
	
	// OUTPUT(sortByLastSeen, NAMED('sortByLastSeen'));
	// OUTPUT(rollForStructure, NAMED('rollForStructure'));
	// OUTPUT(addStructure, NAMED('addStructure'));
	// OUTPUT(addSicNaic, NAMED('addSicNaic'));
	
	// OUTPUT(sortfirstSeenAddr, NAMED('sortfirstSeenAddr'));
	// OUTPUT(dedupFirstSeenAddr, NAMED('dedupFirstSeenAddr'));
	// OUTPUT(findMatchAddr, NAMED('findMatchAddr'));
	// OUTPUT(findMatchAddr(inputAddrMatch), NAMED('findMatchAddr_TRUE'));
	// OUTPUT(sortTopMatch, NAMED('sortTopMatch'));
	// OUTPUT(dedupTopMatch, NAMED('dedupTopMatch'));
	// OUTPUT(addAddrFirstSeen, NAMED('addAddrFirstSeen'));
	
	// OUTPUT(sortFein, NAMED('sortFein'));
	// OUTPUT(rollFein, NAMED('rollFein'));
	// OUTPUT(addNoFein, NAMED('addNoFein'));
	
	// OUTPUT(projectLooseLaws, NAMED('projectLooseLaws'));
	// OUTPUT(rollLooseLaws, NAMED('rollLooseLaws'));
	// OUTPUT(addIncLooseLaws, NAMED('addIncLooseLaws'));									

	// OUTPUT(nonCreditFrstSeenSort, NAMED('nonCreditFrstSeenSort'));
	// OUTPUT(nonCreditFirstSeenDedup, NAMED('nonCreditFirstSeenDedup'));
	// OUTPUT(addNonCreditFirstSeen, NAMED('addNonCreditFirstSeen'));
	
	// OUTPUT(uniquePows, NAMED('uniquePows'));																								
	// OUTPUT(uniquePowsPro, NAMED('uniquePowsPro'));																	
	// OUTPUT(uniquePowsDedup, NAMED('uniquePowsDedup'));
	
	// OUTPUT(notFoundInHeader, NAMED('notFoundInHeader'));	
	// OUTPUT(addNotFound, NAMED('addNotFound'));	

	
	

	
	RETURN 	addNotFound;										
											
END;
										