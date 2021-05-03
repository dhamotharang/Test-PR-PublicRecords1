IMPORT SALT311,STD;
IMPORT Scrubs_Spoke,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 7;
  EXPORT NumRulesFromFieldType := 7;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 7;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_Layout_Spoke)
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 company_state_Invalid;
    UNSIGNED1 company_postal_code_Invalid;
    UNSIGNED1 company_phone_number_Invalid;
    UNSIGNED1 company_annual_revenue_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_Spoke)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Input_Layout_Spoke)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'first_name:invalid_first_name:CUSTOM'
          ,'last_name:invalid_last_name:CUSTOM'
          ,'company_name:invalid_company_name:CUSTOM'
          ,'company_state:invalid_company_state:CUSTOM'
          ,'company_postal_code:invalid_postal_code:CUSTOM'
          ,'company_phone_number:invalid_phone_number:CUSTOM'
          ,'company_annual_revenue:invalid_annual_revenue:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Input_Fields.InvalidMessage_first_name(1)
          ,Input_Fields.InvalidMessage_last_name(1)
          ,Input_Fields.InvalidMessage_company_name(1)
          ,Input_Fields.InvalidMessage_company_state(1)
          ,Input_Fields.InvalidMessage_company_postal_code(1)
          ,Input_Fields.InvalidMessage_company_phone_number(1)
          ,Input_Fields.InvalidMessage_company_annual_revenue(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Input_Layout_Spoke) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.first_name_Invalid := Input_Fields.InValid_first_name((SALT311.StrType)le.first_name);
    SELF.last_name_Invalid := Input_Fields.InValid_last_name((SALT311.StrType)le.last_name);
    SELF.company_name_Invalid := Input_Fields.InValid_company_name((SALT311.StrType)le.company_name);
    SELF.company_state_Invalid := Input_Fields.InValid_company_state((SALT311.StrType)le.company_state);
    SELF.company_postal_code_Invalid := Input_Fields.InValid_company_postal_code((SALT311.StrType)le.company_postal_code);
    SELF.company_phone_number_Invalid := Input_Fields.InValid_company_phone_number((SALT311.StrType)le.company_phone_number);
    SELF.company_annual_revenue_Invalid := Input_Fields.InValid_company_annual_revenue((SALT311.StrType)le.company_annual_revenue);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_Spoke);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.first_name_Invalid << 0 ) + ( le.last_name_Invalid << 1 ) + ( le.company_name_Invalid << 2 ) + ( le.company_state_Invalid << 3 ) + ( le.company_postal_code_Invalid << 4 ) + ( le.company_phone_number_Invalid << 5 ) + ( le.company_annual_revenue_Invalid << 6 );
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
  EXPORT Infile := PROJECT(h,Input_Layout_Spoke);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.company_state_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.company_postal_code_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.company_phone_number_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.company_annual_revenue_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    company_state_CUSTOM_ErrorCount := COUNT(GROUP,h.company_state_Invalid=1);
    company_postal_code_CUSTOM_ErrorCount := COUNT(GROUP,h.company_postal_code_Invalid=1);
    company_phone_number_CUSTOM_ErrorCount := COUNT(GROUP,h.company_phone_number_Invalid=1);
    company_annual_revenue_CUSTOM_ErrorCount := COUNT(GROUP,h.company_annual_revenue_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.first_name_Invalid > 0 OR h.last_name_Invalid > 0 OR h.company_name_Invalid > 0 OR h.company_state_Invalid > 0 OR h.company_postal_code_Invalid > 0 OR h.company_phone_number_Invalid > 0 OR h.company_annual_revenue_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_postal_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_phone_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_annual_revenue_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_postal_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_phone_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_annual_revenue_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.first_name_Invalid,le.last_name_Invalid,le.company_name_Invalid,le.company_state_Invalid,le.company_postal_code_Invalid,le.company_phone_number_Invalid,le.company_annual_revenue_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_first_name(le.first_name_Invalid),Input_Fields.InvalidMessage_last_name(le.last_name_Invalid),Input_Fields.InvalidMessage_company_name(le.company_name_Invalid),Input_Fields.InvalidMessage_company_state(le.company_state_Invalid),Input_Fields.InvalidMessage_company_postal_code(le.company_postal_code_Invalid),Input_Fields.InvalidMessage_company_phone_number(le.company_phone_number_Invalid),Input_Fields.InvalidMessage_company_annual_revenue(le.company_annual_revenue_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_postal_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_phone_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_annual_revenue_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'first_name','last_name','company_name','company_state','company_postal_code','company_phone_number','company_annual_revenue','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_first_name','invalid_last_name','invalid_company_name','invalid_company_state','invalid_postal_code','invalid_phone_number','invalid_annual_revenue','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.first_name,(SALT311.StrType)le.last_name,(SALT311.StrType)le.company_name,(SALT311.StrType)le.company_state,(SALT311.StrType)le.company_postal_code,(SALT311.StrType)le.company_phone_number,(SALT311.StrType)le.company_annual_revenue,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_Layout_Spoke) prevDS = DATASET([], Input_Layout_Spoke), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.first_name_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.company_state_CUSTOM_ErrorCount
          ,le.company_postal_code_CUSTOM_ErrorCount
          ,le.company_phone_number_CUSTOM_ErrorCount
          ,le.company_annual_revenue_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.first_name_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.company_state_CUSTOM_ErrorCount
          ,le.company_postal_code_CUSTOM_ErrorCount
          ,le.company_phone_number_CUSTOM_ErrorCount
          ,le.company_annual_revenue_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_hygiene(PROJECT(h, Input_Layout_Spoke));
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
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'job_title:' + getFieldTypeText(h.job_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'validation_date:' + getFieldTypeText(h.validation_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_street_address:' + getFieldTypeText(h.company_street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_city:' + getFieldTypeText(h.company_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_state:' + getFieldTypeText(h.company_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_postal_code:' + getFieldTypeText(h.company_postal_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_phone_number:' + getFieldTypeText(h.company_phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_annual_revenue:' + getFieldTypeText(h.company_annual_revenue) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_business_description:' + getFieldTypeText(h.company_business_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_first_name_cnt
          ,le.populated_last_name_cnt
          ,le.populated_job_title_cnt
          ,le.populated_company_name_cnt
          ,le.populated_validation_date_cnt
          ,le.populated_company_street_address_cnt
          ,le.populated_company_city_cnt
          ,le.populated_company_state_cnt
          ,le.populated_company_postal_code_cnt
          ,le.populated_company_phone_number_cnt
          ,le.populated_company_annual_revenue_cnt
          ,le.populated_company_business_description_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_first_name_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_job_title_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_validation_date_pcnt
          ,le.populated_company_street_address_pcnt
          ,le.populated_company_city_pcnt
          ,le.populated_company_state_pcnt
          ,le.populated_company_postal_code_pcnt
          ,le.populated_company_phone_number_pcnt
          ,le.populated_company_annual_revenue_pcnt
          ,le.populated_company_business_description_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,12,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_Delta(prevDS, PROJECT(h, Input_Layout_Spoke));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),12,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_Layout_Spoke) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Spoke, Input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
