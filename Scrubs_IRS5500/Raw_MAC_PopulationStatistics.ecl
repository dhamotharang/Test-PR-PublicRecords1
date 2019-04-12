 
EXPORT Raw_MAC_PopulationStatistics(infile,Ref='',Input_ack_id = '',Input_form_plan_year_begin_date = '',Input_form_tax_prd = '',Input_type_plan_entity_cd = '',Input_type_dfe_plan_entity_cd = '',Input_initial_filing_ind = '',Input_amended_ind = '',Input_final_filing_ind = '',Input_short_plan_yr_ind = '',Input_collective_bargain_ind = '',Input_f5558_application_filed_ind = '',Input_ext_automatic_ind = '',Input_dfvc_program_ind = '',Input_ext_special_ind = '',Input_ext_special_text = '',Input_plan_name = '',Input_spons_dfe_pn = '',Input_plan_eff_date = '',Input_sponsor_dfe_name = '',Input_spons_dfe_dba_name = '',Input_spons_dfe_care_of_name = '',Input_spons_dfe_mail_us_address1 = '',Input_spons_dfe_mail_us_address2 = '',Input_spons_dfe_mail_us_city = '',Input_spons_dfe_mail_us_state = '',Input_spons_dfe_mail_us_zip = '',Input_spons_dfe_mail_foreign_addr1 = '',Input_spons_dfe_mail_foreign_addr2 = '',Input_spons_dfe_mail_foreign_city = '',Input_spons_dfe_mail_forgn_prov_st = '',Input_spons_dfe_mail_foreign_cntry = '',Input_spons_dfe_mail_forgn_postal_cd = '',Input_spons_dfe_loc_us_address1 = '',Input_spons_dfe_loc_us_address2 = '',Input_spons_dfe_loc_us_city = '',Input_spons_dfe_loc_us_state = '',Input_spons_dfe_loc_us_zip = '',Input_spons_dfe_loc_foreign_address1 = '',Input_spons_dfe_loc_foreign_address2 = '',Input_spons_dfe_loc_foreign_city = '',Input_spons_dfe_loc_forgn_prov_st = '',Input_spons_dfe_loc_foreign_cntry = '',Input_spons_dfe_loc_forgn_postal_cd = '',Input_spons_dfe_ein = '',Input_spons_dfe_phone_num = '',Input_business_code = '',Input_admin_name = '',Input_admin_care_of_name = '',Input_admin_us_address1 = '',Input_admin_us_address2 = '',Input_admin_us_city = '',Input_admin_us_state = '',Input_admin_us_zip = '',Input_admin_foreign_address1 = '',Input_admin_foreign_address2 = '',Input_admin_foreign_city = '',Input_admin_foreign_prov_state = '',Input_admin_foreign_cntry = '',Input_admin_foreign_postal_cd = '',Input_admin_ein = '',Input_admin_phone_num = '',Input_last_rpt_spons_name = '',Input_last_rpt_spons_ein = '',Input_last_rpt_plan_num = '',Input_admin_signed_date = '',Input_admin_signed_name = '',Input_spons_signed_date = '',Input_spons_signed_name = '',Input_dfe_signed_date = '',Input_dfe_signed_name = '',Input_tot_partcp_boy_cnt = '',Input_tot_active_partcp_cnt = '',Input_rtd_sep_partcp_rcvg_cnt = '',Input_rtd_sep_partcp_fut_cnt = '',Input_subtl_act_rtd_sep_cnt = '',Input_benef_rcvg_bnft_cnt = '',Input_tot_act_rtd_sep_benef_cnt = '',Input_partcp_account_bal_cnt = '',Input_sep_partcp_partl_vstd_cnt = '',Input_contrib_emplrs_cnt = '',Input_type_pension_bnft_code = '',Input_type_welfare_bnft_code = '',Input_funding_insurance_ind = '',Input_funding_sec412_ind = '',Input_funding_trust_ind = '',Input_funding_gen_asset_ind = '',Input_benefit_insurance_ind = '',Input_benefit_sec412_ind = '',Input_benefit_trust_ind = '',Input_benefit_gen_asset_ind = '',Input_sch_r_attached_ind = '',Input_sch_mb_attached_ind = '',Input_sch_sb_attached_ind = '',Input_sch_h_attached_ind = '',Input_sch_i_attached_ind = '',Input_sch_a_attached_ind = '',Input_num_sch_a_attached_cnt = '',Input_sch_c_attached_ind = '',Input_sch_d_attached_ind = '',Input_sch_g_attached_ind = '',Input_filing_status = '',Input_date_received = '',Input_valid_admin_signature = '',Input_valid_dfe_signature = '',Input_valid_sponsor_signature = '',Input_admin_phone_num_foreign = '',Input_spons_dfe_phone_num_foreign = '',Input_admin_name_same_spon_ind = '',Input_admin_address_same_spon_ind = '',Input_preparer_name = '',Input_preparer_firm_name = '',Input_preparer_us_address1 = '',Input_preparer_us_address2 = '',Input_preparer_us_city = '',Input_preparer_us_state = '',Input_preparer_us_zip = '',Input_preparer_foreign_address1 = '',Input_preparer_foreign_address2 = '',Input_preparer_foreign_city = '',Input_preparer_foreign_prov_state = '',Input_preparer_foreign_cntry = '',Input_preparer_foreign_postal_cd = '',Input_preparer_phone_num = '',Input_preparer_phone_num_foreign = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_IRS5500;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ack_id)='' )
      '' 
    #ELSE
        IF( le.Input_ack_id = (TYPEOF(le.Input_ack_id))'','',':ack_id')
    #END
 
