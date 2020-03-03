 
EXPORT Moxie_Court_Offenses_Dev_MAC_PopulationStatistics(infile,Ref='',vendor='',Input_process_date = '',Input_offender_key = '',Input_vendor = '',Input_state_origin = '',Input_source_file = '',Input_data_type = '',Input_off_comp = '',Input_off_delete_flag = '',Input_off_date = '',Input_arr_date = '',Input_num_of_counts = '',Input_le_agency_cd = '',Input_le_agency_desc = '',Input_le_agency_case_number = '',Input_traffic_ticket_number = '',Input_traffic_dl_no = '',Input_traffic_dl_st = '',Input_arr_off_code = '',Input_arr_off_desc_1 = '',Input_arr_off_desc_2 = '',Input_arr_off_type_cd = '',Input_arr_off_type_desc = '',Input_arr_off_lev = '',Input_arr_statute = '',Input_arr_statute_desc = '',Input_arr_disp_date = '',Input_arr_disp_code = '',Input_arr_disp_desc_1 = '',Input_arr_disp_desc_2 = '',Input_pros_refer_cd = '',Input_pros_refer = '',Input_pros_assgn_cd = '',Input_pros_assgn = '',Input_pros_chg_rej = '',Input_pros_off_code = '',Input_pros_off_desc_1 = '',Input_pros_off_desc_2 = '',Input_pros_off_type_cd = '',Input_pros_off_type_desc = '',Input_pros_off_lev = '',Input_pros_act_filed = '',Input_court_case_number = '',Input_court_cd = '',Input_court_desc = '',Input_court_appeal_flag = '',Input_court_final_plea = '',Input_court_off_code = '',Input_court_off_desc_1 = '',Input_court_off_desc_2 = '',Input_court_off_type_cd = '',Input_court_off_type_desc = '',Input_court_off_lev = '',Input_court_statute = '',Input_court_additional_statutes = '',Input_court_statute_desc = '',Input_court_disp_date = '',Input_court_disp_code = '',Input_court_disp_desc_1 = '',Input_court_disp_desc_2 = '',Input_sent_date = '',Input_sent_jail = '',Input_sent_susp_time = '',Input_sent_court_cost = '',Input_sent_court_fine = '',Input_sent_susp_court_fine = '',Input_sent_probation = '',Input_sent_addl_prov_code = '',Input_sent_addl_prov_desc_1 = '',Input_sent_addl_prov_desc_2 = '',Input_sent_consec = '',Input_sent_agency_rec_cust_ori = '',Input_sent_agency_rec_cust = '',Input_appeal_date = '',Input_appeal_off_disp = '',Input_appeal_final_decision = '',Input_convict_dt = '',Input_offense_town = '',Input_cty_conv = '',Input_restitution = '',Input_community_service = '',Input_parole = '',Input_addl_sent_dates = '',Input_probation_desc2 = '',Input_court_dt = '',Input_court_county = '',Input_arr_off_lev_mapped = '',Input_court_off_lev_mapped = '',Input_fcra_offense_key = '',Input_fcra_conviction_flag = '',Input_fcra_traffic_flag = '',Input_fcra_date = '',Input_fcra_date_type = '',Input_conviction_override_date = '',Input_conviction_override_date_type = '',Input_offense_score = '',Input_offense_persistent_id = '',Input_offense_category = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Crim;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(vendor)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_offender_key)='' )
      '' 
    #ELSE
        IF( le.Input_offender_key = (TYPEOF(le.Input_offender_key))'','',':offender_key')
    #END
 
+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END
 
+    #IF( #TEXT(Input_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_state_origin = (TYPEOF(le.Input_state_origin))'','',':state_origin')
    #END
 
+    #IF( #TEXT(Input_source_file)='' )
      '' 
    #ELSE
        IF( le.Input_source_file = (TYPEOF(le.Input_source_file))'','',':source_file')
    #END
 
