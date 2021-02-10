IMPORT Business_Credit_KEL, Business_Credit;


EXPORT getDBT_V5ArchiveMode (DATASET(RECORDOF(Business_Credit_KEL.File_SBFE_temp)) originalFDCRecord) := FUNCTION

    nTradelines := NORMALIZE(originalFDCRecord,
                             LEFT.tradelines,
                             TRANSFORM(Business_Credit.Layouts.rAccountBaseSeq,
                                 SELF := RIGHT;
                                 SELF := [];
                                      )
                            ); 


    calculatedDBT_V5 := SORT(UNGROUP(Business_Credit.CalculateDBTV5(nTradelines)), seq_num);


    overwriteOriginalTradelines := JOIN(originalFDCRecord.tradelines, calculatedDBT_V5,
                                        LEFT.seq_num = RIGHT.seq_num,
                                             TRANSFORM(RECORDOF(LEFT),
                                                 SELF.DBT_V5 := RIGHT.DBT_V5;
                                                 SELF.Raw_DBT_V5 := RIGHT.Raw_DBT_V5;
                                                 SELF := LEFT;
                                                      ),
                                        LEFT OUTER
                                       );


    dTradelinesBackIntoFDCRecord := DENORMALIZE(originalFDCRecord, overwriteOriginalTradelines,
                                                LEFT.seq = RIGHT.seq,
                                                GROUP,
                                                   TRANSFORM(RECORDOF(LEFT),
                                                       SELF.seq := LEFT.seq;
                                                       SELF.tradelines := ROWS(RIGHT);
                                                       SELF := LEFT;
                                                       SELF := []; 
                                                            )
                                               );
    
    // Debugging options
    // OUTPUT(nTradelines, NAMED('nTradelines'));
    // OUTPUT(calculatedDBT_V5, NAMED('calculatedDBT_V5'));
    // OUTPUT(overwriteOriginalTradelines, NAMED('overwriteOriginalTradelines'));
    // OUTPUT(dTradelinesBackIntoFDCRecord, NAMED('dTradelinesBackIntoFDCRecord'));
    
    RETURN dTradelinesBackIntoFDCRecord;
        
END;
