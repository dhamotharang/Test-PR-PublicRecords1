IMPORT ut,SALT34;
EXPORT hygiene(dataset(layout_In_MT) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_corp_ra_dt_first_seen_pcnt := AVE(GROUP,IF(h.corp_ra_dt_first_seen = (TYPEOF(h.corp_ra_dt_first_seen))'',0,100));
    maxlength_corp_ra_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_dt_first_seen)));
    avelength_corp_ra_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_dt_first_seen)),h.corp_ra_dt_first_seen<>(typeof(h.corp_ra_dt_first_seen))'');
    populated_corp_ra_dt_last_seen_pcnt := AVE(GROUP,IF(h.corp_ra_dt_last_seen = (TYPEOF(h.corp_ra_dt_last_seen))'',0,100));
    maxlength_corp_ra_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_dt_last_seen)));
    avelength_corp_ra_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_dt_last_seen)),h.corp_ra_dt_last_seen<>(typeof(h.corp_ra_dt_last_seen))'');
    populated_corp_process_date_pcnt := AVE(GROUP,IF(h.corp_process_date = (TYPEOF(h.corp_process_date))'',0,100));
    maxlength_corp_process_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_process_date)));
    avelength_corp_process_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_process_date)),h.corp_process_date<>(typeof(h.corp_process_date))'');
    populated_corp_key_pcnt := AVE(GROUP,IF(h.corp_key = (TYPEOF(h.corp_key))'',0,100));
    maxlength_corp_key := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_key)));
    avelength_corp_key := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_key)),h.corp_key<>(typeof(h.corp_key))'');
    populated_corp_orig_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_orig_sos_charter_nbr = (TYPEOF(h.corp_orig_sos_charter_nbr))'',0,100));
    maxlength_corp_orig_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_sos_charter_nbr)));
    avelength_corp_orig_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_sos_charter_nbr)),h.corp_orig_sos_charter_nbr<>(typeof(h.corp_orig_sos_charter_nbr))'');
    populated_corp_vendor_pcnt := AVE(GROUP,IF(h.corp_vendor = (TYPEOF(h.corp_vendor))'',0,100));
    maxlength_corp_vendor := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_vendor)));
    avelength_corp_vendor := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_vendor)),h.corp_vendor<>(typeof(h.corp_vendor))'');
    populated_corp_state_origin_pcnt := AVE(GROUP,IF(h.corp_state_origin = (TYPEOF(h.corp_state_origin))'',0,100));
    maxlength_corp_state_origin := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_state_origin)));
    avelength_corp_state_origin := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_state_origin)),h.corp_state_origin<>(typeof(h.corp_state_origin))'');
    populated_corp_inc_state_pcnt := AVE(GROUP,IF(h.corp_inc_state = (TYPEOF(h.corp_inc_state))'',0,100));
    maxlength_corp_inc_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_inc_state)));
    avelength_corp_inc_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_inc_state)),h.corp_inc_state<>(typeof(h.corp_inc_state))'');
    populated_corp_legal_name_pcnt := AVE(GROUP,IF(h.corp_legal_name = (TYPEOF(h.corp_legal_name))'',0,100));
    maxlength_corp_legal_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_legal_name)));
    avelength_corp_legal_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_legal_name)),h.corp_legal_name<>(typeof(h.corp_legal_name))'');
    populated_corp_ln_name_type_cd_pcnt := AVE(GROUP,IF(h.corp_ln_name_type_cd = (TYPEOF(h.corp_ln_name_type_cd))'',0,100));
    maxlength_corp_ln_name_type_cd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ln_name_type_cd)));
    avelength_corp_ln_name_type_cd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ln_name_type_cd)),h.corp_ln_name_type_cd<>(typeof(h.corp_ln_name_type_cd))'');
    populated_corp_filing_date_pcnt := AVE(GROUP,IF(h.corp_filing_date = (TYPEOF(h.corp_filing_date))'',0,100));
    maxlength_corp_filing_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_filing_date)));
    avelength_corp_filing_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_filing_date)),h.corp_filing_date<>(typeof(h.corp_filing_date))'');
    populated_corp_inc_date_pcnt := AVE(GROUP,IF(h.corp_inc_date = (TYPEOF(h.corp_inc_date))'',0,100));
    maxlength_corp_inc_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_inc_date)));
    avelength_corp_inc_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_inc_date)),h.corp_inc_date<>(typeof(h.corp_inc_date))'');
    populated_corp_forgn_date_pcnt := AVE(GROUP,IF(h.corp_forgn_date = (TYPEOF(h.corp_forgn_date))'',0,100));
    maxlength_corp_forgn_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_forgn_date)));
    avelength_corp_forgn_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_forgn_date)),h.corp_forgn_date<>(typeof(h.corp_forgn_date))'');
    populated_corp_foreign_domestic_ind_pcnt := AVE(GROUP,IF(h.corp_foreign_domestic_ind = (TYPEOF(h.corp_foreign_domestic_ind))'',0,100));
    maxlength_corp_foreign_domestic_ind := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_foreign_domestic_ind)));
    avelength_corp_foreign_domestic_ind := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_foreign_domestic_ind)),h.corp_foreign_domestic_ind<>(typeof(h.corp_foreign_domestic_ind))'');
    populated_corp_forgn_state_desc_pcnt := AVE(GROUP,IF(h.corp_forgn_state_desc = (TYPEOF(h.corp_forgn_state_desc))'',0,100));
    maxlength_corp_forgn_state_desc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_forgn_state_desc)));
    avelength_corp_forgn_state_desc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_forgn_state_desc)),h.corp_forgn_state_desc<>(typeof(h.corp_forgn_state_desc))'');
    populated_corp_trademark_class_desc1_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc1 = (TYPEOF(h.corp_trademark_class_desc1))'',0,100));
    maxlength_corp_trademark_class_desc1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc1)));
    avelength_corp_trademark_class_desc1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc1)),h.corp_trademark_class_desc1<>(typeof(h.corp_trademark_class_desc1))'');
    populated_corp_trademark_class_desc2_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc2 = (TYPEOF(h.corp_trademark_class_desc2))'',0,100));
    maxlength_corp_trademark_class_desc2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc2)));
    avelength_corp_trademark_class_desc2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc2)),h.corp_trademark_class_desc2<>(typeof(h.corp_trademark_class_desc2))'');
    populated_corp_trademark_class_desc3_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc3 = (TYPEOF(h.corp_trademark_class_desc3))'',0,100));
    maxlength_corp_trademark_class_desc3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc3)));
    avelength_corp_trademark_class_desc3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc3)),h.corp_trademark_class_desc3<>(typeof(h.corp_trademark_class_desc3))'');
    populated_corp_trademark_class_desc4_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc4 = (TYPEOF(h.corp_trademark_class_desc4))'',0,100));
    maxlength_corp_trademark_class_desc4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc4)));
    avelength_corp_trademark_class_desc4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc4)),h.corp_trademark_class_desc4<>(typeof(h.corp_trademark_class_desc4))'');
    populated_corp_trademark_class_desc5_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc5 = (TYPEOF(h.corp_trademark_class_desc5))'',0,100));
    maxlength_corp_trademark_class_desc5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc5)));
    avelength_corp_trademark_class_desc5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc5)),h.corp_trademark_class_desc5<>(typeof(h.corp_trademark_class_desc5))'');
    populated_corp_trademark_class_desc6_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc6 = (TYPEOF(h.corp_trademark_class_desc6))'',0,100));
    maxlength_corp_trademark_class_desc6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc6)));
    avelength_corp_trademark_class_desc6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_class_desc6)),h.corp_trademark_class_desc6<>(typeof(h.corp_trademark_class_desc6))'');
    populated_corp_term_exist_cd_pcnt := AVE(GROUP,IF(h.corp_term_exist_cd = (TYPEOF(h.corp_term_exist_cd))'',0,100));
    maxlength_corp_term_exist_cd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_term_exist_cd)));
    avelength_corp_term_exist_cd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_term_exist_cd)),h.corp_term_exist_cd<>(typeof(h.corp_term_exist_cd))'');
    populated_corp_term_exist_exp_pcnt := AVE(GROUP,IF(h.corp_term_exist_exp = (TYPEOF(h.corp_term_exist_exp))'',0,100));
    maxlength_corp_term_exist_exp := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_term_exist_exp)));
    avelength_corp_term_exist_exp := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_term_exist_exp)),h.corp_term_exist_exp<>(typeof(h.corp_term_exist_exp))'');
    populated_corp_orig_org_structure_cd_pcnt := AVE(GROUP,IF(h.corp_orig_org_structure_cd = (TYPEOF(h.corp_orig_org_structure_cd))'',0,100));
    maxlength_corp_orig_org_structure_cd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_org_structure_cd)));
    avelength_corp_orig_org_structure_cd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_org_structure_cd)),h.corp_orig_org_structure_cd<>(typeof(h.corp_orig_org_structure_cd))'');
    populated_corp_orig_bus_type_cd_pcnt := AVE(GROUP,IF(h.corp_orig_bus_type_cd = (TYPEOF(h.corp_orig_bus_type_cd))'',0,100));
    maxlength_corp_orig_bus_type_cd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_bus_type_cd)));
    avelength_corp_orig_bus_type_cd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_orig_bus_type_cd)),h.corp_orig_bus_type_cd<>(typeof(h.corp_orig_bus_type_cd))'');
    populated_corp_status_desc_pcnt := AVE(GROUP,IF(h.corp_status_desc = (TYPEOF(h.corp_status_desc))'',0,100));
    maxlength_corp_status_desc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_status_desc)));
    avelength_corp_status_desc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_status_desc)),h.corp_status_desc<>(typeof(h.corp_status_desc))'');
    populated_corp_status_comment_pcnt := AVE(GROUP,IF(h.corp_status_comment = (TYPEOF(h.corp_status_comment))'',0,100));
    maxlength_corp_status_comment := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_status_comment)));
    avelength_corp_status_comment := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_status_comment)),h.corp_status_comment<>(typeof(h.corp_status_comment))'');
    populated_corp_purpose_pcnt := AVE(GROUP,IF(h.corp_purpose = (TYPEOF(h.corp_purpose))'',0,100));
    maxlength_corp_purpose := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_purpose)));
    avelength_corp_purpose := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_purpose)),h.corp_purpose<>(typeof(h.corp_purpose))'');
    populated_corp_ra_resign_date_pcnt := AVE(GROUP,IF(h.corp_ra_resign_date = (TYPEOF(h.corp_ra_resign_date))'',0,100));
    maxlength_corp_ra_resign_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_resign_date)));
    avelength_corp_ra_resign_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_resign_date)),h.corp_ra_resign_date<>(typeof(h.corp_ra_resign_date))'');
    populated_corp_dissolved_date_pcnt := AVE(GROUP,IF(h.corp_dissolved_date = (TYPEOF(h.corp_dissolved_date))'',0,100));
    maxlength_corp_dissolved_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_dissolved_date)));
    avelength_corp_dissolved_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_dissolved_date)),h.corp_dissolved_date<>(typeof(h.corp_dissolved_date))'');
    populated_corp_name_effective_date_pcnt := AVE(GROUP,IF(h.corp_name_effective_date = (TYPEOF(h.corp_name_effective_date))'',0,100));
    maxlength_corp_name_effective_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_name_effective_date)));
    avelength_corp_name_effective_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_name_effective_date)),h.corp_name_effective_date<>(typeof(h.corp_name_effective_date))'');
    populated_corp_ra_addl_info_pcnt := AVE(GROUP,IF(h.corp_ra_addl_info = (TYPEOF(h.corp_ra_addl_info))'',0,100));
    maxlength_corp_ra_addl_info := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_addl_info)));
    avelength_corp_ra_addl_info := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_ra_addl_info)),h.corp_ra_addl_info<>(typeof(h.corp_ra_addl_info))'');
    populated_corp_agent_status_cd_pcnt := AVE(GROUP,IF(h.corp_agent_status_cd = (TYPEOF(h.corp_agent_status_cd))'',0,100));
    maxlength_corp_agent_status_cd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_agent_status_cd)));
    avelength_corp_agent_status_cd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_agent_status_cd)),h.corp_agent_status_cd<>(typeof(h.corp_agent_status_cd))'');
    populated_corp_trademark_first_use_date_pcnt := AVE(GROUP,IF(h.corp_trademark_first_use_date = (TYPEOF(h.corp_trademark_first_use_date))'',0,100));
    maxlength_corp_trademark_first_use_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_first_use_date)));
    avelength_corp_trademark_first_use_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_first_use_date)),h.corp_trademark_first_use_date<>(typeof(h.corp_trademark_first_use_date))'');
    populated_corp_trademark_first_use_date_in_state_pcnt := AVE(GROUP,IF(h.corp_trademark_first_use_date_in_state = (TYPEOF(h.corp_trademark_first_use_date_in_state))'',0,100));
    maxlength_corp_trademark_first_use_date_in_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_first_use_date_in_state)));
    avelength_corp_trademark_first_use_date_in_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_first_use_date_in_state)),h.corp_trademark_first_use_date_in_state<>(typeof(h.corp_trademark_first_use_date_in_state))'');
    populated_corp_trademark_renewal_date_pcnt := AVE(GROUP,IF(h.corp_trademark_renewal_date = (TYPEOF(h.corp_trademark_renewal_date))'',0,100));
    maxlength_corp_trademark_renewal_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_renewal_date)));
    avelength_corp_trademark_renewal_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_trademark_renewal_date)),h.corp_trademark_renewal_date<>(typeof(h.corp_trademark_renewal_date))'');
    populated_corp_registered_counties_pcnt := AVE(GROUP,IF(h.corp_registered_counties = (TYPEOF(h.corp_registered_counties))'',0,100));
    maxlength_corp_registered_counties := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_registered_counties)));
    avelength_corp_registered_counties := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.corp_registered_counties)),h.corp_registered_counties<>(typeof(h.corp_registered_counties))'');
    populated_cont_status_cd_pcnt := AVE(GROUP,IF(h.cont_status_cd = (TYPEOF(h.cont_status_cd))'',0,100));
    maxlength_cont_status_cd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cont_status_cd)));
    avelength_cont_status_cd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cont_status_cd)),h.cont_status_cd<>(typeof(h.cont_status_cd))'');
    populated_cont_title1_desc_pcnt := AVE(GROUP,IF(h.cont_title1_desc = (TYPEOF(h.cont_title1_desc))'',0,100));
    maxlength_cont_title1_desc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cont_title1_desc)));
    avelength_cont_title1_desc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cont_title1_desc)),h.cont_title1_desc<>(typeof(h.cont_title1_desc))'');
    populated_recordorigin_pcnt := AVE(GROUP,IF(h.recordorigin = (TYPEOF(h.recordorigin))'',0,100));
    maxlength_recordorigin := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.recordorigin)));
    avelength_recordorigin := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.recordorigin)),h.recordorigin<>(typeof(h.recordorigin))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_corp_ra_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_corp_ra_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_corp_process_date_pcnt *   0.00 / 100 + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_orig_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_corp_vendor_pcnt *   0.00 / 100 + T.Populated_corp_state_origin_pcnt *   0.00 / 100 + T.Populated_corp_inc_state_pcnt *   0.00 / 100 + T.Populated_corp_legal_name_pcnt *   0.00 / 100 + T.Populated_corp_ln_name_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_filing_date_pcnt *   0.00 / 100 + T.Populated_corp_inc_date_pcnt *   0.00 / 100 + T.Populated_corp_forgn_date_pcnt *   0.00 / 100 + T.Populated_corp_foreign_domestic_ind_pcnt *   0.00 / 100 + T.Populated_corp_forgn_state_desc_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc1_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc2_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc3_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc4_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc5_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc6_pcnt *   0.00 / 100 + T.Populated_corp_term_exist_cd_pcnt *   0.00 / 100 + T.Populated_corp_term_exist_exp_pcnt *   0.00 / 100 + T.Populated_corp_orig_org_structure_cd_pcnt *   0.00 / 100 + T.Populated_corp_orig_bus_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_status_desc_pcnt *   0.00 / 100 + T.Populated_corp_status_comment_pcnt *   0.00 / 100 + T.Populated_corp_purpose_pcnt *   0.00 / 100 + T.Populated_corp_ra_resign_date_pcnt *   0.00 / 100 + T.Populated_corp_dissolved_date_pcnt *   0.00 / 100 + T.Populated_corp_name_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_ra_addl_info_pcnt *   0.00 / 100 + T.Populated_corp_agent_status_cd_pcnt *   0.00 / 100 + T.Populated_corp_trademark_first_use_date_pcnt *   0.00 / 100 + T.Populated_corp_trademark_first_use_date_in_state_pcnt *   0.00 / 100 + T.Populated_corp_trademark_renewal_date_pcnt *   0.00 / 100 + T.Populated_corp_registered_counties_pcnt *   0.00 / 100 + T.Populated_cont_status_cd_pcnt *   0.00 / 100 + T.Populated_cont_title1_desc_pcnt *   0.00 / 100 + T.Populated_recordorigin_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_process_date','corp_key','corp_orig_sos_charter_nbr','corp_vendor','corp_state_origin','corp_inc_state','corp_legal_name','corp_ln_name_type_cd','corp_filing_date','corp_inc_date','corp_forgn_date','corp_foreign_domestic_ind','corp_forgn_state_desc','corp_trademark_class_desc1','corp_trademark_class_desc2','corp_trademark_class_desc3','corp_trademark_class_desc4','corp_trademark_class_desc5','corp_trademark_class_desc6','corp_term_exist_cd','corp_term_exist_exp','corp_orig_org_structure_cd','corp_orig_bus_type_cd','corp_status_desc','corp_status_comment','corp_purpose','corp_ra_resign_date','corp_dissolved_date','corp_name_effective_date','corp_ra_addl_info','corp_agent_status_cd','corp_trademark_first_use_date','corp_trademark_first_use_date_in_state','corp_trademark_renewal_date','corp_registered_counties','cont_status_cd','cont_title1_desc','recordorigin');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_corp_ra_dt_first_seen_pcnt,le.populated_corp_ra_dt_last_seen_pcnt,le.populated_corp_process_date_pcnt,le.populated_corp_key_pcnt,le.populated_corp_orig_sos_charter_nbr_pcnt,le.populated_corp_vendor_pcnt,le.populated_corp_state_origin_pcnt,le.populated_corp_inc_state_pcnt,le.populated_corp_legal_name_pcnt,le.populated_corp_ln_name_type_cd_pcnt,le.populated_corp_filing_date_pcnt,le.populated_corp_inc_date_pcnt,le.populated_corp_forgn_date_pcnt,le.populated_corp_foreign_domestic_ind_pcnt,le.populated_corp_forgn_state_desc_pcnt,le.populated_corp_trademark_class_desc1_pcnt,le.populated_corp_trademark_class_desc2_pcnt,le.populated_corp_trademark_class_desc3_pcnt,le.populated_corp_trademark_class_desc4_pcnt,le.populated_corp_trademark_class_desc5_pcnt,le.populated_corp_trademark_class_desc6_pcnt,le.populated_corp_term_exist_cd_pcnt,le.populated_corp_term_exist_exp_pcnt,le.populated_corp_orig_org_structure_cd_pcnt,le.populated_corp_orig_bus_type_cd_pcnt,le.populated_corp_status_desc_pcnt,le.populated_corp_status_comment_pcnt,le.populated_corp_purpose_pcnt,le.populated_corp_ra_resign_date_pcnt,le.populated_corp_dissolved_date_pcnt,le.populated_corp_name_effective_date_pcnt,le.populated_corp_ra_addl_info_pcnt,le.populated_corp_agent_status_cd_pcnt,le.populated_corp_trademark_first_use_date_pcnt,le.populated_corp_trademark_first_use_date_in_state_pcnt,le.populated_corp_trademark_renewal_date_pcnt,le.populated_corp_registered_counties_pcnt,le.populated_cont_status_cd_pcnt,le.populated_cont_title1_desc_pcnt,le.populated_recordorigin_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_corp_ra_dt_first_seen,le.maxlength_corp_ra_dt_last_seen,le.maxlength_corp_process_date,le.maxlength_corp_key,le.maxlength_corp_orig_sos_charter_nbr,le.maxlength_corp_vendor,le.maxlength_corp_state_origin,le.maxlength_corp_inc_state,le.maxlength_corp_legal_name,le.maxlength_corp_ln_name_type_cd,le.maxlength_corp_filing_date,le.maxlength_corp_inc_date,le.maxlength_corp_forgn_date,le.maxlength_corp_foreign_domestic_ind,le.maxlength_corp_forgn_state_desc,le.maxlength_corp_trademark_class_desc1,le.maxlength_corp_trademark_class_desc2,le.maxlength_corp_trademark_class_desc3,le.maxlength_corp_trademark_class_desc4,le.maxlength_corp_trademark_class_desc5,le.maxlength_corp_trademark_class_desc6,le.maxlength_corp_term_exist_cd,le.maxlength_corp_term_exist_exp,le.maxlength_corp_orig_org_structure_cd,le.maxlength_corp_orig_bus_type_cd,le.maxlength_corp_status_desc,le.maxlength_corp_status_comment,le.maxlength_corp_purpose,le.maxlength_corp_ra_resign_date,le.maxlength_corp_dissolved_date,le.maxlength_corp_name_effective_date,le.maxlength_corp_ra_addl_info,le.maxlength_corp_agent_status_cd,le.maxlength_corp_trademark_first_use_date,le.maxlength_corp_trademark_first_use_date_in_state,le.maxlength_corp_trademark_renewal_date,le.maxlength_corp_registered_counties,le.maxlength_cont_status_cd,le.maxlength_cont_title1_desc,le.maxlength_recordorigin);
  SELF.avelength := CHOOSE(C,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_corp_ra_dt_first_seen,le.avelength_corp_ra_dt_last_seen,le.avelength_corp_process_date,le.avelength_corp_key,le.avelength_corp_orig_sos_charter_nbr,le.avelength_corp_vendor,le.avelength_corp_state_origin,le.avelength_corp_inc_state,le.avelength_corp_legal_name,le.avelength_corp_ln_name_type_cd,le.avelength_corp_filing_date,le.avelength_corp_inc_date,le.avelength_corp_forgn_date,le.avelength_corp_foreign_domestic_ind,le.avelength_corp_forgn_state_desc,le.avelength_corp_trademark_class_desc1,le.avelength_corp_trademark_class_desc2,le.avelength_corp_trademark_class_desc3,le.avelength_corp_trademark_class_desc4,le.avelength_corp_trademark_class_desc5,le.avelength_corp_trademark_class_desc6,le.avelength_corp_term_exist_cd,le.avelength_corp_term_exist_exp,le.avelength_corp_orig_org_structure_cd,le.avelength_corp_orig_bus_type_cd,le.avelength_corp_status_desc,le.avelength_corp_status_comment,le.avelength_corp_purpose,le.avelength_corp_ra_resign_date,le.avelength_corp_dissolved_date,le.avelength_corp_name_effective_date,le.avelength_corp_ra_addl_info,le.avelength_corp_agent_status_cd,le.avelength_corp_trademark_first_use_date,le.avelength_corp_trademark_first_use_date_in_state,le.avelength_corp_trademark_renewal_date,le.avelength_corp_registered_counties,le.avelength_cont_status_cd,le.avelength_cont_title1_desc,le.avelength_recordorigin);
