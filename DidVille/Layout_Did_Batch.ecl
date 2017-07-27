IMPORT BatchShare;

EXPORT Layout_Did_Batch :=
MODULE
  EXPORT In :=
  RECORD(Didville.Layout_Did_InBatch)
    BatchShare.Layouts.ShareAcct;
  END;
  
  EXPORT Out :=
  RECORD(Didville.Layout_Did_OutBatch)
    BatchShare.Layouts.ShareAcct;
  END;
END;