+    #IF( #TEXT(Input_data_type)='' )
      '' 
    #ELSE
        IF( le.Input_data_type = (TYPEOF(le.Input_data_type))'','',':data_type')
    #END
 
+    #IF( #TEXT(Input_off_comp)='' )
      '' 
    #ELSE
        IF( le.Input_off_comp = (TYPEOF(le.Input_off_comp))'','',':off_comp')
    #END
 
+    #IF( #TEXT(Input_off_delete_flag)='' )
      '' 
    #ELSE
        IF( le.Input_off_delete_flag = (TYPEOF(le.Input_off_delete_flag))'','',':off_delete_flag')
    #END
 
+    #IF( #TEXT(Input_off_date)='' )
      '' 
    #ELSE
        IF( le.Input_off_date = (TYPEOF(le.Input_off_date))'','',':off_date')
    #END
 
+    #IF( #TEXT(Input_arr_date)='' )
      '' 
    #ELSE
        IF( le.Input_arr_date = (TYPEOF(le.Input_arr_date))'','',':arr_date')
    #END
 
+    #IF( #TEXT(Input_num_of_counts)='' )
      '' 
    #ELSE
        IF( le.Input_num_of_counts = (TYPEOF(le.Input_num_of_counts))'','',':num_of_counts')
    #END
 
+    #IF( #TEXT(Input_le_agency_cd)='' )
      '' 
    #ELSE
        IF( le.Input_le_agency_cd = (TYPEOF(le.Input_le_agency_cd))'','',':le_agency_cd')
    #END
 
+    #IF( #TEXT(Input_le_agency_desc)='' )
      '' 
    #ELSE
        IF( le.Input_le_agency_desc = (TYPEOF(le.Input_le_agency_desc))'','',':le_agency_desc')
    #END
 
+    #IF( #TEXT(Input_le_agency_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_le_agency_case_number = (TYPEOF(le.Input_le_agency_case_number))'','',':le_agency_case_number')
    #END
 
+    #IF( #TEXT(Input_traffic_ticket_number)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_ticket_number = (TYPEOF(le.Input_traffic_ticket_number))'','',':traffic_ticket_number')
    #END
 
+    #IF( #TEXT(Input_traffic_dl_no)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_dl_no = (TYPEOF(le.Input_traffic_dl_no))'','',':traffic_dl_no')
    #END
 
+    #IF( #TEXT(Input_traffic_dl_st)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_dl_st = (TYPEOF(le.Input_traffic_dl_st))'','',':traffic_dl_st')
    #END
 
+    #IF( #TEXT(Input_arr_off_code)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_code = (TYPEOF(le.Input_arr_off_code))'','',':arr_off_code')
    #END
 
+    #IF( #TEXT(Input_arr_off_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_desc_1 = (TYPEOF(le.Input_arr_off_desc_1))'','',':arr_off_desc_1')
    #END
 
+    #IF( #TEXT(Input_arr_off_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_desc_2 = (TYPEOF(le.Input_arr_off_desc_2))'','',':arr_off_desc_2')
    #END
 
+    #IF( #TEXT(Input_arr_off_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_type_cd = (TYPEOF(le.Input_arr_off_type_cd))'','',':arr_off_type_cd')
    #END
 
+    #IF( #TEXT(Input_arr_off_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_type_desc = (TYPEOF(le.Input_arr_off_type_desc))'','',':arr_off_type_desc')
    #END
 
+    #IF( #TEXT(Input_arr_off_lev)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_lev = (TYPEOF(le.Input_arr_off_lev))'','',':arr_off_lev')
    #END
 
+    #IF( #TEXT(Input_arr_statute)='' )
      '' 
    #ELSE
        IF( le.Input_arr_statute = (TYPEOF(le.Input_arr_statute))'','',':arr_statute')
    #END
 
+    #IF( #TEXT(Input_arr_statute_desc)='' )
      '' 
    #ELSE
        IF( le.Input_arr_statute_desc = (TYPEOF(le.Input_arr_statute_desc))'','',':arr_statute_desc')
    #END
 
