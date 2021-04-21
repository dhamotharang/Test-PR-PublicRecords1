IMPORT corrections, iesp, FFD;

EXPORT layouts := MODULE

  EXPORT l_search := RECORD
    STRING60 offender_key;
    BOOLEAN isDeepDive := FALSE;
  END;

  EXPORT docnum_rec := RECORD
    STRING25 doc_number;
  END;

  EXPORT casenum_rec := RECORD
    STRING35 case_number;
  END;
  
  EXPORT l_raw := RECORD
    corrections.layout_Offender;
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED2 penalt := 0;
    FFD.Layouts.CommonRawRecordElements;
  END;

  EXPORT offense_rec := RECORD
    UNSIGNED bitmap;
    STRING description;
  END;

  EXPORT raw_with_offenses := RECORD
    l_raw;
    DATASET(offense_rec) offenses;
  END;

  EXPORT t_CrimSearchRecordWithPenalty := RECORD
    iesp.criminal_fcra.t_FcraCrimSearchRecord;
  END;
  
END;
