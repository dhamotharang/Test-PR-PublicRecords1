EXPORT MAC_PopulationStatistics(infile,Ref='',Input_customer_account_sk = '',Input_platform_cd = '',Input_hh_id = '',Input_hh_name = '',Input_current_subaccount_id = '',Input_hist_subaccount_id = '',Input_subaccount_name = '',Input_mbs_gc_id = '',Input_mbs_reseller_parent_gc_id = '',Input_mbs_reseller_parent_company_id = '',Input_mbs_company_id = '',Input_mbs_billing_id = '',Input_mbs_product_id = '',Input_mbs_sub_product_id = '',Input_vc_id = '',Input_ins_account = '',Input_ins_account_suffix = '',Input_dyt_sub_acct_id = '',Input_ins_control_nbr = '',Input_ins_control_name = '',Input_ins_company_nbr = '',Input_ins_company_name = '',Input_dyt_account_id = '',Input_dyt_account_name = '',Input_dyt_customer_name = '',Input_mbs_reseller_parent_name = '',Input_cancel_reason = '',Input_internal_flag = '',Input_dummy_subaccount_flag = '',Input_primary_market_gen_1 = '',Input_primary_market_cd = '',Input_primary_market_desc = '',Input_secondary_market_cd = '',Input_secondary_market_desc = '',Input_Sub_market = '',Input_sub_market_gen_1 = '',Input_sub_market_gen_2 = '',Input_segment_lead = '',Input_subaccount_status = '',Input_acc_application_type = '',Input_acc_company_type = '',Input_bussrv_crd_customer = '',Input_integrator = '',Input_migration_type = '',Input_aba_flag = '',Input_acquisition_tracking = '',Input_acquisition_tracking_Gen01 = '',Input_acquisition_tracking_Gen02 = '',Input_acquisition_tracking_Gen03 = '',Input_new_subaccount_year = '',Input_new_subaccount_year_month = '',Input_new_hh_year = '',Input_new_hh_year_month = '',Input_subaccount_attrition_year = '',Input_subaccount_attrition_year_month = '',Input_hh_attrition_year = '',Input_hh_attrition_year_month = '',Input_bussrv_r12m_tier_cd = '',Input_bussrv_r12m_tier_desc = '',Input_bussrv_r12m_tier_gen_1 = '',Input_bussrv_r12m_tier_gen_2 = '',Input_bussrv_py_tier_cd = '',Input_bussrv_py_tier_desc = '',Input_bussrv_py_tier_gen_1 = '',Input_bussrv_py_tier_gen_2 = '',Input_govt_cy_tier = '',Input_cy_vertical_sk = '',Input_py_vertical_sk = '',Input_current_primary_territory_sk = '',Input_current_secondary_territory_sk = '',Input_ins_business_line = '',Input_ins_market_code = '',Input_ins_platform_type = '',Input_mvr_alt1_gen01 = '',Input_mvr_alt1_gen02 = '',Input_mvr_alt1_gen03 = '',Input_mvr_alt1_gen04 = '',Input_mvr_rate_type = '',Input_legal_entity_id = '',Input_legal_entity_code = '',Input_legal_entity_name = '',Input_currency_id = '',Input_currency_code = '',Input_lang_code = '',Input_lang_name = '',Input_country = '',Input_country_gen3 = '',Input_country_gen2 = '',Input_country_gen1 = '',Input_country_tier = '',Input_PMK_Customer_Product = '',Input_use_case = '',Input_market_segment = '',OutFile) := MACRO
  IMPORT SALT30,scrubs_FIDO;
  #uniquename(of)
  %of% := RECORD
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_customer_account_sk)='' )
      '' 
    #ELSE
        IF( le.Input_customer_account_sk = (TYPEOF(le.Input_customer_account_sk))'','',':customer_account_sk')
    #END
+    #IF( #TEXT(Input_platform_cd)='' )
      '' 
    #ELSE
        IF( le.Input_platform_cd = (TYPEOF(le.Input_platform_cd))'','',':platform_cd')
    #END
+    #IF( #TEXT(Input_hh_id)='' )
      '' 
    #ELSE
        IF( le.Input_hh_id = (TYPEOF(le.Input_hh_id))'','',':hh_id')
    #END