+    #IF( #TEXT(Input_arr_disp_date)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_date = (TYPEOF(le.Input_arr_disp_date))'','',':arr_disp_date')
    #END
 
+    #IF( #TEXT(Input_arr_disp_code)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_code = (TYPEOF(le.Input_arr_disp_code))'','',':arr_disp_code')
    #END
 
+    #IF( #TEXT(Input_arr_disp_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_desc_1 = (TYPEOF(le.Input_arr_disp_desc_1))'','',':arr_disp_desc_1')
    #END
 
+    #IF( #TEXT(Input_arr_disp_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_desc_2 = (TYPEOF(le.Input_arr_disp_desc_2))'','',':arr_disp_desc_2')
    #END
 
+    #IF( #TEXT(Input_pros_refer_cd)='' )
      '' 
    #ELSE
        IF( le.Input_pros_refer_cd = (TYPEOF(le.Input_pros_refer_cd))'','',':pros_refer_cd')
    #END
 
+    #IF( #TEXT(Input_pros_refer)='' )
      '' 
    #ELSE
        IF( le.Input_pros_refer = (TYPEOF(le.Input_pros_refer))'','',':pros_refer')
    #END
 
+    #IF( #TEXT(Input_pros_assgn_cd)='' )
      '' 
    #ELSE
        IF( le.Input_pros_assgn_cd = (TYPEOF(le.Input_pros_assgn_cd))'','',':pros_assgn_cd')
    #END
 
+    #IF( #TEXT(Input_pros_assgn)='' )
      '' 
    #ELSE
        IF( le.Input_pros_assgn = (TYPEOF(le.Input_pros_assgn))'','',':pros_assgn')
    #END
 
+    #IF( #TEXT(Input_pros_chg_rej)='' )
      '' 
    #ELSE
        IF( le.Input_pros_chg_rej = (TYPEOF(le.Input_pros_chg_rej))'','',':pros_chg_rej')
    #END
 
+    #IF( #TEXT(Input_pros_off_code)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_code = (TYPEOF(le.Input_pros_off_code))'','',':pros_off_code')
    #END
 
+    #IF( #TEXT(Input_pros_off_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_desc_1 = (TYPEOF(le.Input_pros_off_desc_1))'','',':pros_off_desc_1')
    #END
 
+    #IF( #TEXT(Input_pros_off_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_desc_2 = (TYPEOF(le.Input_pros_off_desc_2))'','',':pros_off_desc_2')
    #END
 
+    #IF( #TEXT(Input_pros_off_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_type_cd = (TYPEOF(le.Input_pros_off_type_cd))'','',':pros_off_type_cd')
    #END
 
+    #IF( #TEXT(Input_pros_off_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_type_desc = (TYPEOF(le.Input_pros_off_type_desc))'','',':pros_off_type_desc')
    #END
 
+    #IF( #TEXT(Input_pros_off_lev)='' )
      '' 
    #ELSE
        IF( le.Input_pros_off_lev = (TYPEOF(le.Input_pros_off_lev))'','',':pros_off_lev')
    #END
 
+    #IF( #TEXT(Input_pros_act_filed)='' )
      '' 
    #ELSE
        IF( le.Input_pros_act_filed = (TYPEOF(le.Input_pros_act_filed))'','',':pros_act_filed')
    #END
 
+    #IF( #TEXT(Input_court_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_court_case_number = (TYPEOF(le.Input_court_case_number))'','',':court_case_number')
    #END
 
+    #IF( #TEXT(Input_court_cd)='' )
      '' 
    #ELSE
        IF( le.Input_court_cd = (TYPEOF(le.Input_court_cd))'','',':court_cd')
    #END
 
+    #IF( #TEXT(Input_court_desc)='' )
      '' 
    #ELSE
        IF( le.Input_court_desc = (TYPEOF(le.Input_court_desc))'','',':court_desc')
    #END
 
