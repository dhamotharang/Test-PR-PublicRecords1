IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

/*
	Following Keys being used:
			BIPV2.Key_BH_Linking_Ids.kFetch2
*/

EXPORT getBusHeader(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
													Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
													BIPV2.mod_sources.iParams linkingOptions) := FUNCTION

	busHeaderRaw := BIPV2.Key_BH_Linking_Ids.kFetch2(DueDiligence.Common.GetLinkIDs(indata),
																							Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE, /* dnbFullRemove */
																							TRUE, /* bypassContactSuppression */
																							Options.KeepLargeBusinesses);
														
	
	// Add back our Seq numbers.
	DueDiligence.Common.AppendSeq(busHeaderRaw, indata, busHeader_seq);

	// Filter out records after our history date.
	busHeaderFiltRecs := DueDiligence.Common.FilterRecords(busHeader_seq, dt_first_seen, dt_vendor_first_reported);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	clean_dtLastSeen := DueDiligence.Common.CleanDateFields(busHeaderFiltRecs, dt_last_seen);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	busHeaderFilt := clean_dtLastSeen;
	
	//get date first seen and date last seen
	sortByDates := SORT(busHeaderFilt, uniqueID, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), dt_first_seen, dt_last_seen);
		
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
	dedupSortBusHeaderSource := DEDUP(SORT(busHeaderFilt(source != ''), uniqueID, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), source),
															 uniqueID, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), source);

	hdrSrcTable := TABLE(dedupSortBusHeaderSource, {seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), SrcCount := COUNT(GROUP)}, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()));
	
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
	creditSrcTable := TABLE(busHeaderFilt(source IN DueDiligence.Constants.CREDIT_SOURCES), {seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), crdSrcCnt := COUNT(GROUP)}, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()));

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
	shellSrcTable := TABLE(busHeaderFilt(source IN DueDiligence.Constants.BUS_SHELL_SOURCES), {seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), shellSrcCnt := COUNT(GROUP)}, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()));

	addShellSrcCnt := JOIN(addCreditSrcCnt, shellSrcTable,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.ShellHdrSrcCnt := RIGHT.shellSrcCnt;
																		SELF := LEFT),
													LEFT OUTER);
													
	//get business header address count
	sortBusHdrAddr := SORT(busHeaderFilt(prim_name != '' AND prim_name[1..6] != 'PO BOX'), uniqueID, #expand(DueDiligence.Constants.mac_ListTop4Linkids()));
	dedupSortBusHdrAddr := DEDUP(sortBusHdrAddr, uniqueID, #expand(DueDiligence.Constants.mac_ListTop4Linkids()));
	
	hdrAddrTable := TABLE(dedupSortBusHdrAddr, {seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), addrCount := COUNT(GROUP)}, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()));
	
	addHdrAddrCount := JOIN(addShellSrcCnt, hdrAddrTable,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.hdAddrCount := RIGHT.addrCount;
																		SELF := LEFT;),
													LEFT OUTER);
													
															

	
	//get business header state count
	busHdrStates := DEDUP(SORT(busHeaderFilt(prim_name!=''), uniqueID, #expand(DueDiligence.Constants.mac_ListTop4Linkids()), st), uniqueID, #expand(DueDiligence.Constants.mac_ListTop4Linkids()), st);

	hdrStateTable := TABLE(busHdrStates, {seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), stateCount := COUNT(GROUP)}, seq, #expand(DueDiligence.Constants.mac_ListTop3Linkids()));

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
	sortByLastSeen := SORT(busHeaderFilt, uniqueID, #expand(DueDiligence.Constants.mac_ListTop3Linkids()), -dt_last_seen);

	rollForStructure := ROLLUP(sortByLastSeen,
															LEFT.seq = RIGHT.seq AND
															LEFT.ultID = RIGHT.ultID AND
															LEFT.orgID = RIGHT.orgID AND
															LEFT.seleID = RIGHT.seleID,
															TRANSFORM({RECORDOF(busHeaderFilt)},
																				SELF.company_org_structure_derived := IF(LEFT.company_org_structure_derived = '', RIGHT.company_org_structure_derived, LEFT.company_org_structure_derived);
																				SELF := LEFT;));

	
	addStructure := JOIN(addHdrStateCount, rollForStructure,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.busnType := RIGHT.company_org_structure_derived;
																			SELF := LEFT;),
														LEFT OUTER);
	
	//retrieve SIC and NAIC codes with dates
	//SIC
	outSic1 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_sic_code1, TRUE, TRUE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_HEADER);
	outSic2 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_sic_code2, TRUE, FALSE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_HEADER);
	outSic3 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_sic_code3, TRUE, FALSE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_HEADER);
	outSic4 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_sic_code4, TRUE, FALSE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_HEADER);
	outSic5 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_sic_code5, TRUE, FALSE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_HEADER);

	// NAIC
	outNaic1 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_naics_code1, FALSE, TRUE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_HEADER);
	outNaic2 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_naics_code2, FALSE, FALSE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_HEADER);
	outNaic3 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_naics_code3, FALSE, FALSE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_HEADER);
	outNaic4 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_naics_code4, FALSE, FALSE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_HEADER);
	outNaic5 := DueDiligence.Common.getSicNaicCodes(busHeaderFilt, company_naics_code5, FALSE, FALSE, dt_first_seen, dt_last_seen, DueDiligence.Constants.SOURCE_BUSINESS_HEADER);
	
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
	
	
	
	
	
	
	
	
	
	//testing no fein
	// test := SORT(busHeaderFilt, uniqueID, #expand(DueDiligence.Constants.mac_ListTop3Linkids()));
	// rollTest := ROLLUP(test, 
													// LEFT.seq = RIGHT.seq AND
													// LEFT.ultID = RIGHT.ultID AND
													// LEFT.orgID = RIGHT.orgID AND
													// LEFT.seleID = RIGHT.seleID,
													// TRANSFORM({RECORDOF(busHeaderFilt)},
																		// SELF.company_fein := MAX(LEFT.company_fein, RIGHT.company_fein);
																		// SELF := LEFT;));
																		
	// testProject := JOIN(indata, rollTest,
											// LEFT.seq = RIGHT.seq AND
											// LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
											// LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
											// LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
											// TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																// self.NoFein := (UNSIGNED)RIGHT.company_fein = 0 and LEFT.fein = '';
																// self := LEFT;),
											// LEFT OUTER);
											
	// filtProjectTest := testProject(relateddegree='IB');
	
	
	sortBusHeader := SORT(addSicNaic, seq, relatedDegree);
	rolledBusHeader := ROLLUP(sortBusHeader,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.HDAddrCount := LEFT.HDAddrCount + RIGHT.HDAddrCount; //add both inquired and linked bus counts to inquired bus
																			SELF := LEFT;));
																		
																		
																		

	// OUTPUT(indata, NAMED('indata'));
	// OUTPUT(busHeaderRaw, NAMED('busHeaderRaw'));
	// OUTPUT(busHeader_seq, NAMED('busHeader_seq'));
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
	// OUTPUT(HdrAddrTable, NAMED('HdrAddrTable'));
	// OUTPUT(addHdrAddrCount, NAMED('addHdrAddrCount'));
	// OUTPUT(busHdrStates, NAMED('busHdrStates'));
	// OUTPUT(hdrStateTable, NAMED('hdrStateTable')); 
	// OUTPUT(addHdrStateCount, NAMED('addHdrStateCount'));
	
	
	// OUTPUT(sortByLastSeen, NAMED('sortByLastSeen'));
	// OUTPUT(rollForStructure, NAMED('rollForStructure'));
	// OUTPUT(addStructure, NAMED('addStructure'));

	
	

	// OUTPUT(test, NAMED('test'));
	// OUTPUT(rollTest, NAMED('rollTest'));
	// OUTPUT(testProject, NAMED('testProject'));
	// OUTPUT(filtProjectTest, NAMED('filtProjectTest'));
	
	

	
	RETURN 	rolledBusHeader;										
											
END;
										