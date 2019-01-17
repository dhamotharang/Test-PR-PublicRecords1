IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

EXPORT getIndBusAssocBus(DATASET(DueDiligence.Layouts.Busn_Internal) businesses,
                          Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                          BIPV2.mod_sources.iParams linkingOptions) := FUNCTION
     
     
    BOOLEAN includeAllBusinessData := FALSE;
    BOOLEAN includeReportData := FALSE;
                          
    //get information to retrieve SIC/NAICS info
    linkedBus := DueDiligence.getBusLinkedBus(businesses, options, linkingOptions);
  
    busReg := DueDiligence.getBusRegistration(linkedBus, options, includeAllBusinessData);
    
    busHeader := DueDiligence.getBusHeader(busReg, options, linkingOptions, includeAllBusinessData, includeReportData);
    
    busSOS := DueDiligence.getBusSOSDetail(busHeader, options, includeAllBusinessData, includeReportData);
    
    addrRisk := DueDiligence.getBusAddrData(busSOS, options, includeReportData);  //must be called after getBusSOSDetail & getBusRegistration
    
    getBusSICNAICS := DueDiligence.getBusSicNaic(addrRisk, options, linkingOptions, includeReportData);
    
    getBEOs := DueDiligence.getSharedBEOs(getBusSICNAICS, options, linkingOptions); 
    
    //populate the structure for the business
    associatedBusinesses := PROJECT(getBEOs, TRANSFORM(DueDiligence.LayoutsInternal.IndBusAssociations,
                                                        SELF.seq := LEFT.seq;
                                                        SELF.inputSeq := LEFT.Busn_info.inputSeq;
                                                        SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                        SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                        SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                        SELF.busAssociation.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                        SELF.busAssociation.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                        SELF.busAssociation.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                        SELF.busAssociation.beos := PROJECT(LEFT.execs + LEFT.DIDlessExecs, TRANSFORM(DueDiligence.Layouts.Associates, SELF.isBEO := TRUE; SELF := LEFT;));
                                                        SELF.busAssociation.registeredAgents := PROJECT(LEFT.registeredAgents, TRANSFORM(DueDiligence.Layouts.SlimIndividual, SELF := LEFT; SELF := [];));
                                                        SELF.busAssociation.sicNaicRisk := LEFT.sicNaicRisk;
                                                        SELF.busAssociation.structure := MAP(LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_ASSUMED_NAME_DBA OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_ASSUMED_NAME_DBA => DueDiligence.Constants.CMPTYP_ASSUMED_NAME_DBA,
                                                                              LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_TRUST OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_TRUST => DueDiligence.Constants.CMPTYP_TRUST,
                                                                              LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_CORP OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_CORP => DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_CORP,
                                                                              LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_FOREIGN_LLC OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_FOREIGN_LLC => DueDiligence.Constants.CMPTYP_FOREIGN_LLC,
                                                                              LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_CORP_NON_PROFIT OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_CORP_NON_PROFIT => DueDiligence.Constants.CMPTYP_CORP_NON_PROFIT,
                                                                              LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_CORP_BUSINESS OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_CORP_BUSINESS => DueDiligence.Constants.CMPTYP_CORP_BUSINESS,
                                                                              LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_FOREIGN_CORP OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_FOREIGN_CORP => DueDiligence.Constants.CMPTYP_FOREIGN_CORP,
                                                                              LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_PROFESSIONAL_CORP OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_PROFESSIONAL_CORP => DueDiligence.Constants.CMPTYP_PROFESSIONAL_CORP,
                                                                              LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_PROFESSIONAL_ASSOC OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_PROFESSIONAL_ASSOC => DueDiligence.Constants.CMPTYP_PROFESSIONAL_ASSOC,
                                                                              LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_LIMITED_PARTNERSHIP OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_LIMITED_PARTNERSHIP => DueDiligence.Constants.CMPTYP_LIMITED_PARTNERSHIP,
                                                                              LEFT.adrBusnType = DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_PARTNERSHIP OR LEFT.hdBusnType = DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_PARTNERSHIP => DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_PARTNERSHIP,
                                                                              DueDiligence.Constants.EMPTY);
                                                        SELF := [];));
    

      
      
      
      
                          
    // OUTPUT(linkedBus, NAMED('linkedBus'));                
    // OUTPUT(busReg, NAMED('busReg'));                
    // OUTPUT(busHeader, NAMED('busHeader'));                
    // OUTPUT(busSOS, NAMED('busSOS'));                
    // OUTPUT(addrRisk, NAMED('addrRisk'));                
    // OUTPUT(getBusSICNAICS, NAMED('bab_getBusSICNAICS'));                
    // OUTPUT(getBEOs, NAMED('getBEOs'));                
    // OUTPUT(associatedBusinesses, NAMED('associatedBusinesses'));               
                          
                          
    RETURN associatedBusinesses;                      
END;