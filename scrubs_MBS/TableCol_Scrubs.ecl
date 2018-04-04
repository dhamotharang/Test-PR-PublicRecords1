IMPORT SALT39,STD;
EXPORT TableCol_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 4;
  EXPORT NumRulesFromFieldType := 4;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 4;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(TableCol_Layout_TableCol)
    UNSIGNED1 table_column_id_Invalid;
    UNSIGNED1 table_name_Invalid;
    UNSIGNED1 column_name_Invalid;
    UNSIGNED1 is_column_value_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(TableCol_Layout_TableCol)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(TableCol_Layout_TableCol) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.table_column_id_Invalid := TableCol_Fields.InValid_table_column_id((SALT39.StrType)le.table_column_id);
    SELF.table_name_Invalid := TableCol_Fields.InValid_table_name((SALT39.StrType)le.table_name);
    SELF.column_name_Invalid := TableCol_Fields.InValid_column_name((SALT39.StrType)le.column_name);
    SELF.is_column_value_Invalid := TableCol_Fields.InValid_is_column_value((SALT39.StrType)le.is_column_value);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),TableCol_Layout_TableCol);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.table_column_id_Invalid << 0 ) + ( le.table_name_Invalid << 1 ) + ( le.column_name_Invalid << 2 ) + ( le.is_column_value_Invalid << 3 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,TableCol_Layout_TableCol);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.table_column_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.table_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.column_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.is_column_value_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    table_column_id_ALLOW_ErrorCount := COUNT(GROUP,h.table_column_id_Invalid=1);
    table_name_ALLOW_ErrorCount := COUNT(GROUP,h.table_name_Invalid=1);
    column_name_ALLOW_ErrorCount := COUNT(GROUP,h.column_name_Invalid=1);
    is_column_value_ALLOW_ErrorCount := COUNT(GROUP,h.is_column_value_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.table_column_id_Invalid > 0 OR h.table_name_Invalid > 0 OR h.column_name_Invalid > 0 OR h.is_column_value_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.table_column_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.table_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.column_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.is_column_value_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.table_column_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.table_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.column_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.is_column_value_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.table_column_id_Invalid,le.table_name_Invalid,le.column_name_Invalid,le.is_column_value_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,TableCol_Fields.InvalidMessage_table_column_id(le.table_column_id_Invalid),TableCol_Fields.InvalidMessage_table_name(le.table_name_Invalid),TableCol_Fields.InvalidMessage_column_name(le.column_name_Invalid),TableCol_Fields.InvalidMessage_is_column_value(le.is_column_value_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.table_column_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.table_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.column_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.is_column_value_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'table_column_id','table_name','column_name','is_column_value','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.table_column_id,(SALT39.StrType)le.table_name,(SALT39.StrType)le.column_name,(SALT39.StrType)le.is_column_value,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,4,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(TableCol_Layout_TableCol) prevDS = DATASET([], TableCol_Layout_TableCol), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'table_column_id:invalid_numeric:ALLOW'
          ,'table_name:invalid_alphanumeric:ALLOW'
          ,'column_name:invalid_alphanumeric:ALLOW'
          ,'is_column_value:invalid_numeric:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,TableCol_Fields.InvalidMessage_table_column_id(1)
          ,TableCol_Fields.InvalidMessage_table_name(1)
          ,TableCol_Fields.InvalidMessage_column_name(1)
          ,TableCol_Fields.InvalidMessage_is_column_value(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.table_column_id_ALLOW_ErrorCount
          ,le.table_name_ALLOW_ErrorCount
          ,le.column_name_ALLOW_ErrorCount
          ,le.is_column_value_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.table_column_id_ALLOW_ErrorCount
          ,le.table_name_ALLOW_ErrorCount
          ,le.column_name_ALLOW_ErrorCount
          ,le.is_column_value_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := TableCol_hygiene(PROJECT(h, TableCol_Layout_TableCol));
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
          ,'table_column_id:' + getFieldTypeText(h.table_column_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'table_name:' + getFieldTypeText(h.table_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'column_name:' + getFieldTypeText(h.column_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_column_value:' + getFieldTypeText(h.is_column_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_table_column_id_cnt
          ,le.populated_table_name_cnt
          ,le.populated_column_name_cnt
          ,le.populated_is_column_value_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_table_column_id_pcnt
          ,le.populated_table_name_pcnt
          ,le.populated_column_name_pcnt
          ,le.populated_is_column_value_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,4,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := TableCol_Delta(prevDS, PROJECT(h, TableCol_Layout_TableCol));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),4,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(TableCol_Layout_TableCol) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_MBS, TableCol_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
