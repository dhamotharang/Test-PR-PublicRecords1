﻿IMPORT SALT311,STD;
EXPORT ColValDesc_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 5;
  EXPORT NumRulesFromFieldType := 5;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 5;
  EXPORT NumFieldsWithPossibleEdits := 5;
  EXPORT NumRulesWithPossibleEdits := 5;
  EXPORT Expanded_Layout := RECORD(ColValDesc_Layout_ColValDesc)
    UNSIGNED1 column_value_desc_id_Invalid;
    BOOLEAN column_value_desc_id_wouldClean;
    UNSIGNED1 table_column_id_Invalid;
    BOOLEAN table_column_id_wouldClean;
    UNSIGNED1 desc_value_Invalid;
    BOOLEAN desc_value_wouldClean;
    UNSIGNED1 status_Invalid;
    BOOLEAN status_wouldClean;
    UNSIGNED1 description_Invalid;
    BOOLEAN description_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(ColValDesc_Layout_ColValDesc)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(ColValDesc_Layout_ColValDesc) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.column_value_desc_id_Invalid := ColValDesc_Fields.InValid_column_value_desc_id((SALT311.StrType)le.column_value_desc_id);
    SELF.column_value_desc_id := IF(SELF.column_value_desc_id_Invalid=0 OR NOT withOnfail, le.column_value_desc_id, (TYPEOF(le.column_value_desc_id))''); // ONFAIL(BLANK)
    SELF.column_value_desc_id_wouldClean :=  SELF.column_value_desc_id_Invalid > 0;
    SELF.table_column_id_Invalid := ColValDesc_Fields.InValid_table_column_id((SALT311.StrType)le.table_column_id);
    SELF.table_column_id := IF(SELF.table_column_id_Invalid=0 OR NOT withOnfail, le.table_column_id, (TYPEOF(le.table_column_id))''); // ONFAIL(BLANK)
    SELF.table_column_id_wouldClean :=  SELF.table_column_id_Invalid > 0;
    SELF.desc_value_Invalid := ColValDesc_Fields.InValid_desc_value((SALT311.StrType)le.desc_value);
    SELF.desc_value := IF(SELF.desc_value_Invalid=0 OR NOT withOnfail, le.desc_value, (TYPEOF(le.desc_value))''); // ONFAIL(BLANK)
    SELF.desc_value_wouldClean :=  SELF.desc_value_Invalid > 0;
    SELF.status_Invalid := ColValDesc_Fields.InValid_status((SALT311.StrType)le.status);
    SELF.status := IF(SELF.status_Invalid=0 OR NOT withOnfail, le.status, (TYPEOF(le.status))''); // ONFAIL(BLANK)
    SELF.status_wouldClean :=  SELF.status_Invalid > 0;
    SELF.description_Invalid := ColValDesc_Fields.InValid_description((SALT311.StrType)le.description);
    SELF.description := IF(SELF.description_Invalid=0 OR NOT withOnfail, le.description, (TYPEOF(le.description))''); // ONFAIL(BLANK)
    SELF.description_wouldClean :=  SELF.description_Invalid > 0;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),ColValDesc_Layout_ColValDesc);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.column_value_desc_id_Invalid << 0 ) + ( le.table_column_id_Invalid << 1 ) + ( le.desc_value_Invalid << 2 ) + ( le.status_Invalid << 3 ) + ( le.description_Invalid << 4 );
    SELF.ScrubsCleanBits1 := ( IF(le.column_value_desc_id_wouldClean, 1, 0) << 0 ) + ( IF(le.table_column_id_wouldClean, 1, 0) << 1 ) + ( IF(le.desc_value_wouldClean, 1, 0) << 2 ) + ( IF(le.status_wouldClean, 1, 0) << 3 ) + ( IF(le.description_wouldClean, 1, 0) << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,ColValDesc_Layout_ColValDesc);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.column_value_desc_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.table_column_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.desc_value_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.description_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.column_value_desc_id_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.table_column_id_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.desc_value_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.status_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.description_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    column_value_desc_id_ALLOW_ErrorCount := COUNT(GROUP,h.column_value_desc_id_Invalid=1);
    column_value_desc_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.column_value_desc_id_Invalid=1 AND h.column_value_desc_id_wouldClean);
    table_column_id_ALLOW_ErrorCount := COUNT(GROUP,h.table_column_id_Invalid=1);
    table_column_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.table_column_id_Invalid=1 AND h.table_column_id_wouldClean);
    desc_value_ALLOW_ErrorCount := COUNT(GROUP,h.desc_value_Invalid=1);
    desc_value_ALLOW_WouldModifyCount := COUNT(GROUP,h.desc_value_Invalid=1 AND h.desc_value_wouldClean);
    status_ALLOW_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    status_ALLOW_WouldModifyCount := COUNT(GROUP,h.status_Invalid=1 AND h.status_wouldClean);
    description_ALLOW_ErrorCount := COUNT(GROUP,h.description_Invalid=1);
    description_ALLOW_WouldModifyCount := COUNT(GROUP,h.description_Invalid=1 AND h.description_wouldClean);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.column_value_desc_id_Invalid > 0 OR h.table_column_id_Invalid > 0 OR h.desc_value_Invalid > 0 OR h.status_Invalid > 0 OR h.description_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.column_value_desc_id_wouldClean OR h.table_column_id_wouldClean OR h.desc_value_wouldClean OR h.status_wouldClean OR h.description_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.column_value_desc_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.table_column_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.desc_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.description_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.column_value_desc_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.table_column_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.desc_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.description_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.column_value_desc_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.table_column_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.desc_value_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.status_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.description_ALLOW_WouldModifyCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.column_value_desc_id_Invalid,le.table_column_id_Invalid,le.desc_value_Invalid,le.status_Invalid,le.description_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,ColValDesc_Fields.InvalidMessage_column_value_desc_id(le.column_value_desc_id_Invalid),ColValDesc_Fields.InvalidMessage_table_column_id(le.table_column_id_Invalid),ColValDesc_Fields.InvalidMessage_desc_value(le.desc_value_Invalid),ColValDesc_Fields.InvalidMessage_status(le.status_Invalid),ColValDesc_Fields.InvalidMessage_description(le.description_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.column_value_desc_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.table_column_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.desc_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.description_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'column_value_desc_id','table_column_id','desc_value','status','description','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_text','invalid_numeric','invalid_text','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.column_value_desc_id,(SALT311.StrType)le.table_column_id,(SALT311.StrType)le.desc_value,(SALT311.StrType)le.status,(SALT311.StrType)le.description,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,5,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(ColValDesc_Layout_ColValDesc) prevDS = DATASET([], ColValDesc_Layout_ColValDesc), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'column_value_desc_id:invalid_numeric:ALLOW'
          ,'table_column_id:invalid_numeric:ALLOW'
          ,'desc_value:invalid_text:ALLOW'
          ,'status:invalid_numeric:ALLOW'
          ,'description:invalid_text:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,ColValDesc_Fields.InvalidMessage_column_value_desc_id(1)
          ,ColValDesc_Fields.InvalidMessage_table_column_id(1)
          ,ColValDesc_Fields.InvalidMessage_desc_value(1)
          ,ColValDesc_Fields.InvalidMessage_status(1)
          ,ColValDesc_Fields.InvalidMessage_description(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.column_value_desc_id_ALLOW_ErrorCount
          ,le.table_column_id_ALLOW_ErrorCount
          ,le.desc_value_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.description_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.column_value_desc_id_ALLOW_ErrorCount
          ,le.table_column_id_ALLOW_ErrorCount
          ,le.desc_value_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.description_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
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
    mod_hygiene := ColValDesc_hygiene(PROJECT(h, ColValDesc_Layout_ColValDesc));
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
          ,'column_value_desc_id:' + getFieldTypeText(h.column_value_desc_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'table_column_id:' + getFieldTypeText(h.table_column_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'desc_value:' + getFieldTypeText(h.desc_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'status:' + getFieldTypeText(h.status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'description:' + getFieldTypeText(h.description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_column_value_desc_id_cnt
          ,le.populated_table_column_id_cnt
          ,le.populated_desc_value_cnt
          ,le.populated_status_cnt
          ,le.populated_description_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_column_value_desc_id_pcnt
          ,le.populated_table_column_id_pcnt
          ,le.populated_desc_value_pcnt
          ,le.populated_status_pcnt
          ,le.populated_description_pcnt,0);
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
 
    mod_Delta := ColValDesc_Delta(prevDS, PROJECT(h, ColValDesc_Layout_ColValDesc));
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
 
EXPORT StandardStats(DATASET(ColValDesc_Layout_ColValDesc) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_MBS, ColValDesc_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
