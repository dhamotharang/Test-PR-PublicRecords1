IMPORT DueDiligence;


EXPORT notFound(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                        DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested) := FUNCTION
                        


    //individual not found
    STRING10 INVALID_BUSINESS_FLAGS := 'FFFFFFFFFF';
    STRING2 INVALID_BUSINESS_SCORE := '-1';
    
    
    noDataFound := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessResults,
                                              SELF.seq := LEFT.seq;
                                              
                                              SELF.busMatchLevel := INVALID_BUSINESS_SCORE; //always called regardless of module(s)
                                              SELF.busMatchLevel_Flag := INVALID_BUSINESS_FLAGS; //always called regardless of module(s)
                                              
                                              SELF.busCivilLegalEvent := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEvent, INVALID_BUSINESS_SCORE, DueDiligence.Constants.EMPTY);
                                              SELF.busCivilLegalEvent_Flag := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEvent, INVALID_BUSINESS_FLAGS, DueDiligence.Constants.EMPTY);
                                              
                                              SELF.busCivilLegalEventFilingAmt := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEventFilingAmount, INVALID_BUSINESS_SCORE, DueDiligence.Constants.EMPTY);
                                              SELF.busCivilLegalEventFilingAmt_Flag := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEventFilingAmount, INVALID_BUSINESS_FLAGS, DueDiligence.Constants.EMPTY);
                                              
                                              SELF.busOffenseType := IF(attributesRequested.includeAll OR attributesRequested.includeOffenseType, INVALID_BUSINESS_SCORE, DueDiligence.Constants.EMPTY);;
                                              SELF.busOffenseType_Flag := IF(attributesRequested.includeAll OR attributesRequested.includeOffenseType, INVALID_BUSINESS_FLAGS, DueDiligence.Constants.EMPTY);
                                              
                                              SELF.busStateLegalEvent := IF(attributesRequested.includeAll OR attributesRequested.includeStateLegalEvent, INVALID_BUSINESS_SCORE, DueDiligence.Constants.EMPTY);
                                              SELF.busStateLegalEvent_Flag := IF(attributesRequested.includeAll OR attributesRequested.includeStateLegalEvent, INVALID_BUSINESS_FLAGS, DueDiligence.Constants.EMPTY);
                                              
                                              SELF.busBEOAccessToFundsProperty := IF(attributesRequested.includeAll OR attributesRequested.includeBEOAccessToFundsProperty, INVALID_BUSINESS_SCORE, DueDiligence.Constants.EMPTY);
                                              SELF.busBEOAccessToFundsProperty_Flag := IF(attributesRequested.includeAll OR attributesRequested.includeBEOAccessToFundsProperty, INVALID_BUSINESS_FLAGS, DueDiligence.Constants.EMPTY);
                                              
                                              SELF.busIndustry := IF(attributesRequested.includeAll OR attributesRequested.includeIndustry, INVALID_BUSINESS_SCORE, DueDiligence.Constants.EMPTY);
                                              SELF.busIndustry_Flag := IF(attributesRequested.includeAll OR attributesRequested.includeIndustry, INVALID_BUSINESS_FLAGS, DueDiligence.Constants.EMPTY);
                                              
                                              SELF := [];));

    RETURN noDataFound;
END;