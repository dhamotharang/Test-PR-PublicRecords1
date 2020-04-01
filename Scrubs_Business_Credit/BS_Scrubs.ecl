IMPORT SALT311,STD;
EXPORT BS_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 14;
  EXPORT NumRulesFromFieldType := 14;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(BS_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 parent_sequence_number_Invalid;
    UNSIGNED1 account_base_number_Invalid;
    UNSIGNED1 business_name_Invalid;
    UNSIGNED1 web_address_Invalid;
    UNSIGNED1 guarantor_owner_indicator_Invalid;
    UNSIGNED1 relationship_to_business_indicator_Invalid;
    UNSIGNED1 percent_of_liability_Invalid;
    UNSIGNED1 percent_of_ownership_if_owner_principal_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(BS_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(BS_Layout_Business_Credit)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'segment_identifier:invalid_segment_identifier:ENUM'
          ,'file_sequence_number:invalid_file_sequence_number:ALLOW','file_sequence_number:invalid_file_sequence_number:LENGTHS'
          ,'parent_sequence_number:invalid_parent_sequence_number:ALLOW','parent_sequence_number:invalid_parent_sequence_number:LENGTHS'
          ,'account_base_number:invalid_account_base_ab_number:ALLOW','account_base_number:invalid_account_base_ab_number:LENGTHS'
          ,'business_name:invalid_business_name:ALLOW','business_name:invalid_business_name:LENGTHS'
          ,'web_address:invalid_web_address:ALLOW'
          ,'guarantor_owner_indicator:invalid_guarantor_owner_indicator:ENUM'
          ,'relationship_to_business_indicator:invalid_relationship_to_business_indicator:ALLOW'
          ,'percent_of_liability:invalid_percent_of_liability:ALLOW'
          ,'percent_of_ownership_if_owner_principal:invalid_percent_of_ownership_if_owner_principal:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,BS_Fields.InvalidMessage_segment_identifier(1)
          ,BS_Fields.InvalidMessage_file_sequence_number(1),BS_Fields.InvalidMessage_file_sequence_number(2)
          ,BS_Fields.InvalidMessage_parent_sequence_number(1),BS_Fields.InvalidMessage_parent_sequence_number(2)
          ,BS_Fields.InvalidMessage_account_base_number(1),BS_Fields.InvalidMessage_account_base_number(2)
          ,BS_Fields.InvalidMessage_business_name(1),BS_Fields.InvalidMessage_business_name(2)
          ,BS_Fields.InvalidMessage_web_address(1)
          ,BS_Fields.InvalidMessage_guarantor_owner_indicator(1)
          ,BS_Fields.InvalidMessage_relationship_to_business_indicator(1)
          ,BS_Fields.InvalidMessage_percent_of_liability(1)
          ,BS_Fields.InvalidMessage_percent_of_ownership_if_owner_principal(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(BS_Layout_Business_Credit) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.segment_identifier_Invalid := BS_Fields.InValid_segment_identifier((SALT311.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := BS_Fields.InValid_file_sequence_number((SALT311.StrType)le.file_sequence_number);
    SELF.parent_sequence_number_Invalid := BS_Fields.InValid_parent_sequence_number((SALT311.StrType)le.parent_sequence_number);
    SELF.account_base_number_Invalid := BS_Fields.InValid_account_base_number((SALT311.StrType)le.account_base_number);
    SELF.business_name_Invalid := BS_Fields.InValid_business_name((SALT311.StrType)le.business_name);
    SELF.web_address_Invalid := BS_Fields.InValid_web_address((SALT311.StrType)le.web_address);
    SELF.guarantor_owner_indicator_Invalid := BS_Fields.InValid_guarantor_owner_indicator((SALT311.StrType)le.guarantor_owner_indicator);
    SELF.relationship_to_business_indicator_Invalid := BS_Fields.InValid_relationship_to_business_indicator((SALT311.StrType)le.relationship_to_business_indicator);
    SELF.percent_of_liability_Invalid := BS_Fields.InValid_percent_of_liability((SALT311.StrType)le.percent_of_liability);
    SELF.percent_of_ownership_if_owner_principal_Invalid := BS_Fields.InValid_percent_of_ownership_if_owner_principal((SALT311.StrType)le.percent_of_ownership_if_owner_principal);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),BS_Layout_Business_Credit);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.parent_sequence_number_Invalid << 3 ) + ( le.account_base_number_Invalid << 5 ) + ( le.business_name_Invalid << 7 ) + ( le.web_address_Invalid << 9 ) + ( le.guarantor_owner_indicator_Invalid << 10 ) + ( le.relationship_to_business_indicator_Invalid << 11 ) + ( le.percent_of_liability_Invalid << 12 ) + ( le.percent_of_ownership_if_owner_principal_Invalid << 13 );
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
  EXPORT Infile := PROJECT(h,BS_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.parent_sequence_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.account_base_number_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.business_name_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.web_address_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.guarantor_owner_indicator_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.relationship_to_business_indicator_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.percent_of_liability_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.percent_of_ownership_if_owner_principal_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    segment_identifier_ENUM_ErrorCount := COUNT(GROUP,h.segment_identifier_Invalid=1);
    file_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid=1);
    file_sequence_number_LENGTHS_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid=2);
    file_sequence_number_Total_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid>0);
    parent_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid=1);
    parent_sequence_number_LENGTHS_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid=2);
    parent_sequence_number_Total_ErrorCount := COUNT(GROUP,h.parent_sequence_number_Invalid>0);
    account_base_number_ALLOW_ErrorCount := COUNT(GROUP,h.account_base_number_Invalid=1);
    account_base_number_LENGTHS_ErrorCount := COUNT(GROUP,h.account_base_number_Invalid=2);
    account_base_number_Total_ErrorCount := COUNT(GROUP,h.account_base_number_Invalid>0);
    business_name_ALLOW_ErrorCount := COUNT(GROUP,h.business_name_Invalid=1);
    business_name_LENGTHS_ErrorCount := COUNT(GROUP,h.business_name_Invalid=2);
    business_name_Total_ErrorCount := COUNT(GROUP,h.business_name_Invalid>0);
    web_address_ALLOW_ErrorCount := COUNT(GROUP,h.web_address_Invalid=1);
    guarantor_owner_indicator_ENUM_ErrorCount := COUNT(GROUP,h.guarantor_owner_indicator_Invalid=1);
    relationship_to_business_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.relationship_to_business_indicator_Invalid=1);
    percent_of_liability_ALLOW_ErrorCount := COUNT(GROUP,h.percent_of_liability_Invalid=1);
    percent_of_ownership_if_owner_principal_ALLOW_ErrorCount := COUNT(GROUP,h.percent_of_ownership_if_owner_principal_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.segment_identifier_Invalid > 0 OR h.file_sequence_number_Invalid > 0 OR h.parent_sequence_number_Invalid > 0 OR h.account_base_number_Invalid > 0 OR h.business_name_Invalid > 0 OR h.web_address_Invalid > 0 OR h.guarantor_owner_indicator_Invalid > 0 OR h.relationship_to_business_indicator_Invalid > 0 OR h.percent_of_liability_Invalid > 0 OR h.percent_of_ownership_if_owner_principal_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.segment_identifier_ENUM_ErrorCount > 0, 1, 0) + IF(le.file_sequence_number_Total_ErrorCount > 0, 1, 0) + IF(le.parent_sequence_number_Total_ErrorCount > 0, 1, 0) + IF(le.account_base_number_Total_ErrorCount > 0, 1, 0) + IF(le.business_name_Total_ErrorCount > 0, 1, 0) + IF(le.web_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.guarantor_owner_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.relationship_to_business_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.percent_of_liability_ALLOW_ErrorCount > 0, 1, 0) + IF(le.percent_of_ownership_if_owner_principal_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.segment_identifier_ENUM_ErrorCount > 0, 1, 0) + IF(le.file_sequence_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_sequence_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.parent_sequence_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parent_sequence_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.account_base_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.account_base_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.business_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.business_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.web_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.guarantor_owner_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.relationship_to_business_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.percent_of_liability_ALLOW_ErrorCount > 0, 1, 0) + IF(le.percent_of_ownership_if_owner_principal_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.parent_sequence_number_Invalid,le.account_base_number_Invalid,le.business_name_Invalid,le.web_address_Invalid,le.guarantor_owner_indicator_Invalid,le.relationship_to_business_indicator_Invalid,le.percent_of_liability_Invalid,le.percent_of_ownership_if_owner_principal_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,BS_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),BS_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),BS_Fields.InvalidMessage_parent_sequence_number(le.parent_sequence_number_Invalid),BS_Fields.InvalidMessage_account_base_number(le.account_base_number_Invalid),BS_Fields.InvalidMessage_business_name(le.business_name_Invalid),BS_Fields.InvalidMessage_web_address(le.web_address_Invalid),BS_Fields.InvalidMessage_guarantor_owner_indicator(le.guarantor_owner_indicator_Invalid),BS_Fields.InvalidMessage_relationship_to_business_indicator(le.relationship_to_business_indicator_Invalid),BS_Fields.InvalidMessage_percent_of_liability(le.percent_of_liability_Invalid),BS_Fields.InvalidMessage_percent_of_ownership_if_owner_principal(le.percent_of_ownership_if_owner_principal_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.parent_sequence_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.account_base_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.business_name_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.web_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.guarantor_owner_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.relationship_to_business_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.percent_of_liability_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.percent_of_ownership_if_owner_principal_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','business_name','web_address','guarantor_owner_indicator','relationship_to_business_indicator','percent_of_liability','percent_of_ownership_if_owner_principal','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_file_sequence_number','invalid_parent_sequence_number','invalid_account_base_ab_number','invalid_business_name','invalid_web_address','invalid_guarantor_owner_indicator','invalid_relationship_to_business_indicator','invalid_percent_of_liability','invalid_percent_of_ownership_if_owner_principal','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.segment_identifier,(SALT311.StrType)le.file_sequence_number,(SALT311.StrType)le.parent_sequence_number,(SALT311.StrType)le.account_base_number,(SALT311.StrType)le.business_name,(SALT311.StrType)le.web_address,(SALT311.StrType)le.guarantor_owner_indicator,(SALT311.StrType)le.relationship_to_business_indicator,(SALT311.StrType)le.percent_of_liability,(SALT311.StrType)le.percent_of_ownership_if_owner_principal,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(BS_Layout_Business_Credit) prevDS = DATASET([], BS_Layout_Business_Credit), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTHS_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTHS_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTHS_ErrorCount
          ,le.business_name_ALLOW_ErrorCount,le.business_name_LENGTHS_ErrorCount
          ,le.web_address_ALLOW_ErrorCount
          ,le.guarantor_owner_indicator_ENUM_ErrorCount
          ,le.relationship_to_business_indicator_ALLOW_ErrorCount
          ,le.percent_of_liability_ALLOW_ErrorCount
          ,le.percent_of_ownership_if_owner_principal_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTHS_ErrorCount
          ,le.parent_sequence_number_ALLOW_ErrorCount,le.parent_sequence_number_LENGTHS_ErrorCount
          ,le.account_base_number_ALLOW_ErrorCount,le.account_base_number_LENGTHS_ErrorCount
          ,le.business_name_ALLOW_ErrorCount,le.business_name_LENGTHS_ErrorCount
          ,le.web_address_ALLOW_ErrorCount
          ,le.guarantor_owner_indicator_ENUM_ErrorCount
          ,le.relationship_to_business_indicator_ALLOW_ErrorCount
          ,le.percent_of_liability_ALLOW_ErrorCount
          ,le.percent_of_ownership_if_owner_principal_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := BS_hygiene(PROJECT(h, BS_Layout_Business_Credit));
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
          ,'segment_identifier:' + getFieldTypeText(h.segment_identifier) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_sequence_number:' + getFieldTypeText(h.file_sequence_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parent_sequence_number:' + getFieldTypeText(h.parent_sequence_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_base_number:' + getFieldTypeText(h.account_base_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_name:' + getFieldTypeText(h.business_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'web_address:' + getFieldTypeText(h.web_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'guarantor_owner_indicator:' + getFieldTypeText(h.guarantor_owner_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relationship_to_business_indicator:' + getFieldTypeText(h.relationship_to_business_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'percent_of_liability:' + getFieldTypeText(h.percent_of_liability) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'percent_of_ownership_if_owner_principal:' + getFieldTypeText(h.percent_of_ownership_if_owner_principal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_segment_identifier_cnt
          ,le.populated_file_sequence_number_cnt
          ,le.populated_parent_sequence_number_cnt
          ,le.populated_account_base_number_cnt
          ,le.populated_business_name_cnt
          ,le.populated_web_address_cnt
          ,le.populated_guarantor_owner_indicator_cnt
          ,le.populated_relationship_to_business_indicator_cnt
          ,le.populated_percent_of_liability_cnt
          ,le.populated_percent_of_ownership_if_owner_principal_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_segment_identifier_pcnt
          ,le.populated_file_sequence_number_pcnt
          ,le.populated_parent_sequence_number_pcnt
          ,le.populated_account_base_number_pcnt
          ,le.populated_business_name_pcnt
          ,le.populated_web_address_pcnt
          ,le.populated_guarantor_owner_indicator_pcnt
          ,le.populated_relationship_to_business_indicator_pcnt
          ,le.populated_percent_of_liability_pcnt
          ,le.populated_percent_of_ownership_if_owner_principal_pcnt,0);
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
 
    mod_Delta := BS_Delta(prevDS, PROJECT(h, BS_Layout_Business_Credit));
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
 
EXPORT StandardStats(DATASET(BS_Layout_Business_Credit) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Business_Credit, BS_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
