IMPORT DueDiligence, iesp;


EXPORT getAllBusAttrRpt(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) v3Input,
                        DATASET(DueDiligence.v3Layouts.DDInput.BusinessSearch) rawInput,
                        DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested,
                        DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                        DueDiligence.DDInterface.iDDBusinessOptions ddOptions,
                        BOOLEAN debugMode) := FUNCTION

    
    inquiredBus := PROJECT(v3Input, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                              SELF.seq := LEFT.seq;

                                              SELF.busn_info.BIP_IDs.UltID.LinkID := LEFT.inquiredBusiness.UltID;
                                              SELF.busn_info.BIP_IDs.OrgID.LinkID := LEFT.inquiredBusiness.OrgID;
                                              SELF.busn_info.BIP_IDs.SeleID.LinkID := LEFT.inquiredBusiness.SeleID;
                                              SELF.busn_info.BIP_IDs.ProxID.LinkID := LEFT.inquiredBusiness.ProxID;
                                              SELF.busn_info.BIP_IDs.PowID.LinkID := LEFT.inquiredBusiness.PowID;

                                              SELF.busn_info.lexID := (STRING)LEFT.inquiredBusiness.SeleID;
                                              SELF.busn_info.companyName := LEFT.inquiredBusiness.companyName; 
                                              SELF.busn_info.fein := LEFT.inquiredBusiness.fein;
                                              SELF.busn_info.phone := LEFT.inquiredBusiness.phone;
                                              SELF.busn_info.address.zip5 := LEFT.inquiredBusiness.zip;
                                              SELF.busn_info.address := LEFT.inquiredBusiness;
                                              
                                              SELF.score := LEFT.lexIDScore;

                                              SELF.historyDate := LEFT.historyDate;
                                              SELF.relatedDegree := DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE;                                           

                                              SELF.bestBusInfo.companyName := LEFT.bestData.companyName;
                                              SELF.bestBusInfo.address.zip5 := LEFT.bestData.zip;
                                              SELF.bestBusInfo.address := LEFT.bestData;
                                              SELF.bestBusInfo.phone := LEFT.bestData.phone;
                                              SELF.bestBusInfo.fein := LEFT.bestData.fein;
                                              
                                              allExecs := PROJECT(LEFT.beos, TRANSFORM(DueDiligence.Layouts.RelatedParty,
                                                                                        SELF.did := LEFT.lexID;
                                                                                        SELF.firstName := LEFT.firstName;
                                                                                        SELF.middleName := LEFT.middleName;
                                                                                        SELF.lastName := LEFT.lastName;
                                                                                        SELF.suffix := LEFT.suffix;
                                                                                        SELF.ssn := LEFT.ssn;
                                                                                        SELF.dob := LEFT.dob;
                                                                                        SELF.phone := LEFT.phone;
                                                                                        SELF.relationship := LEFT.relationship;
                                                                                        SELF.zip5 := LEFT.zip;
                                                                                        SELF.numofpositions := COUNT(LEFT.titles);
                                                                                        SELF.legalEventTypeScore := LEFT.offenseType;
                                                                                        SELF.legalEventTypeFlags := LEFT.offenseTypeFlag;
                                                                                        SELF.stateCriminalLegalEventsScore := LEFT.stateLegalEvents;
                                                                                        SELF.stateCriminalLegalEventsFlags := LEFT.stateLegalEventsFlag;
                                                                                        SELF.positions := PROJECT(LEFT.titles, TRANSFORM(DueDiligence.Layouts.Positions,
                                                                                                                                          SELF.title := LEFT.title;
                                                                                                                                          SELF.firstSeen := LEFT.firstSeen;
                                                                                                                                          SELF.lastSeen := LEFT.lastSeen;
                                                                                                                                          SELF := [];));;
                                                                                        SELF := LEFT;
                                                                                        SELF := [];));
                                                                                    
          
          
                                              SELF.DIDlessBEOCount := COUNT(allExecs(did = 0));
                                              SELF.DIDlessExecs := allExecs(did = 0);
                                              
                                              SELF.execCount := COUNT(allExecs(did > 0));
                                              SELF.execs := allExecs(did > 0);
          
                                              SELF := [];));
                                              
    addRaw := JOIN(rawInput, inquiredBus,
                   LEFT.seq = RIGHT.seq,
                   TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                             SELF.busn_info.accountNumber := LEFT.accountNumber;
                             
                             SELF.busn_input.lexID := (STRING)LEFT.rawData.seleID;
                             SELF.busn_input.companyName := LEFT.rawData.companyName;
                             SELF.busn_input.fein := LEFT.rawData.fein;
                             SELF.busn_input.phone := LEFT.rawData.phone;
                             SELF.busn_input.address.zip5 := LEFT.rawData.zip;
                             SELF.busn_input.address := LEFT.rawData;
                             
                             SELF.inputaddressprovided := LEFT.rawData.streetAddress1 <> DueDiligence.Constants.EMPTY OR LEFT.rawData.streetAddress2 <> DueDiligence.Constants.EMPTY OR LEFT.rawData.prim_range <> DueDiligence.Constants.EMPTY OR LEFT.rawData.predir <> DueDiligence.Constants.EMPTY OR 
                                                                LEFT.rawData.prim_name <> DueDiligence.Constants.EMPTY OR LEFT.rawData.addr_suffix <> DueDiligence.Constants.EMPTY OR LEFT.rawData.postdir <> DueDiligence.Constants.EMPTY OR LEFT.rawData.unit_desig <> DueDiligence.Constants.EMPTY OR 
                                                                LEFT.rawData.sec_range <> DueDiligence.Constants.EMPTY OR LEFT.rawData.city <> DueDiligence.Constants.EMPTY OR LEFT.rawData.state <> DueDiligence.Constants.EMPTY OR LEFT.rawData.zip <> DueDiligence.Constants.EMPTY;	
                                                                        
                                                          
                             SELF.fullinputaddressprovided := (LEFT.searchBy.streetAddress1 <> DueDiligence.Constants.EMPTY OR LEFT.searchBy.prim_name <> DueDiligence.Constants.EMPTY) AND LEFT.searchBy.city <> DueDiligence.Constants.EMPTY AND LEFT.searchBy.state <> DueDiligence.Constants.EMPTY AND LEFT.searchBy.zip <> DueDiligence.Constants.EMPTY;
                             
                             SELF := RIGHT;),
                   // LEFT OUTER,
                   RIGHT OUTER);
                   // ATMOST(1));

    
    options := DueDiligence.v3Common.DDBusiness.GetBusinessShellOptions(regulatoryAccess);
    linkingOpts := DueDiligence.v3Common.DDBusiness.GetLinkingOptions(regulatoryAccess);


    prevBusAttrs := DueDiligence.getBusAttributes(addRaw, ddOptions.ssnMask,
                                                  ddOptions.includeReportData, options,
                                                  linkingOpts, debugMode,
                                                  regulatoryAccess.lexIDSourceOptOut, regulatoryAccess.transactionID, 
                                                  regulatoryAccess.batchUID, regulatoryAccess.globalCompanyID);
    

    convertOld2New := PROJECT(prevBusAttrs, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessResults,
                                                      SELF.seq := LEFT.seq;
                                                      SELF.ultID := LEFT.Busn_info.BIP_IDs.UltID.LinkID;
                                                      SELF.orgID := LEFT.Busn_info.BIP_IDs.OrgID.LinkID;
                                                      SELF.seleID := LEFT.Busn_info.BIP_IDs.SeleID.LinkID;
                                                      
                                                      SELF.economicReportIncluded := ddOptions.includeReportData AND DueDiligence.v3Common.DDBusiness.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_ECONOMIC, attributesRequested);
                                                      SELF.operatingReportIncluded := ddOptions.includeReportData AND DueDiligence.v3Common.DDBusiness.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_OPERATING, attributesRequested);
                                                      SELF.networkReportIncluded := ddOptions.includeReportData AND DueDiligence.v3Common.DDBusiness.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_NETWORK, attributesRequested);
                                                      
                                                      
                                                      
                                                      //attributes/reports are converted in new modularity logic
                                                      SELF.busIndustry := '';
                                                      SELF.busIndustry_Flag := '';
                                                      SELF.report.businessReport.businessAttributeDetails.operating.businessInformation.SICNAICs := DATASET([], iesp.duediligencebusinessreport.t_DDRSICNAIC);
                                                      
                                                      
                                                      SELF.report.BusinessReport := LEFT.BusinessReport;
                                                      
                                                      SELF := LEFT;
                                                      SELF := [];));



 
    
    // OUTPUT(inquiredBus, NAMED('inquiredBus_allAttr'));
    // OUTPUT(addRaw, NAMED('addRaw_allAttr'));
    // OUTPUT(prevBusAttrs, NAMED('prevBusAttrs'));
    // OUTPUT(convertOld2New, NAMED('convertOld2New'));

    RETURN convertOld2New;
END;