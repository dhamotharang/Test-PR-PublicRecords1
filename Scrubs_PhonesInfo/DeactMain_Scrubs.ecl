IMPORT SALT38,STD;
EXPORT DeactMain_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 19;
  EXPORT NumRulesFromFieldType := 19;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 18;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(DeactMain_Layout_PhonesInfo)
    UNSIGNED1 vendor_first_reported_dt_Invalid;
    UNSIGNED1 vendor_last_reported_dt_Invalid;
    UNSIGNED1 action_code_Invalid;
    UNSIGNED1 timestamp_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone_swap_Invalid;
    UNSIGNED1 filename_Invalid;
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
  END;
  EXPORT  Bitmap_Layout := RECORD(DeactMain_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(DeactMain_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.vendor_first_reported_dt_Invalid := DeactMain_Fields.InValid_vendor_first_reported_dt((SALT38.StrType)le.vendor_first_reported_dt);
    SELF.vendor_last_reported_dt_Invalid := DeactMain_Fields.InValid_vendor_last_reported_dt((SALT38.StrType)le.vendor_last_reported_dt);
    SELF.action_code_Invalid := DeactMain_Fields.InValid_action_code((SALT38.StrType)le.action_code);
    SELF.timestamp_Invalid := DeactMain_Fields.InValid_timestamp((SALT38.StrType)le.timestamp);
    SELF.phone_Invalid := DeactMain_Fields.InValid_phone((SALT38.StrType)le.phone);
    SELF.phone_swap_Invalid := DeactMain_Fields.InValid_phone_swap((SALT38.StrType)le.phone_swap);
    SELF.filename_Invalid := DeactMain_Fields.InValid_filename((SALT38.StrType)le.filename);
    SELF.filedate_Invalid := DeactMain_Fields.InValid_filedate((SALT38.StrType)le.filedate);
    SELF.swap_start_dt_Invalid := DeactMain_Fields.InValid_swap_start_dt((SALT38.StrType)le.swap_start_dt);
    SELF.swap_end_dt_Invalid := DeactMain_Fields.InValid_swap_end_dt((SALT38.StrType)le.swap_end_dt);
    SELF.deact_code_Invalid := DeactMain_Fields.InValid_deact_code((SALT38.StrType)le.deact_code);
    SELF.deact_start_dt_Invalid := DeactMain_Fields.InValid_deact_start_dt((SALT38.StrType)le.deact_start_dt);
    SELF.deact_end_dt_Invalid := DeactMain_Fields.InValid_deact_end_dt((SALT38.StrType)le.deact_end_dt);
    SELF.react_start_dt_Invalid := DeactMain_Fields.InValid_react_start_dt((SALT38.StrType)le.react_start_dt);
    SELF.react_end_dt_Invalid := DeactMain_Fields.InValid_react_end_dt((SALT38.StrType)le.react_end_dt);
    SELF.is_react_Invalid := DeactMain_Fields.InValid_is_react((SALT38.StrType)le.is_react);
    SELF.is_deact_Invalid := DeactMain_Fields.InValid_is_deact((SALT38.StrType)le.is_deact);
    SELF.porting_dt_Invalid := DeactMain_Fields.InValid_porting_dt((SALT38.StrType)le.porting_dt);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),DeactMain_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.vendor_first_reported_dt_Invalid << 0 ) + ( le.vendor_last_reported_dt_Invalid << 1 ) + ( le.action_code_Invalid << 2 ) + ( le.timestamp_Invalid << 4 ) + ( le.phone_Invalid << 5 ) + ( le.phone_swap_Invalid << 6 ) + ( le.filename_Invalid << 7 ) + ( le.filedate_Invalid << 8 ) + ( le.swap_start_dt_Invalid << 9 ) + ( le.swap_end_dt_Invalid << 10 ) + ( le.deact_code_Invalid << 11 ) + ( le.deact_start_dt_Invalid << 12 ) + ( le.deact_end_dt_Invalid << 13 ) + ( le.react_start_dt_Invalid << 14 ) + ( le.react_end_dt_Invalid << 15 ) + ( le.is_react_Invalid << 16 ) + ( le.is_deact_Invalid << 17 ) + ( le.porting_dt_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,DeactMain_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.vendor_first_reported_dt_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.vendor_last_reported_dt_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.action_code_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.timestamp_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.phone_swap_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.filename_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.filedate_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.swap_start_dt_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.swap_end_dt_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.deact_code_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.deact_start_dt_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.deact_end_dt_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.react_start_dt_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.react_end_dt_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.is_react_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.is_deact_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.porting_dt_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    vendor_first_reported_dt_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_first_reported_dt_Invalid=1);
    vendor_last_reported_dt_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_last_reported_dt_Invalid=1);
    action_code_ENUM_ErrorCount := COUNT(GROUP,h.action_code_Invalid=1);
    action_code_LENGTH_ErrorCount := COUNT(GROUP,h.action_code_Invalid=2);
    action_code_Total_ErrorCount := COUNT(GROUP,h.action_code_Invalid>0);
    timestamp_ALLOW_ErrorCount := COUNT(GROUP,h.timestamp_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_swap_ALLOW_ErrorCount := COUNT(GROUP,h.phone_swap_Invalid=1);
    filename_ALLOW_ErrorCount := COUNT(GROUP,h.filename_Invalid=1);
    filedate_ALLOW_ErrorCount := COUNT(GROUP,h.filedate_Invalid=1);
    swap_start_dt_ALLOW_ErrorCount := COUNT(GROUP,h.swap_start_dt_Invalid=1);
    swap_end_dt_ALLOW_ErrorCount := COUNT(GROUP,h.swap_end_dt_Invalid=1);
    deact_code_ENUM_ErrorCount := COUNT(GROUP,h.deact_code_Invalid=1);
    deact_start_dt_ALLOW_ErrorCount := COUNT(GROUP,h.deact_start_dt_Invalid=1);
    deact_end_dt_ALLOW_ErrorCount := COUNT(GROUP,h.deact_end_dt_Invalid=1);
    react_start_dt_ALLOW_ErrorCount := COUNT(GROUP,h.react_start_dt_Invalid=1);
    react_end_dt_ALLOW_ErrorCount := COUNT(GROUP,h.react_end_dt_Invalid=1);
    is_react_ALLOW_ErrorCount := COUNT(GROUP,h.is_react_Invalid=1);
    is_deact_ALLOW_ErrorCount := COUNT(GROUP,h.is_deact_Invalid=1);
    porting_dt_ALLOW_ErrorCount := COUNT(GROUP,h.porting_dt_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.vendor_first_reported_dt_Invalid > 0 OR h.vendor_last_reported_dt_Invalid > 0 OR h.action_code_Invalid > 0 OR h.timestamp_Invalid > 0 OR h.phone_Invalid > 0 OR h.phone_swap_Invalid > 0 OR h.filename_Invalid > 0 OR h.filedate_Invalid > 0 OR h.swap_start_dt_Invalid > 0 OR h.swap_end_dt_Invalid > 0 OR h.deact_code_Invalid > 0 OR h.deact_start_dt_Invalid > 0 OR h.deact_end_dt_Invalid > 0 OR h.react_start_dt_Invalid > 0 OR h.react_end_dt_Invalid > 0 OR h.is_react_Invalid > 0 OR h.is_deact_Invalid > 0 OR h.porting_dt_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.vendor_first_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.action_code_Total_ErrorCount > 0, 1, 0) + IF(le.timestamp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_swap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filedate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.swap_start_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.swap_end_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deact_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.deact_start_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deact_end_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.react_start_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.react_end_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.is_react_ALLOW_ErrorCount > 0, 1, 0) + IF(le.is_deact_ALLOW_ErrorCount > 0, 1, 0) + IF(le.porting_dt_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.vendor_first_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_last_reported_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.action_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.action_code_LENGTH_ErrorCount > 0, 1, 0) + IF(le.timestamp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_swap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filedate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.swap_start_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.swap_end_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deact_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.deact_start_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deact_end_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.react_start_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.react_end_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.is_react_ALLOW_ErrorCount > 0, 1, 0) + IF(le.is_deact_ALLOW_ErrorCount > 0, 1, 0) + IF(le.porting_dt_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.vendor_first_reported_dt_Invalid,le.vendor_last_reported_dt_Invalid,le.action_code_Invalid,le.timestamp_Invalid,le.phone_Invalid,le.phone_swap_Invalid,le.filename_Invalid,le.filedate_Invalid,le.swap_start_dt_Invalid,le.swap_end_dt_Invalid,le.deact_code_Invalid,le.deact_start_dt_Invalid,le.deact_end_dt_Invalid,le.react_start_dt_Invalid,le.react_end_dt_Invalid,le.is_react_Invalid,le.is_deact_Invalid,le.porting_dt_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,DeactMain_Fields.InvalidMessage_vendor_first_reported_dt(le.vendor_first_reported_dt_Invalid),DeactMain_Fields.InvalidMessage_vendor_last_reported_dt(le.vendor_last_reported_dt_Invalid),DeactMain_Fields.InvalidMessage_action_code(le.action_code_Invalid),DeactMain_Fields.InvalidMessage_timestamp(le.timestamp_Invalid),DeactMain_Fields.InvalidMessage_phone(le.phone_Invalid),DeactMain_Fields.InvalidMessage_phone_swap(le.phone_swap_Invalid),DeactMain_Fields.InvalidMessage_filename(le.filename_Invalid),DeactMain_Fields.InvalidMessage_filedate(le.filedate_Invalid),DeactMain_Fields.InvalidMessage_swap_start_dt(le.swap_start_dt_Invalid),DeactMain_Fields.InvalidMessage_swap_end_dt(le.swap_end_dt_Invalid),DeactMain_Fields.InvalidMessage_deact_code(le.deact_code_Invalid),DeactMain_Fields.InvalidMessage_deact_start_dt(le.deact_start_dt_Invalid),DeactMain_Fields.InvalidMessage_deact_end_dt(le.deact_end_dt_Invalid),DeactMain_Fields.InvalidMessage_react_start_dt(le.react_start_dt_Invalid),DeactMain_Fields.InvalidMessage_react_end_dt(le.react_end_dt_Invalid),DeactMain_Fields.InvalidMessage_is_react(le.is_react_Invalid),DeactMain_Fields.InvalidMessage_is_deact(le.is_deact_Invalid),DeactMain_Fields.InvalidMessage_porting_dt(le.porting_dt_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.vendor_first_reported_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_last_reported_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.action_code_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.timestamp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_swap_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filename_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filedate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.swap_start_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.swap_end_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.deact_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.deact_start_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.deact_end_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.react_start_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.react_end_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.is_react_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.is_deact_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.porting_dt_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'vendor_first_reported_dt','vendor_last_reported_dt','action_code','timestamp','phone','phone_swap','filename','filedate','swap_start_dt','swap_end_dt','deact_code','deact_start_dt','deact_end_dt','react_start_dt','react_end_dt','is_react','is_deact','porting_dt','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Num','Invalid_Action_Code','Invalid_Num','Invalid_Num','Invalid_Num_Blank','Invalid_Filename','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Deact_Code','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_IS','Invalid_IS','Invalid_Num_Blank','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.vendor_first_reported_dt,(SALT38.StrType)le.vendor_last_reported_dt,(SALT38.StrType)le.action_code,(SALT38.StrType)le.timestamp,(SALT38.StrType)le.phone,(SALT38.StrType)le.phone_swap,(SALT38.StrType)le.filename,(SALT38.StrType)le.filedate,(SALT38.StrType)le.swap_start_dt,(SALT38.StrType)le.swap_end_dt,(SALT38.StrType)le.deact_code,(SALT38.StrType)le.deact_start_dt,(SALT38.StrType)le.deact_end_dt,(SALT38.StrType)le.react_start_dt,(SALT38.StrType)le.react_end_dt,(SALT38.StrType)le.is_react,(SALT38.StrType)le.is_deact,(SALT38.StrType)le.porting_dt,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,18,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(DeactMain_Layout_PhonesInfo) prevDS = DATASET([], DeactMain_Layout_PhonesInfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'vendor_first_reported_dt:Invalid_Num:ALLOW'
          ,'vendor_last_reported_dt:Invalid_Num:ALLOW'
          ,'action_code:Invalid_Action_Code:ENUM','action_code:Invalid_Action_Code:LENGTH'
          ,'timestamp:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'phone_swap:Invalid_Num_Blank:ALLOW'
          ,'filename:Invalid_Filename:ALLOW'
          ,'filedate:Invalid_Num:ALLOW'
          ,'swap_start_dt:Invalid_Num:ALLOW'
          ,'swap_end_dt:Invalid_Num:ALLOW'
          ,'deact_code:Invalid_Deact_Code:ENUM'
          ,'deact_start_dt:Invalid_Num:ALLOW'
          ,'deact_end_dt:Invalid_Num:ALLOW'
          ,'react_start_dt:Invalid_Num:ALLOW'
          ,'react_end_dt:Invalid_Num:ALLOW'
          ,'is_react:Invalid_IS:ALLOW'
          ,'is_deact:Invalid_IS:ALLOW'
          ,'porting_dt:Invalid_Num_Blank:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,DeactMain_Fields.InvalidMessage_vendor_first_reported_dt(1)
          ,DeactMain_Fields.InvalidMessage_vendor_last_reported_dt(1)
          ,DeactMain_Fields.InvalidMessage_action_code(1),DeactMain_Fields.InvalidMessage_action_code(2)
          ,DeactMain_Fields.InvalidMessage_timestamp(1)
          ,DeactMain_Fields.InvalidMessage_phone(1)
          ,DeactMain_Fields.InvalidMessage_phone_swap(1)
          ,DeactMain_Fields.InvalidMessage_filename(1)
          ,DeactMain_Fields.InvalidMessage_filedate(1)
          ,DeactMain_Fields.InvalidMessage_swap_start_dt(1)
          ,DeactMain_Fields.InvalidMessage_swap_end_dt(1)
          ,DeactMain_Fields.InvalidMessage_deact_code(1)
          ,DeactMain_Fields.InvalidMessage_deact_start_dt(1)
          ,DeactMain_Fields.InvalidMessage_deact_end_dt(1)
          ,DeactMain_Fields.InvalidMessage_react_start_dt(1)
          ,DeactMain_Fields.InvalidMessage_react_end_dt(1)
          ,DeactMain_Fields.InvalidMessage_is_react(1)
          ,DeactMain_Fields.InvalidMessage_is_deact(1)
          ,DeactMain_Fields.InvalidMessage_porting_dt(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.vendor_first_reported_dt_ALLOW_ErrorCount
          ,le.vendor_last_reported_dt_ALLOW_ErrorCount
          ,le.action_code_ENUM_ErrorCount,le.action_code_LENGTH_ErrorCount
          ,le.timestamp_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount
          ,le.filedate_ALLOW_ErrorCount
          ,le.swap_start_dt_ALLOW_ErrorCount
          ,le.swap_end_dt_ALLOW_ErrorCount
          ,le.deact_code_ENUM_ErrorCount
          ,le.deact_start_dt_ALLOW_ErrorCount
          ,le.deact_end_dt_ALLOW_ErrorCount
          ,le.react_start_dt_ALLOW_ErrorCount
          ,le.react_end_dt_ALLOW_ErrorCount
          ,le.is_react_ALLOW_ErrorCount
          ,le.is_deact_ALLOW_ErrorCount
          ,le.porting_dt_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.vendor_first_reported_dt_ALLOW_ErrorCount
          ,le.vendor_last_reported_dt_ALLOW_ErrorCount
          ,le.action_code_ENUM_ErrorCount,le.action_code_LENGTH_ErrorCount
          ,le.timestamp_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount
          ,le.filedate_ALLOW_ErrorCount
          ,le.swap_start_dt_ALLOW_ErrorCount
          ,le.swap_end_dt_ALLOW_ErrorCount
          ,le.deact_code_ENUM_ErrorCount
          ,le.deact_start_dt_ALLOW_ErrorCount
          ,le.deact_end_dt_ALLOW_ErrorCount
          ,le.react_start_dt_ALLOW_ErrorCount
          ,le.react_end_dt_ALLOW_ErrorCount
          ,le.is_react_ALLOW_ErrorCount
          ,le.is_deact_ALLOW_ErrorCount
          ,le.porting_dt_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);

    // field population stats
    mod_hygiene := DeactMain_hygiene(PROJECT(h, DeactMain_Layout_PhonesInfo));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
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
          ,'porting_dt:' + getFieldTypeText(h.porting_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
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
          ,le.populated_porting_dt_cnt,0);
      SELF.rulepcnt := CHOOSE(c
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
          ,le.populated_porting_dt_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,19,xNormHygieneStats(LEFT,COUNTER,'POP'));

  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));

    mod_Delta := DeactMain_Delta(prevDS, PROJECT(h, DeactMain_Layout_PhonesInfo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),19,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(DeactMain_Layout_PhonesInfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesInfo, DeactMain_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));

  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);

  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));

  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
