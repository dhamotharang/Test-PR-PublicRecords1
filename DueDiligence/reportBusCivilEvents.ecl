IMPORT DueDiligence;

EXPORT reportBusCivilEvents(DATASET(DueDiligence.layouts.Busn_Internal) inData) := FUNCTION

    //get all the business civil event details
    normCivil := NORMALIZE(inData, LEFT.busLJEDetails, TRANSFORM(DueDiligence.LayoutsInternalReport.SharedCivilEvents,
                                                                  SELF.seq := LEFT.seq; 
                                                                  SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                                  SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                                  SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                                  
                                                                  SELF := RIGHT;
                                                                  SELF := [];));
                                                                  
                                                                  
    sharedCivil := reportSharedCivil(normCivil);
    
    
    //populate the report with the civil event information
    populatedCivil := JOIN(inData, sharedCivil,
                           LEFT.seq = RIGHT.seq AND
                           LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
                           LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
                           LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
                           TRANSFORM(DueDiligence.layouts.Busn_Internal,
                                     SELF.BusinessReport.BusinessAttributeDetails.Legal.PossibleLiensJudgmentsEvictions := RIGHT.lje;
                                     SELF := LEFT;),
                           LEFT OUTER,
                           ATMOST(1));
                                                                  
                                                                  

    // OUTPUT(normCivil, NAMED('normCivil'));
    // OUTPUT(sharedCivil, NAMED('sharedCivil'));
    // OUTPUT(populatedCivil, NAMED('populatedCivil'));
    
    RETURN populatedCivil;
END;