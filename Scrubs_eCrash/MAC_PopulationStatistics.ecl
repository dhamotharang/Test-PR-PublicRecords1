EXPORT MAC_PopulationStatistics(infile,Ref='',report_code='',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_report_code = '',Input_report_category = '',Input_report_code_desc = '',Input_citation_id = '',Input_creation_date = '',Input_incident_id = '',Input_citation_issued = '',Input_citation_number1 = '',Input_citation_number2 = '',Input_section_number1 = '',Input_court_date = '',Input_court_time = '',Input_citation_detail1 = '',Input_local_code = '',Input_violation_code1 = '',Input_violation_code2 = '',Input_multiple_charges_indicator = '',Input_dui_indicator = '',Input_commercial_id = '',Input_vehicle_id = '',Input_commercial_info_source = '',Input_commercial_vehicle_type = '',Input_motor_carrier_id_dot_number = '',Input_motor_carrier_id_state_id = '',Input_motor_carrier_id_carrier_name = '',Input_motor_carrier_id_address = '',Input_motor_carrier_id_city = '',Input_motor_carrier_id_state = '',Input_motor_carrier_id_zipcode = '',Input_motor_carrier_id_commercial_indicator = '',Input_carrier_id_type = '',Input_carrier_unit_number = '',Input_dot_permit_number = '',Input_iccmc_number = '',Input_mcs_vehicle_inspection = '',Input_mcs_form_number = '',Input_mcs_out_of_service = '',Input_mcs_violation_related = '',Input_number_of_axles = '',Input_number_of_tires = '',Input_gvw_over_10k_pounds = '',Input_weight_rating = '',Input_registered_gross_vehicle_weight = '',Input_vehicle_length_feet = '',Input_cargo_body_type = '',Input_load_type = '',Input_oversize_load = '',Input_vehicle_configuration = '',Input_trailer1_type = '',Input_trailer1_length_feet = '',Input_trailer1_width_feet = '',Input_trailer2_type = '',Input_trailer2_length_feet = '',Input_trailer2_width_feet = '',Input_federally_reportable = '',Input_vehicle_inspection_hazmat = '',Input_hazmat_form_number = '',Input_hazmt_out_of_service = '',Input_hazmat_violation_related = '',Input_hazardous_materials_placard = '',Input_hazardous_materials_class_number1 = '',Input_hazardous_materials_class_number2 = '',Input_hazmat_placard_name = '',Input_hazardous_materials_released1 = '',Input_hazardous_materials_released2 = '',Input_hazardous_materials_released3 = '',Input_hazardous_materials_released4 = '',Input_commercial_event1 = '',Input_commercial_event2 = '',Input_commercial_event3 = '',Input_commercial_event4 = '',Input_recommended_driver_reexam = '',Input_transporting_hazmat = '',Input_liquid_hazmat_volume = '',Input_oversize_vehicle = '',Input_overlength_vehicle = '',Input_oversize_vehicle_permitted = '',Input_overlength_vehicle_permitted = '',Input_carrier_phone_number = '',Input_commerce_type = '',Input_citation_issued_to_vehicle = '',Input_cdl_class = '',Input_dot_state = '',Input_fire_hazardous_materials_involvement = '',Input_commercial_event_description = '',Input_supplment_required_hazmat_placard = '',Input_other_state_number1 = '',Input_other_state_number2 = '',Input_work_type_id = '',Input_report_id = '',Input_agency_id = '',Input_sent_to_hpcc_datetime = '',Input_corrected_incident = '',Input_cru_order_id = '',Input_cru_sequence_nbr = '',Input_loss_state_abbr = '',Input_report_type_id = '',Input_hash_key = '',Input_case_identifier = '',Input_crash_county = '',Input_county_cd = '',Input_crash_cityplace = '',Input_crash_city = '',Input_city_code = '',Input_first_harmful_event = '',Input_first_harmful_event_location = '',Input_manner_crash_impact1 = '',Input_weather_condition1 = '',Input_weather_condition2 = '',Input_light_condition1 = '',Input_light_condition2 = '',Input_road_surface_condition = '',Input_contributing_circumstances_environmental1 = '',Input_contributing_circumstances_environmental2 = '',Input_contributing_circumstances_environmental3 = '',Input_contributing_circumstances_environmental4 = '',Input_contributing_circumstances_road1 = '',Input_contributing_circumstances_road2 = '',Input_contributing_circumstances_road3 = '',Input_contributing_circumstances_road4 = '',Input_relation_to_junction = '',Input_intersection_type = '',Input_school_bus_related = '',Input_work_zone_related = '',Input_work_zone_location = '',Input_work_zone_type = '',Input_work_zone_workers_present = '',Input_work_zone_law_enforcement_present = '',Input_crash_severity = '',Input_number_of_vehicles = '',Input_total_nonfatal_injuries = '',Input_total_fatal_injuries = '',Input_day_of_week = '',Input_roadway_curvature = '',Input_part_of_national_highway_system = '',Input_roadway_functional_class = '',Input_access_control = '',Input_rr_crossing_id = '',Input_roadway_lighting = '',Input_traffic_control_type_at_intersection1 = '',Input_traffic_control_type_at_intersection2 = '',Input_ncic_number = '',Input_state_report_number = '',Input_ori_number = '',Input_crash_date = '',Input_crash_time = '',Input_lattitude = '',Input_longitude = '',Input_milepost1 = '',Input_milepost2 = '',Input_address_number = '',Input_loss_street = '',Input_loss_street_route_number = '',Input_loss_street_type = '',Input_loss_street_speed_limit = '',Input_incident_location_indicator = '',Input_loss_cross_street = '',Input_loss_cross_street_route_number = '',Input_loss_cross_street_intersecting_route_segment = '',Input_loss_cross_street_type = '',Input_loss_cross_street_speed_limit = '',Input_loss_cross_street_number_of_lanes = '',Input_loss_cross_street_orientation = '',Input_loss_cross_street_route_sign = '',Input_at_node_number = '',Input_distance_from_node_feet = '',Input_distance_from_node_miles = '',Input_next_node_number = '',Input_next_roadway_node_number = '',Input_direction_of_travel = '',Input_next_street = '',Input_next_street_type = '',Input_next_street_suffix = '',Input_before_or_after_next_street = '',Input_next_street_distance_feet = '',Input_next_street_distance_miles = '',Input_next_street_direction = '',Input_next_street_route_segment = '',Input_continuing_toward_street = '',Input_continuing_street_suffix = '',Input_continuing_street_direction = '',Input_continuting_street_route_segment = '',Input_city_type = '',Input_outside_city_indicator = '',Input_outside_city_direction = '',Input_outside_city_distance_feet = '',Input_outside_city_distance_miles = '',Input_crash_type = '',Input_motor_vehicle_involved_with = '',Input_report_investigation_type = '',Input_incident_hit_and_run = '',Input_tow_away = '',Input_date_notified = '',Input_time_notified = '',Input_notification_method = '',Input_officer_arrival_time = '',Input_officer_report_date = '',Input_officer_report_time = '',Input_officer_id = '',Input_officer_department = '',Input_officer_rank = '',Input_officer_command = '',Input_officer_tax_id_number = '',Input_completed_report_date = '',Input_supervisor_check_date = '',Input_supervisor_check_time = '',Input_supervisor_id = '',Input_supervisor_rank = '',Input_reviewers_name = '',Input_road_surface = '',Input_roadway_alignment = '',Input_traffic_way_description = '',Input_traffic_flow = '',Input_property_damage_involved = '',Input_property_damage_description1 = '',Input_property_damage_description2 = '',Input_property_damage_estimate1 = '',Input_property_damage_estimate2 = '',Input_incident_damage_over_limit = '',Input_property_owner_notified = '',Input_government_property = '',Input_accident_condition = '',Input_unusual_road_condition1 = '',Input_unusual_road_condition2 = '',Input_number_of_lanes = '',Input_divided_highway = '',Input_most_harmful_event = '',Input_second_harmful_event = '',Input_ems_notified_date = '',Input_ems_arrival_date = '',Input_hospital_arrival_date = '',Input_injured_taken_by = '',Input_injured_taken_to = '',Input_incident_transported_for_medical_care = '',Input_photographs_taken = '',Input_photographed_by = '',Input_photographer_id = '',Input_photography_agency_name = '',Input_agency_name = '',Input_judicial_district = '',Input_precinct = '',Input_beat = '',Input_location_type = '',Input_shoulder_type = '',Input_investigation_complete = '',Input_investigation_not_complete_why = '',Input_investigating_officer_name = '',Input_investigation_notification_issued = '',Input_agency_type = '',Input_no_injury_tow_involved = '',Input_injury_tow_involved = '',Input_lars_code1 = '',Input_lars_code2 = '',Input_private_property_incident = '',Input_accident_involvement = '',Input_local_use = '',Input_street_prefix = '',Input_street_suffix = '',Input_toll_road = '',Input_street_description = '',Input_cross_street_address_number = '',Input_cross_street_prefix = '',Input_cross_street_suffix = '',Input_report_complete = '',Input_dispatch_notified = '',Input_counter_report = '',Input_road_type = '',Input_agency_code = '',Input_public_property_employee = '',Input_bridge_related = '',Input_ramp_indicator = '',Input_to_or_from_location = '',Input_complaint_number = '',Input_school_zone_related = '',Input_notify_dot_maintenance = '',Input_special_location = '',Input_route_segment = '',Input_route_sign = '',Input_route_category_street = '',Input_route_category_cross_street = '',Input_route_category_next_street = '',Input_lane_closed = '',Input_lane_closure_direction = '',Input_lane_direction = '',Input_traffic_detoured = '',Input_time_closed = '',Input_pedestrian_signals = '',Input_work_zone_speed_limit = '',Input_work_zone_shoulder_median = '',Input_work_zone_intermittent_moving = '',Input_work_zone_flagger_control = '',Input_special_work_zone_characteristics = '',Input_lane_number = '',Input_offset_distance_feet = '',Input_offset_distance_miles = '',Input_offset_direction = '',Input_asru_code = '',Input_mp_grid = '',Input_number_of_qualifying_units = '',Input_number_of_hazmat_vehicles = '',Input_number_of_buses_involved = '',Input_number_taken_to_treatment = '',Input_number_vehicles_towed = '',Input_vehicle_at_fault_unit_number = '',Input_time_officer_cleared_scene = '',Input_total_minutes_on_scene = '',Input_motorists_report = '',Input_fatality_involved = '',Input_local_dot_index_number = '',Input_dor_number = '',Input_hospital_code = '',Input_special_jurisdiction = '',Input_document_type = '',Input_distance_was_measured = '',Input_street_orientation = '',Input_intersecting_route_segment = '',Input_primary_fault_indicator = '',Input_first_harmful_event_pedestrian = '',Input_reference_markers = '',Input_other_officer_on_scene = '',Input_other_officer_badge_number = '',Input_supplemental_report = '',Input_supplemental_type = '',Input_amended_report = '',Input_corrected_report = '',Input_state_highway_related = '',Input_roadway_lighting_condition = '',Input_vendor_reference_number = '',Input_duplicate_copy_unit_number = '',Input_other_city_agency_description = '',Input_notifcation_description = '',Input_primary_collision_improper_driving_description = '',Input_weather_other_description = '',Input_crash_type_description = '',Input_motor_vehicle_involved_with_animal_description = '',Input_motor_vehicle_involved_with_fixed_object_description = '',Input_motor_vehicle_involved_with_other_object_description = '',Input_other_investigation_time = '',Input_milepost_detail = '',Input_utility_pole_number1 = '',Input_utility_pole_number2 = '',Input_utility_pole_number3 = '',Input_person_id = '',Input_person_number = '',Input_vehicle_unit_number = '',Input_sex = '',Input_person_type = '',Input_injury_status = '',Input_occupant_vehicle_unit_number = '',Input_seating_position1 = '',Input_safety_equipment_restraint1 = '',Input_safety_equipment_restraint2 = '',Input_safety_equipment_helmet = '',Input_air_bag_deployed = '',Input_ejection = '',Input_drivers_license_jurisdiction = '',Input_dl_number_class = '',Input_dl_number_cdl = '',Input_dl_number_endorsements = '',Input_driver_actions_at_time_of_crash1 = '',Input_driver_actions_at_time_of_crash2 = '',Input_driver_actions_at_time_of_crash3 = '',Input_driver_actions_at_time_of_crash4 = '',Input_violation_codes = '',Input_condition_at_time_of_crash1 = '',Input_condition_at_time_of_crash2 = '',Input_law_enforcement_suspects_alcohol_use = '',Input_alcohol_test_status = '',Input_alcohol_test_type = '',Input_alcohol_test_result = '',Input_law_enforcement_suspects_drug_use = '',Input_drug_test_given = '',Input_non_motorist_actions_prior_to_crash1 = '',Input_non_motorist_actions_prior_to_crash2 = '',Input_non_motorist_actions_at_time_of_crash = '',Input_non_motorist_location_at_time_of_crash = '',Input_non_motorist_safety_equipment1 = '',Input_age = '',Input_driver_license_restrictions1 = '',Input_drug_test_type = '',Input_drug_test_result1 = '',Input_drug_test_result2 = '',Input_drug_test_result3 = '',Input_drug_test_result4 = '',Input_injury_area = '',Input_injury_description = '',Input_motorcyclist_head_injury = '',Input_party_id = '',Input_same_as_driver = '',Input_address_same_as_driver = '',Input_last_name = '',Input_first_name = '',Input_middle_name = '',Input_name_suffx = '',Input_date_of_birth = '',Input_address = '',Input_city = '',Input_state = '',Input_zip_code = '',Input_home_phone = '',Input_business_phone = '',Input_insurance_company = '',Input_insurance_company_phone_number = '',Input_insurance_policy_number = '',Input_insurance_effective_date = '',Input_ssn = '',Input_drivers_license_number = '',Input_drivers_license_expiration = '',Input_eye_color = '',Input_hair_color = '',Input_height = '',Input_weight = '',Input_race = '',Input_pedestrian_cyclist_visibility = '',Input_first_aid_by = '',Input_person_first_aid_party_type = '',Input_person_first_aid_party_type_description = '',Input_deceased_at_scene = '',Input_death_date = '',Input_death_time = '',Input_extricated = '',Input_alcohol_drug_use = '',Input_physical_defects = '',Input_driver_residence = '',Input_id_type = '',Input_proof_of_insurance = '',Input_insurance_expired = '',Input_insurance_exempt = '',Input_insurance_type = '',Input_violent_crime_victim_notified = '',Input_insurance_company_code = '',Input_refused_medical_treatment = '',Input_safety_equipment_available_or_used = '',Input_apartment_number = '',Input_licensed_driver = '',Input_physical_emotional_status = '',Input_driver_presence = '',Input_ejection_path = '',Input_state_person_id = '',Input_contributed_to_collision = '',Input_person_transported_for_medical_care = '',Input_transported_by_agency_type = '',Input_transported_to = '',Input_non_motorist_driver_license_number = '',Input_air_bag_type = '',Input_cell_phone_use = '',Input_driver_license_restriction_compliance = '',Input_driver_license_endorsement_compliance = '',Input_driver_license_compliance = '',Input_contributing_circumstances_p1 = '',Input_contributing_circumstances_p2 = '',Input_contributing_circumstances_p3 = '',Input_contributing_circumstances_p4 = '',Input_passenger_number = '',Input_person_deleted = '',Input_owner_lessee = '',Input_driver_charged = '',Input_motorcycle_eye_protection = '',Input_motorcycle_long_sleeves = '',Input_motorcycle_long_pants = '',Input_motorcycle_over_ankle_boots = '',Input_contributing_circumstances_environmental_non_incident1 = '',Input_contributing_circumstances_environmental_non_incident2 = '',Input_alcohol_drug_test_given = '',Input_alcohol_drug_test_type = '',Input_alcohol_drug_test_result = '',Input_vin = '',Input_vin_status = '',Input_damaged_areas_derived1 = '',Input_damaged_areas_derived2 = '',Input_airbags_deployed_derived = '',Input_vehicle_towed_derived = '',Input_unit_type = '',Input_unit_number = '',Input_registration_state = '',Input_registration_year = '',Input_license_plate = '',Input_make = '',Input_model_yr = '',Input_model = '',Input_body_type_category = '',Input_total_occupants_in_vehicle = '',Input_special_function_in_transport = '',Input_special_function_in_transport_other_unit = '',Input_emergency_use = '',Input_posted_satutory_speed_limit = '',Input_direction_of_travel_before_crash = '',Input_trafficway_description = '',Input_traffic_control_device_type = '',Input_vehicle_maneuver_action_prior1 = '',Input_vehicle_maneuver_action_prior2 = '',Input_impact_area1 = '',Input_impact_area2 = '',Input_event_sequence1 = '',Input_event_sequence2 = '',Input_event_sequence3 = '',Input_event_sequence4 = '',Input_most_harmful_event_for_vehicle = '',Input_bus_use = '',Input_vehicle_hit_and_run = '',Input_vehicle_towed = '',Input_contributing_circumstances_v1 = '',Input_contributing_circumstances_v2 = '',Input_contributing_circumstances_v3 = '',Input_contributing_circumstances_v4 = '',Input_on_street = '',Input_vehicle_color = '',Input_estimated_speed = '',Input_accident_investigation_site = '',Input_car_fire = '',Input_vehicle_damage_amount = '',Input_contributing_factors1 = '',Input_contributing_factors2 = '',Input_contributing_factors3 = '',Input_contributing_factors4 = '',Input_other_contributing_factors1 = '',Input_other_contributing_factors2 = '',Input_other_contributing_factors3 = '',Input_vision_obscured1 = '',Input_vision_obscured2 = '',Input_vehicle_on_road = '',Input_ran_off_road = '',Input_skidding_occurred = '',Input_vehicle_incident_location1 = '',Input_vehicle_incident_location2 = '',Input_vehicle_incident_location3 = '',Input_vehicle_disabled = '',Input_vehicle_removed_to = '',Input_removed_by = '',Input_tow_requested_by_driver = '',Input_solicitation = '',Input_other_unit_vehicle_damage_amount = '',Input_other_unit_model_year = '',Input_other_unit_make = '',Input_other_unit_model = '',Input_other_unit_vin = '',Input_other_unit_vin_status = '',Input_other_unit_body_type_category = '',Input_other_unit_registration_state = '',Input_other_unit_registration_year = '',Input_other_unit_license_plate = '',Input_other_unit_color = '',Input_other_unit_type = '',Input_damaged_areas1 = '',Input_damaged_areas2 = '',Input_parked_vehicle = '',Input_damage_rating1 = '',Input_damage_rating2 = '',Input_vehicle_inventoried = '',Input_vehicle_defect_apparent = '',Input_defect_may_have_contributed1 = '',Input_defect_may_have_contributed2 = '',Input_registration_expiration = '',Input_owner_driver_type = '',Input_make_code = '',Input_number_trailing_units = '',Input_vehicle_position = '',Input_vehicle_type = '',Input_motorcycle_engine_size = '',Input_motorcycle_driver_educated = '',Input_motorcycle_helmet_type = '',Input_motorcycle_passenger = '',Input_motorcycle_helmet_stayed_on = '',Input_motorcycle_helmet_dot_snell = '',Input_motorcycle_saddlebag_trunk = '',Input_motorcycle_trailer = '',Input_pedacycle_passenger = '',Input_pedacycle_headlights = '',Input_pedacycle_helmet = '',Input_pedacycle_rear_reflectors = '',Input_cdl_required = '',Input_truck_bus_supplement_required = '',Input_unit_damage_amount = '',Input_airbag_switch = '',Input_underride_override_damage = '',Input_vehicle_attachment = '',Input_action_on_impact = '',Input_speed_detection_method = '',Input_non_motorist_direction_of_travel_from = '',Input_non_motorist_direction_of_travel_to = '',Input_vehicle_use = '',Input_department_unit_number = '',Input_equipment_in_use_at_time_of_accident = '',Input_actions_of_police_vehicle = '',Input_vehicle_command_id = '',Input_traffic_control_device_inoperative = '',Input_direction_of_impact1 = '',Input_direction_of_impact2 = '',Input_ran_off_road_direction = '',Input_vin_other_unit_number = '',Input_damaged_area_generic = '',Input_vision_obscured_description = '',Input_inattention_description = '',Input_contributing_circumstances_defect_description = '',Input_contributing_circumstances_other_descriptioin = '',Input_vehicle_maneuver_action_prior_other_description = '',Input_vehicle_special_use = '',Input_vehicle_type_extended1 = '',Input_vehicle_type_extended2 = '',Input_fixed_object_direction1 = '',Input_fixed_object_direction2 = '',Input_fixed_object_direction3 = '',Input_fixed_object_direction4 = '',Input_vehicle_left_at_scene = '',Input_vehicle_impounded = '',Input_vehicle_driven_from_scene = '',Input_on_cross_street = '',Input_actions_of_police_vehicle_description = '',Input_vehicle_seg = '',Input_vehicle_seg_type = '',Input_model_year = '',Input_body_style_code = '',Input_engine_size = '',Input_fuel_code = '',Input_number_of_driving_wheels = '',Input_steering_type = '',Input_vina_series = '',Input_vina_model = '',Input_vina_make = '',Input_vina_body_style = '',Input_make_description = '',Input_model_description = '',Input_series_description = '',Input_car_cylinders = '',Input_other_vehicle_seg = '',Input_other_vehicle_seg_type = '',Input_other_model_year = '',Input_other_body_style_code = '',Input_other_engine_size = '',Input_other_fuel_code = '',Input_other_number_of_driving_wheels = '',Input_other_steering_type = '',Input_other_vina_series = '',Input_other_vina_model = '',Input_other_vina_make = '',Input_other_vina_body_style = '',Input_other_make_description = '',Input_other_model_description = '',Input_other_series_description = '',Input_other_car_cylinders = '',Input_report_has_coversheet = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_z5 = '',Input_z4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_county_code = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_nametype = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_suffix = '',Input_title2 = '',Input_fname2 = '',Input_mname2 = '',Input_lname2 = '',Input_suffix2 = '',Input_name_score = '',Input_did = '',Input_did_score = '',Input_bdid = '',Input_bdid_score = '',Input_rawaid = '',Input_law_enforcement_suspects_alcohol_use1 = '',Input_law_enforcement_suspects_drug_use1 = '',Input_ems_notified_time = '',Input_ems_arrival_time = '',Input_avoidance_maneuver2 = '',Input_avoidance_maneuver3 = '',Input_avoidance_maneuver4 = '',Input_damaged_areas_severity1 = '',Input_damaged_areas_severity2 = '',Input_vehicle_outside_city_indicator = '',Input_vehicle_outside_city_distance_miles = '',Input_vehicle_outside_city_direction = '',Input_vehicle_crash_cityplace = '',Input_insurance_company_standardized = '',Input_insurance_expiration_date = '',Input_insurance_policy_holder = '',Input_is_tag_converted = '',Input_vin_original = '',Input_make_original = '',Input_model_original = '',Input_model_year_original = '',Input_other_unit_vin_original = '',Input_other_unit_make_original = '',Input_other_unit_model_original = '',Input_other_unit_model_year_original = '',Input_source_id = '',Input_orig_fname = '',Input_orig_lname = '',Input_orig_mname = '',Input_initial_point_of_contact = '',Input_vehicle_driveable = '',Input_drivers_license_type = '',Input_alcohol_test_type_refused = '',Input_alcohol_test_type_not_offered = '',Input_alcohol_test_type_field = '',Input_alcohol_test_type_pbt = '',Input_alcohol_test_type_breath = '',Input_alcohol_test_type_blood = '',Input_alcohol_test_type_urine = '',Input_trapped = '',Input_dl_number_cdl_endorsements = '',Input_dl_number_cdl_restrictions = '',Input_dl_number_cdl_exempt = '',Input_dl_number_cdl_medical_card = '',Input_interlock_device_in_use = '',Input_drug_test_type_blood = '',Input_drug_test_type_urine = '',Input_traffic_control_condition = '',Input_intersection_related = '',Input_special_study_local = '',Input_special_study_state = '',Input_off_road_vehicle_involved = '',Input_location_type2 = '',Input_speed_limit_posted = '',Input_traffic_control_damage_notify_date = '',Input_traffic_control_damage_notify_time = '',Input_traffic_control_damage_notify_name = '',Input_public_property_damaged = '',Input_replacement_report = '',Input_deleted_report = '',Input_next_street_prefix = '',Input_violator_name = '',Input_type_hazardous = '',Input_type_other = '',Input_unit_type_and_axles1 = '',Input_unit_type_and_axles2 = '',Input_unit_type_and_axles3 = '',Input_unit_type_and_axles4 = '',Input_incident_damage_amount = '',Input_dot_use = '',Input_number_of_persons_involved = '',Input_unusual_road_condition_other_description = '',Input_number_of_narrative_sections = '',Input_cad_number = '',Input_visibility = '',Input_accident_at_intersection = '',Input_accident_not_at_intersection = '',Input_first_harmful_event_within_interchange = '',Input_injury_involved = '',Input_citation_status = '',Input_commercial_vehicle = '',Input_not_in_transport = '',Input_other_unit_number = '',Input_other_unit_length = '',Input_other_unit_axles = '',Input_other_unit_plate_expiration = '',Input_other_unit_permanent_registration = '',Input_other_unit_model_year2 = '',Input_other_unit_make2 = '',Input_other_unit_vin2 = '',Input_other_unit_registration_state2 = '',Input_other_unit_registration_year2 = '',Input_other_unit_license_plate2 = '',Input_other_unit_number2 = '',Input_other_unit_length2 = '',Input_other_unit_axles2 = '',Input_other_unit_plate_expiration2 = '',Input_other_unit_permanent_registration2 = '',Input_other_unit_type2 = '',Input_other_unit_model_year3 = '',Input_other_unit_make3 = '',Input_other_unit_vin3 = '',Input_other_unit_registration_state3 = '',Input_other_unit_registration_year3 = '',Input_other_unit_license_plate3 = '',Input_other_unit_number3 = '',Input_other_unit_length3 = '',Input_other_unit_axles3 = '',Input_other_unit_plate_expiration3 = '',Input_other_unit_permanent_registration3 = '',Input_other_unit_type3 = '',Input_damaged_areas3 = '',Input_driver_distracted_by = '',Input_non_motorist_type = '',Input_seating_position_row = '',Input_seating_position_seat = '',Input_seating_position_description = '',Input_transported_id_number = '',Input_witness_number = '',Input_date_of_birth_derived = '',Input_property_damage_id = '',Input_property_owner_name = '',Input_damage_description = '',Input_damage_estimate = '',Input_narrative = '',Input_narrative_continuance = '',Input_hazardous_materials_hazmat_placard_number1 = '',Input_hazardous_materials_hazmat_placard_number2 = '',Input_vendor_code = '',Input_report_property_damage = '',Input_report_collision_type = '',Input_report_first_harmful_event = '',Input_report_light_condition = '',Input_report_weather_condition = '',Input_report_road_condition = '',Input_report_injury_status = '',Input_report_damage_extent = '',Input_report_vehicle_type = '',Input_report_traffic_control_device_type = '',Input_report_contributing_circumstances_v = '',Input_report_vehicle_maneuver_action_prior = '',Input_report_vehicle_body_type = '',Input_cru_agency_name = '',Input_cru_agency_id = '',Input_cname = '',Input_name_type = '',Input_vendor_report_id = '',Input_is_available_for_public = '',Input_has_addendum = '',Input_report_agency_ori = '',Input_report_status = '',Input_super_report_id = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_eCrash;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(report_code)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_date_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_first_reported = (TYPEOF(le.Input_date_vendor_first_reported))'','',':date_vendor_first_reported')
    #END
