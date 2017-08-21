IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Profile_VehicleV2_Experian)
    UNSIGNED1 append_process_date_Invalid;
    UNSIGNED1 append_state_origin_Invalid;
    UNSIGNED1 file_typ_Invalid;
    UNSIGNED1 vin_Invalid;
    UNSIGNED1 vehicle_typ_Invalid;
    UNSIGNED1 model_yr_Invalid;
    UNSIGNED1 model_yr_ind_Invalid;
    UNSIGNED1 make_Invalid;
    UNSIGNED1 make_ind_Invalid;
    UNSIGNED1 series_Invalid;
    UNSIGNED1 series_ind_Invalid;
    UNSIGNED1 prime_color_Invalid;
    UNSIGNED1 second_color_Invalid;
    UNSIGNED1 body_style_Invalid;
    UNSIGNED1 body_style_ind_Invalid;
    UNSIGNED1 model_Invalid;
    UNSIGNED1 model_ind_Invalid;
    UNSIGNED1 weight_Invalid;
    UNSIGNED1 lengt_Invalid;
    UNSIGNED1 axle_cnt_Invalid;
    UNSIGNED1 plate_nbr_Invalid;
    UNSIGNED1 plate_state_Invalid;
    UNSIGNED1 prev_plate_nbr_Invalid;
    UNSIGNED1 prev_plate_state_Invalid;
    UNSIGNED1 plate_typ_cd_Invalid;
    UNSIGNED1 mstr_src_state_Invalid;
    UNSIGNED1 reg_decal_nbr_Invalid;
    UNSIGNED1 org_reg_dt_Invalid;
    UNSIGNED1 reg_renew_dt_Invalid;
    UNSIGNED1 reg_exp_dt_Invalid;
    UNSIGNED1 title_nbr_Invalid;
    UNSIGNED1 org_title_dt_Invalid;
    UNSIGNED1 title_trans_dt_Invalid;
    UNSIGNED1 name_typ_cd_Invalid;
    UNSIGNED1 owner_typ_cd_Invalid;
    UNSIGNED1 first_nm_Invalid;
    UNSIGNED1 middle_nm_Invalid;
    UNSIGNED1 last_nm_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 prof_suffix_Invalid;
    UNSIGNED1 ind_ssn_Invalid;
    UNSIGNED1 ind_dob_Invalid;
    UNSIGNED1 mail_range_Invalid;
    UNSIGNED1 m_pre_dir_Invalid;
    UNSIGNED1 m_street_Invalid;
    UNSIGNED1 m_suffix_Invalid;
    UNSIGNED1 m_post_dir_Invalid;
    UNSIGNED1 m_pob_Invalid;
    UNSIGNED1 m_rr_nbr_Invalid;
    UNSIGNED1 m_rr_box_Invalid;
    UNSIGNED1 m_scndry_rng_Invalid;
    UNSIGNED1 m_scndry_des_Invalid;
    UNSIGNED1 m_city_Invalid;
    UNSIGNED1 m_state_Invalid;
    UNSIGNED1 m_zip5_Invalid;
    UNSIGNED1 m_zip4_Invalid;
    UNSIGNED1 m_cc_Invalid;
    UNSIGNED1 m_county_Invalid;
    UNSIGNED1 phys_range_Invalid;
    UNSIGNED1 p_pre_dir_Invalid;
    UNSIGNED1 p_street_Invalid;
    UNSIGNED1 p_suffix_Invalid;
    UNSIGNED1 p_post_dir_Invalid;
    UNSIGNED1 p_pob_Invalid;
    UNSIGNED1 p_rr_nbr_Invalid;
    UNSIGNED1 p_rr_box_Invalid;
    UNSIGNED1 p_scndry_rng_Invalid;
    UNSIGNED1 p_scndry_des_Invalid;
    UNSIGNED1 p_city_Invalid;
    UNSIGNED1 p_state_Invalid;
    UNSIGNED1 p_zip5_Invalid;
    UNSIGNED1 p_zip4_Invalid;
    UNSIGNED1 p_cc_Invalid;
    UNSIGNED1 p_county_Invalid;
    UNSIGNED1 opt_out_cd_Invalid;
    UNSIGNED1 asg_wgt_Invalid;
    UNSIGNED1 asg_wgt_uom_Invalid;
    UNSIGNED1 source_ctl_id_Invalid;
    UNSIGNED1 raw_name_Invalid;
    UNSIGNED1 branded_title_flag_Invalid;
    UNSIGNED1 brand_code_1_Invalid;
    UNSIGNED1 brand_date_1_Invalid;
    UNSIGNED1 brand_state_1_Invalid;
    UNSIGNED1 brand_code_2_Invalid;
    UNSIGNED1 brand_date_2_Invalid;
    UNSIGNED1 brand_state_2_Invalid;
    UNSIGNED1 brand_code_3_Invalid;
    UNSIGNED1 brand_date_3_Invalid;
    UNSIGNED1 brand_state_3_Invalid;
    UNSIGNED1 brand_code_4_Invalid;
    UNSIGNED1 brand_date_4_Invalid;
    UNSIGNED1 brand_state_4_Invalid;
    UNSIGNED1 brand_code_5_Invalid;
    UNSIGNED1 brand_date_5_Invalid;
    UNSIGNED1 brand_state_5_Invalid;
    UNSIGNED1 tod_flag_Invalid;
    UNSIGNED1 model_class_Invalid;
    UNSIGNED1 min_door_count_Invalid;
    UNSIGNED1 safety_type_Invalid;
    UNSIGNED1 airbag_driver_Invalid;
    UNSIGNED1 airbag_front_driver_side_Invalid;
    UNSIGNED1 airbag_front_head_curtain_Invalid;
    UNSIGNED1 airbag_front_pass_Invalid;
    UNSIGNED1 airbag_front_pass_side_Invalid;
    UNSIGNED1 airbags_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Profile_VehicleV2_Experian)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
  END;