+    #IF( #TEXT(Input_court_appeal_flag)='' )
      '' 
    #ELSE
        IF( le.Input_court_appeal_flag = (TYPEOF(le.Input_court_appeal_flag))'','',':court_appeal_flag')
    #END
 
+    #IF( #TEXT(Input_court_final_plea)='' )
      '' 
    #ELSE
        IF( le.Input_court_final_plea = (TYPEOF(le.Input_court_final_plea))'','',':court_final_plea')
    #END
 
+    #IF( #TEXT(Input_court_off_code)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_code = (TYPEOF(le.Input_court_off_code))'','',':court_off_code')
    #END
 
+    #IF( #TEXT(Input_court_off_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_desc_1 = (TYPEOF(le.Input_court_off_desc_1))'','',':court_off_desc_1')
    #END
 
+    #IF( #TEXT(Input_court_off_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_desc_2 = (TYPEOF(le.Input_court_off_desc_2))'','',':court_off_desc_2')
    #END
 
+    #IF( #TEXT(Input_court_off_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_type_cd = (TYPEOF(le.Input_court_off_type_cd))'','',':court_off_type_cd')
    #END
 
+    #IF( #TEXT(Input_court_off_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_type_desc = (TYPEOF(le.Input_court_off_type_desc))'','',':court_off_type_desc')
    #END
 
+    #IF( #TEXT(Input_court_off_lev)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_lev = (TYPEOF(le.Input_court_off_lev))'','',':court_off_lev')
    #END
 
+    #IF( #TEXT(Input_court_statute)='' )
      '' 
    #ELSE
        IF( le.Input_court_statute = (TYPEOF(le.Input_court_statute))'','',':court_statute')
    #END
 
+    #IF( #TEXT(Input_court_additional_statutes)='' )
      '' 
    #ELSE
        IF( le.Input_court_additional_statutes = (TYPEOF(le.Input_court_additional_statutes))'','',':court_additional_statutes')
    #END
 
+    #IF( #TEXT(Input_court_statute_desc)='' )
      '' 
    #ELSE
        IF( le.Input_court_statute_desc = (TYPEOF(le.Input_court_statute_desc))'','',':court_statute_desc')
    #END
 
+    #IF( #TEXT(Input_court_disp_date)='' )
      '' 
    #ELSE
        IF( le.Input_court_disp_date = (TYPEOF(le.Input_court_disp_date))'','',':court_disp_date')
    #END
 
+    #IF( #TEXT(Input_court_disp_code)='' )
      '' 
    #ELSE
        IF( le.Input_court_disp_code = (TYPEOF(le.Input_court_disp_code))'','',':court_disp_code')
    #END
 
+    #IF( #TEXT(Input_court_disp_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_court_disp_desc_1 = (TYPEOF(le.Input_court_disp_desc_1))'','',':court_disp_desc_1')
    #END
 
+    #IF( #TEXT(Input_court_disp_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_court_disp_desc_2 = (TYPEOF(le.Input_court_disp_desc_2))'','',':court_disp_desc_2')
    #END
 
+    #IF( #TEXT(Input_sent_date)='' )
      '' 
    #ELSE
        IF( le.Input_sent_date = (TYPEOF(le.Input_sent_date))'','',':sent_date')
    #END
 
+    #IF( #TEXT(Input_sent_jail)='' )
      '' 
    #ELSE
        IF( le.Input_sent_jail = (TYPEOF(le.Input_sent_jail))'','',':sent_jail')
    #END
 
+    #IF( #TEXT(Input_sent_susp_time)='' )
      '' 
    #ELSE
        IF( le.Input_sent_susp_time = (TYPEOF(le.Input_sent_susp_time))'','',':sent_susp_time')
    #END
 
+    #IF( #TEXT(Input_sent_court_cost)='' )
      '' 
    #ELSE
        IF( le.Input_sent_court_cost = (TYPEOF(le.Input_sent_court_cost))'','',':sent_court_cost')
    #END
 
+    #IF( #TEXT(Input_sent_court_fine)='' )
      '' 
    #ELSE
        IF( le.Input_sent_court_fine = (TYPEOF(le.Input_sent_court_fine))'','',':sent_court_fine')
    #END
 