+    #IF( #TEXT(Input_date_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_last_reported = (TYPEOF(le.Input_date_vendor_last_reported))'','',':date_vendor_last_reported')
    #END
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
+    #IF( #TEXT(Input_report_code)='' )
      '' 
    #ELSE
        IF( le.Input_report_code = (TYPEOF(le.Input_report_code))'','',':report_code')
    #END
+    #IF( #TEXT(Input_report_category)='' )
      '' 
    #ELSE
        IF( le.Input_report_category = (TYPEOF(le.Input_report_category))'','',':report_category')
    #END
+    #IF( #TEXT(Input_report_code_desc)='' )
      '' 
    #ELSE
        IF( le.Input_report_code_desc = (TYPEOF(le.Input_report_code_desc))'','',':report_code_desc')
    #END
+    #IF( #TEXT(Input_citation_id)='' )
      '' 
    #ELSE
        IF( le.Input_citation_id = (TYPEOF(le.Input_citation_id))'','',':citation_id')
    #END
+    #IF( #TEXT(Input_creation_date)='' )
      '' 
    #ELSE
        IF( le.Input_creation_date = (TYPEOF(le.Input_creation_date))'','',':creation_date')
    #END
+    #IF( #TEXT(Input_incident_id)='' )
      '' 
    #ELSE
        IF( le.Input_incident_id = (TYPEOF(le.Input_incident_id))'','',':incident_id')
    #END
+    #IF( #TEXT(Input_citation_issued)='' )
      '' 
    #ELSE
        IF( le.Input_citation_issued = (TYPEOF(le.Input_citation_issued))'','',':citation_issued')
    #END
+    #IF( #TEXT(Input_citation_number1)='' )
      '' 
    #ELSE
        IF( le.Input_citation_number1 = (TYPEOF(le.Input_citation_number1))'','',':citation_number1')
    #END
+    #IF( #TEXT(Input_citation_number2)='' )
      '' 
    #ELSE
        IF( le.Input_citation_number2 = (TYPEOF(le.Input_citation_number2))'','',':citation_number2')
    #END
+    #IF( #TEXT(Input_section_number1)='' )
      '' 
    #ELSE
        IF( le.Input_section_number1 = (TYPEOF(le.Input_section_number1))'','',':section_number1')
    #END
+    #IF( #TEXT(Input_court_date)='' )
      '' 
    #ELSE
        IF( le.Input_court_date = (TYPEOF(le.Input_court_date))'','',':court_date')
    #END
+    #IF( #TEXT(Input_court_time)='' )
      '' 
    #ELSE
        IF( le.Input_court_time = (TYPEOF(le.Input_court_time))'','',':court_time')
    #END
+    #IF( #TEXT(Input_citation_detail1)='' )
      '' 
    #ELSE
        IF( le.Input_citation_detail1 = (TYPEOF(le.Input_citation_detail1))'','',':citation_detail1')
    #END
+    #IF( #TEXT(Input_local_code)='' )
      '' 
    #ELSE
        IF( le.Input_local_code = (TYPEOF(le.Input_local_code))'','',':local_code')
    #END
+    #IF( #TEXT(Input_violation_code1)='' )
      '' 
    #ELSE
        IF( le.Input_violation_code1 = (TYPEOF(le.Input_violation_code1))'','',':violation_code1')
    #END
+    #IF( #TEXT(Input_violation_code2)='' )
      '' 
    #ELSE
        IF( le.Input_violation_code2 = (TYPEOF(le.Input_violation_code2))'','',':violation_code2')
    #END
+    #IF( #TEXT(Input_multiple_charges_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_multiple_charges_indicator = (TYPEOF(le.Input_multiple_charges_indicator))'','',':multiple_charges_indicator')
    #END
+    #IF( #TEXT(Input_dui_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_dui_indicator = (TYPEOF(le.Input_dui_indicator))'','',':dui_indicator')
    #END
+    #IF( #TEXT(Input_commercial_id)='' )
      '' 
    #ELSE
        IF( le.Input_commercial_id = (TYPEOF(le.Input_commercial_id))'','',':commercial_id')
    #END
+    #IF( #TEXT(Input_vehicle_id)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_id = (TYPEOF(le.Input_vehicle_id))'','',':vehicle_id')
    #END
+    #IF( #TEXT(Input_commercial_info_source)='' )
      '' 
    #ELSE
        IF( le.Input_commercial_info_source = (TYPEOF(le.Input_commercial_info_source))'','',':commercial_info_source')
    #END
+    #IF( #TEXT(Input_commercial_vehicle_type)='' )
      '' 
    #ELSE
        IF( le.Input_commercial_vehicle_type = (TYPEOF(le.Input_commercial_vehicle_type))'','',':commercial_vehicle_type')
    #END
+    #IF( #TEXT(Input_motor_carrier_id_dot_number)='' )
      '' 
    #ELSE
        IF( le.Input_motor_carrier_id_dot_number = (TYPEOF(le.Input_motor_carrier_id_dot_number))'','',':motor_carrier_id_dot_number')
    #END
+    #IF( #TEXT(Input_motor_carrier_id_state_id)='' )
      '' 
    #ELSE
        IF( le.Input_motor_carrier_id_state_id = (TYPEOF(le.Input_motor_carrier_id_state_id))'','',':motor_carrier_id_state_id')
    #END
+    #IF( #TEXT(Input_motor_carrier_id_carrier_name)='' )
      '' 
    #ELSE
        IF( le.Input_motor_carrier_id_carrier_name = (TYPEOF(le.Input_motor_carrier_id_carrier_name))'','',':motor_carrier_id_carrier_name')
    #END
+    #IF( #TEXT(Input_motor_carrier_id_address)='' )
      '' 
    #ELSE
        IF( le.Input_motor_carrier_id_address = (TYPEOF(le.Input_motor_carrier_id_address))'','',':motor_carrier_id_address')
    #END
+    #IF( #TEXT(Input_motor_carrier_id_city)='' )
      '' 
    #ELSE
        IF( le.Input_motor_carrier_id_city = (TYPEOF(le.Input_motor_carrier_id_city))'','',':motor_carrier_id_city')
    #END
+    #IF( #TEXT(Input_motor_carrier_id_state)='' )
      '' 
    #ELSE
        IF( le.Input_motor_carrier_id_state = (TYPEOF(le.Input_motor_carrier_id_state))'','',':motor_carrier_id_state')
    #END
+    #IF( #TEXT(Input_motor_carrier_id_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_motor_carrier_id_zipcode = (TYPEOF(le.Input_motor_carrier_id_zipcode))'','',':motor_carrier_id_zipcode')
    #END
+    #IF( #TEXT(Input_motor_carrier_id_commercial_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_motor_carrier_id_commercial_indicator = (TYPEOF(le.Input_motor_carrier_id_commercial_indicator))'','',':motor_carrier_id_commercial_indicator')
    #END
+    #IF( #TEXT(Input_carrier_id_type)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_id_type = (TYPEOF(le.Input_carrier_id_type))'','',':carrier_id_type')
    #END
+    #IF( #TEXT(Input_carrier_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_unit_number = (TYPEOF(le.Input_carrier_unit_number))'','',':carrier_unit_number')
    #END
+    #IF( #TEXT(Input_dot_permit_number)='' )
      '' 
    #ELSE
        IF( le.Input_dot_permit_number = (TYPEOF(le.Input_dot_permit_number))'','',':dot_permit_number')
    #END
+    #IF( #TEXT(Input_iccmc_number)='' )
      '' 
    #ELSE
        IF( le.Input_iccmc_number = (TYPEOF(le.Input_iccmc_number))'','',':iccmc_number')
    #END
+    #IF( #TEXT(Input_mcs_vehicle_inspection)='' )
      '' 
    #ELSE
        IF( le.Input_mcs_vehicle_inspection = (TYPEOF(le.Input_mcs_vehicle_inspection))'','',':mcs_vehicle_inspection')
    #END
+    #IF( #TEXT(Input_mcs_form_number)='' )
      '' 
    #ELSE
        IF( le.Input_mcs_form_number = (TYPEOF(le.Input_mcs_form_number))'','',':mcs_form_number')
    #END
+    #IF( #TEXT(Input_mcs_out_of_service)='' )
      '' 
    #ELSE
        IF( le.Input_mcs_out_of_service = (TYPEOF(le.Input_mcs_out_of_service))'','',':mcs_out_of_service')
    #END
+    #IF( #TEXT(Input_mcs_violation_related)='' )
      '' 
    #ELSE
        IF( le.Input_mcs_violation_related = (TYPEOF(le.Input_mcs_violation_related))'','',':mcs_violation_related')
    #END
+    #IF( #TEXT(Input_number_of_axles)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_axles = (TYPEOF(le.Input_number_of_axles))'','',':number_of_axles')
    #END
+    #IF( #TEXT(Input_number_of_tires)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_tires = (TYPEOF(le.Input_number_of_tires))'','',':number_of_tires')
    #END
+    #IF( #TEXT(Input_gvw_over_10k_pounds)='' )
      '' 
    #ELSE
        IF( le.Input_gvw_over_10k_pounds = (TYPEOF(le.Input_gvw_over_10k_pounds))'','',':gvw_over_10k_pounds')
    #END
+    #IF( #TEXT(Input_weight_rating)='' )
      '' 
    #ELSE
        IF( le.Input_weight_rating = (TYPEOF(le.Input_weight_rating))'','',':weight_rating')
    #END
+    #IF( #TEXT(Input_registered_gross_vehicle_weight)='' )
      '' 
    #ELSE
        IF( le.Input_registered_gross_vehicle_weight = (TYPEOF(le.Input_registered_gross_vehicle_weight))'','',':registered_gross_vehicle_weight')
    #END
+    #IF( #TEXT(Input_vehicle_length_feet)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_length_feet = (TYPEOF(le.Input_vehicle_length_feet))'','',':vehicle_length_feet')
    #END
+    #IF( #TEXT(Input_cargo_body_type)='' )
      '' 
    #ELSE
        IF( le.Input_cargo_body_type = (TYPEOF(le.Input_cargo_body_type))'','',':cargo_body_type')
    #END
+    #IF( #TEXT(Input_load_type)='' )
      '' 
    #ELSE
        IF( le.Input_load_type = (TYPEOF(le.Input_load_type))'','',':load_type')
    #END
+    #IF( #TEXT(Input_oversize_load)='' )
      '' 
    #ELSE
        IF( le.Input_oversize_load = (TYPEOF(le.Input_oversize_load))'','',':oversize_load')
    #END
+    #IF( #TEXT(Input_vehicle_configuration)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_configuration = (TYPEOF(le.Input_vehicle_configuration))'','',':vehicle_configuration')
    #END
+    #IF( #TEXT(Input_trailer1_type)='' )
      '' 
    #ELSE
        IF( le.Input_trailer1_type = (TYPEOF(le.Input_trailer1_type))'','',':trailer1_type')
    #END
+    #IF( #TEXT(Input_trailer1_length_feet)='' )
      '' 
    #ELSE
        IF( le.Input_trailer1_length_feet = (TYPEOF(le.Input_trailer1_length_feet))'','',':trailer1_length_feet')
    #END
+    #IF( #TEXT(Input_trailer1_width_feet)='' )
      '' 
    #ELSE
        IF( le.Input_trailer1_width_feet = (TYPEOF(le.Input_trailer1_width_feet))'','',':trailer1_width_feet')
    #END
+    #IF( #TEXT(Input_trailer2_type)='' )
      '' 
    #ELSE
        IF( le.Input_trailer2_type = (TYPEOF(le.Input_trailer2_type))'','',':trailer2_type')
    #END
+    #IF( #TEXT(Input_trailer2_length_feet)='' )
      '' 
    #ELSE
        IF( le.Input_trailer2_length_feet = (TYPEOF(le.Input_trailer2_length_feet))'','',':trailer2_length_feet')
    #END
+    #IF( #TEXT(Input_trailer2_width_feet)='' )
      '' 
    #ELSE
        IF( le.Input_trailer2_width_feet = (TYPEOF(le.Input_trailer2_width_feet))'','',':trailer2_width_feet')
    #END
+    #IF( #TEXT(Input_federally_reportable)='' )
      '' 
    #ELSE
        IF( le.Input_federally_reportable = (TYPEOF(le.Input_federally_reportable))'','',':federally_reportable')
    #END
+    #IF( #TEXT(Input_vehicle_inspection_hazmat)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_inspection_hazmat = (TYPEOF(le.Input_vehicle_inspection_hazmat))'','',':vehicle_inspection_hazmat')
    #END
+    #IF( #TEXT(Input_hazmat_form_number)='' )
      '' 
    #ELSE
        IF( le.Input_hazmat_form_number = (TYPEOF(le.Input_hazmat_form_number))'','',':hazmat_form_number')
    #END
+    #IF( #TEXT(Input_hazmt_out_of_service)='' )
      '' 
    #ELSE
        IF( le.Input_hazmt_out_of_service = (TYPEOF(le.Input_hazmt_out_of_service))'','',':hazmt_out_of_service')
    #END
+    #IF( #TEXT(Input_hazmat_violation_related)='' )
      '' 
    #ELSE
        IF( le.Input_hazmat_violation_related = (TYPEOF(le.Input_hazmat_violation_related))'','',':hazmat_violation_related')
    #END
+    #IF( #TEXT(Input_hazardous_materials_placard)='' )
      '' 
    #ELSE
        IF( le.Input_hazardous_materials_placard = (TYPEOF(le.Input_hazardous_materials_placard))'','',':hazardous_materials_placard')
    #END
+    #IF( #TEXT(Input_hazardous_materials_class_number1)='' )
      '' 
    #ELSE
        IF( le.Input_hazardous_materials_class_number1 = (TYPEOF(le.Input_hazardous_materials_class_number1))'','',':hazardous_materials_class_number1')
    #END
+    #IF( #TEXT(Input_hazardous_materials_class_number2)='' )
      '' 
    #ELSE
        IF( le.Input_hazardous_materials_class_number2 = (TYPEOF(le.Input_hazardous_materials_class_number2))'','',':hazardous_materials_class_number2')
    #END
+    #IF( #TEXT(Input_hazmat_placard_name)='' )
      '' 
    #ELSE
        IF( le.Input_hazmat_placard_name = (TYPEOF(le.Input_hazmat_placard_name))'','',':hazmat_placard_name')
    #END
+    #IF( #TEXT(Input_hazardous_materials_released1)='' )
      '' 
    #ELSE
        IF( le.Input_hazardous_materials_released1 = (TYPEOF(le.Input_hazardous_materials_released1))'','',':hazardous_materials_released1')
    #END
+    #IF( #TEXT(Input_hazardous_materials_released2)='' )
      '' 
    #ELSE
        IF( le.Input_hazardous_materials_released2 = (TYPEOF(le.Input_hazardous_materials_released2))'','',':hazardous_materials_released2')
    #END
+    #IF( #TEXT(Input_hazardous_materials_released3)='' )
      '' 
    #ELSE
        IF( le.Input_hazardous_materials_released3 = (TYPEOF(le.Input_hazardous_materials_released3))'','',':hazardous_materials_released3')
    #END
+    #IF( #TEXT(Input_hazardous_materials_released4)='' )
      '' 
    #ELSE
        IF( le.Input_hazardous_materials_released4 = (TYPEOF(le.Input_hazardous_materials_released4))'','',':hazardous_materials_released4')
    #END
+    #IF( #TEXT(Input_commercial_event1)='' )
      '' 
    #ELSE
        IF( le.Input_commercial_event1 = (TYPEOF(le.Input_commercial_event1))'','',':commercial_event1')
    #END
+    #IF( #TEXT(Input_commercial_event2)='' )
      '' 
    #ELSE
        IF( le.Input_commercial_event2 = (TYPEOF(le.Input_commercial_event2))'','',':commercial_event2')
    #END
+    #IF( #TEXT(Input_commercial_event3)='' )
      '' 
    #ELSE
        IF( le.Input_commercial_event3 = (TYPEOF(le.Input_commercial_event3))'','',':commercial_event3')
    #END
+    #IF( #TEXT(Input_commercial_event4)='' )
      '' 
    #ELSE
        IF( le.Input_commercial_event4 = (TYPEOF(le.Input_commercial_event4))'','',':commercial_event4')
    #END
+    #IF( #TEXT(Input_recommended_driver_reexam)='' )
      '' 
    #ELSE
        IF( le.Input_recommended_driver_reexam = (TYPEOF(le.Input_recommended_driver_reexam))'','',':recommended_driver_reexam')
    #END
+    #IF( #TEXT(Input_transporting_hazmat)='' )
      '' 
    #ELSE
        IF( le.Input_transporting_hazmat = (TYPEOF(le.Input_transporting_hazmat))'','',':transporting_hazmat')
    #END
+    #IF( #TEXT(Input_liquid_hazmat_volume)='' )
      '' 
    #ELSE
        IF( le.Input_liquid_hazmat_volume = (TYPEOF(le.Input_liquid_hazmat_volume))'','',':liquid_hazmat_volume')
    #END
+    #IF( #TEXT(Input_oversize_vehicle)='' )
      '' 
    #ELSE
        IF( le.Input_oversize_vehicle = (TYPEOF(le.Input_oversize_vehicle))'','',':oversize_vehicle')
    #END
+    #IF( #TEXT(Input_overlength_vehicle)='' )
      '' 
    #ELSE
        IF( le.Input_overlength_vehicle = (TYPEOF(le.Input_overlength_vehicle))'','',':overlength_vehicle')
    #END
+    #IF( #TEXT(Input_oversize_vehicle_permitted)='' )
      '' 
    #ELSE
        IF( le.Input_oversize_vehicle_permitted = (TYPEOF(le.Input_oversize_vehicle_permitted))'','',':oversize_vehicle_permitted')
    #END
+    #IF( #TEXT(Input_overlength_vehicle_permitted)='' )
      '' 
    #ELSE
        IF( le.Input_overlength_vehicle_permitted = (TYPEOF(le.Input_overlength_vehicle_permitted))'','',':overlength_vehicle_permitted')
    #END
+    #IF( #TEXT(Input_carrier_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_phone_number = (TYPEOF(le.Input_carrier_phone_number))'','',':carrier_phone_number')
    #END
+    #IF( #TEXT(Input_commerce_type)='' )
      '' 
    #ELSE
        IF( le.Input_commerce_type = (TYPEOF(le.Input_commerce_type))'','',':commerce_type')
    #END
+    #IF( #TEXT(Input_citation_issued_to_vehicle)='' )
      '' 
    #ELSE
        IF( le.Input_citation_issued_to_vehicle = (TYPEOF(le.Input_citation_issued_to_vehicle))'','',':citation_issued_to_vehicle')
    #END
+    #IF( #TEXT(Input_cdl_class)='' )
      '' 
    #ELSE
        IF( le.Input_cdl_class = (TYPEOF(le.Input_cdl_class))'','',':cdl_class')
    #END
+    #IF( #TEXT(Input_dot_state)='' )
      '' 
    #ELSE
        IF( le.Input_dot_state = (TYPEOF(le.Input_dot_state))'','',':dot_state')
    #END
+    #IF( #TEXT(Input_fire_hazardous_materials_involvement)='' )
      '' 
    #ELSE
        IF( le.Input_fire_hazardous_materials_involvement = (TYPEOF(le.Input_fire_hazardous_materials_involvement))'','',':fire_hazardous_materials_involvement')
    #END
+    #IF( #TEXT(Input_commercial_event_description)='' )
      '' 
    #ELSE
        IF( le.Input_commercial_event_description = (TYPEOF(le.Input_commercial_event_description))'','',':commercial_event_description')
    #END
+    #IF( #TEXT(Input_supplment_required_hazmat_placard)='' )
      '' 
    #ELSE
        IF( le.Input_supplment_required_hazmat_placard = (TYPEOF(le.Input_supplment_required_hazmat_placard))'','',':supplment_required_hazmat_placard')
    #END
+    #IF( #TEXT(Input_other_state_number1)='' )
      '' 
    #ELSE
        IF( le.Input_other_state_number1 = (TYPEOF(le.Input_other_state_number1))'','',':other_state_number1')
    #END
+    #IF( #TEXT(Input_other_state_number2)='' )
      '' 
    #ELSE
        IF( le.Input_other_state_number2 = (TYPEOF(le.Input_other_state_number2))'','',':other_state_number2')
    #END
+    #IF( #TEXT(Input_work_type_id)='' )
      '' 
    #ELSE
        IF( le.Input_work_type_id = (TYPEOF(le.Input_work_type_id))'','',':work_type_id')
    #END
+    #IF( #TEXT(Input_report_id)='' )
      '' 
    #ELSE
        IF( le.Input_report_id = (TYPEOF(le.Input_report_id))'','',':report_id')
    #END
+    #IF( #TEXT(Input_agency_id)='' )
      '' 
    #ELSE
        IF( le.Input_agency_id = (TYPEOF(le.Input_agency_id))'','',':agency_id')
    #END
+    #IF( #TEXT(Input_sent_to_hpcc_datetime)='' )
      '' 
    #ELSE
        IF( le.Input_sent_to_hpcc_datetime = (TYPEOF(le.Input_sent_to_hpcc_datetime))'','',':sent_to_hpcc_datetime')
    #END
+    #IF( #TEXT(Input_corrected_incident)='' )
      '' 
    #ELSE
        IF( le.Input_corrected_incident = (TYPEOF(le.Input_corrected_incident))'','',':corrected_incident')
    #END
+    #IF( #TEXT(Input_cru_order_id)='' )
      '' 
    #ELSE
        IF( le.Input_cru_order_id = (TYPEOF(le.Input_cru_order_id))'','',':cru_order_id')
    #END
+    #IF( #TEXT(Input_cru_sequence_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_cru_sequence_nbr = (TYPEOF(le.Input_cru_sequence_nbr))'','',':cru_sequence_nbr')
    #END
+    #IF( #TEXT(Input_loss_state_abbr)='' )
      '' 
    #ELSE
        IF( le.Input_loss_state_abbr = (TYPEOF(le.Input_loss_state_abbr))'','',':loss_state_abbr')
    #END
+    #IF( #TEXT(Input_report_type_id)='' )
      '' 
    #ELSE
        IF( le.Input_report_type_id = (TYPEOF(le.Input_report_type_id))'','',':report_type_id')
    #END
+    #IF( #TEXT(Input_hash_key)='' )
      '' 
    #ELSE
        IF( le.Input_hash_key = (TYPEOF(le.Input_hash_key))'','',':hash_key')
    #END
+    #IF( #TEXT(Input_case_identifier)='' )
      '' 
    #ELSE
        IF( le.Input_case_identifier = (TYPEOF(le.Input_case_identifier))'','',':case_identifier')
    #END
