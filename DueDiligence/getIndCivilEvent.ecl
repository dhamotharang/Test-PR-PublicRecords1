IMPORT doxie, DueDiligence, liensv2;

/*
	Following Keys being used:
			liensv2.key_liens_DID
      liensv2.key_liens_party_id
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
                          
                          
    indivLienInfo := JOIN(indivLienKeys, liensv2.key_liens_party_id, 
                          LEFT.rmsid <> DueDiligence.Constants.EMPTY AND
                          KEYED(LEFT.tmsid = RIGHT.tmsid) AND 
                          KEYED(LEFT.rmsid = RIGHT.rmsid),
                          TRANSFORM(DueDiligence.LayoutsInternal.SharedSlimLiens, 
                                     SELF.dateFirstSeen := (UNSIGNED4)RIGHT.date_first_seen,
                                     SELF.dateLastSeen := (UNSIGNED4)RIGHT.date_last_seen,
                                     SELF := LEFT;),
                          KEEP(DueDiligence.Constants.MAX_ATMOST_1000),
                          ATMOST(KEYED(LEFT.tmsid = RIGHT.tmsid) AND KEYED(LEFT.rmsid = RIGHT.rmsid), DueDiligence.Constants.MAX_ATMOST_1000));
                          


    eventDetails := DueDiligence.getSharedLiensJudgementsEvictions(indivLienInfo, mod_access);

    
    //add civil information back to the input
    addCivil := JOIN(inData, eventDetails,
                      LEFT.seq = RIGHT.seq AND
                      LEFT.inquiredDID = RIGHT.did,
                      TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                SELF.liensUnreleasedCntInThePastNYR := RIGHT.totalUnreleasedLiensPast3Yrs;
                                SELF.liensUnreleasedCntOVNYR := RIGHT.totalUnreleasedLiensOver3Yrs;
                                SELF.evictionsCntInThePastNYR := RIGHT.totalEvictionsPast3Yrs;
                                SELF.evictionsCntOVNYR := RIGHT.totalEvictionsOver3Yrs;
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(1));




    // OUTPUT(indivLienKeys, NAMED('indivLienKeys'));
    // OUTPUT(indivLienInfo, NAMED('indivLienInfo'));
    
    // OUTPUT(eventDetails, NAMED('eventDetails'));
    // OUTPUT(addCivil, NAMED('addCivil'));
    


    RETURN addCivil;
END;