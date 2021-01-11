IMPORT DueDiligence;



EXPORT getDataDependencies(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                           DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION


    retrieveBestIndustry := DueDiligence.v3BusinessData.getIndustryBest(inData, regulatoryAccess);
    
    
    
    bestIndustryCodes := JOIN(inData, retrieveBestIndustry,
                              LEFT.seq = RIGHT.seq AND
                              LEFT.inquiredBusiness.ultID = RIGHT.inquiredBusiness.ultID AND
                              LEFT.inquiredBusiness.orgID = RIGHT.inquiredBusiness.orgID AND
                              LEFT.inquiredBusiness.seleID = RIGHT.inquiredBusiness.seleID,
                              TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                        SELF.bestData.sicCode := RIGHT.bestData.sicCode;
                                        SELF.bestData.naicsCode := RIGHT.bestData.naicsCode;
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(1));
    
    
    
    

    // OUTPUT(bestIndustryCodes, NAMED('bestIndustryCodes'));

    RETURN bestIndustryCodes;
END;