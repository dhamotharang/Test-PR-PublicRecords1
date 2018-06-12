IMPORT SALT38,STD,Corp2_Mapping;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 9;
  EXPORT NumRulesFromFieldType := 9;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 6;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Corp2_Mapping.LayoutsCommon.Stock)
    UNSIGNED1 corp_key_Invalid;
    UNSIGNED1 corp_vendor_Invalid;
    UNSIGNED1 corp_state_origin_Invalid;
    UNSIGNED1 corp_process_date_Invalid;
    UNSIGNED1 corp_sos_charter_nbr_Invalid;
    UNSIGNED1 stock_authorized_nbr_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Corp2_Mapping.LayoutsCommon.Stock)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Corp2_Mapping.LayoutsCommon.Stock) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.corp_key_Invalid := Fields.InValid_corp_key((SALT38.StrType)le.corp_key);
    SELF.corp_vendor_Invalid := Fields.InValid_corp_vendor((SALT38.StrType)le.corp_vendor);
    SELF.corp_state_origin_Invalid := Fields.InValid_corp_state_origin((SALT38.StrType)le.corp_state_origin);
    SELF.corp_process_date_Invalid := Fields.InValid_corp_process_date((SALT38.StrType)le.corp_process_date);
    SELF.corp_sos_charter_nbr_Invalid := Fields.InValid_corp_sos_charter_nbr((SALT38.StrType)le.corp_sos_charter_nbr);
    SELF.stock_authorized_nbr_Invalid := Fields.InValid_stock_authorized_nbr((SALT38.StrType)le.stock_authorized_nbr);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Corp2_Mapping.LayoutsCommon.Stock);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.corp_key_Invalid << 0 ) + ( le.corp_vendor_Invalid << 2 ) + ( le.corp_state_origin_Invalid << 3 ) + ( le.corp_process_date_Invalid << 4 ) + ( le.corp_sos_charter_nbr_Invalid << 6 ) + ( le.stock_authorized_nbr_Invalid << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Corp2_Mapping.LayoutsCommon.Stock);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.corp_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.corp_vendor_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.corp_state_origin_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.corp_process_date_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.corp_sos_charter_nbr_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.stock_authorized_nbr_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
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
    stock_authorized_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.stock_authorized_nbr_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.corp_key_Invalid > 0 OR h.corp_vendor_Invalid > 0 OR h.corp_state_origin_Invalid > 0 OR h.corp_process_date_Invalid > 0 OR h.corp_sos_charter_nbr_Invalid > 0 OR h.stock_authorized_nbr_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.corp_key_Total_ErrorCount > 0, 1, 0) + IF(le.corp_vendor_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_Total_ErrorCount > 0, 1, 0) + IF(le.corp_sos_charter_nbr_Total_ErrorCount > 0, 1, 0) + IF(le.stock_authorized_nbr_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.corp_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.corp_vendor_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.corp_sos_charter_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.corp_sos_charter_nbr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.stock_authorized_nbr_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.corp_key_Invalid,le.corp_vendor_Invalid,le.corp_state_origin_Invalid,le.corp_process_date_Invalid,le.corp_sos_charter_nbr_Invalid,le.stock_authorized_nbr_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_corp_key(le.corp_key_Invalid),Fields.InvalidMessage_corp_vendor(le.corp_vendor_Invalid),Fields.InvalidMessage_corp_state_origin(le.corp_state_origin_Invalid),Fields.InvalidMessage_corp_process_date(le.corp_process_date_Invalid),Fields.InvalidMessage_corp_sos_charter_nbr(le.corp_sos_charter_nbr_Invalid),Fields.InvalidMessage_stock_authorized_nbr(le.stock_authorized_nbr_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.corp_key_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.corp_vendor_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.corp_process_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.corp_sos_charter_nbr_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.stock_authorized_nbr_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_sos_charter_nbr','stock_authorized_nbr','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_date','invalid_charter_nbr','invalid_stock_authorized_nbr','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.corp_key,(SALT38.StrType)le.corp_vendor,(SALT38.StrType)le.corp_state_origin,(SALT38.StrType)le.corp_process_date,(SALT38.StrType)le.corp_sos_charter_nbr,(SALT38.StrType)le.stock_authorized_nbr,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,6,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Corp2_Mapping.LayoutsCommon.Stock) prevDS = DATASET([], Corp2_Mapping.LayoutsCommon.Stock), STRING10 Src='UNK'):= FUNCTION
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
          ,'stock_authorized_nbr:invalid_stock_authorized_nbr:ALLOW'
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
          ,Fields.InvalidMessage_stock_authorized_nbr(1)
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
          ,le.stock_authorized_nbr_ALLOW_ErrorCount
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
          ,le.stock_authorized_nbr_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Corp2_Mapping.LayoutsCommon.Stock));
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
          ,'stock_ticker_symbol:' + getFieldTypeText(h.stock_ticker_symbol) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_exchange:' + getFieldTypeText(h.stock_exchange) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_type:' + getFieldTypeText(h.stock_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_class:' + getFieldTypeText(h.stock_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_shares_issued:' + getFieldTypeText(h.stock_shares_issued) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_authorized_nbr:' + getFieldTypeText(h.stock_authorized_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_par_value:' + getFieldTypeText(h.stock_par_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_nbr_par_shares:' + getFieldTypeText(h.stock_nbr_par_shares) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_change_ind:' + getFieldTypeText(h.stock_change_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_change_date:' + getFieldTypeText(h.stock_change_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_voting_rights_ind:' + getFieldTypeText(h.stock_voting_rights_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_convert_ind:' + getFieldTypeText(h.stock_convert_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_convert_date:' + getFieldTypeText(h.stock_convert_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_change_in_cap:' + getFieldTypeText(h.stock_change_in_cap) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_tax_capital:' + getFieldTypeText(h.stock_tax_capital) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_total_capital:' + getFieldTypeText(h.stock_total_capital) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_addl_info:' + getFieldTypeText(h.stock_addl_info) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_stock_description:' + getFieldTypeText(h.stock_stock_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_stock_series:' + getFieldTypeText(h.stock_stock_series) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_non_par_value_flag:' + getFieldTypeText(h.stock_non_par_value_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_additional_stock:' + getFieldTypeText(h.stock_additional_stock) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_shares_proportion_to_ohio_for_foreign_license:' + getFieldTypeText(h.stock_shares_proportion_to_ohio_for_foreign_license) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_share_credits:' + getFieldTypeText(h.stock_share_credits) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_authorized_capital:' + getFieldTypeText(h.stock_authorized_capital) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_stock_paid_in_capital:' + getFieldTypeText(h.stock_stock_paid_in_capital) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_pay_higher_stock_fees:' + getFieldTypeText(h.stock_pay_higher_stock_fees) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_actual_amt_invested_in_state:' + getFieldTypeText(h.stock_actual_amt_invested_in_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_share_exchange_during_merger:' + getFieldTypeText(h.stock_share_exchange_during_merger) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_date_stock_limit_approved:' + getFieldTypeText(h.stock_date_stock_limit_approved) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_number_of_shares_paid_for:' + getFieldTypeText(h.stock_number_of_shares_paid_for) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_total_value_of_shares_paid_for:' + getFieldTypeText(h.stock_total_value_of_shares_paid_for) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_sharesofbeneficialinterest:' + getFieldTypeText(h.stock_sharesofbeneficialinterest) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stock_beneficialsharevalue:' + getFieldTypeText(h.stock_beneficialsharevalue) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_corp_key_cnt
          ,le.populated_corp_vendor_cnt
          ,le.populated_corp_vendor_county_cnt
          ,le.populated_corp_vendor_subcode_cnt
          ,le.populated_corp_state_origin_cnt
          ,le.populated_corp_process_date_cnt
          ,le.populated_corp_sos_charter_nbr_cnt
          ,le.populated_stock_ticker_symbol_cnt
          ,le.populated_stock_exchange_cnt
          ,le.populated_stock_type_cnt
          ,le.populated_stock_class_cnt
          ,le.populated_stock_shares_issued_cnt
          ,le.populated_stock_authorized_nbr_cnt
          ,le.populated_stock_par_value_cnt
          ,le.populated_stock_nbr_par_shares_cnt
          ,le.populated_stock_change_ind_cnt
          ,le.populated_stock_change_date_cnt
          ,le.populated_stock_voting_rights_ind_cnt
          ,le.populated_stock_convert_ind_cnt
          ,le.populated_stock_convert_date_cnt
          ,le.populated_stock_change_in_cap_cnt
          ,le.populated_stock_tax_capital_cnt
          ,le.populated_stock_total_capital_cnt
          ,le.populated_stock_addl_info_cnt
          ,le.populated_stock_stock_description_cnt
          ,le.populated_stock_stock_series_cnt
          ,le.populated_stock_non_par_value_flag_cnt
          ,le.populated_stock_additional_stock_cnt
          ,le.populated_stock_shares_proportion_to_ohio_for_foreign_license_cnt
          ,le.populated_stock_share_credits_cnt
          ,le.populated_stock_authorized_capital_cnt
          ,le.populated_stock_stock_paid_in_capital_cnt
          ,le.populated_stock_pay_higher_stock_fees_cnt
          ,le.populated_stock_actual_amt_invested_in_state_cnt
          ,le.populated_stock_share_exchange_during_merger_cnt
          ,le.populated_stock_date_stock_limit_approved_cnt
          ,le.populated_stock_number_of_shares_paid_for_cnt
          ,le.populated_stock_total_value_of_shares_paid_for_cnt
          ,le.populated_stock_sharesofbeneficialinterest_cnt
          ,le.populated_stock_beneficialsharevalue_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_corp_key_pcnt
          ,le.populated_corp_vendor_pcnt
          ,le.populated_corp_vendor_county_pcnt
          ,le.populated_corp_vendor_subcode_pcnt
          ,le.populated_corp_state_origin_pcnt
          ,le.populated_corp_process_date_pcnt
          ,le.populated_corp_sos_charter_nbr_pcnt
          ,le.populated_stock_ticker_symbol_pcnt
          ,le.populated_stock_exchange_pcnt
          ,le.populated_stock_type_pcnt
          ,le.populated_stock_class_pcnt
          ,le.populated_stock_shares_issued_pcnt
          ,le.populated_stock_authorized_nbr_pcnt
          ,le.populated_stock_par_value_pcnt
          ,le.populated_stock_nbr_par_shares_pcnt
          ,le.populated_stock_change_ind_pcnt
          ,le.populated_stock_change_date_pcnt
          ,le.populated_stock_voting_rights_ind_pcnt
          ,le.populated_stock_convert_ind_pcnt
          ,le.populated_stock_convert_date_pcnt
          ,le.populated_stock_change_in_cap_pcnt
          ,le.populated_stock_tax_capital_pcnt
          ,le.populated_stock_total_capital_pcnt
          ,le.populated_stock_addl_info_pcnt
          ,le.populated_stock_stock_description_pcnt
          ,le.populated_stock_stock_series_pcnt
          ,le.populated_stock_non_par_value_flag_pcnt
          ,le.populated_stock_additional_stock_pcnt
          ,le.populated_stock_shares_proportion_to_ohio_for_foreign_license_pcnt
          ,le.populated_stock_share_credits_pcnt
          ,le.populated_stock_authorized_capital_pcnt
          ,le.populated_stock_stock_paid_in_capital_pcnt
          ,le.populated_stock_pay_higher_stock_fees_pcnt
          ,le.populated_stock_actual_amt_invested_in_state_pcnt
          ,le.populated_stock_share_exchange_during_merger_pcnt
          ,le.populated_stock_date_stock_limit_approved_pcnt
          ,le.populated_stock_number_of_shares_paid_for_pcnt
          ,le.populated_stock_total_value_of_shares_paid_for_pcnt
          ,le.populated_stock_sharesofbeneficialinterest_pcnt
          ,le.populated_stock_beneficialsharevalue_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,40,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Corp2_Mapping.LayoutsCommon.Stock));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),40,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Corp2_Mapping.LayoutsCommon.Stock) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Corp2_Mapping_MI_Stock, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
