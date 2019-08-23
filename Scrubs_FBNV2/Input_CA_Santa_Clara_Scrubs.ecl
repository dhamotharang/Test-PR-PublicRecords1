IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_Santa_Clara_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 8;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_CA_Santa_Clara_Layout_FBNV2)
    UNSIGNED1 FIlED_DATE_Invalid;
    UNSIGNED1 FILING_TYPE_Invalid;
    UNSIGNED1 BUSINESS_NAME_Invalid;
    UNSIGNED1 ORIG_FILED_DATE_Invalid;
    UNSIGNED1 FBN_NUM_Invalid;
    UNSIGNED1 owner_name_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_CA_Santa_Clara_Layout_FBNV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_CA_Santa_Clara_Layout_FBNV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.FIlED_DATE_Invalid := Input_CA_Santa_Clara_Fields.InValid_FIlED_DATE((SALT311.StrType)le.FIlED_DATE);
    SELF.FILING_TYPE_Invalid := Input_CA_Santa_Clara_Fields.InValid_FILING_TYPE((SALT311.StrType)le.FILING_TYPE);
    SELF.BUSINESS_NAME_Invalid := Input_CA_Santa_Clara_Fields.InValid_BUSINESS_NAME((SALT311.StrType)le.BUSINESS_NAME);
    SELF.ORIG_FILED_DATE_Invalid := Input_CA_Santa_Clara_Fields.InValid_ORIG_FILED_DATE((SALT311.StrType)le.ORIG_FILED_DATE);
    SELF.FBN_NUM_Invalid := Input_CA_Santa_Clara_Fields.InValid_FBN_NUM((SALT311.StrType)le.FBN_NUM);
    SELF.owner_name_Invalid := Input_CA_Santa_Clara_Fields.InValid_owner_name((SALT311.StrType)le.owner_name);
    SELF.prep_addr_line1_Invalid := Input_CA_Santa_Clara_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Input_CA_Santa_Clara_Fields.InValid_prep_addr_line_last((SALT311.StrType)le.prep_addr_line_last);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_CA_Santa_Clara_Layout_FBNV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.FIlED_DATE_Invalid << 0 ) + ( le.FILING_TYPE_Invalid << 1 ) + ( le.BUSINESS_NAME_Invalid << 2 ) + ( le.ORIG_FILED_DATE_Invalid << 3 ) + ( le.FBN_NUM_Invalid << 4 ) + ( le.owner_name_Invalid << 5 ) + ( le.prep_addr_line1_Invalid << 6 ) + ( le.prep_addr_line_last_Invalid << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_CA_Santa_Clara_Layout_FBNV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.FIlED_DATE_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.FILING_TYPE_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.BUSINESS_NAME_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.ORIG_FILED_DATE_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.FBN_NUM_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.owner_name_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    FIlED_DATE_CUSTOM_ErrorCount := COUNT(GROUP,h.FIlED_DATE_Invalid=1);
    FILING_TYPE_LENGTHS_ErrorCount := COUNT(GROUP,h.FILING_TYPE_Invalid=1);
    BUSINESS_NAME_LENGTHS_ErrorCount := COUNT(GROUP,h.BUSINESS_NAME_Invalid=1);
    ORIG_FILED_DATE_CUSTOM_ErrorCount := COUNT(GROUP,h.ORIG_FILED_DATE_Invalid=1);
    FBN_NUM_LENGTHS_ErrorCount := COUNT(GROUP,h.FBN_NUM_Invalid=1);
    owner_name_LENGTHS_ErrorCount := COUNT(GROUP,h.owner_name_Invalid=1);
    prep_addr_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr_line_last_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.FIlED_DATE_Invalid > 0 OR h.FILING_TYPE_Invalid > 0 OR h.BUSINESS_NAME_Invalid > 0 OR h.ORIG_FILED_DATE_Invalid > 0 OR h.FBN_NUM_Invalid > 0 OR h.owner_name_Invalid > 0 OR h.prep_addr_line1_Invalid > 0 OR h.prep_addr_line_last_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.FIlED_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.FILING_TYPE_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.BUSINESS_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ORIG_FILED_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.FBN_NUM_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.owner_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.FIlED_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.FILING_TYPE_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.BUSINESS_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ORIG_FILED_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.FBN_NUM_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.owner_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.FIlED_DATE_Invalid,le.FILING_TYPE_Invalid,le.BUSINESS_NAME_Invalid,le.ORIG_FILED_DATE_Invalid,le.FBN_NUM_Invalid,le.owner_name_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_CA_Santa_Clara_Fields.InvalidMessage_FIlED_DATE(le.FIlED_DATE_Invalid),Input_CA_Santa_Clara_Fields.InvalidMessage_FILING_TYPE(le.FILING_TYPE_Invalid),Input_CA_Santa_Clara_Fields.InvalidMessage_BUSINESS_NAME(le.BUSINESS_NAME_Invalid),Input_CA_Santa_Clara_Fields.InvalidMessage_ORIG_FILED_DATE(le.ORIG_FILED_DATE_Invalid),Input_CA_Santa_Clara_Fields.InvalidMessage_FBN_NUM(le.FBN_NUM_Invalid),Input_CA_Santa_Clara_Fields.InvalidMessage_owner_name(le.owner_name_Invalid),Input_CA_Santa_Clara_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Input_CA_Santa_Clara_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.FIlED_DATE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.FILING_TYPE_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.BUSINESS_NAME_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.ORIG_FILED_DATE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.FBN_NUM_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.owner_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'FIlED_DATE','FILING_TYPE','BUSINESS_NAME','ORIG_FILED_DATE','FBN_NUM','owner_name','prep_addr_line1','prep_addr_line_last','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.FIlED_DATE,(SALT311.StrType)le.FILING_TYPE,(SALT311.StrType)le.BUSINESS_NAME,(SALT311.StrType)le.ORIG_FILED_DATE,(SALT311.StrType)le.FBN_NUM,(SALT311.StrType)le.owner_name,(SALT311.StrType)le.prep_addr_line1,(SALT311.StrType)le.prep_addr_line_last,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_CA_Santa_Clara_Layout_FBNV2) prevDS = DATASET([], Input_CA_Santa_Clara_Layout_FBNV2), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'FIlED_DATE:invalid_past_date:CUSTOM'
          ,'FILING_TYPE:invalid_mandatory:LENGTHS'
          ,'BUSINESS_NAME:invalid_mandatory:LENGTHS'
          ,'ORIG_FILED_DATE:invalid_past_date:CUSTOM'
          ,'FBN_NUM:invalid_mandatory:LENGTHS'
          ,'owner_name:invalid_mandatory:LENGTHS'
          ,'prep_addr_line1:invalid_mandatory:LENGTHS'
          ,'prep_addr_line_last:invalid_mandatory:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_CA_Santa_Clara_Fields.InvalidMessage_FIlED_DATE(1)
          ,Input_CA_Santa_Clara_Fields.InvalidMessage_FILING_TYPE(1)
          ,Input_CA_Santa_Clara_Fields.InvalidMessage_BUSINESS_NAME(1)
          ,Input_CA_Santa_Clara_Fields.InvalidMessage_ORIG_FILED_DATE(1)
          ,Input_CA_Santa_Clara_Fields.InvalidMessage_FBN_NUM(1)
          ,Input_CA_Santa_Clara_Fields.InvalidMessage_owner_name(1)
          ,Input_CA_Santa_Clara_Fields.InvalidMessage_prep_addr_line1(1)
          ,Input_CA_Santa_Clara_Fields.InvalidMessage_prep_addr_line_last(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.FIlED_DATE_CUSTOM_ErrorCount
          ,le.FILING_TYPE_LENGTHS_ErrorCount
          ,le.BUSINESS_NAME_LENGTHS_ErrorCount
          ,le.ORIG_FILED_DATE_CUSTOM_ErrorCount
          ,le.FBN_NUM_LENGTHS_ErrorCount
          ,le.owner_name_LENGTHS_ErrorCount
          ,le.prep_addr_line1_LENGTHS_ErrorCount
          ,le.prep_addr_line_last_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.FIlED_DATE_CUSTOM_ErrorCount
          ,le.FILING_TYPE_LENGTHS_ErrorCount
          ,le.BUSINESS_NAME_LENGTHS_ErrorCount
          ,le.ORIG_FILED_DATE_CUSTOM_ErrorCount
          ,le.FBN_NUM_LENGTHS_ErrorCount
          ,le.owner_name_LENGTHS_ErrorCount
          ,le.prep_addr_line1_LENGTHS_ErrorCount
          ,le.prep_addr_line_last_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_CA_Santa_Clara_hygiene(PROJECT(h, Input_CA_Santa_Clara_Layout_FBNV2));
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
          ,'status:' + getFieldTypeText(h.status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FIlED_DATE:' + getFieldTypeText(h.FIlED_DATE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FBN_TYPE:' + getFieldTypeText(h.FBN_TYPE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FILING_TYPE:' + getFieldTypeText(h.FILING_TYPE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BUSINESS_NAME:' + getFieldTypeText(h.BUSINESS_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BUSINESS_TYPE:' + getFieldTypeText(h.BUSINESS_TYPE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ORIG_FILED_DATE:' + getFieldTypeText(h.ORIG_FILED_DATE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ORIG_FBN_NUM:' + getFieldTypeText(h.ORIG_FBN_NUM) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RECORD_CODE1:' + getFieldTypeText(h.RECORD_CODE1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FBN_NUM:' + getFieldTypeText(h.FBN_NUM) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BUSINESS_ADDR1:' + getFieldTypeText(h.BUSINESS_ADDR1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RECORD_CODE2:' + getFieldTypeText(h.RECORD_CODE2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BUSINESS_ADDR2:' + getFieldTypeText(h.BUSINESS_ADDR2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RECORD_CODE3:' + getFieldTypeText(h.RECORD_CODE3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BUS_CITY:' + getFieldTypeText(h.BUS_CITY) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BUS_ST:' + getFieldTypeText(h.BUS_ST) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BUS_ZIP:' + getFieldTypeText(h.BUS_ZIP) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RECORD_CODE4:' + getFieldTypeText(h.RECORD_CODE4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ADDTL_BUSINESS:' + getFieldTypeText(h.ADDTL_BUSINESS) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RECORD_CODE5:' + getFieldTypeText(h.RECORD_CODE5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'owner_name:' + getFieldTypeText(h.owner_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'OWNER_TYPE:' + getFieldTypeText(h.OWNER_TYPE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RECORD_CODE6:' + getFieldTypeText(h.RECORD_CODE6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'OWNER_ADDR1:' + getFieldTypeText(h.OWNER_ADDR1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'OWNER_CITY:' + getFieldTypeText(h.OWNER_CITY) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'OWNER_ST:' + getFieldTypeText(h.OWNER_ST) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'OWNER_ZIP:' + getFieldTypeText(h.OWNER_ZIP) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Owner_title:' + getFieldTypeText(h.Owner_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Owner_fname:' + getFieldTypeText(h.Owner_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Owner_mname:' + getFieldTypeText(h.Owner_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Owner_lname:' + getFieldTypeText(h.Owner_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Owner_name_suffix:' + getFieldTypeText(h.Owner_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Owner_name_score:' + getFieldTypeText(h.Owner_name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line1:' + getFieldTypeText(h.prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line_last:' + getFieldTypeText(h.prep_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_owner_addr_line1:' + getFieldTypeText(h.prep_owner_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_owner_addr_line_last:' + getFieldTypeText(h.prep_owner_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_status_cnt
          ,le.populated_process_date_cnt
          ,le.populated_FIlED_DATE_cnt
          ,le.populated_FBN_TYPE_cnt
          ,le.populated_FILING_TYPE_cnt
          ,le.populated_BUSINESS_NAME_cnt
          ,le.populated_BUSINESS_TYPE_cnt
          ,le.populated_ORIG_FILED_DATE_cnt
          ,le.populated_ORIG_FBN_NUM_cnt
          ,le.populated_RECORD_CODE1_cnt
          ,le.populated_FBN_NUM_cnt
          ,le.populated_BUSINESS_ADDR1_cnt
          ,le.populated_RECORD_CODE2_cnt
          ,le.populated_BUSINESS_ADDR2_cnt
          ,le.populated_RECORD_CODE3_cnt
          ,le.populated_BUS_CITY_cnt
          ,le.populated_BUS_ST_cnt
          ,le.populated_BUS_ZIP_cnt
          ,le.populated_RECORD_CODE4_cnt
          ,le.populated_ADDTL_BUSINESS_cnt
          ,le.populated_RECORD_CODE5_cnt
          ,le.populated_owner_name_cnt
          ,le.populated_OWNER_TYPE_cnt
          ,le.populated_RECORD_CODE6_cnt
          ,le.populated_OWNER_ADDR1_cnt
          ,le.populated_OWNER_CITY_cnt
          ,le.populated_OWNER_ST_cnt
          ,le.populated_OWNER_ZIP_cnt
          ,le.populated_Owner_title_cnt
          ,le.populated_Owner_fname_cnt
          ,le.populated_Owner_mname_cnt
          ,le.populated_Owner_lname_cnt
          ,le.populated_Owner_name_suffix_cnt
          ,le.populated_Owner_name_score_cnt
          ,le.populated_prep_addr_line1_cnt
          ,le.populated_prep_addr_line_last_cnt
          ,le.populated_prep_owner_addr_line1_cnt
          ,le.populated_prep_owner_addr_line_last_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_status_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_FIlED_DATE_pcnt
          ,le.populated_FBN_TYPE_pcnt
          ,le.populated_FILING_TYPE_pcnt
          ,le.populated_BUSINESS_NAME_pcnt
          ,le.populated_BUSINESS_TYPE_pcnt
          ,le.populated_ORIG_FILED_DATE_pcnt
          ,le.populated_ORIG_FBN_NUM_pcnt
          ,le.populated_RECORD_CODE1_pcnt
          ,le.populated_FBN_NUM_pcnt
          ,le.populated_BUSINESS_ADDR1_pcnt
          ,le.populated_RECORD_CODE2_pcnt
          ,le.populated_BUSINESS_ADDR2_pcnt
          ,le.populated_RECORD_CODE3_pcnt
          ,le.populated_BUS_CITY_pcnt
          ,le.populated_BUS_ST_pcnt
          ,le.populated_BUS_ZIP_pcnt
          ,le.populated_RECORD_CODE4_pcnt
          ,le.populated_ADDTL_BUSINESS_pcnt
          ,le.populated_RECORD_CODE5_pcnt
          ,le.populated_owner_name_pcnt
          ,le.populated_OWNER_TYPE_pcnt
          ,le.populated_RECORD_CODE6_pcnt
          ,le.populated_OWNER_ADDR1_pcnt
          ,le.populated_OWNER_CITY_pcnt
          ,le.populated_OWNER_ST_pcnt
          ,le.populated_OWNER_ZIP_pcnt
          ,le.populated_Owner_title_pcnt
          ,le.populated_Owner_fname_pcnt
          ,le.populated_Owner_mname_pcnt
          ,le.populated_Owner_lname_pcnt
          ,le.populated_Owner_name_suffix_pcnt
          ,le.populated_Owner_name_score_pcnt
          ,le.populated_prep_addr_line1_pcnt
          ,le.populated_prep_addr_line_last_pcnt
          ,le.populated_prep_owner_addr_line1_pcnt
          ,le.populated_prep_owner_addr_line_last_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,38,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_CA_Santa_Clara_Delta(prevDS, PROJECT(h, Input_CA_Santa_Clara_Layout_FBNV2));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),38,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_CA_Santa_Clara_Layout_FBNV2) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FBNV2, Input_CA_Santa_Clara_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
