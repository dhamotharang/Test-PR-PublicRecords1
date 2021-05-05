IMPORT dx_official_records, iesp;
EXPORT Layouts := MODULE
  
  EXPORT search := RECORD
    STRING60 official_record_key;
  END;

  EXPORT raw_rec := RECORD
    dx_Official_Records.layouts.Party;
  END;
  
  EXPORT t_OfficialRecRecordWithPenalty := RECORD
    iesp.officialrecord.t_OfficialRecRecord;
  END;

END;
