IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Medians_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 5;
  EXPORT NumRulesFromFieldType := 5;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 5;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Medians_Layout_AVM)
    UNSIGNED1 history_date_Invalid;
    UNSIGNED1 fips_geo_12_Invalid;
    UNSIGNED1 median_valuation_Invalid;
    UNSIGNED1 history_history_date_Invalid;
    UNSIGNED1 history_median_valuation_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Medians_Layout_AVM)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Medians_Layout_AVM) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.history_date_Invalid := Medians_Fields.InValid_history_date((SALT38.StrType)le.history_date);
    SELF.fips_geo_12_Invalid := Medians_Fields.InValid_fips_geo_12((SALT38.StrType)le.fips_geo_12);
    SELF.median_valuation_Invalid := Medians_Fields.InValid_median_valuation((SALT38.StrType)le.median_valuation);
    SELF.history_history_date_Invalid := Medians_Fields.InValid_history_history_date((SALT38.StrType)le.history_history_date);
    SELF.history_median_valuation_Invalid := Medians_Fields.InValid_history_median_valuation((SALT38.StrType)le.history_median_valuation);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Medians_Layout_AVM);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.history_date_Invalid << 0 ) + ( le.fips_geo_12_Invalid << 1 ) + ( le.median_valuation_Invalid << 2 ) + ( le.history_history_date_Invalid << 3 ) + ( le.history_median_valuation_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Medians_Layout_AVM);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.history_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.fips_geo_12_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.median_valuation_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.history_history_date_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.history_median_valuation_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    history_date_CUSTOM_ErrorCount := COUNT(GROUP,h.history_date_Invalid=1);
    fips_geo_12_ALLOW_ErrorCount := COUNT(GROUP,h.fips_geo_12_Invalid=1);
    median_valuation_ALLOW_ErrorCount := COUNT(GROUP,h.median_valuation_Invalid=1);
    history_history_date_CUSTOM_ErrorCount := COUNT(GROUP,h.history_history_date_Invalid=1);
    history_median_valuation_ALLOW_ErrorCount := COUNT(GROUP,h.history_median_valuation_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.history_date_Invalid > 0 OR h.fips_geo_12_Invalid > 0 OR h.median_valuation_Invalid > 0 OR h.history_history_date_Invalid > 0 OR h.history_median_valuation_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.history_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_geo_12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.median_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_history_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.history_median_valuation_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.history_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_geo_12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.median_valuation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.history_history_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.history_median_valuation_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.history_date_Invalid,le.fips_geo_12_Invalid,le.median_valuation_Invalid,le.history_history_date_Invalid,le.history_median_valuation_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Medians_Fields.InvalidMessage_history_date(le.history_date_Invalid),Medians_Fields.InvalidMessage_fips_geo_12(le.fips_geo_12_Invalid),Medians_Fields.InvalidMessage_median_valuation(le.median_valuation_Invalid),Medians_Fields.InvalidMessage_history_history_date(le.history_history_date_Invalid),Medians_Fields.InvalidMessage_history_median_valuation(le.history_median_valuation_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.history_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_geo_12_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.median_valuation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.history_history_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.history_median_valuation_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'history_date','fips_geo_12','median_valuation','history_history_date','history_median_valuation','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Date','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.history_date,(SALT38.StrType)le.fips_geo_12,(SALT38.StrType)le.median_valuation,(SALT38.StrType)le.history_history_date,(SALT38.StrType)le.history_median_valuation,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,5,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Medians_Layout_AVM) prevDS = DATASET([], Medians_Layout_AVM), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'history_date:Invalid_Date:CUSTOM'
          ,'fips_geo_12:Invalid_Num:ALLOW'
          ,'median_valuation:Invalid_Num:ALLOW'
          ,'history_history_date:Invalid_Date:CUSTOM'
          ,'history_median_valuation:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Medians_Fields.InvalidMessage_history_date(1)
          ,Medians_Fields.InvalidMessage_fips_geo_12(1)
          ,Medians_Fields.InvalidMessage_median_valuation(1)
          ,Medians_Fields.InvalidMessage_history_history_date(1)
          ,Medians_Fields.InvalidMessage_history_median_valuation(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.history_date_CUSTOM_ErrorCount
          ,le.fips_geo_12_ALLOW_ErrorCount
          ,le.median_valuation_ALLOW_ErrorCount
          ,le.history_history_date_CUSTOM_ErrorCount
          ,le.history_median_valuation_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.history_date_CUSTOM_ErrorCount
          ,le.fips_geo_12_ALLOW_ErrorCount
          ,le.median_valuation_ALLOW_ErrorCount
          ,le.history_history_date_CUSTOM_ErrorCount
          ,le.history_median_valuation_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := Medians_hygiene(PROJECT(h, Medians_Layout_AVM));
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
          ,'history_date:' + getFieldTypeText(h.history_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_geo_12:' + getFieldTypeText(h.fips_geo_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'median_valuation:' + getFieldTypeText(h.median_valuation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_history_date:' + getFieldTypeText(h.history_history_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_median_valuation:' + getFieldTypeText(h.history_median_valuation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_history_date_cnt
          ,le.populated_fips_geo_12_cnt
          ,le.populated_median_valuation_cnt
          ,le.populated_history_history_date_cnt
          ,le.populated_history_median_valuation_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_history_date_pcnt
          ,le.populated_fips_geo_12_pcnt
          ,le.populated_median_valuation_pcnt
          ,le.populated_history_history_date_pcnt
          ,le.populated_history_median_valuation_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,5,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Medians_Delta(prevDS, PROJECT(h, Medians_Layout_AVM));
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
 
EXPORT StandardStats(DATASET(Medians_Layout_AVM) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_AVM, Medians_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
