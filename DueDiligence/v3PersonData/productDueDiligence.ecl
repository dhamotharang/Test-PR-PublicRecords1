IMPORT DueDiligence, Header, Risk_Indicators, STD;


EXPORT productDueDiligence(DATASET(DueDiligence.v3Layouts.DDInput.PersonSearch) inData,
                            DATASET(Risk_Indicators.Layout_Boca_Shell) bs,
                            DATASET(DueDiligence.Citizenship.Layouts.IndicatorLayout) riskIndicators,
                            DueDiligence.DDInterface.iDDv3PersonAttributes attributesRequested,
                            DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                            DueDiligence.DDInterface.iDDPersonOptions ddOptions,
                            BOOLEAN debugMode = FALSE) := FUNCTION



    requestingLegalAttributes := DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_LEGAL, attributesRequested);
    requestingEconomicAttributes := DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_ECONOMIC, attributesRequested);
    requestingGeographicAttributes := DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_GEOGRAPHIC, attributesRequested);
    requestingIdentityAttributes := DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_IDENTITY, attributesRequested);
    requestingNetworkAttributes := DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_NETWORK, attributesRequested);
 




    //convert input to an internal layout to be used to hold/share data between calls
    convertToInternal := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.Internal.PersonTemp,
                                                    SELF.seq := LEFT.seq;
                                                    SELF.historyDateRaw := LEFT.historyDateRaw;
                                                    SELF.historyDate := IF(LEFT.historyDateRaw = 0 OR LEFT.historyDateRaw = 999999, DueDiligence.Constants.date8Nines, LEFT.historyDateRaw); 
                                                    SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL;
                                                    
                                                    SELF.inquired.lexID := LEFT.searchBy.lexID;
                                                    SELF.inquired.fullName := LEFT.searchBy.fullName;
                                                    SELF.inquired.firstName := LEFT.searchBy.firstName;
                                                    SELF.inquired.middleName := LEFT.searchBy.middleName;
                                                    SELF.inquired.lastName := LEFT.searchBy.lastName;
                                                    SELF.inquired.suffix := LEFT.searchBy.suffix;
                                                    
                                                    SELF.inquired.streetAddress1 := LEFT.searchBy.streetAddress1;
                                                    SELF.inquired.streetAddress2 := LEFT.searchBy.streetAddress2;
                                                    SELF.inquired.prim_range := LEFT.searchBy.prim_range;
                                                    SELF.inquired.predir := LEFT.searchBy.predir;
                                                    SELF.inquired.prim_name := LEFT.searchBy.prim_name;
                                                    SELF.inquired.addr_suffix := LEFT.searchBy.addr_suffix;
                                                    SELF.inquired.postdir := LEFT.searchBy.postdir;
                                                    SELF.inquired.unit_desig := LEFT.searchBy.unit_desig;
                                                    SELF.inquired.sec_range := LEFT.searchBy.sec_range;
                                                    SELF.inquired.city := LEFT.searchBy.city;
                                                    SELF.inquired.state := LEFT.searchBy.state;
                                                    SELF.inquired.zip := LEFT.searchBy.zip;
                                                    SELF.inquired.zip4 := LEFT.searchBy.zip4;
                                                    SELF.inquired.geo_blk := LEFT.searchBy.geo_blk;
                                                    SELF.inquired.county := LEFT.searchBy.county;
                                                    
                                                    SELF.inquired.dob := LEFT.searchBy.dob;
                                                    SELF.inquired.phone := LEFT.searchBy.phone;
                                                    SELF.inquired.ssn := LEFT.searchBy.ssn;
                                                    SELF.inquired.relationship := Header.relative_titles.num_Subject;
                                                    
                                                    SELF := [];));
    

    //get information from shared resources and/or additional data used in various calls: header, relatives
    retrievePrereqs := DueDiligence.v3PersonData.getDataDependencies(convertToInternal, attributesRequested, regulatoryAccess, ddOptions);
    
    //only need to pass those with valid LexIDs on for processing
    validInquiredData := retrievePrereqs(inquiredDID > 0);
    noInquiredData := retrievePrereqs(inquiredDID = 0);
    
                                                     
    
  

    
    
    
    //get requested attributes and report data if requested
    noResults := DATASET([], DueDiligence.v3Layouts.InternalPerson.PersonResults);
    
    matchLevelAttributeData := DueDiligence.v3PersonAttributes.getMatchLevel(validInquiredData); //always called regardless of module(s)
    
    legalAttributeData := IF(requestingLegalAttributes, 
                                DueDiligence.v3AttributeModules.getPersonLegal(validInquiredData, attributesRequested, regulatoryAccess, ddOptions),
                                noResults);
      
      
      
      
     //TEMP CODE      
     tempMods := requestingEconomicAttributes OR requestingGeographicAttributes OR requestingIdentityAttributes OR requestingNetworkAttributes;
     
     oldAttributes := IF(tempMods, 
                        DueDiligence.getAllIndAttrRpt(retrievePrereqs, inData, bs, riskIndicators, attributesRequested, regulatoryAccess, ddOptions, debugMode), 
                        noResults);
       
       
       
       
    //for those that did not have a valid lexID return -1 for attribute and flags for those attributes requested
    noDataForAttributes := DueDiligence.v3PersonAttributes.notFound(noInquiredData, attributesRequested);
    
    
    
    
    //populate input/best sections of the report - not necessarily tied to an attribute
    // getInputBestReportSections := DueDiligence.v3PersonReport.getInputBest(inData, ssnMask);
    
    allAttributesAndReports := matchLevelAttributeData + legalAttributeData + oldAttributes + noDataForAttributes; // + getInputBestReportSections;
    
    rollAllData := ROLLUP(SORT(allAttributesAndReports, seq, lexID),
                          LEFT.seq = RIGHT.seq AND
                          LEFT.lexID = RIGHT.lexID,
                          TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonResults,
                                    //attributes - legal
                                    SELF.perCivilLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(perCivilLegalEvent);
                                    SELF.perCivilLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perCivilLegalEvent_Flag); 
                                    SELF.perCivilLegalEventFilingAmt := DueDiligence.v3Common.General.FirstPopulatedString(perCivilLegalEventFilingAmt);
                                    SELF.perCivilLegalEventFilingAmt_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perCivilLegalEventFilingAmt_Flag);                                    
                                    SELF.perOffenseType := DueDiligence.v3Common.General.FirstPopulatedString(perOffenseType);
                                    SELF.perOffenseType_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perOffenseType_Flag);                                    
                                    SELF.perStateLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(perStateLegalEvent);
                                    SELF.perStateLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perStateLegalEvent_Flag);
                                    // SELF.perFederalLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(perFederalLegalEvent);
                                    // SELF.perFederalLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perFederalLegalEvent_Flag);
                                    // SELF.perFederalLegalMatchLevel := DueDiligence.v3Common.General.FirstPopulatedString(perFederalLegalMatchLevel);
                                    // SELF.perFederalLegalMatchLevel_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perFederalLegalMatchLevel_Flag);
                                    
                                    
                                    //attributes - economic (non-modular)
                                    SELF.perAssetOwnProperty := DueDiligence.v3Common.General.FirstPopulatedString(perAssetOwnProperty);
                                    SELF.perAssetOwnProperty_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perAssetOwnProperty_Flag);
                                    SELF.perAssetOwnAircraft := DueDiligence.v3Common.General.FirstPopulatedString(perAssetOwnAircraft);
                                    SELF.perAssetOwnAircraft_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perAssetOwnAircraft_Flag);
                                    SELF.perAssetOwnWatercraft := DueDiligence.v3Common.General.FirstPopulatedString(perAssetOwnWatercraft);
                                    SELF.perAssetOwnWatercraft_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perAssetOwnWatercraft_Flag);
                                    SELF.perAssetOwnVehicle := DueDiligence.v3Common.General.FirstPopulatedString(perAssetOwnVehicle);
                                    SELF.perAssetOwnVehicle_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perAssetOwnVehicle_Flag);
                                    SELF.perAccessToFundsIncome := DueDiligence.v3Common.General.FirstPopulatedString(perAccessToFundsIncome);
                                    SELF.perAccessToFundsIncome_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perAccessToFundsIncome_Flag);
                                    SELF.perAccessToFundsProperty := DueDiligence.v3Common.General.FirstPopulatedString(perAccessToFundsProperty);
                                    SELF.perAccessToFundsProperty_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perAccessToFundsProperty_Flag);
                                    
                                    
                                    //attributes - geographic (non-modular)
                                    SELF.perGeographic := DueDiligence.v3Common.General.FirstPopulatedString(perGeographic);
                                    SELF.perGeographic_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perGeographic_Flag);
                                    SELF.perMobility := DueDiligence.v3Common.General.FirstPopulatedString(perMobility);
                                    SELF.perMobility_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perMobility_Flag);
                                    
                                    
                                    //attributes - identity (non-modular)
                                    SELF.perAgeRange := DueDiligence.v3Common.General.FirstPopulatedString(perAgeRange);
                                    SELF.perAgeRange_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perAgeRange_Flag);
                                    SELF.perIdentityRisk := DueDiligence.v3Common.General.FirstPopulatedString(perIdentityRisk);
                                    SELF.perIdentityRisk_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perIdentityRisk_Flag);
                                    SELF.perUSResidency := DueDiligence.v3Common.General.FirstPopulatedString(perUSResidency);
                                    SELF.perUSResidency_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perUSResidency_Flag);
                                    
                                    
                                    //attributes - network (non-modular)
                                    SELF.perAssociates := DueDiligence.v3Common.General.FirstPopulatedString(perAssociates);
                                    SELF.perAssociates_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perAssociates_Flag);
                                    // SELF.perEmploymentIndustry := DueDiligence.v3Common.General.FirstPopulatedString(perEmploymentIndustry);
                                    // SELF.perEmploymentIndustry_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perEmploymentIndustry_Flag);
                                    SELF.perProfLicense := DueDiligence.v3Common.General.FirstPopulatedString(perProfLicense);
                                    SELF.perProfLicense_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perProfLicense_Flag);
                                    SELF.perBusAssociations := DueDiligence.v3Common.General.FirstPopulatedString(perBusAssociations);
                                    SELF.perBusAssociations_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perBusAssociations_Flag);
                                    
                                    //always returned - when attributes are requested
                                    SELF.perMatchLevel := DueDiligence.v3Common.General.FirstPopulatedString(perMatchLevel);
                                    SELF.perMatchLevel_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perMatchLevel_Flag);
                                    
                                    SELF.perLexID := (STRING)DueDiligence.v3Common.General.FirstPopulatedString(perLexID);
                                    SELF.perLexIDMatch := (STRING)DueDiligence.v3Common.General.FirstPopulatedString(perLexIDMatch);
      		
 
                                    //reports
                                    legalSection := IF(RIGHT.legalReportIncluded, RIGHT, LEFT);
                                    economicSection := IF(RIGHT.economicReportIncluded, RIGHT, LEFT);
                                    geoSection := IF(RIGHT.geographicReportIncluded, RIGHT, LEFT);
                                    identitySection := IF(RIGHT.identityReportIncluded, RIGHT, LEFT);
                                    networkSection := IF(RIGHT.networkReportIncluded, RIGHT, LEFT);
                                    
                                    SELF.legalReportIncluded := RIGHT.legalReportIncluded OR LEFT.legalReportIncluded;
                                    SELF.economicReportIncluded := RIGHT.economicReportIncluded OR LEFT.economicReportIncluded;
                                    SELF.geographicReportIncluded := RIGHT.geographicReportIncluded OR LEFT.geographicReportIncluded;
                                    SELF.identityReportIncluded := RIGHT.identityReportIncluded OR LEFT.identityReportIncluded;
                                    SELF.networkReportIncluded := RIGHT.networkReportIncluded OR LEFT.networkReportIncluded;
                                    
                                    SELF.personReport.personAttributeDetails.Legal := legalSection.personReport.personAttributeDetails.legal;
                                    SELF.personReport.personAttributeDetails.Economic := economicSection.personReport.personAttributeDetails.economic;
                                    SELF.personReport.personAttributeDetails.Geographic := geoSection.personReport.personAttributeDetails.geographic;
                                    SELF.personReport.personAttributeDetails.Identitiy := identitySection.personReport.personAttributeDetails.identitiy;
                                    SELF.personReport.personAttributeDetails.ProfessionalNetwork := networkSection.personReport.personAttributeDetails.professionalNetwork;
                                    SELF.personReport.personAttributeDetails.PersonAssociation := networkSection.personReport.personAttributeDetails.personAssociation;
                                    SELF.personReport.personAttributeDetails.BusinessAssocation := networkSection.personReport.personAttributeDetails.businessAssocation;
                                                        
                                    SELF.personReport.PersonInformation := IF(LEFT.personReport.personInformation.lexID <> DueDiligence.Constants.EMPTY, LEFT.personReport.personInformation, RIGHT.personReport.personInformation);
                                    
                                    SELF := LEFT;));
    
 
    
    //convert data back to simple response - drop all unnecessary data for caller
    final := JOIN(convertToInternal, rollAllData,
                  LEFT.seq = RIGHT.seq,
                  TRANSFORM(DueDiligence.v3Layouts.DDOutput.PersonResults,
                            SELF.seq := LEFT.seq;
                            SELF := RIGHT;
                            SELF := [];),
                  LEFT OUTER,
                  ATMOST(1));
    
  
  
  
  
  
  
  
  
  
    IF(debugMode, OUTPUT(convertToInternal, NAMED('convertToInternal')));
    IF(debugMode, OUTPUT(retrievePrereqs, NAMED('retrievePrereqs')));
    IF(debugMode, OUTPUT(validInquiredData, NAMED('validInquiredData')));
    IF(debugMode, OUTPUT(noInquiredData, NAMED('noInquiredData')));
    
    IF(debugMode, OUTPUT(matchLevelAttributeData, NAMED('matchLevelAttributeData')));
    IF(debugMode, OUTPUT(legalAttributeData, NAMED('legalAttributeData')));
    IF(debugMode, OUTPUT(oldAttributes, NAMED('oldAttributes')));
    
    IF(debugMode, OUTPUT(allAttributesAndReports, NAMED('allAttributesAndReports')));
    IF(debugMode, OUTPUT(rollAllData, NAMED('rollAllData')));
    IF(debugMode, OUTPUT(noDataForAttributes, NAMED('noDataForAttributes')));
    IF(debugMode, OUTPUT(final, NAMED('final')));


    RETURN final;
END;