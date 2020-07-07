IMPORT doxie, DueDiligence, liensv2;

/*
	Following Keys being used:
			liensv2.key_liens_DID
*/

EXPORT getIndCivilEvent(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                        doxie.IDataAccess mod_access) := FUNCTION


    indivLienKeys := JOIN(inData, liensv2.key_liens_DID,
                          KEYED(LEFT.inquiredDID = RIGHT.did),
                          TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens,
                                    SELF.seq := LEFT.seq;
                                    SELF.did := LEFT.inquiredDID;
                                    SELF.historyDate := LEFT.historyDate;
                                    SELF.rmsid := RIGHT.rmsid;
                                    SELF.tmsid := RIGHT.tmsid;
                                    SELF := [];),
                          KEEP(DueDiligence.Constants.MAX_ATMOST_500),
                          ATMOST(KEYED(LEFT.inquiredDID = RIGHT.did), DueDiligence.Constants.MAX_ATMOST_1000));
                          


    eventDetails := DueDiligence.getSharedLiensJudgementsEvictions(indivLienKeys, mod_access);

    
    //add civil information back to the input
    addCivil := JOIN(inData, eventDetails,
                      LEFT.seq = RIGHT.seq AND
                      LEFT.inquiredDID = RIGHT.did,
                      TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                SELF.liensUnreleasedCntInThePastNYR := RIGHT.totalUnreleasedLiensPast3Yrs;
                                SELF.liensUnreleasedCntOVNYR := RIGHT.totalUnreleasedLiensOver3Yrs;
                                SELF.evictionsCntInThePastNYR := RIGHT.totalEvictionsPast3Yrs;
                                SELF.evictionsCntOVNYR := RIGHT.totalEvictionsOver3Yrs;
                                SELF.ljeDetails := RIGHT.lje;
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(1));




    // OUTPUT(indivLienKeys, NAMED('indivLienKeys'));    
    // OUTPUT(eventDetails, NAMED('eventDetails'));
    // OUTPUT(addCivil, NAMED('addCivil'));
    


    RETURN addCivil;
END;