+    #IF( #TEXT(Input_sent_susp_court_fine)='' )
      '' 
    #ELSE
        IF( le.Input_sent_susp_court_fine = (TYPEOF(le.Input_sent_susp_court_fine))'','',':sent_susp_court_fine')
    #END
 
+    #IF( #TEXT(Input_sent_probation)='' )
      '' 
    #ELSE
        IF( le.Input_sent_probation = (TYPEOF(le.Input_sent_probation))'','',':sent_probation')
    #END
 
+    #IF( #TEXT(Input_sent_addl_prov_code)='' )
      '' 
    #ELSE
        IF( le.Input_sent_addl_prov_code = (TYPEOF(le.Input_sent_addl_prov_code))'','',':sent_addl_prov_code')
    #END
 
+    #IF( #TEXT(Input_sent_addl_prov_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_sent_addl_prov_desc_1 = (TYPEOF(le.Input_sent_addl_prov_desc_1))'','',':sent_addl_prov_desc_1')
    #END
 
+    #IF( #TEXT(Input_sent_addl_prov_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_sent_addl_prov_desc_2 = (TYPEOF(le.Input_sent_addl_prov_desc_2))'','',':sent_addl_prov_desc_2')
    #END
 
+    #IF( #TEXT(Input_sent_consec)='' )
      '' 
    #ELSE
        IF( le.Input_sent_consec = (TYPEOF(le.Input_sent_consec))'','',':sent_consec')
    #END
 
+    #IF( #TEXT(Input_sent_agency_rec_cust_ori)='' )
      '' 
    #ELSE
        IF( le.Input_sent_agency_rec_cust_ori = (TYPEOF(le.Input_sent_agency_rec_cust_ori))'','',':sent_agency_rec_cust_ori')
    #END
 
+    #IF( #TEXT(Input_sent_agency_rec_cust)='' )
      '' 
    #ELSE
        IF( le.Input_sent_agency_rec_cust = (TYPEOF(le.Input_sent_agency_rec_cust))'','',':sent_agency_rec_cust')
    #END
 
+    #IF( #TEXT(Input_appeal_date)='' )
      '' 
    #ELSE
        IF( le.Input_appeal_date = (TYPEOF(le.Input_appeal_date))'','',':appeal_date')
    #END
 
+    #IF( #TEXT(Input_appeal_off_disp)='' )
      '' 
    #ELSE
        IF( le.Input_appeal_off_disp = (TYPEOF(le.Input_appeal_off_disp))'','',':appeal_off_disp')
    #END
 
+    #IF( #TEXT(Input_appeal_final_decision)='' )
      '' 
    #ELSE
        IF( le.Input_appeal_final_decision = (TYPEOF(le.Input_appeal_final_decision))'','',':appeal_final_decision')
    #END
 
+    #IF( #TEXT(Input_convict_dt)='' )
      '' 
    #ELSE
        IF( le.Input_convict_dt = (TYPEOF(le.Input_convict_dt))'','',':convict_dt')
    #END
 
+    #IF( #TEXT(Input_offense_town)='' )
      '' 
    #ELSE
        IF( le.Input_offense_town = (TYPEOF(le.Input_offense_town))'','',':offense_town')
    #END
 
+    #IF( #TEXT(Input_cty_conv)='' )
      '' 
    #ELSE
        IF( le.Input_cty_conv = (TYPEOF(le.Input_cty_conv))'','',':cty_conv')
    #END
 
+    #IF( #TEXT(Input_restitution)='' )
      '' 
    #ELSE
        IF( le.Input_restitution = (TYPEOF(le.Input_restitution))'','',':restitution')
    #END
 
+    #IF( #TEXT(Input_community_service)='' )
      '' 
    #ELSE
        IF( le.Input_community_service = (TYPEOF(le.Input_community_service))'','',':community_service')
    #END
 
