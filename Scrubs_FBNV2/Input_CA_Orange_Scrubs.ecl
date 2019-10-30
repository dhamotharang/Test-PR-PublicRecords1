﻿IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_Orange_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 13;
  EXPORT NumRulesFromFieldType := 13;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 13;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_CA_Orange_Layout_FBNV2)
    UNSIGNED1 REGIS_NBR_Invalid;
    UNSIGNED1 BUSINESS_NAME_Invalid;
    UNSIGNED1 PHONE_NBR_Invalid;
    UNSIGNED1 FILE_DATE_Invalid;
    UNSIGNED1 FIRST_NAME_Invalid;
    UNSIGNED1 MIDDLE_NAME_Invalid;
    UNSIGNED1 LAST_NAME_COMPANY_Invalid;
    UNSIGNED1 OWNER_ADDRESS_Invalid;
    UNSIGNED1 prep_bus_addr_line1_Invalid;
    UNSIGNED1 prep_bus_addr_line_last_Invalid;
    UNSIGNED1 prep_owner_addr_line1_Invalid;
    UNSIGNED1 prep_owner_addr_line_last_Invalid;
    UNSIGNED1 cname_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_CA_Orange_Layout_FBNV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_CA_Orange_Layout_FBNV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.REGIS_NBR_Invalid := Input_CA_Orange_Fields.InValid_REGIS_NBR((SALT311.StrType)le.REGIS_NBR);
    SELF.BUSINESS_NAME_Invalid := Input_CA_Orange_Fields.InValid_BUSINESS_NAME((SALT311.StrType)le.BUSINESS_NAME);
    SELF.PHONE_NBR_Invalid := Input_CA_Orange_Fields.InValid_PHONE_NBR((SALT311.StrType)le.PHONE_NBR);
    SELF.FILE_DATE_Invalid := Input_CA_Orange_Fields.InValid_FILE_DATE((SALT311.StrType)le.FILE_DATE);
    SELF.FIRST_NAME_Invalid := Input_CA_Orange_Fields.InValid_FIRST_NAME((SALT311.StrType)le.FIRST_NAME);
    SELF.MIDDLE_NAME_Invalid := Input_CA_Orange_Fields.InValid_MIDDLE_NAME((SALT311.StrType)le.MIDDLE_NAME);
    SELF.LAST_NAME_COMPANY_Invalid := Input_CA_Orange_Fields.InValid_LAST_NAME_COMPANY((SALT311.StrType)le.LAST_NAME_COMPANY);
    SELF.OWNER_ADDRESS_Invalid := Input_CA_Orange_Fields.InValid_OWNER_ADDRESS((SALT311.StrType)le.OWNER_ADDRESS);
    SELF.prep_bus_addr_line1_Invalid := Input_CA_Orange_Fields.InValid_prep_bus_addr_line1((SALT311.StrType)le.prep_bus_addr_line1);
    SELF.prep_bus_addr_line_last_Invalid := Input_CA_Orange_Fields.InValid_prep_bus_addr_line_last((SALT311.StrType)le.prep_bus_addr_line_last);
    SELF.prep_owner_addr_line1_Invalid := Input_CA_Orange_Fields.InValid_prep_owner_addr_line1((SALT311.StrType)le.prep_owner_addr_line1);
    SELF.prep_owner_addr_line_last_Invalid := Input_CA_Orange_Fields.InValid_prep_owner_addr_line_last((SALT311.StrType)le.prep_owner_addr_line_last);
    SELF.cname_Invalid := Input_CA_Orange_Fields.InValid_cname((SALT311.StrType)le.cname);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_CA_Orange_Layout_FBNV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.REGIS_NBR_Invalid << 0 ) + ( le.BUSINESS_NAME_Invalid << 1 ) + ( le.PHONE_NBR_Invalid << 2 ) + ( le.FILE_DATE_Invalid << 3 ) + ( le.FIRST_NAME_Invalid << 4 ) + ( le.MIDDLE_NAME_Invalid << 5 ) + ( le.LAST_NAME_COMPANY_Invalid << 6 ) + ( le.OWNER_ADDRESS_Invalid << 7 ) + ( le.prep_bus_addr_line1_Invalid << 8 ) + ( le.prep_bus_addr_line_last_Invalid << 9 ) + ( le.prep_owner_addr_line1_Invalid << 10 ) + ( le.prep_owner_addr_line_last_Invalid << 11 ) + ( le.cname_Invalid << 12 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_CA_Orange_Layout_FBNV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.REGIS_NBR_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.BUSINESS_NAME_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.PHONE_NBR_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.FILE_DATE_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.FIRST_NAME_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.MIDDLE_NAME_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.LAST_NAME_COMPANY_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.OWNER_ADDRESS_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.prep_bus_addr_line1_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.prep_bus_addr_line_last_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.prep_owner_addr_line1_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.prep_owner_addr_line_last_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.cname_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    REGIS_NBR_LENGTHS_ErrorCount := COUNT(GROUP,h.REGIS_NBR_Invalid=1);
    BUSINESS_NAME_LENGTHS_ErrorCount := COUNT(GROUP,h.BUSINESS_NAME_Invalid=1);
    PHONE_NBR_CUSTOM_ErrorCount := COUNT(GROUP,h.PHONE_NBR_Invalid=1);
    FILE_DATE_CUSTOM_ErrorCount := COUNT(GROUP,h.FILE_DATE_Invalid=1);
    FIRST_NAME_LENGTHS_ErrorCount := COUNT(GROUP,h.FIRST_NAME_Invalid=1);
    MIDDLE_NAME_LENGTHS_ErrorCount := COUNT(GROUP,h.MIDDLE_NAME_Invalid=1);
    LAST_NAME_COMPANY_LENGTHS_ErrorCount := COUNT(GROUP,h.LAST_NAME_COMPANY_Invalid=1);
    OWNER_ADDRESS_LENGTHS_ErrorCount := COUNT(GROUP,h.OWNER_ADDRESS_Invalid=1);
    prep_bus_addr_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_bus_addr_line1_Invalid=1);
    prep_bus_addr_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_bus_addr_line_last_Invalid=1);
    prep_owner_addr_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_owner_addr_line1_Invalid=1);
    prep_owner_addr_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_owner_addr_line_last_Invalid=1);
    cname_LENGTHS_ErrorCount := COUNT(GROUP,h.cname_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.REGIS_NBR_Invalid > 0 OR h.BUSINESS_NAME_Invalid > 0 OR h.PHONE_NBR_Invalid > 0 OR h.FILE_DATE_Invalid > 0 OR h.FIRST_NAME_Invalid > 0 OR h.MIDDLE_NAME_Invalid > 0 OR h.LAST_NAME_COMPANY_Invalid > 0 OR h.OWNER_ADDRESS_Invalid > 0 OR h.prep_bus_addr_line1_Invalid > 0 OR h.prep_bus_addr_line_last_Invalid > 0 OR h.prep_owner_addr_line1_Invalid > 0 OR h.prep_owner_addr_line_last_Invalid > 0 OR h.cname_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.REGIS_NBR_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.BUSINESS_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.PHONE_NBR_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.FILE_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.FIRST_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.MIDDLE_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.LAST_NAME_COMPANY_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.OWNER_ADDRESS_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_bus_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_bus_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cname_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.REGIS_NBR_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.BUSINESS_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.PHONE_NBR_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.FILE_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.FIRST_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.MIDDLE_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.LAST_NAME_COMPANY_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.OWNER_ADDRESS_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_bus_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_bus_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cname_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.REGIS_NBR_Invalid,le.BUSINESS_NAME_Invalid,le.PHONE_NBR_Invalid,le.FILE_DATE_Invalid,le.FIRST_NAME_Invalid,le.MIDDLE_NAME_Invalid,le.LAST_NAME_COMPANY_Invalid,le.OWNER_ADDRESS_Invalid,le.prep_bus_addr_line1_Invalid,le.prep_bus_addr_line_last_Invalid,le.prep_owner_addr_line1_Invalid,le.prep_owner_addr_line_last_Invalid,le.cname_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_CA_Orange_Fields.InvalidMessage_REGIS_NBR(le.REGIS_NBR_Invalid),Input_CA_Orange_Fields.InvalidMessage_BUSINESS_NAME(le.BUSINESS_NAME_Invalid),Input_CA_Orange_Fields.InvalidMessage_PHONE_NBR(le.PHONE_NBR_Invalid),Input_CA_Orange_Fields.InvalidMessage_FILE_DATE(le.FILE_DATE_Invalid),Input_CA_Orange_Fields.InvalidMessage_FIRST_NAME(le.FIRST_NAME_Invalid),Input_CA_Orange_Fields.InvalidMessage_MIDDLE_NAME(le.MIDDLE_NAME_Invalid),Input_CA_Orange_Fields.InvalidMessage_LAST_NAME_COMPANY(le.LAST_NAME_COMPANY_Invalid),Input_CA_Orange_Fields.InvalidMessage_OWNER_ADDRESS(le.OWNER_ADDRESS_Invalid),Input_CA_Orange_Fields.InvalidMessage_prep_bus_addr_line1(le.prep_bus_addr_line1_Invalid),Input_CA_Orange_Fields.InvalidMessage_prep_bus_addr_line_last(le.prep_bus_addr_line_last_Invalid),Input_CA_Orange_Fields.InvalidMessage_prep_owner_addr_line1(le.prep_owner_addr_line1_Invalid),Input_CA_Orange_Fields.InvalidMessage_prep_owner_addr_line_last(le.prep_owner_addr_line_last_Invalid),Input_CA_Orange_Fields.InvalidMessage_cname(le.cname_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.REGIS_NBR_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.BUSINESS_NAME_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.PHONE_NBR_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.FILE_DATE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.FIRST_NAME_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.MIDDLE_NAME_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.LAST_NAME_COMPANY_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.OWNER_ADDRESS_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_bus_addr_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_bus_addr_line_last_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_owner_addr_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_owner_addr_line_last_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.cname_Invalid,'LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'REGIS_NBR','BUSINESS_NAME','PHONE_NBR','FILE_DATE','FIRST_NAME','MIDDLE_NAME','LAST_NAME_COMPANY','OWNER_ADDRESS','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','cname','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_phone','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.REGIS_NBR,(SALT311.StrType)le.BUSINESS_NAME,(SALT311.StrType)le.PHONE_NBR,(SALT311.StrType)le.FILE_DATE,(SALT311.StrType)le.FIRST_NAME,(SALT311.StrType)le.MIDDLE_NAME,(SALT311.StrType)le.LAST_NAME_COMPANY,(SALT311.StrType)le.OWNER_ADDRESS,(SALT311.StrType)le.prep_bus_addr_line1,(SALT311.StrType)le.prep_bus_addr_line_last,(SALT311.StrType)le.prep_owner_addr_line1,(SALT311.StrType)le.prep_owner_addr_line_last,(SALT311.StrType)le.cname,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_CA_Orange_Layout_FBNV2) prevDS = DATASET([], Input_CA_Orange_Layout_FBNV2), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'REGIS_NBR:invalid_mandatory:LENGTHS'
          ,'BUSINESS_NAME:invalid_mandatory:LENGTHS'
          ,'PHONE_NBR:invalid_phone:CUSTOM'
          ,'FILE_DATE:invalid_past_date:CUSTOM'
          ,'FIRST_NAME:invalid_mandatory:LENGTHS'
          ,'MIDDLE_NAME:invalid_mandatory:LENGTHS'
          ,'LAST_NAME_COMPANY:invalid_mandatory:LENGTHS'
          ,'OWNER_ADDRESS:invalid_mandatory:LENGTHS'
          ,'prep_bus_addr_line1:invalid_mandatory:LENGTHS'
          ,'prep_bus_addr_line_last:invalid_mandatory:LENGTHS'
          ,'prep_owner_addr_line1:invalid_mandatory:LENGTHS'
          ,'prep_owner_addr_line_last:invalid_mandatory:LENGTHS'
          ,'cname:invalid_mandatory:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_CA_Orange_Fields.InvalidMessage_REGIS_NBR(1)
          ,Input_CA_Orange_Fields.InvalidMessage_BUSINESS_NAME(1)
          ,Input_CA_Orange_Fields.InvalidMessage_PHONE_NBR(1)
          ,Input_CA_Orange_Fields.InvalidMessage_FILE_DATE(1)
          ,Input_CA_Orange_Fields.InvalidMessage_FIRST_NAME(1)
          ,Input_CA_Orange_Fields.InvalidMessage_MIDDLE_NAME(1)
          ,Input_CA_Orange_Fields.InvalidMessage_LAST_NAME_COMPANY(1)
          ,Input_CA_Orange_Fields.InvalidMessage_OWNER_ADDRESS(1)
          ,Input_CA_Orange_Fields.InvalidMessage_prep_bus_addr_line1(1)
          ,Input_CA_Orange_Fields.InvalidMessage_prep_bus_addr_line_last(1)
          ,Input_CA_Orange_Fields.InvalidMessage_prep_owner_addr_line1(1)
          ,Input_CA_Orange_Fields.InvalidMessage_prep_owner_addr_line_last(1)
          ,Input_CA_Orange_Fields.InvalidMessage_cname(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.REGIS_NBR_LENGTHS_ErrorCount
          ,le.BUSINESS_NAME_LENGTHS_ErrorCount
          ,le.PHONE_NBR_CUSTOM_ErrorCount
          ,le.FILE_DATE_CUSTOM_ErrorCount
          ,le.FIRST_NAME_LENGTHS_ErrorCount
          ,le.MIDDLE_NAME_LENGTHS_ErrorCount
          ,le.LAST_NAME_COMPANY_LENGTHS_ErrorCount
          ,le.OWNER_ADDRESS_LENGTHS_ErrorCount
          ,le.prep_bus_addr_line1_LENGTHS_ErrorCount
          ,le.prep_bus_addr_line_last_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line1_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line_last_LENGTHS_ErrorCount
          ,le.cname_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.REGIS_NBR_LENGTHS_ErrorCount
          ,le.BUSINESS_NAME_LENGTHS_ErrorCount
          ,le.PHONE_NBR_CUSTOM_ErrorCount
          ,le.FILE_DATE_CUSTOM_ErrorCount
          ,le.FIRST_NAME_LENGTHS_ErrorCount
          ,le.MIDDLE_NAME_LENGTHS_ErrorCount
          ,le.LAST_NAME_COMPANY_LENGTHS_ErrorCount
          ,le.OWNER_ADDRESS_LENGTHS_ErrorCount
          ,le.prep_bus_addr_line1_LENGTHS_ErrorCount
          ,le.prep_bus_addr_line_last_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line1_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line_last_LENGTHS_ErrorCount
          ,le.cname_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_CA_Orange_hygiene(PROJECT(h, Input_CA_Orange_Layout_FBNV2));
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
          ,'REGIS_NBR:' + getFieldTypeText(h.REGIS_NBR) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BUSINESS_NAME:' + getFieldTypeText(h.BUSINESS_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PHONE_NBR:' + getFieldTypeText(h.PHONE_NBR) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FILE_DATE:' + getFieldTypeText(h.FILE_DATE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FIRST_NAME:' + getFieldTypeText(h.FIRST_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'MIDDLE_NAME:' + getFieldTypeText(h.MIDDLE_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LAST_NAME_COMPANY:' + getFieldTypeText(h.LAST_NAME_COMPANY) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'OWNER_ADDRESS:' + getFieldTypeText(h.OWNER_ADDRESS) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_bus_addr_line1:' + getFieldTypeText(h.prep_bus_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_bus_addr_line_last:' + getFieldTypeText(h.prep_bus_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_owner_addr_line1:' + getFieldTypeText(h.prep_owner_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_owner_addr_line_last:' + getFieldTypeText(h.prep_owner_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cname:' + getFieldTypeText(h.cname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_REGIS_NBR_cnt
          ,le.populated_BUSINESS_NAME_cnt
          ,le.populated_PHONE_NBR_cnt
          ,le.populated_FILE_DATE_cnt
          ,le.populated_FIRST_NAME_cnt
          ,le.populated_MIDDLE_NAME_cnt
          ,le.populated_LAST_NAME_COMPANY_cnt
          ,le.populated_OWNER_ADDRESS_cnt
          ,le.populated_prep_bus_addr_line1_cnt
          ,le.populated_prep_bus_addr_line_last_cnt
          ,le.populated_prep_owner_addr_line1_cnt
          ,le.populated_prep_owner_addr_line_last_cnt
          ,le.populated_cname_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_REGIS_NBR_pcnt
          ,le.populated_BUSINESS_NAME_pcnt
          ,le.populated_PHONE_NBR_pcnt
          ,le.populated_FILE_DATE_pcnt
          ,le.populated_FIRST_NAME_pcnt
          ,le.populated_MIDDLE_NAME_pcnt
          ,le.populated_LAST_NAME_COMPANY_pcnt
          ,le.populated_OWNER_ADDRESS_pcnt
          ,le.populated_prep_bus_addr_line1_pcnt
          ,le.populated_prep_bus_addr_line_last_pcnt
          ,le.populated_prep_owner_addr_line1_pcnt
          ,le.populated_prep_owner_addr_line_last_pcnt
          ,le.populated_cname_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,13,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_CA_Orange_Delta(prevDS, PROJECT(h, Input_CA_Orange_Layout_FBNV2));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),13,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_CA_Orange_Layout_FBNV2) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FBNV2, Input_CA_Orange_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
