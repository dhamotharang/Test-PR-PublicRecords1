EXPORT MAC_PopulationStatistics(infile,Ref='',append_state_origin='',Input_append_process_date = '',Input_append_state_origin = '',Input_file_typ = '',Input_vin = '',Input_vehicle_typ = '',Input_model_yr = '',Input_model_yr_ind = '',Input_make = '',Input_make_ind = '',Input_series = '',Input_series_ind = '',Input_prime_color = '',Input_second_color = '',Input_body_style = '',Input_body_style_ind = '',Input_model = '',Input_model_ind = '',Input_weight = '',Input_lengt = '',Input_axle_cnt = '',Input_plate_nbr = '',Input_plate_state = '',Input_prev_plate_nbr = '',Input_prev_plate_state = '',Input_plate_typ_cd = '',Input_mstr_src_state = '',Input_reg_decal_nbr = '',Input_org_reg_dt = '',Input_reg_renew_dt = '',Input_reg_exp_dt = '',Input_title_nbr = '',Input_org_title_dt = '',Input_title_trans_dt = '',Input_name_typ_cd = '',Input_owner_typ_cd = '',Input_first_nm = '',Input_middle_nm = '',Input_last_nm = '',Input_name_suffix = '',Input_prof_suffix = '',Input_ind_ssn = '',Input_ind_dob = '',Input_mail_range = '',Input_m_pre_dir = '',Input_m_street = '',Input_m_suffix = '',Input_m_post_dir = '',Input_m_pob = '',Input_m_rr_nbr = '',Input_m_rr_box = '',Input_m_scndry_rng = '',Input_m_scndry_des = '',Input_m_city = '',Input_m_state = '',Input_m_zip5 = '',Input_m_zip4 = '',Input_m_cntry_cd = '',Input_m_cc_filler = '',Input_m_cc = '',Input_m_county = '',Input_phys_range = '',Input_p_pre_dir = '',Input_p_street = '',Input_p_suffix = '',Input_p_post_dir = '',Input_p_pob = '',Input_p_rr_nbr = '',Input_p_rr_box = '',Input_p_scndry_rng = '',Input_p_scndry_des = '',Input_p_city = '',Input_p_state = '',Input_p_zip5 = '',Input_p_zip4 = '',Input_p_cntry_cd = '',Input_p_cc_filler = '',Input_p_cc = '',Input_p_county = '',Input_opt_out_cd = '',Input_asg_wgt = '',Input_asg_wgt_uom = '',Input_source_ctl_id = '',Input_raw_name = '',Input_branded_title_flag = '',Input_brand_code_1 = '',Input_brand_date_1 = '',Input_brand_state_1 = '',Input_brand_code_2 = '',Input_brand_date_2 = '',Input_brand_state_2 = '',Input_brand_code_3 = '',Input_brand_date_3 = '',Input_brand_state_3 = '',Input_brand_code_4 = '',Input_brand_date_4 = '',Input_brand_state_4 = '',Input_brand_code_5 = '',Input_brand_date_5 = '',Input_brand_state_5 = '',Input_tod_flag = '',Input_model_class_code = '',Input_model_class = '',Input_min_door_count = '',Input_safety_type = '',Input_airbag_driver = '',Input_airbag_front_driver_side = '',Input_airbag_front_head_curtain = '',Input_airbag_front_pass = '',Input_airbag_front_pass_side = '',Input_airbags = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_VehicleV2_Experian;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(append_state_origin)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_append_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_append_process_date = (TYPEOF(le.Input_append_process_date))'','',':append_process_date')
    #END
+    #IF( #TEXT(Input_append_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_append_state_origin = (TYPEOF(le.Input_append_state_origin))'','',':append_state_origin')
    #END
+    #IF( #TEXT(Input_file_typ)='' )
      '' 
    #ELSE
        IF( le.Input_file_typ = (TYPEOF(le.Input_file_typ))'','',':file_typ')
    #END
+    #IF( #TEXT(Input_vin)='' )
      '' 
    #ELSE
        IF( le.Input_vin = (TYPEOF(le.Input_vin))'','',':vin')
    #END
+    #IF( #TEXT(Input_vehicle_typ)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_typ = (TYPEOF(le.Input_vehicle_typ))'','',':vehicle_typ')
    #END
+    #IF( #TEXT(Input_model_yr)='' )
      '' 
    #ELSE
        IF( le.Input_model_yr = (TYPEOF(le.Input_model_yr))'','',':model_yr')
    #END
