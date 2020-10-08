IMPORT DueDiligence;

EXPORT getDataDependencies(DATASET(DueDiligence.v3Layouts.Internal.PersonTemp) inData,
                           DueDiligence.DDInterface.iDDv3PersonAttributes attributesRequested,
                           DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                           DueDiligence.DDInterface.iDDPersonOptions ddOptions) := FUNCTION


    //retrieve the best data
    bestInquired := DueDiligence.v3PersonData.getInputBestData(inData, regulatoryAccess, ddOptions);
    
    //only need to retrieve information if we have an inquiredDID
    continueWith := bestInquired(inquiredDID > 0);


    //retrieve information for other individuals if requesting an attribute that
    //needs or takes into account other individuals
    // includeSpouses := attributesRequested.includeAll OR attributesRequested.includeAssetOwnProperty OR
                       // attributesRequested.includeAssetOwnAircraft OR attributesRequested.includeAssetOwnWatercraft OR
                       // attributesRequested.includeAssetOwnVehicle OR attributesRequested.includeAccessToFundsProperty OR
                       // attributesRequested.includeAssociates;
                     
    // includeParents := attributesRequested.includeAll OR attributesRequested.includeUSResidency OR
                      // attributesRequested.includeAssociates;
                     
    // includeOtherRelationships := attributesRequested.includeAll OR attributesRequested.includeAssociates;
    
    // includeAdditionalRelationships := includeSpouses OR includeParents OR includeOtherRelationships;
    
    
    
    // retrievedRelationships := DueDiligence.v3PersonData.getRelationships(continueWith, regulatoryAccess, includeSpouses, includeParents, includeOtherRelationships, ddOptions.includeReportData);
    
    // populatedRelationships := IF(includeAdditionalRelationships, retrievedRelationships, continueWith);
    populatedRelationships := continueWith;
    
    
    returnData := bestInquired(inquiredDID = 0) + populatedRelationships;
    
    
    
    
    // OUTPUT(bestInquired, NAMED('bestInquired'));
    // OUTPUT(includeSpouses, NAMED('includeSpouses'));
    // OUTPUT(includeParents, NAMED('includeParents'));
    // OUTPUT(includeOtherRelationships, NAMED('includeOtherRelationships'));
    // OUTPUT(includeAdditionalRelationships, NAMED('includeAdditionalRelationships'));
    // OUTPUT(retrievedRelationships, NAMED('retrievedRelationships'));
    // OUTPUT(populatedRelationships, NAMED('populatedRelationships'));
    
    
    RETURN returnData;
END;