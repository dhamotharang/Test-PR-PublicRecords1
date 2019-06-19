IMPORT FFD, iesp;

EXPORT Layouts :=
MODULE

  EXPORT ReportResponse := RECORD
    iesp.share.t_ResponseHeader.Status;
    iesp.share.t_ResponseHeader.Message;
    iesp.share.t_ResponseHeader.Exceptions;
    iesp.fcradataservice.t_FcraDataServiceReport Records;
  END;

  EXPORT Metadata := RECORD
    iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Meta')};
  END;

  EXPORT RecordIds := RECORD(iesp.fcradataservice_common.t_FcraDataServiceRecID)
  END;

  EXPORT ComplianceFlags := RECORD    
    BOOLEAN IsOverwritten := FALSE;
    BOOLEAN IsOverride := FALSE;
    BOOLEAN IsSuppressed := FALSE;
    BOOLEAN isDisputed := FALSE;
  END;
  
  EXPORT InternalMetadata := RECORD
    ComplianceFlags compliance_flags;
    RecordIds record_ids;
    UNSIGNED6 subject_did := 0;
    STRING100 combined_record_id := '';
    DATASET(FFD.Layouts.StatementIdRec) statement_ids := DATASET([], FFD.Layouts.StatementIdRec);
  END;
  
  EXPORT ssn_rec := RECORD
    UNSIGNED6 subject_did := 0;
    UNSIGNED3 dt_last_seen;
    STRING9   ssn;
    STRING1   valid_SSN := '';
    BOOLEAN   inquiry_source := FALSE;
    BOOLEAN   header_source := FALSE;
  END;
  
  EXPORT address_rec := RECORD
    UNSIGNED6 subject_did := 0;
    STRING10 prim_range;
    STRING2  predir;
    STRING28 prim_name;
    STRING4  suffix;
    STRING2  postdir;
    STRING10 unit_desig;
    STRING8  sec_range;
    STRING25 city_name;
    STRING2  st;
    STRING5  zip;
    STRING4  zip4;
    STRING3  county;
    STRING7   geo_blk;
  END;

END;