+    #IF( #TEXT(Input_model_yr_ind)='' )
      '' 
    #ELSE
        IF( le.Input_model_yr_ind = (TYPEOF(le.Input_model_yr_ind))'','',':model_yr_ind')
    #END
+    #IF( #TEXT(Input_make)='' )
      '' 
    #ELSE
        IF( le.Input_make = (TYPEOF(le.Input_make))'','',':make')
    #END
+    #IF( #TEXT(Input_make_ind)='' )
      '' 
    #ELSE
        IF( le.Input_make_ind = (TYPEOF(le.Input_make_ind))'','',':make_ind')
    #END
+    #IF( #TEXT(Input_series)='' )
      '' 
    #ELSE
        IF( le.Input_series = (TYPEOF(le.Input_series))'','',':series')
    #END
+    #IF( #TEXT(Input_series_ind)='' )
      '' 
    #ELSE
        IF( le.Input_series_ind = (TYPEOF(le.Input_series_ind))'','',':series_ind')
    #END
+    #IF( #TEXT(Input_prime_color)='' )
      '' 
    #ELSE
        IF( le.Input_prime_color = (TYPEOF(le.Input_prime_color))'','',':prime_color')
    #END
+    #IF( #TEXT(Input_second_color)='' )
      '' 
    #ELSE
        IF( le.Input_second_color = (TYPEOF(le.Input_second_color))'','',':second_color')
    #END
+    #IF( #TEXT(Input_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_body_style = (TYPEOF(le.Input_body_style))'','',':body_style')
    #END
+    #IF( #TEXT(Input_body_style_ind)='' )
      '' 
    #ELSE
        IF( le.Input_body_style_ind = (TYPEOF(le.Input_body_style_ind))'','',':body_style_ind')
    #END
+    #IF( #TEXT(Input_model)='' )
      '' 
    #ELSE
        IF( le.Input_model = (TYPEOF(le.Input_model))'','',':model')
    #END
+    #IF( #TEXT(Input_model_ind)='' )
      '' 
    #ELSE
        IF( le.Input_model_ind = (TYPEOF(le.Input_model_ind))'','',':model_ind')
    #END
+    #IF( #TEXT(Input_weight)='' )
      '' 
    #ELSE
        IF( le.Input_weight = (TYPEOF(le.Input_weight))'','',':weight')
    #END
+    #IF( #TEXT(Input_lengt)='' )
      '' 
    #ELSE
        IF( le.Input_lengt = (TYPEOF(le.Input_lengt))'','',':lengt')
    #END
+    #IF( #TEXT(Input_axle_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_axle_cnt = (TYPEOF(le.Input_axle_cnt))'','',':axle_cnt')
    #END
+    #IF( #TEXT(Input_plate_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_plate_nbr = (TYPEOF(le.Input_plate_nbr))'','',':plate_nbr')
    #END
+    #IF( #TEXT(Input_plate_state)='' )
      '' 
    #ELSE
        IF( le.Input_plate_state = (TYPEOF(le.Input_plate_state))'','',':plate_state')
    #END
+    #IF( #TEXT(Input_prev_plate_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_prev_plate_nbr = (TYPEOF(le.Input_prev_plate_nbr))'','',':prev_plate_nbr')
    #END
+    #IF( #TEXT(Input_prev_plate_state)='' )
      '' 
    #ELSE
        IF( le.Input_prev_plate_state = (TYPEOF(le.Input_prev_plate_state))'','',':prev_plate_state')
    #END
+    #IF( #TEXT(Input_plate_typ_cd)='' )
      '' 
    #ELSE
        IF( le.Input_plate_typ_cd = (TYPEOF(le.Input_plate_typ_cd))'','',':plate_typ_cd')
    #END
+    #IF( #TEXT(Input_mstr_src_state)='' )
      '' 
    #ELSE
        IF( le.Input_mstr_src_state = (TYPEOF(le.Input_mstr_src_state))'','',':mstr_src_state')
    #END
+    #IF( #TEXT(Input_reg_decal_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_reg_decal_nbr = (TYPEOF(le.Input_reg_decal_nbr))'','',':reg_decal_nbr')
    #END
+    #IF( #TEXT(Input_org_reg_dt)='' )
      '' 
    #ELSE
        IF( le.Input_org_reg_dt = (TYPEOF(le.Input_org_reg_dt))'','',':org_reg_dt')
    #END
