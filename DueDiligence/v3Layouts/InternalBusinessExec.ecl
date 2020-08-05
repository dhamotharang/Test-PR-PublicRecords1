IMPORT DueDiligence;


EXPORT InternalBusinessExec := MODULE

    EXPORT ExecDetails := RECORD
      DueDiligence.v3Layouts.InternalShared.InternalIDs -did;
      DueDiligence.v3Layouts.Internal.SlimExec -relationship -phone;
      UNSIGNED4 historyDate;
      DueDiligence.v3Layouts.Internal.beoTitles;
    END;
    
    EXPORT ExecDetsSlim := RECORD
      DueDiligence.v3Layouts.InternalShared.InternalIDs; 
      DATASET(DueDiligence.v3Layouts.Internal.SlimExec) execs;
    END;

END;