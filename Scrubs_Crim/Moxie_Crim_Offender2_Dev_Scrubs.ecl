IMPORT ut,SALT33;
IMPORT Scrubs_Crim,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Moxie_Crim_Offender2_Dev_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Moxie_Crim_Offender2_Dev_Layout_crim)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 file_date_Invalid;
    UNSIGNED1 offender_key_Invalid;
    UNSIGNED1 case_date_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 clean_errors_Invalid;
    UNSIGNED1 fcra_date_Invalid;
    UNSIGNED1 offender_persistent_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Moxie_Crim_Offender2_Dev_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Moxie_Crim_Offender2_Dev_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Moxie_Crim_Offender2_Dev_Fields.InValid_process_date((SALT33.StrType)le.process_date);
    SELF.file_date_Invalid := Moxie_Crim_Offender2_Dev_Fields.InValid_file_date((SALT33.StrType)le.file_date);
    SELF.offender_key_Invalid := Moxie_Crim_Offender2_Dev_Fields.InValid_offender_key((SALT33.StrType)le.offender_key);
    SELF.case_date_Invalid := Moxie_Crim_Offender2_Dev_Fields.InValid_case_date((SALT33.StrType)le.case_date);
    SELF.dob_Invalid := Moxie_Crim_Offender2_Dev_Fields.InValid_dob((SALT33.StrType)le.dob);
    SELF.clean_errors_Invalid := Moxie_Crim_Offender2_Dev_Fields.InValid_clean_errors((SALT33.StrType)le.clean_errors);
    SELF.fcra_date_Invalid := Moxie_Crim_Offender2_Dev_Fields.InValid_fcra_date((SALT33.StrType)le.fcra_date);
    SELF.offender_persistent_id_Invalid := Moxie_Crim_Offender2_Dev_Fields.InValid_offender_persistent_id((SALT33.StrType)le.offender_persistent_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Moxie_Crim_Offender2_Dev_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.file_date_Invalid << 1 ) + ( le.offender_key_Invalid << 2 ) + ( le.case_date_Invalid << 3 ) + ( le.dob_Invalid << 4 ) + ( le.clean_errors_Invalid << 5 ) + ( le.fcra_date_Invalid << 6 ) + ( le.offender_persistent_id_Invalid << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Moxie_Crim_Offender2_Dev_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.offender_key_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.case_date_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.clean_errors_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.fcra_date_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.offender_persistent_id_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.vendor;
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    file_date_CUSTOM_ErrorCount := COUNT(GROUP,h.file_date_Invalid=1);
    offender_key_LENGTH_ErrorCount := COUNT(GROUP,h.offender_key_Invalid=1);
    case_date_CUSTOM_ErrorCount := COUNT(GROUP,h.case_date_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    clean_errors_ALLOW_ErrorCount := COUNT(GROUP,h.clean_errors_Invalid=1);
    fcra_date_CUSTOM_ErrorCount := COUNT(GROUP,h.fcra_date_Invalid=1);
    offender_persistent_id_ALLOW_ErrorCount := COUNT(GROUP,h.offender_persistent_id_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,vendor,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.vendor;
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.file_date_Invalid,le.offender_key_Invalid,le.case_date_Invalid,le.dob_Invalid,le.clean_errors_Invalid,le.fcra_date_Invalid,le.offender_persistent_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_process_date(le.process_date_Invalid),Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_file_date(le.file_date_Invalid),Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_offender_key(le.offender_key_Invalid),Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_case_date(le.case_date_Invalid),Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_dob(le.dob_Invalid),Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_clean_errors(le.clean_errors_Invalid),Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_fcra_date(le.fcra_date_Invalid),Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_offender_persistent_id(le.offender_persistent_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.offender_key_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.case_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_errors_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fcra_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.offender_persistent_id_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','file_date','offender_key','case_date','dob','clean_errors','fcra_date','offender_persistent_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Current_Date','Invalid_Current_Date','Non_Blank','Invalid_Current_Date','Invalid_Current_DOB','Invalid_Num','Invalid_Current_Date','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.process_date,(SALT33.StrType)le.file_date,(SALT33.StrType)le.offender_key,(SALT33.StrType)le.case_date,(SALT33.StrType)le.dob,(SALT33.StrType)le.clean_errors,(SALT33.StrType)le.fcra_date,(SALT33.StrType)le.offender_persistent_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:Invalid_Current_Date:CUSTOM'
          ,'file_date:Invalid_Current_Date:CUSTOM'
          ,'offender_key:Non_Blank:LENGTH'
          ,'case_date:Invalid_Current_Date:CUSTOM'
          ,'dob:Invalid_Current_DOB:CUSTOM'
          ,'clean_errors:Invalid_Num:ALLOW'
          ,'fcra_date:Invalid_Current_Date:CUSTOM'
          ,'offender_persistent_id:Invalid_Num:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_process_date(1)
          ,Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_file_date(1)
          ,Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_offender_key(1)
          ,Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_case_date(1)
          ,Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_dob(1)
          ,Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_clean_errors(1)
          ,Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_fcra_date(1)
          ,Moxie_Crim_Offender2_Dev_Fields.InvalidMessage_offender_persistent_id(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.file_date_CUSTOM_ErrorCount
          ,le.offender_key_LENGTH_ErrorCount
          ,le.case_date_CUSTOM_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.clean_errors_ALLOW_ErrorCount
          ,le.fcra_date_CUSTOM_ErrorCount
          ,le.offender_persistent_id_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.file_date_CUSTOM_ErrorCount
          ,le.offender_key_LENGTH_ErrorCount
          ,le.case_date_CUSTOM_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.clean_errors_ALLOW_ErrorCount
          ,le.fcra_date_CUSTOM_ErrorCount
          ,le.offender_persistent_id_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,8,Into(LEFT,COUNTER));
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
