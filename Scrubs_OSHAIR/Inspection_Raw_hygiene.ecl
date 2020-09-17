IMPORT SALT311,STD;
EXPORT Inspection_Raw_hygiene(dataset(Inspection_Raw_Layout) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_activity_nr_cnt := COUNT(GROUP,h.activity_nr <> (TYPEOF(h.activity_nr))'');
    populated_activity_nr_pcnt := AVE(GROUP,IF(h.activity_nr = (TYPEOF(h.activity_nr))'',0,100));
    maxlength_activity_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_nr)));
    avelength_activity_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_nr)),h.activity_nr<>(typeof(h.activity_nr))'');
    populated_reporting_id_cnt := COUNT(GROUP,h.reporting_id <> (TYPEOF(h.reporting_id))'');
    populated_reporting_id_pcnt := AVE(GROUP,IF(h.reporting_id = (TYPEOF(h.reporting_id))'',0,100));
    maxlength_reporting_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reporting_id)));
    avelength_reporting_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reporting_id)),h.reporting_id<>(typeof(h.reporting_id))'');
    populated_state_flag_cnt := COUNT(GROUP,h.state_flag <> (TYPEOF(h.state_flag))'');
    populated_state_flag_pcnt := AVE(GROUP,IF(h.state_flag = (TYPEOF(h.state_flag))'',0,100));
    maxlength_state_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_flag)));
    avelength_state_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_flag)),h.state_flag<>(typeof(h.state_flag))'');
    populated_site_state_cnt := COUNT(GROUP,h.site_state <> (TYPEOF(h.site_state))'');
    populated_site_state_pcnt := AVE(GROUP,IF(h.site_state = (TYPEOF(h.site_state))'',0,100));
    maxlength_site_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_state)));
    avelength_site_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_state)),h.site_state<>(typeof(h.site_state))'');
    populated_site_zip_cnt := COUNT(GROUP,h.site_zip <> (TYPEOF(h.site_zip))'');
    populated_site_zip_pcnt := AVE(GROUP,IF(h.site_zip = (TYPEOF(h.site_zip))'',0,100));
    maxlength_site_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_zip)));
    avelength_site_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_zip)),h.site_zip<>(typeof(h.site_zip))'');
    populated_owner_type_cnt := COUNT(GROUP,h.owner_type <> (TYPEOF(h.owner_type))'');
    populated_owner_type_pcnt := AVE(GROUP,IF(h.owner_type = (TYPEOF(h.owner_type))'',0,100));
    maxlength_owner_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_type)));
    avelength_owner_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_type)),h.owner_type<>(typeof(h.owner_type))'');
    populated_owner_code_cnt := COUNT(GROUP,h.owner_code <> (TYPEOF(h.owner_code))'');
    populated_owner_code_pcnt := AVE(GROUP,IF(h.owner_code = (TYPEOF(h.owner_code))'',0,100));
    maxlength_owner_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_code)));
    avelength_owner_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_code)),h.owner_code<>(typeof(h.owner_code))'');
    populated_adv_notice_cnt := COUNT(GROUP,h.adv_notice <> (TYPEOF(h.adv_notice))'');
    populated_adv_notice_pcnt := AVE(GROUP,IF(h.adv_notice = (TYPEOF(h.adv_notice))'',0,100));
    maxlength_adv_notice := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.adv_notice)));
    avelength_adv_notice := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.adv_notice)),h.adv_notice<>(typeof(h.adv_notice))'');
    populated_safety_hlth_cnt := COUNT(GROUP,h.safety_hlth <> (TYPEOF(h.safety_hlth))'');
    populated_safety_hlth_pcnt := AVE(GROUP,IF(h.safety_hlth = (TYPEOF(h.safety_hlth))'',0,100));
    maxlength_safety_hlth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.safety_hlth)));
    avelength_safety_hlth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.safety_hlth)),h.safety_hlth<>(typeof(h.safety_hlth))'');
    populated_sic_code_cnt := COUNT(GROUP,h.sic_code <> (TYPEOF(h.sic_code))'');
    populated_sic_code_pcnt := AVE(GROUP,IF(h.sic_code = (TYPEOF(h.sic_code))'',0,100));
    maxlength_sic_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_code)));
    avelength_sic_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_code)),h.sic_code<>(typeof(h.sic_code))'');
    populated_naics_code_cnt := COUNT(GROUP,h.naics_code <> (TYPEOF(h.naics_code))'');
    populated_naics_code_pcnt := AVE(GROUP,IF(h.naics_code = (TYPEOF(h.naics_code))'',0,100));
    maxlength_naics_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics_code)));
    avelength_naics_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics_code)),h.naics_code<>(typeof(h.naics_code))'');
    populated_insp_type_cnt := COUNT(GROUP,h.insp_type <> (TYPEOF(h.insp_type))'');
    populated_insp_type_pcnt := AVE(GROUP,IF(h.insp_type = (TYPEOF(h.insp_type))'',0,100));
    maxlength_insp_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insp_type)));
    avelength_insp_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insp_type)),h.insp_type<>(typeof(h.insp_type))'');
    populated_insp_scope_cnt := COUNT(GROUP,h.insp_scope <> (TYPEOF(h.insp_scope))'');
    populated_insp_scope_pcnt := AVE(GROUP,IF(h.insp_scope = (TYPEOF(h.insp_scope))'',0,100));
    maxlength_insp_scope := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insp_scope)));
    avelength_insp_scope := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insp_scope)),h.insp_scope<>(typeof(h.insp_scope))'');
    populated_why_no_insp_cnt := COUNT(GROUP,h.why_no_insp <> (TYPEOF(h.why_no_insp))'');
    populated_why_no_insp_pcnt := AVE(GROUP,IF(h.why_no_insp = (TYPEOF(h.why_no_insp))'',0,100));
    maxlength_why_no_insp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.why_no_insp)));
    avelength_why_no_insp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.why_no_insp)),h.why_no_insp<>(typeof(h.why_no_insp))'');
    populated_union_status_cnt := COUNT(GROUP,h.union_status <> (TYPEOF(h.union_status))'');
    populated_union_status_pcnt := AVE(GROUP,IF(h.union_status = (TYPEOF(h.union_status))'',0,100));
    maxlength_union_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.union_status)));
    avelength_union_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.union_status)),h.union_status<>(typeof(h.union_status))'');
    populated_safety_manuf_cnt := COUNT(GROUP,h.safety_manuf <> (TYPEOF(h.safety_manuf))'');
    populated_safety_manuf_pcnt := AVE(GROUP,IF(h.safety_manuf = (TYPEOF(h.safety_manuf))'',0,100));
    maxlength_safety_manuf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.safety_manuf)));
    avelength_safety_manuf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.safety_manuf)),h.safety_manuf<>(typeof(h.safety_manuf))'');
    populated_safety_const_cnt := COUNT(GROUP,h.safety_const <> (TYPEOF(h.safety_const))'');
    populated_safety_const_pcnt := AVE(GROUP,IF(h.safety_const = (TYPEOF(h.safety_const))'',0,100));
    maxlength_safety_const := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.safety_const)));
    avelength_safety_const := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.safety_const)),h.safety_const<>(typeof(h.safety_const))'');
    populated_safety_marit_cnt := COUNT(GROUP,h.safety_marit <> (TYPEOF(h.safety_marit))'');
    populated_safety_marit_pcnt := AVE(GROUP,IF(h.safety_marit = (TYPEOF(h.safety_marit))'',0,100));
    maxlength_safety_marit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.safety_marit)));
    avelength_safety_marit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.safety_marit)),h.safety_marit<>(typeof(h.safety_marit))'');
    populated_health_manuf_cnt := COUNT(GROUP,h.health_manuf <> (TYPEOF(h.health_manuf))'');
    populated_health_manuf_pcnt := AVE(GROUP,IF(h.health_manuf = (TYPEOF(h.health_manuf))'',0,100));
    maxlength_health_manuf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.health_manuf)));
    avelength_health_manuf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.health_manuf)),h.health_manuf<>(typeof(h.health_manuf))'');
    populated_health_const_cnt := COUNT(GROUP,h.health_const <> (TYPEOF(h.health_const))'');
    populated_health_const_pcnt := AVE(GROUP,IF(h.health_const = (TYPEOF(h.health_const))'',0,100));
    maxlength_health_const := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.health_const)));
    avelength_health_const := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.health_const)),h.health_const<>(typeof(h.health_const))'');
    populated_health_marit_cnt := COUNT(GROUP,h.health_marit <> (TYPEOF(h.health_marit))'');
    populated_health_marit_pcnt := AVE(GROUP,IF(h.health_marit = (TYPEOF(h.health_marit))'',0,100));
    maxlength_health_marit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.health_marit)));
    avelength_health_marit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.health_marit)),h.health_marit<>(typeof(h.health_marit))'');
    populated_migrant_cnt := COUNT(GROUP,h.migrant <> (TYPEOF(h.migrant))'');
    populated_migrant_pcnt := AVE(GROUP,IF(h.migrant = (TYPEOF(h.migrant))'',0,100));
    maxlength_migrant := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.migrant)));
    avelength_migrant := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.migrant)),h.migrant<>(typeof(h.migrant))'');
    populated_mail_state_cnt := COUNT(GROUP,h.mail_state <> (TYPEOF(h.mail_state))'');
    populated_mail_state_pcnt := AVE(GROUP,IF(h.mail_state = (TYPEOF(h.mail_state))'',0,100));
    maxlength_mail_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_state)));
    avelength_mail_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_state)),h.mail_state<>(typeof(h.mail_state))'');
    populated_mail_zip_cnt := COUNT(GROUP,h.mail_zip <> (TYPEOF(h.mail_zip))'');
    populated_mail_zip_pcnt := AVE(GROUP,IF(h.mail_zip = (TYPEOF(h.mail_zip))'',0,100));
    maxlength_mail_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_zip)));
    avelength_mail_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_zip)),h.mail_zip<>(typeof(h.mail_zip))'');
    populated_host_est_key_cnt := COUNT(GROUP,h.host_est_key <> (TYPEOF(h.host_est_key))'');
    populated_host_est_key_pcnt := AVE(GROUP,IF(h.host_est_key = (TYPEOF(h.host_est_key))'',0,100));
    maxlength_host_est_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.host_est_key)));
    avelength_host_est_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.host_est_key)),h.host_est_key<>(typeof(h.host_est_key))'');
    populated_nr_in_estab_cnt := COUNT(GROUP,h.nr_in_estab <> (TYPEOF(h.nr_in_estab))'');
    populated_nr_in_estab_pcnt := AVE(GROUP,IF(h.nr_in_estab = (TYPEOF(h.nr_in_estab))'',0,100));
    maxlength_nr_in_estab := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nr_in_estab)));
    avelength_nr_in_estab := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nr_in_estab)),h.nr_in_estab<>(typeof(h.nr_in_estab))'');
    populated_open_date_cnt := COUNT(GROUP,h.open_date <> (TYPEOF(h.open_date))'');
    populated_open_date_pcnt := AVE(GROUP,IF(h.open_date = (TYPEOF(h.open_date))'',0,100));
    maxlength_open_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.open_date)));
    avelength_open_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.open_date)),h.open_date<>(typeof(h.open_date))'');
    populated_case_mod_date_cnt := COUNT(GROUP,h.case_mod_date <> (TYPEOF(h.case_mod_date))'');
    populated_case_mod_date_pcnt := AVE(GROUP,IF(h.case_mod_date = (TYPEOF(h.case_mod_date))'',0,100));
    maxlength_case_mod_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.case_mod_date)));
    avelength_case_mod_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.case_mod_date)),h.case_mod_date<>(typeof(h.case_mod_date))'');
    populated_close_conf_date_cnt := COUNT(GROUP,h.close_conf_date <> (TYPEOF(h.close_conf_date))'');
    populated_close_conf_date_pcnt := AVE(GROUP,IF(h.close_conf_date = (TYPEOF(h.close_conf_date))'',0,100));
    maxlength_close_conf_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.close_conf_date)));
    avelength_close_conf_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.close_conf_date)),h.close_conf_date<>(typeof(h.close_conf_date))'');
    populated_close_case_date_cnt := COUNT(GROUP,h.close_case_date <> (TYPEOF(h.close_case_date))'');
    populated_close_case_date_pcnt := AVE(GROUP,IF(h.close_case_date = (TYPEOF(h.close_case_date))'',0,100));
    maxlength_close_case_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.close_case_date)));
    avelength_close_case_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.close_case_date)),h.close_case_date<>(typeof(h.close_case_date))'');
    populated_open_year_cnt := COUNT(GROUP,h.open_year <> (TYPEOF(h.open_year))'');
    populated_open_year_pcnt := AVE(GROUP,IF(h.open_year = (TYPEOF(h.open_year))'',0,100));
    maxlength_open_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.open_year)));
    avelength_open_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.open_year)),h.open_year<>(typeof(h.open_year))'');
    populated_case_mod_year_cnt := COUNT(GROUP,h.case_mod_year <> (TYPEOF(h.case_mod_year))'');
    populated_case_mod_year_pcnt := AVE(GROUP,IF(h.case_mod_year = (TYPEOF(h.case_mod_year))'',0,100));
    maxlength_case_mod_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.case_mod_year)));
    avelength_case_mod_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.case_mod_year)),h.case_mod_year<>(typeof(h.case_mod_year))'');
    populated_close_conf_year_cnt := COUNT(GROUP,h.close_conf_year <> (TYPEOF(h.close_conf_year))'');
    populated_close_conf_year_pcnt := AVE(GROUP,IF(h.close_conf_year = (TYPEOF(h.close_conf_year))'',0,100));
    maxlength_close_conf_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.close_conf_year)));
    avelength_close_conf_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.close_conf_year)),h.close_conf_year<>(typeof(h.close_conf_year))'');
    populated_close_case_year_cnt := COUNT(GROUP,h.close_case_year <> (TYPEOF(h.close_case_year))'');
    populated_close_case_year_pcnt := AVE(GROUP,IF(h.close_case_year = (TYPEOF(h.close_case_year))'',0,100));
    maxlength_close_case_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.close_case_year)));
    avelength_close_case_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.close_case_year)),h.close_case_year<>(typeof(h.close_case_year))'');
    populated_estab_name_cnt := COUNT(GROUP,h.estab_name <> (TYPEOF(h.estab_name))'');
    populated_estab_name_pcnt := AVE(GROUP,IF(h.estab_name = (TYPEOF(h.estab_name))'',0,100));
    maxlength_estab_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.estab_name)));
    avelength_estab_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.estab_name)),h.estab_name<>(typeof(h.estab_name))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_activity_nr_pcnt *   0.00 / 100 + T.Populated_reporting_id_pcnt *   0.00 / 100 + T.Populated_state_flag_pcnt *   0.00 / 100 + T.Populated_site_state_pcnt *   0.00 / 100 + T.Populated_site_zip_pcnt *   0.00 / 100 + T.Populated_owner_type_pcnt *   0.00 / 100 + T.Populated_owner_code_pcnt *   0.00 / 100 + T.Populated_adv_notice_pcnt *   0.00 / 100 + T.Populated_safety_hlth_pcnt *   0.00 / 100 + T.Populated_sic_code_pcnt *   0.00 / 100 + T.Populated_naics_code_pcnt *   0.00 / 100 + T.Populated_insp_type_pcnt *   0.00 / 100 + T.Populated_insp_scope_pcnt *   0.00 / 100 + T.Populated_why_no_insp_pcnt *   0.00 / 100 + T.Populated_union_status_pcnt *   0.00 / 100 + T.Populated_safety_manuf_pcnt *   0.00 / 100 + T.Populated_safety_const_pcnt *   0.00 / 100 + T.Populated_safety_marit_pcnt *   0.00 / 100 + T.Populated_health_manuf_pcnt *   0.00 / 100 + T.Populated_health_const_pcnt *   0.00 / 100 + T.Populated_health_marit_pcnt *   0.00 / 100 + T.Populated_migrant_pcnt *   0.00 / 100 + T.Populated_mail_state_pcnt *   0.00 / 100 + T.Populated_mail_zip_pcnt *   0.00 / 100 + T.Populated_host_est_key_pcnt *   0.00 / 100 + T.Populated_nr_in_estab_pcnt *   0.00 / 100 + T.Populated_open_date_pcnt *   0.00 / 100 + T.Populated_case_mod_date_pcnt *   0.00 / 100 + T.Populated_close_conf_date_pcnt *   0.00 / 100 + T.Populated_close_case_date_pcnt *   0.00 / 100 + T.Populated_open_year_pcnt *   0.00 / 100 + T.Populated_case_mod_year_pcnt *   0.00 / 100 + T.Populated_close_conf_year_pcnt *   0.00 / 100 + T.Populated_close_case_year_pcnt *   0.00 / 100 + T.Populated_estab_name_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'activity_nr','reporting_id','state_flag','site_state','site_zip','owner_type','owner_code','adv_notice','safety_hlth','sic_code','naics_code','insp_type','insp_scope','why_no_insp','union_status','safety_manuf','safety_const','safety_marit','health_manuf','health_const','health_marit','migrant','mail_state','mail_zip','host_est_key','nr_in_estab','open_date','case_mod_date','close_conf_date','close_case_date','open_year','case_mod_year','close_conf_year','close_case_year','estab_name');
  SELF.populated_pcnt := CHOOSE(C,le.populated_activity_nr_pcnt,le.populated_reporting_id_pcnt,le.populated_state_flag_pcnt,le.populated_site_state_pcnt,le.populated_site_zip_pcnt,le.populated_owner_type_pcnt,le.populated_owner_code_pcnt,le.populated_adv_notice_pcnt,le.populated_safety_hlth_pcnt,le.populated_sic_code_pcnt,le.populated_naics_code_pcnt,le.populated_insp_type_pcnt,le.populated_insp_scope_pcnt,le.populated_why_no_insp_pcnt,le.populated_union_status_pcnt,le.populated_safety_manuf_pcnt,le.populated_safety_const_pcnt,le.populated_safety_marit_pcnt,le.populated_health_manuf_pcnt,le.populated_health_const_pcnt,le.populated_health_marit_pcnt,le.populated_migrant_pcnt,le.populated_mail_state_pcnt,le.populated_mail_zip_pcnt,le.populated_host_est_key_pcnt,le.populated_nr_in_estab_pcnt,le.populated_open_date_pcnt,le.populated_case_mod_date_pcnt,le.populated_close_conf_date_pcnt,le.populated_close_case_date_pcnt,le.populated_open_year_pcnt,le.populated_case_mod_year_pcnt,le.populated_close_conf_year_pcnt,le.populated_close_case_year_pcnt,le.populated_estab_name_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_activity_nr,le.maxlength_reporting_id,le.maxlength_state_flag,le.maxlength_site_state,le.maxlength_site_zip,le.maxlength_owner_type,le.maxlength_owner_code,le.maxlength_adv_notice,le.maxlength_safety_hlth,le.maxlength_sic_code,le.maxlength_naics_code,le.maxlength_insp_type,le.maxlength_insp_scope,le.maxlength_why_no_insp,le.maxlength_union_status,le.maxlength_safety_manuf,le.maxlength_safety_const,le.maxlength_safety_marit,le.maxlength_health_manuf,le.maxlength_health_const,le.maxlength_health_marit,le.maxlength_migrant,le.maxlength_mail_state,le.maxlength_mail_zip,le.maxlength_host_est_key,le.maxlength_nr_in_estab,le.maxlength_open_date,le.maxlength_case_mod_date,le.maxlength_close_conf_date,le.maxlength_close_case_date,le.maxlength_open_year,le.maxlength_case_mod_year,le.maxlength_close_conf_year,le.maxlength_close_case_year,le.maxlength_estab_name);
  SELF.avelength := CHOOSE(C,le.avelength_activity_nr,le.avelength_reporting_id,le.avelength_state_flag,le.avelength_site_state,le.avelength_site_zip,le.avelength_owner_type,le.avelength_owner_code,le.avelength_adv_notice,le.avelength_safety_hlth,le.avelength_sic_code,le.avelength_naics_code,le.avelength_insp_type,le.avelength_insp_scope,le.avelength_why_no_insp,le.avelength_union_status,le.avelength_safety_manuf,le.avelength_safety_const,le.avelength_safety_marit,le.avelength_health_manuf,le.avelength_health_const,le.avelength_health_marit,le.avelength_migrant,le.avelength_mail_state,le.avelength_mail_zip,le.avelength_host_est_key,le.avelength_nr_in_estab,le.avelength_open_date,le.avelength_case_mod_date,le.avelength_close_conf_date,le.avelength_close_case_date,le.avelength_open_year,le.avelength_case_mod_year,le.avelength_close_conf_year,le.avelength_close_case_year,le.avelength_estab_name);
