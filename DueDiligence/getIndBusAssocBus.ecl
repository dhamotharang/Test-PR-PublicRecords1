IMPORT BIPV2, Business_Risk_BIP, DueDiligence, Doxie;

EXPORT getIndBusAssocBus(DATASET(DueDiligence.Layouts.Busn_Internal) businesses,
                          Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                          BIPV2.mod_sources.iParams linkingOptions,
                          doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
     
     
    BOOLEAN includeAllBusinessData := FALSE;
    BOOLEAN includeReportData := FALSE;
                          
    //get information to retrieve SIC/NAICS info
    linkedBus := DueDiligence.getBusLinkedBus(businesses, options, linkingOptions);
  
    busReg := DueDiligence.getBusRegistration(linkedBus, options, includeAllBusinessData);
    
    busHeader := DueDiligence.getBusHeader(busReg, options, linkingOptions, includeAllBusinessData, includeReportData, mod_access);
    
    busSOS := DueDiligence.getBusSOSDetail(busHeader, options, includeAllBusinessData, includeReportData);
    
    addrRisk := DueDiligence.getBusAddrData(busSOS, options, includeReportData);  //must be called after getBusSOSDetail & getBusRegistration
    
    
        
    
   
   regulatoryAccess := MODULE(DueDiligence.DDInterface.iDDRegulatoryCompliance)
                            EXPORT UNSIGNED3 glba := mod_access.glb;
                            EXPORT UNSIGNED3 dppa := mod_access.dppa;
                            EXPORT STRING drm := mod_access.DataRestrictionMask;
                            EXPORT STRING dpm := mod_access.DataPermissionMask;
                            
                            //CCPA Regulatory fields
                            EXPORT UNSIGNED1 lexIDSourceOptOut := mod_access.lexid_source_optout;
                            EXPORT STRING transactionID := mod_access.transaction_id;
                            EXPORT UNSIGNED6 globalCompanyID := mod_access.global_company_id;
                        END;
    
    
    
    transDataForV3 := PROJECT(businesses, TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                                    SELF.seq := LEFT.seq;
                                                    SELF.historyDate := LEFT.historydate;
                                                    SELF.inquiredBusiness.ultID := LEFT.busn_info.BIP_IDs.UltID.LinkID;
                                                    SELF.inquiredBusiness.orgID := LEFT.busn_info.BIP_IDs.OrgID.LinkID;
                                                    SELF.inquiredBusiness.seleID := LEFT.busn_info.BIP_IDs.SeleID.LinkID;
                                                    SELF := [];));
    
    
    bestIndustryResults := DueDiligence.v3BusinessData.getIndustryBest(transDataForV3, regulatoryAccess);
    rawIndustryResults := DueDiligence.v3BusinessData.getIndustry(bestIndustryResults, regulatoryAccess);
    
    newIndustryResults := PROJECT(addrRisk, TRANSFORM(DueDiligence.layouts.Busn_Internal,
                                                      
                                                      industryForBus := rawIndustryResults(seq = LEFT.seq AND ultID = LEFT.busn_info.BIP_IDs.UltID.LinkID AND
                                                                                           orgID = LEFT.busn_info.BIP_IDs.OrgID.LinkID AND seleID = LEFT.busn_info.BIP_IDs.UltID.LinkID);
                                                      
                                                      limitedIndustry := CHOOSEN(industryForBus, DueDiligence.Constants.MAX_SIC_NAIC);
                                                      
                                                      SELF.numOfSicNaic := COUNT(limitedIndustry);
                                                      SELF.sicNaicSources := PROJECT(limitedIndustry, TRANSFORM(DueDiligence.Layouts.LayoutSICNAIC,
                                                                                                                SELF.DateFirstSeen := LEFT.dateFirstSeen;
                                                                                                                SELF.DateLastSeen := LEFT.dateLastSeen;
                                                                                                                SELF.SICCode := LEFT.sicCode;
                                                                                                                SELF.sicDesc := LEFT.sicDesc;
                                                                                                                SELF.SICIndustry := LEFT.sicIndustry;
                                                                                                                SELF.SICRiskLevel := LEFT.sicRiskLevel;
                                                                                                                SELF.NAICCode := LEFT.naicsCode;
                                                                                                                SELF.naicsDesc := LEFT.naicsDesc;
                                                                                                                SELF.NAICIndustry := LEFT.naicsIndustry;
                                                                                                                SELF.NAICRiskLevel := LEFT.naicsRiskLevel;
                                                                                                                SELF.IsPrimary := LEFT.isBest;
                                                                                                                SELF.riskiestLevel := LEFT.riskiestOverallLevel;
                                                                                                                SELF := [];));
                                                      
                                                       
                                                      SELF := LEFT;));
    
    getBEOs := DueDiligence.getSharedBEOs(newIndustryResults, options, linkingOptions, mod_access); 
    
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
                                                        SELF.busAssociation.sicNaicSources := LEFT.sicNaicSources;
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
    
    // OUTPUT(transDataForV3, NAMED('transDataForV3'));         
    // OUTPUT(bestIndustryResults, NAMED('bestIndustryResults'));         
    // OUTPUT(rawIndustryResults, NAMED('rawIndustryResults'));         
    // OUTPUT(newIndustryResults, NAMED('newIndustryResults'));         
    
    // OUTPUT(getBEOs, NAMED('getBEOs'));                
    // OUTPUT(associatedBusinesses, NAMED('associatedBusinesses'));               
                          
                          
    RETURN associatedBusinesses;                      
END;