+    #IF( #TEXT(Input_form_plan_year_begin_date)='' )
      '' 
    #ELSE
        IF( le.Input_form_plan_year_begin_date = (TYPEOF(le.Input_form_plan_year_begin_date))'','',':form_plan_year_begin_date')
    #END
 
+    #IF( #TEXT(Input_form_tax_prd)='' )
      '' 
    #ELSE
        IF( le.Input_form_tax_prd = (TYPEOF(le.Input_form_tax_prd))'','',':form_tax_prd')
    #END
 
+    #IF( #TEXT(Input_type_plan_entity_cd)='' )
      '' 
    #ELSE
        IF( le.Input_type_plan_entity_cd = (TYPEOF(le.Input_type_plan_entity_cd))'','',':type_plan_entity_cd')
    #END
 
+    #IF( #TEXT(Input_type_dfe_plan_entity_cd)='' )
      '' 
    #ELSE
        IF( le.Input_type_dfe_plan_entity_cd = (TYPEOF(le.Input_type_dfe_plan_entity_cd))'','',':type_dfe_plan_entity_cd')
    #END
 
+    #IF( #TEXT(Input_initial_filing_ind)='' )
      '' 
    #ELSE
        IF( le.Input_initial_filing_ind = (TYPEOF(le.Input_initial_filing_ind))'','',':initial_filing_ind')
    #END
 
+    #IF( #TEXT(Input_amended_ind)='' )
      '' 
    #ELSE
        IF( le.Input_amended_ind = (TYPEOF(le.Input_amended_ind))'','',':amended_ind')
    #END
 
+    #IF( #TEXT(Input_final_filing_ind)='' )
      '' 
    #ELSE
        IF( le.Input_final_filing_ind = (TYPEOF(le.Input_final_filing_ind))'','',':final_filing_ind')
    #END
 
+    #IF( #TEXT(Input_short_plan_yr_ind)='' )
      '' 
    #ELSE
        IF( le.Input_short_plan_yr_ind = (TYPEOF(le.Input_short_plan_yr_ind))'','',':short_plan_yr_ind')
    #END
 
+    #IF( #TEXT(Input_collective_bargain_ind)='' )
      '' 
    #ELSE
        IF( le.Input_collective_bargain_ind = (TYPEOF(le.Input_collective_bargain_ind))'','',':collective_bargain_ind')
    #END
 
+    #IF( #TEXT(Input_f5558_application_filed_ind)='' )
      '' 
    #ELSE
        IF( le.Input_f5558_application_filed_ind = (TYPEOF(le.Input_f5558_application_filed_ind))'','',':f5558_application_filed_ind')
    #END
 
+    #IF( #TEXT(Input_ext_automatic_ind)='' )
      '' 
    #ELSE
        IF( le.Input_ext_automatic_ind = (TYPEOF(le.Input_ext_automatic_ind))'','',':ext_automatic_ind')
    #END
 
