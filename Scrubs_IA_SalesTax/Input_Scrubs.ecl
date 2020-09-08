IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_IA_SalesTax; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 8;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_Layout_IA_SalesTax)
    UNSIGNED1 permit_nbr_Invalid;
    UNSIGNED1 issue_date_Invalid;
    UNSIGNED1 owner_name_Invalid;
    UNSIGNED1 business_name_Invalid;
    UNSIGNED1 state_mailing_address_Invalid;
    UNSIGNED1 mailing_zip_code_Invalid;
    UNSIGNED1 state_of_location_Invalid;
    UNSIGNED1 location_zip_code_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_IA_SalesTax)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Input_Layout_IA_SalesTax)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'permit_nbr:invalid_permit_nbr:CUSTOM'
          ,'issue_date:invalid_issue_date:CUSTOM'
          ,'owner_name:invalid_owner_name:CUSTOM'
          ,'business_name:invalid_business_name:CUSTOM'
          ,'state_mailing_address:invalid_state:CUSTOM'
          ,'mailing_zip_code:invalid_zip:CUSTOM'
          ,'state_of_location:invalid_state:CUSTOM'
          ,'location_zip_code:invalid_zip:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Input_Fields.InvalidMessage_permit_nbr(1)
          ,Input_Fields.InvalidMessage_issue_date(1)
          ,Input_Fields.InvalidMessage_owner_name(1)
          ,Input_Fields.InvalidMessage_business_name(1)
          ,Input_Fields.InvalidMessage_state_mailing_address(1)
          ,Input_Fields.InvalidMessage_mailing_zip_code(1)
          ,Input_Fields.InvalidMessage_state_of_location(1)
          ,Input_Fields.InvalidMessage_location_zip_code(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Input_Layout_IA_SalesTax) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.permit_nbr_Invalid := Input_Fields.InValid_permit_nbr((SALT311.StrType)le.permit_nbr);
    SELF.issue_date_Invalid := Input_Fields.InValid_issue_date((SALT311.StrType)le.issue_date);
    SELF.owner_name_Invalid := Input_Fields.InValid_owner_name((SALT311.StrType)le.owner_name);
    SELF.business_name_Invalid := Input_Fields.InValid_business_name((SALT311.StrType)le.business_name);
    SELF.state_mailing_address_Invalid := Input_Fields.InValid_state_mailing_address((SALT311.StrType)le.state_mailing_address);
    SELF.mailing_zip_code_Invalid := Input_Fields.InValid_mailing_zip_code((SALT311.StrType)le.mailing_zip_code);
    SELF.state_of_location_Invalid := Input_Fields.InValid_state_of_location((SALT311.StrType)le.state_of_location);
    SELF.location_zip_code_Invalid := Input_Fields.InValid_location_zip_code((SALT311.StrType)le.location_zip_code);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_IA_SalesTax);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.permit_nbr_Invalid << 0 ) + ( le.issue_date_Invalid << 1 ) + ( le.owner_name_Invalid << 2 ) + ( le.business_name_Invalid << 3 ) + ( le.state_mailing_address_Invalid << 4 ) + ( le.mailing_zip_code_Invalid << 5 ) + ( le.state_of_location_Invalid << 6 ) + ( le.location_zip_code_Invalid << 7 );
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
  EXPORT Infile := PROJECT(h,Input_Layout_IA_SalesTax);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.permit_nbr_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.issue_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.owner_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.business_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.state_mailing_address_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.mailing_zip_code_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.state_of_location_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.location_zip_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    permit_nbr_CUSTOM_ErrorCount := COUNT(GROUP,h.permit_nbr_Invalid=1);
    issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.issue_date_Invalid=1);
    owner_name_CUSTOM_ErrorCount := COUNT(GROUP,h.owner_name_Invalid=1);
    business_name_CUSTOM_ErrorCount := COUNT(GROUP,h.business_name_Invalid=1);
    state_mailing_address_CUSTOM_ErrorCount := COUNT(GROUP,h.state_mailing_address_Invalid=1);
    mailing_zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_zip_code_Invalid=1);
    state_of_location_CUSTOM_ErrorCount := COUNT(GROUP,h.state_of_location_Invalid=1);
    location_zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.location_zip_code_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.permit_nbr_Invalid > 0 OR h.issue_date_Invalid > 0 OR h.owner_name_Invalid > 0 OR h.business_name_Invalid > 0 OR h.state_mailing_address_Invalid > 0 OR h.mailing_zip_code_Invalid > 0 OR h.state_of_location_Invalid > 0 OR h.location_zip_code_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.permit_nbr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.issue_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.owner_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_mailing_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_of_location_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.location_zip_code_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.permit_nbr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.issue_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.owner_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_mailing_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_of_location_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.location_zip_code_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.permit_nbr_Invalid,le.issue_date_Invalid,le.owner_name_Invalid,le.business_name_Invalid,le.state_mailing_address_Invalid,le.mailing_zip_code_Invalid,le.state_of_location_Invalid,le.location_zip_code_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_permit_nbr(le.permit_nbr_Invalid),Input_Fields.InvalidMessage_issue_date(le.issue_date_Invalid),Input_Fields.InvalidMessage_owner_name(le.owner_name_Invalid),Input_Fields.InvalidMessage_business_name(le.business_name_Invalid),Input_Fields.InvalidMessage_state_mailing_address(le.state_mailing_address_Invalid),Input_Fields.InvalidMessage_mailing_zip_code(le.mailing_zip_code_Invalid),Input_Fields.InvalidMessage_state_of_location(le.state_of_location_Invalid),Input_Fields.InvalidMessage_location_zip_code(le.location_zip_code_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.permit_nbr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.issue_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.owner_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_mailing_address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_of_location_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.location_zip_code_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'permit_nbr','issue_date','owner_name','business_name','state_mailing_address','mailing_zip_code','state_of_location','location_zip_code','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_permit_nbr','invalid_issue_date','invalid_owner_name','invalid_business_name','invalid_state','invalid_zip','invalid_state','invalid_zip','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.permit_nbr,(SALT311.StrType)le.issue_date,(SALT311.StrType)le.owner_name,(SALT311.StrType)le.business_name,(SALT311.StrType)le.state_mailing_address,(SALT311.StrType)le.mailing_zip_code,(SALT311.StrType)le.state_of_location,(SALT311.StrType)le.location_zip_code,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_Layout_IA_SalesTax) prevDS = DATASET([], Input_Layout_IA_SalesTax), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.permit_nbr_CUSTOM_ErrorCount
          ,le.issue_date_CUSTOM_ErrorCount
          ,le.owner_name_CUSTOM_ErrorCount
          ,le.business_name_CUSTOM_ErrorCount
          ,le.state_mailing_address_CUSTOM_ErrorCount
          ,le.mailing_zip_code_CUSTOM_ErrorCount
          ,le.state_of_location_CUSTOM_ErrorCount
          ,le.location_zip_code_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.permit_nbr_CUSTOM_ErrorCount
          ,le.issue_date_CUSTOM_ErrorCount
          ,le.owner_name_CUSTOM_ErrorCount
          ,le.business_name_CUSTOM_ErrorCount
          ,le.state_mailing_address_CUSTOM_ErrorCount
          ,le.mailing_zip_code_CUSTOM_ErrorCount
          ,le.state_of_location_CUSTOM_ErrorCount
          ,le.location_zip_code_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_hygiene(PROJECT(h, Input_Layout_IA_SalesTax));
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
          ,'permit_nbr:' + getFieldTypeText(h.permit_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'issue_date:' + getFieldTypeText(h.issue_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'owner_name:' + getFieldTypeText(h.owner_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_name:' + getFieldTypeText(h.business_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_mailing_address:' + getFieldTypeText(h.city_mailing_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_address:' + getFieldTypeText(h.mailing_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_mailing_address:' + getFieldTypeText(h.state_mailing_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_zip_code:' + getFieldTypeText(h.mailing_zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'location_address:' + getFieldTypeText(h.location_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_of_location:' + getFieldTypeText(h.city_of_location) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_of_location:' + getFieldTypeText(h.state_of_location) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'location_zip_code:' + getFieldTypeText(h.location_zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_permit_nbr_cnt
          ,le.populated_issue_date_cnt
          ,le.populated_owner_name_cnt
          ,le.populated_business_name_cnt
          ,le.populated_city_mailing_address_cnt
          ,le.populated_mailing_address_cnt
          ,le.populated_state_mailing_address_cnt
          ,le.populated_mailing_zip_code_cnt
          ,le.populated_location_address_cnt
          ,le.populated_city_of_location_cnt
          ,le.populated_state_of_location_cnt
          ,le.populated_location_zip_code_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_permit_nbr_pcnt
          ,le.populated_issue_date_pcnt
          ,le.populated_owner_name_pcnt
          ,le.populated_business_name_pcnt
          ,le.populated_city_mailing_address_pcnt
          ,le.populated_mailing_address_pcnt
          ,le.populated_state_mailing_address_pcnt
          ,le.populated_mailing_zip_code_pcnt
          ,le.populated_location_address_pcnt
          ,le.populated_city_of_location_pcnt
          ,le.populated_state_of_location_pcnt
          ,le.populated_location_zip_code_pcnt,0);
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
 
    mod_Delta := Input_Delta(prevDS, PROJECT(h, Input_Layout_IA_SalesTax));
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
 
EXPORT StandardStats(DATASET(Input_Layout_IA_SalesTax) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_IA_SalesTax, Input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
