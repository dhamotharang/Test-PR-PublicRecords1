IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 19;
  EXPORT NumRulesFromFieldType := 19;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 19;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_Layout_Frandx)
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 brand_name_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 franchisee_id_Invalid;
    UNSIGNED1 fruns_Invalid;
    UNSIGNED1 industry_Invalid;
    UNSIGNED1 industry_type_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone_extension_Invalid;
    UNSIGNED1 record_id_Invalid;
    UNSIGNED1 relationship_code_Invalid;
    UNSIGNED1 secondary_phone_Invalid;
    UNSIGNED1 sector_Invalid;
    UNSIGNED1 sic_code_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 unit_flag_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 zip_code4_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_Frandx)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_Layout_Frandx) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.address1_Invalid := Input_Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.brand_name_Invalid := Input_Fields.InValid_brand_name((SALT311.StrType)le.brand_name);
    SELF.city_Invalid := Input_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.company_name_Invalid := Input_Fields.InValid_company_name((SALT311.StrType)le.company_name);
    SELF.franchisee_id_Invalid := Input_Fields.InValid_franchisee_id((SALT311.StrType)le.franchisee_id);
    SELF.fruns_Invalid := Input_Fields.InValid_fruns((SALT311.StrType)le.fruns);
    SELF.industry_Invalid := Input_Fields.InValid_industry((SALT311.StrType)le.industry);
    SELF.industry_type_Invalid := Input_Fields.InValid_industry_type((SALT311.StrType)le.industry_type);
    SELF.phone_Invalid := Input_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.phone_extension_Invalid := Input_Fields.InValid_phone_extension((SALT311.StrType)le.phone_extension);
    SELF.record_id_Invalid := Input_Fields.InValid_record_id((SALT311.StrType)le.record_id);
    SELF.relationship_code_Invalid := Input_Fields.InValid_relationship_code((SALT311.StrType)le.relationship_code);
    SELF.secondary_phone_Invalid := Input_Fields.InValid_secondary_phone((SALT311.StrType)le.secondary_phone);
    SELF.sector_Invalid := Input_Fields.InValid_sector((SALT311.StrType)le.sector);
    SELF.sic_code_Invalid := Input_Fields.InValid_sic_code((SALT311.StrType)le.sic_code);
    SELF.state_Invalid := Input_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.unit_flag_Invalid := Input_Fields.InValid_unit_flag((SALT311.StrType)le.unit_flag);
    SELF.zip_code_Invalid := Input_Fields.InValid_zip_code((SALT311.StrType)le.zip_code);
    SELF.zip_code4_Invalid := Input_Fields.InValid_zip_code4((SALT311.StrType)le.zip_code4);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_Frandx);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.address1_Invalid << 0 ) + ( le.brand_name_Invalid << 1 ) + ( le.city_Invalid << 2 ) + ( le.company_name_Invalid << 3 ) + ( le.franchisee_id_Invalid << 4 ) + ( le.fruns_Invalid << 5 ) + ( le.industry_Invalid << 6 ) + ( le.industry_type_Invalid << 7 ) + ( le.phone_Invalid << 8 ) + ( le.phone_extension_Invalid << 9 ) + ( le.record_id_Invalid << 10 ) + ( le.relationship_code_Invalid << 11 ) + ( le.secondary_phone_Invalid << 12 ) + ( le.sector_Invalid << 13 ) + ( le.sic_code_Invalid << 14 ) + ( le.state_Invalid << 15 ) + ( le.unit_flag_Invalid << 16 ) + ( le.zip_code_Invalid << 17 ) + ( le.zip_code4_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_Layout_Frandx);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.address1_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.brand_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.franchisee_id_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.fruns_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.industry_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.industry_type_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.phone_extension_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.record_id_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.relationship_code_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.secondary_phone_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.sector_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.sic_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.unit_flag_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.zip_code4_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    address1_CUSTOM_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    brand_name_CUSTOM_ErrorCount := COUNT(GROUP,h.brand_name_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    franchisee_id_CUSTOM_ErrorCount := COUNT(GROUP,h.franchisee_id_Invalid=1);
    fruns_CUSTOM_ErrorCount := COUNT(GROUP,h.fruns_Invalid=1);
    industry_CUSTOM_ErrorCount := COUNT(GROUP,h.industry_Invalid=1);
    industry_type_ENUM_ErrorCount := COUNT(GROUP,h.industry_type_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_extension_ALLOW_ErrorCount := COUNT(GROUP,h.phone_extension_Invalid=1);
    record_id_CUSTOM_ErrorCount := COUNT(GROUP,h.record_id_Invalid=1);
    relationship_code_ENUM_ErrorCount := COUNT(GROUP,h.relationship_code_Invalid=1);
    secondary_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.secondary_phone_Invalid=1);
    sector_CUSTOM_ErrorCount := COUNT(GROUP,h.sector_Invalid=1);
    sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sic_code_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    unit_flag_ENUM_ErrorCount := COUNT(GROUP,h.unit_flag_Invalid=1);
    zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    zip_code4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code4_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.address1_Invalid > 0 OR h.brand_name_Invalid > 0 OR h.city_Invalid > 0 OR h.company_name_Invalid > 0 OR h.franchisee_id_Invalid > 0 OR h.fruns_Invalid > 0 OR h.industry_Invalid > 0 OR h.industry_type_Invalid > 0 OR h.phone_Invalid > 0 OR h.phone_extension_Invalid > 0 OR h.record_id_Invalid > 0 OR h.relationship_code_Invalid > 0 OR h.secondary_phone_Invalid > 0 OR h.sector_Invalid > 0 OR h.sic_code_Invalid > 0 OR h.state_Invalid > 0 OR h.unit_flag_Invalid > 0 OR h.zip_code_Invalid > 0 OR h.zip_code4_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.brand_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.franchisee_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fruns_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_extension_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.secondary_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sector_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code4_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.brand_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.franchisee_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fruns_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.industry_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_extension_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.relationship_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.secondary_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sector_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code4_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.address1_Invalid,le.brand_name_Invalid,le.city_Invalid,le.company_name_Invalid,le.franchisee_id_Invalid,le.fruns_Invalid,le.industry_Invalid,le.industry_type_Invalid,le.phone_Invalid,le.phone_extension_Invalid,le.record_id_Invalid,le.relationship_code_Invalid,le.secondary_phone_Invalid,le.sector_Invalid,le.sic_code_Invalid,le.state_Invalid,le.unit_flag_Invalid,le.zip_code_Invalid,le.zip_code4_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_address1(le.address1_Invalid),Input_Fields.InvalidMessage_brand_name(le.brand_name_Invalid),Input_Fields.InvalidMessage_city(le.city_Invalid),Input_Fields.InvalidMessage_company_name(le.company_name_Invalid),Input_Fields.InvalidMessage_franchisee_id(le.franchisee_id_Invalid),Input_Fields.InvalidMessage_fruns(le.fruns_Invalid),Input_Fields.InvalidMessage_industry(le.industry_Invalid),Input_Fields.InvalidMessage_industry_type(le.industry_type_Invalid),Input_Fields.InvalidMessage_phone(le.phone_Invalid),Input_Fields.InvalidMessage_phone_extension(le.phone_extension_Invalid),Input_Fields.InvalidMessage_record_id(le.record_id_Invalid),Input_Fields.InvalidMessage_relationship_code(le.relationship_code_Invalid),Input_Fields.InvalidMessage_secondary_phone(le.secondary_phone_Invalid),Input_Fields.InvalidMessage_sector(le.sector_Invalid),Input_Fields.InvalidMessage_sic_code(le.sic_code_Invalid),Input_Fields.InvalidMessage_state(le.state_Invalid),Input_Fields.InvalidMessage_unit_flag(le.unit_flag_Invalid),Input_Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Input_Fields.InvalidMessage_zip_code4(le.zip_code4_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.brand_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.franchisee_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fruns_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.industry_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.industry_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_extension_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.record_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.relationship_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.secondary_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sector_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.unit_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code4_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'address1','brand_name','city','company_name','franchisee_id','fruns','industry','industry_type','phone','phone_extension','record_id','relationship_code','secondary_phone','sector','sic_code','state','unit_flag','zip_code','zip_code4','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alpha','invalid_alpha','invalid_alpha','invalid_company_name','invalid_franchisee_id','invalid_fruns','invalid_alpha','invalid_industry_type','invalid_phone','invalid_numeric','invalid_nonempty_number','invalid_relationship_code','invalid_secondary_phone','invalid_alpha','invalid_sic_code','invalid_state','invalid_unit_flag','invalid_zip_code','invalid_zip_code4','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.address1,(SALT311.StrType)le.brand_name,(SALT311.StrType)le.city,(SALT311.StrType)le.company_name,(SALT311.StrType)le.franchisee_id,(SALT311.StrType)le.fruns,(SALT311.StrType)le.industry,(SALT311.StrType)le.industry_type,(SALT311.StrType)le.phone,(SALT311.StrType)le.phone_extension,(SALT311.StrType)le.record_id,(SALT311.StrType)le.relationship_code,(SALT311.StrType)le.secondary_phone,(SALT311.StrType)le.sector,(SALT311.StrType)le.sic_code,(SALT311.StrType)le.state,(SALT311.StrType)le.unit_flag,(SALT311.StrType)le.zip_code,(SALT311.StrType)le.zip_code4,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,19,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_Layout_Frandx) prevDS = DATASET([], Input_Layout_Frandx), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'address1:invalid_alpha:CUSTOM'
          ,'brand_name:invalid_alpha:CUSTOM'
          ,'city:invalid_alpha:CUSTOM'
          ,'company_name:invalid_company_name:CUSTOM'
          ,'franchisee_id:invalid_franchisee_id:CUSTOM'
          ,'fruns:invalid_fruns:CUSTOM'
          ,'industry:invalid_alpha:CUSTOM'
          ,'industry_type:invalid_industry_type:ENUM'
          ,'phone:invalid_phone:CUSTOM'
          ,'phone_extension:invalid_numeric:ALLOW'
          ,'record_id:invalid_nonempty_number:CUSTOM'
          ,'relationship_code:invalid_relationship_code:ENUM'
          ,'secondary_phone:invalid_secondary_phone:CUSTOM'
          ,'sector:invalid_alpha:CUSTOM'
          ,'sic_code:invalid_sic_code:CUSTOM'
          ,'state:invalid_state:CUSTOM'
          ,'unit_flag:invalid_unit_flag:ENUM'
          ,'zip_code:invalid_zip_code:CUSTOM'
          ,'zip_code4:invalid_zip_code4:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_Fields.InvalidMessage_address1(1)
          ,Input_Fields.InvalidMessage_brand_name(1)
          ,Input_Fields.InvalidMessage_city(1)
          ,Input_Fields.InvalidMessage_company_name(1)
          ,Input_Fields.InvalidMessage_franchisee_id(1)
          ,Input_Fields.InvalidMessage_fruns(1)
          ,Input_Fields.InvalidMessage_industry(1)
          ,Input_Fields.InvalidMessage_industry_type(1)
          ,Input_Fields.InvalidMessage_phone(1)
          ,Input_Fields.InvalidMessage_phone_extension(1)
          ,Input_Fields.InvalidMessage_record_id(1)
          ,Input_Fields.InvalidMessage_relationship_code(1)
          ,Input_Fields.InvalidMessage_secondary_phone(1)
          ,Input_Fields.InvalidMessage_sector(1)
          ,Input_Fields.InvalidMessage_sic_code(1)
          ,Input_Fields.InvalidMessage_state(1)
          ,Input_Fields.InvalidMessage_unit_flag(1)
          ,Input_Fields.InvalidMessage_zip_code(1)
          ,Input_Fields.InvalidMessage_zip_code4(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.address1_CUSTOM_ErrorCount
          ,le.brand_name_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.franchisee_id_CUSTOM_ErrorCount
          ,le.fruns_CUSTOM_ErrorCount
          ,le.industry_CUSTOM_ErrorCount
          ,le.industry_type_ENUM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.phone_extension_ALLOW_ErrorCount
          ,le.record_id_CUSTOM_ErrorCount
          ,le.relationship_code_ENUM_ErrorCount
          ,le.secondary_phone_CUSTOM_ErrorCount
          ,le.sector_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.unit_flag_ENUM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.zip_code4_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.address1_CUSTOM_ErrorCount
          ,le.brand_name_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.franchisee_id_CUSTOM_ErrorCount
          ,le.fruns_CUSTOM_ErrorCount
          ,le.industry_CUSTOM_ErrorCount
          ,le.industry_type_ENUM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.phone_extension_ALLOW_ErrorCount
          ,le.record_id_CUSTOM_ErrorCount
          ,le.relationship_code_ENUM_ErrorCount
          ,le.secondary_phone_CUSTOM_ErrorCount
          ,le.sector_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.unit_flag_ENUM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.zip_code4_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_hygiene(PROJECT(h, Input_Layout_Frandx));
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
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_name:' + getFieldTypeText(h.brand_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exec_full_name:' + getFieldTypeText(h.exec_full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'franchisee_id:' + getFieldTypeText(h.franchisee_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fruns:' + getFieldTypeText(h.fruns) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'industry:' + getFieldTypeText(h.industry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'industry_type:' + getFieldTypeText(h.industry_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_extension:' + getFieldTypeText(h.phone_extension) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_id:' + getFieldTypeText(h.record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'relationship_code:' + getFieldTypeText(h.relationship_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'secondary_phone:' + getFieldTypeText(h.secondary_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sector:' + getFieldTypeText(h.sector) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic_code:' + getFieldTypeText(h.sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_flag:' + getFieldTypeText(h.unit_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code4:' + getFieldTypeText(h.zip_code4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_brand_name_cnt
          ,le.populated_city_cnt
          ,le.populated_company_name_cnt
          ,le.populated_exec_full_name_cnt
          ,le.populated_franchisee_id_cnt
          ,le.populated_fruns_cnt
          ,le.populated_industry_cnt
          ,le.populated_industry_type_cnt
          ,le.populated_phone_cnt
          ,le.populated_phone_extension_cnt
          ,le.populated_record_id_cnt
          ,le.populated_relationship_code_cnt
          ,le.populated_secondary_phone_cnt
          ,le.populated_sector_cnt
          ,le.populated_sic_code_cnt
          ,le.populated_state_cnt
          ,le.populated_unit_flag_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_zip_code4_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_brand_name_pcnt
          ,le.populated_city_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_exec_full_name_pcnt
          ,le.populated_franchisee_id_pcnt
          ,le.populated_fruns_pcnt
          ,le.populated_industry_pcnt
          ,le.populated_industry_type_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_phone_extension_pcnt
          ,le.populated_record_id_pcnt
          ,le.populated_relationship_code_pcnt
          ,le.populated_secondary_phone_pcnt
          ,le.populated_sector_pcnt
          ,le.populated_sic_code_pcnt
          ,le.populated_state_pcnt
          ,le.populated_unit_flag_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_zip_code4_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,21,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_Delta(prevDS, PROJECT(h, Input_Layout_Frandx));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),21,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_Layout_Frandx) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Frandx, Input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