+    #IF( #TEXT(Input_hh_name)='' )
      '' 
    #ELSE
        IF( le.Input_hh_name = (TYPEOF(le.Input_hh_name))'','',':hh_name')
    #END
+    #IF( #TEXT(Input_current_subaccount_id)='' )
      '' 
    #ELSE
        IF( le.Input_current_subaccount_id = (TYPEOF(le.Input_current_subaccount_id))'','',':current_subaccount_id')
    #END
+    #IF( #TEXT(Input_hist_subaccount_id)='' )
      '' 
    #ELSE
        IF( le.Input_hist_subaccount_id = (TYPEOF(le.Input_hist_subaccount_id))'','',':hist_subaccount_id')
    #END
+    #IF( #TEXT(Input_subaccount_name)='' )
      '' 
    #ELSE
        IF( le.Input_subaccount_name = (TYPEOF(le.Input_subaccount_name))'','',':subaccount_name')
    #END
+    #IF( #TEXT(Input_mbs_gc_id)='' )
      '' 
    #ELSE
        IF( le.Input_mbs_gc_id = (TYPEOF(le.Input_mbs_gc_id))'','',':mbs_gc_id')
    #END
+    #IF( #TEXT(Input_mbs_reseller_parent_gc_id)='' )
      '' 
    #ELSE
        IF( le.Input_mbs_reseller_parent_gc_id = (TYPEOF(le.Input_mbs_reseller_parent_gc_id))'','',':mbs_reseller_parent_gc_id')
    #END
+    #IF( #TEXT(Input_mbs_reseller_parent_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_mbs_reseller_parent_company_id = (TYPEOF(le.Input_mbs_reseller_parent_company_id))'','',':mbs_reseller_parent_company_id')
    #END
+    #IF( #TEXT(Input_mbs_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_mbs_company_id = (TYPEOF(le.Input_mbs_company_id))'','',':mbs_company_id')
    #END
+    #IF( #TEXT(Input_mbs_billing_id)='' )
      '' 
    #ELSE
        IF( le.Input_mbs_billing_id = (TYPEOF(le.Input_mbs_billing_id))'','',':mbs_billing_id')
    #END
+    #IF( #TEXT(Input_mbs_product_id)='' )
      '' 
    #ELSE
        IF( le.Input_mbs_product_id = (TYPEOF(le.Input_mbs_product_id))'','',':mbs_product_id')
    #END
+    #IF( #TEXT(Input_mbs_sub_product_id)='' )
      '' 
    #ELSE
        IF( le.Input_mbs_sub_product_id = (TYPEOF(le.Input_mbs_sub_product_id))'','',':mbs_sub_product_id')
    #END
+    #IF( #TEXT(Input_vc_id)='' )
      '' 
    #ELSE
        IF( le.Input_vc_id = (TYPEOF(le.Input_vc_id))'','',':vc_id')
    #END
+    #IF( #TEXT(Input_ins_account)='' )
      '' 
    #ELSE
        IF( le.Input_ins_account = (TYPEOF(le.Input_ins_account))'','',':ins_account')
    #END
+    #IF( #TEXT(Input_ins_account_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_ins_account_suffix = (TYPEOF(le.Input_ins_account_suffix))'','',':ins_account_suffix')
    #END
+    #IF( #TEXT(Input_dyt_sub_acct_id)='' )
      '' 
    #ELSE
        IF( le.Input_dyt_sub_acct_id = (TYPEOF(le.Input_dyt_sub_acct_id))'','',':dyt_sub_acct_id')
    #END
+    #IF( #TEXT(Input_ins_control_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_ins_control_nbr = (TYPEOF(le.Input_ins_control_nbr))'','',':ins_control_nbr')
    #END
+    #IF( #TEXT(Input_ins_control_name)='' )
      '' 
    #ELSE
        IF( le.Input_ins_control_name = (TYPEOF(le.Input_ins_control_name))'','',':ins_control_name')
    #END
+    #IF( #TEXT(Input_ins_company_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_ins_company_nbr = (TYPEOF(le.Input_ins_company_nbr))'','',':ins_company_nbr')
    #END
+    #IF( #TEXT(Input_ins_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_ins_company_name = (TYPEOF(le.Input_ins_company_name))'','',':ins_company_name')
    #END
+    #IF( #TEXT(Input_dyt_account_id)='' )
      '' 
    #ELSE
        IF( le.Input_dyt_account_id = (TYPEOF(le.Input_dyt_account_id))'','',':dyt_account_id')
    #END
