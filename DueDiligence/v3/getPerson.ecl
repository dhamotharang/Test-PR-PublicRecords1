IMPORT DueDiligence, Risk_Indicators;

/*
  This function is to be used as an entrance to retrieve Due Diligence person 
  attributes along with potential report sections (if requested)
  and/or Citizenship scores and indicators.

  ASSUMPTIONS:
    **Data passed in has an unique seq identifier populated
  


  Inputs marked with * are required, all other input options are optional

  INPUTS:
    *inData - dataset of data to be searched on; depending on attributes requested dependencies may apply (see INPUT DEPENDENCIES)
    *attributesRequested - interface used to retrieve the desired attributes requested 
                           and only data pertaining to requested attributes will be called
    *regulatoryAccess - interface used to set regulatory/compliance access, can also be expanded for future regulatory/compliance needs
    ddOptions - used to house any additional options for this product (can also be expanded for future needs):
                          includeCitizenship - boolean indicating whether to run citizenship product or not
                          includeReportData - boolean indicating report data is being requested along with attribute(s)
                          inputUsage - how to use the input for any attribute/report calculations
                          bs - boca shell to use if including as to not retrieve another if calling system has already retrieved
    debugMode - boolean indicating additional outputs be returned for debugging purposes  NEVER TO BE ON IN PRODUCTION
    modelValidation - boolean indicating additional outputs be returned for model validation purposes  NEVER TO BE ON IN PRODUCTION


  INPUT DEPENDENCIES:
    Legal Attributes are searched by lexID only
    
*/


