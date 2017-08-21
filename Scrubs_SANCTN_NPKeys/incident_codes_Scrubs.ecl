IMPORT ut,SALT33;
IMPORT Scrubs,Scrubs_SANCTN_NPKeys; // Import modules for FieldTypes attribute definitions
EXPORT incident_codes_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(incident_codes_Layout_SANCTN_NPKeys)
    UNSIGNED1 batch_Invalid;
    UNSIGNED1 dbcode_Invalid;
    UNSIGNED1 primary_key_Invalid;
    UNSIGNED1 foreign_key_Invalid;
    UNSIGNED1 incident_num_Invalid;
    UNSIGNED1 number_Invalid;
    UNSIGNED1 field_name_Invalid;
    UNSIGNED1 code_type_Invalid;
    UNSIGNED1 code_value_Invalid;
    UNSIGNED1 code_state_Invalid;
    UNSIGNED1 cln_license_number_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(incident_codes_Layout_SANCTN_NPKeys)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(incident_codes_Layout_SANCTN_NPKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.batch_Invalid := incident_codes_Fields.InValid_batch((SALT33.StrType)le.batch);
    SELF.dbcode_Invalid := incident_codes_Fields.InValid_dbcode((SALT33.StrType)le.dbcode);
    SELF.primary_key_Invalid := incident_codes_Fields.InValid_primary_key((SALT33.StrType)le.primary_key);
    SELF.foreign_key_Invalid := incident_codes_Fields.InValid_foreign_key((SALT33.StrType)le.foreign_key);
    SELF.incident_num_Invalid := incident_codes_Fields.InValid_incident_num((SALT33.StrType)le.incident_num);
    SELF.number_Invalid := incident_codes_Fields.InValid_number((SALT33.StrType)le.number);
    SELF.field_name_Invalid := incident_codes_Fields.InValid_field_name((SALT33.StrType)le.field_name);
    SELF.code_type_Invalid := incident_codes_Fields.InValid_code_type((SALT33.StrType)le.code_type,(SALT33.StrType)le.field_name);
    SELF.code_value_Invalid := incident_codes_Fields.InValid_code_value((SALT33.StrType)le.code_value,(SALT33.StrType)le.field_name);
    SELF.code_state_Invalid := incident_codes_Fields.InValid_code_state((SALT33.StrType)le.code_state);
    SELF.cln_license_number_Invalid := incident_codes_Fields.InValid_cln_license_number((SALT33.StrType)le.cln_license_number);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),incident_codes_Layout_SANCTN_NPKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.batch_Invalid << 0 ) + ( le.dbcode_Invalid << 2 ) + ( le.primary_key_Invalid << 3 ) + ( le.foreign_key_Invalid << 4 ) + ( le.incident_num_Invalid << 5 ) + ( le.number_Invalid << 6 ) + ( le.field_name_Invalid << 7 ) + ( le.code_type_Invalid << 8 ) + ( le.code_value_Invalid << 9 ) + ( le.code_state_Invalid << 10 ) + ( le.cln_license_number_Invalid << 11 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,incident_codes_Layout_SANCTN_NPKeys);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.batch_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.dbcode_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.primary_key_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.foreign_key_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.incident_num_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.number_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.field_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.code_type_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.code_value_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.code_state_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.cln_license_number_Invalid := (le.ScrubsBits1 >> 11) & 1;
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
    primary_key_ALLOW_ErrorCount := COUNT(GROUP,h.primary_key_Invalid=1);
    foreign_key_ALLOW_ErrorCount := COUNT(GROUP,h.foreign_key_Invalid=1);
    incident_num_ALLOW_ErrorCount := COUNT(GROUP,h.incident_num_Invalid=1);
    number_ALLOW_ErrorCount := COUNT(GROUP,h.number_Invalid=1);
    field_name_ENUM_ErrorCount := COUNT(GROUP,h.field_name_Invalid=1);
    code_type_CUSTOM_ErrorCount := COUNT(GROUP,h.code_type_Invalid=1);
    code_value_CUSTOM_ErrorCount := COUNT(GROUP,h.code_value_Invalid=1);
    code_state_CUSTOM_ErrorCount := COUNT(GROUP,h.code_state_Invalid=1);
    cln_license_number_ALLOW_ErrorCount := COUNT(GROUP,h.cln_license_number_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.batch_Invalid,le.dbcode_Invalid,le.primary_key_Invalid,le.foreign_key_Invalid,le.incident_num_Invalid,le.number_Invalid,le.field_name_Invalid,le.code_type_Invalid,le.code_value_Invalid,le.code_state_Invalid,le.cln_license_number_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,incident_codes_Fields.InvalidMessage_batch(le.batch_Invalid),incident_codes_Fields.InvalidMessage_dbcode(le.dbcode_Invalid),incident_codes_Fields.InvalidMessage_primary_key(le.primary_key_Invalid),incident_codes_Fields.InvalidMessage_foreign_key(le.foreign_key_Invalid),incident_codes_Fields.InvalidMessage_incident_num(le.incident_num_Invalid),incident_codes_Fields.InvalidMessage_number(le.number_Invalid),incident_codes_Fields.InvalidMessage_field_name(le.field_name_Invalid),incident_codes_Fields.InvalidMessage_code_type(le.code_type_Invalid),incident_codes_Fields.InvalidMessage_code_value(le.code_value_Invalid),incident_codes_Fields.InvalidMessage_code_state(le.code_state_Invalid),incident_codes_Fields.InvalidMessage_cln_license_number(le.cln_license_number_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.batch_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dbcode_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.foreign_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.incident_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field_name_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.code_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.code_value_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.code_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cln_license_number_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'batch','dbcode','primary_key','foreign_key','incident_num','number','field_name','code_type','code_value','code_state','cln_license_number','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Batch','Invalid_DBCode','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Field','Invalid_LicenceCode','Invalid_ProfessionCode','Invalid_State','Invalid_Licence','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.batch,(SALT33.StrType)le.dbcode,(SALT33.StrType)le.primary_key,(SALT33.StrType)le.foreign_key,(SALT33.StrType)le.incident_num,(SALT33.StrType)le.number,(SALT33.StrType)le.field_name,(SALT33.StrType)le.code_type,(SALT33.StrType)le.code_value,(SALT33.StrType)le.code_state,(SALT33.StrType)le.cln_license_number,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,11,Into(LEFT,COUNTER));
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
          ,'primary_key:Invalid_Num:ALLOW'
          ,'foreign_key:Invalid_Num:ALLOW'
          ,'incident_num:Invalid_Num:ALLOW'
          ,'number:Invalid_Num:ALLOW'
          ,'field_name:Invalid_Field:ENUM'
          ,'code_type:Invalid_LicenceCode:CUSTOM'
          ,'code_value:Invalid_ProfessionCode:CUSTOM'
          ,'code_state:Invalid_State:CUSTOM'
          ,'cln_license_number:Invalid_Licence:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,incident_codes_Fields.InvalidMessage_batch(1),incident_codes_Fields.InvalidMessage_batch(2)
          ,incident_codes_Fields.InvalidMessage_dbcode(1)
          ,incident_codes_Fields.InvalidMessage_primary_key(1)
          ,incident_codes_Fields.InvalidMessage_foreign_key(1)
          ,incident_codes_Fields.InvalidMessage_incident_num(1)
          ,incident_codes_Fields.InvalidMessage_number(1)
          ,incident_codes_Fields.InvalidMessage_field_name(1)
          ,incident_codes_Fields.InvalidMessage_code_type(1)
          ,incident_codes_Fields.InvalidMessage_code_value(1)
          ,incident_codes_Fields.InvalidMessage_code_state(1)
          ,incident_codes_Fields.InvalidMessage_cln_license_number(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.batch_ALLOW_ErrorCount,le.batch_LENGTH_ErrorCount
          ,le.dbcode_ENUM_ErrorCount
          ,le.primary_key_ALLOW_ErrorCount
          ,le.foreign_key_ALLOW_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.number_ALLOW_ErrorCount
          ,le.field_name_ENUM_ErrorCount
          ,le.code_type_CUSTOM_ErrorCount
          ,le.code_value_CUSTOM_ErrorCount
          ,le.code_state_CUSTOM_ErrorCount
          ,le.cln_license_number_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.batch_ALLOW_ErrorCount,le.batch_LENGTH_ErrorCount
          ,le.dbcode_ENUM_ErrorCount
          ,le.primary_key_ALLOW_ErrorCount
          ,le.foreign_key_ALLOW_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.number_ALLOW_ErrorCount
          ,le.field_name_ENUM_ErrorCount
          ,le.code_type_CUSTOM_ErrorCount
          ,le.code_value_CUSTOM_ErrorCount
          ,le.code_state_CUSTOM_ErrorCount
          ,le.cln_license_number_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,12,Into(LEFT,COUNTER));
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