+    #IF( #TEXT(Input_dyt_account_name)='' )
      '' 
    #ELSE
        IF( le.Input_dyt_account_name = (TYPEOF(le.Input_dyt_account_name))'','',':dyt_account_name')
    #END
+    #IF( #TEXT(Input_dyt_customer_name)='' )
      '' 
    #ELSE
        IF( le.Input_dyt_customer_name = (TYPEOF(le.Input_dyt_customer_name))'','',':dyt_customer_name')
    #END
+    #IF( #TEXT(Input_mbs_reseller_parent_name)='' )
      '' 
    #ELSE
        IF( le.Input_mbs_reseller_parent_name = (TYPEOF(le.Input_mbs_reseller_parent_name))'','',':mbs_reseller_parent_name')
    #END
+    #IF( #TEXT(Input_cancel_reason)='' )
      '' 
    #ELSE
        IF( le.Input_cancel_reason = (TYPEOF(le.Input_cancel_reason))'','',':cancel_reason')
    #END
+    #IF( #TEXT(Input_internal_flag)='' )
      '' 
    #ELSE
        IF( le.Input_internal_flag = (TYPEOF(le.Input_internal_flag))'','',':internal_flag')
    #END
+    #IF( #TEXT(Input_dummy_subaccount_flag)='' )
      '' 
    #ELSE
        IF( le.Input_dummy_subaccount_flag = (TYPEOF(le.Input_dummy_subaccount_flag))'','',':dummy_subaccount_flag')
    #END
+    #IF( #TEXT(Input_primary_market_gen_1)='' )
      '' 
    #ELSE
        IF( le.Input_primary_market_gen_1 = (TYPEOF(le.Input_primary_market_gen_1))'','',':primary_market_gen_1')
    #END
+    #IF( #TEXT(Input_primary_market_cd)='' )
      '' 
    #ELSE
        IF( le.Input_primary_market_cd = (TYPEOF(le.Input_primary_market_cd))'','',':primary_market_cd')
    #END
+    #IF( #TEXT(Input_primary_market_desc)='' )
      '' 
    #ELSE
        IF( le.Input_primary_market_desc = (TYPEOF(le.Input_primary_market_desc))'','',':primary_market_desc')
    #END
+    #IF( #TEXT(Input_secondary_market_cd)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_market_cd = (TYPEOF(le.Input_secondary_market_cd))'','',':secondary_market_cd')
    #END
+    #IF( #TEXT(Input_secondary_market_desc)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_market_desc = (TYPEOF(le.Input_secondary_market_desc))'','',':secondary_market_desc')
    #END
+    #IF( #TEXT(Input_Sub_market)='' )
      '' 
    #ELSE
        IF( le.Input_Sub_market = (TYPEOF(le.Input_Sub_market))'','',':Sub_market')
    #END
+    #IF( #TEXT(Input_sub_market_gen_1)='' )
      '' 
    #ELSE
        IF( le.Input_sub_market_gen_1 = (TYPEOF(le.Input_sub_market_gen_1))'','',':sub_market_gen_1')
    #END
+    #IF( #TEXT(Input_sub_market_gen_2)='' )
      '' 
    #ELSE
        IF( le.Input_sub_market_gen_2 = (TYPEOF(le.Input_sub_market_gen_2))'','',':sub_market_gen_2')
    #END
+    #IF( #TEXT(Input_segment_lead)='' )
      '' 
    #ELSE
        IF( le.Input_segment_lead = (TYPEOF(le.Input_segment_lead))'','',':segment_lead')
    #END
+    #IF( #TEXT(Input_subaccount_status)='' )
      '' 
    #ELSE
        IF( le.Input_subaccount_status = (TYPEOF(le.Input_subaccount_status))'','',':subaccount_status')
    #END
+    #IF( #TEXT(Input_acc_application_type)='' )
      '' 
    #ELSE
        IF( le.Input_acc_application_type = (TYPEOF(le.Input_acc_application_type))'','',':acc_application_type')
    #END
+    #IF( #TEXT(Input_acc_company_type)='' )
      '' 
    #ELSE
        IF( le.Input_acc_company_type = (TYPEOF(le.Input_acc_company_type))'','',':acc_company_type')
    #END
