IMPORT SALT311,STD;
IMPORT Scrubs_BKForeclosure_Nod; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 59;
  EXPORT NumRulesFromFieldType := 59;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 41;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_BKForeclosure_Nod)
    UNSIGNED1 ln_filedate_Invalid;
    UNSIGNED1 src_state_Invalid;
    UNSIGNED1 fips_cd_Invalid;
    UNSIGNED1 doc_type_Invalid;
    UNSIGNED1 recording_dt_Invalid;
    UNSIGNED1 case_number_Invalid;
    UNSIGNED1 orig_contract_date_Invalid;
    UNSIGNED1 as_of_dt_Invalid;
    UNSIGNED1 contact_fname_Invalid;
    UNSIGNED1 contact_lname_Invalid;
    UNSIGNED1 contact_mail_full_addr_Invalid;
    UNSIGNED1 contact_mail_city_Invalid;
    UNSIGNED1 contact_mail_state_Invalid;
    UNSIGNED1 contact_mail_zip5_Invalid;
    UNSIGNED1 contact_mail_zip4_Invalid;
    UNSIGNED1 due_date_Invalid;
    UNSIGNED1 trustee_fname_Invalid;
    UNSIGNED1 trustee_lname_Invalid;
    UNSIGNED1 trustee_mail_full_addr_Invalid;
    UNSIGNED1 trustee_mail_city_Invalid;
    UNSIGNED1 trustee_mail_state_Invalid;
    UNSIGNED1 trustee_mail_zip5_Invalid;
    UNSIGNED1 trustee_mail_zip4_Invalid;
    UNSIGNED1 borrower1_fname_Invalid;
    UNSIGNED1 borrower1_lname_Invalid;
    UNSIGNED1 borrower2_fname_Invalid;
    UNSIGNED1 borrower2_lname_Invalid;
    UNSIGNED1 orig_lender_name_Invalid;
    UNSIGNED1 mers_indicator_Invalid;
    UNSIGNED1 loan_recording_date_Invalid;
    UNSIGNED1 orig_loan_amt_Invalid;
    UNSIGNED1 legal_subdivision_name_Invalid;
    UNSIGNED1 auction_date_Invalid;
    UNSIGNED1 original_nod_recording_date_Invalid;
    UNSIGNED1 property_full_addr_Invalid;
    UNSIGNED1 prop_addr_city_Invalid;
    UNSIGNED1 prop_addr_state_Invalid;
    UNSIGNED1 prop_addr_zip5_Invalid;
    UNSIGNED1 prop_addr_zip4_Invalid;
    UNSIGNED1 apn_Invalid;
    UNSIGNED1 nod_source_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_BKForeclosure_Nod)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_BKForeclosure_Nod) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ln_filedate_Invalid := Fields.InValid_ln_filedate((SALT311.StrType)le.ln_filedate);
    SELF.src_state_Invalid := Fields.InValid_src_state((SALT311.StrType)le.src_state);
    SELF.fips_cd_Invalid := Fields.InValid_fips_cd((SALT311.StrType)le.fips_cd);
    SELF.doc_type_Invalid := Fields.InValid_doc_type((SALT311.StrType)le.doc_type);
    SELF.recording_dt_Invalid := Fields.InValid_recording_dt((SALT311.StrType)le.recording_dt);
    SELF.case_number_Invalid := Fields.InValid_case_number((SALT311.StrType)le.case_number);
    SELF.orig_contract_date_Invalid := Fields.InValid_orig_contract_date((SALT311.StrType)le.orig_contract_date);
    SELF.as_of_dt_Invalid := Fields.InValid_as_of_dt((SALT311.StrType)le.as_of_dt);
    SELF.contact_fname_Invalid := Fields.InValid_contact_fname((SALT311.StrType)le.contact_fname);
    SELF.contact_lname_Invalid := Fields.InValid_contact_lname((SALT311.StrType)le.contact_lname);
    SELF.contact_mail_full_addr_Invalid := Fields.InValid_contact_mail_full_addr((SALT311.StrType)le.contact_mail_full_addr);
    SELF.contact_mail_city_Invalid := Fields.InValid_contact_mail_city((SALT311.StrType)le.contact_mail_city);
    SELF.contact_mail_state_Invalid := Fields.InValid_contact_mail_state((SALT311.StrType)le.contact_mail_state);
    SELF.contact_mail_zip5_Invalid := Fields.InValid_contact_mail_zip5((SALT311.StrType)le.contact_mail_zip5);
    SELF.contact_mail_zip4_Invalid := Fields.InValid_contact_mail_zip4((SALT311.StrType)le.contact_mail_zip4);
    SELF.due_date_Invalid := Fields.InValid_due_date((SALT311.StrType)le.due_date);
    SELF.trustee_fname_Invalid := Fields.InValid_trustee_fname((SALT311.StrType)le.trustee_fname);
    SELF.trustee_lname_Invalid := Fields.InValid_trustee_lname((SALT311.StrType)le.trustee_lname);
    SELF.trustee_mail_full_addr_Invalid := Fields.InValid_trustee_mail_full_addr((SALT311.StrType)le.trustee_mail_full_addr);
    SELF.trustee_mail_city_Invalid := Fields.InValid_trustee_mail_city((SALT311.StrType)le.trustee_mail_city);
    SELF.trustee_mail_state_Invalid := Fields.InValid_trustee_mail_state((SALT311.StrType)le.trustee_mail_state);
    SELF.trustee_mail_zip5_Invalid := Fields.InValid_trustee_mail_zip5((SALT311.StrType)le.trustee_mail_zip5);
    SELF.trustee_mail_zip4_Invalid := Fields.InValid_trustee_mail_zip4((SALT311.StrType)le.trustee_mail_zip4);
    SELF.borrower1_fname_Invalid := Fields.InValid_borrower1_fname((SALT311.StrType)le.borrower1_fname);
    SELF.borrower1_lname_Invalid := Fields.InValid_borrower1_lname((SALT311.StrType)le.borrower1_lname);
    SELF.borrower2_fname_Invalid := Fields.InValid_borrower2_fname((SALT311.StrType)le.borrower2_fname);
    SELF.borrower2_lname_Invalid := Fields.InValid_borrower2_lname((SALT311.StrType)le.borrower2_lname);
    SELF.orig_lender_name_Invalid := Fields.InValid_orig_lender_name((SALT311.StrType)le.orig_lender_name);
    SELF.mers_indicator_Invalid := Fields.InValid_mers_indicator((SALT311.StrType)le.mers_indicator);
    SELF.loan_recording_date_Invalid := Fields.InValid_loan_recording_date((SALT311.StrType)le.loan_recording_date);
    SELF.orig_loan_amt_Invalid := Fields.InValid_orig_loan_amt((SALT311.StrType)le.orig_loan_amt);
    SELF.legal_subdivision_name_Invalid := Fields.InValid_legal_subdivision_name((SALT311.StrType)le.legal_subdivision_name);
    SELF.auction_date_Invalid := Fields.InValid_auction_date((SALT311.StrType)le.auction_date);
    SELF.original_nod_recording_date_Invalid := Fields.InValid_original_nod_recording_date((SALT311.StrType)le.original_nod_recording_date);
    SELF.property_full_addr_Invalid := Fields.InValid_property_full_addr((SALT311.StrType)le.property_full_addr);
    SELF.prop_addr_city_Invalid := Fields.InValid_prop_addr_city((SALT311.StrType)le.prop_addr_city);
    SELF.prop_addr_state_Invalid := Fields.InValid_prop_addr_state((SALT311.StrType)le.prop_addr_state);
    SELF.prop_addr_zip5_Invalid := Fields.InValid_prop_addr_zip5((SALT311.StrType)le.prop_addr_zip5);
    SELF.prop_addr_zip4_Invalid := Fields.InValid_prop_addr_zip4((SALT311.StrType)le.prop_addr_zip4);
    SELF.apn_Invalid := Fields.InValid_apn((SALT311.StrType)le.apn);
    SELF.nod_source_Invalid := Fields.InValid_nod_source((SALT311.StrType)le.nod_source);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_BKForeclosure_Nod);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ln_filedate_Invalid << 0 ) + ( le.src_state_Invalid << 2 ) + ( le.fips_cd_Invalid << 4 ) + ( le.doc_type_Invalid << 5 ) + ( le.recording_dt_Invalid << 6 ) + ( le.case_number_Invalid << 8 ) + ( le.orig_contract_date_Invalid << 9 ) + ( le.as_of_dt_Invalid << 11 ) + ( le.contact_fname_Invalid << 13 ) + ( le.contact_lname_Invalid << 14 ) + ( le.contact_mail_full_addr_Invalid << 15 ) + ( le.contact_mail_city_Invalid << 16 ) + ( le.contact_mail_state_Invalid << 17 ) + ( le.contact_mail_zip5_Invalid << 19 ) + ( le.contact_mail_zip4_Invalid << 21 ) + ( le.due_date_Invalid << 23 ) + ( le.trustee_fname_Invalid << 25 ) + ( le.trustee_lname_Invalid << 26 ) + ( le.trustee_mail_full_addr_Invalid << 27 ) + ( le.trustee_mail_city_Invalid << 28 ) + ( le.trustee_mail_state_Invalid << 29 ) + ( le.trustee_mail_zip5_Invalid << 31 ) + ( le.trustee_mail_zip4_Invalid << 33 ) + ( le.borrower1_fname_Invalid << 35 ) + ( le.borrower1_lname_Invalid << 36 ) + ( le.borrower2_fname_Invalid << 37 ) + ( le.borrower2_lname_Invalid << 38 ) + ( le.orig_lender_name_Invalid << 39 ) + ( le.mers_indicator_Invalid << 40 ) + ( le.loan_recording_date_Invalid << 41 ) + ( le.orig_loan_amt_Invalid << 43 ) + ( le.legal_subdivision_name_Invalid << 44 ) + ( le.auction_date_Invalid << 45 ) + ( le.original_nod_recording_date_Invalid << 47 ) + ( le.property_full_addr_Invalid << 49 ) + ( le.prop_addr_city_Invalid << 50 ) + ( le.prop_addr_state_Invalid << 51 ) + ( le.prop_addr_zip5_Invalid << 53 ) + ( le.prop_addr_zip4_Invalid << 55 ) + ( le.apn_Invalid << 57 ) + ( le.nod_source_Invalid << 58 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_BKForeclosure_Nod);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ln_filedate_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.src_state_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.fips_cd_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.doc_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.recording_dt_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.case_number_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_contract_date_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.as_of_dt_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.contact_fname_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.contact_lname_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.contact_mail_full_addr_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.contact_mail_city_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.contact_mail_state_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.contact_mail_zip5_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.contact_mail_zip4_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.due_date_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.trustee_fname_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.trustee_lname_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.trustee_mail_full_addr_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.trustee_mail_city_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.trustee_mail_state_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.trustee_mail_zip5_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.trustee_mail_zip4_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.borrower1_fname_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.borrower1_lname_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.borrower2_fname_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.borrower2_lname_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.orig_lender_name_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.mers_indicator_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.loan_recording_date_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.orig_loan_amt_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.legal_subdivision_name_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.auction_date_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.original_nod_recording_date_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.property_full_addr_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.prop_addr_city_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.prop_addr_state_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.prop_addr_zip5_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.prop_addr_zip4_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.apn_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.nod_source_Invalid := (le.ScrubsBits1 >> 58) & 1;
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
    src_state_ALLOW_ErrorCount := COUNT(GROUP,h.src_state_Invalid=1);
    src_state_LENGTHS_ErrorCount := COUNT(GROUP,h.src_state_Invalid=2);
    src_state_Total_ErrorCount := COUNT(GROUP,h.src_state_Invalid>0);
    fips_cd_ALLOW_ErrorCount := COUNT(GROUP,h.fips_cd_Invalid=1);
    doc_type_CUSTOM_ErrorCount := COUNT(GROUP,h.doc_type_Invalid=1);
    recording_dt_ALLOW_ErrorCount := COUNT(GROUP,h.recording_dt_Invalid=1);
    recording_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.recording_dt_Invalid=2);
    recording_dt_Total_ErrorCount := COUNT(GROUP,h.recording_dt_Invalid>0);
    case_number_ALLOW_ErrorCount := COUNT(GROUP,h.case_number_Invalid=1);
    orig_contract_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_contract_date_Invalid=1);
    orig_contract_date_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_contract_date_Invalid=2);
    orig_contract_date_Total_ErrorCount := COUNT(GROUP,h.orig_contract_date_Invalid>0);
    as_of_dt_ALLOW_ErrorCount := COUNT(GROUP,h.as_of_dt_Invalid=1);
    as_of_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.as_of_dt_Invalid=2);
    as_of_dt_Total_ErrorCount := COUNT(GROUP,h.as_of_dt_Invalid>0);
    contact_fname_ALLOW_ErrorCount := COUNT(GROUP,h.contact_fname_Invalid=1);
    contact_lname_ALLOW_ErrorCount := COUNT(GROUP,h.contact_lname_Invalid=1);
    contact_mail_full_addr_ALLOW_ErrorCount := COUNT(GROUP,h.contact_mail_full_addr_Invalid=1);
    contact_mail_city_ALLOW_ErrorCount := COUNT(GROUP,h.contact_mail_city_Invalid=1);
    contact_mail_state_ALLOW_ErrorCount := COUNT(GROUP,h.contact_mail_state_Invalid=1);
    contact_mail_state_LENGTHS_ErrorCount := COUNT(GROUP,h.contact_mail_state_Invalid=2);
    contact_mail_state_Total_ErrorCount := COUNT(GROUP,h.contact_mail_state_Invalid>0);
    contact_mail_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.contact_mail_zip5_Invalid=1);
    contact_mail_zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.contact_mail_zip5_Invalid=2);
    contact_mail_zip5_Total_ErrorCount := COUNT(GROUP,h.contact_mail_zip5_Invalid>0);
    contact_mail_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.contact_mail_zip4_Invalid=1);
    contact_mail_zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.contact_mail_zip4_Invalid=2);
    contact_mail_zip4_Total_ErrorCount := COUNT(GROUP,h.contact_mail_zip4_Invalid>0);
    due_date_ALLOW_ErrorCount := COUNT(GROUP,h.due_date_Invalid=1);
    due_date_LENGTHS_ErrorCount := COUNT(GROUP,h.due_date_Invalid=2);
    due_date_Total_ErrorCount := COUNT(GROUP,h.due_date_Invalid>0);
    trustee_fname_ALLOW_ErrorCount := COUNT(GROUP,h.trustee_fname_Invalid=1);
    trustee_lname_ALLOW_ErrorCount := COUNT(GROUP,h.trustee_lname_Invalid=1);
    trustee_mail_full_addr_ALLOW_ErrorCount := COUNT(GROUP,h.trustee_mail_full_addr_Invalid=1);
    trustee_mail_city_ALLOW_ErrorCount := COUNT(GROUP,h.trustee_mail_city_Invalid=1);
    trustee_mail_state_ALLOW_ErrorCount := COUNT(GROUP,h.trustee_mail_state_Invalid=1);
    trustee_mail_state_LENGTHS_ErrorCount := COUNT(GROUP,h.trustee_mail_state_Invalid=2);
    trustee_mail_state_Total_ErrorCount := COUNT(GROUP,h.trustee_mail_state_Invalid>0);
    trustee_mail_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.trustee_mail_zip5_Invalid=1);
    trustee_mail_zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.trustee_mail_zip5_Invalid=2);
    trustee_mail_zip5_Total_ErrorCount := COUNT(GROUP,h.trustee_mail_zip5_Invalid>0);
    trustee_mail_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.trustee_mail_zip4_Invalid=1);
    trustee_mail_zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.trustee_mail_zip4_Invalid=2);
    trustee_mail_zip4_Total_ErrorCount := COUNT(GROUP,h.trustee_mail_zip4_Invalid>0);
    borrower1_fname_ALLOW_ErrorCount := COUNT(GROUP,h.borrower1_fname_Invalid=1);
    borrower1_lname_ALLOW_ErrorCount := COUNT(GROUP,h.borrower1_lname_Invalid=1);
    borrower2_fname_ALLOW_ErrorCount := COUNT(GROUP,h.borrower2_fname_Invalid=1);
    borrower2_lname_ALLOW_ErrorCount := COUNT(GROUP,h.borrower2_lname_Invalid=1);
    orig_lender_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lender_name_Invalid=1);
    mers_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.mers_indicator_Invalid=1);
    loan_recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.loan_recording_date_Invalid=1);
    loan_recording_date_LENGTHS_ErrorCount := COUNT(GROUP,h.loan_recording_date_Invalid=2);
    loan_recording_date_Total_ErrorCount := COUNT(GROUP,h.loan_recording_date_Invalid>0);
    orig_loan_amt_ALLOW_ErrorCount := COUNT(GROUP,h.orig_loan_amt_Invalid=1);
    legal_subdivision_name_ALLOW_ErrorCount := COUNT(GROUP,h.legal_subdivision_name_Invalid=1);
    auction_date_ALLOW_ErrorCount := COUNT(GROUP,h.auction_date_Invalid=1);
    auction_date_LENGTHS_ErrorCount := COUNT(GROUP,h.auction_date_Invalid=2);
    auction_date_Total_ErrorCount := COUNT(GROUP,h.auction_date_Invalid>0);
    original_nod_recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.original_nod_recording_date_Invalid=1);
    original_nod_recording_date_LENGTHS_ErrorCount := COUNT(GROUP,h.original_nod_recording_date_Invalid=2);
    original_nod_recording_date_Total_ErrorCount := COUNT(GROUP,h.original_nod_recording_date_Invalid>0);
    property_full_addr_ALLOW_ErrorCount := COUNT(GROUP,h.property_full_addr_Invalid=1);
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
    apn_ALLOW_ErrorCount := COUNT(GROUP,h.apn_Invalid=1);
    nod_source_ENUM_ErrorCount := COUNT(GROUP,h.nod_source_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ln_filedate_Invalid > 0 OR h.src_state_Invalid > 0 OR h.fips_cd_Invalid > 0 OR h.doc_type_Invalid > 0 OR h.recording_dt_Invalid > 0 OR h.case_number_Invalid > 0 OR h.orig_contract_date_Invalid > 0 OR h.as_of_dt_Invalid > 0 OR h.contact_fname_Invalid > 0 OR h.contact_lname_Invalid > 0 OR h.contact_mail_full_addr_Invalid > 0 OR h.contact_mail_city_Invalid > 0 OR h.contact_mail_state_Invalid > 0 OR h.contact_mail_zip5_Invalid > 0 OR h.contact_mail_zip4_Invalid > 0 OR h.due_date_Invalid > 0 OR h.trustee_fname_Invalid > 0 OR h.trustee_lname_Invalid > 0 OR h.trustee_mail_full_addr_Invalid > 0 OR h.trustee_mail_city_Invalid > 0 OR h.trustee_mail_state_Invalid > 0 OR h.trustee_mail_zip5_Invalid > 0 OR h.trustee_mail_zip4_Invalid > 0 OR h.borrower1_fname_Invalid > 0 OR h.borrower1_lname_Invalid > 0 OR h.borrower2_fname_Invalid > 0 OR h.borrower2_lname_Invalid > 0 OR h.orig_lender_name_Invalid > 0 OR h.mers_indicator_Invalid > 0 OR h.loan_recording_date_Invalid > 0 OR h.orig_loan_amt_Invalid > 0 OR h.legal_subdivision_name_Invalid > 0 OR h.auction_date_Invalid > 0 OR h.original_nod_recording_date_Invalid > 0 OR h.property_full_addr_Invalid > 0 OR h.prop_addr_city_Invalid > 0 OR h.prop_addr_state_Invalid > 0 OR h.prop_addr_zip5_Invalid > 0 OR h.prop_addr_zip4_Invalid > 0 OR h.apn_Invalid > 0 OR h.nod_source_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ln_filedate_Total_ErrorCount > 0, 1, 0) + IF(le.src_state_Total_ErrorCount > 0, 1, 0) + IF(le.fips_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.doc_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.recording_dt_Total_ErrorCount > 0, 1, 0) + IF(le.case_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_contract_date_Total_ErrorCount > 0, 1, 0) + IF(le.as_of_dt_Total_ErrorCount > 0, 1, 0) + IF(le.contact_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_mail_full_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_mail_state_Total_ErrorCount > 0, 1, 0) + IF(le.contact_mail_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.contact_mail_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.due_date_Total_ErrorCount > 0, 1, 0) + IF(le.trustee_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_full_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_state_Total_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.borrower1_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrower1_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrower2_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrower2_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lender_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mers_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loan_recording_date_Total_ErrorCount > 0, 1, 0) + IF(le.orig_loan_amt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.legal_subdivision_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.auction_date_Total_ErrorCount > 0, 1, 0) + IF(le.original_nod_recording_date_Total_ErrorCount > 0, 1, 0) + IF(le.property_full_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_state_Total_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nod_source_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ln_filedate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_filedate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.src_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.doc_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.recording_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recording_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.case_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_contract_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_contract_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.as_of_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.as_of_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.contact_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_mail_full_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_mail_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_mail_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.contact_mail_zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_mail_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.contact_mail_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_mail_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.due_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.due_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.trustee_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_full_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trustee_mail_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.borrower1_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrower1_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrower2_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.borrower2_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lender_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mers_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loan_recording_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loan_recording_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_loan_amt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.legal_subdivision_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.auction_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.auction_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.original_nod_recording_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.original_nod_recording_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.property_full_addr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prop_addr_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nod_source_ENUM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ln_filedate_Invalid,le.src_state_Invalid,le.fips_cd_Invalid,le.doc_type_Invalid,le.recording_dt_Invalid,le.case_number_Invalid,le.orig_contract_date_Invalid,le.as_of_dt_Invalid,le.contact_fname_Invalid,le.contact_lname_Invalid,le.contact_mail_full_addr_Invalid,le.contact_mail_city_Invalid,le.contact_mail_state_Invalid,le.contact_mail_zip5_Invalid,le.contact_mail_zip4_Invalid,le.due_date_Invalid,le.trustee_fname_Invalid,le.trustee_lname_Invalid,le.trustee_mail_full_addr_Invalid,le.trustee_mail_city_Invalid,le.trustee_mail_state_Invalid,le.trustee_mail_zip5_Invalid,le.trustee_mail_zip4_Invalid,le.borrower1_fname_Invalid,le.borrower1_lname_Invalid,le.borrower2_fname_Invalid,le.borrower2_lname_Invalid,le.orig_lender_name_Invalid,le.mers_indicator_Invalid,le.loan_recording_date_Invalid,le.orig_loan_amt_Invalid,le.legal_subdivision_name_Invalid,le.auction_date_Invalid,le.original_nod_recording_date_Invalid,le.property_full_addr_Invalid,le.prop_addr_city_Invalid,le.prop_addr_state_Invalid,le.prop_addr_zip5_Invalid,le.prop_addr_zip4_Invalid,le.apn_Invalid,le.nod_source_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ln_filedate(le.ln_filedate_Invalid),Fields.InvalidMessage_src_state(le.src_state_Invalid),Fields.InvalidMessage_fips_cd(le.fips_cd_Invalid),Fields.InvalidMessage_doc_type(le.doc_type_Invalid),Fields.InvalidMessage_recording_dt(le.recording_dt_Invalid),Fields.InvalidMessage_case_number(le.case_number_Invalid),Fields.InvalidMessage_orig_contract_date(le.orig_contract_date_Invalid),Fields.InvalidMessage_as_of_dt(le.as_of_dt_Invalid),Fields.InvalidMessage_contact_fname(le.contact_fname_Invalid),Fields.InvalidMessage_contact_lname(le.contact_lname_Invalid),Fields.InvalidMessage_contact_mail_full_addr(le.contact_mail_full_addr_Invalid),Fields.InvalidMessage_contact_mail_city(le.contact_mail_city_Invalid),Fields.InvalidMessage_contact_mail_state(le.contact_mail_state_Invalid),Fields.InvalidMessage_contact_mail_zip5(le.contact_mail_zip5_Invalid),Fields.InvalidMessage_contact_mail_zip4(le.contact_mail_zip4_Invalid),Fields.InvalidMessage_due_date(le.due_date_Invalid),Fields.InvalidMessage_trustee_fname(le.trustee_fname_Invalid),Fields.InvalidMessage_trustee_lname(le.trustee_lname_Invalid),Fields.InvalidMessage_trustee_mail_full_addr(le.trustee_mail_full_addr_Invalid),Fields.InvalidMessage_trustee_mail_city(le.trustee_mail_city_Invalid),Fields.InvalidMessage_trustee_mail_state(le.trustee_mail_state_Invalid),Fields.InvalidMessage_trustee_mail_zip5(le.trustee_mail_zip5_Invalid),Fields.InvalidMessage_trustee_mail_zip4(le.trustee_mail_zip4_Invalid),Fields.InvalidMessage_borrower1_fname(le.borrower1_fname_Invalid),Fields.InvalidMessage_borrower1_lname(le.borrower1_lname_Invalid),Fields.InvalidMessage_borrower2_fname(le.borrower2_fname_Invalid),Fields.InvalidMessage_borrower2_lname(le.borrower2_lname_Invalid),Fields.InvalidMessage_orig_lender_name(le.orig_lender_name_Invalid),Fields.InvalidMessage_mers_indicator(le.mers_indicator_Invalid),Fields.InvalidMessage_loan_recording_date(le.loan_recording_date_Invalid),Fields.InvalidMessage_orig_loan_amt(le.orig_loan_amt_Invalid),Fields.InvalidMessage_legal_subdivision_name(le.legal_subdivision_name_Invalid),Fields.InvalidMessage_auction_date(le.auction_date_Invalid),Fields.InvalidMessage_original_nod_recording_date(le.original_nod_recording_date_Invalid),Fields.InvalidMessage_property_full_addr(le.property_full_addr_Invalid),Fields.InvalidMessage_prop_addr_city(le.prop_addr_city_Invalid),Fields.InvalidMessage_prop_addr_state(le.prop_addr_state_Invalid),Fields.InvalidMessage_prop_addr_zip5(le.prop_addr_zip5_Invalid),Fields.InvalidMessage_prop_addr_zip4(le.prop_addr_zip4_Invalid),Fields.InvalidMessage_apn(le.apn_Invalid),Fields.InvalidMessage_nod_source(le.nod_source_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ln_filedate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.src_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fips_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.doc_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.recording_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.case_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_contract_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.as_of_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.contact_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_mail_full_addr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_mail_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_mail_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.contact_mail_zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.contact_mail_zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.due_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.trustee_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.trustee_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.trustee_mail_full_addr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.trustee_mail_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.trustee_mail_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.trustee_mail_zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.trustee_mail_zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.borrower1_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.borrower1_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.borrower2_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.borrower2_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_lender_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mers_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.loan_recording_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.orig_loan_amt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.legal_subdivision_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.auction_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.original_nod_recording_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.property_full_addr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prop_addr_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prop_addr_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prop_addr_zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prop_addr_zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.apn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nod_source_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ln_filedate','src_state','fips_cd','doc_type','recording_dt','case_number','orig_contract_date','as_of_dt','contact_fname','contact_lname','contact_mail_full_addr','contact_mail_city','contact_mail_state','contact_mail_zip5','contact_mail_zip4','due_date','trustee_fname','trustee_lname','trustee_mail_full_addr','trustee_mail_city','trustee_mail_state','trustee_mail_zip5','trustee_mail_zip4','borrower1_fname','borrower1_lname','borrower2_fname','borrower2_lname','orig_lender_name','mers_indicator','loan_recording_date','orig_loan_amt','legal_subdivision_name','auction_date','original_nod_recording_date','property_full_addr','prop_addr_city','prop_addr_state','prop_addr_zip5','prop_addr_zip4','apn','nod_source','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_state','invalid_number','invalid_document_code','invalid_date','invalid_case','invalid_date','invalid_date','invalid_name','invalid_name','invalid_alpha','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','invalid_date','invalid_name','invalid_name','invalid_alpha','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_mers','invalid_date','invalid_amount','invalid_name','invalid_date','invalid_date','invalid_alpha','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','invalid_apn','Invalid_NodSourceCode','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ln_filedate,(SALT311.StrType)le.src_state,(SALT311.StrType)le.fips_cd,(SALT311.StrType)le.doc_type,(SALT311.StrType)le.recording_dt,(SALT311.StrType)le.case_number,(SALT311.StrType)le.orig_contract_date,(SALT311.StrType)le.as_of_dt,(SALT311.StrType)le.contact_fname,(SALT311.StrType)le.contact_lname,(SALT311.StrType)le.contact_mail_full_addr,(SALT311.StrType)le.contact_mail_city,(SALT311.StrType)le.contact_mail_state,(SALT311.StrType)le.contact_mail_zip5,(SALT311.StrType)le.contact_mail_zip4,(SALT311.StrType)le.due_date,(SALT311.StrType)le.trustee_fname,(SALT311.StrType)le.trustee_lname,(SALT311.StrType)le.trustee_mail_full_addr,(SALT311.StrType)le.trustee_mail_city,(SALT311.StrType)le.trustee_mail_state,(SALT311.StrType)le.trustee_mail_zip5,(SALT311.StrType)le.trustee_mail_zip4,(SALT311.StrType)le.borrower1_fname,(SALT311.StrType)le.borrower1_lname,(SALT311.StrType)le.borrower2_fname,(SALT311.StrType)le.borrower2_lname,(SALT311.StrType)le.orig_lender_name,(SALT311.StrType)le.mers_indicator,(SALT311.StrType)le.loan_recording_date,(SALT311.StrType)le.orig_loan_amt,(SALT311.StrType)le.legal_subdivision_name,(SALT311.StrType)le.auction_date,(SALT311.StrType)le.original_nod_recording_date,(SALT311.StrType)le.property_full_addr,(SALT311.StrType)le.prop_addr_city,(SALT311.StrType)le.prop_addr_state,(SALT311.StrType)le.prop_addr_zip5,(SALT311.StrType)le.prop_addr_zip4,(SALT311.StrType)le.apn,(SALT311.StrType)le.nod_source,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,41,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_BKForeclosure_Nod) prevDS = DATASET([], Layout_BKForeclosure_Nod), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ln_filedate:invalid_date:ALLOW','ln_filedate:invalid_date:LENGTHS'
          ,'src_state:invalid_state:ALLOW','src_state:invalid_state:LENGTHS'
          ,'fips_cd:invalid_number:ALLOW'
          ,'doc_type:invalid_document_code:CUSTOM'
          ,'recording_dt:invalid_date:ALLOW','recording_dt:invalid_date:LENGTHS'
          ,'case_number:invalid_case:ALLOW'
          ,'orig_contract_date:invalid_date:ALLOW','orig_contract_date:invalid_date:LENGTHS'
          ,'as_of_dt:invalid_date:ALLOW','as_of_dt:invalid_date:LENGTHS'
          ,'contact_fname:invalid_name:ALLOW'
          ,'contact_lname:invalid_name:ALLOW'
          ,'contact_mail_full_addr:invalid_alpha:ALLOW'
          ,'contact_mail_city:invalid_AlphaNum:ALLOW'
          ,'contact_mail_state:invalid_state:ALLOW','contact_mail_state:invalid_state:LENGTHS'
          ,'contact_mail_zip5:invalid_zip:ALLOW','contact_mail_zip5:invalid_zip:LENGTHS'
          ,'contact_mail_zip4:invalid_zip:ALLOW','contact_mail_zip4:invalid_zip:LENGTHS'
          ,'due_date:invalid_date:ALLOW','due_date:invalid_date:LENGTHS'
          ,'trustee_fname:invalid_name:ALLOW'
          ,'trustee_lname:invalid_name:ALLOW'
          ,'trustee_mail_full_addr:invalid_alpha:ALLOW'
          ,'trustee_mail_city:invalid_AlphaNum:ALLOW'
          ,'trustee_mail_state:invalid_state:ALLOW','trustee_mail_state:invalid_state:LENGTHS'
          ,'trustee_mail_zip5:invalid_zip:ALLOW','trustee_mail_zip5:invalid_zip:LENGTHS'
          ,'trustee_mail_zip4:invalid_zip:ALLOW','trustee_mail_zip4:invalid_zip:LENGTHS'
          ,'borrower1_fname:invalid_name:ALLOW'
          ,'borrower1_lname:invalid_name:ALLOW'
          ,'borrower2_fname:invalid_name:ALLOW'
          ,'borrower2_lname:invalid_name:ALLOW'
          ,'orig_lender_name:invalid_name:ALLOW'
          ,'mers_indicator:invalid_mers:ALLOW'
          ,'loan_recording_date:invalid_date:ALLOW','loan_recording_date:invalid_date:LENGTHS'
          ,'orig_loan_amt:invalid_amount:ALLOW'
          ,'legal_subdivision_name:invalid_name:ALLOW'
          ,'auction_date:invalid_date:ALLOW','auction_date:invalid_date:LENGTHS'
          ,'original_nod_recording_date:invalid_date:ALLOW','original_nod_recording_date:invalid_date:LENGTHS'
          ,'property_full_addr:invalid_alpha:ALLOW'
          ,'prop_addr_city:invalid_AlphaNum:ALLOW'
          ,'prop_addr_state:invalid_state:ALLOW','prop_addr_state:invalid_state:LENGTHS'
          ,'prop_addr_zip5:invalid_zip:ALLOW','prop_addr_zip5:invalid_zip:LENGTHS'
          ,'prop_addr_zip4:invalid_zip:ALLOW','prop_addr_zip4:invalid_zip:LENGTHS'
          ,'apn:invalid_apn:ALLOW'
          ,'nod_source:Invalid_NodSourceCode:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_ln_filedate(1),Fields.InvalidMessage_ln_filedate(2)
          ,Fields.InvalidMessage_src_state(1),Fields.InvalidMessage_src_state(2)
          ,Fields.InvalidMessage_fips_cd(1)
          ,Fields.InvalidMessage_doc_type(1)
          ,Fields.InvalidMessage_recording_dt(1),Fields.InvalidMessage_recording_dt(2)
          ,Fields.InvalidMessage_case_number(1)
          ,Fields.InvalidMessage_orig_contract_date(1),Fields.InvalidMessage_orig_contract_date(2)
          ,Fields.InvalidMessage_as_of_dt(1),Fields.InvalidMessage_as_of_dt(2)
          ,Fields.InvalidMessage_contact_fname(1)
          ,Fields.InvalidMessage_contact_lname(1)
          ,Fields.InvalidMessage_contact_mail_full_addr(1)
          ,Fields.InvalidMessage_contact_mail_city(1)
          ,Fields.InvalidMessage_contact_mail_state(1),Fields.InvalidMessage_contact_mail_state(2)
          ,Fields.InvalidMessage_contact_mail_zip5(1),Fields.InvalidMessage_contact_mail_zip5(2)
          ,Fields.InvalidMessage_contact_mail_zip4(1),Fields.InvalidMessage_contact_mail_zip4(2)
          ,Fields.InvalidMessage_due_date(1),Fields.InvalidMessage_due_date(2)
          ,Fields.InvalidMessage_trustee_fname(1)
          ,Fields.InvalidMessage_trustee_lname(1)
          ,Fields.InvalidMessage_trustee_mail_full_addr(1)
          ,Fields.InvalidMessage_trustee_mail_city(1)
          ,Fields.InvalidMessage_trustee_mail_state(1),Fields.InvalidMessage_trustee_mail_state(2)
          ,Fields.InvalidMessage_trustee_mail_zip5(1),Fields.InvalidMessage_trustee_mail_zip5(2)
          ,Fields.InvalidMessage_trustee_mail_zip4(1),Fields.InvalidMessage_trustee_mail_zip4(2)
          ,Fields.InvalidMessage_borrower1_fname(1)
          ,Fields.InvalidMessage_borrower1_lname(1)
          ,Fields.InvalidMessage_borrower2_fname(1)
          ,Fields.InvalidMessage_borrower2_lname(1)
          ,Fields.InvalidMessage_orig_lender_name(1)
          ,Fields.InvalidMessage_mers_indicator(1)
          ,Fields.InvalidMessage_loan_recording_date(1),Fields.InvalidMessage_loan_recording_date(2)
          ,Fields.InvalidMessage_orig_loan_amt(1)
          ,Fields.InvalidMessage_legal_subdivision_name(1)
          ,Fields.InvalidMessage_auction_date(1),Fields.InvalidMessage_auction_date(2)
          ,Fields.InvalidMessage_original_nod_recording_date(1),Fields.InvalidMessage_original_nod_recording_date(2)
          ,Fields.InvalidMessage_property_full_addr(1)
          ,Fields.InvalidMessage_prop_addr_city(1)
          ,Fields.InvalidMessage_prop_addr_state(1),Fields.InvalidMessage_prop_addr_state(2)
          ,Fields.InvalidMessage_prop_addr_zip5(1),Fields.InvalidMessage_prop_addr_zip5(2)
          ,Fields.InvalidMessage_prop_addr_zip4(1),Fields.InvalidMessage_prop_addr_zip4(2)
          ,Fields.InvalidMessage_apn(1)
          ,Fields.InvalidMessage_nod_source(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ln_filedate_ALLOW_ErrorCount,le.ln_filedate_LENGTHS_ErrorCount
          ,le.src_state_ALLOW_ErrorCount,le.src_state_LENGTHS_ErrorCount
          ,le.fips_cd_ALLOW_ErrorCount
          ,le.doc_type_CUSTOM_ErrorCount
          ,le.recording_dt_ALLOW_ErrorCount,le.recording_dt_LENGTHS_ErrorCount
          ,le.case_number_ALLOW_ErrorCount
          ,le.orig_contract_date_ALLOW_ErrorCount,le.orig_contract_date_LENGTHS_ErrorCount
          ,le.as_of_dt_ALLOW_ErrorCount,le.as_of_dt_LENGTHS_ErrorCount
          ,le.contact_fname_ALLOW_ErrorCount
          ,le.contact_lname_ALLOW_ErrorCount
          ,le.contact_mail_full_addr_ALLOW_ErrorCount
          ,le.contact_mail_city_ALLOW_ErrorCount
          ,le.contact_mail_state_ALLOW_ErrorCount,le.contact_mail_state_LENGTHS_ErrorCount
          ,le.contact_mail_zip5_ALLOW_ErrorCount,le.contact_mail_zip5_LENGTHS_ErrorCount
          ,le.contact_mail_zip4_ALLOW_ErrorCount,le.contact_mail_zip4_LENGTHS_ErrorCount
          ,le.due_date_ALLOW_ErrorCount,le.due_date_LENGTHS_ErrorCount
          ,le.trustee_fname_ALLOW_ErrorCount
          ,le.trustee_lname_ALLOW_ErrorCount
          ,le.trustee_mail_full_addr_ALLOW_ErrorCount
          ,le.trustee_mail_city_ALLOW_ErrorCount
          ,le.trustee_mail_state_ALLOW_ErrorCount,le.trustee_mail_state_LENGTHS_ErrorCount
          ,le.trustee_mail_zip5_ALLOW_ErrorCount,le.trustee_mail_zip5_LENGTHS_ErrorCount
          ,le.trustee_mail_zip4_ALLOW_ErrorCount,le.trustee_mail_zip4_LENGTHS_ErrorCount
          ,le.borrower1_fname_ALLOW_ErrorCount
          ,le.borrower1_lname_ALLOW_ErrorCount
          ,le.borrower2_fname_ALLOW_ErrorCount
          ,le.borrower2_lname_ALLOW_ErrorCount
          ,le.orig_lender_name_ALLOW_ErrorCount
          ,le.mers_indicator_ALLOW_ErrorCount
          ,le.loan_recording_date_ALLOW_ErrorCount,le.loan_recording_date_LENGTHS_ErrorCount
          ,le.orig_loan_amt_ALLOW_ErrorCount
          ,le.legal_subdivision_name_ALLOW_ErrorCount
          ,le.auction_date_ALLOW_ErrorCount,le.auction_date_LENGTHS_ErrorCount
          ,le.original_nod_recording_date_ALLOW_ErrorCount,le.original_nod_recording_date_LENGTHS_ErrorCount
          ,le.property_full_addr_ALLOW_ErrorCount
          ,le.prop_addr_city_ALLOW_ErrorCount
          ,le.prop_addr_state_ALLOW_ErrorCount,le.prop_addr_state_LENGTHS_ErrorCount
          ,le.prop_addr_zip5_ALLOW_ErrorCount,le.prop_addr_zip5_LENGTHS_ErrorCount
          ,le.prop_addr_zip4_ALLOW_ErrorCount,le.prop_addr_zip4_LENGTHS_ErrorCount
          ,le.apn_ALLOW_ErrorCount
          ,le.nod_source_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ln_filedate_ALLOW_ErrorCount,le.ln_filedate_LENGTHS_ErrorCount
          ,le.src_state_ALLOW_ErrorCount,le.src_state_LENGTHS_ErrorCount
          ,le.fips_cd_ALLOW_ErrorCount
          ,le.doc_type_CUSTOM_ErrorCount
          ,le.recording_dt_ALLOW_ErrorCount,le.recording_dt_LENGTHS_ErrorCount
          ,le.case_number_ALLOW_ErrorCount
          ,le.orig_contract_date_ALLOW_ErrorCount,le.orig_contract_date_LENGTHS_ErrorCount
          ,le.as_of_dt_ALLOW_ErrorCount,le.as_of_dt_LENGTHS_ErrorCount
          ,le.contact_fname_ALLOW_ErrorCount
          ,le.contact_lname_ALLOW_ErrorCount
          ,le.contact_mail_full_addr_ALLOW_ErrorCount
          ,le.contact_mail_city_ALLOW_ErrorCount
          ,le.contact_mail_state_ALLOW_ErrorCount,le.contact_mail_state_LENGTHS_ErrorCount
          ,le.contact_mail_zip5_ALLOW_ErrorCount,le.contact_mail_zip5_LENGTHS_ErrorCount
          ,le.contact_mail_zip4_ALLOW_ErrorCount,le.contact_mail_zip4_LENGTHS_ErrorCount
          ,le.due_date_ALLOW_ErrorCount,le.due_date_LENGTHS_ErrorCount
          ,le.trustee_fname_ALLOW_ErrorCount
          ,le.trustee_lname_ALLOW_ErrorCount
          ,le.trustee_mail_full_addr_ALLOW_ErrorCount
          ,le.trustee_mail_city_ALLOW_ErrorCount
          ,le.trustee_mail_state_ALLOW_ErrorCount,le.trustee_mail_state_LENGTHS_ErrorCount
          ,le.trustee_mail_zip5_ALLOW_ErrorCount,le.trustee_mail_zip5_LENGTHS_ErrorCount
          ,le.trustee_mail_zip4_ALLOW_ErrorCount,le.trustee_mail_zip4_LENGTHS_ErrorCount
          ,le.borrower1_fname_ALLOW_ErrorCount
          ,le.borrower1_lname_ALLOW_ErrorCount
          ,le.borrower2_fname_ALLOW_ErrorCount
          ,le.borrower2_lname_ALLOW_ErrorCount
          ,le.orig_lender_name_ALLOW_ErrorCount
          ,le.mers_indicator_ALLOW_ErrorCount
          ,le.loan_recording_date_ALLOW_ErrorCount,le.loan_recording_date_LENGTHS_ErrorCount
          ,le.orig_loan_amt_ALLOW_ErrorCount
          ,le.legal_subdivision_name_ALLOW_ErrorCount
          ,le.auction_date_ALLOW_ErrorCount,le.auction_date_LENGTHS_ErrorCount
          ,le.original_nod_recording_date_ALLOW_ErrorCount,le.original_nod_recording_date_LENGTHS_ErrorCount
          ,le.property_full_addr_ALLOW_ErrorCount
          ,le.prop_addr_city_ALLOW_ErrorCount
          ,le.prop_addr_state_ALLOW_ErrorCount,le.prop_addr_state_LENGTHS_ErrorCount
          ,le.prop_addr_zip5_ALLOW_ErrorCount,le.prop_addr_zip5_LENGTHS_ErrorCount
          ,le.prop_addr_zip4_ALLOW_ErrorCount,le.prop_addr_zip4_LENGTHS_ErrorCount
          ,le.apn_ALLOW_ErrorCount
          ,le.nod_source_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_BKForeclosure_Nod));
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
          ,'src_county:' + getFieldTypeText(h.src_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_state:' + getFieldTypeText(h.src_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_cd:' + getFieldTypeText(h.fips_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_type:' + getFieldTypeText(h.doc_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_dt:' + getFieldTypeText(h.recording_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_doc_num:' + getFieldTypeText(h.recording_doc_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'book_number:' + getFieldTypeText(h.book_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'page_number:' + getFieldTypeText(h.page_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loan_number:' + getFieldTypeText(h.loan_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_sale_number:' + getFieldTypeText(h.trustee_sale_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_number:' + getFieldTypeText(h.case_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_contract_date:' + getFieldTypeText(h.orig_contract_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unpaid_balance:' + getFieldTypeText(h.unpaid_balance) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'past_due_amt:' + getFieldTypeText(h.past_due_amt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'as_of_dt:' + getFieldTypeText(h.as_of_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_fname:' + getFieldTypeText(h.contact_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_lname:' + getFieldTypeText(h.contact_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attention_to:' + getFieldTypeText(h.attention_to) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_mail_full_addr:' + getFieldTypeText(h.contact_mail_full_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_mail_unit:' + getFieldTypeText(h.contact_mail_unit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_mail_city:' + getFieldTypeText(h.contact_mail_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_mail_state:' + getFieldTypeText(h.contact_mail_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_mail_zip5:' + getFieldTypeText(h.contact_mail_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_mail_zip4:' + getFieldTypeText(h.contact_mail_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_telephone:' + getFieldTypeText(h.contact_telephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'due_date:' + getFieldTypeText(h.due_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_fname:' + getFieldTypeText(h.trustee_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_lname:' + getFieldTypeText(h.trustee_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_mail_full_addr:' + getFieldTypeText(h.trustee_mail_full_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_mail_unit:' + getFieldTypeText(h.trustee_mail_unit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_mail_city:' + getFieldTypeText(h.trustee_mail_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_mail_state:' + getFieldTypeText(h.trustee_mail_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_mail_zip5:' + getFieldTypeText(h.trustee_mail_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_mail_zip4:' + getFieldTypeText(h.trustee_mail_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_telephone:' + getFieldTypeText(h.trustee_telephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrower1_fname:' + getFieldTypeText(h.borrower1_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrower1_lname:' + getFieldTypeText(h.borrower1_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrower1_id_cd:' + getFieldTypeText(h.borrower1_id_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrower2_fname:' + getFieldTypeText(h.borrower2_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrower2_lname:' + getFieldTypeText(h.borrower2_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borrower2_id_cd:' + getFieldTypeText(h.borrower2_id_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lender_name:' + getFieldTypeText(h.orig_lender_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lender_type:' + getFieldTypeText(h.orig_lender_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'curr_lender_name:' + getFieldTypeText(h.curr_lender_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'curr_lender_type:' + getFieldTypeText(h.curr_lender_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mers_indicator:' + getFieldTypeText(h.mers_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loan_recording_date:' + getFieldTypeText(h.loan_recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loan_doc_num:' + getFieldTypeText(h.loan_doc_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loan_book:' + getFieldTypeText(h.loan_book) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loan_page:' + getFieldTypeText(h.loan_page) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_loan_amt:' + getFieldTypeText(h.orig_loan_amt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_lot_num:' + getFieldTypeText(h.legal_lot_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_block:' + getFieldTypeText(h.legal_block) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_subdivision_name:' + getFieldTypeText(h.legal_subdivision_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_brief_desc:' + getFieldTypeText(h.legal_brief_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'auction_date:' + getFieldTypeText(h.auction_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'auction_time:' + getFieldTypeText(h.auction_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'auction_location:' + getFieldTypeText(h.auction_location) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'auction_min_bid_amt:' + getFieldTypeText(h.auction_min_bid_amt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trustee_mail_careof:' + getFieldTypeText(h.trustee_mail_careof) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_addr_cd:' + getFieldTypeText(h.property_addr_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'auction_city:' + getFieldTypeText(h.auction_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'original_nod_recording_date:' + getFieldTypeText(h.original_nod_recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'original_nod_doc_num:' + getFieldTypeText(h.original_nod_doc_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'original_nod_book:' + getFieldTypeText(h.original_nod_book) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'original_nod_page:' + getFieldTypeText(h.original_nod_page) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nod_apn:' + getFieldTypeText(h.nod_apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_full_addr:' + getFieldTypeText(h.property_full_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_unit_type:' + getFieldTypeText(h.prop_addr_unit_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_unit_no:' + getFieldTypeText(h.prop_addr_unit_no) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_city:' + getFieldTypeText(h.prop_addr_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_state:' + getFieldTypeText(h.prop_addr_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_zip5:' + getFieldTypeText(h.prop_addr_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_zip4:' + getFieldTypeText(h.prop_addr_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apn:' + getFieldTypeText(h.apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sam_pid:' + getFieldTypeText(h.sam_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deed_pid:' + getFieldTypeText(h.deed_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lps_internal_pid:' + getFieldTypeText(h.lps_internal_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nod_source:' + getFieldTypeText(h.nod_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_foreclosure_id_cnt
          ,le.populated_ln_filedate_cnt
          ,le.populated_bk_infile_type_cnt
          ,le.populated_src_county_cnt
          ,le.populated_src_state_cnt
          ,le.populated_fips_cd_cnt
          ,le.populated_doc_type_cnt
          ,le.populated_recording_dt_cnt
          ,le.populated_recording_doc_num_cnt
          ,le.populated_book_number_cnt
          ,le.populated_page_number_cnt
          ,le.populated_loan_number_cnt
          ,le.populated_trustee_sale_number_cnt
          ,le.populated_case_number_cnt
          ,le.populated_orig_contract_date_cnt
          ,le.populated_unpaid_balance_cnt
          ,le.populated_past_due_amt_cnt
          ,le.populated_as_of_dt_cnt
          ,le.populated_contact_fname_cnt
          ,le.populated_contact_lname_cnt
          ,le.populated_attention_to_cnt
          ,le.populated_contact_mail_full_addr_cnt
          ,le.populated_contact_mail_unit_cnt
          ,le.populated_contact_mail_city_cnt
          ,le.populated_contact_mail_state_cnt
          ,le.populated_contact_mail_zip5_cnt
          ,le.populated_contact_mail_zip4_cnt
          ,le.populated_contact_telephone_cnt
          ,le.populated_due_date_cnt
          ,le.populated_trustee_fname_cnt
          ,le.populated_trustee_lname_cnt
          ,le.populated_trustee_mail_full_addr_cnt
          ,le.populated_trustee_mail_unit_cnt
          ,le.populated_trustee_mail_city_cnt
          ,le.populated_trustee_mail_state_cnt
          ,le.populated_trustee_mail_zip5_cnt
          ,le.populated_trustee_mail_zip4_cnt
          ,le.populated_trustee_telephone_cnt
          ,le.populated_borrower1_fname_cnt
          ,le.populated_borrower1_lname_cnt
          ,le.populated_borrower1_id_cd_cnt
          ,le.populated_borrower2_fname_cnt
          ,le.populated_borrower2_lname_cnt
          ,le.populated_borrower2_id_cd_cnt
          ,le.populated_orig_lender_name_cnt
          ,le.populated_orig_lender_type_cnt
          ,le.populated_curr_lender_name_cnt
          ,le.populated_curr_lender_type_cnt
          ,le.populated_mers_indicator_cnt
          ,le.populated_loan_recording_date_cnt
          ,le.populated_loan_doc_num_cnt
          ,le.populated_loan_book_cnt
          ,le.populated_loan_page_cnt
          ,le.populated_orig_loan_amt_cnt
          ,le.populated_legal_lot_num_cnt
          ,le.populated_legal_block_cnt
          ,le.populated_legal_subdivision_name_cnt
          ,le.populated_legal_brief_desc_cnt
          ,le.populated_auction_date_cnt
          ,le.populated_auction_time_cnt
          ,le.populated_auction_location_cnt
          ,le.populated_auction_min_bid_amt_cnt
          ,le.populated_trustee_mail_careof_cnt
          ,le.populated_property_addr_cd_cnt
          ,le.populated_auction_city_cnt
          ,le.populated_original_nod_recording_date_cnt
          ,le.populated_original_nod_doc_num_cnt
          ,le.populated_original_nod_book_cnt
          ,le.populated_original_nod_page_cnt
          ,le.populated_nod_apn_cnt
          ,le.populated_property_full_addr_cnt
          ,le.populated_prop_addr_unit_type_cnt
          ,le.populated_prop_addr_unit_no_cnt
          ,le.populated_prop_addr_city_cnt
          ,le.populated_prop_addr_state_cnt
          ,le.populated_prop_addr_zip5_cnt
          ,le.populated_prop_addr_zip4_cnt
          ,le.populated_apn_cnt
          ,le.populated_sam_pid_cnt
          ,le.populated_deed_pid_cnt
          ,le.populated_lps_internal_pid_cnt
          ,le.populated_nod_source_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_foreclosure_id_pcnt
          ,le.populated_ln_filedate_pcnt
          ,le.populated_bk_infile_type_pcnt
          ,le.populated_src_county_pcnt
          ,le.populated_src_state_pcnt
          ,le.populated_fips_cd_pcnt
          ,le.populated_doc_type_pcnt
          ,le.populated_recording_dt_pcnt
          ,le.populated_recording_doc_num_pcnt
          ,le.populated_book_number_pcnt
          ,le.populated_page_number_pcnt
          ,le.populated_loan_number_pcnt
          ,le.populated_trustee_sale_number_pcnt
          ,le.populated_case_number_pcnt
          ,le.populated_orig_contract_date_pcnt
          ,le.populated_unpaid_balance_pcnt
          ,le.populated_past_due_amt_pcnt
          ,le.populated_as_of_dt_pcnt
          ,le.populated_contact_fname_pcnt
          ,le.populated_contact_lname_pcnt
          ,le.populated_attention_to_pcnt
          ,le.populated_contact_mail_full_addr_pcnt
          ,le.populated_contact_mail_unit_pcnt
          ,le.populated_contact_mail_city_pcnt
          ,le.populated_contact_mail_state_pcnt
          ,le.populated_contact_mail_zip5_pcnt
          ,le.populated_contact_mail_zip4_pcnt
          ,le.populated_contact_telephone_pcnt
          ,le.populated_due_date_pcnt
          ,le.populated_trustee_fname_pcnt
          ,le.populated_trustee_lname_pcnt
          ,le.populated_trustee_mail_full_addr_pcnt
          ,le.populated_trustee_mail_unit_pcnt
          ,le.populated_trustee_mail_city_pcnt
          ,le.populated_trustee_mail_state_pcnt
          ,le.populated_trustee_mail_zip5_pcnt
          ,le.populated_trustee_mail_zip4_pcnt
          ,le.populated_trustee_telephone_pcnt
          ,le.populated_borrower1_fname_pcnt
          ,le.populated_borrower1_lname_pcnt
          ,le.populated_borrower1_id_cd_pcnt
          ,le.populated_borrower2_fname_pcnt
          ,le.populated_borrower2_lname_pcnt
          ,le.populated_borrower2_id_cd_pcnt
          ,le.populated_orig_lender_name_pcnt
          ,le.populated_orig_lender_type_pcnt
          ,le.populated_curr_lender_name_pcnt
          ,le.populated_curr_lender_type_pcnt
          ,le.populated_mers_indicator_pcnt
          ,le.populated_loan_recording_date_pcnt
          ,le.populated_loan_doc_num_pcnt
          ,le.populated_loan_book_pcnt
          ,le.populated_loan_page_pcnt
          ,le.populated_orig_loan_amt_pcnt
          ,le.populated_legal_lot_num_pcnt
          ,le.populated_legal_block_pcnt
          ,le.populated_legal_subdivision_name_pcnt
          ,le.populated_legal_brief_desc_pcnt
          ,le.populated_auction_date_pcnt
          ,le.populated_auction_time_pcnt
          ,le.populated_auction_location_pcnt
          ,le.populated_auction_min_bid_amt_pcnt
          ,le.populated_trustee_mail_careof_pcnt
          ,le.populated_property_addr_cd_pcnt
          ,le.populated_auction_city_pcnt
          ,le.populated_original_nod_recording_date_pcnt
          ,le.populated_original_nod_doc_num_pcnt
          ,le.populated_original_nod_book_pcnt
          ,le.populated_original_nod_page_pcnt
          ,le.populated_nod_apn_pcnt
          ,le.populated_property_full_addr_pcnt
          ,le.populated_prop_addr_unit_type_pcnt
          ,le.populated_prop_addr_unit_no_pcnt
          ,le.populated_prop_addr_city_pcnt
          ,le.populated_prop_addr_state_pcnt
          ,le.populated_prop_addr_zip5_pcnt
          ,le.populated_prop_addr_zip4_pcnt
          ,le.populated_apn_pcnt
          ,le.populated_sam_pid_pcnt
          ,le.populated_deed_pid_pcnt
          ,le.populated_lps_internal_pid_pcnt
          ,le.populated_nod_source_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,82,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_BKForeclosure_Nod));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),82,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_BKForeclosure_Nod) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_BKForeclosure_Nod, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