+    #IF( #TEXT(Input_reg_renew_dt)='' )
      '' 
    #ELSE
        IF( le.Input_reg_renew_dt = (TYPEOF(le.Input_reg_renew_dt))'','',':reg_renew_dt')
    #END
+    #IF( #TEXT(Input_reg_exp_dt)='' )
      '' 
    #ELSE
        IF( le.Input_reg_exp_dt = (TYPEOF(le.Input_reg_exp_dt))'','',':reg_exp_dt')
    #END
+    #IF( #TEXT(Input_title_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_title_nbr = (TYPEOF(le.Input_title_nbr))'','',':title_nbr')
    #END
+    #IF( #TEXT(Input_org_title_dt)='' )
      '' 
    #ELSE
        IF( le.Input_org_title_dt = (TYPEOF(le.Input_org_title_dt))'','',':org_title_dt')
    #END
+    #IF( #TEXT(Input_title_trans_dt)='' )
      '' 
    #ELSE
        IF( le.Input_title_trans_dt = (TYPEOF(le.Input_title_trans_dt))'','',':title_trans_dt')
    #END
+    #IF( #TEXT(Input_name_typ_cd)='' )
      '' 
    #ELSE
        IF( le.Input_name_typ_cd = (TYPEOF(le.Input_name_typ_cd))'','',':name_typ_cd')
    #END
+    #IF( #TEXT(Input_owner_typ_cd)='' )
      '' 
    #ELSE
        IF( le.Input_owner_typ_cd = (TYPEOF(le.Input_owner_typ_cd))'','',':owner_typ_cd')
    #END
+    #IF( #TEXT(Input_first_nm)='' )
      '' 
    #ELSE
        IF( le.Input_first_nm = (TYPEOF(le.Input_first_nm))'','',':first_nm')
    #END
+    #IF( #TEXT(Input_middle_nm)='' )
      '' 
    #ELSE
        IF( le.Input_middle_nm = (TYPEOF(le.Input_middle_nm))'','',':middle_nm')
    #END
+    #IF( #TEXT(Input_last_nm)='' )
      '' 
    #ELSE
        IF( le.Input_last_nm = (TYPEOF(le.Input_last_nm))'','',':last_nm')
    #END
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
+    #IF( #TEXT(Input_prof_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_prof_suffix = (TYPEOF(le.Input_prof_suffix))'','',':prof_suffix')
    #END
+    #IF( #TEXT(Input_ind_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ind_ssn = (TYPEOF(le.Input_ind_ssn))'','',':ind_ssn')
    #END
+    #IF( #TEXT(Input_ind_dob)='' )
      '' 
    #ELSE
        IF( le.Input_ind_dob = (TYPEOF(le.Input_ind_dob))'','',':ind_dob')
    #END
+    #IF( #TEXT(Input_mail_range)='' )
      '' 
    #ELSE
        IF( le.Input_mail_range = (TYPEOF(le.Input_mail_range))'','',':mail_range')
    #END
+    #IF( #TEXT(Input_m_pre_dir)='' )
      '' 
    #ELSE
        IF( le.Input_m_pre_dir = (TYPEOF(le.Input_m_pre_dir))'','',':m_pre_dir')
    #END
+    #IF( #TEXT(Input_m_street)='' )
      '' 
    #ELSE
        IF( le.Input_m_street = (TYPEOF(le.Input_m_street))'','',':m_street')
    #END
+    #IF( #TEXT(Input_m_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_m_suffix = (TYPEOF(le.Input_m_suffix))'','',':m_suffix')
    #END
+    #IF( #TEXT(Input_m_post_dir)='' )
      '' 
    #ELSE
        IF( le.Input_m_post_dir = (TYPEOF(le.Input_m_post_dir))'','',':m_post_dir')
    #END
+    #IF( #TEXT(Input_m_pob)='' )
      '' 
    #ELSE
        IF( le.Input_m_pob = (TYPEOF(le.Input_m_pob))'','',':m_pob')
    #END
+    #IF( #TEXT(Input_m_rr_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_m_rr_nbr = (TYPEOF(le.Input_m_rr_nbr))'','',':m_rr_nbr')
    #END
+    #IF( #TEXT(Input_m_rr_box)='' )
      '' 
    #ELSE
        IF( le.Input_m_rr_box = (TYPEOF(le.Input_m_rr_box))'','',':m_rr_box')
    #END
