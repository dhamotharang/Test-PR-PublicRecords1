IMPORT Address_Attributes, BIPv2, Business_Header, codes, ADVO, Business_Risk, Risk_indicators, RiskWise, Address, YellowPages, Easi, Business_Risk_BIP, DueDiligence;

/*
	Following Keys being used:
			Address_Attributes.key_AML_addr
			Risk_Indicators.key_HRI_Address_To_SIC
*/

EXPORT getBusAddrData(DATASET(DueDiligence.Layouts.Busn_Internal) inData,
												Business_Risk_BIP.LIB_Business_Shell_LIBIN options) := FUNCTION
	
	//call key to initially get counts based on address, regardless of powID
	addrCountRaw := JOIN(inData, Address_Attributes.key_AML_addr, 
												KEYED(TRIM(LEFT.busn_info.address.zip5) = RIGHT.zip) AND
												KEYED(TRIM(LEFT.busn_info.address.prim_range) = RIGHT.prim_range) AND
												KEYED(TRIM(LEFT.busn_info.address.prim_name) = RIGHT.prim_name) AND
												KEYED(TRIM(LEFT.busn_info.address.addr_suffix) = RIGHT.addr_suffix) AND
												KEYED(TRIM(LEFT.busn_info.address.predir) = RIGHT.predir) AND
												KEYED(TRIM(LEFT.busn_info.address.postdir) = RIGHT.postdir),
												TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED4 historyDate, RECORDOF(RIGHT)},
																	SELF.seq := LEFT.seq;
																	SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																	SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																	SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																	SELF.historyDate := LEFT.historyDate;
																	SELF := RIGHT;
																	SELF := [];),
												KEEP(1));
	
	// Filter out records after our history date.
	addrCountDataFiltRecs := DueDiligence.Common.FilterRecordsSingleDate(addrCountRaw, dt_first_seen);
	
	//determine businesses counts (at addr, incorporated in loose state, have no fein)
	addCounts := JOIN(inData, addrCountDataFiltRecs,
										LEFT.seq = RIGHT.seq AND
										LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
										LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
										LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
										TRANSFORM(DueDiligence.Layouts.Busn_Internal,
															SELF.numOfBusFoundAtAddr := RIGHT.biz_cnt;
															SELF.numOfBusIncInStateLooseLaws := RIGHT.inc_st_loose_cnt;
															SELF.numOfBusNoReportedFein := RIGHT.no_fein_cnt;
															SELF := LEFT;),
										LEFT OUTER);

										
	//first start by grabing the registered agents
	allAgents := NORMALIZE(inData, LEFT.registeredagents, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																																	SELF.seq := LEFT.seq;
																																	SELF.historyDate := LEFT.historyDate;
																																	SELF.Busn_info.BIP_IDS.UltID.LinkID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																																	SELF.Busn_info.BIP_IDS.OrgID.LinkID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																																	SELF.Busn_info.BIP_IDS.SeleID.LinkID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																																	SELF.Busn_info.BIP_IDS.ProxID.LinkID := LEFT.Busn_info.BIP_IDS.ProxID.LinkID;
																																	SELF.Busn_info.BIP_IDS.PowID.LinkID := LEFT.Busn_info.BIP_IDS.PowID.LinkID;
																																	SELF.relatedDegree := DueDiligence.Constants.REGISTERED_AGENT;
																																	SELF.Busn_info.address.prim_range := RIGHT.prim_range;
																																	SELF.Busn_info.address.predir := RIGHT.predir;
																																	SELF.Busn_info.address.prim_name := RIGHT.prim_name;
																																	SELF.Busn_info.address.addr_suffix := RIGHT.addr_suffix;
																																	SELF.Busn_info.address.postdir := RIGHT.postdir;
																																	SELF.Busn_info.address.unit_desig := RIGHT.unit_desig;
																																	SELF.Busn_info.address.sec_range := RIGHT.sec_range;
																																	SELF.Busn_info.address.city := RIGHT.city;
																																	SELF.Busn_info.address.state := RIGHT.state;
																																	SELF.Busn_info.address.zip5 := RIGHT.zip5;
																																	SELF.Busn_info.address.zip4 := RIGHT.zip4;
																																	SELF.setUniquePowIDs := LEFT.setUniquePowIDs;
																																	SELF.atleastOneAgentSameAddrAsBus := LEFT.busn_info.address.prim_range = RIGHT.prim_range AND
																																																				LEFT.busn_info.address.predir = RIGHT.predir AND
																																																				LEFT.busn_info.address.prim_name = RIGHT.prim_name AND
																																																				LEFT.busn_info.address.addr_suffix = RIGHT.addr_suffix AND
																																																				LEFT.busn_info.address.postdir = RIGHT.postdir AND
																																																				LEFT.busn_info.address.unit_desig = RIGHT.unit_desig AND
																																																				LEFT.busn_info.address.sec_range = RIGHT.sec_range AND
																																																				LEFT.busn_info.address.city = RIGHT.city AND
																																																				LEFT.busn_info.address.state = RIGHT.state AND
																																																				LEFT.busn_info.address.zip5 = RIGHT.zip5;
																																	SELF := []));

		
	//Remove duplicate addresses
	raAddressSort := SORT(allAgents, seq, #EXPAND(DueDiligence.Constants.mac_ListTop3Linkids()), Busn_info.address.prim_range, Busn_info.address.prim_name, busn_info.address.addr_suffix, busn_info.address.predir, busn_info.address.postdir, Busn_info.address.zip5);
	raAddressDedup := DEDUP(raAddressSort, seq, #EXPAND(DueDiligence.Constants.mac_ListTop3Linkids()), Busn_info.address.prim_range, Busn_info.address.prim_name, busn_info.address.addr_suffix, busn_info.address.predir, busn_info.address.postdir, Busn_info.address.zip5);

	//Grab registered agent if at the same address as the business
	rollMatchingRAAddr :=  ROLLUP(raAddressDedup,
																LEFT.seq = RIGHT.seq AND
																LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND
																LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND
																LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID,
																TRANSFORM({RECORDOF(LEFT)},
																						SELF.atleastOneAgentSameAddrAsBus := LEFT.atleastOneAgentSameAddrAsBus OR RIGHT.atleastOneAgentSameAddrAsBus;
																						SELF := LEFT;));
	
	addMatchingRAAddresses := JOIN(addCounts, rollMatchingRAAddr,
																	LEFT.seq = RIGHT.seq AND
																	LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND
																	LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND
																	LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID,
																	TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																						SELF.atleastOneAgentSameAddrAsBus := RIGHT.atleastOneAgentSameAddrAsBus;
																						SELF := LEFT;),
																	LEFT OUTER);
	
	//add the registered agents to the input
	allParties := inData + raAddressDedup;
	
	addrRaw := JOIN(allParties, Address_Attributes.key_AML_addr, 
									KEYED(TRIM(LEFT.busn_info.address.zip5) = RIGHT.zip) AND
									KEYED(TRIM(LEFT.busn_info.address.prim_range) = RIGHT.prim_range) AND
									KEYED(TRIM(LEFT.busn_info.address.prim_name) = RIGHT.prim_name) AND
									KEYED(TRIM(LEFT.busn_info.address.addr_suffix) = RIGHT.addr_suffix) AND
									KEYED(TRIM(LEFT.busn_info.address.predir) = RIGHT.predir) AND
									KEYED(TRIM(LEFT.busn_info.address.postdir) = RIGHT.postdir) AND
									RIGHT.powID IN LEFT.setUniquePowIDs,
									TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED4 historyDate, STRING2 partyIndicator, RECORDOF(RIGHT)},
														SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
														SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
														SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
														SELF.historyDate := LEFT.historyDate;
														SELF.partyIndicator := LEFT.relatedDegree;
														SELF := RIGHT;
														SELF := []),
									ATMOST(DueDiligence.Constants.MAX_ATMOST_500));
	
	// Filter out records after our history date.
	addrDataFiltRecs := DueDiligence.Common.FilterRecordsSingleDate(addrRaw, dt_first_seen);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	clean_dateLastSeen := DueDiligence.Common.CleanDateFields(addrDataFiltRecs, dt_last_seen);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	addrDataFilt := clean_dateLastSeen;
	
	filteredInquiredBus := addrDataFilt(partyIndicator = DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE);
	filteredRegisteredAgents := addrDataFilt(partyIndicator = DueDiligence.Constants.REGISTERED_AGENT);
	
	//determine company org structure
	structures := PROJECT(filteredInquiredBus, TRANSFORM({RECORDOF(LEFT)},
																												SELF.company_org_structure_derived := IF(LEFT.trust >= 1, DueDiligence.Constants.CMPTYP_TRUST, LEFT.company_org_structure_derived);
																												SELF := LEFT;));
	
	sortStructures := SORT(structures, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -dt_last_seen);
	
	rollStructure := ROLLUP(sortStructures,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,
													TRANSFORM({RECORDOF(LEFT)},
																		SELF.company_org_structure_derived := IF(LEFT.company_org_structure_derived = DueDiligence.Constants.EMPTY, RIGHT.company_org_structure_derived, LEFT.company_org_structure_derived);
																		SELF := LEFT;));
		
	addAddrStructure := JOIN(addMatchingRAAddresses, rollStructure,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.adrBusnType := RIGHT.company_org_structure_derived;
																			SELF := LEFT;),
														LEFT OUTER);

									
	//determine if business is operating from a private post, mail drop, remailer, storage facility or undeliverable secondary range										
	operatingMailingAddr := PROJECT(filteredInquiredBus, TRANSFORM({BOOLEAN privatePost, BOOLEAN mailDrop, BOOLEAN remailer, BOOLEAN storageFacility, BOOLEAN undelSecRange, BOOLEAN isVacant, BOOLEAN incLooseState, RECORDOF(LEFT)},
																																	SELF.privatePost := LEFT.priv_post > 0;
																																	SELF.mailDrop := LEFT.drop > 0;
																																	SELF.remailer := LEFT.potential_remail;
																																	SELF.storageFacility := LEFT.storage > 0;
																																	SELF.undelSecRange := LEFT.undel_sec > 0;
																																	SELF.isVacant := LEFT.vacant_cnt > 0;
																																	SELF.incLooseState := LEFT.inc_st_loose_cnt > 0;
																																	SELF := LEFT;));
																															
	sortOperatingMailingAddr := SORT(operatingMailingAddr, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	rollOperatingMailingAddr := ROLLUP(sortOperatingMailingAddr,
																			LEFT.seq = RIGHT.seq AND
																			LEFT.ultID = RIGHT.ultID AND
																			LEFT.orgID = RIGHT.orgID AND
																			LEFT.seleID = RIGHT.seleID,
																			TRANSFORM({RECORDOF(LEFT)},
																								SELF.privatePost := LEFT.privatePost OR RIGHT.privatePost;
																								SELF.mailDrop := LEFT.mailDrop OR RIGHT.mailDrop;
																								SELF.remailer := LEFT.remailer OR RIGHT.remailer;
																								SELF.storageFacility := LEFT.storageFacility OR RIGHT.storageFacility;
																								SELF.undelSecRange := LEFT.undelSecRange OR RIGHT.undelSecRange;
																								SELF.isVacant := LEFT.isVacant OR RIGHT.isVacant;
																								SELF.incLooseState := LEFT.incLooseState OR RIGHT.incLooseState;
																								SELF := LEFT;));

	addOperatingMailingAddr := JOIN(addAddrStructure, rollOperatingMailingAddr,
																	LEFT.seq = RIGHT.seq AND
																	LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																	LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																	LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
																	TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																						SELF.privatePostExists := RIGHT.privatePost;
																						SELF.mailDropExists := RIGHT.mailDrop;
																						SELF.remailerExists := RIGHT.remailer;
																						SELF.storageFacilityExists := RIGHT.storageFacility;
																						SELF.undeliverableSecRangeExists := RIGHT.undelSecRange;
																						SELF.vacant := RIGHT.isVacant;
																						SELF.incorpWithLooseLaws := LEFT.incorpWithLooseLaws OR RIGHT.incLooseState;
																						SELF := LEFT;),
																	LEFT OUTER);


	//determine if registered agent address contains a NIS or business incubator
	raInfo := PROJECT(filteredRegisteredAgents, TRANSFORM({BOOLEAN foundNis, BOOLEAN foundIncubator, RECORDOF(LEFT)},
																													SELF.foundNis := LEFT.potential_nis;
																													SELF.foundIncubator := LEFT.potential_shelf;
																													SELF := LEFT;));

	sortRaAgent := SORT(raInfo, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	rollRaAgent := ROLLUP(sortRaAgent,
												LEFT.seq = RIGHT.seq AND
												LEFT.ultID = RIGHT.ultID AND
												LEFT.orgID = RIGHT.orgID AND
												LEFT.seleID = RIGHT.seleID,
												TRANSFORM({RECORDOF(LEFT)},
																		SELF.foundNis := LEFT.foundNis OR RIGHT.foundNis;
																		SELF.foundIncubator := LEFT.foundIncubator OR RIGHT.foundIncubator;
																		SELF := LEFT));
																
	
	addAgentInfo := JOIN(addOperatingMailingAddr, rollRaAgent,
												LEFT.seq = RIGHT.seq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																	SELF.agentShelfBusn := RIGHT.foundIncubator;
																	SELF.agentPotentialNIS := RIGHT.foundNis;
																	SELF := LEFT;),
												LEFT OUTER);



	//determine high risk sic code based on address
	hraSicRaw := JOIN(inData, risk_indicators.key_HRI_Address_To_SIC,
										RIGHT.sic_code <> DueDiligence.Constants.EMPTY and 
										KEYED(TRIM(LEFT.busn_info.address.zip5) = RIGHT.z5) AND
										KEYED(TRIM(LEFT.busn_info.address.prim_range) = RIGHT.prim_range) AND
										KEYED(TRIM(LEFT.busn_info.address.prim_name) = RIGHT.prim_name) AND
										KEYED(TRIM(LEFT.busn_info.address.addr_suffix) = RIGHT.suffix) AND
										KEYED(TRIM(LEFT.busn_info.address.predir) = RIGHT.predir) AND
										KEYED(TRIM(LEFT.busn_info.address.postdir) = RIGHT.postdir) AND
										KEYED(TRIM(LEFT.busn_info.address.sec_range) = RIGHT.sec_range),
										TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED4 historyDate, STRING2 partyIndicator, RECORDOF(RIGHT)},
															SELF.seq := LEFT.seq;
															SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
															SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
															SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
															SELF.historyDate := LEFT.historyDate;
															SELF.partyIndicator := LEFT.relatedDegree;
															SELF := RIGHT;
															SELF := [];),
										ATMOST(DueDiligence.Constants.MAX_ATMOST_100));
	
	// Filter out records after our history date.
	addrSicDataFiltRecs := DueDiligence.Common.FilterRecordsSingleDate(hraSicRaw, dt_first_seen);
	
	addrSicDataTrans := PROJECT(addrSicDataFiltRecs, TRANSFORM({BOOLEAN cmraSicCode, RECORDOF(LEFT)},
																															SELF.cmraSicCode := LEFT.sic_code IN DueDiligence.Constants.CMRA_SIC_CODES;
																															SELF := LEFT;
																															SELF := [];));
																															
	addrSicDataSort := SORT(addrSicDataTrans, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -cmraSicCode);
	addrSicDataDedup := DEDUP(addrSicDataSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	addAddrSicData := JOIN(addAgentInfo, addrSicDataDedup,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.cmra := RIGHT.cmraSicCode;
																		SELF := LEFT;),
													LEFT OUTER);






	// OUTPUT(inData, NAMED('inData'));
	
	// OUTPUT(addrCountRaw, NAMED('addrCountRaw'));
	// OUTPUT(addCounts, NAMED('addCounts'));
			
	// OUTPUT(addrRaw, NAMED('addrRaw'));
	// OUTPUT(addrDataFilt, NAMED('addrDataFilt'));
	
	// OUTPUT(allAgents, NAMED('allAgents'));
	// OUTPUT(raAddressSort, NAMED('raAddressSort'));
	// OUTPUT(raAddressDedup, NAMED('raAddressDedup'));
	
	// OUTPUT(rollMatchingRAAddr, NAMED('rollMatchingRAAddr'));
	// OUTPUT(addMatchingRAAddresses, NAMED('addMatchingRAAddresses'));
	// OUTPUT(allParties, NAMED('allParties'));
	
	// OUTPUT(filteredInquiredBus, NAMED('filteredInquiredBus'));
	// OUTPUT(filteredRegisteredAgents, NAMED('filteredRegisteredAgents'));
	
	// OUTPUT(structures, NAMED('structures'));
	// OUTPUT(sortStructures, NAMED('sortStructures'));
	// OUTPUT(rollStructure, NAMED('rollStructure'));
	// OUTPUT(addAddrStructure, NAMED('addAddrStructure'));

	// OUTPUT(operatingMailingAddr, NAMED('operatingMailingAddr'));
	// OUTPUT(rollOperatingMailingAddr, NAMED('rollOperatingMailingAddr'));
	// OUTPUT(addOperatingMailingAddr, NAMED('addOperatingMailingAddr'));
	
	// OUTPUT(raInfo, NAMED('raInfo'));
	// OUTPUT(rollRaAgent, NAMED('rollRaAgent'));
	// OUTPUT(addAgentInfo, NAMED('addAgentInfo'));
	
	// OUTPUT(hraSicRaw, NAMED('hraSicRaw'));
	// OUTPUT(addrSicDataFiltRecs, NAMED('addrSicDataFiltRecs'));
	// OUTPUT(addrSicDataTrans, NAMED('addrSicDataTrans'));
	// OUTPUT(addrSicDataSort, NAMED('addrSicDataSort'));
	// OUTPUT(addrSicDataDedup, NAMED('addrSicDataDedup'));
	// OUTPUT(addAddrSicData, NAMED('addAddrSicData'));
	



	RETURN addAddrSicData;

END;
