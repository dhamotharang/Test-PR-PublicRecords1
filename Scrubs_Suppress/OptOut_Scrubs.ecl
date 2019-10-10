﻿IMPORT SALT311,STD;
EXPORT OptOut_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 7;
  EXPORT NumRulesFromFieldType := 7;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 5;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(OptOut_Layout_Suppress)
    UNSIGNED1 entry_type_Invalid;
    UNSIGNED1 lexid_Invalid;
    UNSIGNED1 prof_data_Invalid;
    UNSIGNED1 state_act_Invalid;
    UNSIGNED1 date_of_request_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(OptOut_Layout_Suppress)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(OptOut_Layout_Suppress) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.entry_type_Invalid := OptOut_Fields.InValid_entry_type((SALT311.StrType)le.entry_type);
    SELF.lexid_Invalid := OptOut_Fields.InValid_lexid((SALT311.StrType)le.lexid);
    SELF.prof_data_Invalid := OptOut_Fields.InValid_prof_data((SALT311.StrType)le.prof_data);
    SELF.state_act_Invalid := OptOut_Fields.InValid_state_act((SALT311.StrType)le.state_act);
    SELF.date_of_request_Invalid := OptOut_Fields.InValid_date_of_request((SALT311.StrType)le.date_of_request);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),OptOut_Layout_Suppress);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.entry_type_Invalid << 0 ) + ( le.lexid_Invalid << 1 ) + ( le.prof_data_Invalid << 2 ) + ( le.state_act_Invalid << 4 ) + ( le.date_of_request_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,OptOut_Layout_Suppress);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.entry_type_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.lexid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.prof_data_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.state_act_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.date_of_request_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    entry_type_ENUM_ErrorCount := COUNT(GROUP,h.entry_type_Invalid=1);
    lexid_ALLOW_ErrorCount := COUNT(GROUP,h.lexid_Invalid=1);
    prof_data_ENUM_ErrorCount := COUNT(GROUP,h.prof_data_Invalid=1);
    prof_data_LENGTHS_ErrorCount := COUNT(GROUP,h.prof_data_Invalid=2);
    prof_data_Total_ErrorCount := COUNT(GROUP,h.prof_data_Invalid>0);
    state_act_ENUM_ErrorCount := COUNT(GROUP,h.state_act_Invalid=1);
    state_act_LENGTHS_ErrorCount := COUNT(GROUP,h.state_act_Invalid=2);
    state_act_Total_ErrorCount := COUNT(GROUP,h.state_act_Invalid>0);
    date_of_request_ALLOW_ErrorCount := COUNT(GROUP,h.date_of_request_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.entry_type_Invalid > 0 OR h.lexid_Invalid > 0 OR h.prof_data_Invalid > 0 OR h.state_act_Invalid > 0 OR h.date_of_request_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.entry_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.lexid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prof_data_Total_ErrorCount > 0, 1, 0) + IF(le.state_act_Total_ErrorCount > 0, 1, 0) + IF(le.date_of_request_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.entry_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.lexid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prof_data_ENUM_ErrorCount > 0, 1, 0) + IF(le.prof_data_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_act_ENUM_ErrorCount > 0, 1, 0) + IF(le.state_act_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_of_request_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.entry_type_Invalid,le.lexid_Invalid,le.prof_data_Invalid,le.state_act_Invalid,le.date_of_request_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,OptOut_Fields.InvalidMessage_entry_type(le.entry_type_Invalid),OptOut_Fields.InvalidMessage_lexid(le.lexid_Invalid),OptOut_Fields.InvalidMessage_prof_data(le.prof_data_Invalid),OptOut_Fields.InvalidMessage_state_act(le.state_act_Invalid),OptOut_Fields.InvalidMessage_date_of_request(le.date_of_request_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.entry_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lexid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prof_data_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.state_act_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_of_request_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'entry_type','lexid','prof_data','state_act','date_of_request','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Entry_Type','Invalid_Nums','Invalid_Prof_Data','invalid_state_Act','Invalid_Nums','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.entry_type,(SALT311.StrType)le.lexid,(SALT311.StrType)le.prof_data,(SALT311.StrType)le.state_act,(SALT311.StrType)le.date_of_request,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,5,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(OptOut_Layout_Suppress) prevDS = DATASET([], OptOut_Layout_Suppress), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'entry_type:Invalid_Entry_Type:ENUM'
          ,'lexid:Invalid_Nums:ALLOW'
          ,'prof_data:Invalid_Prof_Data:ENUM','prof_data:Invalid_Prof_Data:LENGTHS'
          ,'state_act:invalid_state_Act:ENUM','state_act:invalid_state_Act:LENGTHS'
          ,'date_of_request:Invalid_Nums:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,OptOut_Fields.InvalidMessage_entry_type(1)
          ,OptOut_Fields.InvalidMessage_lexid(1)
          ,OptOut_Fields.InvalidMessage_prof_data(1),OptOut_Fields.InvalidMessage_prof_data(2)
          ,OptOut_Fields.InvalidMessage_state_act(1),OptOut_Fields.InvalidMessage_state_act(2)
          ,OptOut_Fields.InvalidMessage_date_of_request(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.entry_type_ENUM_ErrorCount
          ,le.lexid_ALLOW_ErrorCount
          ,le.prof_data_ENUM_ErrorCount,le.prof_data_LENGTHS_ErrorCount
          ,le.state_act_ENUM_ErrorCount,le.state_act_LENGTHS_ErrorCount
          ,le.date_of_request_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.entry_type_ENUM_ErrorCount
          ,le.lexid_ALLOW_ErrorCount
          ,le.prof_data_ENUM_ErrorCount,le.prof_data_LENGTHS_ErrorCount
          ,le.state_act_ENUM_ErrorCount,le.state_act_LENGTHS_ErrorCount
          ,le.date_of_request_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := OptOut_hygiene(PROJECT(h, OptOut_Layout_Suppress));
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
          ,'entry_type:' + getFieldTypeText(h.entry_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lexid:' + getFieldTypeText(h.lexid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prof_data:' + getFieldTypeText(h.prof_data) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_act:' + getFieldTypeText(h.state_act) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_of_request:' + getFieldTypeText(h.date_of_request) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_entry_type_cnt
          ,le.populated_lexid_cnt
          ,le.populated_prof_data_cnt
          ,le.populated_state_act_cnt
          ,le.populated_date_of_request_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_entry_type_pcnt
          ,le.populated_lexid_pcnt
          ,le.populated_prof_data_pcnt
          ,le.populated_state_act_pcnt
          ,le.populated_date_of_request_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,5,xNormHygieneStats(LEFT,COUNTER,'POP'));

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

    mod_Delta := OptOut_Delta(prevDS, PROJECT(h, OptOut_Layout_Suppress));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),5,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(OptOut_Layout_Suppress) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Suppress, OptOut_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