END;
EXPORT invSummary := NORMALIZE(summary0, 44, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT34.StrType)le.corp_process_date),TRIM((SALT34.StrType)le.corp_key),TRIM((SALT34.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT34.StrType)le.corp_vendor),TRIM((SALT34.StrType)le.corp_state_origin),TRIM((SALT34.StrType)le.corp_inc_state),TRIM((SALT34.StrType)le.corp_legal_name),TRIM((SALT34.StrType)le.corp_ln_name_type_cd),TRIM((SALT34.StrType)le.corp_filing_date),TRIM((SALT34.StrType)le.corp_inc_date),TRIM((SALT34.StrType)le.corp_forgn_date),TRIM((SALT34.StrType)le.corp_foreign_domestic_ind),TRIM((SALT34.StrType)le.corp_forgn_state_desc),TRIM((SALT34.StrType)le.corp_trademark_class_desc1),TRIM((SALT34.StrType)le.corp_trademark_class_desc2),TRIM((SALT34.StrType)le.corp_trademark_class_desc3),TRIM((SALT34.StrType)le.corp_trademark_class_desc4),TRIM((SALT34.StrType)le.corp_trademark_class_desc5),TRIM((SALT34.StrType)le.corp_trademark_class_desc6),TRIM((SALT34.StrType)le.corp_term_exist_cd),TRIM((SALT34.StrType)le.corp_term_exist_exp),TRIM((SALT34.StrType)le.corp_orig_org_structure_cd),TRIM((SALT34.StrType)le.corp_orig_bus_type_cd),TRIM((SALT34.StrType)le.corp_status_desc),TRIM((SALT34.StrType)le.corp_status_comment),TRIM((SALT34.StrType)le.corp_purpose),TRIM((SALT34.StrType)le.corp_ra_resign_date),TRIM((SALT34.StrType)le.corp_dissolved_date),TRIM((SALT34.StrType)le.corp_name_effective_date),TRIM((SALT34.StrType)le.corp_ra_addl_info),TRIM((SALT34.StrType)le.corp_agent_status_cd),TRIM((SALT34.StrType)le.corp_trademark_first_use_date),TRIM((SALT34.StrType)le.corp_trademark_first_use_date_in_state),TRIM((SALT34.StrType)le.corp_trademark_renewal_date),TRIM((SALT34.StrType)le.corp_registered_counties),TRIM((SALT34.StrType)le.cont_status_cd),TRIM((SALT34.StrType)le.cont_title1_desc),TRIM((SALT34.StrType)le.recordorigin)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,44,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 44);
  SELF.FldNo2 := 1 + (C % 44);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT34.StrType)le.corp_process_date),TRIM((SALT34.StrType)le.corp_key),TRIM((SALT34.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT34.StrType)le.corp_vendor),TRIM((SALT34.StrType)le.corp_state_origin),TRIM((SALT34.StrType)le.corp_inc_state),TRIM((SALT34.StrType)le.corp_legal_name),TRIM((SALT34.StrType)le.corp_ln_name_type_cd),TRIM((SALT34.StrType)le.corp_filing_date),TRIM((SALT34.StrType)le.corp_inc_date),TRIM((SALT34.StrType)le.corp_forgn_date),TRIM((SALT34.StrType)le.corp_foreign_domestic_ind),TRIM((SALT34.StrType)le.corp_forgn_state_desc),TRIM((SALT34.StrType)le.corp_trademark_class_desc1),TRIM((SALT34.StrType)le.corp_trademark_class_desc2),TRIM((SALT34.StrType)le.corp_trademark_class_desc3),TRIM((SALT34.StrType)le.corp_trademark_class_desc4),TRIM((SALT34.StrType)le.corp_trademark_class_desc5),TRIM((SALT34.StrType)le.corp_trademark_class_desc6),TRIM((SALT34.StrType)le.corp_term_exist_cd),TRIM((SALT34.StrType)le.corp_term_exist_exp),TRIM((SALT34.StrType)le.corp_orig_org_structure_cd),TRIM((SALT34.StrType)le.corp_orig_bus_type_cd),TRIM((SALT34.StrType)le.corp_status_desc),TRIM((SALT34.StrType)le.corp_status_comment),TRIM((SALT34.StrType)le.corp_purpose),TRIM((SALT34.StrType)le.corp_ra_resign_date),TRIM((SALT34.StrType)le.corp_dissolved_date),TRIM((SALT34.StrType)le.corp_name_effective_date),TRIM((SALT34.StrType)le.corp_ra_addl_info),TRIM((SALT34.StrType)le.corp_agent_status_cd),TRIM((SALT34.StrType)le.corp_trademark_first_use_date),TRIM((SALT34.StrType)le.corp_trademark_first_use_date_in_state),TRIM((SALT34.StrType)le.corp_trademark_renewal_date),TRIM((SALT34.StrType)le.corp_registered_counties),TRIM((SALT34.StrType)le.cont_status_cd),TRIM((SALT34.StrType)le.cont_title1_desc),TRIM((SALT34.StrType)le.recordorigin)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT34.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT34.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT34.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT34.StrType)le.corp_process_date),TRIM((SALT34.StrType)le.corp_key),TRIM((SALT34.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT34.StrType)le.corp_vendor),TRIM((SALT34.StrType)le.corp_state_origin),TRIM((SALT34.StrType)le.corp_inc_state),TRIM((SALT34.StrType)le.corp_legal_name),TRIM((SALT34.StrType)le.corp_ln_name_type_cd),TRIM((SALT34.StrType)le.corp_filing_date),TRIM((SALT34.StrType)le.corp_inc_date),TRIM((SALT34.StrType)le.corp_forgn_date),TRIM((SALT34.StrType)le.corp_foreign_domestic_ind),TRIM((SALT34.StrType)le.corp_forgn_state_desc),TRIM((SALT34.StrType)le.corp_trademark_class_desc1),TRIM((SALT34.StrType)le.corp_trademark_class_desc2),TRIM((SALT34.StrType)le.corp_trademark_class_desc3),TRIM((SALT34.StrType)le.corp_trademark_class_desc4),TRIM((SALT34.StrType)le.corp_trademark_class_desc5),TRIM((SALT34.StrType)le.corp_trademark_class_desc6),TRIM((SALT34.StrType)le.corp_term_exist_cd),TRIM((SALT34.StrType)le.corp_term_exist_exp),TRIM((SALT34.StrType)le.corp_orig_org_structure_cd),TRIM((SALT34.StrType)le.corp_orig_bus_type_cd),TRIM((SALT34.StrType)le.corp_status_desc),TRIM((SALT34.StrType)le.corp_status_comment),TRIM((SALT34.StrType)le.corp_purpose),TRIM((SALT34.StrType)le.corp_ra_resign_date),TRIM((SALT34.StrType)le.corp_dissolved_date),TRIM((SALT34.StrType)le.corp_name_effective_date),TRIM((SALT34.StrType)le.corp_ra_addl_info),TRIM((SALT34.StrType)le.corp_agent_status_cd),TRIM((SALT34.StrType)le.corp_trademark_first_use_date),TRIM((SALT34.StrType)le.corp_trademark_first_use_date_in_state),TRIM((SALT34.StrType)le.corp_trademark_renewal_date),TRIM((SALT34.StrType)le.corp_registered_counties),TRIM((SALT34.StrType)le.cont_status_cd),TRIM((SALT34.StrType)le.cont_title1_desc),TRIM((SALT34.StrType)le.recordorigin)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),44*44,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_vendor_first_reported'}
      ,{2,'dt_vendor_last_reported'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'corp_ra_dt_first_seen'}
      ,{6,'corp_ra_dt_last_seen'}
      ,{7,'corp_process_date'}
      ,{8,'corp_key'}
      ,{9,'corp_orig_sos_charter_nbr'}
      ,{10,'corp_vendor'}
      ,{11,'corp_state_origin'}
      ,{12,'corp_inc_state'}
      ,{13,'corp_legal_name'}
      ,{14,'corp_ln_name_type_cd'}
      ,{15,'corp_filing_date'}
      ,{16,'corp_inc_date'}
      ,{17,'corp_forgn_date'}
      ,{18,'corp_foreign_domestic_ind'}
      ,{19,'corp_forgn_state_desc'}
      ,{20,'corp_trademark_class_desc1'}
      ,{21,'corp_trademark_class_desc2'}
      ,{22,'corp_trademark_class_desc3'}
      ,{23,'corp_trademark_class_desc4'}
      ,{24,'corp_trademark_class_desc5'}
      ,{25,'corp_trademark_class_desc6'}
      ,{26,'corp_term_exist_cd'}
      ,{27,'corp_term_exist_exp'}
      ,{28,'corp_orig_org_structure_cd'}
      ,{29,'corp_orig_bus_type_cd'}
      ,{30,'corp_status_desc'}
      ,{31,'corp_status_comment'}
      ,{32,'corp_purpose'}
      ,{33,'corp_ra_resign_date'}
      ,{34,'corp_dissolved_date'}
      ,{35,'corp_name_effective_date'}
      ,{36,'corp_ra_addl_info'}
      ,{37,'corp_agent_status_cd'}
      ,{38,'corp_trademark_first_use_date'}
      ,{39,'corp_trademark_first_use_date_in_state'}
      ,{40,'corp_trademark_renewal_date'}
      ,{41,'corp_registered_counties'}
      ,{42,'cont_status_cd'}
      ,{43,'cont_title1_desc'}
      ,{44,'recordorigin'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_vendor_first_reported((SALT34.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT34.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_first_seen((SALT34.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT34.StrType)le.dt_last_seen),
    Fields.InValid_corp_ra_dt_first_seen((SALT34.StrType)le.corp_ra_dt_first_seen),
    Fields.InValid_corp_ra_dt_last_seen((SALT34.StrType)le.corp_ra_dt_last_seen),
    Fields.InValid_corp_process_date((SALT34.StrType)le.corp_process_date),
    Fields.InValid_corp_key((SALT34.StrType)le.corp_key),
    Fields.InValid_corp_orig_sos_charter_nbr((SALT34.StrType)le.corp_orig_sos_charter_nbr),
    Fields.InValid_corp_vendor((SALT34.StrType)le.corp_vendor),
    Fields.InValid_corp_state_origin((SALT34.StrType)le.corp_state_origin),
    Fields.InValid_corp_inc_state((SALT34.StrType)le.corp_inc_state),
    Fields.InValid_corp_legal_name((SALT34.StrType)le.corp_legal_name),
    Fields.InValid_corp_ln_name_type_cd((SALT34.StrType)le.corp_ln_name_type_cd,(SALT34.StrType)le.recordOrigin),
    Fields.InValid_corp_filing_date((SALT34.StrType)le.corp_filing_date),
    Fields.InValid_corp_inc_date((SALT34.StrType)le.corp_inc_date),
    Fields.InValid_corp_forgn_date((SALT34.StrType)le.corp_forgn_date),
    Fields.InValid_corp_foreign_domestic_ind((SALT34.StrType)le.corp_foreign_domestic_ind),
    Fields.InValid_corp_forgn_state_desc((SALT34.StrType)le.corp_forgn_state_desc),
    Fields.InValid_corp_trademark_class_desc1((SALT34.StrType)le.corp_trademark_class_desc1),
    Fields.InValid_corp_trademark_class_desc2((SALT34.StrType)le.corp_trademark_class_desc2),
    Fields.InValid_corp_trademark_class_desc3((SALT34.StrType)le.corp_trademark_class_desc3),
    Fields.InValid_corp_trademark_class_desc4((SALT34.StrType)le.corp_trademark_class_desc4),
    Fields.InValid_corp_trademark_class_desc5((SALT34.StrType)le.corp_trademark_class_desc5),
    Fields.InValid_corp_trademark_class_desc6((SALT34.StrType)le.corp_trademark_class_desc6),
    Fields.InValid_corp_term_exist_cd((SALT34.StrType)le.corp_term_exist_cd),
    Fields.InValid_corp_term_exist_exp((SALT34.StrType)le.corp_term_exist_exp),
    Fields.InValid_corp_orig_org_structure_cd((SALT34.StrType)le.corp_orig_org_structure_cd),
    Fields.InValid_corp_orig_bus_type_cd((SALT34.StrType)le.corp_orig_bus_type_cd),
    Fields.InValid_corp_status_desc((SALT34.StrType)le.corp_status_desc),
    Fields.InValid_corp_status_comment((SALT34.StrType)le.corp_status_comment),
    Fields.InValid_corp_purpose((SALT34.StrType)le.corp_purpose),
    Fields.InValid_corp_ra_resign_date((SALT34.StrType)le.corp_ra_resign_date),
    Fields.InValid_corp_dissolved_date((SALT34.StrType)le.corp_dissolved_date),
    Fields.InValid_corp_name_effective_date((SALT34.StrType)le.corp_name_effective_date),
    Fields.InValid_corp_ra_addl_info((SALT34.StrType)le.corp_ra_addl_info),
    Fields.InValid_corp_agent_status_cd((SALT34.StrType)le.corp_agent_status_cd),
    Fields.InValid_corp_trademark_first_use_date((SALT34.StrType)le.corp_trademark_first_use_date),
    Fields.InValid_corp_trademark_first_use_date_in_state((SALT34.StrType)le.corp_trademark_first_use_date_in_state),
    Fields.InValid_corp_trademark_renewal_date((SALT34.StrType)le.corp_trademark_renewal_date),
    Fields.InValid_corp_registered_counties((SALT34.StrType)le.corp_registered_counties),
    Fields.InValid_cont_status_cd((SALT34.StrType)le.cont_status_cd),
    Fields.InValid_cont_title1_desc((SALT34.StrType)le.cont_title1_desc),
    Fields.InValid_recordorigin((SALT34.StrType)le.recordorigin),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,44,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_corp_key','invalid_charter_nbr','invalid_corp_vendor','invalid_state_origin','invalid_state_origin','invalid_mandatory','invalid_name_type_cd','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_forgn_dom_code','invalid_characters','invalid_characters','invalid_characters','invalid_characters','invalid_characters','invalid_characters','invalid_characters','invalid_term_cd','invalid_term_exp','invalid_orig_org_structure_cd','invalid_bus_type_cd','invalid_characters','invalid_characters','invalid_characters','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_characters','invalid_status_cd','invalid_optional_date','invalid_optional_date','invalid_optional_date','invalid_characters','invalid_status_cd','invalid_characters','invalid_recordorigin');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_legal_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ln_name_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_foreign_domestic_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_state_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc3(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc4(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc5(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc6(TotalErrors.ErrorNum),Fields.InValidMessage_corp_term_exist_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_term_exist_exp(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_org_structure_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_bus_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_comment(TotalErrors.ErrorNum),Fields.InValidMessage_corp_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_resign_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_dissolved_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_addl_info(TotalErrors.ErrorNum),Fields.InValidMessage_corp_agent_status_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_first_use_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_first_use_date_in_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_renewal_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_registered_counties(TotalErrors.ErrorNum),Fields.InValidMessage_cont_status_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_title1_desc(TotalErrors.ErrorNum),Fields.InValidMessage_recordorigin(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