+    #IF( #TEXT(Input_m_scndry_rng)='' )
      '' 
    #ELSE
        IF( le.Input_m_scndry_rng = (TYPEOF(le.Input_m_scndry_rng))'','',':m_scndry_rng')
    #END
+    #IF( #TEXT(Input_m_scndry_des)='' )
      '' 
    #ELSE
        IF( le.Input_m_scndry_des = (TYPEOF(le.Input_m_scndry_des))'','',':m_scndry_des')
    #END
+    #IF( #TEXT(Input_m_city)='' )
      '' 
    #ELSE
        IF( le.Input_m_city = (TYPEOF(le.Input_m_city))'','',':m_city')
    #END
+    #IF( #TEXT(Input_m_state)='' )
      '' 
    #ELSE
        IF( le.Input_m_state = (TYPEOF(le.Input_m_state))'','',':m_state')
    #END
+    #IF( #TEXT(Input_m_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_m_zip5 = (TYPEOF(le.Input_m_zip5))'','',':m_zip5')
    #END
+    #IF( #TEXT(Input_m_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_m_zip4 = (TYPEOF(le.Input_m_zip4))'','',':m_zip4')
    #END
+    #IF( #TEXT(Input_m_cntry_cd)='' )
      '' 
    #ELSE
        IF( le.Input_m_cntry_cd = (TYPEOF(le.Input_m_cntry_cd))'','',':m_cntry_cd')
    #END
+    #IF( #TEXT(Input_m_cc_filler)='' )
      '' 
    #ELSE
        IF( le.Input_m_cc_filler = (TYPEOF(le.Input_m_cc_filler))'','',':m_cc_filler')
    #END
+    #IF( #TEXT(Input_m_cc)='' )
      '' 
    #ELSE
        IF( le.Input_m_cc = (TYPEOF(le.Input_m_cc))'','',':m_cc')
    #END
+    #IF( #TEXT(Input_m_county)='' )
      '' 
    #ELSE
        IF( le.Input_m_county = (TYPEOF(le.Input_m_county))'','',':m_county')
    #END
+    #IF( #TEXT(Input_phys_range)='' )
      '' 
    #ELSE
        IF( le.Input_phys_range = (TYPEOF(le.Input_phys_range))'','',':phys_range')
    #END
+    #IF( #TEXT(Input_p_pre_dir)='' )
      '' 
    #ELSE
        IF( le.Input_p_pre_dir = (TYPEOF(le.Input_p_pre_dir))'','',':p_pre_dir')
    #END
+    #IF( #TEXT(Input_p_street)='' )
      '' 
    #ELSE
        IF( le.Input_p_street = (TYPEOF(le.Input_p_street))'','',':p_street')
    #END
+    #IF( #TEXT(Input_p_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_p_suffix = (TYPEOF(le.Input_p_suffix))'','',':p_suffix')
    #END
+    #IF( #TEXT(Input_p_post_dir)='' )
      '' 
    #ELSE
        IF( le.Input_p_post_dir = (TYPEOF(le.Input_p_post_dir))'','',':p_post_dir')
    #END
+    #IF( #TEXT(Input_p_pob)='' )
      '' 
    #ELSE
        IF( le.Input_p_pob = (TYPEOF(le.Input_p_pob))'','',':p_pob')
    #END
+    #IF( #TEXT(Input_p_rr_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_p_rr_nbr = (TYPEOF(le.Input_p_rr_nbr))'','',':p_rr_nbr')
    #END
+    #IF( #TEXT(Input_p_rr_box)='' )
      '' 
    #ELSE
        IF( le.Input_p_rr_box = (TYPEOF(le.Input_p_rr_box))'','',':p_rr_box')
    #END
+    #IF( #TEXT(Input_p_scndry_rng)='' )
      '' 
    #ELSE
        IF( le.Input_p_scndry_rng = (TYPEOF(le.Input_p_scndry_rng))'','',':p_scndry_rng')
    #END
+    #IF( #TEXT(Input_p_scndry_des)='' )
      '' 
    #ELSE
        IF( le.Input_p_scndry_des = (TYPEOF(le.Input_p_scndry_des))'','',':p_scndry_des')
    #END
+    #IF( #TEXT(Input_p_city)='' )
      '' 
    #ELSE
        IF( le.Input_p_city = (TYPEOF(le.Input_p_city))'','',':p_city')
    #END