END;
EXPORT invSummary := NORMALIZE(summary0, 35, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.reporting_id),TRIM((SALT311.StrType)le.state_flag),TRIM((SALT311.StrType)le.site_state),TRIM((SALT311.StrType)le.site_zip),TRIM((SALT311.StrType)le.owner_type),TRIM((SALT311.StrType)le.owner_code),TRIM((SALT311.StrType)le.adv_notice),TRIM((SALT311.StrType)le.safety_hlth),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.naics_code),TRIM((SALT311.StrType)le.insp_type),TRIM((SALT311.StrType)le.insp_scope),TRIM((SALT311.StrType)le.why_no_insp),TRIM((SALT311.StrType)le.union_status),TRIM((SALT311.StrType)le.safety_manuf),TRIM((SALT311.StrType)le.safety_const),TRIM((SALT311.StrType)le.safety_marit),TRIM((SALT311.StrType)le.health_manuf),TRIM((SALT311.StrType)le.health_const),TRIM((SALT311.StrType)le.health_marit),TRIM((SALT311.StrType)le.migrant),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.host_est_key),TRIM((SALT311.StrType)le.nr_in_estab),TRIM((SALT311.StrType)le.open_date),TRIM((SALT311.StrType)le.case_mod_date),TRIM((SALT311.StrType)le.close_conf_date),TRIM((SALT311.StrType)le.close_case_date),TRIM((SALT311.StrType)le.open_year),TRIM((SALT311.StrType)le.case_mod_year),TRIM((SALT311.StrType)le.close_conf_year),TRIM((SALT311.StrType)le.close_case_year),TRIM((SALT311.StrType)le.estab_name)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,35,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 35);
  SELF.FldNo2 := 1 + (C % 35);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.reporting_id),TRIM((SALT311.StrType)le.state_flag),TRIM((SALT311.StrType)le.site_state),TRIM((SALT311.StrType)le.site_zip),TRIM((SALT311.StrType)le.owner_type),TRIM((SALT311.StrType)le.owner_code),TRIM((SALT311.StrType)le.adv_notice),TRIM((SALT311.StrType)le.safety_hlth),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.naics_code),TRIM((SALT311.StrType)le.insp_type),TRIM((SALT311.StrType)le.insp_scope),TRIM((SALT311.StrType)le.why_no_insp),TRIM((SALT311.StrType)le.union_status),TRIM((SALT311.StrType)le.safety_manuf),TRIM((SALT311.StrType)le.safety_const),TRIM((SALT311.StrType)le.safety_marit),TRIM((SALT311.StrType)le.health_manuf),TRIM((SALT311.StrType)le.health_const),TRIM((SALT311.StrType)le.health_marit),TRIM((SALT311.StrType)le.migrant),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.host_est_key),TRIM((SALT311.StrType)le.nr_in_estab),TRIM((SALT311.StrType)le.open_date),TRIM((SALT311.StrType)le.case_mod_date),TRIM((SALT311.StrType)le.close_conf_date),TRIM((SALT311.StrType)le.close_case_date),TRIM((SALT311.StrType)le.open_year),TRIM((SALT311.StrType)le.case_mod_year),TRIM((SALT311.StrType)le.close_conf_year),TRIM((SALT311.StrType)le.close_case_year),TRIM((SALT311.StrType)le.estab_name)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.reporting_id),TRIM((SALT311.StrType)le.state_flag),TRIM((SALT311.StrType)le.site_state),TRIM((SALT311.StrType)le.site_zip),TRIM((SALT311.StrType)le.owner_type),TRIM((SALT311.StrType)le.owner_code),TRIM((SALT311.StrType)le.adv_notice),TRIM((SALT311.StrType)le.safety_hlth),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.naics_code),TRIM((SALT311.StrType)le.insp_type),TRIM((SALT311.StrType)le.insp_scope),TRIM((SALT311.StrType)le.why_no_insp),TRIM((SALT311.StrType)le.union_status),TRIM((SALT311.StrType)le.safety_manuf),TRIM((SALT311.StrType)le.safety_const),TRIM((SALT311.StrType)le.safety_marit),TRIM((SALT311.StrType)le.health_manuf),TRIM((SALT311.StrType)le.health_const),TRIM((SALT311.StrType)le.health_marit),TRIM((SALT311.StrType)le.migrant),TRIM((SALT311.StrType)le.mail_state),TRIM((SALT311.StrType)le.mail_zip),TRIM((SALT311.StrType)le.host_est_key),TRIM((SALT311.StrType)le.nr_in_estab),TRIM((SALT311.StrType)le.open_date),TRIM((SALT311.StrType)le.case_mod_date),TRIM((SALT311.StrType)le.close_conf_date),TRIM((SALT311.StrType)le.close_case_date),TRIM((SALT311.StrType)le.open_year),TRIM((SALT311.StrType)le.case_mod_year),TRIM((SALT311.StrType)le.close_conf_year),TRIM((SALT311.StrType)le.close_case_year),TRIM((SALT311.StrType)le.estab_name)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),35*35,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'activity_nr'}
      ,{2,'reporting_id'}
      ,{3,'state_flag'}
      ,{4,'site_state'}
      ,{5,'site_zip'}
      ,{6,'owner_type'}
      ,{7,'owner_code'}
      ,{8,'adv_notice'}
      ,{9,'safety_hlth'}
      ,{10,'sic_code'}
      ,{11,'naics_code'}
      ,{12,'insp_type'}
      ,{13,'insp_scope'}
      ,{14,'why_no_insp'}
      ,{15,'union_status'}
      ,{16,'safety_manuf'}
      ,{17,'safety_const'}
      ,{18,'safety_marit'}
      ,{19,'health_manuf'}
      ,{20,'health_const'}
      ,{21,'health_marit'}
      ,{22,'migrant'}
      ,{23,'mail_state'}
      ,{24,'mail_zip'}
      ,{25,'host_est_key'}
      ,{26,'nr_in_estab'}
      ,{27,'open_date'}
      ,{28,'case_mod_date'}
      ,{29,'close_conf_date'}
      ,{30,'close_case_date'}
      ,{31,'open_year'}
      ,{32,'case_mod_year'}
      ,{33,'close_conf_year'}
      ,{34,'close_case_year'}
      ,{35,'estab_name'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Inspection_Raw_Fields.InValid_activity_nr((SALT311.StrType)le.activity_nr),
    Inspection_Raw_Fields.InValid_reporting_id((SALT311.StrType)le.reporting_id),
    Inspection_Raw_Fields.InValid_state_flag((SALT311.StrType)le.state_flag),
    Inspection_Raw_Fields.InValid_site_state((SALT311.StrType)le.site_state),
    Inspection_Raw_Fields.InValid_site_zip((SALT311.StrType)le.site_zip),
    Inspection_Raw_Fields.InValid_owner_type((SALT311.StrType)le.owner_type),
    Inspection_Raw_Fields.InValid_owner_code((SALT311.StrType)le.owner_code),
    Inspection_Raw_Fields.InValid_adv_notice((SALT311.StrType)le.adv_notice),
    Inspection_Raw_Fields.InValid_safety_hlth((SALT311.StrType)le.safety_hlth),
    Inspection_Raw_Fields.InValid_sic_code((SALT311.StrType)le.sic_code),
    Inspection_Raw_Fields.InValid_naics_code((SALT311.StrType)le.naics_code),
    Inspection_Raw_Fields.InValid_insp_type((SALT311.StrType)le.insp_type),
    Inspection_Raw_Fields.InValid_insp_scope((SALT311.StrType)le.insp_scope),
    Inspection_Raw_Fields.InValid_why_no_insp((SALT311.StrType)le.why_no_insp),
    Inspection_Raw_Fields.InValid_union_status((SALT311.StrType)le.union_status),
    Inspection_Raw_Fields.InValid_safety_manuf((SALT311.StrType)le.safety_manuf),
    Inspection_Raw_Fields.InValid_safety_const((SALT311.StrType)le.safety_const),
    Inspection_Raw_Fields.InValid_safety_marit((SALT311.StrType)le.safety_marit),
    Inspection_Raw_Fields.InValid_health_manuf((SALT311.StrType)le.health_manuf),
    Inspection_Raw_Fields.InValid_health_const((SALT311.StrType)le.health_const),
    Inspection_Raw_Fields.InValid_health_marit((SALT311.StrType)le.health_marit),
    Inspection_Raw_Fields.InValid_migrant((SALT311.StrType)le.migrant),
    Inspection_Raw_Fields.InValid_mail_state((SALT311.StrType)le.mail_state),
    Inspection_Raw_Fields.InValid_mail_zip((SALT311.StrType)le.mail_zip),
    Inspection_Raw_Fields.InValid_host_est_key((SALT311.StrType)le.host_est_key),
    Inspection_Raw_Fields.InValid_nr_in_estab((SALT311.StrType)le.nr_in_estab),
    Inspection_Raw_Fields.InValid_open_date((SALT311.StrType)le.open_date),
    Inspection_Raw_Fields.InValid_case_mod_date((SALT311.StrType)le.case_mod_date),
    Inspection_Raw_Fields.InValid_close_conf_date((SALT311.StrType)le.close_conf_date),
    Inspection_Raw_Fields.InValid_close_case_date((SALT311.StrType)le.close_case_date),
    Inspection_Raw_Fields.InValid_open_year((SALT311.StrType)le.open_year),
    Inspection_Raw_Fields.InValid_case_mod_year((SALT311.StrType)le.case_mod_year),
    Inspection_Raw_Fields.InValid_close_conf_year((SALT311.StrType)le.close_conf_year),
    Inspection_Raw_Fields.InValid_close_case_year((SALT311.StrType)le.close_case_year),
    Inspection_Raw_Fields.InValid_estab_name((SALT311.StrType)le.estab_name),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,35,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Inspection_Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','invalid_state_flag','invalid_state','invalid_numeric_blank','invalid_owner_type','invalid_numeric_blank','invalid_adv_notice','invalid_safety_hlth','invalid_sic','invalid_naics','invalid_insp_type','invalid_insp_scope','invalid_why_no_insp','invalid_union_status','invalid_X_blank','invalid_X_blank','invalid_X_blank','invalid_X_blank','invalid_X_blank','invalid_X_blank','invalid_X_blank','invalid_state','invalid_numeric_blank','invalid_host_est_key','invalid_numeric_blank','invalid_date_dashes','invalid_date_dashes','invalid_date_dashes','invalid_date_dashes','invalid_year','invalid_year','invalid_year','invalid_year','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Inspection_Raw_Fields.InValidMessage_activity_nr(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_reporting_id(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_state_flag(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_site_state(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_site_zip(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_owner_type(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_owner_code(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_adv_notice(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_safety_hlth(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_sic_code(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_naics_code(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_insp_type(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_insp_scope(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_why_no_insp(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_union_status(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_safety_manuf(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_safety_const(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_safety_marit(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_health_manuf(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_health_const(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_health_marit(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_migrant(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_mail_state(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_mail_zip(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_host_est_key(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_nr_in_estab(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_open_date(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_case_mod_date(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_close_conf_date(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_close_case_date(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_open_year(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_case_mod_year(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_close_conf_year(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_close_case_year(TotalErrors.ErrorNum),Inspection_Raw_Fields.InValidMessage_estab_name(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, Inspection_Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
