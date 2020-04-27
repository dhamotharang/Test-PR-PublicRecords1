IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 11;
  EXPORT NumRulesFromFieldType := 11;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 9;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_FirstData)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 filedate_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 action_code_Invalid;
    UNSIGNED1 cons_id_Invalid;
    UNSIGNED1 dl_state_Invalid;
    UNSIGNED1 first_seen_date_true_Invalid;
    UNSIGNED1 last_seen_date_Invalid;
    UNSIGNED1 lex_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_FirstData)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_FirstData) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.filedate_Invalid := Fields.InValid_filedate((SALT311.StrType)le.filedate);
    SELF.record_type_Invalid := Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.action_code_Invalid := Fields.InValid_action_code((SALT311.StrType)le.action_code);
    SELF.cons_id_Invalid := Fields.InValid_cons_id((SALT311.StrType)le.cons_id);
    SELF.dl_state_Invalid := Fields.InValid_dl_state((SALT311.StrType)le.dl_state);
    SELF.first_seen_date_true_Invalid := Fields.InValid_first_seen_date_true((SALT311.StrType)le.first_seen_date_true);
    SELF.last_seen_date_Invalid := Fields.InValid_last_seen_date((SALT311.StrType)le.last_seen_date);
    SELF.lex_id_Invalid := Fields.InValid_lex_id((SALT311.StrType)le.lex_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_FirstData);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.filedate_Invalid << 1 ) + ( le.record_type_Invalid << 2 ) + ( le.action_code_Invalid << 3 ) + ( le.cons_id_Invalid << 4 ) + ( le.dl_state_Invalid << 6 ) + ( le.first_seen_date_true_Invalid << 8 ) + ( le.last_seen_date_Invalid << 9 ) + ( le.lex_id_Invalid << 10 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_FirstData);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.filedate_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.action_code_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.cons_id_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.dl_state_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.first_seen_date_true_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.last_seen_date_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.lex_id_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    filedate_CUSTOM_ErrorCount := COUNT(GROUP,h.filedate_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    action_code_ENUM_ErrorCount := COUNT(GROUP,h.action_code_Invalid=1);
    cons_id_ALLOW_ErrorCount := COUNT(GROUP,h.cons_id_Invalid=1);
    cons_id_LENGTHS_ErrorCount := COUNT(GROUP,h.cons_id_Invalid=2);
    cons_id_Total_ErrorCount := COUNT(GROUP,h.cons_id_Invalid>0);
    dl_state_ALLOW_ErrorCount := COUNT(GROUP,h.dl_state_Invalid=1);
    dl_state_LENGTHS_ErrorCount := COUNT(GROUP,h.dl_state_Invalid=2);
    dl_state_Total_ErrorCount := COUNT(GROUP,h.dl_state_Invalid>0);
    first_seen_date_true_CUSTOM_ErrorCount := COUNT(GROUP,h.first_seen_date_true_Invalid=1);
    last_seen_date_CUSTOM_ErrorCount := COUNT(GROUP,h.last_seen_date_Invalid=1);
    lex_id_ALLOW_ErrorCount := COUNT(GROUP,h.lex_id_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.filedate_Invalid > 0 OR h.record_type_Invalid > 0 OR h.action_code_Invalid > 0 OR h.cons_id_Invalid > 0 OR h.dl_state_Invalid > 0 OR h.first_seen_date_true_Invalid > 0 OR h.last_seen_date_Invalid > 0 OR h.lex_id_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.action_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.cons_id_Total_ErrorCount > 0, 1, 0) + IF(le.dl_state_Total_ErrorCount > 0, 1, 0) + IF(le.first_seen_date_true_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_seen_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lex_id_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.action_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.cons_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cons_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dl_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dl_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.first_seen_date_true_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_seen_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lex_id_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.filedate_Invalid,le.record_type_Invalid,le.action_code_Invalid,le.cons_id_Invalid,le.dl_state_Invalid,le.first_seen_date_true_Invalid,le.last_seen_date_Invalid,le.lex_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_filedate(le.filedate_Invalid),Fields.InvalidMessage_record_type(le.record_type_Invalid),Fields.InvalidMessage_action_code(le.action_code_Invalid),Fields.InvalidMessage_cons_id(le.cons_id_Invalid),Fields.InvalidMessage_dl_state(le.dl_state_Invalid),Fields.InvalidMessage_first_seen_date_true(le.first_seen_date_true_Invalid),Fields.InvalidMessage_last_seen_date(le.last_seen_date_Invalid),Fields.InvalidMessage_lex_id(le.lex_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.action_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.cons_id_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dl_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.first_seen_date_true_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_seen_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lex_id_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','filedate','record_type','action_code','cons_id','dl_state','first_seen_date_true','last_seen_date','lex_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_RecordType','Invalid_ActionType','Invalid_ConsID','Invalid_State','Invalid_Date','Invalid_Date','Invalid_LexID','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.process_date,(SALT311.StrType)le.filedate,(SALT311.StrType)le.record_type,(SALT311.StrType)le.action_code,(SALT311.StrType)le.cons_id,(SALT311.StrType)le.dl_state,(SALT311.StrType)le.first_seen_date_true,(SALT311.StrType)le.last_seen_date,(SALT311.StrType)le.lex_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,9,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_FirstData) prevDS = DATASET([], Layout_FirstData), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:Invalid_Date:CUSTOM'
          ,'filedate:Invalid_Date:CUSTOM'
          ,'record_type:Invalid_RecordType:ENUM'
          ,'action_code:Invalid_ActionType:ENUM'
          ,'cons_id:Invalid_ConsID:ALLOW','cons_id:Invalid_ConsID:LENGTHS'
          ,'dl_state:Invalid_State:ALLOW','dl_state:Invalid_State:LENGTHS'
          ,'first_seen_date_true:Invalid_Date:CUSTOM'
          ,'last_seen_date:Invalid_Date:CUSTOM'
          ,'lex_id:Invalid_LexID:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1)
          ,Fields.InvalidMessage_filedate(1)
          ,Fields.InvalidMessage_record_type(1)
          ,Fields.InvalidMessage_action_code(1)
          ,Fields.InvalidMessage_cons_id(1),Fields.InvalidMessage_cons_id(2)
          ,Fields.InvalidMessage_dl_state(1),Fields.InvalidMessage_dl_state(2)
          ,Fields.InvalidMessage_first_seen_date_true(1)
          ,Fields.InvalidMessage_last_seen_date(1)
          ,Fields.InvalidMessage_lex_id(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.filedate_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.action_code_ENUM_ErrorCount
          ,le.cons_id_ALLOW_ErrorCount,le.cons_id_LENGTHS_ErrorCount
          ,le.dl_state_ALLOW_ErrorCount,le.dl_state_LENGTHS_ErrorCount
          ,le.first_seen_date_true_CUSTOM_ErrorCount
          ,le.last_seen_date_CUSTOM_ErrorCount
          ,le.lex_id_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.filedate_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.action_code_ENUM_ErrorCount
          ,le.cons_id_ALLOW_ErrorCount,le.cons_id_LENGTHS_ErrorCount
          ,le.dl_state_ALLOW_ErrorCount,le.dl_state_LENGTHS_ErrorCount
          ,le.first_seen_date_true_CUSTOM_ErrorCount
          ,le.last_seen_date_CUSTOM_ErrorCount
          ,le.lex_id_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_FirstData));
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
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filedate:' + getFieldTypeText(h.filedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'action_code:' + getFieldTypeText(h.action_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cons_id:' + getFieldTypeText(h.cons_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl_state:' + getFieldTypeText(h.dl_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl_id:' + getFieldTypeText(h.dl_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_seen_date_true:' + getFieldTypeText(h.first_seen_date_true) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_seen_date:' + getFieldTypeText(h.last_seen_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dispute_status:' + getFieldTypeText(h.dispute_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lex_id:' + getFieldTypeText(h.lex_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_process_date_cnt
          ,le.populated_filedate_cnt
          ,le.populated_record_type_cnt
          ,le.populated_action_code_cnt
          ,le.populated_cons_id_cnt
          ,le.populated_dl_state_cnt
          ,le.populated_dl_id_cnt
          ,le.populated_first_seen_date_true_cnt
          ,le.populated_last_seen_date_cnt
          ,le.populated_dispute_status_cnt
          ,le.populated_lex_id_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_process_date_pcnt
          ,le.populated_filedate_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_action_code_pcnt
          ,le.populated_cons_id_pcnt
          ,le.populated_dl_state_pcnt
          ,le.populated_dl_id_pcnt
          ,le.populated_first_seen_date_true_pcnt
          ,le.populated_last_seen_date_pcnt
          ,le.populated_dispute_status_pcnt
          ,le.populated_lex_id_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,11,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_FirstData));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),11,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_FirstData) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FirstData, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