+    #IF( #TEXT(Input_p_state)='' )
      '' 
    #ELSE
        IF( le.Input_p_state = (TYPEOF(le.Input_p_state))'','',':p_state')
    #END
+    #IF( #TEXT(Input_p_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_p_zip5 = (TYPEOF(le.Input_p_zip5))'','',':p_zip5')
    #END
+    #IF( #TEXT(Input_p_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_p_zip4 = (TYPEOF(le.Input_p_zip4))'','',':p_zip4')
    #END
+    #IF( #TEXT(Input_p_cntry_cd)='' )
      '' 
    #ELSE
        IF( le.Input_p_cntry_cd = (TYPEOF(le.Input_p_cntry_cd))'','',':p_cntry_cd')
    #END
+    #IF( #TEXT(Input_p_cc_filler)='' )
      '' 
    #ELSE
        IF( le.Input_p_cc_filler = (TYPEOF(le.Input_p_cc_filler))'','',':p_cc_filler')
    #END
+    #IF( #TEXT(Input_p_cc)='' )
      '' 
    #ELSE
        IF( le.Input_p_cc = (TYPEOF(le.Input_p_cc))'','',':p_cc')
    #END
+    #IF( #TEXT(Input_p_county)='' )
      '' 
    #ELSE
        IF( le.Input_p_county = (TYPEOF(le.Input_p_county))'','',':p_county')
    #END
+    #IF( #TEXT(Input_opt_out_cd)='' )
      '' 
    #ELSE
        IF( le.Input_opt_out_cd = (TYPEOF(le.Input_opt_out_cd))'','',':opt_out_cd')
    #END
+    #IF( #TEXT(Input_asg_wgt)='' )
      '' 
    #ELSE
        IF( le.Input_asg_wgt = (TYPEOF(le.Input_asg_wgt))'','',':asg_wgt')
    #END
+    #IF( #TEXT(Input_asg_wgt_uom)='' )
      '' 
    #ELSE
        IF( le.Input_asg_wgt_uom = (TYPEOF(le.Input_asg_wgt_uom))'','',':asg_wgt_uom')
    #END
+    #IF( #TEXT(Input_source_ctl_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_ctl_id = (TYPEOF(le.Input_source_ctl_id))'','',':source_ctl_id')
    #END
+    #IF( #TEXT(Input_raw_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_name = (TYPEOF(le.Input_raw_name))'','',':raw_name')
    #END
+    #IF( #TEXT(Input_branded_title_flag)='' )
      '' 
    #ELSE
        IF( le.Input_branded_title_flag = (TYPEOF(le.Input_branded_title_flag))'','',':branded_title_flag')
    #END
+    #IF( #TEXT(Input_brand_code_1)='' )
      '' 
    #ELSE
        IF( le.Input_brand_code_1 = (TYPEOF(le.Input_brand_code_1))'','',':brand_code_1')
    #END
+    #IF( #TEXT(Input_brand_date_1)='' )
      '' 
    #ELSE
        IF( le.Input_brand_date_1 = (TYPEOF(le.Input_brand_date_1))'','',':brand_date_1')
    #END
+    #IF( #TEXT(Input_brand_state_1)='' )
      '' 
    #ELSE
        IF( le.Input_brand_state_1 = (TYPEOF(le.Input_brand_state_1))'','',':brand_state_1')
    #END
+    #IF( #TEXT(Input_brand_code_2)='' )
      '' 
    #ELSE
        IF( le.Input_brand_code_2 = (TYPEOF(le.Input_brand_code_2))'','',':brand_code_2')
    #END
+    #IF( #TEXT(Input_brand_date_2)='' )
      '' 
    #ELSE
        IF( le.Input_brand_date_2 = (TYPEOF(le.Input_brand_date_2))'','',':brand_date_2')
    #END
+    #IF( #TEXT(Input_brand_state_2)='' )
      '' 
    #ELSE
        IF( le.Input_brand_state_2 = (TYPEOF(le.Input_brand_state_2))'','',':brand_state_2')
    #END
+    #IF( #TEXT(Input_brand_code_3)='' )
      '' 
    #ELSE
        IF( le.Input_brand_code_3 = (TYPEOF(le.Input_brand_code_3))'','',':brand_code_3')
    #END
+    #IF( #TEXT(Input_brand_date_3)='' )
      '' 
    #ELSE
        IF( le.Input_brand_date_3 = (TYPEOF(le.Input_brand_date_3))'','',':brand_date_3')
    #END
