IMPORT ut,SALT33;
EXPORT party_aka_dba_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(party_aka_dba_Layout_SANCTN_NPKeys)
    UNSIGNED1 batch_Invalid;
    UNSIGNED1 dbcode_Invalid;
    UNSIGNED1 incident_num_Invalid;
    UNSIGNED1 party_num_Invalid;
    UNSIGNED1 name_type_Invalid;
    UNSIGNED1 party_key_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(party_aka_dba_Layout_SANCTN_NPKeys)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(party_aka_dba_Layout_SANCTN_NPKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.batch_Invalid := party_aka_dba_Fields.InValid_batch((SALT33.StrType)le.batch);
    SELF.dbcode_Invalid := party_aka_dba_Fields.InValid_dbcode((SALT33.StrType)le.dbcode);
    SELF.incident_num_Invalid := party_aka_dba_Fields.InValid_incident_num((SALT33.StrType)le.incident_num);
    SELF.party_num_Invalid := party_aka_dba_Fields.InValid_party_num((SALT33.StrType)le.party_num);
    SELF.name_type_Invalid := party_aka_dba_Fields.InValid_name_type((SALT33.StrType)le.name_type);
    SELF.party_key_Invalid := party_aka_dba_Fields.InValid_party_key((SALT33.StrType)le.party_key);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),party_aka_dba_Layout_SANCTN_NPKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.batch_Invalid << 0 ) + ( le.dbcode_Invalid << 2 ) + ( le.incident_num_Invalid << 3 ) + ( le.party_num_Invalid << 4 ) + ( le.name_type_Invalid << 5 ) + ( le.party_key_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,party_aka_dba_Layout_SANCTN_NPKeys);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.batch_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.dbcode_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.incident_num_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.party_num_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.name_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.party_key_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.dbcode;
    TotalCnt := COUNT(GROUP); // Number of records in total
    batch_ALLOW_ErrorCount := COUNT(GROUP,h.batch_Invalid=1);
    batch_LENGTH_ErrorCount := COUNT(GROUP,h.batch_Invalid=2);
    batch_Total_ErrorCount := COUNT(GROUP,h.batch_Invalid>0);
    dbcode_ENUM_ErrorCount := COUNT(GROUP,h.dbcode_Invalid=1);
    incident_num_ALLOW_ErrorCount := COUNT(GROUP,h.incident_num_Invalid=1);
    party_num_ALLOW_ErrorCount := COUNT(GROUP,h.party_num_Invalid=1);
    name_type_ENUM_ErrorCount := COUNT(GROUP,h.name_type_Invalid=1);
    party_key_ALLOW_ErrorCount := COUNT(GROUP,h.party_key_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,dbcode,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.dbcode;
    UNSIGNED1 ErrNum := CHOOSE(c,le.batch_Invalid,le.dbcode_Invalid,le.incident_num_Invalid,le.party_num_Invalid,le.name_type_Invalid,le.party_key_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,party_aka_dba_Fields.InvalidMessage_batch(le.batch_Invalid),party_aka_dba_Fields.InvalidMessage_dbcode(le.dbcode_Invalid),party_aka_dba_Fields.InvalidMessage_incident_num(le.incident_num_Invalid),party_aka_dba_Fields.InvalidMessage_party_num(le.party_num_Invalid),party_aka_dba_Fields.InvalidMessage_name_type(le.name_type_Invalid),party_aka_dba_Fields.InvalidMessage_party_key(le.party_key_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.batch_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dbcode_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.incident_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.party_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.party_key_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'batch','dbcode','incident_num','party_num','name_type','party_key','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Batch','Invalid_DBCode','Invalid_Num','Invalid_Num','Invalid_NameType','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.batch,(SALT33.StrType)le.dbcode,(SALT33.StrType)le.incident_num,(SALT33.StrType)le.party_num,(SALT33.StrType)le.name_type,(SALT33.StrType)le.party_key,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,6,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.dbcode;
      SELF.ruledesc := CHOOSE(c
          ,'batch:Invalid_Batch:ALLOW','batch:Invalid_Batch:LENGTH'
          ,'dbcode:Invalid_DBCode:ENUM'
          ,'incident_num:Invalid_Num:ALLOW'
          ,'party_num:Invalid_Num:ALLOW'
          ,'name_type:Invalid_NameType:ENUM'
          ,'party_key:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,party_aka_dba_Fields.InvalidMessage_batch(1),party_aka_dba_Fields.InvalidMessage_batch(2)
          ,party_aka_dba_Fields.InvalidMessage_dbcode(1)
          ,party_aka_dba_Fields.InvalidMessage_incident_num(1)
          ,party_aka_dba_Fields.InvalidMessage_party_num(1)
          ,party_aka_dba_Fields.InvalidMessage_name_type(1)
          ,party_aka_dba_Fields.InvalidMessage_party_key(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.batch_ALLOW_ErrorCount,le.batch_LENGTH_ErrorCount
          ,le.dbcode_ENUM_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.party_num_ALLOW_ErrorCount
          ,le.name_type_ENUM_ErrorCount
          ,le.party_key_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.batch_ALLOW_ErrorCount,le.batch_LENGTH_ErrorCount
          ,le.dbcode_ENUM_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.party_num_ALLOW_ErrorCount
          ,le.name_type_ENUM_ErrorCount
          ,le.party_key_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
