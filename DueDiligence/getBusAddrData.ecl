IMPORT Address_Attributes, BIPv2, Business_Header, codes, Business_Risk, Risk_indicators, RiskWise, Address, Business_Risk_BIP, DueDiligence, STD;

/*
	Following Keys being used:
			Address_Attributes.key_AML_addr
			Risk_Indicators.key_HRI_Address_To_SIC
*/

EXPORT getBusAddrData(DATASET(DueDiligence.Layouts.Busn_Internal) inData,
												Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                        BOOLEAN includeReport) := FUNCTION
                        
	//first start by grabing the registered agents
	allAgents := DueDiligence.CommonBusiness.getChildAsInquired(inData, registeredagents, DueDiligence.Constants.REGISTERED_AGENT);
  
  inquiredAndAgents := inData + allAgents;  
  
	//call key to initially get counts based on address, regardless of powID
	addrCountRaw := JOIN(inquiredAndAgents, Address_Attributes.key_AML_addr, 
												KEYED(TRIM(LEFT.busn_info.address.zip5) = RIGHT.zip) AND
												KEYED(TRIM(LEFT.busn_info.address.prim_range) = RIGHT.prim_range) AND
												KEYED(TRIM(LEFT.busn_info.address.prim_name) = RIGHT.prim_name) AND
												KEYED(TRIM(LEFT.busn_info.address.addr_suffix) = RIGHT.addr_suffix) AND
												KEYED(TRIM(LEFT.busn_info.address.predir) = RIGHT.predir) AND
												KEYED(TRIM(LEFT.busn_info.address.postdir) = RIGHT.postdir),
												TRANSFORM({UNSIGNED4 seq, UNSIGNED6 ultID, UNSIGNED6 orgID, UNSIGNED6 seleID, UNSIGNED4 historyDate, STRING2 partyIndicator, RECORDOF(RIGHT)},
																	SELF.seq := LEFT.seq;
																	SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																	SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																	SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																	SELF.historyDate := LEFT.historyDate;
                                  SELF.partyIndicator := LEFT.relatedDegree;
																	SELF := RIGHT;
																	SELF := [];),
												KEEP(1),
												ATMOST(DueDiligence.Constants.MAX_ATMOST_500));
												
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	cleanDateFields := DueDiligence.Common.CleanDatasetDateFields(addrCountRaw, 'dt_first_seen');											
	
	// Filter out records after our history date.
	addrCountDataFiltRecs := DueDiligence.Common.FilterRecordsSingleDate(cleanDateFields, dt_first_seen);
	
	//determine businesses counts (at addr, incorporated in loose state, have no fein)
	addCounts := JOIN(inData, addrCountDataFiltRecs(partyIndicator = DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE),
										#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
										TRANSFORM(DueDiligence.Layouts.Busn_Internal,
															SELF.numOfBusFoundAtAddr := RIGHT.biz_cnt;
															SELF.numOfBusIncInStateLooseLaws := RIGHT.inc_st_loose_cnt;
															SELF.numOfBusNoReportedFein := RIGHT.no_fein_cnt;
															SELF := LEFT;),
										LEFT OUTER);
                    
                    
  //add counts for the registered agents - only if we need it as requested by the report
  addAgentCounts := IF(includeReport, DueDiligence.getBusAddrDataReportData.AddRegisteredAgentAddressCounts(addrCountDataFiltRecs(partyIndicator = DueDiligence.Constants.REGISTERED_AGENT), addCounts), addCounts);
  
	
	//Grab registered agent if at the same address as the business
  sortAgents := SORT(allAgents, seq, #EXPAND(DueDiligence.Constants.mac_ListTop3Linkids()));
  
	rollMatchingRAAddr :=  ROLLUP(sortAgents,
																LEFT.seq = RIGHT.seq AND
																LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND
																LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND
																LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID,
																TRANSFORM({RECORDOF(LEFT)},
																						SELF.atleastOneAgentSameAddrAsBus := LEFT.atleastOneAgentSameAddrAsBus OR RIGHT.atleastOneAgentSameAddrAsBus;
																						SELF := LEFT;));
	
	addMatchingRAAddresses := JOIN(addAgentCounts, rollMatchingRAAddr,
																	LEFT.seq = RIGHT.seq AND
																	LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND
																	LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND
																	LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID,
																	TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																						SELF.atleastOneAgentSameAddrAsBus := RIGHT.atleastOneAgentSameAddrAsBus;
																						SELF := LEFT;),
																	LEFT OUTER);
                                  
  //get the operating locations
  operatingLocations := DueDiligence.CommonBusiness.getChildAsInquired(inData, operatingLocations, DueDiligence.Constants.OPERATING_LOCATION);
	
	//add the registered agents and operating locations to the input
	allParties := inData + allAgents + operatingLocations;
	
	addrRaw := JOIN(allParties, Address_Attributes.key_AML_addr, 
									KEYED(TRIM(LEFT.busn_info.address.zip5) = RIGHT.zip) AND
									KEYED(TRIM(LEFT.busn_info.address.prim_range) = RIGHT.prim_range) AND
									KEYED(TRIM(LEFT.busn_info.address.prim_name) = RIGHT.prim_name) AND
									KEYED(TRIM(LEFT.busn_info.address.addr_suffix) = RIGHT.addr_suffix) AND
									KEYED(TRIM(LEFT.busn_info.address.predir) = RIGHT.predir) AND
									KEYED(TRIM(LEFT.busn_info.address.postdir) = RIGHT.postdir) AND
									RIGHT.powID IN LEFT.setUniquePowIDs,
									TRANSFORM({UNSIGNED4 seq, UNSIGNED6 ultID, UNSIGNED6 orgID, UNSIGNED6 seleID, UNSIGNED4 historyDate, STRING2 partyIndicator, RECORDOF(RIGHT)},
														SELF.seq := LEFT.seq;
														SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
														SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
														SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
														SELF.historyDate := LEFT.historyDate;
														SELF.partyIndicator := LEFT.relatedDegree;
														SELF := RIGHT;
														SELF := []),
									ATMOST(DueDiligence.Constants.MAX_ATMOST_500));
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	addrDateFilt := DueDiligence.Common.CleanDatasetDateFields(addrRaw, 'dt_first_seen, dt_last_seen');
	
	// Filter out records after our history date.
	addrDataFiltRecs := DueDiligence.Common.FilterRecordsSingleDate(addrDateFilt, dt_first_seen);
	
	
	filteredInquiredBus := addrDataFiltRecs(partyIndicator = DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE);
	filteredRegisteredAgents := addrDataFiltRecs(partyIndicator = DueDiligence.Constants.REGISTERED_AGENT);
	filteredOperatingLocations := addrDataFiltRecs(partyIndicator = DueDiligence.Constants.OPERATING_LOCATION);
	
	//determine company org structure
	structures := PROJECT(filteredInquiredBus, TRANSFORM({RECORDOF(LEFT)},
																												SELF.company_org_structure_derived := IF(LEFT.trust >= 1, DueDiligence.Constants.CMPTYP_TRUST, LEFT.company_org_structure_derived);
																												SELF := LEFT;));
	
	sortStructures := SORT(structures, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -dt_last_seen);
	
	rollStructure := ROLLUP(sortStructures,
													#EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
													TRANSFORM({RECORDOF(LEFT)},
																		SELF.company_org_structure_derived := IF(LEFT.company_org_structure_derived = DueDiligence.Constants.EMPTY, RIGHT.company_org_structure_derived, LEFT.company_org_structure_derived);
																		SELF := LEFT;));
		
	addAddrStructure := JOIN(addMatchingRAAddresses, rollStructure,
														#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.adrBusnType := RIGHT.company_org_structure_derived;
																			SELF := LEFT;),
														LEFT OUTER);

									
	//determine if business is operating from a private post, mail drop, remailer, storage facility or undeliverable secondary range										
	operatingMailingAddr := PROJECT(filteredInquiredBus + filteredOperatingLocations, TRANSFORM({BOOLEAN privatePost, BOOLEAN mailDrop, BOOLEAN remailer, BOOLEAN storageFacility, BOOLEAN undelSecRange, BOOLEAN isVacant, BOOLEAN incLooseState, RECORDOF(LEFT)},
                                                                                              SELF.privatePost := LEFT.priv_post > 0;
                                                                                              SELF.mailDrop := LEFT.drop > 0;
                                                                                              SELF.remailer := LEFT.potential_remail;
                                                                                              SELF.storageFacility := LEFT.storage > 0;
                                                                                              SELF.undelSecRange := LEFT.undel_sec > 0;
                                                                                              SELF.isVacant := LEFT.vacant_cnt > 0;
                                                                                              SELF.incLooseState := LEFT.inc_st_loose_cnt > 0;
                                                                                              SELF := LEFT;));
																															
	sortOperatingMailingAddr := SORT(operatingMailingAddr, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), partyIndicator);
	
	rollOperatingMailingAddr := ROLLUP(sortOperatingMailingAddr,
																			#EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                      LEFT.partyIndicator = RIGHT.partyIndicator,
																			TRANSFORM({RECORDOF(LEFT)},
																								SELF.privatePost := LEFT.privatePost OR RIGHT.privatePost;
																								SELF.mailDrop := LEFT.mailDrop OR RIGHT.mailDrop;
																								SELF.remailer := LEFT.remailer OR RIGHT.remailer;
																								SELF.storageFacility := LEFT.storageFacility OR RIGHT.storageFacility;
																								SELF.undelSecRange := LEFT.undelSecRange OR RIGHT.undelSecRange;
																								SELF.isVacant := LEFT.isVacant OR RIGHT.isVacant;
																								SELF.incLooseState := LEFT.incLooseState OR RIGHT.incLooseState;
																								SELF := LEFT;));

	addOperatingMailingAddr := JOIN(addAddrStructure, rollOperatingMailingAddr(partyIndicator = DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE),
																	#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
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
                                  
  //add the vancancy to the operating locations - only if requested by the report
  addOperatingLocation := IF(includeReport, DueDiligence.getBusAddrDataReportData.AddOperatingVacancy(rollOperatingMailingAddr(partyIndicator = DueDiligence.Constants.OPERATING_LOCATION), addOperatingMailingAddr), addOperatingMailingAddr);


	//determine if registered agent address contains a NIS or business incubator
	raInfo := PROJECT(filteredRegisteredAgents, TRANSFORM({BOOLEAN foundNis, BOOLEAN foundIncubator, RECORDOF(LEFT)},
																													SELF.foundNis := LEFT.potential_nis;
																													SELF.foundIncubator := LEFT.potential_shelf;
																													SELF := LEFT;));

	sortRaAgent := SORT(raInfo, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	rollRaAgent := ROLLUP(sortRaAgent,
												#EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
												TRANSFORM({RECORDOF(LEFT)},
																		SELF.foundNis := LEFT.foundNis OR RIGHT.foundNis;
																		SELF.foundIncubator := LEFT.foundIncubator OR RIGHT.foundIncubator;
																		SELF := LEFT));
																
	
	addAgentInfo := JOIN(addOperatingLocation, rollRaAgent,
												#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																	SELF.agentShelfBusn := RIGHT.foundIncubator;
																	SELF.agentPotentialNIS := RIGHT.foundNis;
																	SELF := LEFT;),
												LEFT OUTER);



	//determine high risk sic code based on address - for both inquired business and operating locations
	highRiskBus := inData + operatingLocations;
	
	hraSicRaw := JOIN(highRiskBus, risk_indicators.key_HRI_Address_To_SIC,
										RIGHT.sic_code <> DueDiligence.Constants.EMPTY and 
										KEYED(TRIM(LEFT.busn_info.address.zip5) = RIGHT.z5) AND
										KEYED(TRIM(LEFT.busn_info.address.prim_range) = RIGHT.prim_range) AND
										KEYED(TRIM(LEFT.busn_info.address.prim_name) = RIGHT.prim_name) AND
										KEYED(TRIM(LEFT.busn_info.address.addr_suffix) = RIGHT.suffix) AND
										KEYED(TRIM(LEFT.busn_info.address.predir) = RIGHT.predir) AND
										KEYED(TRIM(LEFT.busn_info.address.postdir) = RIGHT.postdir) AND
										KEYED(TRIM(LEFT.busn_info.address.sec_range) = RIGHT.sec_range),
										TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED4 historyDate, STRING2 partyIndicator, RECORDOF(RIGHT)},
															SELF.seq := LEFT.seq;
															SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
															SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
															SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
															SELF.historyDate := LEFT.historyDate;
															SELF.partyIndicator := LEFT.relatedDegree;
															SELF := RIGHT;
															SELF := [];),
										ATMOST(DueDiligence.Constants.MAX_ATMOST_100));
										
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	addrSicDateFilt := DueDiligence.Common.CleanDatasetDateFields(hraSicRaw, 'dt_first_seen');
	
	// Filter out records after our history date.
	addrSicDataFiltRecs := DueDiligence.Common.FilterRecordsSingleDate(addrSicDateFilt, dt_first_seen);
	
	addrSicDataTrans := PROJECT(addrSicDataFiltRecs, TRANSFORM({BOOLEAN cmraSicCode, RECORDOF(LEFT)},
																															SELF.cmraSicCode := LEFT.sic_code IN DueDiligence.Constants.CMRA_SIC_CODES;
																															SELF := LEFT;
																															SELF := [];));
																															
	addrSicDataSort := SORT(addrSicDataTrans, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), partyIndicator, -cmraSicCode);
	addrSicDataDedup := DEDUP(addrSicDataSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), partyIndicator);
	
	//add cmra to the inquired business
	addAddrSicData := JOIN(addAgentInfo, addrSicDataDedup(partyIndicator = DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE),
													#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.cmra := RIGHT.cmraSicCode;
																		SELF := LEFT;),
													LEFT OUTER);
													
													
	//add the cmra to the operating locations - only if requested by the report
	readdOperatingLocation := IF(includeReport, DueDiligence.getBusAddrDataReportData.AddOperatingCMRA(addrSicDataTrans(partyIndicator = DueDiligence.Constants.OPERATING_LOCATION), addAddrSicData), addAddrSicData); 








	// OUTPUT(inData, NAMED('inData'));
	
	// OUTPUT(addrCountRaw, NAMED('addrCountRaw'));
	// OUTPUT(addCounts, NAMED('addCounts'));
	
	// OUTPUT(allAgents, NAMED('allAgents'));	
	// OUTPUT(rollMatchingRAAddr, NAMED('rollMatchingRAAddr'));
	// OUTPUT(addMatchingRAAddresses, NAMED('addMatchingRAAddresses'));
	
	// OUTPUT(allParties, NAMED('allParties'));
	
	// OUTPUT(addrRaw, NAMED('addrRaw'));
	
	// OUTPUT(filteredInquiredBus, NAMED('filteredInquiredBus'));
	// OUTPUT(filteredRegisteredAgents, NAMED('filteredRegisteredAgents'));
	// OUTPUT(filteredOperatingLocations, NAMED('filteredOperatingLocations'));
	
	// OUTPUT(structures, NAMED('structures'));
	// OUTPUT(sortStructures, NAMED('sortStructures'));
	// OUTPUT(rollStructure, NAMED('rollStructure'));
	// OUTPUT(addAddrStructure, NAMED('addAddrStructure'));

	// OUTPUT(operatingMailingAddr, NAMED('operatingMailingAddr'));
	// OUTPUT(rollOperatingMailingAddr, NAMED('rollOperatingMailingAddr'));
	// OUTPUT(addOperatingMailingAddr, NAMED('addOperatingMailingAddr'));
	
	// OUTPUT(addOperatingLocation, NAMED('addOperatingLocation'));
	
	// OUTPUT(raInfo, NAMED('raInfo'));
	// OUTPUT(rollRaAgent, NAMED('rollRaAgent'));
	// OUTPUT(addAgentInfo, NAMED('addAgentInfo'));
	
	// OUTPUT(operatingLocations, NAMED('operatingLocations'));
	// OUTPUT(highRiskBus, NAMED('highRiskBus'));
	// OUTPUT(hraSicRaw, NAMED('hraSicRaw'));
	// OUTPUT(addrSicDataFiltRecs, NAMED('addrSicDataFiltRecs'));
	// OUTPUT(addrSicDataTrans, NAMED('addrSicDataTrans'));
	// OUTPUT(addrSicDataSort, NAMED('addrSicDataSort'));
	// OUTPUT(addrSicDataDedup, NAMED('addrSicDataDedup'));
	// OUTPUT(addAddrSicData, NAMED('addAddrSicData'));
	
	// OUTPUT(readdOperatingLocation, NAMED('readdOperatingLocation'));
  
	// OUTPUT(addAgentCounts, NAMED('addAgentCounts'));	



	RETURN readdOperatingLocation;

END;
