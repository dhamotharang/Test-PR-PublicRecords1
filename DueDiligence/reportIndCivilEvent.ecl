IMPORT DueDiligence;


EXPORT reportIndCivilEvent(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION


    //get all the business civil event details
    normCivil := NORMALIZE(inData, LEFT.ljeDetails, TRANSFORM(DueDiligence.LayoutsInternalReport.SharedCivilEvents,
                                                              SELF.seq := LEFT.seq; 
                                                              SELF.did := LEFT.inquiredDID;
                                                              
                                                              SELF := RIGHT;
                                                              SELF := [];));
                                                                  
                                                                  
    sharedCivil := reportSharedCivil(normCivil);
    
    
    //populate the report with the civil event information
    populatedCivil := JOIN(inData, sharedCivil,
                           LEFT.seq = RIGHT.seq AND
                           LEFT.inquiredDID = RIGHT.did,
                           TRANSFORM(DueDiligence.layouts.Indv_Internal,
                                     SELF.personReport.PersonAttributeDetails.Legal.PossibleLiensJudgmentsEvictions := RIGHT.lje;
                                     SELF := LEFT;),
                           LEFT OUTER,
                           ATMOST(1));
                                                                  
                                                                  

    // OUTPUT(normCivil, NAMED('normCivil'));
    // OUTPUT(sharedCivil, NAMED('sharedCivil'));
    // OUTPUT(populatedCivil, NAMED('populatedCivil'));
    
    RETURN populatedCivil;
END;