IMPORT emerges, iesp, FFD;
EXPORT Layouts := MODULE
  EXPORT rawrec := RECORD
    RECORDOF(emerges.key_CCW_rid);
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED2 penalt := 0;
    DATASET(FFD.Layouts.StatementIdRec) StatementIds := DATASET([],FFD.Layouts.StatementIdRec);
    BOOLEAN isDisputed := FALSE;
  END;    
  EXPORT search_rid := RECORD
    UNSIGNED6 rid;
    BOOLEAN isDeepDive := FALSE;
  END;
  
  EXPORT search_did := RECORD
    UNSIGNED6 did;
    BOOLEAN isDeepDive := FALSE;
  END;
    
  EXPORT t_CCWRecordWithPenalty := RECORD
    iesp.concealedweapon.t_WeaponRecord;
    BOOLEAN AlsoFound;
    UNSIGNED2 _penalty := 0;
    BOOLEAN isDisputed := FALSE;
    DATASET(FFD.Layouts.StatementIdRec) StatementIds := DATASET([],FFD.Layouts.StatementIdRec);
  END;
END;
