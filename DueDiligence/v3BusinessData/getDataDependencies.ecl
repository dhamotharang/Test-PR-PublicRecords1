IMPORT BIPV2, Business_Risk_BIP, Doxie, DueDiligence;


EXPORT getDataDependencies(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                           DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested,
                           DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                           DueDiligence.DDInterface.iDDBusinessOptions ddOptions) := FUNCTION


    //retrieve the best data
    bestInquired := DueDiligence.v3BusinessData.getInputBestData(inData, regulatoryAccess, ddOptions);
    
    continueWith := bestInquired(inquiredBusiness.seleID > 0);
    
    
    includeBEOs := attributesRequested.includeAll OR 
                   attributesRequested.includeStateLegalEvent OR attributesRequested.includeOffenseType OR
                   attributesRequested.includeBEOProfLicense OR attributesRequested.includeBEOUSResidency; // OR 
                   // attributesRequested.includeBEOAccessToFundsProperty OR attributesRequested.includeLinkedBusinesses; //UNCOMMENT ONCE CODED
                   
                   
    beoData := IF(includeBEOs, DueDiligence.v3BusinessData.getExec(continueWith, attributesRequested, regulatoryAccess, ddOptions), continueWith);
    
    
    returnData := bestInquired(inquiredBusiness.seleID = 0) + beoData;
    
    // OUTPUT(bestInquired, NAMED('bestInquired'));
    // OUTPUT(beoData, NAMED('beoData'));
    // OUTPUT(returnData, NAMED('returnData'));

    RETURN returnData;
END;