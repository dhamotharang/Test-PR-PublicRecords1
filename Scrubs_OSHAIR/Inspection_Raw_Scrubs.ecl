IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_Oshair; // Import modules for FieldTypes attribute definitions
EXPORT Inspection_Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 35;
  EXPORT NumRulesFromFieldType := 35;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 35;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Inspection_Raw_Layout)
    UNSIGNED1 activity_nr_Invalid;
    UNSIGNED1 reporting_id_Invalid;
    UNSIGNED1 state_flag_Invalid;
    UNSIGNED1 site_state_Invalid;
    UNSIGNED1 site_zip_Invalid;
    UNSIGNED1 owner_type_Invalid;
    UNSIGNED1 owner_code_Invalid;
    UNSIGNED1 adv_notice_Invalid;
    UNSIGNED1 safety_hlth_Invalid;
    UNSIGNED1 sic_code_Invalid;
    UNSIGNED1 naics_code_Invalid;
    UNSIGNED1 insp_type_Invalid;
    UNSIGNED1 insp_scope_Invalid;
    UNSIGNED1 why_no_insp_Invalid;
    UNSIGNED1 union_status_Invalid;
    UNSIGNED1 safety_manuf_Invalid;
    UNSIGNED1 safety_const_Invalid;
    UNSIGNED1 safety_marit_Invalid;
    UNSIGNED1 health_manuf_Invalid;
    UNSIGNED1 health_const_Invalid;
    UNSIGNED1 health_marit_Invalid;
    UNSIGNED1 migrant_Invalid;
    UNSIGNED1 mail_state_Invalid;
    UNSIGNED1 mail_zip_Invalid;
    UNSIGNED1 host_est_key_Invalid;
    UNSIGNED1 nr_in_estab_Invalid;
    UNSIGNED1 open_date_Invalid;
    UNSIGNED1 case_mod_date_Invalid;
    UNSIGNED1 close_conf_date_Invalid;
    UNSIGNED1 close_case_date_Invalid;
    UNSIGNED1 open_year_Invalid;
    UNSIGNED1 case_mod_year_Invalid;
    UNSIGNED1 close_conf_year_Invalid;
    UNSIGNED1 close_case_year_Invalid;
    UNSIGNED1 estab_name_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Inspection_Raw_Layout)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Inspection_Raw_Layout) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.activity_nr_Invalid := Inspection_Raw_Fields.InValid_activity_nr((SALT311.StrType)le.activity_nr);
    SELF.reporting_id_Invalid := Inspection_Raw_Fields.InValid_reporting_id((SALT311.StrType)le.reporting_id);
    SELF.state_flag_Invalid := Inspection_Raw_Fields.InValid_state_flag((SALT311.StrType)le.state_flag);
    SELF.site_state_Invalid := Inspection_Raw_Fields.InValid_site_state((SALT311.StrType)le.site_state);
    SELF.site_zip_Invalid := Inspection_Raw_Fields.InValid_site_zip((SALT311.StrType)le.site_zip);
    SELF.owner_type_Invalid := Inspection_Raw_Fields.InValid_owner_type((SALT311.StrType)le.owner_type);
    SELF.owner_code_Invalid := Inspection_Raw_Fields.InValid_owner_code((SALT311.StrType)le.owner_code);
    SELF.adv_notice_Invalid := Inspection_Raw_Fields.InValid_adv_notice((SALT311.StrType)le.adv_notice);
    SELF.safety_hlth_Invalid := Inspection_Raw_Fields.InValid_safety_hlth((SALT311.StrType)le.safety_hlth);
    SELF.sic_code_Invalid := Inspection_Raw_Fields.InValid_sic_code((SALT311.StrType)le.sic_code);
    SELF.naics_code_Invalid := Inspection_Raw_Fields.InValid_naics_code((SALT311.StrType)le.naics_code);
    SELF.insp_type_Invalid := Inspection_Raw_Fields.InValid_insp_type((SALT311.StrType)le.insp_type);
    SELF.insp_scope_Invalid := Inspection_Raw_Fields.InValid_insp_scope((SALT311.StrType)le.insp_scope);
    SELF.why_no_insp_Invalid := Inspection_Raw_Fields.InValid_why_no_insp((SALT311.StrType)le.why_no_insp);
    SELF.union_status_Invalid := Inspection_Raw_Fields.InValid_union_status((SALT311.StrType)le.union_status);
    SELF.safety_manuf_Invalid := Inspection_Raw_Fields.InValid_safety_manuf((SALT311.StrType)le.safety_manuf);
    SELF.safety_const_Invalid := Inspection_Raw_Fields.InValid_safety_const((SALT311.StrType)le.safety_const);
    SELF.safety_marit_Invalid := Inspection_Raw_Fields.InValid_safety_marit((SALT311.StrType)le.safety_marit);
    SELF.health_manuf_Invalid := Inspection_Raw_Fields.InValid_health_manuf((SALT311.StrType)le.health_manuf);
    SELF.health_const_Invalid := Inspection_Raw_Fields.InValid_health_const((SALT311.StrType)le.health_const);
    SELF.health_marit_Invalid := Inspection_Raw_Fields.InValid_health_marit((SALT311.StrType)le.health_marit);
    SELF.migrant_Invalid := Inspection_Raw_Fields.InValid_migrant((SALT311.StrType)le.migrant);
    SELF.mail_state_Invalid := Inspection_Raw_Fields.InValid_mail_state((SALT311.StrType)le.mail_state);
    SELF.mail_zip_Invalid := Inspection_Raw_Fields.InValid_mail_zip((SALT311.StrType)le.mail_zip);
    SELF.host_est_key_Invalid := Inspection_Raw_Fields.InValid_host_est_key((SALT311.StrType)le.host_est_key);
    SELF.nr_in_estab_Invalid := Inspection_Raw_Fields.InValid_nr_in_estab((SALT311.StrType)le.nr_in_estab);
    SELF.open_date_Invalid := Inspection_Raw_Fields.InValid_open_date((SALT311.StrType)le.open_date);
    SELF.case_mod_date_Invalid := Inspection_Raw_Fields.InValid_case_mod_date((SALT311.StrType)le.case_mod_date);
    SELF.close_conf_date_Invalid := Inspection_Raw_Fields.InValid_close_conf_date((SALT311.StrType)le.close_conf_date);
    SELF.close_case_date_Invalid := Inspection_Raw_Fields.InValid_close_case_date((SALT311.StrType)le.close_case_date);
    SELF.open_year_Invalid := Inspection_Raw_Fields.InValid_open_year((SALT311.StrType)le.open_year);
    SELF.case_mod_year_Invalid := Inspection_Raw_Fields.InValid_case_mod_year((SALT311.StrType)le.case_mod_year);
    SELF.close_conf_year_Invalid := Inspection_Raw_Fields.InValid_close_conf_year((SALT311.StrType)le.close_conf_year);
    SELF.close_case_year_Invalid := Inspection_Raw_Fields.InValid_close_case_year((SALT311.StrType)le.close_case_year);
    SELF.estab_name_Invalid := Inspection_Raw_Fields.InValid_estab_name((SALT311.StrType)le.estab_name);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Inspection_Raw_Layout);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.activity_nr_Invalid << 0 ) + ( le.reporting_id_Invalid << 1 ) + ( le.state_flag_Invalid << 2 ) + ( le.site_state_Invalid << 3 ) + ( le.site_zip_Invalid << 4 ) + ( le.owner_type_Invalid << 5 ) + ( le.owner_code_Invalid << 6 ) + ( le.adv_notice_Invalid << 7 ) + ( le.safety_hlth_Invalid << 8 ) + ( le.sic_code_Invalid << 9 ) + ( le.naics_code_Invalid << 10 ) + ( le.insp_type_Invalid << 11 ) + ( le.insp_scope_Invalid << 12 ) + ( le.why_no_insp_Invalid << 13 ) + ( le.union_status_Invalid << 14 ) + ( le.safety_manuf_Invalid << 15 ) + ( le.safety_const_Invalid << 16 ) + ( le.safety_marit_Invalid << 17 ) + ( le.health_manuf_Invalid << 18 ) + ( le.health_const_Invalid << 19 ) + ( le.health_marit_Invalid << 20 ) + ( le.migrant_Invalid << 21 ) + ( le.mail_state_Invalid << 22 ) + ( le.mail_zip_Invalid << 23 ) + ( le.host_est_key_Invalid << 24 ) + ( le.nr_in_estab_Invalid << 25 ) + ( le.open_date_Invalid << 26 ) + ( le.case_mod_date_Invalid << 27 ) + ( le.close_conf_date_Invalid << 28 ) + ( le.close_case_date_Invalid << 29 ) + ( le.open_year_Invalid << 30 ) + ( le.case_mod_year_Invalid << 31 ) + ( le.close_conf_year_Invalid << 32 ) + ( le.close_case_year_Invalid << 33 ) + ( le.estab_name_Invalid << 34 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Inspection_Raw_Layout);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.activity_nr_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.reporting_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.state_flag_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.site_state_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.site_zip_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.owner_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.owner_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.adv_notice_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.safety_hlth_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sic_code_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.naics_code_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.insp_type_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.insp_scope_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.why_no_insp_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.union_status_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.safety_manuf_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.safety_const_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.safety_marit_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.health_manuf_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.health_const_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.health_marit_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.migrant_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.mail_state_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.mail_zip_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.host_est_key_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.nr_in_estab_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.open_date_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.case_mod_date_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.close_conf_date_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.close_case_date_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.open_year_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.case_mod_year_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.close_conf_year_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.close_case_year_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.estab_name_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    activity_nr_CUSTOM_ErrorCount := COUNT(GROUP,h.activity_nr_Invalid=1);
    reporting_id_CUSTOM_ErrorCount := COUNT(GROUP,h.reporting_id_Invalid=1);
    state_flag_CUSTOM_ErrorCount := COUNT(GROUP,h.state_flag_Invalid=1);
    site_state_CUSTOM_ErrorCount := COUNT(GROUP,h.site_state_Invalid=1);
    site_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.site_zip_Invalid=1);
    owner_type_CUSTOM_ErrorCount := COUNT(GROUP,h.owner_type_Invalid=1);
    owner_code_CUSTOM_ErrorCount := COUNT(GROUP,h.owner_code_Invalid=1);
    adv_notice_CUSTOM_ErrorCount := COUNT(GROUP,h.adv_notice_Invalid=1);
    safety_hlth_CUSTOM_ErrorCount := COUNT(GROUP,h.safety_hlth_Invalid=1);
    sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sic_code_Invalid=1);
    naics_code_CUSTOM_ErrorCount := COUNT(GROUP,h.naics_code_Invalid=1);
    insp_type_CUSTOM_ErrorCount := COUNT(GROUP,h.insp_type_Invalid=1);
    insp_scope_CUSTOM_ErrorCount := COUNT(GROUP,h.insp_scope_Invalid=1);
    why_no_insp_CUSTOM_ErrorCount := COUNT(GROUP,h.why_no_insp_Invalid=1);
    union_status_CUSTOM_ErrorCount := COUNT(GROUP,h.union_status_Invalid=1);
    safety_manuf_CUSTOM_ErrorCount := COUNT(GROUP,h.safety_manuf_Invalid=1);
    safety_const_CUSTOM_ErrorCount := COUNT(GROUP,h.safety_const_Invalid=1);
    safety_marit_CUSTOM_ErrorCount := COUNT(GROUP,h.safety_marit_Invalid=1);
    health_manuf_CUSTOM_ErrorCount := COUNT(GROUP,h.health_manuf_Invalid=1);
    health_const_CUSTOM_ErrorCount := COUNT(GROUP,h.health_const_Invalid=1);
    health_marit_CUSTOM_ErrorCount := COUNT(GROUP,h.health_marit_Invalid=1);
    migrant_CUSTOM_ErrorCount := COUNT(GROUP,h.migrant_Invalid=1);
    mail_state_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_state_Invalid=1);
    mail_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_zip_Invalid=1);
    host_est_key_CUSTOM_ErrorCount := COUNT(GROUP,h.host_est_key_Invalid=1);
    nr_in_estab_CUSTOM_ErrorCount := COUNT(GROUP,h.nr_in_estab_Invalid=1);
    open_date_CUSTOM_ErrorCount := COUNT(GROUP,h.open_date_Invalid=1);
    case_mod_date_CUSTOM_ErrorCount := COUNT(GROUP,h.case_mod_date_Invalid=1);
    close_conf_date_CUSTOM_ErrorCount := COUNT(GROUP,h.close_conf_date_Invalid=1);
    close_case_date_CUSTOM_ErrorCount := COUNT(GROUP,h.close_case_date_Invalid=1);
    open_year_CUSTOM_ErrorCount := COUNT(GROUP,h.open_year_Invalid=1);
    case_mod_year_CUSTOM_ErrorCount := COUNT(GROUP,h.case_mod_year_Invalid=1);
    close_conf_year_CUSTOM_ErrorCount := COUNT(GROUP,h.close_conf_year_Invalid=1);
    close_case_year_CUSTOM_ErrorCount := COUNT(GROUP,h.close_case_year_Invalid=1);
    estab_name_CUSTOM_ErrorCount := COUNT(GROUP,h.estab_name_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.activity_nr_Invalid > 0 OR h.reporting_id_Invalid > 0 OR h.state_flag_Invalid > 0 OR h.site_state_Invalid > 0 OR h.site_zip_Invalid > 0 OR h.owner_type_Invalid > 0 OR h.owner_code_Invalid > 0 OR h.adv_notice_Invalid > 0 OR h.safety_hlth_Invalid > 0 OR h.sic_code_Invalid > 0 OR h.naics_code_Invalid > 0 OR h.insp_type_Invalid > 0 OR h.insp_scope_Invalid > 0 OR h.why_no_insp_Invalid > 0 OR h.union_status_Invalid > 0 OR h.safety_manuf_Invalid > 0 OR h.safety_const_Invalid > 0 OR h.safety_marit_Invalid > 0 OR h.health_manuf_Invalid > 0 OR h.health_const_Invalid > 0 OR h.health_marit_Invalid > 0 OR h.migrant_Invalid > 0 OR h.mail_state_Invalid > 0 OR h.mail_zip_Invalid > 0 OR h.host_est_key_Invalid > 0 OR h.nr_in_estab_Invalid > 0 OR h.open_date_Invalid > 0 OR h.case_mod_date_Invalid > 0 OR h.close_conf_date_Invalid > 0 OR h.close_case_date_Invalid > 0 OR h.open_year_Invalid > 0 OR h.case_mod_year_Invalid > 0 OR h.close_conf_year_Invalid > 0 OR h.close_case_year_Invalid > 0 OR h.estab_name_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.activity_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.reporting_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_flag_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.site_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.site_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.owner_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.owner_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.adv_notice_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.safety_hlth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insp_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insp_scope_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.why_no_insp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.union_status_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.safety_manuf_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.safety_const_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.safety_marit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.health_manuf_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.health_const_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.health_marit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.migrant_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.host_est_key_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nr_in_estab_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.open_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.case_mod_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.close_conf_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.close_case_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.open_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.case_mod_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.close_conf_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.close_case_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.estab_name_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.activity_nr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.reporting_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_flag_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.site_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.site_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.owner_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.owner_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.adv_notice_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.safety_hlth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insp_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.insp_scope_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.why_no_insp_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.union_status_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.safety_manuf_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.safety_const_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.safety_marit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.health_manuf_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.health_const_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.health_marit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.migrant_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mail_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.host_est_key_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.nr_in_estab_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.open_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.case_mod_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.close_conf_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.close_case_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.open_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.case_mod_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.close_conf_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.close_case_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.estab_name_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.activity_nr_Invalid,le.reporting_id_Invalid,le.state_flag_Invalid,le.site_state_Invalid,le.site_zip_Invalid,le.owner_type_Invalid,le.owner_code_Invalid,le.adv_notice_Invalid,le.safety_hlth_Invalid,le.sic_code_Invalid,le.naics_code_Invalid,le.insp_type_Invalid,le.insp_scope_Invalid,le.why_no_insp_Invalid,le.union_status_Invalid,le.safety_manuf_Invalid,le.safety_const_Invalid,le.safety_marit_Invalid,le.health_manuf_Invalid,le.health_const_Invalid,le.health_marit_Invalid,le.migrant_Invalid,le.mail_state_Invalid,le.mail_zip_Invalid,le.host_est_key_Invalid,le.nr_in_estab_Invalid,le.open_date_Invalid,le.case_mod_date_Invalid,le.close_conf_date_Invalid,le.close_case_date_Invalid,le.open_year_Invalid,le.case_mod_year_Invalid,le.close_conf_year_Invalid,le.close_case_year_Invalid,le.estab_name_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Inspection_Raw_Fields.InvalidMessage_activity_nr(le.activity_nr_Invalid),Inspection_Raw_Fields.InvalidMessage_reporting_id(le.reporting_id_Invalid),Inspection_Raw_Fields.InvalidMessage_state_flag(le.state_flag_Invalid),Inspection_Raw_Fields.InvalidMessage_site_state(le.site_state_Invalid),Inspection_Raw_Fields.InvalidMessage_site_zip(le.site_zip_Invalid),Inspection_Raw_Fields.InvalidMessage_owner_type(le.owner_type_Invalid),Inspection_Raw_Fields.InvalidMessage_owner_code(le.owner_code_Invalid),Inspection_Raw_Fields.InvalidMessage_adv_notice(le.adv_notice_Invalid),Inspection_Raw_Fields.InvalidMessage_safety_hlth(le.safety_hlth_Invalid),Inspection_Raw_Fields.InvalidMessage_sic_code(le.sic_code_Invalid),Inspection_Raw_Fields.InvalidMessage_naics_code(le.naics_code_Invalid),Inspection_Raw_Fields.InvalidMessage_insp_type(le.insp_type_Invalid),Inspection_Raw_Fields.InvalidMessage_insp_scope(le.insp_scope_Invalid),Inspection_Raw_Fields.InvalidMessage_why_no_insp(le.why_no_insp_Invalid),Inspection_Raw_Fields.InvalidMessage_union_status(le.union_status_Invalid),Inspection_Raw_Fields.InvalidMessage_safety_manuf(le.safety_manuf_Invalid),Inspection_Raw_Fields.InvalidMessage_safety_const(le.safety_const_Invalid),Inspection_Raw_Fields.InvalidMessage_safety_marit(le.safety_marit_Invalid),Inspection_Raw_Fields.InvalidMessage_health_manuf(le.health_manuf_Invalid),Inspection_Raw_Fields.InvalidMessage_health_const(le.health_const_Invalid),Inspection_Raw_Fields.InvalidMessage_health_marit(le.health_marit_Invalid),Inspection_Raw_Fields.InvalidMessage_migrant(le.migrant_Invalid),Inspection_Raw_Fields.InvalidMessage_mail_state(le.mail_state_Invalid),Inspection_Raw_Fields.InvalidMessage_mail_zip(le.mail_zip_Invalid),Inspection_Raw_Fields.InvalidMessage_host_est_key(le.host_est_key_Invalid),Inspection_Raw_Fields.InvalidMessage_nr_in_estab(le.nr_in_estab_Invalid),Inspection_Raw_Fields.InvalidMessage_open_date(le.open_date_Invalid),Inspection_Raw_Fields.InvalidMessage_case_mod_date(le.case_mod_date_Invalid),Inspection_Raw_Fields.InvalidMessage_close_conf_date(le.close_conf_date_Invalid),Inspection_Raw_Fields.InvalidMessage_close_case_date(le.close_case_date_Invalid),Inspection_Raw_Fields.InvalidMessage_open_year(le.open_year_Invalid),Inspection_Raw_Fields.InvalidMessage_case_mod_year(le.case_mod_year_Invalid),Inspection_Raw_Fields.InvalidMessage_close_conf_year(le.close_conf_year_Invalid),Inspection_Raw_Fields.InvalidMessage_close_case_year(le.close_case_year_Invalid),Inspection_Raw_Fields.InvalidMessage_estab_name(le.estab_name_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.activity_nr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.reporting_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_flag_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.site_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.site_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.owner_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.owner_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.adv_notice_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.safety_hlth_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naics_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.insp_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.insp_scope_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.why_no_insp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.union_status_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.safety_manuf_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.safety_const_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.safety_marit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.health_manuf_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.health_const_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.health_marit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.migrant_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.host_est_key_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.nr_in_estab_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.open_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.case_mod_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.close_conf_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.close_case_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.open_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.case_mod_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.close_conf_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.close_case_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.estab_name_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'activity_nr','reporting_id','state_flag','site_state','site_zip','owner_type','owner_code','adv_notice','safety_hlth','sic_code','naics_code','insp_type','insp_scope','why_no_insp','union_status','safety_manuf','safety_const','safety_marit','health_manuf','health_const','health_marit','migrant','mail_state','mail_zip','host_est_key','nr_in_estab','open_date','case_mod_date','close_conf_date','close_case_date','open_year','case_mod_year','close_conf_year','close_case_year','estab_name','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_state_flag','invalid_state','invalid_numeric_blank','invalid_owner_type','invalid_numeric_blank','invalid_adv_notice','invalid_safety_hlth','invalid_sic','invalid_naics','invalid_insp_type','invalid_insp_scope','invalid_why_no_insp','invalid_union_status','invalid_X_blank','invalid_X_blank','invalid_X_blank','invalid_X_blank','invalid_X_blank','invalid_X_blank','invalid_X_blank','invalid_state','invalid_numeric_blank','invalid_host_est_key','invalid_numeric_blank','invalid_date_dashes','invalid_date_dashes','invalid_date_dashes','invalid_date_dashes','invalid_year','invalid_year','invalid_year','invalid_year','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.activity_nr,(SALT311.StrType)le.reporting_id,(SALT311.StrType)le.state_flag,(SALT311.StrType)le.site_state,(SALT311.StrType)le.site_zip,(SALT311.StrType)le.owner_type,(SALT311.StrType)le.owner_code,(SALT311.StrType)le.adv_notice,(SALT311.StrType)le.safety_hlth,(SALT311.StrType)le.sic_code,(SALT311.StrType)le.naics_code,(SALT311.StrType)le.insp_type,(SALT311.StrType)le.insp_scope,(SALT311.StrType)le.why_no_insp,(SALT311.StrType)le.union_status,(SALT311.StrType)le.safety_manuf,(SALT311.StrType)le.safety_const,(SALT311.StrType)le.safety_marit,(SALT311.StrType)le.health_manuf,(SALT311.StrType)le.health_const,(SALT311.StrType)le.health_marit,(SALT311.StrType)le.migrant,(SALT311.StrType)le.mail_state,(SALT311.StrType)le.mail_zip,(SALT311.StrType)le.host_est_key,(SALT311.StrType)le.nr_in_estab,(SALT311.StrType)le.open_date,(SALT311.StrType)le.case_mod_date,(SALT311.StrType)le.close_conf_date,(SALT311.StrType)le.close_case_date,(SALT311.StrType)le.open_year,(SALT311.StrType)le.case_mod_year,(SALT311.StrType)le.close_conf_year,(SALT311.StrType)le.close_case_year,(SALT311.StrType)le.estab_name,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,35,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Inspection_Raw_Layout) prevDS = DATASET([], Inspection_Raw_Layout), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'activity_nr:invalid_numeric:CUSTOM'
          ,'reporting_id:invalid_numeric:CUSTOM'
          ,'state_flag:invalid_state_flag:CUSTOM'
          ,'site_state:invalid_state:CUSTOM'
          ,'site_zip:invalid_numeric_blank:CUSTOM'
          ,'owner_type:invalid_owner_type:CUSTOM'
          ,'owner_code:invalid_numeric_blank:CUSTOM'
          ,'adv_notice:invalid_adv_notice:CUSTOM'
          ,'safety_hlth:invalid_safety_hlth:CUSTOM'
          ,'sic_code:invalid_sic:CUSTOM'
          ,'naics_code:invalid_naics:CUSTOM'
          ,'insp_type:invalid_insp_type:CUSTOM'
          ,'insp_scope:invalid_insp_scope:CUSTOM'
          ,'why_no_insp:invalid_why_no_insp:CUSTOM'
          ,'union_status:invalid_union_status:CUSTOM'
          ,'safety_manuf:invalid_X_blank:CUSTOM'
          ,'safety_const:invalid_X_blank:CUSTOM'
          ,'safety_marit:invalid_X_blank:CUSTOM'
          ,'health_manuf:invalid_X_blank:CUSTOM'
          ,'health_const:invalid_X_blank:CUSTOM'
          ,'health_marit:invalid_X_blank:CUSTOM'
          ,'migrant:invalid_X_blank:CUSTOM'
          ,'mail_state:invalid_state:CUSTOM'
          ,'mail_zip:invalid_numeric_blank:CUSTOM'
          ,'host_est_key:invalid_host_est_key:CUSTOM'
          ,'nr_in_estab:invalid_numeric_blank:CUSTOM'
          ,'open_date:invalid_date_dashes:CUSTOM'
          ,'case_mod_date:invalid_date_dashes:CUSTOM'
          ,'close_conf_date:invalid_date_dashes:CUSTOM'
          ,'close_case_date:invalid_date_dashes:CUSTOM'
          ,'open_year:invalid_year:CUSTOM'
          ,'case_mod_year:invalid_year:CUSTOM'
          ,'close_conf_year:invalid_year:CUSTOM'
          ,'close_case_year:invalid_year:CUSTOM'
          ,'estab_name:invalid_mandatory:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Inspection_Raw_Fields.InvalidMessage_activity_nr(1)
          ,Inspection_Raw_Fields.InvalidMessage_reporting_id(1)
          ,Inspection_Raw_Fields.InvalidMessage_state_flag(1)
          ,Inspection_Raw_Fields.InvalidMessage_site_state(1)
          ,Inspection_Raw_Fields.InvalidMessage_site_zip(1)
          ,Inspection_Raw_Fields.InvalidMessage_owner_type(1)
          ,Inspection_Raw_Fields.InvalidMessage_owner_code(1)
          ,Inspection_Raw_Fields.InvalidMessage_adv_notice(1)
          ,Inspection_Raw_Fields.InvalidMessage_safety_hlth(1)
          ,Inspection_Raw_Fields.InvalidMessage_sic_code(1)
          ,Inspection_Raw_Fields.InvalidMessage_naics_code(1)
          ,Inspection_Raw_Fields.InvalidMessage_insp_type(1)
          ,Inspection_Raw_Fields.InvalidMessage_insp_scope(1)
          ,Inspection_Raw_Fields.InvalidMessage_why_no_insp(1)
          ,Inspection_Raw_Fields.InvalidMessage_union_status(1)
          ,Inspection_Raw_Fields.InvalidMessage_safety_manuf(1)
          ,Inspection_Raw_Fields.InvalidMessage_safety_const(1)
          ,Inspection_Raw_Fields.InvalidMessage_safety_marit(1)
          ,Inspection_Raw_Fields.InvalidMessage_health_manuf(1)
          ,Inspection_Raw_Fields.InvalidMessage_health_const(1)
          ,Inspection_Raw_Fields.InvalidMessage_health_marit(1)
          ,Inspection_Raw_Fields.InvalidMessage_migrant(1)
          ,Inspection_Raw_Fields.InvalidMessage_mail_state(1)
          ,Inspection_Raw_Fields.InvalidMessage_mail_zip(1)
          ,Inspection_Raw_Fields.InvalidMessage_host_est_key(1)
          ,Inspection_Raw_Fields.InvalidMessage_nr_in_estab(1)
          ,Inspection_Raw_Fields.InvalidMessage_open_date(1)
          ,Inspection_Raw_Fields.InvalidMessage_case_mod_date(1)
          ,Inspection_Raw_Fields.InvalidMessage_close_conf_date(1)
          ,Inspection_Raw_Fields.InvalidMessage_close_case_date(1)
          ,Inspection_Raw_Fields.InvalidMessage_open_year(1)
          ,Inspection_Raw_Fields.InvalidMessage_case_mod_year(1)
          ,Inspection_Raw_Fields.InvalidMessage_close_conf_year(1)
          ,Inspection_Raw_Fields.InvalidMessage_close_case_year(1)
          ,Inspection_Raw_Fields.InvalidMessage_estab_name(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.activity_nr_CUSTOM_ErrorCount
          ,le.reporting_id_CUSTOM_ErrorCount
          ,le.state_flag_CUSTOM_ErrorCount
          ,le.site_state_CUSTOM_ErrorCount
          ,le.site_zip_CUSTOM_ErrorCount
          ,le.owner_type_CUSTOM_ErrorCount
          ,le.owner_code_CUSTOM_ErrorCount
          ,le.adv_notice_CUSTOM_ErrorCount
          ,le.safety_hlth_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.naics_code_CUSTOM_ErrorCount
          ,le.insp_type_CUSTOM_ErrorCount
          ,le.insp_scope_CUSTOM_ErrorCount
          ,le.why_no_insp_CUSTOM_ErrorCount
          ,le.union_status_CUSTOM_ErrorCount
          ,le.safety_manuf_CUSTOM_ErrorCount
          ,le.safety_const_CUSTOM_ErrorCount
          ,le.safety_marit_CUSTOM_ErrorCount
          ,le.health_manuf_CUSTOM_ErrorCount
          ,le.health_const_CUSTOM_ErrorCount
          ,le.health_marit_CUSTOM_ErrorCount
          ,le.migrant_CUSTOM_ErrorCount
          ,le.mail_state_CUSTOM_ErrorCount
          ,le.mail_zip_CUSTOM_ErrorCount
          ,le.host_est_key_CUSTOM_ErrorCount
          ,le.nr_in_estab_CUSTOM_ErrorCount
          ,le.open_date_CUSTOM_ErrorCount
          ,le.case_mod_date_CUSTOM_ErrorCount
          ,le.close_conf_date_CUSTOM_ErrorCount
          ,le.close_case_date_CUSTOM_ErrorCount
          ,le.open_year_CUSTOM_ErrorCount
          ,le.case_mod_year_CUSTOM_ErrorCount
          ,le.close_conf_year_CUSTOM_ErrorCount
          ,le.close_case_year_CUSTOM_ErrorCount
          ,le.estab_name_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.activity_nr_CUSTOM_ErrorCount
          ,le.reporting_id_CUSTOM_ErrorCount
          ,le.state_flag_CUSTOM_ErrorCount
          ,le.site_state_CUSTOM_ErrorCount
          ,le.site_zip_CUSTOM_ErrorCount
          ,le.owner_type_CUSTOM_ErrorCount
          ,le.owner_code_CUSTOM_ErrorCount
          ,le.adv_notice_CUSTOM_ErrorCount
          ,le.safety_hlth_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.naics_code_CUSTOM_ErrorCount
          ,le.insp_type_CUSTOM_ErrorCount
          ,le.insp_scope_CUSTOM_ErrorCount
          ,le.why_no_insp_CUSTOM_ErrorCount
          ,le.union_status_CUSTOM_ErrorCount
          ,le.safety_manuf_CUSTOM_ErrorCount
          ,le.safety_const_CUSTOM_ErrorCount
          ,le.safety_marit_CUSTOM_ErrorCount
          ,le.health_manuf_CUSTOM_ErrorCount
          ,le.health_const_CUSTOM_ErrorCount
          ,le.health_marit_CUSTOM_ErrorCount
          ,le.migrant_CUSTOM_ErrorCount
          ,le.mail_state_CUSTOM_ErrorCount
          ,le.mail_zip_CUSTOM_ErrorCount
          ,le.host_est_key_CUSTOM_ErrorCount
          ,le.nr_in_estab_CUSTOM_ErrorCount
          ,le.open_date_CUSTOM_ErrorCount
          ,le.case_mod_date_CUSTOM_ErrorCount
          ,le.close_conf_date_CUSTOM_ErrorCount
          ,le.close_case_date_CUSTOM_ErrorCount
          ,le.open_year_CUSTOM_ErrorCount
          ,le.case_mod_year_CUSTOM_ErrorCount
          ,le.close_conf_year_CUSTOM_ErrorCount
          ,le.close_case_year_CUSTOM_ErrorCount
          ,le.estab_name_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Inspection_Raw_hygiene(PROJECT(h, Inspection_Raw_Layout));
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
          ,'activity_nr:' + getFieldTypeText(h.activity_nr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reporting_id:' + getFieldTypeText(h.reporting_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_flag:' + getFieldTypeText(h.state_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_state:' + getFieldTypeText(h.site_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'site_zip:' + getFieldTypeText(h.site_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'owner_type:' + getFieldTypeText(h.owner_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'owner_code:' + getFieldTypeText(h.owner_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'adv_notice:' + getFieldTypeText(h.adv_notice) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'safety_hlth:' + getFieldTypeText(h.safety_hlth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic_code:' + getFieldTypeText(h.sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naics_code:' + getFieldTypeText(h.naics_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insp_type:' + getFieldTypeText(h.insp_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insp_scope:' + getFieldTypeText(h.insp_scope) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'why_no_insp:' + getFieldTypeText(h.why_no_insp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'union_status:' + getFieldTypeText(h.union_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'safety_manuf:' + getFieldTypeText(h.safety_manuf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'safety_const:' + getFieldTypeText(h.safety_const) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'safety_marit:' + getFieldTypeText(h.safety_marit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'health_manuf:' + getFieldTypeText(h.health_manuf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'health_const:' + getFieldTypeText(h.health_const) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'health_marit:' + getFieldTypeText(h.health_marit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'migrant:' + getFieldTypeText(h.migrant) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_state:' + getFieldTypeText(h.mail_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_zip:' + getFieldTypeText(h.mail_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'host_est_key:' + getFieldTypeText(h.host_est_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nr_in_estab:' + getFieldTypeText(h.nr_in_estab) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'open_date:' + getFieldTypeText(h.open_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_mod_date:' + getFieldTypeText(h.case_mod_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'close_conf_date:' + getFieldTypeText(h.close_conf_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'close_case_date:' + getFieldTypeText(h.close_case_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'open_year:' + getFieldTypeText(h.open_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_mod_year:' + getFieldTypeText(h.case_mod_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'close_conf_year:' + getFieldTypeText(h.close_conf_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'close_case_year:' + getFieldTypeText(h.close_case_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'estab_name:' + getFieldTypeText(h.estab_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_activity_nr_cnt
          ,le.populated_reporting_id_cnt
          ,le.populated_state_flag_cnt
          ,le.populated_site_state_cnt
          ,le.populated_site_zip_cnt
          ,le.populated_owner_type_cnt
          ,le.populated_owner_code_cnt
          ,le.populated_adv_notice_cnt
          ,le.populated_safety_hlth_cnt
          ,le.populated_sic_code_cnt
          ,le.populated_naics_code_cnt
          ,le.populated_insp_type_cnt
          ,le.populated_insp_scope_cnt
          ,le.populated_why_no_insp_cnt
          ,le.populated_union_status_cnt
          ,le.populated_safety_manuf_cnt
          ,le.populated_safety_const_cnt
          ,le.populated_safety_marit_cnt
          ,le.populated_health_manuf_cnt
          ,le.populated_health_const_cnt
          ,le.populated_health_marit_cnt
          ,le.populated_migrant_cnt
          ,le.populated_mail_state_cnt
          ,le.populated_mail_zip_cnt
          ,le.populated_host_est_key_cnt
          ,le.populated_nr_in_estab_cnt
          ,le.populated_open_date_cnt
          ,le.populated_case_mod_date_cnt
          ,le.populated_close_conf_date_cnt
          ,le.populated_close_case_date_cnt
          ,le.populated_open_year_cnt
          ,le.populated_case_mod_year_cnt
          ,le.populated_close_conf_year_cnt
          ,le.populated_close_case_year_cnt
          ,le.populated_estab_name_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_activity_nr_pcnt
          ,le.populated_reporting_id_pcnt
          ,le.populated_state_flag_pcnt
          ,le.populated_site_state_pcnt
          ,le.populated_site_zip_pcnt
          ,le.populated_owner_type_pcnt
          ,le.populated_owner_code_pcnt
          ,le.populated_adv_notice_pcnt
          ,le.populated_safety_hlth_pcnt
          ,le.populated_sic_code_pcnt
          ,le.populated_naics_code_pcnt
          ,le.populated_insp_type_pcnt
          ,le.populated_insp_scope_pcnt
          ,le.populated_why_no_insp_pcnt
          ,le.populated_union_status_pcnt
          ,le.populated_safety_manuf_pcnt
          ,le.populated_safety_const_pcnt
          ,le.populated_safety_marit_pcnt
          ,le.populated_health_manuf_pcnt
          ,le.populated_health_const_pcnt
          ,le.populated_health_marit_pcnt
          ,le.populated_migrant_pcnt
          ,le.populated_mail_state_pcnt
          ,le.populated_mail_zip_pcnt
          ,le.populated_host_est_key_pcnt
          ,le.populated_nr_in_estab_pcnt
          ,le.populated_open_date_pcnt
          ,le.populated_case_mod_date_pcnt
          ,le.populated_close_conf_date_pcnt
          ,le.populated_close_case_date_pcnt
          ,le.populated_open_year_pcnt
          ,le.populated_case_mod_year_pcnt
          ,le.populated_close_conf_year_pcnt
          ,le.populated_close_case_year_pcnt
          ,le.populated_estab_name_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,35,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Inspection_Raw_Delta(prevDS, PROJECT(h, Inspection_Raw_Layout));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),35,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Inspection_Raw_Layout) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_OSHAIR, Inspection_Raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
