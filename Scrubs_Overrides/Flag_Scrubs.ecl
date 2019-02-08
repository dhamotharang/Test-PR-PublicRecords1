IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Flag_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 16;
  EXPORT NumRulesFromFieldType := 16;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 12;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Flag_Layout_Overrides)
    UNSIGNED1 flag_file_id_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 file_id_Invalid;
    UNSIGNED1 override_flag_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 riskwise_uid_Invalid;
    UNSIGNED1 date_added_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Flag_Layout_Overrides)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Flag_Layout_Overrides) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.flag_file_id_Invalid := Flag_Fields.InValid_flag_file_id((SALT311.StrType)le.flag_file_id);
    SELF.did_Invalid := Flag_Fields.InValid_did((SALT311.StrType)le.did);
    SELF.file_id_Invalid := Flag_Fields.InValid_file_id((SALT311.StrType)le.file_id);
    SELF.override_flag_Invalid := Flag_Fields.InValid_override_flag((SALT311.StrType)le.override_flag);
    SELF.fname_Invalid := Flag_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := Flag_Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := Flag_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.name_suffix_Invalid := Flag_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.ssn_Invalid := Flag_Fields.InValid_ssn((SALT311.StrType)le.ssn);
    SELF.dob_Invalid := Flag_Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.riskwise_uid_Invalid := Flag_Fields.InValid_riskwise_uid((SALT311.StrType)le.riskwise_uid);
    SELF.date_added_Invalid := Flag_Fields.InValid_date_added((SALT311.StrType)le.date_added);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Flag_Layout_Overrides);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.flag_file_id_Invalid << 0 ) + ( le.did_Invalid << 2 ) + ( le.file_id_Invalid << 3 ) + ( le.override_flag_Invalid << 5 ) + ( le.fname_Invalid << 6 ) + ( le.mname_Invalid << 7 ) + ( le.lname_Invalid << 8 ) + ( le.name_suffix_Invalid << 9 ) + ( le.ssn_Invalid << 10 ) + ( le.dob_Invalid << 12 ) + ( le.riskwise_uid_Invalid << 14 ) + ( le.date_added_Invalid << 15 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Flag_Layout_Overrides);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.flag_file_id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.did_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.file_id_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.override_flag_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.riskwise_uid_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.date_added_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    flag_file_id_ALLOW_ErrorCount := COUNT(GROUP,h.flag_file_id_Invalid=1);
    flag_file_id_LENGTHS_ErrorCount := COUNT(GROUP,h.flag_file_id_Invalid=2);
    flag_file_id_Total_ErrorCount := COUNT(GROUP,h.flag_file_id_Invalid>0);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    file_id_ALLOW_ErrorCount := COUNT(GROUP,h.file_id_Invalid=1);
    file_id_LENGTHS_ErrorCount := COUNT(GROUP,h.file_id_Invalid=2);
    file_id_Total_ErrorCount := COUNT(GROUP,h.file_id_Invalid>0);
    override_flag_ENUM_ErrorCount := COUNT(GROUP,h.override_flag_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTHS_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    riskwise_uid_ALLOW_ErrorCount := COUNT(GROUP,h.riskwise_uid_Invalid=1);
    date_added_CUSTOM_ErrorCount := COUNT(GROUP,h.date_added_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.flag_file_id_Invalid > 0 OR h.did_Invalid > 0 OR h.file_id_Invalid > 0 OR h.override_flag_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.ssn_Invalid > 0 OR h.dob_Invalid > 0 OR h.riskwise_uid_Invalid > 0 OR h.date_added_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.flag_file_id_Total_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_id_Total_ErrorCount > 0, 1, 0) + IF(le.override_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_Total_ErrorCount > 0, 1, 0) + IF(le.dob_Total_ErrorCount > 0, 1, 0) + IF(le.riskwise_uid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.flag_file_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flag_file_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.override_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.riskwise_uid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.flag_file_id_Invalid,le.did_Invalid,le.file_id_Invalid,le.override_flag_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.ssn_Invalid,le.dob_Invalid,le.riskwise_uid_Invalid,le.date_added_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Flag_Fields.InvalidMessage_flag_file_id(le.flag_file_id_Invalid),Flag_Fields.InvalidMessage_did(le.did_Invalid),Flag_Fields.InvalidMessage_file_id(le.file_id_Invalid),Flag_Fields.InvalidMessage_override_flag(le.override_flag_Invalid),Flag_Fields.InvalidMessage_fname(le.fname_Invalid),Flag_Fields.InvalidMessage_mname(le.mname_Invalid),Flag_Fields.InvalidMessage_lname(le.lname_Invalid),Flag_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Flag_Fields.InvalidMessage_ssn(le.ssn_Invalid),Flag_Fields.InvalidMessage_dob(le.dob_Invalid),Flag_Fields.InvalidMessage_riskwise_uid(le.riskwise_uid_Invalid),Flag_Fields.InvalidMessage_date_added(le.date_added_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.flag_file_id_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.file_id_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.override_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.riskwise_uid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_added_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'flag_file_id','did','file_id','override_flag','fname','mname','lname','name_suffix','ssn','dob','riskwise_uid','date_added','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_FlagID','Invalid_Num','Invalid_Letters','Invalid_OverrideFlag','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_SSN','Invalid_DOB','Invalid_Num','Invalid_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.flag_file_id,(SALT311.StrType)le.did,(SALT311.StrType)le.file_id,(SALT311.StrType)le.override_flag,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.ssn,(SALT311.StrType)le.dob,(SALT311.StrType)le.riskwise_uid,(SALT311.StrType)le.date_added,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,12,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Flag_Layout_Overrides) prevDS = DATASET([], Flag_Layout_Overrides), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'flag_file_id:Invalid_FlagID:ALLOW','flag_file_id:Invalid_FlagID:LENGTHS'
          ,'did:Invalid_Num:ALLOW'
          ,'file_id:Invalid_Letters:ALLOW','file_id:Invalid_Letters:LENGTHS'
          ,'override_flag:Invalid_OverrideFlag:ENUM'
          ,'fname:Invalid_Char:ALLOW'
          ,'mname:Invalid_Char:ALLOW'
          ,'lname:Invalid_Char:ALLOW'
          ,'name_suffix:Invalid_Char:ALLOW'
          ,'ssn:Invalid_SSN:ALLOW','ssn:Invalid_SSN:LENGTHS'
          ,'dob:Invalid_DOB:ALLOW','dob:Invalid_DOB:LENGTHS'
          ,'riskwise_uid:Invalid_Num:ALLOW'
          ,'date_added:Invalid_Date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Flag_Fields.InvalidMessage_flag_file_id(1),Flag_Fields.InvalidMessage_flag_file_id(2)
          ,Flag_Fields.InvalidMessage_did(1)
          ,Flag_Fields.InvalidMessage_file_id(1),Flag_Fields.InvalidMessage_file_id(2)
          ,Flag_Fields.InvalidMessage_override_flag(1)
          ,Flag_Fields.InvalidMessage_fname(1)
          ,Flag_Fields.InvalidMessage_mname(1)
          ,Flag_Fields.InvalidMessage_lname(1)
          ,Flag_Fields.InvalidMessage_name_suffix(1)
          ,Flag_Fields.InvalidMessage_ssn(1),Flag_Fields.InvalidMessage_ssn(2)
          ,Flag_Fields.InvalidMessage_dob(1),Flag_Fields.InvalidMessage_dob(2)
          ,Flag_Fields.InvalidMessage_riskwise_uid(1)
          ,Flag_Fields.InvalidMessage_date_added(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.flag_file_id_ALLOW_ErrorCount,le.flag_file_id_LENGTHS_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.file_id_ALLOW_ErrorCount,le.file_id_LENGTHS_ErrorCount
          ,le.override_flag_ENUM_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTHS_ErrorCount
          ,le.riskwise_uid_ALLOW_ErrorCount
          ,le.date_added_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.flag_file_id_ALLOW_ErrorCount,le.flag_file_id_LENGTHS_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.file_id_ALLOW_ErrorCount,le.file_id_LENGTHS_ErrorCount
          ,le.override_flag_ENUM_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTHS_ErrorCount
          ,le.riskwise_uid_ALLOW_ErrorCount
          ,le.date_added_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Flag_hygiene(PROJECT(h, Flag_Layout_Overrides));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'flag_file_id:' + getFieldTypeText(h.flag_file_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_id:' + getFieldTypeText(h.file_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_id:' + getFieldTypeText(h.record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'override_flag:' + getFieldTypeText(h.override_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'in_dispute_flag:' + getFieldTypeText(h.in_dispute_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'consumer_statement_flag:' + getFieldTypeText(h.consumer_statement_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'riskwise_uid:' + getFieldTypeText(h.riskwise_uid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'user_added:' + getFieldTypeText(h.user_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_added:' + getFieldTypeText(h.date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'known_missing:' + getFieldTypeText(h.known_missing) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'user_changed:' + getFieldTypeText(h.user_changed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_changed:' + getFieldTypeText(h.date_changed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lf:' + getFieldTypeText(h.lf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_flag_file_id_cnt
          ,le.populated_did_cnt
          ,le.populated_file_id_cnt
          ,le.populated_record_id_cnt
          ,le.populated_override_flag_cnt
          ,le.populated_in_dispute_flag_cnt
          ,le.populated_consumer_statement_flag_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_ssn_cnt
          ,le.populated_dob_cnt
          ,le.populated_riskwise_uid_cnt
          ,le.populated_user_added_cnt
          ,le.populated_date_added_cnt
          ,le.populated_known_missing_cnt
          ,le.populated_user_changed_cnt
          ,le.populated_date_changed_cnt
          ,le.populated_lf_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_flag_file_id_pcnt
          ,le.populated_did_pcnt
          ,le.populated_file_id_pcnt
          ,le.populated_record_id_pcnt
          ,le.populated_override_flag_pcnt
          ,le.populated_in_dispute_flag_pcnt
          ,le.populated_consumer_statement_flag_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_riskwise_uid_pcnt
          ,le.populated_user_added_pcnt
          ,le.populated_date_added_pcnt
          ,le.populated_known_missing_pcnt
          ,le.populated_user_changed_pcnt
          ,le.populated_date_changed_pcnt
          ,le.populated_lf_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,20,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Flag_Delta(prevDS, PROJECT(h, Flag_Layout_Overrides));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),20,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Flag_Layout_Overrides) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Overrides, Flag_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
