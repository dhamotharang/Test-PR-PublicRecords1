 
EXPORT Moxie_DOC_Offenses_Dev_MAC_PopulationStatistics(infile,Ref='',vendor='',Input_process_date = '',Input_offender_key = '',Input_vendor = '',Input_county_of_origin = '',Input_source_file = '',Input_data_type = '',Input_record_type = '',Input_orig_state = '',Input_offense_key = '',Input_off_date = '',Input_arr_date = '',Input_case_num = '',Input_total_num_of_offenses = '',Input_num_of_counts = '',Input_off_code = '',Input_chg = '',Input_chg_typ_flg = '',Input_off_of_record = '',Input_off_desc_1 = '',Input_off_desc_2 = '',Input_add_off_cd = '',Input_add_off_desc = '',Input_off_typ = '',Input_off_lev = '',Input_arr_disp_date = '',Input_arr_disp_cd = '',Input_arr_disp_desc_1 = '',Input_arr_disp_desc_2 = '',Input_arr_disp_desc_3 = '',Input_court_cd = '',Input_court_desc = '',Input_ct_dist = '',Input_ct_fnl_plea_cd = '',Input_ct_fnl_plea = '',Input_ct_off_code = '',Input_ct_chg = '',Input_ct_chg_typ_flg = '',Input_ct_off_desc_1 = '',Input_ct_off_desc_2 = '',Input_ct_addl_desc_cd = '',Input_ct_off_lev = '',Input_ct_disp_dt = '',Input_ct_disp_cd = '',Input_ct_disp_desc_1 = '',Input_ct_disp_desc_2 = '',Input_cty_conv_cd = '',Input_cty_conv = '',Input_adj_wthd = '',Input_stc_dt = '',Input_stc_cd = '',Input_stc_comp = '',Input_stc_desc_1 = '',Input_stc_desc_2 = '',Input_stc_desc_3 = '',Input_stc_desc_4 = '',Input_stc_lgth = '',Input_stc_lgth_desc = '',Input_inc_adm_dt = '',Input_min_term = '',Input_min_term_desc = '',Input_max_term = '',Input_max_term_desc = '',Input_parole = '',Input_probation = '',Input_offensetown = '',Input_convict_dt = '',Input_court_county = '',Input_fcra_offense_key = '',Input_fcra_conviction_flag = '',Input_fcra_traffic_flag = '',Input_fcra_date = '',Input_fcra_date_type = '',Input_conviction_override_date = '',Input_conviction_override_date_type = '',Input_offense_score = '',Input_offense_persistent_id = '',Input_offense_category = '',Input_hyg_classification_code = '',Input_old_ln_offense_score = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_county_of_origin)='' )
      '' 
    #ELSE
        IF( le.Input_county_of_origin = (TYPEOF(le.Input_county_of_origin))'','',':county_of_origin')
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
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
 
+    #IF( #TEXT(Input_offense_key)='' )
      '' 
    #ELSE
        IF( le.Input_offense_key = (TYPEOF(le.Input_offense_key))'','',':offense_key')
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
 
+    #IF( #TEXT(Input_case_num)='' )
      '' 
    #ELSE
        IF( le.Input_case_num = (TYPEOF(le.Input_case_num))'','',':case_num')
    #END
 
+    #IF( #TEXT(Input_total_num_of_offenses)='' )
      '' 
    #ELSE
        IF( le.Input_total_num_of_offenses = (TYPEOF(le.Input_total_num_of_offenses))'','',':total_num_of_offenses')
    #END
 
+    #IF( #TEXT(Input_num_of_counts)='' )
      '' 
    #ELSE
        IF( le.Input_num_of_counts = (TYPEOF(le.Input_num_of_counts))'','',':num_of_counts')
    #END
 
+    #IF( #TEXT(Input_off_code)='' )
      '' 
    #ELSE
        IF( le.Input_off_code = (TYPEOF(le.Input_off_code))'','',':off_code')
    #END
 
+    #IF( #TEXT(Input_chg)='' )
      '' 
    #ELSE
        IF( le.Input_chg = (TYPEOF(le.Input_chg))'','',':chg')
    #END
 
+    #IF( #TEXT(Input_chg_typ_flg)='' )
      '' 
    #ELSE
        IF( le.Input_chg_typ_flg = (TYPEOF(le.Input_chg_typ_flg))'','',':chg_typ_flg')
    #END
 
+    #IF( #TEXT(Input_off_of_record)='' )
      '' 
    #ELSE
        IF( le.Input_off_of_record = (TYPEOF(le.Input_off_of_record))'','',':off_of_record')
    #END
 
+    #IF( #TEXT(Input_off_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_off_desc_1 = (TYPEOF(le.Input_off_desc_1))'','',':off_desc_1')
    #END
 
+    #IF( #TEXT(Input_off_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_off_desc_2 = (TYPEOF(le.Input_off_desc_2))'','',':off_desc_2')
    #END
 
+    #IF( #TEXT(Input_add_off_cd)='' )
      '' 
    #ELSE
        IF( le.Input_add_off_cd = (TYPEOF(le.Input_add_off_cd))'','',':add_off_cd')
    #END
 
