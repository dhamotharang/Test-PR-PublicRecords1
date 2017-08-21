//This is the code to execute in a builder window
#workunit('name','scrubs_FIDO.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Alpha 5');
IMPORT scrubs_FIDO,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  scrubs_FIDO.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* customer_account_sk_field */,/* platform_cd_field */,/* hh_id_field */,/* hh_name_field */,/* current_subaccount_id_field */,/* hist_subaccount_id_field */,/* subaccount_name_field */,/* mbs_gc_id_field */,/* mbs_reseller_parent_gc_id_field */,/* mbs_reseller_parent_company_id_field */,/* mbs_company_id_field */,/* mbs_billing_id_field */,/* mbs_product_id_field */,/* mbs_sub_product_id_field */,/* vc_id_field */,/* ins_account_field */,/* ins_account_suffix_field */,/* dyt_sub_acct_id_field */,/* ins_control_nbr_field */,/* ins_control_name_field */,/* ins_company_nbr_field */,/* ins_company_name_field */,/* dyt_account_id_field */,/* dyt_account_name_field */,/* dyt_customer_name_field */,/* mbs_reseller_parent_name_field */,/* cancel_reason_field */,/* internal_flag_field */,/* dummy_subaccount_flag_field */,/* primary_market_gen_1_field */,/* primary_market_cd_field */,/* primary_market_desc_field */,/* secondary_market_cd_field */,/* secondary_market_desc_field */,/* Sub_market_field */,/* sub_market_gen_1_field */,/* sub_market_gen_2_field */,/* segment_lead_field */,/* subaccount_status_field */,/* acc_application_type_field */,/* acc_company_type_field */,/* bussrv_crd_customer_field */,/* integrator_field */,/* migration_type_field */,/* aba_flag_field */,/* acquisition_tracking_field */,/* acquisition_tracking_Gen01_field */,/* acquisition_tracking_Gen02_field */,/* acquisition_tracking_Gen03_field */,/* new_subaccount_year_field */,/* new_subaccount_year_month_field */,/* new_hh_year_field */,/* new_hh_year_month_field */,/* subaccount_attrition_year_field */,/* subaccount_attrition_year_month_field */,/* hh_attrition_year_field */,/* hh_attrition_year_month_field */,/* bussrv_r12m_tier_cd_field */,/* bussrv_r12m_tier_desc_field */,/* bussrv_r12m_tier_gen_1_field */,/* bussrv_r12m_tier_gen_2_field */,/* bussrv_py_tier_cd_field */,/* bussrv_py_tier_desc_field */,/* bussrv_py_tier_gen_1_field */,/* bussrv_py_tier_gen_2_field */,/* govt_cy_tier_field */,/* cy_vertical_sk_field */,/* py_vertical_sk_field */,/* current_primary_territory_sk_field */,/* current_secondary_territory_sk_field */,/* ins_business_line_field */,/* ins_market_code_field */,/* ins_platform_type_field */,/* mvr_alt1_gen01_field */,/* mvr_alt1_gen02_field */,/* mvr_alt1_gen03_field */,/* mvr_alt1_gen04_field */,/* mvr_rate_type_field */,/* legal_entity_id_field */,/* legal_entity_code_field */,/* legal_entity_name_field */,/* currency_id_field */,/* currency_code_field */,/* lang_code_field */,/* lang_name_field */,/* country_field */,/* country_gen3_field */,/* country_gen2_field */,/* country_gen1_field */,/* country_tier_field */,/* PMK_Customer_Product_field */,/* use_case_field */,/* market_segment_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