+    #IF( #TEXT(Input_crash_county)='' )
      '' 
    #ELSE
        IF( le.Input_crash_county = (TYPEOF(le.Input_crash_county))'','',':crash_county')
    #END
+    #IF( #TEXT(Input_county_cd)='' )
      '' 
    #ELSE
        IF( le.Input_county_cd = (TYPEOF(le.Input_county_cd))'','',':county_cd')
    #END
+    #IF( #TEXT(Input_crash_cityplace)='' )
      '' 
    #ELSE
        IF( le.Input_crash_cityplace = (TYPEOF(le.Input_crash_cityplace))'','',':crash_cityplace')
    #END
+    #IF( #TEXT(Input_crash_city)='' )
      '' 
    #ELSE
        IF( le.Input_crash_city = (TYPEOF(le.Input_crash_city))'','',':crash_city')
    #END
+    #IF( #TEXT(Input_city_code)='' )
      '' 
    #ELSE
        IF( le.Input_city_code = (TYPEOF(le.Input_city_code))'','',':city_code')
    #END
+    #IF( #TEXT(Input_first_harmful_event)='' )
      '' 
    #ELSE
        IF( le.Input_first_harmful_event = (TYPEOF(le.Input_first_harmful_event))'','',':first_harmful_event')
    #END
+    #IF( #TEXT(Input_first_harmful_event_location)='' )
      '' 
    #ELSE
        IF( le.Input_first_harmful_event_location = (TYPEOF(le.Input_first_harmful_event_location))'','',':first_harmful_event_location')
    #END
+    #IF( #TEXT(Input_manner_crash_impact1)='' )
      '' 
    #ELSE
        IF( le.Input_manner_crash_impact1 = (TYPEOF(le.Input_manner_crash_impact1))'','',':manner_crash_impact1')
    #END
+    #IF( #TEXT(Input_weather_condition1)='' )
      '' 
    #ELSE
        IF( le.Input_weather_condition1 = (TYPEOF(le.Input_weather_condition1))'','',':weather_condition1')
    #END
+    #IF( #TEXT(Input_weather_condition2)='' )
      '' 
    #ELSE
        IF( le.Input_weather_condition2 = (TYPEOF(le.Input_weather_condition2))'','',':weather_condition2')
    #END
+    #IF( #TEXT(Input_light_condition1)='' )
      '' 
    #ELSE
        IF( le.Input_light_condition1 = (TYPEOF(le.Input_light_condition1))'','',':light_condition1')
    #END
+    #IF( #TEXT(Input_light_condition2)='' )
      '' 
    #ELSE
        IF( le.Input_light_condition2 = (TYPEOF(le.Input_light_condition2))'','',':light_condition2')
    #END
+    #IF( #TEXT(Input_road_surface_condition)='' )
      '' 
    #ELSE
        IF( le.Input_road_surface_condition = (TYPEOF(le.Input_road_surface_condition))'','',':road_surface_condition')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_environmental1)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_environmental1 = (TYPEOF(le.Input_contributing_circumstances_environmental1))'','',':contributing_circumstances_environmental1')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_environmental2)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_environmental2 = (TYPEOF(le.Input_contributing_circumstances_environmental2))'','',':contributing_circumstances_environmental2')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_environmental3)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_environmental3 = (TYPEOF(le.Input_contributing_circumstances_environmental3))'','',':contributing_circumstances_environmental3')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_environmental4)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_environmental4 = (TYPEOF(le.Input_contributing_circumstances_environmental4))'','',':contributing_circumstances_environmental4')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_road1)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_road1 = (TYPEOF(le.Input_contributing_circumstances_road1))'','',':contributing_circumstances_road1')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_road2)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_road2 = (TYPEOF(le.Input_contributing_circumstances_road2))'','',':contributing_circumstances_road2')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_road3)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_road3 = (TYPEOF(le.Input_contributing_circumstances_road3))'','',':contributing_circumstances_road3')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_road4)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_road4 = (TYPEOF(le.Input_contributing_circumstances_road4))'','',':contributing_circumstances_road4')
    #END
+    #IF( #TEXT(Input_relation_to_junction)='' )
      '' 
    #ELSE
        IF( le.Input_relation_to_junction = (TYPEOF(le.Input_relation_to_junction))'','',':relation_to_junction')
    #END
+    #IF( #TEXT(Input_intersection_type)='' )
      '' 
    #ELSE
        IF( le.Input_intersection_type = (TYPEOF(le.Input_intersection_type))'','',':intersection_type')
    #END
+    #IF( #TEXT(Input_school_bus_related)='' )
      '' 
    #ELSE
        IF( le.Input_school_bus_related = (TYPEOF(le.Input_school_bus_related))'','',':school_bus_related')
    #END
+    #IF( #TEXT(Input_work_zone_related)='' )
      '' 
    #ELSE
        IF( le.Input_work_zone_related = (TYPEOF(le.Input_work_zone_related))'','',':work_zone_related')
    #END
+    #IF( #TEXT(Input_work_zone_location)='' )
      '' 
    #ELSE
        IF( le.Input_work_zone_location = (TYPEOF(le.Input_work_zone_location))'','',':work_zone_location')
    #END
+    #IF( #TEXT(Input_work_zone_type)='' )
      '' 
    #ELSE
        IF( le.Input_work_zone_type = (TYPEOF(le.Input_work_zone_type))'','',':work_zone_type')
    #END
+    #IF( #TEXT(Input_work_zone_workers_present)='' )
      '' 
    #ELSE
        IF( le.Input_work_zone_workers_present = (TYPEOF(le.Input_work_zone_workers_present))'','',':work_zone_workers_present')
    #END
+    #IF( #TEXT(Input_work_zone_law_enforcement_present)='' )
      '' 
    #ELSE
        IF( le.Input_work_zone_law_enforcement_present = (TYPEOF(le.Input_work_zone_law_enforcement_present))'','',':work_zone_law_enforcement_present')
    #END
+    #IF( #TEXT(Input_crash_severity)='' )
      '' 
    #ELSE
        IF( le.Input_crash_severity = (TYPEOF(le.Input_crash_severity))'','',':crash_severity')
    #END
+    #IF( #TEXT(Input_number_of_vehicles)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_vehicles = (TYPEOF(le.Input_number_of_vehicles))'','',':number_of_vehicles')
    #END
+    #IF( #TEXT(Input_total_nonfatal_injuries)='' )
      '' 
    #ELSE
        IF( le.Input_total_nonfatal_injuries = (TYPEOF(le.Input_total_nonfatal_injuries))'','',':total_nonfatal_injuries')
    #END
+    #IF( #TEXT(Input_total_fatal_injuries)='' )
      '' 
    #ELSE
        IF( le.Input_total_fatal_injuries = (TYPEOF(le.Input_total_fatal_injuries))'','',':total_fatal_injuries')
    #END
+    #IF( #TEXT(Input_day_of_week)='' )
      '' 
    #ELSE
        IF( le.Input_day_of_week = (TYPEOF(le.Input_day_of_week))'','',':day_of_week')
    #END
+    #IF( #TEXT(Input_roadway_curvature)='' )
      '' 
    #ELSE
        IF( le.Input_roadway_curvature = (TYPEOF(le.Input_roadway_curvature))'','',':roadway_curvature')
    #END
+    #IF( #TEXT(Input_part_of_national_highway_system)='' )
      '' 
    #ELSE
        IF( le.Input_part_of_national_highway_system = (TYPEOF(le.Input_part_of_national_highway_system))'','',':part_of_national_highway_system')
    #END
+    #IF( #TEXT(Input_roadway_functional_class)='' )
      '' 
    #ELSE
        IF( le.Input_roadway_functional_class = (TYPEOF(le.Input_roadway_functional_class))'','',':roadway_functional_class')
    #END
+    #IF( #TEXT(Input_access_control)='' )
      '' 
    #ELSE
        IF( le.Input_access_control = (TYPEOF(le.Input_access_control))'','',':access_control')
    #END
+    #IF( #TEXT(Input_rr_crossing_id)='' )
      '' 
    #ELSE
        IF( le.Input_rr_crossing_id = (TYPEOF(le.Input_rr_crossing_id))'','',':rr_crossing_id')
    #END
+    #IF( #TEXT(Input_roadway_lighting)='' )
      '' 
    #ELSE
        IF( le.Input_roadway_lighting = (TYPEOF(le.Input_roadway_lighting))'','',':roadway_lighting')
    #END
+    #IF( #TEXT(Input_traffic_control_type_at_intersection1)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_control_type_at_intersection1 = (TYPEOF(le.Input_traffic_control_type_at_intersection1))'','',':traffic_control_type_at_intersection1')
    #END
+    #IF( #TEXT(Input_traffic_control_type_at_intersection2)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_control_type_at_intersection2 = (TYPEOF(le.Input_traffic_control_type_at_intersection2))'','',':traffic_control_type_at_intersection2')
    #END
+    #IF( #TEXT(Input_ncic_number)='' )
      '' 
    #ELSE
        IF( le.Input_ncic_number = (TYPEOF(le.Input_ncic_number))'','',':ncic_number')
    #END
+    #IF( #TEXT(Input_state_report_number)='' )
      '' 
    #ELSE
        IF( le.Input_state_report_number = (TYPEOF(le.Input_state_report_number))'','',':state_report_number')
    #END
+    #IF( #TEXT(Input_ori_number)='' )
      '' 
    #ELSE
        IF( le.Input_ori_number = (TYPEOF(le.Input_ori_number))'','',':ori_number')
    #END
+    #IF( #TEXT(Input_crash_date)='' )
      '' 
    #ELSE
        IF( le.Input_crash_date = (TYPEOF(le.Input_crash_date))'','',':crash_date')
    #END
+    #IF( #TEXT(Input_crash_time)='' )
      '' 
    #ELSE
        IF( le.Input_crash_time = (TYPEOF(le.Input_crash_time))'','',':crash_time')
    #END
+    #IF( #TEXT(Input_lattitude)='' )
      '' 
    #ELSE
        IF( le.Input_lattitude = (TYPEOF(le.Input_lattitude))'','',':lattitude')
    #END
+    #IF( #TEXT(Input_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_longitude = (TYPEOF(le.Input_longitude))'','',':longitude')
    #END
+    #IF( #TEXT(Input_milepost1)='' )
      '' 
    #ELSE
        IF( le.Input_milepost1 = (TYPEOF(le.Input_milepost1))'','',':milepost1')
    #END
+    #IF( #TEXT(Input_milepost2)='' )
      '' 
    #ELSE
        IF( le.Input_milepost2 = (TYPEOF(le.Input_milepost2))'','',':milepost2')
    #END
+    #IF( #TEXT(Input_address_number)='' )
      '' 
    #ELSE
        IF( le.Input_address_number = (TYPEOF(le.Input_address_number))'','',':address_number')
    #END
+    #IF( #TEXT(Input_loss_street)='' )
      '' 
    #ELSE
        IF( le.Input_loss_street = (TYPEOF(le.Input_loss_street))'','',':loss_street')
    #END
+    #IF( #TEXT(Input_loss_street_route_number)='' )
      '' 
    #ELSE
        IF( le.Input_loss_street_route_number = (TYPEOF(le.Input_loss_street_route_number))'','',':loss_street_route_number')
    #END
+    #IF( #TEXT(Input_loss_street_type)='' )
      '' 
    #ELSE
        IF( le.Input_loss_street_type = (TYPEOF(le.Input_loss_street_type))'','',':loss_street_type')
    #END
+    #IF( #TEXT(Input_loss_street_speed_limit)='' )
      '' 
    #ELSE
        IF( le.Input_loss_street_speed_limit = (TYPEOF(le.Input_loss_street_speed_limit))'','',':loss_street_speed_limit')
    #END
+    #IF( #TEXT(Input_incident_location_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_incident_location_indicator = (TYPEOF(le.Input_incident_location_indicator))'','',':incident_location_indicator')
    #END
+    #IF( #TEXT(Input_loss_cross_street)='' )
      '' 
    #ELSE
        IF( le.Input_loss_cross_street = (TYPEOF(le.Input_loss_cross_street))'','',':loss_cross_street')
    #END
+    #IF( #TEXT(Input_loss_cross_street_route_number)='' )
      '' 
    #ELSE
        IF( le.Input_loss_cross_street_route_number = (TYPEOF(le.Input_loss_cross_street_route_number))'','',':loss_cross_street_route_number')
    #END
+    #IF( #TEXT(Input_loss_cross_street_intersecting_route_segment)='' )
      '' 
    #ELSE
        IF( le.Input_loss_cross_street_intersecting_route_segment = (TYPEOF(le.Input_loss_cross_street_intersecting_route_segment))'','',':loss_cross_street_intersecting_route_segment')
    #END
+    #IF( #TEXT(Input_loss_cross_street_type)='' )
      '' 
    #ELSE
        IF( le.Input_loss_cross_street_type = (TYPEOF(le.Input_loss_cross_street_type))'','',':loss_cross_street_type')
    #END
+    #IF( #TEXT(Input_loss_cross_street_speed_limit)='' )
      '' 
    #ELSE
        IF( le.Input_loss_cross_street_speed_limit = (TYPEOF(le.Input_loss_cross_street_speed_limit))'','',':loss_cross_street_speed_limit')
    #END
+    #IF( #TEXT(Input_loss_cross_street_number_of_lanes)='' )
      '' 
    #ELSE
        IF( le.Input_loss_cross_street_number_of_lanes = (TYPEOF(le.Input_loss_cross_street_number_of_lanes))'','',':loss_cross_street_number_of_lanes')
    #END
+    #IF( #TEXT(Input_loss_cross_street_orientation)='' )
      '' 
    #ELSE
        IF( le.Input_loss_cross_street_orientation = (TYPEOF(le.Input_loss_cross_street_orientation))'','',':loss_cross_street_orientation')
    #END
+    #IF( #TEXT(Input_loss_cross_street_route_sign)='' )
      '' 
    #ELSE
        IF( le.Input_loss_cross_street_route_sign = (TYPEOF(le.Input_loss_cross_street_route_sign))'','',':loss_cross_street_route_sign')
    #END
+    #IF( #TEXT(Input_at_node_number)='' )
      '' 
    #ELSE
        IF( le.Input_at_node_number = (TYPEOF(le.Input_at_node_number))'','',':at_node_number')
    #END
+    #IF( #TEXT(Input_distance_from_node_feet)='' )
      '' 
    #ELSE
        IF( le.Input_distance_from_node_feet = (TYPEOF(le.Input_distance_from_node_feet))'','',':distance_from_node_feet')
    #END
+    #IF( #TEXT(Input_distance_from_node_miles)='' )
      '' 
    #ELSE
        IF( le.Input_distance_from_node_miles = (TYPEOF(le.Input_distance_from_node_miles))'','',':distance_from_node_miles')
    #END
+    #IF( #TEXT(Input_next_node_number)='' )
      '' 
    #ELSE
        IF( le.Input_next_node_number = (TYPEOF(le.Input_next_node_number))'','',':next_node_number')
    #END
+    #IF( #TEXT(Input_next_roadway_node_number)='' )
      '' 
    #ELSE
        IF( le.Input_next_roadway_node_number = (TYPEOF(le.Input_next_roadway_node_number))'','',':next_roadway_node_number')
    #END
+    #IF( #TEXT(Input_direction_of_travel)='' )
      '' 
    #ELSE
        IF( le.Input_direction_of_travel = (TYPEOF(le.Input_direction_of_travel))'','',':direction_of_travel')
    #END
+    #IF( #TEXT(Input_next_street)='' )
      '' 
    #ELSE
        IF( le.Input_next_street = (TYPEOF(le.Input_next_street))'','',':next_street')
    #END
+    #IF( #TEXT(Input_next_street_type)='' )
      '' 
    #ELSE
        IF( le.Input_next_street_type = (TYPEOF(le.Input_next_street_type))'','',':next_street_type')
    #END
+    #IF( #TEXT(Input_next_street_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_next_street_suffix = (TYPEOF(le.Input_next_street_suffix))'','',':next_street_suffix')
    #END
+    #IF( #TEXT(Input_before_or_after_next_street)='' )
      '' 
    #ELSE
        IF( le.Input_before_or_after_next_street = (TYPEOF(le.Input_before_or_after_next_street))'','',':before_or_after_next_street')
    #END
+    #IF( #TEXT(Input_next_street_distance_feet)='' )
      '' 
    #ELSE
        IF( le.Input_next_street_distance_feet = (TYPEOF(le.Input_next_street_distance_feet))'','',':next_street_distance_feet')
    #END
+    #IF( #TEXT(Input_next_street_distance_miles)='' )
      '' 
    #ELSE
        IF( le.Input_next_street_distance_miles = (TYPEOF(le.Input_next_street_distance_miles))'','',':next_street_distance_miles')
    #END
+    #IF( #TEXT(Input_next_street_direction)='' )
      '' 
    #ELSE
        IF( le.Input_next_street_direction = (TYPEOF(le.Input_next_street_direction))'','',':next_street_direction')
    #END
+    #IF( #TEXT(Input_next_street_route_segment)='' )
      '' 
    #ELSE
        IF( le.Input_next_street_route_segment = (TYPEOF(le.Input_next_street_route_segment))'','',':next_street_route_segment')
    #END
+    #IF( #TEXT(Input_continuing_toward_street)='' )
      '' 
    #ELSE
        IF( le.Input_continuing_toward_street = (TYPEOF(le.Input_continuing_toward_street))'','',':continuing_toward_street')
    #END
+    #IF( #TEXT(Input_continuing_street_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_continuing_street_suffix = (TYPEOF(le.Input_continuing_street_suffix))'','',':continuing_street_suffix')
    #END
+    #IF( #TEXT(Input_continuing_street_direction)='' )
      '' 
    #ELSE
        IF( le.Input_continuing_street_direction = (TYPEOF(le.Input_continuing_street_direction))'','',':continuing_street_direction')
    #END
+    #IF( #TEXT(Input_continuting_street_route_segment)='' )
      '' 
    #ELSE
        IF( le.Input_continuting_street_route_segment = (TYPEOF(le.Input_continuting_street_route_segment))'','',':continuting_street_route_segment')
    #END
+    #IF( #TEXT(Input_city_type)='' )
      '' 
    #ELSE
        IF( le.Input_city_type = (TYPEOF(le.Input_city_type))'','',':city_type')
    #END
+    #IF( #TEXT(Input_outside_city_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_outside_city_indicator = (TYPEOF(le.Input_outside_city_indicator))'','',':outside_city_indicator')
    #END
+    #IF( #TEXT(Input_outside_city_direction)='' )
      '' 
    #ELSE
        IF( le.Input_outside_city_direction = (TYPEOF(le.Input_outside_city_direction))'','',':outside_city_direction')
    #END
+    #IF( #TEXT(Input_outside_city_distance_feet)='' )
      '' 
    #ELSE
        IF( le.Input_outside_city_distance_feet = (TYPEOF(le.Input_outside_city_distance_feet))'','',':outside_city_distance_feet')
    #END
+    #IF( #TEXT(Input_outside_city_distance_miles)='' )
      '' 
    #ELSE
        IF( le.Input_outside_city_distance_miles = (TYPEOF(le.Input_outside_city_distance_miles))'','',':outside_city_distance_miles')
    #END
+    #IF( #TEXT(Input_crash_type)='' )
      '' 
    #ELSE
        IF( le.Input_crash_type = (TYPEOF(le.Input_crash_type))'','',':crash_type')
    #END
+    #IF( #TEXT(Input_motor_vehicle_involved_with)='' )
      '' 
    #ELSE
        IF( le.Input_motor_vehicle_involved_with = (TYPEOF(le.Input_motor_vehicle_involved_with))'','',':motor_vehicle_involved_with')
    #END
+    #IF( #TEXT(Input_report_investigation_type)='' )
      '' 
    #ELSE
        IF( le.Input_report_investigation_type = (TYPEOF(le.Input_report_investigation_type))'','',':report_investigation_type')
    #END
+    #IF( #TEXT(Input_incident_hit_and_run)='' )
      '' 
    #ELSE
        IF( le.Input_incident_hit_and_run = (TYPEOF(le.Input_incident_hit_and_run))'','',':incident_hit_and_run')
    #END
+    #IF( #TEXT(Input_tow_away)='' )
      '' 
    #ELSE
        IF( le.Input_tow_away = (TYPEOF(le.Input_tow_away))'','',':tow_away')
    #END
+    #IF( #TEXT(Input_date_notified)='' )
      '' 
    #ELSE
        IF( le.Input_date_notified = (TYPEOF(le.Input_date_notified))'','',':date_notified')
    #END
+    #IF( #TEXT(Input_time_notified)='' )
      '' 
    #ELSE
        IF( le.Input_time_notified = (TYPEOF(le.Input_time_notified))'','',':time_notified')
    #END
+    #IF( #TEXT(Input_notification_method)='' )
      '' 
    #ELSE
        IF( le.Input_notification_method = (TYPEOF(le.Input_notification_method))'','',':notification_method')
    #END
+    #IF( #TEXT(Input_officer_arrival_time)='' )
      '' 
    #ELSE
        IF( le.Input_officer_arrival_time = (TYPEOF(le.Input_officer_arrival_time))'','',':officer_arrival_time')
    #END
+    #IF( #TEXT(Input_officer_report_date)='' )
      '' 
    #ELSE
        IF( le.Input_officer_report_date = (TYPEOF(le.Input_officer_report_date))'','',':officer_report_date')
    #END
+    #IF( #TEXT(Input_officer_report_time)='' )
      '' 
    #ELSE
        IF( le.Input_officer_report_time = (TYPEOF(le.Input_officer_report_time))'','',':officer_report_time')
    #END
+    #IF( #TEXT(Input_officer_id)='' )
      '' 
    #ELSE
        IF( le.Input_officer_id = (TYPEOF(le.Input_officer_id))'','',':officer_id')
    #END
+    #IF( #TEXT(Input_officer_department)='' )
      '' 
    #ELSE
        IF( le.Input_officer_department = (TYPEOF(le.Input_officer_department))'','',':officer_department')
    #END
+    #IF( #TEXT(Input_officer_rank)='' )
      '' 
    #ELSE
        IF( le.Input_officer_rank = (TYPEOF(le.Input_officer_rank))'','',':officer_rank')
    #END
+    #IF( #TEXT(Input_officer_command)='' )
      '' 
    #ELSE
        IF( le.Input_officer_command = (TYPEOF(le.Input_officer_command))'','',':officer_command')
    #END
+    #IF( #TEXT(Input_officer_tax_id_number)='' )
      '' 
    #ELSE
        IF( le.Input_officer_tax_id_number = (TYPEOF(le.Input_officer_tax_id_number))'','',':officer_tax_id_number')
    #END
+    #IF( #TEXT(Input_completed_report_date)='' )
      '' 
    #ELSE
        IF( le.Input_completed_report_date = (TYPEOF(le.Input_completed_report_date))'','',':completed_report_date')
    #END
+    #IF( #TEXT(Input_supervisor_check_date)='' )
      '' 
    #ELSE
        IF( le.Input_supervisor_check_date = (TYPEOF(le.Input_supervisor_check_date))'','',':supervisor_check_date')
    #END
+    #IF( #TEXT(Input_supervisor_check_time)='' )
      '' 
    #ELSE
        IF( le.Input_supervisor_check_time = (TYPEOF(le.Input_supervisor_check_time))'','',':supervisor_check_time')
    #END
+    #IF( #TEXT(Input_supervisor_id)='' )
      '' 
    #ELSE
        IF( le.Input_supervisor_id = (TYPEOF(le.Input_supervisor_id))'','',':supervisor_id')
    #END
+    #IF( #TEXT(Input_supervisor_rank)='' )
      '' 
    #ELSE
        IF( le.Input_supervisor_rank = (TYPEOF(le.Input_supervisor_rank))'','',':supervisor_rank')
    #END
+    #IF( #TEXT(Input_reviewers_name)='' )
      '' 
    #ELSE
        IF( le.Input_reviewers_name = (TYPEOF(le.Input_reviewers_name))'','',':reviewers_name')
    #END
+    #IF( #TEXT(Input_road_surface)='' )
      '' 
    #ELSE
        IF( le.Input_road_surface = (TYPEOF(le.Input_road_surface))'','',':road_surface')
    #END
+    #IF( #TEXT(Input_roadway_alignment)='' )
      '' 
    #ELSE
        IF( le.Input_roadway_alignment = (TYPEOF(le.Input_roadway_alignment))'','',':roadway_alignment')
    #END
+    #IF( #TEXT(Input_traffic_way_description)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_way_description = (TYPEOF(le.Input_traffic_way_description))'','',':traffic_way_description')
    #END
+    #IF( #TEXT(Input_traffic_flow)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_flow = (TYPEOF(le.Input_traffic_flow))'','',':traffic_flow')
    #END
+    #IF( #TEXT(Input_property_damage_involved)='' )
      '' 
    #ELSE
        IF( le.Input_property_damage_involved = (TYPEOF(le.Input_property_damage_involved))'','',':property_damage_involved')
    #END
+    #IF( #TEXT(Input_property_damage_description1)='' )
      '' 
    #ELSE
        IF( le.Input_property_damage_description1 = (TYPEOF(le.Input_property_damage_description1))'','',':property_damage_description1')
    #END