+    #IF( #TEXT(Input_dfvc_program_ind)='' )
      '' 
    #ELSE
        IF( le.Input_dfvc_program_ind = (TYPEOF(le.Input_dfvc_program_ind))'','',':dfvc_program_ind')
    #END
 
+    #IF( #TEXT(Input_ext_special_ind)='' )
      '' 
    #ELSE
        IF( le.Input_ext_special_ind = (TYPEOF(le.Input_ext_special_ind))'','',':ext_special_ind')
    #END
 
+    #IF( #TEXT(Input_ext_special_text)='' )
      '' 
    #ELSE
        IF( le.Input_ext_special_text = (TYPEOF(le.Input_ext_special_text))'','',':ext_special_text')
    #END
 
+    #IF( #TEXT(Input_plan_name)='' )
      '' 
    #ELSE
        IF( le.Input_plan_name = (TYPEOF(le.Input_plan_name))'','',':plan_name')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_pn)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_pn = (TYPEOF(le.Input_spons_dfe_pn))'','',':spons_dfe_pn')
    #END
 
+    #IF( #TEXT(Input_plan_eff_date)='' )
      '' 
    #ELSE
        IF( le.Input_plan_eff_date = (TYPEOF(le.Input_plan_eff_date))'','',':plan_eff_date')
    #END
 
+    #IF( #TEXT(Input_sponsor_dfe_name)='' )
      '' 
    #ELSE
        IF( le.Input_sponsor_dfe_name = (TYPEOF(le.Input_sponsor_dfe_name))'','',':sponsor_dfe_name')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_dba_name)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_dba_name = (TYPEOF(le.Input_spons_dfe_dba_name))'','',':spons_dfe_dba_name')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_care_of_name)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_care_of_name = (TYPEOF(le.Input_spons_dfe_care_of_name))'','',':spons_dfe_care_of_name')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_us_address1)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_us_address1 = (TYPEOF(le.Input_spons_dfe_mail_us_address1))'','',':spons_dfe_mail_us_address1')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_us_address2)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_us_address2 = (TYPEOF(le.Input_spons_dfe_mail_us_address2))'','',':spons_dfe_mail_us_address2')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_us_city)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_us_city = (TYPEOF(le.Input_spons_dfe_mail_us_city))'','',':spons_dfe_mail_us_city')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_us_state)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_us_state = (TYPEOF(le.Input_spons_dfe_mail_us_state))'','',':spons_dfe_mail_us_state')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_us_zip)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_us_zip = (TYPEOF(le.Input_spons_dfe_mail_us_zip))'','',':spons_dfe_mail_us_zip')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_foreign_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_foreign_addr1 = (TYPEOF(le.Input_spons_dfe_mail_foreign_addr1))'','',':spons_dfe_mail_foreign_addr1')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_foreign_addr2)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_foreign_addr2 = (TYPEOF(le.Input_spons_dfe_mail_foreign_addr2))'','',':spons_dfe_mail_foreign_addr2')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_foreign_city)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_foreign_city = (TYPEOF(le.Input_spons_dfe_mail_foreign_city))'','',':spons_dfe_mail_foreign_city')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_forgn_prov_st)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_forgn_prov_st = (TYPEOF(le.Input_spons_dfe_mail_forgn_prov_st))'','',':spons_dfe_mail_forgn_prov_st')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_foreign_cntry)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_foreign_cntry = (TYPEOF(le.Input_spons_dfe_mail_foreign_cntry))'','',':spons_dfe_mail_foreign_cntry')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_mail_forgn_postal_cd)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_mail_forgn_postal_cd = (TYPEOF(le.Input_spons_dfe_mail_forgn_postal_cd))'','',':spons_dfe_mail_forgn_postal_cd')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_us_address1)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_us_address1 = (TYPEOF(le.Input_spons_dfe_loc_us_address1))'','',':spons_dfe_loc_us_address1')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_us_address2)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_us_address2 = (TYPEOF(le.Input_spons_dfe_loc_us_address2))'','',':spons_dfe_loc_us_address2')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_us_city)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_us_city = (TYPEOF(le.Input_spons_dfe_loc_us_city))'','',':spons_dfe_loc_us_city')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_us_state)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_us_state = (TYPEOF(le.Input_spons_dfe_loc_us_state))'','',':spons_dfe_loc_us_state')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_us_zip)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_us_zip = (TYPEOF(le.Input_spons_dfe_loc_us_zip))'','',':spons_dfe_loc_us_zip')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_foreign_address1)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_foreign_address1 = (TYPEOF(le.Input_spons_dfe_loc_foreign_address1))'','',':spons_dfe_loc_foreign_address1')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_foreign_address2)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_foreign_address2 = (TYPEOF(le.Input_spons_dfe_loc_foreign_address2))'','',':spons_dfe_loc_foreign_address2')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_foreign_city)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_foreign_city = (TYPEOF(le.Input_spons_dfe_loc_foreign_city))'','',':spons_dfe_loc_foreign_city')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_forgn_prov_st)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_forgn_prov_st = (TYPEOF(le.Input_spons_dfe_loc_forgn_prov_st))'','',':spons_dfe_loc_forgn_prov_st')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_foreign_cntry)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_foreign_cntry = (TYPEOF(le.Input_spons_dfe_loc_foreign_cntry))'','',':spons_dfe_loc_foreign_cntry')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_loc_forgn_postal_cd)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_loc_forgn_postal_cd = (TYPEOF(le.Input_spons_dfe_loc_forgn_postal_cd))'','',':spons_dfe_loc_forgn_postal_cd')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_ein)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_ein = (TYPEOF(le.Input_spons_dfe_ein))'','',':spons_dfe_ein')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_phone_num)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_phone_num = (TYPEOF(le.Input_spons_dfe_phone_num))'','',':spons_dfe_phone_num')
    #END
 
