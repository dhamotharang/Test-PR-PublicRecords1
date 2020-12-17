IMPORT DueDiligence;


EXPORT notFound(DATASET(DueDiligence.v3Layouts.Internal.PersonTemp) inData, 
                DueDiligence.DDInterface.iDDv3PersonAttributes attributesRequested) := FUNCTION
                

    //individual not found
    STRING10 INVALID_INDIVIDUAL_FLAGS := 'FFFFFFFFFF';
    STRING2 INVALID_INDIVIDUAL_SCORE := '-1';
    
    
    noDataFound := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonResults,
                                              SELF.seq := LEFT.seq;
                                              
                                              SELF.perMatchLevel := INVALID_INDIVIDUAL_SCORE; //always called regardless of module(s)
                                              SELF.perMatchLevel_Flag := INVALID_INDIVIDUAL_FLAGS; //always called regardless of module(s)
                                              
                                              SELF.perCivilLegalEvent := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEvent, INVALID_INDIVIDUAL_SCORE, DueDiligence.Constants.EMPTY);
                                              SELF.perCivilLegalEvent_Flag := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEvent, INVALID_INDIVIDUAL_FLAGS, DueDiligence.Constants.EMPTY);
                                              
                                              SELF.perCivilLegalEventFilingAmt := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEventFilingAmount, INVALID_INDIVIDUAL_SCORE, DueDiligence.Constants.EMPTY);
                                              SELF.perCivilLegalEventFilingAmt_Flag := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEventFilingAmount, INVALID_INDIVIDUAL_FLAGS, DueDiligence.Constants.EMPTY);
                                              
                                              SELF.perOffenseType := IF(attributesRequested.includeAll OR attributesRequested.includeOffenseType, INVALID_INDIVIDUAL_SCORE, DueDiligence.Constants.EMPTY);;
                                              SELF.perOffenseType_Flag := IF(attributesRequested.includeAll OR attributesRequested.includeOffenseType, INVALID_INDIVIDUAL_FLAGS, DueDiligence.Constants.EMPTY);
                                              
                                              SELF.perStateLegalEvent := IF(attributesRequested.includeAll OR attributesRequested.includeStateLegalEvent, INVALID_INDIVIDUAL_SCORE, DueDiligence.Constants.EMPTY);;
                                              SELF.perStateLegalEvent_Flag := IF(attributesRequested.includeAll OR attributesRequested.includeStateLegalEvent, INVALID_INDIVIDUAL_FLAGS, DueDiligence.Constants.EMPTY);
                                              
                                              SELF := [];));
                
                
                
    RETURN noDataFound;
END;