IMPORT SALT311,STD;
IMPORT Scrubs_Txbus; // Import modules for FieldTypes attribute definitions
EXPORT Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 16;
  EXPORT NumRulesFromFieldType := 16;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 16;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Raw_Layout_Txbus)
    UNSIGNED1 taxpayer_number_Invalid;
    UNSIGNED1 outlet_number_Invalid;
    UNSIGNED1 taxpayer_name_Invalid;
    UNSIGNED1 taxpayer_state_Invalid;
    UNSIGNED1 taxpayer_zipcode_Invalid;
    UNSIGNED1 taxpayer_county_code_Invalid;
    UNSIGNED1 taxpayer_phone_Invalid;
    UNSIGNED1 outlet_name_Invalid;
    UNSIGNED1 outlet_state_Invalid;
    UNSIGNED1 outlet_zipcode_Invalid;
    UNSIGNED1 outlet_county_code_Invalid;
    UNSIGNED1 outlet_phone_Invalid;
    UNSIGNED1 outlet_naics_code_Invalid;
    UNSIGNED1 outlet_city_limits_indicator_Invalid;
    UNSIGNED1 outlet_permit_issue_date_Invalid;
    UNSIGNED1 outlet_first_sales_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Raw_Layout_Txbus)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Raw_Layout_Txbus) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.taxpayer_number_Invalid := Raw_Fields.InValid_taxpayer_number((SALT311.StrType)le.taxpayer_number);
    SELF.outlet_number_Invalid := Raw_Fields.InValid_outlet_number((SALT311.StrType)le.outlet_number);
    SELF.taxpayer_name_Invalid := Raw_Fields.InValid_taxpayer_name((SALT311.StrType)le.taxpayer_name);
    SELF.taxpayer_state_Invalid := Raw_Fields.InValid_taxpayer_state((SALT311.StrType)le.taxpayer_state);
    SELF.taxpayer_zipcode_Invalid := Raw_Fields.InValid_taxpayer_zipcode((SALT311.StrType)le.taxpayer_zipcode);
    SELF.taxpayer_county_code_Invalid := Raw_Fields.InValid_taxpayer_county_code((SALT311.StrType)le.taxpayer_county_code);
    SELF.taxpayer_phone_Invalid := Raw_Fields.InValid_taxpayer_phone((SALT311.StrType)le.taxpayer_phone);
    SELF.outlet_name_Invalid := Raw_Fields.InValid_outlet_name((SALT311.StrType)le.outlet_name);
    SELF.outlet_state_Invalid := Raw_Fields.InValid_outlet_state((SALT311.StrType)le.outlet_state);
    SELF.outlet_zipcode_Invalid := Raw_Fields.InValid_outlet_zipcode((SALT311.StrType)le.outlet_zipcode);
    SELF.outlet_county_code_Invalid := Raw_Fields.InValid_outlet_county_code((SALT311.StrType)le.outlet_county_code);
    SELF.outlet_phone_Invalid := Raw_Fields.InValid_outlet_phone((SALT311.StrType)le.outlet_phone);
    SELF.outlet_naics_code_Invalid := Raw_Fields.InValid_outlet_naics_code((SALT311.StrType)le.outlet_naics_code);
    SELF.outlet_city_limits_indicator_Invalid := Raw_Fields.InValid_outlet_city_limits_indicator((SALT311.StrType)le.outlet_city_limits_indicator);
    SELF.outlet_permit_issue_date_Invalid := Raw_Fields.InValid_outlet_permit_issue_date((SALT311.StrType)le.outlet_permit_issue_date);
    SELF.outlet_first_sales_date_Invalid := Raw_Fields.InValid_outlet_first_sales_date((SALT311.StrType)le.outlet_first_sales_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Raw_Layout_Txbus);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.taxpayer_number_Invalid << 0 ) + ( le.outlet_number_Invalid << 1 ) + ( le.taxpayer_name_Invalid << 2 ) + ( le.taxpayer_state_Invalid << 3 ) + ( le.taxpayer_zipcode_Invalid << 4 ) + ( le.taxpayer_county_code_Invalid << 5 ) + ( le.taxpayer_phone_Invalid << 6 ) + ( le.outlet_name_Invalid << 7 ) + ( le.outlet_state_Invalid << 8 ) + ( le.outlet_zipcode_Invalid << 9 ) + ( le.outlet_county_code_Invalid << 10 ) + ( le.outlet_phone_Invalid << 11 ) + ( le.outlet_naics_code_Invalid << 12 ) + ( le.outlet_city_limits_indicator_Invalid << 13 ) + ( le.outlet_permit_issue_date_Invalid << 14 ) + ( le.outlet_first_sales_date_Invalid << 15 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Raw_Layout_Txbus);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.taxpayer_number_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.outlet_number_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.taxpayer_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.taxpayer_state_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.taxpayer_zipcode_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.taxpayer_county_code_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.taxpayer_phone_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.outlet_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.outlet_state_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.outlet_zipcode_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.outlet_county_code_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.outlet_phone_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.outlet_naics_code_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.outlet_city_limits_indicator_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.outlet_permit_issue_date_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.outlet_first_sales_date_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    taxpayer_number_CUSTOM_ErrorCount := COUNT(GROUP,h.taxpayer_number_Invalid=1);
    outlet_number_CUSTOM_ErrorCount := COUNT(GROUP,h.outlet_number_Invalid=1);
    taxpayer_name_ALLOW_ErrorCount := COUNT(GROUP,h.taxpayer_name_Invalid=1);
    taxpayer_state_CUSTOM_ErrorCount := COUNT(GROUP,h.taxpayer_state_Invalid=1);
    taxpayer_zipcode_CUSTOM_ErrorCount := COUNT(GROUP,h.taxpayer_zipcode_Invalid=1);
    taxpayer_county_code_CUSTOM_ErrorCount := COUNT(GROUP,h.taxpayer_county_code_Invalid=1);
    taxpayer_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.taxpayer_phone_Invalid=1);
    outlet_name_CUSTOM_ErrorCount := COUNT(GROUP,h.outlet_name_Invalid=1);
    outlet_state_CUSTOM_ErrorCount := COUNT(GROUP,h.outlet_state_Invalid=1);
    outlet_zipcode_CUSTOM_ErrorCount := COUNT(GROUP,h.outlet_zipcode_Invalid=1);
    outlet_county_code_CUSTOM_ErrorCount := COUNT(GROUP,h.outlet_county_code_Invalid=1);
    outlet_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.outlet_phone_Invalid=1);
    outlet_naics_code_CUSTOM_ErrorCount := COUNT(GROUP,h.outlet_naics_code_Invalid=1);
    outlet_city_limits_indicator_ENUM_ErrorCount := COUNT(GROUP,h.outlet_city_limits_indicator_Invalid=1);
    outlet_permit_issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.outlet_permit_issue_date_Invalid=1);
    outlet_first_sales_date_CUSTOM_ErrorCount := COUNT(GROUP,h.outlet_first_sales_date_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.taxpayer_number_Invalid > 0 OR h.outlet_number_Invalid > 0 OR h.taxpayer_name_Invalid > 0 OR h.taxpayer_state_Invalid > 0 OR h.taxpayer_zipcode_Invalid > 0 OR h.taxpayer_county_code_Invalid > 0 OR h.taxpayer_phone_Invalid > 0 OR h.outlet_name_Invalid > 0 OR h.outlet_state_Invalid > 0 OR h.outlet_zipcode_Invalid > 0 OR h.outlet_county_code_Invalid > 0 OR h.outlet_phone_Invalid > 0 OR h.outlet_naics_code_Invalid > 0 OR h.outlet_city_limits_indicator_Invalid > 0 OR h.outlet_permit_issue_date_Invalid > 0 OR h.outlet_first_sales_date_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.taxpayer_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.taxpayer_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.taxpayer_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.taxpayer_zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.taxpayer_county_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.taxpayer_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_county_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_city_limits_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.outlet_permit_issue_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_first_sales_date_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.taxpayer_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.taxpayer_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.taxpayer_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.taxpayer_zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.taxpayer_county_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.taxpayer_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_county_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_city_limits_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.outlet_permit_issue_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.outlet_first_sales_date_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.taxpayer_number_Invalid,le.outlet_number_Invalid,le.taxpayer_name_Invalid,le.taxpayer_state_Invalid,le.taxpayer_zipcode_Invalid,le.taxpayer_county_code_Invalid,le.taxpayer_phone_Invalid,le.outlet_name_Invalid,le.outlet_state_Invalid,le.outlet_zipcode_Invalid,le.outlet_county_code_Invalid,le.outlet_phone_Invalid,le.outlet_naics_code_Invalid,le.outlet_city_limits_indicator_Invalid,le.outlet_permit_issue_date_Invalid,le.outlet_first_sales_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Raw_Fields.InvalidMessage_taxpayer_number(le.taxpayer_number_Invalid),Raw_Fields.InvalidMessage_outlet_number(le.outlet_number_Invalid),Raw_Fields.InvalidMessage_taxpayer_name(le.taxpayer_name_Invalid),Raw_Fields.InvalidMessage_taxpayer_state(le.taxpayer_state_Invalid),Raw_Fields.InvalidMessage_taxpayer_zipcode(le.taxpayer_zipcode_Invalid),Raw_Fields.InvalidMessage_taxpayer_county_code(le.taxpayer_county_code_Invalid),Raw_Fields.InvalidMessage_taxpayer_phone(le.taxpayer_phone_Invalid),Raw_Fields.InvalidMessage_outlet_name(le.outlet_name_Invalid),Raw_Fields.InvalidMessage_outlet_state(le.outlet_state_Invalid),Raw_Fields.InvalidMessage_outlet_zipcode(le.outlet_zipcode_Invalid),Raw_Fields.InvalidMessage_outlet_county_code(le.outlet_county_code_Invalid),Raw_Fields.InvalidMessage_outlet_phone(le.outlet_phone_Invalid),Raw_Fields.InvalidMessage_outlet_naics_code(le.outlet_naics_code_Invalid),Raw_Fields.InvalidMessage_outlet_city_limits_indicator(le.outlet_city_limits_indicator_Invalid),Raw_Fields.InvalidMessage_outlet_permit_issue_date(le.outlet_permit_issue_date_Invalid),Raw_Fields.InvalidMessage_outlet_first_sales_date(le.outlet_first_sales_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.taxpayer_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.outlet_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.taxpayer_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.taxpayer_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.taxpayer_zipcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.taxpayer_county_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.taxpayer_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.outlet_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.outlet_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.outlet_zipcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.outlet_county_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.outlet_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.outlet_naics_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.outlet_city_limits_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.outlet_permit_issue_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.outlet_first_sales_date_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'taxpayer_number','outlet_number','taxpayer_name','taxpayer_state','taxpayer_zipcode','taxpayer_county_code','taxpayer_phone','outlet_name','outlet_state','outlet_zipcode','outlet_county_code','outlet_phone','outlet_naics_code','outlet_city_limits_indicator','outlet_permit_issue_date','outlet_first_sales_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_taxpayer_number','invalid_outlet_number','invalid_taxpayer_name','invalid_taxpayer_state','invalid_taxpayer_zipcode','invalid_taxpayer_zipcode','invalid_taxpayer_zipcode','invalid_taxpayer_zipcode','invalid_outlet_state','invalid_outlet_zipcode','invalid_outlet_county_code','invalid_outlet_phone','invalid_outlet_naics_code','invalid_outlet_city_limits_indicator','invalid_outlet_permit_issue_date','invalid_outlet_first_sales_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.taxpayer_number,(SALT311.StrType)le.outlet_number,(SALT311.StrType)le.taxpayer_name,(SALT311.StrType)le.taxpayer_state,(SALT311.StrType)le.taxpayer_zipcode,(SALT311.StrType)le.taxpayer_county_code,(SALT311.StrType)le.taxpayer_phone,(SALT311.StrType)le.outlet_name,(SALT311.StrType)le.outlet_state,(SALT311.StrType)le.outlet_zipcode,(SALT311.StrType)le.outlet_county_code,(SALT311.StrType)le.outlet_phone,(SALT311.StrType)le.outlet_naics_code,(SALT311.StrType)le.outlet_city_limits_indicator,(SALT311.StrType)le.outlet_permit_issue_date,(SALT311.StrType)le.outlet_first_sales_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,16,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Raw_Layout_Txbus) prevDS = DATASET([], Raw_Layout_Txbus), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'taxpayer_number:invalid_taxpayer_number:CUSTOM'
          ,'outlet_number:invalid_outlet_number:CUSTOM'
          ,'taxpayer_name:invalid_taxpayer_name:ALLOW'
          ,'taxpayer_state:invalid_taxpayer_state:CUSTOM'
          ,'taxpayer_zipcode:invalid_taxpayer_zipcode:CUSTOM'
          ,'taxpayer_county_code:invalid_taxpayer_zipcode:CUSTOM'
          ,'taxpayer_phone:invalid_taxpayer_zipcode:CUSTOM'
          ,'outlet_name:invalid_taxpayer_zipcode:CUSTOM'
          ,'outlet_state:invalid_outlet_state:CUSTOM'
          ,'outlet_zipcode:invalid_outlet_zipcode:CUSTOM'
          ,'outlet_county_code:invalid_outlet_county_code:CUSTOM'
          ,'outlet_phone:invalid_outlet_phone:CUSTOM'
          ,'outlet_naics_code:invalid_outlet_naics_code:CUSTOM'
          ,'outlet_city_limits_indicator:invalid_outlet_city_limits_indicator:ENUM'
          ,'outlet_permit_issue_date:invalid_outlet_permit_issue_date:CUSTOM'
          ,'outlet_first_sales_date:invalid_outlet_first_sales_date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Raw_Fields.InvalidMessage_taxpayer_number(1)
          ,Raw_Fields.InvalidMessage_outlet_number(1)
          ,Raw_Fields.InvalidMessage_taxpayer_name(1)
          ,Raw_Fields.InvalidMessage_taxpayer_state(1)
          ,Raw_Fields.InvalidMessage_taxpayer_zipcode(1)
          ,Raw_Fields.InvalidMessage_taxpayer_county_code(1)
          ,Raw_Fields.InvalidMessage_taxpayer_phone(1)
          ,Raw_Fields.InvalidMessage_outlet_name(1)
          ,Raw_Fields.InvalidMessage_outlet_state(1)
          ,Raw_Fields.InvalidMessage_outlet_zipcode(1)
          ,Raw_Fields.InvalidMessage_outlet_county_code(1)
          ,Raw_Fields.InvalidMessage_outlet_phone(1)
          ,Raw_Fields.InvalidMessage_outlet_naics_code(1)
          ,Raw_Fields.InvalidMessage_outlet_city_limits_indicator(1)
          ,Raw_Fields.InvalidMessage_outlet_permit_issue_date(1)
          ,Raw_Fields.InvalidMessage_outlet_first_sales_date(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.taxpayer_number_CUSTOM_ErrorCount
          ,le.outlet_number_CUSTOM_ErrorCount
          ,le.taxpayer_name_ALLOW_ErrorCount
          ,le.taxpayer_state_CUSTOM_ErrorCount
          ,le.taxpayer_zipcode_CUSTOM_ErrorCount
          ,le.taxpayer_county_code_CUSTOM_ErrorCount
          ,le.taxpayer_phone_CUSTOM_ErrorCount
          ,le.outlet_name_CUSTOM_ErrorCount
          ,le.outlet_state_CUSTOM_ErrorCount
          ,le.outlet_zipcode_CUSTOM_ErrorCount
          ,le.outlet_county_code_CUSTOM_ErrorCount
          ,le.outlet_phone_CUSTOM_ErrorCount
          ,le.outlet_naics_code_CUSTOM_ErrorCount
          ,le.outlet_city_limits_indicator_ENUM_ErrorCount
          ,le.outlet_permit_issue_date_CUSTOM_ErrorCount
          ,le.outlet_first_sales_date_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.taxpayer_number_CUSTOM_ErrorCount
          ,le.outlet_number_CUSTOM_ErrorCount
          ,le.taxpayer_name_ALLOW_ErrorCount
          ,le.taxpayer_state_CUSTOM_ErrorCount
          ,le.taxpayer_zipcode_CUSTOM_ErrorCount
          ,le.taxpayer_county_code_CUSTOM_ErrorCount
          ,le.taxpayer_phone_CUSTOM_ErrorCount
          ,le.outlet_name_CUSTOM_ErrorCount
          ,le.outlet_state_CUSTOM_ErrorCount
          ,le.outlet_zipcode_CUSTOM_ErrorCount
          ,le.outlet_county_code_CUSTOM_ErrorCount
          ,le.outlet_phone_CUSTOM_ErrorCount
          ,le.outlet_naics_code_CUSTOM_ErrorCount
          ,le.outlet_city_limits_indicator_ENUM_ErrorCount
          ,le.outlet_permit_issue_date_CUSTOM_ErrorCount
          ,le.outlet_first_sales_date_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Raw_hygiene(PROJECT(h, Raw_Layout_Txbus));
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
          ,'taxpayer_number:' + getFieldTypeText(h.taxpayer_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_number:' + getFieldTypeText(h.outlet_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxpayer_name:' + getFieldTypeText(h.taxpayer_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxpayer_address:' + getFieldTypeText(h.taxpayer_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxpayer_city:' + getFieldTypeText(h.taxpayer_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxpayer_state:' + getFieldTypeText(h.taxpayer_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxpayer_zipcode:' + getFieldTypeText(h.taxpayer_zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxpayer_county_code:' + getFieldTypeText(h.taxpayer_county_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxpayer_phone:' + getFieldTypeText(h.taxpayer_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxpayer_org_type:' + getFieldTypeText(h.taxpayer_org_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_name:' + getFieldTypeText(h.outlet_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_address:' + getFieldTypeText(h.outlet_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_city:' + getFieldTypeText(h.outlet_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_state:' + getFieldTypeText(h.outlet_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_zipcode:' + getFieldTypeText(h.outlet_zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_county_code:' + getFieldTypeText(h.outlet_county_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_phone:' + getFieldTypeText(h.outlet_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_naics_code:' + getFieldTypeText(h.outlet_naics_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_city_limits_indicator:' + getFieldTypeText(h.outlet_city_limits_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_permit_issue_date:' + getFieldTypeText(h.outlet_permit_issue_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'outlet_first_sales_date:' + getFieldTypeText(h.outlet_first_sales_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crlf:' + getFieldTypeText(h.crlf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_taxpayer_number_cnt
          ,le.populated_outlet_number_cnt
          ,le.populated_taxpayer_name_cnt
          ,le.populated_taxpayer_address_cnt
          ,le.populated_taxpayer_city_cnt
          ,le.populated_taxpayer_state_cnt
          ,le.populated_taxpayer_zipcode_cnt
          ,le.populated_taxpayer_county_code_cnt
          ,le.populated_taxpayer_phone_cnt
          ,le.populated_taxpayer_org_type_cnt
          ,le.populated_outlet_name_cnt
          ,le.populated_outlet_address_cnt
          ,le.populated_outlet_city_cnt
          ,le.populated_outlet_state_cnt
          ,le.populated_outlet_zipcode_cnt
          ,le.populated_outlet_county_code_cnt
          ,le.populated_outlet_phone_cnt
          ,le.populated_outlet_naics_code_cnt
          ,le.populated_outlet_city_limits_indicator_cnt
          ,le.populated_outlet_permit_issue_date_cnt
          ,le.populated_outlet_first_sales_date_cnt
          ,le.populated_crlf_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_taxpayer_number_pcnt
          ,le.populated_outlet_number_pcnt
          ,le.populated_taxpayer_name_pcnt
          ,le.populated_taxpayer_address_pcnt
          ,le.populated_taxpayer_city_pcnt
          ,le.populated_taxpayer_state_pcnt
          ,le.populated_taxpayer_zipcode_pcnt
          ,le.populated_taxpayer_county_code_pcnt
          ,le.populated_taxpayer_phone_pcnt
          ,le.populated_taxpayer_org_type_pcnt
          ,le.populated_outlet_name_pcnt
          ,le.populated_outlet_address_pcnt
          ,le.populated_outlet_city_pcnt
          ,le.populated_outlet_state_pcnt
          ,le.populated_outlet_zipcode_pcnt
          ,le.populated_outlet_county_code_pcnt
          ,le.populated_outlet_phone_pcnt
          ,le.populated_outlet_naics_code_pcnt
          ,le.populated_outlet_city_limits_indicator_pcnt
          ,le.populated_outlet_permit_issue_date_pcnt
          ,le.populated_outlet_first_sales_date_pcnt
          ,le.populated_crlf_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,22,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Raw_Delta(prevDS, PROJECT(h, Raw_Layout_Txbus));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),22,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Raw_Layout_Txbus) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Txbus, Raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