+    #IF( #TEXT(Input_bussrv_crd_customer)='' )
      '' 
    #ELSE
        IF( le.Input_bussrv_crd_customer = (TYPEOF(le.Input_bussrv_crd_customer))'','',':bussrv_crd_customer')
    #END
+    #IF( #TEXT(Input_integrator)='' )
      '' 
    #ELSE
        IF( le.Input_integrator = (TYPEOF(le.Input_integrator))'','',':integrator')
    #END
+    #IF( #TEXT(Input_migration_type)='' )
      '' 
    #ELSE
        IF( le.Input_migration_type = (TYPEOF(le.Input_migration_type))'','',':migration_type')
    #END
+    #IF( #TEXT(Input_aba_flag)='' )
      '' 
    #ELSE
        IF( le.Input_aba_flag = (TYPEOF(le.Input_aba_flag))'','',':aba_flag')
    #END
+    #IF( #TEXT(Input_acquisition_tracking)='' )
      '' 
    #ELSE
        IF( le.Input_acquisition_tracking = (TYPEOF(le.Input_acquisition_tracking))'','',':acquisition_tracking')
    #END
+    #IF( #TEXT(Input_acquisition_tracking_Gen01)='' )
      '' 
    #ELSE
        IF( le.Input_acquisition_tracking_Gen01 = (TYPEOF(le.Input_acquisition_tracking_Gen01))'','',':acquisition_tracking_Gen01')
    #END
+    #IF( #TEXT(Input_acquisition_tracking_Gen02)='' )
      '' 
    #ELSE
        IF( le.Input_acquisition_tracking_Gen02 = (TYPEOF(le.Input_acquisition_tracking_Gen02))'','',':acquisition_tracking_Gen02')
    #END
+    #IF( #TEXT(Input_acquisition_tracking_Gen03)='' )
      '' 
    #ELSE
        IF( le.Input_acquisition_tracking_Gen03 = (TYPEOF(le.Input_acquisition_tracking_Gen03))'','',':acquisition_tracking_Gen03')
    #END
+    #IF( #TEXT(Input_new_subaccount_year)='' )
      '' 
    #ELSE
        IF( le.Input_new_subaccount_year = (TYPEOF(le.Input_new_subaccount_year))'','',':new_subaccount_year')
    #END
+    #IF( #TEXT(Input_new_subaccount_year_month)='' )
      '' 
    #ELSE
        IF( le.Input_new_subaccount_year_month = (TYPEOF(le.Input_new_subaccount_year_month))'','',':new_subaccount_year_month')
    #END
+    #IF( #TEXT(Input_new_hh_year)='' )
      '' 
    #ELSE
        IF( le.Input_new_hh_year = (TYPEOF(le.Input_new_hh_year))'','',':new_hh_year')
    #END
+    #IF( #TEXT(Input_new_hh_year_month)='' )
      '' 
    #ELSE
        IF( le.Input_new_hh_year_month = (TYPEOF(le.Input_new_hh_year_month))'','',':new_hh_year_month')
    #END
+    #IF( #TEXT(Input_subaccount_attrition_year)='' )
      '' 
    #ELSE
        IF( le.Input_subaccount_attrition_year = (TYPEOF(le.Input_subaccount_attrition_year))'','',':subaccount_attrition_year')
    #END
+    #IF( #TEXT(Input_subaccount_attrition_year_month)='' )
      '' 
    #ELSE
        IF( le.Input_subaccount_attrition_year_month = (TYPEOF(le.Input_subaccount_attrition_year_month))'','',':subaccount_attrition_year_month')
    #END
+    #IF( #TEXT(Input_hh_attrition_year)='' )
      '' 
    #ELSE
        IF( le.Input_hh_attrition_year = (TYPEOF(le.Input_hh_attrition_year))'','',':hh_attrition_year')
    #END
+    #IF( #TEXT(Input_hh_attrition_year_month)='' )
      '' 
    #ELSE
        IF( le.Input_hh_attrition_year_month = (TYPEOF(le.Input_hh_attrition_year_month))'','',':hh_attrition_year_month')
    #END
+    #IF( #TEXT(Input_bussrv_r12m_tier_cd)='' )
      '' 
    #ELSE
        IF( le.Input_bussrv_r12m_tier_cd = (TYPEOF(le.Input_bussrv_r12m_tier_cd))'','',':bussrv_r12m_tier_cd')
    #END
