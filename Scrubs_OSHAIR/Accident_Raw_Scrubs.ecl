IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_Oshair; // Import modules for FieldTypes attribute definitions
EXPORT Accident_Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 10;
  EXPORT NumRulesFromFieldType := 10;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Accident_Raw_Layout)
    UNSIGNED1 summary_nr_Invalid;
    UNSIGNED1 report_id_Invalid;
    UNSIGNED1 event_date_time_Invalid;
    UNSIGNED1 const_end_use_Invalid;
    UNSIGNED1 build_stories_Invalid;
    UNSIGNED1 nonbuild_ht_Invalid;
    UNSIGNED1 project_cost_Invalid;
    UNSIGNED1 project_type_Invalid;
    UNSIGNED1 sic_list_Invalid;
    UNSIGNED1 fatality_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Accident_Raw_Layout)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Accident_Raw_Layout) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.summary_nr_Invalid := Accident_Raw_Fields.InValid_summary_nr((SALT311.StrType)le.summary_nr);
    SELF.report_id_Invalid := Accident_Raw_Fields.InValid_report_id((SALT311.StrType)le.report_id);
    SELF.event_date_time_Invalid := Accident_Raw_Fields.InValid_event_date_time((SALT311.StrType)le.event_date_time);
    SELF.const_end_use_Invalid := Accident_Raw_Fields.InValid_const_end_use((SALT311.StrType)le.const_end_use);
    SELF.build_stories_Invalid := Accident_Raw_Fields.InValid_build_stories((SALT311.StrType)le.build_stories);
    SELF.nonbuild_ht_Invalid := Accident_Raw_Fields.InValid_nonbuild_ht((SALT311.StrType)le.nonbuild_ht);
    SELF.project_cost_Invalid := Accident_Raw_Fields.InValid_project_cost((SALT311.StrType)le.project_cost);
    SELF.project_type_Invalid := Accident_Raw_Fields.InValid_project_type((SALT311.StrType)le.project_type);
    SELF.sic_list_Invalid := Accident_Raw_Fields.InValid_sic_list((SALT311.StrType)le.sic_list);
    SELF.fatality_Invalid := Accident_Raw_Fields.InValid_fatality((SALT311.StrType)le.fatality);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Accident_Raw_Layout);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.summary_nr_Invalid << 0 ) + ( le.report_id_Invalid << 1 ) + ( le.event_date_time_Invalid << 2 ) + ( le.const_end_use_Invalid << 3 ) + ( le.build_stories_Invalid << 4 ) + ( le.nonbuild_ht_Invalid << 5 ) + ( le.project_cost_Invalid << 6 ) + ( le.project_type_Invalid << 7 ) + ( le.sic_list_Invalid << 8 ) + ( le.fatality_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Accident_Raw_Layout);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.summary_nr_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.report_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.event_date_time_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.const_end_use_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.build_stories_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.nonbuild_ht_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.project_cost_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.project_type_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.sic_list_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.fatality_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    summary_nr_CUSTOM_ErrorCount := COUNT(GROUP,h.summary_nr_Invalid=1);
    report_id_CUSTOM_ErrorCount := COUNT(GROUP,h.report_id_Invalid=1);
    event_date_time_CUSTOM_ErrorCount := COUNT(GROUP,h.event_date_time_Invalid=1);
    const_end_use_CUSTOM_ErrorCount := COUNT(GROUP,h.const_end_use_Invalid=1);
    build_stories_CUSTOM_ErrorCount := COUNT(GROUP,h.build_stories_Invalid=1);
    nonbuild_ht_CUSTOM_ErrorCount := COUNT(GROUP,h.nonbuild_ht_Invalid=1);
    project_cost_CUSTOM_ErrorCount := COUNT(GROUP,h.project_cost_Invalid=1);
    project_type_CUSTOM_ErrorCount := COUNT(GROUP,h.project_type_Invalid=1);
    sic_list_CUSTOM_ErrorCount := COUNT(GROUP,h.sic_list_Invalid=1);
    fatality_CUSTOM_ErrorCount := COUNT(GROUP,h.fatality_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.summary_nr_Invalid > 0 OR h.report_id_Invalid > 0 OR h.event_date_time_Invalid > 0 OR h.const_end_use_Invalid > 0 OR h.build_stories_Invalid > 0 OR h.nonbuild_ht_Invalid > 0 OR h.project_cost_Invalid > 0 OR h.project_type_Invalid > 0 OR h.sic_list_Invalid > 0 OR h.fatality_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.summary_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.report_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.event_date_time_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.const_end_use_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.build_stories_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nonbuild_ht_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.project_cost_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.project_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_list_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fatality_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.summary_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.report_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.event_date_time_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.const_end_use_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.build_stories_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nonbuild_ht_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.project_cost_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.project_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_list_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fatality_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.summary_nr_Invalid,le.report_id_Invalid,le.event_date_time_Invalid,le.const_end_use_Invalid,le.build_stories_Invalid,le.nonbuild_ht_Invalid,le.project_cost_Invalid,le.project_type_Invalid,le.sic_list_Invalid,le.fatality_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Accident_Raw_Fields.InvalidMessage_summary_nr(le.summary_nr_Invalid),Accident_Raw_Fields.InvalidMessage_report_id(le.report_id_Invalid),Accident_Raw_Fields.InvalidMessage_event_date_time(le.event_date_time_Invalid),Accident_Raw_Fields.InvalidMessage_const_end_use(le.const_end_use_Invalid),Accident_Raw_Fields.InvalidMessage_build_stories(le.build_stories_Invalid),Accident_Raw_Fields.InvalidMessage_nonbuild_ht(le.nonbuild_ht_Invalid),Accident_Raw_Fields.InvalidMessage_project_cost(le.project_cost_Invalid),Accident_Raw_Fields.InvalidMessage_project_type(le.project_type_Invalid),Accident_Raw_Fields.InvalidMessage_sic_list(le.sic_list_Invalid),Accident_Raw_Fields.InvalidMessage_fatality(le.fatality_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.summary_nr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.report_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.event_date_time_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.const_end_use_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.build_stories_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.nonbuild_ht_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.project_cost_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.project_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic_list_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fatality_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'summary_nr','report_id','event_date_time','const_end_use','build_stories','nonbuild_ht','project_cost','project_type','sic_list','fatality','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_date_time','invalid_const_end_use','invalid_numeric_blank','invalid_numeric_blank','invalid_project_cost','invalid_project_type','invalid_sic_list','invalid_fatality','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.summary_nr,(SALT311.StrType)le.report_id,(SALT311.StrType)le.event_date_time,(SALT311.StrType)le.const_end_use,(SALT311.StrType)le.build_stories,(SALT311.StrType)le.nonbuild_ht,(SALT311.StrType)le.project_cost,(SALT311.StrType)le.project_type,(SALT311.StrType)le.sic_list,(SALT311.StrType)le.fatality,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Accident_Raw_Layout) prevDS = DATASET([], Accident_Raw_Layout), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'summary_nr:invalid_numeric:CUSTOM'
          ,'report_id:invalid_numeric:CUSTOM'
          ,'event_date_time:invalid_date_time:CUSTOM'
          ,'const_end_use:invalid_const_end_use:CUSTOM'
          ,'build_stories:invalid_numeric_blank:CUSTOM'
          ,'nonbuild_ht:invalid_numeric_blank:CUSTOM'
          ,'project_cost:invalid_project_cost:CUSTOM'
          ,'project_type:invalid_project_type:CUSTOM'
          ,'sic_list:invalid_sic_list:CUSTOM'
          ,'fatality:invalid_fatality:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Accident_Raw_Fields.InvalidMessage_summary_nr(1)
          ,Accident_Raw_Fields.InvalidMessage_report_id(1)
          ,Accident_Raw_Fields.InvalidMessage_event_date_time(1)
          ,Accident_Raw_Fields.InvalidMessage_const_end_use(1)
          ,Accident_Raw_Fields.InvalidMessage_build_stories(1)
          ,Accident_Raw_Fields.InvalidMessage_nonbuild_ht(1)
          ,Accident_Raw_Fields.InvalidMessage_project_cost(1)
          ,Accident_Raw_Fields.InvalidMessage_project_type(1)
          ,Accident_Raw_Fields.InvalidMessage_sic_list(1)
          ,Accident_Raw_Fields.InvalidMessage_fatality(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.summary_nr_CUSTOM_ErrorCount
          ,le.report_id_CUSTOM_ErrorCount
          ,le.event_date_time_CUSTOM_ErrorCount
          ,le.const_end_use_CUSTOM_ErrorCount
          ,le.build_stories_CUSTOM_ErrorCount
          ,le.nonbuild_ht_CUSTOM_ErrorCount
          ,le.project_cost_CUSTOM_ErrorCount
          ,le.project_type_CUSTOM_ErrorCount
          ,le.sic_list_CUSTOM_ErrorCount
          ,le.fatality_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.summary_nr_CUSTOM_ErrorCount
          ,le.report_id_CUSTOM_ErrorCount
          ,le.event_date_time_CUSTOM_ErrorCount
          ,le.const_end_use_CUSTOM_ErrorCount
          ,le.build_stories_CUSTOM_ErrorCount
          ,le.nonbuild_ht_CUSTOM_ErrorCount
          ,le.project_cost_CUSTOM_ErrorCount
          ,le.project_type_CUSTOM_ErrorCount
          ,le.sic_list_CUSTOM_ErrorCount
          ,le.fatality_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Accident_Raw_hygiene(PROJECT(h, Accident_Raw_Layout));
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
          ,'summary_nr:' + getFieldTypeText(h.summary_nr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'report_id:' + getFieldTypeText(h.report_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'event_date_time:' + getFieldTypeText(h.event_date_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'const_end_use:' + getFieldTypeText(h.const_end_use) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'build_stories:' + getFieldTypeText(h.build_stories) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nonbuild_ht:' + getFieldTypeText(h.nonbuild_ht) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'project_cost:' + getFieldTypeText(h.project_cost) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'project_type:' + getFieldTypeText(h.project_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic_list:' + getFieldTypeText(h.sic_list) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fatality:' + getFieldTypeText(h.fatality) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_summary_nr_cnt
          ,le.populated_report_id_cnt
          ,le.populated_event_date_time_cnt
          ,le.populated_const_end_use_cnt
          ,le.populated_build_stories_cnt
          ,le.populated_nonbuild_ht_cnt
          ,le.populated_project_cost_cnt
          ,le.populated_project_type_cnt
          ,le.populated_sic_list_cnt
          ,le.populated_fatality_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_summary_nr_pcnt
          ,le.populated_report_id_pcnt
          ,le.populated_event_date_time_pcnt
          ,le.populated_const_end_use_pcnt
          ,le.populated_build_stories_pcnt
          ,le.populated_nonbuild_ht_pcnt
          ,le.populated_project_cost_pcnt
          ,le.populated_project_type_pcnt
          ,le.populated_sic_list_pcnt
          ,le.populated_fatality_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,10,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Accident_Raw_Delta(prevDS, PROJECT(h, Accident_Raw_Layout));
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
 
EXPORT StandardStats(DATASET(Accident_Raw_Layout) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_OSHAIR, Accident_Raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
