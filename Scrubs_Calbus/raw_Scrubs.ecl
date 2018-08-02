IMPORT SALT38,STD;
IMPORT Scrubs_Calbus; // Import modules for FieldTypes attribute definitions
EXPORT raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 16;
  EXPORT NumRulesFromFieldType := 16;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 16;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(raw_Layout_Calbus)
    UNSIGNED1 district_branch_Invalid;
    UNSIGNED1 account_number_Invalid;
    UNSIGNED1 sub_account_number_Invalid;
    UNSIGNED1 district_Invalid;
    UNSIGNED1 account_type_Invalid;
    UNSIGNED1 firm_name_Invalid;
    UNSIGNED1 owner_name_Invalid;
    UNSIGNED1 business_street_Invalid;
    UNSIGNED1 business_city_Invalid;
    UNSIGNED1 business_state_Invalid;
    UNSIGNED1 business_zip_5_Invalid;
    UNSIGNED1 business_zip_plus_4_Invalid;
    UNSIGNED1 business_foreign_zip_Invalid;
    UNSIGNED1 business_country_name_Invalid;
    UNSIGNED1 start_date_Invalid;
    UNSIGNED1 ownership_code_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(raw_Layout_Calbus)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(raw_Layout_Calbus) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.district_branch_Invalid := raw_Fields.InValid_district_branch((SALT38.StrType)le.district_branch);
    SELF.account_number_Invalid := raw_Fields.InValid_account_number((SALT38.StrType)le.account_number);
    SELF.sub_account_number_Invalid := raw_Fields.InValid_sub_account_number((SALT38.StrType)le.sub_account_number);
    SELF.district_Invalid := raw_Fields.InValid_district((SALT38.StrType)le.district);
    SELF.account_type_Invalid := raw_Fields.InValid_account_type((SALT38.StrType)le.account_type);
    SELF.firm_name_Invalid := raw_Fields.InValid_firm_name((SALT38.StrType)le.firm_name);
    SELF.owner_name_Invalid := raw_Fields.InValid_owner_name((SALT38.StrType)le.owner_name);
    SELF.business_street_Invalid := raw_Fields.InValid_business_street((SALT38.StrType)le.business_street);
    SELF.business_city_Invalid := raw_Fields.InValid_business_city((SALT38.StrType)le.business_city);
    SELF.business_state_Invalid := raw_Fields.InValid_business_state((SALT38.StrType)le.business_state);
    SELF.business_zip_5_Invalid := raw_Fields.InValid_business_zip_5((SALT38.StrType)le.business_zip_5);
    SELF.business_zip_plus_4_Invalid := raw_Fields.InValid_business_zip_plus_4((SALT38.StrType)le.business_zip_plus_4);
    SELF.business_foreign_zip_Invalid := raw_Fields.InValid_business_foreign_zip((SALT38.StrType)le.business_foreign_zip);
    SELF.business_country_name_Invalid := raw_Fields.InValid_business_country_name((SALT38.StrType)le.business_country_name);
    SELF.start_date_Invalid := raw_Fields.InValid_start_date((SALT38.StrType)le.start_date);
    SELF.ownership_code_Invalid := raw_Fields.InValid_ownership_code((SALT38.StrType)le.ownership_code);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),raw_Layout_Calbus);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.district_branch_Invalid << 0 ) + ( le.account_number_Invalid << 1 ) + ( le.sub_account_number_Invalid << 2 ) + ( le.district_Invalid << 3 ) + ( le.account_type_Invalid << 4 ) + ( le.firm_name_Invalid << 5 ) + ( le.owner_name_Invalid << 6 ) + ( le.business_street_Invalid << 7 ) + ( le.business_city_Invalid << 8 ) + ( le.business_state_Invalid << 9 ) + ( le.business_zip_5_Invalid << 10 ) + ( le.business_zip_plus_4_Invalid << 11 ) + ( le.business_foreign_zip_Invalid << 12 ) + ( le.business_country_name_Invalid << 13 ) + ( le.start_date_Invalid << 14 ) + ( le.ownership_code_Invalid << 15 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,raw_Layout_Calbus);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.district_branch_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.account_number_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.sub_account_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.district_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.account_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.firm_name_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.owner_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.business_street_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.business_city_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.business_state_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.business_zip_5_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.business_zip_plus_4_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.business_foreign_zip_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.business_country_name_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.start_date_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.ownership_code_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    district_branch_CUSTOM_ErrorCount := COUNT(GROUP,h.district_branch_Invalid=1);
    account_number_CUSTOM_ErrorCount := COUNT(GROUP,h.account_number_Invalid=1);
    sub_account_number_CUSTOM_ErrorCount := COUNT(GROUP,h.sub_account_number_Invalid=1);
    district_CUSTOM_ErrorCount := COUNT(GROUP,h.district_Invalid=1);
    account_type_ALLOW_ErrorCount := COUNT(GROUP,h.account_type_Invalid=1);
    firm_name_CUSTOM_ErrorCount := COUNT(GROUP,h.firm_name_Invalid=1);
    owner_name_CUSTOM_ErrorCount := COUNT(GROUP,h.owner_name_Invalid=1);
    business_street_CUSTOM_ErrorCount := COUNT(GROUP,h.business_street_Invalid=1);
    business_city_CUSTOM_ErrorCount := COUNT(GROUP,h.business_city_Invalid=1);
    business_state_CUSTOM_ErrorCount := COUNT(GROUP,h.business_state_Invalid=1);
    business_zip_5_CUSTOM_ErrorCount := COUNT(GROUP,h.business_zip_5_Invalid=1);
    business_zip_plus_4_CUSTOM_ErrorCount := COUNT(GROUP,h.business_zip_plus_4_Invalid=1);
    business_foreign_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.business_foreign_zip_Invalid=1);
    business_country_name_ALLOW_ErrorCount := COUNT(GROUP,h.business_country_name_Invalid=1);
    start_date_CUSTOM_ErrorCount := COUNT(GROUP,h.start_date_Invalid=1);
    ownership_code_ALLOW_ErrorCount := COUNT(GROUP,h.ownership_code_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.district_branch_Invalid > 0 OR h.account_number_Invalid > 0 OR h.sub_account_number_Invalid > 0 OR h.district_Invalid > 0 OR h.account_type_Invalid > 0 OR h.firm_name_Invalid > 0 OR h.owner_name_Invalid > 0 OR h.business_street_Invalid > 0 OR h.business_city_Invalid > 0 OR h.business_state_Invalid > 0 OR h.business_zip_5_Invalid > 0 OR h.business_zip_plus_4_Invalid > 0 OR h.business_foreign_zip_Invalid > 0 OR h.business_country_name_Invalid > 0 OR h.start_date_Invalid > 0 OR h.ownership_code_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.district_branch_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sub_account_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.district_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firm_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.owner_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_street_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_zip_5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_zip_plus_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_foreign_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_country_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.start_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ownership_code_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.district_branch_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sub_account_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.district_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.account_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firm_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.owner_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_street_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_zip_5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_zip_plus_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_foreign_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_country_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.start_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ownership_code_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.district_branch_Invalid,le.account_number_Invalid,le.sub_account_number_Invalid,le.district_Invalid,le.account_type_Invalid,le.firm_name_Invalid,le.owner_name_Invalid,le.business_street_Invalid,le.business_city_Invalid,le.business_state_Invalid,le.business_zip_5_Invalid,le.business_zip_plus_4_Invalid,le.business_foreign_zip_Invalid,le.business_country_name_Invalid,le.start_date_Invalid,le.ownership_code_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,raw_Fields.InvalidMessage_district_branch(le.district_branch_Invalid),raw_Fields.InvalidMessage_account_number(le.account_number_Invalid),raw_Fields.InvalidMessage_sub_account_number(le.sub_account_number_Invalid),raw_Fields.InvalidMessage_district(le.district_Invalid),raw_Fields.InvalidMessage_account_type(le.account_type_Invalid),raw_Fields.InvalidMessage_firm_name(le.firm_name_Invalid),raw_Fields.InvalidMessage_owner_name(le.owner_name_Invalid),raw_Fields.InvalidMessage_business_street(le.business_street_Invalid),raw_Fields.InvalidMessage_business_city(le.business_city_Invalid),raw_Fields.InvalidMessage_business_state(le.business_state_Invalid),raw_Fields.InvalidMessage_business_zip_5(le.business_zip_5_Invalid),raw_Fields.InvalidMessage_business_zip_plus_4(le.business_zip_plus_4_Invalid),raw_Fields.InvalidMessage_business_foreign_zip(le.business_foreign_zip_Invalid),raw_Fields.InvalidMessage_business_country_name(le.business_country_name_Invalid),raw_Fields.InvalidMessage_start_date(le.start_date_Invalid),raw_Fields.InvalidMessage_ownership_code(le.ownership_code_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.district_branch_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.account_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sub_account_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.district_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.account_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.firm_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.owner_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_street_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_zip_5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_zip_plus_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_foreign_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_country_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.start_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ownership_code_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'district_branch','account_number','sub_account_number','district','account_type','firm_name','owner_name','business_street','business_city','business_state','business_zip_5','business_zip_plus_4','business_foreign_zip','business_country_name','start_date','ownership_code','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_district','invalid_numeric','invalid_numeric','invalid_district','invalid_account_type','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip_5','invalid_zip_plus_4','invalid_full_zip','invalid_country_name','invalid_start_date','invalid_ownership_code','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.district_branch,(SALT38.StrType)le.account_number,(SALT38.StrType)le.sub_account_number,(SALT38.StrType)le.district,(SALT38.StrType)le.account_type,(SALT38.StrType)le.firm_name,(SALT38.StrType)le.owner_name,(SALT38.StrType)le.business_street,(SALT38.StrType)le.business_city,(SALT38.StrType)le.business_state,(SALT38.StrType)le.business_zip_5,(SALT38.StrType)le.business_zip_plus_4,(SALT38.StrType)le.business_foreign_zip,(SALT38.StrType)le.business_country_name,(SALT38.StrType)le.start_date,(SALT38.StrType)le.ownership_code,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,16,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(raw_Layout_Calbus) prevDS = DATASET([], raw_Layout_Calbus), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'district_branch:invalid_district:CUSTOM'
          ,'account_number:invalid_numeric:CUSTOM'
          ,'sub_account_number:invalid_numeric:CUSTOM'
          ,'district:invalid_district:CUSTOM'
          ,'account_type:invalid_account_type:ALLOW'
          ,'firm_name:invalid_mandatory:CUSTOM'
          ,'owner_name:invalid_mandatory:CUSTOM'
          ,'business_street:invalid_mandatory:CUSTOM'
          ,'business_city:invalid_mandatory:CUSTOM'
          ,'business_state:invalid_state:CUSTOM'
          ,'business_zip_5:invalid_zip_5:CUSTOM'
          ,'business_zip_plus_4:invalid_zip_plus_4:CUSTOM'
          ,'business_foreign_zip:invalid_full_zip:CUSTOM'
          ,'business_country_name:invalid_country_name:ALLOW'
          ,'start_date:invalid_start_date:CUSTOM'
          ,'ownership_code:invalid_ownership_code:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,raw_Fields.InvalidMessage_district_branch(1)
          ,raw_Fields.InvalidMessage_account_number(1)
          ,raw_Fields.InvalidMessage_sub_account_number(1)
          ,raw_Fields.InvalidMessage_district(1)
          ,raw_Fields.InvalidMessage_account_type(1)
          ,raw_Fields.InvalidMessage_firm_name(1)
          ,raw_Fields.InvalidMessage_owner_name(1)
          ,raw_Fields.InvalidMessage_business_street(1)
          ,raw_Fields.InvalidMessage_business_city(1)
          ,raw_Fields.InvalidMessage_business_state(1)
          ,raw_Fields.InvalidMessage_business_zip_5(1)
          ,raw_Fields.InvalidMessage_business_zip_plus_4(1)
          ,raw_Fields.InvalidMessage_business_foreign_zip(1)
          ,raw_Fields.InvalidMessage_business_country_name(1)
          ,raw_Fields.InvalidMessage_start_date(1)
          ,raw_Fields.InvalidMessage_ownership_code(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.district_branch_CUSTOM_ErrorCount
          ,le.account_number_CUSTOM_ErrorCount
          ,le.sub_account_number_CUSTOM_ErrorCount
          ,le.district_CUSTOM_ErrorCount
          ,le.account_type_ALLOW_ErrorCount
          ,le.firm_name_CUSTOM_ErrorCount
          ,le.owner_name_CUSTOM_ErrorCount
          ,le.business_street_CUSTOM_ErrorCount
          ,le.business_city_CUSTOM_ErrorCount
          ,le.business_state_CUSTOM_ErrorCount
          ,le.business_zip_5_CUSTOM_ErrorCount
          ,le.business_zip_plus_4_CUSTOM_ErrorCount
          ,le.business_foreign_zip_CUSTOM_ErrorCount
          ,le.business_country_name_ALLOW_ErrorCount
          ,le.start_date_CUSTOM_ErrorCount
          ,le.ownership_code_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.district_branch_CUSTOM_ErrorCount
          ,le.account_number_CUSTOM_ErrorCount
          ,le.sub_account_number_CUSTOM_ErrorCount
          ,le.district_CUSTOM_ErrorCount
          ,le.account_type_ALLOW_ErrorCount
          ,le.firm_name_CUSTOM_ErrorCount
          ,le.owner_name_CUSTOM_ErrorCount
          ,le.business_street_CUSTOM_ErrorCount
          ,le.business_city_CUSTOM_ErrorCount
          ,le.business_state_CUSTOM_ErrorCount
          ,le.business_zip_5_CUSTOM_ErrorCount
          ,le.business_zip_plus_4_CUSTOM_ErrorCount
          ,le.business_foreign_zip_CUSTOM_ErrorCount
          ,le.business_country_name_ALLOW_ErrorCount
          ,le.start_date_CUSTOM_ErrorCount
          ,le.ownership_code_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := raw_hygiene(PROJECT(h, raw_Layout_Calbus));
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
          ,'district_branch:' + getFieldTypeText(h.district_branch) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_number:' + getFieldTypeText(h.account_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sub_account_number:' + getFieldTypeText(h.sub_account_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'district:' + getFieldTypeText(h.district) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_type:' + getFieldTypeText(h.account_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firm_name:' + getFieldTypeText(h.firm_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'owner_name:' + getFieldTypeText(h.owner_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_street:' + getFieldTypeText(h.business_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_city:' + getFieldTypeText(h.business_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_state:' + getFieldTypeText(h.business_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_zip_5:' + getFieldTypeText(h.business_zip_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_zip_plus_4:' + getFieldTypeText(h.business_zip_plus_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_foreign_zip:' + getFieldTypeText(h.business_foreign_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_country_name:' + getFieldTypeText(h.business_country_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'start_date:' + getFieldTypeText(h.start_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownership_code:' + getFieldTypeText(h.ownership_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_district_branch_cnt
          ,le.populated_account_number_cnt
          ,le.populated_sub_account_number_cnt
          ,le.populated_district_cnt
          ,le.populated_account_type_cnt
          ,le.populated_firm_name_cnt
          ,le.populated_owner_name_cnt
          ,le.populated_business_street_cnt
          ,le.populated_business_city_cnt
          ,le.populated_business_state_cnt
          ,le.populated_business_zip_5_cnt
          ,le.populated_business_zip_plus_4_cnt
          ,le.populated_business_foreign_zip_cnt
          ,le.populated_business_country_name_cnt
          ,le.populated_start_date_cnt
          ,le.populated_ownership_code_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_district_branch_pcnt
          ,le.populated_account_number_pcnt
          ,le.populated_sub_account_number_pcnt
          ,le.populated_district_pcnt
          ,le.populated_account_type_pcnt
          ,le.populated_firm_name_pcnt
          ,le.populated_owner_name_pcnt
          ,le.populated_business_street_pcnt
          ,le.populated_business_city_pcnt
          ,le.populated_business_state_pcnt
          ,le.populated_business_zip_5_pcnt
          ,le.populated_business_zip_plus_4_pcnt
          ,le.populated_business_foreign_zip_pcnt
          ,le.populated_business_country_name_pcnt
          ,le.populated_start_date_pcnt
          ,le.populated_ownership_code_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,16,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := raw_Delta(prevDS, PROJECT(h, raw_Layout_Calbus));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),16,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(raw_Layout_Calbus) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Calbus, raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