+    #IF( #TEXT(Input_property_damage_description2)='' )
      '' 
    #ELSE
        IF( le.Input_property_damage_description2 = (TYPEOF(le.Input_property_damage_description2))'','',':property_damage_description2')
    #END
+    #IF( #TEXT(Input_property_damage_estimate1)='' )
      '' 
    #ELSE
        IF( le.Input_property_damage_estimate1 = (TYPEOF(le.Input_property_damage_estimate1))'','',':property_damage_estimate1')
    #END
+    #IF( #TEXT(Input_property_damage_estimate2)='' )
      '' 
    #ELSE
        IF( le.Input_property_damage_estimate2 = (TYPEOF(le.Input_property_damage_estimate2))'','',':property_damage_estimate2')
    #END
+    #IF( #TEXT(Input_incident_damage_over_limit)='' )
      '' 
    #ELSE
        IF( le.Input_incident_damage_over_limit = (TYPEOF(le.Input_incident_damage_over_limit))'','',':incident_damage_over_limit')
    #END
+    #IF( #TEXT(Input_property_owner_notified)='' )
      '' 
    #ELSE
        IF( le.Input_property_owner_notified = (TYPEOF(le.Input_property_owner_notified))'','',':property_owner_notified')
    #END
+    #IF( #TEXT(Input_government_property)='' )
      '' 
    #ELSE
        IF( le.Input_government_property = (TYPEOF(le.Input_government_property))'','',':government_property')
    #END
+    #IF( #TEXT(Input_accident_condition)='' )
      '' 
    #ELSE
        IF( le.Input_accident_condition = (TYPEOF(le.Input_accident_condition))'','',':accident_condition')
    #END
+    #IF( #TEXT(Input_unusual_road_condition1)='' )
      '' 
    #ELSE
        IF( le.Input_unusual_road_condition1 = (TYPEOF(le.Input_unusual_road_condition1))'','',':unusual_road_condition1')
    #END
+    #IF( #TEXT(Input_unusual_road_condition2)='' )
      '' 
    #ELSE
        IF( le.Input_unusual_road_condition2 = (TYPEOF(le.Input_unusual_road_condition2))'','',':unusual_road_condition2')
    #END
+    #IF( #TEXT(Input_number_of_lanes)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_lanes = (TYPEOF(le.Input_number_of_lanes))'','',':number_of_lanes')
    #END
+    #IF( #TEXT(Input_divided_highway)='' )
      '' 
    #ELSE
        IF( le.Input_divided_highway = (TYPEOF(le.Input_divided_highway))'','',':divided_highway')
    #END
+    #IF( #TEXT(Input_most_harmful_event)='' )
      '' 
    #ELSE
        IF( le.Input_most_harmful_event = (TYPEOF(le.Input_most_harmful_event))'','',':most_harmful_event')
    #END
+    #IF( #TEXT(Input_second_harmful_event)='' )
      '' 
    #ELSE
        IF( le.Input_second_harmful_event = (TYPEOF(le.Input_second_harmful_event))'','',':second_harmful_event')
    #END
+    #IF( #TEXT(Input_ems_notified_date)='' )
      '' 
    #ELSE
        IF( le.Input_ems_notified_date = (TYPEOF(le.Input_ems_notified_date))'','',':ems_notified_date')
    #END
+    #IF( #TEXT(Input_ems_arrival_date)='' )
      '' 
    #ELSE
        IF( le.Input_ems_arrival_date = (TYPEOF(le.Input_ems_arrival_date))'','',':ems_arrival_date')
    #END
+    #IF( #TEXT(Input_hospital_arrival_date)='' )
      '' 
    #ELSE
        IF( le.Input_hospital_arrival_date = (TYPEOF(le.Input_hospital_arrival_date))'','',':hospital_arrival_date')
    #END
+    #IF( #TEXT(Input_injured_taken_by)='' )
      '' 
    #ELSE
        IF( le.Input_injured_taken_by = (TYPEOF(le.Input_injured_taken_by))'','',':injured_taken_by')
    #END
+    #IF( #TEXT(Input_injured_taken_to)='' )
      '' 
    #ELSE
        IF( le.Input_injured_taken_to = (TYPEOF(le.Input_injured_taken_to))'','',':injured_taken_to')
    #END
+    #IF( #TEXT(Input_incident_transported_for_medical_care)='' )
      '' 
    #ELSE
        IF( le.Input_incident_transported_for_medical_care = (TYPEOF(le.Input_incident_transported_for_medical_care))'','',':incident_transported_for_medical_care')
    #END
+    #IF( #TEXT(Input_photographs_taken)='' )
      '' 
    #ELSE
        IF( le.Input_photographs_taken = (TYPEOF(le.Input_photographs_taken))'','',':photographs_taken')
    #END
+    #IF( #TEXT(Input_photographed_by)='' )
      '' 
    #ELSE
        IF( le.Input_photographed_by = (TYPEOF(le.Input_photographed_by))'','',':photographed_by')
    #END
+    #IF( #TEXT(Input_photographer_id)='' )
      '' 
    #ELSE
        IF( le.Input_photographer_id = (TYPEOF(le.Input_photographer_id))'','',':photographer_id')
    #END
+    #IF( #TEXT(Input_photography_agency_name)='' )
      '' 
    #ELSE
        IF( le.Input_photography_agency_name = (TYPEOF(le.Input_photography_agency_name))'','',':photography_agency_name')
    #END
+    #IF( #TEXT(Input_agency_name)='' )
      '' 
    #ELSE
        IF( le.Input_agency_name = (TYPEOF(le.Input_agency_name))'','',':agency_name')
    #END
+    #IF( #TEXT(Input_judicial_district)='' )
      '' 
    #ELSE
        IF( le.Input_judicial_district = (TYPEOF(le.Input_judicial_district))'','',':judicial_district')
    #END
+    #IF( #TEXT(Input_precinct)='' )
      '' 
    #ELSE
        IF( le.Input_precinct = (TYPEOF(le.Input_precinct))'','',':precinct')
    #END
+    #IF( #TEXT(Input_beat)='' )
      '' 
    #ELSE
        IF( le.Input_beat = (TYPEOF(le.Input_beat))'','',':beat')
    #END
+    #IF( #TEXT(Input_location_type)='' )
      '' 
    #ELSE
        IF( le.Input_location_type = (TYPEOF(le.Input_location_type))'','',':location_type')
    #END
+    #IF( #TEXT(Input_shoulder_type)='' )
      '' 
    #ELSE
        IF( le.Input_shoulder_type = (TYPEOF(le.Input_shoulder_type))'','',':shoulder_type')
    #END
+    #IF( #TEXT(Input_investigation_complete)='' )
      '' 
    #ELSE
        IF( le.Input_investigation_complete = (TYPEOF(le.Input_investigation_complete))'','',':investigation_complete')
    #END
+    #IF( #TEXT(Input_investigation_not_complete_why)='' )
      '' 
    #ELSE
        IF( le.Input_investigation_not_complete_why = (TYPEOF(le.Input_investigation_not_complete_why))'','',':investigation_not_complete_why')
    #END
+    #IF( #TEXT(Input_investigating_officer_name)='' )
      '' 
    #ELSE
        IF( le.Input_investigating_officer_name = (TYPEOF(le.Input_investigating_officer_name))'','',':investigating_officer_name')
    #END
+    #IF( #TEXT(Input_investigation_notification_issued)='' )
      '' 
    #ELSE
        IF( le.Input_investigation_notification_issued = (TYPEOF(le.Input_investigation_notification_issued))'','',':investigation_notification_issued')
    #END
+    #IF( #TEXT(Input_agency_type)='' )
      '' 
    #ELSE
        IF( le.Input_agency_type = (TYPEOF(le.Input_agency_type))'','',':agency_type')
    #END
+    #IF( #TEXT(Input_no_injury_tow_involved)='' )
      '' 
    #ELSE
        IF( le.Input_no_injury_tow_involved = (TYPEOF(le.Input_no_injury_tow_involved))'','',':no_injury_tow_involved')
    #END
+    #IF( #TEXT(Input_injury_tow_involved)='' )
      '' 
    #ELSE
        IF( le.Input_injury_tow_involved = (TYPEOF(le.Input_injury_tow_involved))'','',':injury_tow_involved')
    #END
+    #IF( #TEXT(Input_lars_code1)='' )
      '' 
    #ELSE
        IF( le.Input_lars_code1 = (TYPEOF(le.Input_lars_code1))'','',':lars_code1')
    #END
+    #IF( #TEXT(Input_lars_code2)='' )
      '' 
    #ELSE
        IF( le.Input_lars_code2 = (TYPEOF(le.Input_lars_code2))'','',':lars_code2')
    #END
+    #IF( #TEXT(Input_private_property_incident)='' )
      '' 
    #ELSE
        IF( le.Input_private_property_incident = (TYPEOF(le.Input_private_property_incident))'','',':private_property_incident')
    #END
+    #IF( #TEXT(Input_accident_involvement)='' )
      '' 
    #ELSE
        IF( le.Input_accident_involvement = (TYPEOF(le.Input_accident_involvement))'','',':accident_involvement')
    #END
+    #IF( #TEXT(Input_local_use)='' )
      '' 
    #ELSE
        IF( le.Input_local_use = (TYPEOF(le.Input_local_use))'','',':local_use')
    #END
+    #IF( #TEXT(Input_street_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_street_prefix = (TYPEOF(le.Input_street_prefix))'','',':street_prefix')
    #END
+    #IF( #TEXT(Input_street_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_street_suffix = (TYPEOF(le.Input_street_suffix))'','',':street_suffix')
    #END
+    #IF( #TEXT(Input_toll_road)='' )
      '' 
    #ELSE
        IF( le.Input_toll_road = (TYPEOF(le.Input_toll_road))'','',':toll_road')
    #END
+    #IF( #TEXT(Input_street_description)='' )
      '' 
    #ELSE
        IF( le.Input_street_description = (TYPEOF(le.Input_street_description))'','',':street_description')
    #END
+    #IF( #TEXT(Input_cross_street_address_number)='' )
      '' 
    #ELSE
        IF( le.Input_cross_street_address_number = (TYPEOF(le.Input_cross_street_address_number))'','',':cross_street_address_number')
    #END
+    #IF( #TEXT(Input_cross_street_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_cross_street_prefix = (TYPEOF(le.Input_cross_street_prefix))'','',':cross_street_prefix')
    #END
+    #IF( #TEXT(Input_cross_street_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_cross_street_suffix = (TYPEOF(le.Input_cross_street_suffix))'','',':cross_street_suffix')
    #END
+    #IF( #TEXT(Input_report_complete)='' )
      '' 
    #ELSE
        IF( le.Input_report_complete = (TYPEOF(le.Input_report_complete))'','',':report_complete')
    #END
+    #IF( #TEXT(Input_dispatch_notified)='' )
      '' 
    #ELSE
        IF( le.Input_dispatch_notified = (TYPEOF(le.Input_dispatch_notified))'','',':dispatch_notified')
    #END
+    #IF( #TEXT(Input_counter_report)='' )
      '' 
    #ELSE
        IF( le.Input_counter_report = (TYPEOF(le.Input_counter_report))'','',':counter_report')
    #END
+    #IF( #TEXT(Input_road_type)='' )
      '' 
    #ELSE
        IF( le.Input_road_type = (TYPEOF(le.Input_road_type))'','',':road_type')
    #END
+    #IF( #TEXT(Input_agency_code)='' )
      '' 
    #ELSE
        IF( le.Input_agency_code = (TYPEOF(le.Input_agency_code))'','',':agency_code')
    #END
+    #IF( #TEXT(Input_public_property_employee)='' )
      '' 
    #ELSE
        IF( le.Input_public_property_employee = (TYPEOF(le.Input_public_property_employee))'','',':public_property_employee')
    #END
+    #IF( #TEXT(Input_bridge_related)='' )
      '' 
    #ELSE
        IF( le.Input_bridge_related = (TYPEOF(le.Input_bridge_related))'','',':bridge_related')
    #END
+    #IF( #TEXT(Input_ramp_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_ramp_indicator = (TYPEOF(le.Input_ramp_indicator))'','',':ramp_indicator')
    #END
+    #IF( #TEXT(Input_to_or_from_location)='' )
      '' 
    #ELSE
        IF( le.Input_to_or_from_location = (TYPEOF(le.Input_to_or_from_location))'','',':to_or_from_location')
    #END
+    #IF( #TEXT(Input_complaint_number)='' )
      '' 
    #ELSE
        IF( le.Input_complaint_number = (TYPEOF(le.Input_complaint_number))'','',':complaint_number')
    #END
+    #IF( #TEXT(Input_school_zone_related)='' )
      '' 
    #ELSE
        IF( le.Input_school_zone_related = (TYPEOF(le.Input_school_zone_related))'','',':school_zone_related')
    #END
+    #IF( #TEXT(Input_notify_dot_maintenance)='' )
      '' 
    #ELSE
        IF( le.Input_notify_dot_maintenance = (TYPEOF(le.Input_notify_dot_maintenance))'','',':notify_dot_maintenance')
    #END
+    #IF( #TEXT(Input_special_location)='' )
      '' 
    #ELSE
        IF( le.Input_special_location = (TYPEOF(le.Input_special_location))'','',':special_location')
    #END
+    #IF( #TEXT(Input_route_segment)='' )
      '' 
    #ELSE
        IF( le.Input_route_segment = (TYPEOF(le.Input_route_segment))'','',':route_segment')
    #END
+    #IF( #TEXT(Input_route_sign)='' )
      '' 
    #ELSE
        IF( le.Input_route_sign = (TYPEOF(le.Input_route_sign))'','',':route_sign')
    #END
+    #IF( #TEXT(Input_route_category_street)='' )
      '' 
    #ELSE
        IF( le.Input_route_category_street = (TYPEOF(le.Input_route_category_street))'','',':route_category_street')
    #END
+    #IF( #TEXT(Input_route_category_cross_street)='' )
      '' 
    #ELSE
        IF( le.Input_route_category_cross_street = (TYPEOF(le.Input_route_category_cross_street))'','',':route_category_cross_street')
    #END
+    #IF( #TEXT(Input_route_category_next_street)='' )
      '' 
    #ELSE
        IF( le.Input_route_category_next_street = (TYPEOF(le.Input_route_category_next_street))'','',':route_category_next_street')
    #END
+    #IF( #TEXT(Input_lane_closed)='' )
      '' 
    #ELSE
        IF( le.Input_lane_closed = (TYPEOF(le.Input_lane_closed))'','',':lane_closed')
    #END
+    #IF( #TEXT(Input_lane_closure_direction)='' )
      '' 
    #ELSE
        IF( le.Input_lane_closure_direction = (TYPEOF(le.Input_lane_closure_direction))'','',':lane_closure_direction')
    #END
+    #IF( #TEXT(Input_lane_direction)='' )
      '' 
    #ELSE
        IF( le.Input_lane_direction = (TYPEOF(le.Input_lane_direction))'','',':lane_direction')
    #END
+    #IF( #TEXT(Input_traffic_detoured)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_detoured = (TYPEOF(le.Input_traffic_detoured))'','',':traffic_detoured')
    #END
+    #IF( #TEXT(Input_time_closed)='' )
      '' 
    #ELSE
        IF( le.Input_time_closed = (TYPEOF(le.Input_time_closed))'','',':time_closed')
    #END
+    #IF( #TEXT(Input_pedestrian_signals)='' )
      '' 
    #ELSE
        IF( le.Input_pedestrian_signals = (TYPEOF(le.Input_pedestrian_signals))'','',':pedestrian_signals')
    #END
+    #IF( #TEXT(Input_work_zone_speed_limit)='' )
      '' 
    #ELSE
        IF( le.Input_work_zone_speed_limit = (TYPEOF(le.Input_work_zone_speed_limit))'','',':work_zone_speed_limit')
    #END
+    #IF( #TEXT(Input_work_zone_shoulder_median)='' )
      '' 
    #ELSE
        IF( le.Input_work_zone_shoulder_median = (TYPEOF(le.Input_work_zone_shoulder_median))'','',':work_zone_shoulder_median')
    #END
+    #IF( #TEXT(Input_work_zone_intermittent_moving)='' )
      '' 
    #ELSE
        IF( le.Input_work_zone_intermittent_moving = (TYPEOF(le.Input_work_zone_intermittent_moving))'','',':work_zone_intermittent_moving')
    #END
+    #IF( #TEXT(Input_work_zone_flagger_control)='' )
      '' 
    #ELSE
        IF( le.Input_work_zone_flagger_control = (TYPEOF(le.Input_work_zone_flagger_control))'','',':work_zone_flagger_control')
    #END
+    #IF( #TEXT(Input_special_work_zone_characteristics)='' )
      '' 
    #ELSE
        IF( le.Input_special_work_zone_characteristics = (TYPEOF(le.Input_special_work_zone_characteristics))'','',':special_work_zone_characteristics')
    #END
+    #IF( #TEXT(Input_lane_number)='' )
      '' 
    #ELSE
        IF( le.Input_lane_number = (TYPEOF(le.Input_lane_number))'','',':lane_number')
    #END
+    #IF( #TEXT(Input_offset_distance_feet)='' )
      '' 
    #ELSE
        IF( le.Input_offset_distance_feet = (TYPEOF(le.Input_offset_distance_feet))'','',':offset_distance_feet')
    #END
+    #IF( #TEXT(Input_offset_distance_miles)='' )
      '' 
    #ELSE
        IF( le.Input_offset_distance_miles = (TYPEOF(le.Input_offset_distance_miles))'','',':offset_distance_miles')
    #END
+    #IF( #TEXT(Input_offset_direction)='' )
      '' 
    #ELSE
        IF( le.Input_offset_direction = (TYPEOF(le.Input_offset_direction))'','',':offset_direction')
    #END
+    #IF( #TEXT(Input_asru_code)='' )
      '' 
    #ELSE
        IF( le.Input_asru_code = (TYPEOF(le.Input_asru_code))'','',':asru_code')
    #END
+    #IF( #TEXT(Input_mp_grid)='' )
      '' 
    #ELSE
        IF( le.Input_mp_grid = (TYPEOF(le.Input_mp_grid))'','',':mp_grid')
    #END
+    #IF( #TEXT(Input_number_of_qualifying_units)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_qualifying_units = (TYPEOF(le.Input_number_of_qualifying_units))'','',':number_of_qualifying_units')
    #END
+    #IF( #TEXT(Input_number_of_hazmat_vehicles)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_hazmat_vehicles = (TYPEOF(le.Input_number_of_hazmat_vehicles))'','',':number_of_hazmat_vehicles')
    #END
+    #IF( #TEXT(Input_number_of_buses_involved)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_buses_involved = (TYPEOF(le.Input_number_of_buses_involved))'','',':number_of_buses_involved')
    #END
+    #IF( #TEXT(Input_number_taken_to_treatment)='' )
      '' 
    #ELSE
        IF( le.Input_number_taken_to_treatment = (TYPEOF(le.Input_number_taken_to_treatment))'','',':number_taken_to_treatment')
    #END
+    #IF( #TEXT(Input_number_vehicles_towed)='' )
      '' 
    #ELSE
        IF( le.Input_number_vehicles_towed = (TYPEOF(le.Input_number_vehicles_towed))'','',':number_vehicles_towed')
    #END
+    #IF( #TEXT(Input_vehicle_at_fault_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_at_fault_unit_number = (TYPEOF(le.Input_vehicle_at_fault_unit_number))'','',':vehicle_at_fault_unit_number')
    #END
+    #IF( #TEXT(Input_time_officer_cleared_scene)='' )
      '' 
    #ELSE
        IF( le.Input_time_officer_cleared_scene = (TYPEOF(le.Input_time_officer_cleared_scene))'','',':time_officer_cleared_scene')
    #END
+    #IF( #TEXT(Input_total_minutes_on_scene)='' )
      '' 
    #ELSE
        IF( le.Input_total_minutes_on_scene = (TYPEOF(le.Input_total_minutes_on_scene))'','',':total_minutes_on_scene')
    #END
+    #IF( #TEXT(Input_motorists_report)='' )
      '' 
    #ELSE
        IF( le.Input_motorists_report = (TYPEOF(le.Input_motorists_report))'','',':motorists_report')
    #END
+    #IF( #TEXT(Input_fatality_involved)='' )
      '' 
    #ELSE
        IF( le.Input_fatality_involved = (TYPEOF(le.Input_fatality_involved))'','',':fatality_involved')
    #END
+    #IF( #TEXT(Input_local_dot_index_number)='' )
      '' 
    #ELSE
        IF( le.Input_local_dot_index_number = (TYPEOF(le.Input_local_dot_index_number))'','',':local_dot_index_number')
    #END
+    #IF( #TEXT(Input_dor_number)='' )
      '' 
    #ELSE
        IF( le.Input_dor_number = (TYPEOF(le.Input_dor_number))'','',':dor_number')
    #END
+    #IF( #TEXT(Input_hospital_code)='' )
      '' 
    #ELSE
        IF( le.Input_hospital_code = (TYPEOF(le.Input_hospital_code))'','',':hospital_code')
    #END
+    #IF( #TEXT(Input_special_jurisdiction)='' )
      '' 
    #ELSE
        IF( le.Input_special_jurisdiction = (TYPEOF(le.Input_special_jurisdiction))'','',':special_jurisdiction')
    #END
+    #IF( #TEXT(Input_document_type)='' )
      '' 
    #ELSE
        IF( le.Input_document_type = (TYPEOF(le.Input_document_type))'','',':document_type')
    #END
+    #IF( #TEXT(Input_distance_was_measured)='' )
      '' 
    #ELSE
        IF( le.Input_distance_was_measured = (TYPEOF(le.Input_distance_was_measured))'','',':distance_was_measured')
    #END
+    #IF( #TEXT(Input_street_orientation)='' )
      '' 
    #ELSE
        IF( le.Input_street_orientation = (TYPEOF(le.Input_street_orientation))'','',':street_orientation')
    #END
+    #IF( #TEXT(Input_intersecting_route_segment)='' )
      '' 
    #ELSE
        IF( le.Input_intersecting_route_segment = (TYPEOF(le.Input_intersecting_route_segment))'','',':intersecting_route_segment')
    #END
+    #IF( #TEXT(Input_primary_fault_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_primary_fault_indicator = (TYPEOF(le.Input_primary_fault_indicator))'','',':primary_fault_indicator')
    #END
+    #IF( #TEXT(Input_first_harmful_event_pedestrian)='' )
      '' 
    #ELSE
        IF( le.Input_first_harmful_event_pedestrian = (TYPEOF(le.Input_first_harmful_event_pedestrian))'','',':first_harmful_event_pedestrian')
    #END
+    #IF( #TEXT(Input_reference_markers)='' )
      '' 
    #ELSE
        IF( le.Input_reference_markers = (TYPEOF(le.Input_reference_markers))'','',':reference_markers')
    #END
+    #IF( #TEXT(Input_other_officer_on_scene)='' )
      '' 
    #ELSE
        IF( le.Input_other_officer_on_scene = (TYPEOF(le.Input_other_officer_on_scene))'','',':other_officer_on_scene')
    #END
+    #IF( #TEXT(Input_other_officer_badge_number)='' )
      '' 
    #ELSE
        IF( le.Input_other_officer_badge_number = (TYPEOF(le.Input_other_officer_badge_number))'','',':other_officer_badge_number')
    #END
+    #IF( #TEXT(Input_supplemental_report)='' )
      '' 
    #ELSE
        IF( le.Input_supplemental_report = (TYPEOF(le.Input_supplemental_report))'','',':supplemental_report')
    #END
+    #IF( #TEXT(Input_supplemental_type)='' )
      '' 
    #ELSE
        IF( le.Input_supplemental_type = (TYPEOF(le.Input_supplemental_type))'','',':supplemental_type')
    #END
+    #IF( #TEXT(Input_amended_report)='' )
      '' 
    #ELSE
        IF( le.Input_amended_report = (TYPEOF(le.Input_amended_report))'','',':amended_report')
    #END
+    #IF( #TEXT(Input_corrected_report)='' )
      '' 
    #ELSE
        IF( le.Input_corrected_report = (TYPEOF(le.Input_corrected_report))'','',':corrected_report')
    #END
+    #IF( #TEXT(Input_state_highway_related)='' )
      '' 
    #ELSE
        IF( le.Input_state_highway_related = (TYPEOF(le.Input_state_highway_related))'','',':state_highway_related')
    #END
+    #IF( #TEXT(Input_roadway_lighting_condition)='' )
      '' 
    #ELSE
        IF( le.Input_roadway_lighting_condition = (TYPEOF(le.Input_roadway_lighting_condition))'','',':roadway_lighting_condition')
    #END
+    #IF( #TEXT(Input_vendor_reference_number)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_reference_number = (TYPEOF(le.Input_vendor_reference_number))'','',':vendor_reference_number')
    #END
+    #IF( #TEXT(Input_duplicate_copy_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_duplicate_copy_unit_number = (TYPEOF(le.Input_duplicate_copy_unit_number))'','',':duplicate_copy_unit_number')
    #END
