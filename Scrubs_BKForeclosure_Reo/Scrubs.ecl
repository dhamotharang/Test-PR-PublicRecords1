IMPORT SALT311,STD;
IMPORT Scrubs_BKForeclosure_Reo; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 39;
  EXPORT NumRulesFromFieldType := 39;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 29;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_BKForeclosure_Reo)
    UNSIGNED1 ln_filedate_Invalid;
    UNSIGNED1 fips_cd_Invalid;
    UNSIGNED1 prop_full_addr_Invalid;
    UNSIGNED1 prop_addr_city_Invalid;
    UNSIGNED1 prop_addr_state_Invalid;
    UNSIGNED1 prop_addr_zip5_Invalid;
    UNSIGNED1 prop_addr_zip4_Invalid;
    UNSIGNED1 recording_date_Invalid;
    UNSIGNED1 doc_type_cd_Invalid;
    UNSIGNED1 apn_Invalid;
    UNSIGNED1 seller1_fname_Invalid;
    UNSIGNED1 seller1_lname_Invalid;
    UNSIGNED1 seller2_fname_Invalid;
    UNSIGNED1 seller2_lname_Invalid;
    UNSIGNED1 buyer1_fname_Invalid;
    UNSIGNED1 buyer1_lname_Invalid;
    UNSIGNED1 buyer2_fname_Invalid;
    UNSIGNED1 buyer2_lname_Invalid;
    UNSIGNED1 buyer_mail_city_Invalid;
    UNSIGNED1 buyer_mail_state_Invalid;
    UNSIGNED1 buyer_mail_zip5_Invalid;
    UNSIGNED1 buyer_mail_zip4_Invalid;
    UNSIGNED1 property_use_cd_Invalid;
    UNSIGNED1 orig_contract_date_Invalid;
    UNSIGNED1 concurrent_lender_type_Invalid;
    UNSIGNED1 concurrent_loan_type_Invalid;
    UNSIGNED1 concurrent_due_dt_Invalid;
    UNSIGNED1 buyer_mail_full_addr_Invalid;
    UNSIGNED1 asses_land_use_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_BKForeclosure_Reo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_BKForeclosure_Reo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ln_filedate_Invalid := Fields.InValid_ln_filedate((SALT311.StrType)le.ln_filedate);
    SELF.fips_cd_Invalid := Fields.InValid_fips_cd((SALT311.StrType)le.fips_cd);
    SELF.prop_full_addr_Invalid := Fields.InValid_prop_full_addr((SALT311.StrType)le.prop_full_addr);
    SELF.prop_addr_city_Invalid := Fields.InValid_prop_addr_city((SALT311.StrType)le.prop_addr_city);
    SELF.prop_addr_state_Invalid := Fields.InValid_prop_addr_state((SALT311.StrType)le.prop_addr_state);
    SELF.prop_addr_zip5_Invalid := Fields.InValid_prop_addr_zip5((SALT311.StrType)le.prop_addr_zip5);
    SELF.prop_addr_zip4_Invalid := Fields.InValid_prop_addr_zip4((SALT311.StrType)le.prop_addr_zip4);
    SELF.recording_date_Invalid := Fields.InValid_recording_date((SALT311.StrType)le.recording_date);
    SELF.doc_type_cd_Invalid := Fields.InValid_doc_type_cd((SALT311.StrType)le.doc_type_cd);
    SELF.apn_Invalid := Fields.InValid_apn((SALT311.StrType)le.apn);
    SELF.seller1_fname_Invalid := Fields.InValid_seller1_fname((SALT311.StrType)le.seller1_fname);
    SELF.seller1_lname_Invalid := Fields.InValid_seller1_lname((SALT311.StrType)le.seller1_lname);
    SELF.seller2_fname_Invalid := Fields.InValid_seller2_fname((SALT311.StrType)le.seller2_fname);
    SELF.seller2_lname_Invalid := Fields.InValid_seller2_lname((SALT311.StrType)le.seller2_lname);
    SELF.buyer1_fname_Invalid := Fields.InValid_buyer1_fname((SALT311.StrType)le.buyer1_fname);
    SELF.buyer1_lname_Invalid := Fields.InValid_buyer1_lname((SALT311.StrType)le.buyer1_lname);
    SELF.buyer2_fname_Invalid := Fields.InValid_buyer2_fname((SALT311.StrType)le.buyer2_fname);
    SELF.buyer2_lname_Invalid := Fields.InValid_buyer2_lname((SALT311.StrType)le.buyer2_lname);
    SELF.buyer_mail_city_Invalid := Fields.InValid_buyer_mail_city((SALT311.StrType)le.buyer_mail_city);
    SELF.buyer_mail_state_Invalid := Fields.InValid_buyer_mail_state((SALT311.StrType)le.buyer_mail_state);
    SELF.buyer_mail_zip5_Invalid := Fields.InValid_buyer_mail_zip5((SALT311.StrType)le.buyer_mail_zip5);
    SELF.buyer_mail_zip4_Invalid := Fields.InValid_buyer_mail_zip4((SALT311.StrType)le.buyer_mail_zip4);
    SELF.property_use_cd_Invalid := Fields.InValid_property_use_cd((SALT311.StrType)le.property_use_cd);
    SELF.orig_contract_date_Invalid := Fields.InValid_orig_contract_date((SALT311.StrType)le.orig_contract_date);
    SELF.concurrent_lender_type_Invalid := Fields.InValid_concurrent_lender_type((SALT311.StrType)le.concurrent_lender_type);
    SELF.concurrent_loan_type_Invalid := Fields.InValid_concurrent_loan_type((SALT311.StrType)le.concurrent_loan_type);
    SELF.concurrent_due_dt_Invalid := Fields.InValid_concurrent_due_dt((SALT311.StrType)le.concurrent_due_dt);
    SELF.buyer_mail_full_addr_Invalid := Fields.InValid_buyer_mail_full_addr((SALT311.StrType)le.buyer_mail_full_addr);
    SELF.asses_land_use_Invalid := Fields.InValid_asses_land_use((SALT311.StrType)le.asses_land_use);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_BKForeclosure_Reo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ln_filedate_Invalid << 0 ) + ( le.fips_cd_Invalid << 2 ) + ( le.prop_full_addr_Invalid << 3 ) + ( le.prop_addr_city_Invalid << 4 ) + ( le.prop_addr_state_Invalid << 5 ) + ( le.prop_addr_zip5_Invalid << 7 ) + ( le.prop_addr_zip4_Invalid << 9 ) + ( le.recording_date_Invalid << 11 ) + ( le.doc_type_cd_Invalid << 13 ) + ( le.apn_Invalid << 14 ) + ( le.seller1_fname_Invalid << 15 ) + ( le.seller1_lname_Invalid << 16 ) + ( le.seller2_fname_Invalid << 17 ) + ( le.seller2_lname_Invalid << 18 ) + ( le.buyer1_fname_Invalid << 19 ) + ( le.buyer1_lname_Invalid << 20 ) + ( le.buyer2_fname_Invalid << 21 ) + ( le.buyer2_lname_Invalid << 22 ) + ( le.buyer_mail_city_Invalid << 23 ) + ( le.buyer_mail_state_Invalid << 24 ) + ( le.buyer_mail_zip5_Invalid << 26 ) + ( le.buyer_mail_zip4_Invalid << 28 ) + ( le.property_use_cd_Invalid << 30 ) + ( le.orig_contract_date_Invalid << 31 ) + ( le.concurrent_lender_type_Invalid << 33 ) + ( le.concurrent_loan_type_Invalid << 34 ) + ( le.concurrent_due_dt_Invalid << 35 ) + ( le.buyer_mail_full_addr_Invalid << 37 ) + ( le.asses_land_use_Invalid << 38 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_BKForeclosure_Reo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ln_filedate_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.fips_cd_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.prop_full_addr_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.prop_addr_city_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.prop_addr_state_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.prop_addr_zip5_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.prop_addr_zip4_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.recording_date_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.doc_type_cd_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.apn_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.seller1_fname_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.seller1_lname_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.seller2_fname_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.seller2_lname_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.buyer1_fname_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.buyer1_lname_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.buyer2_fname_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.buyer2_lname_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.buyer_mail_city_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.buyer_mail_state_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.buyer_mail_zip5_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.buyer_mail_zip4_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.property_use_cd_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.orig_contract_date_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.concurrent_lender_type_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.concurrent_loan_type_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.concurrent_due_dt_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.buyer_mail_full_addr_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.asses_land_use_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ln_filedate_ALLOW_ErrorCount := COUNT(GROUP,h.ln_filedate_Invalid=1);
    ln_filedate_LENGTHS_ErrorCount := COUNT(GROUP,h.ln_filedate_Invalid=2);
    ln_filedate_Total_ErrorCount := COUNT(GROUP,h.ln_filedate_Invalid>0);
    fips_cd_ALLOW_ErrorCount := COUNT(GROUP,h.fips_cd_Invalid=1);
    prop_full_addr_ALLOW_ErrorCount := COUNT(GROUP,h.prop_full_addr_Invalid=1);
    prop_addr_city_ALLOW_ErrorCount := COUNT(GROUP,h.prop_addr_city_Invalid=1);
    prop_addr_state_ALLOW_ErrorCount := COUNT(GROUP,h.prop_addr_state_Invalid=1);
    prop_addr_state_LENGTHS_ErrorCount := COUNT(GROUP,h.prop_addr_state_Invalid=2);
    prop_addr_state_Total_ErrorCount := COUNT(GROUP,h.prop_addr_state_Invalid>0);
    prop_addr_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.prop_addr_zip5_Invalid=1);
    prop_addr_zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.prop_addr_zip5_Invalid=2);
    prop_addr_zip5_Total_ErrorCount := COUNT(GROUP,h.prop_addr_zip5_Invalid>0);
    prop_addr_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.prop_addr_zip4_Invalid=1);
    prop_addr_zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.prop_addr_zip4_Invalid=2);
    prop_addr_zip4_Total_ErrorCount := COUNT(GROUP,h.prop_addr_zip4_Invalid>0);
    recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=1);
    recording_date_LENGTHS_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=2);
    recording_date_Total_ErrorCount := COUNT(GROUP,h.recording_date_Invalid>0);
    doc_type_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.doc_type_cd_Invalid=1);
    apn_ALLOW_ErrorCount := COUNT(GROUP,h.apn_Invalid=1);
    seller1_fname_ALLOW_ErrorCount := COUNT(GROUP,h.seller1_fname_Invalid=1);
    seller1_lname_ALLOW_ErrorCount := COUNT(GROUP,h.seller1_lname_Invalid=1);
    seller2_fname_ALLOW_ErrorCount := COUNT(GROUP,h.seller2_fname_Invalid=1);
    seller2_lname_ALLOW_ErrorCount := COUNT(GROUP,h.seller2_lname_Invalid=1);
    buyer1_fname_ALLOW_ErrorCount := COUNT(GROUP,h.buyer1_fname_Invalid=1);
    buyer1_lname_ALLOW_ErrorCount := COUNT(GROUP,h.buyer1_lname_Invalid=1);
    buyer2_fname_ALLOW_ErrorCount := COUNT(GROUP,h.buyer2_fname_Invalid=1);
    buyer2_lname_ALLOW_ErrorCount := COUNT(GROUP,h.buyer2_lname_Invalid=1);
    buyer_mail_city_ALLOW_ErrorCount := COUNT(GROUP,h.buyer_mail_city_Invalid=1);
    buyer_mail_state_ALLOW_ErrorCount := COUNT(GROUP,h.buyer_mail_state_Invalid=1);
    buyer_mail_state_LENGTHS_ErrorCount := COUNT(GROUP,h.buyer_mail_state_Invalid=2);
    buyer_mail_state_Total_ErrorCount := COUNT(GROUP,h.buyer_mail_state_Invalid>0);
    buyer_mail_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.buyer_mail_zip5_Invalid=1);
    buyer_mail_zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.buyer_mail_zip5_Invalid=2);
    buyer_mail_zip5_Total_ErrorCount := COUNT(GROUP,h.buyer_mail_zip5_Invalid>0);
    buyer_mail_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.buyer_mail_zip4_Invalid=1);
    buyer_mail_zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.buyer_mail_zip4_Invalid=2);
    buyer_mail_zip4_Total_ErrorCount := COUNT(GROUP,h.buyer_mail_zip4_Invalid>0);
    property_use_cd_CUSTOM_ErrorCount := COUNT(GROUP,h.property_use_cd_Invalid=1);
    orig_contract_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_contract_date_Invalid=1);
    orig_contract_date_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_contract_date_Invalid=2);
    orig_contract_date_Total_ErrorCount := COUNT(GROUP,h.orig_contract_date_Invalid>0);
    concurrent_lender_type_CUSTOM_ErrorCount := COUNT(GROUP,h.concurrent_lender_type_Invalid=1);
    concurrent_loan_type_CUSTOM_ErrorCount := COUNT(GROUP,h.concurrent_loan_type_Invalid=1);
    concurrent_due_dt_ALLOW_ErrorCount := COUNT(GROUP,h.concurrent_due_dt_Invalid=1);
    concurrent_due_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.concurrent_due_dt_Invalid=2);
    concurrent_due_dt_Total_ErrorCount := COUNT(GROUP,h.concurrent_due_dt_Invalid>0);
    buyer_mail_full_addr_ALLOW_ErrorCount := COUNT(GROUP,h.buyer_mail_full_addr_Invalid=1);
    asses_land_use_CUSTOM_ErrorCount := COUNT(GROUP,h.asses_land_use_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ln_filedate_Invalid > 0 OR h.fips_cd_Invalid > 0 OR h.prop_full_addr_Invalid > 0 OR h.prop_addr_city_Invalid > 0 OR h.prop_addr_state_Invalid > 0 OR h.prop_addr_zip5_Invalid > 0 OR h.prop_addr_zip4_Invalid > 0 OR h.recording_date_Invalid > 0 OR h.doc_type_cd_Invalid > 0 OR h.apn_Invalid > 0 OR h.seller1_fname_Invalid > 0 OR h.seller1_lname_Invalid > 0 OR h.seller2_fname_Invalid > 0 OR h.seller2_lname_Invalid > 0 OR h.buyer1_fname_Invalid > 0 OR h.buyer1_lname_Invalid > 0 OR h.buyer2_fname_Invalid > 0 OR h.buyer2_lname_Invalid > 0 OR h.buyer_mail_city_Invalid > 0 OR h.buyer_mail_state_Invalid > 0 OR h.buyer_mail_zip5_Invalid > 0 OR h.buyer_mail_zip4_Invalid > 0 OR h.property_use_cd_Invalid > 0 OR h.orig_contract_date_Invalid > 0 OR h.concurrent_lender_type_Invalid > 0 OR h.concurrent_loan_type_Invalid > 0 OR h.concurrent_due_dt_Invalid > 0 OR h.buyer_mail_full_addr_Invalid > 0 OR h.asses_land_use_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ln_filedate_Total_ErrorCount > 0, 1, 0) + IF(le.fips_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_full_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_state_Total_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.recording_date_Total_ErrorCount > 0, 1, 0) + IF(le.doc_type_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller1_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller1_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller2_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller2_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer1_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer1_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer2_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer2_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_state_Total_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.property_use_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_contract_date_Total_ErrorCount > 0, 1, 0) + IF(le.concurrent_lender_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.concurrent_loan_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.concurrent_due_dt_Total_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_full_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.asses_land_use_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ln_filedate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_filedate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_full_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.recording_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recording_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.doc_type_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller1_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller1_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller2_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller2_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer1_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer1_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer2_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer2_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.property_use_cd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_contract_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_contract_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.concurrent_lender_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.concurrent_loan_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.concurrent_due_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.concurrent_due_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.buyer_mail_full_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.asses_land_use_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ln_filedate_Invalid,le.fips_cd_Invalid,le.prop_full_addr_Invalid,le.prop_addr_city_Invalid,le.prop_addr_state_Invalid,le.prop_addr_zip5_Invalid,le.prop_addr_zip4_Invalid,le.recording_date_Invalid,le.doc_type_cd_Invalid,le.apn_Invalid,le.seller1_fname_Invalid,le.seller1_lname_Invalid,le.seller2_fname_Invalid,le.seller2_lname_Invalid,le.buyer1_fname_Invalid,le.buyer1_lname_Invalid,le.buyer2_fname_Invalid,le.buyer2_lname_Invalid,le.buyer_mail_city_Invalid,le.buyer_mail_state_Invalid,le.buyer_mail_zip5_Invalid,le.buyer_mail_zip4_Invalid,le.property_use_cd_Invalid,le.orig_contract_date_Invalid,le.concurrent_lender_type_Invalid,le.concurrent_loan_type_Invalid,le.concurrent_due_dt_Invalid,le.buyer_mail_full_addr_Invalid,le.asses_land_use_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ln_filedate(le.ln_filedate_Invalid),Fields.InvalidMessage_fips_cd(le.fips_cd_Invalid),Fields.InvalidMessage_prop_full_addr(le.prop_full_addr_Invalid),Fields.InvalidMessage_prop_addr_city(le.prop_addr_city_Invalid),Fields.InvalidMessage_prop_addr_state(le.prop_addr_state_Invalid),Fields.InvalidMessage_prop_addr_zip5(le.prop_addr_zip5_Invalid),Fields.InvalidMessage_prop_addr_zip4(le.prop_addr_zip4_Invalid),Fields.InvalidMessage_recording_date(le.recording_date_Invalid),Fields.InvalidMessage_doc_type_cd(le.doc_type_cd_Invalid),Fields.InvalidMessage_apn(le.apn_Invalid),Fields.InvalidMessage_seller1_fname(le.seller1_fname_Invalid),Fields.InvalidMessage_seller1_lname(le.seller1_lname_Invalid),Fields.InvalidMessage_seller2_fname(le.seller2_fname_Invalid),Fields.InvalidMessage_seller2_lname(le.seller2_lname_Invalid),Fields.InvalidMessage_buyer1_fname(le.buyer1_fname_Invalid),Fields.InvalidMessage_buyer1_lname(le.buyer1_lname_Invalid),Fields.InvalidMessage_buyer2_fname(le.buyer2_fname_Invalid),Fields.InvalidMessage_buyer2_lname(le.buyer2_lname_Invalid),Fields.InvalidMessage_buyer_mail_city(le.buyer_mail_city_Invalid),Fields.InvalidMessage_buyer_mail_state(le.buyer_mail_state_Invalid),Fields.InvalidMessage_buyer_mail_zip5(le.buyer_mail_zip5_Invalid),Fields.InvalidMessage_buyer_mail_zip4(le.buyer_mail_zip4_Invalid),Fields.InvalidMessage_property_use_cd(le.property_use_cd_Invalid),Fields.InvalidMessage_orig_contract_date(le.orig_contract_date_Invalid),Fields.InvalidMessage_concurrent_lender_type(le.concurrent_lender_type_Invalid),Fields.InvalidMessage_concurrent_loan_type(le.concurrent_loan_type_Invalid),Fields.InvalidMessage_concurrent_due_dt(le.concurrent_due_dt_Invalid),Fields.InvalidMessage_buyer_mail_full_addr(le.buyer_mail_full_addr_Invalid),Fields.InvalidMessage_asses_land_use(le.asses_land_use_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ln_filedate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fips_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prop_full_addr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prop_addr_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prop_addr_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prop_addr_zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prop_addr_zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.recording_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.doc_type_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.apn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seller1_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seller1_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seller2_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seller2_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.buyer1_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.buyer1_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.buyer2_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.buyer2_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.buyer_mail_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.buyer_mail_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.buyer_mail_zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.buyer_mail_zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.property_use_cd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_contract_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.concurrent_lender_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.concurrent_loan_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.concurrent_due_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.buyer_mail_full_addr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.asses_land_use_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ln_filedate','fips_cd','prop_full_addr','prop_addr_city','prop_addr_state','prop_addr_zip5','prop_addr_zip4','recording_date','doc_type_cd','apn','seller1_fname','seller1_lname','seller2_fname','seller2_lname','buyer1_fname','buyer1_lname','buyer2_fname','buyer2_lname','buyer_mail_city','buyer_mail_state','buyer_mail_zip5','buyer_mail_zip4','property_use_cd','orig_contract_date','concurrent_lender_type','concurrent_loan_type','concurrent_due_dt','buyer_mail_full_addr','asses_land_use','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_number','invalid_addr','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','invalid_date','invalid_document_code','invalid_apn','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','invalid_property_code','invalid_date','invalid_lender_type_code','invalid_loan_type_code','invalid_date','invalid_addr','invalid_land_use_code','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ln_filedate,(SALT311.StrType)le.fips_cd,(SALT311.StrType)le.prop_full_addr,(SALT311.StrType)le.prop_addr_city,(SALT311.StrType)le.prop_addr_state,(SALT311.StrType)le.prop_addr_zip5,(SALT311.StrType)le.prop_addr_zip4,(SALT311.StrType)le.recording_date,(SALT311.StrType)le.doc_type_cd,(SALT311.StrType)le.apn,(SALT311.StrType)le.seller1_fname,(SALT311.StrType)le.seller1_lname,(SALT311.StrType)le.seller2_fname,(SALT311.StrType)le.seller2_lname,(SALT311.StrType)le.buyer1_fname,(SALT311.StrType)le.buyer1_lname,(SALT311.StrType)le.buyer2_fname,(SALT311.StrType)le.buyer2_lname,(SALT311.StrType)le.buyer_mail_city,(SALT311.StrType)le.buyer_mail_state,(SALT311.StrType)le.buyer_mail_zip5,(SALT311.StrType)le.buyer_mail_zip4,(SALT311.StrType)le.property_use_cd,(SALT311.StrType)le.orig_contract_date,(SALT311.StrType)le.concurrent_lender_type,(SALT311.StrType)le.concurrent_loan_type,(SALT311.StrType)le.concurrent_due_dt,(SALT311.StrType)le.buyer_mail_full_addr,(SALT311.StrType)le.asses_land_use,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,29,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_BKForeclosure_Reo) prevDS = DATASET([], Layout_BKForeclosure_Reo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ln_filedate:invalid_date:ALLOW','ln_filedate:invalid_date:LENGTHS'
          ,'fips_cd:invalid_number:ALLOW'
          ,'prop_full_addr:invalid_addr:ALLOW'
          ,'prop_addr_city:invalid_AlphaNum:ALLOW'
          ,'prop_addr_state:invalid_state:ALLOW','prop_addr_state:invalid_state:LENGTHS'
          ,'prop_addr_zip5:invalid_zip:ALLOW','prop_addr_zip5:invalid_zip:LENGTHS'
          ,'prop_addr_zip4:invalid_zip:ALLOW','prop_addr_zip4:invalid_zip:LENGTHS'
          ,'recording_date:invalid_date:ALLOW','recording_date:invalid_date:LENGTHS'
          ,'doc_type_cd:invalid_document_code:CUSTOM'
          ,'apn:invalid_apn:ALLOW'
          ,'seller1_fname:invalid_name:ALLOW'
          ,'seller1_lname:invalid_name:ALLOW'
          ,'seller2_fname:invalid_name:ALLOW'
          ,'seller2_lname:invalid_name:ALLOW'
          ,'buyer1_fname:invalid_name:ALLOW'
          ,'buyer1_lname:invalid_name:ALLOW'
          ,'buyer2_fname:invalid_name:ALLOW'
          ,'buyer2_lname:invalid_name:ALLOW'
          ,'buyer_mail_city:invalid_AlphaNum:ALLOW'
          ,'buyer_mail_state:invalid_state:ALLOW','buyer_mail_state:invalid_state:LENGTHS'
          ,'buyer_mail_zip5:invalid_zip:ALLOW','buyer_mail_zip5:invalid_zip:LENGTHS'
          ,'buyer_mail_zip4:invalid_zip:ALLOW','buyer_mail_zip4:invalid_zip:LENGTHS'
          ,'property_use_cd:invalid_property_code:CUSTOM'
          ,'orig_contract_date:invalid_date:ALLOW','orig_contract_date:invalid_date:LENGTHS'
          ,'concurrent_lender_type:invalid_lender_type_code:CUSTOM'
          ,'concurrent_loan_type:invalid_loan_type_code:CUSTOM'
          ,'concurrent_due_dt:invalid_date:ALLOW','concurrent_due_dt:invalid_date:LENGTHS'
          ,'buyer_mail_full_addr:invalid_addr:ALLOW'
          ,'asses_land_use:invalid_land_use_code:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_ln_filedate(1),Fields.InvalidMessage_ln_filedate(2)
          ,Fields.InvalidMessage_fips_cd(1)
          ,Fields.InvalidMessage_prop_full_addr(1)
          ,Fields.InvalidMessage_prop_addr_city(1)
          ,Fields.InvalidMessage_prop_addr_state(1),Fields.InvalidMessage_prop_addr_state(2)
          ,Fields.InvalidMessage_prop_addr_zip5(1),Fields.InvalidMessage_prop_addr_zip5(2)
          ,Fields.InvalidMessage_prop_addr_zip4(1),Fields.InvalidMessage_prop_addr_zip4(2)
          ,Fields.InvalidMessage_recording_date(1),Fields.InvalidMessage_recording_date(2)
          ,Fields.InvalidMessage_doc_type_cd(1)
          ,Fields.InvalidMessage_apn(1)
          ,Fields.InvalidMessage_seller1_fname(1)
          ,Fields.InvalidMessage_seller1_lname(1)
          ,Fields.InvalidMessage_seller2_fname(1)
          ,Fields.InvalidMessage_seller2_lname(1)
          ,Fields.InvalidMessage_buyer1_fname(1)
          ,Fields.InvalidMessage_buyer1_lname(1)
          ,Fields.InvalidMessage_buyer2_fname(1)
          ,Fields.InvalidMessage_buyer2_lname(1)
          ,Fields.InvalidMessage_buyer_mail_city(1)
          ,Fields.InvalidMessage_buyer_mail_state(1),Fields.InvalidMessage_buyer_mail_state(2)
          ,Fields.InvalidMessage_buyer_mail_zip5(1),Fields.InvalidMessage_buyer_mail_zip5(2)
          ,Fields.InvalidMessage_buyer_mail_zip4(1),Fields.InvalidMessage_buyer_mail_zip4(2)
          ,Fields.InvalidMessage_property_use_cd(1)
          ,Fields.InvalidMessage_orig_contract_date(1),Fields.InvalidMessage_orig_contract_date(2)
          ,Fields.InvalidMessage_concurrent_lender_type(1)
          ,Fields.InvalidMessage_concurrent_loan_type(1)
          ,Fields.InvalidMessage_concurrent_due_dt(1),Fields.InvalidMessage_concurrent_due_dt(2)
          ,Fields.InvalidMessage_buyer_mail_full_addr(1)
          ,Fields.InvalidMessage_asses_land_use(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ln_filedate_ALLOW_ErrorCount,le.ln_filedate_LENGTHS_ErrorCount
          ,le.fips_cd_ALLOW_ErrorCount
          ,le.prop_full_addr_ALLOW_ErrorCount
          ,le.prop_addr_city_ALLOW_ErrorCount
          ,le.prop_addr_state_ALLOW_ErrorCount,le.prop_addr_state_LENGTHS_ErrorCount
          ,le.prop_addr_zip5_ALLOW_ErrorCount,le.prop_addr_zip5_LENGTHS_ErrorCount
          ,le.prop_addr_zip4_ALLOW_ErrorCount,le.prop_addr_zip4_LENGTHS_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_LENGTHS_ErrorCount
          ,le.doc_type_cd_CUSTOM_ErrorCount
          ,le.apn_ALLOW_ErrorCount
          ,le.seller1_fname_ALLOW_ErrorCount
          ,le.seller1_lname_ALLOW_ErrorCount
          ,le.seller2_fname_ALLOW_ErrorCount
          ,le.seller2_lname_ALLOW_ErrorCount
          ,le.buyer1_fname_ALLOW_ErrorCount
          ,le.buyer1_lname_ALLOW_ErrorCount
          ,le.buyer2_fname_ALLOW_ErrorCount
          ,le.buyer2_lname_ALLOW_ErrorCount
          ,le.buyer_mail_city_ALLOW_ErrorCount
          ,le.buyer_mail_state_ALLOW_ErrorCount,le.buyer_mail_state_LENGTHS_ErrorCount
          ,le.buyer_mail_zip5_ALLOW_ErrorCount,le.buyer_mail_zip5_LENGTHS_ErrorCount
          ,le.buyer_mail_zip4_ALLOW_ErrorCount,le.buyer_mail_zip4_LENGTHS_ErrorCount
          ,le.property_use_cd_CUSTOM_ErrorCount
          ,le.orig_contract_date_ALLOW_ErrorCount,le.orig_contract_date_LENGTHS_ErrorCount
          ,le.concurrent_lender_type_CUSTOM_ErrorCount
          ,le.concurrent_loan_type_CUSTOM_ErrorCount
          ,le.concurrent_due_dt_ALLOW_ErrorCount,le.concurrent_due_dt_LENGTHS_ErrorCount
          ,le.buyer_mail_full_addr_ALLOW_ErrorCount
          ,le.asses_land_use_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ln_filedate_ALLOW_ErrorCount,le.ln_filedate_LENGTHS_ErrorCount
          ,le.fips_cd_ALLOW_ErrorCount
          ,le.prop_full_addr_ALLOW_ErrorCount
          ,le.prop_addr_city_ALLOW_ErrorCount
          ,le.prop_addr_state_ALLOW_ErrorCount,le.prop_addr_state_LENGTHS_ErrorCount
          ,le.prop_addr_zip5_ALLOW_ErrorCount,le.prop_addr_zip5_LENGTHS_ErrorCount
          ,le.prop_addr_zip4_ALLOW_ErrorCount,le.prop_addr_zip4_LENGTHS_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_LENGTHS_ErrorCount
          ,le.doc_type_cd_CUSTOM_ErrorCount
          ,le.apn_ALLOW_ErrorCount
          ,le.seller1_fname_ALLOW_ErrorCount
          ,le.seller1_lname_ALLOW_ErrorCount
          ,le.seller2_fname_ALLOW_ErrorCount
          ,le.seller2_lname_ALLOW_ErrorCount
          ,le.buyer1_fname_ALLOW_ErrorCount
          ,le.buyer1_lname_ALLOW_ErrorCount
          ,le.buyer2_fname_ALLOW_ErrorCount
          ,le.buyer2_lname_ALLOW_ErrorCount
          ,le.buyer_mail_city_ALLOW_ErrorCount
          ,le.buyer_mail_state_ALLOW_ErrorCount,le.buyer_mail_state_LENGTHS_ErrorCount
          ,le.buyer_mail_zip5_ALLOW_ErrorCount,le.buyer_mail_zip5_LENGTHS_ErrorCount
          ,le.buyer_mail_zip4_ALLOW_ErrorCount,le.buyer_mail_zip4_LENGTHS_ErrorCount
          ,le.property_use_cd_CUSTOM_ErrorCount
          ,le.orig_contract_date_ALLOW_ErrorCount,le.orig_contract_date_LENGTHS_ErrorCount
          ,le.concurrent_lender_type_CUSTOM_ErrorCount
          ,le.concurrent_loan_type_CUSTOM_ErrorCount
          ,le.concurrent_due_dt_ALLOW_ErrorCount,le.concurrent_due_dt_LENGTHS_ErrorCount
          ,le.buyer_mail_full_addr_ALLOW_ErrorCount
          ,le.asses_land_use_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_BKForeclosure_Reo));
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
          ,'foreclosure_id:' + getFieldTypeText(h.foreclosure_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_filedate:' + getFieldTypeText(h.ln_filedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bk_infile_type:' + getFieldTypeText(h.bk_infile_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_cd:' + getFieldTypeText(h.fips_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_full_addr:' + getFieldTypeText(h.prop_full_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_city:' + getFieldTypeText(h.prop_addr_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_state:' + getFieldTypeText(h.prop_addr_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_zip5:' + getFieldTypeText(h.prop_addr_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_zip4:' + getFieldTypeText(h.prop_addr_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_unit_type:' + getFieldTypeText(h.prop_addr_unit_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_unit_no:' + getFieldTypeText(h.prop_addr_unit_no) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_house_no:' + getFieldTypeText(h.prop_addr_house_no) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_predir:' + getFieldTypeText(h.prop_addr_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_street:' + getFieldTypeText(h.prop_addr_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_suffix:' + getFieldTypeText(h.prop_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_postdir:' + getFieldTypeText(h.prop_addr_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_carrier_rt:' + getFieldTypeText(h.prop_addr_carrier_rt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_date:' + getFieldTypeText(h.recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_book_num:' + getFieldTypeText(h.recording_book_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_page_num:' + getFieldTypeText(h.recording_page_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_doc_num:' + getFieldTypeText(h.recording_doc_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_type_cd:' + getFieldTypeText(h.doc_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apn:' + getFieldTypeText(h.apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'multi_apn:' + getFieldTypeText(h.multi_apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'partial_interest_trans:' + getFieldTypeText(h.partial_interest_trans) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller1_fname:' + getFieldTypeText(h.seller1_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller1_lname:' + getFieldTypeText(h.seller1_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller1_id:' + getFieldTypeText(h.seller1_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller2_fname:' + getFieldTypeText(h.seller2_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller2_lname:' + getFieldTypeText(h.seller2_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer1_fname:' + getFieldTypeText(h.buyer1_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer1_lname:' + getFieldTypeText(h.buyer1_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer1_id_cd:' + getFieldTypeText(h.buyer1_id_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer2_fname:' + getFieldTypeText(h.buyer2_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer2_lname:' + getFieldTypeText(h.buyer2_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer_vesting_cd:' + getFieldTypeText(h.buyer_vesting_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'concurrent_doc_num:' + getFieldTypeText(h.concurrent_doc_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer_mail_city:' + getFieldTypeText(h.buyer_mail_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer_mail_state:' + getFieldTypeText(h.buyer_mail_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer_mail_zip5:' + getFieldTypeText(h.buyer_mail_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer_mail_zip4:' + getFieldTypeText(h.buyer_mail_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_lot_cd:' + getFieldTypeText(h.legal_lot_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_lot_num:' + getFieldTypeText(h.legal_lot_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_block:' + getFieldTypeText(h.legal_block) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_section:' + getFieldTypeText(h.legal_section) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_district:' + getFieldTypeText(h.legal_district) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_land_lot:' + getFieldTypeText(h.legal_land_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_unit:' + getFieldTypeText(h.legal_unit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legacl_city:' + getFieldTypeText(h.legacl_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_subdivision:' + getFieldTypeText(h.legal_subdivision) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_phase_num:' + getFieldTypeText(h.legal_phase_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_tract_num:' + getFieldTypeText(h.legal_tract_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_brief_desc:' + getFieldTypeText(h.legal_brief_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_township:' + getFieldTypeText(h.legal_township) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recorder_map_ref:' + getFieldTypeText(h.recorder_map_ref) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_buyer_mail_addr_cd:' + getFieldTypeText(h.prop_buyer_mail_addr_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_use_cd:' + getFieldTypeText(h.property_use_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_contract_date:' + getFieldTypeText(h.orig_contract_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sales_price:' + getFieldTypeText(h.sales_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sales_price_cd:' + getFieldTypeText(h.sales_price_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_xfer_tax:' + getFieldTypeText(h.city_xfer_tax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_xfer_tax:' + getFieldTypeText(h.county_xfer_tax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_xfer_tax:' + getFieldTypeText(h.total_xfer_tax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'concurrent_lender_name:' + getFieldTypeText(h.concurrent_lender_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'concurrent_lender_type:' + getFieldTypeText(h.concurrent_lender_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'concurrent_loan_amt:' + getFieldTypeText(h.concurrent_loan_amt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'concurrent_loan_type:' + getFieldTypeText(h.concurrent_loan_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'concurrent_type_fin:' + getFieldTypeText(h.concurrent_type_fin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'concurrent_interest_rate:' + getFieldTypeText(h.concurrent_interest_rate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'concurrent_due_dt:' + getFieldTypeText(h.concurrent_due_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'concurrent_2nd_loan_amt:' + getFieldTypeText(h.concurrent_2nd_loan_amt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer_mail_full_addr:' + getFieldTypeText(h.buyer_mail_full_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer_mail_unit_type:' + getFieldTypeText(h.buyer_mail_unit_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer_mail_unit_no:' + getFieldTypeText(h.buyer_mail_unit_no) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lps_internal_pid:' + getFieldTypeText(h.lps_internal_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer_mail_careof:' + getFieldTypeText(h.buyer_mail_careof) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title_co_name:' + getFieldTypeText(h.title_co_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_desc_cd:' + getFieldTypeText(h.legal_desc_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'adj_rate_rider:' + getFieldTypeText(h.adj_rate_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'adj_rate_index:' + getFieldTypeText(h.adj_rate_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'change_index:' + getFieldTypeText(h.change_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rate_change_freq:' + getFieldTypeText(h.rate_change_freq) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'int_rate_ngt:' + getFieldTypeText(h.int_rate_ngt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'int_rate_nlt:' + getFieldTypeText(h.int_rate_nlt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'max_int_rate:' + getFieldTypeText(h.max_int_rate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'int_only_period:' + getFieldTypeText(h.int_only_period) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fixed_rate_rider:' + getFieldTypeText(h.fixed_rate_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_chg_dt_yy:' + getFieldTypeText(h.first_chg_dt_yy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_chg_dt_mmdd:' + getFieldTypeText(h.first_chg_dt_mmdd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prepayment_rider:' + getFieldTypeText(h.prepayment_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prepayment_term:' + getFieldTypeText(h.prepayment_term) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'asses_land_use:' + getFieldTypeText(h.asses_land_use) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_indicator:' + getFieldTypeText(h.res_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'construction_loan:' + getFieldTypeText(h.construction_loan) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inter_family:' + getFieldTypeText(h.inter_family) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cash_purchase:' + getFieldTypeText(h.cash_purchase) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stand_alone_refi:' + getFieldTypeText(h.stand_alone_refi) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'equity_credit_line:' + getFieldTypeText(h.equity_credit_line) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reo_flag:' + getFieldTypeText(h.reo_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'distressedsaleflag:' + getFieldTypeText(h.distressedsaleflag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_foreclosure_id_cnt
          ,le.populated_ln_filedate_cnt
          ,le.populated_bk_infile_type_cnt
          ,le.populated_fips_cd_cnt
          ,le.populated_prop_full_addr_cnt
          ,le.populated_prop_addr_city_cnt
          ,le.populated_prop_addr_state_cnt
          ,le.populated_prop_addr_zip5_cnt
          ,le.populated_prop_addr_zip4_cnt
          ,le.populated_prop_addr_unit_type_cnt
          ,le.populated_prop_addr_unit_no_cnt
          ,le.populated_prop_addr_house_no_cnt
          ,le.populated_prop_addr_predir_cnt
          ,le.populated_prop_addr_street_cnt
          ,le.populated_prop_addr_suffix_cnt
          ,le.populated_prop_addr_postdir_cnt
          ,le.populated_prop_addr_carrier_rt_cnt
          ,le.populated_recording_date_cnt
          ,le.populated_recording_book_num_cnt
          ,le.populated_recording_page_num_cnt
          ,le.populated_recording_doc_num_cnt
          ,le.populated_doc_type_cd_cnt
          ,le.populated_apn_cnt
          ,le.populated_multi_apn_cnt
          ,le.populated_partial_interest_trans_cnt
          ,le.populated_seller1_fname_cnt
          ,le.populated_seller1_lname_cnt
          ,le.populated_seller1_id_cnt
          ,le.populated_seller2_fname_cnt
          ,le.populated_seller2_lname_cnt
          ,le.populated_buyer1_fname_cnt
          ,le.populated_buyer1_lname_cnt
          ,le.populated_buyer1_id_cd_cnt
          ,le.populated_buyer2_fname_cnt
          ,le.populated_buyer2_lname_cnt
          ,le.populated_buyer_vesting_cd_cnt
          ,le.populated_concurrent_doc_num_cnt
          ,le.populated_buyer_mail_city_cnt
          ,le.populated_buyer_mail_state_cnt
          ,le.populated_buyer_mail_zip5_cnt
          ,le.populated_buyer_mail_zip4_cnt
          ,le.populated_legal_lot_cd_cnt
          ,le.populated_legal_lot_num_cnt
          ,le.populated_legal_block_cnt
          ,le.populated_legal_section_cnt
          ,le.populated_legal_district_cnt
          ,le.populated_legal_land_lot_cnt
          ,le.populated_legal_unit_cnt
          ,le.populated_legacl_city_cnt
          ,le.populated_legal_subdivision_cnt
          ,le.populated_legal_phase_num_cnt
          ,le.populated_legal_tract_num_cnt
          ,le.populated_legal_brief_desc_cnt
          ,le.populated_legal_township_cnt
          ,le.populated_recorder_map_ref_cnt
          ,le.populated_prop_buyer_mail_addr_cd_cnt
          ,le.populated_property_use_cd_cnt
          ,le.populated_orig_contract_date_cnt
          ,le.populated_sales_price_cnt
          ,le.populated_sales_price_cd_cnt
          ,le.populated_city_xfer_tax_cnt
          ,le.populated_county_xfer_tax_cnt
          ,le.populated_total_xfer_tax_cnt
          ,le.populated_concurrent_lender_name_cnt
          ,le.populated_concurrent_lender_type_cnt
          ,le.populated_concurrent_loan_amt_cnt
          ,le.populated_concurrent_loan_type_cnt
          ,le.populated_concurrent_type_fin_cnt
          ,le.populated_concurrent_interest_rate_cnt
          ,le.populated_concurrent_due_dt_cnt
          ,le.populated_concurrent_2nd_loan_amt_cnt
          ,le.populated_buyer_mail_full_addr_cnt
          ,le.populated_buyer_mail_unit_type_cnt
          ,le.populated_buyer_mail_unit_no_cnt
          ,le.populated_lps_internal_pid_cnt
          ,le.populated_buyer_mail_careof_cnt
          ,le.populated_title_co_name_cnt
          ,le.populated_legal_desc_cd_cnt
          ,le.populated_adj_rate_rider_cnt
          ,le.populated_adj_rate_index_cnt
          ,le.populated_change_index_cnt
          ,le.populated_rate_change_freq_cnt
          ,le.populated_int_rate_ngt_cnt
          ,le.populated_int_rate_nlt_cnt
          ,le.populated_max_int_rate_cnt
          ,le.populated_int_only_period_cnt
          ,le.populated_fixed_rate_rider_cnt
          ,le.populated_first_chg_dt_yy_cnt
          ,le.populated_first_chg_dt_mmdd_cnt
          ,le.populated_prepayment_rider_cnt
          ,le.populated_prepayment_term_cnt
          ,le.populated_asses_land_use_cnt
          ,le.populated_res_indicator_cnt
          ,le.populated_construction_loan_cnt
          ,le.populated_inter_family_cnt
          ,le.populated_cash_purchase_cnt
          ,le.populated_stand_alone_refi_cnt
          ,le.populated_equity_credit_line_cnt
          ,le.populated_reo_flag_cnt
          ,le.populated_distressedsaleflag_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_foreclosure_id_pcnt
          ,le.populated_ln_filedate_pcnt
          ,le.populated_bk_infile_type_pcnt
          ,le.populated_fips_cd_pcnt
          ,le.populated_prop_full_addr_pcnt
          ,le.populated_prop_addr_city_pcnt
          ,le.populated_prop_addr_state_pcnt
          ,le.populated_prop_addr_zip5_pcnt
          ,le.populated_prop_addr_zip4_pcnt
          ,le.populated_prop_addr_unit_type_pcnt
          ,le.populated_prop_addr_unit_no_pcnt
          ,le.populated_prop_addr_house_no_pcnt
          ,le.populated_prop_addr_predir_pcnt
          ,le.populated_prop_addr_street_pcnt
          ,le.populated_prop_addr_suffix_pcnt
          ,le.populated_prop_addr_postdir_pcnt
          ,le.populated_prop_addr_carrier_rt_pcnt
          ,le.populated_recording_date_pcnt
          ,le.populated_recording_book_num_pcnt
          ,le.populated_recording_page_num_pcnt
          ,le.populated_recording_doc_num_pcnt
          ,le.populated_doc_type_cd_pcnt
          ,le.populated_apn_pcnt
          ,le.populated_multi_apn_pcnt
          ,le.populated_partial_interest_trans_pcnt
          ,le.populated_seller1_fname_pcnt
          ,le.populated_seller1_lname_pcnt
          ,le.populated_seller1_id_pcnt
          ,le.populated_seller2_fname_pcnt
          ,le.populated_seller2_lname_pcnt
          ,le.populated_buyer1_fname_pcnt
          ,le.populated_buyer1_lname_pcnt
          ,le.populated_buyer1_id_cd_pcnt
          ,le.populated_buyer2_fname_pcnt
          ,le.populated_buyer2_lname_pcnt
          ,le.populated_buyer_vesting_cd_pcnt
          ,le.populated_concurrent_doc_num_pcnt
          ,le.populated_buyer_mail_city_pcnt
          ,le.populated_buyer_mail_state_pcnt
          ,le.populated_buyer_mail_zip5_pcnt
          ,le.populated_buyer_mail_zip4_pcnt
          ,le.populated_legal_lot_cd_pcnt
          ,le.populated_legal_lot_num_pcnt
          ,le.populated_legal_block_pcnt
          ,le.populated_legal_section_pcnt
          ,le.populated_legal_district_pcnt
          ,le.populated_legal_land_lot_pcnt
          ,le.populated_legal_unit_pcnt
          ,le.populated_legacl_city_pcnt
          ,le.populated_legal_subdivision_pcnt
          ,le.populated_legal_phase_num_pcnt
          ,le.populated_legal_tract_num_pcnt
          ,le.populated_legal_brief_desc_pcnt
          ,le.populated_legal_township_pcnt
          ,le.populated_recorder_map_ref_pcnt
          ,le.populated_prop_buyer_mail_addr_cd_pcnt
          ,le.populated_property_use_cd_pcnt
          ,le.populated_orig_contract_date_pcnt
          ,le.populated_sales_price_pcnt
          ,le.populated_sales_price_cd_pcnt
          ,le.populated_city_xfer_tax_pcnt
          ,le.populated_county_xfer_tax_pcnt
          ,le.populated_total_xfer_tax_pcnt
          ,le.populated_concurrent_lender_name_pcnt
          ,le.populated_concurrent_lender_type_pcnt
          ,le.populated_concurrent_loan_amt_pcnt
          ,le.populated_concurrent_loan_type_pcnt
          ,le.populated_concurrent_type_fin_pcnt
          ,le.populated_concurrent_interest_rate_pcnt
          ,le.populated_concurrent_due_dt_pcnt
          ,le.populated_concurrent_2nd_loan_amt_pcnt
          ,le.populated_buyer_mail_full_addr_pcnt
          ,le.populated_buyer_mail_unit_type_pcnt
          ,le.populated_buyer_mail_unit_no_pcnt
          ,le.populated_lps_internal_pid_pcnt
          ,le.populated_buyer_mail_careof_pcnt
          ,le.populated_title_co_name_pcnt
          ,le.populated_legal_desc_cd_pcnt
          ,le.populated_adj_rate_rider_pcnt
          ,le.populated_adj_rate_index_pcnt
          ,le.populated_change_index_pcnt
          ,le.populated_rate_change_freq_pcnt
          ,le.populated_int_rate_ngt_pcnt
          ,le.populated_int_rate_nlt_pcnt
          ,le.populated_max_int_rate_pcnt
          ,le.populated_int_only_period_pcnt
          ,le.populated_fixed_rate_rider_pcnt
          ,le.populated_first_chg_dt_yy_pcnt
          ,le.populated_first_chg_dt_mmdd_pcnt
          ,le.populated_prepayment_rider_pcnt
          ,le.populated_prepayment_term_pcnt
          ,le.populated_asses_land_use_pcnt
          ,le.populated_res_indicator_pcnt
          ,le.populated_construction_loan_pcnt
          ,le.populated_inter_family_pcnt
          ,le.populated_cash_purchase_pcnt
          ,le.populated_stand_alone_refi_pcnt
          ,le.populated_equity_credit_line_pcnt
          ,le.populated_reo_flag_pcnt
          ,le.populated_distressedsaleflag_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,100,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_BKForeclosure_Reo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),100,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_BKForeclosure_Reo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_BKForeclosure_Reo, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
