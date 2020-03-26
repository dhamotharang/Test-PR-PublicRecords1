IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_TX_Harris_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 8;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_TX_Harris_Layout_FBNV2)
    UNSIGNED1 FILE_NUMBER_Invalid;
    UNSIGNED1 DATE_FILED_Invalid;
    UNSIGNED1 NAME1_Invalid;
    UNSIGNED1 NAME2_Invalid;
    UNSIGNED1 prep_addr1_line1_Invalid;
    UNSIGNED1 prep_addr1_line_last_Invalid;
    UNSIGNED1 prep_addr2_line1_Invalid;
    UNSIGNED1 prep_addr2_line_last_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_TX_Harris_Layout_FBNV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_TX_Harris_Layout_FBNV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.FILE_NUMBER_Invalid := Input_TX_Harris_Fields.InValid_FILE_NUMBER((SALT311.StrType)le.FILE_NUMBER);
    SELF.DATE_FILED_Invalid := Input_TX_Harris_Fields.InValid_DATE_FILED((SALT311.StrType)le.DATE_FILED);
    SELF.NAME1_Invalid := Input_TX_Harris_Fields.InValid_NAME1((SALT311.StrType)le.NAME1);
    SELF.NAME2_Invalid := Input_TX_Harris_Fields.InValid_NAME2((SALT311.StrType)le.NAME2);
    SELF.prep_addr1_line1_Invalid := Input_TX_Harris_Fields.InValid_prep_addr1_line1((SALT311.StrType)le.prep_addr1_line1);
    SELF.prep_addr1_line_last_Invalid := Input_TX_Harris_Fields.InValid_prep_addr1_line_last((SALT311.StrType)le.prep_addr1_line_last);
    SELF.prep_addr2_line1_Invalid := Input_TX_Harris_Fields.InValid_prep_addr2_line1((SALT311.StrType)le.prep_addr2_line1);
    SELF.prep_addr2_line_last_Invalid := Input_TX_Harris_Fields.InValid_prep_addr2_line_last((SALT311.StrType)le.prep_addr2_line_last);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_TX_Harris_Layout_FBNV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.FILE_NUMBER_Invalid << 0 ) + ( le.DATE_FILED_Invalid << 1 ) + ( le.NAME1_Invalid << 2 ) + ( le.NAME2_Invalid << 3 ) + ( le.prep_addr1_line1_Invalid << 4 ) + ( le.prep_addr1_line_last_Invalid << 5 ) + ( le.prep_addr2_line1_Invalid << 6 ) + ( le.prep_addr2_line_last_Invalid << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_TX_Harris_Layout_FBNV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.FILE_NUMBER_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.DATE_FILED_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.NAME1_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.NAME2_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.prep_addr1_line1_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.prep_addr1_line_last_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.prep_addr2_line1_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.prep_addr2_line_last_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    FILE_NUMBER_LENGTHS_ErrorCount := COUNT(GROUP,h.FILE_NUMBER_Invalid=1);
    DATE_FILED_CUSTOM_ErrorCount := COUNT(GROUP,h.DATE_FILED_Invalid=1);
    NAME1_LENGTHS_ErrorCount := COUNT(GROUP,h.NAME1_Invalid=1);
    NAME2_LENGTHS_ErrorCount := COUNT(GROUP,h.NAME2_Invalid=1);
    prep_addr1_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr1_line1_Invalid=1);
    prep_addr1_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr1_line_last_Invalid=1);
    prep_addr2_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr2_line1_Invalid=1);
    prep_addr2_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr2_line_last_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.FILE_NUMBER_Invalid > 0 OR h.DATE_FILED_Invalid > 0 OR h.NAME1_Invalid > 0 OR h.NAME2_Invalid > 0 OR h.prep_addr1_line1_Invalid > 0 OR h.prep_addr1_line_last_Invalid > 0 OR h.prep_addr2_line1_Invalid > 0 OR h.prep_addr2_line_last_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.FILE_NUMBER_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.DATE_FILED_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.NAME1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.NAME2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr1_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr1_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr2_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr2_line_last_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.FILE_NUMBER_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.DATE_FILED_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.NAME1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.NAME2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr1_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr1_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr2_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr2_line_last_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.FILE_NUMBER_Invalid,le.DATE_FILED_Invalid,le.NAME1_Invalid,le.NAME2_Invalid,le.prep_addr1_line1_Invalid,le.prep_addr1_line_last_Invalid,le.prep_addr2_line1_Invalid,le.prep_addr2_line_last_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_TX_Harris_Fields.InvalidMessage_FILE_NUMBER(le.FILE_NUMBER_Invalid),Input_TX_Harris_Fields.InvalidMessage_DATE_FILED(le.DATE_FILED_Invalid),Input_TX_Harris_Fields.InvalidMessage_NAME1(le.NAME1_Invalid),Input_TX_Harris_Fields.InvalidMessage_NAME2(le.NAME2_Invalid),Input_TX_Harris_Fields.InvalidMessage_prep_addr1_line1(le.prep_addr1_line1_Invalid),Input_TX_Harris_Fields.InvalidMessage_prep_addr1_line_last(le.prep_addr1_line_last_Invalid),Input_TX_Harris_Fields.InvalidMessage_prep_addr2_line1(le.prep_addr2_line1_Invalid),Input_TX_Harris_Fields.InvalidMessage_prep_addr2_line_last(le.prep_addr2_line_last_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.FILE_NUMBER_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.DATE_FILED_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.NAME1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.NAME2_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_addr1_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_addr1_line_last_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_addr2_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_addr2_line_last_Invalid,'LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'FILE_NUMBER','DATE_FILED','NAME1','NAME2','prep_addr1_line1','prep_addr1_line_last','prep_addr2_line1','prep_addr2_line_last','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.FILE_NUMBER,(SALT311.StrType)le.DATE_FILED,(SALT311.StrType)le.NAME1,(SALT311.StrType)le.NAME2,(SALT311.StrType)le.prep_addr1_line1,(SALT311.StrType)le.prep_addr1_line_last,(SALT311.StrType)le.prep_addr2_line1,(SALT311.StrType)le.prep_addr2_line_last,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_TX_Harris_Layout_FBNV2) prevDS = DATASET([], Input_TX_Harris_Layout_FBNV2), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'FILE_NUMBER:invalid_mandatory:LENGTHS'
          ,'DATE_FILED:invalid_past_date:CUSTOM'
          ,'NAME1:invalid_mandatory:LENGTHS'
          ,'NAME2:invalid_mandatory:LENGTHS'
          ,'prep_addr1_line1:invalid_mandatory:LENGTHS'
          ,'prep_addr1_line_last:invalid_mandatory:LENGTHS'
          ,'prep_addr2_line1:invalid_mandatory:LENGTHS'
          ,'prep_addr2_line_last:invalid_mandatory:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_TX_Harris_Fields.InvalidMessage_FILE_NUMBER(1)
          ,Input_TX_Harris_Fields.InvalidMessage_DATE_FILED(1)
          ,Input_TX_Harris_Fields.InvalidMessage_NAME1(1)
          ,Input_TX_Harris_Fields.InvalidMessage_NAME2(1)
          ,Input_TX_Harris_Fields.InvalidMessage_prep_addr1_line1(1)
          ,Input_TX_Harris_Fields.InvalidMessage_prep_addr1_line_last(1)
          ,Input_TX_Harris_Fields.InvalidMessage_prep_addr2_line1(1)
          ,Input_TX_Harris_Fields.InvalidMessage_prep_addr2_line_last(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.FILE_NUMBER_LENGTHS_ErrorCount
          ,le.DATE_FILED_CUSTOM_ErrorCount
          ,le.NAME1_LENGTHS_ErrorCount
          ,le.NAME2_LENGTHS_ErrorCount
          ,le.prep_addr1_line1_LENGTHS_ErrorCount
          ,le.prep_addr1_line_last_LENGTHS_ErrorCount
          ,le.prep_addr2_line1_LENGTHS_ErrorCount
          ,le.prep_addr2_line_last_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.FILE_NUMBER_LENGTHS_ErrorCount
          ,le.DATE_FILED_CUSTOM_ErrorCount
          ,le.NAME1_LENGTHS_ErrorCount
          ,le.NAME2_LENGTHS_ErrorCount
          ,le.prep_addr1_line1_LENGTHS_ErrorCount
          ,le.prep_addr1_line_last_LENGTHS_ErrorCount
          ,le.prep_addr2_line1_LENGTHS_ErrorCount
          ,le.prep_addr2_line_last_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_TX_Harris_hygiene(PROJECT(h, Input_TX_Harris_Layout_FBNV2));
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
          ,'FILE_NUMBER:' + getFieldTypeText(h.FILE_NUMBER) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DATE_FILED:' + getFieldTypeText(h.DATE_FILED) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'NAME1:' + getFieldTypeText(h.NAME1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'NAME2:' + getFieldTypeText(h.NAME2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr1_line1:' + getFieldTypeText(h.prep_addr1_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr1_line_last:' + getFieldTypeText(h.prep_addr1_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr2_line1:' + getFieldTypeText(h.prep_addr2_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr2_line_last:' + getFieldTypeText(h.prep_addr2_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_FILE_NUMBER_cnt
          ,le.populated_DATE_FILED_cnt
          ,le.populated_NAME1_cnt
          ,le.populated_NAME2_cnt
          ,le.populated_prep_addr1_line1_cnt
          ,le.populated_prep_addr1_line_last_cnt
          ,le.populated_prep_addr2_line1_cnt
          ,le.populated_prep_addr2_line_last_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_FILE_NUMBER_pcnt
          ,le.populated_DATE_FILED_pcnt
          ,le.populated_NAME1_pcnt
          ,le.populated_NAME2_pcnt
          ,le.populated_prep_addr1_line1_pcnt
          ,le.populated_prep_addr1_line_last_pcnt
          ,le.populated_prep_addr2_line1_pcnt
          ,le.populated_prep_addr2_line_last_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,8,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_TX_Harris_Delta(prevDS, PROJECT(h, Input_TX_Harris_Layout_FBNV2));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),8,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_TX_Harris_Layout_FBNV2) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FBNV2, Input_TX_Harris_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
