IMPORT BIPv2, Business_Risk_BIP, DueDiligence, iesp;

EXPORT reportBusRegisteredAgents(DATASET(DueDiligence.layouts.Busn_Internal) inData,
                                  Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                                  BIPV2.mod_sources.iParams linkingOptions) := FUNCTION
    
    
    
    getCleanAgents(DATASET(DueDiligence.LayoutsInternal.Agent) agents, BOOLEAN agentsAreBusiness) := FUNCTION
      cleanedAgent := PROJECT(agents, TRANSFORM({RECORDOF(LEFT), UNSIGNED6 agentID, DATASET(DueDiligence.Layouts.CleanedData) clean},
                                                    SELF.clean := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.CleanedData,
                                                                                          SELF.cleanedInput.business.accountNumber := IF(agentsAreBusiness, (STRING)COUNTER, DueDiligence.Constants.EMPTY);
                                                                                          SELF.cleanedInput.business.companyName := IF(agentsAreBusiness, LEFT.agent.fullname, DueDiligence.Constants.EMPTY);
                                                                                          SELF.cleanedInput.business.address := IF(agentsAreBusiness, LEFT.agent);
                                                                                          SELF.inputEcho.business.accountNumber := IF(agentsAreBusiness, (STRING)COUNTER, DueDiligence.Constants.EMPTY);
                                                                                          
                                                                                          
                                                                                          SELF.cleanedInput.fullAddressProvided := TRUE;
                                                                                          SELF.cleanedInput.individual.name := IF(agentsAreBusiness = FALSE, LEFT.agent);
                                                                                          SELF.cleanedInput.individual.address := IF(agentsAreBusiness = FALSE, LEFT.agent);
                                                                                          
                                                                                          SELF.cleanedInput.historyDateYYYYMMDD := LEFT.historyDate;
                                                                                          SELF.cleanedInput.seq := COUNTER;
                                                                                          SELF.inputEcho.seq := COUNTER;
                                                                                          
                                                                                          
                                                                                          SELF := [];));
                                                                                                      
                                                    SELF := LEFT;
                                                    SELF := [];));
                                                    
      RETURN cleanedAgent;
    
    END;
    
    
    
    
    
    //get the list of the registered agents to the inquired business
    agents := DueDiligence.CommonBusiness.getRegisteredAgents(inData);
    
    //limit the amount of registered agents
    sortGroupAgents := GROUP(SORT(agents, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -agent.dateLastSeen), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
  
    //limit the number of associated names for a given fein
    DueDiligence.LayoutsInternal.Agent getMaxAgents(sortGroupAgents sgan, INTEGER agentCount) := TRANSFORM, SKIP(agentCount > iesp.constants.DDRAttributesConst.MaxRegisteredAgents) 
      SELF := sgan;
      SELF := [];
    END;
    
    limitedAgents := PROJECT(sortGroupAgents, getMaxAgents(LEFT, COUNTER));
    ungroupAgents := UNGROUP(limitedAgents);
    
    //get the lexID for the agents - could be business or individual
    busAgents := ungroupAgents(agent.fullname <> DueDiligence.Constants.EMPTY);
    indAgents := ungroupAgents(agent.fullname = DueDiligence.Constants.EMPTY);
    
    cleanBusAgent := getCleanAgents(busAgents, TRUE);
    cleanIndAgent := getCleanAgents(indAgents, FALSE);
    
    
    //get LexIDs
    busLexIDs := DueDiligence.getBusBIPId(cleanBusAgent.clean, options, linkingOptions, FALSE);
    indLexIDs := DueDiligence.getIndDID(cleanIndAgent.clean, options.DataRestrictionMask, options.DPPA_Purpose, options.GLBA_Purpose,
                                        DueDiligence.CitDDShared.DEFAULT_BS_VERSION, DueDiligence.CitDDShared.DEFAULT_BS_OPTIONS);
   

                                                  
    //retrieve LexIDs                                               
    addBusAgentLexID := JOIN(cleanBusAgent, busLexIDs,
                            LEFT.clean[1].inputEcho.seq = RIGHT.seq,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.agentID := RIGHT.Busn_info.BIP_IDS.SeleID.LinkID;
                                      SELF := LEFT;),
                            LEFT OUTER);
                            
    addIndAgentLexID := JOIN(cleanIndAgent, indLexIDs,
                              LEFT.clean[1].inputEcho.seq = RIGHT.seq,
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.agentID := RIGHT.inquiredDID;
                                        SELF := LEFT;),
                              LEFT OUTER);
     
    //since both individual and business agrents are in the same layout - add them together to transform them once 
    allAgentsWithLexID := addBusAgentLexID + addIndAgentLexID;                        

    transformData := PROJECT(allAgentsWithLexID, TRANSFORM(DueDiligence.LayoutsInternalReport.BusRegisteredAgents,
                                                            SELF.regAgents := PROJECT(LEFT, TRANSFORM(iesp.duediligencebusinessreport.t_DDRRegisteredAgents, 
                                                                                                            SELF.Name := PROJECT(LEFT, TRANSFORM(iesp.share.t_Name,
                                                                                                                                                 SELF.full := LEFT.agent.fullName;
                                                                                                                                                 SELF.first := LEFT.agent.firstName;
                                                                                                                                                 SELF.middle := LEFT.agent.middleName;
                                                                                                                                                 SELF.last := LEFT.agent.lastName;
                                                                                                                                                 SELF.suffix := LEFT.agent.suffix;
                                                                                                                                                 SELF := [];));
                                                                  
                                                                                                            SELF.Address := PROJECT(LEFT, TRANSFORM(iesp.share.t_Address,
                                                                                                                                                    SELF.StreetNumber := LEFT.agent.prim_range;
                                                                                                                                                    SELF.StreetPreDirection := LEFT.agent.predir;
                                                                                                                                                    SELF.StreetName := LEFT.agent.prim_name;
                                                                                                                                                    SELF.StreetSuffix := LEFT.agent.addr_suffix;
                                                                                                                                                    SELF.StreetPostDirection := LEFT.agent.postdir;
                                                                                                                                                    SELF.UnitDesignation := LEFT.agent.unit_desig;
                                                                                                                                                    SELF.UnitNumber := LEFT.agent.sec_range;
                                                                                                                                                    SELF.postalCode := LEFT.agent.zip5 + LEFT.agent.zip4;
                                                                                                                                                    SELF.StateCityZip := TRIM(LEFT.agent.State) + TRIM(LEFT.agent.city) + TRIM(LEFT.agent.zip5);
                                                                                                                                                    SELF := LEFT.agent;
                                                                                                                                                    SELF := [];));
                                                                                                            
                                                                                                            SELF.LexID := (STRING)LEFT.agentID;
                                                                                                            SELF.AddressMatchesInputBusiness := LEFT.agent.addressMatchesInquiredBusiness;
                                                                                                            SELF.NumberOfBusinessesAtAddress := LEFT.agent.numberOfBusinessesAtAddress;
                                                                                                            SELF.NumberOfBusinessesWithNoFEIN := LEFT.agent.numberOfBusinessesWithNoFein;
                                                                                                            SELF.NumberOfBusinessesIncorpStateWithLooseIncorpLaws := LEFT.agent.numberOfBusinssesIncWithLooseIncLaws;
                                                                                                            SELF := LEFT.agent;
                                                                                                            SELF := [];));
                                                            SELF := LEFT;
                                                            SELF := [];));
                                                        
    // add all inquired business agents together in esp layout so can add to report
    rollAgents := ROLLUP(SORT(transformData, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())),
                           #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                           TRANSFORM(RECORDOF(LEFT),  
                                      SELF.regAgents := LEFT.regAgents + RIGHT.regAgents;
                                      SELF := LEFT;));
                                      
    // add agents to report
    addAgentsToReport := JOIN(inData, rollAgents,
                              #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.BusinessReport.BusinessAttributeDetails.NetworkDetails.RegisteredAgents := RIGHT.regAgents;
                                        SELF := LEFT),
                              LEFT OUTER);
    
    
    
    
    // OUTPUT(agents, NAMED('agents'));
    // OUTPUT(limitedAgents, NAMED('limitedAgents'));
    // OUTPUT(ungroupAgents, NAMED('ungroupAgents'));
    
    // OUTPUT(busAgents, NAMED('busAgents'));
    // OUTPUT(cleanBusAgent, NAMED('cleanBusAgent'));
    // OUTPUT(busLexIDs, NAMED('busLexIDs'));
    // OUTPUT(addBusAgentLexID, NAMED('addBusAgentLexID'));
    
    // OUTPUT(indAgents, NAMED('indAgents'));
    // OUTPUT(cleanIndAgent, NAMED('cleanIndAgent'));
    // OUTPUT(indLexIDs, NAMED('indLexIDs'));
    // OUTPUT(addIndAgentLexID, NAMED('addIndAgentLexID'));
    
    // OUTPUT(transformData, NAMED('transformData'));
    // OUTPUT(rollAgents, NAMED('rollAgents'));
    // OUTPUT(addAgentsToReport, NAMED('addAgentsToReport'));

    
    
    RETURN addAgentsToReport;
END;                       