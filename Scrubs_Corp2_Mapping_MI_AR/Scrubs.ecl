IMPORT CORP2_MAPPING,SALT38,std;
IMPORT Scrubs,Scrubs_Corp2_Mapping_MI_AR; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 11;
  EXPORT NumRulesFromFieldType := 11;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 7;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Corp2_Mapping.LayoutsCommon.AR)
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 corp_sos_charter_nbr_Invalid;
    UNSIGNED1 ar_year_Invalid;
    UNSIGNED1 ar_filed_dt_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Corp2_Mapping.LayoutsCommon.AR)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Corp2_Mapping.LayoutsCommon.AR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT38.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT38.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT38.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT38.StrType)le.corp_process_date);
    SELF.corp_sos_charter_nbr_Invalid := Fields.InValid_corp_sos_charter_nbr((SALT38.StrType)le.corp_sos_charter_nbr);
    SELF.ar_year_Invalid := Fields.InValid_ar_year((SALT38.StrType)le.ar_year);
    SELF.ar_filed_dt_Invalid := Fields.InValid_ar_filed_dt((SALT38.StrType)le.ar_filed_dt);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Corp2_Mapping.LayoutsCommon.AR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.corp_key_Invalid << 0 ) + ( le.corp_vendor_Invalid << 2 ) + ( le.corp_state_origin_Invalid << 3 ) + ( le.corp_process_date_Invalid << 4 ) + ( le.corp_sos_charter_nbr_Invalid << 6 ) + ( le.ar_year_Invalid << 8 ) + ( le.ar_filed_dt_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Corp2_Mapping.LayoutsCommon.AR);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.corp_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.ar_year_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.ar_filed_dt_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT)) : independent;
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    corp_key_ALLOW_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=1);
    corp_key_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_key_Invalid=2);
    corp_key_Total_ErrorCount := COUNT(GROUP,h.corp_key_Invalid>0);
    corp_vendor_ENUM_ErrorCount := COUNT(GROUP,h.corp_vendor_Invalid=1);
    corp_state_origin_ENUM_ErrorCount := COUNT(GROUP,h.corp_state_origin_Invalid=1);
    corp_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=1);
    corp_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid=2);
    corp_process_date_Total_ErrorCount := COUNT(GROUP,h.corp_process_date_Invalid>0);
    corp_sos_charter_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.corp_sos_charter_nbr_Invalid=1);
    corp_sos_charter_nbr_LENGTHS_ErrorCount := COUNT(GROUP,h.corp_sos_charter_nbr_Invalid=2);
    corp_sos_charter_nbr_Total_ErrorCount := COUNT(GROUP,h.corp_sos_charter_nbr_Invalid>0);
    ar_year_ALLOW_ErrorCount := COUNT(GROUP,h.ar_year_Invalid=1);
    ar_filed_dt_ALLOW_ErrorCount := COUNT(GROUP,h.ar_filed_dt_Invalid=1);
    ar_filed_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.ar_filed_dt_Invalid=2);
    ar_filed_dt_Total_ErrorCount := COUNT(GROUP,h.ar_filed_dt_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.corp_key_Invalid > 0 OR h.corp_vendor_Invalid > 0 OR h.corp_state_origin_Invalid > 0 OR h.corp_process_date_Invalid > 0 OR h.corp_sos_charter_nbr_Invalid > 0 OR h.ar_year_Invalid > 0 OR h.ar_filed_dt_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r) : independent;
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.corp_key_Total_ErrorCount > 0, 1, 0) + IF(le.corp_vendor_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_Total_ErrorCount > 0, 1, 0) + IF(le.corp_sos_charter_nbr_Total_ErrorCount > 0, 1, 0) + IF(le.ar_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ar_filed_dt_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.corp_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_vendor_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_sos_charter_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_sos_charter_nbr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ar_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ar_filed_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ar_filed_dt_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.corp_sos_charter_nbr_Invalid,le.ar_year_Invalid,le.ar_filed_dt_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_sos_charter_nbr(le.corp_sos_charter_nbr_Invalid),Fields.InvalidMessage_ar_year(le.ar_year_Invalid),Fields.InvalidMessage_ar_filed_dt(le.ar_filed_dt_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.corp_key_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_sos_charter_nbr_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ar_year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ar_filed_dt_Invalid,'ALLOW','CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_sos_charter_nbr','ar_year','ar_filed_dt','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_charter_nbr','invalid_numeric','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.corp_key,(SALT38.StrType)le.corp_vendor,(SALT38.StrType)le.corp_state_origin,(SALT38.StrType)le.corp_process_date,(SALT38.StrType)le.corp_sos_charter_nbr,(SALT38.StrType)le.ar_year,(SALT38.StrType)le.ar_filed_dt,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Corp2_Mapping.LayoutsCommon.AR) prevDS = DATASET([], Corp2_Mapping.LayoutsCommon.AR), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'corp_key:invalid_corp_key:ALLOW','corp_key:invalid_corp_key:LENGTHS'
          ,'corp_vendor:invalid_corp_vendor:ENUM'
          ,'corp_state_origin:invalid_state_origin:ENUM'
          ,'corp_process_date:invalid_date:ALLOW','corp_process_date:invalid_date:CUSTOM'
          ,'corp_sos_charter_nbr:invalid_charter_nbr:ALLOW','corp_sos_charter_nbr:invalid_charter_nbr:LENGTHS'
          ,'ar_year:invalid_numeric:ALLOW'
          ,'ar_filed_dt:invalid_date:ALLOW','ar_filed_dt:invalid_date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_corp_key(1),Fields.InvalidMessage_corp_key(2)
          ,Fields.InvalidMessage_corp_vendor(1)
          ,Fields.InvalidMessage_corp_state_origin(1)
          ,Fields.InvalidMessage_corp_process_date(1),Fields.InvalidMessage_corp_process_date(2)
          ,Fields.InvalidMessage_corp_sos_charter_nbr(1),Fields.InvalidMessage_corp_sos_charter_nbr(2)
          ,Fields.InvalidMessage_ar_year(1)
          ,Fields.InvalidMessage_ar_filed_dt(1),Fields.InvalidMessage_ar_filed_dt(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTHS_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount
          ,le.corp_sos_charter_nbr_ALLOW_ErrorCount,le.corp_sos_charter_nbr_LENGTHS_ErrorCount
          ,le.ar_year_ALLOW_ErrorCount
          ,le.ar_filed_dt_ALLOW_ErrorCount,le.ar_filed_dt_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.corp_key_ALLOW_ErrorCount,le.corp_key_LENGTHS_ErrorCount
          ,le.corp_vendor_ENUM_ErrorCount
          ,le.corp_state_origin_ENUM_ErrorCount
          ,le.corp_process_date_ALLOW_ErrorCount,le.corp_process_date_CUSTOM_ErrorCount
          ,le.corp_sos_charter_nbr_ALLOW_ErrorCount,le.corp_sos_charter_nbr_LENGTHS_ErrorCount
          ,le.ar_year_ALLOW_ErrorCount
          ,le.ar_filed_dt_ALLOW_ErrorCount,le.ar_filed_dt_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Corp2_Mapping.LayoutsCommon.AR));
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
          ,'corp_key:' + getFieldTypeText(h.corp_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_vendor:' + getFieldTypeText(h.corp_vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_vendor_county:' + getFieldTypeText(h.corp_vendor_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_vendor_subcode:' + getFieldTypeText(h.corp_vendor_subcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_state_origin:' + getFieldTypeText(h.corp_state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_process_date:' + getFieldTypeText(h.corp_process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'corp_sos_charter_nbr:' + getFieldTypeText(h.corp_sos_charter_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_year:' + getFieldTypeText(h.ar_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_mailed_dt:' + getFieldTypeText(h.ar_mailed_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_due_dt:' + getFieldTypeText(h.ar_due_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_filed_dt:' + getFieldTypeText(h.ar_filed_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_report_dt:' + getFieldTypeText(h.ar_report_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_report_nbr:' + getFieldTypeText(h.ar_report_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_franchise_tax_paid_dt:' + getFieldTypeText(h.ar_franchise_tax_paid_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_delinquent_dt:' + getFieldTypeText(h.ar_delinquent_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_tax_factor:' + getFieldTypeText(h.ar_tax_factor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_tax_amount_paid:' + getFieldTypeText(h.ar_tax_amount_paid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_annual_report_cap:' + getFieldTypeText(h.ar_annual_report_cap) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_illinois_capital:' + getFieldTypeText(h.ar_illinois_capital) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_roll:' + getFieldTypeText(h.ar_roll) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_frame:' + getFieldTypeText(h.ar_frame) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_extension:' + getFieldTypeText(h.ar_extension) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_microfilm_nbr:' + getFieldTypeText(h.ar_microfilm_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_comment:' + getFieldTypeText(h.ar_comment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_type:' + getFieldTypeText(h.ar_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_exempt:' + getFieldTypeText(h.ar_exempt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_license_tax_amount:' + getFieldTypeText(h.ar_license_tax_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_status:' + getFieldTypeText(h.ar_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_paid_date:' + getFieldTypeText(h.ar_paid_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_prev_paid_date:' + getFieldTypeText(h.ar_prev_paid_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_prev_tax_factor:' + getFieldTypeText(h.ar_prev_tax_factor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_extension_date:' + getFieldTypeText(h.ar_extension_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_report_mail_date:' + getFieldTypeText(h.ar_report_mail_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_deliquent_report_mail_date:' + getFieldTypeText(h.ar_deliquent_report_mail_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_report_filed_date:' + getFieldTypeText(h.ar_report_filed_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_year_and_month_due:' + getFieldTypeText(h.ar_year_and_month_due) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_corp_key_cnt
          ,le.populated_corp_vendor_cnt
          ,le.populated_corp_vendor_county_cnt
          ,le.populated_corp_vendor_subcode_cnt
          ,le.populated_corp_state_origin_cnt
          ,le.populated_corp_process_date_cnt
          ,le.populated_corp_sos_charter_nbr_cnt
          ,le.populated_ar_year_cnt
          ,le.populated_ar_mailed_dt_cnt
          ,le.populated_ar_due_dt_cnt
          ,le.populated_ar_filed_dt_cnt
          ,le.populated_ar_report_dt_cnt
          ,le.populated_ar_report_nbr_cnt
          ,le.populated_ar_franchise_tax_paid_dt_cnt
          ,le.populated_ar_delinquent_dt_cnt
          ,le.populated_ar_tax_factor_cnt
          ,le.populated_ar_tax_amount_paid_cnt
          ,le.populated_ar_annual_report_cap_cnt
          ,le.populated_ar_illinois_capital_cnt
          ,le.populated_ar_roll_cnt
          ,le.populated_ar_frame_cnt
          ,le.populated_ar_extension_cnt
          ,le.populated_ar_microfilm_nbr_cnt
          ,le.populated_ar_comment_cnt
          ,le.populated_ar_type_cnt
          ,le.populated_ar_exempt_cnt
          ,le.populated_ar_license_tax_amount_cnt
          ,le.populated_ar_status_cnt
          ,le.populated_ar_paid_date_cnt
          ,le.populated_ar_prev_paid_date_cnt
          ,le.populated_ar_prev_tax_factor_cnt
          ,le.populated_ar_extension_date_cnt
          ,le.populated_ar_report_mail_date_cnt
          ,le.populated_ar_deliquent_report_mail_date_cnt
          ,le.populated_ar_report_filed_date_cnt
          ,le.populated_ar_year_and_month_due_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_corp_key_pcnt
          ,le.populated_corp_vendor_pcnt
          ,le.populated_corp_vendor_county_pcnt
          ,le.populated_corp_vendor_subcode_pcnt
          ,le.populated_corp_state_origin_pcnt
          ,le.populated_corp_process_date_pcnt
          ,le.populated_corp_sos_charter_nbr_pcnt
          ,le.populated_ar_year_pcnt
          ,le.populated_ar_mailed_dt_pcnt
          ,le.populated_ar_due_dt_pcnt
          ,le.populated_ar_filed_dt_pcnt
          ,le.populated_ar_report_dt_pcnt
          ,le.populated_ar_report_nbr_pcnt
          ,le.populated_ar_franchise_tax_paid_dt_pcnt
          ,le.populated_ar_delinquent_dt_pcnt
          ,le.populated_ar_tax_factor_pcnt
          ,le.populated_ar_tax_amount_paid_pcnt
          ,le.populated_ar_annual_report_cap_pcnt
          ,le.populated_ar_illinois_capital_pcnt
          ,le.populated_ar_roll_pcnt
          ,le.populated_ar_frame_pcnt
          ,le.populated_ar_extension_pcnt
          ,le.populated_ar_microfilm_nbr_pcnt
          ,le.populated_ar_comment_pcnt
          ,le.populated_ar_type_pcnt
          ,le.populated_ar_exempt_pcnt
          ,le.populated_ar_license_tax_amount_pcnt
          ,le.populated_ar_status_pcnt
          ,le.populated_ar_paid_date_pcnt
          ,le.populated_ar_prev_paid_date_pcnt
          ,le.populated_ar_prev_tax_factor_pcnt
          ,le.populated_ar_extension_date_pcnt
          ,le.populated_ar_report_mail_date_pcnt
          ,le.populated_ar_deliquent_report_mail_date_pcnt
          ,le.populated_ar_report_filed_date_pcnt
          ,le.populated_ar_year_and_month_due_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,36,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Corp2_Mapping.LayoutsCommon.AR));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),36,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Corp2_Mapping.LayoutsCommon.AR) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Corp2_Mapping_MI_AR, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