+    #IF( #TEXT(Input_other_city_agency_description)='' )
      '' 
    #ELSE
        IF( le.Input_other_city_agency_description = (TYPEOF(le.Input_other_city_agency_description))'','',':other_city_agency_description')
    #END
+    #IF( #TEXT(Input_notifcation_description)='' )
      '' 
    #ELSE
        IF( le.Input_notifcation_description = (TYPEOF(le.Input_notifcation_description))'','',':notifcation_description')
    #END
+    #IF( #TEXT(Input_primary_collision_improper_driving_description)='' )
      '' 
    #ELSE
        IF( le.Input_primary_collision_improper_driving_description = (TYPEOF(le.Input_primary_collision_improper_driving_description))'','',':primary_collision_improper_driving_description')
    #END
+    #IF( #TEXT(Input_weather_other_description)='' )
      '' 
    #ELSE
        IF( le.Input_weather_other_description = (TYPEOF(le.Input_weather_other_description))'','',':weather_other_description')
    #END
+    #IF( #TEXT(Input_crash_type_description)='' )
      '' 
    #ELSE
        IF( le.Input_crash_type_description = (TYPEOF(le.Input_crash_type_description))'','',':crash_type_description')
    #END
+    #IF( #TEXT(Input_motor_vehicle_involved_with_animal_description)='' )
      '' 
    #ELSE
        IF( le.Input_motor_vehicle_involved_with_animal_description = (TYPEOF(le.Input_motor_vehicle_involved_with_animal_description))'','',':motor_vehicle_involved_with_animal_description')
    #END
+    #IF( #TEXT(Input_motor_vehicle_involved_with_fixed_object_description)='' )
      '' 
    #ELSE
        IF( le.Input_motor_vehicle_involved_with_fixed_object_description = (TYPEOF(le.Input_motor_vehicle_involved_with_fixed_object_description))'','',':motor_vehicle_involved_with_fixed_object_description')
    #END
+    #IF( #TEXT(Input_motor_vehicle_involved_with_other_object_description)='' )
      '' 
    #ELSE
        IF( le.Input_motor_vehicle_involved_with_other_object_description = (TYPEOF(le.Input_motor_vehicle_involved_with_other_object_description))'','',':motor_vehicle_involved_with_other_object_description')
    #END
+    #IF( #TEXT(Input_other_investigation_time)='' )
      '' 
    #ELSE
        IF( le.Input_other_investigation_time = (TYPEOF(le.Input_other_investigation_time))'','',':other_investigation_time')
    #END
+    #IF( #TEXT(Input_milepost_detail)='' )
      '' 
    #ELSE
        IF( le.Input_milepost_detail = (TYPEOF(le.Input_milepost_detail))'','',':milepost_detail')
    #END
+    #IF( #TEXT(Input_utility_pole_number1)='' )
      '' 
    #ELSE
        IF( le.Input_utility_pole_number1 = (TYPEOF(le.Input_utility_pole_number1))'','',':utility_pole_number1')
    #END
+    #IF( #TEXT(Input_utility_pole_number2)='' )
      '' 
    #ELSE
        IF( le.Input_utility_pole_number2 = (TYPEOF(le.Input_utility_pole_number2))'','',':utility_pole_number2')
    #END
+    #IF( #TEXT(Input_utility_pole_number3)='' )
      '' 
    #ELSE
        IF( le.Input_utility_pole_number3 = (TYPEOF(le.Input_utility_pole_number3))'','',':utility_pole_number3')
    #END
+    #IF( #TEXT(Input_person_id)='' )
      '' 
    #ELSE
        IF( le.Input_person_id = (TYPEOF(le.Input_person_id))'','',':person_id')
    #END
+    #IF( #TEXT(Input_person_number)='' )
      '' 
    #ELSE
        IF( le.Input_person_number = (TYPEOF(le.Input_person_number))'','',':person_number')
    #END
+    #IF( #TEXT(Input_vehicle_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_unit_number = (TYPEOF(le.Input_vehicle_unit_number))'','',':vehicle_unit_number')
    #END
+    #IF( #TEXT(Input_sex)='' )
      '' 
    #ELSE
        IF( le.Input_sex = (TYPEOF(le.Input_sex))'','',':sex')
    #END
+    #IF( #TEXT(Input_person_type)='' )
      '' 
    #ELSE
        IF( le.Input_person_type = (TYPEOF(le.Input_person_type))'','',':person_type')
    #END
+    #IF( #TEXT(Input_injury_status)='' )
      '' 
    #ELSE
        IF( le.Input_injury_status = (TYPEOF(le.Input_injury_status))'','',':injury_status')
    #END
+    #IF( #TEXT(Input_occupant_vehicle_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_occupant_vehicle_unit_number = (TYPEOF(le.Input_occupant_vehicle_unit_number))'','',':occupant_vehicle_unit_number')
    #END
+    #IF( #TEXT(Input_seating_position1)='' )
      '' 
    #ELSE
        IF( le.Input_seating_position1 = (TYPEOF(le.Input_seating_position1))'','',':seating_position1')
    #END
+    #IF( #TEXT(Input_safety_equipment_restraint1)='' )
      '' 
    #ELSE
        IF( le.Input_safety_equipment_restraint1 = (TYPEOF(le.Input_safety_equipment_restraint1))'','',':safety_equipment_restraint1')
    #END
+    #IF( #TEXT(Input_safety_equipment_restraint2)='' )
      '' 
    #ELSE
        IF( le.Input_safety_equipment_restraint2 = (TYPEOF(le.Input_safety_equipment_restraint2))'','',':safety_equipment_restraint2')
    #END
+    #IF( #TEXT(Input_safety_equipment_helmet)='' )
      '' 
    #ELSE
        IF( le.Input_safety_equipment_helmet = (TYPEOF(le.Input_safety_equipment_helmet))'','',':safety_equipment_helmet')
    #END
+    #IF( #TEXT(Input_air_bag_deployed)='' )
      '' 
    #ELSE
        IF( le.Input_air_bag_deployed = (TYPEOF(le.Input_air_bag_deployed))'','',':air_bag_deployed')
    #END
+    #IF( #TEXT(Input_ejection)='' )
      '' 
    #ELSE
        IF( le.Input_ejection = (TYPEOF(le.Input_ejection))'','',':ejection')
    #END
+    #IF( #TEXT(Input_drivers_license_jurisdiction)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license_jurisdiction = (TYPEOF(le.Input_drivers_license_jurisdiction))'','',':drivers_license_jurisdiction')
    #END
+    #IF( #TEXT(Input_dl_number_class)='' )
      '' 
    #ELSE
        IF( le.Input_dl_number_class = (TYPEOF(le.Input_dl_number_class))'','',':dl_number_class')
    #END
+    #IF( #TEXT(Input_dl_number_cdl)='' )
      '' 
    #ELSE
        IF( le.Input_dl_number_cdl = (TYPEOF(le.Input_dl_number_cdl))'','',':dl_number_cdl')
    #END
+    #IF( #TEXT(Input_dl_number_endorsements)='' )
      '' 
    #ELSE
        IF( le.Input_dl_number_endorsements = (TYPEOF(le.Input_dl_number_endorsements))'','',':dl_number_endorsements')
    #END
+    #IF( #TEXT(Input_driver_actions_at_time_of_crash1)='' )
      '' 
    #ELSE
        IF( le.Input_driver_actions_at_time_of_crash1 = (TYPEOF(le.Input_driver_actions_at_time_of_crash1))'','',':driver_actions_at_time_of_crash1')
    #END
+    #IF( #TEXT(Input_driver_actions_at_time_of_crash2)='' )
      '' 
    #ELSE
        IF( le.Input_driver_actions_at_time_of_crash2 = (TYPEOF(le.Input_driver_actions_at_time_of_crash2))'','',':driver_actions_at_time_of_crash2')
    #END
+    #IF( #TEXT(Input_driver_actions_at_time_of_crash3)='' )
      '' 
    #ELSE
        IF( le.Input_driver_actions_at_time_of_crash3 = (TYPEOF(le.Input_driver_actions_at_time_of_crash3))'','',':driver_actions_at_time_of_crash3')
    #END
+    #IF( #TEXT(Input_driver_actions_at_time_of_crash4)='' )
      '' 
    #ELSE
        IF( le.Input_driver_actions_at_time_of_crash4 = (TYPEOF(le.Input_driver_actions_at_time_of_crash4))'','',':driver_actions_at_time_of_crash4')
    #END
+    #IF( #TEXT(Input_violation_codes)='' )
      '' 
    #ELSE
        IF( le.Input_violation_codes = (TYPEOF(le.Input_violation_codes))'','',':violation_codes')
    #END
+    #IF( #TEXT(Input_condition_at_time_of_crash1)='' )
      '' 
    #ELSE
        IF( le.Input_condition_at_time_of_crash1 = (TYPEOF(le.Input_condition_at_time_of_crash1))'','',':condition_at_time_of_crash1')
    #END
+    #IF( #TEXT(Input_condition_at_time_of_crash2)='' )
      '' 
    #ELSE
        IF( le.Input_condition_at_time_of_crash2 = (TYPEOF(le.Input_condition_at_time_of_crash2))'','',':condition_at_time_of_crash2')
    #END
+    #IF( #TEXT(Input_law_enforcement_suspects_alcohol_use)='' )
      '' 
    #ELSE
        IF( le.Input_law_enforcement_suspects_alcohol_use = (TYPEOF(le.Input_law_enforcement_suspects_alcohol_use))'','',':law_enforcement_suspects_alcohol_use')
    #END
+    #IF( #TEXT(Input_alcohol_test_status)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_test_status = (TYPEOF(le.Input_alcohol_test_status))'','',':alcohol_test_status')
    #END
+    #IF( #TEXT(Input_alcohol_test_type)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_test_type = (TYPEOF(le.Input_alcohol_test_type))'','',':alcohol_test_type')
    #END
+    #IF( #TEXT(Input_alcohol_test_result)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_test_result = (TYPEOF(le.Input_alcohol_test_result))'','',':alcohol_test_result')
    #END
+    #IF( #TEXT(Input_law_enforcement_suspects_drug_use)='' )
      '' 
    #ELSE
        IF( le.Input_law_enforcement_suspects_drug_use = (TYPEOF(le.Input_law_enforcement_suspects_drug_use))'','',':law_enforcement_suspects_drug_use')
    #END
+    #IF( #TEXT(Input_drug_test_given)='' )
      '' 
    #ELSE
        IF( le.Input_drug_test_given = (TYPEOF(le.Input_drug_test_given))'','',':drug_test_given')
    #END
+    #IF( #TEXT(Input_non_motorist_actions_prior_to_crash1)='' )
      '' 
    #ELSE
        IF( le.Input_non_motorist_actions_prior_to_crash1 = (TYPEOF(le.Input_non_motorist_actions_prior_to_crash1))'','',':non_motorist_actions_prior_to_crash1')
    #END
+    #IF( #TEXT(Input_non_motorist_actions_prior_to_crash2)='' )
      '' 
    #ELSE
        IF( le.Input_non_motorist_actions_prior_to_crash2 = (TYPEOF(le.Input_non_motorist_actions_prior_to_crash2))'','',':non_motorist_actions_prior_to_crash2')
    #END
+    #IF( #TEXT(Input_non_motorist_actions_at_time_of_crash)='' )
      '' 
    #ELSE
        IF( le.Input_non_motorist_actions_at_time_of_crash = (TYPEOF(le.Input_non_motorist_actions_at_time_of_crash))'','',':non_motorist_actions_at_time_of_crash')
    #END
+    #IF( #TEXT(Input_non_motorist_location_at_time_of_crash)='' )
      '' 
    #ELSE
        IF( le.Input_non_motorist_location_at_time_of_crash = (TYPEOF(le.Input_non_motorist_location_at_time_of_crash))'','',':non_motorist_location_at_time_of_crash')
    #END
+    #IF( #TEXT(Input_non_motorist_safety_equipment1)='' )
      '' 
    #ELSE
        IF( le.Input_non_motorist_safety_equipment1 = (TYPEOF(le.Input_non_motorist_safety_equipment1))'','',':non_motorist_safety_equipment1')
    #END
+    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
    #END
+    #IF( #TEXT(Input_driver_license_restrictions1)='' )
      '' 
    #ELSE
        IF( le.Input_driver_license_restrictions1 = (TYPEOF(le.Input_driver_license_restrictions1))'','',':driver_license_restrictions1')
    #END
+    #IF( #TEXT(Input_drug_test_type)='' )
      '' 
    #ELSE
        IF( le.Input_drug_test_type = (TYPEOF(le.Input_drug_test_type))'','',':drug_test_type')
    #END
+    #IF( #TEXT(Input_drug_test_result1)='' )
      '' 
    #ELSE
        IF( le.Input_drug_test_result1 = (TYPEOF(le.Input_drug_test_result1))'','',':drug_test_result1')
    #END
+    #IF( #TEXT(Input_drug_test_result2)='' )
      '' 
    #ELSE
        IF( le.Input_drug_test_result2 = (TYPEOF(le.Input_drug_test_result2))'','',':drug_test_result2')
    #END
+    #IF( #TEXT(Input_drug_test_result3)='' )
      '' 
    #ELSE
        IF( le.Input_drug_test_result3 = (TYPEOF(le.Input_drug_test_result3))'','',':drug_test_result3')
    #END
+    #IF( #TEXT(Input_drug_test_result4)='' )
      '' 
    #ELSE
        IF( le.Input_drug_test_result4 = (TYPEOF(le.Input_drug_test_result4))'','',':drug_test_result4')
    #END
+    #IF( #TEXT(Input_injury_area)='' )
      '' 
    #ELSE
        IF( le.Input_injury_area = (TYPEOF(le.Input_injury_area))'','',':injury_area')
    #END
+    #IF( #TEXT(Input_injury_description)='' )
      '' 
    #ELSE
        IF( le.Input_injury_description = (TYPEOF(le.Input_injury_description))'','',':injury_description')
    #END
+    #IF( #TEXT(Input_motorcyclist_head_injury)='' )
      '' 
    #ELSE
        IF( le.Input_motorcyclist_head_injury = (TYPEOF(le.Input_motorcyclist_head_injury))'','',':motorcyclist_head_injury')
    #END
+    #IF( #TEXT(Input_party_id)='' )
      '' 
    #ELSE
        IF( le.Input_party_id = (TYPEOF(le.Input_party_id))'','',':party_id')
    #END
+    #IF( #TEXT(Input_same_as_driver)='' )
      '' 
    #ELSE
        IF( le.Input_same_as_driver = (TYPEOF(le.Input_same_as_driver))'','',':same_as_driver')
    #END
+    #IF( #TEXT(Input_address_same_as_driver)='' )
      '' 
    #ELSE
        IF( le.Input_address_same_as_driver = (TYPEOF(le.Input_address_same_as_driver))'','',':address_same_as_driver')
    #END
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
+    #IF( #TEXT(Input_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_middle_name = (TYPEOF(le.Input_middle_name))'','',':middle_name')
    #END
+    #IF( #TEXT(Input_name_suffx)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffx = (TYPEOF(le.Input_name_suffx))'','',':name_suffx')
    #END
+    #IF( #TEXT(Input_date_of_birth)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_birth = (TYPEOF(le.Input_date_of_birth))'','',':date_of_birth')
    #END
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
+    #IF( #TEXT(Input_home_phone)='' )
      '' 
    #ELSE
        IF( le.Input_home_phone = (TYPEOF(le.Input_home_phone))'','',':home_phone')
    #END
+    #IF( #TEXT(Input_business_phone)='' )
      '' 
    #ELSE
        IF( le.Input_business_phone = (TYPEOF(le.Input_business_phone))'','',':business_phone')
    #END
+    #IF( #TEXT(Input_insurance_company)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_company = (TYPEOF(le.Input_insurance_company))'','',':insurance_company')
    #END
+    #IF( #TEXT(Input_insurance_company_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_company_phone_number = (TYPEOF(le.Input_insurance_company_phone_number))'','',':insurance_company_phone_number')
    #END
+    #IF( #TEXT(Input_insurance_policy_number)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_policy_number = (TYPEOF(le.Input_insurance_policy_number))'','',':insurance_policy_number')
    #END
+    #IF( #TEXT(Input_insurance_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_effective_date = (TYPEOF(le.Input_insurance_effective_date))'','',':insurance_effective_date')
    #END
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
+    #IF( #TEXT(Input_drivers_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license_number = (TYPEOF(le.Input_drivers_license_number))'','',':drivers_license_number')
    #END
+    #IF( #TEXT(Input_drivers_license_expiration)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license_expiration = (TYPEOF(le.Input_drivers_license_expiration))'','',':drivers_license_expiration')
    #END
+    #IF( #TEXT(Input_eye_color)='' )
      '' 
    #ELSE
        IF( le.Input_eye_color = (TYPEOF(le.Input_eye_color))'','',':eye_color')
    #END
+    #IF( #TEXT(Input_hair_color)='' )
      '' 
    #ELSE
        IF( le.Input_hair_color = (TYPEOF(le.Input_hair_color))'','',':hair_color')
    #END
+    #IF( #TEXT(Input_height)='' )
      '' 
    #ELSE
        IF( le.Input_height = (TYPEOF(le.Input_height))'','',':height')
    #END
+    #IF( #TEXT(Input_weight)='' )
      '' 
    #ELSE
        IF( le.Input_weight = (TYPEOF(le.Input_weight))'','',':weight')
    #END
+    #IF( #TEXT(Input_race)='' )
      '' 
    #ELSE
        IF( le.Input_race = (TYPEOF(le.Input_race))'','',':race')
    #END
+    #IF( #TEXT(Input_pedestrian_cyclist_visibility)='' )
      '' 
    #ELSE
        IF( le.Input_pedestrian_cyclist_visibility = (TYPEOF(le.Input_pedestrian_cyclist_visibility))'','',':pedestrian_cyclist_visibility')
    #END
+    #IF( #TEXT(Input_first_aid_by)='' )
      '' 
    #ELSE
        IF( le.Input_first_aid_by = (TYPEOF(le.Input_first_aid_by))'','',':first_aid_by')
    #END
+    #IF( #TEXT(Input_person_first_aid_party_type)='' )
      '' 
    #ELSE
        IF( le.Input_person_first_aid_party_type = (TYPEOF(le.Input_person_first_aid_party_type))'','',':person_first_aid_party_type')
    #END
+    #IF( #TEXT(Input_person_first_aid_party_type_description)='' )
      '' 
    #ELSE
        IF( le.Input_person_first_aid_party_type_description = (TYPEOF(le.Input_person_first_aid_party_type_description))'','',':person_first_aid_party_type_description')
    #END
+    #IF( #TEXT(Input_deceased_at_scene)='' )
      '' 
    #ELSE
        IF( le.Input_deceased_at_scene = (TYPEOF(le.Input_deceased_at_scene))'','',':deceased_at_scene')
    #END
+    #IF( #TEXT(Input_death_date)='' )
      '' 
    #ELSE
        IF( le.Input_death_date = (TYPEOF(le.Input_death_date))'','',':death_date')
    #END
+    #IF( #TEXT(Input_death_time)='' )
      '' 
    #ELSE
        IF( le.Input_death_time = (TYPEOF(le.Input_death_time))'','',':death_time')
    #END
+    #IF( #TEXT(Input_extricated)='' )
      '' 
    #ELSE
        IF( le.Input_extricated = (TYPEOF(le.Input_extricated))'','',':extricated')
    #END
+    #IF( #TEXT(Input_alcohol_drug_use)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_drug_use = (TYPEOF(le.Input_alcohol_drug_use))'','',':alcohol_drug_use')
    #END
+    #IF( #TEXT(Input_physical_defects)='' )
      '' 
    #ELSE
        IF( le.Input_physical_defects = (TYPEOF(le.Input_physical_defects))'','',':physical_defects')
    #END
+    #IF( #TEXT(Input_driver_residence)='' )
      '' 
    #ELSE
        IF( le.Input_driver_residence = (TYPEOF(le.Input_driver_residence))'','',':driver_residence')
    #END
+    #IF( #TEXT(Input_id_type)='' )
      '' 
    #ELSE
        IF( le.Input_id_type = (TYPEOF(le.Input_id_type))'','',':id_type')
    #END
+    #IF( #TEXT(Input_proof_of_insurance)='' )
      '' 
    #ELSE
        IF( le.Input_proof_of_insurance = (TYPEOF(le.Input_proof_of_insurance))'','',':proof_of_insurance')
    #END
+    #IF( #TEXT(Input_insurance_expired)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_expired = (TYPEOF(le.Input_insurance_expired))'','',':insurance_expired')
    #END
+    #IF( #TEXT(Input_insurance_exempt)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_exempt = (TYPEOF(le.Input_insurance_exempt))'','',':insurance_exempt')
    #END
+    #IF( #TEXT(Input_insurance_type)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_type = (TYPEOF(le.Input_insurance_type))'','',':insurance_type')
    #END
+    #IF( #TEXT(Input_violent_crime_victim_notified)='' )
      '' 
    #ELSE
        IF( le.Input_violent_crime_victim_notified = (TYPEOF(le.Input_violent_crime_victim_notified))'','',':violent_crime_victim_notified')
    #END
+    #IF( #TEXT(Input_insurance_company_code)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_company_code = (TYPEOF(le.Input_insurance_company_code))'','',':insurance_company_code')
    #END
+    #IF( #TEXT(Input_refused_medical_treatment)='' )
      '' 
    #ELSE
        IF( le.Input_refused_medical_treatment = (TYPEOF(le.Input_refused_medical_treatment))'','',':refused_medical_treatment')
    #END
+    #IF( #TEXT(Input_safety_equipment_available_or_used)='' )
      '' 
    #ELSE
        IF( le.Input_safety_equipment_available_or_used = (TYPEOF(le.Input_safety_equipment_available_or_used))'','',':safety_equipment_available_or_used')
    #END
+    #IF( #TEXT(Input_apartment_number)='' )
      '' 
    #ELSE
        IF( le.Input_apartment_number = (TYPEOF(le.Input_apartment_number))'','',':apartment_number')
    #END
+    #IF( #TEXT(Input_licensed_driver)='' )
      '' 
    #ELSE
        IF( le.Input_licensed_driver = (TYPEOF(le.Input_licensed_driver))'','',':licensed_driver')
    #END
+    #IF( #TEXT(Input_physical_emotional_status)='' )
      '' 
    #ELSE
        IF( le.Input_physical_emotional_status = (TYPEOF(le.Input_physical_emotional_status))'','',':physical_emotional_status')
    #END
+    #IF( #TEXT(Input_driver_presence)='' )
      '' 
    #ELSE
        IF( le.Input_driver_presence = (TYPEOF(le.Input_driver_presence))'','',':driver_presence')
    #END
+    #IF( #TEXT(Input_ejection_path)='' )
      '' 
    #ELSE
        IF( le.Input_ejection_path = (TYPEOF(le.Input_ejection_path))'','',':ejection_path')
    #END
+    #IF( #TEXT(Input_state_person_id)='' )
      '' 
    #ELSE
        IF( le.Input_state_person_id = (TYPEOF(le.Input_state_person_id))'','',':state_person_id')
    #END
+    #IF( #TEXT(Input_contributed_to_collision)='' )
      '' 
    #ELSE
        IF( le.Input_contributed_to_collision = (TYPEOF(le.Input_contributed_to_collision))'','',':contributed_to_collision')
    #END
+    #IF( #TEXT(Input_person_transported_for_medical_care)='' )
      '' 
    #ELSE
        IF( le.Input_person_transported_for_medical_care = (TYPEOF(le.Input_person_transported_for_medical_care))'','',':person_transported_for_medical_care')
    #END
+    #IF( #TEXT(Input_transported_by_agency_type)='' )
      '' 
    #ELSE
        IF( le.Input_transported_by_agency_type = (TYPEOF(le.Input_transported_by_agency_type))'','',':transported_by_agency_type')
    #END
+    #IF( #TEXT(Input_transported_to)='' )
      '' 
    #ELSE
        IF( le.Input_transported_to = (TYPEOF(le.Input_transported_to))'','',':transported_to')
    #END
+    #IF( #TEXT(Input_non_motorist_driver_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_non_motorist_driver_license_number = (TYPEOF(le.Input_non_motorist_driver_license_number))'','',':non_motorist_driver_license_number')
    #END
+    #IF( #TEXT(Input_air_bag_type)='' )
      '' 
    #ELSE
        IF( le.Input_air_bag_type = (TYPEOF(le.Input_air_bag_type))'','',':air_bag_type')
    #END
+    #IF( #TEXT(Input_cell_phone_use)='' )
      '' 
    #ELSE
        IF( le.Input_cell_phone_use = (TYPEOF(le.Input_cell_phone_use))'','',':cell_phone_use')
    #END
+    #IF( #TEXT(Input_driver_license_restriction_compliance)='' )
      '' 
    #ELSE
        IF( le.Input_driver_license_restriction_compliance = (TYPEOF(le.Input_driver_license_restriction_compliance))'','',':driver_license_restriction_compliance')
    #END
+    #IF( #TEXT(Input_driver_license_endorsement_compliance)='' )
      '' 
    #ELSE
        IF( le.Input_driver_license_endorsement_compliance = (TYPEOF(le.Input_driver_license_endorsement_compliance))'','',':driver_license_endorsement_compliance')
    #END
