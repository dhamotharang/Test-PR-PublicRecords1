IMPORT SALT39,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT DeactMain2_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 18;
  EXPORT NumRulesFromFieldType := 18;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 18;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(DeactMain2_Layout_Phonesinfo)
    UNSIGNED1 groupid_Invalid;
    UNSIGNED1 vendor_first_reported_dt_Invalid;
    UNSIGNED1 vendor_last_reported_dt_Invalid;
    UNSIGNED1 timestamp_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone_swap_Invalid;
    UNSIGNED1 filedate_Invalid;
    UNSIGNED1 swap_start_dt_Invalid;
    UNSIGNED1 swap_end_dt_Invalid;
    UNSIGNED1 deact_code_Invalid;
    UNSIGNED1 deact_start_dt_Invalid;
    UNSIGNED1 deact_end_dt_Invalid;
    UNSIGNED1 react_start_dt_Invalid;
    UNSIGNED1 react_end_dt_Invalid;
    UNSIGNED1 is_react_Invalid;
    UNSIGNED1 is_deact_Invalid;
    UNSIGNED1 porting_dt_Invalid;
    UNSIGNED1 days_apart_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(DeactMain2_Layout_Phonesinfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(DeactMain2_Layout_Phonesinfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.groupid_Invalid := DeactMain2_Fields.InValid_groupid((SALT39.StrType)le.groupid);
    SELF.vendor_first_reported_dt_Invalid := DeactMain2_Fields.InValid_vendor_first_reported_dt((SALT39.StrType)le.vendor_first_reported_dt);
    SELF.vendor_last_reported_dt_Invalid := DeactMain2_Fields.InValid_vendor_last_reported_dt((SALT39.StrType)le.vendor_last_reported_dt);
    SELF.timestamp_Invalid := DeactMain2_Fields.InValid_timestamp((SALT39.StrType)le.timestamp);
    SELF.phone_Invalid := DeactMain2_Fields.InValid_phone((SALT39.StrType)le.phone);
    SELF.phone_swap_Invalid := DeactMain2_Fields.InValid_phone_swap((SALT39.StrType)le.phone_swap);
    SELF.filedate_Invalid := DeactMain2_Fields.InValid_filedate((SALT39.StrType)le.filedate);
    SELF.swap_start_dt_Invalid := DeactMain2_Fields.InValid_swap_start_dt((SALT39.StrType)le.swap_start_dt);
    SELF.swap_end_dt_Invalid := DeactMain2_Fields.InValid_swap_end_dt((SALT39.StrType)le.swap_end_dt);
    SELF.deact_code_Invalid := DeactMain2_Fields.InValid_deact_code((SALT39.StrType)le.deact_code);
    SELF.deact_start_dt_Invalid := DeactMain2_Fields.InValid_deact_start_dt((SALT39.StrType)le.deact_start_dt);
    SELF.deact_end_dt_Invalid := DeactMain2_Fields.InValid_deact_end_dt((SALT39.StrType)le.deact_end_dt);
    SELF.react_start_dt_Invalid := DeactMain2_Fields.InValid_react_start_dt((SALT39.StrType)le.react_start_dt);
    SELF.react_end_dt_Invalid := DeactMain2_Fields.InValid_react_end_dt((SALT39.StrType)le.react_end_dt);
    SELF.is_react_Invalid := DeactMain2_Fields.InValid_is_react((SALT39.StrType)le.is_react);
    SELF.is_deact_Invalid := DeactMain2_Fields.InValid_is_deact((SALT39.StrType)le.is_deact);
    SELF.porting_dt_Invalid := DeactMain2_Fields.InValid_porting_dt((SALT39.StrType)le.porting_dt);
    SELF.days_apart_Invalid := DeactMain2_Fields.InValid_days_apart((SALT39.StrType)le.days_apart);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),DeactMain2_Layout_Phonesinfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.groupid_Invalid << 0 ) + ( le.vendor_first_reported_dt_Invalid << 1 ) + ( le.vendor_last_reported_dt_Invalid << 2 ) + ( le.timestamp_Invalid << 3 ) + ( le.phone_Invalid << 4 ) + ( le.phone_swap_Invalid << 5 ) + ( le.filedate_Invalid << 6 ) + ( le.swap_start_dt_Invalid << 7 ) + ( le.swap_end_dt_Invalid << 8 ) + ( le.deact_code_Invalid << 9 ) + ( le.deact_start_dt_Invalid << 10 ) + ( le.deact_end_dt_Invalid << 11 ) + ( le.react_start_dt_Invalid << 12 ) + ( le.react_end_dt_Invalid << 13 ) + ( le.is_react_Invalid << 14 ) + ( le.is_deact_Invalid << 15 ) + ( le.porting_dt_Invalid << 16 ) + ( le.days_apart_Invalid << 17 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,DeactMain2_Layout_Phonesinfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.groupid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.vendor_first_reported_dt_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.vendor_last_reported_dt_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.timestamp_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.phone_swap_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.filedate_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.swap_start_dt_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.swap_end_dt_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.deact_code_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.deact_start_dt_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.deact_end_dt_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.react_start_dt_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.react_end_dt_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.is_react_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.is_deact_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.porting_dt_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.days_apart_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    groupid_ALLOW_ErrorCount := COUNT(GROUP,h.groupid_Invalid=1);
    vendor_first_reported_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.vendor_first_reported_dt_Invalid=1);
    vendor_last_reported_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.vendor_last_reported_dt_Invalid=1);
    timestamp_CUSTOM_ErrorCount := COUNT(GROUP,h.timestamp_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_swap_ALLOW_ErrorCount := COUNT(GROUP,h.phone_swap_Invalid=1);
    filedate_CUSTOM_ErrorCount := COUNT(GROUP,h.filedate_Invalid=1);
    swap_start_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.swap_start_dt_Invalid=1);
    swap_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.swap_end_dt_Invalid=1);
    deact_code_ENUM_ErrorCount := COUNT(GROUP,h.deact_code_Invalid=1);
    deact_start_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.deact_start_dt_Invalid=1);
    deact_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.deact_end_dt_Invalid=1);
    react_start_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.react_start_dt_Invalid=1);
    react_end_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.react_end_dt_Invalid=1);
    is_react_ENUM_ErrorCount := COUNT(GROUP,h.is_react_Invalid=1);
    is_deact_ENUM_ErrorCount := COUNT(GROUP,h.is_deact_Invalid=1);
    porting_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.porting_dt_Invalid=1);
    days_apart_ALLOW_ErrorCount := COUNT(GROUP,h.days_apart_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.groupid_Invalid > 0 OR h.vendor_first_reported_dt_Invalid > 0 OR h.vendor_last_reported_dt_Invalid > 0 OR h.timestamp_Invalid > 0 OR h.phone_Invalid > 0 OR h.phone_swap_Invalid > 0 OR h.filedate_Invalid > 0 OR h.swap_start_dt_Invalid > 0 OR h.swap_end_dt_Invalid > 0 OR h.deact_code_Invalid > 0 OR h.deact_start_dt_Invalid > 0 OR h.deact_end_dt_Invalid > 0 OR h.react_start_dt_Invalid > 0 OR h.react_end_dt_Invalid > 0 OR h.is_react_Invalid > 0 OR h.is_deact_Invalid > 0 OR h.porting_dt_Invalid > 0 OR h.days_apart_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.groupid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_first_reported_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.timestamp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_swap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.swap_start_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.swap_end_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deact_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.deact_start_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deact_end_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.react_start_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.react_end_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.is_react_ENUM_ErrorCount > 0, 1, 0) + IF(le.is_deact_ENUM_ErrorCount > 0, 1, 0) + IF(le.porting_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.days_apart_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.groupid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_first_reported_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.timestamp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_swap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.swap_start_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.swap_end_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deact_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.deact_start_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deact_end_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.react_start_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.react_end_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.is_react_ENUM_ErrorCount > 0, 1, 0) + IF(le.is_deact_ENUM_ErrorCount > 0, 1, 0) + IF(le.porting_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.days_apart_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.groupid_Invalid,le.vendor_first_reported_dt_Invalid,le.vendor_last_reported_dt_Invalid,le.timestamp_Invalid,le.phone_Invalid,le.phone_swap_Invalid,le.filedate_Invalid,le.swap_start_dt_Invalid,le.swap_end_dt_Invalid,le.deact_code_Invalid,le.deact_start_dt_Invalid,le.deact_end_dt_Invalid,le.react_start_dt_Invalid,le.react_end_dt_Invalid,le.is_react_Invalid,le.is_deact_Invalid,le.porting_dt_Invalid,le.days_apart_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,DeactMain2_Fields.InvalidMessage_groupid(le.groupid_Invalid),DeactMain2_Fields.InvalidMessage_vendor_first_reported_dt(le.vendor_first_reported_dt_Invalid),DeactMain2_Fields.InvalidMessage_vendor_last_reported_dt(le.vendor_last_reported_dt_Invalid),DeactMain2_Fields.InvalidMessage_timestamp(le.timestamp_Invalid),DeactMain2_Fields.InvalidMessage_phone(le.phone_Invalid),DeactMain2_Fields.InvalidMessage_phone_swap(le.phone_swap_Invalid),DeactMain2_Fields.InvalidMessage_filedate(le.filedate_Invalid),DeactMain2_Fields.InvalidMessage_swap_start_dt(le.swap_start_dt_Invalid),DeactMain2_Fields.InvalidMessage_swap_end_dt(le.swap_end_dt_Invalid),DeactMain2_Fields.InvalidMessage_deact_code(le.deact_code_Invalid),DeactMain2_Fields.InvalidMessage_deact_start_dt(le.deact_start_dt_Invalid),DeactMain2_Fields.InvalidMessage_deact_end_dt(le.deact_end_dt_Invalid),DeactMain2_Fields.InvalidMessage_react_start_dt(le.react_start_dt_Invalid),DeactMain2_Fields.InvalidMessage_react_end_dt(le.react_end_dt_Invalid),DeactMain2_Fields.InvalidMessage_is_react(le.is_react_Invalid),DeactMain2_Fields.InvalidMessage_is_deact(le.is_deact_Invalid),DeactMain2_Fields.InvalidMessage_porting_dt(le.porting_dt_Invalid),DeactMain2_Fields.InvalidMessage_days_apart(le.days_apart_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.groupid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_first_reported_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.timestamp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_swap_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.swap_start_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.swap_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deact_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.deact_start_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deact_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.react_start_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.react_end_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.is_react_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.is_deact_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.porting_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.days_apart_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'groupid','vendor_first_reported_dt','vendor_last_reported_dt','timestamp','phone','phone_swap','filedate','swap_start_dt','swap_end_dt','deact_code','deact_start_dt','deact_end_dt','react_start_dt','react_end_dt','is_react','is_deact','porting_dt','days_apart','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_DeactCode','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_YN','Invalid_YN','Invalid_Date','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.groupid,(SALT39.StrType)le.vendor_first_reported_dt,(SALT39.StrType)le.vendor_last_reported_dt,(SALT39.StrType)le.timestamp,(SALT39.StrType)le.phone,(SALT39.StrType)le.phone_swap,(SALT39.StrType)le.filedate,(SALT39.StrType)le.swap_start_dt,(SALT39.StrType)le.swap_end_dt,(SALT39.StrType)le.deact_code,(SALT39.StrType)le.deact_start_dt,(SALT39.StrType)le.deact_end_dt,(SALT39.StrType)le.react_start_dt,(SALT39.StrType)le.react_end_dt,(SALT39.StrType)le.is_react,(SALT39.StrType)le.is_deact,(SALT39.StrType)le.porting_dt,(SALT39.StrType)le.days_apart,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,18,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(DeactMain2_Layout_Phonesinfo) prevDS = DATASET([], DeactMain2_Layout_Phonesinfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'groupid:Invalid_Num:ALLOW'
          ,'vendor_first_reported_dt:Invalid_Date:CUSTOM'
          ,'vendor_last_reported_dt:Invalid_Date:CUSTOM'
          ,'timestamp:Invalid_Date:CUSTOM'
          ,'phone:Invalid_Num:ALLOW'
          ,'phone_swap:Invalid_Num:ALLOW'
          ,'filedate:Invalid_Date:CUSTOM'
          ,'swap_start_dt:Invalid_Date:CUSTOM'
          ,'swap_end_dt:Invalid_Date:CUSTOM'
          ,'deact_code:Invalid_DeactCode:ENUM'
          ,'deact_start_dt:Invalid_Date:CUSTOM'
          ,'deact_end_dt:Invalid_Date:CUSTOM'
          ,'react_start_dt:Invalid_Date:CUSTOM'
          ,'react_end_dt:Invalid_Date:CUSTOM'
          ,'is_react:Invalid_YN:ENUM'
          ,'is_deact:Invalid_YN:ENUM'
          ,'porting_dt:Invalid_Date:CUSTOM'
          ,'days_apart:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,DeactMain2_Fields.InvalidMessage_groupid(1)
          ,DeactMain2_Fields.InvalidMessage_vendor_first_reported_dt(1)
          ,DeactMain2_Fields.InvalidMessage_vendor_last_reported_dt(1)
          ,DeactMain2_Fields.InvalidMessage_timestamp(1)
          ,DeactMain2_Fields.InvalidMessage_phone(1)
          ,DeactMain2_Fields.InvalidMessage_phone_swap(1)
          ,DeactMain2_Fields.InvalidMessage_filedate(1)
          ,DeactMain2_Fields.InvalidMessage_swap_start_dt(1)
          ,DeactMain2_Fields.InvalidMessage_swap_end_dt(1)
          ,DeactMain2_Fields.InvalidMessage_deact_code(1)
          ,DeactMain2_Fields.InvalidMessage_deact_start_dt(1)
          ,DeactMain2_Fields.InvalidMessage_deact_end_dt(1)
          ,DeactMain2_Fields.InvalidMessage_react_start_dt(1)
          ,DeactMain2_Fields.InvalidMessage_react_end_dt(1)
          ,DeactMain2_Fields.InvalidMessage_is_react(1)
          ,DeactMain2_Fields.InvalidMessage_is_deact(1)
          ,DeactMain2_Fields.InvalidMessage_porting_dt(1)
          ,DeactMain2_Fields.InvalidMessage_days_apart(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.groupid_ALLOW_ErrorCount
          ,le.vendor_first_reported_dt_CUSTOM_ErrorCount
          ,le.vendor_last_reported_dt_CUSTOM_ErrorCount
          ,le.timestamp_CUSTOM_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.filedate_CUSTOM_ErrorCount
          ,le.swap_start_dt_CUSTOM_ErrorCount
          ,le.swap_end_dt_CUSTOM_ErrorCount
          ,le.deact_code_ENUM_ErrorCount
          ,le.deact_start_dt_CUSTOM_ErrorCount
          ,le.deact_end_dt_CUSTOM_ErrorCount
          ,le.react_start_dt_CUSTOM_ErrorCount
          ,le.react_end_dt_CUSTOM_ErrorCount
          ,le.is_react_ENUM_ErrorCount
          ,le.is_deact_ENUM_ErrorCount
          ,le.porting_dt_CUSTOM_ErrorCount
          ,le.days_apart_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.groupid_ALLOW_ErrorCount
          ,le.vendor_first_reported_dt_CUSTOM_ErrorCount
          ,le.vendor_last_reported_dt_CUSTOM_ErrorCount
          ,le.timestamp_CUSTOM_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.filedate_CUSTOM_ErrorCount
          ,le.swap_start_dt_CUSTOM_ErrorCount
          ,le.swap_end_dt_CUSTOM_ErrorCount
          ,le.deact_code_ENUM_ErrorCount
          ,le.deact_start_dt_CUSTOM_ErrorCount
          ,le.deact_end_dt_CUSTOM_ErrorCount
          ,le.react_start_dt_CUSTOM_ErrorCount
          ,le.react_end_dt_CUSTOM_ErrorCount
          ,le.is_react_ENUM_ErrorCount
          ,le.is_deact_ENUM_ErrorCount
          ,le.porting_dt_CUSTOM_ErrorCount
          ,le.days_apart_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := DeactMain2_hygiene(PROJECT(h, DeactMain2_Layout_Phonesinfo));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'groupid:' + getFieldTypeText(h.groupid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_first_reported_dt:' + getFieldTypeText(h.vendor_first_reported_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_last_reported_dt:' + getFieldTypeText(h.vendor_last_reported_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'action_code:' + getFieldTypeText(h.action_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timestamp:' + getFieldTypeText(h.timestamp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_swap:' + getFieldTypeText(h.phone_swap) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_name:' + getFieldTypeText(h.carrier_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filedate:' + getFieldTypeText(h.filedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'swap_start_dt:' + getFieldTypeText(h.swap_start_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'swap_end_dt:' + getFieldTypeText(h.swap_end_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deact_code:' + getFieldTypeText(h.deact_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deact_start_dt:' + getFieldTypeText(h.deact_start_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deact_end_dt:' + getFieldTypeText(h.deact_end_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'react_start_dt:' + getFieldTypeText(h.react_start_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'react_end_dt:' + getFieldTypeText(h.react_end_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_react:' + getFieldTypeText(h.is_react) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_deact:' + getFieldTypeText(h.is_deact) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'porting_dt:' + getFieldTypeText(h.porting_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pk_carrier_name:' + getFieldTypeText(h.pk_carrier_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'days_apart:' + getFieldTypeText(h.days_apart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_groupid_cnt
          ,le.populated_vendor_first_reported_dt_cnt
          ,le.populated_vendor_last_reported_dt_cnt
          ,le.populated_action_code_cnt
          ,le.populated_timestamp_cnt
          ,le.populated_phone_cnt
          ,le.populated_phone_swap_cnt
          ,le.populated_filename_cnt
          ,le.populated_carrier_name_cnt
          ,le.populated_filedate_cnt
          ,le.populated_swap_start_dt_cnt
          ,le.populated_swap_end_dt_cnt
          ,le.populated_deact_code_cnt
          ,le.populated_deact_start_dt_cnt
          ,le.populated_deact_end_dt_cnt
          ,le.populated_react_start_dt_cnt
          ,le.populated_react_end_dt_cnt
          ,le.populated_is_react_cnt
          ,le.populated_is_deact_cnt
          ,le.populated_porting_dt_cnt
          ,le.populated_pk_carrier_name_cnt
          ,le.populated_days_apart_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_groupid_pcnt
          ,le.populated_vendor_first_reported_dt_pcnt
          ,le.populated_vendor_last_reported_dt_pcnt
          ,le.populated_action_code_pcnt
          ,le.populated_timestamp_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_phone_swap_pcnt
          ,le.populated_filename_pcnt
          ,le.populated_carrier_name_pcnt
          ,le.populated_filedate_pcnt
          ,le.populated_swap_start_dt_pcnt
          ,le.populated_swap_end_dt_pcnt
          ,le.populated_deact_code_pcnt
          ,le.populated_deact_start_dt_pcnt
          ,le.populated_deact_end_dt_pcnt
          ,le.populated_react_start_dt_pcnt
          ,le.populated_react_end_dt_pcnt
          ,le.populated_is_react_pcnt
          ,le.populated_is_deact_pcnt
          ,le.populated_porting_dt_pcnt
          ,le.populated_pk_carrier_name_pcnt
          ,le.populated_days_apart_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,22,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := DeactMain2_Delta(prevDS, PROJECT(h, DeactMain2_Layout_Phonesinfo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),22,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(DeactMain2_Layout_Phonesinfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Phonesinfo, DeactMain2_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