+    #IF( #TEXT(Input_add_off_desc)='' )
      '' 
    #ELSE
        IF( le.Input_add_off_desc = (TYPEOF(le.Input_add_off_desc))'','',':add_off_desc')
    #END
 
+    #IF( #TEXT(Input_off_typ)='' )
      '' 
    #ELSE
        IF( le.Input_off_typ = (TYPEOF(le.Input_off_typ))'','',':off_typ')
    #END
 
+    #IF( #TEXT(Input_off_lev)='' )
      '' 
    #ELSE
        IF( le.Input_off_lev = (TYPEOF(le.Input_off_lev))'','',':off_lev')
    #END
 
+    #IF( #TEXT(Input_arr_disp_date)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_date = (TYPEOF(le.Input_arr_disp_date))'','',':arr_disp_date')
    #END
 
+    #IF( #TEXT(Input_arr_disp_cd)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_cd = (TYPEOF(le.Input_arr_disp_cd))'','',':arr_disp_cd')
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
 
+    #IF( #TEXT(Input_arr_disp_desc_3)='' )
      '' 
    #ELSE
        IF( le.Input_arr_disp_desc_3 = (TYPEOF(le.Input_arr_disp_desc_3))'','',':arr_disp_desc_3')
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
 
+    #IF( #TEXT(Input_ct_dist)='' )
      '' 
    #ELSE
        IF( le.Input_ct_dist = (TYPEOF(le.Input_ct_dist))'','',':ct_dist')
    #END
 
+    #IF( #TEXT(Input_ct_fnl_plea_cd)='' )
      '' 
    #ELSE
        IF( le.Input_ct_fnl_plea_cd = (TYPEOF(le.Input_ct_fnl_plea_cd))'','',':ct_fnl_plea_cd')
    #END
 
+    #IF( #TEXT(Input_ct_fnl_plea)='' )
      '' 
    #ELSE
        IF( le.Input_ct_fnl_plea = (TYPEOF(le.Input_ct_fnl_plea))'','',':ct_fnl_plea')
    #END
 
+    #IF( #TEXT(Input_ct_off_code)='' )
      '' 
    #ELSE
        IF( le.Input_ct_off_code = (TYPEOF(le.Input_ct_off_code))'','',':ct_off_code')
    #END
 
+    #IF( #TEXT(Input_ct_chg)='' )
      '' 
    #ELSE
        IF( le.Input_ct_chg = (TYPEOF(le.Input_ct_chg))'','',':ct_chg')
    #END
 
+    #IF( #TEXT(Input_ct_chg_typ_flg)='' )
      '' 
    #ELSE
        IF( le.Input_ct_chg_typ_flg = (TYPEOF(le.Input_ct_chg_typ_flg))'','',':ct_chg_typ_flg')
    #END
 
+    #IF( #TEXT(Input_ct_off_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_ct_off_desc_1 = (TYPEOF(le.Input_ct_off_desc_1))'','',':ct_off_desc_1')
    #END
 
+    #IF( #TEXT(Input_ct_off_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_ct_off_desc_2 = (TYPEOF(le.Input_ct_off_desc_2))'','',':ct_off_desc_2')
    #END
 
+    #IF( #TEXT(Input_ct_addl_desc_cd)='' )
      '' 
    #ELSE
        IF( le.Input_ct_addl_desc_cd = (TYPEOF(le.Input_ct_addl_desc_cd))'','',':ct_addl_desc_cd')
    #END
 
+    #IF( #TEXT(Input_ct_off_lev)='' )
      '' 
    #ELSE
        IF( le.Input_ct_off_lev = (TYPEOF(le.Input_ct_off_lev))'','',':ct_off_lev')
    #END
 
+    #IF( #TEXT(Input_ct_disp_dt)='' )
      '' 
    #ELSE
        IF( le.Input_ct_disp_dt = (TYPEOF(le.Input_ct_disp_dt))'','',':ct_disp_dt')
    #END
 
+    #IF( #TEXT(Input_ct_disp_cd)='' )
      '' 
    #ELSE
        IF( le.Input_ct_disp_cd = (TYPEOF(le.Input_ct_disp_cd))'','',':ct_disp_cd')
    #END
 
+    #IF( #TEXT(Input_ct_disp_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_ct_disp_desc_1 = (TYPEOF(le.Input_ct_disp_desc_1))'','',':ct_disp_desc_1')
    #END
 
+    #IF( #TEXT(Input_ct_disp_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_ct_disp_desc_2 = (TYPEOF(le.Input_ct_disp_desc_2))'','',':ct_disp_desc_2')
    #END
 
+    #IF( #TEXT(Input_cty_conv_cd)='' )
      '' 
    #ELSE
        IF( le.Input_cty_conv_cd = (TYPEOF(le.Input_cty_conv_cd))'','',':cty_conv_cd')
    #END
 
+    #IF( #TEXT(Input_cty_conv)='' )
      '' 
    #ELSE
        IF( le.Input_cty_conv = (TYPEOF(le.Input_cty_conv))'','',':cty_conv')
    #END
 
