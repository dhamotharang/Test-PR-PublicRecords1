IMPORT DueDiligence;

EXPORT reportIndIdentity(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION


    addEstimatedAgeRange := PROJECT(inData, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                                      SELF.personReport.PersonAttributeDetails.Identitiy.EstimatedAge := LEFT.estimatedAge;
                                                      SELF := LEFT;));
                                                      
                                                      
                                                      
    RETURN addEstimatedAgeRange;


END;