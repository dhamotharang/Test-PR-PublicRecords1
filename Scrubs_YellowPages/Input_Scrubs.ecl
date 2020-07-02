IMPORT SALT311,STD;
IMPORT Scrubs_YellowPages; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 13;
  EXPORT NumRulesFromFieldType := 13;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 13;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_Layout_YellowPages)
    UNSIGNED1 primary_key_Invalid;
    UNSIGNED1 pub_date_Invalid;
    UNSIGNED1 business_name_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 sic_code_Invalid;
    UNSIGNED1 sic2_Invalid;
    UNSIGNED1 sic3_Invalid;
    UNSIGNED1 sic4_Invalid;
    UNSIGNED1 naics_code_Invalid;
    UNSIGNED1 orig_phone10_Invalid;
    UNSIGNED1 validationdate_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_YellowPages)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Input_Layout_YellowPages)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'primary_key:invalid_numeric:CUSTOM'
          ,'pub_date:invalid_date:CUSTOM'
          ,'business_name:invalid_mandatory:CUSTOM'
          ,'orig_city:invalid_orig_city:CUSTOM'
          ,'orig_state:invalid_orig_state:CUSTOM'
          ,'orig_zip:invalid_orig_zip:CUSTOM'
          ,'sic_code:invalid_sic_code:CUSTOM'
          ,'sic2:invalid_sic2:CUSTOM'
          ,'sic3:invalid_sic3:CUSTOM'
          ,'sic4:invalid_sic4:CUSTOM'
          ,'naics_code:invalid_naics_code:CUSTOM'
          ,'orig_phone10:invalid_orig_phone10:CUSTOM'
          ,'validationdate:invalid_date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Input_Fields.InvalidMessage_primary_key(1)
          ,Input_Fields.InvalidMessage_pub_date(1)
          ,Input_Fields.InvalidMessage_business_name(1)
          ,Input_Fields.InvalidMessage_orig_city(1)
          ,Input_Fields.InvalidMessage_orig_state(1)
          ,Input_Fields.InvalidMessage_orig_zip(1)
          ,Input_Fields.InvalidMessage_sic_code(1)
          ,Input_Fields.InvalidMessage_sic2(1)
          ,Input_Fields.InvalidMessage_sic3(1)
          ,Input_Fields.InvalidMessage_sic4(1)
          ,Input_Fields.InvalidMessage_naics_code(1)
          ,Input_Fields.InvalidMessage_orig_phone10(1)
          ,Input_Fields.InvalidMessage_validationdate(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Input_Layout_YellowPages) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.primary_key_Invalid := Input_Fields.InValid_primary_key((SALT311.StrType)le.primary_key);
    SELF.pub_date_Invalid := Input_Fields.InValid_pub_date((SALT311.StrType)le.pub_date);
    SELF.business_name_Invalid := Input_Fields.InValid_business_name((SALT311.StrType)le.business_name);
    SELF.orig_city_Invalid := Input_Fields.InValid_orig_city((SALT311.StrType)le.orig_city,(SALT311.StrType)le.orig_state,(SALT311.StrType)le.orig_zip);
    SELF.orig_state_Invalid := Input_Fields.InValid_orig_state((SALT311.StrType)le.orig_state);
    SELF.orig_zip_Invalid := Input_Fields.InValid_orig_zip((SALT311.StrType)le.orig_zip);
    SELF.sic_code_Invalid := Input_Fields.InValid_sic_code((SALT311.StrType)le.sic_code);
    SELF.sic2_Invalid := Input_Fields.InValid_sic2((SALT311.StrType)le.sic2);
    SELF.sic3_Invalid := Input_Fields.InValid_sic3((SALT311.StrType)le.sic3);
    SELF.sic4_Invalid := Input_Fields.InValid_sic4((SALT311.StrType)le.sic4);
    SELF.naics_code_Invalid := Input_Fields.InValid_naics_code((SALT311.StrType)le.naics_code);
    SELF.orig_phone10_Invalid := Input_Fields.InValid_orig_phone10((SALT311.StrType)le.orig_phone10);
    SELF.validationdate_Invalid := Input_Fields.InValid_validationdate((SALT311.StrType)le.validationdate);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_YellowPages);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.primary_key_Invalid << 0 ) + ( le.pub_date_Invalid << 1 ) + ( le.business_name_Invalid << 2 ) + ( le.orig_city_Invalid << 3 ) + ( le.orig_state_Invalid << 4 ) + ( le.orig_zip_Invalid << 5 ) + ( le.sic_code_Invalid << 6 ) + ( le.sic2_Invalid << 7 ) + ( le.sic3_Invalid << 8 ) + ( le.sic4_Invalid << 9 ) + ( le.naics_code_Invalid << 10 ) + ( le.orig_phone10_Invalid << 11 ) + ( le.validationdate_Invalid << 12 );
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
  EXPORT Infile := PROJECT(h,Input_Layout_YellowPages);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.primary_key_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.pub_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.business_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.sic_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.sic2_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.sic3_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sic4_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.naics_code_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_phone10_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.validationdate_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    primary_key_CUSTOM_ErrorCount := COUNT(GROUP,h.primary_key_Invalid=1);
    pub_date_CUSTOM_ErrorCount := COUNT(GROUP,h.pub_date_Invalid=1);
    business_name_CUSTOM_ErrorCount := COUNT(GROUP,h.business_name_Invalid=1);
    orig_city_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_state_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sic_code_Invalid=1);
    sic2_CUSTOM_ErrorCount := COUNT(GROUP,h.sic2_Invalid=1);
    sic3_CUSTOM_ErrorCount := COUNT(GROUP,h.sic3_Invalid=1);
    sic4_CUSTOM_ErrorCount := COUNT(GROUP,h.sic4_Invalid=1);
    naics_code_CUSTOM_ErrorCount := COUNT(GROUP,h.naics_code_Invalid=1);
    orig_phone10_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_phone10_Invalid=1);
    validationdate_CUSTOM_ErrorCount := COUNT(GROUP,h.validationdate_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.primary_key_Invalid > 0 OR h.pub_date_Invalid > 0 OR h.business_name_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip_Invalid > 0 OR h.sic_code_Invalid > 0 OR h.sic2_Invalid > 0 OR h.sic3_Invalid > 0 OR h.sic4_Invalid > 0 OR h.naics_code_Invalid > 0 OR h.orig_phone10_Invalid > 0 OR h.validationdate_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.primary_key_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pub_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_phone10_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.validationdate_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.primary_key_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pub_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_phone10_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.validationdate_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.primary_key_Invalid,le.pub_date_Invalid,le.business_name_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_Invalid,le.sic_code_Invalid,le.sic2_Invalid,le.sic3_Invalid,le.sic4_Invalid,le.naics_code_Invalid,le.orig_phone10_Invalid,le.validationdate_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_primary_key(le.primary_key_Invalid),Input_Fields.InvalidMessage_pub_date(le.pub_date_Invalid),Input_Fields.InvalidMessage_business_name(le.business_name_Invalid),Input_Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Input_Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Input_Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Input_Fields.InvalidMessage_sic_code(le.sic_code_Invalid),Input_Fields.InvalidMessage_sic2(le.sic2_Invalid),Input_Fields.InvalidMessage_sic3(le.sic3_Invalid),Input_Fields.InvalidMessage_sic4(le.sic4_Invalid),Input_Fields.InvalidMessage_naics_code(le.naics_code_Invalid),Input_Fields.InvalidMessage_orig_phone10(le.orig_phone10_Invalid),Input_Fields.InvalidMessage_validationdate(le.validationdate_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.primary_key_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pub_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naics_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_phone10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.validationdate_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'primary_key','pub_date','business_name','orig_city','orig_state','orig_zip','sic_code','sic2','sic3','sic4','naics_code','orig_phone10','validationdate','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_date','invalid_mandatory','invalid_orig_city','invalid_orig_state','invalid_orig_zip','invalid_sic_code','invalid_sic2','invalid_sic3','invalid_sic4','invalid_naics_code','invalid_orig_phone10','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.primary_key,(SALT311.StrType)le.pub_date,(SALT311.StrType)le.business_name,(SALT311.StrType)le.orig_city,(SALT311.StrType)le.orig_state,(SALT311.StrType)le.orig_zip,(SALT311.StrType)le.sic_code,(SALT311.StrType)le.sic2,(SALT311.StrType)le.sic3,(SALT311.StrType)le.sic4,(SALT311.StrType)le.naics_code,(SALT311.StrType)le.orig_phone10,(SALT311.StrType)le.validationdate,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_Layout_YellowPages) prevDS = DATASET([], Input_Layout_YellowPages), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.primary_key_CUSTOM_ErrorCount
          ,le.pub_date_CUSTOM_ErrorCount
          ,le.business_name_CUSTOM_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.sic2_CUSTOM_ErrorCount
          ,le.sic3_CUSTOM_ErrorCount
          ,le.sic4_CUSTOM_ErrorCount
          ,le.naics_code_CUSTOM_ErrorCount
          ,le.orig_phone10_CUSTOM_ErrorCount
          ,le.validationdate_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.primary_key_CUSTOM_ErrorCount
          ,le.pub_date_CUSTOM_ErrorCount
          ,le.business_name_CUSTOM_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.sic2_CUSTOM_ErrorCount
          ,le.sic3_CUSTOM_ErrorCount
          ,le.sic4_CUSTOM_ErrorCount
          ,le.naics_code_CUSTOM_ErrorCount
          ,le.orig_phone10_CUSTOM_ErrorCount
          ,le.validationdate_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_hygiene(PROJECT(h, Input_Layout_YellowPages));
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
          ,'primary_key:' + getFieldTypeText(h.primary_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chainid:' + getFieldTypeText(h.chainid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler1:' + getFieldTypeText(h.filler1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pub_date:' + getFieldTypeText(h.pub_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'busshortname:' + getFieldTypeText(h.busshortname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_name:' + getFieldTypeText(h.business_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'busdeptname:' + getFieldTypeText(h.busdeptname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'house:' + getFieldTypeText(h.house) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street:' + getFieldTypeText(h.street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'streettype:' + getFieldTypeText(h.streettype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apttype:' + getFieldTypeText(h.apttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aptnbr:' + getFieldTypeText(h.aptnbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'boxnbr:' + getFieldTypeText(h.boxnbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exppubcity:' + getFieldTypeText(h.exppubcity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpc:' + getFieldTypeText(h.dpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrierroute:' + getFieldTypeText(h.carrierroute) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips:' + getFieldTypeText(h.fips) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countycode:' + getFieldTypeText(h.countycode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'z4type:' + getFieldTypeText(h.z4type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ctract:' + getFieldTypeText(h.ctract) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cblockgroup:' + getFieldTypeText(h.cblockgroup) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cblockid:' + getFieldTypeText(h.cblockid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cbsa:' + getFieldTypeText(h.cbsa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mcdcode:' + getFieldTypeText(h.mcdcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler2:' + getFieldTypeText(h.filler2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addrsensitivity:' + getFieldTypeText(h.addrsensitivity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'maildeliverabilitycode:' + getFieldTypeText(h.maildeliverabilitycode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic1_4:' + getFieldTypeText(h.sic1_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic_code:' + getFieldTypeText(h.sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic2:' + getFieldTypeText(h.sic2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic3:' + getFieldTypeText(h.sic3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic4:' + getFieldTypeText(h.sic4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'indstryclass:' + getFieldTypeText(h.indstryclass) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naics_code:' + getFieldTypeText(h.naics_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mlsc:' + getFieldTypeText(h.mlsc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler3:' + getFieldTypeText(h.filler3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_phone10:' + getFieldTypeText(h.orig_phone10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nosolicitcode:' + getFieldTypeText(h.nosolicitcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dso:' + getFieldTypeText(h.dso) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timezone:' + getFieldTypeText(h.timezone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'validationflag:' + getFieldTypeText(h.validationflag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'validationdate:' + getFieldTypeText(h.validationdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'secvalidationcode:' + getFieldTypeText(h.secvalidationcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'singleaddrflag:' + getFieldTypeText(h.singleaddrflag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler4:' + getFieldTypeText(h.filler4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'execname:' + getFieldTypeText(h.execname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exectitlecode:' + getFieldTypeText(h.exectitlecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exectitle:' + getFieldTypeText(h.exectitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'condtitlecode:' + getFieldTypeText(h.condtitlecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'condtitle:' + getFieldTypeText(h.condtitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contfunctioncode:' + getFieldTypeText(h.contfunctioncode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contfunction:' + getFieldTypeText(h.contfunction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'profession:' + getFieldTypeText(h.profession) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'emplsizecode:' + getFieldTypeText(h.emplsizecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'annualsalescode:' + getFieldTypeText(h.annualsalescode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'yrsinbus:' + getFieldTypeText(h.yrsinbus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ethniccode:' + getFieldTypeText(h.ethniccode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler5:' + getFieldTypeText(h.filler5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'latlongmatchlevel:' + getFieldTypeText(h.latlongmatchlevel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_latitude:' + getFieldTypeText(h.orig_latitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_longitude:' + getFieldTypeText(h.orig_longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler6:' + getFieldTypeText(h.filler6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'heading_string:' + getFieldTypeText(h.heading_string) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ypheading2:' + getFieldTypeText(h.ypheading2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ypheading3:' + getFieldTypeText(h.ypheading3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ypheading4:' + getFieldTypeText(h.ypheading4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ypheading5:' + getFieldTypeText(h.ypheading5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ypheading6:' + getFieldTypeText(h.ypheading6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'maxypadsize:' + getFieldTypeText(h.maxypadsize) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler7:' + getFieldTypeText(h.filler7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'faxac:' + getFieldTypeText(h.faxac) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'faxexchge:' + getFieldTypeText(h.faxexchge) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'faxphone:' + getFieldTypeText(h.faxphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'altac:' + getFieldTypeText(h.altac) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'altexchge:' + getFieldTypeText(h.altexchge) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'altphone:' + getFieldTypeText(h.altphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mobileac:' + getFieldTypeText(h.mobileac) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mobileexchge:' + getFieldTypeText(h.mobileexchge) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mobilephone:' + getFieldTypeText(h.mobilephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tollfreeac:' + getFieldTypeText(h.tollfreeac) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tollfreeexchge:' + getFieldTypeText(h.tollfreeexchge) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tollfreephone:' + getFieldTypeText(h.tollfreephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'creditcards:' + getFieldTypeText(h.creditcards) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brands:' + getFieldTypeText(h.brands) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stdhrs:' + getFieldTypeText(h.stdhrs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hrsopen:' + getFieldTypeText(h.hrsopen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'web_address:' + getFieldTypeText(h.web_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler8:' + getFieldTypeText(h.filler8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email_address:' + getFieldTypeText(h.email_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'services:' + getFieldTypeText(h.services) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'condheading:' + getFieldTypeText(h.condheading) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tagline:' + getFieldTypeText(h.tagline) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler9:' + getFieldTypeText(h.filler9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'totaladspend:' + getFieldTypeText(h.totaladspend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler10:' + getFieldTypeText(h.filler10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crlf:' + getFieldTypeText(h.crlf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_primary_key_cnt
          ,le.populated_chainid_cnt
          ,le.populated_filler1_cnt
          ,le.populated_pub_date_cnt
          ,le.populated_busshortname_cnt
          ,le.populated_business_name_cnt
          ,le.populated_busdeptname_cnt
          ,le.populated_house_cnt
          ,le.populated_predir_cnt
          ,le.populated_street_cnt
          ,le.populated_streettype_cnt
          ,le.populated_postdir_cnt
          ,le.populated_apttype_cnt
          ,le.populated_aptnbr_cnt
          ,le.populated_boxnbr_cnt
          ,le.populated_exppubcity_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_dpc_cnt
          ,le.populated_carrierroute_cnt
          ,le.populated_fips_cnt
          ,le.populated_countycode_cnt
          ,le.populated_z4type_cnt
          ,le.populated_ctract_cnt
          ,le.populated_cblockgroup_cnt
          ,le.populated_cblockid_cnt
          ,le.populated_msa_cnt
          ,le.populated_cbsa_cnt
          ,le.populated_mcdcode_cnt
          ,le.populated_filler2_cnt
          ,le.populated_addrsensitivity_cnt
          ,le.populated_maildeliverabilitycode_cnt
          ,le.populated_sic1_4_cnt
          ,le.populated_sic_code_cnt
          ,le.populated_sic2_cnt
          ,le.populated_sic3_cnt
          ,le.populated_sic4_cnt
          ,le.populated_indstryclass_cnt
          ,le.populated_naics_code_cnt
          ,le.populated_mlsc_cnt
          ,le.populated_filler3_cnt
          ,le.populated_orig_phone10_cnt
          ,le.populated_nosolicitcode_cnt
          ,le.populated_dso_cnt
          ,le.populated_timezone_cnt
          ,le.populated_validationflag_cnt
          ,le.populated_validationdate_cnt
          ,le.populated_secvalidationcode_cnt
          ,le.populated_singleaddrflag_cnt
          ,le.populated_filler4_cnt
          ,le.populated_gender_cnt
          ,le.populated_execname_cnt
          ,le.populated_exectitlecode_cnt
          ,le.populated_exectitle_cnt
          ,le.populated_condtitlecode_cnt
          ,le.populated_condtitle_cnt
          ,le.populated_contfunctioncode_cnt
          ,le.populated_contfunction_cnt
          ,le.populated_profession_cnt
          ,le.populated_emplsizecode_cnt
          ,le.populated_annualsalescode_cnt
          ,le.populated_yrsinbus_cnt
          ,le.populated_ethniccode_cnt
          ,le.populated_filler5_cnt
          ,le.populated_latlongmatchlevel_cnt
          ,le.populated_orig_latitude_cnt
          ,le.populated_orig_longitude_cnt
          ,le.populated_filler6_cnt
          ,le.populated_heading_string_cnt
          ,le.populated_ypheading2_cnt
          ,le.populated_ypheading3_cnt
          ,le.populated_ypheading4_cnt
          ,le.populated_ypheading5_cnt
          ,le.populated_ypheading6_cnt
          ,le.populated_maxypadsize_cnt
          ,le.populated_filler7_cnt
          ,le.populated_faxac_cnt
          ,le.populated_faxexchge_cnt
          ,le.populated_faxphone_cnt
          ,le.populated_altac_cnt
          ,le.populated_altexchge_cnt
          ,le.populated_altphone_cnt
          ,le.populated_mobileac_cnt
          ,le.populated_mobileexchge_cnt
          ,le.populated_mobilephone_cnt
          ,le.populated_tollfreeac_cnt
          ,le.populated_tollfreeexchge_cnt
          ,le.populated_tollfreephone_cnt
          ,le.populated_creditcards_cnt
          ,le.populated_brands_cnt
          ,le.populated_stdhrs_cnt
          ,le.populated_hrsopen_cnt
          ,le.populated_web_address_cnt
          ,le.populated_filler8_cnt
          ,le.populated_email_address_cnt
          ,le.populated_services_cnt
          ,le.populated_condheading_cnt
          ,le.populated_tagline_cnt
          ,le.populated_filler9_cnt
          ,le.populated_totaladspend_cnt
          ,le.populated_filler10_cnt
          ,le.populated_crlf_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_primary_key_pcnt
          ,le.populated_chainid_pcnt
          ,le.populated_filler1_pcnt
          ,le.populated_pub_date_pcnt
          ,le.populated_busshortname_pcnt
          ,le.populated_business_name_pcnt
          ,le.populated_busdeptname_pcnt
          ,le.populated_house_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_street_pcnt
          ,le.populated_streettype_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_apttype_pcnt
          ,le.populated_aptnbr_pcnt
          ,le.populated_boxnbr_pcnt
          ,le.populated_exppubcity_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_dpc_pcnt
          ,le.populated_carrierroute_pcnt
          ,le.populated_fips_pcnt
          ,le.populated_countycode_pcnt
          ,le.populated_z4type_pcnt
          ,le.populated_ctract_pcnt
          ,le.populated_cblockgroup_pcnt
          ,le.populated_cblockid_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_cbsa_pcnt
          ,le.populated_mcdcode_pcnt
          ,le.populated_filler2_pcnt
          ,le.populated_addrsensitivity_pcnt
          ,le.populated_maildeliverabilitycode_pcnt
          ,le.populated_sic1_4_pcnt
          ,le.populated_sic_code_pcnt
          ,le.populated_sic2_pcnt
          ,le.populated_sic3_pcnt
          ,le.populated_sic4_pcnt
          ,le.populated_indstryclass_pcnt
          ,le.populated_naics_code_pcnt
          ,le.populated_mlsc_pcnt
          ,le.populated_filler3_pcnt
          ,le.populated_orig_phone10_pcnt
          ,le.populated_nosolicitcode_pcnt
          ,le.populated_dso_pcnt
          ,le.populated_timezone_pcnt
          ,le.populated_validationflag_pcnt
          ,le.populated_validationdate_pcnt
          ,le.populated_secvalidationcode_pcnt
          ,le.populated_singleaddrflag_pcnt
          ,le.populated_filler4_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_execname_pcnt
          ,le.populated_exectitlecode_pcnt
          ,le.populated_exectitle_pcnt
          ,le.populated_condtitlecode_pcnt
          ,le.populated_condtitle_pcnt
          ,le.populated_contfunctioncode_pcnt
          ,le.populated_contfunction_pcnt
          ,le.populated_profession_pcnt
          ,le.populated_emplsizecode_pcnt
          ,le.populated_annualsalescode_pcnt
          ,le.populated_yrsinbus_pcnt
          ,le.populated_ethniccode_pcnt
          ,le.populated_filler5_pcnt
          ,le.populated_latlongmatchlevel_pcnt
          ,le.populated_orig_latitude_pcnt
          ,le.populated_orig_longitude_pcnt
          ,le.populated_filler6_pcnt
          ,le.populated_heading_string_pcnt
          ,le.populated_ypheading2_pcnt
          ,le.populated_ypheading3_pcnt
          ,le.populated_ypheading4_pcnt
          ,le.populated_ypheading5_pcnt
          ,le.populated_ypheading6_pcnt
          ,le.populated_maxypadsize_pcnt
          ,le.populated_filler7_pcnt
          ,le.populated_faxac_pcnt
          ,le.populated_faxexchge_pcnt
          ,le.populated_faxphone_pcnt
          ,le.populated_altac_pcnt
          ,le.populated_altexchge_pcnt
          ,le.populated_altphone_pcnt
          ,le.populated_mobileac_pcnt
          ,le.populated_mobileexchge_pcnt
          ,le.populated_mobilephone_pcnt
          ,le.populated_tollfreeac_pcnt
          ,le.populated_tollfreeexchge_pcnt
          ,le.populated_tollfreephone_pcnt
          ,le.populated_creditcards_pcnt
          ,le.populated_brands_pcnt
          ,le.populated_stdhrs_pcnt
          ,le.populated_hrsopen_pcnt
          ,le.populated_web_address_pcnt
          ,le.populated_filler8_pcnt
          ,le.populated_email_address_pcnt
          ,le.populated_services_pcnt
          ,le.populated_condheading_pcnt
          ,le.populated_tagline_pcnt
          ,le.populated_filler9_pcnt
          ,le.populated_totaladspend_pcnt
          ,le.populated_filler10_pcnt
          ,le.populated_crlf_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,103,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_Delta(prevDS, PROJECT(h, Input_Layout_YellowPages));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),103,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_Layout_YellowPages) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_YellowPages, Input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
