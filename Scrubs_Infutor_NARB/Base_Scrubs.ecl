IMPORT SALT311,STD;
IMPORT Scrubs_Infutor_NARB,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 36;
  EXPORT NumRulesFromFieldType := 36;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 36;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_Infutor_NARB)
    UNSIGNED1 rcid_Invalid;
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 pid_Invalid;
    UNSIGNED1 address_type_code_Invalid;
    UNSIGNED1 url_Invalid;
    UNSIGNED1 sic1_Invalid;
    UNSIGNED1 sic2_Invalid;
    UNSIGNED1 sic3_Invalid;
    UNSIGNED1 sic4_Invalid;
    UNSIGNED1 sic5_Invalid;
    UNSIGNED1 incorporation_state_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 contact_title_Invalid;
    UNSIGNED1 normcompany_type_Invalid;
    UNSIGNED1 clean_company_name_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 prep_address_line1_Invalid;
    UNSIGNED1 prep_address_line_last_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_Infutor_NARB)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Layout_Infutor_NARB) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.rcid_Invalid := Base_Fields.InValid_rcid((SALT311.StrType)le.rcid);
    SELF.powid_Invalid := Base_Fields.InValid_powid((SALT311.StrType)le.powid);
    SELF.proxid_Invalid := Base_Fields.InValid_proxid((SALT311.StrType)le.proxid);
    SELF.seleid_Invalid := Base_Fields.InValid_seleid((SALT311.StrType)le.seleid);
    SELF.orgid_Invalid := Base_Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.ultid_Invalid := Base_Fields.InValid_ultid((SALT311.StrType)le.ultid);
    SELF.did_Invalid := Base_Fields.InValid_did((SALT311.StrType)le.did);
    SELF.dt_first_seen_Invalid := Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.process_date_Invalid := Base_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.record_type_Invalid := Base_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.pid_Invalid := Base_Fields.InValid_pid((SALT311.StrType)le.pid);
    SELF.address_type_code_Invalid := Base_Fields.InValid_address_type_code((SALT311.StrType)le.address_type_code);
    SELF.url_Invalid := Base_Fields.InValid_url((SALT311.StrType)le.url);
    SELF.sic1_Invalid := Base_Fields.InValid_sic1((SALT311.StrType)le.sic1);
    SELF.sic2_Invalid := Base_Fields.InValid_sic2((SALT311.StrType)le.sic2);
    SELF.sic3_Invalid := Base_Fields.InValid_sic3((SALT311.StrType)le.sic3);
    SELF.sic4_Invalid := Base_Fields.InValid_sic4((SALT311.StrType)le.sic4);
    SELF.sic5_Invalid := Base_Fields.InValid_sic5((SALT311.StrType)le.sic5);
    SELF.incorporation_state_Invalid := Base_Fields.InValid_incorporation_state((SALT311.StrType)le.incorporation_state);
    SELF.email_Invalid := Base_Fields.InValid_email((SALT311.StrType)le.email);
    SELF.contact_title_Invalid := Base_Fields.InValid_contact_title((SALT311.StrType)le.contact_title);
    SELF.normcompany_type_Invalid := Base_Fields.InValid_normcompany_type((SALT311.StrType)le.normcompany_type);
    SELF.clean_company_name_Invalid := Base_Fields.InValid_clean_company_name((SALT311.StrType)le.clean_company_name);
    SELF.clean_phone_Invalid := Base_Fields.InValid_clean_phone((SALT311.StrType)le.clean_phone);
    SELF.fname_Invalid := Base_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.lname_Invalid := Base_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.prim_range_Invalid := Base_Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.p_city_name_Invalid := Base_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Base_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    SELF.st_Invalid := Base_Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip_Invalid := Base_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.prep_address_line1_Invalid := Base_Fields.InValid_prep_address_line1((SALT311.StrType)le.prep_address_line1);
    SELF.prep_address_line_last_Invalid := Base_Fields.InValid_prep_address_line_last((SALT311.StrType)le.prep_address_line_last);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_Infutor_NARB);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.rcid_Invalid << 0 ) + ( le.powid_Invalid << 1 ) + ( le.proxid_Invalid << 2 ) + ( le.seleid_Invalid << 3 ) + ( le.orgid_Invalid << 4 ) + ( le.ultid_Invalid << 5 ) + ( le.did_Invalid << 6 ) + ( le.dt_first_seen_Invalid << 7 ) + ( le.dt_last_seen_Invalid << 8 ) + ( le.dt_vendor_first_reported_Invalid << 9 ) + ( le.dt_vendor_last_reported_Invalid << 10 ) + ( le.process_date_Invalid << 11 ) + ( le.record_type_Invalid << 12 ) + ( le.pid_Invalid << 13 ) + ( le.address_type_code_Invalid << 14 ) + ( le.url_Invalid << 15 ) + ( le.sic1_Invalid << 16 ) + ( le.sic2_Invalid << 17 ) + ( le.sic3_Invalid << 18 ) + ( le.sic4_Invalid << 19 ) + ( le.sic5_Invalid << 20 ) + ( le.incorporation_state_Invalid << 21 ) + ( le.email_Invalid << 22 ) + ( le.contact_title_Invalid << 23 ) + ( le.normcompany_type_Invalid << 24 ) + ( le.clean_company_name_Invalid << 25 ) + ( le.clean_phone_Invalid << 26 ) + ( le.fname_Invalid << 27 ) + ( le.lname_Invalid << 28 ) + ( le.prim_range_Invalid << 29 ) + ( le.p_city_name_Invalid << 30 ) + ( le.v_city_name_Invalid << 31 ) + ( le.st_Invalid << 32 ) + ( le.zip_Invalid << 33 ) + ( le.prep_address_line1_Invalid << 34 ) + ( le.prep_address_line_last_Invalid << 35 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_Infutor_NARB);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.rcid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.powid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.pid_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.address_type_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.url_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.sic1_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.sic2_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.sic3_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.sic4_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.sic5_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.incorporation_state_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.email_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.contact_title_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.normcompany_type_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.clean_company_name_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.clean_phone_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.prep_address_line1_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.prep_address_line_last_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    rcid_CUSTOM_ErrorCount := COUNT(GROUP,h.rcid_Invalid=1);
    powid_LENGTHS_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    proxid_LENGTHS_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    seleid_LENGTHS_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    orgid_LENGTHS_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    ultid_LENGTHS_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    did_LENGTHS_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    pid_CUSTOM_ErrorCount := COUNT(GROUP,h.pid_Invalid=1);
    address_type_code_ENUM_ErrorCount := COUNT(GROUP,h.address_type_code_Invalid=1);
    url_CUSTOM_ErrorCount := COUNT(GROUP,h.url_Invalid=1);
    sic1_CUSTOM_ErrorCount := COUNT(GROUP,h.sic1_Invalid=1);
    sic2_CUSTOM_ErrorCount := COUNT(GROUP,h.sic2_Invalid=1);
    sic3_CUSTOM_ErrorCount := COUNT(GROUP,h.sic3_Invalid=1);
    sic4_CUSTOM_ErrorCount := COUNT(GROUP,h.sic4_Invalid=1);
    sic5_CUSTOM_ErrorCount := COUNT(GROUP,h.sic5_Invalid=1);
    incorporation_state_CUSTOM_ErrorCount := COUNT(GROUP,h.incorporation_state_Invalid=1);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    contact_title_LENGTHS_ErrorCount := COUNT(GROUP,h.contact_title_Invalid=1);
    normcompany_type_ENUM_ErrorCount := COUNT(GROUP,h.normcompany_type_Invalid=1);
    clean_company_name_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid=1);
    clean_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    prim_range_LENGTHS_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    p_city_name_LENGTHS_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_LENGTHS_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    prep_address_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_address_line1_Invalid=1);
    prep_address_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_address_line_last_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.rcid_Invalid > 0 OR h.powid_Invalid > 0 OR h.proxid_Invalid > 0 OR h.seleid_Invalid > 0 OR h.orgid_Invalid > 0 OR h.ultid_Invalid > 0 OR h.did_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.process_date_Invalid > 0 OR h.record_type_Invalid > 0 OR h.pid_Invalid > 0 OR h.address_type_code_Invalid > 0 OR h.url_Invalid > 0 OR h.sic1_Invalid > 0 OR h.sic2_Invalid > 0 OR h.sic3_Invalid > 0 OR h.sic4_Invalid > 0 OR h.sic5_Invalid > 0 OR h.incorporation_state_Invalid > 0 OR h.email_Invalid > 0 OR h.contact_title_Invalid > 0 OR h.normcompany_type_Invalid > 0 OR h.clean_company_name_Invalid > 0 OR h.clean_phone_Invalid > 0 OR h.fname_Invalid > 0 OR h.lname_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.prep_address_line1_Invalid > 0 OR h.prep_address_line_last_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.rcid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.did_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.pid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.url_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.incorporation_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.normcompany_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.clean_company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.p_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.v_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_address_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_address_line_last_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.rcid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.did_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.pid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.url_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.incorporation_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.normcompany_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.clean_company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.p_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.v_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_address_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_address_line_last_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.rcid_Invalid,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.did_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.process_date_Invalid,le.record_type_Invalid,le.pid_Invalid,le.address_type_code_Invalid,le.url_Invalid,le.sic1_Invalid,le.sic2_Invalid,le.sic3_Invalid,le.sic4_Invalid,le.sic5_Invalid,le.incorporation_state_Invalid,le.email_Invalid,le.contact_title_Invalid,le.normcompany_type_Invalid,le.clean_company_name_Invalid,le.clean_phone_Invalid,le.fname_Invalid,le.lname_Invalid,le.prim_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.prep_address_line1_Invalid,le.prep_address_line_last_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_rcid(le.rcid_Invalid),Base_Fields.InvalidMessage_powid(le.powid_Invalid),Base_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_Fields.InvalidMessage_did(le.did_Invalid),Base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Fields.InvalidMessage_pid(le.pid_Invalid),Base_Fields.InvalidMessage_address_type_code(le.address_type_code_Invalid),Base_Fields.InvalidMessage_url(le.url_Invalid),Base_Fields.InvalidMessage_sic1(le.sic1_Invalid),Base_Fields.InvalidMessage_sic2(le.sic2_Invalid),Base_Fields.InvalidMessage_sic3(le.sic3_Invalid),Base_Fields.InvalidMessage_sic4(le.sic4_Invalid),Base_Fields.InvalidMessage_sic5(le.sic5_Invalid),Base_Fields.InvalidMessage_incorporation_state(le.incorporation_state_Invalid),Base_Fields.InvalidMessage_email(le.email_Invalid),Base_Fields.InvalidMessage_contact_title(le.contact_title_Invalid),Base_Fields.InvalidMessage_normcompany_type(le.normcompany_type_Invalid),Base_Fields.InvalidMessage_clean_company_name(le.clean_company_name_Invalid),Base_Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Base_Fields.InvalidMessage_fname(le.fname_Invalid),Base_Fields.InvalidMessage_lname(le.lname_Invalid),Base_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Base_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Base_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Base_Fields.InvalidMessage_st(le.st_Invalid),Base_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Fields.InvalidMessage_prep_address_line1(le.prep_address_line1_Invalid),Base_Fields.InvalidMessage_prep_address_line_last(le.prep_address_line_last_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.rcid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.pid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_type_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.url_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.incorporation_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_title_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.normcompany_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.clean_company_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_address_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_address_line_last_Invalid,'LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'rcid','powid','proxid','seleid','orgid','ultid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','pid','address_type_code','url','sic1','sic2','sic3','sic4','sic5','incorporation_state','email','contact_title','normcompany_type','clean_company_name','clean_phone','fname','lname','prim_range','p_city_name','v_city_name','st','zip','prep_address_line1','prep_address_line_last','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_rcid','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_record_type','invalid_numeric','invalid_address_type_code','invalid_url','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_st','invalid_email','invalid_mandatory','invalid_norm_type','invalid_mandatory','invalid_phone','invalid_alphanum_specials','invalid_alphanum_specials','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_st','invalid_zip5','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.rcid,(SALT311.StrType)le.powid,(SALT311.StrType)le.proxid,(SALT311.StrType)le.seleid,(SALT311.StrType)le.orgid,(SALT311.StrType)le.ultid,(SALT311.StrType)le.did,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.process_date,(SALT311.StrType)le.record_type,(SALT311.StrType)le.pid,(SALT311.StrType)le.address_type_code,(SALT311.StrType)le.url,(SALT311.StrType)le.sic1,(SALT311.StrType)le.sic2,(SALT311.StrType)le.sic3,(SALT311.StrType)le.sic4,(SALT311.StrType)le.sic5,(SALT311.StrType)le.incorporation_state,(SALT311.StrType)le.email,(SALT311.StrType)le.contact_title,(SALT311.StrType)le.normcompany_type,(SALT311.StrType)le.clean_company_name,(SALT311.StrType)le.clean_phone,(SALT311.StrType)le.fname,(SALT311.StrType)le.lname,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.prep_address_line1,(SALT311.StrType)le.prep_address_line_last,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,36,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_Infutor_NARB) prevDS = DATASET([], Base_Layout_Infutor_NARB), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'rcid:invalid_rcid:CUSTOM'
          ,'powid:invalid_mandatory:LENGTHS'
          ,'proxid:invalid_mandatory:LENGTHS'
          ,'seleid:invalid_mandatory:LENGTHS'
          ,'orgid:invalid_mandatory:LENGTHS'
          ,'ultid:invalid_mandatory:LENGTHS'
          ,'did:invalid_mandatory:LENGTHS'
          ,'dt_first_seen:invalid_pastdate8:CUSTOM'
          ,'dt_last_seen:invalid_pastdate8:CUSTOM'
          ,'dt_vendor_first_reported:invalid_pastdate8:CUSTOM'
          ,'dt_vendor_last_reported:invalid_pastdate8:CUSTOM'
          ,'process_date:invalid_pastdate8:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'pid:invalid_numeric:CUSTOM'
          ,'address_type_code:invalid_address_type_code:ENUM'
          ,'url:invalid_url:CUSTOM'
          ,'sic1:invalid_sic:CUSTOM'
          ,'sic2:invalid_sic:CUSTOM'
          ,'sic3:invalid_sic:CUSTOM'
          ,'sic4:invalid_sic:CUSTOM'
          ,'sic5:invalid_sic:CUSTOM'
          ,'incorporation_state:invalid_st:CUSTOM'
          ,'email:invalid_email:ALLOW'
          ,'contact_title:invalid_mandatory:LENGTHS'
          ,'normcompany_type:invalid_norm_type:ENUM'
          ,'clean_company_name:invalid_mandatory:LENGTHS'
          ,'clean_phone:invalid_phone:CUSTOM'
          ,'fname:invalid_alphanum_specials:ALLOW'
          ,'lname:invalid_alphanum_specials:ALLOW'
          ,'prim_range:invalid_mandatory:LENGTHS'
          ,'p_city_name:invalid_mandatory:LENGTHS'
          ,'v_city_name:invalid_mandatory:LENGTHS'
          ,'st:invalid_st:CUSTOM'
          ,'zip:invalid_zip5:CUSTOM'
          ,'prep_address_line1:invalid_mandatory:LENGTHS'
          ,'prep_address_line_last:invalid_mandatory:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_rcid(1)
          ,Base_Fields.InvalidMessage_powid(1)
          ,Base_Fields.InvalidMessage_proxid(1)
          ,Base_Fields.InvalidMessage_seleid(1)
          ,Base_Fields.InvalidMessage_orgid(1)
          ,Base_Fields.InvalidMessage_ultid(1)
          ,Base_Fields.InvalidMessage_did(1)
          ,Base_Fields.InvalidMessage_dt_first_seen(1)
          ,Base_Fields.InvalidMessage_dt_last_seen(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_process_date(1)
          ,Base_Fields.InvalidMessage_record_type(1)
          ,Base_Fields.InvalidMessage_pid(1)
          ,Base_Fields.InvalidMessage_address_type_code(1)
          ,Base_Fields.InvalidMessage_url(1)
          ,Base_Fields.InvalidMessage_sic1(1)
          ,Base_Fields.InvalidMessage_sic2(1)
          ,Base_Fields.InvalidMessage_sic3(1)
          ,Base_Fields.InvalidMessage_sic4(1)
          ,Base_Fields.InvalidMessage_sic5(1)
          ,Base_Fields.InvalidMessage_incorporation_state(1)
          ,Base_Fields.InvalidMessage_email(1)
          ,Base_Fields.InvalidMessage_contact_title(1)
          ,Base_Fields.InvalidMessage_normcompany_type(1)
          ,Base_Fields.InvalidMessage_clean_company_name(1)
          ,Base_Fields.InvalidMessage_clean_phone(1)
          ,Base_Fields.InvalidMessage_fname(1)
          ,Base_Fields.InvalidMessage_lname(1)
          ,Base_Fields.InvalidMessage_prim_range(1)
          ,Base_Fields.InvalidMessage_p_city_name(1)
          ,Base_Fields.InvalidMessage_v_city_name(1)
          ,Base_Fields.InvalidMessage_st(1)
          ,Base_Fields.InvalidMessage_zip(1)
          ,Base_Fields.InvalidMessage_prep_address_line1(1)
          ,Base_Fields.InvalidMessage_prep_address_line_last(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.rcid_CUSTOM_ErrorCount
          ,le.powid_LENGTHS_ErrorCount
          ,le.proxid_LENGTHS_ErrorCount
          ,le.seleid_LENGTHS_ErrorCount
          ,le.orgid_LENGTHS_ErrorCount
          ,le.ultid_LENGTHS_ErrorCount
          ,le.did_LENGTHS_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.pid_CUSTOM_ErrorCount
          ,le.address_type_code_ENUM_ErrorCount
          ,le.url_CUSTOM_ErrorCount
          ,le.sic1_CUSTOM_ErrorCount
          ,le.sic2_CUSTOM_ErrorCount
          ,le.sic3_CUSTOM_ErrorCount
          ,le.sic4_CUSTOM_ErrorCount
          ,le.sic5_CUSTOM_ErrorCount
          ,le.incorporation_state_CUSTOM_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.contact_title_LENGTHS_ErrorCount
          ,le.normcompany_type_ENUM_ErrorCount
          ,le.clean_company_name_LENGTHS_ErrorCount
          ,le.clean_phone_CUSTOM_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.prim_range_LENGTHS_ErrorCount
          ,le.p_city_name_LENGTHS_ErrorCount
          ,le.v_city_name_LENGTHS_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.prep_address_line1_LENGTHS_ErrorCount
          ,le.prep_address_line_last_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.rcid_CUSTOM_ErrorCount
          ,le.powid_LENGTHS_ErrorCount
          ,le.proxid_LENGTHS_ErrorCount
          ,le.seleid_LENGTHS_ErrorCount
          ,le.orgid_LENGTHS_ErrorCount
          ,le.ultid_LENGTHS_ErrorCount
          ,le.did_LENGTHS_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.pid_CUSTOM_ErrorCount
          ,le.address_type_code_ENUM_ErrorCount
          ,le.url_CUSTOM_ErrorCount
          ,le.sic1_CUSTOM_ErrorCount
          ,le.sic2_CUSTOM_ErrorCount
          ,le.sic3_CUSTOM_ErrorCount
          ,le.sic4_CUSTOM_ErrorCount
          ,le.sic5_CUSTOM_ErrorCount
          ,le.incorporation_state_CUSTOM_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.contact_title_LENGTHS_ErrorCount
          ,le.normcompany_type_ENUM_ErrorCount
          ,le.clean_company_name_LENGTHS_ErrorCount
          ,le.clean_phone_CUSTOM_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.prim_range_LENGTHS_ErrorCount
          ,le.p_city_name_LENGTHS_ErrorCount
          ,le.v_city_name_LENGTHS_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.prep_address_line1_LENGTHS_ErrorCount
          ,le.prep_address_line_last_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_Infutor_NARB));
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
          ,'rcid:' + getFieldTypeText(h.rcid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pid:' + getFieldTypeText(h.pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_type_code:' + getFieldTypeText(h.address_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'url:' + getFieldTypeText(h.url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic1:' + getFieldTypeText(h.sic1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic2:' + getFieldTypeText(h.sic2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic3:' + getFieldTypeText(h.sic3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic4:' + getFieldTypeText(h.sic4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic5:' + getFieldTypeText(h.sic5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'incorporation_state:' + getFieldTypeText(h.incorporation_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_title:' + getFieldTypeText(h.contact_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'normcompany_type:' + getFieldTypeText(h.normcompany_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_company_name:' + getFieldTypeText(h.clean_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phone:' + getFieldTypeText(h.clean_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_address_line1:' + getFieldTypeText(h.prep_address_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_address_line_last:' + getFieldTypeText(h.prep_address_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_rcid_cnt
          ,le.populated_powid_cnt
          ,le.populated_proxid_cnt
          ,le.populated_seleid_cnt
          ,le.populated_orgid_cnt
          ,le.populated_ultid_cnt
          ,le.populated_did_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_process_date_cnt
          ,le.populated_record_type_cnt
          ,le.populated_pid_cnt
          ,le.populated_address_type_code_cnt
          ,le.populated_url_cnt
          ,le.populated_sic1_cnt
          ,le.populated_sic2_cnt
          ,le.populated_sic3_cnt
          ,le.populated_sic4_cnt
          ,le.populated_sic5_cnt
          ,le.populated_incorporation_state_cnt
          ,le.populated_email_cnt
          ,le.populated_contact_title_cnt
          ,le.populated_normcompany_type_cnt
          ,le.populated_clean_company_name_cnt
          ,le.populated_clean_phone_cnt
          ,le.populated_fname_cnt
          ,le.populated_lname_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_prep_address_line1_cnt
          ,le.populated_prep_address_line_last_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_rcid_pcnt
          ,le.populated_powid_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_did_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_pid_pcnt
          ,le.populated_address_type_code_pcnt
          ,le.populated_url_pcnt
          ,le.populated_sic1_pcnt
          ,le.populated_sic2_pcnt
          ,le.populated_sic3_pcnt
          ,le.populated_sic4_pcnt
          ,le.populated_sic5_pcnt
          ,le.populated_incorporation_state_pcnt
          ,le.populated_email_pcnt
          ,le.populated_contact_title_pcnt
          ,le.populated_normcompany_type_pcnt
          ,le.populated_clean_company_name_pcnt
          ,le.populated_clean_phone_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_prep_address_line1_pcnt
          ,le.populated_prep_address_line_last_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,36,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_Infutor_NARB));
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
 
EXPORT StandardStats(DATASET(Base_Layout_Infutor_NARB) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Infutor_NARB, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