+    #IF( #TEXT(Input_parole)='' )
      '' 
    #ELSE
        IF( le.Input_parole = (TYPEOF(le.Input_parole))'','',':parole')
    #END
 
+    #IF( #TEXT(Input_addl_sent_dates)='' )
      '' 
    #ELSE
        IF( le.Input_addl_sent_dates = (TYPEOF(le.Input_addl_sent_dates))'','',':addl_sent_dates')
    #END
 
+    #IF( #TEXT(Input_probation_desc2)='' )
      '' 
    #ELSE
        IF( le.Input_probation_desc2 = (TYPEOF(le.Input_probation_desc2))'','',':probation_desc2')
    #END
 
+    #IF( #TEXT(Input_court_dt)='' )
      '' 
    #ELSE
        IF( le.Input_court_dt = (TYPEOF(le.Input_court_dt))'','',':court_dt')
    #END
 
+    #IF( #TEXT(Input_court_county)='' )
      '' 
    #ELSE
        IF( le.Input_court_county = (TYPEOF(le.Input_court_county))'','',':court_county')
    #END
 
+    #IF( #TEXT(Input_arr_off_lev_mapped)='' )
      '' 
    #ELSE
        IF( le.Input_arr_off_lev_mapped = (TYPEOF(le.Input_arr_off_lev_mapped))'','',':arr_off_lev_mapped')
    #END
 
+    #IF( #TEXT(Input_court_off_lev_mapped)='' )
      '' 
    #ELSE
        IF( le.Input_court_off_lev_mapped = (TYPEOF(le.Input_court_off_lev_mapped))'','',':court_off_lev_mapped')
    #END
 
+    #IF( #TEXT(Input_fcra_offense_key)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_offense_key = (TYPEOF(le.Input_fcra_offense_key))'','',':fcra_offense_key')
    #END
 
+    #IF( #TEXT(Input_fcra_conviction_flag)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_conviction_flag = (TYPEOF(le.Input_fcra_conviction_flag))'','',':fcra_conviction_flag')
    #END
 
+    #IF( #TEXT(Input_fcra_traffic_flag)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_traffic_flag = (TYPEOF(le.Input_fcra_traffic_flag))'','',':fcra_traffic_flag')
    #END
 
+    #IF( #TEXT(Input_fcra_date)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_date = (TYPEOF(le.Input_fcra_date))'','',':fcra_date')
    #END
 
+    #IF( #TEXT(Input_fcra_date_type)='' )
      '' 
    #ELSE
        IF( le.Input_fcra_date_type = (TYPEOF(le.Input_fcra_date_type))'','',':fcra_date_type')
    #END
 
+    #IF( #TEXT(Input_conviction_override_date)='' )
      '' 
    #ELSE
        IF( le.Input_conviction_override_date = (TYPEOF(le.Input_conviction_override_date))'','',':conviction_override_date')
    #END
 
+    #IF( #TEXT(Input_conviction_override_date_type)='' )
      '' 
    #ELSE
        IF( le.Input_conviction_override_date_type = (TYPEOF(le.Input_conviction_override_date_type))'','',':conviction_override_date_type')
    #END
 
+    #IF( #TEXT(Input_offense_score)='' )
      '' 
    #ELSE
        IF( le.Input_offense_score = (TYPEOF(le.Input_offense_score))'','',':offense_score')
    #END
 
+    #IF( #TEXT(Input_offense_persistent_id)='' )
      '' 
    #ELSE
        IF( le.Input_offense_persistent_id = (TYPEOF(le.Input_offense_persistent_id))'','',':offense_persistent_id')
    #END
 
+    #IF( #TEXT(Input_offense_category)='' )
      '' 
    #ELSE
        IF( le.Input_offense_category = (TYPEOF(le.Input_offense_category))'','',':offense_category')
    #END
;
    #IF (#TEXT(vendor)<>'')
    SELF.source := le.vendor;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(vendor)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(vendor)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(vendor)<>'' ) source, #END -cnt );
ENDMACRO;
