IMPORT SALT38,STD;
IMPORT Scrubs_DL_TN_WDL,Scrubs_DL_TN_CONV; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 10;
  EXPORT NumRulesFromFieldType := 10;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_In_TN_WDL)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 dl_number_Invalid;
    UNSIGNED1 action_code_Invalid;
    UNSIGNED1 event_date_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 birthdate_Invalid;
    UNSIGNED1 post_date_Invalid;
    UNSIGNED1 county_code_Invalid;
    UNSIGNED1 action_type_Invalid;
    UNSIGNED1 filler_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_TN_WDL)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_TN_WDL) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT38.StrType)le.process_date);
    SELF.dl_number_Invalid := Fields.InValid_dl_number((SALT38.StrType)le.dl_number);
    SELF.action_code_Invalid := Fields.InValid_action_code((SALT38.StrType)le.action_code);
    SELF.event_date_Invalid := Fields.InValid_event_date((SALT38.StrType)le.event_date);
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT38.StrType)le.last_name);
    SELF.birthdate_Invalid := Fields.InValid_birthdate((SALT38.StrType)le.birthdate);
    SELF.post_date_Invalid := Fields.InValid_post_date((SALT38.StrType)le.post_date);
    SELF.county_code_Invalid := Fields.InValid_county_code((SALT38.StrType)le.county_code);
    SELF.action_type_Invalid := Fields.InValid_action_type((SALT38.StrType)le.action_type);
    SELF.filler_Invalid := Fields.InValid_filler((SALT38.StrType)le.filler);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_TN_WDL);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.dl_number_Invalid << 1 ) + ( le.action_code_Invalid << 2 ) + ( le.event_date_Invalid << 3 ) + ( le.last_name_Invalid << 4 ) + ( le.birthdate_Invalid << 5 ) + ( le.post_date_Invalid << 6 ) + ( le.county_code_Invalid << 7 ) + ( le.action_type_Invalid << 8 ) + ( le.filler_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_TN_WDL);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dl_number_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.action_code_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.event_date_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.birthdate_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.post_date_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.county_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.action_type_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.filler_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    dl_number_CUSTOM_ErrorCount := COUNT(GROUP,h.dl_number_Invalid=1);
    action_code_CUSTOM_ErrorCount := COUNT(GROUP,h.action_code_Invalid=1);
    event_date_CUSTOM_ErrorCount := COUNT(GROUP,h.event_date_Invalid=1);
    last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    birthdate_CUSTOM_ErrorCount := COUNT(GROUP,h.birthdate_Invalid=1);
    post_date_CUSTOM_ErrorCount := COUNT(GROUP,h.post_date_Invalid=1);
    county_code_CUSTOM_ErrorCount := COUNT(GROUP,h.county_code_Invalid=1);
    action_type_CUSTOM_ErrorCount := COUNT(GROUP,h.action_type_Invalid=1);
    filler_CUSTOM_ErrorCount := COUNT(GROUP,h.filler_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.dl_number_Invalid > 0 OR h.action_code_Invalid > 0 OR h.event_date_Invalid > 0 OR h.last_name_Invalid > 0 OR h.birthdate_Invalid > 0 OR h.post_date_Invalid > 0 OR h.county_code_Invalid > 0 OR h.action_type_Invalid > 0 OR h.filler_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dl_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.action_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.event_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.birthdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.post_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.action_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filler_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dl_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.action_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.event_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.birthdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.post_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.action_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filler_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.dl_number_Invalid,le.action_code_Invalid,le.event_date_Invalid,le.last_name_Invalid,le.birthdate_Invalid,le.post_date_Invalid,le.county_code_Invalid,le.action_type_Invalid,le.filler_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_dl_number(le.dl_number_Invalid),Fields.InvalidMessage_action_code(le.action_code_Invalid),Fields.InvalidMessage_event_date(le.event_date_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_birthdate(le.birthdate_Invalid),Fields.InvalidMessage_post_date(le.post_date_Invalid),Fields.InvalidMessage_county_code(le.county_code_Invalid),Fields.InvalidMessage_action_type(le.action_type_Invalid),Fields.InvalidMessage_filler(le.filler_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dl_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.event_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.birthdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.post_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.county_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filler_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','dl_number','action_code','event_date','last_name','birthdate','post_date','county_code','action_type','filler','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_past_date','invalid_dl_nbr','invalid_action_code','invalid_past_date','invalid_lname','invalid_past_date','invalid_past_date','invalid_county_code','invalid_action_type','invalid_filler_data','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.process_date,(SALT38.StrType)le.dl_number,(SALT38.StrType)le.action_code,(SALT38.StrType)le.event_date,(SALT38.StrType)le.last_name,(SALT38.StrType)le.birthdate,(SALT38.StrType)le.post_date,(SALT38.StrType)le.county_code,(SALT38.StrType)le.action_type,(SALT38.StrType)le.filler,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_In_TN_WDL) prevDS = DATASET([], Layout_In_TN_WDL), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_past_date:CUSTOM'
          ,'dl_number:invalid_dl_nbr:CUSTOM'
          ,'action_code:invalid_action_code:CUSTOM'
          ,'event_date:invalid_past_date:CUSTOM'
          ,'last_name:invalid_lname:CUSTOM'
          ,'birthdate:invalid_past_date:CUSTOM'
          ,'post_date:invalid_past_date:CUSTOM'
          ,'county_code:invalid_county_code:CUSTOM'
          ,'action_type:invalid_action_type:CUSTOM'
          ,'filler:invalid_filler_data:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1)
          ,Fields.InvalidMessage_dl_number(1)
          ,Fields.InvalidMessage_action_code(1)
          ,Fields.InvalidMessage_event_date(1)
          ,Fields.InvalidMessage_last_name(1)
          ,Fields.InvalidMessage_birthdate(1)
          ,Fields.InvalidMessage_post_date(1)
          ,Fields.InvalidMessage_county_code(1)
          ,Fields.InvalidMessage_action_type(1)
          ,Fields.InvalidMessage_filler(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.dl_number_CUSTOM_ErrorCount
          ,le.action_code_CUSTOM_ErrorCount
          ,le.event_date_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.birthdate_CUSTOM_ErrorCount
          ,le.post_date_CUSTOM_ErrorCount
          ,le.county_code_CUSTOM_ErrorCount
          ,le.action_type_CUSTOM_ErrorCount
          ,le.filler_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.dl_number_CUSTOM_ErrorCount
          ,le.action_code_CUSTOM_ErrorCount
          ,le.event_date_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.birthdate_CUSTOM_ErrorCount
          ,le.post_date_CUSTOM_ErrorCount
          ,le.county_code_CUSTOM_ErrorCount
          ,le.action_type_CUSTOM_ErrorCount
          ,le.filler_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_In_TN_WDL));
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
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dl_number:' + getFieldTypeText(h.dl_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'action_code:' + getFieldTypeText(h.action_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'event_date:' + getFieldTypeText(h.event_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'birthdate:' + getFieldTypeText(h.birthdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'post_date:' + getFieldTypeText(h.post_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_code:' + getFieldTypeText(h.county_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'action_type:' + getFieldTypeText(h.action_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler:' + getFieldTypeText(h.filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_process_date_cnt
          ,le.populated_dl_number_cnt
          ,le.populated_action_code_cnt
          ,le.populated_event_date_cnt
          ,le.populated_last_name_cnt
          ,le.populated_birthdate_cnt
          ,le.populated_post_date_cnt
          ,le.populated_county_code_cnt
          ,le.populated_action_type_cnt
          ,le.populated_filler_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_process_date_pcnt
          ,le.populated_dl_number_pcnt
          ,le.populated_action_code_pcnt
          ,le.populated_event_date_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_birthdate_pcnt
          ,le.populated_post_date_pcnt
          ,le.populated_county_code_pcnt
          ,le.populated_action_type_pcnt
          ,le.populated_filler_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,10,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_In_TN_WDL));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),10,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_In_TN_WDL) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DL_TN_WDL, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