+    #IF( #TEXT(Input_business_code)='' )
      '' 
    #ELSE
        IF( le.Input_business_code = (TYPEOF(le.Input_business_code))'','',':business_code')
    #END
 
+    #IF( #TEXT(Input_admin_name)='' )
      '' 
    #ELSE
        IF( le.Input_admin_name = (TYPEOF(le.Input_admin_name))'','',':admin_name')
    #END
 
+    #IF( #TEXT(Input_admin_care_of_name)='' )
      '' 
    #ELSE
        IF( le.Input_admin_care_of_name = (TYPEOF(le.Input_admin_care_of_name))'','',':admin_care_of_name')
    #END
 
+    #IF( #TEXT(Input_admin_us_address1)='' )
      '' 
    #ELSE
        IF( le.Input_admin_us_address1 = (TYPEOF(le.Input_admin_us_address1))'','',':admin_us_address1')
    #END
 
+    #IF( #TEXT(Input_admin_us_address2)='' )
      '' 
    #ELSE
        IF( le.Input_admin_us_address2 = (TYPEOF(le.Input_admin_us_address2))'','',':admin_us_address2')
    #END
 
+    #IF( #TEXT(Input_admin_us_city)='' )
      '' 
    #ELSE
        IF( le.Input_admin_us_city = (TYPEOF(le.Input_admin_us_city))'','',':admin_us_city')
    #END
 
+    #IF( #TEXT(Input_admin_us_state)='' )
      '' 
    #ELSE
        IF( le.Input_admin_us_state = (TYPEOF(le.Input_admin_us_state))'','',':admin_us_state')
    #END
 
+    #IF( #TEXT(Input_admin_us_zip)='' )
      '' 
    #ELSE
        IF( le.Input_admin_us_zip = (TYPEOF(le.Input_admin_us_zip))'','',':admin_us_zip')
    #END
 
+    #IF( #TEXT(Input_admin_foreign_address1)='' )
      '' 
    #ELSE
        IF( le.Input_admin_foreign_address1 = (TYPEOF(le.Input_admin_foreign_address1))'','',':admin_foreign_address1')
    #END
 
+    #IF( #TEXT(Input_admin_foreign_address2)='' )
      '' 
    #ELSE
        IF( le.Input_admin_foreign_address2 = (TYPEOF(le.Input_admin_foreign_address2))'','',':admin_foreign_address2')
    #END
 
+    #IF( #TEXT(Input_admin_foreign_city)='' )
      '' 
    #ELSE
        IF( le.Input_admin_foreign_city = (TYPEOF(le.Input_admin_foreign_city))'','',':admin_foreign_city')
    #END
 
