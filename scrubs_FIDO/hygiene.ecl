import ut,SALT30;
export hygiene(dataset(layout_FIDO) h) := MODULE
//A simple summary record
export Summary(SALT30.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_customer_account_sk_pcnt := AVE(GROUP,IF(h.customer_account_sk = (TYPEOF(h.customer_account_sk))'',0,100));
    maxlength_customer_account_sk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.customer_account_sk)));
    avelength_customer_account_sk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.customer_account_sk)),h.customer_account_sk<>(typeof(h.customer_account_sk))'');
    populated_platform_cd_pcnt := AVE(GROUP,IF(h.platform_cd = (TYPEOF(h.platform_cd))'',0,100));
    maxlength_platform_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.platform_cd)));
    avelength_platform_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.platform_cd)),h.platform_cd<>(typeof(h.platform_cd))'');
    populated_hh_id_pcnt := AVE(GROUP,IF(h.hh_id = (TYPEOF(h.hh_id))'',0,100));
    maxlength_hh_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hh_id)));
    avelength_hh_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hh_id)),h.hh_id<>(typeof(h.hh_id))'');
    populated_hh_name_pcnt := AVE(GROUP,IF(h.hh_name = (TYPEOF(h.hh_name))'',0,100));
    maxlength_hh_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hh_name)));
    avelength_hh_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hh_name)),h.hh_name<>(typeof(h.hh_name))'');
    populated_current_subaccount_id_pcnt := AVE(GROUP,IF(h.current_subaccount_id = (TYPEOF(h.current_subaccount_id))'',0,100));
    maxlength_current_subaccount_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.current_subaccount_id)));
    avelength_current_subaccount_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.current_subaccount_id)),h.current_subaccount_id<>(typeof(h.current_subaccount_id))'');
    populated_hist_subaccount_id_pcnt := AVE(GROUP,IF(h.hist_subaccount_id = (TYPEOF(h.hist_subaccount_id))'',0,100));
    maxlength_hist_subaccount_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_subaccount_id)));
    avelength_hist_subaccount_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_subaccount_id)),h.hist_subaccount_id<>(typeof(h.hist_subaccount_id))'');
    populated_subaccount_name_pcnt := AVE(GROUP,IF(h.subaccount_name = (TYPEOF(h.subaccount_name))'',0,100));
    maxlength_subaccount_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.subaccount_name)));
    avelength_subaccount_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.subaccount_name)),h.subaccount_name<>(typeof(h.subaccount_name))'');
    populated_mbs_gc_id_pcnt := AVE(GROUP,IF(h.mbs_gc_id = (TYPEOF(h.mbs_gc_id))'',0,100));
    maxlength_mbs_gc_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_gc_id)));
    avelength_mbs_gc_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_gc_id)),h.mbs_gc_id<>(typeof(h.mbs_gc_id))'');
    populated_mbs_reseller_parent_gc_id_pcnt := AVE(GROUP,IF(h.mbs_reseller_parent_gc_id = (TYPEOF(h.mbs_reseller_parent_gc_id))'',0,100));
    maxlength_mbs_reseller_parent_gc_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_reseller_parent_gc_id)));
    avelength_mbs_reseller_parent_gc_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_reseller_parent_gc_id)),h.mbs_reseller_parent_gc_id<>(typeof(h.mbs_reseller_parent_gc_id))'');
    populated_mbs_reseller_parent_company_id_pcnt := AVE(GROUP,IF(h.mbs_reseller_parent_company_id = (TYPEOF(h.mbs_reseller_parent_company_id))'',0,100));
    maxlength_mbs_reseller_parent_company_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_reseller_parent_company_id)));
    avelength_mbs_reseller_parent_company_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_reseller_parent_company_id)),h.mbs_reseller_parent_company_id<>(typeof(h.mbs_reseller_parent_company_id))'');
    populated_mbs_company_id_pcnt := AVE(GROUP,IF(h.mbs_company_id = (TYPEOF(h.mbs_company_id))'',0,100));
    maxlength_mbs_company_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_company_id)));
    avelength_mbs_company_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_company_id)),h.mbs_company_id<>(typeof(h.mbs_company_id))'');
    populated_mbs_billing_id_pcnt := AVE(GROUP,IF(h.mbs_billing_id = (TYPEOF(h.mbs_billing_id))'',0,100));
    maxlength_mbs_billing_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_billing_id)));
    avelength_mbs_billing_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_billing_id)),h.mbs_billing_id<>(typeof(h.mbs_billing_id))'');
    populated_mbs_product_id_pcnt := AVE(GROUP,IF(h.mbs_product_id = (TYPEOF(h.mbs_product_id))'',0,100));
    maxlength_mbs_product_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_product_id)));
    avelength_mbs_product_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_product_id)),h.mbs_product_id<>(typeof(h.mbs_product_id))'');
    populated_mbs_sub_product_id_pcnt := AVE(GROUP,IF(h.mbs_sub_product_id = (TYPEOF(h.mbs_sub_product_id))'',0,100));
    maxlength_mbs_sub_product_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_sub_product_id)));
    avelength_mbs_sub_product_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_sub_product_id)),h.mbs_sub_product_id<>(typeof(h.mbs_sub_product_id))'');
    populated_vc_id_pcnt := AVE(GROUP,IF(h.vc_id = (TYPEOF(h.vc_id))'',0,100));
    maxlength_vc_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vc_id)));
    avelength_vc_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vc_id)),h.vc_id<>(typeof(h.vc_id))'');
    populated_ins_account_pcnt := AVE(GROUP,IF(h.ins_account = (TYPEOF(h.ins_account))'',0,100));
    maxlength_ins_account := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_account)));
    avelength_ins_account := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_account)),h.ins_account<>(typeof(h.ins_account))'');
    populated_ins_account_suffix_pcnt := AVE(GROUP,IF(h.ins_account_suffix = (TYPEOF(h.ins_account_suffix))'',0,100));
    maxlength_ins_account_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_account_suffix)));
    avelength_ins_account_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_account_suffix)),h.ins_account_suffix<>(typeof(h.ins_account_suffix))'');
    populated_dyt_sub_acct_id_pcnt := AVE(GROUP,IF(h.dyt_sub_acct_id = (TYPEOF(h.dyt_sub_acct_id))'',0,100));
    maxlength_dyt_sub_acct_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dyt_sub_acct_id)));
    avelength_dyt_sub_acct_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dyt_sub_acct_id)),h.dyt_sub_acct_id<>(typeof(h.dyt_sub_acct_id))'');
    populated_ins_control_nbr_pcnt := AVE(GROUP,IF(h.ins_control_nbr = (TYPEOF(h.ins_control_nbr))'',0,100));
    maxlength_ins_control_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_control_nbr)));
    avelength_ins_control_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_control_nbr)),h.ins_control_nbr<>(typeof(h.ins_control_nbr))'');
    populated_ins_control_name_pcnt := AVE(GROUP,IF(h.ins_control_name = (TYPEOF(h.ins_control_name))'',0,100));
    maxlength_ins_control_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_control_name)));
    avelength_ins_control_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_control_name)),h.ins_control_name<>(typeof(h.ins_control_name))'');
    populated_ins_company_nbr_pcnt := AVE(GROUP,IF(h.ins_company_nbr = (TYPEOF(h.ins_company_nbr))'',0,100));
    maxlength_ins_company_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_company_nbr)));
    avelength_ins_company_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_company_nbr)),h.ins_company_nbr<>(typeof(h.ins_company_nbr))'');
    populated_ins_company_name_pcnt := AVE(GROUP,IF(h.ins_company_name = (TYPEOF(h.ins_company_name))'',0,100));
    maxlength_ins_company_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_company_name)));
    avelength_ins_company_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_company_name)),h.ins_company_name<>(typeof(h.ins_company_name))'');
    populated_dyt_account_id_pcnt := AVE(GROUP,IF(h.dyt_account_id = (TYPEOF(h.dyt_account_id))'',0,100));
    maxlength_dyt_account_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dyt_account_id)));
    avelength_dyt_account_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dyt_account_id)),h.dyt_account_id<>(typeof(h.dyt_account_id))'');
    populated_dyt_account_name_pcnt := AVE(GROUP,IF(h.dyt_account_name = (TYPEOF(h.dyt_account_name))'',0,100));
    maxlength_dyt_account_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dyt_account_name)));
    avelength_dyt_account_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dyt_account_name)),h.dyt_account_name<>(typeof(h.dyt_account_name))'');
    populated_dyt_customer_name_pcnt := AVE(GROUP,IF(h.dyt_customer_name = (TYPEOF(h.dyt_customer_name))'',0,100));
    maxlength_dyt_customer_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dyt_customer_name)));
    avelength_dyt_customer_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dyt_customer_name)),h.dyt_customer_name<>(typeof(h.dyt_customer_name))'');
    populated_mbs_reseller_parent_name_pcnt := AVE(GROUP,IF(h.mbs_reseller_parent_name = (TYPEOF(h.mbs_reseller_parent_name))'',0,100));
    maxlength_mbs_reseller_parent_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_reseller_parent_name)));
    avelength_mbs_reseller_parent_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mbs_reseller_parent_name)),h.mbs_reseller_parent_name<>(typeof(h.mbs_reseller_parent_name))'');
    populated_cancel_reason_pcnt := AVE(GROUP,IF(h.cancel_reason = (TYPEOF(h.cancel_reason))'',0,100));
    maxlength_cancel_reason := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cancel_reason)));
    avelength_cancel_reason := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cancel_reason)),h.cancel_reason<>(typeof(h.cancel_reason))'');
    populated_internal_flag_pcnt := AVE(GROUP,IF(h.internal_flag = (TYPEOF(h.internal_flag))'',0,100));
    maxlength_internal_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.internal_flag)));
    avelength_internal_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.internal_flag)),h.internal_flag<>(typeof(h.internal_flag))'');
    populated_dummy_subaccount_flag_pcnt := AVE(GROUP,IF(h.dummy_subaccount_flag = (TYPEOF(h.dummy_subaccount_flag))'',0,100));
    maxlength_dummy_subaccount_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dummy_subaccount_flag)));
    avelength_dummy_subaccount_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dummy_subaccount_flag)),h.dummy_subaccount_flag<>(typeof(h.dummy_subaccount_flag))'');
    populated_primary_market_gen_1_pcnt := AVE(GROUP,IF(h.primary_market_gen_1 = (TYPEOF(h.primary_market_gen_1))'',0,100));
    maxlength_primary_market_gen_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_market_gen_1)));
    avelength_primary_market_gen_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_market_gen_1)),h.primary_market_gen_1<>(typeof(h.primary_market_gen_1))'');
    populated_primary_market_cd_pcnt := AVE(GROUP,IF(h.primary_market_cd = (TYPEOF(h.primary_market_cd))'',0,100));
    maxlength_primary_market_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_market_cd)));
    avelength_primary_market_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_market_cd)),h.primary_market_cd<>(typeof(h.primary_market_cd))'');
    populated_primary_market_desc_pcnt := AVE(GROUP,IF(h.primary_market_desc = (TYPEOF(h.primary_market_desc))'',0,100));
    maxlength_primary_market_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_market_desc)));
    avelength_primary_market_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_market_desc)),h.primary_market_desc<>(typeof(h.primary_market_desc))'');
    populated_secondary_market_cd_pcnt := AVE(GROUP,IF(h.secondary_market_cd = (TYPEOF(h.secondary_market_cd))'',0,100));
    maxlength_secondary_market_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_market_cd)));
    avelength_secondary_market_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_market_cd)),h.secondary_market_cd<>(typeof(h.secondary_market_cd))'');
    populated_secondary_market_desc_pcnt := AVE(GROUP,IF(h.secondary_market_desc = (TYPEOF(h.secondary_market_desc))'',0,100));
    maxlength_secondary_market_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_market_desc)));
    avelength_secondary_market_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_market_desc)),h.secondary_market_desc<>(typeof(h.secondary_market_desc))'');
    populated_Sub_market_pcnt := AVE(GROUP,IF(h.Sub_market = (TYPEOF(h.Sub_market))'',0,100));
    maxlength_Sub_market := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.Sub_market)));
    avelength_Sub_market := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.Sub_market)),h.Sub_market<>(typeof(h.Sub_market))'');
    populated_sub_market_gen_1_pcnt := AVE(GROUP,IF(h.sub_market_gen_1 = (TYPEOF(h.sub_market_gen_1))'',0,100));
    maxlength_sub_market_gen_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sub_market_gen_1)));
    avelength_sub_market_gen_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sub_market_gen_1)),h.sub_market_gen_1<>(typeof(h.sub_market_gen_1))'');
    populated_sub_market_gen_2_pcnt := AVE(GROUP,IF(h.sub_market_gen_2 = (TYPEOF(h.sub_market_gen_2))'',0,100));
    maxlength_sub_market_gen_2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sub_market_gen_2)));
    avelength_sub_market_gen_2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sub_market_gen_2)),h.sub_market_gen_2<>(typeof(h.sub_market_gen_2))'');
    populated_segment_lead_pcnt := AVE(GROUP,IF(h.segment_lead = (TYPEOF(h.segment_lead))'',0,100));
    maxlength_segment_lead := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.segment_lead)));
    avelength_segment_lead := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.segment_lead)),h.segment_lead<>(typeof(h.segment_lead))'');
    populated_subaccount_status_pcnt := AVE(GROUP,IF(h.subaccount_status = (TYPEOF(h.subaccount_status))'',0,100));
    maxlength_subaccount_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.subaccount_status)));
    avelength_subaccount_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.subaccount_status)),h.subaccount_status<>(typeof(h.subaccount_status))'');
    populated_acc_application_type_pcnt := AVE(GROUP,IF(h.acc_application_type = (TYPEOF(h.acc_application_type))'',0,100));
    maxlength_acc_application_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.acc_application_type)));
    avelength_acc_application_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.acc_application_type)),h.acc_application_type<>(typeof(h.acc_application_type))'');
    populated_acc_company_type_pcnt := AVE(GROUP,IF(h.acc_company_type = (TYPEOF(h.acc_company_type))'',0,100));
    maxlength_acc_company_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.acc_company_type)));
    avelength_acc_company_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.acc_company_type)),h.acc_company_type<>(typeof(h.acc_company_type))'');
    populated_bussrv_crd_customer_pcnt := AVE(GROUP,IF(h.bussrv_crd_customer = (TYPEOF(h.bussrv_crd_customer))'',0,100));
    maxlength_bussrv_crd_customer := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_crd_customer)));
    avelength_bussrv_crd_customer := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_crd_customer)),h.bussrv_crd_customer<>(typeof(h.bussrv_crd_customer))'');
    populated_integrator_pcnt := AVE(GROUP,IF(h.integrator = (TYPEOF(h.integrator))'',0,100));
    maxlength_integrator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.integrator)));
    avelength_integrator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.integrator)),h.integrator<>(typeof(h.integrator))'');
    populated_migration_type_pcnt := AVE(GROUP,IF(h.migration_type = (TYPEOF(h.migration_type))'',0,100));
    maxlength_migration_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.migration_type)));
    avelength_migration_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.migration_type)),h.migration_type<>(typeof(h.migration_type))'');
    populated_aba_flag_pcnt := AVE(GROUP,IF(h.aba_flag = (TYPEOF(h.aba_flag))'',0,100));
    maxlength_aba_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.aba_flag)));
    avelength_aba_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.aba_flag)),h.aba_flag<>(typeof(h.aba_flag))'');
    populated_acquisition_tracking_pcnt := AVE(GROUP,IF(h.acquisition_tracking = (TYPEOF(h.acquisition_tracking))'',0,100));
    maxlength_acquisition_tracking := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.acquisition_tracking)));
    avelength_acquisition_tracking := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.acquisition_tracking)),h.acquisition_tracking<>(typeof(h.acquisition_tracking))'');
    populated_acquisition_tracking_Gen01_pcnt := AVE(GROUP,IF(h.acquisition_tracking_Gen01 = (TYPEOF(h.acquisition_tracking_Gen01))'',0,100));
    maxlength_acquisition_tracking_Gen01 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.acquisition_tracking_Gen01)));
    avelength_acquisition_tracking_Gen01 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.acquisition_tracking_Gen01)),h.acquisition_tracking_Gen01<>(typeof(h.acquisition_tracking_Gen01))'');
    populated_acquisition_tracking_Gen02_pcnt := AVE(GROUP,IF(h.acquisition_tracking_Gen02 = (TYPEOF(h.acquisition_tracking_Gen02))'',0,100));
    maxlength_acquisition_tracking_Gen02 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.acquisition_tracking_Gen02)));
    avelength_acquisition_tracking_Gen02 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.acquisition_tracking_Gen02)),h.acquisition_tracking_Gen02<>(typeof(h.acquisition_tracking_Gen02))'');
    populated_acquisition_tracking_Gen03_pcnt := AVE(GROUP,IF(h.acquisition_tracking_Gen03 = (TYPEOF(h.acquisition_tracking_Gen03))'',0,100));
    maxlength_acquisition_tracking_Gen03 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.acquisition_tracking_Gen03)));
    avelength_acquisition_tracking_Gen03 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.acquisition_tracking_Gen03)),h.acquisition_tracking_Gen03<>(typeof(h.acquisition_tracking_Gen03))'');
    populated_new_subaccount_year_pcnt := AVE(GROUP,IF(h.new_subaccount_year = (TYPEOF(h.new_subaccount_year))'',0,100));
    maxlength_new_subaccount_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.new_subaccount_year)));
    avelength_new_subaccount_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.new_subaccount_year)),h.new_subaccount_year<>(typeof(h.new_subaccount_year))'');
    populated_new_subaccount_year_month_pcnt := AVE(GROUP,IF(h.new_subaccount_year_month = (TYPEOF(h.new_subaccount_year_month))'',0,100));
    maxlength_new_subaccount_year_month := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.new_subaccount_year_month)));
    avelength_new_subaccount_year_month := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.new_subaccount_year_month)),h.new_subaccount_year_month<>(typeof(h.new_subaccount_year_month))'');
    populated_new_hh_year_pcnt := AVE(GROUP,IF(h.new_hh_year = (TYPEOF(h.new_hh_year))'',0,100));
    maxlength_new_hh_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.new_hh_year)));
    avelength_new_hh_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.new_hh_year)),h.new_hh_year<>(typeof(h.new_hh_year))'');
    populated_new_hh_year_month_pcnt := AVE(GROUP,IF(h.new_hh_year_month = (TYPEOF(h.new_hh_year_month))'',0,100));
    maxlength_new_hh_year_month := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.new_hh_year_month)));
    avelength_new_hh_year_month := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.new_hh_year_month)),h.new_hh_year_month<>(typeof(h.new_hh_year_month))'');
    populated_subaccount_attrition_year_pcnt := AVE(GROUP,IF(h.subaccount_attrition_year = (TYPEOF(h.subaccount_attrition_year))'',0,100));
    maxlength_subaccount_attrition_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.subaccount_attrition_year)));
    avelength_subaccount_attrition_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.subaccount_attrition_year)),h.subaccount_attrition_year<>(typeof(h.subaccount_attrition_year))'');
    populated_subaccount_attrition_year_month_pcnt := AVE(GROUP,IF(h.subaccount_attrition_year_month = (TYPEOF(h.subaccount_attrition_year_month))'',0,100));
    maxlength_subaccount_attrition_year_month := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.subaccount_attrition_year_month)));
    avelength_subaccount_attrition_year_month := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.subaccount_attrition_year_month)),h.subaccount_attrition_year_month<>(typeof(h.subaccount_attrition_year_month))'');
    populated_hh_attrition_year_pcnt := AVE(GROUP,IF(h.hh_attrition_year = (TYPEOF(h.hh_attrition_year))'',0,100));
    maxlength_hh_attrition_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hh_attrition_year)));
    avelength_hh_attrition_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hh_attrition_year)),h.hh_attrition_year<>(typeof(h.hh_attrition_year))'');
    populated_hh_attrition_year_month_pcnt := AVE(GROUP,IF(h.hh_attrition_year_month = (TYPEOF(h.hh_attrition_year_month))'',0,100));
    maxlength_hh_attrition_year_month := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hh_attrition_year_month)));
    avelength_hh_attrition_year_month := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hh_attrition_year_month)),h.hh_attrition_year_month<>(typeof(h.hh_attrition_year_month))'');
    populated_bussrv_r12m_tier_cd_pcnt := AVE(GROUP,IF(h.bussrv_r12m_tier_cd = (TYPEOF(h.bussrv_r12m_tier_cd))'',0,100));
    maxlength_bussrv_r12m_tier_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_r12m_tier_cd)));
    avelength_bussrv_r12m_tier_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_r12m_tier_cd)),h.bussrv_r12m_tier_cd<>(typeof(h.bussrv_r12m_tier_cd))'');
    populated_bussrv_r12m_tier_desc_pcnt := AVE(GROUP,IF(h.bussrv_r12m_tier_desc = (TYPEOF(h.bussrv_r12m_tier_desc))'',0,100));
    maxlength_bussrv_r12m_tier_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_r12m_tier_desc)));
    avelength_bussrv_r12m_tier_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_r12m_tier_desc)),h.bussrv_r12m_tier_desc<>(typeof(h.bussrv_r12m_tier_desc))'');
    populated_bussrv_r12m_tier_gen_1_pcnt := AVE(GROUP,IF(h.bussrv_r12m_tier_gen_1 = (TYPEOF(h.bussrv_r12m_tier_gen_1))'',0,100));
    maxlength_bussrv_r12m_tier_gen_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_r12m_tier_gen_1)));
    avelength_bussrv_r12m_tier_gen_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_r12m_tier_gen_1)),h.bussrv_r12m_tier_gen_1<>(typeof(h.bussrv_r12m_tier_gen_1))'');
    populated_bussrv_r12m_tier_gen_2_pcnt := AVE(GROUP,IF(h.bussrv_r12m_tier_gen_2 = (TYPEOF(h.bussrv_r12m_tier_gen_2))'',0,100));
    maxlength_bussrv_r12m_tier_gen_2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_r12m_tier_gen_2)));
    avelength_bussrv_r12m_tier_gen_2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_r12m_tier_gen_2)),h.bussrv_r12m_tier_gen_2<>(typeof(h.bussrv_r12m_tier_gen_2))'');
    populated_bussrv_py_tier_cd_pcnt := AVE(GROUP,IF(h.bussrv_py_tier_cd = (TYPEOF(h.bussrv_py_tier_cd))'',0,100));
    maxlength_bussrv_py_tier_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_py_tier_cd)));
    avelength_bussrv_py_tier_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_py_tier_cd)),h.bussrv_py_tier_cd<>(typeof(h.bussrv_py_tier_cd))'');
    populated_bussrv_py_tier_desc_pcnt := AVE(GROUP,IF(h.bussrv_py_tier_desc = (TYPEOF(h.bussrv_py_tier_desc))'',0,100));
    maxlength_bussrv_py_tier_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_py_tier_desc)));
    avelength_bussrv_py_tier_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_py_tier_desc)),h.bussrv_py_tier_desc<>(typeof(h.bussrv_py_tier_desc))'');
    populated_bussrv_py_tier_gen_1_pcnt := AVE(GROUP,IF(h.bussrv_py_tier_gen_1 = (TYPEOF(h.bussrv_py_tier_gen_1))'',0,100));
    maxlength_bussrv_py_tier_gen_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_py_tier_gen_1)));
    avelength_bussrv_py_tier_gen_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_py_tier_gen_1)),h.bussrv_py_tier_gen_1<>(typeof(h.bussrv_py_tier_gen_1))'');
    populated_bussrv_py_tier_gen_2_pcnt := AVE(GROUP,IF(h.bussrv_py_tier_gen_2 = (TYPEOF(h.bussrv_py_tier_gen_2))'',0,100));
    maxlength_bussrv_py_tier_gen_2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_py_tier_gen_2)));
    avelength_bussrv_py_tier_gen_2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bussrv_py_tier_gen_2)),h.bussrv_py_tier_gen_2<>(typeof(h.bussrv_py_tier_gen_2))'');
    populated_govt_cy_tier_pcnt := AVE(GROUP,IF(h.govt_cy_tier = (TYPEOF(h.govt_cy_tier))'',0,100));
    maxlength_govt_cy_tier := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.govt_cy_tier)));
    avelength_govt_cy_tier := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.govt_cy_tier)),h.govt_cy_tier<>(typeof(h.govt_cy_tier))'');
    populated_cy_vertical_sk_pcnt := AVE(GROUP,IF(h.cy_vertical_sk = (TYPEOF(h.cy_vertical_sk))'',0,100));
    maxlength_cy_vertical_sk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cy_vertical_sk)));
    avelength_cy_vertical_sk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cy_vertical_sk)),h.cy_vertical_sk<>(typeof(h.cy_vertical_sk))'');
    populated_py_vertical_sk_pcnt := AVE(GROUP,IF(h.py_vertical_sk = (TYPEOF(h.py_vertical_sk))'',0,100));
    maxlength_py_vertical_sk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.py_vertical_sk)));
    avelength_py_vertical_sk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.py_vertical_sk)),h.py_vertical_sk<>(typeof(h.py_vertical_sk))'');
    populated_current_primary_territory_sk_pcnt := AVE(GROUP,IF(h.current_primary_territory_sk = (TYPEOF(h.current_primary_territory_sk))'',0,100));
    maxlength_current_primary_territory_sk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.current_primary_territory_sk)));
    avelength_current_primary_territory_sk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.current_primary_territory_sk)),h.current_primary_territory_sk<>(typeof(h.current_primary_territory_sk))'');
    populated_current_secondary_territory_sk_pcnt := AVE(GROUP,IF(h.current_secondary_territory_sk = (TYPEOF(h.current_secondary_territory_sk))'',0,100));
    maxlength_current_secondary_territory_sk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.current_secondary_territory_sk)));
    avelength_current_secondary_territory_sk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.current_secondary_territory_sk)),h.current_secondary_territory_sk<>(typeof(h.current_secondary_territory_sk))'');
    populated_ins_business_line_pcnt := AVE(GROUP,IF(h.ins_business_line = (TYPEOF(h.ins_business_line))'',0,100));
    maxlength_ins_business_line := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_business_line)));
    avelength_ins_business_line := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_business_line)),h.ins_business_line<>(typeof(h.ins_business_line))'');
    populated_ins_market_code_pcnt := AVE(GROUP,IF(h.ins_market_code = (TYPEOF(h.ins_market_code))'',0,100));
    maxlength_ins_market_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_market_code)));
    avelength_ins_market_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_market_code)),h.ins_market_code<>(typeof(h.ins_market_code))'');
    populated_ins_platform_type_pcnt := AVE(GROUP,IF(h.ins_platform_type = (TYPEOF(h.ins_platform_type))'',0,100));
    maxlength_ins_platform_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_platform_type)));
    avelength_ins_platform_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ins_platform_type)),h.ins_platform_type<>(typeof(h.ins_platform_type))'');
    populated_mvr_alt1_gen01_pcnt := AVE(GROUP,IF(h.mvr_alt1_gen01 = (TYPEOF(h.mvr_alt1_gen01))'',0,100));
    maxlength_mvr_alt1_gen01 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mvr_alt1_gen01)));
    avelength_mvr_alt1_gen01 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mvr_alt1_gen01)),h.mvr_alt1_gen01<>(typeof(h.mvr_alt1_gen01))'');
    populated_mvr_alt1_gen02_pcnt := AVE(GROUP,IF(h.mvr_alt1_gen02 = (TYPEOF(h.mvr_alt1_gen02))'',0,100));
    maxlength_mvr_alt1_gen02 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mvr_alt1_gen02)));
    avelength_mvr_alt1_gen02 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mvr_alt1_gen02)),h.mvr_alt1_gen02<>(typeof(h.mvr_alt1_gen02))'');
    populated_mvr_alt1_gen03_pcnt := AVE(GROUP,IF(h.mvr_alt1_gen03 = (TYPEOF(h.mvr_alt1_gen03))'',0,100));
    maxlength_mvr_alt1_gen03 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mvr_alt1_gen03)));
    avelength_mvr_alt1_gen03 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mvr_alt1_gen03)),h.mvr_alt1_gen03<>(typeof(h.mvr_alt1_gen03))'');
    populated_mvr_alt1_gen04_pcnt := AVE(GROUP,IF(h.mvr_alt1_gen04 = (TYPEOF(h.mvr_alt1_gen04))'',0,100));
    maxlength_mvr_alt1_gen04 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mvr_alt1_gen04)));
    avelength_mvr_alt1_gen04 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mvr_alt1_gen04)),h.mvr_alt1_gen04<>(typeof(h.mvr_alt1_gen04))'');
    populated_mvr_rate_type_pcnt := AVE(GROUP,IF(h.mvr_rate_type = (TYPEOF(h.mvr_rate_type))'',0,100));
    maxlength_mvr_rate_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mvr_rate_type)));
    avelength_mvr_rate_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mvr_rate_type)),h.mvr_rate_type<>(typeof(h.mvr_rate_type))'');
    populated_legal_entity_id_pcnt := AVE(GROUP,IF(h.legal_entity_id = (TYPEOF(h.legal_entity_id))'',0,100));
    maxlength_legal_entity_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.legal_entity_id)));
    avelength_legal_entity_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.legal_entity_id)),h.legal_entity_id<>(typeof(h.legal_entity_id))'');
    populated_legal_entity_code_pcnt := AVE(GROUP,IF(h.legal_entity_code = (TYPEOF(h.legal_entity_code))'',0,100));
    maxlength_legal_entity_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.legal_entity_code)));
    avelength_legal_entity_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.legal_entity_code)),h.legal_entity_code<>(typeof(h.legal_entity_code))'');
    populated_legal_entity_name_pcnt := AVE(GROUP,IF(h.legal_entity_name = (TYPEOF(h.legal_entity_name))'',0,100));
    maxlength_legal_entity_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.legal_entity_name)));
    avelength_legal_entity_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.legal_entity_name)),h.legal_entity_name<>(typeof(h.legal_entity_name))'');
    populated_currency_id_pcnt := AVE(GROUP,IF(h.currency_id = (TYPEOF(h.currency_id))'',0,100));
    maxlength_currency_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.currency_id)));
    avelength_currency_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.currency_id)),h.currency_id<>(typeof(h.currency_id))'');
    populated_currency_code_pcnt := AVE(GROUP,IF(h.currency_code = (TYPEOF(h.currency_code))'',0,100));
    maxlength_currency_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.currency_code)));
    avelength_currency_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.currency_code)),h.currency_code<>(typeof(h.currency_code))'');
    populated_lang_code_pcnt := AVE(GROUP,IF(h.lang_code = (TYPEOF(h.lang_code))'',0,100));
    maxlength_lang_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lang_code)));
    avelength_lang_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lang_code)),h.lang_code<>(typeof(h.lang_code))'');
    populated_lang_name_pcnt := AVE(GROUP,IF(h.lang_name = (TYPEOF(h.lang_name))'',0,100));
    maxlength_lang_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lang_name)));
    avelength_lang_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lang_name)),h.lang_name<>(typeof(h.lang_name))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_country_gen3_pcnt := AVE(GROUP,IF(h.country_gen3 = (TYPEOF(h.country_gen3))'',0,100));
    maxlength_country_gen3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.country_gen3)));
    avelength_country_gen3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.country_gen3)),h.country_gen3<>(typeof(h.country_gen3))'');
    populated_country_gen2_pcnt := AVE(GROUP,IF(h.country_gen2 = (TYPEOF(h.country_gen2))'',0,100));
    maxlength_country_gen2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.country_gen2)));
    avelength_country_gen2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.country_gen2)),h.country_gen2<>(typeof(h.country_gen2))'');
    populated_country_gen1_pcnt := AVE(GROUP,IF(h.country_gen1 = (TYPEOF(h.country_gen1))'',0,100));
    maxlength_country_gen1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.country_gen1)));
    avelength_country_gen1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.country_gen1)),h.country_gen1<>(typeof(h.country_gen1))'');
    populated_country_tier_pcnt := AVE(GROUP,IF(h.country_tier = (TYPEOF(h.country_tier))'',0,100));
    maxlength_country_tier := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.country_tier)));
    avelength_country_tier := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.country_tier)),h.country_tier<>(typeof(h.country_tier))'');
    populated_PMK_Customer_Product_pcnt := AVE(GROUP,IF(h.PMK_Customer_Product = (TYPEOF(h.PMK_Customer_Product))'',0,100));
    maxlength_PMK_Customer_Product := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.PMK_Customer_Product)));
    avelength_PMK_Customer_Product := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.PMK_Customer_Product)),h.PMK_Customer_Product<>(typeof(h.PMK_Customer_Product))'');
    populated_use_case_pcnt := AVE(GROUP,IF(h.use_case = (TYPEOF(h.use_case))'',0,100));
    maxlength_use_case := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.use_case)));
    avelength_use_case := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.use_case)),h.use_case<>(typeof(h.use_case))'');
    populated_market_segment_pcnt := AVE(GROUP,IF(h.market_segment = (TYPEOF(h.market_segment))'',0,100));
    maxlength_market_segment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.market_segment)));
    avelength_market_segment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.market_segment)),h.market_segment<>(typeof(h.market_segment))'');
  END;
  RETURN table(h,SummaryLayout);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'customer_account_sk','platform_cd','hh_id','hh_name','current_subaccount_id','hist_subaccount_id','subaccount_name','mbs_gc_id','mbs_reseller_parent_gc_id','mbs_reseller_parent_company_id','mbs_company_id','mbs_billing_id','mbs_product_id','mbs_sub_product_id','vc_id','ins_account','ins_account_suffix','dyt_sub_acct_id','ins_control_nbr','ins_control_name','ins_company_nbr','ins_company_name','dyt_account_id','dyt_account_name','dyt_customer_name','mbs_reseller_parent_name','cancel_reason','internal_flag','dummy_subaccount_flag','primary_market_gen_1','primary_market_cd','primary_market_desc','secondary_market_cd','secondary_market_desc','Sub_market','sub_market_gen_1','sub_market_gen_2','segment_lead','subaccount_status','acc_application_type','acc_company_type','bussrv_crd_customer','integrator','migration_type','aba_flag','acquisition_tracking','acquisition_tracking_Gen01','acquisition_tracking_Gen02','acquisition_tracking_Gen03','new_subaccount_year','new_subaccount_year_month','new_hh_year','new_hh_year_month','subaccount_attrition_year','subaccount_attrition_year_month','hh_attrition_year','hh_attrition_year_month','bussrv_r12m_tier_cd','bussrv_r12m_tier_desc','bussrv_r12m_tier_gen_1','bussrv_r12m_tier_gen_2','bussrv_py_tier_cd','bussrv_py_tier_desc','bussrv_py_tier_gen_1','bussrv_py_tier_gen_2','govt_cy_tier','cy_vertical_sk','py_vertical_sk','current_primary_territory_sk','current_secondary_territory_sk','ins_business_line','ins_market_code','ins_platform_type','mvr_alt1_gen01','mvr_alt1_gen02','mvr_alt1_gen03','mvr_alt1_gen04','mvr_rate_type','legal_entity_id','legal_entity_code','legal_entity_name','currency_id','currency_code','lang_code','lang_name','country','country_gen3','country_gen2','country_gen1','country_tier','PMK_Customer_Product','use_case','market_segment');
  SELF.populated_pcnt := CHOOSE(C,le.populated_customer_account_sk_pcnt,le.populated_platform_cd_pcnt,le.populated_hh_id_pcnt,le.populated_hh_name_pcnt,le.populated_current_subaccount_id_pcnt,le.populated_hist_subaccount_id_pcnt,le.populated_subaccount_name_pcnt,le.populated_mbs_gc_id_pcnt,le.populated_mbs_reseller_parent_gc_id_pcnt,le.populated_mbs_reseller_parent_company_id_pcnt,le.populated_mbs_company_id_pcnt,le.populated_mbs_billing_id_pcnt,le.populated_mbs_product_id_pcnt,le.populated_mbs_sub_product_id_pcnt,le.populated_vc_id_pcnt,le.populated_ins_account_pcnt,le.populated_ins_account_suffix_pcnt,le.populated_dyt_sub_acct_id_pcnt,le.populated_ins_control_nbr_pcnt,le.populated_ins_control_name_pcnt,le.populated_ins_company_nbr_pcnt,le.populated_ins_company_name_pcnt,le.populated_dyt_account_id_pcnt,le.populated_dyt_account_name_pcnt,le.populated_dyt_customer_name_pcnt,le.populated_mbs_reseller_parent_name_pcnt,le.populated_cancel_reason_pcnt,le.populated_internal_flag_pcnt,le.populated_dummy_subaccount_flag_pcnt,le.populated_primary_market_gen_1_pcnt,le.populated_primary_market_cd_pcnt,le.populated_primary_market_desc_pcnt,le.populated_secondary_market_cd_pcnt,le.populated_secondary_market_desc_pcnt,le.populated_Sub_market_pcnt,le.populated_sub_market_gen_1_pcnt,le.populated_sub_market_gen_2_pcnt,le.populated_segment_lead_pcnt,le.populated_subaccount_status_pcnt,le.populated_acc_application_type_pcnt,le.populated_acc_company_type_pcnt,le.populated_bussrv_crd_customer_pcnt,le.populated_integrator_pcnt,le.populated_migration_type_pcnt,le.populated_aba_flag_pcnt,le.populated_acquisition_tracking_pcnt,le.populated_acquisition_tracking_Gen01_pcnt,le.populated_acquisition_tracking_Gen02_pcnt,le.populated_acquisition_tracking_Gen03_pcnt,le.populated_new_subaccount_year_pcnt,le.populated_new_subaccount_year_month_pcnt,le.populated_new_hh_year_pcnt,le.populated_new_hh_year_month_pcnt,le.populated_subaccount_attrition_year_pcnt,le.populated_subaccount_attrition_year_month_pcnt,le.populated_hh_attrition_year_pcnt,le.populated_hh_attrition_year_month_pcnt,le.populated_bussrv_r12m_tier_cd_pcnt,le.populated_bussrv_r12m_tier_desc_pcnt,le.populated_bussrv_r12m_tier_gen_1_pcnt,le.populated_bussrv_r12m_tier_gen_2_pcnt,le.populated_bussrv_py_tier_cd_pcnt,le.populated_bussrv_py_tier_desc_pcnt,le.populated_bussrv_py_tier_gen_1_pcnt,le.populated_bussrv_py_tier_gen_2_pcnt,le.populated_govt_cy_tier_pcnt,le.populated_cy_vertical_sk_pcnt,le.populated_py_vertical_sk_pcnt,le.populated_current_primary_territory_sk_pcnt,le.populated_current_secondary_territory_sk_pcnt,le.populated_ins_business_line_pcnt,le.populated_ins_market_code_pcnt,le.populated_ins_platform_type_pcnt,le.populated_mvr_alt1_gen01_pcnt,le.populated_mvr_alt1_gen02_pcnt,le.populated_mvr_alt1_gen03_pcnt,le.populated_mvr_alt1_gen04_pcnt,le.populated_mvr_rate_type_pcnt,le.populated_legal_entity_id_pcnt,le.populated_legal_entity_code_pcnt,le.populated_legal_entity_name_pcnt,le.populated_currency_id_pcnt,le.populated_currency_code_pcnt,le.populated_lang_code_pcnt,le.populated_lang_name_pcnt,le.populated_country_pcnt,le.populated_country_gen3_pcnt,le.populated_country_gen2_pcnt,le.populated_country_gen1_pcnt,le.populated_country_tier_pcnt,le.populated_PMK_Customer_Product_pcnt,le.populated_use_case_pcnt,le.populated_market_segment_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_customer_account_sk,le.maxlength_platform_cd,le.maxlength_hh_id,le.maxlength_hh_name,le.maxlength_current_subaccount_id,le.maxlength_hist_subaccount_id,le.maxlength_subaccount_name,le.maxlength_mbs_gc_id,le.maxlength_mbs_reseller_parent_gc_id,le.maxlength_mbs_reseller_parent_company_id,le.maxlength_mbs_company_id,le.maxlength_mbs_billing_id,le.maxlength_mbs_product_id,le.maxlength_mbs_sub_product_id,le.maxlength_vc_id,le.maxlength_ins_account,le.maxlength_ins_account_suffix,le.maxlength_dyt_sub_acct_id,le.maxlength_ins_control_nbr,le.maxlength_ins_control_name,le.maxlength_ins_company_nbr,le.maxlength_ins_company_name,le.maxlength_dyt_account_id,le.maxlength_dyt_account_name,le.maxlength_dyt_customer_name,le.maxlength_mbs_reseller_parent_name,le.maxlength_cancel_reason,le.maxlength_internal_flag,le.maxlength_dummy_subaccount_flag,le.maxlength_primary_market_gen_1,le.maxlength_primary_market_cd,le.maxlength_primary_market_desc,le.maxlength_secondary_market_cd,le.maxlength_secondary_market_desc,le.maxlength_Sub_market,le.maxlength_sub_market_gen_1,le.maxlength_sub_market_gen_2,le.maxlength_segment_lead,le.maxlength_subaccount_status,le.maxlength_acc_application_type,le.maxlength_acc_company_type,le.maxlength_bussrv_crd_customer,le.maxlength_integrator,le.maxlength_migration_type,le.maxlength_aba_flag,le.maxlength_acquisition_tracking,le.maxlength_acquisition_tracking_Gen01,le.maxlength_acquisition_tracking_Gen02,le.maxlength_acquisition_tracking_Gen03,le.maxlength_new_subaccount_year,le.maxlength_new_subaccount_year_month,le.maxlength_new_hh_year,le.maxlength_new_hh_year_month,le.maxlength_subaccount_attrition_year,le.maxlength_subaccount_attrition_year_month,le.maxlength_hh_attrition_year,le.maxlength_hh_attrition_year_month,le.maxlength_bussrv_r12m_tier_cd,le.maxlength_bussrv_r12m_tier_desc,le.maxlength_bussrv_r12m_tier_gen_1,le.maxlength_bussrv_r12m_tier_gen_2,le.maxlength_bussrv_py_tier_cd,le.maxlength_bussrv_py_tier_desc,le.maxlength_bussrv_py_tier_gen_1,le.maxlength_bussrv_py_tier_gen_2,le.maxlength_govt_cy_tier,le.maxlength_cy_vertical_sk,le.maxlength_py_vertical_sk,le.maxlength_current_primary_territory_sk,le.maxlength_current_secondary_territory_sk,le.maxlength_ins_business_line,le.maxlength_ins_market_code,le.maxlength_ins_platform_type,le.maxlength_mvr_alt1_gen01,le.maxlength_mvr_alt1_gen02,le.maxlength_mvr_alt1_gen03,le.maxlength_mvr_alt1_gen04,le.maxlength_mvr_rate_type,le.maxlength_legal_entity_id,le.maxlength_legal_entity_code,le.maxlength_legal_entity_name,le.maxlength_currency_id,le.maxlength_currency_code,le.maxlength_lang_code,le.maxlength_lang_name,le.maxlength_country,le.maxlength_country_gen3,le.maxlength_country_gen2,le.maxlength_country_gen1,le.maxlength_country_tier,le.maxlength_PMK_Customer_Product,le.maxlength_use_case,le.maxlength_market_segment);
  SELF.avelength := CHOOSE(C,le.avelength_customer_account_sk,le.avelength_platform_cd,le.avelength_hh_id,le.avelength_hh_name,le.avelength_current_subaccount_id,le.avelength_hist_subaccount_id,le.avelength_subaccount_name,le.avelength_mbs_gc_id,le.avelength_mbs_reseller_parent_gc_id,le.avelength_mbs_reseller_parent_company_id,le.avelength_mbs_company_id,le.avelength_mbs_billing_id,le.avelength_mbs_product_id,le.avelength_mbs_sub_product_id,le.avelength_vc_id,le.avelength_ins_account,le.avelength_ins_account_suffix,le.avelength_dyt_sub_acct_id,le.avelength_ins_control_nbr,le.avelength_ins_control_name,le.avelength_ins_company_nbr,le.avelength_ins_company_name,le.avelength_dyt_account_id,le.avelength_dyt_account_name,le.avelength_dyt_customer_name,le.avelength_mbs_reseller_parent_name,le.avelength_cancel_reason,le.avelength_internal_flag,le.avelength_dummy_subaccount_flag,le.avelength_primary_market_gen_1,le.avelength_primary_market_cd,le.avelength_primary_market_desc,le.avelength_secondary_market_cd,le.avelength_secondary_market_desc,le.avelength_Sub_market,le.avelength_sub_market_gen_1,le.avelength_sub_market_gen_2,le.avelength_segment_lead,le.avelength_subaccount_status,le.avelength_acc_application_type,le.avelength_acc_company_type,le.avelength_bussrv_crd_customer,le.avelength_integrator,le.avelength_migration_type,le.avelength_aba_flag,le.avelength_acquisition_tracking,le.avelength_acquisition_tracking_Gen01,le.avelength_acquisition_tracking_Gen02,le.avelength_acquisition_tracking_Gen03,le.avelength_new_subaccount_year,le.avelength_new_subaccount_year_month,le.avelength_new_hh_year,le.avelength_new_hh_year_month,le.avelength_subaccount_attrition_year,le.avelength_subaccount_attrition_year_month,le.avelength_hh_attrition_year,le.avelength_hh_attrition_year_month,le.avelength_bussrv_r12m_tier_cd,le.avelength_bussrv_r12m_tier_desc,le.avelength_bussrv_r12m_tier_gen_1,le.avelength_bussrv_r12m_tier_gen_2,le.avelength_bussrv_py_tier_cd,le.avelength_bussrv_py_tier_desc,le.avelength_bussrv_py_tier_gen_1,le.avelength_bussrv_py_tier_gen_2,le.avelength_govt_cy_tier,le.avelength_cy_vertical_sk,le.avelength_py_vertical_sk,le.avelength_current_primary_territory_sk,le.avelength_current_secondary_territory_sk,le.avelength_ins_business_line,le.avelength_ins_market_code,le.avelength_ins_platform_type,le.avelength_mvr_alt1_gen01,le.avelength_mvr_alt1_gen02,le.avelength_mvr_alt1_gen03,le.avelength_mvr_alt1_gen04,le.avelength_mvr_rate_type,le.avelength_legal_entity_id,le.avelength_legal_entity_code,le.avelength_legal_entity_name,le.avelength_currency_id,le.avelength_currency_code,le.avelength_lang_code,le.avelength_lang_name,le.avelength_country,le.avelength_country_gen3,le.avelength_country_gen2,le.avelength_country_gen1,le.avelength_country_tier,le.avelength_PMK_Customer_Product,le.avelength_use_case,le.avelength_market_segment);
