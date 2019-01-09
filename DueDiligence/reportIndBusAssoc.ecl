IMPORT advo, BIPV2, Business_Risk_BIP, Codes, DueDiligence, iesp, Risk_Indicators;


/*
	Following Keys being used:
			Risk_Indicators.Key_Sic_Description
      Codes.Key_NAICS
*/
EXPORT reportIndBusAssoc(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                          Business_Risk_BIP.LIB_Business_Shell_LIBIN options) := FUNCTION
													
													
													
		
		//convert those that have associated businesses, regardless of any BEOs
    convertToBusiness := NORMALIZE(inData, LEFT.perBusinessAssociations(seleID > 0), TRANSFORM({UNSIGNED6 inquiredDID, DueDiligence.Layouts.CleanedData, DueDiligence.Layouts.BusAsscoiations perBusAssoc},
																																																SELF.inquiredDID := LEFT.inquiredDID;
																																																SELF.cleanedInput.business.BIP_IDs.UltID.LinkID := RIGHT.ultID;
																																																SELF.cleanedInput.business.BIP_IDs.OrgID.LinkID := RIGHT.orgID;
																																																SELF.cleanedInput.business.BIP_IDs.SeleID.LinkID := RIGHT.seleID;
																																																SELF.cleanedInput.business.inputSeq := LEFT.seq;
																																																SELF.cleanedInput.historyDateYYYYMMDD := LEFT.historyDate;
																																																SELF.inputecho.inputSeq := LEFT.seq;
																																																SELF.perBusAssoc := RIGHT;
																																																SELF := [];));
																																										
		uniqueBusinessID := PROJECT(convertToBusiness, TRANSFORM(RECORDOF(LEFT), 
																															SELF.inputecho.seq := COUNTER; 
																															SELF.cleanedInput.seq := COUNTER;
																															SELF := LEFT;));
																															
		layoutForBusInfo := PROJECT(uniqueBusinessID, TRANSFORM(DueDiligence.Layouts.CleanedData, SELF := LEFT));																													
    
		//retrieve the best info for a business
    busInfo := DueDiligence.getBusInfo(layoutForBusInfo);			
		
		populateBusiness := JOIN(busInfo, uniqueBusinessID,
															LEFT.seq = RIGHT.inputEcho.seq,
															TRANSFORM(DueDiligence.LayoutsInternalReport.IndivBusAssociationLayout,
																				SELF.seq := LEFT.seq;
																				SELF.inquiredDID := RIGHT.inquiredDID;
																				SELF.inputSeq := LEFT.busn_info.inputSeq;
																				SELF.ultID := LEFT.busn_info.BIP_IDs.UltID.LinkID;
																				SELF.orgID := LEFT.busn_info.BIP_IDs.OrgID.LinkID;
																				SELF.seleID := LEFT.busn_info.BIP_IDs.SeleID.LinkID;
																				SELF.association.BusinessName := LEFT.busn_info.companyName;
																				
																				address := LEFT.busn_info.address;
																				SELF.association.BusinessAddress := iesp.ECL2ESP.SetAddress(address.prim_name, address.prim_range, address.predir,
																																																		address.postdir, address.addr_suffix, address.unit_desig,
																																																		address.sec_range, address.city, address.state, address.zip5,
																																																		address.zip4, address.county, DueDiligence.Constants.EMPTY,
																																																		address.streetAddress1, address.streetAddress2);
																				SELF.association.BusinessAddressType := advo.Lookup_Descriptions.Record_Type_Description_lookup(address.rec_type);
																				SELF.association.LexID := LEFT.busn_info.lexID;
																				SELF.association.StructureType := RIGHT.perBusAssoc.structure;
																				SELF.association.ExecutiveOfficers := NORMALIZE(RIGHT.perBusAssoc.beos, LEFT.positions, 
																																												TRANSFORM(iesp.duediligencepersonreport.t_DDRExecutives,
																																																	SELF.Name := iesp.ECL2ESP.SetName(LEFT.firstName, LEFT.middleName, LEFT.lastName, LEFT.suffix, DueDiligence.Constants.EMPTY, LEFT.fullName);
																																																	SELF.LexID := (STRING)LEFT.did;
																																																	SELF.ExecTitle := RIGHT.title;
																																																	SELF.FirstReported := iesp.ECL2ESP.toDate(RIGHT.firstSeen);
																																																	SELF.LastReported := iesp.ECL2ESP.toDate(RIGHT.lastSeen);
																																																	SELF := [];));
																				SELF := [];));
		

		
		//get the SIC/NAIC descriptions
		industryRisk := NORMALIZE(uniqueBusinessID, (LEFT.perBusAssoc.sicNAICRisk.bestSic + LEFT.perBusAssoc.sicNAICRisk.bestNAICS + LEFT.perBusAssoc.sicNAICRisk.highestRisk)(code <> DueDiligence.Constants.EMPTY),
															TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED6 inputSeq, DueDiligence.Layouts.SICNAICRating, STRING8 rawCode, iesp.duediligencepersonreport.t_DDRIndustryRisk espRisk},
																				SELF.seq := LEFT.inputecho.seq;
																				SELF.inputSeq := LEFT.inputecho.inputSeq;
																				SELF.seleID := LEFT.cleanedInput.business.BIP_IDS.SeleID.LinkID;																				
																				
																				tempSic := TRIM(RIGHT.code) + '00000000';
																				newSic := tempSic[1..8];
																				
																				SELF.code := IF(RIGHT.sicNAICSIndicator = DueDiligence.Constants.INDUSTRY_INDICATOR_SIC, newSic, RIGHT.code);
																				SELF.rawCode := RIGHT.code;
																				
																				SELF := RIGHT;
																				SELF := [];));
																																		
		// filter out sic and naics
		sicOnly := industryRisk(sicNAICSIndicator = DueDiligence.Constants.INDUSTRY_INDICATOR_SIC);
		naicsOnly := industryRisk(sicNAICSIndicator = DueDiligence.Constants.INDUSTRY_INDICATOR_NAICS);
																																			
		// get descriptions
		sicDescriptions := JOIN(sicOnly, Risk_Indicators.Key_Sic_Description,
														LEFT.code = RIGHT.sic_code,
														TRANSFORM(RECORDOF(LEFT),	
																			SELF.espRisk.Code := LEFT.rawCode;
																			SELF.espRisk.Description := RIGHT.sic_description; // get desc from key
																			SELF.espRisk.IndustryRisk := DueDiligence.translateCodeToText.IndustryRiskText(LEFT.highestIndustryOrRiskLevel);
																			SELF := LEFT;),
														LEFT OUTER,
														ATMOST(DueDiligence.Constants.MAX_ATMOST_1000),
														KEEP(1)); // should only be 1 matching sic code on right
									
		
		naicDiscriptions := JOIN(naicsOnly, Codes.Key_NAICS,
															LEFT.code = RIGHT.naics_code,
															TRANSFORM(RECORDOF(LEFT),	
																				SELF.espRisk.Code := LEFT.rawCode;
																				SELF.espRisk.Description := RIGHT.naics_description; // get desc from key
																				SELF.espRisk.IndustryRisk := DueDiligence.translateCodeToText.IndustryRiskText(LEFT.highestIndustryOrRiskLevel);
																				SELF := LEFT;),
															LEFT OUTER, 
															ATMOST(DueDiligence.Constants.MAX_ATMOST_1000),
															KEEP(1)); // should only be 1 matching naics code on right					 
		

		// add the descriptions back together
		addIndustryCodes := DENORMALIZE(populateBusiness, sicDescriptions + naicDiscriptions,
																		LEFT.seq = RIGHT.seq AND
																		LEFT.inputSeq = RIGHT.inputSeq AND
																		LEFT.seleID = RIGHT.seleID,
																		TRANSFORM(DueDiligence.LayoutsInternalReport.IndivBusAssociationLayout,
																								SELF.association.BestSic := IF(RIGHT.industryCategory = DueDiligence.Constants.INDUSTRY_GROUP_BEST_SIC, RIGHT.espRisk, LEFT.association.BestSic);
																								SELF.association.BestNaics := IF(RIGHT.industryCategory = DueDiligence.Constants.INDUSTRY_GROUP_BEST_NAICS, RIGHT.espRisk, LEFT.association.BestNaics);
																								SELF.association.HighestRisk := IF(RIGHT.industryCategory = DueDiligence.Constants.INDUSTRY_GROUP_HIGHEST_RISK, RIGHT.espRisk, LEFT.association.HighestRisk);
																								SELF := LEFT;),
																		LEFT OUTER);
		
		
		
		//grab the registered agents
		agents := NORMALIZE(uniqueBusinessID, LEFT.perBusAssoc.registeredAgents,
												TRANSFORM({DueDiligence.Layouts.CleanedData clean, UNSIGNED6 agentBusID, BOOLEAN agentIsBus, DueDiligence.Layouts.SlimIndividual agent, DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout bus},
																	agentsAreBusiness := RIGHT.fullName <> DueDiligence.Constants.EMPTY;
																	
																	SELF.clean.cleanedInput.business.companyName := IF(agentsAreBusiness, RIGHT.fullname, DueDiligence.Constants.EMPTY);
																	SELF.clean.cleanedInput.business.address := IF(agentsAreBusiness, RIGHT);
																	
																	SELF.clean.cleanedInput.business.BIP_IDs.UltID.LinkID := DueDiligence.Constants.NUMERIC_ZERO;
																	SELF.clean.cleanedInput.business.BIP_IDs.OrgID.LinkID := DueDiligence.Constants.NUMERIC_ZERO;
																	SELF.clean.cleanedInput.business.BIP_IDs.SeleID.LinkID := DueDiligence.Constants.NUMERIC_ZERO;
																	
																	
																	SELF.clean.cleanedInput.fullAddressProvided := TRUE;
																	SELF.clean.cleanedInput.individual.name := IF(agentsAreBusiness = FALSE, RIGHT);
																	SELF.clean.cleanedInput.individual.address := IF(agentsAreBusiness = FALSE, RIGHT);
																	
																	SELF.agentIsBus := agentsAreBusiness;
																	SELF.agentBusID := LEFT.inputecho.seq;
																	
																	SELF.bus.seq := LEFT.inputecho.seq;
																	SELF.bus.ultID := LEFT.cleanedInput.business.BIP_IDs.UltID.LinkID;
																	SELF.bus.orgID := LEFT.cleanedInput.business.BIP_IDs.OrgID.LinkID;
																	SELF.bus.SeleID := LEFT.cleanedInput.business.BIP_IDs.SeleID.LinkID;
																	
																	SELF.agent := RIGHT;
																	SELF.clean := LEFT;
																	SELF := [];));
																																										
		uniqueAgentID := PROJECT(agents, TRANSFORM({DATASET(DueDiligence.Layouts.CleanedData) clean, UNSIGNED6 agentBusID, BOOLEAN agentIsBus, DueDiligence.Layouts.SlimIndividual agent, DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout bus},
																								SELF.clean := DATASET([TRANSFORM(DueDiligence.Layouts.CleanedData,
																																									SELF.inputecho.seq := COUNTER;
																																									SELF.cleanedInput.seq := COUNTER;
																																									SELF := LEFT.clean;)]);
																								SELF := LEFT;
																								SELF := [];));
																								
		// get LexIDs
		busAgents := uniqueAgentID(agentIsBus);
		indAgents := uniqueAgentID(agentIsBus = FALSE);
		
    busLexIDs := DueDiligence.getBusInfo(busAgents.clean);
    indLexIDs := DueDiligence.getIndDID(indAgents.clean, options.DataRestrictionMask, options.DPPA_Purpose, options.GLBA_Purpose,
                                        DueDiligence.CitDDShared.DEFAULT_BS_VERSION, DueDiligence.CitDDShared.DEFAULT_BS_OPTIONS);
																				
																				
																				
		//retrieve LexIDs                                               
    addBusAgentLexID := JOIN(uniqueAgentID, busLexIDs,
                            LEFT.clean[1].inputEcho.seq = RIGHT.seq,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.agent.did := RIGHT.Busn_info.BIP_IDS.SeleID.LinkID;
                                      SELF := LEFT;));
                            
    addIndAgentLexID := JOIN(uniqueAgentID, indLexIDs,
                              LEFT.clean[1].inputEcho.seq = RIGHT.seq,
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.agent.did := RIGHT.inquiredDID;
                                        SELF := LEFT;));
															
		//since both individual and business agrents are in the same layout - add them together to transform them once 
    allAgentsWithLexID := addBusAgentLexID + addIndAgentLexID; 
		
		sortGroupAgents := GROUP(SORT(allAgentsWithLexID, bus.seq, bus.ultID, bus.orgID, bus.seleID, agentBusID, -agent.dateLastSeen, -agent.did), bus.seq, bus.ultID, bus.orgID, bus.seleID, agentBusID);
		
		maxAgents := DueDiligence.Common.GetMaxRecords(sortGroupAgents, iesp.Constants.DDRAttributesConst.MaxRegisteredAgents);
		
		transformAgents := PROJECT(maxAgents, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED6 inputSeq, iesp.duediligenceshared.t_DDRPersonNameWithLexID flatAgent, DATASET(iesp.duediligenceshared.t_DDRPersonNameWithLexID) espAgents},
																										SELF.seq := LEFT.agentBusID;
																										SELF.ultID := LEFT.bus.ultID;
																										SELF.orgID := LEFT.bus.orgID;
																										SELF.seleID := LEFT.bus.seleID;
																										SELF.inputSeq := LEFT.clean[1].cleanedInput.business.inputSeq;
																										
																										espName := iesp.ECL2ESP.SetName(LEFT.agent.firstName, LEFT.agent.middleName, LEFT.agent.lastName, LEFT.agent.suffix, DueDiligence.Constants.EMPTY, LEFT.agent.fullName);
																										
																										SELF.flatAgent.Name := espName;
																										SELF.flatAgent.LexID := (STRING)LEFT.agent.did;
																										SELF.espAgents := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRPersonNameWithLexID,
																																												SELF.Name := espName;
																																												SELF.LexID := (STRING)LEFT.agent.did;)]);
																										SELF := [];));
		dedupAgents := DEDUP(transformAgents, ALL);	
		
		sortAgents := SORT(dedupAgents, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), inputSeq);
																										
		rolledAgents := ROLLUP(sortAgents,
														LEFT.seq = RIGHT.seq AND
														LEFT.ultID = RIGHT.ultID AND
														LEFT.orgID = RIGHT.orgID AND
														LEFT.seleID = RIGHT.seleID AND
														LEFT.inputSeq = RIGHT.inputSeq,
														TRANSFORM(RECORDOF(LEFT),
																			SELF.espAgents := LEFT.espAgents + RIGHT.espAgents;
																			SELF := LEFT;));
		
		//add the registered agents
		addRegisteredAgents := JOIN(addIndustryCodes, rolledAgents,
																LEFT.seq = RIGHT.seq AND
																LEFT.inputSeq = RIGHT.inputSeq,
																TRANSFORM(DueDiligence.LayoutsInternalReport.IndivBusAssociationLayout,
																						SELF.association.RegisteredAgents := RIGHT.espAgents;
																						SELF := LEFT;),
																LEFT OUTER);
																
																
		//roll the associated businesses up to the inqured
		businessDS := PROJECT(addRegisteredAgents, TRANSFORM({UNSIGNED6 inputSeq, UNSIGNED6 inquiredDID, DATASET(iesp.duediligencepersonreport.t_DDRBusinessAssocationDetails) busAssocs}, 
																													SELF.inputSeq := LEFT.inputSeq;
																													SELF.inquiredDID := LEFT.inquiredDID;
																													SELF.busAssocs := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRBusinessAssocationDetails, SELF := LEFT.association;)]);));
		sortBus := SORT(businessDS, inputSeq);
		rollBus := ROLLUP(sortBus,
											LEFT.inputSeq = RIGHT.inputSeq AND
											LEFT.inquiredDID = RIGHT.inquiredDID,
											TRANSFORM(RECORDOF(LEFT),
																SELF.busAssocs := LEFT.busAssocs + RIGHT.busAssocs;
																SELF := LEFT;));
																
																

		//add business associations to the report
		addBusAssocToReport := JOIN(inData, rollBus,
                                LEFT.seq = RIGHT.inputSeq AND
                                LEFT.inquiredDID = RIGHT.inquiredDID,
                                TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                          SELF.PersonReport.PersonAttributeDetails.BusinessAssocation.Associations := RIGHT.busAssocs;
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));
		
		
		
		
		
    // OUTPUT(convertToBusiness, NAMED('convertToBusiness'));
		// OUTPUT(uniqueBusinessID, NAMED('uniqueBusinessID'));
    // OUTPUT(busInfo, NAMED('busInfo'));
    // OUTPUT(populateBusiness, NAMED('populateBusiness'));
		
    // OUTPUT(industryRisk, NAMED('industryRisk'));
    // OUTPUT(sicOnly, NAMED('sicOnly'));
    // OUTPUT(naicsOnly, NAMED('naicsOnly'));
    // OUTPUT(sicDescriptions, NAMED('sicDescriptions'));
    // OUTPUT(naicDiscriptions, NAMED('naicDiscriptions'));
    // OUTPUT(addIndustryCodes, NAMED('addIndustryCodes'));
		
    // OUTPUT(agents, NAMED('agents'));
    // OUTPUT(uniqueAgentID, NAMED('uniqueAgentID'));
    // OUTPUT(busAgents, NAMED('busAgents'));
    // OUTPUT(indAgents, NAMED('indAgents'));
    // OUTPUT(busLexIDs, NAMED('busLexIDs'));
    // OUTPUT(indLexIDs, NAMED('indLexIDs'));
    // OUTPUT(allAgentsWithLexID, NAMED('allAgentsWithLexID'));
    // OUTPUT(sortGroupAgents, NAMED('sortGroupAgents'));
    // OUTPUT(maxAgents, NAMED('maxAgents'));
    // OUTPUT(transformAgents, NAMED('transformAgents'));
    // OUTPUT(dedupAgents, NAMED('dedupAgents'));
    // OUTPUT(sortAgents, NAMED('sortAgents'));
    // OUTPUT(rolledAgents, NAMED('rolledAgents'));
    // OUTPUT(addRegisteredAgents, NAMED('addRegisteredAgents'));
		
    // OUTPUT(businessDS, NAMED('businessDS'));
    // OUTPUT(sortBus, NAMED('sortBus'));
    // OUTPUT(rollBus, NAMED('rollBus'));
    // OUTPUT(addBusAssocToReport, NAMED('addBusAssocToReport'));
		
		
		
		RETURN addBusAssocToReport;
													
													
END;