+    #IF( #TEXT(Input_admin_foreign_prov_state)='' )
      '' 
    #ELSE
        IF( le.Input_admin_foreign_prov_state = (TYPEOF(le.Input_admin_foreign_prov_state))'','',':admin_foreign_prov_state')
    #END
 
+    #IF( #TEXT(Input_admin_foreign_cntry)='' )
      '' 
    #ELSE
        IF( le.Input_admin_foreign_cntry = (TYPEOF(le.Input_admin_foreign_cntry))'','',':admin_foreign_cntry')
    #END
 
+    #IF( #TEXT(Input_admin_foreign_postal_cd)='' )
      '' 
    #ELSE
        IF( le.Input_admin_foreign_postal_cd = (TYPEOF(le.Input_admin_foreign_postal_cd))'','',':admin_foreign_postal_cd')
    #END
 
+    #IF( #TEXT(Input_admin_ein)='' )
      '' 
    #ELSE
        IF( le.Input_admin_ein = (TYPEOF(le.Input_admin_ein))'','',':admin_ein')
    #END
 
+    #IF( #TEXT(Input_admin_phone_num)='' )
      '' 
    #ELSE
        IF( le.Input_admin_phone_num = (TYPEOF(le.Input_admin_phone_num))'','',':admin_phone_num')
    #END
 
+    #IF( #TEXT(Input_last_rpt_spons_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_rpt_spons_name = (TYPEOF(le.Input_last_rpt_spons_name))'','',':last_rpt_spons_name')
    #END
 
+    #IF( #TEXT(Input_last_rpt_spons_ein)='' )
      '' 
    #ELSE
        IF( le.Input_last_rpt_spons_ein = (TYPEOF(le.Input_last_rpt_spons_ein))'','',':last_rpt_spons_ein')
    #END
 
+    #IF( #TEXT(Input_last_rpt_plan_num)='' )
      '' 
    #ELSE
        IF( le.Input_last_rpt_plan_num = (TYPEOF(le.Input_last_rpt_plan_num))'','',':last_rpt_plan_num')
    #END
 
+    #IF( #TEXT(Input_admin_signed_date)='' )
      '' 
    #ELSE
        IF( le.Input_admin_signed_date = (TYPEOF(le.Input_admin_signed_date))'','',':admin_signed_date')
    #END
 
+    #IF( #TEXT(Input_admin_signed_name)='' )
      '' 
    #ELSE
        IF( le.Input_admin_signed_name = (TYPEOF(le.Input_admin_signed_name))'','',':admin_signed_name')
    #END
 
+    #IF( #TEXT(Input_spons_signed_date)='' )
      '' 
    #ELSE
        IF( le.Input_spons_signed_date = (TYPEOF(le.Input_spons_signed_date))'','',':spons_signed_date')
    #END
 
+    #IF( #TEXT(Input_spons_signed_name)='' )
      '' 
    #ELSE
        IF( le.Input_spons_signed_name = (TYPEOF(le.Input_spons_signed_name))'','',':spons_signed_name')
    #END
 
+    #IF( #TEXT(Input_dfe_signed_date)='' )
      '' 
    #ELSE
        IF( le.Input_dfe_signed_date = (TYPEOF(le.Input_dfe_signed_date))'','',':dfe_signed_date')
    #END
 
+    #IF( #TEXT(Input_dfe_signed_name)='' )
      '' 
    #ELSE
        IF( le.Input_dfe_signed_name = (TYPEOF(le.Input_dfe_signed_name))'','',':dfe_signed_name')
    #END
 
+    #IF( #TEXT(Input_tot_partcp_boy_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_tot_partcp_boy_cnt = (TYPEOF(le.Input_tot_partcp_boy_cnt))'','',':tot_partcp_boy_cnt')
    #END
 
+    #IF( #TEXT(Input_tot_active_partcp_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_tot_active_partcp_cnt = (TYPEOF(le.Input_tot_active_partcp_cnt))'','',':tot_active_partcp_cnt')
    #END
 
+    #IF( #TEXT(Input_rtd_sep_partcp_rcvg_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_rtd_sep_partcp_rcvg_cnt = (TYPEOF(le.Input_rtd_sep_partcp_rcvg_cnt))'','',':rtd_sep_partcp_rcvg_cnt')
    #END
 