EXPORT FromNone(DATASET(Layout_Profile_VehicleV2_Experian) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_process_date_Invalid := Fields.InValid_append_process_date((SALT30.StrType)le.append_process_date);
    SELF.append_state_origin_Invalid := Fields.InValid_append_state_origin((SALT30.StrType)le.append_state_origin);
    SELF.file_typ_Invalid := Fields.InValid_file_typ((SALT30.StrType)le.file_typ);
    SELF.vin_Invalid := Fields.InValid_vin((SALT30.StrType)le.vin);
    SELF.vehicle_typ_Invalid := Fields.InValid_vehicle_typ((SALT30.StrType)le.vehicle_typ);
    SELF.model_yr_Invalid := Fields.InValid_model_yr((SALT30.StrType)le.model_yr);
    SELF.model_yr_ind_Invalid := Fields.InValid_model_yr_ind((SALT30.StrType)le.model_yr_ind);
    SELF.make_Invalid := Fields.InValid_make((SALT30.StrType)le.make);
    SELF.make_ind_Invalid := Fields.InValid_make_ind((SALT30.StrType)le.make_ind);
    SELF.series_Invalid := Fields.InValid_series((SALT30.StrType)le.series);
    SELF.series_ind_Invalid := Fields.InValid_series_ind((SALT30.StrType)le.series_ind);
    SELF.prime_color_Invalid := Fields.InValid_prime_color((SALT30.StrType)le.prime_color);
    SELF.second_color_Invalid := Fields.InValid_second_color((SALT30.StrType)le.second_color);
    SELF.body_style_Invalid := Fields.InValid_body_style((SALT30.StrType)le.body_style);
    SELF.body_style_ind_Invalid := Fields.InValid_body_style_ind((SALT30.StrType)le.body_style_ind);
    SELF.model_Invalid := Fields.InValid_model((SALT30.StrType)le.model);
    SELF.model_ind_Invalid := Fields.InValid_model_ind((SALT30.StrType)le.model_ind);
    SELF.weight_Invalid := Fields.InValid_weight((SALT30.StrType)le.weight);
    SELF.lengt_Invalid := Fields.InValid_lengt((SALT30.StrType)le.lengt);
    SELF.axle_cnt_Invalid := Fields.InValid_axle_cnt((SALT30.StrType)le.axle_cnt);
    SELF.plate_nbr_Invalid := Fields.InValid_plate_nbr((SALT30.StrType)le.plate_nbr);
    SELF.plate_state_Invalid := Fields.InValid_plate_state((SALT30.StrType)le.plate_state);
    SELF.prev_plate_nbr_Invalid := Fields.InValid_prev_plate_nbr((SALT30.StrType)le.prev_plate_nbr);
    SELF.prev_plate_state_Invalid := Fields.InValid_prev_plate_state((SALT30.StrType)le.prev_plate_state);
    SELF.plate_typ_cd_Invalid := Fields.InValid_plate_typ_cd((SALT30.StrType)le.plate_typ_cd);
    SELF.mstr_src_state_Invalid := Fields.InValid_mstr_src_state((SALT30.StrType)le.mstr_src_state);
    SELF.reg_decal_nbr_Invalid := Fields.InValid_reg_decal_nbr((SALT30.StrType)le.reg_decal_nbr);
    SELF.org_reg_dt_Invalid := Fields.InValid_org_reg_dt((SALT30.StrType)le.org_reg_dt);
    SELF.reg_renew_dt_Invalid := Fields.InValid_reg_renew_dt((SALT30.StrType)le.reg_renew_dt);
    SELF.reg_exp_dt_Invalid := Fields.InValid_reg_exp_dt((SALT30.StrType)le.reg_exp_dt);
    SELF.title_nbr_Invalid := Fields.InValid_title_nbr((SALT30.StrType)le.title_nbr);
    SELF.org_title_dt_Invalid := Fields.InValid_org_title_dt((SALT30.StrType)le.org_title_dt);
    SELF.title_trans_dt_Invalid := Fields.InValid_title_trans_dt((SALT30.StrType)le.title_trans_dt);
    SELF.name_typ_cd_Invalid := Fields.InValid_name_typ_cd((SALT30.StrType)le.name_typ_cd);
    SELF.owner_typ_cd_Invalid := Fields.InValid_owner_typ_cd((SALT30.StrType)le.owner_typ_cd);
    SELF.first_nm_Invalid := Fields.InValid_first_nm((SALT30.StrType)le.first_nm);
    SELF.middle_nm_Invalid := Fields.InValid_middle_nm((SALT30.StrType)le.middle_nm);
    SELF.last_nm_Invalid := Fields.InValid_last_nm((SALT30.StrType)le.last_nm);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix);
    SELF.prof_suffix_Invalid := Fields.InValid_prof_suffix((SALT30.StrType)le.prof_suffix);
    SELF.ind_ssn_Invalid := Fields.InValid_ind_ssn((SALT30.StrType)le.ind_ssn);
    SELF.ind_dob_Invalid := Fields.InValid_ind_dob((SALT30.StrType)le.ind_dob);
    SELF.mail_range_Invalid := Fields.InValid_mail_range((SALT30.StrType)le.mail_range);
    SELF.m_pre_dir_Invalid := Fields.InValid_m_pre_dir((SALT30.StrType)le.m_pre_dir);
    SELF.m_street_Invalid := Fields.InValid_m_street((SALT30.StrType)le.m_street);
    SELF.m_suffix_Invalid := Fields.InValid_m_suffix((SALT30.StrType)le.m_suffix);
    SELF.m_post_dir_Invalid := Fields.InValid_m_post_dir((SALT30.StrType)le.m_post_dir);
    SELF.m_pob_Invalid := Fields.InValid_m_pob((SALT30.StrType)le.m_pob);
    SELF.m_rr_nbr_Invalid := Fields.InValid_m_rr_nbr((SALT30.StrType)le.m_rr_nbr);
    SELF.m_rr_box_Invalid := Fields.InValid_m_rr_box((SALT30.StrType)le.m_rr_box);
    SELF.m_scndry_rng_Invalid := Fields.InValid_m_scndry_rng((SALT30.StrType)le.m_scndry_rng);
    SELF.m_scndry_des_Invalid := Fields.InValid_m_scndry_des((SALT30.StrType)le.m_scndry_des);
    SELF.m_city_Invalid := Fields.InValid_m_city((SALT30.StrType)le.m_city);
    SELF.m_state_Invalid := Fields.InValid_m_state((SALT30.StrType)le.m_state);
    SELF.m_zip5_Invalid := Fields.InValid_m_zip5((SALT30.StrType)le.m_zip5);
    SELF.m_zip4_Invalid := Fields.InValid_m_zip4((SALT30.StrType)le.m_zip4);
    SELF.m_cc_Invalid := Fields.InValid_m_cc((SALT30.StrType)le.m_cc);
    SELF.m_county_Invalid := Fields.InValid_m_county((SALT30.StrType)le.m_county);
    SELF.phys_range_Invalid := Fields.InValid_phys_range((SALT30.StrType)le.phys_range);
    SELF.p_pre_dir_Invalid := Fields.InValid_p_pre_dir((SALT30.StrType)le.p_pre_dir);
    SELF.p_street_Invalid := Fields.InValid_p_street((SALT30.StrType)le.p_street);
    SELF.p_suffix_Invalid := Fields.InValid_p_suffix((SALT30.StrType)le.p_suffix);
    SELF.p_post_dir_Invalid := Fields.InValid_p_post_dir((SALT30.StrType)le.p_post_dir);
    SELF.p_pob_Invalid := Fields.InValid_p_pob((SALT30.StrType)le.p_pob);
    SELF.p_rr_nbr_Invalid := Fields.InValid_p_rr_nbr((SALT30.StrType)le.p_rr_nbr);
    SELF.p_rr_box_Invalid := Fields.InValid_p_rr_box((SALT30.StrType)le.p_rr_box);
    SELF.p_scndry_rng_Invalid := Fields.InValid_p_scndry_rng((SALT30.StrType)le.p_scndry_rng);
    SELF.p_scndry_des_Invalid := Fields.InValid_p_scndry_des((SALT30.StrType)le.p_scndry_des);
    SELF.p_city_Invalid := Fields.InValid_p_city((SALT30.StrType)le.p_city);
    SELF.p_state_Invalid := Fields.InValid_p_state((SALT30.StrType)le.p_state);
    SELF.p_zip5_Invalid := Fields.InValid_p_zip5((SALT30.StrType)le.p_zip5);
    SELF.p_zip4_Invalid := Fields.InValid_p_zip4((SALT30.StrType)le.p_zip4);
    SELF.p_cc_Invalid := Fields.InValid_p_cc((SALT30.StrType)le.p_cc);
    SELF.p_county_Invalid := Fields.InValid_p_county((SALT30.StrType)le.p_county);
    SELF.opt_out_cd_Invalid := Fields.InValid_opt_out_cd((SALT30.StrType)le.opt_out_cd);
    SELF.asg_wgt_Invalid := Fields.InValid_asg_wgt((SALT30.StrType)le.asg_wgt);
    SELF.asg_wgt_uom_Invalid := Fields.InValid_asg_wgt_uom((SALT30.StrType)le.asg_wgt_uom);
    SELF.source_ctl_id_Invalid := Fields.InValid_source_ctl_id((SALT30.StrType)le.source_ctl_id);
    SELF.raw_name_Invalid := Fields.InValid_raw_name((SALT30.StrType)le.raw_name);
    SELF.branded_title_flag_Invalid := Fields.InValid_branded_title_flag((SALT30.StrType)le.branded_title_flag);
    SELF.brand_code_1_Invalid := Fields.InValid_brand_code_1((SALT30.StrType)le.brand_code_1);
    SELF.brand_date_1_Invalid := Fields.InValid_brand_date_1((SALT30.StrType)le.brand_date_1);
    SELF.brand_state_1_Invalid := Fields.InValid_brand_state_1((SALT30.StrType)le.brand_state_1);
    SELF.brand_code_2_Invalid := Fields.InValid_brand_code_2((SALT30.StrType)le.brand_code_2);
    SELF.brand_date_2_Invalid := Fields.InValid_brand_date_2((SALT30.StrType)le.brand_date_2);
    SELF.brand_state_2_Invalid := Fields.InValid_brand_state_2((SALT30.StrType)le.brand_state_2);
    SELF.brand_code_3_Invalid := Fields.InValid_brand_code_3((SALT30.StrType)le.brand_code_3);
    SELF.brand_date_3_Invalid := Fields.InValid_brand_date_3((SALT30.StrType)le.brand_date_3);
    SELF.brand_state_3_Invalid := Fields.InValid_brand_state_3((SALT30.StrType)le.brand_state_3);
    SELF.brand_code_4_Invalid := Fields.InValid_brand_code_4((SALT30.StrType)le.brand_code_4);
    SELF.brand_date_4_Invalid := Fields.InValid_brand_date_4((SALT30.StrType)le.brand_date_4);
    SELF.brand_state_4_Invalid := Fields.InValid_brand_state_4((SALT30.StrType)le.brand_state_4);
    SELF.brand_code_5_Invalid := Fields.InValid_brand_code_5((SALT30.StrType)le.brand_code_5);
    SELF.brand_date_5_Invalid := Fields.InValid_brand_date_5((SALT30.StrType)le.brand_date_5);
    SELF.brand_state_5_Invalid := Fields.InValid_brand_state_5((SALT30.StrType)le.brand_state_5);
    SELF.tod_flag_Invalid := Fields.InValid_tod_flag((SALT30.StrType)le.tod_flag);
    SELF.model_class_Invalid := Fields.InValid_model_class((SALT30.StrType)le.model_class);
    SELF.min_door_count_Invalid := Fields.InValid_min_door_count((SALT30.StrType)le.min_door_count);
    SELF.safety_type_Invalid := Fields.InValid_safety_type((SALT30.StrType)le.safety_type);
    SELF.airbag_driver_Invalid := Fields.InValid_airbag_driver((SALT30.StrType)le.airbag_driver);
    SELF.airbag_front_driver_side_Invalid := Fields.InValid_airbag_front_driver_side((SALT30.StrType)le.airbag_front_driver_side);
    SELF.airbag_front_head_curtain_Invalid := Fields.InValid_airbag_front_head_curtain((SALT30.StrType)le.airbag_front_head_curtain);
    SELF.airbag_front_pass_Invalid := Fields.InValid_airbag_front_pass((SALT30.StrType)le.airbag_front_pass);
    SELF.airbag_front_pass_side_Invalid := Fields.InValid_airbag_front_pass_side((SALT30.StrType)le.airbag_front_pass_side);
    SELF.airbags_Invalid := Fields.InValid_airbags((SALT30.StrType)le.airbags);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.append_process_date_Invalid << 0 ) + ( le.append_state_origin_Invalid << 2 ) + ( le.file_typ_Invalid << 4 ) + ( le.vin_Invalid << 6 ) + ( le.vehicle_typ_Invalid << 8 ) + ( le.model_yr_Invalid << 10 ) + ( le.model_yr_ind_Invalid << 12 ) + ( le.make_Invalid << 14 ) + ( le.make_ind_Invalid << 16 ) + ( le.series_Invalid << 18 ) + ( le.series_ind_Invalid << 20 ) + ( le.prime_color_Invalid << 22 ) + ( le.second_color_Invalid << 24 ) + ( le.body_style_Invalid << 26 ) + ( le.body_style_ind_Invalid << 28 ) + ( le.model_Invalid << 30 ) + ( le.model_ind_Invalid << 32 ) + ( le.weight_Invalid << 34 ) + ( le.lengt_Invalid << 35 ) + ( le.axle_cnt_Invalid << 36 ) + ( le.plate_nbr_Invalid << 37 ) + ( le.plate_state_Invalid << 39 ) + ( le.prev_plate_nbr_Invalid << 41 ) + ( le.prev_plate_state_Invalid << 43 ) + ( le.plate_typ_cd_Invalid << 45 ) + ( le.mstr_src_state_Invalid << 47 ) + ( le.reg_decal_nbr_Invalid << 49 ) + ( le.org_reg_dt_Invalid << 51 ) + ( le.reg_renew_dt_Invalid << 53 ) + ( le.reg_exp_dt_Invalid << 55 ) + ( le.title_nbr_Invalid << 57 ) + ( le.org_title_dt_Invalid << 59 ) + ( le.title_trans_dt_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.name_typ_cd_Invalid << 0 ) + ( le.owner_typ_cd_Invalid << 2 ) + ( le.first_nm_Invalid << 4 ) + ( le.middle_nm_Invalid << 6 ) + ( le.last_nm_Invalid << 8 ) + ( le.name_suffix_Invalid << 10 ) + ( le.prof_suffix_Invalid << 12 ) + ( le.ind_ssn_Invalid << 14 ) + ( le.ind_dob_Invalid << 16 ) + ( le.mail_range_Invalid << 18 ) + ( le.m_pre_dir_Invalid << 20 ) + ( le.m_street_Invalid << 22 ) + ( le.m_suffix_Invalid << 24 ) + ( le.m_post_dir_Invalid << 26 ) + ( le.m_pob_Invalid << 28 ) + ( le.m_rr_nbr_Invalid << 30 ) + ( le.m_rr_box_Invalid << 32 ) + ( le.m_scndry_rng_Invalid << 34 ) + ( le.m_scndry_des_Invalid << 36 ) + ( le.m_city_Invalid << 38 ) + ( le.m_state_Invalid << 40 ) + ( le.m_zip5_Invalid << 42 ) + ( le.m_zip4_Invalid << 44 ) + ( le.m_cc_Invalid << 46 ) + ( le.m_county_Invalid << 48 ) + ( le.phys_range_Invalid << 50 ) + ( le.p_pre_dir_Invalid << 52 ) + ( le.p_street_Invalid << 54 ) + ( le.p_suffix_Invalid << 56 ) + ( le.p_post_dir_Invalid << 58 ) + ( le.p_pob_Invalid << 60 ) + ( le.p_rr_nbr_Invalid << 62 );
    SELF.ScrubsBits3 := ( le.p_rr_box_Invalid << 0 ) + ( le.p_scndry_rng_Invalid << 2 ) + ( le.p_scndry_des_Invalid << 4 ) + ( le.p_city_Invalid << 6 ) + ( le.p_state_Invalid << 8 ) + ( le.p_zip5_Invalid << 10 ) + ( le.p_zip4_Invalid << 12 ) + ( le.p_cc_Invalid << 14 ) + ( le.p_county_Invalid << 16 ) + ( le.opt_out_cd_Invalid << 18 ) + ( le.asg_wgt_Invalid << 20 ) + ( le.asg_wgt_uom_Invalid << 21 ) + ( le.source_ctl_id_Invalid << 23 ) + ( le.raw_name_Invalid << 24 ) + ( le.branded_title_flag_Invalid << 26 ) + ( le.brand_code_1_Invalid << 28 ) + ( le.brand_date_1_Invalid << 30 ) + ( le.brand_state_1_Invalid << 32 ) + ( le.brand_code_2_Invalid << 34 ) + ( le.brand_date_2_Invalid << 36 ) + ( le.brand_state_2_Invalid << 38 ) + ( le.brand_code_3_Invalid << 40 ) + ( le.brand_date_3_Invalid << 42 ) + ( le.brand_state_3_Invalid << 44 ) + ( le.brand_code_4_Invalid << 46 ) + ( le.brand_date_4_Invalid << 48 ) + ( le.brand_state_4_Invalid << 50 ) + ( le.brand_code_5_Invalid << 52 ) + ( le.brand_date_5_Invalid << 54 ) + ( le.brand_state_5_Invalid << 56 ) + ( le.tod_flag_Invalid << 58 ) + ( le.model_class_Invalid << 60 ) + ( le.min_door_count_Invalid << 62 );
    SELF.ScrubsBits4 := ( le.safety_type_Invalid << 0 ) + ( le.airbag_driver_Invalid << 2 ) + ( le.airbag_front_driver_side_Invalid << 4 ) + ( le.airbag_front_head_curtain_Invalid << 6 ) + ( le.airbag_front_pass_Invalid << 8 ) + ( le.airbag_front_pass_side_Invalid << 10 ) + ( le.airbags_Invalid << 12 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Profile_VehicleV2_Experian);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.append_state_origin_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.file_typ_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.vin_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.vehicle_typ_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.model_yr_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.model_yr_ind_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.make_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.make_ind_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.series_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.series_ind_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.prime_color_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.second_color_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.body_style_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.body_style_ind_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.model_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.model_ind_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.weight_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.lengt_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.axle_cnt_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.plate_nbr_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.plate_state_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.prev_plate_nbr_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.prev_plate_state_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.plate_typ_cd_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.mstr_src_state_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.reg_decal_nbr_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.org_reg_dt_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.reg_renew_dt_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.reg_exp_dt_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.title_nbr_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.org_title_dt_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.title_trans_dt_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.name_typ_cd_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.owner_typ_cd_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.first_nm_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.middle_nm_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.last_nm_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.prof_suffix_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.ind_ssn_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.ind_dob_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.mail_range_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.m_pre_dir_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.m_street_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.m_suffix_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.m_post_dir_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.m_pob_Invalid := (le.ScrubsBits2 >> 28) & 3;
    SELF.m_rr_nbr_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.m_rr_box_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.m_scndry_rng_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.m_scndry_des_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.m_city_Invalid := (le.ScrubsBits2 >> 38) & 3;
    SELF.m_state_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.m_zip5_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.m_zip4_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.m_cc_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.m_county_Invalid := (le.ScrubsBits2 >> 48) & 3;
    SELF.phys_range_Invalid := (le.ScrubsBits2 >> 50) & 3;
    SELF.p_pre_dir_Invalid := (le.ScrubsBits2 >> 52) & 3;
    SELF.p_street_Invalid := (le.ScrubsBits2 >> 54) & 3;
    SELF.p_suffix_Invalid := (le.ScrubsBits2 >> 56) & 3;
    SELF.p_post_dir_Invalid := (le.ScrubsBits2 >> 58) & 3;
    SELF.p_pob_Invalid := (le.ScrubsBits2 >> 60) & 3;
    SELF.p_rr_nbr_Invalid := (le.ScrubsBits2 >> 62) & 3;
    SELF.p_rr_box_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.p_scndry_rng_Invalid := (le.ScrubsBits3 >> 2) & 3;
    SELF.p_scndry_des_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.p_city_Invalid := (le.ScrubsBits3 >> 6) & 3;
    SELF.p_state_Invalid := (le.ScrubsBits3 >> 8) & 3;
    SELF.p_zip5_Invalid := (le.ScrubsBits3 >> 10) & 3;
    SELF.p_zip4_Invalid := (le.ScrubsBits3 >> 12) & 3;
    SELF.p_cc_Invalid := (le.ScrubsBits3 >> 14) & 3;
    SELF.p_county_Invalid := (le.ScrubsBits3 >> 16) & 3;
    SELF.opt_out_cd_Invalid := (le.ScrubsBits3 >> 18) & 3;
    SELF.asg_wgt_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.asg_wgt_uom_Invalid := (le.ScrubsBits3 >> 21) & 3;
    SELF.source_ctl_id_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.raw_name_Invalid := (le.ScrubsBits3 >> 24) & 3;
    SELF.branded_title_flag_Invalid := (le.ScrubsBits3 >> 26) & 3;
    SELF.brand_code_1_Invalid := (le.ScrubsBits3 >> 28) & 3;
    SELF.brand_date_1_Invalid := (le.ScrubsBits3 >> 30) & 3;
    SELF.brand_state_1_Invalid := (le.ScrubsBits3 >> 32) & 3;
    SELF.brand_code_2_Invalid := (le.ScrubsBits3 >> 34) & 3;
    SELF.brand_date_2_Invalid := (le.ScrubsBits3 >> 36) & 3;
    SELF.brand_state_2_Invalid := (le.ScrubsBits3 >> 38) & 3;
    SELF.brand_code_3_Invalid := (le.ScrubsBits3 >> 40) & 3;
    SELF.brand_date_3_Invalid := (le.ScrubsBits3 >> 42) & 3;
    SELF.brand_state_3_Invalid := (le.ScrubsBits3 >> 44) & 3;
    SELF.brand_code_4_Invalid := (le.ScrubsBits3 >> 46) & 3;
    SELF.brand_date_4_Invalid := (le.ScrubsBits3 >> 48) & 3;
    SELF.brand_state_4_Invalid := (le.ScrubsBits3 >> 50) & 3;
    SELF.brand_code_5_Invalid := (le.ScrubsBits3 >> 52) & 3;
    SELF.brand_date_5_Invalid := (le.ScrubsBits3 >> 54) & 3;
    SELF.brand_state_5_Invalid := (le.ScrubsBits3 >> 56) & 3;
    SELF.tod_flag_Invalid := (le.ScrubsBits3 >> 58) & 3;
    SELF.model_class_Invalid := (le.ScrubsBits3 >> 60) & 3;
    SELF.min_door_count_Invalid := (le.ScrubsBits3 >> 62) & 3;
    SELF.safety_type_Invalid := (le.ScrubsBits4 >> 0) & 3;
    SELF.airbag_driver_Invalid := (le.ScrubsBits4 >> 2) & 3;
    SELF.airbag_front_driver_side_Invalid := (le.ScrubsBits4 >> 4) & 3;
    SELF.airbag_front_head_curtain_Invalid := (le.ScrubsBits4 >> 6) & 3;
    SELF.airbag_front_pass_Invalid := (le.ScrubsBits4 >> 8) & 3;
    SELF.airbag_front_pass_side_Invalid := (le.ScrubsBits4 >> 10) & 3;
    SELF.airbags_Invalid := (le.ScrubsBits4 >> 12) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.append_state_origin;
    TotalCnt := COUNT(GROUP); // Number of records in total
    append_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=1);
    append_process_date_LENGTH_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=2);
    append_process_date_Total_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid>0);
    append_state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.append_state_origin_Invalid=1);
    append_state_origin_LENGTH_ErrorCount := COUNT(GROUP,h.append_state_origin_Invalid=2);
    append_state_origin_Total_ErrorCount := COUNT(GROUP,h.append_state_origin_Invalid>0);
    file_typ_ENUM_ErrorCount := COUNT(GROUP,h.file_typ_Invalid=1);
    file_typ_LENGTH_ErrorCount := COUNT(GROUP,h.file_typ_Invalid=2);
    file_typ_Total_ErrorCount := COUNT(GROUP,h.file_typ_Invalid>0);
    vin_CAPS_ErrorCount := COUNT(GROUP,h.vin_Invalid=1);
    vin_ALLOW_ErrorCount := COUNT(GROUP,h.vin_Invalid=2);
    vin_LENGTH_ErrorCount := COUNT(GROUP,h.vin_Invalid=3);
    vin_Total_ErrorCount := COUNT(GROUP,h.vin_Invalid>0);
    vehicle_typ_ENUM_ErrorCount := COUNT(GROUP,h.vehicle_typ_Invalid=1);
    vehicle_typ_LENGTH_ErrorCount := COUNT(GROUP,h.vehicle_typ_Invalid=2);
    vehicle_typ_Total_ErrorCount := COUNT(GROUP,h.vehicle_typ_Invalid>0);
    model_yr_ALLOW_ErrorCount := COUNT(GROUP,h.model_yr_Invalid=1);
    model_yr_LENGTH_ErrorCount := COUNT(GROUP,h.model_yr_Invalid=2);
    model_yr_Total_ErrorCount := COUNT(GROUP,h.model_yr_Invalid>0);
    model_yr_ind_ENUM_ErrorCount := COUNT(GROUP,h.model_yr_ind_Invalid=1);
    model_yr_ind_LENGTH_ErrorCount := COUNT(GROUP,h.model_yr_ind_Invalid=2);
    model_yr_ind_Total_ErrorCount := COUNT(GROUP,h.model_yr_ind_Invalid>0);
    make_CAPS_ErrorCount := COUNT(GROUP,h.make_Invalid=1);
    make_ALLOW_ErrorCount := COUNT(GROUP,h.make_Invalid=2);
    make_Total_ErrorCount := COUNT(GROUP,h.make_Invalid>0);
    make_ind_ENUM_ErrorCount := COUNT(GROUP,h.make_ind_Invalid=1);
    make_ind_LENGTH_ErrorCount := COUNT(GROUP,h.make_ind_Invalid=2);
    make_ind_Total_ErrorCount := COUNT(GROUP,h.make_ind_Invalid>0);
    series_CAPS_ErrorCount := COUNT(GROUP,h.series_Invalid=1);
    series_ALLOW_ErrorCount := COUNT(GROUP,h.series_Invalid=2);
    series_Total_ErrorCount := COUNT(GROUP,h.series_Invalid>0);
    series_ind_ENUM_ErrorCount := COUNT(GROUP,h.series_ind_Invalid=1);
    series_ind_LENGTH_ErrorCount := COUNT(GROUP,h.series_ind_Invalid=2);
    series_ind_Total_ErrorCount := COUNT(GROUP,h.series_ind_Invalid>0);
    prime_color_CAPS_ErrorCount := COUNT(GROUP,h.prime_color_Invalid=1);
    prime_color_ALLOW_ErrorCount := COUNT(GROUP,h.prime_color_Invalid=2);
    prime_color_Total_ErrorCount := COUNT(GROUP,h.prime_color_Invalid>0);
    second_color_CAPS_ErrorCount := COUNT(GROUP,h.second_color_Invalid=1);
    second_color_ALLOW_ErrorCount := COUNT(GROUP,h.second_color_Invalid=2);
    second_color_Total_ErrorCount := COUNT(GROUP,h.second_color_Invalid>0);
    body_style_CAPS_ErrorCount := COUNT(GROUP,h.body_style_Invalid=1);
    body_style_ALLOW_ErrorCount := COUNT(GROUP,h.body_style_Invalid=2);
    body_style_Total_ErrorCount := COUNT(GROUP,h.body_style_Invalid>0);
    body_style_ind_ENUM_ErrorCount := COUNT(GROUP,h.body_style_ind_Invalid=1);
    body_style_ind_LENGTH_ErrorCount := COUNT(GROUP,h.body_style_ind_Invalid=2);
    body_style_ind_Total_ErrorCount := COUNT(GROUP,h.body_style_ind_Invalid>0);
    model_CAPS_ErrorCount := COUNT(GROUP,h.model_Invalid=1);
    model_ALLOW_ErrorCount := COUNT(GROUP,h.model_Invalid=2);
    model_Total_ErrorCount := COUNT(GROUP,h.model_Invalid>0);
    model_ind_ENUM_ErrorCount := COUNT(GROUP,h.model_ind_Invalid=1);
    model_ind_LENGTH_ErrorCount := COUNT(GROUP,h.model_ind_Invalid=2);
    model_ind_Total_ErrorCount := COUNT(GROUP,h.model_ind_Invalid>0);
    weight_ALLOW_ErrorCount := COUNT(GROUP,h.weight_Invalid=1);
    lengt_ALLOW_ErrorCount := COUNT(GROUP,h.lengt_Invalid=1);
    axle_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.axle_cnt_Invalid=1);
    plate_nbr_CAPS_ErrorCount := COUNT(GROUP,h.plate_nbr_Invalid=1);
    plate_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.plate_nbr_Invalid=2);
    plate_nbr_Total_ErrorCount := COUNT(GROUP,h.plate_nbr_Invalid>0);
    plate_state_ALLOW_ErrorCount := COUNT(GROUP,h.plate_state_Invalid=1);
    plate_state_LENGTH_ErrorCount := COUNT(GROUP,h.plate_state_Invalid=2);
    plate_state_Total_ErrorCount := COUNT(GROUP,h.plate_state_Invalid>0);
    prev_plate_nbr_CAPS_ErrorCount := COUNT(GROUP,h.prev_plate_nbr_Invalid=1);
    prev_plate_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.prev_plate_nbr_Invalid=2);
    prev_plate_nbr_Total_ErrorCount := COUNT(GROUP,h.prev_plate_nbr_Invalid>0);
    prev_plate_state_ALLOW_ErrorCount := COUNT(GROUP,h.prev_plate_state_Invalid=1);
    prev_plate_state_LENGTH_ErrorCount := COUNT(GROUP,h.prev_plate_state_Invalid=2);
    prev_plate_state_Total_ErrorCount := COUNT(GROUP,h.prev_plate_state_Invalid>0);
    plate_typ_cd_CAPS_ErrorCount := COUNT(GROUP,h.plate_typ_cd_Invalid=1);
    plate_typ_cd_ALLOW_ErrorCount := COUNT(GROUP,h.plate_typ_cd_Invalid=2);
    plate_typ_cd_Total_ErrorCount := COUNT(GROUP,h.plate_typ_cd_Invalid>0);
    mstr_src_state_ALLOW_ErrorCount := COUNT(GROUP,h.mstr_src_state_Invalid=1);
    mstr_src_state_LENGTH_ErrorCount := COUNT(GROUP,h.mstr_src_state_Invalid=2);
    mstr_src_state_Total_ErrorCount := COUNT(GROUP,h.mstr_src_state_Invalid>0);
    reg_decal_nbr_CAPS_ErrorCount := COUNT(GROUP,h.reg_decal_nbr_Invalid=1);
    reg_decal_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.reg_decal_nbr_Invalid=2);
    reg_decal_nbr_Total_ErrorCount := COUNT(GROUP,h.reg_decal_nbr_Invalid>0);
    org_reg_dt_ALLOW_ErrorCount := COUNT(GROUP,h.org_reg_dt_Invalid=1);
    org_reg_dt_LENGTH_ErrorCount := COUNT(GROUP,h.org_reg_dt_Invalid=2);
    org_reg_dt_Total_ErrorCount := COUNT(GROUP,h.org_reg_dt_Invalid>0);
    reg_renew_dt_ALLOW_ErrorCount := COUNT(GROUP,h.reg_renew_dt_Invalid=1);
    reg_renew_dt_LENGTH_ErrorCount := COUNT(GROUP,h.reg_renew_dt_Invalid=2);
    reg_renew_dt_Total_ErrorCount := COUNT(GROUP,h.reg_renew_dt_Invalid>0);
    reg_exp_dt_ALLOW_ErrorCount := COUNT(GROUP,h.reg_exp_dt_Invalid=1);
    reg_exp_dt_LENGTH_ErrorCount := COUNT(GROUP,h.reg_exp_dt_Invalid=2);
    reg_exp_dt_Total_ErrorCount := COUNT(GROUP,h.reg_exp_dt_Invalid>0);
    title_nbr_CAPS_ErrorCount := COUNT(GROUP,h.title_nbr_Invalid=1);
    title_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.title_nbr_Invalid=2);
    title_nbr_Total_ErrorCount := COUNT(GROUP,h.title_nbr_Invalid>0);
    org_title_dt_ALLOW_ErrorCount := COUNT(GROUP,h.org_title_dt_Invalid=1);
    org_title_dt_LENGTH_ErrorCount := COUNT(GROUP,h.org_title_dt_Invalid=2);
    org_title_dt_Total_ErrorCount := COUNT(GROUP,h.org_title_dt_Invalid>0);
    title_trans_dt_ALLOW_ErrorCount := COUNT(GROUP,h.title_trans_dt_Invalid=1);
    title_trans_dt_LENGTH_ErrorCount := COUNT(GROUP,h.title_trans_dt_Invalid=2);
    title_trans_dt_Total_ErrorCount := COUNT(GROUP,h.title_trans_dt_Invalid>0);
    name_typ_cd_ENUM_ErrorCount := COUNT(GROUP,h.name_typ_cd_Invalid=1);
    name_typ_cd_LENGTH_ErrorCount := COUNT(GROUP,h.name_typ_cd_Invalid=2);
    name_typ_cd_Total_ErrorCount := COUNT(GROUP,h.name_typ_cd_Invalid>0);
    owner_typ_cd_ENUM_ErrorCount := COUNT(GROUP,h.owner_typ_cd_Invalid=1);
    owner_typ_cd_LENGTH_ErrorCount := COUNT(GROUP,h.owner_typ_cd_Invalid=2);
    owner_typ_cd_Total_ErrorCount := COUNT(GROUP,h.owner_typ_cd_Invalid>0);
    first_nm_CAPS_ErrorCount := COUNT(GROUP,h.first_nm_Invalid=1);
    first_nm_ALLOW_ErrorCount := COUNT(GROUP,h.first_nm_Invalid=2);
    first_nm_Total_ErrorCount := COUNT(GROUP,h.first_nm_Invalid>0);
    middle_nm_CAPS_ErrorCount := COUNT(GROUP,h.middle_nm_Invalid=1);
    middle_nm_ALLOW_ErrorCount := COUNT(GROUP,h.middle_nm_Invalid=2);
    middle_nm_Total_ErrorCount := COUNT(GROUP,h.middle_nm_Invalid>0);
    last_nm_CAPS_ErrorCount := COUNT(GROUP,h.last_nm_Invalid=1);
    last_nm_ALLOW_ErrorCount := COUNT(GROUP,h.last_nm_Invalid=2);
    last_nm_Total_ErrorCount := COUNT(GROUP,h.last_nm_Invalid>0);
    name_suffix_CAPS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    prof_suffix_CAPS_ErrorCount := COUNT(GROUP,h.prof_suffix_Invalid=1);
    prof_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.prof_suffix_Invalid=2);
    prof_suffix_Total_ErrorCount := COUNT(GROUP,h.prof_suffix_Invalid>0);
    ind_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ind_ssn_Invalid=1);
    ind_ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ind_ssn_Invalid=2);
    ind_ssn_Total_ErrorCount := COUNT(GROUP,h.ind_ssn_Invalid>0);
    ind_dob_ALLOW_ErrorCount := COUNT(GROUP,h.ind_dob_Invalid=1);
    ind_dob_LENGTH_ErrorCount := COUNT(GROUP,h.ind_dob_Invalid=2);
    ind_dob_Total_ErrorCount := COUNT(GROUP,h.ind_dob_Invalid>0);
    mail_range_CAPS_ErrorCount := COUNT(GROUP,h.mail_range_Invalid=1);
    mail_range_ALLOW_ErrorCount := COUNT(GROUP,h.mail_range_Invalid=2);
    mail_range_Total_ErrorCount := COUNT(GROUP,h.mail_range_Invalid>0);
    m_pre_dir_CAPS_ErrorCount := COUNT(GROUP,h.m_pre_dir_Invalid=1);
    m_pre_dir_ALLOW_ErrorCount := COUNT(GROUP,h.m_pre_dir_Invalid=2);
    m_pre_dir_Total_ErrorCount := COUNT(GROUP,h.m_pre_dir_Invalid>0);
    m_street_CAPS_ErrorCount := COUNT(GROUP,h.m_street_Invalid=1);
    m_street_ALLOW_ErrorCount := COUNT(GROUP,h.m_street_Invalid=2);
    m_street_Total_ErrorCount := COUNT(GROUP,h.m_street_Invalid>0);
    m_suffix_CAPS_ErrorCount := COUNT(GROUP,h.m_suffix_Invalid=1);
    m_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.m_suffix_Invalid=2);
    m_suffix_Total_ErrorCount := COUNT(GROUP,h.m_suffix_Invalid>0);
    m_post_dir_CAPS_ErrorCount := COUNT(GROUP,h.m_post_dir_Invalid=1);
    m_post_dir_ALLOW_ErrorCount := COUNT(GROUP,h.m_post_dir_Invalid=2);
    m_post_dir_Total_ErrorCount := COUNT(GROUP,h.m_post_dir_Invalid>0);
    m_pob_CAPS_ErrorCount := COUNT(GROUP,h.m_pob_Invalid=1);
    m_pob_ALLOW_ErrorCount := COUNT(GROUP,h.m_pob_Invalid=2);
    m_pob_Total_ErrorCount := COUNT(GROUP,h.m_pob_Invalid>0);
    m_rr_nbr_CAPS_ErrorCount := COUNT(GROUP,h.m_rr_nbr_Invalid=1);
    m_rr_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.m_rr_nbr_Invalid=2);
    m_rr_nbr_Total_ErrorCount := COUNT(GROUP,h.m_rr_nbr_Invalid>0);
    m_rr_box_CAPS_ErrorCount := COUNT(GROUP,h.m_rr_box_Invalid=1);
    m_rr_box_ALLOW_ErrorCount := COUNT(GROUP,h.m_rr_box_Invalid=2);
    m_rr_box_Total_ErrorCount := COUNT(GROUP,h.m_rr_box_Invalid>0);
    m_scndry_rng_CAPS_ErrorCount := COUNT(GROUP,h.m_scndry_rng_Invalid=1);
    m_scndry_rng_ALLOW_ErrorCount := COUNT(GROUP,h.m_scndry_rng_Invalid=2);
    m_scndry_rng_Total_ErrorCount := COUNT(GROUP,h.m_scndry_rng_Invalid>0);
    m_scndry_des_CAPS_ErrorCount := COUNT(GROUP,h.m_scndry_des_Invalid=1);
    m_scndry_des_ALLOW_ErrorCount := COUNT(GROUP,h.m_scndry_des_Invalid=2);
    m_scndry_des_Total_ErrorCount := COUNT(GROUP,h.m_scndry_des_Invalid>0);
    m_city_CAPS_ErrorCount := COUNT(GROUP,h.m_city_Invalid=1);
    m_city_ALLOW_ErrorCount := COUNT(GROUP,h.m_city_Invalid=2);
    m_city_Total_ErrorCount := COUNT(GROUP,h.m_city_Invalid>0);
    m_state_ALLOW_ErrorCount := COUNT(GROUP,h.m_state_Invalid=1);
    m_state_LENGTH_ErrorCount := COUNT(GROUP,h.m_state_Invalid=2);
    m_state_Total_ErrorCount := COUNT(GROUP,h.m_state_Invalid>0);
    m_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.m_zip5_Invalid=1);
    m_zip5_LENGTH_ErrorCount := COUNT(GROUP,h.m_zip5_Invalid=2);
    m_zip5_Total_ErrorCount := COUNT(GROUP,h.m_zip5_Invalid>0);
    m_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.m_zip4_Invalid=1);
    m_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.m_zip4_Invalid=2);
    m_zip4_Total_ErrorCount := COUNT(GROUP,h.m_zip4_Invalid>0);
    m_cc_ENUM_ErrorCount := COUNT(GROUP,h.m_cc_Invalid=1);
    m_cc_LENGTH_ErrorCount := COUNT(GROUP,h.m_cc_Invalid=2);
    m_cc_Total_ErrorCount := COUNT(GROUP,h.m_cc_Invalid>0);
    m_county_CAPS_ErrorCount := COUNT(GROUP,h.m_county_Invalid=1);
    m_county_ALLOW_ErrorCount := COUNT(GROUP,h.m_county_Invalid=2);
    m_county_Total_ErrorCount := COUNT(GROUP,h.m_county_Invalid>0);
    phys_range_CAPS_ErrorCount := COUNT(GROUP,h.phys_range_Invalid=1);
    phys_range_ALLOW_ErrorCount := COUNT(GROUP,h.phys_range_Invalid=2);
    phys_range_Total_ErrorCount := COUNT(GROUP,h.phys_range_Invalid>0);
    p_pre_dir_CAPS_ErrorCount := COUNT(GROUP,h.p_pre_dir_Invalid=1);
    p_pre_dir_ALLOW_ErrorCount := COUNT(GROUP,h.p_pre_dir_Invalid=2);
    p_pre_dir_Total_ErrorCount := COUNT(GROUP,h.p_pre_dir_Invalid>0);
    p_street_CAPS_ErrorCount := COUNT(GROUP,h.p_street_Invalid=1);
    p_street_ALLOW_ErrorCount := COUNT(GROUP,h.p_street_Invalid=2);
    p_street_Total_ErrorCount := COUNT(GROUP,h.p_street_Invalid>0);
    p_suffix_CAPS_ErrorCount := COUNT(GROUP,h.p_suffix_Invalid=1);
    p_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.p_suffix_Invalid=2);
    p_suffix_Total_ErrorCount := COUNT(GROUP,h.p_suffix_Invalid>0);
    p_post_dir_CAPS_ErrorCount := COUNT(GROUP,h.p_post_dir_Invalid=1);
    p_post_dir_ALLOW_ErrorCount := COUNT(GROUP,h.p_post_dir_Invalid=2);
    p_post_dir_Total_ErrorCount := COUNT(GROUP,h.p_post_dir_Invalid>0);
    p_pob_CAPS_ErrorCount := COUNT(GROUP,h.p_pob_Invalid=1);
    p_pob_ALLOW_ErrorCount := COUNT(GROUP,h.p_pob_Invalid=2);
    p_pob_Total_ErrorCount := COUNT(GROUP,h.p_pob_Invalid>0);
    p_rr_nbr_CAPS_ErrorCount := COUNT(GROUP,h.p_rr_nbr_Invalid=1);
    p_rr_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.p_rr_nbr_Invalid=2);
    p_rr_nbr_Total_ErrorCount := COUNT(GROUP,h.p_rr_nbr_Invalid>0);
    p_rr_box_CAPS_ErrorCount := COUNT(GROUP,h.p_rr_box_Invalid=1);
    p_rr_box_ALLOW_ErrorCount := COUNT(GROUP,h.p_rr_box_Invalid=2);
    p_rr_box_Total_ErrorCount := COUNT(GROUP,h.p_rr_box_Invalid>0);
    p_scndry_rng_CAPS_ErrorCount := COUNT(GROUP,h.p_scndry_rng_Invalid=1);
    p_scndry_rng_ALLOW_ErrorCount := COUNT(GROUP,h.p_scndry_rng_Invalid=2);
    p_scndry_rng_Total_ErrorCount := COUNT(GROUP,h.p_scndry_rng_Invalid>0);
    p_scndry_des_CAPS_ErrorCount := COUNT(GROUP,h.p_scndry_des_Invalid=1);
    p_scndry_des_ALLOW_ErrorCount := COUNT(GROUP,h.p_scndry_des_Invalid=2);
    p_scndry_des_Total_ErrorCount := COUNT(GROUP,h.p_scndry_des_Invalid>0);
    p_city_CAPS_ErrorCount := COUNT(GROUP,h.p_city_Invalid=1);
    p_city_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_Invalid=2);
    p_city_Total_ErrorCount := COUNT(GROUP,h.p_city_Invalid>0);
    p_state_ALLOW_ErrorCount := COUNT(GROUP,h.p_state_Invalid=1);
    p_state_LENGTH_ErrorCount := COUNT(GROUP,h.p_state_Invalid=2);
    p_state_Total_ErrorCount := COUNT(GROUP,h.p_state_Invalid>0);
    p_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.p_zip5_Invalid=1);
    p_zip5_LENGTH_ErrorCount := COUNT(GROUP,h.p_zip5_Invalid=2);
    p_zip5_Total_ErrorCount := COUNT(GROUP,h.p_zip5_Invalid>0);
    p_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.p_zip4_Invalid=1);
    p_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.p_zip4_Invalid=2);
    p_zip4_Total_ErrorCount := COUNT(GROUP,h.p_zip4_Invalid>0);
    p_cc_ENUM_ErrorCount := COUNT(GROUP,h.p_cc_Invalid=1);
    p_cc_LENGTH_ErrorCount := COUNT(GROUP,h.p_cc_Invalid=2);
    p_cc_Total_ErrorCount := COUNT(GROUP,h.p_cc_Invalid>0);
    p_county_CAPS_ErrorCount := COUNT(GROUP,h.p_county_Invalid=1);
    p_county_ALLOW_ErrorCount := COUNT(GROUP,h.p_county_Invalid=2);
    p_county_Total_ErrorCount := COUNT(GROUP,h.p_county_Invalid>0);
    opt_out_cd_ENUM_ErrorCount := COUNT(GROUP,h.opt_out_cd_Invalid=1);
    opt_out_cd_LENGTH_ErrorCount := COUNT(GROUP,h.opt_out_cd_Invalid=2);
    opt_out_cd_Total_ErrorCount := COUNT(GROUP,h.opt_out_cd_Invalid>0);
    asg_wgt_ALLOW_ErrorCount := COUNT(GROUP,h.asg_wgt_Invalid=1);
    asg_wgt_uom_CAPS_ErrorCount := COUNT(GROUP,h.asg_wgt_uom_Invalid=1);
    asg_wgt_uom_ALLOW_ErrorCount := COUNT(GROUP,h.asg_wgt_uom_Invalid=2);
    asg_wgt_uom_Total_ErrorCount := COUNT(GROUP,h.asg_wgt_uom_Invalid>0);
    source_ctl_id_ALLOW_ErrorCount := COUNT(GROUP,h.source_ctl_id_Invalid=1);
    raw_name_CAPS_ErrorCount := COUNT(GROUP,h.raw_name_Invalid=1);
    raw_name_ALLOW_ErrorCount := COUNT(GROUP,h.raw_name_Invalid=2);
    raw_name_Total_ErrorCount := COUNT(GROUP,h.raw_name_Invalid>0);
    branded_title_flag_ENUM_ErrorCount := COUNT(GROUP,h.branded_title_flag_Invalid=1);
    branded_title_flag_LENGTH_ErrorCount := COUNT(GROUP,h.branded_title_flag_Invalid=2);
    branded_title_flag_Total_ErrorCount := COUNT(GROUP,h.branded_title_flag_Invalid>0);
    brand_code_1_CAPS_ErrorCount := COUNT(GROUP,h.brand_code_1_Invalid=1);
    brand_code_1_ALLOW_ErrorCount := COUNT(GROUP,h.brand_code_1_Invalid=2);
    brand_code_1_Total_ErrorCount := COUNT(GROUP,h.brand_code_1_Invalid>0);
    brand_date_1_ALLOW_ErrorCount := COUNT(GROUP,h.brand_date_1_Invalid=1);
    brand_date_1_LENGTH_ErrorCount := COUNT(GROUP,h.brand_date_1_Invalid=2);
    brand_date_1_Total_ErrorCount := COUNT(GROUP,h.brand_date_1_Invalid>0);
    brand_state_1_ALLOW_ErrorCount := COUNT(GROUP,h.brand_state_1_Invalid=1);
    brand_state_1_LENGTH_ErrorCount := COUNT(GROUP,h.brand_state_1_Invalid=2);
    brand_state_1_Total_ErrorCount := COUNT(GROUP,h.brand_state_1_Invalid>0);
    brand_code_2_CAPS_ErrorCount := COUNT(GROUP,h.brand_code_2_Invalid=1);
    brand_code_2_ALLOW_ErrorCount := COUNT(GROUP,h.brand_code_2_Invalid=2);
    brand_code_2_Total_ErrorCount := COUNT(GROUP,h.brand_code_2_Invalid>0);
    brand_date_2_ALLOW_ErrorCount := COUNT(GROUP,h.brand_date_2_Invalid=1);
    brand_date_2_LENGTH_ErrorCount := COUNT(GROUP,h.brand_date_2_Invalid=2);
    brand_date_2_Total_ErrorCount := COUNT(GROUP,h.brand_date_2_Invalid>0);
    brand_state_2_ALLOW_ErrorCount := COUNT(GROUP,h.brand_state_2_Invalid=1);
    brand_state_2_LENGTH_ErrorCount := COUNT(GROUP,h.brand_state_2_Invalid=2);
    brand_state_2_Total_ErrorCount := COUNT(GROUP,h.brand_state_2_Invalid>0);
    brand_code_3_CAPS_ErrorCount := COUNT(GROUP,h.brand_code_3_Invalid=1);
    brand_code_3_ALLOW_ErrorCount := COUNT(GROUP,h.brand_code_3_Invalid=2);
    brand_code_3_Total_ErrorCount := COUNT(GROUP,h.brand_code_3_Invalid>0);
    brand_date_3_ALLOW_ErrorCount := COUNT(GROUP,h.brand_date_3_Invalid=1);
    brand_date_3_LENGTH_ErrorCount := COUNT(GROUP,h.brand_date_3_Invalid=2);
    brand_date_3_Total_ErrorCount := COUNT(GROUP,h.brand_date_3_Invalid>0);
    brand_state_3_ALLOW_ErrorCount := COUNT(GROUP,h.brand_state_3_Invalid=1);
    brand_state_3_LENGTH_ErrorCount := COUNT(GROUP,h.brand_state_3_Invalid=2);
    brand_state_3_Total_ErrorCount := COUNT(GROUP,h.brand_state_3_Invalid>0);
    brand_code_4_CAPS_ErrorCount := COUNT(GROUP,h.brand_code_4_Invalid=1);
    brand_code_4_ALLOW_ErrorCount := COUNT(GROUP,h.brand_code_4_Invalid=2);
    brand_code_4_Total_ErrorCount := COUNT(GROUP,h.brand_code_4_Invalid>0);
    brand_date_4_ALLOW_ErrorCount := COUNT(GROUP,h.brand_date_4_Invalid=1);
    brand_date_4_LENGTH_ErrorCount := COUNT(GROUP,h.brand_date_4_Invalid=2);
    brand_date_4_Total_ErrorCount := COUNT(GROUP,h.brand_date_4_Invalid>0);
    brand_state_4_ALLOW_ErrorCount := COUNT(GROUP,h.brand_state_4_Invalid=1);
    brand_state_4_LENGTH_ErrorCount := COUNT(GROUP,h.brand_state_4_Invalid=2);
    brand_state_4_Total_ErrorCount := COUNT(GROUP,h.brand_state_4_Invalid>0);
    brand_code_5_CAPS_ErrorCount := COUNT(GROUP,h.brand_code_5_Invalid=1);
    brand_code_5_ALLOW_ErrorCount := COUNT(GROUP,h.brand_code_5_Invalid=2);
    brand_code_5_Total_ErrorCount := COUNT(GROUP,h.brand_code_5_Invalid>0);
    brand_date_5_ALLOW_ErrorCount := COUNT(GROUP,h.brand_date_5_Invalid=1);
    brand_date_5_LENGTH_ErrorCount := COUNT(GROUP,h.brand_date_5_Invalid=2);
    brand_date_5_Total_ErrorCount := COUNT(GROUP,h.brand_date_5_Invalid>0);
    brand_state_5_ALLOW_ErrorCount := COUNT(GROUP,h.brand_state_5_Invalid=1);
    brand_state_5_LENGTH_ErrorCount := COUNT(GROUP,h.brand_state_5_Invalid=2);
    brand_state_5_Total_ErrorCount := COUNT(GROUP,h.brand_state_5_Invalid>0);
    tod_flag_ENUM_ErrorCount := COUNT(GROUP,h.tod_flag_Invalid=1);
    tod_flag_LENGTH_ErrorCount := COUNT(GROUP,h.tod_flag_Invalid=2);
    tod_flag_Total_ErrorCount := COUNT(GROUP,h.tod_flag_Invalid>0);
    model_class_CAPS_ErrorCount := COUNT(GROUP,h.model_class_Invalid=1);
    model_class_ALLOW_ErrorCount := COUNT(GROUP,h.model_class_Invalid=2);
    model_class_Total_ErrorCount := COUNT(GROUP,h.model_class_Invalid>0);
    min_door_count_ALLOW_ErrorCount := COUNT(GROUP,h.min_door_count_Invalid=1);
    min_door_count_LENGTH_ErrorCount := COUNT(GROUP,h.min_door_count_Invalid=2);
    min_door_count_Total_ErrorCount := COUNT(GROUP,h.min_door_count_Invalid>0);
    safety_type_CAPS_ErrorCount := COUNT(GROUP,h.safety_type_Invalid=1);
    safety_type_ALLOW_ErrorCount := COUNT(GROUP,h.safety_type_Invalid=2);
    safety_type_Total_ErrorCount := COUNT(GROUP,h.safety_type_Invalid>0);
    airbag_driver_CAPS_ErrorCount := COUNT(GROUP,h.airbag_driver_Invalid=1);
    airbag_driver_ALLOW_ErrorCount := COUNT(GROUP,h.airbag_driver_Invalid=2);
    airbag_driver_Total_ErrorCount := COUNT(GROUP,h.airbag_driver_Invalid>0);
    airbag_front_driver_side_CAPS_ErrorCount := COUNT(GROUP,h.airbag_front_driver_side_Invalid=1);
    airbag_front_driver_side_ALLOW_ErrorCount := COUNT(GROUP,h.airbag_front_driver_side_Invalid=2);
    airbag_front_driver_side_Total_ErrorCount := COUNT(GROUP,h.airbag_front_driver_side_Invalid>0);
    airbag_front_head_curtain_CAPS_ErrorCount := COUNT(GROUP,h.airbag_front_head_curtain_Invalid=1);
    airbag_front_head_curtain_ALLOW_ErrorCount := COUNT(GROUP,h.airbag_front_head_curtain_Invalid=2);
    airbag_front_head_curtain_Total_ErrorCount := COUNT(GROUP,h.airbag_front_head_curtain_Invalid>0);
    airbag_front_pass_CAPS_ErrorCount := COUNT(GROUP,h.airbag_front_pass_Invalid=1);
    airbag_front_pass_ALLOW_ErrorCount := COUNT(GROUP,h.airbag_front_pass_Invalid=2);
    airbag_front_pass_Total_ErrorCount := COUNT(GROUP,h.airbag_front_pass_Invalid>0);
    airbag_front_pass_side_CAPS_ErrorCount := COUNT(GROUP,h.airbag_front_pass_side_Invalid=1);
    airbag_front_pass_side_ALLOW_ErrorCount := COUNT(GROUP,h.airbag_front_pass_side_Invalid=2);
    airbag_front_pass_side_Total_ErrorCount := COUNT(GROUP,h.airbag_front_pass_side_Invalid>0);
    airbags_CAPS_ErrorCount := COUNT(GROUP,h.airbags_Invalid=1);
    airbags_ALLOW_ErrorCount := COUNT(GROUP,h.airbags_Invalid=2);
    airbags_Total_ErrorCount := COUNT(GROUP,h.airbags_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,append_state_origin,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.append_state_origin;
    UNSIGNED1 ErrNum := CHOOSE(c,le.append_process_date_Invalid,le.append_state_origin_Invalid,le.file_typ_Invalid,le.vin_Invalid,le.vehicle_typ_Invalid,le.model_yr_Invalid,le.model_yr_ind_Invalid,le.make_Invalid,le.make_ind_Invalid,le.series_Invalid,le.series_ind_Invalid,le.prime_color_Invalid,le.second_color_Invalid,le.body_style_Invalid,le.body_style_ind_Invalid,le.model_Invalid,le.model_ind_Invalid,le.weight_Invalid,le.lengt_Invalid,le.axle_cnt_Invalid,le.plate_nbr_Invalid,le.plate_state_Invalid,le.prev_plate_nbr_Invalid,le.prev_plate_state_Invalid,le.plate_typ_cd_Invalid,le.mstr_src_state_Invalid,le.reg_decal_nbr_Invalid,le.org_reg_dt_Invalid,le.reg_renew_dt_Invalid,le.reg_exp_dt_Invalid,le.title_nbr_Invalid,le.org_title_dt_Invalid,le.title_trans_dt_Invalid,le.name_typ_cd_Invalid,le.owner_typ_cd_Invalid,le.first_nm_Invalid,le.middle_nm_Invalid,le.last_nm_Invalid,le.name_suffix_Invalid,le.prof_suffix_Invalid,le.ind_ssn_Invalid,le.ind_dob_Invalid,le.mail_range_Invalid,le.m_pre_dir_Invalid,le.m_street_Invalid,le.m_suffix_Invalid,le.m_post_dir_Invalid,le.m_pob_Invalid,le.m_rr_nbr_Invalid,le.m_rr_box_Invalid,le.m_scndry_rng_Invalid,le.m_scndry_des_Invalid,le.m_city_Invalid,le.m_state_Invalid,le.m_zip5_Invalid,le.m_zip4_Invalid,le.m_cc_Invalid,le.m_county_Invalid,le.phys_range_Invalid,le.p_pre_dir_Invalid,le.p_street_Invalid,le.p_suffix_Invalid,le.p_post_dir_Invalid,le.p_pob_Invalid,le.p_rr_nbr_Invalid,le.p_rr_box_Invalid,le.p_scndry_rng_Invalid,le.p_scndry_des_Invalid,le.p_city_Invalid,le.p_state_Invalid,le.p_zip5_Invalid,le.p_zip4_Invalid,le.p_cc_Invalid,le.p_county_Invalid,le.opt_out_cd_Invalid,le.asg_wgt_Invalid,le.asg_wgt_uom_Invalid,le.source_ctl_id_Invalid,le.raw_name_Invalid,le.branded_title_flag_Invalid,le.brand_code_1_Invalid,le.brand_date_1_Invalid,le.brand_state_1_Invalid,le.brand_code_2_Invalid,le.brand_date_2_Invalid,le.brand_state_2_Invalid,le.brand_code_3_Invalid,le.brand_date_3_Invalid,le.brand_state_3_Invalid,le.brand_code_4_Invalid,le.brand_date_4_Invalid,le.brand_state_4_Invalid,le.brand_code_5_Invalid,le.brand_date_5_Invalid,le.brand_state_5_Invalid,le.tod_flag_Invalid,le.model_class_Invalid,le.min_door_count_Invalid,le.safety_type_Invalid,le.airbag_driver_Invalid,le.airbag_front_driver_side_Invalid,le.airbag_front_head_curtain_Invalid,le.airbag_front_pass_Invalid,le.airbag_front_pass_side_Invalid,le.airbags_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_append_process_date(le.append_process_date_Invalid),Fields.InvalidMessage_append_state_origin(le.append_state_origin_Invalid),Fields.InvalidMessage_file_typ(le.file_typ_Invalid),Fields.InvalidMessage_vin(le.vin_Invalid),Fields.InvalidMessage_vehicle_typ(le.vehicle_typ_Invalid),Fields.InvalidMessage_model_yr(le.model_yr_Invalid),Fields.InvalidMessage_model_yr_ind(le.model_yr_ind_Invalid),Fields.InvalidMessage_make(le.make_Invalid),Fields.InvalidMessage_make_ind(le.make_ind_Invalid),Fields.InvalidMessage_series(le.series_Invalid),Fields.InvalidMessage_series_ind(le.series_ind_Invalid),Fields.InvalidMessage_prime_color(le.prime_color_Invalid),Fields.InvalidMessage_second_color(le.second_color_Invalid),Fields.InvalidMessage_body_style(le.body_style_Invalid),Fields.InvalidMessage_body_style_ind(le.body_style_ind_Invalid),Fields.InvalidMessage_model(le.model_Invalid),Fields.InvalidMessage_model_ind(le.model_ind_Invalid),Fields.InvalidMessage_weight(le.weight_Invalid),Fields.InvalidMessage_lengt(le.lengt_Invalid),Fields.InvalidMessage_axle_cnt(le.axle_cnt_Invalid),Fields.InvalidMessage_plate_nbr(le.plate_nbr_Invalid),Fields.InvalidMessage_plate_state(le.plate_state_Invalid),Fields.InvalidMessage_prev_plate_nbr(le.prev_plate_nbr_Invalid),Fields.InvalidMessage_prev_plate_state(le.prev_plate_state_Invalid),Fields.InvalidMessage_plate_typ_cd(le.plate_typ_cd_Invalid),Fields.InvalidMessage_mstr_src_state(le.mstr_src_state_Invalid),Fields.InvalidMessage_reg_decal_nbr(le.reg_decal_nbr_Invalid),Fields.InvalidMessage_org_reg_dt(le.org_reg_dt_Invalid),Fields.InvalidMessage_reg_renew_dt(le.reg_renew_dt_Invalid),Fields.InvalidMessage_reg_exp_dt(le.reg_exp_dt_Invalid),Fields.InvalidMessage_title_nbr(le.title_nbr_Invalid),Fields.InvalidMessage_org_title_dt(le.org_title_dt_Invalid),Fields.InvalidMessage_title_trans_dt(le.title_trans_dt_Invalid),Fields.InvalidMessage_name_typ_cd(le.name_typ_cd_Invalid),Fields.InvalidMessage_owner_typ_cd(le.owner_typ_cd_Invalid),Fields.InvalidMessage_first_nm(le.first_nm_Invalid),Fields.InvalidMessage_middle_nm(le.middle_nm_Invalid),Fields.InvalidMessage_last_nm(le.last_nm_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_prof_suffix(le.prof_suffix_Invalid),Fields.InvalidMessage_ind_ssn(le.ind_ssn_Invalid),Fields.InvalidMessage_ind_dob(le.ind_dob_Invalid),Fields.InvalidMessage_mail_range(le.mail_range_Invalid),Fields.InvalidMessage_m_pre_dir(le.m_pre_dir_Invalid),Fields.InvalidMessage_m_street(le.m_street_Invalid),Fields.InvalidMessage_m_suffix(le.m_suffix_Invalid),Fields.InvalidMessage_m_post_dir(le.m_post_dir_Invalid),Fields.InvalidMessage_m_pob(le.m_pob_Invalid),Fields.InvalidMessage_m_rr_nbr(le.m_rr_nbr_Invalid),Fields.InvalidMessage_m_rr_box(le.m_rr_box_Invalid),Fields.InvalidMessage_m_scndry_rng(le.m_scndry_rng_Invalid),Fields.InvalidMessage_m_scndry_des(le.m_scndry_des_Invalid),Fields.InvalidMessage_m_city(le.m_city_Invalid),Fields.InvalidMessage_m_state(le.m_state_Invalid),Fields.InvalidMessage_m_zip5(le.m_zip5_Invalid),Fields.InvalidMessage_m_zip4(le.m_zip4_Invalid),Fields.InvalidMessage_m_cc(le.m_cc_Invalid),Fields.InvalidMessage_m_county(le.m_county_Invalid),Fields.InvalidMessage_phys_range(le.phys_range_Invalid),Fields.InvalidMessage_p_pre_dir(le.p_pre_dir_Invalid),Fields.InvalidMessage_p_street(le.p_street_Invalid),Fields.InvalidMessage_p_suffix(le.p_suffix_Invalid),Fields.InvalidMessage_p_post_dir(le.p_post_dir_Invalid),Fields.InvalidMessage_p_pob(le.p_pob_Invalid),Fields.InvalidMessage_p_rr_nbr(le.p_rr_nbr_Invalid),Fields.InvalidMessage_p_rr_box(le.p_rr_box_Invalid),Fields.InvalidMessage_p_scndry_rng(le.p_scndry_rng_Invalid),Fields.InvalidMessage_p_scndry_des(le.p_scndry_des_Invalid),Fields.InvalidMessage_p_city(le.p_city_Invalid),Fields.InvalidMessage_p_state(le.p_state_Invalid),Fields.InvalidMessage_p_zip5(le.p_zip5_Invalid),Fields.InvalidMessage_p_zip4(le.p_zip4_Invalid),Fields.InvalidMessage_p_cc(le.p_cc_Invalid),Fields.InvalidMessage_p_county(le.p_county_Invalid),Fields.InvalidMessage_opt_out_cd(le.opt_out_cd_Invalid),Fields.InvalidMessage_asg_wgt(le.asg_wgt_Invalid),Fields.InvalidMessage_asg_wgt_uom(le.asg_wgt_uom_Invalid),Fields.InvalidMessage_source_ctl_id(le.source_ctl_id_Invalid),Fields.InvalidMessage_raw_name(le.raw_name_Invalid),Fields.InvalidMessage_branded_title_flag(le.branded_title_flag_Invalid),Fields.InvalidMessage_brand_code_1(le.brand_code_1_Invalid),Fields.InvalidMessage_brand_date_1(le.brand_date_1_Invalid),Fields.InvalidMessage_brand_state_1(le.brand_state_1_Invalid),Fields.InvalidMessage_brand_code_2(le.brand_code_2_Invalid),Fields.InvalidMessage_brand_date_2(le.brand_date_2_Invalid),Fields.InvalidMessage_brand_state_2(le.brand_state_2_Invalid),Fields.InvalidMessage_brand_code_3(le.brand_code_3_Invalid),Fields.InvalidMessage_brand_date_3(le.brand_date_3_Invalid),Fields.InvalidMessage_brand_state_3(le.brand_state_3_Invalid),Fields.InvalidMessage_brand_code_4(le.brand_code_4_Invalid),Fields.InvalidMessage_brand_date_4(le.brand_date_4_Invalid),Fields.InvalidMessage_brand_state_4(le.brand_state_4_Invalid),Fields.InvalidMessage_brand_code_5(le.brand_code_5_Invalid),Fields.InvalidMessage_brand_date_5(le.brand_date_5_Invalid),Fields.InvalidMessage_brand_state_5(le.brand_state_5_Invalid),Fields.InvalidMessage_tod_flag(le.tod_flag_Invalid),Fields.InvalidMessage_model_class(le.model_class_Invalid),Fields.InvalidMessage_min_door_count(le.min_door_count_Invalid),Fields.InvalidMessage_safety_type(le.safety_type_Invalid),Fields.InvalidMessage_airbag_driver(le.airbag_driver_Invalid),Fields.InvalidMessage_airbag_front_driver_side(le.airbag_front_driver_side_Invalid),Fields.InvalidMessage_airbag_front_head_curtain(le.airbag_front_head_curtain_Invalid),Fields.InvalidMessage_airbag_front_pass(le.airbag_front_pass_Invalid),Fields.InvalidMessage_airbag_front_pass_side(le.airbag_front_pass_side_Invalid),Fields.InvalidMessage_airbags(le.airbags_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.append_process_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.append_state_origin_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.file_typ_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.vin_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.vehicle_typ_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.model_yr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.model_yr_ind_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.make_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.make_ind_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.series_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.series_ind_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.prime_color_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.second_color_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.body_style_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.body_style_ind_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.model_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.model_ind_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.weight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lengt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.axle_cnt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.plate_nbr_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.plate_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.prev_plate_nbr_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.prev_plate_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.plate_typ_cd_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.mstr_src_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.reg_decal_nbr_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.org_reg_dt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.reg_renew_dt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.reg_exp_dt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title_nbr_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.org_title_dt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title_trans_dt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_typ_cd_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.owner_typ_cd_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.first_nm_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.middle_nm_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.last_nm_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.prof_suffix_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.ind_ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ind_dob_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mail_range_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_pre_dir_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_street_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_suffix_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_post_dir_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_pob_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_rr_nbr_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_rr_box_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_scndry_rng_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_scndry_des_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_city_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.m_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.m_zip5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.m_zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.m_cc_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.m_county_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.phys_range_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_pre_dir_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_street_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_suffix_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_post_dir_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_pob_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_rr_nbr_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_rr_box_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_scndry_rng_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_scndry_des_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.p_zip5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.p_zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.p_cc_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.p_county_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.opt_out_cd_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.asg_wgt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.asg_wgt_uom_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.source_ctl_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.branded_title_flag_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.brand_code_1_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.brand_date_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.brand_state_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.brand_code_2_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.brand_date_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.brand_state_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.brand_code_3_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.brand_date_3_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.brand_state_3_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.brand_code_4_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.brand_date_4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.brand_state_4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.brand_code_5_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.brand_date_5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.brand_state_5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.tod_flag_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.model_class_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.min_door_count_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.safety_type_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.airbag_driver_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.airbag_front_driver_side_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.airbag_front_head_curtain_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.airbag_front_pass_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.airbag_front_pass_side_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.airbags_Invalid,'CAPS','ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'append_process_date','append_state_origin','file_typ','vin','vehicle_typ','model_yr','model_yr_ind','make','make_ind','series','series_ind','prime_color','second_color','body_style','body_style_ind','model','model_ind','weight','lengt','axle_cnt','plate_nbr','plate_state','prev_plate_nbr','prev_plate_state','plate_typ_cd','mstr_src_state','reg_decal_nbr','org_reg_dt','reg_renew_dt','reg_exp_dt','title_nbr','org_title_dt','title_trans_dt','name_typ_cd','owner_typ_cd','first_nm','middle_nm','last_nm','name_suffix','prof_suffix','ind_ssn','ind_dob','mail_range','m_pre_dir','m_street','m_suffix','m_post_dir','m_pob','m_rr_nbr','m_rr_box','m_scndry_rng','m_scndry_des','m_city','m_state','m_zip5','m_zip4','m_cc','m_county','phys_range','p_pre_dir','p_street','p_suffix','p_post_dir','p_pob','p_rr_nbr','p_rr_box','p_scndry_rng','p_scndry_des','p_city','p_state','p_zip5','p_zip4','p_cc','p_county','opt_out_cd','asg_wgt','asg_wgt_uom','source_ctl_id','raw_name','branded_title_flag','brand_code_1','brand_date_1','brand_state_1','brand_code_2','brand_date_2','brand_state_2','brand_code_3','brand_date_3','brand_state_3','brand_code_4','brand_date_4','brand_state_4','brand_code_5','brand_date_5','brand_state_5','tod_flag','model_class','min_door_count','safety_type','airbag_driver','airbag_front_driver_side','airbag_front_head_curtain','airbag_front_pass','airbag_front_pass_side','airbags','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_state','invalid_file_typ','invalid_vin','invalid_vehicle_typ','invalid_year','invalid_model_yr_ind','invalid_alpha','invalid_model_yr_ind','invalid_alpha','invalid_model_yr_ind','invalid_only_alpha','invalid_only_alpha','invalid_alpha','invalid_model_yr_ind','invalid_alpha','invalid_model_yr_ind','invalid_number','invalid_number','invalid_number','invalid_alpha','invalid_state','invalid_alpha','invalid_state','invalid_only_alpha','invalid_state','invalid_alphanumeric','invalid_date','invalid_date','invalid_date','invalid_alphanumeric','invalid_date','invalid_date','invalid_name_typ_cd','invalid_owner_typ_cd','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_ssn','invalid_date','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_state','invalid_zip5','invalid_zip4','invalid_cc','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_state','invalid_zip5','invalid_zip4','invalid_cc','invalid_alpha','invalid_opt_out_cd','invalid_number','invalid_only_alpha','invalid_number','invalid_alpha','invalid_yes_no','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_yes_no','invalid_alpha','invalid_min_door_count','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.append_process_date,(SALT30.StrType)le.append_state_origin,(SALT30.StrType)le.file_typ,(SALT30.StrType)le.vin,(SALT30.StrType)le.vehicle_typ,(SALT30.StrType)le.model_yr,(SALT30.StrType)le.model_yr_ind,(SALT30.StrType)le.make,(SALT30.StrType)le.make_ind,(SALT30.StrType)le.series,(SALT30.StrType)le.series_ind,(SALT30.StrType)le.prime_color,(SALT30.StrType)le.second_color,(SALT30.StrType)le.body_style,(SALT30.StrType)le.body_style_ind,(SALT30.StrType)le.model,(SALT30.StrType)le.model_ind,(SALT30.StrType)le.weight,(SALT30.StrType)le.lengt,(SALT30.StrType)le.axle_cnt,(SALT30.StrType)le.plate_nbr,(SALT30.StrType)le.plate_state,(SALT30.StrType)le.prev_plate_nbr,(SALT30.StrType)le.prev_plate_state,(SALT30.StrType)le.plate_typ_cd,(SALT30.StrType)le.mstr_src_state,(SALT30.StrType)le.reg_decal_nbr,(SALT30.StrType)le.org_reg_dt,(SALT30.StrType)le.reg_renew_dt,(SALT30.StrType)le.reg_exp_dt,(SALT30.StrType)le.title_nbr,(SALT30.StrType)le.org_title_dt,(SALT30.StrType)le.title_trans_dt,(SALT30.StrType)le.name_typ_cd,(SALT30.StrType)le.owner_typ_cd,(SALT30.StrType)le.first_nm,(SALT30.StrType)le.middle_nm,(SALT30.StrType)le.last_nm,(SALT30.StrType)le.name_suffix,(SALT30.StrType)le.prof_suffix,(SALT30.StrType)le.ind_ssn,(SALT30.StrType)le.ind_dob,(SALT30.StrType)le.mail_range,(SALT30.StrType)le.m_pre_dir,(SALT30.StrType)le.m_street,(SALT30.StrType)le.m_suffix,(SALT30.StrType)le.m_post_dir,(SALT30.StrType)le.m_pob,(SALT30.StrType)le.m_rr_nbr,(SALT30.StrType)le.m_rr_box,(SALT30.StrType)le.m_scndry_rng,(SALT30.StrType)le.m_scndry_des,(SALT30.StrType)le.m_city,(SALT30.StrType)le.m_state,(SALT30.StrType)le.m_zip5,(SALT30.StrType)le.m_zip4,(SALT30.StrType)le.m_cc,(SALT30.StrType)le.m_county,(SALT30.StrType)le.phys_range,(SALT30.StrType)le.p_pre_dir,(SALT30.StrType)le.p_street,(SALT30.StrType)le.p_suffix,(SALT30.StrType)le.p_post_dir,(SALT30.StrType)le.p_pob,(SALT30.StrType)le.p_rr_nbr,(SALT30.StrType)le.p_rr_box,(SALT30.StrType)le.p_scndry_rng,(SALT30.StrType)le.p_scndry_des,(SALT30.StrType)le.p_city,(SALT30.StrType)le.p_state,(SALT30.StrType)le.p_zip5,(SALT30.StrType)le.p_zip4,(SALT30.StrType)le.p_cc,(SALT30.StrType)le.p_county,(SALT30.StrType)le.opt_out_cd,(SALT30.StrType)le.asg_wgt,(SALT30.StrType)le.asg_wgt_uom,(SALT30.StrType)le.source_ctl_id,(SALT30.StrType)le.raw_name,(SALT30.StrType)le.branded_title_flag,(SALT30.StrType)le.brand_code_1,(SALT30.StrType)le.brand_date_1,(SALT30.StrType)le.brand_state_1,(SALT30.StrType)le.brand_code_2,(SALT30.StrType)le.brand_date_2,(SALT30.StrType)le.brand_state_2,(SALT30.StrType)le.brand_code_3,(SALT30.StrType)le.brand_date_3,(SALT30.StrType)le.brand_state_3,(SALT30.StrType)le.brand_code_4,(SALT30.StrType)le.brand_date_4,(SALT30.StrType)le.brand_state_4,(SALT30.StrType)le.brand_code_5,(SALT30.StrType)le.brand_date_5,(SALT30.StrType)le.brand_state_5,(SALT30.StrType)le.tod_flag,(SALT30.StrType)le.model_class,(SALT30.StrType)le.min_door_count,(SALT30.StrType)le.safety_type,(SALT30.StrType)le.airbag_driver,(SALT30.StrType)le.airbag_front_driver_side,(SALT30.StrType)le.airbag_front_head_curtain,(SALT30.StrType)le.airbag_front_pass,(SALT30.StrType)le.airbag_front_pass_side,(SALT30.StrType)le.airbags,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,105,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.append_state_origin;
      SELF.ruledesc := CHOOSE(c
          ,'append_process_date:invalid_date:ALLOW','append_process_date:invalid_date:LENGTH'
          ,'append_state_origin:invalid_state:ALLOW','append_state_origin:invalid_state:LENGTH'
          ,'file_typ:invalid_file_typ:ENUM','file_typ:invalid_file_typ:LENGTH'
          ,'vin:invalid_vin:CAPS','vin:invalid_vin:ALLOW','vin:invalid_vin:LENGTH'
          ,'vehicle_typ:invalid_vehicle_typ:ENUM','vehicle_typ:invalid_vehicle_typ:LENGTH'
          ,'model_yr:invalid_year:ALLOW','model_yr:invalid_year:LENGTH'
          ,'model_yr_ind:invalid_model_yr_ind:ENUM','model_yr_ind:invalid_model_yr_ind:LENGTH'
          ,'make:invalid_alpha:CAPS','make:invalid_alpha:ALLOW'
          ,'make_ind:invalid_model_yr_ind:ENUM','make_ind:invalid_model_yr_ind:LENGTH'
          ,'series:invalid_alpha:CAPS','series:invalid_alpha:ALLOW'
          ,'series_ind:invalid_model_yr_ind:ENUM','series_ind:invalid_model_yr_ind:LENGTH'
          ,'prime_color:invalid_only_alpha:CAPS','prime_color:invalid_only_alpha:ALLOW'
          ,'second_color:invalid_only_alpha:CAPS','second_color:invalid_only_alpha:ALLOW'
          ,'body_style:invalid_alpha:CAPS','body_style:invalid_alpha:ALLOW'
          ,'body_style_ind:invalid_model_yr_ind:ENUM','body_style_ind:invalid_model_yr_ind:LENGTH'
          ,'model:invalid_alpha:CAPS','model:invalid_alpha:ALLOW'
          ,'model_ind:invalid_model_yr_ind:ENUM','model_ind:invalid_model_yr_ind:LENGTH'
          ,'weight:invalid_number:ALLOW'
          ,'lengt:invalid_number:ALLOW'
          ,'axle_cnt:invalid_number:ALLOW'
          ,'plate_nbr:invalid_alpha:CAPS','plate_nbr:invalid_alpha:ALLOW'
          ,'plate_state:invalid_state:ALLOW','plate_state:invalid_state:LENGTH'
          ,'prev_plate_nbr:invalid_alpha:CAPS','prev_plate_nbr:invalid_alpha:ALLOW'
          ,'prev_plate_state:invalid_state:ALLOW','prev_plate_state:invalid_state:LENGTH'
          ,'plate_typ_cd:invalid_only_alpha:CAPS','plate_typ_cd:invalid_only_alpha:ALLOW'
          ,'mstr_src_state:invalid_state:ALLOW','mstr_src_state:invalid_state:LENGTH'
          ,'reg_decal_nbr:invalid_alphanumeric:CAPS','reg_decal_nbr:invalid_alphanumeric:ALLOW'
          ,'org_reg_dt:invalid_date:ALLOW','org_reg_dt:invalid_date:LENGTH'
          ,'reg_renew_dt:invalid_date:ALLOW','reg_renew_dt:invalid_date:LENGTH'
          ,'reg_exp_dt:invalid_date:ALLOW','reg_exp_dt:invalid_date:LENGTH'
          ,'title_nbr:invalid_alphanumeric:CAPS','title_nbr:invalid_alphanumeric:ALLOW'
          ,'org_title_dt:invalid_date:ALLOW','org_title_dt:invalid_date:LENGTH'
          ,'title_trans_dt:invalid_date:ALLOW','title_trans_dt:invalid_date:LENGTH'
          ,'name_typ_cd:invalid_name_typ_cd:ENUM','name_typ_cd:invalid_name_typ_cd:LENGTH'
          ,'owner_typ_cd:invalid_owner_typ_cd:ENUM','owner_typ_cd:invalid_owner_typ_cd:LENGTH'
          ,'first_nm:invalid_alpha:CAPS','first_nm:invalid_alpha:ALLOW'
          ,'middle_nm:invalid_alpha:CAPS','middle_nm:invalid_alpha:ALLOW'
          ,'last_nm:invalid_alpha:CAPS','last_nm:invalid_alpha:ALLOW'
          ,'name_suffix:invalid_alpha:CAPS','name_suffix:invalid_alpha:ALLOW'
          ,'prof_suffix:invalid_alpha:CAPS','prof_suffix:invalid_alpha:ALLOW'
          ,'ind_ssn:invalid_ssn:ALLOW','ind_ssn:invalid_ssn:LENGTH'
          ,'ind_dob:invalid_date:ALLOW','ind_dob:invalid_date:LENGTH'
          ,'mail_range:invalid_alpha:CAPS','mail_range:invalid_alpha:ALLOW'
          ,'m_pre_dir:invalid_alpha:CAPS','m_pre_dir:invalid_alpha:ALLOW'
          ,'m_street:invalid_alpha:CAPS','m_street:invalid_alpha:ALLOW'
          ,'m_suffix:invalid_alpha:CAPS','m_suffix:invalid_alpha:ALLOW'
          ,'m_post_dir:invalid_alpha:CAPS','m_post_dir:invalid_alpha:ALLOW'
          ,'m_pob:invalid_alpha:CAPS','m_pob:invalid_alpha:ALLOW'
          ,'m_rr_nbr:invalid_alpha:CAPS','m_rr_nbr:invalid_alpha:ALLOW'
          ,'m_rr_box:invalid_alpha:CAPS','m_rr_box:invalid_alpha:ALLOW'
          ,'m_scndry_rng:invalid_alpha:CAPS','m_scndry_rng:invalid_alpha:ALLOW'
          ,'m_scndry_des:invalid_alpha:CAPS','m_scndry_des:invalid_alpha:ALLOW'
          ,'m_city:invalid_alpha:CAPS','m_city:invalid_alpha:ALLOW'
          ,'m_state:invalid_state:ALLOW','m_state:invalid_state:LENGTH'
          ,'m_zip5:invalid_zip5:ALLOW','m_zip5:invalid_zip5:LENGTH'
          ,'m_zip4:invalid_zip4:ALLOW','m_zip4:invalid_zip4:LENGTH'
          ,'m_cc:invalid_cc:ENUM','m_cc:invalid_cc:LENGTH'
          ,'m_county:invalid_alpha:CAPS','m_county:invalid_alpha:ALLOW'
          ,'phys_range:invalid_alpha:CAPS','phys_range:invalid_alpha:ALLOW'
          ,'p_pre_dir:invalid_alpha:CAPS','p_pre_dir:invalid_alpha:ALLOW'
          ,'p_street:invalid_alpha:CAPS','p_street:invalid_alpha:ALLOW'
          ,'p_suffix:invalid_alpha:CAPS','p_suffix:invalid_alpha:ALLOW'
          ,'p_post_dir:invalid_alpha:CAPS','p_post_dir:invalid_alpha:ALLOW'
          ,'p_pob:invalid_alpha:CAPS','p_pob:invalid_alpha:ALLOW'
          ,'p_rr_nbr:invalid_alpha:CAPS','p_rr_nbr:invalid_alpha:ALLOW'
          ,'p_rr_box:invalid_alpha:CAPS','p_rr_box:invalid_alpha:ALLOW'
          ,'p_scndry_rng:invalid_alpha:CAPS','p_scndry_rng:invalid_alpha:ALLOW'
          ,'p_scndry_des:invalid_alpha:CAPS','p_scndry_des:invalid_alpha:ALLOW'
          ,'p_city:invalid_alpha:CAPS','p_city:invalid_alpha:ALLOW'
          ,'p_state:invalid_state:ALLOW','p_state:invalid_state:LENGTH'
          ,'p_zip5:invalid_zip5:ALLOW','p_zip5:invalid_zip5:LENGTH'
          ,'p_zip4:invalid_zip4:ALLOW','p_zip4:invalid_zip4:LENGTH'
          ,'p_cc:invalid_cc:ENUM','p_cc:invalid_cc:LENGTH'
          ,'p_county:invalid_alpha:CAPS','p_county:invalid_alpha:ALLOW'
          ,'opt_out_cd:invalid_opt_out_cd:ENUM','opt_out_cd:invalid_opt_out_cd:LENGTH'
          ,'asg_wgt:invalid_number:ALLOW'
          ,'asg_wgt_uom:invalid_only_alpha:CAPS','asg_wgt_uom:invalid_only_alpha:ALLOW'
          ,'source_ctl_id:invalid_number:ALLOW'
          ,'raw_name:invalid_alpha:CAPS','raw_name:invalid_alpha:ALLOW'
          ,'branded_title_flag:invalid_yes_no:ENUM','branded_title_flag:invalid_yes_no:LENGTH'
          ,'brand_code_1:invalid_only_alpha:CAPS','brand_code_1:invalid_only_alpha:ALLOW'
          ,'brand_date_1:invalid_date1:ALLOW','brand_date_1:invalid_date1:LENGTH'
          ,'brand_state_1:invalid_state:ALLOW','brand_state_1:invalid_state:LENGTH'
          ,'brand_code_2:invalid_only_alpha:CAPS','brand_code_2:invalid_only_alpha:ALLOW'
          ,'brand_date_2:invalid_date1:ALLOW','brand_date_2:invalid_date1:LENGTH'
          ,'brand_state_2:invalid_state:ALLOW','brand_state_2:invalid_state:LENGTH'
          ,'brand_code_3:invalid_only_alpha:CAPS','brand_code_3:invalid_only_alpha:ALLOW'
          ,'brand_date_3:invalid_date1:ALLOW','brand_date_3:invalid_date1:LENGTH'
          ,'brand_state_3:invalid_state:ALLOW','brand_state_3:invalid_state:LENGTH'
          ,'brand_code_4:invalid_only_alpha:CAPS','brand_code_4:invalid_only_alpha:ALLOW'
          ,'brand_date_4:invalid_date1:ALLOW','brand_date_4:invalid_date1:LENGTH'
          ,'brand_state_4:invalid_state:ALLOW','brand_state_4:invalid_state:LENGTH'
          ,'brand_code_5:invalid_only_alpha:CAPS','brand_code_5:invalid_only_alpha:ALLOW'
          ,'brand_date_5:invalid_date1:ALLOW','brand_date_5:invalid_date1:LENGTH'
          ,'brand_state_5:invalid_state:ALLOW','brand_state_5:invalid_state:LENGTH'
          ,'tod_flag:invalid_yes_no:ENUM','tod_flag:invalid_yes_no:LENGTH'
          ,'model_class:invalid_alpha:CAPS','model_class:invalid_alpha:ALLOW'
          ,'min_door_count:invalid_min_door_count:ALLOW','min_door_count:invalid_min_door_count:LENGTH'
          ,'safety_type:invalid_alpha:CAPS','safety_type:invalid_alpha:ALLOW'
          ,'airbag_driver:invalid_alpha:CAPS','airbag_driver:invalid_alpha:ALLOW'
          ,'airbag_front_driver_side:invalid_alpha:CAPS','airbag_front_driver_side:invalid_alpha:ALLOW'
          ,'airbag_front_head_curtain:invalid_alpha:CAPS','airbag_front_head_curtain:invalid_alpha:ALLOW'
          ,'airbag_front_pass:invalid_alpha:CAPS','airbag_front_pass:invalid_alpha:ALLOW'
          ,'airbag_front_pass_side:invalid_alpha:CAPS','airbag_front_pass_side:invalid_alpha:ALLOW'
          ,'airbags:invalid_alpha:CAPS','airbags:invalid_alpha:ALLOW','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.append_process_date_ALLOW_ErrorCount,le.append_process_date_LENGTH_ErrorCount
          ,le.append_state_origin_ALLOW_ErrorCount,le.append_state_origin_LENGTH_ErrorCount
          ,le.file_typ_ENUM_ErrorCount,le.file_typ_LENGTH_ErrorCount
          ,le.vin_CAPS_ErrorCount,le.vin_ALLOW_ErrorCount,le.vin_LENGTH_ErrorCount
          ,le.vehicle_typ_ENUM_ErrorCount,le.vehicle_typ_LENGTH_ErrorCount
          ,le.model_yr_ALLOW_ErrorCount,le.model_yr_LENGTH_ErrorCount
          ,le.model_yr_ind_ENUM_ErrorCount,le.model_yr_ind_LENGTH_ErrorCount
          ,le.make_CAPS_ErrorCount,le.make_ALLOW_ErrorCount
          ,le.make_ind_ENUM_ErrorCount,le.make_ind_LENGTH_ErrorCount
          ,le.series_CAPS_ErrorCount,le.series_ALLOW_ErrorCount
          ,le.series_ind_ENUM_ErrorCount,le.series_ind_LENGTH_ErrorCount
          ,le.prime_color_CAPS_ErrorCount,le.prime_color_ALLOW_ErrorCount
          ,le.second_color_CAPS_ErrorCount,le.second_color_ALLOW_ErrorCount
          ,le.body_style_CAPS_ErrorCount,le.body_style_ALLOW_ErrorCount
          ,le.body_style_ind_ENUM_ErrorCount,le.body_style_ind_LENGTH_ErrorCount
          ,le.model_CAPS_ErrorCount,le.model_ALLOW_ErrorCount
          ,le.model_ind_ENUM_ErrorCount,le.model_ind_LENGTH_ErrorCount
          ,le.weight_ALLOW_ErrorCount
          ,le.lengt_ALLOW_ErrorCount
          ,le.axle_cnt_ALLOW_ErrorCount
          ,le.plate_nbr_CAPS_ErrorCount,le.plate_nbr_ALLOW_ErrorCount
          ,le.plate_state_ALLOW_ErrorCount,le.plate_state_LENGTH_ErrorCount
          ,le.prev_plate_nbr_CAPS_ErrorCount,le.prev_plate_nbr_ALLOW_ErrorCount
          ,le.prev_plate_state_ALLOW_ErrorCount,le.prev_plate_state_LENGTH_ErrorCount
          ,le.plate_typ_cd_CAPS_ErrorCount,le.plate_typ_cd_ALLOW_ErrorCount
          ,le.mstr_src_state_ALLOW_ErrorCount,le.mstr_src_state_LENGTH_ErrorCount
          ,le.reg_decal_nbr_CAPS_ErrorCount,le.reg_decal_nbr_ALLOW_ErrorCount
          ,le.org_reg_dt_ALLOW_ErrorCount,le.org_reg_dt_LENGTH_ErrorCount
          ,le.reg_renew_dt_ALLOW_ErrorCount,le.reg_renew_dt_LENGTH_ErrorCount
          ,le.reg_exp_dt_ALLOW_ErrorCount,le.reg_exp_dt_LENGTH_ErrorCount
          ,le.title_nbr_CAPS_ErrorCount,le.title_nbr_ALLOW_ErrorCount
          ,le.org_title_dt_ALLOW_ErrorCount,le.org_title_dt_LENGTH_ErrorCount
          ,le.title_trans_dt_ALLOW_ErrorCount,le.title_trans_dt_LENGTH_ErrorCount
          ,le.name_typ_cd_ENUM_ErrorCount,le.name_typ_cd_LENGTH_ErrorCount
          ,le.owner_typ_cd_ENUM_ErrorCount,le.owner_typ_cd_LENGTH_ErrorCount
          ,le.first_nm_CAPS_ErrorCount,le.first_nm_ALLOW_ErrorCount
          ,le.middle_nm_CAPS_ErrorCount,le.middle_nm_ALLOW_ErrorCount
          ,le.last_nm_CAPS_ErrorCount,le.last_nm_ALLOW_ErrorCount
          ,le.name_suffix_CAPS_ErrorCount,le.name_suffix_ALLOW_ErrorCount
          ,le.prof_suffix_CAPS_ErrorCount,le.prof_suffix_ALLOW_ErrorCount
          ,le.ind_ssn_ALLOW_ErrorCount,le.ind_ssn_LENGTH_ErrorCount
          ,le.ind_dob_ALLOW_ErrorCount,le.ind_dob_LENGTH_ErrorCount
          ,le.mail_range_CAPS_ErrorCount,le.mail_range_ALLOW_ErrorCount
          ,le.m_pre_dir_CAPS_ErrorCount,le.m_pre_dir_ALLOW_ErrorCount
          ,le.m_street_CAPS_ErrorCount,le.m_street_ALLOW_ErrorCount
          ,le.m_suffix_CAPS_ErrorCount,le.m_suffix_ALLOW_ErrorCount
          ,le.m_post_dir_CAPS_ErrorCount,le.m_post_dir_ALLOW_ErrorCount
          ,le.m_pob_CAPS_ErrorCount,le.m_pob_ALLOW_ErrorCount
          ,le.m_rr_nbr_CAPS_ErrorCount,le.m_rr_nbr_ALLOW_ErrorCount
          ,le.m_rr_box_CAPS_ErrorCount,le.m_rr_box_ALLOW_ErrorCount
          ,le.m_scndry_rng_CAPS_ErrorCount,le.m_scndry_rng_ALLOW_ErrorCount
          ,le.m_scndry_des_CAPS_ErrorCount,le.m_scndry_des_ALLOW_ErrorCount
          ,le.m_city_CAPS_ErrorCount,le.m_city_ALLOW_ErrorCount
          ,le.m_state_ALLOW_ErrorCount,le.m_state_LENGTH_ErrorCount
          ,le.m_zip5_ALLOW_ErrorCount,le.m_zip5_LENGTH_ErrorCount
          ,le.m_zip4_ALLOW_ErrorCount,le.m_zip4_LENGTH_ErrorCount
          ,le.m_cc_ENUM_ErrorCount,le.m_cc_LENGTH_ErrorCount
          ,le.m_county_CAPS_ErrorCount,le.m_county_ALLOW_ErrorCount
          ,le.phys_range_CAPS_ErrorCount,le.phys_range_ALLOW_ErrorCount
          ,le.p_pre_dir_CAPS_ErrorCount,le.p_pre_dir_ALLOW_ErrorCount
          ,le.p_street_CAPS_ErrorCount,le.p_street_ALLOW_ErrorCount
          ,le.p_suffix_CAPS_ErrorCount,le.p_suffix_ALLOW_ErrorCount
          ,le.p_post_dir_CAPS_ErrorCount,le.p_post_dir_ALLOW_ErrorCount
          ,le.p_pob_CAPS_ErrorCount,le.p_pob_ALLOW_ErrorCount
          ,le.p_rr_nbr_CAPS_ErrorCount,le.p_rr_nbr_ALLOW_ErrorCount
          ,le.p_rr_box_CAPS_ErrorCount,le.p_rr_box_ALLOW_ErrorCount
          ,le.p_scndry_rng_CAPS_ErrorCount,le.p_scndry_rng_ALLOW_ErrorCount
          ,le.p_scndry_des_CAPS_ErrorCount,le.p_scndry_des_ALLOW_ErrorCount
          ,le.p_city_CAPS_ErrorCount,le.p_city_ALLOW_ErrorCount
          ,le.p_state_ALLOW_ErrorCount,le.p_state_LENGTH_ErrorCount
          ,le.p_zip5_ALLOW_ErrorCount,le.p_zip5_LENGTH_ErrorCount
          ,le.p_zip4_ALLOW_ErrorCount,le.p_zip4_LENGTH_ErrorCount
          ,le.p_cc_ENUM_ErrorCount,le.p_cc_LENGTH_ErrorCount
          ,le.p_county_CAPS_ErrorCount,le.p_county_ALLOW_ErrorCount
          ,le.opt_out_cd_ENUM_ErrorCount,le.opt_out_cd_LENGTH_ErrorCount
          ,le.asg_wgt_ALLOW_ErrorCount
          ,le.asg_wgt_uom_CAPS_ErrorCount,le.asg_wgt_uom_ALLOW_ErrorCount
          ,le.source_ctl_id_ALLOW_ErrorCount
          ,le.raw_name_CAPS_ErrorCount,le.raw_name_ALLOW_ErrorCount
          ,le.branded_title_flag_ENUM_ErrorCount,le.branded_title_flag_LENGTH_ErrorCount
          ,le.brand_code_1_CAPS_ErrorCount,le.brand_code_1_ALLOW_ErrorCount
          ,le.brand_date_1_ALLOW_ErrorCount,le.brand_date_1_LENGTH_ErrorCount
          ,le.brand_state_1_ALLOW_ErrorCount,le.brand_state_1_LENGTH_ErrorCount
          ,le.brand_code_2_CAPS_ErrorCount,le.brand_code_2_ALLOW_ErrorCount
          ,le.brand_date_2_ALLOW_ErrorCount,le.brand_date_2_LENGTH_ErrorCount
          ,le.brand_state_2_ALLOW_ErrorCount,le.brand_state_2_LENGTH_ErrorCount
          ,le.brand_code_3_CAPS_ErrorCount,le.brand_code_3_ALLOW_ErrorCount
          ,le.brand_date_3_ALLOW_ErrorCount,le.brand_date_3_LENGTH_ErrorCount
          ,le.brand_state_3_ALLOW_ErrorCount,le.brand_state_3_LENGTH_ErrorCount
          ,le.brand_code_4_CAPS_ErrorCount,le.brand_code_4_ALLOW_ErrorCount
          ,le.brand_date_4_ALLOW_ErrorCount,le.brand_date_4_LENGTH_ErrorCount
          ,le.brand_state_4_ALLOW_ErrorCount,le.brand_state_4_LENGTH_ErrorCount
          ,le.brand_code_5_CAPS_ErrorCount,le.brand_code_5_ALLOW_ErrorCount
          ,le.brand_date_5_ALLOW_ErrorCount,le.brand_date_5_LENGTH_ErrorCount
          ,le.brand_state_5_ALLOW_ErrorCount,le.brand_state_5_LENGTH_ErrorCount
          ,le.tod_flag_ENUM_ErrorCount,le.tod_flag_LENGTH_ErrorCount
          ,le.model_class_CAPS_ErrorCount,le.model_class_ALLOW_ErrorCount
          ,le.min_door_count_ALLOW_ErrorCount,le.min_door_count_LENGTH_ErrorCount
          ,le.safety_type_CAPS_ErrorCount,le.safety_type_ALLOW_ErrorCount
          ,le.airbag_driver_CAPS_ErrorCount,le.airbag_driver_ALLOW_ErrorCount
          ,le.airbag_front_driver_side_CAPS_ErrorCount,le.airbag_front_driver_side_ALLOW_ErrorCount
          ,le.airbag_front_head_curtain_CAPS_ErrorCount,le.airbag_front_head_curtain_ALLOW_ErrorCount
          ,le.airbag_front_pass_CAPS_ErrorCount,le.airbag_front_pass_ALLOW_ErrorCount
          ,le.airbag_front_pass_side_CAPS_ErrorCount,le.airbag_front_pass_side_ALLOW_ErrorCount
          ,le.airbags_CAPS_ErrorCount,le.airbags_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.append_process_date_ALLOW_ErrorCount,le.append_process_date_LENGTH_ErrorCount
          ,le.append_state_origin_ALLOW_ErrorCount,le.append_state_origin_LENGTH_ErrorCount
          ,le.file_typ_ENUM_ErrorCount,le.file_typ_LENGTH_ErrorCount
          ,le.vin_CAPS_ErrorCount,le.vin_ALLOW_ErrorCount,le.vin_LENGTH_ErrorCount
          ,le.vehicle_typ_ENUM_ErrorCount,le.vehicle_typ_LENGTH_ErrorCount
          ,le.model_yr_ALLOW_ErrorCount,le.model_yr_LENGTH_ErrorCount
          ,le.model_yr_ind_ENUM_ErrorCount,le.model_yr_ind_LENGTH_ErrorCount
          ,le.make_CAPS_ErrorCount,le.make_ALLOW_ErrorCount
          ,le.make_ind_ENUM_ErrorCount,le.make_ind_LENGTH_ErrorCount
          ,le.series_CAPS_ErrorCount,le.series_ALLOW_ErrorCount
          ,le.series_ind_ENUM_ErrorCount,le.series_ind_LENGTH_ErrorCount
          ,le.prime_color_CAPS_ErrorCount,le.prime_color_ALLOW_ErrorCount
          ,le.second_color_CAPS_ErrorCount,le.second_color_ALLOW_ErrorCount
          ,le.body_style_CAPS_ErrorCount,le.body_style_ALLOW_ErrorCount
          ,le.body_style_ind_ENUM_ErrorCount,le.body_style_ind_LENGTH_ErrorCount
          ,le.model_CAPS_ErrorCount,le.model_ALLOW_ErrorCount
          ,le.model_ind_ENUM_ErrorCount,le.model_ind_LENGTH_ErrorCount
          ,le.weight_ALLOW_ErrorCount
          ,le.lengt_ALLOW_ErrorCount
          ,le.axle_cnt_ALLOW_ErrorCount
          ,le.plate_nbr_CAPS_ErrorCount,le.plate_nbr_ALLOW_ErrorCount
          ,le.plate_state_ALLOW_ErrorCount,le.plate_state_LENGTH_ErrorCount
          ,le.prev_plate_nbr_CAPS_ErrorCount,le.prev_plate_nbr_ALLOW_ErrorCount
          ,le.prev_plate_state_ALLOW_ErrorCount,le.prev_plate_state_LENGTH_ErrorCount
          ,le.plate_typ_cd_CAPS_ErrorCount,le.plate_typ_cd_ALLOW_ErrorCount
          ,le.mstr_src_state_ALLOW_ErrorCount,le.mstr_src_state_LENGTH_ErrorCount
          ,le.reg_decal_nbr_CAPS_ErrorCount,le.reg_decal_nbr_ALLOW_ErrorCount
          ,le.org_reg_dt_ALLOW_ErrorCount,le.org_reg_dt_LENGTH_ErrorCount
          ,le.reg_renew_dt_ALLOW_ErrorCount,le.reg_renew_dt_LENGTH_ErrorCount
          ,le.reg_exp_dt_ALLOW_ErrorCount,le.reg_exp_dt_LENGTH_ErrorCount
          ,le.title_nbr_CAPS_ErrorCount,le.title_nbr_ALLOW_ErrorCount
          ,le.org_title_dt_ALLOW_ErrorCount,le.org_title_dt_LENGTH_ErrorCount
          ,le.title_trans_dt_ALLOW_ErrorCount,le.title_trans_dt_LENGTH_ErrorCount
          ,le.name_typ_cd_ENUM_ErrorCount,le.name_typ_cd_LENGTH_ErrorCount
          ,le.owner_typ_cd_ENUM_ErrorCount,le.owner_typ_cd_LENGTH_ErrorCount
          ,le.first_nm_CAPS_ErrorCount,le.first_nm_ALLOW_ErrorCount
          ,le.middle_nm_CAPS_ErrorCount,le.middle_nm_ALLOW_ErrorCount
          ,le.last_nm_CAPS_ErrorCount,le.last_nm_ALLOW_ErrorCount
          ,le.name_suffix_CAPS_ErrorCount,le.name_suffix_ALLOW_ErrorCount
          ,le.prof_suffix_CAPS_ErrorCount,le.prof_suffix_ALLOW_ErrorCount
          ,le.ind_ssn_ALLOW_ErrorCount,le.ind_ssn_LENGTH_ErrorCount
          ,le.ind_dob_ALLOW_ErrorCount,le.ind_dob_LENGTH_ErrorCount
          ,le.mail_range_CAPS_ErrorCount,le.mail_range_ALLOW_ErrorCount
          ,le.m_pre_dir_CAPS_ErrorCount,le.m_pre_dir_ALLOW_ErrorCount
          ,le.m_street_CAPS_ErrorCount,le.m_street_ALLOW_ErrorCount
          ,le.m_suffix_CAPS_ErrorCount,le.m_suffix_ALLOW_ErrorCount
          ,le.m_post_dir_CAPS_ErrorCount,le.m_post_dir_ALLOW_ErrorCount
          ,le.m_pob_CAPS_ErrorCount,le.m_pob_ALLOW_ErrorCount
          ,le.m_rr_nbr_CAPS_ErrorCount,le.m_rr_nbr_ALLOW_ErrorCount
          ,le.m_rr_box_CAPS_ErrorCount,le.m_rr_box_ALLOW_ErrorCount
          ,le.m_scndry_rng_CAPS_ErrorCount,le.m_scndry_rng_ALLOW_ErrorCount
          ,le.m_scndry_des_CAPS_ErrorCount,le.m_scndry_des_ALLOW_ErrorCount
          ,le.m_city_CAPS_ErrorCount,le.m_city_ALLOW_ErrorCount
          ,le.m_state_ALLOW_ErrorCount,le.m_state_LENGTH_ErrorCount
          ,le.m_zip5_ALLOW_ErrorCount,le.m_zip5_LENGTH_ErrorCount
          ,le.m_zip4_ALLOW_ErrorCount,le.m_zip4_LENGTH_ErrorCount
          ,le.m_cc_ENUM_ErrorCount,le.m_cc_LENGTH_ErrorCount
          ,le.m_county_CAPS_ErrorCount,le.m_county_ALLOW_ErrorCount
          ,le.phys_range_CAPS_ErrorCount,le.phys_range_ALLOW_ErrorCount
          ,le.p_pre_dir_CAPS_ErrorCount,le.p_pre_dir_ALLOW_ErrorCount
          ,le.p_street_CAPS_ErrorCount,le.p_street_ALLOW_ErrorCount
          ,le.p_suffix_CAPS_ErrorCount,le.p_suffix_ALLOW_ErrorCount
          ,le.p_post_dir_CAPS_ErrorCount,le.p_post_dir_ALLOW_ErrorCount
          ,le.p_pob_CAPS_ErrorCount,le.p_pob_ALLOW_ErrorCount
          ,le.p_rr_nbr_CAPS_ErrorCount,le.p_rr_nbr_ALLOW_ErrorCount
          ,le.p_rr_box_CAPS_ErrorCount,le.p_rr_box_ALLOW_ErrorCount
          ,le.p_scndry_rng_CAPS_ErrorCount,le.p_scndry_rng_ALLOW_ErrorCount
          ,le.p_scndry_des_CAPS_ErrorCount,le.p_scndry_des_ALLOW_ErrorCount
          ,le.p_city_CAPS_ErrorCount,le.p_city_ALLOW_ErrorCount
          ,le.p_state_ALLOW_ErrorCount,le.p_state_LENGTH_ErrorCount
          ,le.p_zip5_ALLOW_ErrorCount,le.p_zip5_LENGTH_ErrorCount
          ,le.p_zip4_ALLOW_ErrorCount,le.p_zip4_LENGTH_ErrorCount
          ,le.p_cc_ENUM_ErrorCount,le.p_cc_LENGTH_ErrorCount
          ,le.p_county_CAPS_ErrorCount,le.p_county_ALLOW_ErrorCount
          ,le.opt_out_cd_ENUM_ErrorCount,le.opt_out_cd_LENGTH_ErrorCount
          ,le.asg_wgt_ALLOW_ErrorCount
          ,le.asg_wgt_uom_CAPS_ErrorCount,le.asg_wgt_uom_ALLOW_ErrorCount
          ,le.source_ctl_id_ALLOW_ErrorCount
          ,le.raw_name_CAPS_ErrorCount,le.raw_name_ALLOW_ErrorCount
          ,le.branded_title_flag_ENUM_ErrorCount,le.branded_title_flag_LENGTH_ErrorCount
          ,le.brand_code_1_CAPS_ErrorCount,le.brand_code_1_ALLOW_ErrorCount
          ,le.brand_date_1_ALLOW_ErrorCount,le.brand_date_1_LENGTH_ErrorCount
          ,le.brand_state_1_ALLOW_ErrorCount,le.brand_state_1_LENGTH_ErrorCount
          ,le.brand_code_2_CAPS_ErrorCount,le.brand_code_2_ALLOW_ErrorCount
          ,le.brand_date_2_ALLOW_ErrorCount,le.brand_date_2_LENGTH_ErrorCount
          ,le.brand_state_2_ALLOW_ErrorCount,le.brand_state_2_LENGTH_ErrorCount
          ,le.brand_code_3_CAPS_ErrorCount,le.brand_code_3_ALLOW_ErrorCount
          ,le.brand_date_3_ALLOW_ErrorCount,le.brand_date_3_LENGTH_ErrorCount
          ,le.brand_state_3_ALLOW_ErrorCount,le.brand_state_3_LENGTH_ErrorCount
          ,le.brand_code_4_CAPS_ErrorCount,le.brand_code_4_ALLOW_ErrorCount
          ,le.brand_date_4_ALLOW_ErrorCount,le.brand_date_4_LENGTH_ErrorCount
          ,le.brand_state_4_ALLOW_ErrorCount,le.brand_state_4_LENGTH_ErrorCount
          ,le.brand_code_5_CAPS_ErrorCount,le.brand_code_5_ALLOW_ErrorCount
          ,le.brand_date_5_ALLOW_ErrorCount,le.brand_date_5_LENGTH_ErrorCount
          ,le.brand_state_5_ALLOW_ErrorCount,le.brand_state_5_LENGTH_ErrorCount
          ,le.tod_flag_ENUM_ErrorCount,le.tod_flag_LENGTH_ErrorCount
          ,le.model_class_CAPS_ErrorCount,le.model_class_ALLOW_ErrorCount
          ,le.min_door_count_ALLOW_ErrorCount,le.min_door_count_LENGTH_ErrorCount
          ,le.safety_type_CAPS_ErrorCount,le.safety_type_ALLOW_ErrorCount
          ,le.airbag_driver_CAPS_ErrorCount,le.airbag_driver_ALLOW_ErrorCount
          ,le.airbag_front_driver_side_CAPS_ErrorCount,le.airbag_front_driver_side_ALLOW_ErrorCount
          ,le.airbag_front_head_curtain_CAPS_ErrorCount,le.airbag_front_head_curtain_ALLOW_ErrorCount
          ,le.airbag_front_pass_CAPS_ErrorCount,le.airbag_front_pass_ALLOW_ErrorCount
          ,le.airbag_front_pass_side_CAPS_ErrorCount,le.airbag_front_pass_side_ALLOW_ErrorCount
          ,le.airbags_CAPS_ErrorCount,le.airbags_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,206,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
