IMPORT ut,SALT31;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Prof_License_Mari)
    UNSIGNED1 primary_key_Invalid;
    UNSIGNED1 create_dte_Invalid;
    UNSIGNED1 last_upd_dte_Invalid;
    UNSIGNED1 stamp_dte_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 gen_nbr_Invalid;
    UNSIGNED1 std_prof_desc_Invalid;
    UNSIGNED1 std_source_upd_Invalid;
    UNSIGNED1 std_source_desc_Invalid;
    UNSIGNED1 type_cd_Invalid;
    UNSIGNED1 name_org_prefx_Invalid;
    UNSIGNED1 name_org_Invalid;
    UNSIGNED1 name_org_sufx_Invalid;
    UNSIGNED1 store_nbr_Invalid;
    UNSIGNED1 name_dba_prefx_Invalid;
    UNSIGNED1 name_dba_Invalid;
    UNSIGNED1 name_dba_sufx_Invalid;
    UNSIGNED1 store_nbr_dba_Invalid;
    UNSIGNED1 dba_flag_Invalid;
    UNSIGNED1 name_office_Invalid;
    UNSIGNED1 office_parse_Invalid;
    UNSIGNED1 name_prefx_Invalid;
    UNSIGNED1 name_first_Invalid;
    UNSIGNED1 name_mid_Invalid;
    UNSIGNED1 name_last_Invalid;
    UNSIGNED1 name_sufx_Invalid;
    UNSIGNED1 name_nick_Invalid;
    UNSIGNED1 birth_dte_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 prov_stat_Invalid;
    UNSIGNED1 credential_Invalid;
    UNSIGNED1 license_nbr_Invalid;
    UNSIGNED1 off_license_nbr_Invalid;
    UNSIGNED1 prev_license_nbr_Invalid;
    UNSIGNED1 prev_license_type_Invalid;
    UNSIGNED1 license_state_Invalid;
    UNSIGNED1 raw_license_type_Invalid;
    UNSIGNED1 raw_license_status_Invalid;
    UNSIGNED1 std_status_desc_Invalid;
    UNSIGNED1 curr_issue_dte_Invalid;
    UNSIGNED1 orig_issue_dte_Invalid;
    UNSIGNED1 expire_dte_Invalid;
    UNSIGNED1 renewal_dte_Invalid;
    UNSIGNED1 active_flag_Invalid;
    UNSIGNED1 ssn_taxid_1_Invalid;
    UNSIGNED1 tax_type_1_Invalid;
    UNSIGNED1 ssn_taxid_2_Invalid;
    UNSIGNED1 tax_type_2_Invalid;
    UNSIGNED1 fed_rssd_Invalid;
    UNSIGNED1 addr_bus_ind_Invalid;
    UNSIGNED1 name_format_Invalid;
    UNSIGNED1 name_org_orig_Invalid;
    UNSIGNED1 name_dba_orig_Invalid;
    UNSIGNED1 name_mari_org_Invalid;
    UNSIGNED1 name_mari_dba_Invalid;
    UNSIGNED1 phn_mari_1_Invalid;
    UNSIGNED1 phn_mari_fax_1_Invalid;
    UNSIGNED1 phn_mari_2_Invalid;
    UNSIGNED1 phn_mari_fax_2_Invalid;
    UNSIGNED1 addr_addr1_1_Invalid;
    UNSIGNED1 addr_addr2_1_Invalid;
    UNSIGNED1 addr_addr3_1_Invalid;
    UNSIGNED1 addr_addr4_1_Invalid;
    UNSIGNED1 addr_city_1_Invalid;
    UNSIGNED1 addr_state_1_Invalid;
    UNSIGNED1 addr_zip5_1_Invalid;
    UNSIGNED1 addr_zip4_1_Invalid;
    UNSIGNED1 phn_phone_1_Invalid;
    UNSIGNED1 phn_fax_1_Invalid;
    UNSIGNED1 addr_cnty_1_Invalid;
    UNSIGNED1 addr_cntry_1_Invalid;
    UNSIGNED1 sud_key_1_Invalid;
    UNSIGNED1 ooc_ind_1_Invalid;
    UNSIGNED1 addr_mail_ind_Invalid;
    UNSIGNED1 addr_addr1_2_Invalid;
    UNSIGNED1 addr_addr2_2_Invalid;
    UNSIGNED1 addr_addr3_2_Invalid;
    UNSIGNED1 addr_addr4_2_Invalid;
    UNSIGNED1 addr_city_2_Invalid;
    UNSIGNED1 addr_state_2_Invalid;
    UNSIGNED1 addr_zip5_2_Invalid;
    UNSIGNED1 addr_zip4_2_Invalid;
    UNSIGNED1 addr_cnty_2_Invalid;
    UNSIGNED1 addr_cntry_2_Invalid;
    UNSIGNED1 phn_phone_2_Invalid;
    UNSIGNED1 phn_fax_2_Invalid;
    UNSIGNED1 sud_key_2_Invalid;
    UNSIGNED1 ooc_ind_2_Invalid;
    UNSIGNED1 license_nbr_contact_Invalid;
    UNSIGNED1 name_contact_prefx_Invalid;
    UNSIGNED1 name_contact_first_Invalid;
    UNSIGNED1 name_contact_mid_Invalid;
    UNSIGNED1 name_contact_last_Invalid;
    UNSIGNED1 name_contact_sufx_Invalid;
    UNSIGNED1 name_contact_nick_Invalid;
    UNSIGNED1 name_contact_ttl_Invalid;
    UNSIGNED1 phn_contact_Invalid;
    UNSIGNED1 phn_contact_ext_Invalid;
    UNSIGNED1 phn_contact_fax_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 url_Invalid;
    UNSIGNED1 bk_class_Invalid;
    UNSIGNED1 bk_class_desc_Invalid;
    UNSIGNED1 charter_Invalid;
    UNSIGNED1 inst_beg_dte_Invalid;
    UNSIGNED1 origin_cd_Invalid;
    UNSIGNED1 origin_cd_desc_Invalid;
    UNSIGNED1 disp_type_cd_Invalid;
    UNSIGNED1 disp_type_desc_Invalid;
    UNSIGNED1 reg_agent_Invalid;
    UNSIGNED1 regulator_Invalid;
    UNSIGNED1 hqtr_city_Invalid;
    UNSIGNED1 hqtr_name_Invalid;
    UNSIGNED1 domestic_off_nbr_Invalid;
    UNSIGNED1 foreign_off_nbr_Invalid;
    UNSIGNED1 hcr_rssd_Invalid;
    UNSIGNED1 hcr_location_Invalid;
    UNSIGNED1 affil_type_cd_Invalid;
    UNSIGNED1 genlink_Invalid;
    UNSIGNED1 research_ind_Invalid;
    UNSIGNED1 docket_id_Invalid;
    UNSIGNED1 mltreckey_Invalid;
    UNSIGNED1 cmc_slpk_Invalid;
    UNSIGNED1 pcmc_slpk_Invalid;
    UNSIGNED1 affil_key_Invalid;
    UNSIGNED1 action_taken_ind_Invalid;
    UNSIGNED1 viol_type_Invalid;
    UNSIGNED1 viol_cd_Invalid;
    UNSIGNED1 viol_desc_Invalid;
    UNSIGNED1 viol_dte_Invalid;
    UNSIGNED1 viol_case_nbr_Invalid;
    UNSIGNED1 viol_eff_dte_Invalid;
    UNSIGNED1 action_final_nbr_Invalid;
    UNSIGNED1 action_status_Invalid;
    UNSIGNED1 action_status_dte_Invalid;
    UNSIGNED1 action_file_name_Invalid;
    UNSIGNED1 occupation_Invalid;
    UNSIGNED1 practice_hrs_Invalid;
    UNSIGNED1 practice_type_Invalid;
    UNSIGNED1 misc_other_id_Invalid;
    UNSIGNED1 misc_other_type_Invalid;
    UNSIGNED1 cont_education_ernd_Invalid;
    UNSIGNED1 cont_education_req_Invalid;
    UNSIGNED1 cont_education_term_Invalid;
    UNSIGNED1 schl_attend_1_Invalid;
    UNSIGNED1 schl_attend_dte_1_Invalid;
    UNSIGNED1 schl_curriculum_1_Invalid;
    UNSIGNED1 schl_degree_1_Invalid;
    UNSIGNED1 schl_attend_2_Invalid;
    UNSIGNED1 schl_attend_dte_2_Invalid;
    UNSIGNED1 schl_curriculum_2_Invalid;
    UNSIGNED1 schl_degree_2_Invalid;
    UNSIGNED1 schl_attend_3_Invalid;
    UNSIGNED1 schl_attend_dte_3_Invalid;
    UNSIGNED1 schl_curriculum_3_Invalid;
    UNSIGNED1 schl_degree_3_Invalid;
    UNSIGNED1 addl_license_spec_Invalid;
    UNSIGNED1 place_birth_cd_Invalid;
    UNSIGNED1 place_birth_desc_Invalid;
    UNSIGNED1 race_cd_Invalid;
    UNSIGNED1 std_race_cd_Invalid;
    UNSIGNED1 race_desc_Invalid;
    UNSIGNED1 status_effect_dte_Invalid;
    UNSIGNED1 status_renew_desc_Invalid;
    UNSIGNED1 agency_status_Invalid;
    UNSIGNED1 prev_primary_key_Invalid;
    UNSIGNED1 prev_mltreckey_Invalid;
    UNSIGNED1 prev_cmc_slpk_Invalid;
    UNSIGNED1 prev_pcmc_slpk_Invalid;
    UNSIGNED1 license_id_Invalid;
    UNSIGNED1 nmls_id_Invalid;
    UNSIGNED1 foreign_nmls_id_Invalid;
    UNSIGNED1 location_type_Invalid;
    UNSIGNED1 off_license_nbr_type_Invalid;
    UNSIGNED1 brkr_license_nbr_Invalid;
    UNSIGNED1 brkr_license_nbr_type_Invalid;
    UNSIGNED1 agency_id_Invalid;
    UNSIGNED1 site_location_Invalid;
    UNSIGNED1 business_type_Invalid;
    UNSIGNED1 start_dte_Invalid;
    UNSIGNED1 is_authorized_license_Invalid;
    UNSIGNED1 is_authorized_conduct_Invalid;
    UNSIGNED1 federal_regulator_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Prof_License_Mari)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
  END;