+    #IF( #TEXT(Input_rtd_sep_partcp_fut_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_rtd_sep_partcp_fut_cnt = (TYPEOF(le.Input_rtd_sep_partcp_fut_cnt))'','',':rtd_sep_partcp_fut_cnt')
    #END
 
+    #IF( #TEXT(Input_subtl_act_rtd_sep_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_subtl_act_rtd_sep_cnt = (TYPEOF(le.Input_subtl_act_rtd_sep_cnt))'','',':subtl_act_rtd_sep_cnt')
    #END
 
+    #IF( #TEXT(Input_benef_rcvg_bnft_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_benef_rcvg_bnft_cnt = (TYPEOF(le.Input_benef_rcvg_bnft_cnt))'','',':benef_rcvg_bnft_cnt')
    #END
 
+    #IF( #TEXT(Input_tot_act_rtd_sep_benef_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_tot_act_rtd_sep_benef_cnt = (TYPEOF(le.Input_tot_act_rtd_sep_benef_cnt))'','',':tot_act_rtd_sep_benef_cnt')
    #END
 
+    #IF( #TEXT(Input_partcp_account_bal_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_partcp_account_bal_cnt = (TYPEOF(le.Input_partcp_account_bal_cnt))'','',':partcp_account_bal_cnt')
    #END
 
+    #IF( #TEXT(Input_sep_partcp_partl_vstd_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_sep_partcp_partl_vstd_cnt = (TYPEOF(le.Input_sep_partcp_partl_vstd_cnt))'','',':sep_partcp_partl_vstd_cnt')
    #END
 
+    #IF( #TEXT(Input_contrib_emplrs_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_contrib_emplrs_cnt = (TYPEOF(le.Input_contrib_emplrs_cnt))'','',':contrib_emplrs_cnt')
    #END
 
+    #IF( #TEXT(Input_type_pension_bnft_code)='' )
      '' 
    #ELSE
        IF( le.Input_type_pension_bnft_code = (TYPEOF(le.Input_type_pension_bnft_code))'','',':type_pension_bnft_code')
    #END
 
+    #IF( #TEXT(Input_type_welfare_bnft_code)='' )
      '' 
    #ELSE
        IF( le.Input_type_welfare_bnft_code = (TYPEOF(le.Input_type_welfare_bnft_code))'','',':type_welfare_bnft_code')
    #END
 
+    #IF( #TEXT(Input_funding_insurance_ind)='' )
      '' 
    #ELSE
        IF( le.Input_funding_insurance_ind = (TYPEOF(le.Input_funding_insurance_ind))'','',':funding_insurance_ind')
    #END
 
+    #IF( #TEXT(Input_funding_sec412_ind)='' )
      '' 
    #ELSE
        IF( le.Input_funding_sec412_ind = (TYPEOF(le.Input_funding_sec412_ind))'','',':funding_sec412_ind')
    #END
 
+    #IF( #TEXT(Input_funding_trust_ind)='' )
      '' 
    #ELSE
        IF( le.Input_funding_trust_ind = (TYPEOF(le.Input_funding_trust_ind))'','',':funding_trust_ind')
    #END
 
+    #IF( #TEXT(Input_funding_gen_asset_ind)='' )
      '' 
    #ELSE
        IF( le.Input_funding_gen_asset_ind = (TYPEOF(le.Input_funding_gen_asset_ind))'','',':funding_gen_asset_ind')
    #END
 
+    #IF( #TEXT(Input_benefit_insurance_ind)='' )
      '' 
    #ELSE
        IF( le.Input_benefit_insurance_ind = (TYPEOF(le.Input_benefit_insurance_ind))'','',':benefit_insurance_ind')
    #END
 
+    #IF( #TEXT(Input_benefit_sec412_ind)='' )
      '' 
    #ELSE
        IF( le.Input_benefit_sec412_ind = (TYPEOF(le.Input_benefit_sec412_ind))'','',':benefit_sec412_ind')
    #END
 
+    #IF( #TEXT(Input_benefit_trust_ind)='' )
      '' 
    #ELSE
        IF( le.Input_benefit_trust_ind = (TYPEOF(le.Input_benefit_trust_ind))'','',':benefit_trust_ind')
    #END
 