+    #IF( #TEXT(Input_driver_license_compliance)='' )
      '' 
    #ELSE
        IF( le.Input_driver_license_compliance = (TYPEOF(le.Input_driver_license_compliance))'','',':driver_license_compliance')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_p1)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_p1 = (TYPEOF(le.Input_contributing_circumstances_p1))'','',':contributing_circumstances_p1')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_p2)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_p2 = (TYPEOF(le.Input_contributing_circumstances_p2))'','',':contributing_circumstances_p2')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_p3)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_p3 = (TYPEOF(le.Input_contributing_circumstances_p3))'','',':contributing_circumstances_p3')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_p4)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_p4 = (TYPEOF(le.Input_contributing_circumstances_p4))'','',':contributing_circumstances_p4')
    #END
+    #IF( #TEXT(Input_passenger_number)='' )
      '' 
    #ELSE
        IF( le.Input_passenger_number = (TYPEOF(le.Input_passenger_number))'','',':passenger_number')
    #END
+    #IF( #TEXT(Input_person_deleted)='' )
      '' 
    #ELSE
        IF( le.Input_person_deleted = (TYPEOF(le.Input_person_deleted))'','',':person_deleted')
    #END
+    #IF( #TEXT(Input_owner_lessee)='' )
      '' 
    #ELSE
        IF( le.Input_owner_lessee = (TYPEOF(le.Input_owner_lessee))'','',':owner_lessee')
    #END
+    #IF( #TEXT(Input_driver_charged)='' )
      '' 
    #ELSE
        IF( le.Input_driver_charged = (TYPEOF(le.Input_driver_charged))'','',':driver_charged')
    #END
+    #IF( #TEXT(Input_motorcycle_eye_protection)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_eye_protection = (TYPEOF(le.Input_motorcycle_eye_protection))'','',':motorcycle_eye_protection')
    #END
+    #IF( #TEXT(Input_motorcycle_long_sleeves)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_long_sleeves = (TYPEOF(le.Input_motorcycle_long_sleeves))'','',':motorcycle_long_sleeves')
    #END
+    #IF( #TEXT(Input_motorcycle_long_pants)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_long_pants = (TYPEOF(le.Input_motorcycle_long_pants))'','',':motorcycle_long_pants')
    #END
+    #IF( #TEXT(Input_motorcycle_over_ankle_boots)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_over_ankle_boots = (TYPEOF(le.Input_motorcycle_over_ankle_boots))'','',':motorcycle_over_ankle_boots')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_environmental_non_incident1)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_environmental_non_incident1 = (TYPEOF(le.Input_contributing_circumstances_environmental_non_incident1))'','',':contributing_circumstances_environmental_non_incident1')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_environmental_non_incident2)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_environmental_non_incident2 = (TYPEOF(le.Input_contributing_circumstances_environmental_non_incident2))'','',':contributing_circumstances_environmental_non_incident2')
    #END
+    #IF( #TEXT(Input_alcohol_drug_test_given)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_drug_test_given = (TYPEOF(le.Input_alcohol_drug_test_given))'','',':alcohol_drug_test_given')
    #END
+    #IF( #TEXT(Input_alcohol_drug_test_type)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_drug_test_type = (TYPEOF(le.Input_alcohol_drug_test_type))'','',':alcohol_drug_test_type')
    #END
+    #IF( #TEXT(Input_alcohol_drug_test_result)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_drug_test_result = (TYPEOF(le.Input_alcohol_drug_test_result))'','',':alcohol_drug_test_result')
    #END
+    #IF( #TEXT(Input_vin)='' )
      '' 
    #ELSE
        IF( le.Input_vin = (TYPEOF(le.Input_vin))'','',':vin')
    #END
+    #IF( #TEXT(Input_vin_status)='' )
      '' 
    #ELSE
        IF( le.Input_vin_status = (TYPEOF(le.Input_vin_status))'','',':vin_status')
    #END
+    #IF( #TEXT(Input_damaged_areas_derived1)='' )
      '' 
    #ELSE
        IF( le.Input_damaged_areas_derived1 = (TYPEOF(le.Input_damaged_areas_derived1))'','',':damaged_areas_derived1')
    #END
+    #IF( #TEXT(Input_damaged_areas_derived2)='' )
      '' 
    #ELSE
        IF( le.Input_damaged_areas_derived2 = (TYPEOF(le.Input_damaged_areas_derived2))'','',':damaged_areas_derived2')
    #END
+    #IF( #TEXT(Input_airbags_deployed_derived)='' )
      '' 
    #ELSE
        IF( le.Input_airbags_deployed_derived = (TYPEOF(le.Input_airbags_deployed_derived))'','',':airbags_deployed_derived')
    #END
+    #IF( #TEXT(Input_vehicle_towed_derived)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_towed_derived = (TYPEOF(le.Input_vehicle_towed_derived))'','',':vehicle_towed_derived')
    #END
+    #IF( #TEXT(Input_unit_type)='' )
      '' 
    #ELSE
        IF( le.Input_unit_type = (TYPEOF(le.Input_unit_type))'','',':unit_type')
    #END
+    #IF( #TEXT(Input_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_unit_number = (TYPEOF(le.Input_unit_number))'','',':unit_number')
    #END
+    #IF( #TEXT(Input_registration_state)='' )
      '' 
    #ELSE
        IF( le.Input_registration_state = (TYPEOF(le.Input_registration_state))'','',':registration_state')
    #END
+    #IF( #TEXT(Input_registration_year)='' )
      '' 
    #ELSE
        IF( le.Input_registration_year = (TYPEOF(le.Input_registration_year))'','',':registration_year')
    #END
+    #IF( #TEXT(Input_license_plate)='' )
      '' 
    #ELSE
        IF( le.Input_license_plate = (TYPEOF(le.Input_license_plate))'','',':license_plate')
    #END
+    #IF( #TEXT(Input_make)='' )
      '' 
    #ELSE
        IF( le.Input_make = (TYPEOF(le.Input_make))'','',':make')
    #END
+    #IF( #TEXT(Input_model_yr)='' )
      '' 
    #ELSE
        IF( le.Input_model_yr = (TYPEOF(le.Input_model_yr))'','',':model_yr')
    #END
+    #IF( #TEXT(Input_model)='' )
      '' 
    #ELSE
        IF( le.Input_model = (TYPEOF(le.Input_model))'','',':model')
    #END
+    #IF( #TEXT(Input_body_type_category)='' )
      '' 
    #ELSE
        IF( le.Input_body_type_category = (TYPEOF(le.Input_body_type_category))'','',':body_type_category')
    #END
+    #IF( #TEXT(Input_total_occupants_in_vehicle)='' )
      '' 
    #ELSE
        IF( le.Input_total_occupants_in_vehicle = (TYPEOF(le.Input_total_occupants_in_vehicle))'','',':total_occupants_in_vehicle')
    #END
+    #IF( #TEXT(Input_special_function_in_transport)='' )
      '' 
    #ELSE
        IF( le.Input_special_function_in_transport = (TYPEOF(le.Input_special_function_in_transport))'','',':special_function_in_transport')
    #END
+    #IF( #TEXT(Input_special_function_in_transport_other_unit)='' )
      '' 
    #ELSE
        IF( le.Input_special_function_in_transport_other_unit = (TYPEOF(le.Input_special_function_in_transport_other_unit))'','',':special_function_in_transport_other_unit')
    #END
+    #IF( #TEXT(Input_emergency_use)='' )
      '' 
    #ELSE
        IF( le.Input_emergency_use = (TYPEOF(le.Input_emergency_use))'','',':emergency_use')
    #END
+    #IF( #TEXT(Input_posted_satutory_speed_limit)='' )
      '' 
    #ELSE
        IF( le.Input_posted_satutory_speed_limit = (TYPEOF(le.Input_posted_satutory_speed_limit))'','',':posted_satutory_speed_limit')
    #END
+    #IF( #TEXT(Input_direction_of_travel_before_crash)='' )
      '' 
    #ELSE
        IF( le.Input_direction_of_travel_before_crash = (TYPEOF(le.Input_direction_of_travel_before_crash))'','',':direction_of_travel_before_crash')
    #END
+    #IF( #TEXT(Input_trafficway_description)='' )
      '' 
    #ELSE
        IF( le.Input_trafficway_description = (TYPEOF(le.Input_trafficway_description))'','',':trafficway_description')
    #END
+    #IF( #TEXT(Input_traffic_control_device_type)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_control_device_type = (TYPEOF(le.Input_traffic_control_device_type))'','',':traffic_control_device_type')
    #END
+    #IF( #TEXT(Input_vehicle_maneuver_action_prior1)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_maneuver_action_prior1 = (TYPEOF(le.Input_vehicle_maneuver_action_prior1))'','',':vehicle_maneuver_action_prior1')
    #END
+    #IF( #TEXT(Input_vehicle_maneuver_action_prior2)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_maneuver_action_prior2 = (TYPEOF(le.Input_vehicle_maneuver_action_prior2))'','',':vehicle_maneuver_action_prior2')
    #END
+    #IF( #TEXT(Input_impact_area1)='' )
      '' 
    #ELSE
        IF( le.Input_impact_area1 = (TYPEOF(le.Input_impact_area1))'','',':impact_area1')
    #END
+    #IF( #TEXT(Input_impact_area2)='' )
      '' 
    #ELSE
        IF( le.Input_impact_area2 = (TYPEOF(le.Input_impact_area2))'','',':impact_area2')
    #END
+    #IF( #TEXT(Input_event_sequence1)='' )
      '' 
    #ELSE
        IF( le.Input_event_sequence1 = (TYPEOF(le.Input_event_sequence1))'','',':event_sequence1')
    #END
+    #IF( #TEXT(Input_event_sequence2)='' )
      '' 
    #ELSE
        IF( le.Input_event_sequence2 = (TYPEOF(le.Input_event_sequence2))'','',':event_sequence2')
    #END
+    #IF( #TEXT(Input_event_sequence3)='' )
      '' 
    #ELSE
        IF( le.Input_event_sequence3 = (TYPEOF(le.Input_event_sequence3))'','',':event_sequence3')
    #END
+    #IF( #TEXT(Input_event_sequence4)='' )
      '' 
    #ELSE
        IF( le.Input_event_sequence4 = (TYPEOF(le.Input_event_sequence4))'','',':event_sequence4')
    #END
+    #IF( #TEXT(Input_most_harmful_event_for_vehicle)='' )
      '' 
    #ELSE
        IF( le.Input_most_harmful_event_for_vehicle = (TYPEOF(le.Input_most_harmful_event_for_vehicle))'','',':most_harmful_event_for_vehicle')
    #END
+    #IF( #TEXT(Input_bus_use)='' )
      '' 
    #ELSE
        IF( le.Input_bus_use = (TYPEOF(le.Input_bus_use))'','',':bus_use')
    #END
+    #IF( #TEXT(Input_vehicle_hit_and_run)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_hit_and_run = (TYPEOF(le.Input_vehicle_hit_and_run))'','',':vehicle_hit_and_run')
    #END
+    #IF( #TEXT(Input_vehicle_towed)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_towed = (TYPEOF(le.Input_vehicle_towed))'','',':vehicle_towed')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_v1)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_v1 = (TYPEOF(le.Input_contributing_circumstances_v1))'','',':contributing_circumstances_v1')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_v2)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_v2 = (TYPEOF(le.Input_contributing_circumstances_v2))'','',':contributing_circumstances_v2')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_v3)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_v3 = (TYPEOF(le.Input_contributing_circumstances_v3))'','',':contributing_circumstances_v3')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_v4)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_v4 = (TYPEOF(le.Input_contributing_circumstances_v4))'','',':contributing_circumstances_v4')
    #END
+    #IF( #TEXT(Input_on_street)='' )
      '' 
    #ELSE
        IF( le.Input_on_street = (TYPEOF(le.Input_on_street))'','',':on_street')
    #END
+    #IF( #TEXT(Input_vehicle_color)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_color = (TYPEOF(le.Input_vehicle_color))'','',':vehicle_color')
    #END
+    #IF( #TEXT(Input_estimated_speed)='' )
      '' 
    #ELSE
        IF( le.Input_estimated_speed = (TYPEOF(le.Input_estimated_speed))'','',':estimated_speed')
    #END
+    #IF( #TEXT(Input_accident_investigation_site)='' )
      '' 
    #ELSE
        IF( le.Input_accident_investigation_site = (TYPEOF(le.Input_accident_investigation_site))'','',':accident_investigation_site')
    #END
+    #IF( #TEXT(Input_car_fire)='' )
      '' 
    #ELSE
        IF( le.Input_car_fire = (TYPEOF(le.Input_car_fire))'','',':car_fire')
    #END
+    #IF( #TEXT(Input_vehicle_damage_amount)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_damage_amount = (TYPEOF(le.Input_vehicle_damage_amount))'','',':vehicle_damage_amount')
    #END
+    #IF( #TEXT(Input_contributing_factors1)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_factors1 = (TYPEOF(le.Input_contributing_factors1))'','',':contributing_factors1')
    #END
+    #IF( #TEXT(Input_contributing_factors2)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_factors2 = (TYPEOF(le.Input_contributing_factors2))'','',':contributing_factors2')
    #END
+    #IF( #TEXT(Input_contributing_factors3)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_factors3 = (TYPEOF(le.Input_contributing_factors3))'','',':contributing_factors3')
    #END
+    #IF( #TEXT(Input_contributing_factors4)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_factors4 = (TYPEOF(le.Input_contributing_factors4))'','',':contributing_factors4')
    #END
+    #IF( #TEXT(Input_other_contributing_factors1)='' )
      '' 
    #ELSE
        IF( le.Input_other_contributing_factors1 = (TYPEOF(le.Input_other_contributing_factors1))'','',':other_contributing_factors1')
    #END
+    #IF( #TEXT(Input_other_contributing_factors2)='' )
      '' 
    #ELSE
        IF( le.Input_other_contributing_factors2 = (TYPEOF(le.Input_other_contributing_factors2))'','',':other_contributing_factors2')
    #END
+    #IF( #TEXT(Input_other_contributing_factors3)='' )
      '' 
    #ELSE
        IF( le.Input_other_contributing_factors3 = (TYPEOF(le.Input_other_contributing_factors3))'','',':other_contributing_factors3')
    #END
+    #IF( #TEXT(Input_vision_obscured1)='' )
      '' 
    #ELSE
        IF( le.Input_vision_obscured1 = (TYPEOF(le.Input_vision_obscured1))'','',':vision_obscured1')
    #END
+    #IF( #TEXT(Input_vision_obscured2)='' )
      '' 
    #ELSE
        IF( le.Input_vision_obscured2 = (TYPEOF(le.Input_vision_obscured2))'','',':vision_obscured2')
    #END
+    #IF( #TEXT(Input_vehicle_on_road)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_on_road = (TYPEOF(le.Input_vehicle_on_road))'','',':vehicle_on_road')
    #END
+    #IF( #TEXT(Input_ran_off_road)='' )
      '' 
    #ELSE
        IF( le.Input_ran_off_road = (TYPEOF(le.Input_ran_off_road))'','',':ran_off_road')
    #END
+    #IF( #TEXT(Input_skidding_occurred)='' )
      '' 
    #ELSE
        IF( le.Input_skidding_occurred = (TYPEOF(le.Input_skidding_occurred))'','',':skidding_occurred')
    #END
+    #IF( #TEXT(Input_vehicle_incident_location1)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_incident_location1 = (TYPEOF(le.Input_vehicle_incident_location1))'','',':vehicle_incident_location1')
    #END
+    #IF( #TEXT(Input_vehicle_incident_location2)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_incident_location2 = (TYPEOF(le.Input_vehicle_incident_location2))'','',':vehicle_incident_location2')
    #END
+    #IF( #TEXT(Input_vehicle_incident_location3)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_incident_location3 = (TYPEOF(le.Input_vehicle_incident_location3))'','',':vehicle_incident_location3')
    #END
+    #IF( #TEXT(Input_vehicle_disabled)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_disabled = (TYPEOF(le.Input_vehicle_disabled))'','',':vehicle_disabled')
    #END
+    #IF( #TEXT(Input_vehicle_removed_to)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_removed_to = (TYPEOF(le.Input_vehicle_removed_to))'','',':vehicle_removed_to')
    #END
+    #IF( #TEXT(Input_removed_by)='' )
      '' 
    #ELSE
        IF( le.Input_removed_by = (TYPEOF(le.Input_removed_by))'','',':removed_by')
    #END
+    #IF( #TEXT(Input_tow_requested_by_driver)='' )
      '' 
    #ELSE
        IF( le.Input_tow_requested_by_driver = (TYPEOF(le.Input_tow_requested_by_driver))'','',':tow_requested_by_driver')
    #END
+    #IF( #TEXT(Input_solicitation)='' )
      '' 
    #ELSE
        IF( le.Input_solicitation = (TYPEOF(le.Input_solicitation))'','',':solicitation')
    #END
+    #IF( #TEXT(Input_other_unit_vehicle_damage_amount)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_vehicle_damage_amount = (TYPEOF(le.Input_other_unit_vehicle_damage_amount))'','',':other_unit_vehicle_damage_amount')
    #END
+    #IF( #TEXT(Input_other_unit_model_year)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_model_year = (TYPEOF(le.Input_other_unit_model_year))'','',':other_unit_model_year')
    #END
+    #IF( #TEXT(Input_other_unit_make)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_make = (TYPEOF(le.Input_other_unit_make))'','',':other_unit_make')
    #END
+    #IF( #TEXT(Input_other_unit_model)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_model = (TYPEOF(le.Input_other_unit_model))'','',':other_unit_model')
    #END
+    #IF( #TEXT(Input_other_unit_vin)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_vin = (TYPEOF(le.Input_other_unit_vin))'','',':other_unit_vin')
    #END
+    #IF( #TEXT(Input_other_unit_vin_status)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_vin_status = (TYPEOF(le.Input_other_unit_vin_status))'','',':other_unit_vin_status')
    #END
+    #IF( #TEXT(Input_other_unit_body_type_category)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_body_type_category = (TYPEOF(le.Input_other_unit_body_type_category))'','',':other_unit_body_type_category')
    #END
+    #IF( #TEXT(Input_other_unit_registration_state)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_registration_state = (TYPEOF(le.Input_other_unit_registration_state))'','',':other_unit_registration_state')
    #END
+    #IF( #TEXT(Input_other_unit_registration_year)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_registration_year = (TYPEOF(le.Input_other_unit_registration_year))'','',':other_unit_registration_year')
    #END
+    #IF( #TEXT(Input_other_unit_license_plate)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_license_plate = (TYPEOF(le.Input_other_unit_license_plate))'','',':other_unit_license_plate')
    #END
+    #IF( #TEXT(Input_other_unit_color)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_color = (TYPEOF(le.Input_other_unit_color))'','',':other_unit_color')
    #END
+    #IF( #TEXT(Input_other_unit_type)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_type = (TYPEOF(le.Input_other_unit_type))'','',':other_unit_type')
    #END
+    #IF( #TEXT(Input_damaged_areas1)='' )
      '' 
    #ELSE
        IF( le.Input_damaged_areas1 = (TYPEOF(le.Input_damaged_areas1))'','',':damaged_areas1')
    #END
+    #IF( #TEXT(Input_damaged_areas2)='' )
      '' 
    #ELSE
        IF( le.Input_damaged_areas2 = (TYPEOF(le.Input_damaged_areas2))'','',':damaged_areas2')
    #END
+    #IF( #TEXT(Input_parked_vehicle)='' )
      '' 
    #ELSE
        IF( le.Input_parked_vehicle = (TYPEOF(le.Input_parked_vehicle))'','',':parked_vehicle')
    #END
+    #IF( #TEXT(Input_damage_rating1)='' )
      '' 
    #ELSE
        IF( le.Input_damage_rating1 = (TYPEOF(le.Input_damage_rating1))'','',':damage_rating1')
    #END
+    #IF( #TEXT(Input_damage_rating2)='' )
      '' 
    #ELSE
        IF( le.Input_damage_rating2 = (TYPEOF(le.Input_damage_rating2))'','',':damage_rating2')
    #END
+    #IF( #TEXT(Input_vehicle_inventoried)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_inventoried = (TYPEOF(le.Input_vehicle_inventoried))'','',':vehicle_inventoried')
    #END
+    #IF( #TEXT(Input_vehicle_defect_apparent)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_defect_apparent = (TYPEOF(le.Input_vehicle_defect_apparent))'','',':vehicle_defect_apparent')
    #END
+    #IF( #TEXT(Input_defect_may_have_contributed1)='' )
      '' 
    #ELSE
        IF( le.Input_defect_may_have_contributed1 = (TYPEOF(le.Input_defect_may_have_contributed1))'','',':defect_may_have_contributed1')
    #END
+    #IF( #TEXT(Input_defect_may_have_contributed2)='' )
      '' 
    #ELSE
        IF( le.Input_defect_may_have_contributed2 = (TYPEOF(le.Input_defect_may_have_contributed2))'','',':defect_may_have_contributed2')
    #END
+    #IF( #TEXT(Input_registration_expiration)='' )
      '' 
    #ELSE
        IF( le.Input_registration_expiration = (TYPEOF(le.Input_registration_expiration))'','',':registration_expiration')
    #END
+    #IF( #TEXT(Input_owner_driver_type)='' )
      '' 
    #ELSE
        IF( le.Input_owner_driver_type = (TYPEOF(le.Input_owner_driver_type))'','',':owner_driver_type')
    #END
+    #IF( #TEXT(Input_make_code)='' )
      '' 
    #ELSE
        IF( le.Input_make_code = (TYPEOF(le.Input_make_code))'','',':make_code')
    #END
+    #IF( #TEXT(Input_number_trailing_units)='' )
      '' 
    #ELSE
        IF( le.Input_number_trailing_units = (TYPEOF(le.Input_number_trailing_units))'','',':number_trailing_units')
    #END
+    #IF( #TEXT(Input_vehicle_position)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_position = (TYPEOF(le.Input_vehicle_position))'','',':vehicle_position')
    #END
+    #IF( #TEXT(Input_vehicle_type)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_type = (TYPEOF(le.Input_vehicle_type))'','',':vehicle_type')
    #END
+    #IF( #TEXT(Input_motorcycle_engine_size)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_engine_size = (TYPEOF(le.Input_motorcycle_engine_size))'','',':motorcycle_engine_size')
    #END
+    #IF( #TEXT(Input_motorcycle_driver_educated)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_driver_educated = (TYPEOF(le.Input_motorcycle_driver_educated))'','',':motorcycle_driver_educated')
    #END
+    #IF( #TEXT(Input_motorcycle_helmet_type)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_helmet_type = (TYPEOF(le.Input_motorcycle_helmet_type))'','',':motorcycle_helmet_type')
    #END
+    #IF( #TEXT(Input_motorcycle_passenger)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_passenger = (TYPEOF(le.Input_motorcycle_passenger))'','',':motorcycle_passenger')
    #END
+    #IF( #TEXT(Input_motorcycle_helmet_stayed_on)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_helmet_stayed_on = (TYPEOF(le.Input_motorcycle_helmet_stayed_on))'','',':motorcycle_helmet_stayed_on')
    #END
+    #IF( #TEXT(Input_motorcycle_helmet_dot_snell)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_helmet_dot_snell = (TYPEOF(le.Input_motorcycle_helmet_dot_snell))'','',':motorcycle_helmet_dot_snell')
    #END
+    #IF( #TEXT(Input_motorcycle_saddlebag_trunk)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_saddlebag_trunk = (TYPEOF(le.Input_motorcycle_saddlebag_trunk))'','',':motorcycle_saddlebag_trunk')
    #END
+    #IF( #TEXT(Input_motorcycle_trailer)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_trailer = (TYPEOF(le.Input_motorcycle_trailer))'','',':motorcycle_trailer')
    #END
+    #IF( #TEXT(Input_pedacycle_passenger)='' )
      '' 
    #ELSE
        IF( le.Input_pedacycle_passenger = (TYPEOF(le.Input_pedacycle_passenger))'','',':pedacycle_passenger')
    #END
+    #IF( #TEXT(Input_pedacycle_headlights)='' )
      '' 
    #ELSE
        IF( le.Input_pedacycle_headlights = (TYPEOF(le.Input_pedacycle_headlights))'','',':pedacycle_headlights')
    #END
+    #IF( #TEXT(Input_pedacycle_helmet)='' )
      '' 
    #ELSE
        IF( le.Input_pedacycle_helmet = (TYPEOF(le.Input_pedacycle_helmet))'','',':pedacycle_helmet')
    #END
+    #IF( #TEXT(Input_pedacycle_rear_reflectors)='' )
      '' 
    #ELSE
        IF( le.Input_pedacycle_rear_reflectors = (TYPEOF(le.Input_pedacycle_rear_reflectors))'','',':pedacycle_rear_reflectors')
    #END
+    #IF( #TEXT(Input_cdl_required)='' )
      '' 
    #ELSE
        IF( le.Input_cdl_required = (TYPEOF(le.Input_cdl_required))'','',':cdl_required')
    #END
