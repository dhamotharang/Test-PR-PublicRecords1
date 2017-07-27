IMPORT FFD;

EXPORT SlimPersonContext (DATASET(FFD.Layouts.PersonContextBatch) PersonContext ) := FUNCTION
  
    // This rolls up the record level person context like DR and RS
    pc_filt := PersonContext (RecordType IN FFD.Constants.RecordType.RecordLevel);

    pc_grp := GROUP (SORT (pc_filt, acctno, LexId, DataGroup, RecId1, RecId2, RecId3, RecId4),
                                    acctno, LexId, DataGroup, RecId1, RecId2, RecId3, RecId4); 


    FFD.Layouts.PersonContextBatchSlim xform (FFD.layouts.PersonContextBatch L, 
                                              DATASET (FFD.layouts.PersonContextBatch) R) := TRANSFORM
        SELF.StatementIDs := PROJECT (R (RecordType IN FFD.Constants.RecordType.StatementRecordLevel), FFD.Layouts.StatementIdRec);
        SELF.isDisputed   := EXISTS (R (RecordType = FFD.Constants.RecordType.DR));
        SELF := L;
    END;

    SlimPersonContext := ROLLUP (pc_grp, GROUP, xform (LEFT, ROWS (LEFT)));
  
    RETURN SlimPersonContext;
END;