+    #IF( #TEXT(Input_benefit_gen_asset_ind)='' )
      '' 
    #ELSE
        IF( le.Input_benefit_gen_asset_ind = (TYPEOF(le.Input_benefit_gen_asset_ind))'','',':benefit_gen_asset_ind')
    #END
 
+    #IF( #TEXT(Input_sch_r_attached_ind)='' )
      '' 
    #ELSE
        IF( le.Input_sch_r_attached_ind = (TYPEOF(le.Input_sch_r_attached_ind))'','',':sch_r_attached_ind')
    #END
 
+    #IF( #TEXT(Input_sch_mb_attached_ind)='' )
      '' 
    #ELSE
        IF( le.Input_sch_mb_attached_ind = (TYPEOF(le.Input_sch_mb_attached_ind))'','',':sch_mb_attached_ind')
    #END
 
+    #IF( #TEXT(Input_sch_sb_attached_ind)='' )
      '' 
    #ELSE
        IF( le.Input_sch_sb_attached_ind = (TYPEOF(le.Input_sch_sb_attached_ind))'','',':sch_sb_attached_ind')
    #END
 
+    #IF( #TEXT(Input_sch_h_attached_ind)='' )
      '' 
    #ELSE
        IF( le.Input_sch_h_attached_ind = (TYPEOF(le.Input_sch_h_attached_ind))'','',':sch_h_attached_ind')
    #END
 
+    #IF( #TEXT(Input_sch_i_attached_ind)='' )
      '' 
    #ELSE
        IF( le.Input_sch_i_attached_ind = (TYPEOF(le.Input_sch_i_attached_ind))'','',':sch_i_attached_ind')
    #END
 
+    #IF( #TEXT(Input_sch_a_attached_ind)='' )
      '' 
    #ELSE
        IF( le.Input_sch_a_attached_ind = (TYPEOF(le.Input_sch_a_attached_ind))'','',':sch_a_attached_ind')
    #END
 
+    #IF( #TEXT(Input_num_sch_a_attached_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_num_sch_a_attached_cnt = (TYPEOF(le.Input_num_sch_a_attached_cnt))'','',':num_sch_a_attached_cnt')
    #END
 
+    #IF( #TEXT(Input_sch_c_attached_ind)='' )
      '' 
    #ELSE
        IF( le.Input_sch_c_attached_ind = (TYPEOF(le.Input_sch_c_attached_ind))'','',':sch_c_attached_ind')
    #END
 
+    #IF( #TEXT(Input_sch_d_attached_ind)='' )
      '' 
    #ELSE
        IF( le.Input_sch_d_attached_ind = (TYPEOF(le.Input_sch_d_attached_ind))'','',':sch_d_attached_ind')
    #END
 
+    #IF( #TEXT(Input_sch_g_attached_ind)='' )
      '' 
    #ELSE
        IF( le.Input_sch_g_attached_ind = (TYPEOF(le.Input_sch_g_attached_ind))'','',':sch_g_attached_ind')
    #END
 
+    #IF( #TEXT(Input_filing_status)='' )
      '' 
    #ELSE
        IF( le.Input_filing_status = (TYPEOF(le.Input_filing_status))'','',':filing_status')
    #END
 
+    #IF( #TEXT(Input_date_received)='' )
      '' 
    #ELSE
        IF( le.Input_date_received = (TYPEOF(le.Input_date_received))'','',':date_received')
    #END
 
+    #IF( #TEXT(Input_valid_admin_signature)='' )
      '' 
    #ELSE
        IF( le.Input_valid_admin_signature = (TYPEOF(le.Input_valid_admin_signature))'','',':valid_admin_signature')
    #END
 
+    #IF( #TEXT(Input_valid_dfe_signature)='' )
      '' 
    #ELSE
        IF( le.Input_valid_dfe_signature = (TYPEOF(le.Input_valid_dfe_signature))'','',':valid_dfe_signature')
    #END
 
+    #IF( #TEXT(Input_valid_sponsor_signature)='' )
      '' 
    #ELSE
        IF( le.Input_valid_sponsor_signature = (TYPEOF(le.Input_valid_sponsor_signature))'','',':valid_sponsor_signature')
    #END
 
