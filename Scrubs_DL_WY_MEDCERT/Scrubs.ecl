IMPORT SALT38,STD;
IMPORT Scrubs_DL_WY_MEDCERT; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 26;
  EXPORT NumRulesFromFieldType := 26;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 26;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_In_WY_MEDCERT)
    UNSIGNED1 append_process_date_Invalid;
    UNSIGNED1 orig_first_name_Invalid;
    UNSIGNED1 mailing_street_addr_1_Invalid;
    UNSIGNED1 mailing_city_1_Invalid;
    UNSIGNED1 mailing_state_1_Invalid;
    UNSIGNED1 mailing_zip_code_1_Invalid;
    UNSIGNED1 phys_street_addr_2_Invalid;
    UNSIGNED1 phys_city_2_Invalid;
    UNSIGNED1 phys_state_2_Invalid;
    UNSIGNED1 phys_zip_code_2_Invalid;
    UNSIGNED1 orig_dl_number_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_code_1_Invalid;
    UNSIGNED1 orig_code_2_Invalid;
    UNSIGNED1 orig_code_3_Invalid;
    UNSIGNED1 orig_code_4_Invalid;
    UNSIGNED1 orig_code_5_Invalid;
    UNSIGNED1 orig_code_6_Invalid;
    UNSIGNED1 orig_code_7_Invalid;
    UNSIGNED1 orig_code_8_Invalid;
    UNSIGNED1 orig_issue_date_Invalid;
    UNSIGNED1 orig_expire_date_Invalid;
    UNSIGNED1 med_cert_status_Invalid;
    UNSIGNED1 med_cert_type_Invalid;
    UNSIGNED1 med_cert_expire_date_Invalid;
    UNSIGNED1 clean_name_first_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_WY_MEDCERT)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_WY_MEDCERT) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.append_process_date_Invalid := Fields.InValid_append_process_date((SALT38.StrType)le.append_process_date);
    SELF.orig_first_name_Invalid := Fields.InValid_orig_first_name((SALT38.StrType)le.orig_first_name,(SALT38.StrType)le.orig_middle_name,(SALT38.StrType)le.orig_last_name);
    SELF.mailing_street_addr_1_Invalid := Fields.InValid_mailing_street_addr_1((SALT38.StrType)le.mailing_street_addr_1);
    SELF.mailing_city_1_Invalid := Fields.InValid_mailing_city_1((SALT38.StrType)le.mailing_city_1);
    SELF.mailing_state_1_Invalid := Fields.InValid_mailing_state_1((SALT38.StrType)le.mailing_state_1);
    SELF.mailing_zip_code_1_Invalid := Fields.InValid_mailing_zip_code_1((SALT38.StrType)le.mailing_zip_code_1);
    SELF.phys_street_addr_2_Invalid := Fields.InValid_phys_street_addr_2((SALT38.StrType)le.phys_street_addr_2);
    SELF.phys_city_2_Invalid := Fields.InValid_phys_city_2((SALT38.StrType)le.phys_city_2);
    SELF.phys_state_2_Invalid := Fields.InValid_phys_state_2((SALT38.StrType)le.phys_state_2);
    SELF.phys_zip_code_2_Invalid := Fields.InValid_phys_zip_code_2((SALT38.StrType)le.phys_zip_code_2);
    SELF.orig_dl_number_Invalid := Fields.InValid_orig_dl_number((SALT38.StrType)le.orig_dl_number);
    SELF.orig_dob_Invalid := Fields.InValid_orig_dob((SALT38.StrType)le.orig_dob);
    SELF.orig_code_1_Invalid := Fields.InValid_orig_code_1((SALT38.StrType)le.orig_code_1);
    SELF.orig_code_2_Invalid := Fields.InValid_orig_code_2((SALT38.StrType)le.orig_code_2);
    SELF.orig_code_3_Invalid := Fields.InValid_orig_code_3((SALT38.StrType)le.orig_code_3);
    SELF.orig_code_4_Invalid := Fields.InValid_orig_code_4((SALT38.StrType)le.orig_code_4);
    SELF.orig_code_5_Invalid := Fields.InValid_orig_code_5((SALT38.StrType)le.orig_code_5);
    SELF.orig_code_6_Invalid := Fields.InValid_orig_code_6((SALT38.StrType)le.orig_code_6);
    SELF.orig_code_7_Invalid := Fields.InValid_orig_code_7((SALT38.StrType)le.orig_code_7);
    SELF.orig_code_8_Invalid := Fields.InValid_orig_code_8((SALT38.StrType)le.orig_code_8);
    SELF.orig_issue_date_Invalid := Fields.InValid_orig_issue_date((SALT38.StrType)le.orig_issue_date);
    SELF.orig_expire_date_Invalid := Fields.InValid_orig_expire_date((SALT38.StrType)le.orig_expire_date);
    SELF.med_cert_status_Invalid := Fields.InValid_med_cert_status((SALT38.StrType)le.med_cert_status);
    SELF.med_cert_type_Invalid := Fields.InValid_med_cert_type((SALT38.StrType)le.med_cert_type);
    SELF.med_cert_expire_date_Invalid := Fields.InValid_med_cert_expire_date((SALT38.StrType)le.med_cert_expire_date);
    SELF.clean_name_first_Invalid := Fields.InValid_clean_name_first((SALT38.StrType)le.clean_name_first,(SALT38.StrType)le.clean_name_middle,(SALT38.StrType)le.clean_name_last);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_WY_MEDCERT);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.append_process_date_Invalid << 0 ) + ( le.orig_first_name_Invalid << 1 ) + ( le.mailing_street_addr_1_Invalid << 2 ) + ( le.mailing_city_1_Invalid << 3 ) + ( le.mailing_state_1_Invalid << 4 ) + ( le.mailing_zip_code_1_Invalid << 5 ) + ( le.phys_street_addr_2_Invalid << 6 ) + ( le.phys_city_2_Invalid << 7 ) + ( le.phys_state_2_Invalid << 8 ) + ( le.phys_zip_code_2_Invalid << 9 ) + ( le.orig_dl_number_Invalid << 10 ) + ( le.orig_dob_Invalid << 11 ) + ( le.orig_code_1_Invalid << 12 ) + ( le.orig_code_2_Invalid << 13 ) + ( le.orig_code_3_Invalid << 14 ) + ( le.orig_code_4_Invalid << 15 ) + ( le.orig_code_5_Invalid << 16 ) + ( le.orig_code_6_Invalid << 17 ) + ( le.orig_code_7_Invalid << 18 ) + ( le.orig_code_8_Invalid << 19 ) + ( le.orig_issue_date_Invalid << 20 ) + ( le.orig_expire_date_Invalid << 21 ) + ( le.med_cert_status_Invalid << 22 ) + ( le.med_cert_type_Invalid << 23 ) + ( le.med_cert_expire_date_Invalid << 24 ) + ( le.clean_name_first_Invalid << 25 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_WY_MEDCERT);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.orig_first_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.mailing_street_addr_1_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.mailing_city_1_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.mailing_state_1_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.mailing_zip_code_1_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.phys_street_addr_2_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.phys_city_2_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.phys_state_2_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.phys_zip_code_2_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orig_dl_number_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_code_1_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.orig_code_2_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.orig_code_3_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orig_code_4_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orig_code_5_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.orig_code_6_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.orig_code_7_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.orig_code_8_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.orig_issue_date_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.orig_expire_date_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.med_cert_status_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.med_cert_type_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.med_cert_expire_date_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.clean_name_first_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    append_process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=1);
    orig_first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_first_name_Invalid=1);
    mailing_street_addr_1_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_street_addr_1_Invalid=1);
    mailing_city_1_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_city_1_Invalid=1);
    mailing_state_1_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_state_1_Invalid=1);
    mailing_zip_code_1_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_zip_code_1_Invalid=1);
    phys_street_addr_2_CUSTOM_ErrorCount := COUNT(GROUP,h.phys_street_addr_2_Invalid=1);
    phys_city_2_CUSTOM_ErrorCount := COUNT(GROUP,h.phys_city_2_Invalid=1);
    phys_state_2_CUSTOM_ErrorCount := COUNT(GROUP,h.phys_state_2_Invalid=1);
    phys_zip_code_2_CUSTOM_ErrorCount := COUNT(GROUP,h.phys_zip_code_2_Invalid=1);
    orig_dl_number_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid=1);
    orig_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_code_1_ALLOW_ErrorCount := COUNT(GROUP,h.orig_code_1_Invalid=1);
    orig_code_2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_code_2_Invalid=1);
    orig_code_3_ALLOW_ErrorCount := COUNT(GROUP,h.orig_code_3_Invalid=1);
    orig_code_4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_code_4_Invalid=1);
    orig_code_5_ALLOW_ErrorCount := COUNT(GROUP,h.orig_code_5_Invalid=1);
    orig_code_6_ALLOW_ErrorCount := COUNT(GROUP,h.orig_code_6_Invalid=1);
    orig_code_7_ALLOW_ErrorCount := COUNT(GROUP,h.orig_code_7_Invalid=1);
    orig_code_8_ALLOW_ErrorCount := COUNT(GROUP,h.orig_code_8_Invalid=1);
    orig_issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_issue_date_Invalid=1);
    orig_expire_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_expire_date_Invalid=1);
    med_cert_status_ALLOW_ErrorCount := COUNT(GROUP,h.med_cert_status_Invalid=1);
    med_cert_type_ALLOW_ErrorCount := COUNT(GROUP,h.med_cert_type_Invalid=1);
    med_cert_expire_date_CUSTOM_ErrorCount := COUNT(GROUP,h.med_cert_expire_date_Invalid=1);
    clean_name_first_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_name_first_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.append_process_date_Invalid > 0 OR h.orig_first_name_Invalid > 0 OR h.mailing_street_addr_1_Invalid > 0 OR h.mailing_city_1_Invalid > 0 OR h.mailing_state_1_Invalid > 0 OR h.mailing_zip_code_1_Invalid > 0 OR h.phys_street_addr_2_Invalid > 0 OR h.phys_city_2_Invalid > 0 OR h.phys_state_2_Invalid > 0 OR h.phys_zip_code_2_Invalid > 0 OR h.orig_dl_number_Invalid > 0 OR h.orig_dob_Invalid > 0 OR h.orig_code_1_Invalid > 0 OR h.orig_code_2_Invalid > 0 OR h.orig_code_3_Invalid > 0 OR h.orig_code_4_Invalid > 0 OR h.orig_code_5_Invalid > 0 OR h.orig_code_6_Invalid > 0 OR h.orig_code_7_Invalid > 0 OR h.orig_code_8_Invalid > 0 OR h.orig_issue_date_Invalid > 0 OR h.orig_expire_date_Invalid > 0 OR h.med_cert_status_Invalid > 0 OR h.med_cert_type_Invalid > 0 OR h.med_cert_expire_date_Invalid > 0 OR h.clean_name_first_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.append_process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_street_addr_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_city_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_state_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_zip_code_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phys_street_addr_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phys_city_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phys_state_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phys_zip_code_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_code_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_issue_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_expire_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.med_cert_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.med_cert_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.med_cert_expire_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_name_first_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.append_process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_street_addr_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_city_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_state_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_zip_code_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phys_street_addr_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phys_city_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phys_state_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phys_zip_code_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dl_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_code_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_code_8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_issue_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_expire_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.med_cert_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.med_cert_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.med_cert_expire_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_name_first_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.append_process_date_Invalid,le.orig_first_name_Invalid,le.mailing_street_addr_1_Invalid,le.mailing_city_1_Invalid,le.mailing_state_1_Invalid,le.mailing_zip_code_1_Invalid,le.phys_street_addr_2_Invalid,le.phys_city_2_Invalid,le.phys_state_2_Invalid,le.phys_zip_code_2_Invalid,le.orig_dl_number_Invalid,le.orig_dob_Invalid,le.orig_code_1_Invalid,le.orig_code_2_Invalid,le.orig_code_3_Invalid,le.orig_code_4_Invalid,le.orig_code_5_Invalid,le.orig_code_6_Invalid,le.orig_code_7_Invalid,le.orig_code_8_Invalid,le.orig_issue_date_Invalid,le.orig_expire_date_Invalid,le.med_cert_status_Invalid,le.med_cert_type_Invalid,le.med_cert_expire_date_Invalid,le.clean_name_first_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_append_process_date(le.append_process_date_Invalid),Fields.InvalidMessage_orig_first_name(le.orig_first_name_Invalid),Fields.InvalidMessage_mailing_street_addr_1(le.mailing_street_addr_1_Invalid),Fields.InvalidMessage_mailing_city_1(le.mailing_city_1_Invalid),Fields.InvalidMessage_mailing_state_1(le.mailing_state_1_Invalid),Fields.InvalidMessage_mailing_zip_code_1(le.mailing_zip_code_1_Invalid),Fields.InvalidMessage_phys_street_addr_2(le.phys_street_addr_2_Invalid),Fields.InvalidMessage_phys_city_2(le.phys_city_2_Invalid),Fields.InvalidMessage_phys_state_2(le.phys_state_2_Invalid),Fields.InvalidMessage_phys_zip_code_2(le.phys_zip_code_2_Invalid),Fields.InvalidMessage_orig_dl_number(le.orig_dl_number_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_code_1(le.orig_code_1_Invalid),Fields.InvalidMessage_orig_code_2(le.orig_code_2_Invalid),Fields.InvalidMessage_orig_code_3(le.orig_code_3_Invalid),Fields.InvalidMessage_orig_code_4(le.orig_code_4_Invalid),Fields.InvalidMessage_orig_code_5(le.orig_code_5_Invalid),Fields.InvalidMessage_orig_code_6(le.orig_code_6_Invalid),Fields.InvalidMessage_orig_code_7(le.orig_code_7_Invalid),Fields.InvalidMessage_orig_code_8(le.orig_code_8_Invalid),Fields.InvalidMessage_orig_issue_date(le.orig_issue_date_Invalid),Fields.InvalidMessage_orig_expire_date(le.orig_expire_date_Invalid),Fields.InvalidMessage_med_cert_status(le.med_cert_status_Invalid),Fields.InvalidMessage_med_cert_type(le.med_cert_type_Invalid),Fields.InvalidMessage_med_cert_expire_date(le.med_cert_expire_date_Invalid),Fields.InvalidMessage_clean_name_first(le.clean_name_first_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.append_process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_street_addr_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_city_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_state_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_zip_code_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phys_street_addr_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phys_city_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phys_state_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phys_zip_code_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dl_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_code_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_code_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_code_3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_code_4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_code_5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_code_6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_code_7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_code_8_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_issue_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_expire_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.med_cert_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.med_cert_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.med_cert_expire_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_name_first_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'append_process_date','orig_first_name','mailing_street_addr_1','mailing_city_1','mailing_state_1','mailing_zip_code_1','phys_street_addr_2','phys_city_2','phys_state_2','phys_zip_code_2','orig_dl_number','orig_dob','orig_code_1','orig_code_2','orig_code_3','orig_code_4','orig_code_5','orig_code_6','orig_code_7','orig_code_8','orig_issue_date','orig_expire_date','med_cert_status','med_cert_type','med_cert_expire_date','clean_name_first','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_Past_Date','invalid_orig_name','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5','invalid_numeric','invalid_Past_Date','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_orig_code','invalid_Past_Date','invalid_General_Date','invalid_med_cert_status','invalid_med_cert_type','invalid_General_Date','invalid_clean_name','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.append_process_date,(SALT38.StrType)le.orig_first_name,(SALT38.StrType)le.mailing_street_addr_1,(SALT38.StrType)le.mailing_city_1,(SALT38.StrType)le.mailing_state_1,(SALT38.StrType)le.mailing_zip_code_1,(SALT38.StrType)le.phys_street_addr_2,(SALT38.StrType)le.phys_city_2,(SALT38.StrType)le.phys_state_2,(SALT38.StrType)le.phys_zip_code_2,(SALT38.StrType)le.orig_dl_number,(SALT38.StrType)le.orig_dob,(SALT38.StrType)le.orig_code_1,(SALT38.StrType)le.orig_code_2,(SALT38.StrType)le.orig_code_3,(SALT38.StrType)le.orig_code_4,(SALT38.StrType)le.orig_code_5,(SALT38.StrType)le.orig_code_6,(SALT38.StrType)le.orig_code_7,(SALT38.StrType)le.orig_code_8,(SALT38.StrType)le.orig_issue_date,(SALT38.StrType)le.orig_expire_date,(SALT38.StrType)le.med_cert_status,(SALT38.StrType)le.med_cert_type,(SALT38.StrType)le.med_cert_expire_date,(SALT38.StrType)le.clean_name_first,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,26,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_In_WY_MEDCERT) prevDS = DATASET([], Layout_In_WY_MEDCERT), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'append_process_date:invalid_Past_Date:CUSTOM'
          ,'orig_first_name:invalid_orig_name:CUSTOM'
          ,'mailing_street_addr_1:invalid_mandatory:CUSTOM'
          ,'mailing_city_1:invalid_mandatory:CUSTOM'
          ,'mailing_state_1:invalid_state:CUSTOM'
          ,'mailing_zip_code_1:invalid_zip5:CUSTOM'
          ,'phys_street_addr_2:invalid_mandatory:CUSTOM'
          ,'phys_city_2:invalid_mandatory:CUSTOM'
          ,'phys_state_2:invalid_state:CUSTOM'
          ,'phys_zip_code_2:invalid_zip5:CUSTOM'
          ,'orig_dl_number:invalid_numeric:CUSTOM'
          ,'orig_dob:invalid_Past_Date:CUSTOM'
          ,'orig_code_1:invalid_orig_code:ALLOW'
          ,'orig_code_2:invalid_orig_code:ALLOW'
          ,'orig_code_3:invalid_orig_code:ALLOW'
          ,'orig_code_4:invalid_orig_code:ALLOW'
          ,'orig_code_5:invalid_orig_code:ALLOW'
          ,'orig_code_6:invalid_orig_code:ALLOW'
          ,'orig_code_7:invalid_orig_code:ALLOW'
          ,'orig_code_8:invalid_orig_code:ALLOW'
          ,'orig_issue_date:invalid_Past_Date:CUSTOM'
          ,'orig_expire_date:invalid_General_Date:CUSTOM'
          ,'med_cert_status:invalid_med_cert_status:ALLOW'
          ,'med_cert_type:invalid_med_cert_type:ALLOW'
          ,'med_cert_expire_date:invalid_General_Date:CUSTOM'
          ,'clean_name_first:invalid_clean_name:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_append_process_date(1)
          ,Fields.InvalidMessage_orig_first_name(1)
          ,Fields.InvalidMessage_mailing_street_addr_1(1)
          ,Fields.InvalidMessage_mailing_city_1(1)
          ,Fields.InvalidMessage_mailing_state_1(1)
          ,Fields.InvalidMessage_mailing_zip_code_1(1)
          ,Fields.InvalidMessage_phys_street_addr_2(1)
          ,Fields.InvalidMessage_phys_city_2(1)
          ,Fields.InvalidMessage_phys_state_2(1)
          ,Fields.InvalidMessage_phys_zip_code_2(1)
          ,Fields.InvalidMessage_orig_dl_number(1)
          ,Fields.InvalidMessage_orig_dob(1)
          ,Fields.InvalidMessage_orig_code_1(1)
          ,Fields.InvalidMessage_orig_code_2(1)
          ,Fields.InvalidMessage_orig_code_3(1)
          ,Fields.InvalidMessage_orig_code_4(1)
          ,Fields.InvalidMessage_orig_code_5(1)
          ,Fields.InvalidMessage_orig_code_6(1)
          ,Fields.InvalidMessage_orig_code_7(1)
          ,Fields.InvalidMessage_orig_code_8(1)
          ,Fields.InvalidMessage_orig_issue_date(1)
          ,Fields.InvalidMessage_orig_expire_date(1)
          ,Fields.InvalidMessage_med_cert_status(1)
          ,Fields.InvalidMessage_med_cert_type(1)
          ,Fields.InvalidMessage_med_cert_expire_date(1)
          ,Fields.InvalidMessage_clean_name_first(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount
          ,le.orig_first_name_CUSTOM_ErrorCount
          ,le.mailing_street_addr_1_CUSTOM_ErrorCount
          ,le.mailing_city_1_CUSTOM_ErrorCount
          ,le.mailing_state_1_CUSTOM_ErrorCount
          ,le.mailing_zip_code_1_CUSTOM_ErrorCount
          ,le.phys_street_addr_2_CUSTOM_ErrorCount
          ,le.phys_city_2_CUSTOM_ErrorCount
          ,le.phys_state_2_CUSTOM_ErrorCount
          ,le.phys_zip_code_2_CUSTOM_ErrorCount
          ,le.orig_dl_number_CUSTOM_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount
          ,le.orig_code_1_ALLOW_ErrorCount
          ,le.orig_code_2_ALLOW_ErrorCount
          ,le.orig_code_3_ALLOW_ErrorCount
          ,le.orig_code_4_ALLOW_ErrorCount
          ,le.orig_code_5_ALLOW_ErrorCount
          ,le.orig_code_6_ALLOW_ErrorCount
          ,le.orig_code_7_ALLOW_ErrorCount
          ,le.orig_code_8_ALLOW_ErrorCount
          ,le.orig_issue_date_CUSTOM_ErrorCount
          ,le.orig_expire_date_CUSTOM_ErrorCount
          ,le.med_cert_status_ALLOW_ErrorCount
          ,le.med_cert_type_ALLOW_ErrorCount
          ,le.med_cert_expire_date_CUSTOM_ErrorCount
          ,le.clean_name_first_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.append_process_date_CUSTOM_ErrorCount
          ,le.orig_first_name_CUSTOM_ErrorCount
          ,le.mailing_street_addr_1_CUSTOM_ErrorCount
          ,le.mailing_city_1_CUSTOM_ErrorCount
          ,le.mailing_state_1_CUSTOM_ErrorCount
          ,le.mailing_zip_code_1_CUSTOM_ErrorCount
          ,le.phys_street_addr_2_CUSTOM_ErrorCount
          ,le.phys_city_2_CUSTOM_ErrorCount
          ,le.phys_state_2_CUSTOM_ErrorCount
          ,le.phys_zip_code_2_CUSTOM_ErrorCount
          ,le.orig_dl_number_CUSTOM_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount
          ,le.orig_code_1_ALLOW_ErrorCount
          ,le.orig_code_2_ALLOW_ErrorCount
          ,le.orig_code_3_ALLOW_ErrorCount
          ,le.orig_code_4_ALLOW_ErrorCount
          ,le.orig_code_5_ALLOW_ErrorCount
          ,le.orig_code_6_ALLOW_ErrorCount
          ,le.orig_code_7_ALLOW_ErrorCount
          ,le.orig_code_8_ALLOW_ErrorCount
          ,le.orig_issue_date_CUSTOM_ErrorCount
          ,le.orig_expire_date_CUSTOM_ErrorCount
          ,le.med_cert_status_ALLOW_ErrorCount
          ,le.med_cert_type_ALLOW_ErrorCount
          ,le.med_cert_expire_date_CUSTOM_ErrorCount
          ,le.clean_name_first_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_In_WY_MEDCERT));
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
          ,'append_process_date:' + getFieldTypeText(h.append_process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_first_name:' + getFieldTypeText(h.orig_first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_middle_name:' + getFieldTypeText(h.orig_middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_last_name:' + getFieldTypeText(h.orig_last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_street_addr_1:' + getFieldTypeText(h.mailing_street_addr_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_city_1:' + getFieldTypeText(h.mailing_city_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_state_1:' + getFieldTypeText(h.mailing_state_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_zip_code_1:' + getFieldTypeText(h.mailing_zip_code_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phys_street_addr_2:' + getFieldTypeText(h.phys_street_addr_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phys_city_2:' + getFieldTypeText(h.phys_city_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phys_state_2:' + getFieldTypeText(h.phys_state_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phys_zip_code_2:' + getFieldTypeText(h.phys_zip_code_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dl_number:' + getFieldTypeText(h.orig_dl_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob:' + getFieldTypeText(h.orig_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_code_1:' + getFieldTypeText(h.orig_code_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_code_2:' + getFieldTypeText(h.orig_code_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_code_3:' + getFieldTypeText(h.orig_code_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_code_4:' + getFieldTypeText(h.orig_code_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_code_5:' + getFieldTypeText(h.orig_code_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_code_6:' + getFieldTypeText(h.orig_code_6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_code_7:' + getFieldTypeText(h.orig_code_7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_code_8:' + getFieldTypeText(h.orig_code_8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_issue_date:' + getFieldTypeText(h.orig_issue_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_expire_date:' + getFieldTypeText(h.orig_expire_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'med_cert_status:' + getFieldTypeText(h.med_cert_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'med_cert_type:' + getFieldTypeText(h.med_cert_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'med_cert_expire_date:' + getFieldTypeText(h.med_cert_expire_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_prefix:' + getFieldTypeText(h.clean_name_prefix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_first:' + getFieldTypeText(h.clean_name_first) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_middle:' + getFieldTypeText(h.clean_name_middle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_last:' + getFieldTypeText(h.clean_name_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_suffix:' + getFieldTypeText(h.clean_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_score:' + getFieldTypeText(h.clean_name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_append_process_date_cnt
          ,le.populated_orig_first_name_cnt
          ,le.populated_orig_middle_name_cnt
          ,le.populated_orig_last_name_cnt
          ,le.populated_mailing_street_addr_1_cnt
          ,le.populated_mailing_city_1_cnt
          ,le.populated_mailing_state_1_cnt
          ,le.populated_mailing_zip_code_1_cnt
          ,le.populated_phys_street_addr_2_cnt
          ,le.populated_phys_city_2_cnt
          ,le.populated_phys_state_2_cnt
          ,le.populated_phys_zip_code_2_cnt
          ,le.populated_orig_dl_number_cnt
          ,le.populated_orig_dob_cnt
          ,le.populated_orig_code_1_cnt
          ,le.populated_orig_code_2_cnt
          ,le.populated_orig_code_3_cnt
          ,le.populated_orig_code_4_cnt
          ,le.populated_orig_code_5_cnt
          ,le.populated_orig_code_6_cnt
          ,le.populated_orig_code_7_cnt
          ,le.populated_orig_code_8_cnt
          ,le.populated_orig_issue_date_cnt
          ,le.populated_orig_expire_date_cnt
          ,le.populated_med_cert_status_cnt
          ,le.populated_med_cert_type_cnt
          ,le.populated_med_cert_expire_date_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_clean_name_prefix_cnt
          ,le.populated_clean_name_first_cnt
          ,le.populated_clean_name_middle_cnt
          ,le.populated_clean_name_last_cnt
          ,le.populated_clean_name_suffix_cnt
          ,le.populated_clean_name_score_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_append_process_date_pcnt
          ,le.populated_orig_first_name_pcnt
          ,le.populated_orig_middle_name_pcnt
          ,le.populated_orig_last_name_pcnt
          ,le.populated_mailing_street_addr_1_pcnt
          ,le.populated_mailing_city_1_pcnt
          ,le.populated_mailing_state_1_pcnt
          ,le.populated_mailing_zip_code_1_pcnt
          ,le.populated_phys_street_addr_2_pcnt
          ,le.populated_phys_city_2_pcnt
          ,le.populated_phys_state_2_pcnt
          ,le.populated_phys_zip_code_2_pcnt
          ,le.populated_orig_dl_number_pcnt
          ,le.populated_orig_dob_pcnt
          ,le.populated_orig_code_1_pcnt
          ,le.populated_orig_code_2_pcnt
          ,le.populated_orig_code_3_pcnt
          ,le.populated_orig_code_4_pcnt
          ,le.populated_orig_code_5_pcnt
          ,le.populated_orig_code_6_pcnt
          ,le.populated_orig_code_7_pcnt
          ,le.populated_orig_code_8_pcnt
          ,le.populated_orig_issue_date_pcnt
          ,le.populated_orig_expire_date_pcnt
          ,le.populated_med_cert_status_pcnt
          ,le.populated_med_cert_type_pcnt
          ,le.populated_med_cert_expire_date_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_clean_name_prefix_pcnt
          ,le.populated_clean_name_first_pcnt
          ,le.populated_clean_name_middle_pcnt
          ,le.populated_clean_name_last_pcnt
          ,le.populated_clean_name_suffix_pcnt
          ,le.populated_clean_name_score_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,34,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_In_WY_MEDCERT));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),34,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_In_WY_MEDCERT) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DL_WY_MEDCERT, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
