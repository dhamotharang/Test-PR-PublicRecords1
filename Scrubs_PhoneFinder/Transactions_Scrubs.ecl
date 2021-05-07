IMPORT SALT311,STD;
IMPORT Scrubs_PhoneFinder; // Import modules for FieldTypes attribute definitions
EXPORT Transactions_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 39;
  EXPORT NumRulesFromFieldType := 39;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 36;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Transactions_Layout_PhoneFinder)
    UNSIGNED1 transaction_id_Invalid;
    UNSIGNED1 transaction_date_Invalid;
    UNSIGNED1 product_code_Invalid;
    UNSIGNED1 company_id_Invalid;
    UNSIGNED1 source_code_Invalid;
    UNSIGNED1 batch_job_id_Invalid;
    UNSIGNED1 batch_acctno_Invalid;
    UNSIGNED1 response_time_Invalid;
    UNSIGNED1 reference_code_Invalid;
    UNSIGNED1 phonefinder_type_Invalid;
    UNSIGNED1 submitted_lexid_Invalid;
    UNSIGNED1 submitted_phonenumber_Invalid;
    UNSIGNED1 submitted_firstname_Invalid;
    UNSIGNED1 submitted_lastname_Invalid;
    UNSIGNED1 submitted_middlename_Invalid;
    UNSIGNED1 submitted_city_Invalid;
    UNSIGNED1 submitted_state_Invalid;
    UNSIGNED1 submitted_zip_Invalid;
    UNSIGNED1 phonenumber_Invalid;
    UNSIGNED1 data_source_Invalid;
    UNSIGNED1 royalty_used_Invalid;
    UNSIGNED1 carrier_Invalid;
    UNSIGNED1 risk_indicator_Invalid;
    UNSIGNED1 phone_type_Invalid;
    UNSIGNED1 phone_status_Invalid;
    UNSIGNED1 ported_count_Invalid;
    UNSIGNED1 last_ported_date_Invalid;
    UNSIGNED1 otp_count_Invalid;
    UNSIGNED1 last_otp_date_Invalid;
    UNSIGNED1 spoof_count_Invalid;
    UNSIGNED1 last_spoof_date_Invalid;
    UNSIGNED1 phone_forwarded_Invalid;
    UNSIGNED1 identity_count_Invalid;
    UNSIGNED1 phone_verified_Invalid;
    UNSIGNED1 verification_type_Invalid;
    UNSIGNED1 phone_star_rating_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Transactions_Layout_PhoneFinder)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Transactions_Layout_PhoneFinder)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'transaction_id:Invalid_ID:ALLOW'
          ,'transaction_date:Invalid_Date:CUSTOM'
          ,'product_code:Invalid_Alpha:ALLOW'
          ,'company_id:Invalid_No:ALLOW'
          ,'source_code:Invalid_Code:ALLOW'
          ,'batch_job_id:Invalid_Code:ALLOW'
          ,'batch_acctno:Invalid_No:ALLOW'
          ,'response_time:Invalid_No:ALLOW'
          ,'reference_code:Invalid_AlphaChar:ALLOW'
          ,'phonefinder_type:Invalid_Alpha:ALLOW'
          ,'submitted_lexid:Invalid_Code:ALLOW'
          ,'submitted_phonenumber:Invalid_Code:ALLOW'
          ,'submitted_firstname:Invalid_AlphaChar:ALLOW'
          ,'submitted_lastname:Invalid_AlphaChar:ALLOW'
          ,'submitted_middlename:Invalid_AlphaChar:ALLOW'
          ,'submitted_city:Invalid_AlphaChar:ALLOW'
          ,'submitted_state:Invalid_State:ALLOW','submitted_state:Invalid_State:LENGTHS'
          ,'submitted_zip:Invalid_Zip:ALLOW','submitted_zip:Invalid_Zip:LENGTHS'
          ,'phonenumber:Invalid_Phone:ALLOW','phonenumber:Invalid_Phone:LENGTHS'
          ,'data_source:Invalid_Binary:ALLOW'
          ,'royalty_used:Invalid_Alpha:ALLOW'
          ,'carrier:Invalid_AlphaChar:ALLOW'
          ,'risk_indicator:Invalid_Risk:ENUM'
          ,'phone_type:Invalid_Phone_Type:ENUM'
          ,'phone_status:Invalid_Phone_Status:ENUM'
          ,'ported_count:Invalid_No:ALLOW'
          ,'last_ported_date:Invalid_Date:CUSTOM'
          ,'otp_count:Invalid_No:ALLOW'
          ,'last_otp_date:Invalid_Date:CUSTOM'
          ,'spoof_count:Invalid_No:ALLOW'
          ,'last_spoof_date:Invalid_Date:CUSTOM'
          ,'phone_forwarded:Invalid_Forward:ENUM'
          ,'identity_count:Invalid_No:ALLOW'
          ,'phone_verified:Invalid_Code:ALLOW'
          ,'verification_type:Invalid_AlphaChar:ALLOW'
          ,'phone_star_rating:Invalid_Rating:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Transactions_Fields.InvalidMessage_transaction_id(1)
          ,Transactions_Fields.InvalidMessage_transaction_date(1)
          ,Transactions_Fields.InvalidMessage_product_code(1)
          ,Transactions_Fields.InvalidMessage_company_id(1)
          ,Transactions_Fields.InvalidMessage_source_code(1)
          ,Transactions_Fields.InvalidMessage_batch_job_id(1)
          ,Transactions_Fields.InvalidMessage_batch_acctno(1)
          ,Transactions_Fields.InvalidMessage_response_time(1)
          ,Transactions_Fields.InvalidMessage_reference_code(1)
          ,Transactions_Fields.InvalidMessage_phonefinder_type(1)
          ,Transactions_Fields.InvalidMessage_submitted_lexid(1)
          ,Transactions_Fields.InvalidMessage_submitted_phonenumber(1)
          ,Transactions_Fields.InvalidMessage_submitted_firstname(1)
          ,Transactions_Fields.InvalidMessage_submitted_lastname(1)
          ,Transactions_Fields.InvalidMessage_submitted_middlename(1)
          ,Transactions_Fields.InvalidMessage_submitted_city(1)
          ,Transactions_Fields.InvalidMessage_submitted_state(1),Transactions_Fields.InvalidMessage_submitted_state(2)
          ,Transactions_Fields.InvalidMessage_submitted_zip(1),Transactions_Fields.InvalidMessage_submitted_zip(2)
          ,Transactions_Fields.InvalidMessage_phonenumber(1),Transactions_Fields.InvalidMessage_phonenumber(2)
          ,Transactions_Fields.InvalidMessage_data_source(1)
          ,Transactions_Fields.InvalidMessage_royalty_used(1)
          ,Transactions_Fields.InvalidMessage_carrier(1)
          ,Transactions_Fields.InvalidMessage_risk_indicator(1)
          ,Transactions_Fields.InvalidMessage_phone_type(1)
          ,Transactions_Fields.InvalidMessage_phone_status(1)
          ,Transactions_Fields.InvalidMessage_ported_count(1)
          ,Transactions_Fields.InvalidMessage_last_ported_date(1)
          ,Transactions_Fields.InvalidMessage_otp_count(1)
          ,Transactions_Fields.InvalidMessage_last_otp_date(1)
          ,Transactions_Fields.InvalidMessage_spoof_count(1)
          ,Transactions_Fields.InvalidMessage_last_spoof_date(1)
          ,Transactions_Fields.InvalidMessage_phone_forwarded(1)
          ,Transactions_Fields.InvalidMessage_identity_count(1)
          ,Transactions_Fields.InvalidMessage_phone_verified(1)
          ,Transactions_Fields.InvalidMessage_verification_type(1)
          ,Transactions_Fields.InvalidMessage_phone_star_rating(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Transactions_Layout_PhoneFinder) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.transaction_id_Invalid := Transactions_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id);
    SELF.transaction_date_Invalid := Transactions_Fields.InValid_transaction_date((SALT311.StrType)le.transaction_date);
    SELF.product_code_Invalid := Transactions_Fields.InValid_product_code((SALT311.StrType)le.product_code);
    SELF.company_id_Invalid := Transactions_Fields.InValid_company_id((SALT311.StrType)le.company_id);
    SELF.source_code_Invalid := Transactions_Fields.InValid_source_code((SALT311.StrType)le.source_code);
    SELF.batch_job_id_Invalid := Transactions_Fields.InValid_batch_job_id((SALT311.StrType)le.batch_job_id);
    SELF.batch_acctno_Invalid := Transactions_Fields.InValid_batch_acctno((SALT311.StrType)le.batch_acctno);
    SELF.response_time_Invalid := Transactions_Fields.InValid_response_time((SALT311.StrType)le.response_time);
    SELF.reference_code_Invalid := Transactions_Fields.InValid_reference_code((SALT311.StrType)le.reference_code);
    SELF.phonefinder_type_Invalid := Transactions_Fields.InValid_phonefinder_type((SALT311.StrType)le.phonefinder_type);
    SELF.submitted_lexid_Invalid := Transactions_Fields.InValid_submitted_lexid((SALT311.StrType)le.submitted_lexid);
    SELF.submitted_phonenumber_Invalid := Transactions_Fields.InValid_submitted_phonenumber((SALT311.StrType)le.submitted_phonenumber);
    SELF.submitted_firstname_Invalid := Transactions_Fields.InValid_submitted_firstname((SALT311.StrType)le.submitted_firstname);
    SELF.submitted_lastname_Invalid := Transactions_Fields.InValid_submitted_lastname((SALT311.StrType)le.submitted_lastname);
    SELF.submitted_middlename_Invalid := Transactions_Fields.InValid_submitted_middlename((SALT311.StrType)le.submitted_middlename);
    SELF.submitted_city_Invalid := Transactions_Fields.InValid_submitted_city((SALT311.StrType)le.submitted_city);
    SELF.submitted_state_Invalid := Transactions_Fields.InValid_submitted_state((SALT311.StrType)le.submitted_state);
    SELF.submitted_zip_Invalid := Transactions_Fields.InValid_submitted_zip((SALT311.StrType)le.submitted_zip);
    SELF.phonenumber_Invalid := Transactions_Fields.InValid_phonenumber((SALT311.StrType)le.phonenumber);
    SELF.data_source_Invalid := Transactions_Fields.InValid_data_source((SALT311.StrType)le.data_source);
    SELF.royalty_used_Invalid := Transactions_Fields.InValid_royalty_used((SALT311.StrType)le.royalty_used);
    SELF.carrier_Invalid := Transactions_Fields.InValid_carrier((SALT311.StrType)le.carrier);
    SELF.risk_indicator_Invalid := Transactions_Fields.InValid_risk_indicator((SALT311.StrType)le.risk_indicator);
    SELF.phone_type_Invalid := Transactions_Fields.InValid_phone_type((SALT311.StrType)le.phone_type);
    SELF.phone_status_Invalid := Transactions_Fields.InValid_phone_status((SALT311.StrType)le.phone_status);
    SELF.ported_count_Invalid := Transactions_Fields.InValid_ported_count((SALT311.StrType)le.ported_count);
    SELF.last_ported_date_Invalid := Transactions_Fields.InValid_last_ported_date((SALT311.StrType)le.last_ported_date);
    SELF.otp_count_Invalid := Transactions_Fields.InValid_otp_count((SALT311.StrType)le.otp_count);
    SELF.last_otp_date_Invalid := Transactions_Fields.InValid_last_otp_date((SALT311.StrType)le.last_otp_date);
    SELF.spoof_count_Invalid := Transactions_Fields.InValid_spoof_count((SALT311.StrType)le.spoof_count);
    SELF.last_spoof_date_Invalid := Transactions_Fields.InValid_last_spoof_date((SALT311.StrType)le.last_spoof_date);
    SELF.phone_forwarded_Invalid := Transactions_Fields.InValid_phone_forwarded((SALT311.StrType)le.phone_forwarded);
    SELF.identity_count_Invalid := Transactions_Fields.InValid_identity_count((SALT311.StrType)le.identity_count);
    SELF.phone_verified_Invalid := Transactions_Fields.InValid_phone_verified((SALT311.StrType)le.phone_verified);
    SELF.verification_type_Invalid := Transactions_Fields.InValid_verification_type((SALT311.StrType)le.verification_type);
    SELF.phone_star_rating_Invalid := Transactions_Fields.InValid_phone_star_rating((SALT311.StrType)le.phone_star_rating);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Transactions_Layout_PhoneFinder);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.transaction_id_Invalid << 0 ) + ( le.transaction_date_Invalid << 1 ) + ( le.product_code_Invalid << 2 ) + ( le.company_id_Invalid << 3 ) + ( le.source_code_Invalid << 4 ) + ( le.batch_job_id_Invalid << 5 ) + ( le.batch_acctno_Invalid << 6 ) + ( le.response_time_Invalid << 7 ) + ( le.reference_code_Invalid << 8 ) + ( le.phonefinder_type_Invalid << 9 ) + ( le.submitted_lexid_Invalid << 10 ) + ( le.submitted_phonenumber_Invalid << 11 ) + ( le.submitted_firstname_Invalid << 12 ) + ( le.submitted_lastname_Invalid << 13 ) + ( le.submitted_middlename_Invalid << 14 ) + ( le.submitted_city_Invalid << 15 ) + ( le.submitted_state_Invalid << 16 ) + ( le.submitted_zip_Invalid << 18 ) + ( le.phonenumber_Invalid << 20 ) + ( le.data_source_Invalid << 22 ) + ( le.royalty_used_Invalid << 23 ) + ( le.carrier_Invalid << 24 ) + ( le.risk_indicator_Invalid << 25 ) + ( le.phone_type_Invalid << 26 ) + ( le.phone_status_Invalid << 27 ) + ( le.ported_count_Invalid << 28 ) + ( le.last_ported_date_Invalid << 29 ) + ( le.otp_count_Invalid << 30 ) + ( le.last_otp_date_Invalid << 31 ) + ( le.spoof_count_Invalid << 32 ) + ( le.last_spoof_date_Invalid << 33 ) + ( le.phone_forwarded_Invalid << 34 ) + ( le.identity_count_Invalid << 35 ) + ( le.phone_verified_Invalid << 36 ) + ( le.verification_type_Invalid << 37 ) + ( le.phone_star_rating_Invalid << 38 );
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
  EXPORT Infile := PROJECT(h,Transactions_Layout_PhoneFinder);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.transaction_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.transaction_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.product_code_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.company_id_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.source_code_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.batch_job_id_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.batch_acctno_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.response_time_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.reference_code_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.phonefinder_type_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.submitted_lexid_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.submitted_phonenumber_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.submitted_firstname_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.submitted_lastname_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.submitted_middlename_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.submitted_city_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.submitted_state_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.submitted_zip_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.phonenumber_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.data_source_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.royalty_used_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.carrier_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.risk_indicator_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.phone_type_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.phone_status_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.ported_count_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.last_ported_date_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.otp_count_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.last_otp_date_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.spoof_count_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.last_spoof_date_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.phone_forwarded_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.identity_count_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.phone_verified_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.verification_type_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.phone_star_rating_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=1);
    transaction_date_CUSTOM_ErrorCount := COUNT(GROUP,h.transaction_date_Invalid=1);
    product_code_ALLOW_ErrorCount := COUNT(GROUP,h.product_code_Invalid=1);
    company_id_ALLOW_ErrorCount := COUNT(GROUP,h.company_id_Invalid=1);
    source_code_ALLOW_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    batch_job_id_ALLOW_ErrorCount := COUNT(GROUP,h.batch_job_id_Invalid=1);
    batch_acctno_ALLOW_ErrorCount := COUNT(GROUP,h.batch_acctno_Invalid=1);
    response_time_ALLOW_ErrorCount := COUNT(GROUP,h.response_time_Invalid=1);
    reference_code_ALLOW_ErrorCount := COUNT(GROUP,h.reference_code_Invalid=1);
    phonefinder_type_ALLOW_ErrorCount := COUNT(GROUP,h.phonefinder_type_Invalid=1);
    submitted_lexid_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_lexid_Invalid=1);
    submitted_phonenumber_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_phonenumber_Invalid=1);
    submitted_firstname_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_firstname_Invalid=1);
    submitted_lastname_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_lastname_Invalid=1);
    submitted_middlename_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_middlename_Invalid=1);
    submitted_city_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_city_Invalid=1);
    submitted_state_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_state_Invalid=1);
    submitted_state_LENGTHS_ErrorCount := COUNT(GROUP,h.submitted_state_Invalid=2);
    submitted_state_Total_ErrorCount := COUNT(GROUP,h.submitted_state_Invalid>0);
    submitted_zip_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_zip_Invalid=1);
    submitted_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.submitted_zip_Invalid=2);
    submitted_zip_Total_ErrorCount := COUNT(GROUP,h.submitted_zip_Invalid>0);
    phonenumber_ALLOW_ErrorCount := COUNT(GROUP,h.phonenumber_Invalid=1);
    phonenumber_LENGTHS_ErrorCount := COUNT(GROUP,h.phonenumber_Invalid=2);
    phonenumber_Total_ErrorCount := COUNT(GROUP,h.phonenumber_Invalid>0);
    data_source_ALLOW_ErrorCount := COUNT(GROUP,h.data_source_Invalid=1);
    royalty_used_ALLOW_ErrorCount := COUNT(GROUP,h.royalty_used_Invalid=1);
    carrier_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_Invalid=1);
    risk_indicator_ENUM_ErrorCount := COUNT(GROUP,h.risk_indicator_Invalid=1);
    phone_type_ENUM_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=1);
    phone_status_ENUM_ErrorCount := COUNT(GROUP,h.phone_status_Invalid=1);
    ported_count_ALLOW_ErrorCount := COUNT(GROUP,h.ported_count_Invalid=1);
    last_ported_date_CUSTOM_ErrorCount := COUNT(GROUP,h.last_ported_date_Invalid=1);
    otp_count_ALLOW_ErrorCount := COUNT(GROUP,h.otp_count_Invalid=1);
    last_otp_date_CUSTOM_ErrorCount := COUNT(GROUP,h.last_otp_date_Invalid=1);
    spoof_count_ALLOW_ErrorCount := COUNT(GROUP,h.spoof_count_Invalid=1);
    last_spoof_date_CUSTOM_ErrorCount := COUNT(GROUP,h.last_spoof_date_Invalid=1);
    phone_forwarded_ENUM_ErrorCount := COUNT(GROUP,h.phone_forwarded_Invalid=1);
    identity_count_ALLOW_ErrorCount := COUNT(GROUP,h.identity_count_Invalid=1);
    phone_verified_ALLOW_ErrorCount := COUNT(GROUP,h.phone_verified_Invalid=1);
    verification_type_ALLOW_ErrorCount := COUNT(GROUP,h.verification_type_Invalid=1);
    phone_star_rating_ALLOW_ErrorCount := COUNT(GROUP,h.phone_star_rating_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.transaction_id_Invalid > 0 OR h.transaction_date_Invalid > 0 OR h.product_code_Invalid > 0 OR h.company_id_Invalid > 0 OR h.source_code_Invalid > 0 OR h.batch_job_id_Invalid > 0 OR h.batch_acctno_Invalid > 0 OR h.response_time_Invalid > 0 OR h.reference_code_Invalid > 0 OR h.phonefinder_type_Invalid > 0 OR h.submitted_lexid_Invalid > 0 OR h.submitted_phonenumber_Invalid > 0 OR h.submitted_firstname_Invalid > 0 OR h.submitted_lastname_Invalid > 0 OR h.submitted_middlename_Invalid > 0 OR h.submitted_city_Invalid > 0 OR h.submitted_state_Invalid > 0 OR h.submitted_zip_Invalid > 0 OR h.phonenumber_Invalid > 0 OR h.data_source_Invalid > 0 OR h.royalty_used_Invalid > 0 OR h.carrier_Invalid > 0 OR h.risk_indicator_Invalid > 0 OR h.phone_type_Invalid > 0 OR h.phone_status_Invalid > 0 OR h.ported_count_Invalid > 0 OR h.last_ported_date_Invalid > 0 OR h.otp_count_Invalid > 0 OR h.last_otp_date_Invalid > 0 OR h.spoof_count_Invalid > 0 OR h.last_spoof_date_Invalid > 0 OR h.phone_forwarded_Invalid > 0 OR h.identity_count_Invalid > 0 OR h.phone_verified_Invalid > 0 OR h.verification_type_Invalid > 0 OR h.phone_star_rating_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.product_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_job_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_acctno_ALLOW_ErrorCount > 0, 1, 0) + IF(le.response_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reference_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phonefinder_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_lexid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_phonenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_firstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_lastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_middlename_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_state_Total_ErrorCount > 0, 1, 0) + IF(le.submitted_zip_Total_ErrorCount > 0, 1, 0) + IF(le.phonenumber_Total_ErrorCount > 0, 1, 0) + IF(le.data_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.royalty_used_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_ALLOW_ErrorCount > 0, 1, 0) + IF(le.risk_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.phone_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.phone_status_ENUM_ErrorCount > 0, 1, 0) + IF(le.ported_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_ported_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.otp_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_otp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spoof_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_spoof_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_forwarded_ENUM_ErrorCount > 0, 1, 0) + IF(le.identity_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_verified_ALLOW_ErrorCount > 0, 1, 0) + IF(le.verification_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_star_rating_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transaction_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.product_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_job_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_acctno_ALLOW_ErrorCount > 0, 1, 0) + IF(le.response_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reference_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phonefinder_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_lexid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_phonenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_firstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_lastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_middlename_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.submitted_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.phonenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phonenumber_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.data_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.royalty_used_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_ALLOW_ErrorCount > 0, 1, 0) + IF(le.risk_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.phone_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.phone_status_ENUM_ErrorCount > 0, 1, 0) + IF(le.ported_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_ported_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.otp_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_otp_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spoof_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_spoof_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_forwarded_ENUM_ErrorCount > 0, 1, 0) + IF(le.identity_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_verified_ALLOW_ErrorCount > 0, 1, 0) + IF(le.verification_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_star_rating_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.transaction_id_Invalid,le.transaction_date_Invalid,le.product_code_Invalid,le.company_id_Invalid,le.source_code_Invalid,le.batch_job_id_Invalid,le.batch_acctno_Invalid,le.response_time_Invalid,le.reference_code_Invalid,le.phonefinder_type_Invalid,le.submitted_lexid_Invalid,le.submitted_phonenumber_Invalid,le.submitted_firstname_Invalid,le.submitted_lastname_Invalid,le.submitted_middlename_Invalid,le.submitted_city_Invalid,le.submitted_state_Invalid,le.submitted_zip_Invalid,le.phonenumber_Invalid,le.data_source_Invalid,le.royalty_used_Invalid,le.carrier_Invalid,le.risk_indicator_Invalid,le.phone_type_Invalid,le.phone_status_Invalid,le.ported_count_Invalid,le.last_ported_date_Invalid,le.otp_count_Invalid,le.last_otp_date_Invalid,le.spoof_count_Invalid,le.last_spoof_date_Invalid,le.phone_forwarded_Invalid,le.identity_count_Invalid,le.phone_verified_Invalid,le.verification_type_Invalid,le.phone_star_rating_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Transactions_Fields.InvalidMessage_transaction_id(le.transaction_id_Invalid),Transactions_Fields.InvalidMessage_transaction_date(le.transaction_date_Invalid),Transactions_Fields.InvalidMessage_product_code(le.product_code_Invalid),Transactions_Fields.InvalidMessage_company_id(le.company_id_Invalid),Transactions_Fields.InvalidMessage_source_code(le.source_code_Invalid),Transactions_Fields.InvalidMessage_batch_job_id(le.batch_job_id_Invalid),Transactions_Fields.InvalidMessage_batch_acctno(le.batch_acctno_Invalid),Transactions_Fields.InvalidMessage_response_time(le.response_time_Invalid),Transactions_Fields.InvalidMessage_reference_code(le.reference_code_Invalid),Transactions_Fields.InvalidMessage_phonefinder_type(le.phonefinder_type_Invalid),Transactions_Fields.InvalidMessage_submitted_lexid(le.submitted_lexid_Invalid),Transactions_Fields.InvalidMessage_submitted_phonenumber(le.submitted_phonenumber_Invalid),Transactions_Fields.InvalidMessage_submitted_firstname(le.submitted_firstname_Invalid),Transactions_Fields.InvalidMessage_submitted_lastname(le.submitted_lastname_Invalid),Transactions_Fields.InvalidMessage_submitted_middlename(le.submitted_middlename_Invalid),Transactions_Fields.InvalidMessage_submitted_city(le.submitted_city_Invalid),Transactions_Fields.InvalidMessage_submitted_state(le.submitted_state_Invalid),Transactions_Fields.InvalidMessage_submitted_zip(le.submitted_zip_Invalid),Transactions_Fields.InvalidMessage_phonenumber(le.phonenumber_Invalid),Transactions_Fields.InvalidMessage_data_source(le.data_source_Invalid),Transactions_Fields.InvalidMessage_royalty_used(le.royalty_used_Invalid),Transactions_Fields.InvalidMessage_carrier(le.carrier_Invalid),Transactions_Fields.InvalidMessage_risk_indicator(le.risk_indicator_Invalid),Transactions_Fields.InvalidMessage_phone_type(le.phone_type_Invalid),Transactions_Fields.InvalidMessage_phone_status(le.phone_status_Invalid),Transactions_Fields.InvalidMessage_ported_count(le.ported_count_Invalid),Transactions_Fields.InvalidMessage_last_ported_date(le.last_ported_date_Invalid),Transactions_Fields.InvalidMessage_otp_count(le.otp_count_Invalid),Transactions_Fields.InvalidMessage_last_otp_date(le.last_otp_date_Invalid),Transactions_Fields.InvalidMessage_spoof_count(le.spoof_count_Invalid),Transactions_Fields.InvalidMessage_last_spoof_date(le.last_spoof_date_Invalid),Transactions_Fields.InvalidMessage_phone_forwarded(le.phone_forwarded_Invalid),Transactions_Fields.InvalidMessage_identity_count(le.identity_count_Invalid),Transactions_Fields.InvalidMessage_phone_verified(le.phone_verified_Invalid),Transactions_Fields.InvalidMessage_verification_type(le.verification_type_Invalid),Transactions_Fields.InvalidMessage_phone_star_rating(le.phone_star_rating_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.transaction_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transaction_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.product_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.batch_job_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.batch_acctno_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.response_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reference_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phonefinder_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_lexid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_phonenumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_firstname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_lastname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_middlename_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.submitted_zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.phonenumber_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.data_source_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.royalty_used_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carrier_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.risk_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_status_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ported_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_ported_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.otp_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_otp_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spoof_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_spoof_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_forwarded_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.identity_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_verified_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.verification_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_star_rating_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'transaction_id','transaction_date','product_code','company_id','source_code','batch_job_id','batch_acctno','response_time','reference_code','phonefinder_type','submitted_lexid','submitted_phonenumber','submitted_firstname','submitted_lastname','submitted_middlename','submitted_city','submitted_state','submitted_zip','phonenumber','data_source','royalty_used','carrier','risk_indicator','phone_type','phone_status','ported_count','last_ported_date','otp_count','last_otp_date','spoof_count','last_spoof_date','phone_forwarded','identity_count','phone_verified','verification_type','phone_star_rating','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_ID','Invalid_Date','Invalid_Alpha','Invalid_No','Invalid_Code','Invalid_Code','Invalid_No','Invalid_No','Invalid_AlphaChar','Invalid_Alpha','Invalid_Code','Invalid_Code','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_Binary','Invalid_Alpha','Invalid_AlphaChar','Invalid_Risk','Invalid_Phone_Type','Invalid_Phone_Status','Invalid_No','Invalid_Date','Invalid_No','Invalid_Date','Invalid_No','Invalid_Date','Invalid_Forward','Invalid_No','Invalid_Code','Invalid_AlphaChar','Invalid_Rating','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.transaction_id,(SALT311.StrType)le.transaction_date,(SALT311.StrType)le.product_code,(SALT311.StrType)le.company_id,(SALT311.StrType)le.source_code,(SALT311.StrType)le.batch_job_id,(SALT311.StrType)le.batch_acctno,(SALT311.StrType)le.response_time,(SALT311.StrType)le.reference_code,(SALT311.StrType)le.phonefinder_type,(SALT311.StrType)le.submitted_lexid,(SALT311.StrType)le.submitted_phonenumber,(SALT311.StrType)le.submitted_firstname,(SALT311.StrType)le.submitted_lastname,(SALT311.StrType)le.submitted_middlename,(SALT311.StrType)le.submitted_city,(SALT311.StrType)le.submitted_state,(SALT311.StrType)le.submitted_zip,(SALT311.StrType)le.phonenumber,(SALT311.StrType)le.data_source,(SALT311.StrType)le.royalty_used,(SALT311.StrType)le.carrier,(SALT311.StrType)le.risk_indicator,(SALT311.StrType)le.phone_type,(SALT311.StrType)le.phone_status,(SALT311.StrType)le.ported_count,(SALT311.StrType)le.last_ported_date,(SALT311.StrType)le.otp_count,(SALT311.StrType)le.last_otp_date,(SALT311.StrType)le.spoof_count,(SALT311.StrType)le.last_spoof_date,(SALT311.StrType)le.phone_forwarded,(SALT311.StrType)le.identity_count,(SALT311.StrType)le.phone_verified,(SALT311.StrType)le.verification_type,(SALT311.StrType)le.phone_star_rating,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,36,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Transactions_Layout_PhoneFinder) prevDS = DATASET([], Transactions_Layout_PhoneFinder), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.transaction_date_CUSTOM_ErrorCount
          ,le.product_code_ALLOW_ErrorCount
          ,le.company_id_ALLOW_ErrorCount
          ,le.source_code_ALLOW_ErrorCount
          ,le.batch_job_id_ALLOW_ErrorCount
          ,le.batch_acctno_ALLOW_ErrorCount
          ,le.response_time_ALLOW_ErrorCount
          ,le.reference_code_ALLOW_ErrorCount
          ,le.phonefinder_type_ALLOW_ErrorCount
          ,le.submitted_lexid_ALLOW_ErrorCount
          ,le.submitted_phonenumber_ALLOW_ErrorCount
          ,le.submitted_firstname_ALLOW_ErrorCount
          ,le.submitted_lastname_ALLOW_ErrorCount
          ,le.submitted_middlename_ALLOW_ErrorCount
          ,le.submitted_city_ALLOW_ErrorCount
          ,le.submitted_state_ALLOW_ErrorCount,le.submitted_state_LENGTHS_ErrorCount
          ,le.submitted_zip_ALLOW_ErrorCount,le.submitted_zip_LENGTHS_ErrorCount
          ,le.phonenumber_ALLOW_ErrorCount,le.phonenumber_LENGTHS_ErrorCount
          ,le.data_source_ALLOW_ErrorCount
          ,le.royalty_used_ALLOW_ErrorCount
          ,le.carrier_ALLOW_ErrorCount
          ,le.risk_indicator_ENUM_ErrorCount
          ,le.phone_type_ENUM_ErrorCount
          ,le.phone_status_ENUM_ErrorCount
          ,le.ported_count_ALLOW_ErrorCount
          ,le.last_ported_date_CUSTOM_ErrorCount
          ,le.otp_count_ALLOW_ErrorCount
          ,le.last_otp_date_CUSTOM_ErrorCount
          ,le.spoof_count_ALLOW_ErrorCount
          ,le.last_spoof_date_CUSTOM_ErrorCount
          ,le.phone_forwarded_ENUM_ErrorCount
          ,le.identity_count_ALLOW_ErrorCount
          ,le.phone_verified_ALLOW_ErrorCount
          ,le.verification_type_ALLOW_ErrorCount
          ,le.phone_star_rating_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.transaction_date_CUSTOM_ErrorCount
          ,le.product_code_ALLOW_ErrorCount
          ,le.company_id_ALLOW_ErrorCount
          ,le.source_code_ALLOW_ErrorCount
          ,le.batch_job_id_ALLOW_ErrorCount
          ,le.batch_acctno_ALLOW_ErrorCount
          ,le.response_time_ALLOW_ErrorCount
          ,le.reference_code_ALLOW_ErrorCount
          ,le.phonefinder_type_ALLOW_ErrorCount
          ,le.submitted_lexid_ALLOW_ErrorCount
          ,le.submitted_phonenumber_ALLOW_ErrorCount
          ,le.submitted_firstname_ALLOW_ErrorCount
          ,le.submitted_lastname_ALLOW_ErrorCount
          ,le.submitted_middlename_ALLOW_ErrorCount
          ,le.submitted_city_ALLOW_ErrorCount
          ,le.submitted_state_ALLOW_ErrorCount,le.submitted_state_LENGTHS_ErrorCount
          ,le.submitted_zip_ALLOW_ErrorCount,le.submitted_zip_LENGTHS_ErrorCount
          ,le.phonenumber_ALLOW_ErrorCount,le.phonenumber_LENGTHS_ErrorCount
          ,le.data_source_ALLOW_ErrorCount
          ,le.royalty_used_ALLOW_ErrorCount
          ,le.carrier_ALLOW_ErrorCount
          ,le.risk_indicator_ENUM_ErrorCount
          ,le.phone_type_ENUM_ErrorCount
          ,le.phone_status_ENUM_ErrorCount
          ,le.ported_count_ALLOW_ErrorCount
          ,le.last_ported_date_CUSTOM_ErrorCount
          ,le.otp_count_ALLOW_ErrorCount
          ,le.last_otp_date_CUSTOM_ErrorCount
          ,le.spoof_count_ALLOW_ErrorCount
          ,le.last_spoof_date_CUSTOM_ErrorCount
          ,le.phone_forwarded_ENUM_ErrorCount
          ,le.identity_count_ALLOW_ErrorCount
          ,le.phone_verified_ALLOW_ErrorCount
          ,le.verification_type_ALLOW_ErrorCount
          ,le.phone_star_rating_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Transactions_hygiene(PROJECT(h, Transactions_Layout_PhoneFinder));
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
          ,'transaction_id:' + getFieldTypeText(h.transaction_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_date:' + getFieldTypeText(h.transaction_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'user_id:' + getFieldTypeText(h.user_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'product_code:' + getFieldTypeText(h.product_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_id:' + getFieldTypeText(h.company_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_code:' + getFieldTypeText(h.source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'batch_job_id:' + getFieldTypeText(h.batch_job_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'batch_acctno:' + getFieldTypeText(h.batch_acctno) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'response_time:' + getFieldTypeText(h.response_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reference_code:' + getFieldTypeText(h.reference_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phonefinder_type:' + getFieldTypeText(h.phonefinder_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_lexid:' + getFieldTypeText(h.submitted_lexid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_phonenumber:' + getFieldTypeText(h.submitted_phonenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_firstname:' + getFieldTypeText(h.submitted_firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_lastname:' + getFieldTypeText(h.submitted_lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_middlename:' + getFieldTypeText(h.submitted_middlename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_streetaddress1:' + getFieldTypeText(h.submitted_streetaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_city:' + getFieldTypeText(h.submitted_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_state:' + getFieldTypeText(h.submitted_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_zip:' + getFieldTypeText(h.submitted_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phonenumber:' + getFieldTypeText(h.phonenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'data_source:' + getFieldTypeText(h.data_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'royalty_used:' + getFieldTypeText(h.royalty_used) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier:' + getFieldTypeText(h.carrier) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'risk_indicator:' + getFieldTypeText(h.risk_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_type:' + getFieldTypeText(h.phone_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_status:' + getFieldTypeText(h.phone_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ported_count:' + getFieldTypeText(h.ported_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_ported_date:' + getFieldTypeText(h.last_ported_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'otp_count:' + getFieldTypeText(h.otp_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_otp_date:' + getFieldTypeText(h.last_otp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spoof_count:' + getFieldTypeText(h.spoof_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_spoof_date:' + getFieldTypeText(h.last_spoof_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_forwarded:' + getFieldTypeText(h.phone_forwarded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_added:' + getFieldTypeText(h.date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'identity_count:' + getFieldTypeText(h.identity_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_verified:' + getFieldTypeText(h.phone_verified) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'verification_type:' + getFieldTypeText(h.verification_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_star_rating:' + getFieldTypeText(h.phone_star_rating) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_transaction_id_cnt
          ,le.populated_transaction_date_cnt
          ,le.populated_user_id_cnt
          ,le.populated_product_code_cnt
          ,le.populated_company_id_cnt
          ,le.populated_source_code_cnt
          ,le.populated_batch_job_id_cnt
          ,le.populated_batch_acctno_cnt
          ,le.populated_response_time_cnt
          ,le.populated_reference_code_cnt
          ,le.populated_phonefinder_type_cnt
          ,le.populated_submitted_lexid_cnt
          ,le.populated_submitted_phonenumber_cnt
          ,le.populated_submitted_firstname_cnt
          ,le.populated_submitted_lastname_cnt
          ,le.populated_submitted_middlename_cnt
          ,le.populated_submitted_streetaddress1_cnt
          ,le.populated_submitted_city_cnt
          ,le.populated_submitted_state_cnt
          ,le.populated_submitted_zip_cnt
          ,le.populated_phonenumber_cnt
          ,le.populated_data_source_cnt
          ,le.populated_royalty_used_cnt
          ,le.populated_carrier_cnt
          ,le.populated_risk_indicator_cnt
          ,le.populated_phone_type_cnt
          ,le.populated_phone_status_cnt
          ,le.populated_ported_count_cnt
          ,le.populated_last_ported_date_cnt
          ,le.populated_otp_count_cnt
          ,le.populated_last_otp_date_cnt
          ,le.populated_spoof_count_cnt
          ,le.populated_last_spoof_date_cnt
          ,le.populated_phone_forwarded_cnt
          ,le.populated_date_added_cnt
          ,le.populated_identity_count_cnt
          ,le.populated_phone_verified_cnt
          ,le.populated_verification_type_cnt
          ,le.populated_phone_star_rating_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_transaction_id_pcnt
          ,le.populated_transaction_date_pcnt
          ,le.populated_user_id_pcnt
          ,le.populated_product_code_pcnt
          ,le.populated_company_id_pcnt
          ,le.populated_source_code_pcnt
          ,le.populated_batch_job_id_pcnt
          ,le.populated_batch_acctno_pcnt
          ,le.populated_response_time_pcnt
          ,le.populated_reference_code_pcnt
          ,le.populated_phonefinder_type_pcnt
          ,le.populated_submitted_lexid_pcnt
          ,le.populated_submitted_phonenumber_pcnt
          ,le.populated_submitted_firstname_pcnt
          ,le.populated_submitted_lastname_pcnt
          ,le.populated_submitted_middlename_pcnt
          ,le.populated_submitted_streetaddress1_pcnt
          ,le.populated_submitted_city_pcnt
          ,le.populated_submitted_state_pcnt
          ,le.populated_submitted_zip_pcnt
          ,le.populated_phonenumber_pcnt
          ,le.populated_data_source_pcnt
          ,le.populated_royalty_used_pcnt
          ,le.populated_carrier_pcnt
          ,le.populated_risk_indicator_pcnt
          ,le.populated_phone_type_pcnt
          ,le.populated_phone_status_pcnt
          ,le.populated_ported_count_pcnt
          ,le.populated_last_ported_date_pcnt
          ,le.populated_otp_count_pcnt
          ,le.populated_last_otp_date_pcnt
          ,le.populated_spoof_count_pcnt
          ,le.populated_last_spoof_date_pcnt
          ,le.populated_phone_forwarded_pcnt
          ,le.populated_date_added_pcnt
          ,le.populated_identity_count_pcnt
          ,le.populated_phone_verified_pcnt
          ,le.populated_verification_type_pcnt
          ,le.populated_phone_star_rating_pcnt
          ,le.populated_filename_pcnt,0);
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
 
    mod_Delta := Transactions_Delta(prevDS, PROJECT(h, Transactions_Layout_PhoneFinder));
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
 
EXPORT StandardStats(DATASET(Transactions_Layout_PhoneFinder) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhoneFinder, Transactions_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
