IMPORT DueDiligence;

/*
  This function is to be used as an entrance to retrieve Due Diligence business
  attributes along with potential report sections (if requested)

  ASSUMPTIONS:
    **Data passed in has an unique seq identifier populated
    **Searching is done at the seleID level
    **All attributes within a module have to be requested to return supplemental/report data
  


  Inputs marked with * are required, all other input options are optional

  INPUTS:
    *inData - dataset of data to be searched on; depending on attributes requested dependencies may apply (see INPUT DEPENDENCIES)
    *attributesRequested - interface used to retrieve the desired attributes requested 
                           and only data pertaining to requested attributes will be called
    *regulatoryAccess - interface used to set regulatory/compliance access, can also be expanded for future regulatory/compliance needs
    ddOptions - used to house any additional options for this product (can also be expanded for future needs):
                          includeReportData - boolean indicating report data is being requested along with attributes
                          inputUsage - how to use the input for any attribute/report calculations
    debugMode - boolean indicating additional outputs be returned for debugging purposes  NEVER TO BE ON IN PRODUCTION


  INPUT DEPENDENCIES:
    Legal Attributes - civil legal data is searched by LexID/SeleID level
                     - other legal attributes are based on the LexID/DID of the BEO(s)
    
*/

EXPORT getBusiness(DATASET(DueDiligence.v3Layouts.DDInput.BusinessSearch) inData, 
                   DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested,
                   DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                   DueDiligence.DDInterface.iDDBusinessOptions ddOptions,
                   BOOLEAN debugMode = FALSE) := FUNCTION



    //see which grouping of attributes that have been requested (ie economic vs legal)
    requestingLegalAttributes := DueDiligence.v3Common.DDBusiness.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_LEGAL, attributesRequested);
    requestingEconomicAttributes := DueDiligence.v3Common.DDBusiness.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_ECONOMIC, attributesRequested);
    requestingOperatingAttributes := DueDiligence.v3Common.DDBusiness.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_OPERATING, attributesRequested);
    requestingNetworkAttributes := DueDiligence.v3Common.DDBusiness.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_NETWORK, attributesRequested);
      



    //convert input to an internal layout to be used to hold/share data between calls
    convertToInternal := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                                    SELF.seq := LEFT.seq;
                                                    SELF.historyDateRaw := LEFT.historyDateRaw;
                                                    SELF.historyDate := IF(LEFT.historyDateRaw = 0 OR LEFT.historyDateRaw = 999999, DueDiligence.Constants.date8Nines, LEFT.historyDateRaw);  
                                                    
                                                    SELF.inquiredBusiness.ultID := LEFT.searchBy.ultID;
                                                    SELF.inquiredBusiness.orgID := LEFT.searchBy.orgID;
                                                    SELF.inquiredBusiness.seleID := LEFT.searchBy.seleID;
                                                    
                                                    SELF.inquiredBusiness.companyName := LEFT.searchBy.companyName;
                                                    SELF.inquiredBusiness.fein := LEFT.searchBy.fein;
                                                    SELF.inquiredBusiness.phone := LEFT.searchBy.phone;
                                                    
                                                    SELF.inquiredBusiness.streetAddress1 := LEFT.searchBy.streetAddress1;
                                                    SELF.inquiredBusiness.streetAddress2 := LEFT.searchBy.streetAddress2;
                                                    SELF.inquiredBusiness.prim_range := LEFT.searchBy.prim_range;
                                                    SELF.inquiredBusiness.predir := LEFT.searchBy.predir;
                                                    SELF.inquiredBusiness.prim_name := LEFT.searchBy.prim_name;
                                                    SELF.inquiredBusiness.addr_suffix := LEFT.searchBy.addr_suffix;
                                                    SELF.inquiredBusiness.postdir := LEFT.searchBy.postdir;
                                                    SELF.inquiredBusiness.unit_desig := LEFT.searchBy.unit_desig;
                                                    SELF.inquiredBusiness.sec_range := LEFT.searchBy.sec_range;
                                                    SELF.inquiredBusiness.city := LEFT.searchBy.city;
                                                    SELF.inquiredBusiness.state := LEFT.searchBy.state;
                                                    SELF.inquiredBusiness.zip := LEFT.searchBy.zip;
                                                    SELF.inquiredBusiness.zip4 := LEFT.searchBy.zip4;
                                                    SELF.inquiredBusiness.geo_blk := LEFT.searchBy.geo_blk;
                                                    SELF.inquiredBusiness.county := LEFT.searchBy.county;
                                                    
                                                    SELF := [];));



    //////////////////////////////////
    //     Prerequisite Section
    ///////////////////////////////// 
    
    //retrieve the best data
    bestInquired := DueDiligence.v3BusinessData.getInputBestData(convertToInternal, regulatoryAccess, ddOptions);
    
    validBusiness := bestInquired(inquiredBusiness.seleID > 0);
    invalidBusiness := bestInquired(inquiredBusiness.seleID = 0);
    

    //get BEO information - information pertaining to individuals associated with the business
    beoData := DueDiligence.v3BusinessData.getExec(validBusiness, attributesRequested, regulatoryAccess, ddOptions);
    
    
    //get information from shared resources and/or additional data used in various calls
    retrieveDataDependencies := DueDiligence.v3BusinessData.getDataDependencies(beoData, regulatoryAccess);
    
    
    businessesToUse := retrieveDataDependencies;

    
    
 
   
    


    //get requested attributes and report data if requested
    noResults := DATASET([], DueDiligence.v3Layouts.InternalBusiness.BusinessResults);
    
    //for those that did not have a valid lexID return -1 for attribute and flags for those attributes requested
    noDataForAttribute := DueDiligence.v3BusinessAttributes.notFound(invalidBusiness, attributesRequested);
     
     
    //////////////////////////////////
    //          Match Level
    ///////////////////////////////// 
    matchLevelData := DueDiligence.v3BusinessAttributes.getMatchLevel(businessesToUse, inData); //always called regardless of module(s)
    
    
    //////////////////////////////////
    //      Legal Module Data
    /////////////////////////////////
    legalModuleInfo := IF(requestingLegalAttributes, 
                          DueDiligence.v3AttributeModules.getBusinessLegal(businessesToUse, attributesRequested, regulatoryAccess, ddOptions),
                          noResults);
                                
                                
    //////////////////////////////////
    //     Economic Module Data
    /////////////////////////////////
    economicModuleInfo := noResults;
    
    
    //////////////////////////////////
    //     Operating Module Data
    /////////////////////////////////
    operatingModuleInfo := IF(requestingOperatingAttributes,
                              DueDiligence.v3AttributeModules.getBusinessOperating(businessesToUse, attributesRequested, regulatoryAccess, ddOptions),
                              noResults);
                              
    
    
    //////////////////////////////////
    //      Network Module Data
    /////////////////////////////////
    networkModuleInfo := IF(requestingNetworkAttributes, 
                            DueDiligence.v3AttributeModules.getBusinessNetwork(businessesToUse, attributesRequested),
                            noResults);
                                


    //////////////////////////////////
    //  Temp to not break existing
    /////////////////////////////////
    tempMods := requestingEconomicAttributes OR
                requestingOperatingAttributes OR
                requestingNetworkAttributes;


    oldAttributesWithReport := IF(tempMods, 
                                  DueDiligence.getAllBusAttrRpt(businessesToUse + invalidBusiness, inData, attributesRequested, regulatoryAccess, ddOptions, debugMode), 
                                  noResults);
                                
    
    
    



    allAttributesAndReports := matchLevelData + legalModuleInfo + economicModuleInfo + 
                               operatingModuleInfo + networkModuleInfo + noDataForAttribute +
                               oldAttributesWithReport;
                               
    
    rollAllData := ROLLUP(SORT(allAttributesAndReports, seq, ultID, orgID, seleID),
                          LEFT.seq = RIGHT.seq AND
                          LEFT.ultID = RIGHT.ultID AND
                          LEFT.orgID = RIGHT.orgID AND
                          LEFT.seleID = RIGHT.seleID,
                          TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessResults,
                                    //attributes - legal
                                    SELF.busCivilLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(busCivilLegalEvent);
                                    SELF.busCivilLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busCivilLegalEvent_Flag);
                                    SELF.busCivilLegalEventFilingAmt := DueDiligence.v3Common.General.FirstPopulatedString(busCivilLegalEventFilingAmt);
                                    SELF.busCivilLegalEventFilingAmt_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busCivilLegalEventFilingAmt_Flag);
                                    SELF.busOffenseType := DueDiligence.v3Common.General.FirstPopulatedString(busOffenseType);
                                    SELF.busOffenseType_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busOffenseType_Flag);
                                    SELF.busStateLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(busStateLegalEvent);
                                    SELF.busStateLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busStateLegalEvent_Flag);
                                    // SELF.busFederalLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(busFederalLegalEvent);
                                    // SELF.busFederalLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busFederalLegalEvent_Flag);
                                    // SELF.busFederalLegalMatchLevel := DueDiligence.v3Common.General.FirstPopulatedString(busFederalLegalMatchLevel);
                                    // SELF.busFederalLegalMatchLevel_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busFederalLegalMatchLevel_Flag);
                                    
                                    //attributes - economic (non-modular)
                                    SELF.busAssetOwnProperty := DueDiligence.v3Common.General.FirstPopulatedString(busAssetOwnProperty);
                                    SELF.busAssetOwnProperty_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busAssetOwnProperty_Flag);
                                    SELF.busAssetOwnAircraft := DueDiligence.v3Common.General.FirstPopulatedString(busAssetOwnAircraft);
                                    SELF.busAssetOwnAircraft_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busAssetOwnAircraft_Flag);
                                    SELF.busAssetOwnWatercraft := DueDiligence.v3Common.General.FirstPopulatedString(busAssetOwnWatercraft);
                                    SELF.busAssetOwnWatercraft_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busAssetOwnWatercraft_Flag);
                                    SELF.busAssetOwnVehicle := DueDiligence.v3Common.General.FirstPopulatedString(busAssetOwnVehicle);
                                    SELF.busAssetOwnVehicle_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busAssetOwnVehicle_Flag);
                                    SELF.busAccessToFundSales := DueDiligence.v3Common.General.FirstPopulatedString(busAccessToFundSales);
                                    SELF.busAccessToFundsSales_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busAccessToFundsSales_Flag);
                                    SELF.busAccessToFundsProperty := DueDiligence.v3Common.General.FirstPopulatedString(busAccessToFundsProperty);
                                    SELF.busAccessToFundsProperty_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busAccessToFundsProperty_Flag);
                                    
                                    //attributes - operating (part-modular-ish)
                                    SELF.busGeographic := DueDiligence.v3Common.General.FirstPopulatedString(busGeographic);
                                    SELF.busGeographic_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busGeographic_Flag);
                                    SELF.busValidity := DueDiligence.v3Common.General.FirstPopulatedString(busValidity);
                                    SELF.busValidity_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busValidity_Flag);
                                    SELF.busStability := DueDiligence.v3Common.General.FirstPopulatedString(busStability);
                                    SELF.busStability_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busStability_Flag);
                                    SELF.busIndustry := DueDiligence.v3Common.General.FirstPopulatedString(busIndustry);
                                    SELF.busIndustry_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busIndustry_Flag);
                                    SELF.busStructureType := DueDiligence.v3Common.General.FirstPopulatedString(busStructureType);
                                    SELF.busStructureType_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busStructureType_Flag);
                                    SELF.busSOSAgeRange := DueDiligence.v3Common.General.FirstPopulatedString(busSOSAgeRange);
                                    SELF.busSOSAgeRange_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busSOSAgeRange_Flag);
                                    SELF.busPublicRecordAgeRange := DueDiligence.v3Common.General.FirstPopulatedString(busPublicRecordAgeRange);
                                    SELF.busPublicRecordAgeRange_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busPublicRecordAgeRange_Flag);
                                    SELF.busShellShelf := DueDiligence.v3Common.General.FirstPopulatedString(busShellShelf);
                                    SELF.busShellShelf_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busShellShelf_Flag);
                                    
                                    //attributes - network (non-modular)
                                    SELF.busBEOProfLicense := DueDiligence.v3Common.General.FirstPopulatedString(busBEOProfLicense);
                                    SELF.busBEOProfLicense_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busBEOProfLicense_Flag);
                                    SELF.busBEOUSResidency := DueDiligence.v3Common.General.FirstPopulatedString(busBEOUSResidency);
                                    SELF.busBEOUSResidency_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busBEOUSResidency_Flag);
                                    SELF.busBEOAccessToFundsProperty := DueDiligence.v3Common.General.FirstPopulatedString(busBEOAccessToFundsProperty);
                                    SELF.busBEOAccessToFundsProperty_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busBEOAccessToFundsProperty_Flag);
                                    // SELF.busLinkedBusinesses := DueDiligence.v3Common.General.FirstPopulatedString(busLinkedBusinesses);
                                    // SELF.busLinkedBusinesses_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busLinkedBusinesses_Flag);
                                    
                                    //always returned - when attributes are requested 
                                    SELF.busLexID := DueDiligence.v3Common.General.FirstPopulatedString(busLexID);
                                    SELF.busLexIDMatch := DueDiligence.v3Common.General.FirstPopulatedString(busLexIDMatch);
                                    
                                    SELF.busMatchLevel := (STRING)DueDiligence.v3Common.General.FirstPopulatedString(busMatchLevel);
                                    SELF.busMatchLevel_Flag := (STRING)DueDiligence.v3Common.General.FirstPopulatedString(busMatchLevel_Flag);


                                    //reports
                                    legalSection := IF(RIGHT.legalReportIncluded, RIGHT, LEFT);
                                    operatingSection := IF(RIGHT.operatingReportIncluded, RIGHT, LEFT);
                                    economicSection := IF(RIGHT.economicReportIncluded, RIGHT, LEFT);
                                    networkSection := IF(RIGHT.networkReportIncluded, RIGHT, LEFT);
                                    
                                    
                                    SELF.legalReportIncluded := LEFT.legalReportIncluded OR RIGHT.legalReportIncluded;
                                    SELF.operatingReportIncluded := LEFT.operatingReportIncluded OR RIGHT.operatingReportIncluded;
                                    SELF.economicReportIncluded := LEFT.economicReportIncluded OR RIGHT.economicReportIncluded;
                                    SELF.networkReportIncluded := LEFT.networkReportIncluded OR RIGHT.networkReportIncluded;
                                    
                                    //this should be temp once all operating is moved to the operating module
                                    industry := IF(RIGHT.busIndustry <> DueDiligence.Constants.EMPTY, RIGHT, LEFT);
                                    SELF.report.businessReport.businessAttributeDetails.operating.businessInformation.SICNAICs := industry.report.businessReport.businessAttributeDetails.Operating.businessInformation.SICNAICs;
                                    
                                    
                                    
                                    SELF.report.businessReport.businessInformation.NaicsCode := industry.report.businessReport.businessInformation.NaicsCode;
                                    SELF.report.businessReport.businessInformation.NaicsDescription := industry.report.businessReport.businessInformation.NaicsDescription;
                                    SELF.report.businessReport.businessInformation.SicCode := industry.report.businessReport.businessInformation.SicCode;
                                    SELF.report.businessReport.businessInformation.SicDescription := industry.report.businessReport.businessInformation.SicDescription;
                                    
                                    SELF.report.businessReport.businessAttributeDetails.Legal := legalSection.report.businessReport.businessAttributeDetails.Legal;
                                    SELF.report.businessReport.businessAttributeDetails.Economic := economicSection.report.businessReport.businessAttributeDetails.Economic;
                                    SELF.report.businessReport.businessAttributeDetails.Operating := operatingSection.report.businessReport.businessAttributeDetails.Operating;
                                    SELF.report.businessReport.businessAttributeDetails.NetworkDetails := networkSection.report.businessReport.businessAttributeDetails.NetworkDetails;                                                       
                                                                        
                                    SELF := LEFT;));
                                  
                                  
    //add input/best to report if it was requested
    addInputBest := IF(ddOptions.includeReportData,
                        DueDiligence.v3BusinessReport.getInputBest(inData, validBusiness, rollAllData),
                        rollAllData);
                                    
                                    
    
    
    //convert data back to simple response - drop all unnecessary data for caller
    final := JOIN(convertToInternal, addInputBest,
                  LEFT.seq = RIGHT.seq,
                  TRANSFORM(DueDiligence.v3Layouts.DDOutput.BusinessResults,
                            SELF.seq := LEFT.seq;
                            SELF := RIGHT;
                            SELF := [];),
                  LEFT OUTER,
                  ATMOST(1));

    
                             
                                






    //DEBUGGING
    IF(debugMode, OUTPUT(inData, NAMED('v3BusInData')));
    IF(debugMode, OUTPUT(convertToInternal, NAMED('convertToInternalBus')));
    
    IF(debugMode, OUTPUT(bestInquired, NAMED('bestInquired')));
    IF(debugMode, OUTPUT(validBusiness, NAMED('validBusiness')));
    IF(debugMode, OUTPUT(invalidBusiness, NAMED('invalidBusiness')));
    IF(debugMode, OUTPUT(beoData, NAMED('beoData')));
    IF(debugMode, OUTPUT(retrieveDataDependencies, NAMED('retrieveDataDependencies')));
    
    IF(debugMode, OUTPUT(matchLevelData, NAMED('matchLevelDataBus')));
    IF(debugMode, OUTPUT(legalModuleInfo, NAMED('legalModuleInfoBus')));
    IF(debugMode, OUTPUT(economicModuleInfo, NAMED('economicModuleInfo')));
    IF(debugMode, OUTPUT(operatingModuleInfo, NAMED('operatingModuleInfo')));
    IF(debugMode, OUTPUT(networkModuleInfo, NAMED('networkModuleInfo')));
    
    IF(debugMode, OUTPUT(tempMods, NAMED('tempMods')));
    IF(debugMode, OUTPUT(oldAttributesWithReport, NAMED('oldAttributesWithReportBus')));
    
    IF(debugMode, OUTPUT(allAttributesAndReports, NAMED('allAttributesAndReportsBus')));
    IF(debugMode, OUTPUT(rollAllData, NAMED('rollAllDataBus')));
    IF(debugMode, OUTPUT(addInputBest, NAMED('addInputBestBus')));
    IF(debugMode, OUTPUT(noDataForAttribute, NAMED('noDataForAttributeBus')));
    IF(debugMode, OUTPUT(final, NAMED('finalBus')));

    
    RETURN SORT(final, seq);
END;