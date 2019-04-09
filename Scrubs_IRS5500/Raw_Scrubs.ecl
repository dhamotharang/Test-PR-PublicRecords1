IMPORT SALT311,STD;
IMPORT Scrubs_IRS5500; // Import modules for FieldTypes attribute definitions
EXPORT Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 96;
  EXPORT NumRulesFromFieldType := 96;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 96;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Raw_Layout_IRS5500)
    UNSIGNED1 ack_id_Invalid;
    UNSIGNED1 form_plan_year_begin_date_Invalid;
    UNSIGNED1 form_tax_prd_Invalid;
    UNSIGNED1 type_plan_entity_cd_Invalid;
    UNSIGNED1 type_dfe_plan_entity_cd_Invalid;
    UNSIGNED1 initial_filing_ind_Invalid;
    UNSIGNED1 amended_ind_Invalid;
    UNSIGNED1 final_filing_ind_Invalid;
    UNSIGNED1 short_plan_yr_ind_Invalid;
    UNSIGNED1 collective_bargain_ind_Invalid;
    UNSIGNED1 f5558_application_filed_ind_Invalid;
    UNSIGNED1 ext_automatic_ind_Invalid;
    UNSIGNED1 dfvc_program_ind_Invalid;
    UNSIGNED1 ext_special_ind_Invalid;
    UNSIGNED1 plan_name_Invalid;
    UNSIGNED1 spons_dfe_pn_Invalid;
    UNSIGNED1 plan_eff_date_Invalid;
    UNSIGNED1 sponsor_dfe_name_Invalid;
    UNSIGNED1 spons_dfe_dba_name_Invalid;
    UNSIGNED1 spons_dfe_care_of_name_Invalid;
    UNSIGNED1 spons_dfe_mail_us_address1_Invalid;
    UNSIGNED1 spons_dfe_mail_us_city_Invalid;
    UNSIGNED1 spons_dfe_mail_us_state_Invalid;
    UNSIGNED1 spons_dfe_mail_us_zip_Invalid;
    UNSIGNED1 spons_dfe_mail_foreign_addr1_Invalid;
    UNSIGNED1 spons_dfe_mail_foreign_city_Invalid;
    UNSIGNED1 spons_dfe_mail_forgn_prov_st_Invalid;
    UNSIGNED1 spons_dfe_mail_foreign_cntry_Invalid;
    UNSIGNED1 spons_dfe_mail_forgn_postal_cd_Invalid;
    UNSIGNED1 spons_dfe_loc_us_address1_Invalid;
    UNSIGNED1 spons_dfe_loc_us_city_Invalid;
    UNSIGNED1 spons_dfe_loc_us_state_Invalid;
    UNSIGNED1 spons_dfe_loc_us_zip_Invalid;
    UNSIGNED1 spons_dfe_loc_foreign_address1_Invalid;
    UNSIGNED1 spons_dfe_loc_foreign_city_Invalid;
    UNSIGNED1 spons_dfe_loc_forgn_prov_st_Invalid;
    UNSIGNED1 spons_dfe_loc_foreign_cntry_Invalid;
    UNSIGNED1 spons_dfe_loc_forgn_postal_cd_Invalid;
    UNSIGNED1 spons_dfe_phone_num_Invalid;
    UNSIGNED1 business_code_Invalid;
    UNSIGNED1 admin_name_Invalid;
    UNSIGNED1 admin_care_of_name_Invalid;
    UNSIGNED1 admin_us_address1_Invalid;
    UNSIGNED1 admin_us_city_Invalid;
    UNSIGNED1 admin_us_state_Invalid;
    UNSIGNED1 admin_us_zip_Invalid;
    UNSIGNED1 admin_foreign_address1_Invalid;
    UNSIGNED1 admin_foreign_city_Invalid;
    UNSIGNED1 admin_foreign_prov_state_Invalid;
    UNSIGNED1 admin_foreign_cntry_Invalid;
    UNSIGNED1 admin_foreign_postal_cd_Invalid;
    UNSIGNED1 admin_ein_Invalid;
    UNSIGNED1 admin_phone_num_Invalid;
    UNSIGNED1 last_rpt_spons_name_Invalid;
    UNSIGNED1 last_rpt_spons_ein_Invalid;
    UNSIGNED1 last_rpt_plan_num_Invalid;
    UNSIGNED1 admin_signed_date_Invalid;
    UNSIGNED1 admin_signed_name_Invalid;
    UNSIGNED1 spons_signed_date_Invalid;
    UNSIGNED1 spons_signed_name_Invalid;
    UNSIGNED1 dfe_signed_date_Invalid;
    UNSIGNED1 dfe_signed_name_Invalid;
    UNSIGNED1 tot_partcp_boy_cnt_Invalid;
    UNSIGNED1 tot_active_partcp_cnt_Invalid;
    UNSIGNED1 rtd_sep_partcp_rcvg_cnt_Invalid;
    UNSIGNED1 rtd_sep_partcp_fut_cnt_Invalid;
    UNSIGNED1 subtl_act_rtd_sep_cnt_Invalid;
    UNSIGNED1 benef_rcvg_bnft_cnt_Invalid;
    UNSIGNED1 tot_act_rtd_sep_benef_cnt_Invalid;
    UNSIGNED1 partcp_account_bal_cnt_Invalid;
    UNSIGNED1 sep_partcp_partl_vstd_cnt_Invalid;
    UNSIGNED1 contrib_emplrs_cnt_Invalid;
    UNSIGNED1 type_pension_bnft_code_Invalid;
    UNSIGNED1 type_welfare_bnft_code_Invalid;
    UNSIGNED1 funding_insurance_ind_Invalid;
    UNSIGNED1 funding_sec412_ind_Invalid;
    UNSIGNED1 funding_trust_ind_Invalid;
    UNSIGNED1 funding_gen_asset_ind_Invalid;
    UNSIGNED1 benefit_insurance_ind_Invalid;
    UNSIGNED1 benefit_sec412_ind_Invalid;
    UNSIGNED1 benefit_trust_ind_Invalid;
    UNSIGNED1 benefit_gen_asset_ind_Invalid;
    UNSIGNED1 sch_r_attached_ind_Invalid;
    UNSIGNED1 sch_mb_attached_ind_Invalid;
    UNSIGNED1 sch_sb_attached_ind_Invalid;
    UNSIGNED1 sch_h_attached_ind_Invalid;
    UNSIGNED1 sch_i_attached_ind_Invalid;
    UNSIGNED1 sch_a_attached_ind_Invalid;
    UNSIGNED1 num_sch_a_attached_cnt_Invalid;
    UNSIGNED1 sch_c_attached_ind_Invalid;
    UNSIGNED1 sch_d_attached_ind_Invalid;
    UNSIGNED1 sch_g_attached_ind_Invalid;
    UNSIGNED1 filing_status_Invalid;
    UNSIGNED1 date_received_Invalid;
    UNSIGNED1 admin_phone_num_foreign_Invalid;
    UNSIGNED1 spons_dfe_phone_num_foreign_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Raw_Layout_IRS5500)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Raw_Layout_IRS5500) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ack_id_Invalid := Raw_Fields.InValid_ack_id((SALT311.StrType)le.ack_id);
    SELF.form_plan_year_begin_date_Invalid := Raw_Fields.InValid_form_plan_year_begin_date((SALT311.StrType)le.form_plan_year_begin_date);
    SELF.form_tax_prd_Invalid := Raw_Fields.InValid_form_tax_prd((SALT311.StrType)le.form_tax_prd);
    SELF.type_plan_entity_cd_Invalid := Raw_Fields.InValid_type_plan_entity_cd((SALT311.StrType)le.type_plan_entity_cd);
    SELF.type_dfe_plan_entity_cd_Invalid := Raw_Fields.InValid_type_dfe_plan_entity_cd((SALT311.StrType)le.type_dfe_plan_entity_cd);
    SELF.initial_filing_ind_Invalid := Raw_Fields.InValid_initial_filing_ind((SALT311.StrType)le.initial_filing_ind);
    SELF.amended_ind_Invalid := Raw_Fields.InValid_amended_ind((SALT311.StrType)le.amended_ind);
    SELF.final_filing_ind_Invalid := Raw_Fields.InValid_final_filing_ind((SALT311.StrType)le.final_filing_ind);
    SELF.short_plan_yr_ind_Invalid := Raw_Fields.InValid_short_plan_yr_ind((SALT311.StrType)le.short_plan_yr_ind);
    SELF.collective_bargain_ind_Invalid := Raw_Fields.InValid_collective_bargain_ind((SALT311.StrType)le.collective_bargain_ind);
    SELF.f5558_application_filed_ind_Invalid := Raw_Fields.InValid_f5558_application_filed_ind((SALT311.StrType)le.f5558_application_filed_ind);
    SELF.ext_automatic_ind_Invalid := Raw_Fields.InValid_ext_automatic_ind((SALT311.StrType)le.ext_automatic_ind);
    SELF.dfvc_program_ind_Invalid := Raw_Fields.InValid_dfvc_program_ind((SALT311.StrType)le.dfvc_program_ind);
    SELF.ext_special_ind_Invalid := Raw_Fields.InValid_ext_special_ind((SALT311.StrType)le.ext_special_ind);
    SELF.plan_name_Invalid := Raw_Fields.InValid_plan_name((SALT311.StrType)le.plan_name);
    SELF.spons_dfe_pn_Invalid := Raw_Fields.InValid_spons_dfe_pn((SALT311.StrType)le.spons_dfe_pn);
    SELF.plan_eff_date_Invalid := Raw_Fields.InValid_plan_eff_date((SALT311.StrType)le.plan_eff_date);
    SELF.sponsor_dfe_name_Invalid := Raw_Fields.InValid_sponsor_dfe_name((SALT311.StrType)le.sponsor_dfe_name);
    SELF.spons_dfe_dba_name_Invalid := Raw_Fields.InValid_spons_dfe_dba_name((SALT311.StrType)le.spons_dfe_dba_name);
    SELF.spons_dfe_care_of_name_Invalid := Raw_Fields.InValid_spons_dfe_care_of_name((SALT311.StrType)le.spons_dfe_care_of_name);
    SELF.spons_dfe_mail_us_address1_Invalid := Raw_Fields.InValid_spons_dfe_mail_us_address1((SALT311.StrType)le.spons_dfe_mail_us_address1,(SALT311.StrType)le.spons_dfe_mail_us_address2);
    SELF.spons_dfe_mail_us_city_Invalid := Raw_Fields.InValid_spons_dfe_mail_us_city((SALT311.StrType)le.spons_dfe_mail_us_city);
    SELF.spons_dfe_mail_us_state_Invalid := Raw_Fields.InValid_spons_dfe_mail_us_state((SALT311.StrType)le.spons_dfe_mail_us_state);
    SELF.spons_dfe_mail_us_zip_Invalid := Raw_Fields.InValid_spons_dfe_mail_us_zip((SALT311.StrType)le.spons_dfe_mail_us_zip);
    SELF.spons_dfe_mail_foreign_addr1_Invalid := Raw_Fields.InValid_spons_dfe_mail_foreign_addr1((SALT311.StrType)le.spons_dfe_mail_foreign_addr1,(SALT311.StrType)le.spons_dfe_mail_foreign_addr2);
    SELF.spons_dfe_mail_foreign_city_Invalid := Raw_Fields.InValid_spons_dfe_mail_foreign_city((SALT311.StrType)le.spons_dfe_mail_foreign_city);
    SELF.spons_dfe_mail_forgn_prov_st_Invalid := Raw_Fields.InValid_spons_dfe_mail_forgn_prov_st((SALT311.StrType)le.spons_dfe_mail_forgn_prov_st);
    SELF.spons_dfe_mail_foreign_cntry_Invalid := Raw_Fields.InValid_spons_dfe_mail_foreign_cntry((SALT311.StrType)le.spons_dfe_mail_foreign_cntry);
    SELF.spons_dfe_mail_forgn_postal_cd_Invalid := Raw_Fields.InValid_spons_dfe_mail_forgn_postal_cd((SALT311.StrType)le.spons_dfe_mail_forgn_postal_cd);
    SELF.spons_dfe_loc_us_address1_Invalid := Raw_Fields.InValid_spons_dfe_loc_us_address1((SALT311.StrType)le.spons_dfe_loc_us_address1,(SALT311.StrType)le.spons_dfe_loc_us_address2);
    SELF.spons_dfe_loc_us_city_Invalid := Raw_Fields.InValid_spons_dfe_loc_us_city((SALT311.StrType)le.spons_dfe_loc_us_city);
    SELF.spons_dfe_loc_us_state_Invalid := Raw_Fields.InValid_spons_dfe_loc_us_state((SALT311.StrType)le.spons_dfe_loc_us_state);
    SELF.spons_dfe_loc_us_zip_Invalid := Raw_Fields.InValid_spons_dfe_loc_us_zip((SALT311.StrType)le.spons_dfe_loc_us_zip);
    SELF.spons_dfe_loc_foreign_address1_Invalid := Raw_Fields.InValid_spons_dfe_loc_foreign_address1((SALT311.StrType)le.spons_dfe_loc_foreign_address1,(SALT311.StrType)le.spons_dfe_loc_foreign_address2);
    SELF.spons_dfe_loc_foreign_city_Invalid := Raw_Fields.InValid_spons_dfe_loc_foreign_city((SALT311.StrType)le.spons_dfe_loc_foreign_city);
    SELF.spons_dfe_loc_forgn_prov_st_Invalid := Raw_Fields.InValid_spons_dfe_loc_forgn_prov_st((SALT311.StrType)le.spons_dfe_loc_forgn_prov_st);
    SELF.spons_dfe_loc_foreign_cntry_Invalid := Raw_Fields.InValid_spons_dfe_loc_foreign_cntry((SALT311.StrType)le.spons_dfe_loc_foreign_cntry);
    SELF.spons_dfe_loc_forgn_postal_cd_Invalid := Raw_Fields.InValid_spons_dfe_loc_forgn_postal_cd((SALT311.StrType)le.spons_dfe_loc_forgn_postal_cd);
    SELF.spons_dfe_phone_num_Invalid := Raw_Fields.InValid_spons_dfe_phone_num((SALT311.StrType)le.spons_dfe_phone_num);
    SELF.business_code_Invalid := Raw_Fields.InValid_business_code((SALT311.StrType)le.business_code);
    SELF.admin_name_Invalid := Raw_Fields.InValid_admin_name((SALT311.StrType)le.admin_name);
    SELF.admin_care_of_name_Invalid := Raw_Fields.InValid_admin_care_of_name((SALT311.StrType)le.admin_care_of_name);
    SELF.admin_us_address1_Invalid := Raw_Fields.InValid_admin_us_address1((SALT311.StrType)le.admin_us_address1,(SALT311.StrType)le.admin_us_address2);
    SELF.admin_us_city_Invalid := Raw_Fields.InValid_admin_us_city((SALT311.StrType)le.admin_us_city);
    SELF.admin_us_state_Invalid := Raw_Fields.InValid_admin_us_state((SALT311.StrType)le.admin_us_state);
    SELF.admin_us_zip_Invalid := Raw_Fields.InValid_admin_us_zip((SALT311.StrType)le.admin_us_zip);
    SELF.admin_foreign_address1_Invalid := Raw_Fields.InValid_admin_foreign_address1((SALT311.StrType)le.admin_foreign_address1,(SALT311.StrType)le.admin_foreign_address2);
    SELF.admin_foreign_city_Invalid := Raw_Fields.InValid_admin_foreign_city((SALT311.StrType)le.admin_foreign_city);
    SELF.admin_foreign_prov_state_Invalid := Raw_Fields.InValid_admin_foreign_prov_state((SALT311.StrType)le.admin_foreign_prov_state);
    SELF.admin_foreign_cntry_Invalid := Raw_Fields.InValid_admin_foreign_cntry((SALT311.StrType)le.admin_foreign_cntry);
    SELF.admin_foreign_postal_cd_Invalid := Raw_Fields.InValid_admin_foreign_postal_cd((SALT311.StrType)le.admin_foreign_postal_cd);
    SELF.admin_ein_Invalid := Raw_Fields.InValid_admin_ein((SALT311.StrType)le.admin_ein);
    SELF.admin_phone_num_Invalid := Raw_Fields.InValid_admin_phone_num((SALT311.StrType)le.admin_phone_num);
    SELF.last_rpt_spons_name_Invalid := Raw_Fields.InValid_last_rpt_spons_name((SALT311.StrType)le.last_rpt_spons_name);
    SELF.last_rpt_spons_ein_Invalid := Raw_Fields.InValid_last_rpt_spons_ein((SALT311.StrType)le.last_rpt_spons_ein);
    SELF.last_rpt_plan_num_Invalid := Raw_Fields.InValid_last_rpt_plan_num((SALT311.StrType)le.last_rpt_plan_num);
    SELF.admin_signed_date_Invalid := Raw_Fields.InValid_admin_signed_date((SALT311.StrType)le.admin_signed_date);
    SELF.admin_signed_name_Invalid := Raw_Fields.InValid_admin_signed_name((SALT311.StrType)le.admin_signed_name);
    SELF.spons_signed_date_Invalid := Raw_Fields.InValid_spons_signed_date((SALT311.StrType)le.spons_signed_date);
    SELF.spons_signed_name_Invalid := Raw_Fields.InValid_spons_signed_name((SALT311.StrType)le.spons_signed_name);
    SELF.dfe_signed_date_Invalid := Raw_Fields.InValid_dfe_signed_date((SALT311.StrType)le.dfe_signed_date);
    SELF.dfe_signed_name_Invalid := Raw_Fields.InValid_dfe_signed_name((SALT311.StrType)le.dfe_signed_name);
    SELF.tot_partcp_boy_cnt_Invalid := Raw_Fields.InValid_tot_partcp_boy_cnt((SALT311.StrType)le.tot_partcp_boy_cnt);
    SELF.tot_active_partcp_cnt_Invalid := Raw_Fields.InValid_tot_active_partcp_cnt((SALT311.StrType)le.tot_active_partcp_cnt);
    SELF.rtd_sep_partcp_rcvg_cnt_Invalid := Raw_Fields.InValid_rtd_sep_partcp_rcvg_cnt((SALT311.StrType)le.rtd_sep_partcp_rcvg_cnt);
    SELF.rtd_sep_partcp_fut_cnt_Invalid := Raw_Fields.InValid_rtd_sep_partcp_fut_cnt((SALT311.StrType)le.rtd_sep_partcp_fut_cnt);
    SELF.subtl_act_rtd_sep_cnt_Invalid := Raw_Fields.InValid_subtl_act_rtd_sep_cnt((SALT311.StrType)le.subtl_act_rtd_sep_cnt);
    SELF.benef_rcvg_bnft_cnt_Invalid := Raw_Fields.InValid_benef_rcvg_bnft_cnt((SALT311.StrType)le.benef_rcvg_bnft_cnt);
    SELF.tot_act_rtd_sep_benef_cnt_Invalid := Raw_Fields.InValid_tot_act_rtd_sep_benef_cnt((SALT311.StrType)le.tot_act_rtd_sep_benef_cnt);
    SELF.partcp_account_bal_cnt_Invalid := Raw_Fields.InValid_partcp_account_bal_cnt((SALT311.StrType)le.partcp_account_bal_cnt);
    SELF.sep_partcp_partl_vstd_cnt_Invalid := Raw_Fields.InValid_sep_partcp_partl_vstd_cnt((SALT311.StrType)le.sep_partcp_partl_vstd_cnt);
    SELF.contrib_emplrs_cnt_Invalid := Raw_Fields.InValid_contrib_emplrs_cnt((SALT311.StrType)le.contrib_emplrs_cnt);
    SELF.type_pension_bnft_code_Invalid := Raw_Fields.InValid_type_pension_bnft_code((SALT311.StrType)le.type_pension_bnft_code);
    SELF.type_welfare_bnft_code_Invalid := Raw_Fields.InValid_type_welfare_bnft_code((SALT311.StrType)le.type_welfare_bnft_code);
    SELF.funding_insurance_ind_Invalid := Raw_Fields.InValid_funding_insurance_ind((SALT311.StrType)le.funding_insurance_ind);
    SELF.funding_sec412_ind_Invalid := Raw_Fields.InValid_funding_sec412_ind((SALT311.StrType)le.funding_sec412_ind);
    SELF.funding_trust_ind_Invalid := Raw_Fields.InValid_funding_trust_ind((SALT311.StrType)le.funding_trust_ind);
    SELF.funding_gen_asset_ind_Invalid := Raw_Fields.InValid_funding_gen_asset_ind((SALT311.StrType)le.funding_gen_asset_ind);
    SELF.benefit_insurance_ind_Invalid := Raw_Fields.InValid_benefit_insurance_ind((SALT311.StrType)le.benefit_insurance_ind);
    SELF.benefit_sec412_ind_Invalid := Raw_Fields.InValid_benefit_sec412_ind((SALT311.StrType)le.benefit_sec412_ind);
    SELF.benefit_trust_ind_Invalid := Raw_Fields.InValid_benefit_trust_ind((SALT311.StrType)le.benefit_trust_ind);
    SELF.benefit_gen_asset_ind_Invalid := Raw_Fields.InValid_benefit_gen_asset_ind((SALT311.StrType)le.benefit_gen_asset_ind);
    SELF.sch_r_attached_ind_Invalid := Raw_Fields.InValid_sch_r_attached_ind((SALT311.StrType)le.sch_r_attached_ind);
    SELF.sch_mb_attached_ind_Invalid := Raw_Fields.InValid_sch_mb_attached_ind((SALT311.StrType)le.sch_mb_attached_ind);
    SELF.sch_sb_attached_ind_Invalid := Raw_Fields.InValid_sch_sb_attached_ind((SALT311.StrType)le.sch_sb_attached_ind);
    SELF.sch_h_attached_ind_Invalid := Raw_Fields.InValid_sch_h_attached_ind((SALT311.StrType)le.sch_h_attached_ind);
    SELF.sch_i_attached_ind_Invalid := Raw_Fields.InValid_sch_i_attached_ind((SALT311.StrType)le.sch_i_attached_ind);
    SELF.sch_a_attached_ind_Invalid := Raw_Fields.InValid_sch_a_attached_ind((SALT311.StrType)le.sch_a_attached_ind);
    SELF.num_sch_a_attached_cnt_Invalid := Raw_Fields.InValid_num_sch_a_attached_cnt((SALT311.StrType)le.num_sch_a_attached_cnt);
    SELF.sch_c_attached_ind_Invalid := Raw_Fields.InValid_sch_c_attached_ind((SALT311.StrType)le.sch_c_attached_ind);
    SELF.sch_d_attached_ind_Invalid := Raw_Fields.InValid_sch_d_attached_ind((SALT311.StrType)le.sch_d_attached_ind);
    SELF.sch_g_attached_ind_Invalid := Raw_Fields.InValid_sch_g_attached_ind((SALT311.StrType)le.sch_g_attached_ind);
    SELF.filing_status_Invalid := Raw_Fields.InValid_filing_status((SALT311.StrType)le.filing_status);
    SELF.date_received_Invalid := Raw_Fields.InValid_date_received((SALT311.StrType)le.date_received);
    SELF.admin_phone_num_foreign_Invalid := Raw_Fields.InValid_admin_phone_num_foreign((SALT311.StrType)le.admin_phone_num_foreign);
    SELF.spons_dfe_phone_num_foreign_Invalid := Raw_Fields.InValid_spons_dfe_phone_num_foreign((SALT311.StrType)le.spons_dfe_phone_num_foreign);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Raw_Layout_IRS5500);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ack_id_Invalid << 0 ) + ( le.form_plan_year_begin_date_Invalid << 1 ) + ( le.form_tax_prd_Invalid << 2 ) + ( le.type_plan_entity_cd_Invalid << 3 ) + ( le.type_dfe_plan_entity_cd_Invalid << 4 ) + ( le.initial_filing_ind_Invalid << 5 ) + ( le.amended_ind_Invalid << 6 ) + ( le.final_filing_ind_Invalid << 7 ) + ( le.short_plan_yr_ind_Invalid << 8 ) + ( le.collective_bargain_ind_Invalid << 9 ) + ( le.f5558_application_filed_ind_Invalid << 10 ) + ( le.ext_automatic_ind_Invalid << 11 ) + ( le.dfvc_program_ind_Invalid << 12 ) + ( le.ext_special_ind_Invalid << 13 ) + ( le.plan_name_Invalid << 14 ) + ( le.spons_dfe_pn_Invalid << 15 ) + ( le.plan_eff_date_Invalid << 16 ) + ( le.sponsor_dfe_name_Invalid << 17 ) + ( le.spons_dfe_dba_name_Invalid << 18 ) + ( le.spons_dfe_care_of_name_Invalid << 19 ) + ( le.spons_dfe_mail_us_address1_Invalid << 20 ) + ( le.spons_dfe_mail_us_city_Invalid << 21 ) + ( le.spons_dfe_mail_us_state_Invalid << 22 ) + ( le.spons_dfe_mail_us_zip_Invalid << 23 ) + ( le.spons_dfe_mail_foreign_addr1_Invalid << 24 ) + ( le.spons_dfe_mail_foreign_city_Invalid << 25 ) + ( le.spons_dfe_mail_forgn_prov_st_Invalid << 26 ) + ( le.spons_dfe_mail_foreign_cntry_Invalid << 27 ) + ( le.spons_dfe_mail_forgn_postal_cd_Invalid << 28 ) + ( le.spons_dfe_loc_us_address1_Invalid << 29 ) + ( le.spons_dfe_loc_us_city_Invalid << 30 ) + ( le.spons_dfe_loc_us_state_Invalid << 31 ) + ( le.spons_dfe_loc_us_zip_Invalid << 32 ) + ( le.spons_dfe_loc_foreign_address1_Invalid << 33 ) + ( le.spons_dfe_loc_foreign_city_Invalid << 34 ) + ( le.spons_dfe_loc_forgn_prov_st_Invalid << 35 ) + ( le.spons_dfe_loc_foreign_cntry_Invalid << 36 ) + ( le.spons_dfe_loc_forgn_postal_cd_Invalid << 37 ) + ( le.spons_dfe_phone_num_Invalid << 38 ) + ( le.business_code_Invalid << 39 ) + ( le.admin_name_Invalid << 40 ) + ( le.admin_care_of_name_Invalid << 41 ) + ( le.admin_us_address1_Invalid << 42 ) + ( le.admin_us_city_Invalid << 43 ) + ( le.admin_us_state_Invalid << 44 ) + ( le.admin_us_zip_Invalid << 45 ) + ( le.admin_foreign_address1_Invalid << 46 ) + ( le.admin_foreign_city_Invalid << 47 ) + ( le.admin_foreign_prov_state_Invalid << 48 ) + ( le.admin_foreign_cntry_Invalid << 49 ) + ( le.admin_foreign_postal_cd_Invalid << 50 ) + ( le.admin_ein_Invalid << 51 ) + ( le.admin_phone_num_Invalid << 52 ) + ( le.last_rpt_spons_name_Invalid << 53 ) + ( le.last_rpt_spons_ein_Invalid << 54 ) + ( le.last_rpt_plan_num_Invalid << 55 ) + ( le.admin_signed_date_Invalid << 56 ) + ( le.admin_signed_name_Invalid << 57 ) + ( le.spons_signed_date_Invalid << 58 ) + ( le.spons_signed_name_Invalid << 59 ) + ( le.dfe_signed_date_Invalid << 60 ) + ( le.dfe_signed_name_Invalid << 61 ) + ( le.tot_partcp_boy_cnt_Invalid << 62 ) + ( le.tot_active_partcp_cnt_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.rtd_sep_partcp_rcvg_cnt_Invalid << 0 ) + ( le.rtd_sep_partcp_fut_cnt_Invalid << 1 ) + ( le.subtl_act_rtd_sep_cnt_Invalid << 2 ) + ( le.benef_rcvg_bnft_cnt_Invalid << 3 ) + ( le.tot_act_rtd_sep_benef_cnt_Invalid << 4 ) + ( le.partcp_account_bal_cnt_Invalid << 5 ) + ( le.sep_partcp_partl_vstd_cnt_Invalid << 6 ) + ( le.contrib_emplrs_cnt_Invalid << 7 ) + ( le.type_pension_bnft_code_Invalid << 8 ) + ( le.type_welfare_bnft_code_Invalid << 9 ) + ( le.funding_insurance_ind_Invalid << 10 ) + ( le.funding_sec412_ind_Invalid << 11 ) + ( le.funding_trust_ind_Invalid << 12 ) + ( le.funding_gen_asset_ind_Invalid << 13 ) + ( le.benefit_insurance_ind_Invalid << 14 ) + ( le.benefit_sec412_ind_Invalid << 15 ) + ( le.benefit_trust_ind_Invalid << 16 ) + ( le.benefit_gen_asset_ind_Invalid << 17 ) + ( le.sch_r_attached_ind_Invalid << 18 ) + ( le.sch_mb_attached_ind_Invalid << 19 ) + ( le.sch_sb_attached_ind_Invalid << 20 ) + ( le.sch_h_attached_ind_Invalid << 21 ) + ( le.sch_i_attached_ind_Invalid << 22 ) + ( le.sch_a_attached_ind_Invalid << 23 ) + ( le.num_sch_a_attached_cnt_Invalid << 24 ) + ( le.sch_c_attached_ind_Invalid << 25 ) + ( le.sch_d_attached_ind_Invalid << 26 ) + ( le.sch_g_attached_ind_Invalid << 27 ) + ( le.filing_status_Invalid << 28 ) + ( le.date_received_Invalid << 29 ) + ( le.admin_phone_num_foreign_Invalid << 30 ) + ( le.spons_dfe_phone_num_foreign_Invalid << 31 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Raw_Layout_IRS5500);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ack_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.form_plan_year_begin_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.form_tax_prd_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.type_plan_entity_cd_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.type_dfe_plan_entity_cd_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.initial_filing_ind_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.amended_ind_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.final_filing_ind_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.short_plan_yr_ind_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.collective_bargain_ind_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.f5558_application_filed_ind_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.ext_automatic_ind_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.dfvc_program_ind_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.ext_special_ind_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.plan_name_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.spons_dfe_pn_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.plan_eff_date_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.sponsor_dfe_name_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.spons_dfe_dba_name_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.spons_dfe_care_of_name_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.spons_dfe_mail_us_address1_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.spons_dfe_mail_us_city_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.spons_dfe_mail_us_state_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.spons_dfe_mail_us_zip_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.spons_dfe_mail_foreign_addr1_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.spons_dfe_mail_foreign_city_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.spons_dfe_mail_forgn_prov_st_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.spons_dfe_mail_foreign_cntry_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.spons_dfe_mail_forgn_postal_cd_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.spons_dfe_loc_us_address1_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.spons_dfe_loc_us_city_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.spons_dfe_loc_us_state_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.spons_dfe_loc_us_zip_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.spons_dfe_loc_foreign_address1_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.spons_dfe_loc_foreign_city_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.spons_dfe_loc_forgn_prov_st_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.spons_dfe_loc_foreign_cntry_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.spons_dfe_loc_forgn_postal_cd_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.spons_dfe_phone_num_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.business_code_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.admin_name_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.admin_care_of_name_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.admin_us_address1_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.admin_us_city_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.admin_us_state_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.admin_us_zip_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.admin_foreign_address1_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.admin_foreign_city_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.admin_foreign_prov_state_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.admin_foreign_cntry_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.admin_foreign_postal_cd_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.admin_ein_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.admin_phone_num_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.last_rpt_spons_name_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.last_rpt_spons_ein_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.last_rpt_plan_num_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.admin_signed_date_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.admin_signed_name_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.spons_signed_date_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.spons_signed_name_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.dfe_signed_date_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.dfe_signed_name_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.tot_partcp_boy_cnt_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.tot_active_partcp_cnt_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.rtd_sep_partcp_rcvg_cnt_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.rtd_sep_partcp_fut_cnt_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.subtl_act_rtd_sep_cnt_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.benef_rcvg_bnft_cnt_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.tot_act_rtd_sep_benef_cnt_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.partcp_account_bal_cnt_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.sep_partcp_partl_vstd_cnt_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.contrib_emplrs_cnt_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.type_pension_bnft_code_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.type_welfare_bnft_code_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.funding_insurance_ind_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.funding_sec412_ind_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.funding_trust_ind_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.funding_gen_asset_ind_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.benefit_insurance_ind_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.benefit_sec412_ind_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.benefit_trust_ind_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.benefit_gen_asset_ind_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.sch_r_attached_ind_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.sch_mb_attached_ind_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.sch_sb_attached_ind_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.sch_h_attached_ind_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.sch_i_attached_ind_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.sch_a_attached_ind_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.num_sch_a_attached_cnt_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.sch_c_attached_ind_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.sch_d_attached_ind_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.sch_g_attached_ind_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.filing_status_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.date_received_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.admin_phone_num_foreign_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.spons_dfe_phone_num_foreign_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ack_id_ALLOW_ErrorCount := COUNT(GROUP,h.ack_id_Invalid=1);
    form_plan_year_begin_date_CUSTOM_ErrorCount := COUNT(GROUP,h.form_plan_year_begin_date_Invalid=1);
    form_tax_prd_CUSTOM_ErrorCount := COUNT(GROUP,h.form_tax_prd_Invalid=1);
    type_plan_entity_cd_ENUM_ErrorCount := COUNT(GROUP,h.type_plan_entity_cd_Invalid=1);
    type_dfe_plan_entity_cd_ENUM_ErrorCount := COUNT(GROUP,h.type_dfe_plan_entity_cd_Invalid=1);
    initial_filing_ind_ENUM_ErrorCount := COUNT(GROUP,h.initial_filing_ind_Invalid=1);
    amended_ind_ENUM_ErrorCount := COUNT(GROUP,h.amended_ind_Invalid=1);
    final_filing_ind_ENUM_ErrorCount := COUNT(GROUP,h.final_filing_ind_Invalid=1);
    short_plan_yr_ind_ENUM_ErrorCount := COUNT(GROUP,h.short_plan_yr_ind_Invalid=1);
    collective_bargain_ind_ENUM_ErrorCount := COUNT(GROUP,h.collective_bargain_ind_Invalid=1);
    f5558_application_filed_ind_ENUM_ErrorCount := COUNT(GROUP,h.f5558_application_filed_ind_Invalid=1);
    ext_automatic_ind_ENUM_ErrorCount := COUNT(GROUP,h.ext_automatic_ind_Invalid=1);
    dfvc_program_ind_ENUM_ErrorCount := COUNT(GROUP,h.dfvc_program_ind_Invalid=1);
    ext_special_ind_ENUM_ErrorCount := COUNT(GROUP,h.ext_special_ind_Invalid=1);
    plan_name_CUSTOM_ErrorCount := COUNT(GROUP,h.plan_name_Invalid=1);
    spons_dfe_pn_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_pn_Invalid=1);
    plan_eff_date_CUSTOM_ErrorCount := COUNT(GROUP,h.plan_eff_date_Invalid=1);
    sponsor_dfe_name_CUSTOM_ErrorCount := COUNT(GROUP,h.sponsor_dfe_name_Invalid=1);
    spons_dfe_dba_name_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_dba_name_Invalid=1);
    spons_dfe_care_of_name_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_care_of_name_Invalid=1);
    spons_dfe_mail_us_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_mail_us_address1_Invalid=1);
    spons_dfe_mail_us_city_ALLOW_ErrorCount := COUNT(GROUP,h.spons_dfe_mail_us_city_Invalid=1);
    spons_dfe_mail_us_state_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_mail_us_state_Invalid=1);
    spons_dfe_mail_us_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_mail_us_zip_Invalid=1);
    spons_dfe_mail_foreign_addr1_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_mail_foreign_addr1_Invalid=1);
    spons_dfe_mail_foreign_city_ALLOW_ErrorCount := COUNT(GROUP,h.spons_dfe_mail_foreign_city_Invalid=1);
    spons_dfe_mail_forgn_prov_st_ALLOW_ErrorCount := COUNT(GROUP,h.spons_dfe_mail_forgn_prov_st_Invalid=1);
    spons_dfe_mail_foreign_cntry_ALLOW_ErrorCount := COUNT(GROUP,h.spons_dfe_mail_foreign_cntry_Invalid=1);
    spons_dfe_mail_forgn_postal_cd_ALLOW_ErrorCount := COUNT(GROUP,h.spons_dfe_mail_forgn_postal_cd_Invalid=1);
    spons_dfe_loc_us_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_loc_us_address1_Invalid=1);
    spons_dfe_loc_us_city_ALLOW_ErrorCount := COUNT(GROUP,h.spons_dfe_loc_us_city_Invalid=1);
    spons_dfe_loc_us_state_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_loc_us_state_Invalid=1);
    spons_dfe_loc_us_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_loc_us_zip_Invalid=1);
    spons_dfe_loc_foreign_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_loc_foreign_address1_Invalid=1);
    spons_dfe_loc_foreign_city_ALLOW_ErrorCount := COUNT(GROUP,h.spons_dfe_loc_foreign_city_Invalid=1);
    spons_dfe_loc_forgn_prov_st_ALLOW_ErrorCount := COUNT(GROUP,h.spons_dfe_loc_forgn_prov_st_Invalid=1);
    spons_dfe_loc_foreign_cntry_ALLOW_ErrorCount := COUNT(GROUP,h.spons_dfe_loc_foreign_cntry_Invalid=1);
    spons_dfe_loc_forgn_postal_cd_ALLOW_ErrorCount := COUNT(GROUP,h.spons_dfe_loc_forgn_postal_cd_Invalid=1);
    spons_dfe_phone_num_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_phone_num_Invalid=1);
    business_code_CUSTOM_ErrorCount := COUNT(GROUP,h.business_code_Invalid=1);
    admin_name_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_name_Invalid=1);
    admin_care_of_name_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_care_of_name_Invalid=1);
    admin_us_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_us_address1_Invalid=1);
    admin_us_city_ALLOW_ErrorCount := COUNT(GROUP,h.admin_us_city_Invalid=1);
    admin_us_state_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_us_state_Invalid=1);
    admin_us_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_us_zip_Invalid=1);
    admin_foreign_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_foreign_address1_Invalid=1);
    admin_foreign_city_ALLOW_ErrorCount := COUNT(GROUP,h.admin_foreign_city_Invalid=1);
    admin_foreign_prov_state_ALLOW_ErrorCount := COUNT(GROUP,h.admin_foreign_prov_state_Invalid=1);
    admin_foreign_cntry_ALLOW_ErrorCount := COUNT(GROUP,h.admin_foreign_cntry_Invalid=1);
    admin_foreign_postal_cd_ALLOW_ErrorCount := COUNT(GROUP,h.admin_foreign_postal_cd_Invalid=1);
    admin_ein_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_ein_Invalid=1);
    admin_phone_num_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_phone_num_Invalid=1);
    last_rpt_spons_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_rpt_spons_name_Invalid=1);
    last_rpt_spons_ein_CUSTOM_ErrorCount := COUNT(GROUP,h.last_rpt_spons_ein_Invalid=1);
    last_rpt_plan_num_CUSTOM_ErrorCount := COUNT(GROUP,h.last_rpt_plan_num_Invalid=1);
    admin_signed_date_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_signed_date_Invalid=1);
    admin_signed_name_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_signed_name_Invalid=1);
    spons_signed_date_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_signed_date_Invalid=1);
    spons_signed_name_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_signed_name_Invalid=1);
    dfe_signed_date_CUSTOM_ErrorCount := COUNT(GROUP,h.dfe_signed_date_Invalid=1);
    dfe_signed_name_CUSTOM_ErrorCount := COUNT(GROUP,h.dfe_signed_name_Invalid=1);
    tot_partcp_boy_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.tot_partcp_boy_cnt_Invalid=1);
    tot_active_partcp_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.tot_active_partcp_cnt_Invalid=1);
    rtd_sep_partcp_rcvg_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.rtd_sep_partcp_rcvg_cnt_Invalid=1);
    rtd_sep_partcp_fut_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.rtd_sep_partcp_fut_cnt_Invalid=1);
    subtl_act_rtd_sep_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.subtl_act_rtd_sep_cnt_Invalid=1);
    benef_rcvg_bnft_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.benef_rcvg_bnft_cnt_Invalid=1);
    tot_act_rtd_sep_benef_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.tot_act_rtd_sep_benef_cnt_Invalid=1);
    partcp_account_bal_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.partcp_account_bal_cnt_Invalid=1);
    sep_partcp_partl_vstd_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.sep_partcp_partl_vstd_cnt_Invalid=1);
    contrib_emplrs_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.contrib_emplrs_cnt_Invalid=1);
    type_pension_bnft_code_ALLOW_ErrorCount := COUNT(GROUP,h.type_pension_bnft_code_Invalid=1);
    type_welfare_bnft_code_ALLOW_ErrorCount := COUNT(GROUP,h.type_welfare_bnft_code_Invalid=1);
    funding_insurance_ind_ENUM_ErrorCount := COUNT(GROUP,h.funding_insurance_ind_Invalid=1);
    funding_sec412_ind_ENUM_ErrorCount := COUNT(GROUP,h.funding_sec412_ind_Invalid=1);
    funding_trust_ind_ENUM_ErrorCount := COUNT(GROUP,h.funding_trust_ind_Invalid=1);
    funding_gen_asset_ind_ENUM_ErrorCount := COUNT(GROUP,h.funding_gen_asset_ind_Invalid=1);
    benefit_insurance_ind_ENUM_ErrorCount := COUNT(GROUP,h.benefit_insurance_ind_Invalid=1);
    benefit_sec412_ind_ENUM_ErrorCount := COUNT(GROUP,h.benefit_sec412_ind_Invalid=1);
    benefit_trust_ind_ENUM_ErrorCount := COUNT(GROUP,h.benefit_trust_ind_Invalid=1);
    benefit_gen_asset_ind_ENUM_ErrorCount := COUNT(GROUP,h.benefit_gen_asset_ind_Invalid=1);
    sch_r_attached_ind_ENUM_ErrorCount := COUNT(GROUP,h.sch_r_attached_ind_Invalid=1);
    sch_mb_attached_ind_ENUM_ErrorCount := COUNT(GROUP,h.sch_mb_attached_ind_Invalid=1);
    sch_sb_attached_ind_ENUM_ErrorCount := COUNT(GROUP,h.sch_sb_attached_ind_Invalid=1);
    sch_h_attached_ind_ENUM_ErrorCount := COUNT(GROUP,h.sch_h_attached_ind_Invalid=1);
    sch_i_attached_ind_ENUM_ErrorCount := COUNT(GROUP,h.sch_i_attached_ind_Invalid=1);
    sch_a_attached_ind_ENUM_ErrorCount := COUNT(GROUP,h.sch_a_attached_ind_Invalid=1);
    num_sch_a_attached_cnt_CUSTOM_ErrorCount := COUNT(GROUP,h.num_sch_a_attached_cnt_Invalid=1);
    sch_c_attached_ind_ENUM_ErrorCount := COUNT(GROUP,h.sch_c_attached_ind_Invalid=1);
    sch_d_attached_ind_ENUM_ErrorCount := COUNT(GROUP,h.sch_d_attached_ind_Invalid=1);
    sch_g_attached_ind_ENUM_ErrorCount := COUNT(GROUP,h.sch_g_attached_ind_Invalid=1);
    filing_status_ENUM_ErrorCount := COUNT(GROUP,h.filing_status_Invalid=1);
    date_received_CUSTOM_ErrorCount := COUNT(GROUP,h.date_received_Invalid=1);
    admin_phone_num_foreign_CUSTOM_ErrorCount := COUNT(GROUP,h.admin_phone_num_foreign_Invalid=1);
    spons_dfe_phone_num_foreign_CUSTOM_ErrorCount := COUNT(GROUP,h.spons_dfe_phone_num_foreign_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ack_id_Invalid > 0 OR h.form_plan_year_begin_date_Invalid > 0 OR h.form_tax_prd_Invalid > 0 OR h.type_plan_entity_cd_Invalid > 0 OR h.type_dfe_plan_entity_cd_Invalid > 0 OR h.initial_filing_ind_Invalid > 0 OR h.amended_ind_Invalid > 0 OR h.final_filing_ind_Invalid > 0 OR h.short_plan_yr_ind_Invalid > 0 OR h.collective_bargain_ind_Invalid > 0 OR h.f5558_application_filed_ind_Invalid > 0 OR h.ext_automatic_ind_Invalid > 0 OR h.dfvc_program_ind_Invalid > 0 OR h.ext_special_ind_Invalid > 0 OR h.plan_name_Invalid > 0 OR h.spons_dfe_pn_Invalid > 0 OR h.plan_eff_date_Invalid > 0 OR h.sponsor_dfe_name_Invalid > 0 OR h.spons_dfe_dba_name_Invalid > 0 OR h.spons_dfe_care_of_name_Invalid > 0 OR h.spons_dfe_mail_us_address1_Invalid > 0 OR h.spons_dfe_mail_us_city_Invalid > 0 OR h.spons_dfe_mail_us_state_Invalid > 0 OR h.spons_dfe_mail_us_zip_Invalid > 0 OR h.spons_dfe_mail_foreign_addr1_Invalid > 0 OR h.spons_dfe_mail_foreign_city_Invalid > 0 OR h.spons_dfe_mail_forgn_prov_st_Invalid > 0 OR h.spons_dfe_mail_foreign_cntry_Invalid > 0 OR h.spons_dfe_mail_forgn_postal_cd_Invalid > 0 OR h.spons_dfe_loc_us_address1_Invalid > 0 OR h.spons_dfe_loc_us_city_Invalid > 0 OR h.spons_dfe_loc_us_state_Invalid > 0 OR h.spons_dfe_loc_us_zip_Invalid > 0 OR h.spons_dfe_loc_foreign_address1_Invalid > 0 OR h.spons_dfe_loc_foreign_city_Invalid > 0 OR h.spons_dfe_loc_forgn_prov_st_Invalid > 0 OR h.spons_dfe_loc_foreign_cntry_Invalid > 0 OR h.spons_dfe_loc_forgn_postal_cd_Invalid > 0 OR h.spons_dfe_phone_num_Invalid > 0 OR h.business_code_Invalid > 0 OR h.admin_name_Invalid > 0 OR h.admin_care_of_name_Invalid > 0 OR h.admin_us_address1_Invalid > 0 OR h.admin_us_city_Invalid > 0 OR h.admin_us_state_Invalid > 0 OR h.admin_us_zip_Invalid > 0 OR h.admin_foreign_address1_Invalid > 0 OR h.admin_foreign_city_Invalid > 0 OR h.admin_foreign_prov_state_Invalid > 0 OR h.admin_foreign_cntry_Invalid > 0 OR h.admin_foreign_postal_cd_Invalid > 0 OR h.admin_ein_Invalid > 0 OR h.admin_phone_num_Invalid > 0 OR h.last_rpt_spons_name_Invalid > 0 OR h.last_rpt_spons_ein_Invalid > 0 OR h.last_rpt_plan_num_Invalid > 0 OR h.admin_signed_date_Invalid > 0 OR h.admin_signed_name_Invalid > 0 OR h.spons_signed_date_Invalid > 0 OR h.spons_signed_name_Invalid > 0 OR h.dfe_signed_date_Invalid > 0 OR h.dfe_signed_name_Invalid > 0 OR h.tot_partcp_boy_cnt_Invalid > 0 OR h.tot_active_partcp_cnt_Invalid > 0 OR h.rtd_sep_partcp_rcvg_cnt_Invalid > 0 OR h.rtd_sep_partcp_fut_cnt_Invalid > 0 OR h.subtl_act_rtd_sep_cnt_Invalid > 0 OR h.benef_rcvg_bnft_cnt_Invalid > 0 OR h.tot_act_rtd_sep_benef_cnt_Invalid > 0 OR h.partcp_account_bal_cnt_Invalid > 0 OR h.sep_partcp_partl_vstd_cnt_Invalid > 0 OR h.contrib_emplrs_cnt_Invalid > 0 OR h.type_pension_bnft_code_Invalid > 0 OR h.type_welfare_bnft_code_Invalid > 0 OR h.funding_insurance_ind_Invalid > 0 OR h.funding_sec412_ind_Invalid > 0 OR h.funding_trust_ind_Invalid > 0 OR h.funding_gen_asset_ind_Invalid > 0 OR h.benefit_insurance_ind_Invalid > 0 OR h.benefit_sec412_ind_Invalid > 0 OR h.benefit_trust_ind_Invalid > 0 OR h.benefit_gen_asset_ind_Invalid > 0 OR h.sch_r_attached_ind_Invalid > 0 OR h.sch_mb_attached_ind_Invalid > 0 OR h.sch_sb_attached_ind_Invalid > 0 OR h.sch_h_attached_ind_Invalid > 0 OR h.sch_i_attached_ind_Invalid > 0 OR h.sch_a_attached_ind_Invalid > 0 OR h.num_sch_a_attached_cnt_Invalid > 0 OR h.sch_c_attached_ind_Invalid > 0 OR h.sch_d_attached_ind_Invalid > 0 OR h.sch_g_attached_ind_Invalid > 0 OR h.filing_status_Invalid > 0 OR h.date_received_Invalid > 0 OR h.admin_phone_num_foreign_Invalid > 0 OR h.spons_dfe_phone_num_foreign_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ack_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.form_plan_year_begin_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.form_tax_prd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_plan_entity_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.type_dfe_plan_entity_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.initial_filing_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.amended_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.final_filing_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.short_plan_yr_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.collective_bargain_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.f5558_application_filed_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.ext_automatic_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.dfvc_program_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.ext_special_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.plan_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_pn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.plan_eff_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sponsor_dfe_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_dba_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_care_of_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_us_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_us_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_us_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_us_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_foreign_addr1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_foreign_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_forgn_prov_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_foreign_cntry_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_forgn_postal_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_us_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_us_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_us_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_us_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_foreign_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_foreign_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_forgn_prov_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_foreign_cntry_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_forgn_postal_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_phone_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_care_of_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_us_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_us_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_us_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_us_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_foreign_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_foreign_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_foreign_prov_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_foreign_cntry_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_foreign_postal_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_ein_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_phone_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_rpt_spons_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_rpt_spons_ein_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_rpt_plan_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_signed_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_signed_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_signed_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_signed_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dfe_signed_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dfe_signed_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tot_partcp_boy_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tot_active_partcp_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rtd_sep_partcp_rcvg_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rtd_sep_partcp_fut_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.subtl_act_rtd_sep_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.benef_rcvg_bnft_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tot_act_rtd_sep_benef_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.partcp_account_bal_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sep_partcp_partl_vstd_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contrib_emplrs_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_pension_bnft_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.type_welfare_bnft_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.funding_insurance_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.funding_sec412_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.funding_trust_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.funding_gen_asset_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.benefit_insurance_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.benefit_sec412_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.benefit_trust_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.benefit_gen_asset_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_r_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_mb_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_sb_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_h_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_i_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_a_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.num_sch_a_attached_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sch_c_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_d_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_g_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.filing_status_ENUM_ErrorCount > 0, 1, 0) + IF(le.date_received_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_phone_num_foreign_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_phone_num_foreign_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ack_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.form_plan_year_begin_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.form_tax_prd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_plan_entity_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.type_dfe_plan_entity_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.initial_filing_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.amended_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.final_filing_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.short_plan_yr_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.collective_bargain_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.f5558_application_filed_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.ext_automatic_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.dfvc_program_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.ext_special_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.plan_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_pn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.plan_eff_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sponsor_dfe_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_dba_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_care_of_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_us_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_us_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_us_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_us_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_foreign_addr1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_foreign_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_forgn_prov_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_foreign_cntry_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_mail_forgn_postal_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_us_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_us_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_us_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_us_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_foreign_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_foreign_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_forgn_prov_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_foreign_cntry_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_loc_forgn_postal_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_phone_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_care_of_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_us_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_us_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_us_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_us_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_foreign_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_foreign_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_foreign_prov_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_foreign_cntry_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_foreign_postal_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_ein_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_phone_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_rpt_spons_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_rpt_spons_ein_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_rpt_plan_num_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_signed_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_signed_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_signed_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_signed_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dfe_signed_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dfe_signed_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tot_partcp_boy_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tot_active_partcp_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rtd_sep_partcp_rcvg_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rtd_sep_partcp_fut_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.subtl_act_rtd_sep_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.benef_rcvg_bnft_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tot_act_rtd_sep_benef_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.partcp_account_bal_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sep_partcp_partl_vstd_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contrib_emplrs_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_pension_bnft_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.type_welfare_bnft_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.funding_insurance_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.funding_sec412_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.funding_trust_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.funding_gen_asset_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.benefit_insurance_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.benefit_sec412_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.benefit_trust_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.benefit_gen_asset_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_r_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_mb_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_sb_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_h_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_i_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_a_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.num_sch_a_attached_cnt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sch_c_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_d_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.sch_g_attached_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.filing_status_ENUM_ErrorCount > 0, 1, 0) + IF(le.date_received_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.admin_phone_num_foreign_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.spons_dfe_phone_num_foreign_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ack_id_Invalid,le.form_plan_year_begin_date_Invalid,le.form_tax_prd_Invalid,le.type_plan_entity_cd_Invalid,le.type_dfe_plan_entity_cd_Invalid,le.initial_filing_ind_Invalid,le.amended_ind_Invalid,le.final_filing_ind_Invalid,le.short_plan_yr_ind_Invalid,le.collective_bargain_ind_Invalid,le.f5558_application_filed_ind_Invalid,le.ext_automatic_ind_Invalid,le.dfvc_program_ind_Invalid,le.ext_special_ind_Invalid,le.plan_name_Invalid,le.spons_dfe_pn_Invalid,le.plan_eff_date_Invalid,le.sponsor_dfe_name_Invalid,le.spons_dfe_dba_name_Invalid,le.spons_dfe_care_of_name_Invalid,le.spons_dfe_mail_us_address1_Invalid,le.spons_dfe_mail_us_city_Invalid,le.spons_dfe_mail_us_state_Invalid,le.spons_dfe_mail_us_zip_Invalid,le.spons_dfe_mail_foreign_addr1_Invalid,le.spons_dfe_mail_foreign_city_Invalid,le.spons_dfe_mail_forgn_prov_st_Invalid,le.spons_dfe_mail_foreign_cntry_Invalid,le.spons_dfe_mail_forgn_postal_cd_Invalid,le.spons_dfe_loc_us_address1_Invalid,le.spons_dfe_loc_us_city_Invalid,le.spons_dfe_loc_us_state_Invalid,le.spons_dfe_loc_us_zip_Invalid,le.spons_dfe_loc_foreign_address1_Invalid,le.spons_dfe_loc_foreign_city_Invalid,le.spons_dfe_loc_forgn_prov_st_Invalid,le.spons_dfe_loc_foreign_cntry_Invalid,le.spons_dfe_loc_forgn_postal_cd_Invalid,le.spons_dfe_phone_num_Invalid,le.business_code_Invalid,le.admin_name_Invalid,le.admin_care_of_name_Invalid,le.admin_us_address1_Invalid,le.admin_us_city_Invalid,le.admin_us_state_Invalid,le.admin_us_zip_Invalid,le.admin_foreign_address1_Invalid,le.admin_foreign_city_Invalid,le.admin_foreign_prov_state_Invalid,le.admin_foreign_cntry_Invalid,le.admin_foreign_postal_cd_Invalid,le.admin_ein_Invalid,le.admin_phone_num_Invalid,le.last_rpt_spons_name_Invalid,le.last_rpt_spons_ein_Invalid,le.last_rpt_plan_num_Invalid,le.admin_signed_date_Invalid,le.admin_signed_name_Invalid,le.spons_signed_date_Invalid,le.spons_signed_name_Invalid,le.dfe_signed_date_Invalid,le.dfe_signed_name_Invalid,le.tot_partcp_boy_cnt_Invalid,le.tot_active_partcp_cnt_Invalid,le.rtd_sep_partcp_rcvg_cnt_Invalid,le.rtd_sep_partcp_fut_cnt_Invalid,le.subtl_act_rtd_sep_cnt_Invalid,le.benef_rcvg_bnft_cnt_Invalid,le.tot_act_rtd_sep_benef_cnt_Invalid,le.partcp_account_bal_cnt_Invalid,le.sep_partcp_partl_vstd_cnt_Invalid,le.contrib_emplrs_cnt_Invalid,le.type_pension_bnft_code_Invalid,le.type_welfare_bnft_code_Invalid,le.funding_insurance_ind_Invalid,le.funding_sec412_ind_Invalid,le.funding_trust_ind_Invalid,le.funding_gen_asset_ind_Invalid,le.benefit_insurance_ind_Invalid,le.benefit_sec412_ind_Invalid,le.benefit_trust_ind_Invalid,le.benefit_gen_asset_ind_Invalid,le.sch_r_attached_ind_Invalid,le.sch_mb_attached_ind_Invalid,le.sch_sb_attached_ind_Invalid,le.sch_h_attached_ind_Invalid,le.sch_i_attached_ind_Invalid,le.sch_a_attached_ind_Invalid,le.num_sch_a_attached_cnt_Invalid,le.sch_c_attached_ind_Invalid,le.sch_d_attached_ind_Invalid,le.sch_g_attached_ind_Invalid,le.filing_status_Invalid,le.date_received_Invalid,le.admin_phone_num_foreign_Invalid,le.spons_dfe_phone_num_foreign_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Raw_Fields.InvalidMessage_ack_id(le.ack_id_Invalid),Raw_Fields.InvalidMessage_form_plan_year_begin_date(le.form_plan_year_begin_date_Invalid),Raw_Fields.InvalidMessage_form_tax_prd(le.form_tax_prd_Invalid),Raw_Fields.InvalidMessage_type_plan_entity_cd(le.type_plan_entity_cd_Invalid),Raw_Fields.InvalidMessage_type_dfe_plan_entity_cd(le.type_dfe_plan_entity_cd_Invalid),Raw_Fields.InvalidMessage_initial_filing_ind(le.initial_filing_ind_Invalid),Raw_Fields.InvalidMessage_amended_ind(le.amended_ind_Invalid),Raw_Fields.InvalidMessage_final_filing_ind(le.final_filing_ind_Invalid),Raw_Fields.InvalidMessage_short_plan_yr_ind(le.short_plan_yr_ind_Invalid),Raw_Fields.InvalidMessage_collective_bargain_ind(le.collective_bargain_ind_Invalid),Raw_Fields.InvalidMessage_f5558_application_filed_ind(le.f5558_application_filed_ind_Invalid),Raw_Fields.InvalidMessage_ext_automatic_ind(le.ext_automatic_ind_Invalid),Raw_Fields.InvalidMessage_dfvc_program_ind(le.dfvc_program_ind_Invalid),Raw_Fields.InvalidMessage_ext_special_ind(le.ext_special_ind_Invalid),Raw_Fields.InvalidMessage_plan_name(le.plan_name_Invalid),Raw_Fields.InvalidMessage_spons_dfe_pn(le.spons_dfe_pn_Invalid),Raw_Fields.InvalidMessage_plan_eff_date(le.plan_eff_date_Invalid),Raw_Fields.InvalidMessage_sponsor_dfe_name(le.sponsor_dfe_name_Invalid),Raw_Fields.InvalidMessage_spons_dfe_dba_name(le.spons_dfe_dba_name_Invalid),Raw_Fields.InvalidMessage_spons_dfe_care_of_name(le.spons_dfe_care_of_name_Invalid),Raw_Fields.InvalidMessage_spons_dfe_mail_us_address1(le.spons_dfe_mail_us_address1_Invalid),Raw_Fields.InvalidMessage_spons_dfe_mail_us_city(le.spons_dfe_mail_us_city_Invalid),Raw_Fields.InvalidMessage_spons_dfe_mail_us_state(le.spons_dfe_mail_us_state_Invalid),Raw_Fields.InvalidMessage_spons_dfe_mail_us_zip(le.spons_dfe_mail_us_zip_Invalid),Raw_Fields.InvalidMessage_spons_dfe_mail_foreign_addr1(le.spons_dfe_mail_foreign_addr1_Invalid),Raw_Fields.InvalidMessage_spons_dfe_mail_foreign_city(le.spons_dfe_mail_foreign_city_Invalid),Raw_Fields.InvalidMessage_spons_dfe_mail_forgn_prov_st(le.spons_dfe_mail_forgn_prov_st_Invalid),Raw_Fields.InvalidMessage_spons_dfe_mail_foreign_cntry(le.spons_dfe_mail_foreign_cntry_Invalid),Raw_Fields.InvalidMessage_spons_dfe_mail_forgn_postal_cd(le.spons_dfe_mail_forgn_postal_cd_Invalid),Raw_Fields.InvalidMessage_spons_dfe_loc_us_address1(le.spons_dfe_loc_us_address1_Invalid),Raw_Fields.InvalidMessage_spons_dfe_loc_us_city(le.spons_dfe_loc_us_city_Invalid),Raw_Fields.InvalidMessage_spons_dfe_loc_us_state(le.spons_dfe_loc_us_state_Invalid),Raw_Fields.InvalidMessage_spons_dfe_loc_us_zip(le.spons_dfe_loc_us_zip_Invalid),Raw_Fields.InvalidMessage_spons_dfe_loc_foreign_address1(le.spons_dfe_loc_foreign_address1_Invalid),Raw_Fields.InvalidMessage_spons_dfe_loc_foreign_city(le.spons_dfe_loc_foreign_city_Invalid),Raw_Fields.InvalidMessage_spons_dfe_loc_forgn_prov_st(le.spons_dfe_loc_forgn_prov_st_Invalid),Raw_Fields.InvalidMessage_spons_dfe_loc_foreign_cntry(le.spons_dfe_loc_foreign_cntry_Invalid),Raw_Fields.InvalidMessage_spons_dfe_loc_forgn_postal_cd(le.spons_dfe_loc_forgn_postal_cd_Invalid),Raw_Fields.InvalidMessage_spons_dfe_phone_num(le.spons_dfe_phone_num_Invalid),Raw_Fields.InvalidMessage_business_code(le.business_code_Invalid),Raw_Fields.InvalidMessage_admin_name(le.admin_name_Invalid),Raw_Fields.InvalidMessage_admin_care_of_name(le.admin_care_of_name_Invalid),Raw_Fields.InvalidMessage_admin_us_address1(le.admin_us_address1_Invalid),Raw_Fields.InvalidMessage_admin_us_city(le.admin_us_city_Invalid),Raw_Fields.InvalidMessage_admin_us_state(le.admin_us_state_Invalid),Raw_Fields.InvalidMessage_admin_us_zip(le.admin_us_zip_Invalid),Raw_Fields.InvalidMessage_admin_foreign_address1(le.admin_foreign_address1_Invalid),Raw_Fields.InvalidMessage_admin_foreign_city(le.admin_foreign_city_Invalid),Raw_Fields.InvalidMessage_admin_foreign_prov_state(le.admin_foreign_prov_state_Invalid),Raw_Fields.InvalidMessage_admin_foreign_cntry(le.admin_foreign_cntry_Invalid),Raw_Fields.InvalidMessage_admin_foreign_postal_cd(le.admin_foreign_postal_cd_Invalid),Raw_Fields.InvalidMessage_admin_ein(le.admin_ein_Invalid),Raw_Fields.InvalidMessage_admin_phone_num(le.admin_phone_num_Invalid),Raw_Fields.InvalidMessage_last_rpt_spons_name(le.last_rpt_spons_name_Invalid),Raw_Fields.InvalidMessage_last_rpt_spons_ein(le.last_rpt_spons_ein_Invalid),Raw_Fields.InvalidMessage_last_rpt_plan_num(le.last_rpt_plan_num_Invalid),Raw_Fields.InvalidMessage_admin_signed_date(le.admin_signed_date_Invalid),Raw_Fields.InvalidMessage_admin_signed_name(le.admin_signed_name_Invalid),Raw_Fields.InvalidMessage_spons_signed_date(le.spons_signed_date_Invalid),Raw_Fields.InvalidMessage_spons_signed_name(le.spons_signed_name_Invalid),Raw_Fields.InvalidMessage_dfe_signed_date(le.dfe_signed_date_Invalid),Raw_Fields.InvalidMessage_dfe_signed_name(le.dfe_signed_name_Invalid),Raw_Fields.InvalidMessage_tot_partcp_boy_cnt(le.tot_partcp_boy_cnt_Invalid),Raw_Fields.InvalidMessage_tot_active_partcp_cnt(le.tot_active_partcp_cnt_Invalid),Raw_Fields.InvalidMessage_rtd_sep_partcp_rcvg_cnt(le.rtd_sep_partcp_rcvg_cnt_Invalid),Raw_Fields.InvalidMessage_rtd_sep_partcp_fut_cnt(le.rtd_sep_partcp_fut_cnt_Invalid),Raw_Fields.InvalidMessage_subtl_act_rtd_sep_cnt(le.subtl_act_rtd_sep_cnt_Invalid),Raw_Fields.InvalidMessage_benef_rcvg_bnft_cnt(le.benef_rcvg_bnft_cnt_Invalid),Raw_Fields.InvalidMessage_tot_act_rtd_sep_benef_cnt(le.tot_act_rtd_sep_benef_cnt_Invalid),Raw_Fields.InvalidMessage_partcp_account_bal_cnt(le.partcp_account_bal_cnt_Invalid),Raw_Fields.InvalidMessage_sep_partcp_partl_vstd_cnt(le.sep_partcp_partl_vstd_cnt_Invalid),Raw_Fields.InvalidMessage_contrib_emplrs_cnt(le.contrib_emplrs_cnt_Invalid),Raw_Fields.InvalidMessage_type_pension_bnft_code(le.type_pension_bnft_code_Invalid),Raw_Fields.InvalidMessage_type_welfare_bnft_code(le.type_welfare_bnft_code_Invalid),Raw_Fields.InvalidMessage_funding_insurance_ind(le.funding_insurance_ind_Invalid),Raw_Fields.InvalidMessage_funding_sec412_ind(le.funding_sec412_ind_Invalid),Raw_Fields.InvalidMessage_funding_trust_ind(le.funding_trust_ind_Invalid),Raw_Fields.InvalidMessage_funding_gen_asset_ind(le.funding_gen_asset_ind_Invalid),Raw_Fields.InvalidMessage_benefit_insurance_ind(le.benefit_insurance_ind_Invalid),Raw_Fields.InvalidMessage_benefit_sec412_ind(le.benefit_sec412_ind_Invalid),Raw_Fields.InvalidMessage_benefit_trust_ind(le.benefit_trust_ind_Invalid),Raw_Fields.InvalidMessage_benefit_gen_asset_ind(le.benefit_gen_asset_ind_Invalid),Raw_Fields.InvalidMessage_sch_r_attached_ind(le.sch_r_attached_ind_Invalid),Raw_Fields.InvalidMessage_sch_mb_attached_ind(le.sch_mb_attached_ind_Invalid),Raw_Fields.InvalidMessage_sch_sb_attached_ind(le.sch_sb_attached_ind_Invalid),Raw_Fields.InvalidMessage_sch_h_attached_ind(le.sch_h_attached_ind_Invalid),Raw_Fields.InvalidMessage_sch_i_attached_ind(le.sch_i_attached_ind_Invalid),Raw_Fields.InvalidMessage_sch_a_attached_ind(le.sch_a_attached_ind_Invalid),Raw_Fields.InvalidMessage_num_sch_a_attached_cnt(le.num_sch_a_attached_cnt_Invalid),Raw_Fields.InvalidMessage_sch_c_attached_ind(le.sch_c_attached_ind_Invalid),Raw_Fields.InvalidMessage_sch_d_attached_ind(le.sch_d_attached_ind_Invalid),Raw_Fields.InvalidMessage_sch_g_attached_ind(le.sch_g_attached_ind_Invalid),Raw_Fields.InvalidMessage_filing_status(le.filing_status_Invalid),Raw_Fields.InvalidMessage_date_received(le.date_received_Invalid),Raw_Fields.InvalidMessage_admin_phone_num_foreign(le.admin_phone_num_foreign_Invalid),Raw_Fields.InvalidMessage_spons_dfe_phone_num_foreign(le.spons_dfe_phone_num_foreign_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ack_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.form_plan_year_begin_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.form_tax_prd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.type_plan_entity_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.type_dfe_plan_entity_cd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.initial_filing_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.amended_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.final_filing_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.short_plan_yr_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.collective_bargain_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.f5558_application_filed_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ext_automatic_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dfvc_program_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ext_special_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.plan_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_pn_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.plan_eff_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sponsor_dfe_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_dba_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_care_of_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_mail_us_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_mail_us_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spons_dfe_mail_us_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_mail_us_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_mail_foreign_addr1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_mail_foreign_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spons_dfe_mail_forgn_prov_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spons_dfe_mail_foreign_cntry_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spons_dfe_mail_forgn_postal_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spons_dfe_loc_us_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_loc_us_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spons_dfe_loc_us_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_loc_us_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_loc_foreign_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_loc_foreign_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spons_dfe_loc_forgn_prov_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spons_dfe_loc_foreign_cntry_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spons_dfe_loc_forgn_postal_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spons_dfe_phone_num_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_care_of_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_us_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_us_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.admin_us_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_us_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_foreign_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_foreign_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.admin_foreign_prov_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.admin_foreign_cntry_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.admin_foreign_postal_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.admin_ein_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_phone_num_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_rpt_spons_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_rpt_spons_ein_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_rpt_plan_num_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_signed_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_signed_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_signed_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_signed_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dfe_signed_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dfe_signed_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tot_partcp_boy_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tot_active_partcp_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rtd_sep_partcp_rcvg_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rtd_sep_partcp_fut_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.subtl_act_rtd_sep_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.benef_rcvg_bnft_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tot_act_rtd_sep_benef_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.partcp_account_bal_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sep_partcp_partl_vstd_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contrib_emplrs_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.type_pension_bnft_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.type_welfare_bnft_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.funding_insurance_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.funding_sec412_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.funding_trust_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.funding_gen_asset_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.benefit_insurance_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.benefit_sec412_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.benefit_trust_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.benefit_gen_asset_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sch_r_attached_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sch_mb_attached_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sch_sb_attached_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sch_h_attached_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sch_i_attached_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sch_a_attached_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.num_sch_a_attached_cnt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sch_c_attached_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sch_d_attached_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sch_g_attached_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.filing_status_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.date_received_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.admin_phone_num_foreign_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.spons_dfe_phone_num_foreign_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ack_id','form_plan_year_begin_date','form_tax_prd','type_plan_entity_cd','type_dfe_plan_entity_cd','initial_filing_ind','amended_ind','final_filing_ind','short_plan_yr_ind','collective_bargain_ind','f5558_application_filed_ind','ext_automatic_ind','dfvc_program_ind','ext_special_ind','plan_name','spons_dfe_pn','plan_eff_date','sponsor_dfe_name','spons_dfe_dba_name','spons_dfe_care_of_name','spons_dfe_mail_us_address1','spons_dfe_mail_us_city','spons_dfe_mail_us_state','spons_dfe_mail_us_zip','spons_dfe_mail_foreign_addr1','spons_dfe_mail_foreign_city','spons_dfe_mail_forgn_prov_st','spons_dfe_mail_foreign_cntry','spons_dfe_mail_forgn_postal_cd','spons_dfe_loc_us_address1','spons_dfe_loc_us_city','spons_dfe_loc_us_state','spons_dfe_loc_us_zip','spons_dfe_loc_foreign_address1','spons_dfe_loc_foreign_city','spons_dfe_loc_forgn_prov_st','spons_dfe_loc_foreign_cntry','spons_dfe_loc_forgn_postal_cd','spons_dfe_phone_num','business_code','admin_name','admin_care_of_name','admin_us_address1','admin_us_city','admin_us_state','admin_us_zip','admin_foreign_address1','admin_foreign_city','admin_foreign_prov_state','admin_foreign_cntry','admin_foreign_postal_cd','admin_ein','admin_phone_num','last_rpt_spons_name','last_rpt_spons_ein','last_rpt_plan_num','admin_signed_date','admin_signed_name','spons_signed_date','spons_signed_name','dfe_signed_date','dfe_signed_name','tot_partcp_boy_cnt','tot_active_partcp_cnt','rtd_sep_partcp_rcvg_cnt','rtd_sep_partcp_fut_cnt','subtl_act_rtd_sep_cnt','benef_rcvg_bnft_cnt','tot_act_rtd_sep_benef_cnt','partcp_account_bal_cnt','sep_partcp_partl_vstd_cnt','contrib_emplrs_cnt','type_pension_bnft_code','type_welfare_bnft_code','funding_insurance_ind','funding_sec412_ind','funding_trust_ind','funding_gen_asset_ind','benefit_insurance_ind','benefit_sec412_ind','benefit_trust_ind','benefit_gen_asset_ind','sch_r_attached_ind','sch_mb_attached_ind','sch_sb_attached_ind','sch_h_attached_ind','sch_i_attached_ind','sch_a_attached_ind','num_sch_a_attached_cnt','sch_c_attached_ind','sch_d_attached_ind','sch_g_attached_ind','filing_status','date_received','admin_phone_num_foreign','spons_dfe_phone_num_foreign','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_ack_id','invalid_pastdate','invalid_pastdate','invalid_type_plan_entity_cd','invalid_type_dfe_plan_entity_cd','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_name','invalid_numeric','invalid_pastdate','invalid_name','invalid_name','invalid_name','invalid_dfe_mail_us_address','invalid_alpha_sp','invalid_state','invalid_full_zip','invalid_dfe_mail_foreign_addr','invalid_alphablank','invalid_alphablank','invalid_alphablank','invalid_alpha_numeric_blank','invalid_dfe_loc_us_address','invalid_alpha_sp','invalid_state','invalid_full_zip','invalid_dfe_loc_foreign_address','invalid_alphablank','invalid_alphablank','invalid_alphablank','invalid_alpha_numeric_blank','invalid_phone','invalid_numeric','invalid_name','invalid_name','invalid_admin_us_address','invalid_alpha_sp','invalid_state','invalid_full_zip','invalid_admin_foreign_address','invalid_alphablank','invalid_alphablank','invalid_alphablank','invalid_alpha_numeric_blank','invalid_numeric','invalid_phone','invalid_name','invalid_numeric','invalid_numeric','invalid_pastdate','invalid_name','invalid_pastdate','invalid_name','invalid_pastdate','invalid_name','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_type_pension_bnft_code','invalid_type_welfare_bnft_code','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_numeric','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_filing_status','invalid_generaldate','invalid_phone','invalid_phone','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ack_id,(SALT311.StrType)le.form_plan_year_begin_date,(SALT311.StrType)le.form_tax_prd,(SALT311.StrType)le.type_plan_entity_cd,(SALT311.StrType)le.type_dfe_plan_entity_cd,(SALT311.StrType)le.initial_filing_ind,(SALT311.StrType)le.amended_ind,(SALT311.StrType)le.final_filing_ind,(SALT311.StrType)le.short_plan_yr_ind,(SALT311.StrType)le.collective_bargain_ind,(SALT311.StrType)le.f5558_application_filed_ind,(SALT311.StrType)le.ext_automatic_ind,(SALT311.StrType)le.dfvc_program_ind,(SALT311.StrType)le.ext_special_ind,(SALT311.StrType)le.plan_name,(SALT311.StrType)le.spons_dfe_pn,(SALT311.StrType)le.plan_eff_date,(SALT311.StrType)le.sponsor_dfe_name,(SALT311.StrType)le.spons_dfe_dba_name,(SALT311.StrType)le.spons_dfe_care_of_name,(SALT311.StrType)le.spons_dfe_mail_us_address1,(SALT311.StrType)le.spons_dfe_mail_us_city,(SALT311.StrType)le.spons_dfe_mail_us_state,(SALT311.StrType)le.spons_dfe_mail_us_zip,(SALT311.StrType)le.spons_dfe_mail_foreign_addr1,(SALT311.StrType)le.spons_dfe_mail_foreign_city,(SALT311.StrType)le.spons_dfe_mail_forgn_prov_st,(SALT311.StrType)le.spons_dfe_mail_foreign_cntry,(SALT311.StrType)le.spons_dfe_mail_forgn_postal_cd,(SALT311.StrType)le.spons_dfe_loc_us_address1,(SALT311.StrType)le.spons_dfe_loc_us_city,(SALT311.StrType)le.spons_dfe_loc_us_state,(SALT311.StrType)le.spons_dfe_loc_us_zip,(SALT311.StrType)le.spons_dfe_loc_foreign_address1,(SALT311.StrType)le.spons_dfe_loc_foreign_city,(SALT311.StrType)le.spons_dfe_loc_forgn_prov_st,(SALT311.StrType)le.spons_dfe_loc_foreign_cntry,(SALT311.StrType)le.spons_dfe_loc_forgn_postal_cd,(SALT311.StrType)le.spons_dfe_phone_num,(SALT311.StrType)le.business_code,(SALT311.StrType)le.admin_name,(SALT311.StrType)le.admin_care_of_name,(SALT311.StrType)le.admin_us_address1,(SALT311.StrType)le.admin_us_city,(SALT311.StrType)le.admin_us_state,(SALT311.StrType)le.admin_us_zip,(SALT311.StrType)le.admin_foreign_address1,(SALT311.StrType)le.admin_foreign_city,(SALT311.StrType)le.admin_foreign_prov_state,(SALT311.StrType)le.admin_foreign_cntry,(SALT311.StrType)le.admin_foreign_postal_cd,(SALT311.StrType)le.admin_ein,(SALT311.StrType)le.admin_phone_num,(SALT311.StrType)le.last_rpt_spons_name,(SALT311.StrType)le.last_rpt_spons_ein,(SALT311.StrType)le.last_rpt_plan_num,(SALT311.StrType)le.admin_signed_date,(SALT311.StrType)le.admin_signed_name,(SALT311.StrType)le.spons_signed_date,(SALT311.StrType)le.spons_signed_name,(SALT311.StrType)le.dfe_signed_date,(SALT311.StrType)le.dfe_signed_name,(SALT311.StrType)le.tot_partcp_boy_cnt,(SALT311.StrType)le.tot_active_partcp_cnt,(SALT311.StrType)le.rtd_sep_partcp_rcvg_cnt,(SALT311.StrType)le.rtd_sep_partcp_fut_cnt,(SALT311.StrType)le.subtl_act_rtd_sep_cnt,(SALT311.StrType)le.benef_rcvg_bnft_cnt,(SALT311.StrType)le.tot_act_rtd_sep_benef_cnt,(SALT311.StrType)le.partcp_account_bal_cnt,(SALT311.StrType)le.sep_partcp_partl_vstd_cnt,(SALT311.StrType)le.contrib_emplrs_cnt,(SALT311.StrType)le.type_pension_bnft_code,(SALT311.StrType)le.type_welfare_bnft_code,(SALT311.StrType)le.funding_insurance_ind,(SALT311.StrType)le.funding_sec412_ind,(SALT311.StrType)le.funding_trust_ind,(SALT311.StrType)le.funding_gen_asset_ind,(SALT311.StrType)le.benefit_insurance_ind,(SALT311.StrType)le.benefit_sec412_ind,(SALT311.StrType)le.benefit_trust_ind,(SALT311.StrType)le.benefit_gen_asset_ind,(SALT311.StrType)le.sch_r_attached_ind,(SALT311.StrType)le.sch_mb_attached_ind,(SALT311.StrType)le.sch_sb_attached_ind,(SALT311.StrType)le.sch_h_attached_ind,(SALT311.StrType)le.sch_i_attached_ind,(SALT311.StrType)le.sch_a_attached_ind,(SALT311.StrType)le.num_sch_a_attached_cnt,(SALT311.StrType)le.sch_c_attached_ind,(SALT311.StrType)le.sch_d_attached_ind,(SALT311.StrType)le.sch_g_attached_ind,(SALT311.StrType)le.filing_status,(SALT311.StrType)le.date_received,(SALT311.StrType)le.admin_phone_num_foreign,(SALT311.StrType)le.spons_dfe_phone_num_foreign,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,96,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Raw_Layout_IRS5500) prevDS = DATASET([], Raw_Layout_IRS5500), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ack_id:invalid_ack_id:ALLOW'
          ,'form_plan_year_begin_date:invalid_pastdate:CUSTOM'
          ,'form_tax_prd:invalid_pastdate:CUSTOM'
          ,'type_plan_entity_cd:invalid_type_plan_entity_cd:ENUM'
          ,'type_dfe_plan_entity_cd:invalid_type_dfe_plan_entity_cd:ENUM'
          ,'initial_filing_ind:invalid_zero_1_bk:ENUM'
          ,'amended_ind:invalid_zero_1_bk:ENUM'
          ,'final_filing_ind:invalid_zero_1_bk:ENUM'
          ,'short_plan_yr_ind:invalid_zero_1_bk:ENUM'
          ,'collective_bargain_ind:invalid_zero_1_bk:ENUM'
          ,'f5558_application_filed_ind:invalid_zero_1_bk:ENUM'
          ,'ext_automatic_ind:invalid_zero_1_bk:ENUM'
          ,'dfvc_program_ind:invalid_zero_1_bk:ENUM'
          ,'ext_special_ind:invalid_zero_1_bk:ENUM'
          ,'plan_name:invalid_name:CUSTOM'
          ,'spons_dfe_pn:invalid_numeric:CUSTOM'
          ,'plan_eff_date:invalid_pastdate:CUSTOM'
          ,'sponsor_dfe_name:invalid_name:CUSTOM'
          ,'spons_dfe_dba_name:invalid_name:CUSTOM'
          ,'spons_dfe_care_of_name:invalid_name:CUSTOM'
          ,'spons_dfe_mail_us_address1:invalid_dfe_mail_us_address:CUSTOM'
          ,'spons_dfe_mail_us_city:invalid_alpha_sp:ALLOW'
          ,'spons_dfe_mail_us_state:invalid_state:CUSTOM'
          ,'spons_dfe_mail_us_zip:invalid_full_zip:CUSTOM'
          ,'spons_dfe_mail_foreign_addr1:invalid_dfe_mail_foreign_addr:CUSTOM'
          ,'spons_dfe_mail_foreign_city:invalid_alphablank:ALLOW'
          ,'spons_dfe_mail_forgn_prov_st:invalid_alphablank:ALLOW'
          ,'spons_dfe_mail_foreign_cntry:invalid_alphablank:ALLOW'
          ,'spons_dfe_mail_forgn_postal_cd:invalid_alpha_numeric_blank:ALLOW'
          ,'spons_dfe_loc_us_address1:invalid_dfe_loc_us_address:CUSTOM'
          ,'spons_dfe_loc_us_city:invalid_alpha_sp:ALLOW'
          ,'spons_dfe_loc_us_state:invalid_state:CUSTOM'
          ,'spons_dfe_loc_us_zip:invalid_full_zip:CUSTOM'
          ,'spons_dfe_loc_foreign_address1:invalid_dfe_loc_foreign_address:CUSTOM'
          ,'spons_dfe_loc_foreign_city:invalid_alphablank:ALLOW'
          ,'spons_dfe_loc_forgn_prov_st:invalid_alphablank:ALLOW'
          ,'spons_dfe_loc_foreign_cntry:invalid_alphablank:ALLOW'
          ,'spons_dfe_loc_forgn_postal_cd:invalid_alpha_numeric_blank:ALLOW'
          ,'spons_dfe_phone_num:invalid_phone:CUSTOM'
          ,'business_code:invalid_numeric:CUSTOM'
          ,'admin_name:invalid_name:CUSTOM'
          ,'admin_care_of_name:invalid_name:CUSTOM'
          ,'admin_us_address1:invalid_admin_us_address:CUSTOM'
          ,'admin_us_city:invalid_alpha_sp:ALLOW'
          ,'admin_us_state:invalid_state:CUSTOM'
          ,'admin_us_zip:invalid_full_zip:CUSTOM'
          ,'admin_foreign_address1:invalid_admin_foreign_address:CUSTOM'
          ,'admin_foreign_city:invalid_alphablank:ALLOW'
          ,'admin_foreign_prov_state:invalid_alphablank:ALLOW'
          ,'admin_foreign_cntry:invalid_alphablank:ALLOW'
          ,'admin_foreign_postal_cd:invalid_alpha_numeric_blank:ALLOW'
          ,'admin_ein:invalid_numeric:CUSTOM'
          ,'admin_phone_num:invalid_phone:CUSTOM'
          ,'last_rpt_spons_name:invalid_name:CUSTOM'
          ,'last_rpt_spons_ein:invalid_numeric:CUSTOM'
          ,'last_rpt_plan_num:invalid_numeric:CUSTOM'
          ,'admin_signed_date:invalid_pastdate:CUSTOM'
          ,'admin_signed_name:invalid_name:CUSTOM'
          ,'spons_signed_date:invalid_pastdate:CUSTOM'
          ,'spons_signed_name:invalid_name:CUSTOM'
          ,'dfe_signed_date:invalid_pastdate:CUSTOM'
          ,'dfe_signed_name:invalid_name:CUSTOM'
          ,'tot_partcp_boy_cnt:invalid_numeric:CUSTOM'
          ,'tot_active_partcp_cnt:invalid_numeric:CUSTOM'
          ,'rtd_sep_partcp_rcvg_cnt:invalid_numeric:CUSTOM'
          ,'rtd_sep_partcp_fut_cnt:invalid_numeric:CUSTOM'
          ,'subtl_act_rtd_sep_cnt:invalid_numeric:CUSTOM'
          ,'benef_rcvg_bnft_cnt:invalid_numeric:CUSTOM'
          ,'tot_act_rtd_sep_benef_cnt:invalid_numeric:CUSTOM'
          ,'partcp_account_bal_cnt:invalid_numeric:CUSTOM'
          ,'sep_partcp_partl_vstd_cnt:invalid_numeric:CUSTOM'
          ,'contrib_emplrs_cnt:invalid_numeric:CUSTOM'
          ,'type_pension_bnft_code:invalid_type_pension_bnft_code:ALLOW'
          ,'type_welfare_bnft_code:invalid_type_welfare_bnft_code:ALLOW'
          ,'funding_insurance_ind:invalid_zero_1_bk:ENUM'
          ,'funding_sec412_ind:invalid_zero_1_bk:ENUM'
          ,'funding_trust_ind:invalid_zero_1_bk:ENUM'
          ,'funding_gen_asset_ind:invalid_zero_1_bk:ENUM'
          ,'benefit_insurance_ind:invalid_zero_1_bk:ENUM'
          ,'benefit_sec412_ind:invalid_zero_1_bk:ENUM'
          ,'benefit_trust_ind:invalid_zero_1_bk:ENUM'
          ,'benefit_gen_asset_ind:invalid_zero_1_bk:ENUM'
          ,'sch_r_attached_ind:invalid_zero_1_bk:ENUM'
          ,'sch_mb_attached_ind:invalid_zero_1_bk:ENUM'
          ,'sch_sb_attached_ind:invalid_zero_1_bk:ENUM'
          ,'sch_h_attached_ind:invalid_zero_1_bk:ENUM'
          ,'sch_i_attached_ind:invalid_zero_1_bk:ENUM'
          ,'sch_a_attached_ind:invalid_zero_1_bk:ENUM'
          ,'num_sch_a_attached_cnt:invalid_numeric:CUSTOM'
          ,'sch_c_attached_ind:invalid_zero_1_bk:ENUM'
          ,'sch_d_attached_ind:invalid_zero_1_bk:ENUM'
          ,'sch_g_attached_ind:invalid_zero_1_bk:ENUM'
          ,'filing_status:invalid_filing_status:ENUM'
          ,'date_received:invalid_generaldate:CUSTOM'
          ,'admin_phone_num_foreign:invalid_phone:CUSTOM'
          ,'spons_dfe_phone_num_foreign:invalid_phone:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Raw_Fields.InvalidMessage_ack_id(1)
          ,Raw_Fields.InvalidMessage_form_plan_year_begin_date(1)
          ,Raw_Fields.InvalidMessage_form_tax_prd(1)
          ,Raw_Fields.InvalidMessage_type_plan_entity_cd(1)
          ,Raw_Fields.InvalidMessage_type_dfe_plan_entity_cd(1)
          ,Raw_Fields.InvalidMessage_initial_filing_ind(1)
          ,Raw_Fields.InvalidMessage_amended_ind(1)
          ,Raw_Fields.InvalidMessage_final_filing_ind(1)
          ,Raw_Fields.InvalidMessage_short_plan_yr_ind(1)
          ,Raw_Fields.InvalidMessage_collective_bargain_ind(1)
          ,Raw_Fields.InvalidMessage_f5558_application_filed_ind(1)
          ,Raw_Fields.InvalidMessage_ext_automatic_ind(1)
          ,Raw_Fields.InvalidMessage_dfvc_program_ind(1)
          ,Raw_Fields.InvalidMessage_ext_special_ind(1)
          ,Raw_Fields.InvalidMessage_plan_name(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_pn(1)
          ,Raw_Fields.InvalidMessage_plan_eff_date(1)
          ,Raw_Fields.InvalidMessage_sponsor_dfe_name(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_dba_name(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_care_of_name(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_mail_us_address1(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_mail_us_city(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_mail_us_state(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_mail_us_zip(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_mail_foreign_addr1(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_mail_foreign_city(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_mail_forgn_prov_st(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_mail_foreign_cntry(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_mail_forgn_postal_cd(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_loc_us_address1(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_loc_us_city(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_loc_us_state(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_loc_us_zip(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_loc_foreign_address1(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_loc_foreign_city(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_loc_forgn_prov_st(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_loc_foreign_cntry(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_loc_forgn_postal_cd(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_phone_num(1)
          ,Raw_Fields.InvalidMessage_business_code(1)
          ,Raw_Fields.InvalidMessage_admin_name(1)
          ,Raw_Fields.InvalidMessage_admin_care_of_name(1)
          ,Raw_Fields.InvalidMessage_admin_us_address1(1)
          ,Raw_Fields.InvalidMessage_admin_us_city(1)
          ,Raw_Fields.InvalidMessage_admin_us_state(1)
          ,Raw_Fields.InvalidMessage_admin_us_zip(1)
          ,Raw_Fields.InvalidMessage_admin_foreign_address1(1)
          ,Raw_Fields.InvalidMessage_admin_foreign_city(1)
          ,Raw_Fields.InvalidMessage_admin_foreign_prov_state(1)
          ,Raw_Fields.InvalidMessage_admin_foreign_cntry(1)
          ,Raw_Fields.InvalidMessage_admin_foreign_postal_cd(1)
          ,Raw_Fields.InvalidMessage_admin_ein(1)
          ,Raw_Fields.InvalidMessage_admin_phone_num(1)
          ,Raw_Fields.InvalidMessage_last_rpt_spons_name(1)
          ,Raw_Fields.InvalidMessage_last_rpt_spons_ein(1)
          ,Raw_Fields.InvalidMessage_last_rpt_plan_num(1)
          ,Raw_Fields.InvalidMessage_admin_signed_date(1)
          ,Raw_Fields.InvalidMessage_admin_signed_name(1)
          ,Raw_Fields.InvalidMessage_spons_signed_date(1)
          ,Raw_Fields.InvalidMessage_spons_signed_name(1)
          ,Raw_Fields.InvalidMessage_dfe_signed_date(1)
          ,Raw_Fields.InvalidMessage_dfe_signed_name(1)
          ,Raw_Fields.InvalidMessage_tot_partcp_boy_cnt(1)
          ,Raw_Fields.InvalidMessage_tot_active_partcp_cnt(1)
          ,Raw_Fields.InvalidMessage_rtd_sep_partcp_rcvg_cnt(1)
          ,Raw_Fields.InvalidMessage_rtd_sep_partcp_fut_cnt(1)
          ,Raw_Fields.InvalidMessage_subtl_act_rtd_sep_cnt(1)
          ,Raw_Fields.InvalidMessage_benef_rcvg_bnft_cnt(1)
          ,Raw_Fields.InvalidMessage_tot_act_rtd_sep_benef_cnt(1)
          ,Raw_Fields.InvalidMessage_partcp_account_bal_cnt(1)
          ,Raw_Fields.InvalidMessage_sep_partcp_partl_vstd_cnt(1)
          ,Raw_Fields.InvalidMessage_contrib_emplrs_cnt(1)
          ,Raw_Fields.InvalidMessage_type_pension_bnft_code(1)
          ,Raw_Fields.InvalidMessage_type_welfare_bnft_code(1)
          ,Raw_Fields.InvalidMessage_funding_insurance_ind(1)
          ,Raw_Fields.InvalidMessage_funding_sec412_ind(1)
          ,Raw_Fields.InvalidMessage_funding_trust_ind(1)
          ,Raw_Fields.InvalidMessage_funding_gen_asset_ind(1)
          ,Raw_Fields.InvalidMessage_benefit_insurance_ind(1)
          ,Raw_Fields.InvalidMessage_benefit_sec412_ind(1)
          ,Raw_Fields.InvalidMessage_benefit_trust_ind(1)
          ,Raw_Fields.InvalidMessage_benefit_gen_asset_ind(1)
          ,Raw_Fields.InvalidMessage_sch_r_attached_ind(1)
          ,Raw_Fields.InvalidMessage_sch_mb_attached_ind(1)
          ,Raw_Fields.InvalidMessage_sch_sb_attached_ind(1)
          ,Raw_Fields.InvalidMessage_sch_h_attached_ind(1)
          ,Raw_Fields.InvalidMessage_sch_i_attached_ind(1)
          ,Raw_Fields.InvalidMessage_sch_a_attached_ind(1)
          ,Raw_Fields.InvalidMessage_num_sch_a_attached_cnt(1)
          ,Raw_Fields.InvalidMessage_sch_c_attached_ind(1)
          ,Raw_Fields.InvalidMessage_sch_d_attached_ind(1)
          ,Raw_Fields.InvalidMessage_sch_g_attached_ind(1)
          ,Raw_Fields.InvalidMessage_filing_status(1)
          ,Raw_Fields.InvalidMessage_date_received(1)
          ,Raw_Fields.InvalidMessage_admin_phone_num_foreign(1)
          ,Raw_Fields.InvalidMessage_spons_dfe_phone_num_foreign(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ack_id_ALLOW_ErrorCount
          ,le.form_plan_year_begin_date_CUSTOM_ErrorCount
          ,le.form_tax_prd_CUSTOM_ErrorCount
          ,le.type_plan_entity_cd_ENUM_ErrorCount
          ,le.type_dfe_plan_entity_cd_ENUM_ErrorCount
          ,le.initial_filing_ind_ENUM_ErrorCount
          ,le.amended_ind_ENUM_ErrorCount
          ,le.final_filing_ind_ENUM_ErrorCount
          ,le.short_plan_yr_ind_ENUM_ErrorCount
          ,le.collective_bargain_ind_ENUM_ErrorCount
          ,le.f5558_application_filed_ind_ENUM_ErrorCount
          ,le.ext_automatic_ind_ENUM_ErrorCount
          ,le.dfvc_program_ind_ENUM_ErrorCount
          ,le.ext_special_ind_ENUM_ErrorCount
          ,le.plan_name_CUSTOM_ErrorCount
          ,le.spons_dfe_pn_CUSTOM_ErrorCount
          ,le.plan_eff_date_CUSTOM_ErrorCount
          ,le.sponsor_dfe_name_CUSTOM_ErrorCount
          ,le.spons_dfe_dba_name_CUSTOM_ErrorCount
          ,le.spons_dfe_care_of_name_CUSTOM_ErrorCount
          ,le.spons_dfe_mail_us_address1_CUSTOM_ErrorCount
          ,le.spons_dfe_mail_us_city_ALLOW_ErrorCount
          ,le.spons_dfe_mail_us_state_CUSTOM_ErrorCount
          ,le.spons_dfe_mail_us_zip_CUSTOM_ErrorCount
          ,le.spons_dfe_mail_foreign_addr1_CUSTOM_ErrorCount
          ,le.spons_dfe_mail_foreign_city_ALLOW_ErrorCount
          ,le.spons_dfe_mail_forgn_prov_st_ALLOW_ErrorCount
          ,le.spons_dfe_mail_foreign_cntry_ALLOW_ErrorCount
          ,le.spons_dfe_mail_forgn_postal_cd_ALLOW_ErrorCount
          ,le.spons_dfe_loc_us_address1_CUSTOM_ErrorCount
          ,le.spons_dfe_loc_us_city_ALLOW_ErrorCount
          ,le.spons_dfe_loc_us_state_CUSTOM_ErrorCount
          ,le.spons_dfe_loc_us_zip_CUSTOM_ErrorCount
          ,le.spons_dfe_loc_foreign_address1_CUSTOM_ErrorCount
          ,le.spons_dfe_loc_foreign_city_ALLOW_ErrorCount
          ,le.spons_dfe_loc_forgn_prov_st_ALLOW_ErrorCount
          ,le.spons_dfe_loc_foreign_cntry_ALLOW_ErrorCount
          ,le.spons_dfe_loc_forgn_postal_cd_ALLOW_ErrorCount
          ,le.spons_dfe_phone_num_CUSTOM_ErrorCount
          ,le.business_code_CUSTOM_ErrorCount
          ,le.admin_name_CUSTOM_ErrorCount
          ,le.admin_care_of_name_CUSTOM_ErrorCount
          ,le.admin_us_address1_CUSTOM_ErrorCount
          ,le.admin_us_city_ALLOW_ErrorCount
          ,le.admin_us_state_CUSTOM_ErrorCount
          ,le.admin_us_zip_CUSTOM_ErrorCount
          ,le.admin_foreign_address1_CUSTOM_ErrorCount
          ,le.admin_foreign_city_ALLOW_ErrorCount
          ,le.admin_foreign_prov_state_ALLOW_ErrorCount
          ,le.admin_foreign_cntry_ALLOW_ErrorCount
          ,le.admin_foreign_postal_cd_ALLOW_ErrorCount
          ,le.admin_ein_CUSTOM_ErrorCount
          ,le.admin_phone_num_CUSTOM_ErrorCount
          ,le.last_rpt_spons_name_CUSTOM_ErrorCount
          ,le.last_rpt_spons_ein_CUSTOM_ErrorCount
          ,le.last_rpt_plan_num_CUSTOM_ErrorCount
          ,le.admin_signed_date_CUSTOM_ErrorCount
          ,le.admin_signed_name_CUSTOM_ErrorCount
          ,le.spons_signed_date_CUSTOM_ErrorCount
          ,le.spons_signed_name_CUSTOM_ErrorCount
          ,le.dfe_signed_date_CUSTOM_ErrorCount
          ,le.dfe_signed_name_CUSTOM_ErrorCount
          ,le.tot_partcp_boy_cnt_CUSTOM_ErrorCount
          ,le.tot_active_partcp_cnt_CUSTOM_ErrorCount
          ,le.rtd_sep_partcp_rcvg_cnt_CUSTOM_ErrorCount
          ,le.rtd_sep_partcp_fut_cnt_CUSTOM_ErrorCount
          ,le.subtl_act_rtd_sep_cnt_CUSTOM_ErrorCount
          ,le.benef_rcvg_bnft_cnt_CUSTOM_ErrorCount
          ,le.tot_act_rtd_sep_benef_cnt_CUSTOM_ErrorCount
          ,le.partcp_account_bal_cnt_CUSTOM_ErrorCount
          ,le.sep_partcp_partl_vstd_cnt_CUSTOM_ErrorCount
          ,le.contrib_emplrs_cnt_CUSTOM_ErrorCount
          ,le.type_pension_bnft_code_ALLOW_ErrorCount
          ,le.type_welfare_bnft_code_ALLOW_ErrorCount
          ,le.funding_insurance_ind_ENUM_ErrorCount
          ,le.funding_sec412_ind_ENUM_ErrorCount
          ,le.funding_trust_ind_ENUM_ErrorCount
          ,le.funding_gen_asset_ind_ENUM_ErrorCount
          ,le.benefit_insurance_ind_ENUM_ErrorCount
          ,le.benefit_sec412_ind_ENUM_ErrorCount
          ,le.benefit_trust_ind_ENUM_ErrorCount
          ,le.benefit_gen_asset_ind_ENUM_ErrorCount
          ,le.sch_r_attached_ind_ENUM_ErrorCount
          ,le.sch_mb_attached_ind_ENUM_ErrorCount
          ,le.sch_sb_attached_ind_ENUM_ErrorCount
          ,le.sch_h_attached_ind_ENUM_ErrorCount
          ,le.sch_i_attached_ind_ENUM_ErrorCount
          ,le.sch_a_attached_ind_ENUM_ErrorCount
          ,le.num_sch_a_attached_cnt_CUSTOM_ErrorCount
          ,le.sch_c_attached_ind_ENUM_ErrorCount
          ,le.sch_d_attached_ind_ENUM_ErrorCount
          ,le.sch_g_attached_ind_ENUM_ErrorCount
          ,le.filing_status_ENUM_ErrorCount
          ,le.date_received_CUSTOM_ErrorCount
          ,le.admin_phone_num_foreign_CUSTOM_ErrorCount
          ,le.spons_dfe_phone_num_foreign_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ack_id_ALLOW_ErrorCount
          ,le.form_plan_year_begin_date_CUSTOM_ErrorCount
          ,le.form_tax_prd_CUSTOM_ErrorCount
          ,le.type_plan_entity_cd_ENUM_ErrorCount
          ,le.type_dfe_plan_entity_cd_ENUM_ErrorCount
          ,le.initial_filing_ind_ENUM_ErrorCount
          ,le.amended_ind_ENUM_ErrorCount
          ,le.final_filing_ind_ENUM_ErrorCount
          ,le.short_plan_yr_ind_ENUM_ErrorCount
          ,le.collective_bargain_ind_ENUM_ErrorCount
          ,le.f5558_application_filed_ind_ENUM_ErrorCount
          ,le.ext_automatic_ind_ENUM_ErrorCount
          ,le.dfvc_program_ind_ENUM_ErrorCount
          ,le.ext_special_ind_ENUM_ErrorCount
          ,le.plan_name_CUSTOM_ErrorCount
          ,le.spons_dfe_pn_CUSTOM_ErrorCount
          ,le.plan_eff_date_CUSTOM_ErrorCount
          ,le.sponsor_dfe_name_CUSTOM_ErrorCount
          ,le.spons_dfe_dba_name_CUSTOM_ErrorCount
          ,le.spons_dfe_care_of_name_CUSTOM_ErrorCount
          ,le.spons_dfe_mail_us_address1_CUSTOM_ErrorCount
          ,le.spons_dfe_mail_us_city_ALLOW_ErrorCount
          ,le.spons_dfe_mail_us_state_CUSTOM_ErrorCount
          ,le.spons_dfe_mail_us_zip_CUSTOM_ErrorCount
          ,le.spons_dfe_mail_foreign_addr1_CUSTOM_ErrorCount
          ,le.spons_dfe_mail_foreign_city_ALLOW_ErrorCount
          ,le.spons_dfe_mail_forgn_prov_st_ALLOW_ErrorCount
          ,le.spons_dfe_mail_foreign_cntry_ALLOW_ErrorCount
          ,le.spons_dfe_mail_forgn_postal_cd_ALLOW_ErrorCount
          ,le.spons_dfe_loc_us_address1_CUSTOM_ErrorCount
          ,le.spons_dfe_loc_us_city_ALLOW_ErrorCount
          ,le.spons_dfe_loc_us_state_CUSTOM_ErrorCount
          ,le.spons_dfe_loc_us_zip_CUSTOM_ErrorCount
          ,le.spons_dfe_loc_foreign_address1_CUSTOM_ErrorCount
          ,le.spons_dfe_loc_foreign_city_ALLOW_ErrorCount
          ,le.spons_dfe_loc_forgn_prov_st_ALLOW_ErrorCount
          ,le.spons_dfe_loc_foreign_cntry_ALLOW_ErrorCount
          ,le.spons_dfe_loc_forgn_postal_cd_ALLOW_ErrorCount
          ,le.spons_dfe_phone_num_CUSTOM_ErrorCount
          ,le.business_code_CUSTOM_ErrorCount
          ,le.admin_name_CUSTOM_ErrorCount
          ,le.admin_care_of_name_CUSTOM_ErrorCount
          ,le.admin_us_address1_CUSTOM_ErrorCount
          ,le.admin_us_city_ALLOW_ErrorCount
          ,le.admin_us_state_CUSTOM_ErrorCount
          ,le.admin_us_zip_CUSTOM_ErrorCount
          ,le.admin_foreign_address1_CUSTOM_ErrorCount
          ,le.admin_foreign_city_ALLOW_ErrorCount
          ,le.admin_foreign_prov_state_ALLOW_ErrorCount
          ,le.admin_foreign_cntry_ALLOW_ErrorCount
          ,le.admin_foreign_postal_cd_ALLOW_ErrorCount
          ,le.admin_ein_CUSTOM_ErrorCount
          ,le.admin_phone_num_CUSTOM_ErrorCount
          ,le.last_rpt_spons_name_CUSTOM_ErrorCount
          ,le.last_rpt_spons_ein_CUSTOM_ErrorCount
          ,le.last_rpt_plan_num_CUSTOM_ErrorCount
          ,le.admin_signed_date_CUSTOM_ErrorCount
          ,le.admin_signed_name_CUSTOM_ErrorCount
          ,le.spons_signed_date_CUSTOM_ErrorCount
          ,le.spons_signed_name_CUSTOM_ErrorCount
          ,le.dfe_signed_date_CUSTOM_ErrorCount
          ,le.dfe_signed_name_CUSTOM_ErrorCount
          ,le.tot_partcp_boy_cnt_CUSTOM_ErrorCount
          ,le.tot_active_partcp_cnt_CUSTOM_ErrorCount
          ,le.rtd_sep_partcp_rcvg_cnt_CUSTOM_ErrorCount
          ,le.rtd_sep_partcp_fut_cnt_CUSTOM_ErrorCount
          ,le.subtl_act_rtd_sep_cnt_CUSTOM_ErrorCount
          ,le.benef_rcvg_bnft_cnt_CUSTOM_ErrorCount
          ,le.tot_act_rtd_sep_benef_cnt_CUSTOM_ErrorCount
          ,le.partcp_account_bal_cnt_CUSTOM_ErrorCount
          ,le.sep_partcp_partl_vstd_cnt_CUSTOM_ErrorCount
          ,le.contrib_emplrs_cnt_CUSTOM_ErrorCount
          ,le.type_pension_bnft_code_ALLOW_ErrorCount
          ,le.type_welfare_bnft_code_ALLOW_ErrorCount
          ,le.funding_insurance_ind_ENUM_ErrorCount
          ,le.funding_sec412_ind_ENUM_ErrorCount
          ,le.funding_trust_ind_ENUM_ErrorCount
          ,le.funding_gen_asset_ind_ENUM_ErrorCount
          ,le.benefit_insurance_ind_ENUM_ErrorCount
          ,le.benefit_sec412_ind_ENUM_ErrorCount
          ,le.benefit_trust_ind_ENUM_ErrorCount
          ,le.benefit_gen_asset_ind_ENUM_ErrorCount
          ,le.sch_r_attached_ind_ENUM_ErrorCount
          ,le.sch_mb_attached_ind_ENUM_ErrorCount
          ,le.sch_sb_attached_ind_ENUM_ErrorCount
          ,le.sch_h_attached_ind_ENUM_ErrorCount
          ,le.sch_i_attached_ind_ENUM_ErrorCount
          ,le.sch_a_attached_ind_ENUM_ErrorCount
          ,le.num_sch_a_attached_cnt_CUSTOM_ErrorCount
          ,le.sch_c_attached_ind_ENUM_ErrorCount
          ,le.sch_d_attached_ind_ENUM_ErrorCount
          ,le.sch_g_attached_ind_ENUM_ErrorCount
          ,le.filing_status_ENUM_ErrorCount
          ,le.date_received_CUSTOM_ErrorCount
          ,le.admin_phone_num_foreign_CUSTOM_ErrorCount
          ,le.spons_dfe_phone_num_foreign_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Raw_hygiene(PROJECT(h, Raw_Layout_IRS5500));
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
          ,'ack_id:' + getFieldTypeText(h.ack_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'form_plan_year_begin_date:' + getFieldTypeText(h.form_plan_year_begin_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'form_tax_prd:' + getFieldTypeText(h.form_tax_prd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_plan_entity_cd:' + getFieldTypeText(h.type_plan_entity_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_dfe_plan_entity_cd:' + getFieldTypeText(h.type_dfe_plan_entity_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'initial_filing_ind:' + getFieldTypeText(h.initial_filing_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amended_ind:' + getFieldTypeText(h.amended_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'final_filing_ind:' + getFieldTypeText(h.final_filing_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'short_plan_yr_ind:' + getFieldTypeText(h.short_plan_yr_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'collective_bargain_ind:' + getFieldTypeText(h.collective_bargain_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'f5558_application_filed_ind:' + getFieldTypeText(h.f5558_application_filed_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ext_automatic_ind:' + getFieldTypeText(h.ext_automatic_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dfvc_program_ind:' + getFieldTypeText(h.dfvc_program_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ext_special_ind:' + getFieldTypeText(h.ext_special_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ext_special_text:' + getFieldTypeText(h.ext_special_text) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plan_name:' + getFieldTypeText(h.plan_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_pn:' + getFieldTypeText(h.spons_dfe_pn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plan_eff_date:' + getFieldTypeText(h.plan_eff_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sponsor_dfe_name:' + getFieldTypeText(h.sponsor_dfe_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_dba_name:' + getFieldTypeText(h.spons_dfe_dba_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_care_of_name:' + getFieldTypeText(h.spons_dfe_care_of_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_us_address1:' + getFieldTypeText(h.spons_dfe_mail_us_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_us_address2:' + getFieldTypeText(h.spons_dfe_mail_us_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_us_city:' + getFieldTypeText(h.spons_dfe_mail_us_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_us_state:' + getFieldTypeText(h.spons_dfe_mail_us_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_us_zip:' + getFieldTypeText(h.spons_dfe_mail_us_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_foreign_addr1:' + getFieldTypeText(h.spons_dfe_mail_foreign_addr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_foreign_addr2:' + getFieldTypeText(h.spons_dfe_mail_foreign_addr2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_foreign_city:' + getFieldTypeText(h.spons_dfe_mail_foreign_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_forgn_prov_st:' + getFieldTypeText(h.spons_dfe_mail_forgn_prov_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_foreign_cntry:' + getFieldTypeText(h.spons_dfe_mail_foreign_cntry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_mail_forgn_postal_cd:' + getFieldTypeText(h.spons_dfe_mail_forgn_postal_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_us_address1:' + getFieldTypeText(h.spons_dfe_loc_us_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_us_address2:' + getFieldTypeText(h.spons_dfe_loc_us_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_us_city:' + getFieldTypeText(h.spons_dfe_loc_us_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_us_state:' + getFieldTypeText(h.spons_dfe_loc_us_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_us_zip:' + getFieldTypeText(h.spons_dfe_loc_us_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_foreign_address1:' + getFieldTypeText(h.spons_dfe_loc_foreign_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_foreign_address2:' + getFieldTypeText(h.spons_dfe_loc_foreign_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_foreign_city:' + getFieldTypeText(h.spons_dfe_loc_foreign_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_forgn_prov_st:' + getFieldTypeText(h.spons_dfe_loc_forgn_prov_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_foreign_cntry:' + getFieldTypeText(h.spons_dfe_loc_foreign_cntry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_loc_forgn_postal_cd:' + getFieldTypeText(h.spons_dfe_loc_forgn_postal_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_ein:' + getFieldTypeText(h.spons_dfe_ein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_phone_num:' + getFieldTypeText(h.spons_dfe_phone_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_code:' + getFieldTypeText(h.business_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_name:' + getFieldTypeText(h.admin_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_care_of_name:' + getFieldTypeText(h.admin_care_of_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_us_address1:' + getFieldTypeText(h.admin_us_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_us_address2:' + getFieldTypeText(h.admin_us_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_us_city:' + getFieldTypeText(h.admin_us_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_us_state:' + getFieldTypeText(h.admin_us_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_us_zip:' + getFieldTypeText(h.admin_us_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_foreign_address1:' + getFieldTypeText(h.admin_foreign_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_foreign_address2:' + getFieldTypeText(h.admin_foreign_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_foreign_city:' + getFieldTypeText(h.admin_foreign_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_foreign_prov_state:' + getFieldTypeText(h.admin_foreign_prov_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_foreign_cntry:' + getFieldTypeText(h.admin_foreign_cntry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_foreign_postal_cd:' + getFieldTypeText(h.admin_foreign_postal_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_ein:' + getFieldTypeText(h.admin_ein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_phone_num:' + getFieldTypeText(h.admin_phone_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_rpt_spons_name:' + getFieldTypeText(h.last_rpt_spons_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_rpt_spons_ein:' + getFieldTypeText(h.last_rpt_spons_ein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_rpt_plan_num:' + getFieldTypeText(h.last_rpt_plan_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_signed_date:' + getFieldTypeText(h.admin_signed_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_signed_name:' + getFieldTypeText(h.admin_signed_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_signed_date:' + getFieldTypeText(h.spons_signed_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_signed_name:' + getFieldTypeText(h.spons_signed_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dfe_signed_date:' + getFieldTypeText(h.dfe_signed_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dfe_signed_name:' + getFieldTypeText(h.dfe_signed_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tot_partcp_boy_cnt:' + getFieldTypeText(h.tot_partcp_boy_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tot_active_partcp_cnt:' + getFieldTypeText(h.tot_active_partcp_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rtd_sep_partcp_rcvg_cnt:' + getFieldTypeText(h.rtd_sep_partcp_rcvg_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rtd_sep_partcp_fut_cnt:' + getFieldTypeText(h.rtd_sep_partcp_fut_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subtl_act_rtd_sep_cnt:' + getFieldTypeText(h.subtl_act_rtd_sep_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'benef_rcvg_bnft_cnt:' + getFieldTypeText(h.benef_rcvg_bnft_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tot_act_rtd_sep_benef_cnt:' + getFieldTypeText(h.tot_act_rtd_sep_benef_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'partcp_account_bal_cnt:' + getFieldTypeText(h.partcp_account_bal_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sep_partcp_partl_vstd_cnt:' + getFieldTypeText(h.sep_partcp_partl_vstd_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contrib_emplrs_cnt:' + getFieldTypeText(h.contrib_emplrs_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_pension_bnft_code:' + getFieldTypeText(h.type_pension_bnft_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_welfare_bnft_code:' + getFieldTypeText(h.type_welfare_bnft_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'funding_insurance_ind:' + getFieldTypeText(h.funding_insurance_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'funding_sec412_ind:' + getFieldTypeText(h.funding_sec412_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'funding_trust_ind:' + getFieldTypeText(h.funding_trust_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'funding_gen_asset_ind:' + getFieldTypeText(h.funding_gen_asset_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'benefit_insurance_ind:' + getFieldTypeText(h.benefit_insurance_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'benefit_sec412_ind:' + getFieldTypeText(h.benefit_sec412_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'benefit_trust_ind:' + getFieldTypeText(h.benefit_trust_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'benefit_gen_asset_ind:' + getFieldTypeText(h.benefit_gen_asset_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sch_r_attached_ind:' + getFieldTypeText(h.sch_r_attached_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sch_mb_attached_ind:' + getFieldTypeText(h.sch_mb_attached_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sch_sb_attached_ind:' + getFieldTypeText(h.sch_sb_attached_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sch_h_attached_ind:' + getFieldTypeText(h.sch_h_attached_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sch_i_attached_ind:' + getFieldTypeText(h.sch_i_attached_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sch_a_attached_ind:' + getFieldTypeText(h.sch_a_attached_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'num_sch_a_attached_cnt:' + getFieldTypeText(h.num_sch_a_attached_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sch_c_attached_ind:' + getFieldTypeText(h.sch_c_attached_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sch_d_attached_ind:' + getFieldTypeText(h.sch_d_attached_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sch_g_attached_ind:' + getFieldTypeText(h.sch_g_attached_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_status:' + getFieldTypeText(h.filing_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_received:' + getFieldTypeText(h.date_received) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'valid_admin_signature:' + getFieldTypeText(h.valid_admin_signature) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'valid_dfe_signature:' + getFieldTypeText(h.valid_dfe_signature) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'valid_sponsor_signature:' + getFieldTypeText(h.valid_sponsor_signature) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_phone_num_foreign:' + getFieldTypeText(h.admin_phone_num_foreign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spons_dfe_phone_num_foreign:' + getFieldTypeText(h.spons_dfe_phone_num_foreign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_name_same_spon_ind:' + getFieldTypeText(h.admin_name_same_spon_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_address_same_spon_ind:' + getFieldTypeText(h.admin_address_same_spon_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_name:' + getFieldTypeText(h.preparer_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_firm_name:' + getFieldTypeText(h.preparer_firm_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_us_address1:' + getFieldTypeText(h.preparer_us_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_us_address2:' + getFieldTypeText(h.preparer_us_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_us_city:' + getFieldTypeText(h.preparer_us_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_us_state:' + getFieldTypeText(h.preparer_us_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_us_zip:' + getFieldTypeText(h.preparer_us_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_foreign_address1:' + getFieldTypeText(h.preparer_foreign_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_foreign_address2:' + getFieldTypeText(h.preparer_foreign_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_foreign_city:' + getFieldTypeText(h.preparer_foreign_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_foreign_prov_state:' + getFieldTypeText(h.preparer_foreign_prov_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_foreign_cntry:' + getFieldTypeText(h.preparer_foreign_cntry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_foreign_postal_cd:' + getFieldTypeText(h.preparer_foreign_postal_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_phone_num:' + getFieldTypeText(h.preparer_phone_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'preparer_phone_num_foreign:' + getFieldTypeText(h.preparer_phone_num_foreign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ack_id_cnt
          ,le.populated_form_plan_year_begin_date_cnt
          ,le.populated_form_tax_prd_cnt
          ,le.populated_type_plan_entity_cd_cnt
          ,le.populated_type_dfe_plan_entity_cd_cnt
          ,le.populated_initial_filing_ind_cnt
          ,le.populated_amended_ind_cnt
          ,le.populated_final_filing_ind_cnt
          ,le.populated_short_plan_yr_ind_cnt
          ,le.populated_collective_bargain_ind_cnt
          ,le.populated_f5558_application_filed_ind_cnt
          ,le.populated_ext_automatic_ind_cnt
          ,le.populated_dfvc_program_ind_cnt
          ,le.populated_ext_special_ind_cnt
          ,le.populated_ext_special_text_cnt
          ,le.populated_plan_name_cnt
          ,le.populated_spons_dfe_pn_cnt
          ,le.populated_plan_eff_date_cnt
          ,le.populated_sponsor_dfe_name_cnt
          ,le.populated_spons_dfe_dba_name_cnt
          ,le.populated_spons_dfe_care_of_name_cnt
          ,le.populated_spons_dfe_mail_us_address1_cnt
          ,le.populated_spons_dfe_mail_us_address2_cnt
          ,le.populated_spons_dfe_mail_us_city_cnt
          ,le.populated_spons_dfe_mail_us_state_cnt
          ,le.populated_spons_dfe_mail_us_zip_cnt
          ,le.populated_spons_dfe_mail_foreign_addr1_cnt
          ,le.populated_spons_dfe_mail_foreign_addr2_cnt
          ,le.populated_spons_dfe_mail_foreign_city_cnt
          ,le.populated_spons_dfe_mail_forgn_prov_st_cnt
          ,le.populated_spons_dfe_mail_foreign_cntry_cnt
          ,le.populated_spons_dfe_mail_forgn_postal_cd_cnt
          ,le.populated_spons_dfe_loc_us_address1_cnt
          ,le.populated_spons_dfe_loc_us_address2_cnt
          ,le.populated_spons_dfe_loc_us_city_cnt
          ,le.populated_spons_dfe_loc_us_state_cnt
          ,le.populated_spons_dfe_loc_us_zip_cnt
          ,le.populated_spons_dfe_loc_foreign_address1_cnt
          ,le.populated_spons_dfe_loc_foreign_address2_cnt
          ,le.populated_spons_dfe_loc_foreign_city_cnt
          ,le.populated_spons_dfe_loc_forgn_prov_st_cnt
          ,le.populated_spons_dfe_loc_foreign_cntry_cnt
          ,le.populated_spons_dfe_loc_forgn_postal_cd_cnt
          ,le.populated_spons_dfe_ein_cnt
          ,le.populated_spons_dfe_phone_num_cnt
          ,le.populated_business_code_cnt
          ,le.populated_admin_name_cnt
          ,le.populated_admin_care_of_name_cnt
          ,le.populated_admin_us_address1_cnt
          ,le.populated_admin_us_address2_cnt
          ,le.populated_admin_us_city_cnt
          ,le.populated_admin_us_state_cnt
          ,le.populated_admin_us_zip_cnt
          ,le.populated_admin_foreign_address1_cnt
          ,le.populated_admin_foreign_address2_cnt
          ,le.populated_admin_foreign_city_cnt
          ,le.populated_admin_foreign_prov_state_cnt
          ,le.populated_admin_foreign_cntry_cnt
          ,le.populated_admin_foreign_postal_cd_cnt
          ,le.populated_admin_ein_cnt
          ,le.populated_admin_phone_num_cnt
          ,le.populated_last_rpt_spons_name_cnt
          ,le.populated_last_rpt_spons_ein_cnt
          ,le.populated_last_rpt_plan_num_cnt
          ,le.populated_admin_signed_date_cnt
          ,le.populated_admin_signed_name_cnt
          ,le.populated_spons_signed_date_cnt
          ,le.populated_spons_signed_name_cnt
          ,le.populated_dfe_signed_date_cnt
          ,le.populated_dfe_signed_name_cnt
          ,le.populated_tot_partcp_boy_cnt_cnt
          ,le.populated_tot_active_partcp_cnt_cnt
          ,le.populated_rtd_sep_partcp_rcvg_cnt_cnt
          ,le.populated_rtd_sep_partcp_fut_cnt_cnt
          ,le.populated_subtl_act_rtd_sep_cnt_cnt
          ,le.populated_benef_rcvg_bnft_cnt_cnt
          ,le.populated_tot_act_rtd_sep_benef_cnt_cnt
          ,le.populated_partcp_account_bal_cnt_cnt
          ,le.populated_sep_partcp_partl_vstd_cnt_cnt
          ,le.populated_contrib_emplrs_cnt_cnt
          ,le.populated_type_pension_bnft_code_cnt
          ,le.populated_type_welfare_bnft_code_cnt
          ,le.populated_funding_insurance_ind_cnt
          ,le.populated_funding_sec412_ind_cnt
          ,le.populated_funding_trust_ind_cnt
          ,le.populated_funding_gen_asset_ind_cnt
          ,le.populated_benefit_insurance_ind_cnt
          ,le.populated_benefit_sec412_ind_cnt
          ,le.populated_benefit_trust_ind_cnt
          ,le.populated_benefit_gen_asset_ind_cnt
          ,le.populated_sch_r_attached_ind_cnt
          ,le.populated_sch_mb_attached_ind_cnt
          ,le.populated_sch_sb_attached_ind_cnt
          ,le.populated_sch_h_attached_ind_cnt
          ,le.populated_sch_i_attached_ind_cnt
          ,le.populated_sch_a_attached_ind_cnt
          ,le.populated_num_sch_a_attached_cnt_cnt
          ,le.populated_sch_c_attached_ind_cnt
          ,le.populated_sch_d_attached_ind_cnt
          ,le.populated_sch_g_attached_ind_cnt
          ,le.populated_filing_status_cnt
          ,le.populated_date_received_cnt
          ,le.populated_valid_admin_signature_cnt
          ,le.populated_valid_dfe_signature_cnt
          ,le.populated_valid_sponsor_signature_cnt
          ,le.populated_admin_phone_num_foreign_cnt
          ,le.populated_spons_dfe_phone_num_foreign_cnt
          ,le.populated_admin_name_same_spon_ind_cnt
          ,le.populated_admin_address_same_spon_ind_cnt
          ,le.populated_preparer_name_cnt
          ,le.populated_preparer_firm_name_cnt
          ,le.populated_preparer_us_address1_cnt
          ,le.populated_preparer_us_address2_cnt
          ,le.populated_preparer_us_city_cnt
          ,le.populated_preparer_us_state_cnt
          ,le.populated_preparer_us_zip_cnt
          ,le.populated_preparer_foreign_address1_cnt
          ,le.populated_preparer_foreign_address2_cnt
          ,le.populated_preparer_foreign_city_cnt
          ,le.populated_preparer_foreign_prov_state_cnt
          ,le.populated_preparer_foreign_cntry_cnt
          ,le.populated_preparer_foreign_postal_cd_cnt
          ,le.populated_preparer_phone_num_cnt
          ,le.populated_preparer_phone_num_foreign_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ack_id_pcnt
          ,le.populated_form_plan_year_begin_date_pcnt
          ,le.populated_form_tax_prd_pcnt
          ,le.populated_type_plan_entity_cd_pcnt
          ,le.populated_type_dfe_plan_entity_cd_pcnt
          ,le.populated_initial_filing_ind_pcnt
          ,le.populated_amended_ind_pcnt
          ,le.populated_final_filing_ind_pcnt
          ,le.populated_short_plan_yr_ind_pcnt
          ,le.populated_collective_bargain_ind_pcnt
          ,le.populated_f5558_application_filed_ind_pcnt
          ,le.populated_ext_automatic_ind_pcnt
          ,le.populated_dfvc_program_ind_pcnt
          ,le.populated_ext_special_ind_pcnt
          ,le.populated_ext_special_text_pcnt
          ,le.populated_plan_name_pcnt
          ,le.populated_spons_dfe_pn_pcnt
          ,le.populated_plan_eff_date_pcnt
          ,le.populated_sponsor_dfe_name_pcnt
          ,le.populated_spons_dfe_dba_name_pcnt
          ,le.populated_spons_dfe_care_of_name_pcnt
          ,le.populated_spons_dfe_mail_us_address1_pcnt
          ,le.populated_spons_dfe_mail_us_address2_pcnt
          ,le.populated_spons_dfe_mail_us_city_pcnt
          ,le.populated_spons_dfe_mail_us_state_pcnt
          ,le.populated_spons_dfe_mail_us_zip_pcnt
          ,le.populated_spons_dfe_mail_foreign_addr1_pcnt
          ,le.populated_spons_dfe_mail_foreign_addr2_pcnt
          ,le.populated_spons_dfe_mail_foreign_city_pcnt
          ,le.populated_spons_dfe_mail_forgn_prov_st_pcnt
          ,le.populated_spons_dfe_mail_foreign_cntry_pcnt
          ,le.populated_spons_dfe_mail_forgn_postal_cd_pcnt
          ,le.populated_spons_dfe_loc_us_address1_pcnt
          ,le.populated_spons_dfe_loc_us_address2_pcnt
          ,le.populated_spons_dfe_loc_us_city_pcnt
          ,le.populated_spons_dfe_loc_us_state_pcnt
          ,le.populated_spons_dfe_loc_us_zip_pcnt
          ,le.populated_spons_dfe_loc_foreign_address1_pcnt
          ,le.populated_spons_dfe_loc_foreign_address2_pcnt
          ,le.populated_spons_dfe_loc_foreign_city_pcnt
          ,le.populated_spons_dfe_loc_forgn_prov_st_pcnt
          ,le.populated_spons_dfe_loc_foreign_cntry_pcnt
          ,le.populated_spons_dfe_loc_forgn_postal_cd_pcnt
          ,le.populated_spons_dfe_ein_pcnt
          ,le.populated_spons_dfe_phone_num_pcnt
          ,le.populated_business_code_pcnt
          ,le.populated_admin_name_pcnt
          ,le.populated_admin_care_of_name_pcnt
          ,le.populated_admin_us_address1_pcnt
          ,le.populated_admin_us_address2_pcnt
          ,le.populated_admin_us_city_pcnt
          ,le.populated_admin_us_state_pcnt
          ,le.populated_admin_us_zip_pcnt
          ,le.populated_admin_foreign_address1_pcnt
          ,le.populated_admin_foreign_address2_pcnt
          ,le.populated_admin_foreign_city_pcnt
          ,le.populated_admin_foreign_prov_state_pcnt
          ,le.populated_admin_foreign_cntry_pcnt
          ,le.populated_admin_foreign_postal_cd_pcnt
          ,le.populated_admin_ein_pcnt
          ,le.populated_admin_phone_num_pcnt
          ,le.populated_last_rpt_spons_name_pcnt
          ,le.populated_last_rpt_spons_ein_pcnt
          ,le.populated_last_rpt_plan_num_pcnt
          ,le.populated_admin_signed_date_pcnt
          ,le.populated_admin_signed_name_pcnt
          ,le.populated_spons_signed_date_pcnt
          ,le.populated_spons_signed_name_pcnt
          ,le.populated_dfe_signed_date_pcnt
          ,le.populated_dfe_signed_name_pcnt
          ,le.populated_tot_partcp_boy_cnt_pcnt
          ,le.populated_tot_active_partcp_cnt_pcnt
          ,le.populated_rtd_sep_partcp_rcvg_cnt_pcnt
          ,le.populated_rtd_sep_partcp_fut_cnt_pcnt
          ,le.populated_subtl_act_rtd_sep_cnt_pcnt
          ,le.populated_benef_rcvg_bnft_cnt_pcnt
          ,le.populated_tot_act_rtd_sep_benef_cnt_pcnt
          ,le.populated_partcp_account_bal_cnt_pcnt
          ,le.populated_sep_partcp_partl_vstd_cnt_pcnt
          ,le.populated_contrib_emplrs_cnt_pcnt
          ,le.populated_type_pension_bnft_code_pcnt
          ,le.populated_type_welfare_bnft_code_pcnt
          ,le.populated_funding_insurance_ind_pcnt
          ,le.populated_funding_sec412_ind_pcnt
          ,le.populated_funding_trust_ind_pcnt
          ,le.populated_funding_gen_asset_ind_pcnt
          ,le.populated_benefit_insurance_ind_pcnt
          ,le.populated_benefit_sec412_ind_pcnt
          ,le.populated_benefit_trust_ind_pcnt
          ,le.populated_benefit_gen_asset_ind_pcnt
          ,le.populated_sch_r_attached_ind_pcnt
          ,le.populated_sch_mb_attached_ind_pcnt
          ,le.populated_sch_sb_attached_ind_pcnt
          ,le.populated_sch_h_attached_ind_pcnt
          ,le.populated_sch_i_attached_ind_pcnt
          ,le.populated_sch_a_attached_ind_pcnt
          ,le.populated_num_sch_a_attached_cnt_pcnt
          ,le.populated_sch_c_attached_ind_pcnt
          ,le.populated_sch_d_attached_ind_pcnt
          ,le.populated_sch_g_attached_ind_pcnt
          ,le.populated_filing_status_pcnt
          ,le.populated_date_received_pcnt
          ,le.populated_valid_admin_signature_pcnt
          ,le.populated_valid_dfe_signature_pcnt
          ,le.populated_valid_sponsor_signature_pcnt
          ,le.populated_admin_phone_num_foreign_pcnt
          ,le.populated_spons_dfe_phone_num_foreign_pcnt
          ,le.populated_admin_name_same_spon_ind_pcnt
          ,le.populated_admin_address_same_spon_ind_pcnt
          ,le.populated_preparer_name_pcnt
          ,le.populated_preparer_firm_name_pcnt
          ,le.populated_preparer_us_address1_pcnt
          ,le.populated_preparer_us_address2_pcnt
          ,le.populated_preparer_us_city_pcnt
          ,le.populated_preparer_us_state_pcnt
          ,le.populated_preparer_us_zip_pcnt
          ,le.populated_preparer_foreign_address1_pcnt
          ,le.populated_preparer_foreign_address2_pcnt
          ,le.populated_preparer_foreign_city_pcnt
          ,le.populated_preparer_foreign_prov_state_pcnt
          ,le.populated_preparer_foreign_cntry_pcnt
          ,le.populated_preparer_foreign_postal_cd_pcnt
          ,le.populated_preparer_phone_num_pcnt
          ,le.populated_preparer_phone_num_foreign_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,124,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Raw_Delta(prevDS, PROJECT(h, Raw_Layout_IRS5500));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),124,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Raw_Layout_IRS5500) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_IRS5500, Raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
