IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 41;
  EXPORT NumRulesFromFieldType := 41;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 35;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_AddressFeedback)
    UNSIGNED1 address_feedback_id_Invalid;
    UNSIGNED1 login_history_id_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 unique_id_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 orig_street_pre_direction_Invalid;
    UNSIGNED1 orig_street_post_direction_Invalid;
    UNSIGNED1 orig_street_number_Invalid;
    UNSIGNED1 orig_street_name_Invalid;
    UNSIGNED1 orig_street_suffix_Invalid;
    UNSIGNED1 orig_unit_number_Invalid;
    UNSIGNED1 orig_unit_designation_Invalid;
    UNSIGNED1 orig_zip5_Invalid;
    UNSIGNED1 orig_zip4_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 street_pre_direction_Invalid;
    UNSIGNED1 street_post_direction_Invalid;
    UNSIGNED1 street_number_Invalid;
    UNSIGNED1 street_name_Invalid;
    UNSIGNED1 street_suffix_Invalid;
    UNSIGNED1 unit_number_Invalid;
    UNSIGNED1 unit_designation_Invalid;
    UNSIGNED1 zip5_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 alt_phone_Invalid;
    UNSIGNED1 address_contact_type_Invalid;
    UNSIGNED1 feedback_source_Invalid;
    UNSIGNED1 date_time_added_Invalid;
    UNSIGNED1 loginid_Invalid;
    UNSIGNED1 companyid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_AddressFeedback)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_AddressFeedback)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'address_feedback_id:Invalid_No:ALLOW'
          ,'login_history_id:Invalid_No:ALLOW'
          ,'phone_number:Invalid_Phone:ALLOW','phone_number:Invalid_Phone:LENGTHS'
          ,'unique_id:Invalid_No:ALLOW'
          ,'fname:Invalid_AlphaChar:ALLOW'
          ,'lname:Invalid_AlphaChar:ALLOW'
          ,'mname:Invalid_Alpha:ALLOW'
          ,'orig_street_pre_direction:Invalid_Dir:ALLOW'
          ,'orig_street_post_direction:Invalid_Dir:ALLOW'
          ,'orig_street_number:Invalid_No:ALLOW'
          ,'orig_street_name:Invalid_AlphaNum:ALLOW'
          ,'orig_street_suffix:Invalid_Alpha:ALLOW'
          ,'orig_unit_number:Invalid_AlphaNum:ALLOW'
          ,'orig_unit_designation:Invalid_Alpha:ALLOW'
          ,'orig_zip5:Invalid_Zip:ALLOW','orig_zip5:Invalid_Zip:LENGTHS'
          ,'orig_zip4:Invalid_No:ALLOW'
          ,'orig_city:Invalid_AlphaChar:ALLOW'
          ,'orig_state:Invalid_State:ALLOW','orig_state:Invalid_State:LENGTHS'
          ,'street_pre_direction:Invalid_Dir:ALLOW'
          ,'street_post_direction:Invalid_Dir:ALLOW'
          ,'street_number:Invalid_No:ALLOW'
          ,'street_name:Invalid_AlphaNum:ALLOW'
          ,'street_suffix:Invalid_Alpha:ALLOW'
          ,'unit_number:Invalid_AlphaNum:ALLOW'
          ,'unit_designation:Invalid_Alpha:ALLOW'
          ,'zip5:Invalid_Zip:ALLOW','zip5:Invalid_Zip:LENGTHS'
          ,'zip4:Invalid_No:ALLOW'
          ,'city:Invalid_AlphaChar:ALLOW'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTHS'
          ,'alt_phone:Invalid_Phone:ALLOW','alt_phone:Invalid_Phone:LENGTHS'
          ,'address_contact_type:Invalid_No:ALLOW'
          ,'feedback_source:Invalid_No:ALLOW'
          ,'date_time_added:Invalid_Date:CUSTOM'
          ,'loginid:Invalid_No:ALLOW'
          ,'companyid:Invalid_No:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_address_feedback_id(1)
          ,Fields.InvalidMessage_login_history_id(1)
          ,Fields.InvalidMessage_phone_number(1),Fields.InvalidMessage_phone_number(2)
          ,Fields.InvalidMessage_unique_id(1)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_orig_street_pre_direction(1)
          ,Fields.InvalidMessage_orig_street_post_direction(1)
          ,Fields.InvalidMessage_orig_street_number(1)
          ,Fields.InvalidMessage_orig_street_name(1)
          ,Fields.InvalidMessage_orig_street_suffix(1)
          ,Fields.InvalidMessage_orig_unit_number(1)
          ,Fields.InvalidMessage_orig_unit_designation(1)
          ,Fields.InvalidMessage_orig_zip5(1),Fields.InvalidMessage_orig_zip5(2)
          ,Fields.InvalidMessage_orig_zip4(1)
          ,Fields.InvalidMessage_orig_city(1)
          ,Fields.InvalidMessage_orig_state(1),Fields.InvalidMessage_orig_state(2)
          ,Fields.InvalidMessage_street_pre_direction(1)
          ,Fields.InvalidMessage_street_post_direction(1)
          ,Fields.InvalidMessage_street_number(1)
          ,Fields.InvalidMessage_street_name(1)
          ,Fields.InvalidMessage_street_suffix(1)
          ,Fields.InvalidMessage_unit_number(1)
          ,Fields.InvalidMessage_unit_designation(1)
          ,Fields.InvalidMessage_zip5(1),Fields.InvalidMessage_zip5(2)
          ,Fields.InvalidMessage_zip4(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_alt_phone(1),Fields.InvalidMessage_alt_phone(2)
          ,Fields.InvalidMessage_address_contact_type(1)
          ,Fields.InvalidMessage_feedback_source(1)
          ,Fields.InvalidMessage_date_time_added(1)
          ,Fields.InvalidMessage_loginid(1)
          ,Fields.InvalidMessage_companyid(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_AddressFeedback) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.address_feedback_id_Invalid := Fields.InValid_address_feedback_id((SALT311.StrType)le.address_feedback_id);
    SELF.login_history_id_Invalid := Fields.InValid_login_history_id((SALT311.StrType)le.login_history_id);
    SELF.phone_number_Invalid := Fields.InValid_phone_number((SALT311.StrType)le.phone_number);
    SELF.unique_id_Invalid := Fields.InValid_unique_id((SALT311.StrType)le.unique_id);
    SELF.fname_Invalid := Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.orig_street_pre_direction_Invalid := Fields.InValid_orig_street_pre_direction((SALT311.StrType)le.orig_street_pre_direction);
    SELF.orig_street_post_direction_Invalid := Fields.InValid_orig_street_post_direction((SALT311.StrType)le.orig_street_post_direction);
    SELF.orig_street_number_Invalid := Fields.InValid_orig_street_number((SALT311.StrType)le.orig_street_number);
    SELF.orig_street_name_Invalid := Fields.InValid_orig_street_name((SALT311.StrType)le.orig_street_name);
    SELF.orig_street_suffix_Invalid := Fields.InValid_orig_street_suffix((SALT311.StrType)le.orig_street_suffix);
    SELF.orig_unit_number_Invalid := Fields.InValid_orig_unit_number((SALT311.StrType)le.orig_unit_number);
    SELF.orig_unit_designation_Invalid := Fields.InValid_orig_unit_designation((SALT311.StrType)le.orig_unit_designation);
    SELF.orig_zip5_Invalid := Fields.InValid_orig_zip5((SALT311.StrType)le.orig_zip5);
    SELF.orig_zip4_Invalid := Fields.InValid_orig_zip4((SALT311.StrType)le.orig_zip4);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT311.StrType)le.orig_city);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT311.StrType)le.orig_state);
    SELF.street_pre_direction_Invalid := Fields.InValid_street_pre_direction((SALT311.StrType)le.street_pre_direction);
    SELF.street_post_direction_Invalid := Fields.InValid_street_post_direction((SALT311.StrType)le.street_post_direction);
    SELF.street_number_Invalid := Fields.InValid_street_number((SALT311.StrType)le.street_number);
    SELF.street_name_Invalid := Fields.InValid_street_name((SALT311.StrType)le.street_name);
    SELF.street_suffix_Invalid := Fields.InValid_street_suffix((SALT311.StrType)le.street_suffix);
    SELF.unit_number_Invalid := Fields.InValid_unit_number((SALT311.StrType)le.unit_number);
    SELF.unit_designation_Invalid := Fields.InValid_unit_designation((SALT311.StrType)le.unit_designation);
    SELF.zip5_Invalid := Fields.InValid_zip5((SALT311.StrType)le.zip5);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.alt_phone_Invalid := Fields.InValid_alt_phone((SALT311.StrType)le.alt_phone);
    SELF.address_contact_type_Invalid := Fields.InValid_address_contact_type((SALT311.StrType)le.address_contact_type);
    SELF.feedback_source_Invalid := Fields.InValid_feedback_source((SALT311.StrType)le.feedback_source);
    SELF.date_time_added_Invalid := Fields.InValid_date_time_added((SALT311.StrType)le.date_time_added);
    SELF.loginid_Invalid := Fields.InValid_loginid((SALT311.StrType)le.loginid);
    SELF.companyid_Invalid := Fields.InValid_companyid((SALT311.StrType)le.companyid);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_AddressFeedback);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.address_feedback_id_Invalid << 0 ) + ( le.login_history_id_Invalid << 1 ) + ( le.phone_number_Invalid << 2 ) + ( le.unique_id_Invalid << 4 ) + ( le.fname_Invalid << 5 ) + ( le.lname_Invalid << 6 ) + ( le.mname_Invalid << 7 ) + ( le.orig_street_pre_direction_Invalid << 8 ) + ( le.orig_street_post_direction_Invalid << 9 ) + ( le.orig_street_number_Invalid << 10 ) + ( le.orig_street_name_Invalid << 11 ) + ( le.orig_street_suffix_Invalid << 12 ) + ( le.orig_unit_number_Invalid << 13 ) + ( le.orig_unit_designation_Invalid << 14 ) + ( le.orig_zip5_Invalid << 15 ) + ( le.orig_zip4_Invalid << 17 ) + ( le.orig_city_Invalid << 18 ) + ( le.orig_state_Invalid << 19 ) + ( le.street_pre_direction_Invalid << 21 ) + ( le.street_post_direction_Invalid << 22 ) + ( le.street_number_Invalid << 23 ) + ( le.street_name_Invalid << 24 ) + ( le.street_suffix_Invalid << 25 ) + ( le.unit_number_Invalid << 26 ) + ( le.unit_designation_Invalid << 27 ) + ( le.zip5_Invalid << 28 ) + ( le.zip4_Invalid << 30 ) + ( le.city_Invalid << 31 ) + ( le.state_Invalid << 32 ) + ( le.alt_phone_Invalid << 34 ) + ( le.address_contact_type_Invalid << 36 ) + ( le.feedback_source_Invalid << 37 ) + ( le.date_time_added_Invalid << 38 ) + ( le.loginid_Invalid << 39 ) + ( le.companyid_Invalid << 40 );
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
  EXPORT Infile := PROJECT(h,Layout_AddressFeedback);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.address_feedback_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.login_history_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.unique_id_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.orig_street_pre_direction_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_street_post_direction_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orig_street_number_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_street_name_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_street_suffix_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.orig_unit_number_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.orig_unit_designation_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orig_zip5_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.orig_zip4_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.street_pre_direction_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.street_post_direction_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.street_number_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.street_name_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.street_suffix_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.unit_number_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.unit_designation_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.alt_phone_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.address_contact_type_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.feedback_source_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.date_time_added_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.loginid_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.companyid_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    address_feedback_id_ALLOW_ErrorCount := COUNT(GROUP,h.address_feedback_id_Invalid=1);
    login_history_id_ALLOW_ErrorCount := COUNT(GROUP,h.login_history_id_Invalid=1);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    phone_number_LENGTHS_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=2);
    phone_number_Total_ErrorCount := COUNT(GROUP,h.phone_number_Invalid>0);
    unique_id_ALLOW_ErrorCount := COUNT(GROUP,h.unique_id_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    orig_street_pre_direction_ALLOW_ErrorCount := COUNT(GROUP,h.orig_street_pre_direction_Invalid=1);
    orig_street_post_direction_ALLOW_ErrorCount := COUNT(GROUP,h.orig_street_post_direction_Invalid=1);
    orig_street_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_street_number_Invalid=1);
    orig_street_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_street_name_Invalid=1);
    orig_street_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_street_suffix_Invalid=1);
    orig_unit_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_unit_number_Invalid=1);
    orig_unit_designation_ALLOW_ErrorCount := COUNT(GROUP,h.orig_unit_designation_Invalid=1);
    orig_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=1);
    orig_zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=2);
    orig_zip5_Total_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid>0);
    orig_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=1);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_state_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=2);
    orig_state_Total_ErrorCount := COUNT(GROUP,h.orig_state_Invalid>0);
    street_pre_direction_ALLOW_ErrorCount := COUNT(GROUP,h.street_pre_direction_Invalid=1);
    street_post_direction_ALLOW_ErrorCount := COUNT(GROUP,h.street_post_direction_Invalid=1);
    street_number_ALLOW_ErrorCount := COUNT(GROUP,h.street_number_Invalid=1);
    street_name_ALLOW_ErrorCount := COUNT(GROUP,h.street_name_Invalid=1);
    street_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.street_suffix_Invalid=1);
    unit_number_ALLOW_ErrorCount := COUNT(GROUP,h.unit_number_Invalid=1);
    unit_designation_ALLOW_ErrorCount := COUNT(GROUP,h.unit_designation_Invalid=1);
    zip5_ALLOW_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.zip5_Invalid=2);
    zip5_Total_ErrorCount := COUNT(GROUP,h.zip5_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    alt_phone_ALLOW_ErrorCount := COUNT(GROUP,h.alt_phone_Invalid=1);
    alt_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.alt_phone_Invalid=2);
    alt_phone_Total_ErrorCount := COUNT(GROUP,h.alt_phone_Invalid>0);
    address_contact_type_ALLOW_ErrorCount := COUNT(GROUP,h.address_contact_type_Invalid=1);
    feedback_source_ALLOW_ErrorCount := COUNT(GROUP,h.feedback_source_Invalid=1);
    date_time_added_CUSTOM_ErrorCount := COUNT(GROUP,h.date_time_added_Invalid=1);
    loginid_ALLOW_ErrorCount := COUNT(GROUP,h.loginid_Invalid=1);
    companyid_ALLOW_ErrorCount := COUNT(GROUP,h.companyid_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.address_feedback_id_Invalid > 0 OR h.login_history_id_Invalid > 0 OR h.phone_number_Invalid > 0 OR h.unique_id_Invalid > 0 OR h.fname_Invalid > 0 OR h.lname_Invalid > 0 OR h.mname_Invalid > 0 OR h.orig_street_pre_direction_Invalid > 0 OR h.orig_street_post_direction_Invalid > 0 OR h.orig_street_number_Invalid > 0 OR h.orig_street_name_Invalid > 0 OR h.orig_street_suffix_Invalid > 0 OR h.orig_unit_number_Invalid > 0 OR h.orig_unit_designation_Invalid > 0 OR h.orig_zip5_Invalid > 0 OR h.orig_zip4_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.street_pre_direction_Invalid > 0 OR h.street_post_direction_Invalid > 0 OR h.street_number_Invalid > 0 OR h.street_name_Invalid > 0 OR h.street_suffix_Invalid > 0 OR h.unit_number_Invalid > 0 OR h.unit_designation_Invalid > 0 OR h.zip5_Invalid > 0 OR h.zip4_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.alt_phone_Invalid > 0 OR h.address_contact_type_Invalid > 0 OR h.feedback_source_Invalid > 0 OR h.date_time_added_Invalid > 0 OR h.loginid_Invalid > 0 OR h.companyid_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.address_feedback_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.login_history_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_Total_ErrorCount > 0, 1, 0) + IF(le.unique_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_pre_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_post_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_unit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_unit_designation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_state_Total_ErrorCount > 0, 1, 0) + IF(le.street_pre_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_post_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_designation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip5_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.alt_phone_Total_ErrorCount > 0, 1, 0) + IF(le.address_contact_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.feedback_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_time_added_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.loginid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.companyid_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.address_feedback_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.login_history_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.unique_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_pre_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_post_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_street_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_unit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_unit_designation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.street_pre_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_post_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_designation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.alt_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.alt_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.address_contact_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.feedback_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_time_added_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.loginid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.companyid_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.address_feedback_id_Invalid,le.login_history_id_Invalid,le.phone_number_Invalid,le.unique_id_Invalid,le.fname_Invalid,le.lname_Invalid,le.mname_Invalid,le.orig_street_pre_direction_Invalid,le.orig_street_post_direction_Invalid,le.orig_street_number_Invalid,le.orig_street_name_Invalid,le.orig_street_suffix_Invalid,le.orig_unit_number_Invalid,le.orig_unit_designation_Invalid,le.orig_zip5_Invalid,le.orig_zip4_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.street_pre_direction_Invalid,le.street_post_direction_Invalid,le.street_number_Invalid,le.street_name_Invalid,le.street_suffix_Invalid,le.unit_number_Invalid,le.unit_designation_Invalid,le.zip5_Invalid,le.zip4_Invalid,le.city_Invalid,le.state_Invalid,le.alt_phone_Invalid,le.address_contact_type_Invalid,le.feedback_source_Invalid,le.date_time_added_Invalid,le.loginid_Invalid,le.companyid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_address_feedback_id(le.address_feedback_id_Invalid),Fields.InvalidMessage_login_history_id(le.login_history_id_Invalid),Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Fields.InvalidMessage_unique_id(le.unique_id_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_orig_street_pre_direction(le.orig_street_pre_direction_Invalid),Fields.InvalidMessage_orig_street_post_direction(le.orig_street_post_direction_Invalid),Fields.InvalidMessage_orig_street_number(le.orig_street_number_Invalid),Fields.InvalidMessage_orig_street_name(le.orig_street_name_Invalid),Fields.InvalidMessage_orig_street_suffix(le.orig_street_suffix_Invalid),Fields.InvalidMessage_orig_unit_number(le.orig_unit_number_Invalid),Fields.InvalidMessage_orig_unit_designation(le.orig_unit_designation_Invalid),Fields.InvalidMessage_orig_zip5(le.orig_zip5_Invalid),Fields.InvalidMessage_orig_zip4(le.orig_zip4_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_street_pre_direction(le.street_pre_direction_Invalid),Fields.InvalidMessage_street_post_direction(le.street_post_direction_Invalid),Fields.InvalidMessage_street_number(le.street_number_Invalid),Fields.InvalidMessage_street_name(le.street_name_Invalid),Fields.InvalidMessage_street_suffix(le.street_suffix_Invalid),Fields.InvalidMessage_unit_number(le.unit_number_Invalid),Fields.InvalidMessage_unit_designation(le.unit_designation_Invalid),Fields.InvalidMessage_zip5(le.zip5_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_alt_phone(le.alt_phone_Invalid),Fields.InvalidMessage_address_contact_type(le.address_contact_type_Invalid),Fields.InvalidMessage_feedback_source(le.feedback_source_Invalid),Fields.InvalidMessage_date_time_added(le.date_time_added_Invalid),Fields.InvalidMessage_loginid(le.loginid_Invalid),Fields.InvalidMessage_companyid(le.companyid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.address_feedback_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.login_history_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.unique_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_street_pre_direction_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_street_post_direction_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_street_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_street_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_street_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_unit_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_unit_designation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.orig_zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.street_pre_direction_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_post_direction_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_designation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.alt_phone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.address_contact_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.feedback_source_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_time_added_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.loginid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.companyid_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'address_feedback_id','login_history_id','phone_number','unique_id','fname','lname','mname','orig_street_pre_direction','orig_street_post_direction','orig_street_number','orig_street_name','orig_street_suffix','orig_unit_number','orig_unit_designation','orig_zip5','orig_zip4','orig_city','orig_state','street_pre_direction','street_post_direction','street_number','street_name','street_suffix','unit_number','unit_designation','zip5','zip4','city','state','alt_phone','address_contact_type','feedback_source','date_time_added','loginid','companyid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_No','Invalid_Phone','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_Dir','Invalid_Dir','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaChar','Invalid_State','Invalid_Dir','Invalid_Dir','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaChar','Invalid_State','Invalid_Phone','Invalid_No','Invalid_No','Invalid_Date','Invalid_No','Invalid_No','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.address_feedback_id,(SALT311.StrType)le.login_history_id,(SALT311.StrType)le.phone_number,(SALT311.StrType)le.unique_id,(SALT311.StrType)le.fname,(SALT311.StrType)le.lname,(SALT311.StrType)le.mname,(SALT311.StrType)le.orig_street_pre_direction,(SALT311.StrType)le.orig_street_post_direction,(SALT311.StrType)le.orig_street_number,(SALT311.StrType)le.orig_street_name,(SALT311.StrType)le.orig_street_suffix,(SALT311.StrType)le.orig_unit_number,(SALT311.StrType)le.orig_unit_designation,(SALT311.StrType)le.orig_zip5,(SALT311.StrType)le.orig_zip4,(SALT311.StrType)le.orig_city,(SALT311.StrType)le.orig_state,(SALT311.StrType)le.street_pre_direction,(SALT311.StrType)le.street_post_direction,(SALT311.StrType)le.street_number,(SALT311.StrType)le.street_name,(SALT311.StrType)le.street_suffix,(SALT311.StrType)le.unit_number,(SALT311.StrType)le.unit_designation,(SALT311.StrType)le.zip5,(SALT311.StrType)le.zip4,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.alt_phone,(SALT311.StrType)le.address_contact_type,(SALT311.StrType)le.feedback_source,(SALT311.StrType)le.date_time_added,(SALT311.StrType)le.loginid,(SALT311.StrType)le.companyid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,35,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_AddressFeedback) prevDS = DATASET([], Layout_AddressFeedback), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.address_feedback_id_ALLOW_ErrorCount
          ,le.login_history_id_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTHS_ErrorCount
          ,le.unique_id_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.orig_street_pre_direction_ALLOW_ErrorCount
          ,le.orig_street_post_direction_ALLOW_ErrorCount
          ,le.orig_street_number_ALLOW_ErrorCount
          ,le.orig_street_name_ALLOW_ErrorCount
          ,le.orig_street_suffix_ALLOW_ErrorCount
          ,le.orig_unit_number_ALLOW_ErrorCount
          ,le.orig_unit_designation_ALLOW_ErrorCount
          ,le.orig_zip5_ALLOW_ErrorCount,le.orig_zip5_LENGTHS_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTHS_ErrorCount
          ,le.street_pre_direction_ALLOW_ErrorCount
          ,le.street_post_direction_ALLOW_ErrorCount
          ,le.street_number_ALLOW_ErrorCount
          ,le.street_name_ALLOW_ErrorCount
          ,le.street_suffix_ALLOW_ErrorCount
          ,le.unit_number_ALLOW_ErrorCount
          ,le.unit_designation_ALLOW_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.alt_phone_ALLOW_ErrorCount,le.alt_phone_LENGTHS_ErrorCount
          ,le.address_contact_type_ALLOW_ErrorCount
          ,le.feedback_source_ALLOW_ErrorCount
          ,le.date_time_added_CUSTOM_ErrorCount
          ,le.loginid_ALLOW_ErrorCount
          ,le.companyid_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.address_feedback_id_ALLOW_ErrorCount
          ,le.login_history_id_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount,le.phone_number_LENGTHS_ErrorCount
          ,le.unique_id_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.orig_street_pre_direction_ALLOW_ErrorCount
          ,le.orig_street_post_direction_ALLOW_ErrorCount
          ,le.orig_street_number_ALLOW_ErrorCount
          ,le.orig_street_name_ALLOW_ErrorCount
          ,le.orig_street_suffix_ALLOW_ErrorCount
          ,le.orig_unit_number_ALLOW_ErrorCount
          ,le.orig_unit_designation_ALLOW_ErrorCount
          ,le.orig_zip5_ALLOW_ErrorCount,le.orig_zip5_LENGTHS_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTHS_ErrorCount
          ,le.street_pre_direction_ALLOW_ErrorCount
          ,le.street_post_direction_ALLOW_ErrorCount
          ,le.street_number_ALLOW_ErrorCount
          ,le.street_name_ALLOW_ErrorCount
          ,le.street_suffix_ALLOW_ErrorCount
          ,le.unit_number_ALLOW_ErrorCount
          ,le.unit_designation_ALLOW_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.alt_phone_ALLOW_ErrorCount,le.alt_phone_LENGTHS_ErrorCount
          ,le.address_contact_type_ALLOW_ErrorCount
          ,le.feedback_source_ALLOW_ErrorCount
          ,le.date_time_added_CUSTOM_ErrorCount
          ,le.loginid_ALLOW_ErrorCount
          ,le.companyid_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_AddressFeedback));
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
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_aid:' + getFieldTypeText(h.raw_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hhid:' + getFieldTypeText(h.hhid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_feedback_id:' + getFieldTypeText(h.address_feedback_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'login_history_id:' + getFieldTypeText(h.login_history_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number:' + getFieldTypeText(h.phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unique_id:' + getFieldTypeText(h.unique_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_street_pre_direction:' + getFieldTypeText(h.orig_street_pre_direction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_street_post_direction:' + getFieldTypeText(h.orig_street_post_direction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_street_number:' + getFieldTypeText(h.orig_street_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_street_name:' + getFieldTypeText(h.orig_street_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_street_suffix:' + getFieldTypeText(h.orig_street_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_unit_number:' + getFieldTypeText(h.orig_unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_unit_designation:' + getFieldTypeText(h.orig_unit_designation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip5:' + getFieldTypeText(h.orig_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip4:' + getFieldTypeText(h.orig_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_pre_direction:' + getFieldTypeText(h.street_pre_direction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_post_direction:' + getFieldTypeText(h.street_post_direction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_number:' + getFieldTypeText(h.street_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_name:' + getFieldTypeText(h.street_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_suffix:' + getFieldTypeText(h.street_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_number:' + getFieldTypeText(h.unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_designation:' + getFieldTypeText(h.unit_designation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip5:' + getFieldTypeText(h.zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'alt_phone:' + getFieldTypeText(h.alt_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_info:' + getFieldTypeText(h.other_info) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_contact_type:' + getFieldTypeText(h.address_contact_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'feedback_source:' + getFieldTypeText(h.feedback_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_time_added:' + getFieldTypeText(h.date_time_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loginid:' + getFieldTypeText(h.loginid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'companyid:' + getFieldTypeText(h.companyid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_raw_aid_cnt
          ,le.populated_hhid_cnt
          ,le.populated_address_feedback_id_cnt
          ,le.populated_login_history_id_cnt
          ,le.populated_phone_number_cnt
          ,le.populated_unique_id_cnt
          ,le.populated_fname_cnt
          ,le.populated_lname_cnt
          ,le.populated_mname_cnt
          ,le.populated_orig_street_pre_direction_cnt
          ,le.populated_orig_street_post_direction_cnt
          ,le.populated_orig_street_number_cnt
          ,le.populated_orig_street_name_cnt
          ,le.populated_orig_street_suffix_cnt
          ,le.populated_orig_unit_number_cnt
          ,le.populated_orig_unit_designation_cnt
          ,le.populated_orig_zip5_cnt
          ,le.populated_orig_zip4_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_street_pre_direction_cnt
          ,le.populated_street_post_direction_cnt
          ,le.populated_street_number_cnt
          ,le.populated_street_name_cnt
          ,le.populated_street_suffix_cnt
          ,le.populated_unit_number_cnt
          ,le.populated_unit_designation_cnt
          ,le.populated_zip5_cnt
          ,le.populated_zip4_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_alt_phone_cnt
          ,le.populated_other_info_cnt
          ,le.populated_address_contact_type_cnt
          ,le.populated_feedback_source_cnt
          ,le.populated_date_time_added_cnt
          ,le.populated_loginid_cnt
          ,le.populated_companyid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_raw_aid_pcnt
          ,le.populated_hhid_pcnt
          ,le.populated_address_feedback_id_pcnt
          ,le.populated_login_history_id_pcnt
          ,le.populated_phone_number_pcnt
          ,le.populated_unique_id_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_orig_street_pre_direction_pcnt
          ,le.populated_orig_street_post_direction_pcnt
          ,le.populated_orig_street_number_pcnt
          ,le.populated_orig_street_name_pcnt
          ,le.populated_orig_street_suffix_pcnt
          ,le.populated_orig_unit_number_pcnt
          ,le.populated_orig_unit_designation_pcnt
          ,le.populated_orig_zip5_pcnt
          ,le.populated_orig_zip4_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_street_pre_direction_pcnt
          ,le.populated_street_post_direction_pcnt
          ,le.populated_street_number_pcnt
          ,le.populated_street_name_pcnt
          ,le.populated_street_suffix_pcnt
          ,le.populated_unit_number_pcnt
          ,le.populated_unit_designation_pcnt
          ,le.populated_zip5_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_alt_phone_pcnt
          ,le.populated_other_info_pcnt
          ,le.populated_address_contact_type_pcnt
          ,le.populated_feedback_source_pcnt
          ,le.populated_date_time_added_pcnt
          ,le.populated_loginid_pcnt
          ,le.populated_companyid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,40,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_AddressFeedback));
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
 
EXPORT StandardStats(DATASET(Layout_AddressFeedback) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_AddressFeedback, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