+    #IF( #TEXT(Input_adj_wthd)='' )
      '' 
    #ELSE
        IF( le.Input_adj_wthd = (TYPEOF(le.Input_adj_wthd))'','',':adj_wthd')
    #END
 
+    #IF( #TEXT(Input_stc_dt)='' )
      '' 
    #ELSE
        IF( le.Input_stc_dt = (TYPEOF(le.Input_stc_dt))'','',':stc_dt')
    #END
 
+    #IF( #TEXT(Input_stc_cd)='' )
      '' 
    #ELSE
        IF( le.Input_stc_cd = (TYPEOF(le.Input_stc_cd))'','',':stc_cd')
    #END
 
+    #IF( #TEXT(Input_stc_comp)='' )
      '' 
    #ELSE
        IF( le.Input_stc_comp = (TYPEOF(le.Input_stc_comp))'','',':stc_comp')
    #END
 
+    #IF( #TEXT(Input_stc_desc_1)='' )
      '' 
    #ELSE
        IF( le.Input_stc_desc_1 = (TYPEOF(le.Input_stc_desc_1))'','',':stc_desc_1')
    #END
 
+    #IF( #TEXT(Input_stc_desc_2)='' )
      '' 
    #ELSE
        IF( le.Input_stc_desc_2 = (TYPEOF(le.Input_stc_desc_2))'','',':stc_desc_2')
    #END
 
+    #IF( #TEXT(Input_stc_desc_3)='' )
      '' 
    #ELSE
        IF( le.Input_stc_desc_3 = (TYPEOF(le.Input_stc_desc_3))'','',':stc_desc_3')
    #END
 
+    #IF( #TEXT(Input_stc_desc_4)='' )
      '' 
    #ELSE
        IF( le.Input_stc_desc_4 = (TYPEOF(le.Input_stc_desc_4))'','',':stc_desc_4')
    #END
 
+    #IF( #TEXT(Input_stc_lgth)='' )
      '' 
    #ELSE
        IF( le.Input_stc_lgth = (TYPEOF(le.Input_stc_lgth))'','',':stc_lgth')
    #END
 
+    #IF( #TEXT(Input_stc_lgth_desc)='' )
      '' 
    #ELSE
        IF( le.Input_stc_lgth_desc = (TYPEOF(le.Input_stc_lgth_desc))'','',':stc_lgth_desc')
    #END
 
+    #IF( #TEXT(Input_inc_adm_dt)='' )
      '' 
    #ELSE
        IF( le.Input_inc_adm_dt = (TYPEOF(le.Input_inc_adm_dt))'','',':inc_adm_dt')
    #END
 
+    #IF( #TEXT(Input_min_term)='' )
      '' 
    #ELSE
        IF( le.Input_min_term = (TYPEOF(le.Input_min_term))'','',':min_term')
    #END
 
+    #IF( #TEXT(Input_min_term_desc)='' )
      '' 
    #ELSE
        IF( le.Input_min_term_desc = (TYPEOF(le.Input_min_term_desc))'','',':min_term_desc')
    #END
 
+    #IF( #TEXT(Input_max_term)='' )
      '' 
    #ELSE
        IF( le.Input_max_term = (TYPEOF(le.Input_max_term))'','',':max_term')
    #END
 
+    #IF( #TEXT(Input_max_term_desc)='' )
      '' 
    #ELSE
        IF( le.Input_max_term_desc = (TYPEOF(le.Input_max_term_desc))'','',':max_term_desc')
    #END
 
+    #IF( #TEXT(Input_parole)='' )
      '' 
    #ELSE
        IF( le.Input_parole = (TYPEOF(le.Input_parole))'','',':parole')
    #END
 
+    #IF( #TEXT(Input_probation)='' )
      '' 
    #ELSE
        IF( le.Input_probation = (TYPEOF(le.Input_probation))'','',':probation')
    #END
 
+    #IF( #TEXT(Input_offensetown)='' )
      '' 
    #ELSE
        IF( le.Input_offensetown = (TYPEOF(le.Input_offensetown))'','',':offensetown')
    #END
 
+    #IF( #TEXT(Input_convict_dt)='' )
      '' 
    #ELSE
        IF( le.Input_convict_dt = (TYPEOF(le.Input_convict_dt))'','',':convict_dt')
    #END
 
+    #IF( #TEXT(Input_court_county)='' )
      '' 
    #ELSE
        IF( le.Input_court_county = (TYPEOF(le.Input_court_county))'','',':court_county')
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
 
+    #IF( #TEXT(Input_hyg_classification_code)='' )
      '' 
    #ELSE
        IF( le.Input_hyg_classification_code = (TYPEOF(le.Input_hyg_classification_code))'','',':hyg_classification_code')
    #END
 
+    #IF( #TEXT(Input_old_ln_offense_score)='' )
      '' 
    #ELSE
        IF( le.Input_old_ln_offense_score = (TYPEOF(le.Input_old_ln_offense_score))'','',':old_ln_offense_score')
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