END;
EXPORT invSummary := NORMALIZE(summary0, 93, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.customer_account_sk),TRIM((SALT30.StrType)le.platform_cd),TRIM((SALT30.StrType)le.hh_id),TRIM((SALT30.StrType)le.hh_name),TRIM((SALT30.StrType)le.current_subaccount_id),TRIM((SALT30.StrType)le.hist_subaccount_id),TRIM((SALT30.StrType)le.subaccount_name),TRIM((SALT30.StrType)le.mbs_gc_id),TRIM((SALT30.StrType)le.mbs_reseller_parent_gc_id),TRIM((SALT30.StrType)le.mbs_reseller_parent_company_id),TRIM((SALT30.StrType)le.mbs_company_id),TRIM((SALT30.StrType)le.mbs_billing_id),TRIM((SALT30.StrType)le.mbs_product_id),TRIM((SALT30.StrType)le.mbs_sub_product_id),TRIM((SALT30.StrType)le.vc_id),TRIM((SALT30.StrType)le.ins_account),TRIM((SALT30.StrType)le.ins_account_suffix),TRIM((SALT30.StrType)le.dyt_sub_acct_id),TRIM((SALT30.StrType)le.ins_control_nbr),TRIM((SALT30.StrType)le.ins_control_name),TRIM((SALT30.StrType)le.ins_company_nbr),TRIM((SALT30.StrType)le.ins_company_name),TRIM((SALT30.StrType)le.dyt_account_id),TRIM((SALT30.StrType)le.dyt_account_name),TRIM((SALT30.StrType)le.dyt_customer_name),TRIM((SALT30.StrType)le.mbs_reseller_parent_name),TRIM((SALT30.StrType)le.cancel_reason),TRIM((SALT30.StrType)le.internal_flag),TRIM((SALT30.StrType)le.dummy_subaccount_flag),TRIM((SALT30.StrType)le.primary_market_gen_1),TRIM((SALT30.StrType)le.primary_market_cd),TRIM((SALT30.StrType)le.primary_market_desc),TRIM((SALT30.StrType)le.secondary_market_cd),TRIM((SALT30.StrType)le.secondary_market_desc),TRIM((SALT30.StrType)le.Sub_market),TRIM((SALT30.StrType)le.sub_market_gen_1),TRIM((SALT30.StrType)le.sub_market_gen_2),TRIM((SALT30.StrType)le.segment_lead),TRIM((SALT30.StrType)le.subaccount_status),TRIM((SALT30.StrType)le.acc_application_type),TRIM((SALT30.StrType)le.acc_company_type),TRIM((SALT30.StrType)le.bussrv_crd_customer),TRIM((SALT30.StrType)le.integrator),TRIM((SALT30.StrType)le.migration_type),TRIM((SALT30.StrType)le.aba_flag),TRIM((SALT30.StrType)le.acquisition_tracking),TRIM((SALT30.StrType)le.acquisition_tracking_Gen01),TRIM((SALT30.StrType)le.acquisition_tracking_Gen02),TRIM((SALT30.StrType)le.acquisition_tracking_Gen03),TRIM((SALT30.StrType)le.new_subaccount_year),TRIM((SALT30.StrType)le.new_subaccount_year_month),TRIM((SALT30.StrType)le.new_hh_year),TRIM((SALT30.StrType)le.new_hh_year_month),TRIM((SALT30.StrType)le.subaccount_attrition_year),TRIM((SALT30.StrType)le.subaccount_attrition_year_month),TRIM((SALT30.StrType)le.hh_attrition_year),TRIM((SALT30.StrType)le.hh_attrition_year_month),TRIM((SALT30.StrType)le.bussrv_r12m_tier_cd),TRIM((SALT30.StrType)le.bussrv_r12m_tier_desc),TRIM((SALT30.StrType)le.bussrv_r12m_tier_gen_1),TRIM((SALT30.StrType)le.bussrv_r12m_tier_gen_2),TRIM((SALT30.StrType)le.bussrv_py_tier_cd),TRIM((SALT30.StrType)le.bussrv_py_tier_desc),TRIM((SALT30.StrType)le.bussrv_py_tier_gen_1),TRIM((SALT30.StrType)le.bussrv_py_tier_gen_2),TRIM((SALT30.StrType)le.govt_cy_tier),TRIM((SALT30.StrType)le.cy_vertical_sk),TRIM((SALT30.StrType)le.py_vertical_sk),TRIM((SALT30.StrType)le.current_primary_territory_sk),TRIM((SALT30.StrType)le.current_secondary_territory_sk),TRIM((SALT30.StrType)le.ins_business_line),TRIM((SALT30.StrType)le.ins_market_code),TRIM((SALT30.StrType)le.ins_platform_type),TRIM((SALT30.StrType)le.mvr_alt1_gen01),TRIM((SALT30.StrType)le.mvr_alt1_gen02),TRIM((SALT30.StrType)le.mvr_alt1_gen03),TRIM((SALT30.StrType)le.mvr_alt1_gen04),TRIM((SALT30.StrType)le.mvr_rate_type),TRIM((SALT30.StrType)le.legal_entity_id),TRIM((SALT30.StrType)le.legal_entity_code),TRIM((SALT30.StrType)le.legal_entity_name),TRIM((SALT30.StrType)le.currency_id),TRIM((SALT30.StrType)le.currency_code),TRIM((SALT30.StrType)le.lang_code),TRIM((SALT30.StrType)le.lang_name),TRIM((SALT30.StrType)le.country),TRIM((SALT30.StrType)le.country_gen3),TRIM((SALT30.StrType)le.country_gen2),TRIM((SALT30.StrType)le.country_gen1),TRIM((SALT30.StrType)le.country_tier),TRIM((SALT30.StrType)le.PMK_Customer_Product),TRIM((SALT30.StrType)le.use_case),TRIM((SALT30.StrType)le.market_segment)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,93,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 93);
  SELF.FldNo2 := 1 + (C % 93);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.customer_account_sk),TRIM((SALT30.StrType)le.platform_cd),TRIM((SALT30.StrType)le.hh_id),TRIM((SALT30.StrType)le.hh_name),TRIM((SALT30.StrType)le.current_subaccount_id),TRIM((SALT30.StrType)le.hist_subaccount_id),TRIM((SALT30.StrType)le.subaccount_name),TRIM((SALT30.StrType)le.mbs_gc_id),TRIM((SALT30.StrType)le.mbs_reseller_parent_gc_id),TRIM((SALT30.StrType)le.mbs_reseller_parent_company_id),TRIM((SALT30.StrType)le.mbs_company_id),TRIM((SALT30.StrType)le.mbs_billing_id),TRIM((SALT30.StrType)le.mbs_product_id),TRIM((SALT30.StrType)le.mbs_sub_product_id),TRIM((SALT30.StrType)le.vc_id),TRIM((SALT30.StrType)le.ins_account),TRIM((SALT30.StrType)le.ins_account_suffix),TRIM((SALT30.StrType)le.dyt_sub_acct_id),TRIM((SALT30.StrType)le.ins_control_nbr),TRIM((SALT30.StrType)le.ins_control_name),TRIM((SALT30.StrType)le.ins_company_nbr),TRIM((SALT30.StrType)le.ins_company_name),TRIM((SALT30.StrType)le.dyt_account_id),TRIM((SALT30.StrType)le.dyt_account_name),TRIM((SALT30.StrType)le.dyt_customer_name),TRIM((SALT30.StrType)le.mbs_reseller_parent_name),TRIM((SALT30.StrType)le.cancel_reason),TRIM((SALT30.StrType)le.internal_flag),TRIM((SALT30.StrType)le.dummy_subaccount_flag),TRIM((SALT30.StrType)le.primary_market_gen_1),TRIM((SALT30.StrType)le.primary_market_cd),TRIM((SALT30.StrType)le.primary_market_desc),TRIM((SALT30.StrType)le.secondary_market_cd),TRIM((SALT30.StrType)le.secondary_market_desc),TRIM((SALT30.StrType)le.Sub_market),TRIM((SALT30.StrType)le.sub_market_gen_1),TRIM((SALT30.StrType)le.sub_market_gen_2),TRIM((SALT30.StrType)le.segment_lead),TRIM((SALT30.StrType)le.subaccount_status),TRIM((SALT30.StrType)le.acc_application_type),TRIM((SALT30.StrType)le.acc_company_type),TRIM((SALT30.StrType)le.bussrv_crd_customer),TRIM((SALT30.StrType)le.integrator),TRIM((SALT30.StrType)le.migration_type),TRIM((SALT30.StrType)le.aba_flag),TRIM((SALT30.StrType)le.acquisition_tracking),TRIM((SALT30.StrType)le.acquisition_tracking_Gen01),TRIM((SALT30.StrType)le.acquisition_tracking_Gen02),TRIM((SALT30.StrType)le.acquisition_tracking_Gen03),TRIM((SALT30.StrType)le.new_subaccount_year),TRIM((SALT30.StrType)le.new_subaccount_year_month),TRIM((SALT30.StrType)le.new_hh_year),TRIM((SALT30.StrType)le.new_hh_year_month),TRIM((SALT30.StrType)le.subaccount_attrition_year),TRIM((SALT30.StrType)le.subaccount_attrition_year_month),TRIM((SALT30.StrType)le.hh_attrition_year),TRIM((SALT30.StrType)le.hh_attrition_year_month),TRIM((SALT30.StrType)le.bussrv_r12m_tier_cd),TRIM((SALT30.StrType)le.bussrv_r12m_tier_desc),TRIM((SALT30.StrType)le.bussrv_r12m_tier_gen_1),TRIM((SALT30.StrType)le.bussrv_r12m_tier_gen_2),TRIM((SALT30.StrType)le.bussrv_py_tier_cd),TRIM((SALT30.StrType)le.bussrv_py_tier_desc),TRIM((SALT30.StrType)le.bussrv_py_tier_gen_1),TRIM((SALT30.StrType)le.bussrv_py_tier_gen_2),TRIM((SALT30.StrType)le.govt_cy_tier),TRIM((SALT30.StrType)le.cy_vertical_sk),TRIM((SALT30.StrType)le.py_vertical_sk),TRIM((SALT30.StrType)le.current_primary_territory_sk),TRIM((SALT30.StrType)le.current_secondary_territory_sk),TRIM((SALT30.StrType)le.ins_business_line),TRIM((SALT30.StrType)le.ins_market_code),TRIM((SALT30.StrType)le.ins_platform_type),TRIM((SALT30.StrType)le.mvr_alt1_gen01),TRIM((SALT30.StrType)le.mvr_alt1_gen02),TRIM((SALT30.StrType)le.mvr_alt1_gen03),TRIM((SALT30.StrType)le.mvr_alt1_gen04),TRIM((SALT30.StrType)le.mvr_rate_type),TRIM((SALT30.StrType)le.legal_entity_id),TRIM((SALT30.StrType)le.legal_entity_code),TRIM((SALT30.StrType)le.legal_entity_name),TRIM((SALT30.StrType)le.currency_id),TRIM((SALT30.StrType)le.currency_code),TRIM((SALT30.StrType)le.lang_code),TRIM((SALT30.StrType)le.lang_name),TRIM((SALT30.StrType)le.country),TRIM((SALT30.StrType)le.country_gen3),TRIM((SALT30.StrType)le.country_gen2),TRIM((SALT30.StrType)le.country_gen1),TRIM((SALT30.StrType)le.country_tier),TRIM((SALT30.StrType)le.PMK_Customer_Product),TRIM((SALT30.StrType)le.use_case),TRIM((SALT30.StrType)le.market_segment)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.customer_account_sk),TRIM((SALT30.StrType)le.platform_cd),TRIM((SALT30.StrType)le.hh_id),TRIM((SALT30.StrType)le.hh_name),TRIM((SALT30.StrType)le.current_subaccount_id),TRIM((SALT30.StrType)le.hist_subaccount_id),TRIM((SALT30.StrType)le.subaccount_name),TRIM((SALT30.StrType)le.mbs_gc_id),TRIM((SALT30.StrType)le.mbs_reseller_parent_gc_id),TRIM((SALT30.StrType)le.mbs_reseller_parent_company_id),TRIM((SALT30.StrType)le.mbs_company_id),TRIM((SALT30.StrType)le.mbs_billing_id),TRIM((SALT30.StrType)le.mbs_product_id),TRIM((SALT30.StrType)le.mbs_sub_product_id),TRIM((SALT30.StrType)le.vc_id),TRIM((SALT30.StrType)le.ins_account),TRIM((SALT30.StrType)le.ins_account_suffix),TRIM((SALT30.StrType)le.dyt_sub_acct_id),TRIM((SALT30.StrType)le.ins_control_nbr),TRIM((SALT30.StrType)le.ins_control_name),TRIM((SALT30.StrType)le.ins_company_nbr),TRIM((SALT30.StrType)le.ins_company_name),TRIM((SALT30.StrType)le.dyt_account_id),TRIM((SALT30.StrType)le.dyt_account_name),TRIM((SALT30.StrType)le.dyt_customer_name),TRIM((SALT30.StrType)le.mbs_reseller_parent_name),TRIM((SALT30.StrType)le.cancel_reason),TRIM((SALT30.StrType)le.internal_flag),TRIM((SALT30.StrType)le.dummy_subaccount_flag),TRIM((SALT30.StrType)le.primary_market_gen_1),TRIM((SALT30.StrType)le.primary_market_cd),TRIM((SALT30.StrType)le.primary_market_desc),TRIM((SALT30.StrType)le.secondary_market_cd),TRIM((SALT30.StrType)le.secondary_market_desc),TRIM((SALT30.StrType)le.Sub_market),TRIM((SALT30.StrType)le.sub_market_gen_1),TRIM((SALT30.StrType)le.sub_market_gen_2),TRIM((SALT30.StrType)le.segment_lead),TRIM((SALT30.StrType)le.subaccount_status),TRIM((SALT30.StrType)le.acc_application_type),TRIM((SALT30.StrType)le.acc_company_type),TRIM((SALT30.StrType)le.bussrv_crd_customer),TRIM((SALT30.StrType)le.integrator),TRIM((SALT30.StrType)le.migration_type),TRIM((SALT30.StrType)le.aba_flag),TRIM((SALT30.StrType)le.acquisition_tracking),TRIM((SALT30.StrType)le.acquisition_tracking_Gen01),TRIM((SALT30.StrType)le.acquisition_tracking_Gen02),TRIM((SALT30.StrType)le.acquisition_tracking_Gen03),TRIM((SALT30.StrType)le.new_subaccount_year),TRIM((SALT30.StrType)le.new_subaccount_year_month),TRIM((SALT30.StrType)le.new_hh_year),TRIM((SALT30.StrType)le.new_hh_year_month),TRIM((SALT30.StrType)le.subaccount_attrition_year),TRIM((SALT30.StrType)le.subaccount_attrition_year_month),TRIM((SALT30.StrType)le.hh_attrition_year),TRIM((SALT30.StrType)le.hh_attrition_year_month),TRIM((SALT30.StrType)le.bussrv_r12m_tier_cd),TRIM((SALT30.StrType)le.bussrv_r12m_tier_desc),TRIM((SALT30.StrType)le.bussrv_r12m_tier_gen_1),TRIM((SALT30.StrType)le.bussrv_r12m_tier_gen_2),TRIM((SALT30.StrType)le.bussrv_py_tier_cd),TRIM((SALT30.StrType)le.bussrv_py_tier_desc),TRIM((SALT30.StrType)le.bussrv_py_tier_gen_1),TRIM((SALT30.StrType)le.bussrv_py_tier_gen_2),TRIM((SALT30.StrType)le.govt_cy_tier),TRIM((SALT30.StrType)le.cy_vertical_sk),TRIM((SALT30.StrType)le.py_vertical_sk),TRIM((SALT30.StrType)le.current_primary_territory_sk),TRIM((SALT30.StrType)le.current_secondary_territory_sk),TRIM((SALT30.StrType)le.ins_business_line),TRIM((SALT30.StrType)le.ins_market_code),TRIM((SALT30.StrType)le.ins_platform_type),TRIM((SALT30.StrType)le.mvr_alt1_gen01),TRIM((SALT30.StrType)le.mvr_alt1_gen02),TRIM((SALT30.StrType)le.mvr_alt1_gen03),TRIM((SALT30.StrType)le.mvr_alt1_gen04),TRIM((SALT30.StrType)le.mvr_rate_type),TRIM((SALT30.StrType)le.legal_entity_id),TRIM((SALT30.StrType)le.legal_entity_code),TRIM((SALT30.StrType)le.legal_entity_name),TRIM((SALT30.StrType)le.currency_id),TRIM((SALT30.StrType)le.currency_code),TRIM((SALT30.StrType)le.lang_code),TRIM((SALT30.StrType)le.lang_name),TRIM((SALT30.StrType)le.country),TRIM((SALT30.StrType)le.country_gen3),TRIM((SALT30.StrType)le.country_gen2),TRIM((SALT30.StrType)le.country_gen1),TRIM((SALT30.StrType)le.country_tier),TRIM((SALT30.StrType)le.PMK_Customer_Product),TRIM((SALT30.StrType)le.use_case),TRIM((SALT30.StrType)le.market_segment)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),93*93,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'customer_account_sk'}
      ,{2,'platform_cd'}
      ,{3,'hh_id'}
      ,{4,'hh_name'}
      ,{5,'current_subaccount_id'}
      ,{6,'hist_subaccount_id'}
      ,{7,'subaccount_name'}
      ,{8,'mbs_gc_id'}
      ,{9,'mbs_reseller_parent_gc_id'}
      ,{10,'mbs_reseller_parent_company_id'}
      ,{11,'mbs_company_id'}
      ,{12,'mbs_billing_id'}
      ,{13,'mbs_product_id'}
      ,{14,'mbs_sub_product_id'}
      ,{15,'vc_id'}
      ,{16,'ins_account'}
      ,{17,'ins_account_suffix'}
      ,{18,'dyt_sub_acct_id'}
      ,{19,'ins_control_nbr'}
      ,{20,'ins_control_name'}
      ,{21,'ins_company_nbr'}
      ,{22,'ins_company_name'}
      ,{23,'dyt_account_id'}
      ,{24,'dyt_account_name'}
      ,{25,'dyt_customer_name'}
      ,{26,'mbs_reseller_parent_name'}
      ,{27,'cancel_reason'}
      ,{28,'internal_flag'}
      ,{29,'dummy_subaccount_flag'}
      ,{30,'primary_market_gen_1'}
      ,{31,'primary_market_cd'}
      ,{32,'primary_market_desc'}
      ,{33,'secondary_market_cd'}
      ,{34,'secondary_market_desc'}
      ,{35,'Sub_market'}
      ,{36,'sub_market_gen_1'}
      ,{37,'sub_market_gen_2'}
      ,{38,'segment_lead'}
      ,{39,'subaccount_status'}
      ,{40,'acc_application_type'}
      ,{41,'acc_company_type'}
      ,{42,'bussrv_crd_customer'}
      ,{43,'integrator'}
      ,{44,'migration_type'}
      ,{45,'aba_flag'}
      ,{46,'acquisition_tracking'}
      ,{47,'acquisition_tracking_Gen01'}
      ,{48,'acquisition_tracking_Gen02'}
      ,{49,'acquisition_tracking_Gen03'}
      ,{50,'new_subaccount_year'}
      ,{51,'new_subaccount_year_month'}
      ,{52,'new_hh_year'}
      ,{53,'new_hh_year_month'}
      ,{54,'subaccount_attrition_year'}
      ,{55,'subaccount_attrition_year_month'}
      ,{56,'hh_attrition_year'}
      ,{57,'hh_attrition_year_month'}
      ,{58,'bussrv_r12m_tier_cd'}
      ,{59,'bussrv_r12m_tier_desc'}
      ,{60,'bussrv_r12m_tier_gen_1'}
      ,{61,'bussrv_r12m_tier_gen_2'}
      ,{62,'bussrv_py_tier_cd'}
      ,{63,'bussrv_py_tier_desc'}
      ,{64,'bussrv_py_tier_gen_1'}
      ,{65,'bussrv_py_tier_gen_2'}
      ,{66,'govt_cy_tier'}
      ,{67,'cy_vertical_sk'}
      ,{68,'py_vertical_sk'}
      ,{69,'current_primary_territory_sk'}
      ,{70,'current_secondary_territory_sk'}
      ,{71,'ins_business_line'}
      ,{72,'ins_market_code'}
      ,{73,'ins_platform_type'}
      ,{74,'mvr_alt1_gen01'}
      ,{75,'mvr_alt1_gen02'}
      ,{76,'mvr_alt1_gen03'}
      ,{77,'mvr_alt1_gen04'}
      ,{78,'mvr_rate_type'}
      ,{79,'legal_entity_id'}
      ,{80,'legal_entity_code'}
      ,{81,'legal_entity_name'}
      ,{82,'currency_id'}
      ,{83,'currency_code'}
      ,{84,'lang_code'}
      ,{85,'lang_name'}
      ,{86,'country'}
      ,{87,'country_gen3'}
      ,{88,'country_gen2'}
      ,{89,'country_gen1'}
      ,{90,'country_tier'}
      ,{91,'PMK_Customer_Product'}
      ,{92,'use_case'}
      ,{93,'market_segment'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_customer_account_sk((SALT30.StrType)le.customer_account_sk),
    Fields.InValid_platform_cd((SALT30.StrType)le.platform_cd),
    Fields.InValid_hh_id((SALT30.StrType)le.hh_id),
    Fields.InValid_hh_name((SALT30.StrType)le.hh_name),
    Fields.InValid_current_subaccount_id((SALT30.StrType)le.current_subaccount_id),
    Fields.InValid_hist_subaccount_id((SALT30.StrType)le.hist_subaccount_id),
    Fields.InValid_subaccount_name((SALT30.StrType)le.subaccount_name),
    Fields.InValid_mbs_gc_id((SALT30.StrType)le.mbs_gc_id),
    Fields.InValid_mbs_reseller_parent_gc_id((SALT30.StrType)le.mbs_reseller_parent_gc_id),
    Fields.InValid_mbs_reseller_parent_company_id((SALT30.StrType)le.mbs_reseller_parent_company_id),
    Fields.InValid_mbs_company_id((SALT30.StrType)le.mbs_company_id),
    Fields.InValid_mbs_billing_id((SALT30.StrType)le.mbs_billing_id),
    Fields.InValid_mbs_product_id((SALT30.StrType)le.mbs_product_id),
    Fields.InValid_mbs_sub_product_id((SALT30.StrType)le.mbs_sub_product_id),
    Fields.InValid_vc_id((SALT30.StrType)le.vc_id),
    Fields.InValid_ins_account((SALT30.StrType)le.ins_account),
    Fields.InValid_ins_account_suffix((SALT30.StrType)le.ins_account_suffix),
    Fields.InValid_dyt_sub_acct_id((SALT30.StrType)le.dyt_sub_acct_id),
    Fields.InValid_ins_control_nbr((SALT30.StrType)le.ins_control_nbr),
    Fields.InValid_ins_control_name((SALT30.StrType)le.ins_control_name),
    Fields.InValid_ins_company_nbr((SALT30.StrType)le.ins_company_nbr),
    Fields.InValid_ins_company_name((SALT30.StrType)le.ins_company_name),
    Fields.InValid_dyt_account_id((SALT30.StrType)le.dyt_account_id),
    Fields.InValid_dyt_account_name((SALT30.StrType)le.dyt_account_name),
    Fields.InValid_dyt_customer_name((SALT30.StrType)le.dyt_customer_name),
    Fields.InValid_mbs_reseller_parent_name((SALT30.StrType)le.mbs_reseller_parent_name),
    Fields.InValid_cancel_reason((SALT30.StrType)le.cancel_reason),
    Fields.InValid_internal_flag((SALT30.StrType)le.internal_flag),
    Fields.InValid_dummy_subaccount_flag((SALT30.StrType)le.dummy_subaccount_flag),
    Fields.InValid_primary_market_gen_1((SALT30.StrType)le.primary_market_gen_1),
    Fields.InValid_primary_market_cd((SALT30.StrType)le.primary_market_cd),
    Fields.InValid_primary_market_desc((SALT30.StrType)le.primary_market_desc),
    Fields.InValid_secondary_market_cd((SALT30.StrType)le.secondary_market_cd),
    Fields.InValid_secondary_market_desc((SALT30.StrType)le.secondary_market_desc),
    Fields.InValid_Sub_market((SALT30.StrType)le.Sub_market),
    Fields.InValid_sub_market_gen_1((SALT30.StrType)le.sub_market_gen_1),
    Fields.InValid_sub_market_gen_2((SALT30.StrType)le.sub_market_gen_2),
    Fields.InValid_segment_lead((SALT30.StrType)le.segment_lead),
    Fields.InValid_subaccount_status((SALT30.StrType)le.subaccount_status),
    Fields.InValid_acc_application_type((SALT30.StrType)le.acc_application_type),
    Fields.InValid_acc_company_type((SALT30.StrType)le.acc_company_type),
    Fields.InValid_bussrv_crd_customer((SALT30.StrType)le.bussrv_crd_customer),
    Fields.InValid_integrator((SALT30.StrType)le.integrator),
    Fields.InValid_migration_type((SALT30.StrType)le.migration_type),
    Fields.InValid_aba_flag((SALT30.StrType)le.aba_flag),
    Fields.InValid_acquisition_tracking((SALT30.StrType)le.acquisition_tracking),
    Fields.InValid_acquisition_tracking_Gen01((SALT30.StrType)le.acquisition_tracking_Gen01),
    Fields.InValid_acquisition_tracking_Gen02((SALT30.StrType)le.acquisition_tracking_Gen02),
    Fields.InValid_acquisition_tracking_Gen03((SALT30.StrType)le.acquisition_tracking_Gen03),
    Fields.InValid_new_subaccount_year((SALT30.StrType)le.new_subaccount_year),
    Fields.InValid_new_subaccount_year_month((SALT30.StrType)le.new_subaccount_year_month),
    Fields.InValid_new_hh_year((SALT30.StrType)le.new_hh_year),
    Fields.InValid_new_hh_year_month((SALT30.StrType)le.new_hh_year_month),
    Fields.InValid_subaccount_attrition_year((SALT30.StrType)le.subaccount_attrition_year),
    Fields.InValid_subaccount_attrition_year_month((SALT30.StrType)le.subaccount_attrition_year_month),
    Fields.InValid_hh_attrition_year((SALT30.StrType)le.hh_attrition_year),
    Fields.InValid_hh_attrition_year_month((SALT30.StrType)le.hh_attrition_year_month),
    Fields.InValid_bussrv_r12m_tier_cd((SALT30.StrType)le.bussrv_r12m_tier_cd),
    Fields.InValid_bussrv_r12m_tier_desc((SALT30.StrType)le.bussrv_r12m_tier_desc),
    Fields.InValid_bussrv_r12m_tier_gen_1((SALT30.StrType)le.bussrv_r12m_tier_gen_1),
    Fields.InValid_bussrv_r12m_tier_gen_2((SALT30.StrType)le.bussrv_r12m_tier_gen_2),
    Fields.InValid_bussrv_py_tier_cd((SALT30.StrType)le.bussrv_py_tier_cd),
    Fields.InValid_bussrv_py_tier_desc((SALT30.StrType)le.bussrv_py_tier_desc),
    Fields.InValid_bussrv_py_tier_gen_1((SALT30.StrType)le.bussrv_py_tier_gen_1),
    Fields.InValid_bussrv_py_tier_gen_2((SALT30.StrType)le.bussrv_py_tier_gen_2),
    Fields.InValid_govt_cy_tier((SALT30.StrType)le.govt_cy_tier),
    Fields.InValid_cy_vertical_sk((SALT30.StrType)le.cy_vertical_sk),
    Fields.InValid_py_vertical_sk((SALT30.StrType)le.py_vertical_sk),
    Fields.InValid_current_primary_territory_sk((SALT30.StrType)le.current_primary_territory_sk),
    Fields.InValid_current_secondary_territory_sk((SALT30.StrType)le.current_secondary_territory_sk),
    Fields.InValid_ins_business_line((SALT30.StrType)le.ins_business_line),
    Fields.InValid_ins_market_code((SALT30.StrType)le.ins_market_code),
    Fields.InValid_ins_platform_type((SALT30.StrType)le.ins_platform_type),
    Fields.InValid_mvr_alt1_gen01((SALT30.StrType)le.mvr_alt1_gen01),
    Fields.InValid_mvr_alt1_gen02((SALT30.StrType)le.mvr_alt1_gen02),
    Fields.InValid_mvr_alt1_gen03((SALT30.StrType)le.mvr_alt1_gen03),
    Fields.InValid_mvr_alt1_gen04((SALT30.StrType)le.mvr_alt1_gen04),
    Fields.InValid_mvr_rate_type((SALT30.StrType)le.mvr_rate_type),
    Fields.InValid_legal_entity_id((SALT30.StrType)le.legal_entity_id),
    Fields.InValid_legal_entity_code((SALT30.StrType)le.legal_entity_code),
    Fields.InValid_legal_entity_name((SALT30.StrType)le.legal_entity_name),
    Fields.InValid_currency_id((SALT30.StrType)le.currency_id),
    Fields.InValid_currency_code((SALT30.StrType)le.currency_code),
    Fields.InValid_lang_code((SALT30.StrType)le.lang_code),
    Fields.InValid_lang_name((SALT30.StrType)le.lang_name),
    Fields.InValid_country((SALT30.StrType)le.country),
    Fields.InValid_country_gen3((SALT30.StrType)le.country_gen3),
    Fields.InValid_country_gen2((SALT30.StrType)le.country_gen2),
    Fields.InValid_country_gen1((SALT30.StrType)le.country_gen1),
    Fields.InValid_country_tier((SALT30.StrType)le.country_tier),
    Fields.InValid_PMK_Customer_Product((SALT30.StrType)le.PMK_Customer_Product),
    Fields.InValid_use_case((SALT30.StrType)le.use_case),
    Fields.InValid_market_segment((SALT30.StrType)le.market_segment),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,93,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_customer_account_sk(TotalErrors.ErrorNum),Fields.InValidMessage_platform_cd(TotalErrors.ErrorNum),Fields.InValidMessage_hh_id(TotalErrors.ErrorNum),Fields.InValidMessage_hh_name(TotalErrors.ErrorNum),Fields.InValidMessage_current_subaccount_id(TotalErrors.ErrorNum),Fields.InValidMessage_hist_subaccount_id(TotalErrors.ErrorNum),Fields.InValidMessage_subaccount_name(TotalErrors.ErrorNum),Fields.InValidMessage_mbs_gc_id(TotalErrors.ErrorNum),Fields.InValidMessage_mbs_reseller_parent_gc_id(TotalErrors.ErrorNum),Fields.InValidMessage_mbs_reseller_parent_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_mbs_company_id(TotalErrors.ErrorNum),Fields.InValidMessage_mbs_billing_id(TotalErrors.ErrorNum),Fields.InValidMessage_mbs_product_id(TotalErrors.ErrorNum),Fields.InValidMessage_mbs_sub_product_id(TotalErrors.ErrorNum),Fields.InValidMessage_vc_id(TotalErrors.ErrorNum),Fields.InValidMessage_ins_account(TotalErrors.ErrorNum),Fields.InValidMessage_ins_account_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_dyt_sub_acct_id(TotalErrors.ErrorNum),Fields.InValidMessage_ins_control_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_ins_control_name(TotalErrors.ErrorNum),Fields.InValidMessage_ins_company_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_ins_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_dyt_account_id(TotalErrors.ErrorNum),Fields.InValidMessage_dyt_account_name(TotalErrors.ErrorNum),Fields.InValidMessage_dyt_customer_name(TotalErrors.ErrorNum),Fields.InValidMessage_mbs_reseller_parent_name(TotalErrors.ErrorNum),Fields.InValidMessage_cancel_reason(TotalErrors.ErrorNum),Fields.InValidMessage_internal_flag(TotalErrors.ErrorNum),Fields.InValidMessage_dummy_subaccount_flag(TotalErrors.ErrorNum),Fields.InValidMessage_primary_market_gen_1(TotalErrors.ErrorNum),Fields.InValidMessage_primary_market_cd(TotalErrors.ErrorNum),Fields.InValidMessage_primary_market_desc(TotalErrors.ErrorNum),Fields.InValidMessage_secondary_market_cd(TotalErrors.ErrorNum),Fields.InValidMessage_secondary_market_desc(TotalErrors.ErrorNum),Fields.InValidMessage_Sub_market(TotalErrors.ErrorNum),Fields.InValidMessage_sub_market_gen_1(TotalErrors.ErrorNum),Fields.InValidMessage_sub_market_gen_2(TotalErrors.ErrorNum),Fields.InValidMessage_segment_lead(TotalErrors.ErrorNum),Fields.InValidMessage_subaccount_status(TotalErrors.ErrorNum),Fields.InValidMessage_acc_application_type(TotalErrors.ErrorNum),Fields.InValidMessage_acc_company_type(TotalErrors.ErrorNum),Fields.InValidMessage_bussrv_crd_customer(TotalErrors.ErrorNum),Fields.InValidMessage_integrator(TotalErrors.ErrorNum),Fields.InValidMessage_migration_type(TotalErrors.ErrorNum),Fields.InValidMessage_aba_flag(TotalErrors.ErrorNum),Fields.InValidMessage_acquisition_tracking(TotalErrors.ErrorNum),Fields.InValidMessage_acquisition_tracking_Gen01(TotalErrors.ErrorNum),Fields.InValidMessage_acquisition_tracking_Gen02(TotalErrors.ErrorNum),Fields.InValidMessage_acquisition_tracking_Gen03(TotalErrors.ErrorNum),Fields.InValidMessage_new_subaccount_year(TotalErrors.ErrorNum),Fields.InValidMessage_new_subaccount_year_month(TotalErrors.ErrorNum),Fields.InValidMessage_new_hh_year(TotalErrors.ErrorNum),Fields.InValidMessage_new_hh_year_month(TotalErrors.ErrorNum),Fields.InValidMessage_subaccount_attrition_year(TotalErrors.ErrorNum),Fields.InValidMessage_subaccount_attrition_year_month(TotalErrors.ErrorNum),Fields.InValidMessage_hh_attrition_year(TotalErrors.ErrorNum),Fields.InValidMessage_hh_attrition_year_month(TotalErrors.ErrorNum),Fields.InValidMessage_bussrv_r12m_tier_cd(TotalErrors.ErrorNum),Fields.InValidMessage_bussrv_r12m_tier_desc(TotalErrors.ErrorNum),Fields.InValidMessage_bussrv_r12m_tier_gen_1(TotalErrors.ErrorNum),Fields.InValidMessage_bussrv_r12m_tier_gen_2(TotalErrors.ErrorNum),Fields.InValidMessage_bussrv_py_tier_cd(TotalErrors.ErrorNum),Fields.InValidMessage_bussrv_py_tier_desc(TotalErrors.ErrorNum),Fields.InValidMessage_bussrv_py_tier_gen_1(TotalErrors.ErrorNum),Fields.InValidMessage_bussrv_py_tier_gen_2(TotalErrors.ErrorNum),Fields.InValidMessage_govt_cy_tier(TotalErrors.ErrorNum),Fields.InValidMessage_cy_vertical_sk(TotalErrors.ErrorNum),Fields.InValidMessage_py_vertical_sk(TotalErrors.ErrorNum),Fields.InValidMessage_current_primary_territory_sk(TotalErrors.ErrorNum),Fields.InValidMessage_current_secondary_territory_sk(TotalErrors.ErrorNum),Fields.InValidMessage_ins_business_line(TotalErrors.ErrorNum),Fields.InValidMessage_ins_market_code(TotalErrors.ErrorNum),Fields.InValidMessage_ins_platform_type(TotalErrors.ErrorNum),Fields.InValidMessage_mvr_alt1_gen01(TotalErrors.ErrorNum),Fields.InValidMessage_mvr_alt1_gen02(TotalErrors.ErrorNum),Fields.InValidMessage_mvr_alt1_gen03(TotalErrors.ErrorNum),Fields.InValidMessage_mvr_alt1_gen04(TotalErrors.ErrorNum),Fields.InValidMessage_mvr_rate_type(TotalErrors.ErrorNum),Fields.InValidMessage_legal_entity_id(TotalErrors.ErrorNum),Fields.InValidMessage_legal_entity_code(TotalErrors.ErrorNum),Fields.InValidMessage_legal_entity_name(TotalErrors.ErrorNum),Fields.InValidMessage_currency_id(TotalErrors.ErrorNum),Fields.InValidMessage_currency_code(TotalErrors.ErrorNum),Fields.InValidMessage_lang_code(TotalErrors.ErrorNum),Fields.InValidMessage_lang_name(TotalErrors.ErrorNum),Fields.InValidMessage_country(TotalErrors.ErrorNum),Fields.InValidMessage_country_gen3(TotalErrors.ErrorNum),Fields.InValidMessage_country_gen2(TotalErrors.ErrorNum),Fields.InValidMessage_country_gen1(TotalErrors.ErrorNum),Fields.InValidMessage_country_tier(TotalErrors.ErrorNum),Fields.InValidMessage_PMK_Customer_Product(TotalErrors.ErrorNum),Fields.InValidMessage_use_case(TotalErrors.ErrorNum),Fields.InValidMessage_market_segment(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
