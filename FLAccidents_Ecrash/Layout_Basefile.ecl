﻿EXPORT Layout_Basefile := RECORD,MAXLENGTH(40000)
	STRING8 date_vendor_first_reported;
	STRING8 date_vendor_last_reported;
	STRING8 dt_first_seen;
	STRING8 dt_last_seen;
	STRING2 report_code;
	STRING25 report_category;
	STRING65 report_code_desc;
	STRING11 citation_id;
	STRING19 creation_date;
	STRING11 incident_id;
	STRING7 citation_issued;
	STRING20 citation_number1;
	STRING20 citation_number2;
	STRING30 section_number1;
	STRING10 court_date;
	STRING9 court_time;
	STRING200 citation_detail1;
	STRING3 local_code;
	STRING30 violation_code1;
	STRING30 violation_code2;
	STRING7 multiple_charges_indicator;
	STRING7 dui_indicator;
	STRING11 commercial_id;
	STRING9 vehicle_id;
	STRING20 commercial_info_source;
	STRING30 commercial_vehicle_type;
	STRING50 motor_carrier_id_dot_number;
	STRING15 motor_carrier_id_state_id;
	STRING120 motor_carrier_id_carrier_name;
	STRING80 motor_carrier_id_address;
	STRING40 motor_carrier_id_city;
	STRING20 motor_carrier_id_state;
	STRING10 motor_carrier_id_zipcode;
	STRING20 motor_carrier_id_commercial_indicator;
	STRING20 carrier_id_type;
	STRING15 carrier_unit_number;
	STRING20 dot_permit_number;
	STRING7 iccmc_number;
	STRING7 mcs_vehicle_inspection;
	STRING20 mcs_form_number;
	STRING7 mcs_out_of_service;
	STRING7 mcs_violation_related;
	STRING1 number_of_axles;
	STRING2 number_of_tires;
	STRING7 gvw_over_10k_pounds;
	STRING50 weight_rating;
	STRING20 registered_gross_vehicle_weight;
	STRING3 vehicle_length_feet;
	STRING100 cargo_body_type;
	STRING20 load_type;
	STRING7 oversize_load;
	STRING70 vehicle_configuration;
	STRING20 trailer1_type;
	STRING3 trailer1_length_feet;
	STRING2 trailer1_width_feet;
	STRING20 trailer2_type;
	STRING3 trailer2_length_feet;
	STRING2 trailer2_width_feet;
	STRING7 federally_reportable;
	STRING7 vehicle_inspection_hazmat;
	STRING20 hazmat_form_number;
	STRING7 hazmt_out_of_service;
	STRING7 hazmat_violation_related;
	STRING15 hazardous_materials_placard;
	STRING1 hazardous_materials_class_number1;
	STRING1 hazardous_materials_class_number2;
	STRING20 hazmat_placard_name;
	STRING15 hazardous_materials_released1;
	STRING15 hazardous_materials_released2;
	STRING15 hazardous_materials_released3;
	STRING15 hazardous_materials_released4;
	STRING30 commercial_event1;
	STRING30 commercial_event2;
	STRING30 commercial_event3;
	STRING30 commercial_event4;
	STRING20 recommended_driver_reexam;
	STRING3 transporting_hazmat;
	STRING20 liquid_hazmat_volume;
	STRING3 oversize_vehicle;
	STRING3 overlength_vehicle;
	STRING3 oversize_vehicle_permitted;
	STRING3 overlength_vehicle_permitted;
	STRING12 carrier_phone_number;
	STRING50 commerce_type;
	STRING3 citation_issued_to_vehicle;
	STRING10 cdl_class;
	STRING2 dot_state;
	STRING30 fire_hazardous_materials_involvement;
	STRING200 commercial_event_description;
	STRING7 supplment_required_hazmat_placard;
	STRING15 other_state_number1;
	STRING15 other_state_number2;
	STRING4 work_type_id;
	STRING11 report_id;
	STRING11 agency_id;
	STRING19 sent_to_hpcc_datetime;
	STRING4 corrected_incident;
	STRING9 cru_order_id;
	STRING1 cru_sequence_nbr;
	STRING2 loss_state_abbr;
	STRING3 report_type_id;
	STRING64 hash_key;
	STRING40 case_identifier;
	STRING50 crash_county;
	STRING4 county_cd;
	STRING50 crash_cityplace;
	STRING50 crash_city;
	STRING4 city_code;
	STRING110 first_harmful_event;
	STRING40 first_harmful_event_location;
	STRING30 manner_crash_impact1;
	STRING40 weather_condition1;
	STRING40 weather_condition2;
	STRING40 light_condition1;
	STRING40 light_condition2;
	STRING40 road_surface_condition;
	STRING40 contributing_circumstances_environmental1;
	STRING40 contributing_circumstances_environmental2;
	STRING40 contributing_circumstances_environmental3;
	STRING40 contributing_circumstances_environmental4;
	STRING60 contributing_circumstances_road1;
	STRING60 contributing_circumstances_road2;
	STRING60 contributing_circumstances_road3;
	STRING40 contributing_circumstances_road4;
	STRING100 relation_to_junction;
	STRING30 intersection_type;
	STRING50 school_bus_related;
	STRING30 work_zone_related;
	STRING50 work_zone_location;
	STRING30 work_zone_type;
	STRING7 work_zone_workers_present;
	STRING30 work_zone_law_enforcement_present;
	STRING25 crash_severity;
	STRING3 number_of_vehicles;
	STRING3 total_nonfatal_injuries;
	STRING3 total_fatal_injuries;
	STRING9 day_of_week;
	STRING20 roadway_curvature;
	STRING7 part_of_national_highway_system;
	STRING40 roadway_functional_class;
	STRING25 access_control;
	STRING25 rr_crossing_id;
	STRING30 roadway_lighting;
	STRING30 traffic_control_type_at_intersection1;
	STRING30 traffic_control_type_at_intersection2;
	STRING15 ncic_number;
	STRING40 state_report_number;
	STRING9 ori_number;
	STRING10 crash_date;
	STRING9 crash_time;
	STRING12 lattitude;
	STRING18 longitude;
	STRING6 milepost1;
	STRING6 milepost2;
	STRING20 address_number;
	STRING100 loss_street;
	STRING10 loss_street_route_number;
	STRING100 loss_street_type;
	STRING3 loss_street_speed_limit;
	STRING30 incident_location_indicator;
	STRING100 loss_cross_street;
	STRING10 loss_cross_street_route_number;
	STRING4 loss_cross_street_intersecting_route_segment;
	STRING30 loss_cross_street_type;
	STRING2 loss_cross_street_speed_limit;
	STRING2 loss_cross_street_number_of_lanes;
	STRING10 loss_cross_street_orientation;
	STRING7 loss_cross_street_route_sign;
	STRING10 at_node_number;
	STRING5 distance_from_node_feet;
	STRING5 distance_from_node_miles;
	STRING10 next_node_number;
	STRING10 next_roadway_node_number;
	STRING10 direction_of_travel;
	STRING60 next_street;
	STRING30 next_street_type;
	STRING15 next_street_suffix;
	STRING5 before_or_after_next_street;
	STRING5 next_street_distance_feet;
	STRING5 next_street_distance_miles;
	STRING5 next_street_direction;
	STRING4 next_street_route_segment;
	STRING60 continuing_toward_street;
	STRING20 continuing_street_suffix;
	STRING5 continuing_street_direction;
	STRING4 continuting_street_route_segment;
	STRING30 city_type;
	STRING7 outside_city_indicator;
	STRING25 outside_city_direction;
	STRING5 outside_city_distance_feet;
	STRING5 outside_city_distance_miles;
	STRING30 crash_type;
	STRING30 motor_vehicle_involved_with;
	STRING30 report_investigation_type;
	STRING7 incident_hit_and_run;
	STRING7 tow_away;
	STRING10 date_notified;
	STRING9 time_notified;
	STRING10 notification_method;
	STRING9 officer_arrival_time;
	STRING10 officer_report_date;
	STRING9 officer_report_time;
	STRING12 officer_id;
	STRING30 officer_department;
	STRING30 officer_rank;
	STRING30 officer_command;
	STRING20 officer_tax_id_number;
	STRING10 completed_report_date;
	STRING10 supervisor_check_date;
	STRING9 supervisor_check_time;
	STRING12 supervisor_id;
	STRING20 supervisor_rank;
	STRING60 reviewers_name;
	STRING30 road_surface;
	STRING30 roadway_alignment;
	STRING30 traffic_way_description;
	STRING60 traffic_flow;
	STRING7 property_damage_involved;
	STRING200 property_damage_description1;
	STRING200 property_damage_description2;
	STRING7 property_damage_estimate1;
	STRING7 property_damage_estimate2;
	STRING7 incident_damage_over_limit;
	STRING7 property_owner_notified;
	STRING7 government_property;
	STRING30 accident_condition;
	STRING30 unusual_road_condition1;
	STRING30 unusual_road_condition2;
	STRING2 number_of_lanes;
	STRING10 divided_highway;
	STRING110 most_harmful_event;
	STRING110 second_harmful_event;
	STRING10 ems_notified_date;
	STRING10 ems_arrival_date;
	STRING10 hospital_arrival_date;
	STRING60 injured_taken_by;
	STRING60 injured_taken_to;
	STRING7 incident_transported_for_medical_care;
	STRING7 photographs_taken;
	STRING60 photographed_by;
	STRING20 photographer_id;
	STRING50 photography_agency_name;
	STRING100 agency_name;
	STRING30 judicial_district;
	STRING30 precinct;
	STRING20 beat;
	STRING30 location_type;
	STRING10 shoulder_type;
	STRING7 investigation_complete;
	STRING50 investigation_not_complete_why;
	STRING100 investigating_officer_name;
	STRING7 investigation_notification_issued;
	STRING30 agency_type;
	STRING40 no_injury_tow_involved;
	STRING40 injury_tow_involved;
	STRING20 lars_code1;
	STRING20 lars_code2;
	STRING7 private_property_incident;
	STRING20 accident_involvement;
	STRING50 local_use;
	STRING9 street_prefix;
	STRING15 street_suffix;
	STRING7 toll_road;
	STRING50 street_description;
	STRING10 cross_street_address_number;
	STRING9 cross_street_prefix;
	STRING15 cross_street_suffix;
	STRING3 report_complete;
	STRING7 dispatch_notified;
	STRING3 counter_report;
	STRING30 road_type;
	STRING30 agency_code;
	STRING3 public_property_employee;
	STRING3 bridge_related;
	STRING3 ramp_indicator;
	STRING4 to_or_from_location;
	STRING10 complaint_number;
	STRING7 school_zone_related;
	STRING7 notify_dot_maintenance;
	STRING10 special_location;
	STRING4 route_segment;
	STRING7 route_sign;
	STRING15 route_category_street;
	STRING15 route_category_cross_street;
	STRING15 route_category_next_street;
	STRING15 lane_closed;
	STRING15 lane_closure_direction;
	STRING5 lane_direction;
	STRING7 traffic_detoured;
	STRING15 time_closed;
	STRING20 pedestrian_signals;
	STRING2 work_zone_speed_limit;
	STRING7 work_zone_shoulder_median;
	STRING7 work_zone_intermittent_moving;
	STRING7 work_zone_flagger_control;
	STRING30 special_work_zone_characteristics;
	STRING10 lane_number;
	STRING3 offset_distance_feet;
	STRING5 offset_distance_miles;
	STRING10 offset_direction;
	STRING15 asru_code;
	STRING20 mp_grid;
	STRING2 number_of_qualifying_units;
	STRING2 number_of_hazmat_vehicles;
	STRING2 number_of_buses_involved;
	STRING2 number_taken_to_treatment;
	STRING2 number_vehicles_towed;
	STRING2 vehicle_at_fault_unit_number;
	STRING20 time_officer_cleared_scene;
	STRING12 total_minutes_on_scene;
	STRING60 motorists_report;
	STRING7 fatality_involved;
	STRING20 local_dot_index_number;
	STRING20 dor_number;
	STRING5 hospital_code;
	STRING30 special_jurisdiction;
	STRING50 document_type;
	STRING7 distance_was_measured;
	STRING10 street_orientation;
	STRING4 intersecting_route_segment;
	STRING40 primary_fault_indicator;
	STRING100 first_harmful_event_pedestrian;
	STRING12 reference_markers;
	STRING80 other_officer_on_scene;
	STRING12 other_officer_badge_number;
	STRING12 supplemental_report;
	STRING30 supplemental_type;
	STRING12 amended_report;
	STRING12 corrected_report;
	STRING7 state_highway_related;
	STRING30 roadway_lighting_condition;
	STRING35 vendor_reference_number;
	STRING5 duplicate_copy_unit_number;
	STRING40 other_city_agency_description;
	STRING255 notifcation_description;
	STRING30 primary_collision_improper_driving_description;
	STRING30 weather_other_description;
	STRING30 crash_type_description;
	STRING30 motor_vehicle_involved_with_animal_description;
	STRING30 motor_vehicle_involved_with_fixed_object_description;
	STRING30 motor_vehicle_involved_with_other_object_description;
	STRING4 other_investigation_time;
	STRING100 milepost_detail;
	STRING10 utility_pole_number1;
	STRING10 utility_pole_number2;
	STRING10 utility_pole_number3;
	STRING11 person_id;
	STRING3 person_number;
	STRING3 vehicle_unit_number;
	STRING8 sex;
	STRING100 person_type;
	STRING30 injury_status;
	STRING3 occupant_vehicle_unit_number;
	STRING50 seating_position1;
	STRING40 safety_equipment_restraint1;
	STRING40 safety_equipment_restraint2;
	STRING40 safety_equipment_helmet;
	STRING100 air_bag_deployed;
	STRING20 ejection;
	STRING30 drivers_license_jurisdiction;
	STRING30 dl_number_class;
	STRING3 dl_number_cdl;
	STRING50 dl_number_endorsements;
	STRING100 driver_actions_at_time_of_crash1;
	STRING100 driver_actions_at_time_of_crash2;
	STRING100 driver_actions_at_time_of_crash3;
	STRING100 driver_actions_at_time_of_crash4;
	STRING20 violation_codes;
	STRING50 condition_at_time_of_crash1;
	STRING50 condition_at_time_of_crash2;
	STRING50 law_enforcement_suspects_alcohol_use;
	STRING25 alcohol_test_status;
	STRING25 alcohol_test_type;
	STRING25 alcohol_test_result;
	STRING7 law_enforcement_suspects_drug_use;
	STRING20 drug_test_given;
	STRING100 non_motorist_actions_prior_to_crash1;
	STRING100 non_motorist_actions_prior_to_crash2;
	STRING100 non_motorist_actions_at_time_of_crash;
	STRING50 non_motorist_location_at_time_of_crash;
	STRING50 non_motorist_safety_equipment1;
	STRING3 age;
	STRING50 driver_license_restrictions1;
	STRING10 drug_test_type;
	STRING25 drug_test_result1;
	STRING50 drug_test_result2;
	STRING50 drug_test_result3;
	STRING50 drug_test_result4;
	STRING25 injury_area;
	STRING200 injury_description;
	STRING7 motorcyclist_head_injury;
	STRING3 party_id;
	STRING7 same_as_driver;
	STRING7 address_same_as_driver;
	STRING100 last_name;
	STRING40 first_name;
	STRING40 middle_name;
	STRING3 name_suffx;
	STRING10 date_of_birth;
	STRING100 address;
	STRING50 city;
	STRING2 state;
	STRING10 zip_code;
	STRING20 home_phone;
	STRING20 business_phone;
	STRING100 insurance_company;
	STRING20 insurance_company_phone_number;
	STRING50 insurance_policy_number;
	STRING30 insurance_effective_date;
	STRING11 ssn;
	STRING25 drivers_license_number;
	STRING12 drivers_license_expiration;
	STRING15 eye_color;
	STRING15 hair_color;
	STRING10 height;
	STRING3 weight;
	STRING25 race;
	STRING7 pedestrian_cyclist_visibility;
	STRING35 first_aid_by;
	STRING20 person_first_aid_party_type;
	STRING30 person_first_aid_party_type_description;
	STRING7 deceased_at_scene;
	STRING10 death_date;
	STRING9 death_time;
	STRING7 extricated;
	STRING40 alcohol_drug_use;
	STRING40 physical_defects;
	STRING40 driver_residence;
	STRING30 id_type;
	STRING7 proof_of_insurance;
	STRING3 insurance_expired;
	STRING3 insurance_exempt;
	STRING50 insurance_type;
	STRING3 violent_crime_victim_notified;
	STRING10 insurance_company_code;
	STRING3 refused_medical_treatment;
	STRING10 safety_equipment_available_or_used;
	STRING10 apartment_number;
	STRING10 licensed_driver;
	STRING30 physical_emotional_status;
	STRING20 driver_presence;
	STRING20 ejection_path;
	STRING20 state_person_id;
	STRING3 contributed_to_collision;
	STRING7 person_transported_for_medical_care;
	STRING60 transported_by_agency_type;
	STRING60 transported_to;
	STRING25 non_motorist_driver_license_number;
	STRING25 air_bag_type;
	STRING20 cell_phone_use;
	STRING30 driver_license_restriction_compliance;
	STRING30 driver_license_endorsement_compliance;
	STRING30 driver_license_compliance;
	STRING110 contributing_circumstances_p1;
	STRING110 contributing_circumstances_p2;
	STRING110 contributing_circumstances_p3;
	STRING110 contributing_circumstances_p4;
	STRING3 passenger_number;
	STRING7 person_deleted;
	STRING10 owner_lessee;
	STRING7 driver_charged;
	STRING7 motorcycle_eye_protection;
	STRING7 motorcycle_long_sleeves;
	STRING7 motorcycle_long_pants;
	STRING7 motorcycle_over_ankle_boots;
	STRING40 contributing_circumstances_environmental_non_incident1;
	STRING40 contributing_circumstances_environmental_non_incident2;
	STRING7 alcohol_drug_test_given;
	STRING10 alcohol_drug_test_type;
	STRING20 alcohol_drug_test_result;
	STRING30 vin;
	STRING5 vin_status;
	STRING20 damaged_areas_derived1;
	STRING20 damaged_areas_derived2;
	STRING4 airbags_deployed_derived;
	STRING4 vehicle_towed_derived;
	STRING15 unit_type;
	STRING3 unit_number;
	STRING2 registration_state;
	STRING10 registration_year;
	STRING12 license_plate;
	STRING100 make;
	STRING10 model_yr;
	STRING100 model;
	STRING60 body_type_category;
	STRING3 total_occupants_in_vehicle;
	STRING30 special_function_in_transport;
	STRING30 special_function_in_transport_other_unit;
	STRING7 emergency_use;
	STRING2 posted_satutory_speed_limit;
	STRING15 direction_of_travel_before_crash;
	STRING60 trafficway_description;
	STRING50 traffic_control_device_type;
	STRING40 vehicle_maneuver_action_prior1;
	STRING40 vehicle_maneuver_action_prior2;
	STRING30 impact_area1;
	STRING20 impact_area2;
	STRING100 event_sequence1;
	STRING100 event_sequence2;
	STRING100 event_sequence3;
	STRING100 event_sequence4;
	STRING60 most_harmful_event_for_vehicle;
	STRING50 bus_use;
	STRING25 vehicle_hit_and_run;
	STRING7 vehicle_towed;
	STRING60 contributing_circumstances_v1;
	STRING60 contributing_circumstances_v2;
	STRING60 contributing_circumstances_v3;
	STRING60 contributing_circumstances_v4;
	STRING60 on_street;
	STRING15 vehicle_color;
	STRING3 estimated_speed;
	STRING7 accident_investigation_site;
	STRING7 car_fire;
	STRING36 vehicle_damage_amount;
	STRING50 contributing_factors1;
	STRING50 contributing_factors2;
	STRING50 contributing_factors3;
	STRING50 contributing_factors4;
	STRING50 other_contributing_factors1;
	STRING50 other_contributing_factors2;
	STRING50 other_contributing_factors3;
	STRING25 vision_obscured1;
	STRING25 vision_obscured2;
	STRING7 vehicle_on_road;
	STRING7 ran_off_road;
	STRING21 skidding_occurred;
	STRING100 vehicle_incident_location1;
	STRING100 vehicle_incident_location2;
	STRING100 vehicle_incident_location3;
	STRING7 vehicle_disabled;
	STRING50 vehicle_removed_to;
	STRING50 removed_by;
	STRING30 tow_requested_by_driver;
	STRING7 solicitation;
	STRING7 other_unit_vehicle_damage_amount;
	STRING10 other_unit_model_year;
	STRING20 other_unit_make;
	STRING30 other_unit_model;
	STRING25 other_unit_vin;
	STRING5 other_unit_vin_status;
	STRING30 other_unit_body_type_category;
	STRING2 other_unit_registration_state;
	STRING10 other_unit_registration_year;
	STRING12 other_unit_license_plate;
	STRING30 other_unit_color;
	STRING30 other_unit_type;
	STRING70 damaged_areas1;
	STRING70 damaged_areas2;
	STRING10 parked_vehicle;
	STRING60 damage_rating1;
	STRING60 damage_rating2;
	STRING3 vehicle_inventoried;
	STRING7 vehicle_defect_apparent;
	STRING50 defect_may_have_contributed1;
	STRING50 defect_may_have_contributed2;
	STRING12 registration_expiration;
	STRING50 owner_driver_type;
	STRING50 make_code;
	STRING2 number_trailing_units;
	STRING25 vehicle_position;
	STRING25 vehicle_type;
	STRING8 motorcycle_engine_size;
	STRING7 motorcycle_driver_educated;
	STRING20 motorcycle_helmet_type;
	STRING7 motorcycle_passenger;
	STRING7 motorcycle_helmet_stayed_on;
	STRING7 motorcycle_helmet_dot_snell;
	STRING7 motorcycle_saddlebag_trunk;
	STRING7 motorcycle_trailer;
	STRING7 pedacycle_passenger;
	STRING7 pedacycle_headlights;
	STRING7 pedacycle_helmet;
	STRING7 pedacycle_rear_reflectors;
	STRING3 cdl_required;
	STRING3 truck_bus_supplement_required;
	STRING6 unit_damage_amount;
	STRING25 airbag_switch;
	STRING30 underride_override_damage;
	STRING30 vehicle_attachment;
	STRING30 action_on_impact;
	STRING15 speed_detection_method;
	STRING25 non_motorist_direction_of_travel_from;
	STRING25 non_motorist_direction_of_travel_to;
	STRING30 vehicle_use;
	STRING10 department_unit_number;
	STRING30 equipment_in_use_at_time_of_accident;
	STRING50 actions_of_police_vehicle;
	STRING30 vehicle_command_id;
	STRING7 traffic_control_device_inoperative;
	STRING20 direction_of_impact1;
	STRING20 direction_of_impact2;
	STRING7 ran_off_road_direction;
	STRING17 vin_other_unit_number;
	STRING20 damaged_area_generic;
	STRING30 vision_obscured_description;
	STRING30 inattention_description;
	STRING30 contributing_circumstances_defect_description;
	STRING30 contributing_circumstances_other_descriptioin;
	STRING30 vehicle_maneuver_action_prior_other_description;
	STRING35 vehicle_special_use;
	STRING30 vehicle_type_extended1;
	STRING30 vehicle_type_extended2;
	STRING10 fixed_object_direction1;
	STRING10 fixed_object_direction2;
	STRING10 fixed_object_direction3;
	STRING10 fixed_object_direction4;
	STRING7 vehicle_left_at_scene;
	STRING7 vehicle_impounded;
	STRING20 vehicle_driven_from_scene;
	STRING30 on_cross_street;
	STRING255 actions_of_police_vehicle_description;
	STRING42 vehicle_seg;
	STRING1 vehicle_seg_type;
	STRING4 model_year;
	STRING2 body_style_code;
	STRING4 engine_size;
	STRING1 fuel_code;
	STRING1 number_of_driving_wheels;
	STRING1 steering_type;
	STRING3 vina_series;
	STRING3 vina_model;
	STRING3 vina_make;
	STRING2 vina_body_style;
	STRING100 make_description;
	STRING20 model_description;
	STRING20 series_description;
	STRING2 car_cylinders;
	STRING42 other_vehicle_seg;
	STRING1 other_vehicle_seg_type;
	STRING4 other_model_year;
	STRING2 other_body_style_code;
	STRING4 other_engine_size;
	STRING1 other_fuel_code;
	STRING1 other_number_of_driving_wheels;
	STRING1 other_steering_type;
	STRING3 other_vina_series;
	STRING3 other_vina_model;
	STRING3 other_vina_make;
	STRING2 other_vina_body_style;
	STRING20 other_make_description;
	STRING20 other_model_description;
	STRING20 other_series_description;
	STRING2 other_car_cylinders;
	STRING1 Report_Has_Coversheet;
	STRING10 prim_range;
	STRING2 predir;
	STRING28 prim_name;
	STRING4 addr_suffix;
	STRING2 postdir;
	STRING10 unit_desig;
	STRING8 sec_range;
	STRING25 p_city_name;
	STRING25 v_city_name;
	STRING2 st;
	STRING5 z5;
	STRING4 z4;
	STRING4 cart;
	STRING1 cr_sort_sz;
	STRING4 lot;
	STRING1 lot_order;
	STRING2 dpbc;
	STRING1 chk_digit;
	STRING2 rec_type;
	STRING5 county_code;
	STRING10 geo_lat;
	STRING11 geo_long;
	STRING4 msa;
	STRING7 geo_blk;
	STRING1 geo_match;
	STRING4 err_stat;
	STRING1 nametype;
	STRING5 title;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5 suffix;
	STRING5 title2;
	STRING20 fname2;
	STRING20 mname2;
	STRING20 lname2;
	STRING5 suffix2;
	STRING3 name_score;
	UNSIGNED6 did;
	UNSIGNED1 did_score;
	UNSIGNED6 bdid;
	UNSIGNED1 bdid_score;
	UNSIGNED8 rawaid;

	STRING10 Law_Enforcement_Suspects_Alcohol_Use1;
	STRING10 Law_Enforcement_Suspects_Drug_Use1;
	STRING12 EMS_Notified_Time;
	STRING12 EMS_Arrival_Time;
	STRING60 Avoidance_Maneuver2 ;
	STRING60 Avoidance_Maneuver3 ;
	STRING60 Avoidance_Maneuver4 ;
	STRING100 Damaged_Areas_Severity1 ;
	STRING100 Damaged_Areas_Severity2 ;
	STRING7 Vehicle_Outside_City_Indicator ;
	STRING5 Vehicle_Outside_City_Distance_Miles ;
	STRING5 Vehicle_Outside_City_Direction;
	STRING50 Vehicle_Crash_Cityplace;
	STRING100 Insurance_Company_Standardized;

	STRING100 Insurance_Expiration_Date ; // already exsists adding this to base 
	STRING100 Insurance_Policy_Holder; 
	STRING4 Is_Tag_Converted; 
	STRING25 VIN_Original ; 
	STRING55 Make_Original ; 
	STRING55 Model_Original ; 
	STRING10 Model_Year_Original ; 
	STRING25 Other_Unit_VIN_Original ; 
	STRING55 Other_Unit_Make_Original ; 
	STRING55 Other_Unit_Model_Original ; 
	STRING10 Other_Unit_Model_Year_Original; 
	STRING2 Source_ID; 
	STRING100 orig_fname ;
	STRING100 orig_lname ;
	STRING60 orig_mname ;
	//3.0.1
	STRING50 initial_point_of_contact	:='';
	STRING7 vehicle_driveable:='';

	//STRING7 Solicitation	;
	STRING25 drivers_license_type	;
	STRING7 alcohol_test_type_refused;	
	STRING7 alcohol_test_type_not_offered	;
	STRING7 alcohol_test_type_field;	
	STRING7 alcohol_test_type_pbt	;
	STRING7 alcohol_test_type_breath	;
	STRING7 alcohol_test_type_blood	;
	STRING7 alcohol_test_type_urine	;
	STRING7 trapped	;
	STRING50 dl_number_cdl_endorsements;
	STRING50 dl_number_cdl_restrictions	;
	STRING20 dl_number_cdl_exempt	;
	STRING7 dl_number_cdl_medical_card	;
	STRING7 interlock_device_in_use	;
	STRING7 drug_test_type_blood	;
	STRING7 drug_test_type_urine;

	STRING30 traffic_control_condition;
	STRING7 intersection_related	;
	STRING7 special_study_local	;
	STRING7 special_study_state	;
	STRING7 off_road_vehicle_involved	;
	STRING30 location_type2	;
	STRING7 speed_limit_posted	;
	STRING10 traffic_control_damage_notify_date	;
	STRING20 traffic_control_damage_notify_time	;
	STRING60 traffic_control_damage_notify_name	;
	STRING7 public_property_damaged;
	STRING7 replacement_report	;
	STRING7 deleted_report	;
	STRING9 next_street_prefix	;

	STRING150 Violator_Name;
	STRING7 Type_Hazardous;
	STRING7 Type_Other;

	STRING10 Unit_Type_And_Axles1;
	STRING10 Unit_Type_And_Axles2;
	STRING10 Unit_Type_And_Axles3;
	STRING10 Unit_Type_And_Axles4;
	STRING30  incident_damage_amount; 
	// silverlight
	STRING64 dot_use;	
	STRING5  number_of_persons_involved	;
	STRING64 unusual_road_condition_other_description	;
	STRING64 number_of_narrative_sections	;
	STRING64 CAD_number	;
	STRING64 visibility	;
	STRING7  accident_at_intersection	;
	STRING7  accident_not_at_intersection	;
	STRING7  first_harmful_event_within_interchange;	
	STRING7  injury_involved;
	STRING64 Citation_Status;
	STRING7 commercial_vehicle	;
	STRING7 not_in_transport	;
	STRING20 other_unit_number;	
	STRING20 other_unit_length;	
	STRING20 other_unit_axles	;
	STRING20 other_unit_plate_expiration	;
	STRING7  other_unit_permanent_registration	;
	STRING10 other_unit_model_year2	;
	STRING55 other_unit_make2	;
	STRING55 other_unit_vin2	;
	STRING25 other_unit_registration_state2	;
	STRING10 other_unit_registration_year2	;
	STRING12 other_unit_license_plate2	;
	STRING20 other_unit_number2	;
	STRING20 other_unit_length2	;
	STRING20 other_unit_axles2	;
	STRING12 other_unit_plate_expiration2	;
	STRING7 other_unit_permanent_registration2	;
	STRING30 other_unit_type2	;
	STRING10 other_unit_model_year3	;
	STRING55 other_unit_make3	;
	STRING25 other_unit_vin3	;
	STRING25 other_unit_registration_state3	;
	STRING10 other_unit_registration_year3	;
	STRING12 other_unit_license_plate3	;
	STRING20 other_unit_number3	;
	STRING20 other_unit_length3	;
	STRING20 other_unit_axles3	;
	STRING20 other_unit_plate_expiration3	;
	STRING7 other_unit_permanent_registration3	;
	STRING30 other_unit_type3	;
	STRING70 damaged_areas3	;
	STRING64 driver_distracted_by;	
	STRING64 non_motorist_type;	
	STRING64 seating_position_row;	
	STRING64 seating_position_seat	;
	STRING64 seating_position_description;	
	STRING64 transported_id_number;	
	STRING10 witness_number	;
	STRING20 date_of_birth_derived;
	STRING11 Property_Damage_ID;
	STRING200 property_owner_name	;
	STRING200 damage_description	;
	STRING7 damage_estimate	;
	STRING255 Narrative;
	STRING255 Narrative_Continuance;
	STRING4 Hazardous_Materials_Hazmat_Placard_Number1;
	STRING4 Hazardous_Materials_Hazmat_Placard_Number2;

	//STRING1   Admin_Portal_Visible;
	STRING100 Vendor_Code;
	STRING1   Report_Property_Damage;
	STRING   Report_Collision_Type;
	STRING   Report_First_Harmful_Event;
	STRING   Report_Light_Condition;
	STRING   Report_Weather_Condition;
	STRING   Report_Road_Condition;
	STRING   Report_Injury_Status;
	STRING   Report_Damage_Extent;
	STRING   Report_Vehicle_Type;
	STRING   Report_Traffic_Control_Device_Type;
	STRING   Report_Contributing_Circumstances_v;
	STRING   Report_Vehicle_Maneuver_Action_Prior;
	STRING   Report_Vehicle_Body_Type;

	// CRU2eCrash integration 

	STRING100 cru_agency_name;
	STRING20  cru_agency_id;
	STRING100 cname;
	STRING1    name_type; 
	STRING20  vendor_report_id;
	STRING1   is_available_for_public;
	STRING1   has_addendum;
	STRING10  report_agency_ori;
	STRING20  report_status;
	STRING11  super_report_id;
	UNSIGNED  scrubsbits1 := 0 ;
	STRING20  ReportLinkID ; 
	UNSIGNED6 Idfield ; 
	STRING3 Page_Count;
	STRING100 address2;

	//BuyCrash Project KY Integration
	STRING3 Contrib_source; 
	
	//BuyCrash Release 6
  STRING10 Date_Report_Submitted;
END;