EXPORT getPerson(DATASET(DueDiligence.v3Layouts.DDInput.PersonSearch) inData, 
                 DueDiligence.DDInterface.iDDv3PersonAttributes attributesRequested,
                 DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                 DueDiligence.DDInterface.iDDPersonOptions ddOptions,
                 BOOLEAN debugMode = FALSE,
                 BOOLEAN modelValidation = FALSE) := FUNCTION

    
    
    allIdentityCit := attributesRequested.includeAll OR attributesRequested.includeIdentityRisk OR ddOptions.includeCitizenship;
    
    
    //see which grouping of attributes that have been requested (ie assets vs legal)
    requestingLegalAttributes := DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_LEGAL, attributesRequested);
    requestinEconomicAttributes := DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_ECONOMIC, attributesRequested);
    requestinGeographicAttributes := DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_GEOGRAPHIC, attributesRequested);
    requestinIdentityAttributes := DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_IDENTITY, attributesRequested);
    requestinNetworkAttributes := DueDiligence.v3Common.DDPerson.IsRequestedModuleBeingRequested(DueDiligence.ConstantsQuery.MODULE_NETWORK, attributesRequested);
 
    ddRequested := requestingLegalAttributes OR requestinEconomicAttributes OR 
                    requestinGeographicAttributes OR requestinIdentityAttributes OR requestinNetworkAttributes;



    ////////////////////////////////////////////////////////////////////////
    //
    // Shared logic between products
    //
    ////////////////////////////////////////////////////////////////////////

    //get the boca shell if we do not have it and are requesting all attributes, identity, or citizenship
    bsToUse := IF(allIdentityCit,
                  IF(EXISTS(ddOptions.bs), ddOptions.bs, DueDiligence.v3PersonData.getBocaShell(inData, regulatoryAccess)),
                  DATASET([], Risk_Indicators.Layout_Boca_Shell));


    //get risk indicators if all attributes, identity or citizenship are requested
    riskIndicators := IF(allIdentityCit, DueDiligence.Citizenship.getRiskIndicators(inData, bsToUse), DATASET([], DueDiligence.Citizenship.Layouts.IndicatorLayout));




    ////////////////////////////////////////////////////////////////////////
    //
    // Call the product(s) being requested: Citizenship and/or DueDiligence
    //
    ////////////////////////////////////////////////////////////////////////

    noProductResults := DATASET([], DueDiligence.v3Layouts.DDOutput.PersonResults);

    //call citizenship if requested
    citResults := IF(ddOptions.includeCitizenship, DueDiligence.v3PersonData.productCitizenship(bsToUse, riskIndicators, modelValidation), noProductResults);
       
    //call due diligence if requested
    ddResults := IF(ddRequested, DueDiligence.v3PersonData.productDueDiligence(inData, bsToUse, riskIndicators, attributesRequested, regulatoryAccess, ddOptions, debugMode), noProductResults);

    
    
    ////////////////////////////////////////////////////////////////////////
    //
    // Roll data between product(s) so only 1 row per seq is returned
    //
    ////////////////////////////////////////////////////////////////////////    
    
    sortResults := SORT(citResults + ddResults, seq);
    
    rollProducts := ROLLUP(sortResults,
                          LEFT.seq = RIGHT.seq,
                          TRANSFORM(DueDiligence.v3Layouts.DDOutput.PersonResults,
                                    SELF.perLexID := DueDiligence.v3Common.General.FirstPopulatedString(perLexID);
                                    SELF.perLexIDMatch := DueDiligence.v3Common.General.FirstPopulatedString(perLexIDMatch);
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
                                    SELF.perGeographic := DueDiligence.v3Common.General.FirstPopulatedString(perGeographic);
                                    SELF.perGeographic_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perGeographic_Flag);
                                    SELF.perMobility := DueDiligence.v3Common.General.FirstPopulatedString(perMobility);
                                    SELF.perMobility_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perMobility_Flag);
                                    SELF.perStateLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(perStateLegalEvent);
                                    SELF.perStateLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perStateLegalEvent_Flag);
                                    SELF.perFederalLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(perFederalLegalEvent);
                                    SELF.perFederalLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perFederalLegalEvent_Flag);
                                    SELF.perFederalLegalMatchLevel := DueDiligence.v3Common.General.FirstPopulatedString(perFederalLegalMatchLevel);
                                    SELF.perFederalLegalMatchLevel_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perFederalLegalMatchLevel_Flag);
                                    SELF.perCivilLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(perCivilLegalEvent);
                                    SELF.perCivilLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perCivilLegalEvent_Flag);
                                    SELF.perOffenseType := DueDiligence.v3Common.General.FirstPopulatedString(perOffenseType);
                                    SELF.perOffenseType_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perOffenseType_Flag);
                                    SELF.perAgeRange := DueDiligence.v3Common.General.FirstPopulatedString(perAgeRange);
                                    SELF.perAgeRange_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perAgeRange_Flag);
                                    SELF.perIdentityRisk := DueDiligence.v3Common.General.FirstPopulatedString(perIdentityRisk);
                                    SELF.perIdentityRisk_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perIdentityRisk_Flag);
                                    SELF.perUSResidency := DueDiligence.v3Common.General.FirstPopulatedString(perUSResidency);
                                    SELF.perUSResidency_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perUSResidency_Flag);
                                    SELF.perMatchLevel := DueDiligence.v3Common.General.FirstPopulatedString(perMatchLevel);
                                    SELF.perMatchLevel_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perMatchLevel_Flag);
                                    SELF.perAssociates := DueDiligence.v3Common.General.FirstPopulatedString(perAssociates);
                                    SELF.perAssociates_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perAssociates_Flag);
                                    SELF.perProfLicense := DueDiligence.v3Common.General.FirstPopulatedString(perProfLicense);
                                    SELF.perProfLicense_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perProfLicense_Flag);
                                    SELF.perBusAssociations := DueDiligence.v3Common.General.FirstPopulatedString(perBusAssociations);
                                    SELF.perBusAssociations_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perBusAssociations_Flag);
                                    SELF.perEmploymentIndustry := DueDiligence.v3Common.General.FirstPopulatedString(perEmploymentIndustry);
                                    SELF.perEmploymentIndustry_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perEmploymentIndustry_Flag);
                                    
                                    SELF.citizenshipScore := DueDiligence.v3Common.General.FirstPopulatedString(citizenshipScore);
                                    SELF.lexID := DueDiligence.v3Common.General.FirstNonZeroNumber(lexID);
                                    SELF.identityAge := DueDiligence.v3Common.General.FirstNonZeroNumber(identityAge);
                                    SELF.emergenceAgeHeader := DueDiligence.v3Common.General.FirstNonZeroNumber(emergenceAgeHeader);
                                    SELF.emergenceAgeBureau := DueDiligence.v3Common.General.FirstNonZeroNumber(emergenceAgeBureau);
                                    SELF.ssnIssuanceAge := DueDiligence.v3Common.General.FirstNonZeroNumber(ssnIssuanceAge);
                                    SELF.ssnIssuanceYears := DueDiligence.v3Common.General.FirstNonZeroNumber(ssnIssuanceYears);
                                    SELF.relativeCount := DueDiligence.v3Common.General.FirstNonZeroNumber(relativeCount);
                                    SELF.ver_voterRecords := DueDiligence.v3Common.General.FirstNonZeroNumber(ver_voterRecords);
                                    SELF.ver_insuranceRecords := DueDiligence.v3Common.General.FirstNonZeroNumber(ver_insuranceRecords);
                                    SELF.ver_studentFile := DueDiligence.v3Common.General.FirstNonZeroNumber(ver_studentFile);
                                    SELF.firstSeenAddr10 := DueDiligence.v3Common.General.FirstNonZeroNumber(firstSeenAddr10);
                                    SELF.reportedCurAddressYears := DueDiligence.v3Common.General.FirstNonZeroNumber(reportedCurAddressYears);
                                    SELF.addressFirstReportedAge := DueDiligence.v3Common.General.FirstNonZeroNumber(addressFirstReportedAge);
                                    SELF.timeSinceLastReportedNonBureau := DueDiligence.v3Common.General.FirstNonZeroNumber(timeSinceLastReportedNonBureau);
                                    SELF.inputSSNRandomlyIssued := DueDiligence.v3Common.General.FirstNonZeroNumber(inputSSNRandomlyIssued);
                                    SELF.inputSSNRandomIssuedInvalid := DueDiligence.v3Common.General.FirstNonZeroNumber(inputSSNRandomIssuedInvalid);
                                    SELF.inputSSNIssuedToNonUS := DueDiligence.v3Common.General.FirstNonZeroNumber(inputSSNIssuedToNonUS);
                                    SELF.inputSSNITIN := DueDiligence.v3Common.General.FirstNonZeroNumber(inputSSNITIN);
                                    SELF.inputSSNInvalid := DueDiligence.v3Common.General.FirstNonZeroNumber(inputSSNInvalid);
                                    SELF.inputSSNIssuedPriorDOB := DueDiligence.v3Common.General.FirstNonZeroNumber(inputSSNIssuedPriorDOB);
                                    SELF.inputSSNAssociatedMultLexIDs := DueDiligence.v3Common.General.FirstNonZeroNumber(inputSSNAssociatedMultLexIDs);
                                    SELF.inputSSNReportedDeceased := DueDiligence.v3Common.General.FirstNonZeroNumber(inputSSNReportedDeceased);
                                    SELF.inputSSNNotPrimaryLexID := DueDiligence.v3Common.General.FirstNonZeroNumber(inputSSNNotPrimaryLexID);
                                    SELF.lexIDBestSSNInvalid := DueDiligence.v3Common.General.FirstNonZeroNumber(lexIDBestSSNInvalid);
                                    SELF.lexIDReportedDeceased := DueDiligence.v3Common.General.FirstNonZeroNumber(lexIDReportedDeceased);
                                    SELF.lexIDMultipleSSNs := DueDiligence.v3Common.General.FirstNonZeroNumber(lexIDMultipleSSNs);
                                    SELF.inputComponentDivRisk := DueDiligence.v3Common.General.FirstNonZeroNumber(inputComponentDivRisk);
                                    
                                    SELF := LEFT));



    
    //DEBUGGING
    IF(debugMode, OUTPUT(bsToUse, NAMED('bsToUse')));
    IF(debugMode, OUTPUT(riskIndicators, NAMED('riskIndicators')));
    IF(debugMode, OUTPUT(citResults, NAMED('citResults')));
    IF(debugMode, OUTPUT(ddResults, NAMED('ddResults')));
    IF(debugMode, OUTPUT(sortResults, NAMED('sortResults')));
    IF(debugMode, OUTPUT(rollProducts, NAMED('rollProducts')));
    
    
    

    RETURN SORT(rollProducts, seq);
END;