+    #IF( #TEXT(Input_bussrv_r12m_tier_desc)='' )
      '' 
    #ELSE
        IF( le.Input_bussrv_r12m_tier_desc = (TYPEOF(le.Input_bussrv_r12m_tier_desc))'','',':bussrv_r12m_tier_desc')
    #END
+    #IF( #TEXT(Input_bussrv_r12m_tier_gen_1)='' )
      '' 
    #ELSE
        IF( le.Input_bussrv_r12m_tier_gen_1 = (TYPEOF(le.Input_bussrv_r12m_tier_gen_1))'','',':bussrv_r12m_tier_gen_1')
    #END
+    #IF( #TEXT(Input_bussrv_r12m_tier_gen_2)='' )
      '' 
    #ELSE
        IF( le.Input_bussrv_r12m_tier_gen_2 = (TYPEOF(le.Input_bussrv_r12m_tier_gen_2))'','',':bussrv_r12m_tier_gen_2')
    #END
+    #IF( #TEXT(Input_bussrv_py_tier_cd)='' )
      '' 
    #ELSE
        IF( le.Input_bussrv_py_tier_cd = (TYPEOF(le.Input_bussrv_py_tier_cd))'','',':bussrv_py_tier_cd')
    #END
+    #IF( #TEXT(Input_bussrv_py_tier_desc)='' )
      '' 
    #ELSE
        IF( le.Input_bussrv_py_tier_desc = (TYPEOF(le.Input_bussrv_py_tier_desc))'','',':bussrv_py_tier_desc')
    #END
+    #IF( #TEXT(Input_bussrv_py_tier_gen_1)='' )
      '' 
    #ELSE
        IF( le.Input_bussrv_py_tier_gen_1 = (TYPEOF(le.Input_bussrv_py_tier_gen_1))'','',':bussrv_py_tier_gen_1')
    #END
+    #IF( #TEXT(Input_bussrv_py_tier_gen_2)='' )
      '' 
    #ELSE
        IF( le.Input_bussrv_py_tier_gen_2 = (TYPEOF(le.Input_bussrv_py_tier_gen_2))'','',':bussrv_py_tier_gen_2')
    #END
+    #IF( #TEXT(Input_govt_cy_tier)='' )
      '' 
    #ELSE
        IF( le.Input_govt_cy_tier = (TYPEOF(le.Input_govt_cy_tier))'','',':govt_cy_tier')
    #END
+    #IF( #TEXT(Input_cy_vertical_sk)='' )
      '' 
    #ELSE
        IF( le.Input_cy_vertical_sk = (TYPEOF(le.Input_cy_vertical_sk))'','',':cy_vertical_sk')
    #END
+    #IF( #TEXT(Input_py_vertical_sk)='' )
      '' 
    #ELSE
        IF( le.Input_py_vertical_sk = (TYPEOF(le.Input_py_vertical_sk))'','',':py_vertical_sk')
    #END
+    #IF( #TEXT(Input_current_primary_territory_sk)='' )
      '' 
    #ELSE
        IF( le.Input_current_primary_territory_sk = (TYPEOF(le.Input_current_primary_territory_sk))'','',':current_primary_territory_sk')
    #END
+    #IF( #TEXT(Input_current_secondary_territory_sk)='' )
      '' 
    #ELSE
        IF( le.Input_current_secondary_territory_sk = (TYPEOF(le.Input_current_secondary_territory_sk))'','',':current_secondary_territory_sk')
    #END
+    #IF( #TEXT(Input_ins_business_line)='' )
      '' 
    #ELSE
        IF( le.Input_ins_business_line = (TYPEOF(le.Input_ins_business_line))'','',':ins_business_line')
    #END
+    #IF( #TEXT(Input_ins_market_code)='' )
      '' 
    #ELSE
        IF( le.Input_ins_market_code = (TYPEOF(le.Input_ins_market_code))'','',':ins_market_code')
    #END
+    #IF( #TEXT(Input_ins_platform_type)='' )
      '' 
    #ELSE
        IF( le.Input_ins_platform_type = (TYPEOF(le.Input_ins_platform_type))'','',':ins_platform_type')
    #END