+    #IF( #TEXT(Input_brand_state_3)='' )
      '' 
    #ELSE
        IF( le.Input_brand_state_3 = (TYPEOF(le.Input_brand_state_3))'','',':brand_state_3')
    #END
+    #IF( #TEXT(Input_brand_code_4)='' )
      '' 
    #ELSE
        IF( le.Input_brand_code_4 = (TYPEOF(le.Input_brand_code_4))'','',':brand_code_4')
    #END
+    #IF( #TEXT(Input_brand_date_4)='' )
      '' 
    #ELSE
        IF( le.Input_brand_date_4 = (TYPEOF(le.Input_brand_date_4))'','',':brand_date_4')
    #END
+    #IF( #TEXT(Input_brand_state_4)='' )
      '' 
    #ELSE
        IF( le.Input_brand_state_4 = (TYPEOF(le.Input_brand_state_4))'','',':brand_state_4')
    #END
+    #IF( #TEXT(Input_brand_code_5)='' )
      '' 
    #ELSE
        IF( le.Input_brand_code_5 = (TYPEOF(le.Input_brand_code_5))'','',':brand_code_5')
    #END
+    #IF( #TEXT(Input_brand_date_5)='' )
      '' 
    #ELSE
        IF( le.Input_brand_date_5 = (TYPEOF(le.Input_brand_date_5))'','',':brand_date_5')
    #END
+    #IF( #TEXT(Input_brand_state_5)='' )
      '' 
    #ELSE
        IF( le.Input_brand_state_5 = (TYPEOF(le.Input_brand_state_5))'','',':brand_state_5')
    #END
+    #IF( #TEXT(Input_tod_flag)='' )
      '' 
    #ELSE
        IF( le.Input_tod_flag = (TYPEOF(le.Input_tod_flag))'','',':tod_flag')
    #END
+    #IF( #TEXT(Input_model_class_code)='' )
      '' 
    #ELSE
        IF( le.Input_model_class_code = (TYPEOF(le.Input_model_class_code))'','',':model_class_code')
    #END
+    #IF( #TEXT(Input_model_class)='' )
      '' 
    #ELSE
        IF( le.Input_model_class = (TYPEOF(le.Input_model_class))'','',':model_class')
    #END
+    #IF( #TEXT(Input_min_door_count)='' )
      '' 
    #ELSE
        IF( le.Input_min_door_count = (TYPEOF(le.Input_min_door_count))'','',':min_door_count')
    #END
+    #IF( #TEXT(Input_safety_type)='' )
      '' 
    #ELSE
        IF( le.Input_safety_type = (TYPEOF(le.Input_safety_type))'','',':safety_type')
    #END
+    #IF( #TEXT(Input_airbag_driver)='' )
      '' 
    #ELSE
        IF( le.Input_airbag_driver = (TYPEOF(le.Input_airbag_driver))'','',':airbag_driver')
    #END
+    #IF( #TEXT(Input_airbag_front_driver_side)='' )
      '' 
    #ELSE
        IF( le.Input_airbag_front_driver_side = (TYPEOF(le.Input_airbag_front_driver_side))'','',':airbag_front_driver_side')
    #END
+    #IF( #TEXT(Input_airbag_front_head_curtain)='' )
      '' 
    #ELSE
        IF( le.Input_airbag_front_head_curtain = (TYPEOF(le.Input_airbag_front_head_curtain))'','',':airbag_front_head_curtain')
    #END
+    #IF( #TEXT(Input_airbag_front_pass)='' )
      '' 
    #ELSE
        IF( le.Input_airbag_front_pass = (TYPEOF(le.Input_airbag_front_pass))'','',':airbag_front_pass')
    #END
+    #IF( #TEXT(Input_airbag_front_pass_side)='' )
      '' 
    #ELSE
        IF( le.Input_airbag_front_pass_side = (TYPEOF(le.Input_airbag_front_pass_side))'','',':airbag_front_pass_side')
    #END
+    #IF( #TEXT(Input_airbags)='' )
      '' 
    #ELSE
        IF( le.Input_airbags = (TYPEOF(le.Input_airbags))'','',':airbags')
    #END
;
    #IF (#TEXT(append_state_origin)<>'')
    SELF.source := le.append_state_origin;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(append_state_origin)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(append_state_origin)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(append_state_origin)<>'' ) source, #END -cnt );
ENDMACRO;