EXPORT FromNone(DATASET(Layout_Prof_License_Mari) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.primary_key_Invalid := Fields.InValid_primary_key((SALT31.StrType)le.primary_key);
    SELF.create_dte_Invalid := Fields.InValid_create_dte((SALT31.StrType)le.create_dte);
    SELF.last_upd_dte_Invalid := Fields.InValid_last_upd_dte((SALT31.StrType)le.last_upd_dte);
    SELF.stamp_dte_Invalid := Fields.InValid_stamp_dte((SALT31.StrType)le.stamp_dte);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT31.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT31.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT31.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT31.StrType)le.date_vendor_last_reported);
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT31.StrType)le.process_date);
    SELF.gen_nbr_Invalid := Fields.InValid_gen_nbr((SALT31.StrType)le.gen_nbr);
    SELF.std_prof_desc_Invalid := Fields.InValid_std_prof_desc((SALT31.StrType)le.std_prof_desc);
    SELF.std_source_upd_Invalid := Fields.InValid_std_source_upd((SALT31.StrType)le.std_source_upd);
    SELF.std_source_desc_Invalid := Fields.InValid_std_source_desc((SALT31.StrType)le.std_source_desc);
    SELF.type_cd_Invalid := Fields.InValid_type_cd((SALT31.StrType)le.type_cd);
    SELF.name_org_prefx_Invalid := Fields.InValid_name_org_prefx((SALT31.StrType)le.name_org_prefx);
    SELF.name_org_Invalid := Fields.InValid_name_org((SALT31.StrType)le.name_org);
    SELF.name_org_sufx_Invalid := Fields.InValid_name_org_sufx((SALT31.StrType)le.name_org_sufx);
    SELF.store_nbr_Invalid := Fields.InValid_store_nbr((SALT31.StrType)le.store_nbr);
    SELF.name_dba_prefx_Invalid := Fields.InValid_name_dba_prefx((SALT31.StrType)le.name_dba_prefx);
    SELF.name_dba_Invalid := Fields.InValid_name_dba((SALT31.StrType)le.name_dba);
    SELF.name_dba_sufx_Invalid := Fields.InValid_name_dba_sufx((SALT31.StrType)le.name_dba_sufx);
    SELF.store_nbr_dba_Invalid := Fields.InValid_store_nbr_dba((SALT31.StrType)le.store_nbr_dba);
    SELF.dba_flag_Invalid := Fields.InValid_dba_flag((SALT31.StrType)le.dba_flag);
    SELF.name_office_Invalid := Fields.InValid_name_office((SALT31.StrType)le.name_office);
    SELF.office_parse_Invalid := Fields.InValid_office_parse((SALT31.StrType)le.office_parse);
    SELF.name_prefx_Invalid := Fields.InValid_name_prefx((SALT31.StrType)le.name_prefx);
    SELF.name_first_Invalid := Fields.InValid_name_first((SALT31.StrType)le.name_first);
    SELF.name_mid_Invalid := Fields.InValid_name_mid((SALT31.StrType)le.name_mid);
    SELF.name_last_Invalid := Fields.InValid_name_last((SALT31.StrType)le.name_last);
    SELF.name_sufx_Invalid := Fields.InValid_name_sufx((SALT31.StrType)le.name_sufx);
    SELF.name_nick_Invalid := Fields.InValid_name_nick((SALT31.StrType)le.name_nick);
    SELF.birth_dte_Invalid := Fields.InValid_birth_dte((SALT31.StrType)le.birth_dte);
    SELF.gender_Invalid := Fields.InValid_gender((SALT31.StrType)le.gender);
    SELF.prov_stat_Invalid := Fields.InValid_prov_stat((SALT31.StrType)le.prov_stat);
    SELF.credential_Invalid := Fields.InValid_credential((SALT31.StrType)le.credential);
    SELF.license_nbr_Invalid := Fields.InValid_license_nbr((SALT31.StrType)le.license_nbr);
    SELF.off_license_nbr_Invalid := Fields.InValid_off_license_nbr((SALT31.StrType)le.off_license_nbr);
    SELF.prev_license_nbr_Invalid := Fields.InValid_prev_license_nbr((SALT31.StrType)le.prev_license_nbr);
    SELF.prev_license_type_Invalid := Fields.InValid_prev_license_type((SALT31.StrType)le.prev_license_type);
    SELF.license_state_Invalid := Fields.InValid_license_state((SALT31.StrType)le.license_state);
    SELF.raw_license_type_Invalid := Fields.InValid_raw_license_type((SALT31.StrType)le.raw_license_type);
    SELF.raw_license_status_Invalid := Fields.InValid_raw_license_status((SALT31.StrType)le.raw_license_status);
    SELF.std_status_desc_Invalid := Fields.InValid_std_status_desc((SALT31.StrType)le.std_status_desc);
    SELF.curr_issue_dte_Invalid := Fields.InValid_curr_issue_dte((SALT31.StrType)le.curr_issue_dte);
    SELF.orig_issue_dte_Invalid := Fields.InValid_orig_issue_dte((SALT31.StrType)le.orig_issue_dte);
    SELF.expire_dte_Invalid := Fields.InValid_expire_dte((SALT31.StrType)le.expire_dte);
    SELF.renewal_dte_Invalid := Fields.InValid_renewal_dte((SALT31.StrType)le.renewal_dte);
    SELF.active_flag_Invalid := Fields.InValid_active_flag((SALT31.StrType)le.active_flag);
    SELF.ssn_taxid_1_Invalid := Fields.InValid_ssn_taxid_1((SALT31.StrType)le.ssn_taxid_1);
    SELF.tax_type_1_Invalid := Fields.InValid_tax_type_1((SALT31.StrType)le.tax_type_1);
    SELF.ssn_taxid_2_Invalid := Fields.InValid_ssn_taxid_2((SALT31.StrType)le.ssn_taxid_2);
    SELF.tax_type_2_Invalid := Fields.InValid_tax_type_2((SALT31.StrType)le.tax_type_2);
    SELF.fed_rssd_Invalid := Fields.InValid_fed_rssd((SALT31.StrType)le.fed_rssd);
    SELF.addr_bus_ind_Invalid := Fields.InValid_addr_bus_ind((SALT31.StrType)le.addr_bus_ind);
    SELF.name_format_Invalid := Fields.InValid_name_format((SALT31.StrType)le.name_format);
    SELF.name_org_orig_Invalid := Fields.InValid_name_org_orig((SALT31.StrType)le.name_org_orig);
    SELF.name_dba_orig_Invalid := Fields.InValid_name_dba_orig((SALT31.StrType)le.name_dba_orig);
    SELF.name_mari_org_Invalid := Fields.InValid_name_mari_org((SALT31.StrType)le.name_mari_org);
    SELF.name_mari_dba_Invalid := Fields.InValid_name_mari_dba((SALT31.StrType)le.name_mari_dba);
    SELF.phn_mari_1_Invalid := Fields.InValid_phn_mari_1((SALT31.StrType)le.phn_mari_1);
    SELF.phn_mari_fax_1_Invalid := Fields.InValid_phn_mari_fax_1((SALT31.StrType)le.phn_mari_fax_1);
    SELF.phn_mari_2_Invalid := Fields.InValid_phn_mari_2((SALT31.StrType)le.phn_mari_2);
    SELF.phn_mari_fax_2_Invalid := Fields.InValid_phn_mari_fax_2((SALT31.StrType)le.phn_mari_fax_2);
    SELF.addr_addr1_1_Invalid := Fields.InValid_addr_addr1_1((SALT31.StrType)le.addr_addr1_1);
    SELF.addr_addr2_1_Invalid := Fields.InValid_addr_addr2_1((SALT31.StrType)le.addr_addr2_1);
    SELF.addr_addr3_1_Invalid := Fields.InValid_addr_addr3_1((SALT31.StrType)le.addr_addr3_1);
    SELF.addr_addr4_1_Invalid := Fields.InValid_addr_addr4_1((SALT31.StrType)le.addr_addr4_1);
    SELF.addr_city_1_Invalid := Fields.InValid_addr_city_1((SALT31.StrType)le.addr_city_1);
    SELF.addr_state_1_Invalid := Fields.InValid_addr_state_1((SALT31.StrType)le.addr_state_1);
    SELF.addr_zip5_1_Invalid := Fields.InValid_addr_zip5_1((SALT31.StrType)le.addr_zip5_1);
    SELF.addr_zip4_1_Invalid := Fields.InValid_addr_zip4_1((SALT31.StrType)le.addr_zip4_1);
    SELF.phn_phone_1_Invalid := Fields.InValid_phn_phone_1((SALT31.StrType)le.phn_phone_1);
    SELF.phn_fax_1_Invalid := Fields.InValid_phn_fax_1((SALT31.StrType)le.phn_fax_1);
    SELF.addr_cnty_1_Invalid := Fields.InValid_addr_cnty_1((SALT31.StrType)le.addr_cnty_1);
    SELF.addr_cntry_1_Invalid := Fields.InValid_addr_cntry_1((SALT31.StrType)le.addr_cntry_1);
    SELF.sud_key_1_Invalid := Fields.InValid_sud_key_1((SALT31.StrType)le.sud_key_1);
    SELF.ooc_ind_1_Invalid := Fields.InValid_ooc_ind_1((SALT31.StrType)le.ooc_ind_1);
    SELF.addr_mail_ind_Invalid := Fields.InValid_addr_mail_ind((SALT31.StrType)le.addr_mail_ind);
    SELF.addr_addr1_2_Invalid := Fields.InValid_addr_addr1_2((SALT31.StrType)le.addr_addr1_2);
    SELF.addr_addr2_2_Invalid := Fields.InValid_addr_addr2_2((SALT31.StrType)le.addr_addr2_2);
    SELF.addr_addr3_2_Invalid := Fields.InValid_addr_addr3_2((SALT31.StrType)le.addr_addr3_2);
    SELF.addr_addr4_2_Invalid := Fields.InValid_addr_addr4_2((SALT31.StrType)le.addr_addr4_2);
    SELF.addr_city_2_Invalid := Fields.InValid_addr_city_2((SALT31.StrType)le.addr_city_2);
    SELF.addr_state_2_Invalid := Fields.InValid_addr_state_2((SALT31.StrType)le.addr_state_2);
    SELF.addr_zip5_2_Invalid := Fields.InValid_addr_zip5_2((SALT31.StrType)le.addr_zip5_2);
    SELF.addr_zip4_2_Invalid := Fields.InValid_addr_zip4_2((SALT31.StrType)le.addr_zip4_2);
    SELF.addr_cnty_2_Invalid := Fields.InValid_addr_cnty_2((SALT31.StrType)le.addr_cnty_2);
    SELF.addr_cntry_2_Invalid := Fields.InValid_addr_cntry_2((SALT31.StrType)le.addr_cntry_2);
    SELF.phn_phone_2_Invalid := Fields.InValid_phn_phone_2((SALT31.StrType)le.phn_phone_2);
    SELF.phn_fax_2_Invalid := Fields.InValid_phn_fax_2((SALT31.StrType)le.phn_fax_2);
    SELF.sud_key_2_Invalid := Fields.InValid_sud_key_2((SALT31.StrType)le.sud_key_2);
    SELF.ooc_ind_2_Invalid := Fields.InValid_ooc_ind_2((SALT31.StrType)le.ooc_ind_2);
    SELF.license_nbr_contact_Invalid := Fields.InValid_license_nbr_contact((SALT31.StrType)le.license_nbr_contact);
    SELF.name_contact_prefx_Invalid := Fields.InValid_name_contact_prefx((SALT31.StrType)le.name_contact_prefx);
    SELF.name_contact_first_Invalid := Fields.InValid_name_contact_first((SALT31.StrType)le.name_contact_first);
    SELF.name_contact_mid_Invalid := Fields.InValid_name_contact_mid((SALT31.StrType)le.name_contact_mid);
    SELF.name_contact_last_Invalid := Fields.InValid_name_contact_last((SALT31.StrType)le.name_contact_last);
    SELF.name_contact_sufx_Invalid := Fields.InValid_name_contact_sufx((SALT31.StrType)le.name_contact_sufx);
    SELF.name_contact_nick_Invalid := Fields.InValid_name_contact_nick((SALT31.StrType)le.name_contact_nick);
    SELF.name_contact_ttl_Invalid := Fields.InValid_name_contact_ttl((SALT31.StrType)le.name_contact_ttl);
    SELF.phn_contact_Invalid := Fields.InValid_phn_contact((SALT31.StrType)le.phn_contact);
    SELF.phn_contact_ext_Invalid := Fields.InValid_phn_contact_ext((SALT31.StrType)le.phn_contact_ext);
    SELF.phn_contact_fax_Invalid := Fields.InValid_phn_contact_fax((SALT31.StrType)le.phn_contact_fax);
    SELF.email_Invalid := Fields.InValid_email((SALT31.StrType)le.email);
    SELF.url_Invalid := Fields.InValid_url((SALT31.StrType)le.url);
    SELF.bk_class_Invalid := Fields.InValid_bk_class((SALT31.StrType)le.bk_class);
    SELF.bk_class_desc_Invalid := Fields.InValid_bk_class_desc((SALT31.StrType)le.bk_class_desc);
    SELF.charter_Invalid := Fields.InValid_charter((SALT31.StrType)le.charter);
    SELF.inst_beg_dte_Invalid := Fields.InValid_inst_beg_dte((SALT31.StrType)le.inst_beg_dte);
    SELF.origin_cd_Invalid := Fields.InValid_origin_cd((SALT31.StrType)le.origin_cd);
    SELF.origin_cd_desc_Invalid := Fields.InValid_origin_cd_desc((SALT31.StrType)le.origin_cd_desc);
    SELF.disp_type_cd_Invalid := Fields.InValid_disp_type_cd((SALT31.StrType)le.disp_type_cd);
    SELF.disp_type_desc_Invalid := Fields.InValid_disp_type_desc((SALT31.StrType)le.disp_type_desc);
    SELF.reg_agent_Invalid := Fields.InValid_reg_agent((SALT31.StrType)le.reg_agent);
    SELF.regulator_Invalid := Fields.InValid_regulator((SALT31.StrType)le.regulator);
    SELF.hqtr_city_Invalid := Fields.InValid_hqtr_city((SALT31.StrType)le.hqtr_city);
    SELF.hqtr_name_Invalid := Fields.InValid_hqtr_name((SALT31.StrType)le.hqtr_name);
    SELF.domestic_off_nbr_Invalid := Fields.InValid_domestic_off_nbr((SALT31.StrType)le.domestic_off_nbr);
    SELF.foreign_off_nbr_Invalid := Fields.InValid_foreign_off_nbr((SALT31.StrType)le.foreign_off_nbr);
    SELF.hcr_rssd_Invalid := Fields.InValid_hcr_rssd((SALT31.StrType)le.hcr_rssd);
    SELF.hcr_location_Invalid := Fields.InValid_hcr_location((SALT31.StrType)le.hcr_location);
    SELF.affil_type_cd_Invalid := Fields.InValid_affil_type_cd((SALT31.StrType)le.affil_type_cd);
    SELF.genlink_Invalid := Fields.InValid_genlink((SALT31.StrType)le.genlink);
    SELF.research_ind_Invalid := Fields.InValid_research_ind((SALT31.StrType)le.research_ind);
    SELF.docket_id_Invalid := Fields.InValid_docket_id((SALT31.StrType)le.docket_id);
    SELF.mltreckey_Invalid := Fields.InValid_mltreckey((SALT31.StrType)le.mltreckey);
    SELF.cmc_slpk_Invalid := Fields.InValid_cmc_slpk((SALT31.StrType)le.cmc_slpk);
    SELF.pcmc_slpk_Invalid := Fields.InValid_pcmc_slpk((SALT31.StrType)le.pcmc_slpk);
    SELF.affil_key_Invalid := Fields.InValid_affil_key((SALT31.StrType)le.affil_key);
    SELF.action_taken_ind_Invalid := Fields.InValid_action_taken_ind((SALT31.StrType)le.action_taken_ind);
    SELF.viol_type_Invalid := Fields.InValid_viol_type((SALT31.StrType)le.viol_type);
    SELF.viol_cd_Invalid := Fields.InValid_viol_cd((SALT31.StrType)le.viol_cd);
    SELF.viol_desc_Invalid := Fields.InValid_viol_desc((SALT31.StrType)le.viol_desc);
    SELF.viol_dte_Invalid := Fields.InValid_viol_dte((SALT31.StrType)le.viol_dte);
    SELF.viol_case_nbr_Invalid := Fields.InValid_viol_case_nbr((SALT31.StrType)le.viol_case_nbr);
    SELF.viol_eff_dte_Invalid := Fields.InValid_viol_eff_dte((SALT31.StrType)le.viol_eff_dte);
    SELF.action_final_nbr_Invalid := Fields.InValid_action_final_nbr((SALT31.StrType)le.action_final_nbr);
    SELF.action_status_Invalid := Fields.InValid_action_status((SALT31.StrType)le.action_status);
    SELF.action_status_dte_Invalid := Fields.InValid_action_status_dte((SALT31.StrType)le.action_status_dte);
    SELF.action_file_name_Invalid := Fields.InValid_action_file_name((SALT31.StrType)le.action_file_name);
    SELF.occupation_Invalid := Fields.InValid_occupation((SALT31.StrType)le.occupation);
    SELF.practice_hrs_Invalid := Fields.InValid_practice_hrs((SALT31.StrType)le.practice_hrs);
    SELF.practice_type_Invalid := Fields.InValid_practice_type((SALT31.StrType)le.practice_type);
    SELF.misc_other_id_Invalid := Fields.InValid_misc_other_id((SALT31.StrType)le.misc_other_id);
    SELF.misc_other_type_Invalid := Fields.InValid_misc_other_type((SALT31.StrType)le.misc_other_type);
    SELF.cont_education_ernd_Invalid := Fields.InValid_cont_education_ernd((SALT31.StrType)le.cont_education_ernd);
    SELF.cont_education_req_Invalid := Fields.InValid_cont_education_req((SALT31.StrType)le.cont_education_req);
    SELF.cont_education_term_Invalid := Fields.InValid_cont_education_term((SALT31.StrType)le.cont_education_term);
    SELF.schl_attend_1_Invalid := Fields.InValid_schl_attend_1((SALT31.StrType)le.schl_attend_1);
    SELF.schl_attend_dte_1_Invalid := Fields.InValid_schl_attend_dte_1((SALT31.StrType)le.schl_attend_dte_1);
    SELF.schl_curriculum_1_Invalid := Fields.InValid_schl_curriculum_1((SALT31.StrType)le.schl_curriculum_1);
    SELF.schl_degree_1_Invalid := Fields.InValid_schl_degree_1((SALT31.StrType)le.schl_degree_1);
    SELF.schl_attend_2_Invalid := Fields.InValid_schl_attend_2((SALT31.StrType)le.schl_attend_2);
    SELF.schl_attend_dte_2_Invalid := Fields.InValid_schl_attend_dte_2((SALT31.StrType)le.schl_attend_dte_2);
    SELF.schl_curriculum_2_Invalid := Fields.InValid_schl_curriculum_2((SALT31.StrType)le.schl_curriculum_2);
    SELF.schl_degree_2_Invalid := Fields.InValid_schl_degree_2((SALT31.StrType)le.schl_degree_2);
    SELF.schl_attend_3_Invalid := Fields.InValid_schl_attend_3((SALT31.StrType)le.schl_attend_3);
    SELF.schl_attend_dte_3_Invalid := Fields.InValid_schl_attend_dte_3((SALT31.StrType)le.schl_attend_dte_3);
    SELF.schl_curriculum_3_Invalid := Fields.InValid_schl_curriculum_3((SALT31.StrType)le.schl_curriculum_3);
    SELF.schl_degree_3_Invalid := Fields.InValid_schl_degree_3((SALT31.StrType)le.schl_degree_3);
    SELF.addl_license_spec_Invalid := Fields.InValid_addl_license_spec((SALT31.StrType)le.addl_license_spec);
    SELF.place_birth_cd_Invalid := Fields.InValid_place_birth_cd((SALT31.StrType)le.place_birth_cd);
    SELF.place_birth_desc_Invalid := Fields.InValid_place_birth_desc((SALT31.StrType)le.place_birth_desc);
    SELF.race_cd_Invalid := Fields.InValid_race_cd((SALT31.StrType)le.race_cd);
    SELF.std_race_cd_Invalid := Fields.InValid_std_race_cd((SALT31.StrType)le.std_race_cd);
    SELF.race_desc_Invalid := Fields.InValid_race_desc((SALT31.StrType)le.race_desc);
    SELF.status_effect_dte_Invalid := Fields.InValid_status_effect_dte((SALT31.StrType)le.status_effect_dte);
    SELF.status_renew_desc_Invalid := Fields.InValid_status_renew_desc((SALT31.StrType)le.status_renew_desc);
    SELF.agency_status_Invalid := Fields.InValid_agency_status((SALT31.StrType)le.agency_status);
    SELF.prev_primary_key_Invalid := Fields.InValid_prev_primary_key((SALT31.StrType)le.prev_primary_key);
    SELF.prev_mltreckey_Invalid := Fields.InValid_prev_mltreckey((SALT31.StrType)le.prev_mltreckey);
    SELF.prev_cmc_slpk_Invalid := Fields.InValid_prev_cmc_slpk((SALT31.StrType)le.prev_cmc_slpk);
    SELF.prev_pcmc_slpk_Invalid := Fields.InValid_prev_pcmc_slpk((SALT31.StrType)le.prev_pcmc_slpk);
    SELF.license_id_Invalid := Fields.InValid_license_id((SALT31.StrType)le.license_id);
    SELF.nmls_id_Invalid := Fields.InValid_nmls_id((SALT31.StrType)le.nmls_id);
    SELF.foreign_nmls_id_Invalid := Fields.InValid_foreign_nmls_id((SALT31.StrType)le.foreign_nmls_id);
    SELF.location_type_Invalid := Fields.InValid_location_type((SALT31.StrType)le.location_type);
    SELF.off_license_nbr_type_Invalid := Fields.InValid_off_license_nbr_type((SALT31.StrType)le.off_license_nbr_type);
    SELF.brkr_license_nbr_Invalid := Fields.InValid_brkr_license_nbr((SALT31.StrType)le.brkr_license_nbr);
    SELF.brkr_license_nbr_type_Invalid := Fields.InValid_brkr_license_nbr_type((SALT31.StrType)le.brkr_license_nbr_type);
    SELF.agency_id_Invalid := Fields.InValid_agency_id((SALT31.StrType)le.agency_id);
    SELF.site_location_Invalid := Fields.InValid_site_location((SALT31.StrType)le.site_location);
    SELF.business_type_Invalid := Fields.InValid_business_type((SALT31.StrType)le.business_type);
    SELF.start_dte_Invalid := Fields.InValid_start_dte((SALT31.StrType)le.start_dte);
    SELF.is_authorized_license_Invalid := Fields.InValid_is_authorized_license((SALT31.StrType)le.is_authorized_license);
    SELF.is_authorized_conduct_Invalid := Fields.InValid_is_authorized_conduct((SALT31.StrType)le.is_authorized_conduct);
    SELF.federal_regulator_Invalid := Fields.InValid_federal_regulator((SALT31.StrType)le.federal_regulator);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.primary_key_Invalid << 0 ) + ( le.create_dte_Invalid << 1 ) + ( le.last_upd_dte_Invalid << 3 ) + ( le.stamp_dte_Invalid << 5 ) + ( le.date_first_seen_Invalid << 7 ) + ( le.date_last_seen_Invalid << 9 ) + ( le.date_vendor_first_reported_Invalid << 11 ) + ( le.date_vendor_last_reported_Invalid << 13 ) + ( le.process_date_Invalid << 15 ) + ( le.gen_nbr_Invalid << 17 ) + ( le.std_prof_desc_Invalid << 19 ) + ( le.std_source_upd_Invalid << 20 ) + ( le.std_source_desc_Invalid << 22 ) + ( le.type_cd_Invalid << 24 ) + ( le.name_org_prefx_Invalid << 26 ) + ( le.name_org_Invalid << 28 ) + ( le.name_org_sufx_Invalid << 29 ) + ( le.store_nbr_Invalid << 31 ) + ( le.name_dba_prefx_Invalid << 33 ) + ( le.name_dba_Invalid << 35 ) + ( le.name_dba_sufx_Invalid << 36 ) + ( le.store_nbr_dba_Invalid << 38 ) + ( le.dba_flag_Invalid << 40 ) + ( le.name_office_Invalid << 41 ) + ( le.office_parse_Invalid << 43 ) + ( le.name_prefx_Invalid << 45 ) + ( le.name_first_Invalid << 46 ) + ( le.name_mid_Invalid << 47 ) + ( le.name_last_Invalid << 48 ) + ( le.name_sufx_Invalid << 49 ) + ( le.name_nick_Invalid << 50 ) + ( le.birth_dte_Invalid << 51 ) + ( le.gender_Invalid << 53 ) + ( le.prov_stat_Invalid << 55 ) + ( le.credential_Invalid << 57 ) + ( le.license_nbr_Invalid << 59 ) + ( le.off_license_nbr_Invalid << 60 ) + ( le.prev_license_nbr_Invalid << 61 ) + ( le.prev_license_type_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.license_state_Invalid << 0 ) + ( le.raw_license_type_Invalid << 2 ) + ( le.raw_license_status_Invalid << 3 ) + ( le.std_status_desc_Invalid << 4 ) + ( le.curr_issue_dte_Invalid << 5 ) + ( le.orig_issue_dte_Invalid << 7 ) + ( le.expire_dte_Invalid << 9 ) + ( le.renewal_dte_Invalid << 11 ) + ( le.active_flag_Invalid << 12 ) + ( le.ssn_taxid_1_Invalid << 14 ) + ( le.tax_type_1_Invalid << 16 ) + ( le.ssn_taxid_2_Invalid << 18 ) + ( le.tax_type_2_Invalid << 19 ) + ( le.fed_rssd_Invalid << 20 ) + ( le.addr_bus_ind_Invalid << 22 ) + ( le.name_format_Invalid << 24 ) + ( le.name_org_orig_Invalid << 26 ) + ( le.name_dba_orig_Invalid << 27 ) + ( le.name_mari_org_Invalid << 28 ) + ( le.name_mari_dba_Invalid << 29 ) + ( le.phn_mari_1_Invalid << 30 ) + ( le.phn_mari_fax_1_Invalid << 32 ) + ( le.phn_mari_2_Invalid << 34 ) + ( le.phn_mari_fax_2_Invalid << 36 ) + ( le.addr_addr1_1_Invalid << 38 ) + ( le.addr_addr2_1_Invalid << 39 ) + ( le.addr_addr3_1_Invalid << 40 ) + ( le.addr_addr4_1_Invalid << 41 ) + ( le.addr_city_1_Invalid << 42 ) + ( le.addr_state_1_Invalid << 43 ) + ( le.addr_zip5_1_Invalid << 45 ) + ( le.addr_zip4_1_Invalid << 47 ) + ( le.phn_phone_1_Invalid << 49 ) + ( le.phn_fax_1_Invalid << 51 ) + ( le.addr_cnty_1_Invalid << 53 ) + ( le.addr_cntry_1_Invalid << 54 ) + ( le.sud_key_1_Invalid << 55 ) + ( le.ooc_ind_1_Invalid << 56 ) + ( le.addr_mail_ind_Invalid << 58 ) + ( le.addr_addr1_2_Invalid << 60 ) + ( le.addr_addr2_2_Invalid << 61 ) + ( le.addr_addr3_2_Invalid << 62 ) + ( le.addr_addr4_2_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.addr_city_2_Invalid << 0 ) + ( le.addr_state_2_Invalid << 1 ) + ( le.addr_zip5_2_Invalid << 3 ) + ( le.addr_zip4_2_Invalid << 5 ) + ( le.addr_cnty_2_Invalid << 7 ) + ( le.addr_cntry_2_Invalid << 8 ) + ( le.phn_phone_2_Invalid << 9 ) + ( le.phn_fax_2_Invalid << 11 ) + ( le.sud_key_2_Invalid << 13 ) + ( le.ooc_ind_2_Invalid << 14 ) + ( le.license_nbr_contact_Invalid << 16 ) + ( le.name_contact_prefx_Invalid << 17 ) + ( le.name_contact_first_Invalid << 18 ) + ( le.name_contact_mid_Invalid << 19 ) + ( le.name_contact_last_Invalid << 20 ) + ( le.name_contact_sufx_Invalid << 21 ) + ( le.name_contact_nick_Invalid << 22 ) + ( le.name_contact_ttl_Invalid << 23 ) + ( le.phn_contact_Invalid << 24 ) + ( le.phn_contact_ext_Invalid << 26 ) + ( le.phn_contact_fax_Invalid << 28 ) + ( le.email_Invalid << 30 ) + ( le.url_Invalid << 31 ) + ( le.bk_class_Invalid << 32 ) + ( le.bk_class_desc_Invalid << 34 ) + ( le.charter_Invalid << 35 ) + ( le.inst_beg_dte_Invalid << 36 ) + ( le.origin_cd_Invalid << 38 ) + ( le.origin_cd_desc_Invalid << 40 ) + ( le.disp_type_cd_Invalid << 41 ) + ( le.disp_type_desc_Invalid << 43 ) + ( le.reg_agent_Invalid << 44 ) + ( le.regulator_Invalid << 45 ) + ( le.hqtr_city_Invalid << 46 ) + ( le.hqtr_name_Invalid << 47 ) + ( le.domestic_off_nbr_Invalid << 48 ) + ( le.foreign_off_nbr_Invalid << 49 ) + ( le.hcr_rssd_Invalid << 50 ) + ( le.hcr_location_Invalid << 51 ) + ( le.affil_type_cd_Invalid << 53 ) + ( le.genlink_Invalid << 55 ) + ( le.research_ind_Invalid << 57 ) + ( le.docket_id_Invalid << 59 ) + ( le.mltreckey_Invalid << 60 ) + ( le.cmc_slpk_Invalid << 61 ) + ( le.pcmc_slpk_Invalid << 62 ) + ( le.affil_key_Invalid << 63 );
    SELF.ScrubsBits4 := ( le.action_taken_ind_Invalid << 0 ) + ( le.viol_type_Invalid << 1 ) + ( le.viol_cd_Invalid << 2 ) + ( le.viol_desc_Invalid << 3 ) + ( le.viol_dte_Invalid << 4 ) + ( le.viol_case_nbr_Invalid << 6 ) + ( le.viol_eff_dte_Invalid << 7 ) + ( le.action_final_nbr_Invalid << 8 ) + ( le.action_status_Invalid << 9 ) + ( le.action_status_dte_Invalid << 10 ) + ( le.action_file_name_Invalid << 11 ) + ( le.occupation_Invalid << 12 ) + ( le.practice_hrs_Invalid << 13 ) + ( le.practice_type_Invalid << 14 ) + ( le.misc_other_id_Invalid << 15 ) + ( le.misc_other_type_Invalid << 16 ) + ( le.cont_education_ernd_Invalid << 17 ) + ( le.cont_education_req_Invalid << 18 ) + ( le.cont_education_term_Invalid << 19 ) + ( le.schl_attend_1_Invalid << 20 ) + ( le.schl_attend_dte_1_Invalid << 21 ) + ( le.schl_curriculum_1_Invalid << 22 ) + ( le.schl_degree_1_Invalid << 23 ) + ( le.schl_attend_2_Invalid << 24 ) + ( le.schl_attend_dte_2_Invalid << 25 ) + ( le.schl_curriculum_2_Invalid << 26 ) + ( le.schl_degree_2_Invalid << 27 ) + ( le.schl_attend_3_Invalid << 28 ) + ( le.schl_attend_dte_3_Invalid << 29 ) + ( le.schl_curriculum_3_Invalid << 30 ) + ( le.schl_degree_3_Invalid << 31 ) + ( le.addl_license_spec_Invalid << 32 ) + ( le.place_birth_cd_Invalid << 33 ) + ( le.place_birth_desc_Invalid << 34 ) + ( le.race_cd_Invalid << 35 ) + ( le.std_race_cd_Invalid << 37 ) + ( le.race_desc_Invalid << 38 ) + ( le.status_effect_dte_Invalid << 39 ) + ( le.status_renew_desc_Invalid << 41 ) + ( le.agency_status_Invalid << 42 ) + ( le.prev_primary_key_Invalid << 43 ) + ( le.prev_mltreckey_Invalid << 44 ) + ( le.prev_cmc_slpk_Invalid << 45 ) + ( le.prev_pcmc_slpk_Invalid << 46 ) + ( le.license_id_Invalid << 47 ) + ( le.nmls_id_Invalid << 48 ) + ( le.foreign_nmls_id_Invalid << 49 ) + ( le.location_type_Invalid << 50 ) + ( le.off_license_nbr_type_Invalid << 51 ) + ( le.brkr_license_nbr_Invalid << 52 ) + ( le.brkr_license_nbr_type_Invalid << 53 ) + ( le.agency_id_Invalid << 54 ) + ( le.site_location_Invalid << 55 ) + ( le.business_type_Invalid << 56 ) + ( le.start_dte_Invalid << 57 ) + ( le.is_authorized_license_Invalid << 59 ) + ( le.is_authorized_conduct_Invalid << 60 ) + ( le.federal_regulator_Invalid << 61 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Prof_License_Mari);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.primary_key_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.create_dte_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.last_upd_dte_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.stamp_dte_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.gen_nbr_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.std_prof_desc_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.std_source_upd_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.std_source_desc_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.type_cd_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.name_org_prefx_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.name_org_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.name_org_sufx_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.store_nbr_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.name_dba_prefx_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.name_dba_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.name_dba_sufx_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.store_nbr_dba_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.dba_flag_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.name_office_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.office_parse_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.name_prefx_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.name_first_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.name_mid_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.name_last_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.name_sufx_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.name_nick_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.birth_dte_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.prov_stat_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.credential_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.license_nbr_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.off_license_nbr_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.prev_license_nbr_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.prev_license_type_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.license_state_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.raw_license_type_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.raw_license_status_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.std_status_desc_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.curr_issue_dte_Invalid := (le.ScrubsBits2 >> 5) & 3;
    SELF.orig_issue_dte_Invalid := (le.ScrubsBits2 >> 7) & 3;
    SELF.expire_dte_Invalid := (le.ScrubsBits2 >> 9) & 3;
    SELF.renewal_dte_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.active_flag_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.ssn_taxid_1_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.tax_type_1_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.ssn_taxid_2_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.tax_type_2_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.fed_rssd_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.addr_bus_ind_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.name_format_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.name_org_orig_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.name_dba_orig_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.name_mari_org_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.name_mari_dba_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.phn_mari_1_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.phn_mari_fax_1_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.phn_mari_2_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.phn_mari_fax_2_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.addr_addr1_1_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.addr_addr2_1_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.addr_addr3_1_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.addr_addr4_1_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.addr_city_1_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.addr_state_1_Invalid := (le.ScrubsBits2 >> 43) & 3;
    SELF.addr_zip5_1_Invalid := (le.ScrubsBits2 >> 45) & 3;
    SELF.addr_zip4_1_Invalid := (le.ScrubsBits2 >> 47) & 3;
    SELF.phn_phone_1_Invalid := (le.ScrubsBits2 >> 49) & 3;
    SELF.phn_fax_1_Invalid := (le.ScrubsBits2 >> 51) & 3;
    SELF.addr_cnty_1_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.addr_cntry_1_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.sud_key_1_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.ooc_ind_1_Invalid := (le.ScrubsBits2 >> 56) & 3;
    SELF.addr_mail_ind_Invalid := (le.ScrubsBits2 >> 58) & 3;
    SELF.addr_addr1_2_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.addr_addr2_2_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.addr_addr3_2_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.addr_addr4_2_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.addr_city_2_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.addr_state_2_Invalid := (le.ScrubsBits3 >> 1) & 3;
    SELF.addr_zip5_2_Invalid := (le.ScrubsBits3 >> 3) & 3;
    SELF.addr_zip4_2_Invalid := (le.ScrubsBits3 >> 5) & 3;
    SELF.addr_cnty_2_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.addr_cntry_2_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.phn_phone_2_Invalid := (le.ScrubsBits3 >> 9) & 3;
    SELF.phn_fax_2_Invalid := (le.ScrubsBits3 >> 11) & 3;
    SELF.sud_key_2_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.ooc_ind_2_Invalid := (le.ScrubsBits3 >> 14) & 3;
    SELF.license_nbr_contact_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.name_contact_prefx_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.name_contact_first_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.name_contact_mid_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.name_contact_last_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.name_contact_sufx_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.name_contact_nick_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.name_contact_ttl_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.phn_contact_Invalid := (le.ScrubsBits3 >> 24) & 3;
    SELF.phn_contact_ext_Invalid := (le.ScrubsBits3 >> 26) & 3;
    SELF.phn_contact_fax_Invalid := (le.ScrubsBits3 >> 28) & 3;
    SELF.email_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.url_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.bk_class_Invalid := (le.ScrubsBits3 >> 32) & 3;
    SELF.bk_class_desc_Invalid := (le.ScrubsBits3 >> 34) & 1;
    SELF.charter_Invalid := (le.ScrubsBits3 >> 35) & 1;
    SELF.inst_beg_dte_Invalid := (le.ScrubsBits3 >> 36) & 3;
    SELF.origin_cd_Invalid := (le.ScrubsBits3 >> 38) & 3;
    SELF.origin_cd_desc_Invalid := (le.ScrubsBits3 >> 40) & 1;
    SELF.disp_type_cd_Invalid := (le.ScrubsBits3 >> 41) & 3;
    SELF.disp_type_desc_Invalid := (le.ScrubsBits3 >> 43) & 1;
    SELF.reg_agent_Invalid := (le.ScrubsBits3 >> 44) & 1;
    SELF.regulator_Invalid := (le.ScrubsBits3 >> 45) & 1;
    SELF.hqtr_city_Invalid := (le.ScrubsBits3 >> 46) & 1;
    SELF.hqtr_name_Invalid := (le.ScrubsBits3 >> 47) & 1;
    SELF.domestic_off_nbr_Invalid := (le.ScrubsBits3 >> 48) & 1;
    SELF.foreign_off_nbr_Invalid := (le.ScrubsBits3 >> 49) & 1;
    SELF.hcr_rssd_Invalid := (le.ScrubsBits3 >> 50) & 1;
    SELF.hcr_location_Invalid := (le.ScrubsBits3 >> 51) & 3;
    SELF.affil_type_cd_Invalid := (le.ScrubsBits3 >> 53) & 3;
    SELF.genlink_Invalid := (le.ScrubsBits3 >> 55) & 3;
    SELF.research_ind_Invalid := (le.ScrubsBits3 >> 57) & 3;
    SELF.docket_id_Invalid := (le.ScrubsBits3 >> 59) & 1;
    SELF.mltreckey_Invalid := (le.ScrubsBits3 >> 60) & 1;
    SELF.cmc_slpk_Invalid := (le.ScrubsBits3 >> 61) & 1;
    SELF.pcmc_slpk_Invalid := (le.ScrubsBits3 >> 62) & 1;
    SELF.affil_key_Invalid := (le.ScrubsBits3 >> 63) & 1;
    SELF.action_taken_ind_Invalid := (le.ScrubsBits4 >> 0) & 1;
    SELF.viol_type_Invalid := (le.ScrubsBits4 >> 1) & 1;
    SELF.viol_cd_Invalid := (le.ScrubsBits4 >> 2) & 1;
    SELF.viol_desc_Invalid := (le.ScrubsBits4 >> 3) & 1;
    SELF.viol_dte_Invalid := (le.ScrubsBits4 >> 4) & 3;
    SELF.viol_case_nbr_Invalid := (le.ScrubsBits4 >> 6) & 1;
    SELF.viol_eff_dte_Invalid := (le.ScrubsBits4 >> 7) & 1;
    SELF.action_final_nbr_Invalid := (le.ScrubsBits4 >> 8) & 1;
    SELF.action_status_Invalid := (le.ScrubsBits4 >> 9) & 1;
    SELF.action_status_dte_Invalid := (le.ScrubsBits4 >> 10) & 1;
    SELF.action_file_name_Invalid := (le.ScrubsBits4 >> 11) & 1;
    SELF.occupation_Invalid := (le.ScrubsBits4 >> 12) & 1;
    SELF.practice_hrs_Invalid := (le.ScrubsBits4 >> 13) & 1;
    SELF.practice_type_Invalid := (le.ScrubsBits4 >> 14) & 1;
    SELF.misc_other_id_Invalid := (le.ScrubsBits4 >> 15) & 1;
    SELF.misc_other_type_Invalid := (le.ScrubsBits4 >> 16) & 1;
    SELF.cont_education_ernd_Invalid := (le.ScrubsBits4 >> 17) & 1;
    SELF.cont_education_req_Invalid := (le.ScrubsBits4 >> 18) & 1;
    SELF.cont_education_term_Invalid := (le.ScrubsBits4 >> 19) & 1;
    SELF.schl_attend_1_Invalid := (le.ScrubsBits4 >> 20) & 1;
    SELF.schl_attend_dte_1_Invalid := (le.ScrubsBits4 >> 21) & 1;
    SELF.schl_curriculum_1_Invalid := (le.ScrubsBits4 >> 22) & 1;
    SELF.schl_degree_1_Invalid := (le.ScrubsBits4 >> 23) & 1;
    SELF.schl_attend_2_Invalid := (le.ScrubsBits4 >> 24) & 1;
    SELF.schl_attend_dte_2_Invalid := (le.ScrubsBits4 >> 25) & 1;
    SELF.schl_curriculum_2_Invalid := (le.ScrubsBits4 >> 26) & 1;
    SELF.schl_degree_2_Invalid := (le.ScrubsBits4 >> 27) & 1;
    SELF.schl_attend_3_Invalid := (le.ScrubsBits4 >> 28) & 1;
    SELF.schl_attend_dte_3_Invalid := (le.ScrubsBits4 >> 29) & 1;
    SELF.schl_curriculum_3_Invalid := (le.ScrubsBits4 >> 30) & 1;
    SELF.schl_degree_3_Invalid := (le.ScrubsBits4 >> 31) & 1;
    SELF.addl_license_spec_Invalid := (le.ScrubsBits4 >> 32) & 1;
    SELF.place_birth_cd_Invalid := (le.ScrubsBits4 >> 33) & 1;
    SELF.place_birth_desc_Invalid := (le.ScrubsBits4 >> 34) & 1;
    SELF.race_cd_Invalid := (le.ScrubsBits4 >> 35) & 3;
    SELF.std_race_cd_Invalid := (le.ScrubsBits4 >> 37) & 1;
    SELF.race_desc_Invalid := (le.ScrubsBits4 >> 38) & 1;
    SELF.status_effect_dte_Invalid := (le.ScrubsBits4 >> 39) & 3;
    SELF.status_renew_desc_Invalid := (le.ScrubsBits4 >> 41) & 1;
    SELF.agency_status_Invalid := (le.ScrubsBits4 >> 42) & 1;
    SELF.prev_primary_key_Invalid := (le.ScrubsBits4 >> 43) & 1;
    SELF.prev_mltreckey_Invalid := (le.ScrubsBits4 >> 44) & 1;
    SELF.prev_cmc_slpk_Invalid := (le.ScrubsBits4 >> 45) & 1;
    SELF.prev_pcmc_slpk_Invalid := (le.ScrubsBits4 >> 46) & 1;
    SELF.license_id_Invalid := (le.ScrubsBits4 >> 47) & 1;
    SELF.nmls_id_Invalid := (le.ScrubsBits4 >> 48) & 1;
    SELF.foreign_nmls_id_Invalid := (le.ScrubsBits4 >> 49) & 1;
    SELF.location_type_Invalid := (le.ScrubsBits4 >> 50) & 1;
    SELF.off_license_nbr_type_Invalid := (le.ScrubsBits4 >> 51) & 1;
    SELF.brkr_license_nbr_Invalid := (le.ScrubsBits4 >> 52) & 1;
    SELF.brkr_license_nbr_type_Invalid := (le.ScrubsBits4 >> 53) & 1;
    SELF.agency_id_Invalid := (le.ScrubsBits4 >> 54) & 1;
    SELF.site_location_Invalid := (le.ScrubsBits4 >> 55) & 1;
    SELF.business_type_Invalid := (le.ScrubsBits4 >> 56) & 1;
    SELF.start_dte_Invalid := (le.ScrubsBits4 >> 57) & 3;
    SELF.is_authorized_license_Invalid := (le.ScrubsBits4 >> 59) & 1;
    SELF.is_authorized_conduct_Invalid := (le.ScrubsBits4 >> 60) & 1;
    SELF.federal_regulator_Invalid := (le.ScrubsBits4 >> 61) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.std_source_upd;
    TotalCnt := COUNT(GROUP); // Number of records in total
    primary_key_ALLOW_ErrorCount := COUNT(GROUP,h.primary_key_Invalid=1);
    create_dte_ALLOW_ErrorCount := COUNT(GROUP,h.create_dte_Invalid=1);
    create_dte_LENGTH_ErrorCount := COUNT(GROUP,h.create_dte_Invalid=2);
    create_dte_Total_ErrorCount := COUNT(GROUP,h.create_dte_Invalid>0);
    last_upd_dte_ALLOW_ErrorCount := COUNT(GROUP,h.last_upd_dte_Invalid=1);
    last_upd_dte_LENGTH_ErrorCount := COUNT(GROUP,h.last_upd_dte_Invalid=2);
    last_upd_dte_Total_ErrorCount := COUNT(GROUP,h.last_upd_dte_Invalid>0);
    stamp_dte_ALLOW_ErrorCount := COUNT(GROUP,h.stamp_dte_Invalid=1);
    stamp_dte_LENGTH_ErrorCount := COUNT(GROUP,h.stamp_dte_Invalid=2);
    stamp_dte_Total_ErrorCount := COUNT(GROUP,h.stamp_dte_Invalid>0);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2);
    date_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid>0);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    date_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2);
    date_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid>0);
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    gen_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.gen_nbr_Invalid=1);
    gen_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.gen_nbr_Invalid=2);
    gen_nbr_Total_ErrorCount := COUNT(GROUP,h.gen_nbr_Invalid>0);
    std_prof_desc_ENUM_ErrorCount := COUNT(GROUP,h.std_prof_desc_Invalid=1);
    std_source_upd_ALLOW_ErrorCount := COUNT(GROUP,h.std_source_upd_Invalid=1);
    std_source_upd_LENGTH_ErrorCount := COUNT(GROUP,h.std_source_upd_Invalid=2);
    std_source_upd_Total_ErrorCount := COUNT(GROUP,h.std_source_upd_Invalid>0);
    std_source_desc_ALLOW_ErrorCount := COUNT(GROUP,h.std_source_desc_Invalid=1);
    std_source_desc_LENGTH_ErrorCount := COUNT(GROUP,h.std_source_desc_Invalid=2);
    std_source_desc_Total_ErrorCount := COUNT(GROUP,h.std_source_desc_Invalid>0);
    type_cd_ENUM_ErrorCount := COUNT(GROUP,h.type_cd_Invalid=1);
    type_cd_LENGTH_ErrorCount := COUNT(GROUP,h.type_cd_Invalid=2);
    type_cd_Total_ErrorCount := COUNT(GROUP,h.type_cd_Invalid>0);
    name_org_prefx_ALLOW_ErrorCount := COUNT(GROUP,h.name_org_prefx_Invalid=1);
    name_org_prefx_LENGTH_ErrorCount := COUNT(GROUP,h.name_org_prefx_Invalid=2);
    name_org_prefx_Total_ErrorCount := COUNT(GROUP,h.name_org_prefx_Invalid>0);
    name_org_ALLOW_ErrorCount := COUNT(GROUP,h.name_org_Invalid=1);
    name_org_sufx_ALLOW_ErrorCount := COUNT(GROUP,h.name_org_sufx_Invalid=1);
    name_org_sufx_LENGTH_ErrorCount := COUNT(GROUP,h.name_org_sufx_Invalid=2);
    name_org_sufx_Total_ErrorCount := COUNT(GROUP,h.name_org_sufx_Invalid>0);
    store_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.store_nbr_Invalid=1);
    store_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.store_nbr_Invalid=2);
    store_nbr_Total_ErrorCount := COUNT(GROUP,h.store_nbr_Invalid>0);
    name_dba_prefx_ALLOW_ErrorCount := COUNT(GROUP,h.name_dba_prefx_Invalid=1);
    name_dba_prefx_LENGTH_ErrorCount := COUNT(GROUP,h.name_dba_prefx_Invalid=2);
    name_dba_prefx_Total_ErrorCount := COUNT(GROUP,h.name_dba_prefx_Invalid>0);
    name_dba_ALLOW_ErrorCount := COUNT(GROUP,h.name_dba_Invalid=1);
    name_dba_sufx_ALLOW_ErrorCount := COUNT(GROUP,h.name_dba_sufx_Invalid=1);
    name_dba_sufx_LENGTH_ErrorCount := COUNT(GROUP,h.name_dba_sufx_Invalid=2);
    name_dba_sufx_Total_ErrorCount := COUNT(GROUP,h.name_dba_sufx_Invalid>0);
    store_nbr_dba_ALLOW_ErrorCount := COUNT(GROUP,h.store_nbr_dba_Invalid=1);
    store_nbr_dba_LENGTH_ErrorCount := COUNT(GROUP,h.store_nbr_dba_Invalid=2);
    store_nbr_dba_Total_ErrorCount := COUNT(GROUP,h.store_nbr_dba_Invalid>0);
    dba_flag_ALLOW_ErrorCount := COUNT(GROUP,h.dba_flag_Invalid=1);
    name_office_ALLOW_ErrorCount := COUNT(GROUP,h.name_office_Invalid=1);
    name_office_LENGTH_ErrorCount := COUNT(GROUP,h.name_office_Invalid=2);
    name_office_Total_ErrorCount := COUNT(GROUP,h.name_office_Invalid>0);
    office_parse_ENUM_ErrorCount := COUNT(GROUP,h.office_parse_Invalid=1);
    office_parse_LENGTH_ErrorCount := COUNT(GROUP,h.office_parse_Invalid=2);
    office_parse_Total_ErrorCount := COUNT(GROUP,h.office_parse_Invalid>0);
    name_prefx_ALLOW_ErrorCount := COUNT(GROUP,h.name_prefx_Invalid=1);
    name_first_ALLOW_ErrorCount := COUNT(GROUP,h.name_first_Invalid=1);
    name_mid_ALLOW_ErrorCount := COUNT(GROUP,h.name_mid_Invalid=1);
    name_last_ALLOW_ErrorCount := COUNT(GROUP,h.name_last_Invalid=1);
    name_sufx_ALLOW_ErrorCount := COUNT(GROUP,h.name_sufx_Invalid=1);
    name_nick_ALLOW_ErrorCount := COUNT(GROUP,h.name_nick_Invalid=1);
    birth_dte_ALLOW_ErrorCount := COUNT(GROUP,h.birth_dte_Invalid=1);
    birth_dte_LENGTH_ErrorCount := COUNT(GROUP,h.birth_dte_Invalid=2);
    birth_dte_Total_ErrorCount := COUNT(GROUP,h.birth_dte_Invalid>0);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    gender_LENGTH_ErrorCount := COUNT(GROUP,h.gender_Invalid=2);
    gender_Total_ErrorCount := COUNT(GROUP,h.gender_Invalid>0);
    prov_stat_ENUM_ErrorCount := COUNT(GROUP,h.prov_stat_Invalid=1);
    prov_stat_LENGTH_ErrorCount := COUNT(GROUP,h.prov_stat_Invalid=2);
    prov_stat_Total_ErrorCount := COUNT(GROUP,h.prov_stat_Invalid>0);
    credential_ALLOW_ErrorCount := COUNT(GROUP,h.credential_Invalid=1);
    credential_LENGTH_ErrorCount := COUNT(GROUP,h.credential_Invalid=2);
    credential_Total_ErrorCount := COUNT(GROUP,h.credential_Invalid>0);
    license_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.license_nbr_Invalid=1);
    off_license_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.off_license_nbr_Invalid=1);
    prev_license_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.prev_license_nbr_Invalid=1);
    prev_license_type_LENGTH_ErrorCount := COUNT(GROUP,h.prev_license_type_Invalid=1);
    license_state_ALLOW_ErrorCount := COUNT(GROUP,h.license_state_Invalid=1);
    license_state_LENGTH_ErrorCount := COUNT(GROUP,h.license_state_Invalid=2);
    license_state_Total_ErrorCount := COUNT(GROUP,h.license_state_Invalid>0);
    raw_license_type_ALLOW_ErrorCount := COUNT(GROUP,h.raw_license_type_Invalid=1);
    raw_license_status_ALLOW_ErrorCount := COUNT(GROUP,h.raw_license_status_Invalid=1);
    std_status_desc_ALLOW_ErrorCount := COUNT(GROUP,h.std_status_desc_Invalid=1);
    curr_issue_dte_ALLOW_ErrorCount := COUNT(GROUP,h.curr_issue_dte_Invalid=1);
    curr_issue_dte_LENGTH_ErrorCount := COUNT(GROUP,h.curr_issue_dte_Invalid=2);
    curr_issue_dte_Total_ErrorCount := COUNT(GROUP,h.curr_issue_dte_Invalid>0);
    orig_issue_dte_ALLOW_ErrorCount := COUNT(GROUP,h.orig_issue_dte_Invalid=1);
    orig_issue_dte_LENGTH_ErrorCount := COUNT(GROUP,h.orig_issue_dte_Invalid=2);
    orig_issue_dte_Total_ErrorCount := COUNT(GROUP,h.orig_issue_dte_Invalid>0);
    expire_dte_ALLOW_ErrorCount := COUNT(GROUP,h.expire_dte_Invalid=1);
    expire_dte_LENGTH_ErrorCount := COUNT(GROUP,h.expire_dte_Invalid=2);
    expire_dte_Total_ErrorCount := COUNT(GROUP,h.expire_dte_Invalid>0);
    renewal_dte_ALLOW_ErrorCount := COUNT(GROUP,h.renewal_dte_Invalid=1);
    active_flag_ALLOW_ErrorCount := COUNT(GROUP,h.active_flag_Invalid=1);
    active_flag_LENGTH_ErrorCount := COUNT(GROUP,h.active_flag_Invalid=2);
    active_flag_Total_ErrorCount := COUNT(GROUP,h.active_flag_Invalid>0);
    ssn_taxid_1_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_taxid_1_Invalid=1);
    ssn_taxid_1_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_taxid_1_Invalid=2);
    ssn_taxid_1_Total_ErrorCount := COUNT(GROUP,h.ssn_taxid_1_Invalid>0);
    tax_type_1_ALLOW_ErrorCount := COUNT(GROUP,h.tax_type_1_Invalid=1);
    tax_type_1_LENGTH_ErrorCount := COUNT(GROUP,h.tax_type_1_Invalid=2);
    tax_type_1_Total_ErrorCount := COUNT(GROUP,h.tax_type_1_Invalid>0);
    ssn_taxid_2_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_taxid_2_Invalid=1);
    tax_type_2_LENGTH_ErrorCount := COUNT(GROUP,h.tax_type_2_Invalid=1);
    fed_rssd_ALLOW_ErrorCount := COUNT(GROUP,h.fed_rssd_Invalid=1);
    fed_rssd_LENGTH_ErrorCount := COUNT(GROUP,h.fed_rssd_Invalid=2);
    fed_rssd_Total_ErrorCount := COUNT(GROUP,h.fed_rssd_Invalid>0);
    addr_bus_ind_ALLOW_ErrorCount := COUNT(GROUP,h.addr_bus_ind_Invalid=1);
    addr_bus_ind_LENGTH_ErrorCount := COUNT(GROUP,h.addr_bus_ind_Invalid=2);
    addr_bus_ind_Total_ErrorCount := COUNT(GROUP,h.addr_bus_ind_Invalid>0);
    name_format_ALLOW_ErrorCount := COUNT(GROUP,h.name_format_Invalid=1);
    name_format_LENGTH_ErrorCount := COUNT(GROUP,h.name_format_Invalid=2);
    name_format_Total_ErrorCount := COUNT(GROUP,h.name_format_Invalid>0);
    name_org_orig_ALLOW_ErrorCount := COUNT(GROUP,h.name_org_orig_Invalid=1);
    name_dba_orig_ALLOW_ErrorCount := COUNT(GROUP,h.name_dba_orig_Invalid=1);
    name_mari_org_ALLOW_ErrorCount := COUNT(GROUP,h.name_mari_org_Invalid=1);
    name_mari_dba_ALLOW_ErrorCount := COUNT(GROUP,h.name_mari_dba_Invalid=1);
    phn_mari_1_ALLOW_ErrorCount := COUNT(GROUP,h.phn_mari_1_Invalid=1);
    phn_mari_1_LENGTH_ErrorCount := COUNT(GROUP,h.phn_mari_1_Invalid=2);
    phn_mari_1_Total_ErrorCount := COUNT(GROUP,h.phn_mari_1_Invalid>0);
    phn_mari_fax_1_ALLOW_ErrorCount := COUNT(GROUP,h.phn_mari_fax_1_Invalid=1);
    phn_mari_fax_1_LENGTH_ErrorCount := COUNT(GROUP,h.phn_mari_fax_1_Invalid=2);
    phn_mari_fax_1_Total_ErrorCount := COUNT(GROUP,h.phn_mari_fax_1_Invalid>0);
    phn_mari_2_ALLOW_ErrorCount := COUNT(GROUP,h.phn_mari_2_Invalid=1);
    phn_mari_2_LENGTH_ErrorCount := COUNT(GROUP,h.phn_mari_2_Invalid=2);
    phn_mari_2_Total_ErrorCount := COUNT(GROUP,h.phn_mari_2_Invalid>0);
    phn_mari_fax_2_ALLOW_ErrorCount := COUNT(GROUP,h.phn_mari_fax_2_Invalid=1);
    phn_mari_fax_2_LENGTH_ErrorCount := COUNT(GROUP,h.phn_mari_fax_2_Invalid=2);
    phn_mari_fax_2_Total_ErrorCount := COUNT(GROUP,h.phn_mari_fax_2_Invalid>0);
    addr_addr1_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_addr1_1_Invalid=1);
    addr_addr2_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_addr2_1_Invalid=1);
    addr_addr3_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_addr3_1_Invalid=1);
    addr_addr4_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_addr4_1_Invalid=1);
    addr_city_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_city_1_Invalid=1);
    addr_state_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_state_1_Invalid=1);
    addr_state_1_LENGTH_ErrorCount := COUNT(GROUP,h.addr_state_1_Invalid=2);
    addr_state_1_Total_ErrorCount := COUNT(GROUP,h.addr_state_1_Invalid>0);
    addr_zip5_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_zip5_1_Invalid=1);
    addr_zip5_1_LENGTH_ErrorCount := COUNT(GROUP,h.addr_zip5_1_Invalid=2);
    addr_zip5_1_Total_ErrorCount := COUNT(GROUP,h.addr_zip5_1_Invalid>0);
    addr_zip4_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_zip4_1_Invalid=1);
    addr_zip4_1_LENGTH_ErrorCount := COUNT(GROUP,h.addr_zip4_1_Invalid=2);
    addr_zip4_1_Total_ErrorCount := COUNT(GROUP,h.addr_zip4_1_Invalid>0);
    phn_phone_1_ALLOW_ErrorCount := COUNT(GROUP,h.phn_phone_1_Invalid=1);
    phn_phone_1_LENGTH_ErrorCount := COUNT(GROUP,h.phn_phone_1_Invalid=2);
    phn_phone_1_Total_ErrorCount := COUNT(GROUP,h.phn_phone_1_Invalid>0);
    phn_fax_1_ALLOW_ErrorCount := COUNT(GROUP,h.phn_fax_1_Invalid=1);
    phn_fax_1_LENGTH_ErrorCount := COUNT(GROUP,h.phn_fax_1_Invalid=2);
    phn_fax_1_Total_ErrorCount := COUNT(GROUP,h.phn_fax_1_Invalid>0);
    addr_cnty_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_cnty_1_Invalid=1);
    addr_cntry_1_ALLOW_ErrorCount := COUNT(GROUP,h.addr_cntry_1_Invalid=1);
    sud_key_1_ALLOW_ErrorCount := COUNT(GROUP,h.sud_key_1_Invalid=1);
    ooc_ind_1_ALLOW_ErrorCount := COUNT(GROUP,h.ooc_ind_1_Invalid=1);
    ooc_ind_1_LENGTH_ErrorCount := COUNT(GROUP,h.ooc_ind_1_Invalid=2);
    ooc_ind_1_Total_ErrorCount := COUNT(GROUP,h.ooc_ind_1_Invalid>0);
    addr_mail_ind_ALLOW_ErrorCount := COUNT(GROUP,h.addr_mail_ind_Invalid=1);
    addr_mail_ind_LENGTH_ErrorCount := COUNT(GROUP,h.addr_mail_ind_Invalid=2);
    addr_mail_ind_Total_ErrorCount := COUNT(GROUP,h.addr_mail_ind_Invalid>0);
    addr_addr1_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_addr1_2_Invalid=1);
    addr_addr2_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_addr2_2_Invalid=1);
    addr_addr3_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_addr3_2_Invalid=1);
    addr_addr4_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_addr4_2_Invalid=1);
    addr_city_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_city_2_Invalid=1);
    addr_state_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_state_2_Invalid=1);
    addr_state_2_LENGTH_ErrorCount := COUNT(GROUP,h.addr_state_2_Invalid=2);
    addr_state_2_Total_ErrorCount := COUNT(GROUP,h.addr_state_2_Invalid>0);
    addr_zip5_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_zip5_2_Invalid=1);
    addr_zip5_2_LENGTH_ErrorCount := COUNT(GROUP,h.addr_zip5_2_Invalid=2);
    addr_zip5_2_Total_ErrorCount := COUNT(GROUP,h.addr_zip5_2_Invalid>0);
    addr_zip4_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_zip4_2_Invalid=1);
    addr_zip4_2_LENGTH_ErrorCount := COUNT(GROUP,h.addr_zip4_2_Invalid=2);
    addr_zip4_2_Total_ErrorCount := COUNT(GROUP,h.addr_zip4_2_Invalid>0);
    addr_cnty_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_cnty_2_Invalid=1);
    addr_cntry_2_ALLOW_ErrorCount := COUNT(GROUP,h.addr_cntry_2_Invalid=1);
    phn_phone_2_ALLOW_ErrorCount := COUNT(GROUP,h.phn_phone_2_Invalid=1);
    phn_phone_2_LENGTH_ErrorCount := COUNT(GROUP,h.phn_phone_2_Invalid=2);
    phn_phone_2_Total_ErrorCount := COUNT(GROUP,h.phn_phone_2_Invalid>0);
    phn_fax_2_ALLOW_ErrorCount := COUNT(GROUP,h.phn_fax_2_Invalid=1);
    phn_fax_2_LENGTH_ErrorCount := COUNT(GROUP,h.phn_fax_2_Invalid=2);
    phn_fax_2_Total_ErrorCount := COUNT(GROUP,h.phn_fax_2_Invalid>0);
    sud_key_2_ALLOW_ErrorCount := COUNT(GROUP,h.sud_key_2_Invalid=1);
    ooc_ind_2_ALLOW_ErrorCount := COUNT(GROUP,h.ooc_ind_2_Invalid=1);
    ooc_ind_2_LENGTH_ErrorCount := COUNT(GROUP,h.ooc_ind_2_Invalid=2);
    ooc_ind_2_Total_ErrorCount := COUNT(GROUP,h.ooc_ind_2_Invalid>0);
    license_nbr_contact_ALLOW_ErrorCount := COUNT(GROUP,h.license_nbr_contact_Invalid=1);
    name_contact_prefx_ALLOW_ErrorCount := COUNT(GROUP,h.name_contact_prefx_Invalid=1);
    name_contact_first_ALLOW_ErrorCount := COUNT(GROUP,h.name_contact_first_Invalid=1);
    name_contact_mid_ALLOW_ErrorCount := COUNT(GROUP,h.name_contact_mid_Invalid=1);
    name_contact_last_ALLOW_ErrorCount := COUNT(GROUP,h.name_contact_last_Invalid=1);
    name_contact_sufx_ALLOW_ErrorCount := COUNT(GROUP,h.name_contact_sufx_Invalid=1);
    name_contact_nick_ALLOW_ErrorCount := COUNT(GROUP,h.name_contact_nick_Invalid=1);
    name_contact_ttl_ALLOW_ErrorCount := COUNT(GROUP,h.name_contact_ttl_Invalid=1);
    phn_contact_ALLOW_ErrorCount := COUNT(GROUP,h.phn_contact_Invalid=1);
    phn_contact_LENGTH_ErrorCount := COUNT(GROUP,h.phn_contact_Invalid=2);
    phn_contact_Total_ErrorCount := COUNT(GROUP,h.phn_contact_Invalid>0);
    phn_contact_ext_ALLOW_ErrorCount := COUNT(GROUP,h.phn_contact_ext_Invalid=1);
    phn_contact_ext_LENGTH_ErrorCount := COUNT(GROUP,h.phn_contact_ext_Invalid=2);
    phn_contact_ext_Total_ErrorCount := COUNT(GROUP,h.phn_contact_ext_Invalid>0);
    phn_contact_fax_ALLOW_ErrorCount := COUNT(GROUP,h.phn_contact_fax_Invalid=1);
    phn_contact_fax_LENGTH_ErrorCount := COUNT(GROUP,h.phn_contact_fax_Invalid=2);
    phn_contact_fax_Total_ErrorCount := COUNT(GROUP,h.phn_contact_fax_Invalid>0);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    url_ALLOW_ErrorCount := COUNT(GROUP,h.url_Invalid=1);
    bk_class_ALLOW_ErrorCount := COUNT(GROUP,h.bk_class_Invalid=1);
    bk_class_LENGTH_ErrorCount := COUNT(GROUP,h.bk_class_Invalid=2);
    bk_class_Total_ErrorCount := COUNT(GROUP,h.bk_class_Invalid>0);
    bk_class_desc_ALLOW_ErrorCount := COUNT(GROUP,h.bk_class_desc_Invalid=1);
    charter_ALLOW_ErrorCount := COUNT(GROUP,h.charter_Invalid=1);
    inst_beg_dte_ALLOW_ErrorCount := COUNT(GROUP,h.inst_beg_dte_Invalid=1);
    inst_beg_dte_LENGTH_ErrorCount := COUNT(GROUP,h.inst_beg_dte_Invalid=2);
    inst_beg_dte_Total_ErrorCount := COUNT(GROUP,h.inst_beg_dte_Invalid>0);
    origin_cd_ALLOW_ErrorCount := COUNT(GROUP,h.origin_cd_Invalid=1);
    origin_cd_LENGTH_ErrorCount := COUNT(GROUP,h.origin_cd_Invalid=2);
    origin_cd_Total_ErrorCount := COUNT(GROUP,h.origin_cd_Invalid>0);
    origin_cd_desc_ALLOW_ErrorCount := COUNT(GROUP,h.origin_cd_desc_Invalid=1);
    disp_type_cd_ALLOW_ErrorCount := COUNT(GROUP,h.disp_type_cd_Invalid=1);
    disp_type_cd_LENGTH_ErrorCount := COUNT(GROUP,h.disp_type_cd_Invalid=2);
    disp_type_cd_Total_ErrorCount := COUNT(GROUP,h.disp_type_cd_Invalid>0);
    disp_type_desc_ALLOW_ErrorCount := COUNT(GROUP,h.disp_type_desc_Invalid=1);
    reg_agent_ENUM_ErrorCount := COUNT(GROUP,h.reg_agent_Invalid=1);
    regulator_ALLOW_ErrorCount := COUNT(GROUP,h.regulator_Invalid=1);
    hqtr_city_ALLOW_ErrorCount := COUNT(GROUP,h.hqtr_city_Invalid=1);
    hqtr_name_ALLOW_ErrorCount := COUNT(GROUP,h.hqtr_name_Invalid=1);
    domestic_off_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.domestic_off_nbr_Invalid=1);
    foreign_off_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.foreign_off_nbr_Invalid=1);
    hcr_rssd_ALLOW_ErrorCount := COUNT(GROUP,h.hcr_rssd_Invalid=1);
    hcr_location_ALLOW_ErrorCount := COUNT(GROUP,h.hcr_location_Invalid=1);
    hcr_location_LENGTH_ErrorCount := COUNT(GROUP,h.hcr_location_Invalid=2);
    hcr_location_Total_ErrorCount := COUNT(GROUP,h.hcr_location_Invalid>0);
    affil_type_cd_ENUM_ErrorCount := COUNT(GROUP,h.affil_type_cd_Invalid=1);
    affil_type_cd_LENGTH_ErrorCount := COUNT(GROUP,h.affil_type_cd_Invalid=2);
    affil_type_cd_Total_ErrorCount := COUNT(GROUP,h.affil_type_cd_Invalid>0);
    genlink_ALLOW_ErrorCount := COUNT(GROUP,h.genlink_Invalid=1);
    genlink_LENGTH_ErrorCount := COUNT(GROUP,h.genlink_Invalid=2);
    genlink_Total_ErrorCount := COUNT(GROUP,h.genlink_Invalid>0);
    research_ind_ALLOW_ErrorCount := COUNT(GROUP,h.research_ind_Invalid=1);
    research_ind_LENGTH_ErrorCount := COUNT(GROUP,h.research_ind_Invalid=2);
    research_ind_Total_ErrorCount := COUNT(GROUP,h.research_ind_Invalid>0);
    docket_id_ALLOW_ErrorCount := COUNT(GROUP,h.docket_id_Invalid=1);
    mltreckey_ALLOW_ErrorCount := COUNT(GROUP,h.mltreckey_Invalid=1);
    cmc_slpk_ALLOW_ErrorCount := COUNT(GROUP,h.cmc_slpk_Invalid=1);
    pcmc_slpk_ALLOW_ErrorCount := COUNT(GROUP,h.pcmc_slpk_Invalid=1);
    affil_key_ALLOW_ErrorCount := COUNT(GROUP,h.affil_key_Invalid=1);
    action_taken_ind_LENGTH_ErrorCount := COUNT(GROUP,h.action_taken_ind_Invalid=1);
    viol_type_LENGTH_ErrorCount := COUNT(GROUP,h.viol_type_Invalid=1);
    viol_cd_LENGTH_ErrorCount := COUNT(GROUP,h.viol_cd_Invalid=1);
    viol_desc_ALLOW_ErrorCount := COUNT(GROUP,h.viol_desc_Invalid=1);
    viol_dte_ALLOW_ErrorCount := COUNT(GROUP,h.viol_dte_Invalid=1);
    viol_dte_LENGTH_ErrorCount := COUNT(GROUP,h.viol_dte_Invalid=2);
    viol_dte_Total_ErrorCount := COUNT(GROUP,h.viol_dte_Invalid>0);
    viol_case_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.viol_case_nbr_Invalid=1);
    viol_eff_dte_LENGTH_ErrorCount := COUNT(GROUP,h.viol_eff_dte_Invalid=1);
    action_final_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.action_final_nbr_Invalid=1);
    action_status_LENGTH_ErrorCount := COUNT(GROUP,h.action_status_Invalid=1);
    action_status_dte_LENGTH_ErrorCount := COUNT(GROUP,h.action_status_dte_Invalid=1);
    action_file_name_LENGTH_ErrorCount := COUNT(GROUP,h.action_file_name_Invalid=1);
    occupation_LENGTH_ErrorCount := COUNT(GROUP,h.occupation_Invalid=1);
    practice_hrs_LENGTH_ErrorCount := COUNT(GROUP,h.practice_hrs_Invalid=1);
    practice_type_LENGTH_ErrorCount := COUNT(GROUP,h.practice_type_Invalid=1);
    misc_other_id_ALLOW_ErrorCount := COUNT(GROUP,h.misc_other_id_Invalid=1);
    misc_other_type_ENUM_ErrorCount := COUNT(GROUP,h.misc_other_type_Invalid=1);
    cont_education_ernd_ALLOW_ErrorCount := COUNT(GROUP,h.cont_education_ernd_Invalid=1);
    cont_education_req_ALLOW_ErrorCount := COUNT(GROUP,h.cont_education_req_Invalid=1);
    cont_education_term_ALLOW_ErrorCount := COUNT(GROUP,h.cont_education_term_Invalid=1);
    schl_attend_1_LENGTH_ErrorCount := COUNT(GROUP,h.schl_attend_1_Invalid=1);
    schl_attend_dte_1_LENGTH_ErrorCount := COUNT(GROUP,h.schl_attend_dte_1_Invalid=1);
    schl_curriculum_1_LENGTH_ErrorCount := COUNT(GROUP,h.schl_curriculum_1_Invalid=1);
    schl_degree_1_LENGTH_ErrorCount := COUNT(GROUP,h.schl_degree_1_Invalid=1);
    schl_attend_2_LENGTH_ErrorCount := COUNT(GROUP,h.schl_attend_2_Invalid=1);
    schl_attend_dte_2_LENGTH_ErrorCount := COUNT(GROUP,h.schl_attend_dte_2_Invalid=1);
    schl_curriculum_2_LENGTH_ErrorCount := COUNT(GROUP,h.schl_curriculum_2_Invalid=1);
    schl_degree_2_LENGTH_ErrorCount := COUNT(GROUP,h.schl_degree_2_Invalid=1);
    schl_attend_3_LENGTH_ErrorCount := COUNT(GROUP,h.schl_attend_3_Invalid=1);
    schl_attend_dte_3_LENGTH_ErrorCount := COUNT(GROUP,h.schl_attend_dte_3_Invalid=1);
    schl_curriculum_3_LENGTH_ErrorCount := COUNT(GROUP,h.schl_curriculum_3_Invalid=1);
    schl_degree_3_LENGTH_ErrorCount := COUNT(GROUP,h.schl_degree_3_Invalid=1);
    addl_license_spec_ALLOW_ErrorCount := COUNT(GROUP,h.addl_license_spec_Invalid=1);
    place_birth_cd_LENGTH_ErrorCount := COUNT(GROUP,h.place_birth_cd_Invalid=1);
    place_birth_desc_LENGTH_ErrorCount := COUNT(GROUP,h.place_birth_desc_Invalid=1);
    race_cd_ALLOW_ErrorCount := COUNT(GROUP,h.race_cd_Invalid=1);
    race_cd_LENGTH_ErrorCount := COUNT(GROUP,h.race_cd_Invalid=2);
    race_cd_Total_ErrorCount := COUNT(GROUP,h.race_cd_Invalid>0);
    std_race_cd_ENUM_ErrorCount := COUNT(GROUP,h.std_race_cd_Invalid=1);
    race_desc_LENGTH_ErrorCount := COUNT(GROUP,h.race_desc_Invalid=1);
    status_effect_dte_ALLOW_ErrorCount := COUNT(GROUP,h.status_effect_dte_Invalid=1);
    status_effect_dte_LENGTH_ErrorCount := COUNT(GROUP,h.status_effect_dte_Invalid=2);
    status_effect_dte_Total_ErrorCount := COUNT(GROUP,h.status_effect_dte_Invalid>0);
    status_renew_desc_LENGTH_ErrorCount := COUNT(GROUP,h.status_renew_desc_Invalid=1);
    agency_status_ENUM_ErrorCount := COUNT(GROUP,h.agency_status_Invalid=1);
    prev_primary_key_ALLOW_ErrorCount := COUNT(GROUP,h.prev_primary_key_Invalid=1);
    prev_mltreckey_ALLOW_ErrorCount := COUNT(GROUP,h.prev_mltreckey_Invalid=1);
    prev_cmc_slpk_ALLOW_ErrorCount := COUNT(GROUP,h.prev_cmc_slpk_Invalid=1);
    prev_pcmc_slpk_ALLOW_ErrorCount := COUNT(GROUP,h.prev_pcmc_slpk_Invalid=1);
    license_id_ALLOW_ErrorCount := COUNT(GROUP,h.license_id_Invalid=1);
    nmls_id_ALLOW_ErrorCount := COUNT(GROUP,h.nmls_id_Invalid=1);
    foreign_nmls_id_ALLOW_ErrorCount := COUNT(GROUP,h.foreign_nmls_id_Invalid=1);
    location_type_ENUM_ErrorCount := COUNT(GROUP,h.location_type_Invalid=1);
    off_license_nbr_type_ALLOW_ErrorCount := COUNT(GROUP,h.off_license_nbr_type_Invalid=1);
    brkr_license_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.brkr_license_nbr_Invalid=1);
    brkr_license_nbr_type_ALLOW_ErrorCount := COUNT(GROUP,h.brkr_license_nbr_type_Invalid=1);
    agency_id_ALLOW_ErrorCount := COUNT(GROUP,h.agency_id_Invalid=1);
    site_location_ALLOW_ErrorCount := COUNT(GROUP,h.site_location_Invalid=1);
    business_type_ALLOW_ErrorCount := COUNT(GROUP,h.business_type_Invalid=1);
    start_dte_ALLOW_ErrorCount := COUNT(GROUP,h.start_dte_Invalid=1);
    start_dte_LENGTH_ErrorCount := COUNT(GROUP,h.start_dte_Invalid=2);
    start_dte_Total_ErrorCount := COUNT(GROUP,h.start_dte_Invalid>0);
    is_authorized_license_ENUM_ErrorCount := COUNT(GROUP,h.is_authorized_license_Invalid=1);
    is_authorized_conduct_ENUM_ErrorCount := COUNT(GROUP,h.is_authorized_conduct_Invalid=1);
    federal_regulator_ALLOW_ErrorCount := COUNT(GROUP,h.federal_regulator_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,std_source_upd,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT31.StrType ErrorMessage;
    SALT31.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.std_source_upd;
    UNSIGNED1 ErrNum := CHOOSE(c,le.primary_key_Invalid,le.create_dte_Invalid,le.last_upd_dte_Invalid,le.stamp_dte_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.process_date_Invalid,le.gen_nbr_Invalid,le.std_prof_desc_Invalid,le.std_source_upd_Invalid,le.std_source_desc_Invalid,le.type_cd_Invalid,le.name_org_prefx_Invalid,le.name_org_Invalid,le.name_org_sufx_Invalid,le.store_nbr_Invalid,le.name_dba_prefx_Invalid,le.name_dba_Invalid,le.name_dba_sufx_Invalid,le.store_nbr_dba_Invalid,le.dba_flag_Invalid,le.name_office_Invalid,le.office_parse_Invalid,le.name_prefx_Invalid,le.name_first_Invalid,le.name_mid_Invalid,le.name_last_Invalid,le.name_sufx_Invalid,le.name_nick_Invalid,le.birth_dte_Invalid,le.gender_Invalid,le.prov_stat_Invalid,le.credential_Invalid,le.license_nbr_Invalid,le.off_license_nbr_Invalid,le.prev_license_nbr_Invalid,le.prev_license_type_Invalid,le.license_state_Invalid,le.raw_license_type_Invalid,le.raw_license_status_Invalid,le.std_status_desc_Invalid,le.curr_issue_dte_Invalid,le.orig_issue_dte_Invalid,le.expire_dte_Invalid,le.renewal_dte_Invalid,le.active_flag_Invalid,le.ssn_taxid_1_Invalid,le.tax_type_1_Invalid,le.ssn_taxid_2_Invalid,le.tax_type_2_Invalid,le.fed_rssd_Invalid,le.addr_bus_ind_Invalid,le.name_format_Invalid,le.name_org_orig_Invalid,le.name_dba_orig_Invalid,le.name_mari_org_Invalid,le.name_mari_dba_Invalid,le.phn_mari_1_Invalid,le.phn_mari_fax_1_Invalid,le.phn_mari_2_Invalid,le.phn_mari_fax_2_Invalid,le.addr_addr1_1_Invalid,le.addr_addr2_1_Invalid,le.addr_addr3_1_Invalid,le.addr_addr4_1_Invalid,le.addr_city_1_Invalid,le.addr_state_1_Invalid,le.addr_zip5_1_Invalid,le.addr_zip4_1_Invalid,le.phn_phone_1_Invalid,le.phn_fax_1_Invalid,le.addr_cnty_1_Invalid,le.addr_cntry_1_Invalid,le.sud_key_1_Invalid,le.ooc_ind_1_Invalid,le.addr_mail_ind_Invalid,le.addr_addr1_2_Invalid,le.addr_addr2_2_Invalid,le.addr_addr3_2_Invalid,le.addr_addr4_2_Invalid,le.addr_city_2_Invalid,le.addr_state_2_Invalid,le.addr_zip5_2_Invalid,le.addr_zip4_2_Invalid,le.addr_cnty_2_Invalid,le.addr_cntry_2_Invalid,le.phn_phone_2_Invalid,le.phn_fax_2_Invalid,le.sud_key_2_Invalid,le.ooc_ind_2_Invalid,le.license_nbr_contact_Invalid,le.name_contact_prefx_Invalid,le.name_contact_first_Invalid,le.name_contact_mid_Invalid,le.name_contact_last_Invalid,le.name_contact_sufx_Invalid,le.name_contact_nick_Invalid,le.name_contact_ttl_Invalid,le.phn_contact_Invalid,le.phn_contact_ext_Invalid,le.phn_contact_fax_Invalid,le.email_Invalid,le.url_Invalid,le.bk_class_Invalid,le.bk_class_desc_Invalid,le.charter_Invalid,le.inst_beg_dte_Invalid,le.origin_cd_Invalid,le.origin_cd_desc_Invalid,le.disp_type_cd_Invalid,le.disp_type_desc_Invalid,le.reg_agent_Invalid,le.regulator_Invalid,le.hqtr_city_Invalid,le.hqtr_name_Invalid,le.domestic_off_nbr_Invalid,le.foreign_off_nbr_Invalid,le.hcr_rssd_Invalid,le.hcr_location_Invalid,le.affil_type_cd_Invalid,le.genlink_Invalid,le.research_ind_Invalid,le.docket_id_Invalid,le.mltreckey_Invalid,le.cmc_slpk_Invalid,le.pcmc_slpk_Invalid,le.affil_key_Invalid,le.action_taken_ind_Invalid,le.viol_type_Invalid,le.viol_cd_Invalid,le.viol_desc_Invalid,le.viol_dte_Invalid,le.viol_case_nbr_Invalid,le.viol_eff_dte_Invalid,le.action_final_nbr_Invalid,le.action_status_Invalid,le.action_status_dte_Invalid,le.action_file_name_Invalid,le.occupation_Invalid,le.practice_hrs_Invalid,le.practice_type_Invalid,le.misc_other_id_Invalid,le.misc_other_type_Invalid,le.cont_education_ernd_Invalid,le.cont_education_req_Invalid,le.cont_education_term_Invalid,le.schl_attend_1_Invalid,le.schl_attend_dte_1_Invalid,le.schl_curriculum_1_Invalid,le.schl_degree_1_Invalid,le.schl_attend_2_Invalid,le.schl_attend_dte_2_Invalid,le.schl_curriculum_2_Invalid,le.schl_degree_2_Invalid,le.schl_attend_3_Invalid,le.schl_attend_dte_3_Invalid,le.schl_curriculum_3_Invalid,le.schl_degree_3_Invalid,le.addl_license_spec_Invalid,le.place_birth_cd_Invalid,le.place_birth_desc_Invalid,le.race_cd_Invalid,le.std_race_cd_Invalid,le.race_desc_Invalid,le.status_effect_dte_Invalid,le.status_renew_desc_Invalid,le.agency_status_Invalid,le.prev_primary_key_Invalid,le.prev_mltreckey_Invalid,le.prev_cmc_slpk_Invalid,le.prev_pcmc_slpk_Invalid,le.license_id_Invalid,le.nmls_id_Invalid,le.foreign_nmls_id_Invalid,le.location_type_Invalid,le.off_license_nbr_type_Invalid,le.brkr_license_nbr_Invalid,le.brkr_license_nbr_type_Invalid,le.agency_id_Invalid,le.site_location_Invalid,le.business_type_Invalid,le.start_dte_Invalid,le.is_authorized_license_Invalid,le.is_authorized_conduct_Invalid,le.federal_regulator_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_primary_key(le.primary_key_Invalid),Fields.InvalidMessage_create_dte(le.create_dte_Invalid),Fields.InvalidMessage_last_upd_dte(le.last_upd_dte_Invalid),Fields.InvalidMessage_stamp_dte(le.stamp_dte_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_gen_nbr(le.gen_nbr_Invalid),Fields.InvalidMessage_std_prof_desc(le.std_prof_desc_Invalid),Fields.InvalidMessage_std_source_upd(le.std_source_upd_Invalid),Fields.InvalidMessage_std_source_desc(le.std_source_desc_Invalid),Fields.InvalidMessage_type_cd(le.type_cd_Invalid),Fields.InvalidMessage_name_org_prefx(le.name_org_prefx_Invalid),Fields.InvalidMessage_name_org(le.name_org_Invalid),Fields.InvalidMessage_name_org_sufx(le.name_org_sufx_Invalid),Fields.InvalidMessage_store_nbr(le.store_nbr_Invalid),Fields.InvalidMessage_name_dba_prefx(le.name_dba_prefx_Invalid),Fields.InvalidMessage_name_dba(le.name_dba_Invalid),Fields.InvalidMessage_name_dba_sufx(le.name_dba_sufx_Invalid),Fields.InvalidMessage_store_nbr_dba(le.store_nbr_dba_Invalid),Fields.InvalidMessage_dba_flag(le.dba_flag_Invalid),Fields.InvalidMessage_name_office(le.name_office_Invalid),Fields.InvalidMessage_office_parse(le.office_parse_Invalid),Fields.InvalidMessage_name_prefx(le.name_prefx_Invalid),Fields.InvalidMessage_name_first(le.name_first_Invalid),Fields.InvalidMessage_name_mid(le.name_mid_Invalid),Fields.InvalidMessage_name_last(le.name_last_Invalid),Fields.InvalidMessage_name_sufx(le.name_sufx_Invalid),Fields.InvalidMessage_name_nick(le.name_nick_Invalid),Fields.InvalidMessage_birth_dte(le.birth_dte_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_prov_stat(le.prov_stat_Invalid),Fields.InvalidMessage_credential(le.credential_Invalid),Fields.InvalidMessage_license_nbr(le.license_nbr_Invalid),Fields.InvalidMessage_off_license_nbr(le.off_license_nbr_Invalid),Fields.InvalidMessage_prev_license_nbr(le.prev_license_nbr_Invalid),Fields.InvalidMessage_prev_license_type(le.prev_license_type_Invalid),Fields.InvalidMessage_license_state(le.license_state_Invalid),Fields.InvalidMessage_raw_license_type(le.raw_license_type_Invalid),Fields.InvalidMessage_raw_license_status(le.raw_license_status_Invalid),Fields.InvalidMessage_std_status_desc(le.std_status_desc_Invalid),Fields.InvalidMessage_curr_issue_dte(le.curr_issue_dte_Invalid),Fields.InvalidMessage_orig_issue_dte(le.orig_issue_dte_Invalid),Fields.InvalidMessage_expire_dte(le.expire_dte_Invalid),Fields.InvalidMessage_renewal_dte(le.renewal_dte_Invalid),Fields.InvalidMessage_active_flag(le.active_flag_Invalid),Fields.InvalidMessage_ssn_taxid_1(le.ssn_taxid_1_Invalid),Fields.InvalidMessage_tax_type_1(le.tax_type_1_Invalid),Fields.InvalidMessage_ssn_taxid_2(le.ssn_taxid_2_Invalid),Fields.InvalidMessage_tax_type_2(le.tax_type_2_Invalid),Fields.InvalidMessage_fed_rssd(le.fed_rssd_Invalid),Fields.InvalidMessage_addr_bus_ind(le.addr_bus_ind_Invalid),Fields.InvalidMessage_name_format(le.name_format_Invalid),Fields.InvalidMessage_name_org_orig(le.name_org_orig_Invalid),Fields.InvalidMessage_name_dba_orig(le.name_dba_orig_Invalid),Fields.InvalidMessage_name_mari_org(le.name_mari_org_Invalid),Fields.InvalidMessage_name_mari_dba(le.name_mari_dba_Invalid),Fields.InvalidMessage_phn_mari_1(le.phn_mari_1_Invalid),Fields.InvalidMessage_phn_mari_fax_1(le.phn_mari_fax_1_Invalid),Fields.InvalidMessage_phn_mari_2(le.phn_mari_2_Invalid),Fields.InvalidMessage_phn_mari_fax_2(le.phn_mari_fax_2_Invalid),Fields.InvalidMessage_addr_addr1_1(le.addr_addr1_1_Invalid),Fields.InvalidMessage_addr_addr2_1(le.addr_addr2_1_Invalid),Fields.InvalidMessage_addr_addr3_1(le.addr_addr3_1_Invalid),Fields.InvalidMessage_addr_addr4_1(le.addr_addr4_1_Invalid),Fields.InvalidMessage_addr_city_1(le.addr_city_1_Invalid),Fields.InvalidMessage_addr_state_1(le.addr_state_1_Invalid),Fields.InvalidMessage_addr_zip5_1(le.addr_zip5_1_Invalid),Fields.InvalidMessage_addr_zip4_1(le.addr_zip4_1_Invalid),Fields.InvalidMessage_phn_phone_1(le.phn_phone_1_Invalid),Fields.InvalidMessage_phn_fax_1(le.phn_fax_1_Invalid),Fields.InvalidMessage_addr_cnty_1(le.addr_cnty_1_Invalid),Fields.InvalidMessage_addr_cntry_1(le.addr_cntry_1_Invalid),Fields.InvalidMessage_sud_key_1(le.sud_key_1_Invalid),Fields.InvalidMessage_ooc_ind_1(le.ooc_ind_1_Invalid),Fields.InvalidMessage_addr_mail_ind(le.addr_mail_ind_Invalid),Fields.InvalidMessage_addr_addr1_2(le.addr_addr1_2_Invalid),Fields.InvalidMessage_addr_addr2_2(le.addr_addr2_2_Invalid),Fields.InvalidMessage_addr_addr3_2(le.addr_addr3_2_Invalid),Fields.InvalidMessage_addr_addr4_2(le.addr_addr4_2_Invalid),Fields.InvalidMessage_addr_city_2(le.addr_city_2_Invalid),Fields.InvalidMessage_addr_state_2(le.addr_state_2_Invalid),Fields.InvalidMessage_addr_zip5_2(le.addr_zip5_2_Invalid),Fields.InvalidMessage_addr_zip4_2(le.addr_zip4_2_Invalid),Fields.InvalidMessage_addr_cnty_2(le.addr_cnty_2_Invalid),Fields.InvalidMessage_addr_cntry_2(le.addr_cntry_2_Invalid),Fields.InvalidMessage_phn_phone_2(le.phn_phone_2_Invalid),Fields.InvalidMessage_phn_fax_2(le.phn_fax_2_Invalid),Fields.InvalidMessage_sud_key_2(le.sud_key_2_Invalid),Fields.InvalidMessage_ooc_ind_2(le.ooc_ind_2_Invalid),Fields.InvalidMessage_license_nbr_contact(le.license_nbr_contact_Invalid),Fields.InvalidMessage_name_contact_prefx(le.name_contact_prefx_Invalid),Fields.InvalidMessage_name_contact_first(le.name_contact_first_Invalid),Fields.InvalidMessage_name_contact_mid(le.name_contact_mid_Invalid),Fields.InvalidMessage_name_contact_last(le.name_contact_last_Invalid),Fields.InvalidMessage_name_contact_sufx(le.name_contact_sufx_Invalid),Fields.InvalidMessage_name_contact_nick(le.name_contact_nick_Invalid),Fields.InvalidMessage_name_contact_ttl(le.name_contact_ttl_Invalid),Fields.InvalidMessage_phn_contact(le.phn_contact_Invalid),Fields.InvalidMessage_phn_contact_ext(le.phn_contact_ext_Invalid),Fields.InvalidMessage_phn_contact_fax(le.phn_contact_fax_Invalid),Fields.InvalidMessage_email(le.email_Invalid),Fields.InvalidMessage_url(le.url_Invalid),Fields.InvalidMessage_bk_class(le.bk_class_Invalid),Fields.InvalidMessage_bk_class_desc(le.bk_class_desc_Invalid),Fields.InvalidMessage_charter(le.charter_Invalid),Fields.InvalidMessage_inst_beg_dte(le.inst_beg_dte_Invalid),Fields.InvalidMessage_origin_cd(le.origin_cd_Invalid),Fields.InvalidMessage_origin_cd_desc(le.origin_cd_desc_Invalid),Fields.InvalidMessage_disp_type_cd(le.disp_type_cd_Invalid),Fields.InvalidMessage_disp_type_desc(le.disp_type_desc_Invalid),Fields.InvalidMessage_reg_agent(le.reg_agent_Invalid),Fields.InvalidMessage_regulator(le.regulator_Invalid),Fields.InvalidMessage_hqtr_city(le.hqtr_city_Invalid),Fields.InvalidMessage_hqtr_name(le.hqtr_name_Invalid),Fields.InvalidMessage_domestic_off_nbr(le.domestic_off_nbr_Invalid),Fields.InvalidMessage_foreign_off_nbr(le.foreign_off_nbr_Invalid),Fields.InvalidMessage_hcr_rssd(le.hcr_rssd_Invalid),Fields.InvalidMessage_hcr_location(le.hcr_location_Invalid),Fields.InvalidMessage_affil_type_cd(le.affil_type_cd_Invalid),Fields.InvalidMessage_genlink(le.genlink_Invalid),Fields.InvalidMessage_research_ind(le.research_ind_Invalid),Fields.InvalidMessage_docket_id(le.docket_id_Invalid),Fields.InvalidMessage_mltreckey(le.mltreckey_Invalid),Fields.InvalidMessage_cmc_slpk(le.cmc_slpk_Invalid),Fields.InvalidMessage_pcmc_slpk(le.pcmc_slpk_Invalid),Fields.InvalidMessage_affil_key(le.affil_key_Invalid),Fields.InvalidMessage_action_taken_ind(le.action_taken_ind_Invalid),Fields.InvalidMessage_viol_type(le.viol_type_Invalid),Fields.InvalidMessage_viol_cd(le.viol_cd_Invalid),Fields.InvalidMessage_viol_desc(le.viol_desc_Invalid),Fields.InvalidMessage_viol_dte(le.viol_dte_Invalid),Fields.InvalidMessage_viol_case_nbr(le.viol_case_nbr_Invalid),Fields.InvalidMessage_viol_eff_dte(le.viol_eff_dte_Invalid),Fields.InvalidMessage_action_final_nbr(le.action_final_nbr_Invalid),Fields.InvalidMessage_action_status(le.action_status_Invalid),Fields.InvalidMessage_action_status_dte(le.action_status_dte_Invalid),Fields.InvalidMessage_action_file_name(le.action_file_name_Invalid),Fields.InvalidMessage_occupation(le.occupation_Invalid),Fields.InvalidMessage_practice_hrs(le.practice_hrs_Invalid),Fields.InvalidMessage_practice_type(le.practice_type_Invalid),Fields.InvalidMessage_misc_other_id(le.misc_other_id_Invalid),Fields.InvalidMessage_misc_other_type(le.misc_other_type_Invalid),Fields.InvalidMessage_cont_education_ernd(le.cont_education_ernd_Invalid),Fields.InvalidMessage_cont_education_req(le.cont_education_req_Invalid),Fields.InvalidMessage_cont_education_term(le.cont_education_term_Invalid),Fields.InvalidMessage_schl_attend_1(le.schl_attend_1_Invalid),Fields.InvalidMessage_schl_attend_dte_1(le.schl_attend_dte_1_Invalid),Fields.InvalidMessage_schl_curriculum_1(le.schl_curriculum_1_Invalid),Fields.InvalidMessage_schl_degree_1(le.schl_degree_1_Invalid),Fields.InvalidMessage_schl_attend_2(le.schl_attend_2_Invalid),Fields.InvalidMessage_schl_attend_dte_2(le.schl_attend_dte_2_Invalid),Fields.InvalidMessage_schl_curriculum_2(le.schl_curriculum_2_Invalid),Fields.InvalidMessage_schl_degree_2(le.schl_degree_2_Invalid),Fields.InvalidMessage_schl_attend_3(le.schl_attend_3_Invalid),Fields.InvalidMessage_schl_attend_dte_3(le.schl_attend_dte_3_Invalid),Fields.InvalidMessage_schl_curriculum_3(le.schl_curriculum_3_Invalid),Fields.InvalidMessage_schl_degree_3(le.schl_degree_3_Invalid),Fields.InvalidMessage_addl_license_spec(le.addl_license_spec_Invalid),Fields.InvalidMessage_place_birth_cd(le.place_birth_cd_Invalid),Fields.InvalidMessage_place_birth_desc(le.place_birth_desc_Invalid),Fields.InvalidMessage_race_cd(le.race_cd_Invalid),Fields.InvalidMessage_std_race_cd(le.std_race_cd_Invalid),Fields.InvalidMessage_race_desc(le.race_desc_Invalid),Fields.InvalidMessage_status_effect_dte(le.status_effect_dte_Invalid),Fields.InvalidMessage_status_renew_desc(le.status_renew_desc_Invalid),Fields.InvalidMessage_agency_status(le.agency_status_Invalid),Fields.InvalidMessage_prev_primary_key(le.prev_primary_key_Invalid),Fields.InvalidMessage_prev_mltreckey(le.prev_mltreckey_Invalid),Fields.InvalidMessage_prev_cmc_slpk(le.prev_cmc_slpk_Invalid),Fields.InvalidMessage_prev_pcmc_slpk(le.prev_pcmc_slpk_Invalid),Fields.InvalidMessage_license_id(le.license_id_Invalid),Fields.InvalidMessage_nmls_id(le.nmls_id_Invalid),Fields.InvalidMessage_foreign_nmls_id(le.foreign_nmls_id_Invalid),Fields.InvalidMessage_location_type(le.location_type_Invalid),Fields.InvalidMessage_off_license_nbr_type(le.off_license_nbr_type_Invalid),Fields.InvalidMessage_brkr_license_nbr(le.brkr_license_nbr_Invalid),Fields.InvalidMessage_brkr_license_nbr_type(le.brkr_license_nbr_type_Invalid),Fields.InvalidMessage_agency_id(le.agency_id_Invalid),Fields.InvalidMessage_site_location(le.site_location_Invalid),Fields.InvalidMessage_business_type(le.business_type_Invalid),Fields.InvalidMessage_start_dte(le.start_dte_Invalid),Fields.InvalidMessage_is_authorized_license(le.is_authorized_license_Invalid),Fields.InvalidMessage_is_authorized_conduct(le.is_authorized_conduct_Invalid),Fields.InvalidMessage_federal_regulator(le.federal_regulator_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.primary_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.create_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.last_upd_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.stamp_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.gen_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.std_prof_desc_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.std_source_upd_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.std_source_desc_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.type_cd_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_org_prefx_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_org_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_org_sufx_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.store_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_dba_prefx_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_dba_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_dba_sufx_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.store_nbr_dba_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dba_flag_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_office_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.office_parse_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_prefx_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_first_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_mid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_last_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_sufx_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_nick_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.birth_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.prov_stat_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.credential_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.license_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.off_license_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prev_license_nbr_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prev_license_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.license_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.raw_license_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_license_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.std_status_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.curr_issue_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_issue_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.expire_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.renewal_dte_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.active_flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ssn_taxid_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.tax_type_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ssn_taxid_2_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.tax_type_2_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.fed_rssd_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_bus_ind_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_format_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_org_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_dba_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_mari_org_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_mari_dba_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phn_mari_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phn_mari_fax_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phn_mari_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phn_mari_fax_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_addr1_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_addr2_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_addr3_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_addr4_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_city_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_state_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_zip5_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_zip4_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phn_phone_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phn_fax_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_cnty_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_cntry_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sud_key_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ooc_ind_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_mail_ind_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_addr1_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_addr2_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_addr3_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_addr4_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_city_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_state_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_zip5_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_zip4_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_cnty_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_cntry_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phn_phone_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phn_fax_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.sud_key_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ooc_ind_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.license_nbr_contact_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_contact_prefx_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_contact_first_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_contact_mid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_contact_last_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_contact_sufx_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_contact_nick_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_contact_ttl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phn_contact_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phn_contact_ext_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phn_contact_fax_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.url_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bk_class_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bk_class_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.charter_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.inst_beg_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.origin_cd_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.origin_cd_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.disp_type_cd_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.disp_type_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reg_agent_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.regulator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hqtr_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hqtr_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.domestic_off_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.foreign_off_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hcr_rssd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hcr_location_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.affil_type_cd_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.genlink_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.research_ind_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.docket_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mltreckey_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cmc_slpk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pcmc_slpk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.affil_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.action_taken_ind_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.viol_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.viol_cd_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.viol_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.viol_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.viol_case_nbr_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.viol_eff_dte_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.action_final_nbr_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.action_status_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.action_status_dte_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.action_file_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.occupation_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.practice_hrs_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.practice_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.misc_other_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.misc_other_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.cont_education_ernd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cont_education_req_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cont_education_term_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.schl_attend_1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_attend_dte_1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_curriculum_1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_degree_1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_attend_2_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_attend_dte_2_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_curriculum_2_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_degree_2_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_attend_3_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_attend_dte_3_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_curriculum_3_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.schl_degree_3_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.addl_license_spec_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.place_birth_cd_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.place_birth_desc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.race_cd_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.std_race_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.race_desc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.status_effect_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.status_renew_desc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.agency_status_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.prev_primary_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prev_mltreckey_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prev_cmc_slpk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prev_pcmc_slpk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nmls_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.foreign_nmls_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.location_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.off_license_nbr_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.brkr_license_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.brkr_license_nbr_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.agency_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.site_location_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.business_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.start_dte_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.is_authorized_license_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.is_authorized_conduct_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.federal_regulator_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'primary_key','create_dte','last_upd_dte','stamp_dte','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','process_date','gen_nbr','std_prof_desc','std_source_upd','std_source_desc','type_cd','name_org_prefx','name_org','name_org_sufx','store_nbr','name_dba_prefx','name_dba','name_dba_sufx','store_nbr_dba','dba_flag','name_office','office_parse','name_prefx','name_first','name_mid','name_last','name_sufx','name_nick','birth_dte','gender','prov_stat','credential','license_nbr','off_license_nbr','prev_license_nbr','prev_license_type','license_state','raw_license_type','raw_license_status','std_status_desc','curr_issue_dte','orig_issue_dte','expire_dte','renewal_dte','active_flag','ssn_taxid_1','tax_type_1','ssn_taxid_2','tax_type_2','fed_rssd','addr_bus_ind','name_format','name_org_orig','name_dba_orig','name_mari_org','name_mari_dba','phn_mari_1','phn_mari_fax_1','phn_mari_2','phn_mari_fax_2','addr_addr1_1','addr_addr2_1','addr_addr3_1','addr_addr4_1','addr_city_1','addr_state_1','addr_zip5_1','addr_zip4_1','phn_phone_1','phn_fax_1','addr_cnty_1','addr_cntry_1','sud_key_1','ooc_ind_1','addr_mail_ind','addr_addr1_2','addr_addr2_2','addr_addr3_2','addr_addr4_2','addr_city_2','addr_state_2','addr_zip5_2','addr_zip4_2','addr_cnty_2','addr_cntry_2','phn_phone_2','phn_fax_2','sud_key_2','ooc_ind_2','license_nbr_contact','name_contact_prefx','name_contact_first','name_contact_mid','name_contact_last','name_contact_sufx','name_contact_nick','name_contact_ttl','phn_contact','phn_contact_ext','phn_contact_fax','email','url','bk_class','bk_class_desc','charter','inst_beg_dte','origin_cd','origin_cd_desc','disp_type_cd','disp_type_desc','reg_agent','regulator','hqtr_city','hqtr_name','domestic_off_nbr','foreign_off_nbr','hcr_rssd','hcr_location','affil_type_cd','genlink','research_ind','docket_id','mltreckey','cmc_slpk','pcmc_slpk','affil_key','action_taken_ind','viol_type','viol_cd','viol_desc','viol_dte','viol_case_nbr','viol_eff_dte','action_final_nbr','action_status','action_status_dte','action_file_name','occupation','practice_hrs','practice_type','misc_other_id','misc_other_type','cont_education_ernd','cont_education_req','cont_education_term','schl_attend_1','schl_attend_dte_1','schl_curriculum_1','schl_degree_1','schl_attend_2','schl_attend_dte_2','schl_curriculum_2','schl_degree_2','schl_attend_3','schl_attend_dte_3','schl_curriculum_3','schl_degree_3','addl_license_spec','place_birth_cd','place_birth_desc','race_cd','std_race_cd','race_desc','status_effect_dte','status_renew_desc','agency_status','prev_primary_key','prev_mltreckey','prev_cmc_slpk','prev_pcmc_slpk','license_id','nmls_id','foreign_nmls_id','location_type','off_license_nbr_type','brkr_license_nbr','brkr_license_nbr_type','agency_id','site_location','business_type','start_dte','is_authorized_license','is_authorized_conduct','federal_regulator','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_primary_key','invalid_create_dte','invalid_last_upd_dte','invalid_stamp_dte','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_gen_nbr','invalid_std_prof_desc','invalid_std_source_upd','invalid_std_source_desc','invalid_type_cd','invalid_name_org_prefx','invalid_name_org','invalid_name_org_sufx','invalid_store_nbr','invalid_name_dba_prefx','invalid_name_dba','invalid_name_dba_sufx','invalid_store_nbr_dba','invalid_dba_flag','invalid_name_office','invalid_office_parse','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_date','invalid_gender','invalid_prov_stat','invalid_credential','invalid_license_nbr','invalid_license_nbr','invalid_prev_license_nbr','invalid_prev_license_type','invalid_license_state','invalid_raw_license_type','invalid_raw_license_status','invalid_std_status_desc','invalid_date','invalid_date','invalid_date','invalid_renewal_dte','invalid_active_flag','invalid_ssn_taxid_1','invalid_tax_type_1','invalid_ssn_taxid_2','invalid_tax_type_2','invalid_fed_rssd','invalid_addr_bus_ind','invalid_name_format','invalid_name_org_orig','invalid_name_dba_orig','invalid_name_mari_org','invalid_name_mari_dba','invalid_phone_number','invalid_phone_number','invalid_phone_number','invalid_phone_number','invalid_address','invalid_address','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip5','invalid_zip4','invalid_phone_number','invalid_phone_number','invalid_county','invalid_country','invalid_sud_key','invalid_ooc_ind','invalid_addr_mail_ind','invalid_address','invalid_address','invalid_address','invalid_address','invalid_city','invalid_state','invalid_zip5','invalid_zip4','invalid_county','invalid_country','invalid_phone_number','invalid_phone_number','invalid_sud_key','invalid_ooc_ind','invalid_license_nbr_contact','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_phone_number','invalid_phone_number','invalid_phone_number','invalid_email','invalid_url','invalid_bk_class','invalid_bk_class_desc','invalid_charter','invalid_date','invalid_origin_cd','invalid_origin_cd_desc','invalid_disp_type_cd','invalid_disp_type_desc','invalid_reg_agent','invalid_regulator','invalid_city','invalid_hqtr_name','invalid_domestic_off_nbr','invalid_foreign_off_nbr','invalid_hcr_rssd','invalid_state','invalid_affil_type_cd','invalid_genlink','invalid_research_ind','invalid_docket_id','invalid_mltreckey','invalid_cmc_slpk','invalid_pcmc_slpk','invalid_affil_key','invalid_blank','invalid_blank','invalid_blank','invalid_viol_desc','invalid_date','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_misc_other_id','invalid_misc_other_type','invalid_cont_education_ernd','invalid_cont_education_req','invalid_cont_education_term','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_blank','invalid_addl_license_spec','invalid_blank','invalid_blank','invalid_race_cd','invalid_std_race_cd','invalid_blank','invalid_date','invalid_blank','invalid_agency_status','invalid_prev_primary_key','invalid_prev_mltreckey','invalid_prev_cmc_slpk','invalid_prev_pcmc_slpk','invalid_license_id','invalid_nmls_id','invalid_foreign_nmls_id','invalid_location_type','invalid_off_license_nbr_type','invalid_brkr_license_nbr','invalid_brkr_license_nbr_type','invalid_agency_id','invalid_address','invalid_business_type','invalid_date','invalid_is_authorized','invalid_is_authorized','invalid_federal_regulator','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.primary_key,(SALT31.StrType)le.create_dte,(SALT31.StrType)le.last_upd_dte,(SALT31.StrType)le.stamp_dte,(SALT31.StrType)le.date_first_seen,(SALT31.StrType)le.date_last_seen,(SALT31.StrType)le.date_vendor_first_reported,(SALT31.StrType)le.date_vendor_last_reported,(SALT31.StrType)le.process_date,(SALT31.StrType)le.gen_nbr,(SALT31.StrType)le.std_prof_desc,(SALT31.StrType)le.std_source_upd,(SALT31.StrType)le.std_source_desc,(SALT31.StrType)le.type_cd,(SALT31.StrType)le.name_org_prefx,(SALT31.StrType)le.name_org,(SALT31.StrType)le.name_org_sufx,(SALT31.StrType)le.store_nbr,(SALT31.StrType)le.name_dba_prefx,(SALT31.StrType)le.name_dba,(SALT31.StrType)le.name_dba_sufx,(SALT31.StrType)le.store_nbr_dba,(SALT31.StrType)le.dba_flag,(SALT31.StrType)le.name_office,(SALT31.StrType)le.office_parse,(SALT31.StrType)le.name_prefx,(SALT31.StrType)le.name_first,(SALT31.StrType)le.name_mid,(SALT31.StrType)le.name_last,(SALT31.StrType)le.name_sufx,(SALT31.StrType)le.name_nick,(SALT31.StrType)le.birth_dte,(SALT31.StrType)le.gender,(SALT31.StrType)le.prov_stat,(SALT31.StrType)le.credential,(SALT31.StrType)le.license_nbr,(SALT31.StrType)le.off_license_nbr,(SALT31.StrType)le.prev_license_nbr,(SALT31.StrType)le.prev_license_type,(SALT31.StrType)le.license_state,(SALT31.StrType)le.raw_license_type,(SALT31.StrType)le.raw_license_status,(SALT31.StrType)le.std_status_desc,(SALT31.StrType)le.curr_issue_dte,(SALT31.StrType)le.orig_issue_dte,(SALT31.StrType)le.expire_dte,(SALT31.StrType)le.renewal_dte,(SALT31.StrType)le.active_flag,(SALT31.StrType)le.ssn_taxid_1,(SALT31.StrType)le.tax_type_1,(SALT31.StrType)le.ssn_taxid_2,(SALT31.StrType)le.tax_type_2,(SALT31.StrType)le.fed_rssd,(SALT31.StrType)le.addr_bus_ind,(SALT31.StrType)le.name_format,(SALT31.StrType)le.name_org_orig,(SALT31.StrType)le.name_dba_orig,(SALT31.StrType)le.name_mari_org,(SALT31.StrType)le.name_mari_dba,(SALT31.StrType)le.phn_mari_1,(SALT31.StrType)le.phn_mari_fax_1,(SALT31.StrType)le.phn_mari_2,(SALT31.StrType)le.phn_mari_fax_2,(SALT31.StrType)le.addr_addr1_1,(SALT31.StrType)le.addr_addr2_1,(SALT31.StrType)le.addr_addr3_1,(SALT31.StrType)le.addr_addr4_1,(SALT31.StrType)le.addr_city_1,(SALT31.StrType)le.addr_state_1,(SALT31.StrType)le.addr_zip5_1,(SALT31.StrType)le.addr_zip4_1,(SALT31.StrType)le.phn_phone_1,(SALT31.StrType)le.phn_fax_1,(SALT31.StrType)le.addr_cnty_1,(SALT31.StrType)le.addr_cntry_1,(SALT31.StrType)le.sud_key_1,(SALT31.StrType)le.ooc_ind_1,(SALT31.StrType)le.addr_mail_ind,(SALT31.StrType)le.addr_addr1_2,(SALT31.StrType)le.addr_addr2_2,(SALT31.StrType)le.addr_addr3_2,(SALT31.StrType)le.addr_addr4_2,(SALT31.StrType)le.addr_city_2,(SALT31.StrType)le.addr_state_2,(SALT31.StrType)le.addr_zip5_2,(SALT31.StrType)le.addr_zip4_2,(SALT31.StrType)le.addr_cnty_2,(SALT31.StrType)le.addr_cntry_2,(SALT31.StrType)le.phn_phone_2,(SALT31.StrType)le.phn_fax_2,(SALT31.StrType)le.sud_key_2,(SALT31.StrType)le.ooc_ind_2,(SALT31.StrType)le.license_nbr_contact,(SALT31.StrType)le.name_contact_prefx,(SALT31.StrType)le.name_contact_first,(SALT31.StrType)le.name_contact_mid,(SALT31.StrType)le.name_contact_last,(SALT31.StrType)le.name_contact_sufx,(SALT31.StrType)le.name_contact_nick,(SALT31.StrType)le.name_contact_ttl,(SALT31.StrType)le.phn_contact,(SALT31.StrType)le.phn_contact_ext,(SALT31.StrType)le.phn_contact_fax,(SALT31.StrType)le.email,(SALT31.StrType)le.url,(SALT31.StrType)le.bk_class,(SALT31.StrType)le.bk_class_desc,(SALT31.StrType)le.charter,(SALT31.StrType)le.inst_beg_dte,(SALT31.StrType)le.origin_cd,(SALT31.StrType)le.origin_cd_desc,(SALT31.StrType)le.disp_type_cd,(SALT31.StrType)le.disp_type_desc,(SALT31.StrType)le.reg_agent,(SALT31.StrType)le.regulator,(SALT31.StrType)le.hqtr_city,(SALT31.StrType)le.hqtr_name,(SALT31.StrType)le.domestic_off_nbr,(SALT31.StrType)le.foreign_off_nbr,(SALT31.StrType)le.hcr_rssd,(SALT31.StrType)le.hcr_location,(SALT31.StrType)le.affil_type_cd,(SALT31.StrType)le.genlink,(SALT31.StrType)le.research_ind,(SALT31.StrType)le.docket_id,(SALT31.StrType)le.mltreckey,(SALT31.StrType)le.cmc_slpk,(SALT31.StrType)le.pcmc_slpk,(SALT31.StrType)le.affil_key,(SALT31.StrType)le.action_taken_ind,(SALT31.StrType)le.viol_type,(SALT31.StrType)le.viol_cd,(SALT31.StrType)le.viol_desc,(SALT31.StrType)le.viol_dte,(SALT31.StrType)le.viol_case_nbr,(SALT31.StrType)le.viol_eff_dte,(SALT31.StrType)le.action_final_nbr,(SALT31.StrType)le.action_status,(SALT31.StrType)le.action_status_dte,(SALT31.StrType)le.action_file_name,(SALT31.StrType)le.occupation,(SALT31.StrType)le.practice_hrs,(SALT31.StrType)le.practice_type,(SALT31.StrType)le.misc_other_id,(SALT31.StrType)le.misc_other_type,(SALT31.StrType)le.cont_education_ernd,(SALT31.StrType)le.cont_education_req,(SALT31.StrType)le.cont_education_term,(SALT31.StrType)le.schl_attend_1,(SALT31.StrType)le.schl_attend_dte_1,(SALT31.StrType)le.schl_curriculum_1,(SALT31.StrType)le.schl_degree_1,(SALT31.StrType)le.schl_attend_2,(SALT31.StrType)le.schl_attend_dte_2,(SALT31.StrType)le.schl_curriculum_2,(SALT31.StrType)le.schl_degree_2,(SALT31.StrType)le.schl_attend_3,(SALT31.StrType)le.schl_attend_dte_3,(SALT31.StrType)le.schl_curriculum_3,(SALT31.StrType)le.schl_degree_3,(SALT31.StrType)le.addl_license_spec,(SALT31.StrType)le.place_birth_cd,(SALT31.StrType)le.place_birth_desc,(SALT31.StrType)le.race_cd,(SALT31.StrType)le.std_race_cd,(SALT31.StrType)le.race_desc,(SALT31.StrType)le.status_effect_dte,(SALT31.StrType)le.status_renew_desc,(SALT31.StrType)le.agency_status,(SALT31.StrType)le.prev_primary_key,(SALT31.StrType)le.prev_mltreckey,(SALT31.StrType)le.prev_cmc_slpk,(SALT31.StrType)le.prev_pcmc_slpk,(SALT31.StrType)le.license_id,(SALT31.StrType)le.nmls_id,(SALT31.StrType)le.foreign_nmls_id,(SALT31.StrType)le.location_type,(SALT31.StrType)le.off_license_nbr_type,(SALT31.StrType)le.brkr_license_nbr,(SALT31.StrType)le.brkr_license_nbr_type,(SALT31.StrType)le.agency_id,(SALT31.StrType)le.site_location,(SALT31.StrType)le.business_type,(SALT31.StrType)le.start_dte,(SALT31.StrType)le.is_authorized_license,(SALT31.StrType)le.is_authorized_conduct,(SALT31.StrType)le.federal_regulator,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,187,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.std_source_upd;
      SELF.ruledesc := CHOOSE(c
          ,'primary_key:invalid_primary_key:ALLOW'
          ,'create_dte:invalid_create_dte:ALLOW','create_dte:invalid_create_dte:LENGTH'
          ,'last_upd_dte:invalid_last_upd_dte:ALLOW','last_upd_dte:invalid_last_upd_dte:LENGTH'
          ,'stamp_dte:invalid_stamp_dte:ALLOW','stamp_dte:invalid_stamp_dte:LENGTH'
          ,'date_first_seen:invalid_date:ALLOW','date_first_seen:invalid_date:LENGTH'
          ,'date_last_seen:invalid_date:ALLOW','date_last_seen:invalid_date:LENGTH'
          ,'date_vendor_first_reported:invalid_date:ALLOW','date_vendor_first_reported:invalid_date:LENGTH'
          ,'date_vendor_last_reported:invalid_date:ALLOW','date_vendor_last_reported:invalid_date:LENGTH'
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:LENGTH'
          ,'gen_nbr:invalid_gen_nbr:ALLOW','gen_nbr:invalid_gen_nbr:LENGTH'
          ,'std_prof_desc:invalid_std_prof_desc:ENUM'
          ,'std_source_upd:invalid_std_source_upd:ALLOW','std_source_upd:invalid_std_source_upd:LENGTH'
          ,'std_source_desc:invalid_std_source_desc:ALLOW','std_source_desc:invalid_std_source_desc:LENGTH'
          ,'type_cd:invalid_type_cd:ENUM','type_cd:invalid_type_cd:LENGTH'
          ,'name_org_prefx:invalid_name_org_prefx:ALLOW','name_org_prefx:invalid_name_org_prefx:LENGTH'
          ,'name_org:invalid_name_org:ALLOW'
          ,'name_org_sufx:invalid_name_org_sufx:ALLOW','name_org_sufx:invalid_name_org_sufx:LENGTH'
          ,'store_nbr:invalid_store_nbr:ALLOW','store_nbr:invalid_store_nbr:LENGTH'
          ,'name_dba_prefx:invalid_name_dba_prefx:ALLOW','name_dba_prefx:invalid_name_dba_prefx:LENGTH'
          ,'name_dba:invalid_name_dba:ALLOW'
          ,'name_dba_sufx:invalid_name_dba_sufx:ALLOW','name_dba_sufx:invalid_name_dba_sufx:LENGTH'
          ,'store_nbr_dba:invalid_store_nbr_dba:ALLOW','store_nbr_dba:invalid_store_nbr_dba:LENGTH'
          ,'dba_flag:invalid_dba_flag:ALLOW'
          ,'name_office:invalid_name_office:ALLOW','name_office:invalid_name_office:LENGTH'
          ,'office_parse:invalid_office_parse:ENUM','office_parse:invalid_office_parse:LENGTH'
          ,'name_prefx:invalid_name:ALLOW'
          ,'name_first:invalid_name:ALLOW'
          ,'name_mid:invalid_name:ALLOW'
          ,'name_last:invalid_name:ALLOW'
          ,'name_sufx:invalid_name:ALLOW'
          ,'name_nick:invalid_name:ALLOW'
          ,'birth_dte:invalid_date:ALLOW','birth_dte:invalid_date:LENGTH'
          ,'gender:invalid_gender:ENUM','gender:invalid_gender:LENGTH'
          ,'prov_stat:invalid_prov_stat:ENUM','prov_stat:invalid_prov_stat:LENGTH'
          ,'credential:invalid_credential:ALLOW','credential:invalid_credential:LENGTH'
          ,'license_nbr:invalid_license_nbr:ALLOW'
          ,'off_license_nbr:invalid_license_nbr:ALLOW'
          ,'prev_license_nbr:invalid_prev_license_nbr:LENGTH'
          ,'prev_license_type:invalid_prev_license_type:LENGTH'
          ,'license_state:invalid_license_state:ALLOW','license_state:invalid_license_state:LENGTH'
          ,'raw_license_type:invalid_raw_license_type:ALLOW'
          ,'raw_license_status:invalid_raw_license_status:ALLOW'
          ,'std_status_desc:invalid_std_status_desc:ALLOW'
          ,'curr_issue_dte:invalid_date:ALLOW','curr_issue_dte:invalid_date:LENGTH'
          ,'orig_issue_dte:invalid_date:ALLOW','orig_issue_dte:invalid_date:LENGTH'
          ,'expire_dte:invalid_date:ALLOW','expire_dte:invalid_date:LENGTH'
          ,'renewal_dte:invalid_renewal_dte:ALLOW'
          ,'active_flag:invalid_active_flag:ALLOW','active_flag:invalid_active_flag:LENGTH'
          ,'ssn_taxid_1:invalid_ssn_taxid_1:ALLOW','ssn_taxid_1:invalid_ssn_taxid_1:LENGTH'
          ,'tax_type_1:invalid_tax_type_1:ALLOW','tax_type_1:invalid_tax_type_1:LENGTH'
          ,'ssn_taxid_2:invalid_ssn_taxid_2:LENGTH'
          ,'tax_type_2:invalid_tax_type_2:LENGTH'
          ,'fed_rssd:invalid_fed_rssd:ALLOW','fed_rssd:invalid_fed_rssd:LENGTH'
          ,'addr_bus_ind:invalid_addr_bus_ind:ALLOW','addr_bus_ind:invalid_addr_bus_ind:LENGTH'
          ,'name_format:invalid_name_format:ALLOW','name_format:invalid_name_format:LENGTH'
          ,'name_org_orig:invalid_name_org_orig:ALLOW'
          ,'name_dba_orig:invalid_name_dba_orig:ALLOW'
          ,'name_mari_org:invalid_name_mari_org:ALLOW'
          ,'name_mari_dba:invalid_name_mari_dba:ALLOW'
          ,'phn_mari_1:invalid_phone_number:ALLOW','phn_mari_1:invalid_phone_number:LENGTH'
          ,'phn_mari_fax_1:invalid_phone_number:ALLOW','phn_mari_fax_1:invalid_phone_number:LENGTH'
          ,'phn_mari_2:invalid_phone_number:ALLOW','phn_mari_2:invalid_phone_number:LENGTH'
          ,'phn_mari_fax_2:invalid_phone_number:ALLOW','phn_mari_fax_2:invalid_phone_number:LENGTH'
          ,'addr_addr1_1:invalid_address:ALLOW'
          ,'addr_addr2_1:invalid_address:ALLOW'
          ,'addr_addr3_1:invalid_address:ALLOW'
          ,'addr_addr4_1:invalid_address:ALLOW'
          ,'addr_city_1:invalid_city:ALLOW'
          ,'addr_state_1:invalid_state:ALLOW','addr_state_1:invalid_state:LENGTH'
          ,'addr_zip5_1:invalid_zip5:ALLOW','addr_zip5_1:invalid_zip5:LENGTH'
          ,'addr_zip4_1:invalid_zip4:ALLOW','addr_zip4_1:invalid_zip4:LENGTH'
          ,'phn_phone_1:invalid_phone_number:ALLOW','phn_phone_1:invalid_phone_number:LENGTH'
          ,'phn_fax_1:invalid_phone_number:ALLOW','phn_fax_1:invalid_phone_number:LENGTH'
          ,'addr_cnty_1:invalid_county:ALLOW'
          ,'addr_cntry_1:invalid_country:ALLOW'
          ,'sud_key_1:invalid_sud_key:ALLOW'
          ,'ooc_ind_1:invalid_ooc_ind:ALLOW','ooc_ind_1:invalid_ooc_ind:LENGTH'
          ,'addr_mail_ind:invalid_addr_mail_ind:ALLOW','addr_mail_ind:invalid_addr_mail_ind:LENGTH'
          ,'addr_addr1_2:invalid_address:ALLOW'
          ,'addr_addr2_2:invalid_address:ALLOW'
          ,'addr_addr3_2:invalid_address:ALLOW'
          ,'addr_addr4_2:invalid_address:ALLOW'
          ,'addr_city_2:invalid_city:ALLOW'
          ,'addr_state_2:invalid_state:ALLOW','addr_state_2:invalid_state:LENGTH'
          ,'addr_zip5_2:invalid_zip5:ALLOW','addr_zip5_2:invalid_zip5:LENGTH'
          ,'addr_zip4_2:invalid_zip4:ALLOW','addr_zip4_2:invalid_zip4:LENGTH'
          ,'addr_cnty_2:invalid_county:ALLOW'
          ,'addr_cntry_2:invalid_country:ALLOW'
          ,'phn_phone_2:invalid_phone_number:ALLOW','phn_phone_2:invalid_phone_number:LENGTH'
          ,'phn_fax_2:invalid_phone_number:ALLOW','phn_fax_2:invalid_phone_number:LENGTH'
          ,'sud_key_2:invalid_sud_key:ALLOW'
          ,'ooc_ind_2:invalid_ooc_ind:ALLOW','ooc_ind_2:invalid_ooc_ind:LENGTH'
          ,'license_nbr_contact:invalid_license_nbr_contact:ALLOW'
          ,'name_contact_prefx:invalid_name:ALLOW'
          ,'name_contact_first:invalid_name:ALLOW'
          ,'name_contact_mid:invalid_name:ALLOW'
          ,'name_contact_last:invalid_name:ALLOW'
          ,'name_contact_sufx:invalid_name:ALLOW'
          ,'name_contact_nick:invalid_name:ALLOW'
          ,'name_contact_ttl:invalid_name:ALLOW'
          ,'phn_contact:invalid_phone_number:ALLOW','phn_contact:invalid_phone_number:LENGTH'
          ,'phn_contact_ext:invalid_phone_number:ALLOW','phn_contact_ext:invalid_phone_number:LENGTH'
          ,'phn_contact_fax:invalid_phone_number:ALLOW','phn_contact_fax:invalid_phone_number:LENGTH'
          ,'email:invalid_email:ALLOW'
          ,'url:invalid_url:ALLOW'
          ,'bk_class:invalid_bk_class:ALLOW','bk_class:invalid_bk_class:LENGTH'
          ,'bk_class_desc:invalid_bk_class_desc:ALLOW'
          ,'charter:invalid_charter:ALLOW'
          ,'inst_beg_dte:invalid_date:ALLOW','inst_beg_dte:invalid_date:LENGTH'
          ,'origin_cd:invalid_origin_cd:ALLOW','origin_cd:invalid_origin_cd:LENGTH'
          ,'origin_cd_desc:invalid_origin_cd_desc:ALLOW'
          ,'disp_type_cd:invalid_disp_type_cd:ALLOW','disp_type_cd:invalid_disp_type_cd:LENGTH'
          ,'disp_type_desc:invalid_disp_type_desc:ALLOW'
          ,'reg_agent:invalid_reg_agent:ENUM'
          ,'regulator:invalid_regulator:ALLOW'
          ,'hqtr_city:invalid_city:ALLOW'
          ,'hqtr_name:invalid_hqtr_name:ALLOW'
          ,'domestic_off_nbr:invalid_domestic_off_nbr:ALLOW'
          ,'foreign_off_nbr:invalid_foreign_off_nbr:ALLOW'
          ,'hcr_rssd:invalid_hcr_rssd:ALLOW'
          ,'hcr_location:invalid_state:ALLOW','hcr_location:invalid_state:LENGTH'
          ,'affil_type_cd:invalid_affil_type_cd:ENUM','affil_type_cd:invalid_affil_type_cd:LENGTH'
          ,'genlink:invalid_genlink:ALLOW','genlink:invalid_genlink:LENGTH'
          ,'research_ind:invalid_research_ind:ALLOW','research_ind:invalid_research_ind:LENGTH'
          ,'docket_id:invalid_docket_id:ALLOW'
          ,'mltreckey:invalid_mltreckey:ALLOW'
          ,'cmc_slpk:invalid_cmc_slpk:ALLOW'
          ,'pcmc_slpk:invalid_pcmc_slpk:ALLOW'
          ,'affil_key:invalid_affil_key:ALLOW'
          ,'action_taken_ind:invalid_blank:LENGTH'
          ,'viol_type:invalid_blank:LENGTH'
          ,'viol_cd:invalid_blank:LENGTH'
          ,'viol_desc:invalid_viol_desc:ALLOW'
          ,'viol_dte:invalid_date:ALLOW','viol_dte:invalid_date:LENGTH'
          ,'viol_case_nbr:invalid_blank:LENGTH'
          ,'viol_eff_dte:invalid_blank:LENGTH'
          ,'action_final_nbr:invalid_blank:LENGTH'
          ,'action_status:invalid_blank:LENGTH'
          ,'action_status_dte:invalid_blank:LENGTH'
          ,'action_file_name:invalid_blank:LENGTH'
          ,'occupation:invalid_blank:LENGTH'
          ,'practice_hrs:invalid_blank:LENGTH'
          ,'practice_type:invalid_blank:LENGTH'
          ,'misc_other_id:invalid_misc_other_id:ALLOW'
          ,'misc_other_type:invalid_misc_other_type:ENUM'
          ,'cont_education_ernd:invalid_cont_education_ernd:ALLOW'
          ,'cont_education_req:invalid_cont_education_req:ALLOW'
          ,'cont_education_term:invalid_cont_education_term:ALLOW'
          ,'schl_attend_1:invalid_blank:LENGTH'
          ,'schl_attend_dte_1:invalid_blank:LENGTH'
          ,'schl_curriculum_1:invalid_blank:LENGTH'
          ,'schl_degree_1:invalid_blank:LENGTH'
          ,'schl_attend_2:invalid_blank:LENGTH'
          ,'schl_attend_dte_2:invalid_blank:LENGTH'
          ,'schl_curriculum_2:invalid_blank:LENGTH'
          ,'schl_degree_2:invalid_blank:LENGTH'
          ,'schl_attend_3:invalid_blank:LENGTH'
          ,'schl_attend_dte_3:invalid_blank:LENGTH'
          ,'schl_curriculum_3:invalid_blank:LENGTH'
          ,'schl_degree_3:invalid_blank:LENGTH'
          ,'addl_license_spec:invalid_addl_license_spec:ALLOW'
          ,'place_birth_cd:invalid_blank:LENGTH'
          ,'place_birth_desc:invalid_blank:LENGTH'
          ,'race_cd:invalid_race_cd:ALLOW','race_cd:invalid_race_cd:LENGTH'
          ,'std_race_cd:invalid_std_race_cd:ENUM'
          ,'race_desc:invalid_blank:LENGTH'
          ,'status_effect_dte:invalid_date:ALLOW','status_effect_dte:invalid_date:LENGTH'
          ,'status_renew_desc:invalid_blank:LENGTH'
          ,'agency_status:invalid_agency_status:ENUM'
          ,'prev_primary_key:invalid_prev_primary_key:ALLOW'
          ,'prev_mltreckey:invalid_prev_mltreckey:ALLOW'
          ,'prev_cmc_slpk:invalid_prev_cmc_slpk:ALLOW'
          ,'prev_pcmc_slpk:invalid_prev_pcmc_slpk:ALLOW'
          ,'license_id:invalid_license_id:ALLOW'
          ,'nmls_id:invalid_nmls_id:ALLOW'
          ,'foreign_nmls_id:invalid_foreign_nmls_id:ALLOW'
          ,'location_type:invalid_location_type:ENUM'
          ,'off_license_nbr_type:invalid_off_license_nbr_type:ALLOW'
          ,'brkr_license_nbr:invalid_brkr_license_nbr:ALLOW'
          ,'brkr_license_nbr_type:invalid_brkr_license_nbr_type:ALLOW'
          ,'agency_id:invalid_agency_id:ALLOW'
          ,'site_location:invalid_address:ALLOW'
          ,'business_type:invalid_business_type:ALLOW'
          ,'start_dte:invalid_date:ALLOW','start_dte:invalid_date:LENGTH'
          ,'is_authorized_license:invalid_is_authorized:ENUM'
          ,'is_authorized_conduct:invalid_is_authorized:ENUM'
          ,'federal_regulator:invalid_federal_regulator:ALLOW','UNKNOWN');
      SELF.ErrorMessage := '';

      SELF.rulecnt := CHOOSE(c
          ,le.primary_key_ALLOW_ErrorCount
          ,le.create_dte_ALLOW_ErrorCount,le.create_dte_LENGTH_ErrorCount
          ,le.last_upd_dte_ALLOW_ErrorCount,le.last_upd_dte_LENGTH_ErrorCount
          ,le.stamp_dte_ALLOW_ErrorCount,le.stamp_dte_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.gen_nbr_ALLOW_ErrorCount,le.gen_nbr_LENGTH_ErrorCount
          ,le.std_prof_desc_ENUM_ErrorCount
          ,le.std_source_upd_ALLOW_ErrorCount,le.std_source_upd_LENGTH_ErrorCount
          ,le.std_source_desc_ALLOW_ErrorCount,le.std_source_desc_LENGTH_ErrorCount
          ,le.type_cd_ENUM_ErrorCount,le.type_cd_LENGTH_ErrorCount
          ,le.name_org_prefx_ALLOW_ErrorCount,le.name_org_prefx_LENGTH_ErrorCount
          ,le.name_org_ALLOW_ErrorCount
          ,le.name_org_sufx_ALLOW_ErrorCount,le.name_org_sufx_LENGTH_ErrorCount
          ,le.store_nbr_ALLOW_ErrorCount,le.store_nbr_LENGTH_ErrorCount
          ,le.name_dba_prefx_ALLOW_ErrorCount,le.name_dba_prefx_LENGTH_ErrorCount
          ,le.name_dba_ALLOW_ErrorCount
          ,le.name_dba_sufx_ALLOW_ErrorCount,le.name_dba_sufx_LENGTH_ErrorCount
          ,le.store_nbr_dba_ALLOW_ErrorCount,le.store_nbr_dba_LENGTH_ErrorCount
          ,le.dba_flag_ALLOW_ErrorCount
          ,le.name_office_ALLOW_ErrorCount,le.name_office_LENGTH_ErrorCount
          ,le.office_parse_ENUM_ErrorCount,le.office_parse_LENGTH_ErrorCount
          ,le.name_prefx_ALLOW_ErrorCount
          ,le.name_first_ALLOW_ErrorCount
          ,le.name_mid_ALLOW_ErrorCount
          ,le.name_last_ALLOW_ErrorCount
          ,le.name_sufx_ALLOW_ErrorCount
          ,le.name_nick_ALLOW_ErrorCount
          ,le.birth_dte_ALLOW_ErrorCount,le.birth_dte_LENGTH_ErrorCount
          ,le.gender_ENUM_ErrorCount,le.gender_LENGTH_ErrorCount
          ,le.prov_stat_ENUM_ErrorCount,le.prov_stat_LENGTH_ErrorCount
          ,le.credential_ALLOW_ErrorCount,le.credential_LENGTH_ErrorCount
          ,le.license_nbr_ALLOW_ErrorCount
          ,le.off_license_nbr_ALLOW_ErrorCount
          ,le.prev_license_nbr_LENGTH_ErrorCount
          ,le.prev_license_type_LENGTH_ErrorCount
          ,le.license_state_ALLOW_ErrorCount,le.license_state_LENGTH_ErrorCount
          ,le.raw_license_type_ALLOW_ErrorCount
          ,le.raw_license_status_ALLOW_ErrorCount
          ,le.std_status_desc_ALLOW_ErrorCount
          ,le.curr_issue_dte_ALLOW_ErrorCount,le.curr_issue_dte_LENGTH_ErrorCount
          ,le.orig_issue_dte_ALLOW_ErrorCount,le.orig_issue_dte_LENGTH_ErrorCount
          ,le.expire_dte_ALLOW_ErrorCount,le.expire_dte_LENGTH_ErrorCount
          ,le.renewal_dte_ALLOW_ErrorCount
          ,le.active_flag_ALLOW_ErrorCount,le.active_flag_LENGTH_ErrorCount
          ,le.ssn_taxid_1_ALLOW_ErrorCount,le.ssn_taxid_1_LENGTH_ErrorCount
          ,le.tax_type_1_ALLOW_ErrorCount,le.tax_type_1_LENGTH_ErrorCount
          ,le.ssn_taxid_2_LENGTH_ErrorCount
          ,le.tax_type_2_LENGTH_ErrorCount
          ,le.fed_rssd_ALLOW_ErrorCount,le.fed_rssd_LENGTH_ErrorCount
          ,le.addr_bus_ind_ALLOW_ErrorCount,le.addr_bus_ind_LENGTH_ErrorCount
          ,le.name_format_ALLOW_ErrorCount,le.name_format_LENGTH_ErrorCount
          ,le.name_org_orig_ALLOW_ErrorCount
          ,le.name_dba_orig_ALLOW_ErrorCount
          ,le.name_mari_org_ALLOW_ErrorCount
          ,le.name_mari_dba_ALLOW_ErrorCount
          ,le.phn_mari_1_ALLOW_ErrorCount,le.phn_mari_1_LENGTH_ErrorCount
          ,le.phn_mari_fax_1_ALLOW_ErrorCount,le.phn_mari_fax_1_LENGTH_ErrorCount
          ,le.phn_mari_2_ALLOW_ErrorCount,le.phn_mari_2_LENGTH_ErrorCount
          ,le.phn_mari_fax_2_ALLOW_ErrorCount,le.phn_mari_fax_2_LENGTH_ErrorCount
          ,le.addr_addr1_1_ALLOW_ErrorCount
          ,le.addr_addr2_1_ALLOW_ErrorCount
          ,le.addr_addr3_1_ALLOW_ErrorCount
          ,le.addr_addr4_1_ALLOW_ErrorCount
          ,le.addr_city_1_ALLOW_ErrorCount
          ,le.addr_state_1_ALLOW_ErrorCount,le.addr_state_1_LENGTH_ErrorCount
          ,le.addr_zip5_1_ALLOW_ErrorCount,le.addr_zip5_1_LENGTH_ErrorCount
          ,le.addr_zip4_1_ALLOW_ErrorCount,le.addr_zip4_1_LENGTH_ErrorCount
          ,le.phn_phone_1_ALLOW_ErrorCount,le.phn_phone_1_LENGTH_ErrorCount
          ,le.phn_fax_1_ALLOW_ErrorCount,le.phn_fax_1_LENGTH_ErrorCount
          ,le.addr_cnty_1_ALLOW_ErrorCount
          ,le.addr_cntry_1_ALLOW_ErrorCount
          ,le.sud_key_1_ALLOW_ErrorCount
          ,le.ooc_ind_1_ALLOW_ErrorCount,le.ooc_ind_1_LENGTH_ErrorCount
          ,le.addr_mail_ind_ALLOW_ErrorCount,le.addr_mail_ind_LENGTH_ErrorCount
          ,le.addr_addr1_2_ALLOW_ErrorCount
          ,le.addr_addr2_2_ALLOW_ErrorCount
          ,le.addr_addr3_2_ALLOW_ErrorCount
          ,le.addr_addr4_2_ALLOW_ErrorCount
          ,le.addr_city_2_ALLOW_ErrorCount
          ,le.addr_state_2_ALLOW_ErrorCount,le.addr_state_2_LENGTH_ErrorCount
          ,le.addr_zip5_2_ALLOW_ErrorCount,le.addr_zip5_2_LENGTH_ErrorCount
          ,le.addr_zip4_2_ALLOW_ErrorCount,le.addr_zip4_2_LENGTH_ErrorCount
          ,le.addr_cnty_2_ALLOW_ErrorCount
          ,le.addr_cntry_2_ALLOW_ErrorCount
          ,le.phn_phone_2_ALLOW_ErrorCount,le.phn_phone_2_LENGTH_ErrorCount
          ,le.phn_fax_2_ALLOW_ErrorCount,le.phn_fax_2_LENGTH_ErrorCount
          ,le.sud_key_2_ALLOW_ErrorCount
          ,le.ooc_ind_2_ALLOW_ErrorCount,le.ooc_ind_2_LENGTH_ErrorCount
          ,le.license_nbr_contact_ALLOW_ErrorCount
          ,le.name_contact_prefx_ALLOW_ErrorCount
          ,le.name_contact_first_ALLOW_ErrorCount
          ,le.name_contact_mid_ALLOW_ErrorCount
          ,le.name_contact_last_ALLOW_ErrorCount
          ,le.name_contact_sufx_ALLOW_ErrorCount
          ,le.name_contact_nick_ALLOW_ErrorCount
          ,le.name_contact_ttl_ALLOW_ErrorCount
          ,le.phn_contact_ALLOW_ErrorCount,le.phn_contact_LENGTH_ErrorCount
          ,le.phn_contact_ext_ALLOW_ErrorCount,le.phn_contact_ext_LENGTH_ErrorCount
          ,le.phn_contact_fax_ALLOW_ErrorCount,le.phn_contact_fax_LENGTH_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.url_ALLOW_ErrorCount
          ,le.bk_class_ALLOW_ErrorCount,le.bk_class_LENGTH_ErrorCount
          ,le.bk_class_desc_ALLOW_ErrorCount
          ,le.charter_ALLOW_ErrorCount
          ,le.inst_beg_dte_ALLOW_ErrorCount,le.inst_beg_dte_LENGTH_ErrorCount
          ,le.origin_cd_ALLOW_ErrorCount,le.origin_cd_LENGTH_ErrorCount
          ,le.origin_cd_desc_ALLOW_ErrorCount
          ,le.disp_type_cd_ALLOW_ErrorCount,le.disp_type_cd_LENGTH_ErrorCount
          ,le.disp_type_desc_ALLOW_ErrorCount
          ,le.reg_agent_ENUM_ErrorCount
          ,le.regulator_ALLOW_ErrorCount
          ,le.hqtr_city_ALLOW_ErrorCount
          ,le.hqtr_name_ALLOW_ErrorCount
          ,le.domestic_off_nbr_ALLOW_ErrorCount
          ,le.foreign_off_nbr_ALLOW_ErrorCount
          ,le.hcr_rssd_ALLOW_ErrorCount
          ,le.hcr_location_ALLOW_ErrorCount,le.hcr_location_LENGTH_ErrorCount
          ,le.affil_type_cd_ENUM_ErrorCount,le.affil_type_cd_LENGTH_ErrorCount
          ,le.genlink_ALLOW_ErrorCount,le.genlink_LENGTH_ErrorCount
          ,le.research_ind_ALLOW_ErrorCount,le.research_ind_LENGTH_ErrorCount
          ,le.docket_id_ALLOW_ErrorCount
          ,le.mltreckey_ALLOW_ErrorCount
          ,le.cmc_slpk_ALLOW_ErrorCount
          ,le.pcmc_slpk_ALLOW_ErrorCount
          ,le.affil_key_ALLOW_ErrorCount
          ,le.action_taken_ind_LENGTH_ErrorCount
          ,le.viol_type_LENGTH_ErrorCount
          ,le.viol_cd_LENGTH_ErrorCount
          ,le.viol_desc_ALLOW_ErrorCount
          ,le.viol_dte_ALLOW_ErrorCount,le.viol_dte_LENGTH_ErrorCount
          ,le.viol_case_nbr_LENGTH_ErrorCount
          ,le.viol_eff_dte_LENGTH_ErrorCount
          ,le.action_final_nbr_LENGTH_ErrorCount
          ,le.action_status_LENGTH_ErrorCount
          ,le.action_status_dte_LENGTH_ErrorCount
          ,le.action_file_name_LENGTH_ErrorCount
          ,le.occupation_LENGTH_ErrorCount
          ,le.practice_hrs_LENGTH_ErrorCount
          ,le.practice_type_LENGTH_ErrorCount
          ,le.misc_other_id_ALLOW_ErrorCount
          ,le.misc_other_type_ENUM_ErrorCount
          ,le.cont_education_ernd_ALLOW_ErrorCount
          ,le.cont_education_req_ALLOW_ErrorCount
          ,le.cont_education_term_ALLOW_ErrorCount
          ,le.schl_attend_1_LENGTH_ErrorCount
          ,le.schl_attend_dte_1_LENGTH_ErrorCount
          ,le.schl_curriculum_1_LENGTH_ErrorCount
          ,le.schl_degree_1_LENGTH_ErrorCount
          ,le.schl_attend_2_LENGTH_ErrorCount
          ,le.schl_attend_dte_2_LENGTH_ErrorCount
          ,le.schl_curriculum_2_LENGTH_ErrorCount
          ,le.schl_degree_2_LENGTH_ErrorCount
          ,le.schl_attend_3_LENGTH_ErrorCount
          ,le.schl_attend_dte_3_LENGTH_ErrorCount
          ,le.schl_curriculum_3_LENGTH_ErrorCount
          ,le.schl_degree_3_LENGTH_ErrorCount
          ,le.addl_license_spec_ALLOW_ErrorCount
          ,le.place_birth_cd_LENGTH_ErrorCount
          ,le.place_birth_desc_LENGTH_ErrorCount
          ,le.race_cd_ALLOW_ErrorCount,le.race_cd_LENGTH_ErrorCount
          ,le.std_race_cd_ENUM_ErrorCount
          ,le.race_desc_LENGTH_ErrorCount
          ,le.status_effect_dte_ALLOW_ErrorCount,le.status_effect_dte_LENGTH_ErrorCount
          ,le.status_renew_desc_LENGTH_ErrorCount
          ,le.agency_status_ENUM_ErrorCount
          ,le.prev_primary_key_ALLOW_ErrorCount
          ,le.prev_mltreckey_ALLOW_ErrorCount
          ,le.prev_cmc_slpk_ALLOW_ErrorCount
          ,le.prev_pcmc_slpk_ALLOW_ErrorCount
          ,le.license_id_ALLOW_ErrorCount
          ,le.nmls_id_ALLOW_ErrorCount
          ,le.foreign_nmls_id_ALLOW_ErrorCount
          ,le.location_type_ENUM_ErrorCount
          ,le.off_license_nbr_type_ALLOW_ErrorCount
          ,le.brkr_license_nbr_ALLOW_ErrorCount
          ,le.brkr_license_nbr_type_ALLOW_ErrorCount
          ,le.agency_id_ALLOW_ErrorCount
          ,le.site_location_ALLOW_ErrorCount
          ,le.business_type_ALLOW_ErrorCount
          ,le.start_dte_ALLOW_ErrorCount,le.start_dte_LENGTH_ErrorCount
          ,le.is_authorized_license_ENUM_ErrorCount
          ,le.is_authorized_conduct_ENUM_ErrorCount
          ,le.federal_regulator_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.primary_key_ALLOW_ErrorCount
          ,le.create_dte_ALLOW_ErrorCount,le.create_dte_LENGTH_ErrorCount
          ,le.last_upd_dte_ALLOW_ErrorCount,le.last_upd_dte_LENGTH_ErrorCount
          ,le.stamp_dte_ALLOW_ErrorCount,le.stamp_dte_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.gen_nbr_ALLOW_ErrorCount,le.gen_nbr_LENGTH_ErrorCount
          ,le.std_prof_desc_ENUM_ErrorCount
          ,le.std_source_upd_ALLOW_ErrorCount,le.std_source_upd_LENGTH_ErrorCount
          ,le.std_source_desc_ALLOW_ErrorCount,le.std_source_desc_LENGTH_ErrorCount
          ,le.type_cd_ENUM_ErrorCount,le.type_cd_LENGTH_ErrorCount
          ,le.name_org_prefx_ALLOW_ErrorCount,le.name_org_prefx_LENGTH_ErrorCount
          ,le.name_org_ALLOW_ErrorCount
          ,le.name_org_sufx_ALLOW_ErrorCount,le.name_org_sufx_LENGTH_ErrorCount
          ,le.store_nbr_ALLOW_ErrorCount,le.store_nbr_LENGTH_ErrorCount
          ,le.name_dba_prefx_ALLOW_ErrorCount,le.name_dba_prefx_LENGTH_ErrorCount
          ,le.name_dba_ALLOW_ErrorCount
          ,le.name_dba_sufx_ALLOW_ErrorCount,le.name_dba_sufx_LENGTH_ErrorCount
          ,le.store_nbr_dba_ALLOW_ErrorCount,le.store_nbr_dba_LENGTH_ErrorCount
          ,le.dba_flag_ALLOW_ErrorCount
          ,le.name_office_ALLOW_ErrorCount,le.name_office_LENGTH_ErrorCount
          ,le.office_parse_ENUM_ErrorCount,le.office_parse_LENGTH_ErrorCount
          ,le.name_prefx_ALLOW_ErrorCount
          ,le.name_first_ALLOW_ErrorCount
          ,le.name_mid_ALLOW_ErrorCount
          ,le.name_last_ALLOW_ErrorCount
          ,le.name_sufx_ALLOW_ErrorCount
          ,le.name_nick_ALLOW_ErrorCount
          ,le.birth_dte_ALLOW_ErrorCount,le.birth_dte_LENGTH_ErrorCount
          ,le.gender_ENUM_ErrorCount,le.gender_LENGTH_ErrorCount
          ,le.prov_stat_ENUM_ErrorCount,le.prov_stat_LENGTH_ErrorCount
          ,le.credential_ALLOW_ErrorCount,le.credential_LENGTH_ErrorCount
          ,le.license_nbr_ALLOW_ErrorCount
          ,le.off_license_nbr_ALLOW_ErrorCount
          ,le.prev_license_nbr_LENGTH_ErrorCount
          ,le.prev_license_type_LENGTH_ErrorCount
          ,le.license_state_ALLOW_ErrorCount,le.license_state_LENGTH_ErrorCount
          ,le.raw_license_type_ALLOW_ErrorCount
          ,le.raw_license_status_ALLOW_ErrorCount
          ,le.std_status_desc_ALLOW_ErrorCount
          ,le.curr_issue_dte_ALLOW_ErrorCount,le.curr_issue_dte_LENGTH_ErrorCount
          ,le.orig_issue_dte_ALLOW_ErrorCount,le.orig_issue_dte_LENGTH_ErrorCount
          ,le.expire_dte_ALLOW_ErrorCount,le.expire_dte_LENGTH_ErrorCount
          ,le.renewal_dte_ALLOW_ErrorCount
          ,le.active_flag_ALLOW_ErrorCount,le.active_flag_LENGTH_ErrorCount
          ,le.ssn_taxid_1_ALLOW_ErrorCount,le.ssn_taxid_1_LENGTH_ErrorCount
          ,le.tax_type_1_ALLOW_ErrorCount,le.tax_type_1_LENGTH_ErrorCount
          ,le.ssn_taxid_2_LENGTH_ErrorCount
          ,le.tax_type_2_LENGTH_ErrorCount
          ,le.fed_rssd_ALLOW_ErrorCount,le.fed_rssd_LENGTH_ErrorCount
          ,le.addr_bus_ind_ALLOW_ErrorCount,le.addr_bus_ind_LENGTH_ErrorCount
          ,le.name_format_ALLOW_ErrorCount,le.name_format_LENGTH_ErrorCount
          ,le.name_org_orig_ALLOW_ErrorCount
          ,le.name_dba_orig_ALLOW_ErrorCount
          ,le.name_mari_org_ALLOW_ErrorCount
          ,le.name_mari_dba_ALLOW_ErrorCount
          ,le.phn_mari_1_ALLOW_ErrorCount,le.phn_mari_1_LENGTH_ErrorCount
          ,le.phn_mari_fax_1_ALLOW_ErrorCount,le.phn_mari_fax_1_LENGTH_ErrorCount
          ,le.phn_mari_2_ALLOW_ErrorCount,le.phn_mari_2_LENGTH_ErrorCount
          ,le.phn_mari_fax_2_ALLOW_ErrorCount,le.phn_mari_fax_2_LENGTH_ErrorCount
          ,le.addr_addr1_1_ALLOW_ErrorCount
          ,le.addr_addr2_1_ALLOW_ErrorCount
          ,le.addr_addr3_1_ALLOW_ErrorCount
          ,le.addr_addr4_1_ALLOW_ErrorCount
          ,le.addr_city_1_ALLOW_ErrorCount
          ,le.addr_state_1_ALLOW_ErrorCount,le.addr_state_1_LENGTH_ErrorCount
          ,le.addr_zip5_1_ALLOW_ErrorCount,le.addr_zip5_1_LENGTH_ErrorCount
          ,le.addr_zip4_1_ALLOW_ErrorCount,le.addr_zip4_1_LENGTH_ErrorCount
          ,le.phn_phone_1_ALLOW_ErrorCount,le.phn_phone_1_LENGTH_ErrorCount
          ,le.phn_fax_1_ALLOW_ErrorCount,le.phn_fax_1_LENGTH_ErrorCount
          ,le.addr_cnty_1_ALLOW_ErrorCount
          ,le.addr_cntry_1_ALLOW_ErrorCount
          ,le.sud_key_1_ALLOW_ErrorCount
          ,le.ooc_ind_1_ALLOW_ErrorCount,le.ooc_ind_1_LENGTH_ErrorCount
          ,le.addr_mail_ind_ALLOW_ErrorCount,le.addr_mail_ind_LENGTH_ErrorCount
          ,le.addr_addr1_2_ALLOW_ErrorCount
          ,le.addr_addr2_2_ALLOW_ErrorCount
          ,le.addr_addr3_2_ALLOW_ErrorCount
          ,le.addr_addr4_2_ALLOW_ErrorCount
          ,le.addr_city_2_ALLOW_ErrorCount
          ,le.addr_state_2_ALLOW_ErrorCount,le.addr_state_2_LENGTH_ErrorCount
          ,le.addr_zip5_2_ALLOW_ErrorCount,le.addr_zip5_2_LENGTH_ErrorCount
          ,le.addr_zip4_2_ALLOW_ErrorCount,le.addr_zip4_2_LENGTH_ErrorCount
          ,le.addr_cnty_2_ALLOW_ErrorCount
          ,le.addr_cntry_2_ALLOW_ErrorCount
          ,le.phn_phone_2_ALLOW_ErrorCount,le.phn_phone_2_LENGTH_ErrorCount
          ,le.phn_fax_2_ALLOW_ErrorCount,le.phn_fax_2_LENGTH_ErrorCount
          ,le.sud_key_2_ALLOW_ErrorCount
          ,le.ooc_ind_2_ALLOW_ErrorCount,le.ooc_ind_2_LENGTH_ErrorCount
          ,le.license_nbr_contact_ALLOW_ErrorCount
          ,le.name_contact_prefx_ALLOW_ErrorCount
          ,le.name_contact_first_ALLOW_ErrorCount
          ,le.name_contact_mid_ALLOW_ErrorCount
          ,le.name_contact_last_ALLOW_ErrorCount
          ,le.name_contact_sufx_ALLOW_ErrorCount
          ,le.name_contact_nick_ALLOW_ErrorCount
          ,le.name_contact_ttl_ALLOW_ErrorCount
          ,le.phn_contact_ALLOW_ErrorCount,le.phn_contact_LENGTH_ErrorCount
          ,le.phn_contact_ext_ALLOW_ErrorCount,le.phn_contact_ext_LENGTH_ErrorCount
          ,le.phn_contact_fax_ALLOW_ErrorCount,le.phn_contact_fax_LENGTH_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.url_ALLOW_ErrorCount
          ,le.bk_class_ALLOW_ErrorCount,le.bk_class_LENGTH_ErrorCount
          ,le.bk_class_desc_ALLOW_ErrorCount
          ,le.charter_ALLOW_ErrorCount
          ,le.inst_beg_dte_ALLOW_ErrorCount,le.inst_beg_dte_LENGTH_ErrorCount
          ,le.origin_cd_ALLOW_ErrorCount,le.origin_cd_LENGTH_ErrorCount
          ,le.origin_cd_desc_ALLOW_ErrorCount
          ,le.disp_type_cd_ALLOW_ErrorCount,le.disp_type_cd_LENGTH_ErrorCount
          ,le.disp_type_desc_ALLOW_ErrorCount
          ,le.reg_agent_ENUM_ErrorCount
          ,le.regulator_ALLOW_ErrorCount
          ,le.hqtr_city_ALLOW_ErrorCount
          ,le.hqtr_name_ALLOW_ErrorCount
          ,le.domestic_off_nbr_ALLOW_ErrorCount
          ,le.foreign_off_nbr_ALLOW_ErrorCount
          ,le.hcr_rssd_ALLOW_ErrorCount
          ,le.hcr_location_ALLOW_ErrorCount,le.hcr_location_LENGTH_ErrorCount
          ,le.affil_type_cd_ENUM_ErrorCount,le.affil_type_cd_LENGTH_ErrorCount
          ,le.genlink_ALLOW_ErrorCount,le.genlink_LENGTH_ErrorCount
          ,le.research_ind_ALLOW_ErrorCount,le.research_ind_LENGTH_ErrorCount
          ,le.docket_id_ALLOW_ErrorCount
          ,le.mltreckey_ALLOW_ErrorCount
          ,le.cmc_slpk_ALLOW_ErrorCount
          ,le.pcmc_slpk_ALLOW_ErrorCount
          ,le.affil_key_ALLOW_ErrorCount
          ,le.action_taken_ind_LENGTH_ErrorCount
          ,le.viol_type_LENGTH_ErrorCount
          ,le.viol_cd_LENGTH_ErrorCount
          ,le.viol_desc_ALLOW_ErrorCount
          ,le.viol_dte_ALLOW_ErrorCount,le.viol_dte_LENGTH_ErrorCount
          ,le.viol_case_nbr_LENGTH_ErrorCount
          ,le.viol_eff_dte_LENGTH_ErrorCount
          ,le.action_final_nbr_LENGTH_ErrorCount
          ,le.action_status_LENGTH_ErrorCount
          ,le.action_status_dte_LENGTH_ErrorCount
          ,le.action_file_name_LENGTH_ErrorCount
          ,le.occupation_LENGTH_ErrorCount
          ,le.practice_hrs_LENGTH_ErrorCount
          ,le.practice_type_LENGTH_ErrorCount
          ,le.misc_other_id_ALLOW_ErrorCount
          ,le.misc_other_type_ENUM_ErrorCount
          ,le.cont_education_ernd_ALLOW_ErrorCount
          ,le.cont_education_req_ALLOW_ErrorCount
          ,le.cont_education_term_ALLOW_ErrorCount
          ,le.schl_attend_1_LENGTH_ErrorCount
          ,le.schl_attend_dte_1_LENGTH_ErrorCount
          ,le.schl_curriculum_1_LENGTH_ErrorCount
          ,le.schl_degree_1_LENGTH_ErrorCount
          ,le.schl_attend_2_LENGTH_ErrorCount
          ,le.schl_attend_dte_2_LENGTH_ErrorCount
          ,le.schl_curriculum_2_LENGTH_ErrorCount
          ,le.schl_degree_2_LENGTH_ErrorCount
          ,le.schl_attend_3_LENGTH_ErrorCount
          ,le.schl_attend_dte_3_LENGTH_ErrorCount
          ,le.schl_curriculum_3_LENGTH_ErrorCount
          ,le.schl_degree_3_LENGTH_ErrorCount
          ,le.addl_license_spec_ALLOW_ErrorCount
          ,le.place_birth_cd_LENGTH_ErrorCount
          ,le.place_birth_desc_LENGTH_ErrorCount
          ,le.race_cd_ALLOW_ErrorCount,le.race_cd_LENGTH_ErrorCount
          ,le.std_race_cd_ENUM_ErrorCount
          ,le.race_desc_LENGTH_ErrorCount
          ,le.status_effect_dte_ALLOW_ErrorCount,le.status_effect_dte_LENGTH_ErrorCount
          ,le.status_renew_desc_LENGTH_ErrorCount
          ,le.agency_status_ENUM_ErrorCount
          ,le.prev_primary_key_ALLOW_ErrorCount
          ,le.prev_mltreckey_ALLOW_ErrorCount
          ,le.prev_cmc_slpk_ALLOW_ErrorCount
          ,le.prev_pcmc_slpk_ALLOW_ErrorCount
          ,le.license_id_ALLOW_ErrorCount
          ,le.nmls_id_ALLOW_ErrorCount
          ,le.foreign_nmls_id_ALLOW_ErrorCount
          ,le.location_type_ENUM_ErrorCount
          ,le.off_license_nbr_type_ALLOW_ErrorCount
          ,le.brkr_license_nbr_ALLOW_ErrorCount
          ,le.brkr_license_nbr_type_ALLOW_ErrorCount
          ,le.agency_id_ALLOW_ErrorCount
          ,le.site_location_ALLOW_ErrorCount
          ,le.business_type_ALLOW_ErrorCount
          ,le.start_dte_ALLOW_ErrorCount,le.start_dte_LENGTH_ErrorCount
          ,le.is_authorized_license_ENUM_ErrorCount
          ,le.is_authorized_conduct_ENUM_ErrorCount
          ,le.federal_regulator_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,253,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT31.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT31.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF.ErrorMessage := ri.ErrorMessage;
   SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