+    #IF( #TEXT(Input_admin_phone_num_foreign)='' )
      '' 
    #ELSE
        IF( le.Input_admin_phone_num_foreign = (TYPEOF(le.Input_admin_phone_num_foreign))'','',':admin_phone_num_foreign')
    #END
 
+    #IF( #TEXT(Input_spons_dfe_phone_num_foreign)='' )
      '' 
    #ELSE
        IF( le.Input_spons_dfe_phone_num_foreign = (TYPEOF(le.Input_spons_dfe_phone_num_foreign))'','',':spons_dfe_phone_num_foreign')
    #END
 
+    #IF( #TEXT(Input_admin_name_same_spon_ind)='' )
      '' 
    #ELSE
        IF( le.Input_admin_name_same_spon_ind = (TYPEOF(le.Input_admin_name_same_spon_ind))'','',':admin_name_same_spon_ind')
    #END
 
+    #IF( #TEXT(Input_admin_address_same_spon_ind)='' )
      '' 
    #ELSE
        IF( le.Input_admin_address_same_spon_ind = (TYPEOF(le.Input_admin_address_same_spon_ind))'','',':admin_address_same_spon_ind')
    #END
 
+    #IF( #TEXT(Input_preparer_name)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_name = (TYPEOF(le.Input_preparer_name))'','',':preparer_name')
    #END
 
+    #IF( #TEXT(Input_preparer_firm_name)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_firm_name = (TYPEOF(le.Input_preparer_firm_name))'','',':preparer_firm_name')
    #END
 
+    #IF( #TEXT(Input_preparer_us_address1)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_us_address1 = (TYPEOF(le.Input_preparer_us_address1))'','',':preparer_us_address1')
    #END
 
+    #IF( #TEXT(Input_preparer_us_address2)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_us_address2 = (TYPEOF(le.Input_preparer_us_address2))'','',':preparer_us_address2')
    #END
 
+    #IF( #TEXT(Input_preparer_us_city)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_us_city = (TYPEOF(le.Input_preparer_us_city))'','',':preparer_us_city')
    #END
 
+    #IF( #TEXT(Input_preparer_us_state)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_us_state = (TYPEOF(le.Input_preparer_us_state))'','',':preparer_us_state')
    #END
 
+    #IF( #TEXT(Input_preparer_us_zip)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_us_zip = (TYPEOF(le.Input_preparer_us_zip))'','',':preparer_us_zip')
    #END
 
+    #IF( #TEXT(Input_preparer_foreign_address1)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_foreign_address1 = (TYPEOF(le.Input_preparer_foreign_address1))'','',':preparer_foreign_address1')
    #END
 
+    #IF( #TEXT(Input_preparer_foreign_address2)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_foreign_address2 = (TYPEOF(le.Input_preparer_foreign_address2))'','',':preparer_foreign_address2')
    #END
 
+    #IF( #TEXT(Input_preparer_foreign_city)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_foreign_city = (TYPEOF(le.Input_preparer_foreign_city))'','',':preparer_foreign_city')
    #END
 
+    #IF( #TEXT(Input_preparer_foreign_prov_state)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_foreign_prov_state = (TYPEOF(le.Input_preparer_foreign_prov_state))'','',':preparer_foreign_prov_state')
    #END
 
+    #IF( #TEXT(Input_preparer_foreign_cntry)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_foreign_cntry = (TYPEOF(le.Input_preparer_foreign_cntry))'','',':preparer_foreign_cntry')
    #END
 
+    #IF( #TEXT(Input_preparer_foreign_postal_cd)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_foreign_postal_cd = (TYPEOF(le.Input_preparer_foreign_postal_cd))'','',':preparer_foreign_postal_cd')
    #END
 
+    #IF( #TEXT(Input_preparer_phone_num)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_phone_num = (TYPEOF(le.Input_preparer_phone_num))'','',':preparer_phone_num')
    #END
 
+    #IF( #TEXT(Input_preparer_phone_num_foreign)='' )
      '' 
    #ELSE
        IF( le.Input_preparer_phone_num_foreign = (TYPEOF(le.Input_preparer_phone_num_foreign))'','',':preparer_phone_num_foreign')
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
