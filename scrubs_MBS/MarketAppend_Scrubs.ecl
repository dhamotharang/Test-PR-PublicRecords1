IMPORT SALT39,STD;
EXPORT MarketAppend_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 7;
  EXPORT NumRulesFromFieldType := 7;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 7;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(MarketAppend_Layout_MarketAppend)
    UNSIGNED1 company_id_Invalid;
    UNSIGNED1 app_type_Invalid;
    UNSIGNED1 market_Invalid;
    UNSIGNED1 sub_market_Invalid;
    UNSIGNED1 vertical_Invalid;
    UNSIGNED1 main_country_code_Invalid;
    UNSIGNED1 bill_country_code_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(MarketAppend_Layout_MarketAppend)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(MarketAppend_Layout_MarketAppend) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.company_id_Invalid := MarketAppend_Fields.InValid_company_id((SALT39.StrType)le.company_id);
    SELF.app_type_Invalid := MarketAppend_Fields.InValid_app_type((SALT39.StrType)le.app_type);
    SELF.market_Invalid := MarketAppend_Fields.InValid_market((SALT39.StrType)le.market);
    SELF.sub_market_Invalid := MarketAppend_Fields.InValid_sub_market((SALT39.StrType)le.sub_market);
    SELF.vertical_Invalid := MarketAppend_Fields.InValid_vertical((SALT39.StrType)le.vertical);
    SELF.main_country_code_Invalid := MarketAppend_Fields.InValid_main_country_code((SALT39.StrType)le.main_country_code);
    SELF.bill_country_code_Invalid := MarketAppend_Fields.InValid_bill_country_code((SALT39.StrType)le.bill_country_code);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),MarketAppend_Layout_MarketAppend);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.company_id_Invalid << 0 ) + ( le.app_type_Invalid << 1 ) + ( le.market_Invalid << 2 ) + ( le.sub_market_Invalid << 3 ) + ( le.vertical_Invalid << 4 ) + ( le.main_country_code_Invalid << 5 ) + ( le.bill_country_code_Invalid << 6 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,MarketAppend_Layout_MarketAppend);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.company_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.app_type_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.market_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.sub_market_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.vertical_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.main_country_code_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.bill_country_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    company_id_ALLOW_ErrorCount := COUNT(GROUP,h.company_id_Invalid=1);
    app_type_ALLOW_ErrorCount := COUNT(GROUP,h.app_type_Invalid=1);
    market_ALLOW_ErrorCount := COUNT(GROUP,h.market_Invalid=1);
    sub_market_ALLOW_ErrorCount := COUNT(GROUP,h.sub_market_Invalid=1);
    vertical_ALLOW_ErrorCount := COUNT(GROUP,h.vertical_Invalid=1);
    main_country_code_ALLOW_ErrorCount := COUNT(GROUP,h.main_country_code_Invalid=1);
    bill_country_code_ALLOW_ErrorCount := COUNT(GROUP,h.bill_country_code_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.company_id_Invalid > 0 OR h.app_type_Invalid > 0 OR h.market_Invalid > 0 OR h.sub_market_Invalid > 0 OR h.vertical_Invalid > 0 OR h.main_country_code_Invalid > 0 OR h.bill_country_code_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.company_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.app_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sub_market_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vertical_ALLOW_ErrorCount > 0, 1, 0) + IF(le.main_country_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bill_country_code_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.company_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.app_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sub_market_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vertical_ALLOW_ErrorCount > 0, 1, 0) + IF(le.main_country_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bill_country_code_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.company_id_Invalid,le.app_type_Invalid,le.market_Invalid,le.sub_market_Invalid,le.vertical_Invalid,le.main_country_code_Invalid,le.bill_country_code_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,MarketAppend_Fields.InvalidMessage_company_id(le.company_id_Invalid),MarketAppend_Fields.InvalidMessage_app_type(le.app_type_Invalid),MarketAppend_Fields.InvalidMessage_market(le.market_Invalid),MarketAppend_Fields.InvalidMessage_sub_market(le.sub_market_Invalid),MarketAppend_Fields.InvalidMessage_vertical(le.vertical_Invalid),MarketAppend_Fields.InvalidMessage_main_country_code(le.main_country_code_Invalid),MarketAppend_Fields.InvalidMessage_bill_country_code(le.bill_country_code_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.company_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.app_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.market_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sub_market_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vertical_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.main_country_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bill_country_code_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'company_id','app_type','market','sub_market','vertical','main_country_code','bill_country_code','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.company_id,(SALT39.StrType)le.app_type,(SALT39.StrType)le.market,(SALT39.StrType)le.sub_market,(SALT39.StrType)le.vertical,(SALT39.StrType)le.main_country_code,(SALT39.StrType)le.bill_country_code,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(MarketAppend_Layout_MarketAppend) prevDS = DATASET([], MarketAppend_Layout_MarketAppend), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'company_id:invalid_alphanumeric:ALLOW'
          ,'app_type:invalid_alphanumeric:ALLOW'
          ,'market:invalid_alphanumeric:ALLOW'
          ,'sub_market:invalid_alphanumeric:ALLOW'
          ,'vertical:invalid_alphanumeric:ALLOW'
          ,'main_country_code:invalid_alphanumeric:ALLOW'
          ,'bill_country_code:invalid_alphanumeric:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,MarketAppend_Fields.InvalidMessage_company_id(1)
          ,MarketAppend_Fields.InvalidMessage_app_type(1)
          ,MarketAppend_Fields.InvalidMessage_market(1)
          ,MarketAppend_Fields.InvalidMessage_sub_market(1)
          ,MarketAppend_Fields.InvalidMessage_vertical(1)
          ,MarketAppend_Fields.InvalidMessage_main_country_code(1)
          ,MarketAppend_Fields.InvalidMessage_bill_country_code(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.company_id_ALLOW_ErrorCount
          ,le.app_type_ALLOW_ErrorCount
          ,le.market_ALLOW_ErrorCount
          ,le.sub_market_ALLOW_ErrorCount
          ,le.vertical_ALLOW_ErrorCount
          ,le.main_country_code_ALLOW_ErrorCount
          ,le.bill_country_code_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.company_id_ALLOW_ErrorCount
          ,le.app_type_ALLOW_ErrorCount
          ,le.market_ALLOW_ErrorCount
          ,le.sub_market_ALLOW_ErrorCount
          ,le.vertical_ALLOW_ErrorCount
          ,le.main_country_code_ALLOW_ErrorCount
          ,le.bill_country_code_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := MarketAppend_hygiene(PROJECT(h, MarketAppend_Layout_MarketAppend));
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
          ,'company_id:' + getFieldTypeText(h.company_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'app_type:' + getFieldTypeText(h.app_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'market:' + getFieldTypeText(h.market) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sub_market:' + getFieldTypeText(h.sub_market) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vertical:' + getFieldTypeText(h.vertical) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'main_country_code:' + getFieldTypeText(h.main_country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bill_country_code:' + getFieldTypeText(h.bill_country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_company_id_cnt
          ,le.populated_app_type_cnt
          ,le.populated_market_cnt
          ,le.populated_sub_market_cnt
          ,le.populated_vertical_cnt
          ,le.populated_main_country_code_cnt
          ,le.populated_bill_country_code_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_company_id_pcnt
          ,le.populated_app_type_pcnt
          ,le.populated_market_pcnt
          ,le.populated_sub_market_pcnt
          ,le.populated_vertical_pcnt
          ,le.populated_main_country_code_pcnt
          ,le.populated_bill_country_code_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,7,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := MarketAppend_Delta(prevDS, PROJECT(h, MarketAppend_Layout_MarketAppend));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),7,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(MarketAppend_Layout_MarketAppend) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_MBS, MarketAppend_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
