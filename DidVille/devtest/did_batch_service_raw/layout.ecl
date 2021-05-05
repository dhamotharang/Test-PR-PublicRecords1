IMPORT didville;
EXPORT layout := MODULE

  EXPORT request := RECORD
    STRING120 Appends;
    STRING120 Verify;
    STRING120 Fuzzies;
    BOOLEAN Deduped;
    STRING3 AppendThreshold;
    BOOLEAN GLBData;
    BOOLEAN PatriotProcess;
    UNSIGNED1 xADLVersion;
    UNSIGNED8 Max_Results_Per_Acct;
    BOOLEAN IncludeRanking;
    DATASET(didville.Layout_Did_InBatchRaw) did_batch_in; 
  END;

  EXPORT response := didville.Layout_Did_OutBatch_Raw;

END;