+    #IF( #TEXT(Input_truck_bus_supplement_required)='' )
      '' 
    #ELSE
        IF( le.Input_truck_bus_supplement_required = (TYPEOF(le.Input_truck_bus_supplement_required))'','',':truck_bus_supplement_required')
    #END
+    #IF( #TEXT(Input_unit_damage_amount)='' )
      '' 
    #ELSE
        IF( le.Input_unit_damage_amount = (TYPEOF(le.Input_unit_damage_amount))'','',':unit_damage_amount')
    #END
+    #IF( #TEXT(Input_airbag_switch)='' )
      '' 
    #ELSE
        IF( le.Input_airbag_switch = (TYPEOF(le.Input_airbag_switch))'','',':airbag_switch')
    #END
+    #IF( #TEXT(Input_underride_override_damage)='' )
      '' 
    #ELSE
        IF( le.Input_underride_override_damage = (TYPEOF(le.Input_underride_override_damage))'','',':underride_override_damage')
    #END
+    #IF( #TEXT(Input_vehicle_attachment)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_attachment = (TYPEOF(le.Input_vehicle_attachment))'','',':vehicle_attachment')
    #END
+    #IF( #TEXT(Input_action_on_impact)='' )
      '' 
    #ELSE
        IF( le.Input_action_on_impact = (TYPEOF(le.Input_action_on_impact))'','',':action_on_impact')
    #END
+    #IF( #TEXT(Input_speed_detection_method)='' )
      '' 
    #ELSE
        IF( le.Input_speed_detection_method = (TYPEOF(le.Input_speed_detection_method))'','',':speed_detection_method')
    #END
+    #IF( #TEXT(Input_non_motorist_direction_of_travel_from)='' )
      '' 
    #ELSE
        IF( le.Input_non_motorist_direction_of_travel_from = (TYPEOF(le.Input_non_motorist_direction_of_travel_from))'','',':non_motorist_direction_of_travel_from')
    #END
+    #IF( #TEXT(Input_non_motorist_direction_of_travel_to)='' )
      '' 
    #ELSE
        IF( le.Input_non_motorist_direction_of_travel_to = (TYPEOF(le.Input_non_motorist_direction_of_travel_to))'','',':non_motorist_direction_of_travel_to')
    #END
+    #IF( #TEXT(Input_vehicle_use)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_use = (TYPEOF(le.Input_vehicle_use))'','',':vehicle_use')
    #END
+    #IF( #TEXT(Input_department_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_department_unit_number = (TYPEOF(le.Input_department_unit_number))'','',':department_unit_number')
    #END
+    #IF( #TEXT(Input_equipment_in_use_at_time_of_accident)='' )
      '' 
    #ELSE
        IF( le.Input_equipment_in_use_at_time_of_accident = (TYPEOF(le.Input_equipment_in_use_at_time_of_accident))'','',':equipment_in_use_at_time_of_accident')
    #END
+    #IF( #TEXT(Input_actions_of_police_vehicle)='' )
      '' 
    #ELSE
        IF( le.Input_actions_of_police_vehicle = (TYPEOF(le.Input_actions_of_police_vehicle))'','',':actions_of_police_vehicle')
    #END
+    #IF( #TEXT(Input_vehicle_command_id)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_command_id = (TYPEOF(le.Input_vehicle_command_id))'','',':vehicle_command_id')
    #END
+    #IF( #TEXT(Input_traffic_control_device_inoperative)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_control_device_inoperative = (TYPEOF(le.Input_traffic_control_device_inoperative))'','',':traffic_control_device_inoperative')
    #END
+    #IF( #TEXT(Input_direction_of_impact1)='' )
      '' 
    #ELSE
        IF( le.Input_direction_of_impact1 = (TYPEOF(le.Input_direction_of_impact1))'','',':direction_of_impact1')
    #END
+    #IF( #TEXT(Input_direction_of_impact2)='' )
      '' 
    #ELSE
        IF( le.Input_direction_of_impact2 = (TYPEOF(le.Input_direction_of_impact2))'','',':direction_of_impact2')
    #END
+    #IF( #TEXT(Input_ran_off_road_direction)='' )
      '' 
    #ELSE
        IF( le.Input_ran_off_road_direction = (TYPEOF(le.Input_ran_off_road_direction))'','',':ran_off_road_direction')
    #END
+    #IF( #TEXT(Input_vin_other_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_vin_other_unit_number = (TYPEOF(le.Input_vin_other_unit_number))'','',':vin_other_unit_number')
    #END
+    #IF( #TEXT(Input_damaged_area_generic)='' )
      '' 
    #ELSE
        IF( le.Input_damaged_area_generic = (TYPEOF(le.Input_damaged_area_generic))'','',':damaged_area_generic')
    #END
+    #IF( #TEXT(Input_vision_obscured_description)='' )
      '' 
    #ELSE
        IF( le.Input_vision_obscured_description = (TYPEOF(le.Input_vision_obscured_description))'','',':vision_obscured_description')
    #END
+    #IF( #TEXT(Input_inattention_description)='' )
      '' 
    #ELSE
        IF( le.Input_inattention_description = (TYPEOF(le.Input_inattention_description))'','',':inattention_description')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_defect_description)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_defect_description = (TYPEOF(le.Input_contributing_circumstances_defect_description))'','',':contributing_circumstances_defect_description')
    #END
+    #IF( #TEXT(Input_contributing_circumstances_other_descriptioin)='' )
      '' 
    #ELSE
        IF( le.Input_contributing_circumstances_other_descriptioin = (TYPEOF(le.Input_contributing_circumstances_other_descriptioin))'','',':contributing_circumstances_other_descriptioin')
    #END
+    #IF( #TEXT(Input_vehicle_maneuver_action_prior_other_description)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_maneuver_action_prior_other_description = (TYPEOF(le.Input_vehicle_maneuver_action_prior_other_description))'','',':vehicle_maneuver_action_prior_other_description')
    #END
+    #IF( #TEXT(Input_vehicle_special_use)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_special_use = (TYPEOF(le.Input_vehicle_special_use))'','',':vehicle_special_use')
    #END
+    #IF( #TEXT(Input_vehicle_type_extended1)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_type_extended1 = (TYPEOF(le.Input_vehicle_type_extended1))'','',':vehicle_type_extended1')
    #END
+    #IF( #TEXT(Input_vehicle_type_extended2)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_type_extended2 = (TYPEOF(le.Input_vehicle_type_extended2))'','',':vehicle_type_extended2')
    #END
+    #IF( #TEXT(Input_fixed_object_direction1)='' )
      '' 
    #ELSE
        IF( le.Input_fixed_object_direction1 = (TYPEOF(le.Input_fixed_object_direction1))'','',':fixed_object_direction1')
    #END
+    #IF( #TEXT(Input_fixed_object_direction2)='' )
      '' 
    #ELSE
        IF( le.Input_fixed_object_direction2 = (TYPEOF(le.Input_fixed_object_direction2))'','',':fixed_object_direction2')
    #END
+    #IF( #TEXT(Input_fixed_object_direction3)='' )
      '' 
    #ELSE
        IF( le.Input_fixed_object_direction3 = (TYPEOF(le.Input_fixed_object_direction3))'','',':fixed_object_direction3')
    #END
+    #IF( #TEXT(Input_fixed_object_direction4)='' )
      '' 
    #ELSE
        IF( le.Input_fixed_object_direction4 = (TYPEOF(le.Input_fixed_object_direction4))'','',':fixed_object_direction4')
    #END
+    #IF( #TEXT(Input_vehicle_left_at_scene)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_left_at_scene = (TYPEOF(le.Input_vehicle_left_at_scene))'','',':vehicle_left_at_scene')
    #END
+    #IF( #TEXT(Input_vehicle_impounded)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_impounded = (TYPEOF(le.Input_vehicle_impounded))'','',':vehicle_impounded')
    #END
+    #IF( #TEXT(Input_vehicle_driven_from_scene)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_driven_from_scene = (TYPEOF(le.Input_vehicle_driven_from_scene))'','',':vehicle_driven_from_scene')
    #END
+    #IF( #TEXT(Input_on_cross_street)='' )
      '' 
    #ELSE
        IF( le.Input_on_cross_street = (TYPEOF(le.Input_on_cross_street))'','',':on_cross_street')
    #END
+    #IF( #TEXT(Input_actions_of_police_vehicle_description)='' )
      '' 
    #ELSE
        IF( le.Input_actions_of_police_vehicle_description = (TYPEOF(le.Input_actions_of_police_vehicle_description))'','',':actions_of_police_vehicle_description')
    #END
+    #IF( #TEXT(Input_vehicle_seg)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_seg = (TYPEOF(le.Input_vehicle_seg))'','',':vehicle_seg')
    #END
+    #IF( #TEXT(Input_vehicle_seg_type)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_seg_type = (TYPEOF(le.Input_vehicle_seg_type))'','',':vehicle_seg_type')
    #END
+    #IF( #TEXT(Input_model_year)='' )
      '' 
    #ELSE
        IF( le.Input_model_year = (TYPEOF(le.Input_model_year))'','',':model_year')
    #END
+    #IF( #TEXT(Input_body_style_code)='' )
      '' 
    #ELSE
        IF( le.Input_body_style_code = (TYPEOF(le.Input_body_style_code))'','',':body_style_code')
    #END
+    #IF( #TEXT(Input_engine_size)='' )
      '' 
    #ELSE
        IF( le.Input_engine_size = (TYPEOF(le.Input_engine_size))'','',':engine_size')
    #END
+    #IF( #TEXT(Input_fuel_code)='' )
      '' 
    #ELSE
        IF( le.Input_fuel_code = (TYPEOF(le.Input_fuel_code))'','',':fuel_code')
    #END
+    #IF( #TEXT(Input_number_of_driving_wheels)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_driving_wheels = (TYPEOF(le.Input_number_of_driving_wheels))'','',':number_of_driving_wheels')
    #END
+    #IF( #TEXT(Input_steering_type)='' )
      '' 
    #ELSE
        IF( le.Input_steering_type = (TYPEOF(le.Input_steering_type))'','',':steering_type')
    #END
+    #IF( #TEXT(Input_vina_series)='' )
      '' 
    #ELSE
        IF( le.Input_vina_series = (TYPEOF(le.Input_vina_series))'','',':vina_series')
    #END
+    #IF( #TEXT(Input_vina_model)='' )
      '' 
    #ELSE
        IF( le.Input_vina_model = (TYPEOF(le.Input_vina_model))'','',':vina_model')
    #END
+    #IF( #TEXT(Input_vina_make)='' )
      '' 
    #ELSE
        IF( le.Input_vina_make = (TYPEOF(le.Input_vina_make))'','',':vina_make')
    #END
+    #IF( #TEXT(Input_vina_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_vina_body_style = (TYPEOF(le.Input_vina_body_style))'','',':vina_body_style')
    #END
+    #IF( #TEXT(Input_make_description)='' )
      '' 
    #ELSE
        IF( le.Input_make_description = (TYPEOF(le.Input_make_description))'','',':make_description')
    #END
+    #IF( #TEXT(Input_model_description)='' )
      '' 
    #ELSE
        IF( le.Input_model_description = (TYPEOF(le.Input_model_description))'','',':model_description')
    #END
+    #IF( #TEXT(Input_series_description)='' )
      '' 
    #ELSE
        IF( le.Input_series_description = (TYPEOF(le.Input_series_description))'','',':series_description')
    #END
+    #IF( #TEXT(Input_car_cylinders)='' )
      '' 
    #ELSE
        IF( le.Input_car_cylinders = (TYPEOF(le.Input_car_cylinders))'','',':car_cylinders')
    #END
+    #IF( #TEXT(Input_other_vehicle_seg)='' )
      '' 
    #ELSE
        IF( le.Input_other_vehicle_seg = (TYPEOF(le.Input_other_vehicle_seg))'','',':other_vehicle_seg')
    #END
+    #IF( #TEXT(Input_other_vehicle_seg_type)='' )
      '' 
    #ELSE
        IF( le.Input_other_vehicle_seg_type = (TYPEOF(le.Input_other_vehicle_seg_type))'','',':other_vehicle_seg_type')
    #END
+    #IF( #TEXT(Input_other_model_year)='' )
      '' 
    #ELSE
        IF( le.Input_other_model_year = (TYPEOF(le.Input_other_model_year))'','',':other_model_year')
    #END
+    #IF( #TEXT(Input_other_body_style_code)='' )
      '' 
    #ELSE
        IF( le.Input_other_body_style_code = (TYPEOF(le.Input_other_body_style_code))'','',':other_body_style_code')
    #END
+    #IF( #TEXT(Input_other_engine_size)='' )
      '' 
    #ELSE
        IF( le.Input_other_engine_size = (TYPEOF(le.Input_other_engine_size))'','',':other_engine_size')
    #END
+    #IF( #TEXT(Input_other_fuel_code)='' )
      '' 
    #ELSE
        IF( le.Input_other_fuel_code = (TYPEOF(le.Input_other_fuel_code))'','',':other_fuel_code')
    #END
+    #IF( #TEXT(Input_other_number_of_driving_wheels)='' )
      '' 
    #ELSE
        IF( le.Input_other_number_of_driving_wheels = (TYPEOF(le.Input_other_number_of_driving_wheels))'','',':other_number_of_driving_wheels')
    #END
+    #IF( #TEXT(Input_other_steering_type)='' )
      '' 
    #ELSE
        IF( le.Input_other_steering_type = (TYPEOF(le.Input_other_steering_type))'','',':other_steering_type')
    #END
+    #IF( #TEXT(Input_other_vina_series)='' )
      '' 
    #ELSE
        IF( le.Input_other_vina_series = (TYPEOF(le.Input_other_vina_series))'','',':other_vina_series')
    #END
+    #IF( #TEXT(Input_other_vina_model)='' )
      '' 
    #ELSE
        IF( le.Input_other_vina_model = (TYPEOF(le.Input_other_vina_model))'','',':other_vina_model')
    #END
+    #IF( #TEXT(Input_other_vina_make)='' )
      '' 
    #ELSE
        IF( le.Input_other_vina_make = (TYPEOF(le.Input_other_vina_make))'','',':other_vina_make')
    #END
+    #IF( #TEXT(Input_other_vina_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_other_vina_body_style = (TYPEOF(le.Input_other_vina_body_style))'','',':other_vina_body_style')
    #END
+    #IF( #TEXT(Input_other_make_description)='' )
      '' 
    #ELSE
        IF( le.Input_other_make_description = (TYPEOF(le.Input_other_make_description))'','',':other_make_description')
    #END
+    #IF( #TEXT(Input_other_model_description)='' )
      '' 
    #ELSE
        IF( le.Input_other_model_description = (TYPEOF(le.Input_other_model_description))'','',':other_model_description')
    #END
+    #IF( #TEXT(Input_other_series_description)='' )
      '' 
    #ELSE
        IF( le.Input_other_series_description = (TYPEOF(le.Input_other_series_description))'','',':other_series_description')
    #END
+    #IF( #TEXT(Input_other_car_cylinders)='' )
      '' 
    #ELSE
        IF( le.Input_other_car_cylinders = (TYPEOF(le.Input_other_car_cylinders))'','',':other_car_cylinders')
    #END
+    #IF( #TEXT(Input_report_has_coversheet)='' )
      '' 
    #ELSE
        IF( le.Input_report_has_coversheet = (TYPEOF(le.Input_report_has_coversheet))'','',':report_has_coversheet')
    #END
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
+    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
+    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
+    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
+    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
+    #IF( #TEXT(Input_z5)='' )
      '' 
    #ELSE
        IF( le.Input_z5 = (TYPEOF(le.Input_z5))'','',':z5')
    #END
+    #IF( #TEXT(Input_z4)='' )
      '' 
    #ELSE
        IF( le.Input_z4 = (TYPEOF(le.Input_z4))'','',':z4')
    #END
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
+    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
+    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
+    #IF( #TEXT(Input_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_dpbc = (TYPEOF(le.Input_dpbc))'','',':dpbc')
    #END
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
+    #IF( #TEXT(Input_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_county_code = (TYPEOF(le.Input_county_code))'','',':county_code')
    #END
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
+    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
+    #IF( #TEXT(Input_nametype)='' )
      '' 
    #ELSE
        IF( le.Input_nametype = (TYPEOF(le.Input_nametype))'','',':nametype')
    #END
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
+    #IF( #TEXT(Input_title2)='' )
      '' 
    #ELSE
        IF( le.Input_title2 = (TYPEOF(le.Input_title2))'','',':title2')
    #END
+    #IF( #TEXT(Input_fname2)='' )
      '' 
    #ELSE
        IF( le.Input_fname2 = (TYPEOF(le.Input_fname2))'','',':fname2')
    #END
+    #IF( #TEXT(Input_mname2)='' )
      '' 
    #ELSE
        IF( le.Input_mname2 = (TYPEOF(le.Input_mname2))'','',':mname2')
    #END
+    #IF( #TEXT(Input_lname2)='' )
      '' 
    #ELSE
        IF( le.Input_lname2 = (TYPEOF(le.Input_lname2))'','',':lname2')
    #END
+    #IF( #TEXT(Input_suffix2)='' )
      '' 
    #ELSE
        IF( le.Input_suffix2 = (TYPEOF(le.Input_suffix2))'','',':suffix2')
    #END
+    #IF( #TEXT(Input_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_name_score = (TYPEOF(le.Input_name_score))'','',':name_score')
    #END
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
+    #IF( #TEXT(Input_bdid_score)='' )
      '' 
    #ELSE
        IF( le.Input_bdid_score = (TYPEOF(le.Input_bdid_score))'','',':bdid_score')
    #END
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
+    #IF( #TEXT(Input_law_enforcement_suspects_alcohol_use1)='' )
      '' 
    #ELSE
        IF( le.Input_law_enforcement_suspects_alcohol_use1 = (TYPEOF(le.Input_law_enforcement_suspects_alcohol_use1))'','',':law_enforcement_suspects_alcohol_use1')
    #END
+    #IF( #TEXT(Input_law_enforcement_suspects_drug_use1)='' )
      '' 
    #ELSE
        IF( le.Input_law_enforcement_suspects_drug_use1 = (TYPEOF(le.Input_law_enforcement_suspects_drug_use1))'','',':law_enforcement_suspects_drug_use1')
    #END
+    #IF( #TEXT(Input_ems_notified_time)='' )
      '' 
    #ELSE
        IF( le.Input_ems_notified_time = (TYPEOF(le.Input_ems_notified_time))'','',':ems_notified_time')
    #END
+    #IF( #TEXT(Input_ems_arrival_time)='' )
      '' 
    #ELSE
        IF( le.Input_ems_arrival_time = (TYPEOF(le.Input_ems_arrival_time))'','',':ems_arrival_time')
    #END
+    #IF( #TEXT(Input_avoidance_maneuver2)='' )
      '' 
    #ELSE
        IF( le.Input_avoidance_maneuver2 = (TYPEOF(le.Input_avoidance_maneuver2))'','',':avoidance_maneuver2')
    #END
+    #IF( #TEXT(Input_avoidance_maneuver3)='' )
      '' 
    #ELSE
        IF( le.Input_avoidance_maneuver3 = (TYPEOF(le.Input_avoidance_maneuver3))'','',':avoidance_maneuver3')
    #END
+    #IF( #TEXT(Input_avoidance_maneuver4)='' )
      '' 
    #ELSE
        IF( le.Input_avoidance_maneuver4 = (TYPEOF(le.Input_avoidance_maneuver4))'','',':avoidance_maneuver4')
    #END
+    #IF( #TEXT(Input_damaged_areas_severity1)='' )
      '' 
    #ELSE
        IF( le.Input_damaged_areas_severity1 = (TYPEOF(le.Input_damaged_areas_severity1))'','',':damaged_areas_severity1')
    #END
+    #IF( #TEXT(Input_damaged_areas_severity2)='' )
      '' 
    #ELSE
        IF( le.Input_damaged_areas_severity2 = (TYPEOF(le.Input_damaged_areas_severity2))'','',':damaged_areas_severity2')
    #END
+    #IF( #TEXT(Input_vehicle_outside_city_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_outside_city_indicator = (TYPEOF(le.Input_vehicle_outside_city_indicator))'','',':vehicle_outside_city_indicator')
    #END
+    #IF( #TEXT(Input_vehicle_outside_city_distance_miles)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_outside_city_distance_miles = (TYPEOF(le.Input_vehicle_outside_city_distance_miles))'','',':vehicle_outside_city_distance_miles')
    #END
+    #IF( #TEXT(Input_vehicle_outside_city_direction)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_outside_city_direction = (TYPEOF(le.Input_vehicle_outside_city_direction))'','',':vehicle_outside_city_direction')
    #END
+    #IF( #TEXT(Input_vehicle_crash_cityplace)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_crash_cityplace = (TYPEOF(le.Input_vehicle_crash_cityplace))'','',':vehicle_crash_cityplace')
    #END
+    #IF( #TEXT(Input_insurance_company_standardized)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_company_standardized = (TYPEOF(le.Input_insurance_company_standardized))'','',':insurance_company_standardized')
    #END
+    #IF( #TEXT(Input_insurance_expiration_date)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_expiration_date = (TYPEOF(le.Input_insurance_expiration_date))'','',':insurance_expiration_date')
    #END
+    #IF( #TEXT(Input_insurance_policy_holder)='' )
      '' 
    #ELSE
        IF( le.Input_insurance_policy_holder = (TYPEOF(le.Input_insurance_policy_holder))'','',':insurance_policy_holder')
    #END
+    #IF( #TEXT(Input_is_tag_converted)='' )
      '' 
    #ELSE
        IF( le.Input_is_tag_converted = (TYPEOF(le.Input_is_tag_converted))'','',':is_tag_converted')
    #END
+    #IF( #TEXT(Input_vin_original)='' )
      '' 
    #ELSE
        IF( le.Input_vin_original = (TYPEOF(le.Input_vin_original))'','',':vin_original')
    #END
+    #IF( #TEXT(Input_make_original)='' )
      '' 
    #ELSE
        IF( le.Input_make_original = (TYPEOF(le.Input_make_original))'','',':make_original')
    #END
+    #IF( #TEXT(Input_model_original)='' )
      '' 
    #ELSE
        IF( le.Input_model_original = (TYPEOF(le.Input_model_original))'','',':model_original')
    #END
+    #IF( #TEXT(Input_model_year_original)='' )
      '' 
    #ELSE
        IF( le.Input_model_year_original = (TYPEOF(le.Input_model_year_original))'','',':model_year_original')
    #END
+    #IF( #TEXT(Input_other_unit_vin_original)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_vin_original = (TYPEOF(le.Input_other_unit_vin_original))'','',':other_unit_vin_original')
    #END
+    #IF( #TEXT(Input_other_unit_make_original)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_make_original = (TYPEOF(le.Input_other_unit_make_original))'','',':other_unit_make_original')
    #END
+    #IF( #TEXT(Input_other_unit_model_original)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_model_original = (TYPEOF(le.Input_other_unit_model_original))'','',':other_unit_model_original')
    #END
+    #IF( #TEXT(Input_other_unit_model_year_original)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_model_year_original = (TYPEOF(le.Input_other_unit_model_year_original))'','',':other_unit_model_year_original')
    #END
+    #IF( #TEXT(Input_source_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_id = (TYPEOF(le.Input_source_id))'','',':source_id')
    #END
+    #IF( #TEXT(Input_orig_fname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_fname = (TYPEOF(le.Input_orig_fname))'','',':orig_fname')
    #END
+    #IF( #TEXT(Input_orig_lname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lname = (TYPEOF(le.Input_orig_lname))'','',':orig_lname')
    #END
+    #IF( #TEXT(Input_orig_mname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mname = (TYPEOF(le.Input_orig_mname))'','',':orig_mname')
    #END
+    #IF( #TEXT(Input_initial_point_of_contact)='' )
      '' 
    #ELSE
        IF( le.Input_initial_point_of_contact = (TYPEOF(le.Input_initial_point_of_contact))'','',':initial_point_of_contact')
    #END
+    #IF( #TEXT(Input_vehicle_driveable)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_driveable = (TYPEOF(le.Input_vehicle_driveable))'','',':vehicle_driveable')
    #END
+    #IF( #TEXT(Input_drivers_license_type)='' )
      '' 
    #ELSE
        IF( le.Input_drivers_license_type = (TYPEOF(le.Input_drivers_license_type))'','',':drivers_license_type')
    #END
+    #IF( #TEXT(Input_alcohol_test_type_refused)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_test_type_refused = (TYPEOF(le.Input_alcohol_test_type_refused))'','',':alcohol_test_type_refused')
    #END
+    #IF( #TEXT(Input_alcohol_test_type_not_offered)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_test_type_not_offered = (TYPEOF(le.Input_alcohol_test_type_not_offered))'','',':alcohol_test_type_not_offered')
    #END
+    #IF( #TEXT(Input_alcohol_test_type_field)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_test_type_field = (TYPEOF(le.Input_alcohol_test_type_field))'','',':alcohol_test_type_field')
    #END
+    #IF( #TEXT(Input_alcohol_test_type_pbt)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_test_type_pbt = (TYPEOF(le.Input_alcohol_test_type_pbt))'','',':alcohol_test_type_pbt')
    #END
