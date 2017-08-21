EXPORT ReportFiles := module

export currrec := record
string sourceid;
unsigned integer Countgroup;
string did_rate;
string  l_accnbr_CountNonBlank                  ;     
string  report_code_CountNonBlank               ;     
string  jurisdiction_state_CountNonBlank        ;     
string  jurisdiction_CountNonBlank              ;     
string  orig_accnbr_CountNonBlank               ;     
string  vehicle_incident_id_CountNonBlank       ;     
string  vehicle_status_CountNonBlank            ;     
string  dt_first_seen_CountNonBlank             ;     
string  dt_last_seen_CountNonBlank              ;     
string  accident_date_CountNonBlank             ;     
string  did_CountNonBlank                       ;     
string  title_CountNonBlank                     ;     
string  fname_CountNonBlank                     ;     
string  mname_CountNonBlank                     ;     
string  lname_CountNonBlank                     ;     
string  name_suffix_CountNonBlank               ;     
string  dob_CountNonBlank                       ;     
string  b_did_CountNonBlank                     ;     
string  cname_CountNonBlank                     ;     
string  prim_range_CountNonBlank                ;     
string  predir_CountNonBlank                    ;     
string  prim_name_CountNonBlank                 ;     
string  addr_suffix_CountNonBlank               ;     
string  postdir_CountNonBlank                   ;     
string  unit_desig_CountNonBlank                ;     
string  sec_range_CountNonBlank                 ;     
string  v_city_name_CountNonBlank               ;     
string  st_CountNonBlank                        ;     
string  zip_CountNonBlank                       ;     
string  zip4_CountNonBlank                      ;     
string  record_type_CountNonBlank               ;     
string  report_code_desc_CountNonBlank          ;     
string  report_category_CountNonBlank           ;     
string  vin_CountNonBlank                       ;     
string  driver_license_nbr_CountNonBlank        ;     
string  dlnbr_st_CountNonBlank                  ;     
string  tag_nbr_CountNonBlank                   ;     
string  tagnbr_st_CountNonBlank                 ;     
string  accident_location_CountNonBlank         ;     
string  accident_street_CountNonBlank           ;     
string  accident_cross_street_CountNonBlank     ;     
string  next_street_CountNonBlank               ;     
string  jurisdiction_nbr_CountNonBlank          ;     
string  image_hash_CountNonBlank                ;     
string  airbags_deploy_CountNonBlank            ;     
string  policy_num_CountNonBlank                ;     
string  policy_effective_date_CountNonBlank     ;     
string  policy_expiration_date_CountNonBlank    ;     
string  report_has_coversheet_CountNonBlank     ;     
string  other_vin_indicator_CountNonBlank       ;     
string  vehicle_unit_number_CountNonBlank       ;     
string  vehicle_incident_city_CountNonBlank     ;     
string  vehicle_incident_st_CountNonBlank       ;     
string  carrier_name_CountNonBlank              ;     
string  client_type_id_CountNonBlank            ;     
string  towed_CountNonBlank                     ;     
string  impact_location_CountNonBlank           ;     
string  vehicle_owner_driver_code_CountNonBlank ;     
string  vehicle_driver_action_CountNonBlank     ;     
string  vehicle_year_CountNonBlank              ;     
string  vehicle_make_CountNonBlank              ;     
string  vehicle_type_CountNonBlank              ;     
string  vehicle_travel_on_CountNonBlank         ;     
string  direction_travel_CountNonBlank          ;     
string  est_vehicle_speed_CountNonBlank         ;     
string  posted_speed_CountNonBlank              ;     
string  est_vehicle_damage_CountNonBlank        ;     
string  damage_type_CountNonBlank               ;     
string  vehicle_removed_by_CountNonBlank        ;     
string  how_removed_code_CountNonBlank          ;     
string  point_of_impact_CountNonBlank           ;     
string  vehicle_movement_CountNonBlank          ;     
string  vehicle_function_CountNonBlank          ;     
string  vehs_first_defect_CountNonBlank         ;     
string  vehs_second_defect_CountNonBlank        ;     
string  vehicle_modified_CountNonBlank          ;     
string  vehicle_roadway_loc_CountNonBlank       ;     
string  hazard_material_transport_CountNonBlank ;     
string  total_occu_vehicle_CountNonBlank        ;     
string  total_occu_saf_equip_CountNonBlank      ;     
string  moving_violation_CountNonBlank          ;     
string  vehicle_insur_code_CountNonBlank        ;     
string  vehicle_fault_code_CountNonBlank        ;     
string  vehicle_cap_code_CountNonBlank          ;     
string  vehicle_fr_code_CountNonBlank           ;     
string  vehicle_use_CountNonBlank               ;     
string  placarded_CountNonBlank                 ;     
string  dhsmv_vehicle_ind_CountNonBlank         ;     
string  vehicle_seg_CountNonBlank               ;     
string  vehicle_seg_type_CountNonBlank          ;     
string  match_code_CountNonBlank                ;     
string  model_year_CountNonBlank                ;     
string  manufacturer_corporation_CountNonBlank  ;     
string  division_code_CountNonBlank             ;     
string  vehicle_group_code_CountNonBlank        ;     
string  vehicle_subgroup_code_CountNonBlank     ;     
string  vehicle_series_code_CountNonBlank       ;     
string  body_style_code_CountNonBlank           ;     
string  vehicle_abbreviation_CountNonBlank      ;     
string  assembly_country_CountNonBlank          ;     
string  headquarter_country_CountNonBlank       ;     
string  number_of_doors_CountNonBlank           ;     
string  seating_capacity_CountNonBlank          ;     
string  number_of_cylinders_CountNonBlank       ;     
string  engine_size_CountNonBlank               ;     
string  fuel_code_CountNonBlank                 ;     
string  carburetion_type_CountNonBlank          ;     
string  number_of_barrels_CountNonBlank         ;     
string  price_class_code_CountNonBlank          ;     
string  body_size_code_CountNonBlank            ;     
string  number_of_wheels_on_road_CountNonBlank  ;     
string  number_of_driving_wheels_CountNonBlank  ;     
string  drive_type_CountNonBlank                ;     
string  steering_type_CountNonBlank             ;     
string  gvw_code_CountNonBlank                  ;     
string  load_capacity_code_CountNonBlank        ;     
string  cab_type_code_CountNonBlank             ;     
string  bed_length_CountNonBlank                ;     
string  rim_size_CountNonBlank                  ;     
string  manufacture_body_style_CountNonBlank    ;     
string  vehicle_type_code_CountNonBlank         ;     
string  car_line_code_CountNonBlank             ;     
string  car_series_code_CountNonBlank           ;     
string  car_body_style_code_CountNonBlank       ;     
string  engine_cylinder_code_CountNonBlank      ;     
string  truck_make_abbreviation_CountNonBlank   ;     
string  truck_body_style_abbreviation_CountNonBlank;  
string  motorcycle_make_abbreviation_CountNonBlank;   
string  vina_series_CountNonBlank               ;     
string  vina_model_CountNonBlank                ;     
string  reference_number_CountNonBlank          ;     
string  vina_make_CountNonBlank                 ;     
string  vina_body_style_CountNonBlank           ;     
string  make_description_CountNonBlank          ;     
string  model_description_CountNonBlank         ;     
string  series_description_CountNonBlank        ;     
string  car_series_CountNonBlank                ;     
string  car_body_style_CountNonBlank            ;     
string  car_cid_CountNonBlank                   ;     
string  car_cylinders_CountNonBlank             ;     
string  car_carburetion_CountNonBlank           ;     
string  car_fuel_code_CountNonBlank             ;     
string  truck_chassis_body_style_CountNonBlank  ;     
string  truck_wheels_driving_wheels_CountNonBlank;    
string  truck_cid_CountNonBlank                 ;     
string  truck_cylinders_CountNonBlank           ;     
string  truck_fuel_code_CountNonBlank           ;     
string  truck_manufacturers_gvw_code_CountNonBlank;   
string  truck_ton_rating_code_CountNonBlank     ;     
string  truck_series_CountNonBlank              ;     
string  truck_model_CountNonBlank               ;     
string  motorcycle_model_CountNonBlank          ;     
string  motorcycle_engine_displacement_CountNonBlank; 
string  motorcycle_type_of_bike_CountNonBlank   ;     
string  motorcycle_cylinder_coding_CountNonBlank;     
string  addl_report_number_CountNonBlank        ;     
string  agency_ori_CountNonBlank                ;     
string  insurance_company_standardized_CountNonBlank; 
string  is_available_for_public_CountNonBlank   ;     
string  report_status_CountNonBlank             ;     
string  work_type_id_CountNonBlank              ;     
string  orig_fname_CountNonBlank                ;     
string  orig_lname_CountNonBlank                ;     
string  orig_mname_CountNonBlank                ;     
string  orig_full_name_CountNonBlank            ;     
string  ssn_CountNonBlank                       ;     
string  cru_order_id_CountNonBlank              ;     
string  cru_sequence_nbr_CountNonBlank          ;     
string  date_vendor_last_reported_CountNonBlank ;     
string  report_type_id_CountNonBlank            ;     
string  tif_image_hash_CountNonBlank            ;     
end;

