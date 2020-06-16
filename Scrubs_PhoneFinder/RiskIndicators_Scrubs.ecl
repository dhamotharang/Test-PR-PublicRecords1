IMPORT SALT311,STD;
IMPORT Scrubs_PhoneFinder; // Import modules for FieldTypes attribute definitions
EXPORT RiskIndicators_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 8;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(RiskIndicators_Layout_PhoneFinder)
    UNSIGNED1 transaction_id_Invalid;
    UNSIGNED1 phone_id_Invalid;
    UNSIGNED1 sequence_number_Invalid;
    UNSIGNED1 date_added_Invalid;
    UNSIGNED1 risk_indicator_id_Invalid;
    UNSIGNED1 risk_indicator_level_Invalid;
    UNSIGNED1 risk_indicator_category_Invalid;
    UNSIGNED1 filename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(RiskIndicators_Layout_PhoneFinder)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(RiskIndicators_Layout_PhoneFinder)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'transaction_id:Invalid_ID:ALLOW'
          ,'phone_id:Invalid_No:ALLOW'
          ,'sequence_number:Invalid_No:ALLOW'
          ,'date_added:Invalid_Date:CUSTOM'
          ,'risk_indicator_id:Invalid_No:ALLOW'
          ,'risk_indicator_level:Invalid_Alpha:ALLOW'
          ,'risk_indicator_category:Invalid_Risk:CUSTOM'
          ,'filename:Invalid_File:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,RiskIndicators_Fields.InvalidMessage_transaction_id(1)
          ,RiskIndicators_Fields.InvalidMessage_phone_id(1)
          ,RiskIndicators_Fields.InvalidMessage_sequence_number(1)
          ,RiskIndicators_Fields.InvalidMessage_date_added(1)
          ,RiskIndicators_Fields.InvalidMessage_risk_indicator_id(1)
          ,RiskIndicators_Fields.InvalidMessage_risk_indicator_level(1)
          ,RiskIndicators_Fields.InvalidMessage_risk_indicator_category(1)
          ,RiskIndicators_Fields.InvalidMessage_filename(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(RiskIndicators_Layout_PhoneFinder) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.transaction_id_Invalid := RiskIndicators_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id);
    SELF.phone_id_Invalid := RiskIndicators_Fields.InValid_phone_id((SALT311.StrType)le.phone_id);
    SELF.sequence_number_Invalid := RiskIndicators_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number);
    SELF.date_added_Invalid := RiskIndicators_Fields.InValid_date_added((SALT311.StrType)le.date_added);
    SELF.risk_indicator_id_Invalid := RiskIndicators_Fields.InValid_risk_indicator_id((SALT311.StrType)le.risk_indicator_id);
    SELF.risk_indicator_level_Invalid := RiskIndicators_Fields.InValid_risk_indicator_level((SALT311.StrType)le.risk_indicator_level);
    SELF.risk_indicator_category_Invalid := RiskIndicators_Fields.InValid_risk_indicator_category((SALT311.StrType)le.risk_indicator_category);
    SELF.filename_Invalid := RiskIndicators_Fields.InValid_filename((SALT311.StrType)le.filename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),RiskIndicators_Layout_PhoneFinder);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.transaction_id_Invalid << 0 ) + ( le.phone_id_Invalid << 1 ) + ( le.sequence_number_Invalid << 2 ) + ( le.date_added_Invalid << 3 ) + ( le.risk_indicator_id_Invalid << 4 ) + ( le.risk_indicator_level_Invalid << 5 ) + ( le.risk_indicator_category_Invalid << 6 ) + ( le.filename_Invalid << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,RiskIndicators_Layout_PhoneFinder);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.transaction_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.phone_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.sequence_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.date_added_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.risk_indicator_id_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.risk_indicator_level_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.risk_indicator_category_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.filename_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=1);
    phone_id_ALLOW_ErrorCount := COUNT(GROUP,h.phone_id_Invalid=1);
    sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.sequence_number_Invalid=1);
    date_added_CUSTOM_ErrorCount := COUNT(GROUP,h.date_added_Invalid=1);
    risk_indicator_id_ALLOW_ErrorCount := COUNT(GROUP,h.risk_indicator_id_Invalid=1);
    risk_indicator_level_ALLOW_ErrorCount := COUNT(GROUP,h.risk_indicator_level_Invalid=1);
    risk_indicator_category_CUSTOM_ErrorCount := COUNT(GROUP,h.risk_indicator_category_Invalid=1);
    filename_CUSTOM_ErrorCount := COUNT(GROUP,h.filename_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.transaction_id_Invalid > 0 OR h.phone_id_Invalid > 0 OR h.sequence_number_Invalid > 0 OR h.date_added_Invalid > 0 OR h.risk_indicator_id_Invalid > 0 OR h.risk_indicator_level_Invalid > 0 OR h.risk_indicator_category_Invalid > 0 OR h.filename_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sequence_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.risk_indicator_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.risk_indicator_level_ALLOW_ErrorCount > 0, 1, 0) + IF(le.risk_indicator_category_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filename_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sequence_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.risk_indicator_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.risk_indicator_level_ALLOW_ErrorCount > 0, 1, 0) + IF(le.risk_indicator_category_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filename_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.transaction_id_Invalid,le.phone_id_Invalid,le.sequence_number_Invalid,le.date_added_Invalid,le.risk_indicator_id_Invalid,le.risk_indicator_level_Invalid,le.risk_indicator_category_Invalid,le.filename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,RiskIndicators_Fields.InvalidMessage_transaction_id(le.transaction_id_Invalid),RiskIndicators_Fields.InvalidMessage_phone_id(le.phone_id_Invalid),RiskIndicators_Fields.InvalidMessage_sequence_number(le.sequence_number_Invalid),RiskIndicators_Fields.InvalidMessage_date_added(le.date_added_Invalid),RiskIndicators_Fields.InvalidMessage_risk_indicator_id(le.risk_indicator_id_Invalid),RiskIndicators_Fields.InvalidMessage_risk_indicator_level(le.risk_indicator_level_Invalid),RiskIndicators_Fields.InvalidMessage_risk_indicator_category(le.risk_indicator_category_Invalid),RiskIndicators_Fields.InvalidMessage_filename(le.filename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.transaction_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sequence_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_added_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.risk_indicator_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.risk_indicator_level_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.risk_indicator_category_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filename_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'transaction_id','phone_id','sequence_number','date_added','risk_indicator_id','risk_indicator_level','risk_indicator_category','filename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_ID','Invalid_No','Invalid_No','Invalid_Date','Invalid_No','Invalid_Alpha','Invalid_Risk','Invalid_File','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.transaction_id,(SALT311.StrType)le.phone_id,(SALT311.StrType)le.sequence_number,(SALT311.StrType)le.date_added,(SALT311.StrType)le.risk_indicator_id,(SALT311.StrType)le.risk_indicator_level,(SALT311.StrType)le.risk_indicator_category,(SALT311.StrType)le.filename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(RiskIndicators_Layout_PhoneFinder) prevDS = DATASET([], RiskIndicators_Layout_PhoneFinder), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.phone_id_ALLOW_ErrorCount
          ,le.sequence_number_ALLOW_ErrorCount
          ,le.date_added_CUSTOM_ErrorCount
          ,le.risk_indicator_id_ALLOW_ErrorCount
          ,le.risk_indicator_level_ALLOW_ErrorCount
          ,le.risk_indicator_category_CUSTOM_ErrorCount
          ,le.filename_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.phone_id_ALLOW_ErrorCount
          ,le.sequence_number_ALLOW_ErrorCount
          ,le.date_added_CUSTOM_ErrorCount
          ,le.risk_indicator_id_ALLOW_ErrorCount
          ,le.risk_indicator_level_ALLOW_ErrorCount
          ,le.risk_indicator_category_CUSTOM_ErrorCount
          ,le.filename_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := RiskIndicators_hygiene(PROJECT(h, RiskIndicators_Layout_PhoneFinder));
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
          ,'transaction_id:' + getFieldTypeText(h.transaction_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_id:' + getFieldTypeText(h.phone_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sequence_number:' + getFieldTypeText(h.sequence_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_added:' + getFieldTypeText(h.date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'risk_indicator_id:' + getFieldTypeText(h.risk_indicator_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'risk_indicator_level:' + getFieldTypeText(h.risk_indicator_level) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'risk_indicator_text:' + getFieldTypeText(h.risk_indicator_text) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'risk_indicator_category:' + getFieldTypeText(h.risk_indicator_category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_transaction_id_cnt
          ,le.populated_phone_id_cnt
          ,le.populated_sequence_number_cnt
          ,le.populated_date_added_cnt
          ,le.populated_risk_indicator_id_cnt
          ,le.populated_risk_indicator_level_cnt
          ,le.populated_risk_indicator_text_cnt
          ,le.populated_risk_indicator_category_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_transaction_id_pcnt
          ,le.populated_phone_id_pcnt
          ,le.populated_sequence_number_pcnt
          ,le.populated_date_added_pcnt
          ,le.populated_risk_indicator_id_pcnt
          ,le.populated_risk_indicator_level_pcnt
          ,le.populated_risk_indicator_text_pcnt
          ,le.populated_risk_indicator_category_pcnt
          ,le.populated_filename_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,9,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := RiskIndicators_Delta(prevDS, PROJECT(h, RiskIndicators_Layout_PhoneFinder));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),9,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(RiskIndicators_Layout_PhoneFinder) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhoneFinder, RiskIndicators_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
