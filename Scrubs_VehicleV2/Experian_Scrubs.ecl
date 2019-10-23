IMPORT SALT311,STD;
EXPORT Experian_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 159;
  EXPORT NumRulesFromFieldType := 159;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 105;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Experian_Layout_VehicleV2)
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
  EXPORT  Bitmap_Layout := RECORD(Experian_Layout_VehicleV2)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
  END;
EXPORT FromNone(DATASET(Experian_Layout_VehicleV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.append_process_date_Invalid := Experian_Fields.InValid_append_process_date((SALT311.StrType)le.append_process_date);
    SELF.append_state_origin_Invalid := Experian_Fields.InValid_append_state_origin((SALT311.StrType)le.append_state_origin);
    SELF.file_typ_Invalid := Experian_Fields.InValid_file_typ((SALT311.StrType)le.file_typ);
    SELF.vin_Invalid := Experian_Fields.InValid_vin((SALT311.StrType)le.vin);
    SELF.vehicle_typ_Invalid := Experian_Fields.InValid_vehicle_typ((SALT311.StrType)le.vehicle_typ);
    SELF.model_yr_Invalid := Experian_Fields.InValid_model_yr((SALT311.StrType)le.model_yr);
    SELF.model_yr_ind_Invalid := Experian_Fields.InValid_model_yr_ind((SALT311.StrType)le.model_yr_ind);
    SELF.make_Invalid := Experian_Fields.InValid_make((SALT311.StrType)le.make);
    SELF.make_ind_Invalid := Experian_Fields.InValid_make_ind((SALT311.StrType)le.make_ind);
    SELF.series_Invalid := Experian_Fields.InValid_series((SALT311.StrType)le.series);
    SELF.series_ind_Invalid := Experian_Fields.InValid_series_ind((SALT311.StrType)le.series_ind);
    SELF.prime_color_Invalid := Experian_Fields.InValid_prime_color((SALT311.StrType)le.prime_color);
    SELF.second_color_Invalid := Experian_Fields.InValid_second_color((SALT311.StrType)le.second_color);
    SELF.body_style_Invalid := Experian_Fields.InValid_body_style((SALT311.StrType)le.body_style);
    SELF.body_style_ind_Invalid := Experian_Fields.InValid_body_style_ind((SALT311.StrType)le.body_style_ind);
    SELF.model_Invalid := Experian_Fields.InValid_model((SALT311.StrType)le.model);
    SELF.model_ind_Invalid := Experian_Fields.InValid_model_ind((SALT311.StrType)le.model_ind);
    SELF.weight_Invalid := Experian_Fields.InValid_weight((SALT311.StrType)le.weight);
    SELF.lengt_Invalid := Experian_Fields.InValid_lengt((SALT311.StrType)le.lengt);
    SELF.axle_cnt_Invalid := Experian_Fields.InValid_axle_cnt((SALT311.StrType)le.axle_cnt);
    SELF.plate_nbr_Invalid := Experian_Fields.InValid_plate_nbr((SALT311.StrType)le.plate_nbr);
    SELF.plate_state_Invalid := Experian_Fields.InValid_plate_state((SALT311.StrType)le.plate_state);
    SELF.prev_plate_nbr_Invalid := Experian_Fields.InValid_prev_plate_nbr((SALT311.StrType)le.prev_plate_nbr);
    SELF.prev_plate_state_Invalid := Experian_Fields.InValid_prev_plate_state((SALT311.StrType)le.prev_plate_state);
    SELF.plate_typ_cd_Invalid := Experian_Fields.InValid_plate_typ_cd((SALT311.StrType)le.plate_typ_cd);
    SELF.mstr_src_state_Invalid := Experian_Fields.InValid_mstr_src_state((SALT311.StrType)le.mstr_src_state);
    SELF.reg_decal_nbr_Invalid := Experian_Fields.InValid_reg_decal_nbr((SALT311.StrType)le.reg_decal_nbr);
    SELF.org_reg_dt_Invalid := Experian_Fields.InValid_org_reg_dt((SALT311.StrType)le.org_reg_dt);
    SELF.reg_renew_dt_Invalid := Experian_Fields.InValid_reg_renew_dt((SALT311.StrType)le.reg_renew_dt);
    SELF.reg_exp_dt_Invalid := Experian_Fields.InValid_reg_exp_dt((SALT311.StrType)le.reg_exp_dt);
    SELF.title_nbr_Invalid := Experian_Fields.InValid_title_nbr((SALT311.StrType)le.title_nbr);
    SELF.org_title_dt_Invalid := Experian_Fields.InValid_org_title_dt((SALT311.StrType)le.org_title_dt);
    SELF.title_trans_dt_Invalid := Experian_Fields.InValid_title_trans_dt((SALT311.StrType)le.title_trans_dt);
    SELF.name_typ_cd_Invalid := Experian_Fields.InValid_name_typ_cd((SALT311.StrType)le.name_typ_cd);
    SELF.owner_typ_cd_Invalid := Experian_Fields.InValid_owner_typ_cd((SALT311.StrType)le.owner_typ_cd);
    SELF.first_nm_Invalid := Experian_Fields.InValid_first_nm((SALT311.StrType)le.first_nm);
    SELF.middle_nm_Invalid := Experian_Fields.InValid_middle_nm((SALT311.StrType)le.middle_nm);
    SELF.last_nm_Invalid := Experian_Fields.InValid_last_nm((SALT311.StrType)le.last_nm);
    SELF.name_suffix_Invalid := Experian_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.prof_suffix_Invalid := Experian_Fields.InValid_prof_suffix((SALT311.StrType)le.prof_suffix);
    SELF.ind_ssn_Invalid := Experian_Fields.InValid_ind_ssn((SALT311.StrType)le.ind_ssn);
    SELF.ind_dob_Invalid := Experian_Fields.InValid_ind_dob((SALT311.StrType)le.ind_dob);
    SELF.mail_range_Invalid := Experian_Fields.InValid_mail_range((SALT311.StrType)le.mail_range);
    SELF.m_pre_dir_Invalid := Experian_Fields.InValid_m_pre_dir((SALT311.StrType)le.m_pre_dir);
    SELF.m_street_Invalid := Experian_Fields.InValid_m_street((SALT311.StrType)le.m_street);
    SELF.m_suffix_Invalid := Experian_Fields.InValid_m_suffix((SALT311.StrType)le.m_suffix);
    SELF.m_post_dir_Invalid := Experian_Fields.InValid_m_post_dir((SALT311.StrType)le.m_post_dir);
    SELF.m_pob_Invalid := Experian_Fields.InValid_m_pob((SALT311.StrType)le.m_pob);
    SELF.m_rr_nbr_Invalid := Experian_Fields.InValid_m_rr_nbr((SALT311.StrType)le.m_rr_nbr);
    SELF.m_rr_box_Invalid := Experian_Fields.InValid_m_rr_box((SALT311.StrType)le.m_rr_box);
    SELF.m_scndry_rng_Invalid := Experian_Fields.InValid_m_scndry_rng((SALT311.StrType)le.m_scndry_rng);
    SELF.m_scndry_des_Invalid := Experian_Fields.InValid_m_scndry_des((SALT311.StrType)le.m_scndry_des);
    SELF.m_city_Invalid := Experian_Fields.InValid_m_city((SALT311.StrType)le.m_city);
    SELF.m_state_Invalid := Experian_Fields.InValid_m_state((SALT311.StrType)le.m_state);
    SELF.m_zip5_Invalid := Experian_Fields.InValid_m_zip5((SALT311.StrType)le.m_zip5);
    SELF.m_zip4_Invalid := Experian_Fields.InValid_m_zip4((SALT311.StrType)le.m_zip4);
    SELF.m_cc_Invalid := Experian_Fields.InValid_m_cc((SALT311.StrType)le.m_cc);
    SELF.m_county_Invalid := Experian_Fields.InValid_m_county((SALT311.StrType)le.m_county);
    SELF.phys_range_Invalid := Experian_Fields.InValid_phys_range((SALT311.StrType)le.phys_range);
    SELF.p_pre_dir_Invalid := Experian_Fields.InValid_p_pre_dir((SALT311.StrType)le.p_pre_dir);
    SELF.p_street_Invalid := Experian_Fields.InValid_p_street((SALT311.StrType)le.p_street);
    SELF.p_suffix_Invalid := Experian_Fields.InValid_p_suffix((SALT311.StrType)le.p_suffix);
    SELF.p_post_dir_Invalid := Experian_Fields.InValid_p_post_dir((SALT311.StrType)le.p_post_dir);
    SELF.p_pob_Invalid := Experian_Fields.InValid_p_pob((SALT311.StrType)le.p_pob);
    SELF.p_rr_nbr_Invalid := Experian_Fields.InValid_p_rr_nbr((SALT311.StrType)le.p_rr_nbr);
    SELF.p_rr_box_Invalid := Experian_Fields.InValid_p_rr_box((SALT311.StrType)le.p_rr_box);
    SELF.p_scndry_rng_Invalid := Experian_Fields.InValid_p_scndry_rng((SALT311.StrType)le.p_scndry_rng);
    SELF.p_scndry_des_Invalid := Experian_Fields.InValid_p_scndry_des((SALT311.StrType)le.p_scndry_des);
    SELF.p_city_Invalid := Experian_Fields.InValid_p_city((SALT311.StrType)le.p_city);
    SELF.p_state_Invalid := Experian_Fields.InValid_p_state((SALT311.StrType)le.p_state);
    SELF.p_zip5_Invalid := Experian_Fields.InValid_p_zip5((SALT311.StrType)le.p_zip5);
    SELF.p_zip4_Invalid := Experian_Fields.InValid_p_zip4((SALT311.StrType)le.p_zip4);
    SELF.p_cc_Invalid := Experian_Fields.InValid_p_cc((SALT311.StrType)le.p_cc);
    SELF.p_county_Invalid := Experian_Fields.InValid_p_county((SALT311.StrType)le.p_county);
    SELF.opt_out_cd_Invalid := Experian_Fields.InValid_opt_out_cd((SALT311.StrType)le.opt_out_cd);
    SELF.asg_wgt_Invalid := Experian_Fields.InValid_asg_wgt((SALT311.StrType)le.asg_wgt);
    SELF.asg_wgt_uom_Invalid := Experian_Fields.InValid_asg_wgt_uom((SALT311.StrType)le.asg_wgt_uom);
    SELF.source_ctl_id_Invalid := Experian_Fields.InValid_source_ctl_id((SALT311.StrType)le.source_ctl_id);
    SELF.raw_name_Invalid := Experian_Fields.InValid_raw_name((SALT311.StrType)le.raw_name);
    SELF.branded_title_flag_Invalid := Experian_Fields.InValid_branded_title_flag((SALT311.StrType)le.branded_title_flag);
    SELF.brand_code_1_Invalid := Experian_Fields.InValid_brand_code_1((SALT311.StrType)le.brand_code_1);
    SELF.brand_date_1_Invalid := Experian_Fields.InValid_brand_date_1((SALT311.StrType)le.brand_date_1);
    SELF.brand_state_1_Invalid := Experian_Fields.InValid_brand_state_1((SALT311.StrType)le.brand_state_1);
    SELF.brand_code_2_Invalid := Experian_Fields.InValid_brand_code_2((SALT311.StrType)le.brand_code_2);
    SELF.brand_date_2_Invalid := Experian_Fields.InValid_brand_date_2((SALT311.StrType)le.brand_date_2);
    SELF.brand_state_2_Invalid := Experian_Fields.InValid_brand_state_2((SALT311.StrType)le.brand_state_2);
    SELF.brand_code_3_Invalid := Experian_Fields.InValid_brand_code_3((SALT311.StrType)le.brand_code_3);
    SELF.brand_date_3_Invalid := Experian_Fields.InValid_brand_date_3((SALT311.StrType)le.brand_date_3);
    SELF.brand_state_3_Invalid := Experian_Fields.InValid_brand_state_3((SALT311.StrType)le.brand_state_3);
    SELF.brand_code_4_Invalid := Experian_Fields.InValid_brand_code_4((SALT311.StrType)le.brand_code_4);
    SELF.brand_date_4_Invalid := Experian_Fields.InValid_brand_date_4((SALT311.StrType)le.brand_date_4);
    SELF.brand_state_4_Invalid := Experian_Fields.InValid_brand_state_4((SALT311.StrType)le.brand_state_4);
    SELF.brand_code_5_Invalid := Experian_Fields.InValid_brand_code_5((SALT311.StrType)le.brand_code_5);
    SELF.brand_date_5_Invalid := Experian_Fields.InValid_brand_date_5((SALT311.StrType)le.brand_date_5);
    SELF.brand_state_5_Invalid := Experian_Fields.InValid_brand_state_5((SALT311.StrType)le.brand_state_5);
    SELF.tod_flag_Invalid := Experian_Fields.InValid_tod_flag((SALT311.StrType)le.tod_flag);
    SELF.model_class_Invalid := Experian_Fields.InValid_model_class((SALT311.StrType)le.model_class);
    SELF.min_door_count_Invalid := Experian_Fields.InValid_min_door_count((SALT311.StrType)le.min_door_count);
    SELF.safety_type_Invalid := Experian_Fields.InValid_safety_type((SALT311.StrType)le.safety_type);
    SELF.airbag_driver_Invalid := Experian_Fields.InValid_airbag_driver((SALT311.StrType)le.airbag_driver);
    SELF.airbag_front_driver_side_Invalid := Experian_Fields.InValid_airbag_front_driver_side((SALT311.StrType)le.airbag_front_driver_side);
    SELF.airbag_front_head_curtain_Invalid := Experian_Fields.InValid_airbag_front_head_curtain((SALT311.StrType)le.airbag_front_head_curtain);
    SELF.airbag_front_pass_Invalid := Experian_Fields.InValid_airbag_front_pass((SALT311.StrType)le.airbag_front_pass);
    SELF.airbag_front_pass_side_Invalid := Experian_Fields.InValid_airbag_front_pass_side((SALT311.StrType)le.airbag_front_pass_side);
    SELF.airbags_Invalid := Experian_Fields.InValid_airbags((SALT311.StrType)le.airbags);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Experian_Layout_VehicleV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.append_process_date_Invalid << 0 ) + ( le.append_state_origin_Invalid << 2 ) + ( le.file_typ_Invalid << 4 ) + ( le.vin_Invalid << 6 ) + ( le.vehicle_typ_Invalid << 8 ) + ( le.model_yr_Invalid << 10 ) + ( le.model_yr_ind_Invalid << 12 ) + ( le.make_Invalid << 14 ) + ( le.make_ind_Invalid << 15 ) + ( le.series_Invalid << 17 ) + ( le.series_ind_Invalid << 18 ) + ( le.prime_color_Invalid << 20 ) + ( le.second_color_Invalid << 22 ) + ( le.body_style_Invalid << 24 ) + ( le.body_style_ind_Invalid << 25 ) + ( le.model_Invalid << 27 ) + ( le.model_ind_Invalid << 28 ) + ( le.weight_Invalid << 30 ) + ( le.lengt_Invalid << 31 ) + ( le.axle_cnt_Invalid << 32 ) + ( le.plate_nbr_Invalid << 33 ) + ( le.plate_state_Invalid << 34 ) + ( le.prev_plate_nbr_Invalid << 36 ) + ( le.prev_plate_state_Invalid << 37 ) + ( le.plate_typ_cd_Invalid << 39 ) + ( le.mstr_src_state_Invalid << 41 ) + ( le.reg_decal_nbr_Invalid << 43 ) + ( le.org_reg_dt_Invalid << 44 ) + ( le.reg_renew_dt_Invalid << 46 ) + ( le.reg_exp_dt_Invalid << 48 ) + ( le.title_nbr_Invalid << 50 ) + ( le.org_title_dt_Invalid << 51 ) + ( le.title_trans_dt_Invalid << 53 ) + ( le.name_typ_cd_Invalid << 55 ) + ( le.owner_typ_cd_Invalid << 57 ) + ( le.first_nm_Invalid << 59 ) + ( le.middle_nm_Invalid << 60 ) + ( le.last_nm_Invalid << 61 ) + ( le.name_suffix_Invalid << 62 ) + ( le.prof_suffix_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.ind_ssn_Invalid << 0 ) + ( le.ind_dob_Invalid << 2 ) + ( le.mail_range_Invalid << 4 ) + ( le.m_pre_dir_Invalid << 5 ) + ( le.m_street_Invalid << 6 ) + ( le.m_suffix_Invalid << 7 ) + ( le.m_post_dir_Invalid << 8 ) + ( le.m_pob_Invalid << 9 ) + ( le.m_rr_nbr_Invalid << 10 ) + ( le.m_rr_box_Invalid << 11 ) + ( le.m_scndry_rng_Invalid << 12 ) + ( le.m_scndry_des_Invalid << 13 ) + ( le.m_city_Invalid << 14 ) + ( le.m_state_Invalid << 15 ) + ( le.m_zip5_Invalid << 17 ) + ( le.m_zip4_Invalid << 19 ) + ( le.m_cc_Invalid << 21 ) + ( le.m_county_Invalid << 23 ) + ( le.phys_range_Invalid << 24 ) + ( le.p_pre_dir_Invalid << 25 ) + ( le.p_street_Invalid << 26 ) + ( le.p_suffix_Invalid << 27 ) + ( le.p_post_dir_Invalid << 28 ) + ( le.p_pob_Invalid << 29 ) + ( le.p_rr_nbr_Invalid << 30 ) + ( le.p_rr_box_Invalid << 31 ) + ( le.p_scndry_rng_Invalid << 32 ) + ( le.p_scndry_des_Invalid << 33 ) + ( le.p_city_Invalid << 34 ) + ( le.p_state_Invalid << 35 ) + ( le.p_zip5_Invalid << 37 ) + ( le.p_zip4_Invalid << 39 ) + ( le.p_cc_Invalid << 41 ) + ( le.p_county_Invalid << 43 ) + ( le.opt_out_cd_Invalid << 44 ) + ( le.asg_wgt_Invalid << 46 ) + ( le.asg_wgt_uom_Invalid << 47 ) + ( le.source_ctl_id_Invalid << 49 ) + ( le.raw_name_Invalid << 50 ) + ( le.branded_title_flag_Invalid << 51 ) + ( le.brand_code_1_Invalid << 53 ) + ( le.brand_date_1_Invalid << 55 ) + ( le.brand_state_1_Invalid << 57 ) + ( le.brand_code_2_Invalid << 59 ) + ( le.brand_date_2_Invalid << 61 );
    SELF.ScrubsBits3 := ( le.brand_state_2_Invalid << 0 ) + ( le.brand_code_3_Invalid << 2 ) + ( le.brand_date_3_Invalid << 4 ) + ( le.brand_state_3_Invalid << 6 ) + ( le.brand_code_4_Invalid << 8 ) + ( le.brand_date_4_Invalid << 10 ) + ( le.brand_state_4_Invalid << 12 ) + ( le.brand_code_5_Invalid << 14 ) + ( le.brand_date_5_Invalid << 16 ) + ( le.brand_state_5_Invalid << 18 ) + ( le.tod_flag_Invalid << 20 ) + ( le.model_class_Invalid << 22 ) + ( le.min_door_count_Invalid << 23 ) + ( le.safety_type_Invalid << 25 ) + ( le.airbag_driver_Invalid << 26 ) + ( le.airbag_front_driver_side_Invalid << 27 ) + ( le.airbag_front_head_curtain_Invalid << 28 ) + ( le.airbag_front_pass_Invalid << 29 ) + ( le.airbag_front_pass_side_Invalid << 30 ) + ( le.airbags_Invalid << 31 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Experian_Layout_VehicleV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.append_state_origin_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.file_typ_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.vin_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.vehicle_typ_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.model_yr_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.model_yr_ind_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.make_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.make_ind_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.series_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.series_ind_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.prime_color_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.second_color_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.body_style_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.body_style_ind_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.model_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.model_ind_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.weight_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.lengt_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.axle_cnt_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.plate_nbr_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.plate_state_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.prev_plate_nbr_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.prev_plate_state_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.plate_typ_cd_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.mstr_src_state_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.reg_decal_nbr_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.org_reg_dt_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.reg_renew_dt_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.reg_exp_dt_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.title_nbr_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.org_title_dt_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.title_trans_dt_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.name_typ_cd_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.owner_typ_cd_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.first_nm_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.middle_nm_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.last_nm_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.prof_suffix_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.ind_ssn_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.ind_dob_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.mail_range_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.m_pre_dir_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.m_street_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.m_suffix_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.m_post_dir_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.m_pob_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.m_rr_nbr_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.m_rr_box_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.m_scndry_rng_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.m_scndry_des_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.m_city_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.m_state_Invalid := (le.ScrubsBits2 >> 15) & 3;
    SELF.m_zip5_Invalid := (le.ScrubsBits2 >> 17) & 3;
    SELF.m_zip4_Invalid := (le.ScrubsBits2 >> 19) & 3;
    SELF.m_cc_Invalid := (le.ScrubsBits2 >> 21) & 3;
    SELF.m_county_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.phys_range_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.p_pre_dir_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.p_street_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.p_suffix_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.p_post_dir_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.p_pob_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.p_rr_nbr_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.p_rr_box_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.p_scndry_rng_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.p_scndry_des_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.p_city_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.p_state_Invalid := (le.ScrubsBits2 >> 35) & 3;
    SELF.p_zip5_Invalid := (le.ScrubsBits2 >> 37) & 3;
    SELF.p_zip4_Invalid := (le.ScrubsBits2 >> 39) & 3;
    SELF.p_cc_Invalid := (le.ScrubsBits2 >> 41) & 3;
    SELF.p_county_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.opt_out_cd_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.asg_wgt_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.asg_wgt_uom_Invalid := (le.ScrubsBits2 >> 47) & 3;
    SELF.source_ctl_id_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.raw_name_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.branded_title_flag_Invalid := (le.ScrubsBits2 >> 51) & 3;
    SELF.brand_code_1_Invalid := (le.ScrubsBits2 >> 53) & 3;
    SELF.brand_date_1_Invalid := (le.ScrubsBits2 >> 55) & 3;
    SELF.brand_state_1_Invalid := (le.ScrubsBits2 >> 57) & 3;
    SELF.brand_code_2_Invalid := (le.ScrubsBits2 >> 59) & 3;
    SELF.brand_date_2_Invalid := (le.ScrubsBits2 >> 61) & 3;
    SELF.brand_state_2_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.brand_code_3_Invalid := (le.ScrubsBits3 >> 2) & 3;
    SELF.brand_date_3_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.brand_state_3_Invalid := (le.ScrubsBits3 >> 6) & 3;
    SELF.brand_code_4_Invalid := (le.ScrubsBits3 >> 8) & 3;
    SELF.brand_date_4_Invalid := (le.ScrubsBits3 >> 10) & 3;
    SELF.brand_state_4_Invalid := (le.ScrubsBits3 >> 12) & 3;
    SELF.brand_code_5_Invalid := (le.ScrubsBits3 >> 14) & 3;
    SELF.brand_date_5_Invalid := (le.ScrubsBits3 >> 16) & 3;
    SELF.brand_state_5_Invalid := (le.ScrubsBits3 >> 18) & 3;
    SELF.tod_flag_Invalid := (le.ScrubsBits3 >> 20) & 3;
    SELF.model_class_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.min_door_count_Invalid := (le.ScrubsBits3 >> 23) & 3;
    SELF.safety_type_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.airbag_driver_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF.airbag_front_driver_side_Invalid := (le.ScrubsBits3 >> 27) & 1;
    SELF.airbag_front_head_curtain_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.airbag_front_pass_Invalid := (le.ScrubsBits3 >> 29) & 1;
    SELF.airbag_front_pass_side_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.airbags_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.append_state_origin) append_state_origin := IF(Glob, '', h.append_state_origin);
    TotalCnt := COUNT(GROUP); // Number of records in total
    append_process_date_ALLOW_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=1);
    append_process_date_LENGTHS_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid=2);
    append_process_date_Total_ErrorCount := COUNT(GROUP,h.append_process_date_Invalid>0);
    append_state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.append_state_origin_Invalid=1);
    append_state_origin_LENGTHS_ErrorCount := COUNT(GROUP,h.append_state_origin_Invalid=2);
    append_state_origin_Total_ErrorCount := COUNT(GROUP,h.append_state_origin_Invalid>0);
    file_typ_ENUM_ErrorCount := COUNT(GROUP,h.file_typ_Invalid=1);
    file_typ_LENGTHS_ErrorCount := COUNT(GROUP,h.file_typ_Invalid=2);
    file_typ_Total_ErrorCount := COUNT(GROUP,h.file_typ_Invalid>0);
    vin_ALLOW_ErrorCount := COUNT(GROUP,h.vin_Invalid=1);
    vin_LENGTHS_ErrorCount := COUNT(GROUP,h.vin_Invalid=2);
    vin_Total_ErrorCount := COUNT(GROUP,h.vin_Invalid>0);
    vehicle_typ_ENUM_ErrorCount := COUNT(GROUP,h.vehicle_typ_Invalid=1);
    vehicle_typ_LENGTHS_ErrorCount := COUNT(GROUP,h.vehicle_typ_Invalid=2);
    vehicle_typ_Total_ErrorCount := COUNT(GROUP,h.vehicle_typ_Invalid>0);
    model_yr_ALLOW_ErrorCount := COUNT(GROUP,h.model_yr_Invalid=1);
    model_yr_LENGTHS_ErrorCount := COUNT(GROUP,h.model_yr_Invalid=2);
    model_yr_Total_ErrorCount := COUNT(GROUP,h.model_yr_Invalid>0);
    model_yr_ind_ENUM_ErrorCount := COUNT(GROUP,h.model_yr_ind_Invalid=1);
    model_yr_ind_LENGTHS_ErrorCount := COUNT(GROUP,h.model_yr_ind_Invalid=2);
    model_yr_ind_Total_ErrorCount := COUNT(GROUP,h.model_yr_ind_Invalid>0);
    make_ALLOW_ErrorCount := COUNT(GROUP,h.make_Invalid=1);
    make_ind_ENUM_ErrorCount := COUNT(GROUP,h.make_ind_Invalid=1);
    make_ind_LENGTHS_ErrorCount := COUNT(GROUP,h.make_ind_Invalid=2);
    make_ind_Total_ErrorCount := COUNT(GROUP,h.make_ind_Invalid>0);
    series_ALLOW_ErrorCount := COUNT(GROUP,h.series_Invalid=1);
    series_ind_ENUM_ErrorCount := COUNT(GROUP,h.series_ind_Invalid=1);
    series_ind_LENGTHS_ErrorCount := COUNT(GROUP,h.series_ind_Invalid=2);
    series_ind_Total_ErrorCount := COUNT(GROUP,h.series_ind_Invalid>0);
    prime_color_CAPS_ErrorCount := COUNT(GROUP,h.prime_color_Invalid=1);
    prime_color_ALLOW_ErrorCount := COUNT(GROUP,h.prime_color_Invalid=2);
    prime_color_Total_ErrorCount := COUNT(GROUP,h.prime_color_Invalid>0);
    second_color_CAPS_ErrorCount := COUNT(GROUP,h.second_color_Invalid=1);
    second_color_ALLOW_ErrorCount := COUNT(GROUP,h.second_color_Invalid=2);
    second_color_Total_ErrorCount := COUNT(GROUP,h.second_color_Invalid>0);
    body_style_ALLOW_ErrorCount := COUNT(GROUP,h.body_style_Invalid=1);
    body_style_ind_ENUM_ErrorCount := COUNT(GROUP,h.body_style_ind_Invalid=1);
    body_style_ind_LENGTHS_ErrorCount := COUNT(GROUP,h.body_style_ind_Invalid=2);
    body_style_ind_Total_ErrorCount := COUNT(GROUP,h.body_style_ind_Invalid>0);
    model_ALLOW_ErrorCount := COUNT(GROUP,h.model_Invalid=1);
    model_ind_ENUM_ErrorCount := COUNT(GROUP,h.model_ind_Invalid=1);
    model_ind_LENGTHS_ErrorCount := COUNT(GROUP,h.model_ind_Invalid=2);
    model_ind_Total_ErrorCount := COUNT(GROUP,h.model_ind_Invalid>0);
    weight_ALLOW_ErrorCount := COUNT(GROUP,h.weight_Invalid=1);
    lengt_ALLOW_ErrorCount := COUNT(GROUP,h.lengt_Invalid=1);
    axle_cnt_ALLOW_ErrorCount := COUNT(GROUP,h.axle_cnt_Invalid=1);
    plate_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.plate_nbr_Invalid=1);
    plate_state_ALLOW_ErrorCount := COUNT(GROUP,h.plate_state_Invalid=1);
    plate_state_LENGTHS_ErrorCount := COUNT(GROUP,h.plate_state_Invalid=2);
    plate_state_Total_ErrorCount := COUNT(GROUP,h.plate_state_Invalid>0);
    prev_plate_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.prev_plate_nbr_Invalid=1);
    prev_plate_state_ALLOW_ErrorCount := COUNT(GROUP,h.prev_plate_state_Invalid=1);
    prev_plate_state_LENGTHS_ErrorCount := COUNT(GROUP,h.prev_plate_state_Invalid=2);
    prev_plate_state_Total_ErrorCount := COUNT(GROUP,h.prev_plate_state_Invalid>0);
    plate_typ_cd_CAPS_ErrorCount := COUNT(GROUP,h.plate_typ_cd_Invalid=1);
    plate_typ_cd_ALLOW_ErrorCount := COUNT(GROUP,h.plate_typ_cd_Invalid=2);
    plate_typ_cd_Total_ErrorCount := COUNT(GROUP,h.plate_typ_cd_Invalid>0);
    mstr_src_state_ALLOW_ErrorCount := COUNT(GROUP,h.mstr_src_state_Invalid=1);
    mstr_src_state_LENGTHS_ErrorCount := COUNT(GROUP,h.mstr_src_state_Invalid=2);
    mstr_src_state_Total_ErrorCount := COUNT(GROUP,h.mstr_src_state_Invalid>0);
    reg_decal_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.reg_decal_nbr_Invalid=1);
    org_reg_dt_ALLOW_ErrorCount := COUNT(GROUP,h.org_reg_dt_Invalid=1);
    org_reg_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.org_reg_dt_Invalid=2);
    org_reg_dt_Total_ErrorCount := COUNT(GROUP,h.org_reg_dt_Invalid>0);
    reg_renew_dt_ALLOW_ErrorCount := COUNT(GROUP,h.reg_renew_dt_Invalid=1);
    reg_renew_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.reg_renew_dt_Invalid=2);
    reg_renew_dt_Total_ErrorCount := COUNT(GROUP,h.reg_renew_dt_Invalid>0);
    reg_exp_dt_ALLOW_ErrorCount := COUNT(GROUP,h.reg_exp_dt_Invalid=1);
    reg_exp_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.reg_exp_dt_Invalid=2);
    reg_exp_dt_Total_ErrorCount := COUNT(GROUP,h.reg_exp_dt_Invalid>0);
    title_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.title_nbr_Invalid=1);
    org_title_dt_ALLOW_ErrorCount := COUNT(GROUP,h.org_title_dt_Invalid=1);
    org_title_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.org_title_dt_Invalid=2);
    org_title_dt_Total_ErrorCount := COUNT(GROUP,h.org_title_dt_Invalid>0);
    title_trans_dt_ALLOW_ErrorCount := COUNT(GROUP,h.title_trans_dt_Invalid=1);
    title_trans_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.title_trans_dt_Invalid=2);
    title_trans_dt_Total_ErrorCount := COUNT(GROUP,h.title_trans_dt_Invalid>0);
    name_typ_cd_ENUM_ErrorCount := COUNT(GROUP,h.name_typ_cd_Invalid=1);
    name_typ_cd_LENGTHS_ErrorCount := COUNT(GROUP,h.name_typ_cd_Invalid=2);
    name_typ_cd_Total_ErrorCount := COUNT(GROUP,h.name_typ_cd_Invalid>0);
    owner_typ_cd_ENUM_ErrorCount := COUNT(GROUP,h.owner_typ_cd_Invalid=1);
    owner_typ_cd_LENGTHS_ErrorCount := COUNT(GROUP,h.owner_typ_cd_Invalid=2);
    owner_typ_cd_Total_ErrorCount := COUNT(GROUP,h.owner_typ_cd_Invalid>0);
    first_nm_ALLOW_ErrorCount := COUNT(GROUP,h.first_nm_Invalid=1);
    middle_nm_ALLOW_ErrorCount := COUNT(GROUP,h.middle_nm_Invalid=1);
    last_nm_ALLOW_ErrorCount := COUNT(GROUP,h.last_nm_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    prof_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.prof_suffix_Invalid=1);
    ind_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ind_ssn_Invalid=1);
    ind_ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.ind_ssn_Invalid=2);
    ind_ssn_Total_ErrorCount := COUNT(GROUP,h.ind_ssn_Invalid>0);
    ind_dob_ALLOW_ErrorCount := COUNT(GROUP,h.ind_dob_Invalid=1);
    ind_dob_LENGTHS_ErrorCount := COUNT(GROUP,h.ind_dob_Invalid=2);
    ind_dob_Total_ErrorCount := COUNT(GROUP,h.ind_dob_Invalid>0);
    mail_range_ALLOW_ErrorCount := COUNT(GROUP,h.mail_range_Invalid=1);
    m_pre_dir_ALLOW_ErrorCount := COUNT(GROUP,h.m_pre_dir_Invalid=1);
    m_street_ALLOW_ErrorCount := COUNT(GROUP,h.m_street_Invalid=1);
    m_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.m_suffix_Invalid=1);
    m_post_dir_ALLOW_ErrorCount := COUNT(GROUP,h.m_post_dir_Invalid=1);
    m_pob_ALLOW_ErrorCount := COUNT(GROUP,h.m_pob_Invalid=1);
    m_rr_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.m_rr_nbr_Invalid=1);
    m_rr_box_ALLOW_ErrorCount := COUNT(GROUP,h.m_rr_box_Invalid=1);
    m_scndry_rng_ALLOW_ErrorCount := COUNT(GROUP,h.m_scndry_rng_Invalid=1);
    m_scndry_des_ALLOW_ErrorCount := COUNT(GROUP,h.m_scndry_des_Invalid=1);
    m_city_ALLOW_ErrorCount := COUNT(GROUP,h.m_city_Invalid=1);
    m_state_ALLOW_ErrorCount := COUNT(GROUP,h.m_state_Invalid=1);
    m_state_LENGTHS_ErrorCount := COUNT(GROUP,h.m_state_Invalid=2);
    m_state_Total_ErrorCount := COUNT(GROUP,h.m_state_Invalid>0);
    m_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.m_zip5_Invalid=1);
    m_zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.m_zip5_Invalid=2);
    m_zip5_Total_ErrorCount := COUNT(GROUP,h.m_zip5_Invalid>0);
    m_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.m_zip4_Invalid=1);
    m_zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.m_zip4_Invalid=2);
    m_zip4_Total_ErrorCount := COUNT(GROUP,h.m_zip4_Invalid>0);
    m_cc_ENUM_ErrorCount := COUNT(GROUP,h.m_cc_Invalid=1);
    m_cc_LENGTHS_ErrorCount := COUNT(GROUP,h.m_cc_Invalid=2);
    m_cc_Total_ErrorCount := COUNT(GROUP,h.m_cc_Invalid>0);
    m_county_ALLOW_ErrorCount := COUNT(GROUP,h.m_county_Invalid=1);
    phys_range_ALLOW_ErrorCount := COUNT(GROUP,h.phys_range_Invalid=1);
    p_pre_dir_ALLOW_ErrorCount := COUNT(GROUP,h.p_pre_dir_Invalid=1);
    p_street_ALLOW_ErrorCount := COUNT(GROUP,h.p_street_Invalid=1);
    p_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.p_suffix_Invalid=1);
    p_post_dir_ALLOW_ErrorCount := COUNT(GROUP,h.p_post_dir_Invalid=1);
    p_pob_ALLOW_ErrorCount := COUNT(GROUP,h.p_pob_Invalid=1);
    p_rr_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.p_rr_nbr_Invalid=1);
    p_rr_box_ALLOW_ErrorCount := COUNT(GROUP,h.p_rr_box_Invalid=1);
    p_scndry_rng_ALLOW_ErrorCount := COUNT(GROUP,h.p_scndry_rng_Invalid=1);
    p_scndry_des_ALLOW_ErrorCount := COUNT(GROUP,h.p_scndry_des_Invalid=1);
    p_city_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_Invalid=1);
    p_state_ALLOW_ErrorCount := COUNT(GROUP,h.p_state_Invalid=1);
    p_state_LENGTHS_ErrorCount := COUNT(GROUP,h.p_state_Invalid=2);
    p_state_Total_ErrorCount := COUNT(GROUP,h.p_state_Invalid>0);
    p_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.p_zip5_Invalid=1);
    p_zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.p_zip5_Invalid=2);
    p_zip5_Total_ErrorCount := COUNT(GROUP,h.p_zip5_Invalid>0);
    p_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.p_zip4_Invalid=1);
    p_zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.p_zip4_Invalid=2);
    p_zip4_Total_ErrorCount := COUNT(GROUP,h.p_zip4_Invalid>0);
    p_cc_ENUM_ErrorCount := COUNT(GROUP,h.p_cc_Invalid=1);
    p_cc_LENGTHS_ErrorCount := COUNT(GROUP,h.p_cc_Invalid=2);
    p_cc_Total_ErrorCount := COUNT(GROUP,h.p_cc_Invalid>0);
    p_county_ALLOW_ErrorCount := COUNT(GROUP,h.p_county_Invalid=1);
    opt_out_cd_ENUM_ErrorCount := COUNT(GROUP,h.opt_out_cd_Invalid=1);
    opt_out_cd_LENGTHS_ErrorCount := COUNT(GROUP,h.opt_out_cd_Invalid=2);
    opt_out_cd_Total_ErrorCount := COUNT(GROUP,h.opt_out_cd_Invalid>0);
    asg_wgt_ALLOW_ErrorCount := COUNT(GROUP,h.asg_wgt_Invalid=1);
    asg_wgt_uom_CAPS_ErrorCount := COUNT(GROUP,h.asg_wgt_uom_Invalid=1);
    asg_wgt_uom_ALLOW_ErrorCount := COUNT(GROUP,h.asg_wgt_uom_Invalid=2);
    asg_wgt_uom_Total_ErrorCount := COUNT(GROUP,h.asg_wgt_uom_Invalid>0);
    source_ctl_id_ALLOW_ErrorCount := COUNT(GROUP,h.source_ctl_id_Invalid=1);
    raw_name_ALLOW_ErrorCount := COUNT(GROUP,h.raw_name_Invalid=1);
    branded_title_flag_ENUM_ErrorCount := COUNT(GROUP,h.branded_title_flag_Invalid=1);
    branded_title_flag_LENGTHS_ErrorCount := COUNT(GROUP,h.branded_title_flag_Invalid=2);
    branded_title_flag_Total_ErrorCount := COUNT(GROUP,h.branded_title_flag_Invalid>0);
    brand_code_1_CAPS_ErrorCount := COUNT(GROUP,h.brand_code_1_Invalid=1);
    brand_code_1_ALLOW_ErrorCount := COUNT(GROUP,h.brand_code_1_Invalid=2);
    brand_code_1_Total_ErrorCount := COUNT(GROUP,h.brand_code_1_Invalid>0);
    brand_date_1_ALLOW_ErrorCount := COUNT(GROUP,h.brand_date_1_Invalid=1);
    brand_date_1_LENGTHS_ErrorCount := COUNT(GROUP,h.brand_date_1_Invalid=2);
    brand_date_1_Total_ErrorCount := COUNT(GROUP,h.brand_date_1_Invalid>0);
    brand_state_1_ALLOW_ErrorCount := COUNT(GROUP,h.brand_state_1_Invalid=1);
    brand_state_1_LENGTHS_ErrorCount := COUNT(GROUP,h.brand_state_1_Invalid=2);
    brand_state_1_Total_ErrorCount := COUNT(GROUP,h.brand_state_1_Invalid>0);
    brand_code_2_CAPS_ErrorCount := COUNT(GROUP,h.brand_code_2_Invalid=1);
    brand_code_2_ALLOW_ErrorCount := COUNT(GROUP,h.brand_code_2_Invalid=2);
    brand_code_2_Total_ErrorCount := COUNT(GROUP,h.brand_code_2_Invalid>0);
    brand_date_2_ALLOW_ErrorCount := COUNT(GROUP,h.brand_date_2_Invalid=1);
    brand_date_2_LENGTHS_ErrorCount := COUNT(GROUP,h.brand_date_2_Invalid=2);
    brand_date_2_Total_ErrorCount := COUNT(GROUP,h.brand_date_2_Invalid>0);
    brand_state_2_ALLOW_ErrorCount := COUNT(GROUP,h.brand_state_2_Invalid=1);
    brand_state_2_LENGTHS_ErrorCount := COUNT(GROUP,h.brand_state_2_Invalid=2);
    brand_state_2_Total_ErrorCount := COUNT(GROUP,h.brand_state_2_Invalid>0);
    brand_code_3_CAPS_ErrorCount := COUNT(GROUP,h.brand_code_3_Invalid=1);
    brand_code_3_ALLOW_ErrorCount := COUNT(GROUP,h.brand_code_3_Invalid=2);
    brand_code_3_Total_ErrorCount := COUNT(GROUP,h.brand_code_3_Invalid>0);
    brand_date_3_ALLOW_ErrorCount := COUNT(GROUP,h.brand_date_3_Invalid=1);
    brand_date_3_LENGTHS_ErrorCount := COUNT(GROUP,h.brand_date_3_Invalid=2);
    brand_date_3_Total_ErrorCount := COUNT(GROUP,h.brand_date_3_Invalid>0);
    brand_state_3_ALLOW_ErrorCount := COUNT(GROUP,h.brand_state_3_Invalid=1);
    brand_state_3_LENGTHS_ErrorCount := COUNT(GROUP,h.brand_state_3_Invalid=2);
    brand_state_3_Total_ErrorCount := COUNT(GROUP,h.brand_state_3_Invalid>0);
    brand_code_4_CAPS_ErrorCount := COUNT(GROUP,h.brand_code_4_Invalid=1);
    brand_code_4_ALLOW_ErrorCount := COUNT(GROUP,h.brand_code_4_Invalid=2);
    brand_code_4_Total_ErrorCount := COUNT(GROUP,h.brand_code_4_Invalid>0);
    brand_date_4_ALLOW_ErrorCount := COUNT(GROUP,h.brand_date_4_Invalid=1);
    brand_date_4_LENGTHS_ErrorCount := COUNT(GROUP,h.brand_date_4_Invalid=2);
    brand_date_4_Total_ErrorCount := COUNT(GROUP,h.brand_date_4_Invalid>0);
    brand_state_4_ALLOW_ErrorCount := COUNT(GROUP,h.brand_state_4_Invalid=1);
    brand_state_4_LENGTHS_ErrorCount := COUNT(GROUP,h.brand_state_4_Invalid=2);
    brand_state_4_Total_ErrorCount := COUNT(GROUP,h.brand_state_4_Invalid>0);
    brand_code_5_CAPS_ErrorCount := COUNT(GROUP,h.brand_code_5_Invalid=1);
    brand_code_5_ALLOW_ErrorCount := COUNT(GROUP,h.brand_code_5_Invalid=2);
    brand_code_5_Total_ErrorCount := COUNT(GROUP,h.brand_code_5_Invalid>0);
    brand_date_5_ALLOW_ErrorCount := COUNT(GROUP,h.brand_date_5_Invalid=1);
    brand_date_5_LENGTHS_ErrorCount := COUNT(GROUP,h.brand_date_5_Invalid=2);
    brand_date_5_Total_ErrorCount := COUNT(GROUP,h.brand_date_5_Invalid>0);
    brand_state_5_ALLOW_ErrorCount := COUNT(GROUP,h.brand_state_5_Invalid=1);
    brand_state_5_LENGTHS_ErrorCount := COUNT(GROUP,h.brand_state_5_Invalid=2);
    brand_state_5_Total_ErrorCount := COUNT(GROUP,h.brand_state_5_Invalid>0);
    tod_flag_ENUM_ErrorCount := COUNT(GROUP,h.tod_flag_Invalid=1);
    tod_flag_LENGTHS_ErrorCount := COUNT(GROUP,h.tod_flag_Invalid=2);
    tod_flag_Total_ErrorCount := COUNT(GROUP,h.tod_flag_Invalid>0);
    model_class_ALLOW_ErrorCount := COUNT(GROUP,h.model_class_Invalid=1);
    min_door_count_ALLOW_ErrorCount := COUNT(GROUP,h.min_door_count_Invalid=1);
    min_door_count_LENGTHS_ErrorCount := COUNT(GROUP,h.min_door_count_Invalid=2);
    min_door_count_Total_ErrorCount := COUNT(GROUP,h.min_door_count_Invalid>0);
    safety_type_ALLOW_ErrorCount := COUNT(GROUP,h.safety_type_Invalid=1);
    airbag_driver_ALLOW_ErrorCount := COUNT(GROUP,h.airbag_driver_Invalid=1);
    airbag_front_driver_side_ALLOW_ErrorCount := COUNT(GROUP,h.airbag_front_driver_side_Invalid=1);
    airbag_front_head_curtain_ALLOW_ErrorCount := COUNT(GROUP,h.airbag_front_head_curtain_Invalid=1);
    airbag_front_pass_ALLOW_ErrorCount := COUNT(GROUP,h.airbag_front_pass_Invalid=1);
    airbag_front_pass_side_ALLOW_ErrorCount := COUNT(GROUP,h.airbag_front_pass_side_Invalid=1);
    airbags_ALLOW_ErrorCount := COUNT(GROUP,h.airbags_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.append_process_date_Invalid > 0 OR h.append_state_origin_Invalid > 0 OR h.file_typ_Invalid > 0 OR h.vin_Invalid > 0 OR h.vehicle_typ_Invalid > 0 OR h.model_yr_Invalid > 0 OR h.model_yr_ind_Invalid > 0 OR h.make_Invalid > 0 OR h.make_ind_Invalid > 0 OR h.series_Invalid > 0 OR h.series_ind_Invalid > 0 OR h.prime_color_Invalid > 0 OR h.second_color_Invalid > 0 OR h.body_style_Invalid > 0 OR h.body_style_ind_Invalid > 0 OR h.model_Invalid > 0 OR h.model_ind_Invalid > 0 OR h.weight_Invalid > 0 OR h.lengt_Invalid > 0 OR h.axle_cnt_Invalid > 0 OR h.plate_nbr_Invalid > 0 OR h.plate_state_Invalid > 0 OR h.prev_plate_nbr_Invalid > 0 OR h.prev_plate_state_Invalid > 0 OR h.plate_typ_cd_Invalid > 0 OR h.mstr_src_state_Invalid > 0 OR h.reg_decal_nbr_Invalid > 0 OR h.org_reg_dt_Invalid > 0 OR h.reg_renew_dt_Invalid > 0 OR h.reg_exp_dt_Invalid > 0 OR h.title_nbr_Invalid > 0 OR h.org_title_dt_Invalid > 0 OR h.title_trans_dt_Invalid > 0 OR h.name_typ_cd_Invalid > 0 OR h.owner_typ_cd_Invalid > 0 OR h.first_nm_Invalid > 0 OR h.middle_nm_Invalid > 0 OR h.last_nm_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.prof_suffix_Invalid > 0 OR h.ind_ssn_Invalid > 0 OR h.ind_dob_Invalid > 0 OR h.mail_range_Invalid > 0 OR h.m_pre_dir_Invalid > 0 OR h.m_street_Invalid > 0 OR h.m_suffix_Invalid > 0 OR h.m_post_dir_Invalid > 0 OR h.m_pob_Invalid > 0 OR h.m_rr_nbr_Invalid > 0 OR h.m_rr_box_Invalid > 0 OR h.m_scndry_rng_Invalid > 0 OR h.m_scndry_des_Invalid > 0 OR h.m_city_Invalid > 0 OR h.m_state_Invalid > 0 OR h.m_zip5_Invalid > 0 OR h.m_zip4_Invalid > 0 OR h.m_cc_Invalid > 0 OR h.m_county_Invalid > 0 OR h.phys_range_Invalid > 0 OR h.p_pre_dir_Invalid > 0 OR h.p_street_Invalid > 0 OR h.p_suffix_Invalid > 0 OR h.p_post_dir_Invalid > 0 OR h.p_pob_Invalid > 0 OR h.p_rr_nbr_Invalid > 0 OR h.p_rr_box_Invalid > 0 OR h.p_scndry_rng_Invalid > 0 OR h.p_scndry_des_Invalid > 0 OR h.p_city_Invalid > 0 OR h.p_state_Invalid > 0 OR h.p_zip5_Invalid > 0 OR h.p_zip4_Invalid > 0 OR h.p_cc_Invalid > 0 OR h.p_county_Invalid > 0 OR h.opt_out_cd_Invalid > 0 OR h.asg_wgt_Invalid > 0 OR h.asg_wgt_uom_Invalid > 0 OR h.source_ctl_id_Invalid > 0 OR h.raw_name_Invalid > 0 OR h.branded_title_flag_Invalid > 0 OR h.brand_code_1_Invalid > 0 OR h.brand_date_1_Invalid > 0 OR h.brand_state_1_Invalid > 0 OR h.brand_code_2_Invalid > 0 OR h.brand_date_2_Invalid > 0 OR h.brand_state_2_Invalid > 0 OR h.brand_code_3_Invalid > 0 OR h.brand_date_3_Invalid > 0 OR h.brand_state_3_Invalid > 0 OR h.brand_code_4_Invalid > 0 OR h.brand_date_4_Invalid > 0 OR h.brand_state_4_Invalid > 0 OR h.brand_code_5_Invalid > 0 OR h.brand_date_5_Invalid > 0 OR h.brand_state_5_Invalid > 0 OR h.tod_flag_Invalid > 0 OR h.model_class_Invalid > 0 OR h.min_door_count_Invalid > 0 OR h.safety_type_Invalid > 0 OR h.airbag_driver_Invalid > 0 OR h.airbag_front_driver_side_Invalid > 0 OR h.airbag_front_head_curtain_Invalid > 0 OR h.airbag_front_pass_Invalid > 0 OR h.airbag_front_pass_side_Invalid > 0 OR h.airbags_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,append_state_origin,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.append_process_date_Total_ErrorCount > 0, 1, 0) + IF(le.append_state_origin_Total_ErrorCount > 0, 1, 0) + IF(le.file_typ_Total_ErrorCount > 0, 1, 0) + IF(le.vin_Total_ErrorCount > 0, 1, 0) + IF(le.vehicle_typ_Total_ErrorCount > 0, 1, 0) + IF(le.model_yr_Total_ErrorCount > 0, 1, 0) + IF(le.model_yr_ind_Total_ErrorCount > 0, 1, 0) + IF(le.make_ALLOW_ErrorCount > 0, 1, 0) + IF(le.make_ind_Total_ErrorCount > 0, 1, 0) + IF(le.series_ALLOW_ErrorCount > 0, 1, 0) + IF(le.series_ind_Total_ErrorCount > 0, 1, 0) + IF(le.prime_color_Total_ErrorCount > 0, 1, 0) + IF(le.second_color_Total_ErrorCount > 0, 1, 0) + IF(le.body_style_ALLOW_ErrorCount > 0, 1, 0) + IF(le.body_style_ind_Total_ErrorCount > 0, 1, 0) + IF(le.model_ALLOW_ErrorCount > 0, 1, 0) + IF(le.model_ind_Total_ErrorCount > 0, 1, 0) + IF(le.weight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lengt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.axle_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plate_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plate_state_Total_ErrorCount > 0, 1, 0) + IF(le.prev_plate_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prev_plate_state_Total_ErrorCount > 0, 1, 0) + IF(le.plate_typ_cd_Total_ErrorCount > 0, 1, 0) + IF(le.mstr_src_state_Total_ErrorCount > 0, 1, 0) + IF(le.reg_decal_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.org_reg_dt_Total_ErrorCount > 0, 1, 0) + IF(le.reg_renew_dt_Total_ErrorCount > 0, 1, 0) + IF(le.reg_exp_dt_Total_ErrorCount > 0, 1, 0) + IF(le.title_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.org_title_dt_Total_ErrorCount > 0, 1, 0) + IF(le.title_trans_dt_Total_ErrorCount > 0, 1, 0) + IF(le.name_typ_cd_Total_ErrorCount > 0, 1, 0) + IF(le.owner_typ_cd_Total_ErrorCount > 0, 1, 0) + IF(le.first_nm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.middle_nm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_nm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prof_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ind_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.ind_dob_Total_ErrorCount > 0, 1, 0) + IF(le.mail_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_pre_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_street_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_post_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_pob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_rr_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_rr_box_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_scndry_rng_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_scndry_des_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_state_Total_ErrorCount > 0, 1, 0) + IF(le.m_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.m_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.m_cc_Total_ErrorCount > 0, 1, 0) + IF(le.m_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phys_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_pre_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_street_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_post_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_pob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_rr_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_rr_box_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_scndry_rng_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_scndry_des_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_state_Total_ErrorCount > 0, 1, 0) + IF(le.p_zip5_Total_ErrorCount > 0, 1, 0) + IF(le.p_zip4_Total_ErrorCount > 0, 1, 0) + IF(le.p_cc_Total_ErrorCount > 0, 1, 0) + IF(le.p_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.opt_out_cd_Total_ErrorCount > 0, 1, 0) + IF(le.asg_wgt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.asg_wgt_uom_Total_ErrorCount > 0, 1, 0) + IF(le.source_ctl_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.branded_title_flag_Total_ErrorCount > 0, 1, 0) + IF(le.brand_code_1_Total_ErrorCount > 0, 1, 0) + IF(le.brand_date_1_Total_ErrorCount > 0, 1, 0) + IF(le.brand_state_1_Total_ErrorCount > 0, 1, 0) + IF(le.brand_code_2_Total_ErrorCount > 0, 1, 0) + IF(le.brand_date_2_Total_ErrorCount > 0, 1, 0) + IF(le.brand_state_2_Total_ErrorCount > 0, 1, 0) + IF(le.brand_code_3_Total_ErrorCount > 0, 1, 0) + IF(le.brand_date_3_Total_ErrorCount > 0, 1, 0) + IF(le.brand_state_3_Total_ErrorCount > 0, 1, 0) + IF(le.brand_code_4_Total_ErrorCount > 0, 1, 0) + IF(le.brand_date_4_Total_ErrorCount > 0, 1, 0) + IF(le.brand_state_4_Total_ErrorCount > 0, 1, 0) + IF(le.brand_code_5_Total_ErrorCount > 0, 1, 0) + IF(le.brand_date_5_Total_ErrorCount > 0, 1, 0) + IF(le.brand_state_5_Total_ErrorCount > 0, 1, 0) + IF(le.tod_flag_Total_ErrorCount > 0, 1, 0) + IF(le.model_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.min_door_count_Total_ErrorCount > 0, 1, 0) + IF(le.safety_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbag_driver_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbag_front_driver_side_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbag_front_head_curtain_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbag_front_pass_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbag_front_pass_side_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbags_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.append_process_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_process_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.append_state_origin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_state_origin_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.file_typ_ENUM_ErrorCount > 0, 1, 0) + IF(le.file_typ_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vin_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vehicle_typ_ENUM_ErrorCount > 0, 1, 0) + IF(le.vehicle_typ_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.model_yr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.model_yr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.model_yr_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.model_yr_ind_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.make_ALLOW_ErrorCount > 0, 1, 0) + IF(le.make_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.make_ind_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.series_ALLOW_ErrorCount > 0, 1, 0) + IF(le.series_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.series_ind_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prime_color_CAPS_ErrorCount > 0, 1, 0) + IF(le.prime_color_ALLOW_ErrorCount > 0, 1, 0) + IF(le.second_color_CAPS_ErrorCount > 0, 1, 0) + IF(le.second_color_ALLOW_ErrorCount > 0, 1, 0) + IF(le.body_style_ALLOW_ErrorCount > 0, 1, 0) + IF(le.body_style_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.body_style_ind_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.model_ALLOW_ErrorCount > 0, 1, 0) + IF(le.model_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.model_ind_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.weight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lengt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.axle_cnt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plate_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plate_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plate_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prev_plate_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prev_plate_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prev_plate_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.plate_typ_cd_CAPS_ErrorCount > 0, 1, 0) + IF(le.plate_typ_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mstr_src_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mstr_src_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.reg_decal_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.org_reg_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.org_reg_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.reg_renew_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reg_renew_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.reg_exp_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reg_exp_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.title_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.org_title_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.org_title_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.title_trans_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_trans_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.name_typ_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.name_typ_cd_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.owner_typ_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.owner_typ_cd_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.first_nm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.middle_nm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_nm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prof_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ind_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ind_ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ind_dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ind_dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mail_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_pre_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_street_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_post_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_pob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_rr_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_rr_box_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_scndry_rng_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_scndry_des_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.m_zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.m_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.m_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.m_cc_ENUM_ErrorCount > 0, 1, 0) + IF(le.m_cc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.m_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phys_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_pre_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_street_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_post_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_pob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_rr_nbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_rr_box_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_scndry_rng_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_scndry_des_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.p_zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.p_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.p_cc_ENUM_ErrorCount > 0, 1, 0) + IF(le.p_cc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.p_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.opt_out_cd_ENUM_ErrorCount > 0, 1, 0) + IF(le.opt_out_cd_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.asg_wgt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.asg_wgt_uom_CAPS_ErrorCount > 0, 1, 0) + IF(le.asg_wgt_uom_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ctl_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.raw_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.branded_title_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.branded_title_flag_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.brand_code_1_CAPS_ErrorCount > 0, 1, 0) + IF(le.brand_code_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_date_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_date_1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.brand_state_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_state_1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.brand_code_2_CAPS_ErrorCount > 0, 1, 0) + IF(le.brand_code_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_date_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_date_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.brand_state_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_state_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.brand_code_3_CAPS_ErrorCount > 0, 1, 0) + IF(le.brand_code_3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_date_3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_date_3_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.brand_state_3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_state_3_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.brand_code_4_CAPS_ErrorCount > 0, 1, 0) + IF(le.brand_code_4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_date_4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_date_4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.brand_state_4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_state_4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.brand_code_5_CAPS_ErrorCount > 0, 1, 0) + IF(le.brand_code_5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_date_5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_date_5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.brand_state_5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.brand_state_5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tod_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.tod_flag_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.model_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.min_door_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.min_door_count_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.safety_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbag_driver_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbag_front_driver_side_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbag_front_head_curtain_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbag_front_pass_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbag_front_pass_side_ALLOW_ErrorCount > 0, 1, 0) + IF(le.airbags_ALLOW_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  le.append_state_origin;
    UNSIGNED1 ErrNum := CHOOSE(c,le.append_process_date_Invalid,le.append_state_origin_Invalid,le.file_typ_Invalid,le.vin_Invalid,le.vehicle_typ_Invalid,le.model_yr_Invalid,le.model_yr_ind_Invalid,le.make_Invalid,le.make_ind_Invalid,le.series_Invalid,le.series_ind_Invalid,le.prime_color_Invalid,le.second_color_Invalid,le.body_style_Invalid,le.body_style_ind_Invalid,le.model_Invalid,le.model_ind_Invalid,le.weight_Invalid,le.lengt_Invalid,le.axle_cnt_Invalid,le.plate_nbr_Invalid,le.plate_state_Invalid,le.prev_plate_nbr_Invalid,le.prev_plate_state_Invalid,le.plate_typ_cd_Invalid,le.mstr_src_state_Invalid,le.reg_decal_nbr_Invalid,le.org_reg_dt_Invalid,le.reg_renew_dt_Invalid,le.reg_exp_dt_Invalid,le.title_nbr_Invalid,le.org_title_dt_Invalid,le.title_trans_dt_Invalid,le.name_typ_cd_Invalid,le.owner_typ_cd_Invalid,le.first_nm_Invalid,le.middle_nm_Invalid,le.last_nm_Invalid,le.name_suffix_Invalid,le.prof_suffix_Invalid,le.ind_ssn_Invalid,le.ind_dob_Invalid,le.mail_range_Invalid,le.m_pre_dir_Invalid,le.m_street_Invalid,le.m_suffix_Invalid,le.m_post_dir_Invalid,le.m_pob_Invalid,le.m_rr_nbr_Invalid,le.m_rr_box_Invalid,le.m_scndry_rng_Invalid,le.m_scndry_des_Invalid,le.m_city_Invalid,le.m_state_Invalid,le.m_zip5_Invalid,le.m_zip4_Invalid,le.m_cc_Invalid,le.m_county_Invalid,le.phys_range_Invalid,le.p_pre_dir_Invalid,le.p_street_Invalid,le.p_suffix_Invalid,le.p_post_dir_Invalid,le.p_pob_Invalid,le.p_rr_nbr_Invalid,le.p_rr_box_Invalid,le.p_scndry_rng_Invalid,le.p_scndry_des_Invalid,le.p_city_Invalid,le.p_state_Invalid,le.p_zip5_Invalid,le.p_zip4_Invalid,le.p_cc_Invalid,le.p_county_Invalid,le.opt_out_cd_Invalid,le.asg_wgt_Invalid,le.asg_wgt_uom_Invalid,le.source_ctl_id_Invalid,le.raw_name_Invalid,le.branded_title_flag_Invalid,le.brand_code_1_Invalid,le.brand_date_1_Invalid,le.brand_state_1_Invalid,le.brand_code_2_Invalid,le.brand_date_2_Invalid,le.brand_state_2_Invalid,le.brand_code_3_Invalid,le.brand_date_3_Invalid,le.brand_state_3_Invalid,le.brand_code_4_Invalid,le.brand_date_4_Invalid,le.brand_state_4_Invalid,le.brand_code_5_Invalid,le.brand_date_5_Invalid,le.brand_state_5_Invalid,le.tod_flag_Invalid,le.model_class_Invalid,le.min_door_count_Invalid,le.safety_type_Invalid,le.airbag_driver_Invalid,le.airbag_front_driver_side_Invalid,le.airbag_front_head_curtain_Invalid,le.airbag_front_pass_Invalid,le.airbag_front_pass_side_Invalid,le.airbags_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Experian_Fields.InvalidMessage_append_process_date(le.append_process_date_Invalid),Experian_Fields.InvalidMessage_append_state_origin(le.append_state_origin_Invalid),Experian_Fields.InvalidMessage_file_typ(le.file_typ_Invalid),Experian_Fields.InvalidMessage_vin(le.vin_Invalid),Experian_Fields.InvalidMessage_vehicle_typ(le.vehicle_typ_Invalid),Experian_Fields.InvalidMessage_model_yr(le.model_yr_Invalid),Experian_Fields.InvalidMessage_model_yr_ind(le.model_yr_ind_Invalid),Experian_Fields.InvalidMessage_make(le.make_Invalid),Experian_Fields.InvalidMessage_make_ind(le.make_ind_Invalid),Experian_Fields.InvalidMessage_series(le.series_Invalid),Experian_Fields.InvalidMessage_series_ind(le.series_ind_Invalid),Experian_Fields.InvalidMessage_prime_color(le.prime_color_Invalid),Experian_Fields.InvalidMessage_second_color(le.second_color_Invalid),Experian_Fields.InvalidMessage_body_style(le.body_style_Invalid),Experian_Fields.InvalidMessage_body_style_ind(le.body_style_ind_Invalid),Experian_Fields.InvalidMessage_model(le.model_Invalid),Experian_Fields.InvalidMessage_model_ind(le.model_ind_Invalid),Experian_Fields.InvalidMessage_weight(le.weight_Invalid),Experian_Fields.InvalidMessage_lengt(le.lengt_Invalid),Experian_Fields.InvalidMessage_axle_cnt(le.axle_cnt_Invalid),Experian_Fields.InvalidMessage_plate_nbr(le.plate_nbr_Invalid),Experian_Fields.InvalidMessage_plate_state(le.plate_state_Invalid),Experian_Fields.InvalidMessage_prev_plate_nbr(le.prev_plate_nbr_Invalid),Experian_Fields.InvalidMessage_prev_plate_state(le.prev_plate_state_Invalid),Experian_Fields.InvalidMessage_plate_typ_cd(le.plate_typ_cd_Invalid),Experian_Fields.InvalidMessage_mstr_src_state(le.mstr_src_state_Invalid),Experian_Fields.InvalidMessage_reg_decal_nbr(le.reg_decal_nbr_Invalid),Experian_Fields.InvalidMessage_org_reg_dt(le.org_reg_dt_Invalid),Experian_Fields.InvalidMessage_reg_renew_dt(le.reg_renew_dt_Invalid),Experian_Fields.InvalidMessage_reg_exp_dt(le.reg_exp_dt_Invalid),Experian_Fields.InvalidMessage_title_nbr(le.title_nbr_Invalid),Experian_Fields.InvalidMessage_org_title_dt(le.org_title_dt_Invalid),Experian_Fields.InvalidMessage_title_trans_dt(le.title_trans_dt_Invalid),Experian_Fields.InvalidMessage_name_typ_cd(le.name_typ_cd_Invalid),Experian_Fields.InvalidMessage_owner_typ_cd(le.owner_typ_cd_Invalid),Experian_Fields.InvalidMessage_first_nm(le.first_nm_Invalid),Experian_Fields.InvalidMessage_middle_nm(le.middle_nm_Invalid),Experian_Fields.InvalidMessage_last_nm(le.last_nm_Invalid),Experian_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Experian_Fields.InvalidMessage_prof_suffix(le.prof_suffix_Invalid),Experian_Fields.InvalidMessage_ind_ssn(le.ind_ssn_Invalid),Experian_Fields.InvalidMessage_ind_dob(le.ind_dob_Invalid),Experian_Fields.InvalidMessage_mail_range(le.mail_range_Invalid),Experian_Fields.InvalidMessage_m_pre_dir(le.m_pre_dir_Invalid),Experian_Fields.InvalidMessage_m_street(le.m_street_Invalid),Experian_Fields.InvalidMessage_m_suffix(le.m_suffix_Invalid),Experian_Fields.InvalidMessage_m_post_dir(le.m_post_dir_Invalid),Experian_Fields.InvalidMessage_m_pob(le.m_pob_Invalid),Experian_Fields.InvalidMessage_m_rr_nbr(le.m_rr_nbr_Invalid),Experian_Fields.InvalidMessage_m_rr_box(le.m_rr_box_Invalid),Experian_Fields.InvalidMessage_m_scndry_rng(le.m_scndry_rng_Invalid),Experian_Fields.InvalidMessage_m_scndry_des(le.m_scndry_des_Invalid),Experian_Fields.InvalidMessage_m_city(le.m_city_Invalid),Experian_Fields.InvalidMessage_m_state(le.m_state_Invalid),Experian_Fields.InvalidMessage_m_zip5(le.m_zip5_Invalid),Experian_Fields.InvalidMessage_m_zip4(le.m_zip4_Invalid),Experian_Fields.InvalidMessage_m_cc(le.m_cc_Invalid),Experian_Fields.InvalidMessage_m_county(le.m_county_Invalid),Experian_Fields.InvalidMessage_phys_range(le.phys_range_Invalid),Experian_Fields.InvalidMessage_p_pre_dir(le.p_pre_dir_Invalid),Experian_Fields.InvalidMessage_p_street(le.p_street_Invalid),Experian_Fields.InvalidMessage_p_suffix(le.p_suffix_Invalid),Experian_Fields.InvalidMessage_p_post_dir(le.p_post_dir_Invalid),Experian_Fields.InvalidMessage_p_pob(le.p_pob_Invalid),Experian_Fields.InvalidMessage_p_rr_nbr(le.p_rr_nbr_Invalid),Experian_Fields.InvalidMessage_p_rr_box(le.p_rr_box_Invalid),Experian_Fields.InvalidMessage_p_scndry_rng(le.p_scndry_rng_Invalid),Experian_Fields.InvalidMessage_p_scndry_des(le.p_scndry_des_Invalid),Experian_Fields.InvalidMessage_p_city(le.p_city_Invalid),Experian_Fields.InvalidMessage_p_state(le.p_state_Invalid),Experian_Fields.InvalidMessage_p_zip5(le.p_zip5_Invalid),Experian_Fields.InvalidMessage_p_zip4(le.p_zip4_Invalid),Experian_Fields.InvalidMessage_p_cc(le.p_cc_Invalid),Experian_Fields.InvalidMessage_p_county(le.p_county_Invalid),Experian_Fields.InvalidMessage_opt_out_cd(le.opt_out_cd_Invalid),Experian_Fields.InvalidMessage_asg_wgt(le.asg_wgt_Invalid),Experian_Fields.InvalidMessage_asg_wgt_uom(le.asg_wgt_uom_Invalid),Experian_Fields.InvalidMessage_source_ctl_id(le.source_ctl_id_Invalid),Experian_Fields.InvalidMessage_raw_name(le.raw_name_Invalid),Experian_Fields.InvalidMessage_branded_title_flag(le.branded_title_flag_Invalid),Experian_Fields.InvalidMessage_brand_code_1(le.brand_code_1_Invalid),Experian_Fields.InvalidMessage_brand_date_1(le.brand_date_1_Invalid),Experian_Fields.InvalidMessage_brand_state_1(le.brand_state_1_Invalid),Experian_Fields.InvalidMessage_brand_code_2(le.brand_code_2_Invalid),Experian_Fields.InvalidMessage_brand_date_2(le.brand_date_2_Invalid),Experian_Fields.InvalidMessage_brand_state_2(le.brand_state_2_Invalid),Experian_Fields.InvalidMessage_brand_code_3(le.brand_code_3_Invalid),Experian_Fields.InvalidMessage_brand_date_3(le.brand_date_3_Invalid),Experian_Fields.InvalidMessage_brand_state_3(le.brand_state_3_Invalid),Experian_Fields.InvalidMessage_brand_code_4(le.brand_code_4_Invalid),Experian_Fields.InvalidMessage_brand_date_4(le.brand_date_4_Invalid),Experian_Fields.InvalidMessage_brand_state_4(le.brand_state_4_Invalid),Experian_Fields.InvalidMessage_brand_code_5(le.brand_code_5_Invalid),Experian_Fields.InvalidMessage_brand_date_5(le.brand_date_5_Invalid),Experian_Fields.InvalidMessage_brand_state_5(le.brand_state_5_Invalid),Experian_Fields.InvalidMessage_tod_flag(le.tod_flag_Invalid),Experian_Fields.InvalidMessage_model_class(le.model_class_Invalid),Experian_Fields.InvalidMessage_min_door_count(le.min_door_count_Invalid),Experian_Fields.InvalidMessage_safety_type(le.safety_type_Invalid),Experian_Fields.InvalidMessage_airbag_driver(le.airbag_driver_Invalid),Experian_Fields.InvalidMessage_airbag_front_driver_side(le.airbag_front_driver_side_Invalid),Experian_Fields.InvalidMessage_airbag_front_head_curtain(le.airbag_front_head_curtain_Invalid),Experian_Fields.InvalidMessage_airbag_front_pass(le.airbag_front_pass_Invalid),Experian_Fields.InvalidMessage_airbag_front_pass_side(le.airbag_front_pass_side_Invalid),Experian_Fields.InvalidMessage_airbags(le.airbags_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.append_process_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.append_state_origin_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.file_typ_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vin_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vehicle_typ_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.model_yr_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.model_yr_ind_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.make_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.make_ind_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.series_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.series_ind_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prime_color_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.second_color_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.body_style_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.body_style_ind_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.model_ind_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.weight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lengt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.axle_cnt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.plate_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.plate_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prev_plate_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prev_plate_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.plate_typ_cd_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.mstr_src_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.reg_decal_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.org_reg_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.reg_renew_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.reg_exp_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.title_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.org_title_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.title_trans_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.name_typ_cd_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.owner_typ_cd_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.first_nm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.middle_nm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_nm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prof_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ind_ssn_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ind_dob_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mail_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_pre_dir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_street_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_post_dir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_pob_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_rr_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_rr_box_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_scndry_rng_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_scndry_des_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.m_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.m_zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.m_zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.m_cc_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.m_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phys_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_pre_dir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_street_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_post_dir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_pob_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_rr_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_rr_box_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_scndry_rng_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_scndry_des_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.p_zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.p_zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.p_cc_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.p_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.opt_out_cd_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.asg_wgt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.asg_wgt_uom_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.source_ctl_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.raw_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.branded_title_flag_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.brand_code_1_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.brand_date_1_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.brand_state_1_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.brand_code_2_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.brand_date_2_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.brand_state_2_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.brand_code_3_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.brand_date_3_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.brand_state_3_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.brand_code_4_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.brand_date_4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.brand_state_4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.brand_code_5_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.brand_date_5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.brand_state_5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tod_flag_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.model_class_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.min_door_count_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.safety_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.airbag_driver_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.airbag_front_driver_side_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.airbag_front_head_curtain_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.airbag_front_pass_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.airbag_front_pass_side_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.airbags_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'append_process_date','append_state_origin','file_typ','vin','vehicle_typ','model_yr','model_yr_ind','make','make_ind','series','series_ind','prime_color','second_color','body_style','body_style_ind','model','model_ind','weight','lengt','axle_cnt','plate_nbr','plate_state','prev_plate_nbr','prev_plate_state','plate_typ_cd','mstr_src_state','reg_decal_nbr','org_reg_dt','reg_renew_dt','reg_exp_dt','title_nbr','org_title_dt','title_trans_dt','name_typ_cd','owner_typ_cd','first_nm','middle_nm','last_nm','name_suffix','prof_suffix','ind_ssn','ind_dob','mail_range','m_pre_dir','m_street','m_suffix','m_post_dir','m_pob','m_rr_nbr','m_rr_box','m_scndry_rng','m_scndry_des','m_city','m_state','m_zip5','m_zip4','m_cc','m_county','phys_range','p_pre_dir','p_street','p_suffix','p_post_dir','p_pob','p_rr_nbr','p_rr_box','p_scndry_rng','p_scndry_des','p_city','p_state','p_zip5','p_zip4','p_cc','p_county','opt_out_cd','asg_wgt','asg_wgt_uom','source_ctl_id','raw_name','branded_title_flag','brand_code_1','brand_date_1','brand_state_1','brand_code_2','brand_date_2','brand_state_2','brand_code_3','brand_date_3','brand_state_3','brand_code_4','brand_date_4','brand_state_4','brand_code_5','brand_date_5','brand_state_5','tod_flag','model_class','min_door_count','safety_type','airbag_driver','airbag_front_driver_side','airbag_front_head_curtain','airbag_front_pass','airbag_front_pass_side','airbags','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_state','invalid_file_typ','invalid_vin','invalid_vehicle_typ','invalid_year','invalid_model_yr_ind','invalid_alpha','invalid_model_yr_ind','invalid_alpha','invalid_model_yr_ind','invalid_only_alpha','invalid_only_alpha','invalid_alpha','invalid_model_yr_ind','invalid_alpha','invalid_model_yr_ind','invalid_weight','invalid_number','invalid_number','invalid_alpha','invalid_state','invalid_alpha','invalid_state','invalid_only_alpha','invalid_state','invalid_alphanumeric','invalid_date','invalid_date','invalid_date','invalid_alphanumeric','invalid_date','invalid_date','invalid_name_typ_cd','invalid_owner_typ_cd','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_ssn','invalid_date','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_state','invalid_zip5','invalid_zip4','invalid_cc','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_state','invalid_zip5','invalid_zip4','invalid_cc','invalid_alpha','invalid_opt_out_cd','invalid_number','invalid_only_alpha','invalid_number','invalid_alpha','invalid_yes_no','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_only_alpha','invalid_date1','invalid_state','invalid_yes_no','invalid_alpha','invalid_min_door_count','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.append_process_date,(SALT311.StrType)le.append_state_origin,(SALT311.StrType)le.file_typ,(SALT311.StrType)le.vin,(SALT311.StrType)le.vehicle_typ,(SALT311.StrType)le.model_yr,(SALT311.StrType)le.model_yr_ind,(SALT311.StrType)le.make,(SALT311.StrType)le.make_ind,(SALT311.StrType)le.series,(SALT311.StrType)le.series_ind,(SALT311.StrType)le.prime_color,(SALT311.StrType)le.second_color,(SALT311.StrType)le.body_style,(SALT311.StrType)le.body_style_ind,(SALT311.StrType)le.model,(SALT311.StrType)le.model_ind,(SALT311.StrType)le.weight,(SALT311.StrType)le.lengt,(SALT311.StrType)le.axle_cnt,(SALT311.StrType)le.plate_nbr,(SALT311.StrType)le.plate_state,(SALT311.StrType)le.prev_plate_nbr,(SALT311.StrType)le.prev_plate_state,(SALT311.StrType)le.plate_typ_cd,(SALT311.StrType)le.mstr_src_state,(SALT311.StrType)le.reg_decal_nbr,(SALT311.StrType)le.org_reg_dt,(SALT311.StrType)le.reg_renew_dt,(SALT311.StrType)le.reg_exp_dt,(SALT311.StrType)le.title_nbr,(SALT311.StrType)le.org_title_dt,(SALT311.StrType)le.title_trans_dt,(SALT311.StrType)le.name_typ_cd,(SALT311.StrType)le.owner_typ_cd,(SALT311.StrType)le.first_nm,(SALT311.StrType)le.middle_nm,(SALT311.StrType)le.last_nm,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.prof_suffix,(SALT311.StrType)le.ind_ssn,(SALT311.StrType)le.ind_dob,(SALT311.StrType)le.mail_range,(SALT311.StrType)le.m_pre_dir,(SALT311.StrType)le.m_street,(SALT311.StrType)le.m_suffix,(SALT311.StrType)le.m_post_dir,(SALT311.StrType)le.m_pob,(SALT311.StrType)le.m_rr_nbr,(SALT311.StrType)le.m_rr_box,(SALT311.StrType)le.m_scndry_rng,(SALT311.StrType)le.m_scndry_des,(SALT311.StrType)le.m_city,(SALT311.StrType)le.m_state,(SALT311.StrType)le.m_zip5,(SALT311.StrType)le.m_zip4,(SALT311.StrType)le.m_cc,(SALT311.StrType)le.m_county,(SALT311.StrType)le.phys_range,(SALT311.StrType)le.p_pre_dir,(SALT311.StrType)le.p_street,(SALT311.StrType)le.p_suffix,(SALT311.StrType)le.p_post_dir,(SALT311.StrType)le.p_pob,(SALT311.StrType)le.p_rr_nbr,(SALT311.StrType)le.p_rr_box,(SALT311.StrType)le.p_scndry_rng,(SALT311.StrType)le.p_scndry_des,(SALT311.StrType)le.p_city,(SALT311.StrType)le.p_state,(SALT311.StrType)le.p_zip5,(SALT311.StrType)le.p_zip4,(SALT311.StrType)le.p_cc,(SALT311.StrType)le.p_county,(SALT311.StrType)le.opt_out_cd,(SALT311.StrType)le.asg_wgt,(SALT311.StrType)le.asg_wgt_uom,(SALT311.StrType)le.source_ctl_id,(SALT311.StrType)le.raw_name,(SALT311.StrType)le.branded_title_flag,(SALT311.StrType)le.brand_code_1,(SALT311.StrType)le.brand_date_1,(SALT311.StrType)le.brand_state_1,(SALT311.StrType)le.brand_code_2,(SALT311.StrType)le.brand_date_2,(SALT311.StrType)le.brand_state_2,(SALT311.StrType)le.brand_code_3,(SALT311.StrType)le.brand_date_3,(SALT311.StrType)le.brand_state_3,(SALT311.StrType)le.brand_code_4,(SALT311.StrType)le.brand_date_4,(SALT311.StrType)le.brand_state_4,(SALT311.StrType)le.brand_code_5,(SALT311.StrType)le.brand_date_5,(SALT311.StrType)le.brand_state_5,(SALT311.StrType)le.tod_flag,(SALT311.StrType)le.model_class,(SALT311.StrType)le.min_door_count,(SALT311.StrType)le.safety_type,(SALT311.StrType)le.airbag_driver,(SALT311.StrType)le.airbag_front_driver_side,(SALT311.StrType)le.airbag_front_head_curtain,(SALT311.StrType)le.airbag_front_pass,(SALT311.StrType)le.airbag_front_pass_side,(SALT311.StrType)le.airbags,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,105,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Experian_Layout_VehicleV2) prevDS = DATASET([], Experian_Layout_VehicleV2)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.append_state_origin;
      SELF.ruledesc := CHOOSE(c
          ,'append_process_date:invalid_date:ALLOW','append_process_date:invalid_date:LENGTHS'
          ,'append_state_origin:invalid_state:ALLOW','append_state_origin:invalid_state:LENGTHS'
          ,'file_typ:invalid_file_typ:ENUM','file_typ:invalid_file_typ:LENGTHS'
          ,'vin:invalid_vin:ALLOW','vin:invalid_vin:LENGTHS'
          ,'vehicle_typ:invalid_vehicle_typ:ENUM','vehicle_typ:invalid_vehicle_typ:LENGTHS'
          ,'model_yr:invalid_year:ALLOW','model_yr:invalid_year:LENGTHS'
          ,'model_yr_ind:invalid_model_yr_ind:ENUM','model_yr_ind:invalid_model_yr_ind:LENGTHS'
          ,'make:invalid_alpha:ALLOW'
          ,'make_ind:invalid_model_yr_ind:ENUM','make_ind:invalid_model_yr_ind:LENGTHS'
          ,'series:invalid_alpha:ALLOW'
          ,'series_ind:invalid_model_yr_ind:ENUM','series_ind:invalid_model_yr_ind:LENGTHS'
          ,'prime_color:invalid_only_alpha:CAPS','prime_color:invalid_only_alpha:ALLOW'
          ,'second_color:invalid_only_alpha:CAPS','second_color:invalid_only_alpha:ALLOW'
          ,'body_style:invalid_alpha:ALLOW'
          ,'body_style_ind:invalid_model_yr_ind:ENUM','body_style_ind:invalid_model_yr_ind:LENGTHS'
          ,'model:invalid_alpha:ALLOW'
          ,'model_ind:invalid_model_yr_ind:ENUM','model_ind:invalid_model_yr_ind:LENGTHS'
          ,'weight:invalid_weight:ALLOW'
          ,'lengt:invalid_number:ALLOW'
          ,'axle_cnt:invalid_number:ALLOW'
          ,'plate_nbr:invalid_alpha:ALLOW'
          ,'plate_state:invalid_state:ALLOW','plate_state:invalid_state:LENGTHS'
          ,'prev_plate_nbr:invalid_alpha:ALLOW'
          ,'prev_plate_state:invalid_state:ALLOW','prev_plate_state:invalid_state:LENGTHS'
          ,'plate_typ_cd:invalid_only_alpha:CAPS','plate_typ_cd:invalid_only_alpha:ALLOW'
          ,'mstr_src_state:invalid_state:ALLOW','mstr_src_state:invalid_state:LENGTHS'
          ,'reg_decal_nbr:invalid_alphanumeric:ALLOW'
          ,'org_reg_dt:invalid_date:ALLOW','org_reg_dt:invalid_date:LENGTHS'
          ,'reg_renew_dt:invalid_date:ALLOW','reg_renew_dt:invalid_date:LENGTHS'
          ,'reg_exp_dt:invalid_date:ALLOW','reg_exp_dt:invalid_date:LENGTHS'
          ,'title_nbr:invalid_alphanumeric:ALLOW'
          ,'org_title_dt:invalid_date:ALLOW','org_title_dt:invalid_date:LENGTHS'
          ,'title_trans_dt:invalid_date:ALLOW','title_trans_dt:invalid_date:LENGTHS'
          ,'name_typ_cd:invalid_name_typ_cd:ENUM','name_typ_cd:invalid_name_typ_cd:LENGTHS'
          ,'owner_typ_cd:invalid_owner_typ_cd:ENUM','owner_typ_cd:invalid_owner_typ_cd:LENGTHS'
          ,'first_nm:invalid_alpha:ALLOW'
          ,'middle_nm:invalid_alpha:ALLOW'
          ,'last_nm:invalid_alpha:ALLOW'
          ,'name_suffix:invalid_alpha:ALLOW'
          ,'prof_suffix:invalid_alpha:ALLOW'
          ,'ind_ssn:invalid_ssn:ALLOW','ind_ssn:invalid_ssn:LENGTHS'
          ,'ind_dob:invalid_date:ALLOW','ind_dob:invalid_date:LENGTHS'
          ,'mail_range:invalid_alpha:ALLOW'
          ,'m_pre_dir:invalid_alpha:ALLOW'
          ,'m_street:invalid_alpha:ALLOW'
          ,'m_suffix:invalid_alpha:ALLOW'
          ,'m_post_dir:invalid_alpha:ALLOW'
          ,'m_pob:invalid_alpha:ALLOW'
          ,'m_rr_nbr:invalid_alpha:ALLOW'
          ,'m_rr_box:invalid_alpha:ALLOW'
          ,'m_scndry_rng:invalid_alpha:ALLOW'
          ,'m_scndry_des:invalid_alpha:ALLOW'
          ,'m_city:invalid_alpha:ALLOW'
          ,'m_state:invalid_state:ALLOW','m_state:invalid_state:LENGTHS'
          ,'m_zip5:invalid_zip5:ALLOW','m_zip5:invalid_zip5:LENGTHS'
          ,'m_zip4:invalid_zip4:ALLOW','m_zip4:invalid_zip4:LENGTHS'
          ,'m_cc:invalid_cc:ENUM','m_cc:invalid_cc:LENGTHS'
          ,'m_county:invalid_alpha:ALLOW'
          ,'phys_range:invalid_alpha:ALLOW'
          ,'p_pre_dir:invalid_alpha:ALLOW'
          ,'p_street:invalid_alpha:ALLOW'
          ,'p_suffix:invalid_alpha:ALLOW'
          ,'p_post_dir:invalid_alpha:ALLOW'
          ,'p_pob:invalid_alpha:ALLOW'
          ,'p_rr_nbr:invalid_alpha:ALLOW'
          ,'p_rr_box:invalid_alpha:ALLOW'
          ,'p_scndry_rng:invalid_alpha:ALLOW'
          ,'p_scndry_des:invalid_alpha:ALLOW'
          ,'p_city:invalid_alpha:ALLOW'
          ,'p_state:invalid_state:ALLOW','p_state:invalid_state:LENGTHS'
          ,'p_zip5:invalid_zip5:ALLOW','p_zip5:invalid_zip5:LENGTHS'
          ,'p_zip4:invalid_zip4:ALLOW','p_zip4:invalid_zip4:LENGTHS'
          ,'p_cc:invalid_cc:ENUM','p_cc:invalid_cc:LENGTHS'
          ,'p_county:invalid_alpha:ALLOW'
          ,'opt_out_cd:invalid_opt_out_cd:ENUM','opt_out_cd:invalid_opt_out_cd:LENGTHS'
          ,'asg_wgt:invalid_number:ALLOW'
          ,'asg_wgt_uom:invalid_only_alpha:CAPS','asg_wgt_uom:invalid_only_alpha:ALLOW'
          ,'source_ctl_id:invalid_number:ALLOW'
          ,'raw_name:invalid_alpha:ALLOW'
          ,'branded_title_flag:invalid_yes_no:ENUM','branded_title_flag:invalid_yes_no:LENGTHS'
          ,'brand_code_1:invalid_only_alpha:CAPS','brand_code_1:invalid_only_alpha:ALLOW'
          ,'brand_date_1:invalid_date1:ALLOW','brand_date_1:invalid_date1:LENGTHS'
          ,'brand_state_1:invalid_state:ALLOW','brand_state_1:invalid_state:LENGTHS'
          ,'brand_code_2:invalid_only_alpha:CAPS','brand_code_2:invalid_only_alpha:ALLOW'
          ,'brand_date_2:invalid_date1:ALLOW','brand_date_2:invalid_date1:LENGTHS'
          ,'brand_state_2:invalid_state:ALLOW','brand_state_2:invalid_state:LENGTHS'
          ,'brand_code_3:invalid_only_alpha:CAPS','brand_code_3:invalid_only_alpha:ALLOW'
          ,'brand_date_3:invalid_date1:ALLOW','brand_date_3:invalid_date1:LENGTHS'
          ,'brand_state_3:invalid_state:ALLOW','brand_state_3:invalid_state:LENGTHS'
          ,'brand_code_4:invalid_only_alpha:CAPS','brand_code_4:invalid_only_alpha:ALLOW'
          ,'brand_date_4:invalid_date1:ALLOW','brand_date_4:invalid_date1:LENGTHS'
          ,'brand_state_4:invalid_state:ALLOW','brand_state_4:invalid_state:LENGTHS'
          ,'brand_code_5:invalid_only_alpha:CAPS','brand_code_5:invalid_only_alpha:ALLOW'
          ,'brand_date_5:invalid_date1:ALLOW','brand_date_5:invalid_date1:LENGTHS'
          ,'brand_state_5:invalid_state:ALLOW','brand_state_5:invalid_state:LENGTHS'
          ,'tod_flag:invalid_yes_no:ENUM','tod_flag:invalid_yes_no:LENGTHS'
          ,'model_class:invalid_alpha:ALLOW'
          ,'min_door_count:invalid_min_door_count:ALLOW','min_door_count:invalid_min_door_count:LENGTHS'
          ,'safety_type:invalid_alpha:ALLOW'
          ,'airbag_driver:invalid_alpha:ALLOW'
          ,'airbag_front_driver_side:invalid_alpha:ALLOW'
          ,'airbag_front_head_curtain:invalid_alpha:ALLOW'
          ,'airbag_front_pass:invalid_alpha:ALLOW'
          ,'airbag_front_pass_side:invalid_alpha:ALLOW'
          ,'airbags:invalid_alpha:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Experian_Fields.InvalidMessage_append_process_date(1),Experian_Fields.InvalidMessage_append_process_date(2)
          ,Experian_Fields.InvalidMessage_append_state_origin(1),Experian_Fields.InvalidMessage_append_state_origin(2)
          ,Experian_Fields.InvalidMessage_file_typ(1),Experian_Fields.InvalidMessage_file_typ(2)
          ,Experian_Fields.InvalidMessage_vin(1),Experian_Fields.InvalidMessage_vin(2)
          ,Experian_Fields.InvalidMessage_vehicle_typ(1),Experian_Fields.InvalidMessage_vehicle_typ(2)
          ,Experian_Fields.InvalidMessage_model_yr(1),Experian_Fields.InvalidMessage_model_yr(2)
          ,Experian_Fields.InvalidMessage_model_yr_ind(1),Experian_Fields.InvalidMessage_model_yr_ind(2)
          ,Experian_Fields.InvalidMessage_make(1)
          ,Experian_Fields.InvalidMessage_make_ind(1),Experian_Fields.InvalidMessage_make_ind(2)
          ,Experian_Fields.InvalidMessage_series(1)
          ,Experian_Fields.InvalidMessage_series_ind(1),Experian_Fields.InvalidMessage_series_ind(2)
          ,Experian_Fields.InvalidMessage_prime_color(1),Experian_Fields.InvalidMessage_prime_color(2)
          ,Experian_Fields.InvalidMessage_second_color(1),Experian_Fields.InvalidMessage_second_color(2)
          ,Experian_Fields.InvalidMessage_body_style(1)
          ,Experian_Fields.InvalidMessage_body_style_ind(1),Experian_Fields.InvalidMessage_body_style_ind(2)
          ,Experian_Fields.InvalidMessage_model(1)
          ,Experian_Fields.InvalidMessage_model_ind(1),Experian_Fields.InvalidMessage_model_ind(2)
          ,Experian_Fields.InvalidMessage_weight(1)
          ,Experian_Fields.InvalidMessage_lengt(1)
          ,Experian_Fields.InvalidMessage_axle_cnt(1)
          ,Experian_Fields.InvalidMessage_plate_nbr(1)
          ,Experian_Fields.InvalidMessage_plate_state(1),Experian_Fields.InvalidMessage_plate_state(2)
          ,Experian_Fields.InvalidMessage_prev_plate_nbr(1)
          ,Experian_Fields.InvalidMessage_prev_plate_state(1),Experian_Fields.InvalidMessage_prev_plate_state(2)
          ,Experian_Fields.InvalidMessage_plate_typ_cd(1),Experian_Fields.InvalidMessage_plate_typ_cd(2)
          ,Experian_Fields.InvalidMessage_mstr_src_state(1),Experian_Fields.InvalidMessage_mstr_src_state(2)
          ,Experian_Fields.InvalidMessage_reg_decal_nbr(1)
          ,Experian_Fields.InvalidMessage_org_reg_dt(1),Experian_Fields.InvalidMessage_org_reg_dt(2)
          ,Experian_Fields.InvalidMessage_reg_renew_dt(1),Experian_Fields.InvalidMessage_reg_renew_dt(2)
          ,Experian_Fields.InvalidMessage_reg_exp_dt(1),Experian_Fields.InvalidMessage_reg_exp_dt(2)
          ,Experian_Fields.InvalidMessage_title_nbr(1)
          ,Experian_Fields.InvalidMessage_org_title_dt(1),Experian_Fields.InvalidMessage_org_title_dt(2)
          ,Experian_Fields.InvalidMessage_title_trans_dt(1),Experian_Fields.InvalidMessage_title_trans_dt(2)
          ,Experian_Fields.InvalidMessage_name_typ_cd(1),Experian_Fields.InvalidMessage_name_typ_cd(2)
          ,Experian_Fields.InvalidMessage_owner_typ_cd(1),Experian_Fields.InvalidMessage_owner_typ_cd(2)
          ,Experian_Fields.InvalidMessage_first_nm(1)
          ,Experian_Fields.InvalidMessage_middle_nm(1)
          ,Experian_Fields.InvalidMessage_last_nm(1)
          ,Experian_Fields.InvalidMessage_name_suffix(1)
          ,Experian_Fields.InvalidMessage_prof_suffix(1)
          ,Experian_Fields.InvalidMessage_ind_ssn(1),Experian_Fields.InvalidMessage_ind_ssn(2)
          ,Experian_Fields.InvalidMessage_ind_dob(1),Experian_Fields.InvalidMessage_ind_dob(2)
          ,Experian_Fields.InvalidMessage_mail_range(1)
          ,Experian_Fields.InvalidMessage_m_pre_dir(1)
          ,Experian_Fields.InvalidMessage_m_street(1)
          ,Experian_Fields.InvalidMessage_m_suffix(1)
          ,Experian_Fields.InvalidMessage_m_post_dir(1)
          ,Experian_Fields.InvalidMessage_m_pob(1)
          ,Experian_Fields.InvalidMessage_m_rr_nbr(1)
          ,Experian_Fields.InvalidMessage_m_rr_box(1)
          ,Experian_Fields.InvalidMessage_m_scndry_rng(1)
          ,Experian_Fields.InvalidMessage_m_scndry_des(1)
          ,Experian_Fields.InvalidMessage_m_city(1)
          ,Experian_Fields.InvalidMessage_m_state(1),Experian_Fields.InvalidMessage_m_state(2)
          ,Experian_Fields.InvalidMessage_m_zip5(1),Experian_Fields.InvalidMessage_m_zip5(2)
          ,Experian_Fields.InvalidMessage_m_zip4(1),Experian_Fields.InvalidMessage_m_zip4(2)
          ,Experian_Fields.InvalidMessage_m_cc(1),Experian_Fields.InvalidMessage_m_cc(2)
          ,Experian_Fields.InvalidMessage_m_county(1)
          ,Experian_Fields.InvalidMessage_phys_range(1)
          ,Experian_Fields.InvalidMessage_p_pre_dir(1)
          ,Experian_Fields.InvalidMessage_p_street(1)
          ,Experian_Fields.InvalidMessage_p_suffix(1)
          ,Experian_Fields.InvalidMessage_p_post_dir(1)
          ,Experian_Fields.InvalidMessage_p_pob(1)
          ,Experian_Fields.InvalidMessage_p_rr_nbr(1)
          ,Experian_Fields.InvalidMessage_p_rr_box(1)
          ,Experian_Fields.InvalidMessage_p_scndry_rng(1)
          ,Experian_Fields.InvalidMessage_p_scndry_des(1)
          ,Experian_Fields.InvalidMessage_p_city(1)
          ,Experian_Fields.InvalidMessage_p_state(1),Experian_Fields.InvalidMessage_p_state(2)
          ,Experian_Fields.InvalidMessage_p_zip5(1),Experian_Fields.InvalidMessage_p_zip5(2)
          ,Experian_Fields.InvalidMessage_p_zip4(1),Experian_Fields.InvalidMessage_p_zip4(2)
          ,Experian_Fields.InvalidMessage_p_cc(1),Experian_Fields.InvalidMessage_p_cc(2)
          ,Experian_Fields.InvalidMessage_p_county(1)
          ,Experian_Fields.InvalidMessage_opt_out_cd(1),Experian_Fields.InvalidMessage_opt_out_cd(2)
          ,Experian_Fields.InvalidMessage_asg_wgt(1)
          ,Experian_Fields.InvalidMessage_asg_wgt_uom(1),Experian_Fields.InvalidMessage_asg_wgt_uom(2)
          ,Experian_Fields.InvalidMessage_source_ctl_id(1)
          ,Experian_Fields.InvalidMessage_raw_name(1)
          ,Experian_Fields.InvalidMessage_branded_title_flag(1),Experian_Fields.InvalidMessage_branded_title_flag(2)
          ,Experian_Fields.InvalidMessage_brand_code_1(1),Experian_Fields.InvalidMessage_brand_code_1(2)
          ,Experian_Fields.InvalidMessage_brand_date_1(1),Experian_Fields.InvalidMessage_brand_date_1(2)
          ,Experian_Fields.InvalidMessage_brand_state_1(1),Experian_Fields.InvalidMessage_brand_state_1(2)
          ,Experian_Fields.InvalidMessage_brand_code_2(1),Experian_Fields.InvalidMessage_brand_code_2(2)
          ,Experian_Fields.InvalidMessage_brand_date_2(1),Experian_Fields.InvalidMessage_brand_date_2(2)
          ,Experian_Fields.InvalidMessage_brand_state_2(1),Experian_Fields.InvalidMessage_brand_state_2(2)
          ,Experian_Fields.InvalidMessage_brand_code_3(1),Experian_Fields.InvalidMessage_brand_code_3(2)
          ,Experian_Fields.InvalidMessage_brand_date_3(1),Experian_Fields.InvalidMessage_brand_date_3(2)
          ,Experian_Fields.InvalidMessage_brand_state_3(1),Experian_Fields.InvalidMessage_brand_state_3(2)
          ,Experian_Fields.InvalidMessage_brand_code_4(1),Experian_Fields.InvalidMessage_brand_code_4(2)
          ,Experian_Fields.InvalidMessage_brand_date_4(1),Experian_Fields.InvalidMessage_brand_date_4(2)
          ,Experian_Fields.InvalidMessage_brand_state_4(1),Experian_Fields.InvalidMessage_brand_state_4(2)
          ,Experian_Fields.InvalidMessage_brand_code_5(1),Experian_Fields.InvalidMessage_brand_code_5(2)
          ,Experian_Fields.InvalidMessage_brand_date_5(1),Experian_Fields.InvalidMessage_brand_date_5(2)
          ,Experian_Fields.InvalidMessage_brand_state_5(1),Experian_Fields.InvalidMessage_brand_state_5(2)
          ,Experian_Fields.InvalidMessage_tod_flag(1),Experian_Fields.InvalidMessage_tod_flag(2)
          ,Experian_Fields.InvalidMessage_model_class(1)
          ,Experian_Fields.InvalidMessage_min_door_count(1),Experian_Fields.InvalidMessage_min_door_count(2)
          ,Experian_Fields.InvalidMessage_safety_type(1)
          ,Experian_Fields.InvalidMessage_airbag_driver(1)
          ,Experian_Fields.InvalidMessage_airbag_front_driver_side(1)
          ,Experian_Fields.InvalidMessage_airbag_front_head_curtain(1)
          ,Experian_Fields.InvalidMessage_airbag_front_pass(1)
          ,Experian_Fields.InvalidMessage_airbag_front_pass_side(1)
          ,Experian_Fields.InvalidMessage_airbags(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.append_process_date_ALLOW_ErrorCount,le.append_process_date_LENGTHS_ErrorCount
          ,le.append_state_origin_ALLOW_ErrorCount,le.append_state_origin_LENGTHS_ErrorCount
          ,le.file_typ_ENUM_ErrorCount,le.file_typ_LENGTHS_ErrorCount
          ,le.vin_ALLOW_ErrorCount,le.vin_LENGTHS_ErrorCount
          ,le.vehicle_typ_ENUM_ErrorCount,le.vehicle_typ_LENGTHS_ErrorCount
          ,le.model_yr_ALLOW_ErrorCount,le.model_yr_LENGTHS_ErrorCount
          ,le.model_yr_ind_ENUM_ErrorCount,le.model_yr_ind_LENGTHS_ErrorCount
          ,le.make_ALLOW_ErrorCount
          ,le.make_ind_ENUM_ErrorCount,le.make_ind_LENGTHS_ErrorCount
          ,le.series_ALLOW_ErrorCount
          ,le.series_ind_ENUM_ErrorCount,le.series_ind_LENGTHS_ErrorCount
          ,le.prime_color_CAPS_ErrorCount,le.prime_color_ALLOW_ErrorCount
          ,le.second_color_CAPS_ErrorCount,le.second_color_ALLOW_ErrorCount
          ,le.body_style_ALLOW_ErrorCount
          ,le.body_style_ind_ENUM_ErrorCount,le.body_style_ind_LENGTHS_ErrorCount
          ,le.model_ALLOW_ErrorCount
          ,le.model_ind_ENUM_ErrorCount,le.model_ind_LENGTHS_ErrorCount
          ,le.weight_ALLOW_ErrorCount
          ,le.lengt_ALLOW_ErrorCount
          ,le.axle_cnt_ALLOW_ErrorCount
          ,le.plate_nbr_ALLOW_ErrorCount
          ,le.plate_state_ALLOW_ErrorCount,le.plate_state_LENGTHS_ErrorCount
          ,le.prev_plate_nbr_ALLOW_ErrorCount
          ,le.prev_plate_state_ALLOW_ErrorCount,le.prev_plate_state_LENGTHS_ErrorCount
          ,le.plate_typ_cd_CAPS_ErrorCount,le.plate_typ_cd_ALLOW_ErrorCount
          ,le.mstr_src_state_ALLOW_ErrorCount,le.mstr_src_state_LENGTHS_ErrorCount
          ,le.reg_decal_nbr_ALLOW_ErrorCount
          ,le.org_reg_dt_ALLOW_ErrorCount,le.org_reg_dt_LENGTHS_ErrorCount
          ,le.reg_renew_dt_ALLOW_ErrorCount,le.reg_renew_dt_LENGTHS_ErrorCount
          ,le.reg_exp_dt_ALLOW_ErrorCount,le.reg_exp_dt_LENGTHS_ErrorCount
          ,le.title_nbr_ALLOW_ErrorCount
          ,le.org_title_dt_ALLOW_ErrorCount,le.org_title_dt_LENGTHS_ErrorCount
          ,le.title_trans_dt_ALLOW_ErrorCount,le.title_trans_dt_LENGTHS_ErrorCount
          ,le.name_typ_cd_ENUM_ErrorCount,le.name_typ_cd_LENGTHS_ErrorCount
          ,le.owner_typ_cd_ENUM_ErrorCount,le.owner_typ_cd_LENGTHS_ErrorCount
          ,le.first_nm_ALLOW_ErrorCount
          ,le.middle_nm_ALLOW_ErrorCount
          ,le.last_nm_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.prof_suffix_ALLOW_ErrorCount
          ,le.ind_ssn_ALLOW_ErrorCount,le.ind_ssn_LENGTHS_ErrorCount
          ,le.ind_dob_ALLOW_ErrorCount,le.ind_dob_LENGTHS_ErrorCount
          ,le.mail_range_ALLOW_ErrorCount
          ,le.m_pre_dir_ALLOW_ErrorCount
          ,le.m_street_ALLOW_ErrorCount
          ,le.m_suffix_ALLOW_ErrorCount
          ,le.m_post_dir_ALLOW_ErrorCount
          ,le.m_pob_ALLOW_ErrorCount
          ,le.m_rr_nbr_ALLOW_ErrorCount
          ,le.m_rr_box_ALLOW_ErrorCount
          ,le.m_scndry_rng_ALLOW_ErrorCount
          ,le.m_scndry_des_ALLOW_ErrorCount
          ,le.m_city_ALLOW_ErrorCount
          ,le.m_state_ALLOW_ErrorCount,le.m_state_LENGTHS_ErrorCount
          ,le.m_zip5_ALLOW_ErrorCount,le.m_zip5_LENGTHS_ErrorCount
          ,le.m_zip4_ALLOW_ErrorCount,le.m_zip4_LENGTHS_ErrorCount
          ,le.m_cc_ENUM_ErrorCount,le.m_cc_LENGTHS_ErrorCount
          ,le.m_county_ALLOW_ErrorCount
          ,le.phys_range_ALLOW_ErrorCount
          ,le.p_pre_dir_ALLOW_ErrorCount
          ,le.p_street_ALLOW_ErrorCount
          ,le.p_suffix_ALLOW_ErrorCount
          ,le.p_post_dir_ALLOW_ErrorCount
          ,le.p_pob_ALLOW_ErrorCount
          ,le.p_rr_nbr_ALLOW_ErrorCount
          ,le.p_rr_box_ALLOW_ErrorCount
          ,le.p_scndry_rng_ALLOW_ErrorCount
          ,le.p_scndry_des_ALLOW_ErrorCount
          ,le.p_city_ALLOW_ErrorCount
          ,le.p_state_ALLOW_ErrorCount,le.p_state_LENGTHS_ErrorCount
          ,le.p_zip5_ALLOW_ErrorCount,le.p_zip5_LENGTHS_ErrorCount
          ,le.p_zip4_ALLOW_ErrorCount,le.p_zip4_LENGTHS_ErrorCount
          ,le.p_cc_ENUM_ErrorCount,le.p_cc_LENGTHS_ErrorCount
          ,le.p_county_ALLOW_ErrorCount
          ,le.opt_out_cd_ENUM_ErrorCount,le.opt_out_cd_LENGTHS_ErrorCount
          ,le.asg_wgt_ALLOW_ErrorCount
          ,le.asg_wgt_uom_CAPS_ErrorCount,le.asg_wgt_uom_ALLOW_ErrorCount
          ,le.source_ctl_id_ALLOW_ErrorCount
          ,le.raw_name_ALLOW_ErrorCount
          ,le.branded_title_flag_ENUM_ErrorCount,le.branded_title_flag_LENGTHS_ErrorCount
          ,le.brand_code_1_CAPS_ErrorCount,le.brand_code_1_ALLOW_ErrorCount
          ,le.brand_date_1_ALLOW_ErrorCount,le.brand_date_1_LENGTHS_ErrorCount
          ,le.brand_state_1_ALLOW_ErrorCount,le.brand_state_1_LENGTHS_ErrorCount
          ,le.brand_code_2_CAPS_ErrorCount,le.brand_code_2_ALLOW_ErrorCount
          ,le.brand_date_2_ALLOW_ErrorCount,le.brand_date_2_LENGTHS_ErrorCount
          ,le.brand_state_2_ALLOW_ErrorCount,le.brand_state_2_LENGTHS_ErrorCount
          ,le.brand_code_3_CAPS_ErrorCount,le.brand_code_3_ALLOW_ErrorCount
          ,le.brand_date_3_ALLOW_ErrorCount,le.brand_date_3_LENGTHS_ErrorCount
          ,le.brand_state_3_ALLOW_ErrorCount,le.brand_state_3_LENGTHS_ErrorCount
          ,le.brand_code_4_CAPS_ErrorCount,le.brand_code_4_ALLOW_ErrorCount
          ,le.brand_date_4_ALLOW_ErrorCount,le.brand_date_4_LENGTHS_ErrorCount
          ,le.brand_state_4_ALLOW_ErrorCount,le.brand_state_4_LENGTHS_ErrorCount
          ,le.brand_code_5_CAPS_ErrorCount,le.brand_code_5_ALLOW_ErrorCount
          ,le.brand_date_5_ALLOW_ErrorCount,le.brand_date_5_LENGTHS_ErrorCount
          ,le.brand_state_5_ALLOW_ErrorCount,le.brand_state_5_LENGTHS_ErrorCount
          ,le.tod_flag_ENUM_ErrorCount,le.tod_flag_LENGTHS_ErrorCount
          ,le.model_class_ALLOW_ErrorCount
          ,le.min_door_count_ALLOW_ErrorCount,le.min_door_count_LENGTHS_ErrorCount
          ,le.safety_type_ALLOW_ErrorCount
          ,le.airbag_driver_ALLOW_ErrorCount
          ,le.airbag_front_driver_side_ALLOW_ErrorCount
          ,le.airbag_front_head_curtain_ALLOW_ErrorCount
          ,le.airbag_front_pass_ALLOW_ErrorCount
          ,le.airbag_front_pass_side_ALLOW_ErrorCount
          ,le.airbags_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.append_process_date_ALLOW_ErrorCount,le.append_process_date_LENGTHS_ErrorCount
          ,le.append_state_origin_ALLOW_ErrorCount,le.append_state_origin_LENGTHS_ErrorCount
          ,le.file_typ_ENUM_ErrorCount,le.file_typ_LENGTHS_ErrorCount
          ,le.vin_ALLOW_ErrorCount,le.vin_LENGTHS_ErrorCount
          ,le.vehicle_typ_ENUM_ErrorCount,le.vehicle_typ_LENGTHS_ErrorCount
          ,le.model_yr_ALLOW_ErrorCount,le.model_yr_LENGTHS_ErrorCount
          ,le.model_yr_ind_ENUM_ErrorCount,le.model_yr_ind_LENGTHS_ErrorCount
          ,le.make_ALLOW_ErrorCount
          ,le.make_ind_ENUM_ErrorCount,le.make_ind_LENGTHS_ErrorCount
          ,le.series_ALLOW_ErrorCount
          ,le.series_ind_ENUM_ErrorCount,le.series_ind_LENGTHS_ErrorCount
          ,le.prime_color_CAPS_ErrorCount,le.prime_color_ALLOW_ErrorCount
          ,le.second_color_CAPS_ErrorCount,le.second_color_ALLOW_ErrorCount
          ,le.body_style_ALLOW_ErrorCount
          ,le.body_style_ind_ENUM_ErrorCount,le.body_style_ind_LENGTHS_ErrorCount
          ,le.model_ALLOW_ErrorCount
          ,le.model_ind_ENUM_ErrorCount,le.model_ind_LENGTHS_ErrorCount
          ,le.weight_ALLOW_ErrorCount
          ,le.lengt_ALLOW_ErrorCount
          ,le.axle_cnt_ALLOW_ErrorCount
          ,le.plate_nbr_ALLOW_ErrorCount
          ,le.plate_state_ALLOW_ErrorCount,le.plate_state_LENGTHS_ErrorCount
          ,le.prev_plate_nbr_ALLOW_ErrorCount
          ,le.prev_plate_state_ALLOW_ErrorCount,le.prev_plate_state_LENGTHS_ErrorCount
          ,le.plate_typ_cd_CAPS_ErrorCount,le.plate_typ_cd_ALLOW_ErrorCount
          ,le.mstr_src_state_ALLOW_ErrorCount,le.mstr_src_state_LENGTHS_ErrorCount
          ,le.reg_decal_nbr_ALLOW_ErrorCount
          ,le.org_reg_dt_ALLOW_ErrorCount,le.org_reg_dt_LENGTHS_ErrorCount
          ,le.reg_renew_dt_ALLOW_ErrorCount,le.reg_renew_dt_LENGTHS_ErrorCount
          ,le.reg_exp_dt_ALLOW_ErrorCount,le.reg_exp_dt_LENGTHS_ErrorCount
          ,le.title_nbr_ALLOW_ErrorCount
          ,le.org_title_dt_ALLOW_ErrorCount,le.org_title_dt_LENGTHS_ErrorCount
          ,le.title_trans_dt_ALLOW_ErrorCount,le.title_trans_dt_LENGTHS_ErrorCount
          ,le.name_typ_cd_ENUM_ErrorCount,le.name_typ_cd_LENGTHS_ErrorCount
          ,le.owner_typ_cd_ENUM_ErrorCount,le.owner_typ_cd_LENGTHS_ErrorCount
          ,le.first_nm_ALLOW_ErrorCount
          ,le.middle_nm_ALLOW_ErrorCount
          ,le.last_nm_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.prof_suffix_ALLOW_ErrorCount
          ,le.ind_ssn_ALLOW_ErrorCount,le.ind_ssn_LENGTHS_ErrorCount
          ,le.ind_dob_ALLOW_ErrorCount,le.ind_dob_LENGTHS_ErrorCount
          ,le.mail_range_ALLOW_ErrorCount
          ,le.m_pre_dir_ALLOW_ErrorCount
          ,le.m_street_ALLOW_ErrorCount
          ,le.m_suffix_ALLOW_ErrorCount
          ,le.m_post_dir_ALLOW_ErrorCount
          ,le.m_pob_ALLOW_ErrorCount
          ,le.m_rr_nbr_ALLOW_ErrorCount
          ,le.m_rr_box_ALLOW_ErrorCount
          ,le.m_scndry_rng_ALLOW_ErrorCount
          ,le.m_scndry_des_ALLOW_ErrorCount
          ,le.m_city_ALLOW_ErrorCount
          ,le.m_state_ALLOW_ErrorCount,le.m_state_LENGTHS_ErrorCount
          ,le.m_zip5_ALLOW_ErrorCount,le.m_zip5_LENGTHS_ErrorCount
          ,le.m_zip4_ALLOW_ErrorCount,le.m_zip4_LENGTHS_ErrorCount
          ,le.m_cc_ENUM_ErrorCount,le.m_cc_LENGTHS_ErrorCount
          ,le.m_county_ALLOW_ErrorCount
          ,le.phys_range_ALLOW_ErrorCount
          ,le.p_pre_dir_ALLOW_ErrorCount
          ,le.p_street_ALLOW_ErrorCount
          ,le.p_suffix_ALLOW_ErrorCount
          ,le.p_post_dir_ALLOW_ErrorCount
          ,le.p_pob_ALLOW_ErrorCount
          ,le.p_rr_nbr_ALLOW_ErrorCount
          ,le.p_rr_box_ALLOW_ErrorCount
          ,le.p_scndry_rng_ALLOW_ErrorCount
          ,le.p_scndry_des_ALLOW_ErrorCount
          ,le.p_city_ALLOW_ErrorCount
          ,le.p_state_ALLOW_ErrorCount,le.p_state_LENGTHS_ErrorCount
          ,le.p_zip5_ALLOW_ErrorCount,le.p_zip5_LENGTHS_ErrorCount
          ,le.p_zip4_ALLOW_ErrorCount,le.p_zip4_LENGTHS_ErrorCount
          ,le.p_cc_ENUM_ErrorCount,le.p_cc_LENGTHS_ErrorCount
          ,le.p_county_ALLOW_ErrorCount
          ,le.opt_out_cd_ENUM_ErrorCount,le.opt_out_cd_LENGTHS_ErrorCount
          ,le.asg_wgt_ALLOW_ErrorCount
          ,le.asg_wgt_uom_CAPS_ErrorCount,le.asg_wgt_uom_ALLOW_ErrorCount
          ,le.source_ctl_id_ALLOW_ErrorCount
          ,le.raw_name_ALLOW_ErrorCount
          ,le.branded_title_flag_ENUM_ErrorCount,le.branded_title_flag_LENGTHS_ErrorCount
          ,le.brand_code_1_CAPS_ErrorCount,le.brand_code_1_ALLOW_ErrorCount
          ,le.brand_date_1_ALLOW_ErrorCount,le.brand_date_1_LENGTHS_ErrorCount
          ,le.brand_state_1_ALLOW_ErrorCount,le.brand_state_1_LENGTHS_ErrorCount
          ,le.brand_code_2_CAPS_ErrorCount,le.brand_code_2_ALLOW_ErrorCount
          ,le.brand_date_2_ALLOW_ErrorCount,le.brand_date_2_LENGTHS_ErrorCount
          ,le.brand_state_2_ALLOW_ErrorCount,le.brand_state_2_LENGTHS_ErrorCount
          ,le.brand_code_3_CAPS_ErrorCount,le.brand_code_3_ALLOW_ErrorCount
          ,le.brand_date_3_ALLOW_ErrorCount,le.brand_date_3_LENGTHS_ErrorCount
          ,le.brand_state_3_ALLOW_ErrorCount,le.brand_state_3_LENGTHS_ErrorCount
          ,le.brand_code_4_CAPS_ErrorCount,le.brand_code_4_ALLOW_ErrorCount
          ,le.brand_date_4_ALLOW_ErrorCount,le.brand_date_4_LENGTHS_ErrorCount
          ,le.brand_state_4_ALLOW_ErrorCount,le.brand_state_4_LENGTHS_ErrorCount
          ,le.brand_code_5_CAPS_ErrorCount,le.brand_code_5_ALLOW_ErrorCount
          ,le.brand_date_5_ALLOW_ErrorCount,le.brand_date_5_LENGTHS_ErrorCount
          ,le.brand_state_5_ALLOW_ErrorCount,le.brand_state_5_LENGTHS_ErrorCount
          ,le.tod_flag_ENUM_ErrorCount,le.tod_flag_LENGTHS_ErrorCount
          ,le.model_class_ALLOW_ErrorCount
          ,le.min_door_count_ALLOW_ErrorCount,le.min_door_count_LENGTHS_ErrorCount
          ,le.safety_type_ALLOW_ErrorCount
          ,le.airbag_driver_ALLOW_ErrorCount
          ,le.airbag_front_driver_side_ALLOW_ErrorCount
          ,le.airbag_front_head_curtain_ALLOW_ErrorCount
          ,le.airbag_front_pass_ALLOW_ErrorCount
          ,le.airbag_front_pass_side_ALLOW_ErrorCount
          ,le.airbags_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);

    // field population stats
    mod_hygiene := Experian_hygiene(PROJECT(h, Experian_Layout_VehicleV2));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'append_process_date:' + getFieldTypeText(h.append_process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_state_origin:' + getFieldTypeText(h.append_state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_typ:' + getFieldTypeText(h.file_typ) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vin:' + getFieldTypeText(h.vin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vehicle_typ:' + getFieldTypeText(h.vehicle_typ) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_yr:' + getFieldTypeText(h.model_yr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_yr_ind:' + getFieldTypeText(h.model_yr_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'make:' + getFieldTypeText(h.make) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'make_ind:' + getFieldTypeText(h.make_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'series:' + getFieldTypeText(h.series) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'series_ind:' + getFieldTypeText(h.series_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prime_color:' + getFieldTypeText(h.prime_color) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'second_color:' + getFieldTypeText(h.second_color) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'body_style:' + getFieldTypeText(h.body_style) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'body_style_ind:' + getFieldTypeText(h.body_style_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model:' + getFieldTypeText(h.model) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_ind:' + getFieldTypeText(h.model_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'weight:' + getFieldTypeText(h.weight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lengt:' + getFieldTypeText(h.lengt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'axle_cnt:' + getFieldTypeText(h.axle_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plate_nbr:' + getFieldTypeText(h.plate_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plate_state:' + getFieldTypeText(h.plate_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prev_plate_nbr:' + getFieldTypeText(h.prev_plate_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prev_plate_state:' + getFieldTypeText(h.prev_plate_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plate_typ_cd:' + getFieldTypeText(h.plate_typ_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mstr_src_state:' + getFieldTypeText(h.mstr_src_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reg_decal_nbr:' + getFieldTypeText(h.reg_decal_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'org_reg_dt:' + getFieldTypeText(h.org_reg_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reg_renew_dt:' + getFieldTypeText(h.reg_renew_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reg_exp_dt:' + getFieldTypeText(h.reg_exp_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title_nbr:' + getFieldTypeText(h.title_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'org_title_dt:' + getFieldTypeText(h.org_title_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title_trans_dt:' + getFieldTypeText(h.title_trans_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_typ_cd:' + getFieldTypeText(h.name_typ_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'owner_typ_cd:' + getFieldTypeText(h.owner_typ_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_nm:' + getFieldTypeText(h.first_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middle_nm:' + getFieldTypeText(h.middle_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_nm:' + getFieldTypeText(h.last_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prof_suffix:' + getFieldTypeText(h.prof_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ind_ssn:' + getFieldTypeText(h.ind_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ind_dob:' + getFieldTypeText(h.ind_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_range:' + getFieldTypeText(h.mail_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_pre_dir:' + getFieldTypeText(h.m_pre_dir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_street:' + getFieldTypeText(h.m_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_suffix:' + getFieldTypeText(h.m_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_post_dir:' + getFieldTypeText(h.m_post_dir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_pob:' + getFieldTypeText(h.m_pob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_rr_nbr:' + getFieldTypeText(h.m_rr_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_rr_box:' + getFieldTypeText(h.m_rr_box) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_scndry_rng:' + getFieldTypeText(h.m_scndry_rng) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_scndry_des:' + getFieldTypeText(h.m_scndry_des) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_city:' + getFieldTypeText(h.m_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_state:' + getFieldTypeText(h.m_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_zip5:' + getFieldTypeText(h.m_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_zip4:' + getFieldTypeText(h.m_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_cntry_cd:' + getFieldTypeText(h.m_cntry_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_cc_filler:' + getFieldTypeText(h.m_cc_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_cc:' + getFieldTypeText(h.m_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'m_county:' + getFieldTypeText(h.m_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phys_range:' + getFieldTypeText(h.phys_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_pre_dir:' + getFieldTypeText(h.p_pre_dir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_street:' + getFieldTypeText(h.p_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_suffix:' + getFieldTypeText(h.p_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_post_dir:' + getFieldTypeText(h.p_post_dir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_pob:' + getFieldTypeText(h.p_pob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_rr_nbr:' + getFieldTypeText(h.p_rr_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_rr_box:' + getFieldTypeText(h.p_rr_box) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_scndry_rng:' + getFieldTypeText(h.p_scndry_rng) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_scndry_des:' + getFieldTypeText(h.p_scndry_des) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city:' + getFieldTypeText(h.p_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_state:' + getFieldTypeText(h.p_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_zip5:' + getFieldTypeText(h.p_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_zip4:' + getFieldTypeText(h.p_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_cntry_cd:' + getFieldTypeText(h.p_cntry_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_cc_filler:' + getFieldTypeText(h.p_cc_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_cc:' + getFieldTypeText(h.p_cc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_county:' + getFieldTypeText(h.p_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'opt_out_cd:' + getFieldTypeText(h.opt_out_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'asg_wgt:' + getFieldTypeText(h.asg_wgt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'asg_wgt_uom:' + getFieldTypeText(h.asg_wgt_uom) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_ctl_id:' + getFieldTypeText(h.source_ctl_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_name:' + getFieldTypeText(h.raw_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'branded_title_flag:' + getFieldTypeText(h.branded_title_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_code_1:' + getFieldTypeText(h.brand_code_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_date_1:' + getFieldTypeText(h.brand_date_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_state_1:' + getFieldTypeText(h.brand_state_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_code_2:' + getFieldTypeText(h.brand_code_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_date_2:' + getFieldTypeText(h.brand_date_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_state_2:' + getFieldTypeText(h.brand_state_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_code_3:' + getFieldTypeText(h.brand_code_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_date_3:' + getFieldTypeText(h.brand_date_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_state_3:' + getFieldTypeText(h.brand_state_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_code_4:' + getFieldTypeText(h.brand_code_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_date_4:' + getFieldTypeText(h.brand_date_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_state_4:' + getFieldTypeText(h.brand_state_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_code_5:' + getFieldTypeText(h.brand_code_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_date_5:' + getFieldTypeText(h.brand_date_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'brand_state_5:' + getFieldTypeText(h.brand_state_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tod_flag:' + getFieldTypeText(h.tod_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_class_code:' + getFieldTypeText(h.model_class_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_class:' + getFieldTypeText(h.model_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'min_door_count:' + getFieldTypeText(h.min_door_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'safety_type:' + getFieldTypeText(h.safety_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'airbag_driver:' + getFieldTypeText(h.airbag_driver) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'airbag_front_driver_side:' + getFieldTypeText(h.airbag_front_driver_side) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'airbag_front_head_curtain:' + getFieldTypeText(h.airbag_front_head_curtain) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'airbag_front_pass:' + getFieldTypeText(h.airbag_front_pass) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'airbag_front_pass_side:' + getFieldTypeText(h.airbag_front_pass_side) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'airbags:' + getFieldTypeText(h.airbags) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_append_process_date_cnt
          ,le.populated_append_state_origin_cnt
          ,le.populated_file_typ_cnt
          ,le.populated_vin_cnt
          ,le.populated_vehicle_typ_cnt
          ,le.populated_model_yr_cnt
          ,le.populated_model_yr_ind_cnt
          ,le.populated_make_cnt
          ,le.populated_make_ind_cnt
          ,le.populated_series_cnt
          ,le.populated_series_ind_cnt
          ,le.populated_prime_color_cnt
          ,le.populated_second_color_cnt
          ,le.populated_body_style_cnt
          ,le.populated_body_style_ind_cnt
          ,le.populated_model_cnt
          ,le.populated_model_ind_cnt
          ,le.populated_weight_cnt
          ,le.populated_lengt_cnt
          ,le.populated_axle_cnt_cnt
          ,le.populated_plate_nbr_cnt
          ,le.populated_plate_state_cnt
          ,le.populated_prev_plate_nbr_cnt
          ,le.populated_prev_plate_state_cnt
          ,le.populated_plate_typ_cd_cnt
          ,le.populated_mstr_src_state_cnt
          ,le.populated_reg_decal_nbr_cnt
          ,le.populated_org_reg_dt_cnt
          ,le.populated_reg_renew_dt_cnt
          ,le.populated_reg_exp_dt_cnt
          ,le.populated_title_nbr_cnt
          ,le.populated_org_title_dt_cnt
          ,le.populated_title_trans_dt_cnt
          ,le.populated_name_typ_cd_cnt
          ,le.populated_owner_typ_cd_cnt
          ,le.populated_first_nm_cnt
          ,le.populated_middle_nm_cnt
          ,le.populated_last_nm_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_prof_suffix_cnt
          ,le.populated_ind_ssn_cnt
          ,le.populated_ind_dob_cnt
          ,le.populated_mail_range_cnt
          ,le.populated_m_pre_dir_cnt
          ,le.populated_m_street_cnt
          ,le.populated_m_suffix_cnt
          ,le.populated_m_post_dir_cnt
          ,le.populated_m_pob_cnt
          ,le.populated_m_rr_nbr_cnt
          ,le.populated_m_rr_box_cnt
          ,le.populated_m_scndry_rng_cnt
          ,le.populated_m_scndry_des_cnt
          ,le.populated_m_city_cnt
          ,le.populated_m_state_cnt
          ,le.populated_m_zip5_cnt
          ,le.populated_m_zip4_cnt
          ,le.populated_m_cntry_cd_cnt
          ,le.populated_m_cc_filler_cnt
          ,le.populated_m_cc_cnt
          ,le.populated_m_county_cnt
          ,le.populated_phys_range_cnt
          ,le.populated_p_pre_dir_cnt
          ,le.populated_p_street_cnt
          ,le.populated_p_suffix_cnt
          ,le.populated_p_post_dir_cnt
          ,le.populated_p_pob_cnt
          ,le.populated_p_rr_nbr_cnt
          ,le.populated_p_rr_box_cnt
          ,le.populated_p_scndry_rng_cnt
          ,le.populated_p_scndry_des_cnt
          ,le.populated_p_city_cnt
          ,le.populated_p_state_cnt
          ,le.populated_p_zip5_cnt
          ,le.populated_p_zip4_cnt
          ,le.populated_p_cntry_cd_cnt
          ,le.populated_p_cc_filler_cnt
          ,le.populated_p_cc_cnt
          ,le.populated_p_county_cnt
          ,le.populated_opt_out_cd_cnt
          ,le.populated_asg_wgt_cnt
          ,le.populated_asg_wgt_uom_cnt
          ,le.populated_source_ctl_id_cnt
          ,le.populated_raw_name_cnt
          ,le.populated_branded_title_flag_cnt
          ,le.populated_brand_code_1_cnt
          ,le.populated_brand_date_1_cnt
          ,le.populated_brand_state_1_cnt
          ,le.populated_brand_code_2_cnt
          ,le.populated_brand_date_2_cnt
          ,le.populated_brand_state_2_cnt
          ,le.populated_brand_code_3_cnt
          ,le.populated_brand_date_3_cnt
          ,le.populated_brand_state_3_cnt
          ,le.populated_brand_code_4_cnt
          ,le.populated_brand_date_4_cnt
          ,le.populated_brand_state_4_cnt
          ,le.populated_brand_code_5_cnt
          ,le.populated_brand_date_5_cnt
          ,le.populated_brand_state_5_cnt
          ,le.populated_tod_flag_cnt
          ,le.populated_model_class_code_cnt
          ,le.populated_model_class_cnt
          ,le.populated_min_door_count_cnt
          ,le.populated_safety_type_cnt
          ,le.populated_airbag_driver_cnt
          ,le.populated_airbag_front_driver_side_cnt
          ,le.populated_airbag_front_head_curtain_cnt
          ,le.populated_airbag_front_pass_cnt
          ,le.populated_airbag_front_pass_side_cnt
          ,le.populated_airbags_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_append_process_date_pcnt
          ,le.populated_append_state_origin_pcnt
          ,le.populated_file_typ_pcnt
          ,le.populated_vin_pcnt
          ,le.populated_vehicle_typ_pcnt
          ,le.populated_model_yr_pcnt
          ,le.populated_model_yr_ind_pcnt
          ,le.populated_make_pcnt
          ,le.populated_make_ind_pcnt
          ,le.populated_series_pcnt
          ,le.populated_series_ind_pcnt
          ,le.populated_prime_color_pcnt
          ,le.populated_second_color_pcnt
          ,le.populated_body_style_pcnt
          ,le.populated_body_style_ind_pcnt
          ,le.populated_model_pcnt
          ,le.populated_model_ind_pcnt
          ,le.populated_weight_pcnt
          ,le.populated_lengt_pcnt
          ,le.populated_axle_cnt_pcnt
          ,le.populated_plate_nbr_pcnt
          ,le.populated_plate_state_pcnt
          ,le.populated_prev_plate_nbr_pcnt
          ,le.populated_prev_plate_state_pcnt
          ,le.populated_plate_typ_cd_pcnt
          ,le.populated_mstr_src_state_pcnt
          ,le.populated_reg_decal_nbr_pcnt
          ,le.populated_org_reg_dt_pcnt
          ,le.populated_reg_renew_dt_pcnt
          ,le.populated_reg_exp_dt_pcnt
          ,le.populated_title_nbr_pcnt
          ,le.populated_org_title_dt_pcnt
          ,le.populated_title_trans_dt_pcnt
          ,le.populated_name_typ_cd_pcnt
          ,le.populated_owner_typ_cd_pcnt
          ,le.populated_first_nm_pcnt
          ,le.populated_middle_nm_pcnt
          ,le.populated_last_nm_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_prof_suffix_pcnt
          ,le.populated_ind_ssn_pcnt
          ,le.populated_ind_dob_pcnt
          ,le.populated_mail_range_pcnt
          ,le.populated_m_pre_dir_pcnt
          ,le.populated_m_street_pcnt
          ,le.populated_m_suffix_pcnt
          ,le.populated_m_post_dir_pcnt
          ,le.populated_m_pob_pcnt
          ,le.populated_m_rr_nbr_pcnt
          ,le.populated_m_rr_box_pcnt
          ,le.populated_m_scndry_rng_pcnt
          ,le.populated_m_scndry_des_pcnt
          ,le.populated_m_city_pcnt
          ,le.populated_m_state_pcnt
          ,le.populated_m_zip5_pcnt
          ,le.populated_m_zip4_pcnt
          ,le.populated_m_cntry_cd_pcnt
          ,le.populated_m_cc_filler_pcnt
          ,le.populated_m_cc_pcnt
          ,le.populated_m_county_pcnt
          ,le.populated_phys_range_pcnt
          ,le.populated_p_pre_dir_pcnt
          ,le.populated_p_street_pcnt
          ,le.populated_p_suffix_pcnt
          ,le.populated_p_post_dir_pcnt
          ,le.populated_p_pob_pcnt
          ,le.populated_p_rr_nbr_pcnt
          ,le.populated_p_rr_box_pcnt
          ,le.populated_p_scndry_rng_pcnt
          ,le.populated_p_scndry_des_pcnt
          ,le.populated_p_city_pcnt
          ,le.populated_p_state_pcnt
          ,le.populated_p_zip5_pcnt
          ,le.populated_p_zip4_pcnt
          ,le.populated_p_cntry_cd_pcnt
          ,le.populated_p_cc_filler_pcnt
          ,le.populated_p_cc_pcnt
          ,le.populated_p_county_pcnt
          ,le.populated_opt_out_cd_pcnt
          ,le.populated_asg_wgt_pcnt
          ,le.populated_asg_wgt_uom_pcnt
          ,le.populated_source_ctl_id_pcnt
          ,le.populated_raw_name_pcnt
          ,le.populated_branded_title_flag_pcnt
          ,le.populated_brand_code_1_pcnt
          ,le.populated_brand_date_1_pcnt
          ,le.populated_brand_state_1_pcnt
          ,le.populated_brand_code_2_pcnt
          ,le.populated_brand_date_2_pcnt
          ,le.populated_brand_state_2_pcnt
          ,le.populated_brand_code_3_pcnt
          ,le.populated_brand_date_3_pcnt
          ,le.populated_brand_state_3_pcnt
          ,le.populated_brand_code_4_pcnt
          ,le.populated_brand_date_4_pcnt
          ,le.populated_brand_state_4_pcnt
          ,le.populated_brand_code_5_pcnt
          ,le.populated_brand_date_5_pcnt
          ,le.populated_brand_state_5_pcnt
          ,le.populated_tod_flag_pcnt
          ,le.populated_model_class_code_pcnt
          ,le.populated_model_class_pcnt
          ,le.populated_min_door_count_pcnt
          ,le.populated_safety_type_pcnt
          ,le.populated_airbag_driver_pcnt
          ,le.populated_airbag_front_driver_side_pcnt
          ,le.populated_airbag_front_head_curtain_pcnt
          ,le.populated_airbag_front_pass_pcnt
          ,le.populated_airbag_front_pass_side_pcnt
          ,le.populated_airbags_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,110,xNormHygieneStats(LEFT,COUNTER,'POP'));

  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));

    mod_Delta := Experian_Delta(prevDS, PROJECT(h, Experian_Layout_VehicleV2));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),110,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(Experian_Layout_VehicleV2) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_VehicleV2, Experian_Fields, 'RECORDOF(scrubsSummaryOverall)', 'append_state_origin');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));

  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);

  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, append_state_origin, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));

  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
