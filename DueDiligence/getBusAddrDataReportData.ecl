IMPORT DueDiligence;

EXPORT getBusAddrDataReportData := MODULE

  EXPORT AddRegisteredAgentAddressCounts(regAgentData, busnInternalData) := FUNCTIONMACRO
    //add counts for the registered agents
    normAllAgents := DueDiligence.CommonBusiness.getRegisteredAgents(busnInternalData);
    
    allAgentCounts := JOIN(normAllAgents, regAgentData,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                            LEFT.agent.zip5 = RIGHT.zip AND
                            LEFT.agent.prim_range = RIGHT.prim_range AND
                            LEFT.agent.prim_name = RIGHT.prim_name AND
                            LEFT.agent.addr_suffix = RIGHT.addr_suffix AND
                            LEFT.agent.predir = RIGHT.predir AND
                            LEFT.agent.postdir = RIGHT.postdir,
                            TRANSFORM(DueDiligence.LayoutsInternal.AgentLayout,
                                      SELF.agents := DATASET([TRANSFORM(DueDiligence.Layouts.LayoutAgent,
                                                                        SELF.numberOfBusinessesAtAddress := RIGHT.biz_cnt;
                                                                        SELF.numberOfBusinessesWithNoFein := RIGHT.no_fein_cnt;
                                                                        SELF.numberOfBusinssesIncWithLooseIncLaws := RIGHT.inc_st_loose_cnt;
                                                                        SELF := LEFT.agent;)]);
                                      
                                      
                                      SELF := LEFT),
                            LEFT OUTER);

    rollAgentCounts := ROLLUP(SORT(allAgentCounts, seq, ultID, orgID, seleID),
                              #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.agents := LEFT.agents + RIGHT.agents;
                                        SELF := LEFT;));

    
    addAgentCounts := JOIN(busnInternalData, rollAgentCounts,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.registeredAgents := RIGHT.agents;
                                      SELF := LEFT;),
                            LEFT OUTER);
                            
    RETURN addAgentCounts;
  ENDMACRO;
  
  
  EXPORT AddOperatingVacancy(operatingLocationData, busnInternalData) := FUNCTIONMACRO
    //grab the operating locations from the inquired business
    initialOpLocations := DueDiligence.CommonBusiness.GetOperatingLocations(busnInternalData);
    
    addOpLocVancancy := JOIN(initialOpLocations, operatingLocationData,
                          #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                          TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(DueDiligence.Layouts.CommonGeographicLayout) opLocations},
                                    SELF.opLocations := DATASET([TRANSFORM(DueDiligence.Layouts.CommonGeographicLayout,
                                                                            SELF.vacant := RIGHT.vacant;
                                                                            SELF := LEFT;)]);
                                    SELF := LEFT;),
                          LEFT OUTER); 
                      
    //reAdd operating locations
    addOperatingLocation := DueDiligence.CommonBusiness.readdOperatingLocations(busnInternalData, addOpLocVancancy, opLocations);  
    
    RETURN addOperatingLocation;
  ENDMACRO;
  
  
  EXPORT AddOperatingCMRA(operatingLocationData, busnInternalData) := FUNCTIONMACRO
    //grab the operating locations from the inquired business
    originalOpLocations := DueDiligence.CommonBusiness.GetOperatingLocations(busnInternalData);
    
    addOpLocCMRA := JOIN(originalOpLocations, operatingLocationData,
                          #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                          LEFT.zip5 = RIGHT.z5 AND
                          LEFT.prim_range = RIGHT.prim_range AND
                          LEFT.prim_name = RIGHT.prim_name AND
                          LEFT.addr_suffix = RIGHT.suffix AND
                          LEFT.predir = RIGHT.predir AND
                          LEFT.postdir = RIGHT.postdir AND
                          LEFT.sec_range = RIGHT.sec_range,
                          //TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(DueDiligence.Layouts.BusOperLocationLayout) opLocations},
                          TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(DueDiligence.Layouts.CommonGeographicLayout) opLocations},
                                    //SELF.opLocations := DATASET([TRANSFORM(DueDiligence.Layouts.BusOperLocationLayout,
                                    SELF.opLocations := DATASET([TRANSFORM(DueDiligence.Layouts.CommonGeographicLayout,
                                                                            SELF.cmra := RIGHT.cmrasiccode;
                                                                            SELF := LEFT;)]);
                                    SELF := LEFT;),
                          LEFT OUTER);
    
                      
    //reAdd operating locations
    readdOperatingLocation := DueDiligence.CommonBusiness.ReaddOperatingLocations(busnInternalData, addOpLocCMRA, opLocations);
    
    RETURN readdOperatingLocation;
  ENDMACRO;

END;