export curr := dataset('~thor_data400::stats::ecrash_monthly_current',currrec,csv(heading(single),separator(','),terminator('\r\n'),quote('"'),maxlength(32768)));

rec1 := record                                                                                                                                                 
string sourceid;                                                                                                                                              
unsigned integer Countgroup;                                                                                                                                            
string did_rate;                                                                                                                                              
string  l_accnbr_prevCountNonBlank                  ;                                                                                                         
string  report_code_prevCountNonBlank               ;                                                                                                         
string  jurisdiction_state_prevCountNonBlank        ;                                                                                                         
string  jurisdiction_prevCountNonBlank              ;                                                                                                         
string  orig_accnbr_prevCountNonBlank               ;                                                                                                         
string  vehicle_incident_id_prevCountNonBlank       ;                                                                                                         
string  vehicle_status_prevCountNonBlank            ;                                                                                                         
string  dt_first_seen_prevCountNonBlank             ;                                                                                                         
string  dt_last_seen_prevCountNonBlank              ;                                                                                                         
string  accident_date_prevCountNonBlank             ;                                                                                                         
string  did_prevCountNonBlank                       ;                                                                                                         
string  title_prevCountNonBlank                     ;                                                                                                         
string  fname_prevCountNonBlank                     ;                                                                                                         
string  mname_prevCountNonBlank                     ;                                                                                                         
string  lname_prevCountNonBlank                     ;                                                                                                         
string  name_suffix_prevCountNonBlank               ;                                                                                                         
string  dob_prevCountNonBlank                       ;                                                                                                         
string  b_did_prevCountNonBlank                     ;                                                                                                         
string  cname_prevCountNonBlank                     ;                                                                                                         
string  prim_range_prevCountNonBlank                ;                                                                                                         
string  predir_prevCountNonBlank                    ;                                                                                                         
string  prim_name_prevCountNonBlank                 ;                                                                                                         
string  addr_suffix_prevCountNonBlank               ;                                                                                                         
string  postdir_prevCountNonBlank                   ;                                                                                                         
string  unit_desig_prevCountNonBlank                ;                                                                                                         
string  sec_range_prevCountNonBlank                 ;                                                                                                         
string  v_city_name_prevCountNonBlank               ;                                                                                                         
string  st_prevCountNonBlank                        ;                                                                                                         
string  zip_prevCountNonBlank                       ;                                                                                                         
string  zip4_prevCountNonBlank                      ;                                                                                                         
string  record_type_prevCountNonBlank               ;                                                                                                         
string  report_code_desc_prevCountNonBlank          ;                                                                                                         
string  report_category_prevCountNonBlank           ;                                                                                                         
string  vin_prevCountNonBlank                       ;                                                                                                         
string  driver_license_nbr_prevCountNonBlank        ;                                                                                                         
string  dlnbr_st_prevCountNonBlank                  ;                                                                                                         
string  tag_nbr_prevCountNonBlank                   ;                                                                                                         
string  tagnbr_st_prevCountNonBlank                 ;                                                                                                         
string  accident_location_prevCountNonBlank         ;                                                                                                         
string  accident_street_prevCountNonBlank           ;                                                                                                         
string  accident_cross_street_prevCountNonBlank     ;                                                                                                         
string  next_street_prevCountNonBlank               ;                                                                                                         
string  jurisdiction_nbr_prevCountNonBlank          ;                                                                                                         
string  image_hash_prevCountNonBlank                ;                                                                                                         
string  airbags_deploy_prevCountNonBlank            ;                                                                                                         
string  policy_num_prevCountNonBlank                ;                                                                                                         
string  policy_effective_date_prevCountNonBlank     ;                                                                                                         
string  policy_expiration_date_prevCountNonBlank    ;                                                                                                         
string  report_has_coversheet_prevCountNonBlank     ;                                                                                                         
string  other_vin_indicator_prevCountNonBlank       ;                                                                                                         
string  vehicle_unit_number_prevCountNonBlank       ;                                                                                                         
string  vehicle_incident_city_prevCountNonBlank     ;                                                                                                         
string  vehicle_incident_st_prevCountNonBlank       ;                                                                                                         
string  carrier_name_prevCountNonBlank              ;                                                                                                         
string  client_type_id_prevCountNonBlank            ;                                                                                                         
string  towed_prevCountNonBlank                     ;                                                                                                         
string  impact_location_prevCountNonBlank           ;                                                                                                         
string  vehicle_owner_driver_code_prevCountNonBlank ;                                                                                                         
string  vehicle_driver_action_prevCountNonBlank     ;                                                                                                         
string  vehicle_year_prevCountNonBlank              ;                                                                                                         
string  vehicle_make_prevCountNonBlank              ;                                                                                                         
string  vehicle_type_prevCountNonBlank              ;                                                                                                         
string  vehicle_travel_on_prevCountNonBlank         ;                                                                                                         
string  direction_travel_prevCountNonBlank          ;                                                                                                         
string  est_vehicle_speed_prevCountNonBlank         ;                                                                                                         
string  posted_speed_prevCountNonBlank              ;                                                                                                         
string  est_vehicle_damage_prevCountNonBlank        ;                                                                                                         
string  damage_type_prevCountNonBlank               ;                                                                                                         
string  vehicle_removed_by_prevCountNonBlank        ;                                                                                                         
string  how_removed_code_prevCountNonBlank          ;                                                                                                         
string  point_of_impact_prevCountNonBlank           ;                                                                                                         
string  vehicle_movement_prevCountNonBlank          ;                                                                                                         
string  vehicle_function_prevCountNonBlank          ;                                                                                                         
string  vehs_first_defect_prevCountNonBlank         ;                                                                                                         
string  vehs_second_defect_prevCountNonBlank        ;                                                                                                         
string  vehicle_modified_prevCountNonBlank          ;                                                                                                         
string  vehicle_roadway_loc_prevCountNonBlank       ;                                                                                                         
string  hazard_material_transport_prevCountNonBlank ;                                                                                                         
string  total_occu_vehicle_prevCountNonBlank        ;                                                                                                         
string  total_occu_saf_equip_prevCountNonBlank      ;                                                                                                         
string  moving_violation_prevCountNonBlank          ;                                                                                                         
string  vehicle_insur_code_prevCountNonBlank        ;                                                                                                         
string  vehicle_fault_code_prevCountNonBlank        ;                                                                                                         
string  vehicle_cap_code_prevCountNonBlank          ;                                                                                                         
string  vehicle_fr_code_prevCountNonBlank           ;                                                                                                         
string  vehicle_use_prevCountNonBlank               ;                                                                                                         
string  placarded_prevCountNonBlank                 ;                                                                                                         
string  dhsmv_vehicle_ind_prevCountNonBlank         ;                                                                                                         
string  vehicle_seg_prevCountNonBlank               ;                                                                                                         
string  vehicle_seg_type_prevCountNonBlank          ;                                                                                                         
string  match_code_prevCountNonBlank                ;                                                                                                         
string  model_year_prevCountNonBlank                ;                                                                                                         
string  manufacturer_corporation_prevCountNonBlank  ;                                                                                                         
string  division_code_prevCountNonBlank             ;                                                                                                         
string  vehicle_group_code_prevCountNonBlank        ;                                                                                                         
string  vehicle_subgroup_code_prevCountNonBlank     ;                                                                                                         
string  vehicle_series_code_prevCountNonBlank       ;                                                                                                         
string  body_style_code_prevCountNonBlank           ;                                                                                                         
string  vehicle_abbreviation_prevCountNonBlank      ;                                                                                                         
string  assembly_country_prevCountNonBlank          ;                                                                                                         
string  headquarter_country_prevCountNonBlank       ;                                                                                                         
string  number_of_doors_prevCountNonBlank           ;                                                                                                         
string  seating_capacity_prevCountNonBlank          ;                                                                                                         
string  number_of_cylinders_prevCountNonBlank       ;                                                                                                         
string  engine_size_prevCountNonBlank               ;                                                                                                         
string  fuel_code_prevCountNonBlank                 ;                                                                                                         
string  carburetion_type_prevCountNonBlank          ;                                                                                                         
string  number_of_barrels_prevCountNonBlank         ;                                                                                                         
string  price_class_code_prevCountNonBlank          ;                                                                                                         
string  body_size_code_prevCountNonBlank            ;                                                                                                         
string  number_of_wheels_on_road_prevCountNonBlank  ;                                                                                                         
string  number_of_driving_wheels_prevCountNonBlank  ;                                                                                                         
string  drive_type_prevCountNonBlank                ;                                                                                                         
string  steering_type_prevCountNonBlank             ;                                                                                                         
string  gvw_code_prevCountNonBlank                  ;                                                                                                         
string  load_capacity_code_prevCountNonBlank        ;                                                                                                         
string  cab_type_code_prevCountNonBlank             ;                                                                                                         
string  bed_length_prevCountNonBlank                ;                                                                                                         
string  rim_size_prevCountNonBlank                  ;                                                                                                         
string  manufacture_body_style_prevCountNonBlank    ;                                                                                                         
string  vehicle_type_code_prevCountNonBlank         ;                                                                                                         
string  car_line_code_prevCountNonBlank             ;                                                                                                         
string  car_series_code_prevCountNonBlank           ;                                                                                                         
string  car_body_style_code_prevCountNonBlank       ;                                                                                                         
string  engine_cylinder_code_prevCountNonBlank      ;                                                                                                         
string  truck_make_abbreviation_prevCountNonBlank   ;                                                                                                         
string  truck_body_style_abbreviation_CountNonBlank;                                                                                                          
string  motorcycle_make_abbreviation_CountNonBlank;                                                                                                           
string  vina_series_prevCountNonBlank               ;                                                                                                         
string  vina_model_prevCountNonBlank                ;                                                                                                         
string  reference_number_prevCountNonBlank          ;                                                                                                         
string  vina_make_prevCountNonBlank                 ;                                                                                                         
string  vina_body_style_prevCountNonBlank           ;                                                                                                         
string  make_description_prevCountNonBlank          ;                                                                                                         
string  model_description_prevCountNonBlank         ;                                                                                                         
string  series_description_prevCountNonBlank        ;                                                                                                         
string  car_series_prevCountNonBlank                ;                                                                                                         
string  car_body_style_prevCountNonBlank            ;                                                                                                         
string  car_cid_prevCountNonBlank                   ;                                                                                                         
string  car_cylinders_prevCountNonBlank             ;                                                                                                         
string  car_carburetion_prevCountNonBlank           ;                                                                                                         
string  car_fuel_code_prevCountNonBlank             ;                                                                                                         
string  truck_chassis_body_style_prevCountNonBlank  ;                                                                                                         
string  truck_wheels_driving_wheels_prevCountNonBlank;                                                                                                        
string  truck_cid_prevCountNonBlank                 ;                                                                                                         
string  truck_cylinders_prevCountNonBlank           ;                                                                                                         
string  truck_fuel_code_prevCountNonBlank           ;                                                                                                         
string  truck_manufacturers_gvw_code_prevCountNonBlank;                                                                                                       
string  truck_ton_rating_code_prevCountNonBlank     ;                                                                                                         
string  truck_series_prevCountNonBlank              ;                                                                                                         
string  truck_model_prevCountNonBlank               ;                                                                                                         
string  motorcycle_model_prevCountNonBlank          ;                                                                                                         
string  motorcycle_engine_displacement_prevCountNonBlank;                                                                                                     
string  motorcycle_type_of_bike_prevCountNonBlank   ;                                                                                                         
string  motorcycle_cylinder_coding_prevCountNonBlank;                                                                                                         
string  addl_report_number_prevCountNonBlank        ;                                                                                                         
string  agency_ori_prevCountNonBlank                ;                                                                                                         
string  insurance_company_standardized_prevCountNonBlank;                                                                                                     
string  is_available_for_public_prevCountNonBlank   ;                                                                                                         
string  report_status_prevCountNonBlank             ;                                                                                                         
string  work_type_id_prevCountNonBlank              ;                                                                                                         
string  orig_fname_prevCountNonBlank                ;                                                                                                         
string  orig_lname_prevCountNonBlank                ;                                                                                                         
string  orig_mname_prevCountNonBlank                ;                                                                                                         
string  orig_full_name_prevCountNonBlank            ;                                                                                                         
string  ssn_prevCountNonBlank                       ;                                                                                                         
string  cru_order_id_prevCountNonBlank              ;                                                                                                         
string  cru_sequence_nbr_prevCountNonBlank          ;                                                                                                         
string  date_vendor_last_reported_prevCountNonBlank ;                                                                                                         
string  report_type_id_prevCountNonBlank            ;                                                                                                         
string  tif_image_hash_prevCountNonBlank            ;                                                                                                         
end;                                                                                                                                                          
                                                                                                                                                              
export prev := dataset('~thor_data400::stats::ecrash_monthly_prev',rec1,csv(heading(single),separator(','),terminator('\r\n'),quote('"'),maxlength(32768)));
end;