+    #IF( #TEXT(Input_alcohol_test_type_breath)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_test_type_breath = (TYPEOF(le.Input_alcohol_test_type_breath))'','',':alcohol_test_type_breath')
    #END
+    #IF( #TEXT(Input_alcohol_test_type_blood)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_test_type_blood = (TYPEOF(le.Input_alcohol_test_type_blood))'','',':alcohol_test_type_blood')
    #END
+    #IF( #TEXT(Input_alcohol_test_type_urine)='' )
      '' 
    #ELSE
        IF( le.Input_alcohol_test_type_urine = (TYPEOF(le.Input_alcohol_test_type_urine))'','',':alcohol_test_type_urine')
    #END
+    #IF( #TEXT(Input_trapped)='' )
      '' 
    #ELSE
        IF( le.Input_trapped = (TYPEOF(le.Input_trapped))'','',':trapped')
    #END
+    #IF( #TEXT(Input_dl_number_cdl_endorsements)='' )
      '' 
    #ELSE
        IF( le.Input_dl_number_cdl_endorsements = (TYPEOF(le.Input_dl_number_cdl_endorsements))'','',':dl_number_cdl_endorsements')
    #END
+    #IF( #TEXT(Input_dl_number_cdl_restrictions)='' )
      '' 
    #ELSE
        IF( le.Input_dl_number_cdl_restrictions = (TYPEOF(le.Input_dl_number_cdl_restrictions))'','',':dl_number_cdl_restrictions')
    #END
+    #IF( #TEXT(Input_dl_number_cdl_exempt)='' )
      '' 
    #ELSE
        IF( le.Input_dl_number_cdl_exempt = (TYPEOF(le.Input_dl_number_cdl_exempt))'','',':dl_number_cdl_exempt')
    #END
+    #IF( #TEXT(Input_dl_number_cdl_medical_card)='' )
      '' 
    #ELSE
        IF( le.Input_dl_number_cdl_medical_card = (TYPEOF(le.Input_dl_number_cdl_medical_card))'','',':dl_number_cdl_medical_card')
    #END
+    #IF( #TEXT(Input_interlock_device_in_use)='' )
      '' 
    #ELSE
        IF( le.Input_interlock_device_in_use = (TYPEOF(le.Input_interlock_device_in_use))'','',':interlock_device_in_use')
    #END
+    #IF( #TEXT(Input_drug_test_type_blood)='' )
      '' 
    #ELSE
        IF( le.Input_drug_test_type_blood = (TYPEOF(le.Input_drug_test_type_blood))'','',':drug_test_type_blood')
    #END
+    #IF( #TEXT(Input_drug_test_type_urine)='' )
      '' 
    #ELSE
        IF( le.Input_drug_test_type_urine = (TYPEOF(le.Input_drug_test_type_urine))'','',':drug_test_type_urine')
    #END
+    #IF( #TEXT(Input_traffic_control_condition)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_control_condition = (TYPEOF(le.Input_traffic_control_condition))'','',':traffic_control_condition')
    #END
+    #IF( #TEXT(Input_intersection_related)='' )
      '' 
    #ELSE
        IF( le.Input_intersection_related = (TYPEOF(le.Input_intersection_related))'','',':intersection_related')
    #END
+    #IF( #TEXT(Input_special_study_local)='' )
      '' 
    #ELSE
        IF( le.Input_special_study_local = (TYPEOF(le.Input_special_study_local))'','',':special_study_local')
    #END
+    #IF( #TEXT(Input_special_study_state)='' )
      '' 
    #ELSE
        IF( le.Input_special_study_state = (TYPEOF(le.Input_special_study_state))'','',':special_study_state')
    #END
+    #IF( #TEXT(Input_off_road_vehicle_involved)='' )
      '' 
    #ELSE
        IF( le.Input_off_road_vehicle_involved = (TYPEOF(le.Input_off_road_vehicle_involved))'','',':off_road_vehicle_involved')
    #END
+    #IF( #TEXT(Input_location_type2)='' )
      '' 
    #ELSE
        IF( le.Input_location_type2 = (TYPEOF(le.Input_location_type2))'','',':location_type2')
    #END
+    #IF( #TEXT(Input_speed_limit_posted)='' )
      '' 
    #ELSE
        IF( le.Input_speed_limit_posted = (TYPEOF(le.Input_speed_limit_posted))'','',':speed_limit_posted')
    #END
+    #IF( #TEXT(Input_traffic_control_damage_notify_date)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_control_damage_notify_date = (TYPEOF(le.Input_traffic_control_damage_notify_date))'','',':traffic_control_damage_notify_date')
    #END
+    #IF( #TEXT(Input_traffic_control_damage_notify_time)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_control_damage_notify_time = (TYPEOF(le.Input_traffic_control_damage_notify_time))'','',':traffic_control_damage_notify_time')
    #END
+    #IF( #TEXT(Input_traffic_control_damage_notify_name)='' )
      '' 
    #ELSE
        IF( le.Input_traffic_control_damage_notify_name = (TYPEOF(le.Input_traffic_control_damage_notify_name))'','',':traffic_control_damage_notify_name')
    #END
+    #IF( #TEXT(Input_public_property_damaged)='' )
      '' 
    #ELSE
        IF( le.Input_public_property_damaged = (TYPEOF(le.Input_public_property_damaged))'','',':public_property_damaged')
    #END
+    #IF( #TEXT(Input_replacement_report)='' )
      '' 
    #ELSE
        IF( le.Input_replacement_report = (TYPEOF(le.Input_replacement_report))'','',':replacement_report')
    #END
+    #IF( #TEXT(Input_deleted_report)='' )
      '' 
    #ELSE
        IF( le.Input_deleted_report = (TYPEOF(le.Input_deleted_report))'','',':deleted_report')
    #END
+    #IF( #TEXT(Input_next_street_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_next_street_prefix = (TYPEOF(le.Input_next_street_prefix))'','',':next_street_prefix')
    #END
+    #IF( #TEXT(Input_violator_name)='' )
      '' 
    #ELSE
        IF( le.Input_violator_name = (TYPEOF(le.Input_violator_name))'','',':violator_name')
    #END
+    #IF( #TEXT(Input_type_hazardous)='' )
      '' 
    #ELSE
        IF( le.Input_type_hazardous = (TYPEOF(le.Input_type_hazardous))'','',':type_hazardous')
    #END
+    #IF( #TEXT(Input_type_other)='' )
      '' 
    #ELSE
        IF( le.Input_type_other = (TYPEOF(le.Input_type_other))'','',':type_other')
    #END
+    #IF( #TEXT(Input_unit_type_and_axles1)='' )
      '' 
    #ELSE
        IF( le.Input_unit_type_and_axles1 = (TYPEOF(le.Input_unit_type_and_axles1))'','',':unit_type_and_axles1')
    #END
+    #IF( #TEXT(Input_unit_type_and_axles2)='' )
      '' 
    #ELSE
        IF( le.Input_unit_type_and_axles2 = (TYPEOF(le.Input_unit_type_and_axles2))'','',':unit_type_and_axles2')
    #END
+    #IF( #TEXT(Input_unit_type_and_axles3)='' )
      '' 
    #ELSE
        IF( le.Input_unit_type_and_axles3 = (TYPEOF(le.Input_unit_type_and_axles3))'','',':unit_type_and_axles3')
    #END
+    #IF( #TEXT(Input_unit_type_and_axles4)='' )
      '' 
    #ELSE
        IF( le.Input_unit_type_and_axles4 = (TYPEOF(le.Input_unit_type_and_axles4))'','',':unit_type_and_axles4')
    #END
+    #IF( #TEXT(Input_incident_damage_amount)='' )
      '' 
    #ELSE
        IF( le.Input_incident_damage_amount = (TYPEOF(le.Input_incident_damage_amount))'','',':incident_damage_amount')
    #END
+    #IF( #TEXT(Input_dot_use)='' )
      '' 
    #ELSE
        IF( le.Input_dot_use = (TYPEOF(le.Input_dot_use))'','',':dot_use')
    #END
+    #IF( #TEXT(Input_number_of_persons_involved)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_persons_involved = (TYPEOF(le.Input_number_of_persons_involved))'','',':number_of_persons_involved')
    #END
+    #IF( #TEXT(Input_unusual_road_condition_other_description)='' )
      '' 
    #ELSE
        IF( le.Input_unusual_road_condition_other_description = (TYPEOF(le.Input_unusual_road_condition_other_description))'','',':unusual_road_condition_other_description')
    #END
+    #IF( #TEXT(Input_number_of_narrative_sections)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_narrative_sections = (TYPEOF(le.Input_number_of_narrative_sections))'','',':number_of_narrative_sections')
    #END
+    #IF( #TEXT(Input_cad_number)='' )
      '' 
    #ELSE
        IF( le.Input_cad_number = (TYPEOF(le.Input_cad_number))'','',':cad_number')
    #END
+    #IF( #TEXT(Input_visibility)='' )
      '' 
    #ELSE
        IF( le.Input_visibility = (TYPEOF(le.Input_visibility))'','',':visibility')
    #END
+    #IF( #TEXT(Input_accident_at_intersection)='' )
      '' 
    #ELSE
        IF( le.Input_accident_at_intersection = (TYPEOF(le.Input_accident_at_intersection))'','',':accident_at_intersection')
    #END
+    #IF( #TEXT(Input_accident_not_at_intersection)='' )
      '' 
    #ELSE
        IF( le.Input_accident_not_at_intersection = (TYPEOF(le.Input_accident_not_at_intersection))'','',':accident_not_at_intersection')
    #END
+    #IF( #TEXT(Input_first_harmful_event_within_interchange)='' )
      '' 
    #ELSE
        IF( le.Input_first_harmful_event_within_interchange = (TYPEOF(le.Input_first_harmful_event_within_interchange))'','',':first_harmful_event_within_interchange')
    #END
+    #IF( #TEXT(Input_injury_involved)='' )
      '' 
    #ELSE
        IF( le.Input_injury_involved = (TYPEOF(le.Input_injury_involved))'','',':injury_involved')
    #END
+    #IF( #TEXT(Input_citation_status)='' )
      '' 
    #ELSE
        IF( le.Input_citation_status = (TYPEOF(le.Input_citation_status))'','',':citation_status')
    #END
+    #IF( #TEXT(Input_commercial_vehicle)='' )
      '' 
    #ELSE
        IF( le.Input_commercial_vehicle = (TYPEOF(le.Input_commercial_vehicle))'','',':commercial_vehicle')
    #END
+    #IF( #TEXT(Input_not_in_transport)='' )
      '' 
    #ELSE
        IF( le.Input_not_in_transport = (TYPEOF(le.Input_not_in_transport))'','',':not_in_transport')
    #END
+    #IF( #TEXT(Input_other_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_number = (TYPEOF(le.Input_other_unit_number))'','',':other_unit_number')
    #END
+    #IF( #TEXT(Input_other_unit_length)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_length = (TYPEOF(le.Input_other_unit_length))'','',':other_unit_length')
    #END
+    #IF( #TEXT(Input_other_unit_axles)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_axles = (TYPEOF(le.Input_other_unit_axles))'','',':other_unit_axles')
    #END
+    #IF( #TEXT(Input_other_unit_plate_expiration)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_plate_expiration = (TYPEOF(le.Input_other_unit_plate_expiration))'','',':other_unit_plate_expiration')
    #END
+    #IF( #TEXT(Input_other_unit_permanent_registration)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_permanent_registration = (TYPEOF(le.Input_other_unit_permanent_registration))'','',':other_unit_permanent_registration')
    #END
+    #IF( #TEXT(Input_other_unit_model_year2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_model_year2 = (TYPEOF(le.Input_other_unit_model_year2))'','',':other_unit_model_year2')
    #END
+    #IF( #TEXT(Input_other_unit_make2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_make2 = (TYPEOF(le.Input_other_unit_make2))'','',':other_unit_make2')
    #END
+    #IF( #TEXT(Input_other_unit_vin2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_vin2 = (TYPEOF(le.Input_other_unit_vin2))'','',':other_unit_vin2')
    #END
+    #IF( #TEXT(Input_other_unit_registration_state2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_registration_state2 = (TYPEOF(le.Input_other_unit_registration_state2))'','',':other_unit_registration_state2')
    #END
+    #IF( #TEXT(Input_other_unit_registration_year2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_registration_year2 = (TYPEOF(le.Input_other_unit_registration_year2))'','',':other_unit_registration_year2')
    #END
+    #IF( #TEXT(Input_other_unit_license_plate2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_license_plate2 = (TYPEOF(le.Input_other_unit_license_plate2))'','',':other_unit_license_plate2')
    #END
+    #IF( #TEXT(Input_other_unit_number2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_number2 = (TYPEOF(le.Input_other_unit_number2))'','',':other_unit_number2')
    #END
+    #IF( #TEXT(Input_other_unit_length2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_length2 = (TYPEOF(le.Input_other_unit_length2))'','',':other_unit_length2')
    #END
+    #IF( #TEXT(Input_other_unit_axles2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_axles2 = (TYPEOF(le.Input_other_unit_axles2))'','',':other_unit_axles2')
    #END
+    #IF( #TEXT(Input_other_unit_plate_expiration2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_plate_expiration2 = (TYPEOF(le.Input_other_unit_plate_expiration2))'','',':other_unit_plate_expiration2')
    #END
+    #IF( #TEXT(Input_other_unit_permanent_registration2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_permanent_registration2 = (TYPEOF(le.Input_other_unit_permanent_registration2))'','',':other_unit_permanent_registration2')
    #END
+    #IF( #TEXT(Input_other_unit_type2)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_type2 = (TYPEOF(le.Input_other_unit_type2))'','',':other_unit_type2')
    #END
+    #IF( #TEXT(Input_other_unit_model_year3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_model_year3 = (TYPEOF(le.Input_other_unit_model_year3))'','',':other_unit_model_year3')
    #END
+    #IF( #TEXT(Input_other_unit_make3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_make3 = (TYPEOF(le.Input_other_unit_make3))'','',':other_unit_make3')
    #END
+    #IF( #TEXT(Input_other_unit_vin3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_vin3 = (TYPEOF(le.Input_other_unit_vin3))'','',':other_unit_vin3')
    #END
+    #IF( #TEXT(Input_other_unit_registration_state3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_registration_state3 = (TYPEOF(le.Input_other_unit_registration_state3))'','',':other_unit_registration_state3')
    #END
+    #IF( #TEXT(Input_other_unit_registration_year3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_registration_year3 = (TYPEOF(le.Input_other_unit_registration_year3))'','',':other_unit_registration_year3')
    #END
+    #IF( #TEXT(Input_other_unit_license_plate3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_license_plate3 = (TYPEOF(le.Input_other_unit_license_plate3))'','',':other_unit_license_plate3')
    #END
+    #IF( #TEXT(Input_other_unit_number3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_number3 = (TYPEOF(le.Input_other_unit_number3))'','',':other_unit_number3')
    #END
+    #IF( #TEXT(Input_other_unit_length3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_length3 = (TYPEOF(le.Input_other_unit_length3))'','',':other_unit_length3')
    #END
+    #IF( #TEXT(Input_other_unit_axles3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_axles3 = (TYPEOF(le.Input_other_unit_axles3))'','',':other_unit_axles3')
    #END
+    #IF( #TEXT(Input_other_unit_plate_expiration3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_plate_expiration3 = (TYPEOF(le.Input_other_unit_plate_expiration3))'','',':other_unit_plate_expiration3')
    #END
+    #IF( #TEXT(Input_other_unit_permanent_registration3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_permanent_registration3 = (TYPEOF(le.Input_other_unit_permanent_registration3))'','',':other_unit_permanent_registration3')
    #END
+    #IF( #TEXT(Input_other_unit_type3)='' )
      '' 
    #ELSE
        IF( le.Input_other_unit_type3 = (TYPEOF(le.Input_other_unit_type3))'','',':other_unit_type3')
    #END
+    #IF( #TEXT(Input_damaged_areas3)='' )
      '' 
    #ELSE
        IF( le.Input_damaged_areas3 = (TYPEOF(le.Input_damaged_areas3))'','',':damaged_areas3')
    #END
+    #IF( #TEXT(Input_driver_distracted_by)='' )
      '' 
    #ELSE
        IF( le.Input_driver_distracted_by = (TYPEOF(le.Input_driver_distracted_by))'','',':driver_distracted_by')
    #END
+    #IF( #TEXT(Input_non_motorist_type)='' )
      '' 
    #ELSE
        IF( le.Input_non_motorist_type = (TYPEOF(le.Input_non_motorist_type))'','',':non_motorist_type')
    #END
+    #IF( #TEXT(Input_seating_position_row)='' )
      '' 
    #ELSE
        IF( le.Input_seating_position_row = (TYPEOF(le.Input_seating_position_row))'','',':seating_position_row')
    #END
+    #IF( #TEXT(Input_seating_position_seat)='' )
      '' 
    #ELSE
        IF( le.Input_seating_position_seat = (TYPEOF(le.Input_seating_position_seat))'','',':seating_position_seat')
    #END
+    #IF( #TEXT(Input_seating_position_description)='' )
      '' 
    #ELSE
        IF( le.Input_seating_position_description = (TYPEOF(le.Input_seating_position_description))'','',':seating_position_description')
    #END
+    #IF( #TEXT(Input_transported_id_number)='' )
      '' 
    #ELSE
        IF( le.Input_transported_id_number = (TYPEOF(le.Input_transported_id_number))'','',':transported_id_number')
    #END
+    #IF( #TEXT(Input_witness_number)='' )
      '' 
    #ELSE
        IF( le.Input_witness_number = (TYPEOF(le.Input_witness_number))'','',':witness_number')
    #END
+    #IF( #TEXT(Input_date_of_birth_derived)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_birth_derived = (TYPEOF(le.Input_date_of_birth_derived))'','',':date_of_birth_derived')
    #END
+    #IF( #TEXT(Input_property_damage_id)='' )
      '' 
    #ELSE
        IF( le.Input_property_damage_id = (TYPEOF(le.Input_property_damage_id))'','',':property_damage_id')
    #END
+    #IF( #TEXT(Input_property_owner_name)='' )
      '' 
    #ELSE
        IF( le.Input_property_owner_name = (TYPEOF(le.Input_property_owner_name))'','',':property_owner_name')
    #END
+    #IF( #TEXT(Input_damage_description)='' )
      '' 
    #ELSE
        IF( le.Input_damage_description = (TYPEOF(le.Input_damage_description))'','',':damage_description')
    #END
+    #IF( #TEXT(Input_damage_estimate)='' )
      '' 
    #ELSE
        IF( le.Input_damage_estimate = (TYPEOF(le.Input_damage_estimate))'','',':damage_estimate')
    #END
+    #IF( #TEXT(Input_narrative)='' )
      '' 
    #ELSE
        IF( le.Input_narrative = (TYPEOF(le.Input_narrative))'','',':narrative')
    #END
+    #IF( #TEXT(Input_narrative_continuance)='' )
      '' 
    #ELSE
        IF( le.Input_narrative_continuance = (TYPEOF(le.Input_narrative_continuance))'','',':narrative_continuance')
    #END
+    #IF( #TEXT(Input_hazardous_materials_hazmat_placard_number1)='' )
      '' 
    #ELSE
        IF( le.Input_hazardous_materials_hazmat_placard_number1 = (TYPEOF(le.Input_hazardous_materials_hazmat_placard_number1))'','',':hazardous_materials_hazmat_placard_number1')
    #END
+    #IF( #TEXT(Input_hazardous_materials_hazmat_placard_number2)='' )
      '' 
    #ELSE
        IF( le.Input_hazardous_materials_hazmat_placard_number2 = (TYPEOF(le.Input_hazardous_materials_hazmat_placard_number2))'','',':hazardous_materials_hazmat_placard_number2')
    #END
+    #IF( #TEXT(Input_vendor_code)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_code = (TYPEOF(le.Input_vendor_code))'','',':vendor_code')
    #END
+    #IF( #TEXT(Input_report_property_damage)='' )
      '' 
    #ELSE
        IF( le.Input_report_property_damage = (TYPEOF(le.Input_report_property_damage))'','',':report_property_damage')
    #END
+    #IF( #TEXT(Input_report_collision_type)='' )
      '' 
    #ELSE
        IF( le.Input_report_collision_type = (TYPEOF(le.Input_report_collision_type))'','',':report_collision_type')
    #END
+    #IF( #TEXT(Input_report_first_harmful_event)='' )
      '' 
    #ELSE
        IF( le.Input_report_first_harmful_event = (TYPEOF(le.Input_report_first_harmful_event))'','',':report_first_harmful_event')
    #END
+    #IF( #TEXT(Input_report_light_condition)='' )
      '' 
    #ELSE
        IF( le.Input_report_light_condition = (TYPEOF(le.Input_report_light_condition))'','',':report_light_condition')
    #END
+    #IF( #TEXT(Input_report_weather_condition)='' )
      '' 
    #ELSE
        IF( le.Input_report_weather_condition = (TYPEOF(le.Input_report_weather_condition))'','',':report_weather_condition')
    #END
+    #IF( #TEXT(Input_report_road_condition)='' )
      '' 
    #ELSE
        IF( le.Input_report_road_condition = (TYPEOF(le.Input_report_road_condition))'','',':report_road_condition')
    #END
+    #IF( #TEXT(Input_report_injury_status)='' )
      '' 
    #ELSE
        IF( le.Input_report_injury_status = (TYPEOF(le.Input_report_injury_status))'','',':report_injury_status')
    #END
+    #IF( #TEXT(Input_report_damage_extent)='' )
      '' 
    #ELSE
        IF( le.Input_report_damage_extent = (TYPEOF(le.Input_report_damage_extent))'','',':report_damage_extent')
    #END
+    #IF( #TEXT(Input_report_vehicle_type)='' )
      '' 
    #ELSE
        IF( le.Input_report_vehicle_type = (TYPEOF(le.Input_report_vehicle_type))'','',':report_vehicle_type')
    #END
+    #IF( #TEXT(Input_report_traffic_control_device_type)='' )
      '' 
    #ELSE
        IF( le.Input_report_traffic_control_device_type = (TYPEOF(le.Input_report_traffic_control_device_type))'','',':report_traffic_control_device_type')
    #END
+    #IF( #TEXT(Input_report_contributing_circumstances_v)='' )
      '' 
    #ELSE
        IF( le.Input_report_contributing_circumstances_v = (TYPEOF(le.Input_report_contributing_circumstances_v))'','',':report_contributing_circumstances_v')
    #END
+    #IF( #TEXT(Input_report_vehicle_maneuver_action_prior)='' )
      '' 
    #ELSE
        IF( le.Input_report_vehicle_maneuver_action_prior = (TYPEOF(le.Input_report_vehicle_maneuver_action_prior))'','',':report_vehicle_maneuver_action_prior')
    #END
+    #IF( #TEXT(Input_report_vehicle_body_type)='' )
      '' 
    #ELSE
        IF( le.Input_report_vehicle_body_type = (TYPEOF(le.Input_report_vehicle_body_type))'','',':report_vehicle_body_type')
    #END
+    #IF( #TEXT(Input_cru_agency_name)='' )
      '' 
    #ELSE
        IF( le.Input_cru_agency_name = (TYPEOF(le.Input_cru_agency_name))'','',':cru_agency_name')
    #END
+    #IF( #TEXT(Input_cru_agency_id)='' )
      '' 
    #ELSE
        IF( le.Input_cru_agency_id = (TYPEOF(le.Input_cru_agency_id))'','',':cru_agency_id')
    #END
+    #IF( #TEXT(Input_cname)='' )
      '' 
    #ELSE
        IF( le.Input_cname = (TYPEOF(le.Input_cname))'','',':cname')
    #END
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
    #END
+    #IF( #TEXT(Input_vendor_report_id)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_report_id = (TYPEOF(le.Input_vendor_report_id))'','',':vendor_report_id')
    #END
+    #IF( #TEXT(Input_is_available_for_public)='' )
      '' 
    #ELSE
        IF( le.Input_is_available_for_public = (TYPEOF(le.Input_is_available_for_public))'','',':is_available_for_public')
    #END
+    #IF( #TEXT(Input_has_addendum)='' )
      '' 
    #ELSE
        IF( le.Input_has_addendum = (TYPEOF(le.Input_has_addendum))'','',':has_addendum')
    #END
+    #IF( #TEXT(Input_report_agency_ori)='' )
      '' 
    #ELSE
        IF( le.Input_report_agency_ori = (TYPEOF(le.Input_report_agency_ori))'','',':report_agency_ori')
    #END
+    #IF( #TEXT(Input_report_status)='' )
      '' 
    #ELSE
        IF( le.Input_report_status = (TYPEOF(le.Input_report_status))'','',':report_status')
    #END
+    #IF( #TEXT(Input_super_report_id)='' )
      '' 
    #ELSE
        IF( le.Input_super_report_id = (TYPEOF(le.Input_super_report_id))'','',':super_report_id')
    #END
;
    #IF (#TEXT(report_code)<>'')
    SELF.source := le.report_code;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(report_code)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(report_code)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(report_code)<>'' ) source, #END -cnt );
ENDMACRO;
