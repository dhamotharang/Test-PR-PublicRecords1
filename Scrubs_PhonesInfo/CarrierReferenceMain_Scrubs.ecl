IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT CarrierReferenceMain_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 35;
  EXPORT NumRulesFromFieldType := 35;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 31;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(CarrierReferenceMain_Layout_PhonesInfo)
    UNSIGNED1 dt_first_reported_Invalid;
    UNSIGNED1 dt_last_reported_Invalid;
    UNSIGNED1 dt_start_Invalid;
    UNSIGNED1 dt_end_Invalid;
    UNSIGNED1 ocn_Invalid;
    UNSIGNED1 carrier_name_Invalid;
    UNSIGNED1 serv_Invalid;
    UNSIGNED1 line_Invalid;
    UNSIGNED1 prepaid_Invalid;
    UNSIGNED1 high_risk_indicator_Invalid;
    UNSIGNED1 spid_Invalid;
    UNSIGNED1 operator_full_name_Invalid;
    UNSIGNED1 override_file_Invalid;
    UNSIGNED1 data_type_Invalid;
    UNSIGNED1 ocn_state_Invalid;
    UNSIGNED1 overall_ocn_Invalid;
    UNSIGNED1 target_ocn_Invalid;
    UNSIGNED1 overall_target_ocn_Invalid;
    UNSIGNED1 rural_lec_indicator_Invalid;
    UNSIGNED1 small_ilec_indicator_Invalid;
    UNSIGNED1 category_Invalid;
    UNSIGNED1 carrier_city_Invalid;
    UNSIGNED1 carrier_state_Invalid;
    UNSIGNED1 carrier_zip_Invalid;
    UNSIGNED1 carrier_phone_Invalid;
    UNSIGNED1 contact_city_Invalid;
    UNSIGNED1 contact_state_Invalid;
    UNSIGNED1 contact_zip_Invalid;
    UNSIGNED1 contact_phone_Invalid;
    UNSIGNED1 contact_fax_Invalid;
    UNSIGNED1 contact_email_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(CarrierReferenceMain_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(CarrierReferenceMain_Layout_PhonesInfo)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dt_first_reported:Invalid_Date:CUSTOM'
          ,'dt_last_reported:Invalid_Date:CUSTOM'
          ,'dt_start:Invalid_Date:CUSTOM'
          ,'dt_end:Invalid_Date:CUSTOM'
          ,'ocn:Invalid_Ocn_Name:ALLOW','ocn:Invalid_Ocn_Name:LENGTHS'
          ,'carrier_name:Invalid_NotBlank:LENGTHS'
          ,'serv:Invalid_Type:ALLOW','serv:Invalid_Type:LENGTHS'
          ,'line:Invalid_Type:ALLOW','line:Invalid_Type:LENGTHS'
          ,'prepaid:Invalid_Flag:ALLOW'
          ,'high_risk_indicator:Invalid_Flag:ALLOW'
          ,'spid:Invalid_Ocn_Name:ALLOW','spid:Invalid_Ocn_Name:LENGTHS'
          ,'operator_full_name:Invalid_NotBlank:LENGTHS'
          ,'override_file:Invalid_Alpha:ALLOW'
          ,'data_type:Invalid_Alpha:ALLOW'
          ,'ocn_state:Invalid_Alpha:ALLOW'
          ,'overall_ocn:Invalid_AlphaNum:ALLOW'
          ,'target_ocn:Invalid_AlphaNum:ALLOW'
          ,'overall_target_ocn:Invalid_AlphaNum:ALLOW'
          ,'rural_lec_indicator:Invalid_Indicator:ALLOW'
          ,'small_ilec_indicator:Invalid_Indicator:ALLOW'
          ,'category:Invalid_Alpha:ALLOW'
          ,'carrier_city:Invalid_Char:ALLOW'
          ,'carrier_state:Invalid_Alpha:ALLOW'
          ,'carrier_zip:Invalid_AlphaNum:ALLOW'
          ,'carrier_phone:Invalid_Num:ALLOW'
          ,'contact_city:Invalid_Char:ALLOW'
          ,'contact_state:Invalid_Alpha:ALLOW'
          ,'contact_zip:Invalid_AlphaNum:ALLOW'
          ,'contact_phone:Invalid_Num:ALLOW'
          ,'contact_fax:Invalid_Num:ALLOW'
          ,'contact_email:Invalid_Email:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,CarrierReferenceMain_Fields.InvalidMessage_dt_first_reported(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_dt_last_reported(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_dt_start(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_dt_end(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_ocn(1),CarrierReferenceMain_Fields.InvalidMessage_ocn(2)
          ,CarrierReferenceMain_Fields.InvalidMessage_carrier_name(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_serv(1),CarrierReferenceMain_Fields.InvalidMessage_serv(2)
          ,CarrierReferenceMain_Fields.InvalidMessage_line(1),CarrierReferenceMain_Fields.InvalidMessage_line(2)
          ,CarrierReferenceMain_Fields.InvalidMessage_prepaid(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_high_risk_indicator(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_spid(1),CarrierReferenceMain_Fields.InvalidMessage_spid(2)
          ,CarrierReferenceMain_Fields.InvalidMessage_operator_full_name(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_override_file(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_data_type(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_ocn_state(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_overall_ocn(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_target_ocn(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_overall_target_ocn(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_rural_lec_indicator(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_small_ilec_indicator(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_category(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_carrier_city(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_carrier_state(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_carrier_zip(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_carrier_phone(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_contact_city(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_contact_state(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_contact_zip(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_contact_phone(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_contact_fax(1)
          ,CarrierReferenceMain_Fields.InvalidMessage_contact_email(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(CarrierReferenceMain_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_reported_Invalid := CarrierReferenceMain_Fields.InValid_dt_first_reported((SALT311.StrType)le.dt_first_reported);
    SELF.dt_last_reported_Invalid := CarrierReferenceMain_Fields.InValid_dt_last_reported((SALT311.StrType)le.dt_last_reported);
    SELF.dt_start_Invalid := CarrierReferenceMain_Fields.InValid_dt_start((SALT311.StrType)le.dt_start);
    SELF.dt_end_Invalid := CarrierReferenceMain_Fields.InValid_dt_end((SALT311.StrType)le.dt_end);
    SELF.ocn_Invalid := CarrierReferenceMain_Fields.InValid_ocn((SALT311.StrType)le.ocn);
    SELF.carrier_name_Invalid := CarrierReferenceMain_Fields.InValid_carrier_name((SALT311.StrType)le.carrier_name);
    SELF.serv_Invalid := CarrierReferenceMain_Fields.InValid_serv((SALT311.StrType)le.serv);
    SELF.line_Invalid := CarrierReferenceMain_Fields.InValid_line((SALT311.StrType)le.line);
    SELF.prepaid_Invalid := CarrierReferenceMain_Fields.InValid_prepaid((SALT311.StrType)le.prepaid);
    SELF.high_risk_indicator_Invalid := CarrierReferenceMain_Fields.InValid_high_risk_indicator((SALT311.StrType)le.high_risk_indicator);
    SELF.spid_Invalid := CarrierReferenceMain_Fields.InValid_spid((SALT311.StrType)le.spid);
    SELF.operator_full_name_Invalid := CarrierReferenceMain_Fields.InValid_operator_full_name((SALT311.StrType)le.operator_full_name);
    SELF.override_file_Invalid := CarrierReferenceMain_Fields.InValid_override_file((SALT311.StrType)le.override_file);
    SELF.data_type_Invalid := CarrierReferenceMain_Fields.InValid_data_type((SALT311.StrType)le.data_type);
    SELF.ocn_state_Invalid := CarrierReferenceMain_Fields.InValid_ocn_state((SALT311.StrType)le.ocn_state);
    SELF.overall_ocn_Invalid := CarrierReferenceMain_Fields.InValid_overall_ocn((SALT311.StrType)le.overall_ocn);
    SELF.target_ocn_Invalid := CarrierReferenceMain_Fields.InValid_target_ocn((SALT311.StrType)le.target_ocn);
    SELF.overall_target_ocn_Invalid := CarrierReferenceMain_Fields.InValid_overall_target_ocn((SALT311.StrType)le.overall_target_ocn);
    SELF.rural_lec_indicator_Invalid := CarrierReferenceMain_Fields.InValid_rural_lec_indicator((SALT311.StrType)le.rural_lec_indicator);
    SELF.small_ilec_indicator_Invalid := CarrierReferenceMain_Fields.InValid_small_ilec_indicator((SALT311.StrType)le.small_ilec_indicator);
    SELF.category_Invalid := CarrierReferenceMain_Fields.InValid_category((SALT311.StrType)le.category);
    SELF.carrier_city_Invalid := CarrierReferenceMain_Fields.InValid_carrier_city((SALT311.StrType)le.carrier_city);
    SELF.carrier_state_Invalid := CarrierReferenceMain_Fields.InValid_carrier_state((SALT311.StrType)le.carrier_state);
    SELF.carrier_zip_Invalid := CarrierReferenceMain_Fields.InValid_carrier_zip((SALT311.StrType)le.carrier_zip);
    SELF.carrier_phone_Invalid := CarrierReferenceMain_Fields.InValid_carrier_phone((SALT311.StrType)le.carrier_phone);
    SELF.contact_city_Invalid := CarrierReferenceMain_Fields.InValid_contact_city((SALT311.StrType)le.contact_city);
    SELF.contact_state_Invalid := CarrierReferenceMain_Fields.InValid_contact_state((SALT311.StrType)le.contact_state);
    SELF.contact_zip_Invalid := CarrierReferenceMain_Fields.InValid_contact_zip((SALT311.StrType)le.contact_zip);
    SELF.contact_phone_Invalid := CarrierReferenceMain_Fields.InValid_contact_phone((SALT311.StrType)le.contact_phone);
    SELF.contact_fax_Invalid := CarrierReferenceMain_Fields.InValid_contact_fax((SALT311.StrType)le.contact_fax);
    SELF.contact_email_Invalid := CarrierReferenceMain_Fields.InValid_contact_email((SALT311.StrType)le.contact_email);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),CarrierReferenceMain_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_reported_Invalid << 0 ) + ( le.dt_last_reported_Invalid << 1 ) + ( le.dt_start_Invalid << 2 ) + ( le.dt_end_Invalid << 3 ) + ( le.ocn_Invalid << 4 ) + ( le.carrier_name_Invalid << 6 ) + ( le.serv_Invalid << 7 ) + ( le.line_Invalid << 9 ) + ( le.prepaid_Invalid << 11 ) + ( le.high_risk_indicator_Invalid << 12 ) + ( le.spid_Invalid << 13 ) + ( le.operator_full_name_Invalid << 15 ) + ( le.override_file_Invalid << 16 ) + ( le.data_type_Invalid << 17 ) + ( le.ocn_state_Invalid << 18 ) + ( le.overall_ocn_Invalid << 19 ) + ( le.target_ocn_Invalid << 20 ) + ( le.overall_target_ocn_Invalid << 21 ) + ( le.rural_lec_indicator_Invalid << 22 ) + ( le.small_ilec_indicator_Invalid << 23 ) + ( le.category_Invalid << 24 ) + ( le.carrier_city_Invalid << 25 ) + ( le.carrier_state_Invalid << 26 ) + ( le.carrier_zip_Invalid << 27 ) + ( le.carrier_phone_Invalid << 28 ) + ( le.contact_city_Invalid << 29 ) + ( le.contact_state_Invalid << 30 ) + ( le.contact_zip_Invalid << 31 ) + ( le.contact_phone_Invalid << 32 ) + ( le.contact_fax_Invalid << 33 ) + ( le.contact_email_Invalid << 34 );
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
  EXPORT Infile := PROJECT(h,CarrierReferenceMain_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_reported_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_reported_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_start_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_end_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.ocn_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.carrier_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.serv_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.line_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.prepaid_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.high_risk_indicator_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.spid_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.operator_full_name_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.override_file_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.data_type_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ocn_state_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.overall_ocn_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.target_ocn_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.overall_target_ocn_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.rural_lec_indicator_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.small_ilec_indicator_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.category_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.carrier_city_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.carrier_state_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.carrier_zip_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.carrier_phone_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.contact_city_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.contact_state_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.contact_zip_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.contact_phone_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.contact_fax_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.contact_email_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_reported_Invalid=1);
    dt_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_reported_Invalid=1);
    dt_start_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_start_Invalid=1);
    dt_end_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_end_Invalid=1);
    ocn_ALLOW_ErrorCount := COUNT(GROUP,h.ocn_Invalid=1);
    ocn_LENGTHS_ErrorCount := COUNT(GROUP,h.ocn_Invalid=2);
    ocn_Total_ErrorCount := COUNT(GROUP,h.ocn_Invalid>0);
    carrier_name_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_name_Invalid=1);
    serv_ALLOW_ErrorCount := COUNT(GROUP,h.serv_Invalid=1);
    serv_LENGTHS_ErrorCount := COUNT(GROUP,h.serv_Invalid=2);
    serv_Total_ErrorCount := COUNT(GROUP,h.serv_Invalid>0);
    line_ALLOW_ErrorCount := COUNT(GROUP,h.line_Invalid=1);
    line_LENGTHS_ErrorCount := COUNT(GROUP,h.line_Invalid=2);
    line_Total_ErrorCount := COUNT(GROUP,h.line_Invalid>0);
    prepaid_ALLOW_ErrorCount := COUNT(GROUP,h.prepaid_Invalid=1);
    high_risk_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.high_risk_indicator_Invalid=1);
    spid_ALLOW_ErrorCount := COUNT(GROUP,h.spid_Invalid=1);
    spid_LENGTHS_ErrorCount := COUNT(GROUP,h.spid_Invalid=2);
    spid_Total_ErrorCount := COUNT(GROUP,h.spid_Invalid>0);
    operator_full_name_LENGTHS_ErrorCount := COUNT(GROUP,h.operator_full_name_Invalid=1);
    override_file_ALLOW_ErrorCount := COUNT(GROUP,h.override_file_Invalid=1);
    data_type_ALLOW_ErrorCount := COUNT(GROUP,h.data_type_Invalid=1);
    ocn_state_ALLOW_ErrorCount := COUNT(GROUP,h.ocn_state_Invalid=1);
    overall_ocn_ALLOW_ErrorCount := COUNT(GROUP,h.overall_ocn_Invalid=1);
    target_ocn_ALLOW_ErrorCount := COUNT(GROUP,h.target_ocn_Invalid=1);
    overall_target_ocn_ALLOW_ErrorCount := COUNT(GROUP,h.overall_target_ocn_Invalid=1);
    rural_lec_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.rural_lec_indicator_Invalid=1);
    small_ilec_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.small_ilec_indicator_Invalid=1);
    category_ALLOW_ErrorCount := COUNT(GROUP,h.category_Invalid=1);
    carrier_city_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_city_Invalid=1);
    carrier_state_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_state_Invalid=1);
    carrier_zip_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_zip_Invalid=1);
    carrier_phone_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_phone_Invalid=1);
    contact_city_ALLOW_ErrorCount := COUNT(GROUP,h.contact_city_Invalid=1);
    contact_state_ALLOW_ErrorCount := COUNT(GROUP,h.contact_state_Invalid=1);
    contact_zip_ALLOW_ErrorCount := COUNT(GROUP,h.contact_zip_Invalid=1);
    contact_phone_ALLOW_ErrorCount := COUNT(GROUP,h.contact_phone_Invalid=1);
    contact_fax_ALLOW_ErrorCount := COUNT(GROUP,h.contact_fax_Invalid=1);
    contact_email_ALLOW_ErrorCount := COUNT(GROUP,h.contact_email_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_reported_Invalid > 0 OR h.dt_last_reported_Invalid > 0 OR h.dt_start_Invalid > 0 OR h.dt_end_Invalid > 0 OR h.ocn_Invalid > 0 OR h.carrier_name_Invalid > 0 OR h.serv_Invalid > 0 OR h.line_Invalid > 0 OR h.prepaid_Invalid > 0 OR h.high_risk_indicator_Invalid > 0 OR h.spid_Invalid > 0 OR h.operator_full_name_Invalid > 0 OR h.override_file_Invalid > 0 OR h.data_type_Invalid > 0 OR h.ocn_state_Invalid > 0 OR h.overall_ocn_Invalid > 0 OR h.target_ocn_Invalid > 0 OR h.overall_target_ocn_Invalid > 0 OR h.rural_lec_indicator_Invalid > 0 OR h.small_ilec_indicator_Invalid > 0 OR h.category_Invalid > 0 OR h.carrier_city_Invalid > 0 OR h.carrier_state_Invalid > 0 OR h.carrier_zip_Invalid > 0 OR h.carrier_phone_Invalid > 0 OR h.contact_city_Invalid > 0 OR h.contact_state_Invalid > 0 OR h.contact_zip_Invalid > 0 OR h.contact_phone_Invalid > 0 OR h.contact_fax_Invalid > 0 OR h.contact_email_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_start_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_end_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ocn_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.serv_Total_ErrorCount > 0, 1, 0) + IF(le.line_Total_ErrorCount > 0, 1, 0) + IF(le.prepaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.high_risk_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_Total_ErrorCount > 0, 1, 0) + IF(le.operator_full_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.override_file_ALLOW_ErrorCount > 0, 1, 0) + IF(le.data_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.overall_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.target_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.overall_target_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rural_lec_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.small_ilec_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_fax_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_email_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_start_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_end_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.serv_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serv_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.line_ALLOW_ErrorCount > 0, 1, 0) + IF(le.line_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prepaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.high_risk_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.operator_full_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.override_file_ALLOW_ErrorCount > 0, 1, 0) + IF(le.data_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.overall_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.target_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.overall_target_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rural_lec_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.small_ilec_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_fax_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_email_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_reported_Invalid,le.dt_last_reported_Invalid,le.dt_start_Invalid,le.dt_end_Invalid,le.ocn_Invalid,le.carrier_name_Invalid,le.serv_Invalid,le.line_Invalid,le.prepaid_Invalid,le.high_risk_indicator_Invalid,le.spid_Invalid,le.operator_full_name_Invalid,le.override_file_Invalid,le.data_type_Invalid,le.ocn_state_Invalid,le.overall_ocn_Invalid,le.target_ocn_Invalid,le.overall_target_ocn_Invalid,le.rural_lec_indicator_Invalid,le.small_ilec_indicator_Invalid,le.category_Invalid,le.carrier_city_Invalid,le.carrier_state_Invalid,le.carrier_zip_Invalid,le.carrier_phone_Invalid,le.contact_city_Invalid,le.contact_state_Invalid,le.contact_zip_Invalid,le.contact_phone_Invalid,le.contact_fax_Invalid,le.contact_email_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,CarrierReferenceMain_Fields.InvalidMessage_dt_first_reported(le.dt_first_reported_Invalid),CarrierReferenceMain_Fields.InvalidMessage_dt_last_reported(le.dt_last_reported_Invalid),CarrierReferenceMain_Fields.InvalidMessage_dt_start(le.dt_start_Invalid),CarrierReferenceMain_Fields.InvalidMessage_dt_end(le.dt_end_Invalid),CarrierReferenceMain_Fields.InvalidMessage_ocn(le.ocn_Invalid),CarrierReferenceMain_Fields.InvalidMessage_carrier_name(le.carrier_name_Invalid),CarrierReferenceMain_Fields.InvalidMessage_serv(le.serv_Invalid),CarrierReferenceMain_Fields.InvalidMessage_line(le.line_Invalid),CarrierReferenceMain_Fields.InvalidMessage_prepaid(le.prepaid_Invalid),CarrierReferenceMain_Fields.InvalidMessage_high_risk_indicator(le.high_risk_indicator_Invalid),CarrierReferenceMain_Fields.InvalidMessage_spid(le.spid_Invalid),CarrierReferenceMain_Fields.InvalidMessage_operator_full_name(le.operator_full_name_Invalid),CarrierReferenceMain_Fields.InvalidMessage_override_file(le.override_file_Invalid),CarrierReferenceMain_Fields.InvalidMessage_data_type(le.data_type_Invalid),CarrierReferenceMain_Fields.InvalidMessage_ocn_state(le.ocn_state_Invalid),CarrierReferenceMain_Fields.InvalidMessage_overall_ocn(le.overall_ocn_Invalid),CarrierReferenceMain_Fields.InvalidMessage_target_ocn(le.target_ocn_Invalid),CarrierReferenceMain_Fields.InvalidMessage_overall_target_ocn(le.overall_target_ocn_Invalid),CarrierReferenceMain_Fields.InvalidMessage_rural_lec_indicator(le.rural_lec_indicator_Invalid),CarrierReferenceMain_Fields.InvalidMessage_small_ilec_indicator(le.small_ilec_indicator_Invalid),CarrierReferenceMain_Fields.InvalidMessage_category(le.category_Invalid),CarrierReferenceMain_Fields.InvalidMessage_carrier_city(le.carrier_city_Invalid),CarrierReferenceMain_Fields.InvalidMessage_carrier_state(le.carrier_state_Invalid),CarrierReferenceMain_Fields.InvalidMessage_carrier_zip(le.carrier_zip_Invalid),CarrierReferenceMain_Fields.InvalidMessage_carrier_phone(le.carrier_phone_Invalid),CarrierReferenceMain_Fields.InvalidMessage_contact_city(le.contact_city_Invalid),CarrierReferenceMain_Fields.InvalidMessage_contact_state(le.contact_state_Invalid),CarrierReferenceMain_Fields.InvalidMessage_contact_zip(le.contact_zip_Invalid),CarrierReferenceMain_Fields.InvalidMessage_contact_phone(le.contact_phone_Invalid),CarrierReferenceMain_Fields.InvalidMessage_contact_fax(le.contact_fax_Invalid),CarrierReferenceMain_Fields.InvalidMessage_contact_email(le.contact_email_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_start_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_end_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ocn_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.serv_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.line_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prepaid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.high_risk_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spid_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.operator_full_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.override_file_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.data_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ocn_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.overall_ocn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.target_ocn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.overall_target_ocn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rural_lec_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.small_ilec_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.category_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_fax_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_email_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_reported','dt_last_reported','dt_start','dt_end','ocn','carrier_name','serv','line','prepaid','high_risk_indicator','spid','operator_full_name','override_file','data_type','ocn_state','overall_ocn','target_ocn','overall_target_ocn','rural_lec_indicator','small_ilec_indicator','category','carrier_city','carrier_state','carrier_zip','carrier_phone','contact_city','contact_state','contact_zip','contact_phone','contact_fax','contact_email','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Ocn_Name','Invalid_NotBlank','Invalid_Type','Invalid_Type','Invalid_Flag','Invalid_Flag','Invalid_Ocn_Name','Invalid_NotBlank','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Indicator','Invalid_Indicator','Invalid_Alpha','Invalid_Char','Invalid_Alpha','Invalid_AlphaNum','Invalid_Num','Invalid_Char','Invalid_Alpha','Invalid_AlphaNum','Invalid_Num','Invalid_Num','Invalid_Email','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_reported,(SALT311.StrType)le.dt_last_reported,(SALT311.StrType)le.dt_start,(SALT311.StrType)le.dt_end,(SALT311.StrType)le.ocn,(SALT311.StrType)le.carrier_name,(SALT311.StrType)le.serv,(SALT311.StrType)le.line,(SALT311.StrType)le.prepaid,(SALT311.StrType)le.high_risk_indicator,(SALT311.StrType)le.spid,(SALT311.StrType)le.operator_full_name,(SALT311.StrType)le.override_file,(SALT311.StrType)le.data_type,(SALT311.StrType)le.ocn_state,(SALT311.StrType)le.overall_ocn,(SALT311.StrType)le.target_ocn,(SALT311.StrType)le.overall_target_ocn,(SALT311.StrType)le.rural_lec_indicator,(SALT311.StrType)le.small_ilec_indicator,(SALT311.StrType)le.category,(SALT311.StrType)le.carrier_city,(SALT311.StrType)le.carrier_state,(SALT311.StrType)le.carrier_zip,(SALT311.StrType)le.carrier_phone,(SALT311.StrType)le.contact_city,(SALT311.StrType)le.contact_state,(SALT311.StrType)le.contact_zip,(SALT311.StrType)le.contact_phone,(SALT311.StrType)le.contact_fax,(SALT311.StrType)le.contact_email,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,31,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(CarrierReferenceMain_Layout_PhonesInfo) prevDS = DATASET([], CarrierReferenceMain_Layout_PhonesInfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_reported_CUSTOM_ErrorCount
          ,le.dt_last_reported_CUSTOM_ErrorCount
          ,le.dt_start_CUSTOM_ErrorCount
          ,le.dt_end_CUSTOM_ErrorCount
          ,le.ocn_ALLOW_ErrorCount,le.ocn_LENGTHS_ErrorCount
          ,le.carrier_name_LENGTHS_ErrorCount
          ,le.serv_ALLOW_ErrorCount,le.serv_LENGTHS_ErrorCount
          ,le.line_ALLOW_ErrorCount,le.line_LENGTHS_ErrorCount
          ,le.prepaid_ALLOW_ErrorCount
          ,le.high_risk_indicator_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount,le.spid_LENGTHS_ErrorCount
          ,le.operator_full_name_LENGTHS_ErrorCount
          ,le.override_file_ALLOW_ErrorCount
          ,le.data_type_ALLOW_ErrorCount
          ,le.ocn_state_ALLOW_ErrorCount
          ,le.overall_ocn_ALLOW_ErrorCount
          ,le.target_ocn_ALLOW_ErrorCount
          ,le.overall_target_ocn_ALLOW_ErrorCount
          ,le.rural_lec_indicator_ALLOW_ErrorCount
          ,le.small_ilec_indicator_ALLOW_ErrorCount
          ,le.category_ALLOW_ErrorCount
          ,le.carrier_city_ALLOW_ErrorCount
          ,le.carrier_state_ALLOW_ErrorCount
          ,le.carrier_zip_ALLOW_ErrorCount
          ,le.carrier_phone_ALLOW_ErrorCount
          ,le.contact_city_ALLOW_ErrorCount
          ,le.contact_state_ALLOW_ErrorCount
          ,le.contact_zip_ALLOW_ErrorCount
          ,le.contact_phone_ALLOW_ErrorCount
          ,le.contact_fax_ALLOW_ErrorCount
          ,le.contact_email_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_reported_CUSTOM_ErrorCount
          ,le.dt_last_reported_CUSTOM_ErrorCount
          ,le.dt_start_CUSTOM_ErrorCount
          ,le.dt_end_CUSTOM_ErrorCount
          ,le.ocn_ALLOW_ErrorCount,le.ocn_LENGTHS_ErrorCount
          ,le.carrier_name_LENGTHS_ErrorCount
          ,le.serv_ALLOW_ErrorCount,le.serv_LENGTHS_ErrorCount
          ,le.line_ALLOW_ErrorCount,le.line_LENGTHS_ErrorCount
          ,le.prepaid_ALLOW_ErrorCount
          ,le.high_risk_indicator_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount,le.spid_LENGTHS_ErrorCount
          ,le.operator_full_name_LENGTHS_ErrorCount
          ,le.override_file_ALLOW_ErrorCount
          ,le.data_type_ALLOW_ErrorCount
          ,le.ocn_state_ALLOW_ErrorCount
          ,le.overall_ocn_ALLOW_ErrorCount
          ,le.target_ocn_ALLOW_ErrorCount
          ,le.overall_target_ocn_ALLOW_ErrorCount
          ,le.rural_lec_indicator_ALLOW_ErrorCount
          ,le.small_ilec_indicator_ALLOW_ErrorCount
          ,le.category_ALLOW_ErrorCount
          ,le.carrier_city_ALLOW_ErrorCount
          ,le.carrier_state_ALLOW_ErrorCount
          ,le.carrier_zip_ALLOW_ErrorCount
          ,le.carrier_phone_ALLOW_ErrorCount
          ,le.contact_city_ALLOW_ErrorCount
          ,le.contact_state_ALLOW_ErrorCount
          ,le.contact_zip_ALLOW_ErrorCount
          ,le.contact_phone_ALLOW_ErrorCount
          ,le.contact_fax_ALLOW_ErrorCount
          ,le.contact_email_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := CarrierReferenceMain_hygiene(PROJECT(h, CarrierReferenceMain_Layout_PhonesInfo));
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
          ,'dt_first_reported:' + getFieldTypeText(h.dt_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_reported:' + getFieldTypeText(h.dt_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_start:' + getFieldTypeText(h.dt_start) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_end:' + getFieldTypeText(h.dt_end) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn:' + getFieldTypeText(h.ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_name:' + getFieldTypeText(h.carrier_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'serv:' + getFieldTypeText(h.serv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'line:' + getFieldTypeText(h.line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prepaid:' + getFieldTypeText(h.prepaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'high_risk_indicator:' + getFieldTypeText(h.high_risk_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'activation_dt:' + getFieldTypeText(h.activation_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'number_in_service:' + getFieldTypeText(h.number_in_service) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spid:' + getFieldTypeText(h.spid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'operator_full_name:' + getFieldTypeText(h.operator_full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_current:' + getFieldTypeText(h.is_current) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'override_file:' + getFieldTypeText(h.override_file) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'data_type:' + getFieldTypeText(h.data_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn_state:' + getFieldTypeText(h.ocn_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'overall_ocn:' + getFieldTypeText(h.overall_ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'target_ocn:' + getFieldTypeText(h.target_ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'overall_target_ocn:' + getFieldTypeText(h.overall_target_ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn_abbr_name:' + getFieldTypeText(h.ocn_abbr_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rural_lec_indicator:' + getFieldTypeText(h.rural_lec_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'small_ilec_indicator:' + getFieldTypeText(h.small_ilec_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'category:' + getFieldTypeText(h.category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_address1:' + getFieldTypeText(h.carrier_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_address2:' + getFieldTypeText(h.carrier_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_floor:' + getFieldTypeText(h.carrier_floor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_room:' + getFieldTypeText(h.carrier_room) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_city:' + getFieldTypeText(h.carrier_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_state:' + getFieldTypeText(h.carrier_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_zip:' + getFieldTypeText(h.carrier_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_phone:' + getFieldTypeText(h.carrier_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'affiliated_to:' + getFieldTypeText(h.affiliated_to) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'overall_company:' + getFieldTypeText(h.overall_company) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_function:' + getFieldTypeText(h.contact_function) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_name:' + getFieldTypeText(h.contact_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_title:' + getFieldTypeText(h.contact_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_address1:' + getFieldTypeText(h.contact_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_address2:' + getFieldTypeText(h.contact_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_city:' + getFieldTypeText(h.contact_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_state:' + getFieldTypeText(h.contact_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_zip:' + getFieldTypeText(h.contact_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_phone:' + getFieldTypeText(h.contact_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_fax:' + getFieldTypeText(h.contact_fax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_email:' + getFieldTypeText(h.contact_email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_information:' + getFieldTypeText(h.contact_information) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'z5:' + getFieldTypeText(h.z5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_rawaid:' + getFieldTypeText(h.append_rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_type:' + getFieldTypeText(h.address_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'privacy_indicator:' + getFieldTypeText(h.privacy_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_first_reported_cnt
          ,le.populated_dt_last_reported_cnt
          ,le.populated_dt_start_cnt
          ,le.populated_dt_end_cnt
          ,le.populated_ocn_cnt
          ,le.populated_carrier_name_cnt
          ,le.populated_serv_cnt
          ,le.populated_line_cnt
          ,le.populated_prepaid_cnt
          ,le.populated_high_risk_indicator_cnt
          ,le.populated_activation_dt_cnt
          ,le.populated_number_in_service_cnt
          ,le.populated_spid_cnt
          ,le.populated_operator_full_name_cnt
          ,le.populated_is_current_cnt
          ,le.populated_override_file_cnt
          ,le.populated_data_type_cnt
          ,le.populated_ocn_state_cnt
          ,le.populated_overall_ocn_cnt
          ,le.populated_target_ocn_cnt
          ,le.populated_overall_target_ocn_cnt
          ,le.populated_ocn_abbr_name_cnt
          ,le.populated_rural_lec_indicator_cnt
          ,le.populated_small_ilec_indicator_cnt
          ,le.populated_category_cnt
          ,le.populated_carrier_address1_cnt
          ,le.populated_carrier_address2_cnt
          ,le.populated_carrier_floor_cnt
          ,le.populated_carrier_room_cnt
          ,le.populated_carrier_city_cnt
          ,le.populated_carrier_state_cnt
          ,le.populated_carrier_zip_cnt
          ,le.populated_carrier_phone_cnt
          ,le.populated_affiliated_to_cnt
          ,le.populated_overall_company_cnt
          ,le.populated_contact_function_cnt
          ,le.populated_contact_name_cnt
          ,le.populated_contact_title_cnt
          ,le.populated_contact_address1_cnt
          ,le.populated_contact_address2_cnt
          ,le.populated_contact_city_cnt
          ,le.populated_contact_state_cnt
          ,le.populated_contact_zip_cnt
          ,le.populated_contact_phone_cnt
          ,le.populated_contact_fax_cnt
          ,le.populated_contact_email_cnt
          ,le.populated_contact_information_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_z5_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_append_rawaid_cnt
          ,le.populated_address_type_cnt
          ,le.populated_privacy_indicator_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_first_reported_pcnt
          ,le.populated_dt_last_reported_pcnt
          ,le.populated_dt_start_pcnt
          ,le.populated_dt_end_pcnt
          ,le.populated_ocn_pcnt
          ,le.populated_carrier_name_pcnt
          ,le.populated_serv_pcnt
          ,le.populated_line_pcnt
          ,le.populated_prepaid_pcnt
          ,le.populated_high_risk_indicator_pcnt
          ,le.populated_activation_dt_pcnt
          ,le.populated_number_in_service_pcnt
          ,le.populated_spid_pcnt
          ,le.populated_operator_full_name_pcnt
          ,le.populated_is_current_pcnt
          ,le.populated_override_file_pcnt
          ,le.populated_data_type_pcnt
          ,le.populated_ocn_state_pcnt
          ,le.populated_overall_ocn_pcnt
          ,le.populated_target_ocn_pcnt
          ,le.populated_overall_target_ocn_pcnt
          ,le.populated_ocn_abbr_name_pcnt
          ,le.populated_rural_lec_indicator_pcnt
          ,le.populated_small_ilec_indicator_pcnt
          ,le.populated_category_pcnt
          ,le.populated_carrier_address1_pcnt
          ,le.populated_carrier_address2_pcnt
          ,le.populated_carrier_floor_pcnt
          ,le.populated_carrier_room_pcnt
          ,le.populated_carrier_city_pcnt
          ,le.populated_carrier_state_pcnt
          ,le.populated_carrier_zip_pcnt
          ,le.populated_carrier_phone_pcnt
          ,le.populated_affiliated_to_pcnt
          ,le.populated_overall_company_pcnt
          ,le.populated_contact_function_pcnt
          ,le.populated_contact_name_pcnt
          ,le.populated_contact_title_pcnt
          ,le.populated_contact_address1_pcnt
          ,le.populated_contact_address2_pcnt
          ,le.populated_contact_city_pcnt
          ,le.populated_contact_state_pcnt
          ,le.populated_contact_zip_pcnt
          ,le.populated_contact_phone_pcnt
          ,le.populated_contact_fax_pcnt
          ,le.populated_contact_email_pcnt
          ,le.populated_contact_information_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_z5_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_append_rawaid_pcnt
          ,le.populated_address_type_pcnt
          ,le.populated_privacy_indicator_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,77,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := CarrierReferenceMain_Delta(prevDS, PROJECT(h, CarrierReferenceMain_Layout_PhonesInfo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),77,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(CarrierReferenceMain_Layout_PhonesInfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesInfo, CarrierReferenceMain_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