+    #IF( #TEXT(Input_mvr_alt1_gen01)='' )
      '' 
    #ELSE
        IF( le.Input_mvr_alt1_gen01 = (TYPEOF(le.Input_mvr_alt1_gen01))'','',':mvr_alt1_gen01')
    #END
+    #IF( #TEXT(Input_mvr_alt1_gen02)='' )
      '' 
    #ELSE
        IF( le.Input_mvr_alt1_gen02 = (TYPEOF(le.Input_mvr_alt1_gen02))'','',':mvr_alt1_gen02')
    #END
+    #IF( #TEXT(Input_mvr_alt1_gen03)='' )
      '' 
    #ELSE
        IF( le.Input_mvr_alt1_gen03 = (TYPEOF(le.Input_mvr_alt1_gen03))'','',':mvr_alt1_gen03')
    #END
+    #IF( #TEXT(Input_mvr_alt1_gen04)='' )
      '' 
    #ELSE
        IF( le.Input_mvr_alt1_gen04 = (TYPEOF(le.Input_mvr_alt1_gen04))'','',':mvr_alt1_gen04')
    #END
+    #IF( #TEXT(Input_mvr_rate_type)='' )
      '' 
    #ELSE
        IF( le.Input_mvr_rate_type = (TYPEOF(le.Input_mvr_rate_type))'','',':mvr_rate_type')
    #END
+    #IF( #TEXT(Input_legal_entity_id)='' )
      '' 
    #ELSE
        IF( le.Input_legal_entity_id = (TYPEOF(le.Input_legal_entity_id))'','',':legal_entity_id')
    #END
+    #IF( #TEXT(Input_legal_entity_code)='' )
      '' 
    #ELSE
        IF( le.Input_legal_entity_code = (TYPEOF(le.Input_legal_entity_code))'','',':legal_entity_code')
    #END
+    #IF( #TEXT(Input_legal_entity_name)='' )
      '' 
    #ELSE
        IF( le.Input_legal_entity_name = (TYPEOF(le.Input_legal_entity_name))'','',':legal_entity_name')
    #END
+    #IF( #TEXT(Input_currency_id)='' )
      '' 
    #ELSE
        IF( le.Input_currency_id = (TYPEOF(le.Input_currency_id))'','',':currency_id')
    #END
+    #IF( #TEXT(Input_currency_code)='' )
      '' 
    #ELSE
        IF( le.Input_currency_code = (TYPEOF(le.Input_currency_code))'','',':currency_code')
    #END
+    #IF( #TEXT(Input_lang_code)='' )
      '' 
    #ELSE
        IF( le.Input_lang_code = (TYPEOF(le.Input_lang_code))'','',':lang_code')
    #END
+    #IF( #TEXT(Input_lang_name)='' )
      '' 
    #ELSE
        IF( le.Input_lang_name = (TYPEOF(le.Input_lang_name))'','',':lang_name')
    #END
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
+    #IF( #TEXT(Input_country_gen3)='' )
      '' 
    #ELSE
        IF( le.Input_country_gen3 = (TYPEOF(le.Input_country_gen3))'','',':country_gen3')
    #END
+    #IF( #TEXT(Input_country_gen2)='' )
      '' 
    #ELSE
        IF( le.Input_country_gen2 = (TYPEOF(le.Input_country_gen2))'','',':country_gen2')
    #END
+    #IF( #TEXT(Input_country_gen1)='' )
      '' 
    #ELSE
        IF( le.Input_country_gen1 = (TYPEOF(le.Input_country_gen1))'','',':country_gen1')
    #END
+    #IF( #TEXT(Input_country_tier)='' )
      '' 
    #ELSE
        IF( le.Input_country_tier = (TYPEOF(le.Input_country_tier))'','',':country_tier')
    #END
+    #IF( #TEXT(Input_PMK_Customer_Product)='' )
      '' 
    #ELSE
        IF( le.Input_PMK_Customer_Product = (TYPEOF(le.Input_PMK_Customer_Product))'','',':PMK_Customer_Product')
    #END
+    #IF( #TEXT(Input_use_case)='' )
      '' 
    #ELSE
        IF( le.Input_use_case = (TYPEOF(le.Input_use_case))'','',':use_case')
    #END
+    #IF( #TEXT(Input_market_segment)='' )
      '' 
    #ELSE
        IF( le.Input_market_segment = (TYPEOF(le.Input_market_segment))'','',':market_segment')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
