IMPORT ut,SALT31;
EXPORT BaseFile_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(BaseFile_Layout_VINA)
    UNSIGNED1 match_make_Invalid;
    UNSIGNED1 match_year_Invalid;
    UNSIGNED1 match_vin_Invalid;
    UNSIGNED1 make_abbreviation_Invalid;
    UNSIGNED1 model_year_Invalid;
    UNSIGNED1 vehicle_type_Invalid;
    UNSIGNED1 make_name_Invalid;
    UNSIGNED1 series_name_Invalid;
    UNSIGNED1 body_type_Invalid;
    UNSIGNED1 wheels_Invalid;
    UNSIGNED1 displacement_Invalid;
    UNSIGNED1 cylinders_Invalid;
    UNSIGNED1 fuel_Invalid;
    UNSIGNED1 carburetion_Invalid;
    UNSIGNED1 gvw_Invalid;
    UNSIGNED1 wheel_base_Invalid;
    UNSIGNED1 tire_size_Invalid;
    UNSIGNED1 ton_rating_Invalid;
    UNSIGNED1 base_shipping_weight_Invalid;
    UNSIGNED1 variance_weight_Invalid;
    UNSIGNED1 base_list_price_Invalid;
    UNSIGNED1 price_variance_Invalid;
    UNSIGNED1 high_performance_code_Invalid;
    UNSIGNED1 driving_wheels_Invalid;
    UNSIGNED1 location_indicator_Invalid;
    UNSIGNED1 air_conditioning_Invalid;
    UNSIGNED1 power_steering_Invalid;
    UNSIGNED1 power_brakes_Invalid;
    UNSIGNED1 power_windows_Invalid;
    UNSIGNED1 tilt_wheel_Invalid;
    UNSIGNED1 roof_Invalid;
    UNSIGNED1 optional_roof1_Invalid;
    UNSIGNED1 optional_roof2_Invalid;
    UNSIGNED1 radio_Invalid;
    UNSIGNED1 optional_radio1_Invalid;
    UNSIGNED1 optional_radio2_Invalid;
    UNSIGNED1 transmission_Invalid;
    UNSIGNED1 optional_transmission1_Invalid;
    UNSIGNED1 optional_transmission2_Invalid;
    UNSIGNED1 anti_lock_brakes_Invalid;
    UNSIGNED1 security_system_Invalid;
    UNSIGNED1 daytime_running_lights_Invalid;
    UNSIGNED1 visrap_Invalid;
    UNSIGNED1 cab_configuration_Invalid;
    UNSIGNED1 front_axle_code_Invalid;
    UNSIGNED1 rear_axle_code_Invalid;
    UNSIGNED1 brakes_code_Invalid;
    UNSIGNED1 engine_manufacturer_Invalid;
    UNSIGNED1 engine_model_Invalid;
    UNSIGNED1 engine_type_code_Invalid;
    UNSIGNED1 trailer_body_style_Invalid;
    UNSIGNED1 trailer_number_of_axles_Invalid;
    UNSIGNED1 trailer_length_Invalid;
    UNSIGNED1 proactive_vin_Invalid;
    UNSIGNED1 vin_pattern_Invalid;
    UNSIGNED1 ncic_data_Invalid;
    UNSIGNED1 full_body_style_name_Invalid;
    UNSIGNED1 segmentation_code_Invalid;
    UNSIGNED1 country_of_origin_Invalid;
    UNSIGNED1 engine_liter_information_Invalid;
    UNSIGNED1 engine_information_block_type_Invalid;
    UNSIGNED1 engine_information_cylinders_Invalid;
    UNSIGNED1 engine_information_carburetion_Invalid;
    UNSIGNED1 engine_information_head_configuration_Invalid;
    UNSIGNED1 engine_information_total_valves_Invalid;
    UNSIGNED1 engine_information_aspiration_code_Invalid;
    UNSIGNED1 engine_information_carburetion_code_Invalid;
    UNSIGNED1 engine_information_valves_per_cylinder_Invalid;
    UNSIGNED1 transmission_speed_Invalid;
    UNSIGNED1 transmission_type_Invalid;
    UNSIGNED1 transmission_code_Invalid;
    UNSIGNED1 transmission_speed_code_Invalid;
    UNSIGNED1 base_model_Invalid;
    UNSIGNED1 complete_prefix_file_id_Invalid;
    UNSIGNED1 series_name_full_spelling_Invalid;
    UNSIGNED1 vis_theft_code_Invalid;
    UNSIGNED1 base_list_price_expanded_Invalid;
    UNSIGNED1 default_nada_vehicle_id_Invalid;
    UNSIGNED1 default_nada_model_Invalid;
    UNSIGNED1 default_nada_body_style_Invalid;
    UNSIGNED1 default_nada_msrp_Invalid;
    UNSIGNED1 default_nada_gvwr_Invalid;
    UNSIGNED1 default_nada_gcwr_Invalid;
    UNSIGNED1 alt_1_nada_vehicle_id_Invalid;
    UNSIGNED1 alt_1_nada_model_Invalid;
    UNSIGNED1 alt_1_nada_body_style_Invalid;
    UNSIGNED1 alt_1_nada_msrp_Invalid;
    UNSIGNED1 alt_1_nada_gvwr_Invalid;
    UNSIGNED1 alt_1_nada_gcwr_Invalid;
    UNSIGNED1 alt_2_nada_vehicle_id_Invalid;
    UNSIGNED1 alt_2_nada_model_Invalid;
    UNSIGNED1 alt_2_nada_body_style_Invalid;
    UNSIGNED1 alt_2_nada_msrp_Invalid;
    UNSIGNED1 alt_2_nada_gvwr_Invalid;
    UNSIGNED1 alt_2_nada_gcwr_Invalid;
    UNSIGNED1 alt_3_nada_vehicle_id_Invalid;
    UNSIGNED1 alt_3_nada_model_Invalid;
    UNSIGNED1 alt_3_nada_body_style_Invalid;
    UNSIGNED1 alt_3_nada_msrp_Invalid;
    UNSIGNED1 alt_3_nada_gvwr_Invalid;
    UNSIGNED1 alt_3_nada_gcwr_Invalid;
    UNSIGNED1 alt_4_nada_vehicle_id_Invalid;
    UNSIGNED1 alt_4_nada_model_Invalid;
    UNSIGNED1 alt_4_nada_body_style_Invalid;
    UNSIGNED1 alt_4_nada_msrp_Invalid;
    UNSIGNED1 alt_4_nada_gvwr_Invalid;
    UNSIGNED1 alt_4_nada_gcwr_Invalid;
    UNSIGNED1 alt_5_nada_vehicle_id_Invalid;
    UNSIGNED1 alt_5_nada_model_Invalid;
    UNSIGNED1 alt_5_nada_body_style_Invalid;
    UNSIGNED1 alt_5_nada_msrp_Invalid;
    UNSIGNED1 alt_5_nada_gvwr_Invalid;
    UNSIGNED1 alt_5_nada_gcwr_Invalid;
    UNSIGNED1 alt_6_nada_vehicle_id_Invalid;
    UNSIGNED1 alt_6_nada_body_style_Invalid;
    UNSIGNED1 alt_6_nada_msrp_Invalid;
    UNSIGNED1 alt_6_nada_gvwr_Invalid;
    UNSIGNED1 alt_6_nada_gcwr_Invalid;
    UNSIGNED1 alt_7_nada_vehicle_id_Invalid;
    UNSIGNED1 alt_7_nada_model_Invalid;
    UNSIGNED1 alt_7_nada_body_style_Invalid;
    UNSIGNED1 alt_7_nada_msrp_Invalid;
    UNSIGNED1 alt_7_nada_gvwr_Invalid;
    UNSIGNED1 alt_7_nada_gcwr_Invalid;
    UNSIGNED1 aaia_codes_Invalid;
    UNSIGNED1 incomplete_vehicle_flag_Invalid;
    UNSIGNED1 electric_battery_info_type_Invalid;
    UNSIGNED1 electric_battery_kilowatts_Invalid;
    UNSIGNED1 electric_battery_volts_Invalid;
    UNSIGNED1 engine_info_proprietary_engine_brand_Invalid;
    UNSIGNED1 engine_info_high_output_engine_Invalid;
    UNSIGNED1 engine_info_supercharged_Invalid;
    UNSIGNED1 engine_info_turbocharged_Invalid;
    UNSIGNED1 engine_info_vvtl_Invalid;
    UNSIGNED1 iso_liability_Invalid;
    UNSIGNED1 series_name_condensed_Invalid;
    UNSIGNED1 aces_data_Invalid;
    UNSIGNED1 base_shipping_weight_expanded_Invalid;
    UNSIGNED1 customer_defined_data_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(BaseFile_Layout_VINA)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
  END;
EXPORT FromNone(DATASET(BaseFile_Layout_VINA) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.match_make_Invalid := BaseFile_Fields.InValid_match_make((SALT31.StrType)le.match_make);
    SELF.match_year_Invalid := BaseFile_Fields.InValid_match_year((SALT31.StrType)le.match_year);
    SELF.match_vin_Invalid := BaseFile_Fields.InValid_match_vin((SALT31.StrType)le.match_vin);
    SELF.make_abbreviation_Invalid := BaseFile_Fields.InValid_make_abbreviation((SALT31.StrType)le.make_abbreviation);
    SELF.model_year_Invalid := BaseFile_Fields.InValid_model_year((SALT31.StrType)le.model_year);
    SELF.vehicle_type_Invalid := BaseFile_Fields.InValid_vehicle_type((SALT31.StrType)le.vehicle_type);
    SELF.make_name_Invalid := BaseFile_Fields.InValid_make_name((SALT31.StrType)le.make_name);
    SELF.series_name_Invalid := BaseFile_Fields.InValid_series_name((SALT31.StrType)le.series_name);
    SELF.body_type_Invalid := BaseFile_Fields.InValid_body_type((SALT31.StrType)le.body_type);
    SELF.wheels_Invalid := BaseFile_Fields.InValid_wheels((SALT31.StrType)le.wheels);
    SELF.displacement_Invalid := BaseFile_Fields.InValid_displacement((SALT31.StrType)le.displacement);
    SELF.cylinders_Invalid := BaseFile_Fields.InValid_cylinders((SALT31.StrType)le.cylinders);
    SELF.fuel_Invalid := BaseFile_Fields.InValid_fuel((SALT31.StrType)le.fuel);
    SELF.carburetion_Invalid := BaseFile_Fields.InValid_carburetion((SALT31.StrType)le.carburetion);
    SELF.gvw_Invalid := BaseFile_Fields.InValid_gvw((SALT31.StrType)le.gvw);
    SELF.wheel_base_Invalid := BaseFile_Fields.InValid_wheel_base((SALT31.StrType)le.wheel_base);
    SELF.tire_size_Invalid := BaseFile_Fields.InValid_tire_size((SALT31.StrType)le.tire_size);
    SELF.ton_rating_Invalid := BaseFile_Fields.InValid_ton_rating((SALT31.StrType)le.ton_rating);
    SELF.base_shipping_weight_Invalid := BaseFile_Fields.InValid_base_shipping_weight((SALT31.StrType)le.base_shipping_weight);
    SELF.variance_weight_Invalid := BaseFile_Fields.InValid_variance_weight((SALT31.StrType)le.variance_weight);
    SELF.base_list_price_Invalid := BaseFile_Fields.InValid_base_list_price((SALT31.StrType)le.base_list_price);
    SELF.price_variance_Invalid := BaseFile_Fields.InValid_price_variance((SALT31.StrType)le.price_variance);
    SELF.high_performance_code_Invalid := BaseFile_Fields.InValid_high_performance_code((SALT31.StrType)le.high_performance_code);
    SELF.driving_wheels_Invalid := BaseFile_Fields.InValid_driving_wheels((SALT31.StrType)le.driving_wheels);
    SELF.location_indicator_Invalid := BaseFile_Fields.InValid_location_indicator((SALT31.StrType)le.location_indicator);
    SELF.air_conditioning_Invalid := BaseFile_Fields.InValid_air_conditioning((SALT31.StrType)le.air_conditioning);
    SELF.power_steering_Invalid := BaseFile_Fields.InValid_power_steering((SALT31.StrType)le.power_steering);
    SELF.power_brakes_Invalid := BaseFile_Fields.InValid_power_brakes((SALT31.StrType)le.power_brakes);
    SELF.power_windows_Invalid := BaseFile_Fields.InValid_power_windows((SALT31.StrType)le.power_windows);
    SELF.tilt_wheel_Invalid := BaseFile_Fields.InValid_tilt_wheel((SALT31.StrType)le.tilt_wheel);
    SELF.roof_Invalid := BaseFile_Fields.InValid_roof((SALT31.StrType)le.roof);
    SELF.optional_roof1_Invalid := BaseFile_Fields.InValid_optional_roof1((SALT31.StrType)le.optional_roof1);
    SELF.optional_roof2_Invalid := BaseFile_Fields.InValid_optional_roof2((SALT31.StrType)le.optional_roof2);
    SELF.radio_Invalid := BaseFile_Fields.InValid_radio((SALT31.StrType)le.radio);
    SELF.optional_radio1_Invalid := BaseFile_Fields.InValid_optional_radio1((SALT31.StrType)le.optional_radio1);
    SELF.optional_radio2_Invalid := BaseFile_Fields.InValid_optional_radio2((SALT31.StrType)le.optional_radio2);
    SELF.transmission_Invalid := BaseFile_Fields.InValid_transmission((SALT31.StrType)le.transmission);
    SELF.optional_transmission1_Invalid := BaseFile_Fields.InValid_optional_transmission1((SALT31.StrType)le.optional_transmission1);
    SELF.optional_transmission2_Invalid := BaseFile_Fields.InValid_optional_transmission2((SALT31.StrType)le.optional_transmission2);
    SELF.anti_lock_brakes_Invalid := BaseFile_Fields.InValid_anti_lock_brakes((SALT31.StrType)le.anti_lock_brakes);
    SELF.security_system_Invalid := BaseFile_Fields.InValid_security_system((SALT31.StrType)le.security_system);
    SELF.daytime_running_lights_Invalid := BaseFile_Fields.InValid_daytime_running_lights((SALT31.StrType)le.daytime_running_lights);
    SELF.visrap_Invalid := BaseFile_Fields.InValid_visrap((SALT31.StrType)le.visrap);
    SELF.cab_configuration_Invalid := BaseFile_Fields.InValid_cab_configuration((SALT31.StrType)le.cab_configuration);
    SELF.front_axle_code_Invalid := BaseFile_Fields.InValid_front_axle_code((SALT31.StrType)le.front_axle_code);
    SELF.rear_axle_code_Invalid := BaseFile_Fields.InValid_rear_axle_code((SALT31.StrType)le.rear_axle_code);
    SELF.brakes_code_Invalid := BaseFile_Fields.InValid_brakes_code((SALT31.StrType)le.brakes_code);
    SELF.engine_manufacturer_Invalid := BaseFile_Fields.InValid_engine_manufacturer((SALT31.StrType)le.engine_manufacturer);
    SELF.engine_model_Invalid := BaseFile_Fields.InValid_engine_model((SALT31.StrType)le.engine_model);
    SELF.engine_type_code_Invalid := BaseFile_Fields.InValid_engine_type_code((SALT31.StrType)le.engine_type_code);
    SELF.trailer_body_style_Invalid := BaseFile_Fields.InValid_trailer_body_style((SALT31.StrType)le.trailer_body_style);
    SELF.trailer_number_of_axles_Invalid := BaseFile_Fields.InValid_trailer_number_of_axles((SALT31.StrType)le.trailer_number_of_axles);
    SELF.trailer_length_Invalid := BaseFile_Fields.InValid_trailer_length((SALT31.StrType)le.trailer_length);
    SELF.proactive_vin_Invalid := BaseFile_Fields.InValid_proactive_vin((SALT31.StrType)le.proactive_vin);
    SELF.vin_pattern_Invalid := BaseFile_Fields.InValid_vin_pattern((SALT31.StrType)le.vin_pattern);
    SELF.ncic_data_Invalid := BaseFile_Fields.InValid_ncic_data((SALT31.StrType)le.ncic_data);
    SELF.full_body_style_name_Invalid := BaseFile_Fields.InValid_full_body_style_name((SALT31.StrType)le.full_body_style_name);
    SELF.segmentation_code_Invalid := BaseFile_Fields.InValid_segmentation_code((SALT31.StrType)le.segmentation_code);
    SELF.country_of_origin_Invalid := BaseFile_Fields.InValid_country_of_origin((SALT31.StrType)le.country_of_origin);
    SELF.engine_liter_information_Invalid := BaseFile_Fields.InValid_engine_liter_information((SALT31.StrType)le.engine_liter_information);
    SELF.engine_information_block_type_Invalid := BaseFile_Fields.InValid_engine_information_block_type((SALT31.StrType)le.engine_information_block_type);
    SELF.engine_information_cylinders_Invalid := BaseFile_Fields.InValid_engine_information_cylinders((SALT31.StrType)le.engine_information_cylinders);
    SELF.engine_information_carburetion_Invalid := BaseFile_Fields.InValid_engine_information_carburetion((SALT31.StrType)le.engine_information_carburetion);
    SELF.engine_information_head_configuration_Invalid := BaseFile_Fields.InValid_engine_information_head_configuration((SALT31.StrType)le.engine_information_head_configuration);
    SELF.engine_information_total_valves_Invalid := BaseFile_Fields.InValid_engine_information_total_valves((SALT31.StrType)le.engine_information_total_valves);
    SELF.engine_information_aspiration_code_Invalid := BaseFile_Fields.InValid_engine_information_aspiration_code((SALT31.StrType)le.engine_information_aspiration_code);
    SELF.engine_information_carburetion_code_Invalid := BaseFile_Fields.InValid_engine_information_carburetion_code((SALT31.StrType)le.engine_information_carburetion_code);
    SELF.engine_information_valves_per_cylinder_Invalid := BaseFile_Fields.InValid_engine_information_valves_per_cylinder((SALT31.StrType)le.engine_information_valves_per_cylinder);
    SELF.transmission_speed_Invalid := BaseFile_Fields.InValid_transmission_speed((SALT31.StrType)le.transmission_speed);
    SELF.transmission_type_Invalid := BaseFile_Fields.InValid_transmission_type((SALT31.StrType)le.transmission_type);
    SELF.transmission_code_Invalid := BaseFile_Fields.InValid_transmission_code((SALT31.StrType)le.transmission_code);
    SELF.transmission_speed_code_Invalid := BaseFile_Fields.InValid_transmission_speed_code((SALT31.StrType)le.transmission_speed_code);
    SELF.base_model_Invalid := BaseFile_Fields.InValid_base_model((SALT31.StrType)le.base_model);
    SELF.complete_prefix_file_id_Invalid := BaseFile_Fields.InValid_complete_prefix_file_id((SALT31.StrType)le.complete_prefix_file_id);
    SELF.series_name_full_spelling_Invalid := BaseFile_Fields.InValid_series_name_full_spelling((SALT31.StrType)le.series_name_full_spelling);
    SELF.vis_theft_code_Invalid := BaseFile_Fields.InValid_vis_theft_code((SALT31.StrType)le.vis_theft_code);
    SELF.base_list_price_expanded_Invalid := BaseFile_Fields.InValid_base_list_price_expanded((SALT31.StrType)le.base_list_price_expanded);
    SELF.default_nada_vehicle_id_Invalid := BaseFile_Fields.InValid_default_nada_vehicle_id((SALT31.StrType)le.default_nada_vehicle_id);
    SELF.default_nada_model_Invalid := BaseFile_Fields.InValid_default_nada_model((SALT31.StrType)le.default_nada_model);
    SELF.default_nada_body_style_Invalid := BaseFile_Fields.InValid_default_nada_body_style((SALT31.StrType)le.default_nada_body_style);
    SELF.default_nada_msrp_Invalid := BaseFile_Fields.InValid_default_nada_msrp((SALT31.StrType)le.default_nada_msrp);
    SELF.default_nada_gvwr_Invalid := BaseFile_Fields.InValid_default_nada_gvwr((SALT31.StrType)le.default_nada_gvwr);
    SELF.default_nada_gcwr_Invalid := BaseFile_Fields.InValid_default_nada_gcwr((SALT31.StrType)le.default_nada_gcwr);
    SELF.alt_1_nada_vehicle_id_Invalid := BaseFile_Fields.InValid_alt_1_nada_vehicle_id((SALT31.StrType)le.alt_1_nada_vehicle_id);
    SELF.alt_1_nada_model_Invalid := BaseFile_Fields.InValid_alt_1_nada_model((SALT31.StrType)le.alt_1_nada_model);
    SELF.alt_1_nada_body_style_Invalid := BaseFile_Fields.InValid_alt_1_nada_body_style((SALT31.StrType)le.alt_1_nada_body_style);
    SELF.alt_1_nada_msrp_Invalid := BaseFile_Fields.InValid_alt_1_nada_msrp((SALT31.StrType)le.alt_1_nada_msrp);
    SELF.alt_1_nada_gvwr_Invalid := BaseFile_Fields.InValid_alt_1_nada_gvwr((SALT31.StrType)le.alt_1_nada_gvwr);
    SELF.alt_1_nada_gcwr_Invalid := BaseFile_Fields.InValid_alt_1_nada_gcwr((SALT31.StrType)le.alt_1_nada_gcwr);
    SELF.alt_2_nada_vehicle_id_Invalid := BaseFile_Fields.InValid_alt_2_nada_vehicle_id((SALT31.StrType)le.alt_2_nada_vehicle_id);
    SELF.alt_2_nada_model_Invalid := BaseFile_Fields.InValid_alt_2_nada_model((SALT31.StrType)le.alt_2_nada_model);
    SELF.alt_2_nada_body_style_Invalid := BaseFile_Fields.InValid_alt_2_nada_body_style((SALT31.StrType)le.alt_2_nada_body_style);
    SELF.alt_2_nada_msrp_Invalid := BaseFile_Fields.InValid_alt_2_nada_msrp((SALT31.StrType)le.alt_2_nada_msrp);
    SELF.alt_2_nada_gvwr_Invalid := BaseFile_Fields.InValid_alt_2_nada_gvwr((SALT31.StrType)le.alt_2_nada_gvwr);
    SELF.alt_2_nada_gcwr_Invalid := BaseFile_Fields.InValid_alt_2_nada_gcwr((SALT31.StrType)le.alt_2_nada_gcwr);
    SELF.alt_3_nada_vehicle_id_Invalid := BaseFile_Fields.InValid_alt_3_nada_vehicle_id((SALT31.StrType)le.alt_3_nada_vehicle_id);
    SELF.alt_3_nada_model_Invalid := BaseFile_Fields.InValid_alt_3_nada_model((SALT31.StrType)le.alt_3_nada_model);
    SELF.alt_3_nada_body_style_Invalid := BaseFile_Fields.InValid_alt_3_nada_body_style((SALT31.StrType)le.alt_3_nada_body_style);
    SELF.alt_3_nada_msrp_Invalid := BaseFile_Fields.InValid_alt_3_nada_msrp((SALT31.StrType)le.alt_3_nada_msrp);
    SELF.alt_3_nada_gvwr_Invalid := BaseFile_Fields.InValid_alt_3_nada_gvwr((SALT31.StrType)le.alt_3_nada_gvwr);
    SELF.alt_3_nada_gcwr_Invalid := BaseFile_Fields.InValid_alt_3_nada_gcwr((SALT31.StrType)le.alt_3_nada_gcwr);
    SELF.alt_4_nada_vehicle_id_Invalid := BaseFile_Fields.InValid_alt_4_nada_vehicle_id((SALT31.StrType)le.alt_4_nada_vehicle_id);
    SELF.alt_4_nada_model_Invalid := BaseFile_Fields.InValid_alt_4_nada_model((SALT31.StrType)le.alt_4_nada_model);
    SELF.alt_4_nada_body_style_Invalid := BaseFile_Fields.InValid_alt_4_nada_body_style((SALT31.StrType)le.alt_4_nada_body_style);
    SELF.alt_4_nada_msrp_Invalid := BaseFile_Fields.InValid_alt_4_nada_msrp((SALT31.StrType)le.alt_4_nada_msrp);
    SELF.alt_4_nada_gvwr_Invalid := BaseFile_Fields.InValid_alt_4_nada_gvwr((SALT31.StrType)le.alt_4_nada_gvwr);
    SELF.alt_4_nada_gcwr_Invalid := BaseFile_Fields.InValid_alt_4_nada_gcwr((SALT31.StrType)le.alt_4_nada_gcwr);
    SELF.alt_5_nada_vehicle_id_Invalid := BaseFile_Fields.InValid_alt_5_nada_vehicle_id((SALT31.StrType)le.alt_5_nada_vehicle_id);
    SELF.alt_5_nada_model_Invalid := BaseFile_Fields.InValid_alt_5_nada_model((SALT31.StrType)le.alt_5_nada_model);
    SELF.alt_5_nada_body_style_Invalid := BaseFile_Fields.InValid_alt_5_nada_body_style((SALT31.StrType)le.alt_5_nada_body_style);
    SELF.alt_5_nada_msrp_Invalid := BaseFile_Fields.InValid_alt_5_nada_msrp((SALT31.StrType)le.alt_5_nada_msrp);
    SELF.alt_5_nada_gvwr_Invalid := BaseFile_Fields.InValid_alt_5_nada_gvwr((SALT31.StrType)le.alt_5_nada_gvwr);
    SELF.alt_5_nada_gcwr_Invalid := BaseFile_Fields.InValid_alt_5_nada_gcwr((SALT31.StrType)le.alt_5_nada_gcwr);
    SELF.alt_6_nada_vehicle_id_Invalid := BaseFile_Fields.InValid_alt_6_nada_vehicle_id((SALT31.StrType)le.alt_6_nada_vehicle_id);
    SELF.alt_6_nada_body_style_Invalid := BaseFile_Fields.InValid_alt_6_nada_body_style((SALT31.StrType)le.alt_6_nada_body_style);
    SELF.alt_6_nada_msrp_Invalid := BaseFile_Fields.InValid_alt_6_nada_msrp((SALT31.StrType)le.alt_6_nada_msrp);
    SELF.alt_6_nada_gvwr_Invalid := BaseFile_Fields.InValid_alt_6_nada_gvwr((SALT31.StrType)le.alt_6_nada_gvwr);
    SELF.alt_6_nada_gcwr_Invalid := BaseFile_Fields.InValid_alt_6_nada_gcwr((SALT31.StrType)le.alt_6_nada_gcwr);
    SELF.alt_7_nada_vehicle_id_Invalid := BaseFile_Fields.InValid_alt_7_nada_vehicle_id((SALT31.StrType)le.alt_7_nada_vehicle_id);
    SELF.alt_7_nada_model_Invalid := BaseFile_Fields.InValid_alt_7_nada_model((SALT31.StrType)le.alt_7_nada_model);
    SELF.alt_7_nada_body_style_Invalid := BaseFile_Fields.InValid_alt_7_nada_body_style((SALT31.StrType)le.alt_7_nada_body_style);
    SELF.alt_7_nada_msrp_Invalid := BaseFile_Fields.InValid_alt_7_nada_msrp((SALT31.StrType)le.alt_7_nada_msrp);
    SELF.alt_7_nada_gvwr_Invalid := BaseFile_Fields.InValid_alt_7_nada_gvwr((SALT31.StrType)le.alt_7_nada_gvwr);
    SELF.alt_7_nada_gcwr_Invalid := BaseFile_Fields.InValid_alt_7_nada_gcwr((SALT31.StrType)le.alt_7_nada_gcwr);
    SELF.aaia_codes_Invalid := BaseFile_Fields.InValid_aaia_codes((SALT31.StrType)le.aaia_codes);
    SELF.incomplete_vehicle_flag_Invalid := BaseFile_Fields.InValid_incomplete_vehicle_flag((SALT31.StrType)le.incomplete_vehicle_flag);
    SELF.electric_battery_info_type_Invalid := BaseFile_Fields.InValid_electric_battery_info_type((SALT31.StrType)le.electric_battery_info_type);
    SELF.electric_battery_kilowatts_Invalid := BaseFile_Fields.InValid_electric_battery_kilowatts((SALT31.StrType)le.electric_battery_kilowatts);
    SELF.electric_battery_volts_Invalid := BaseFile_Fields.InValid_electric_battery_volts((SALT31.StrType)le.electric_battery_volts);
    SELF.engine_info_proprietary_engine_brand_Invalid := BaseFile_Fields.InValid_engine_info_proprietary_engine_brand((SALT31.StrType)le.engine_info_proprietary_engine_brand);
    SELF.engine_info_high_output_engine_Invalid := BaseFile_Fields.InValid_engine_info_high_output_engine((SALT31.StrType)le.engine_info_high_output_engine);
    SELF.engine_info_supercharged_Invalid := BaseFile_Fields.InValid_engine_info_supercharged((SALT31.StrType)le.engine_info_supercharged);
    SELF.engine_info_turbocharged_Invalid := BaseFile_Fields.InValid_engine_info_turbocharged((SALT31.StrType)le.engine_info_turbocharged);
    SELF.engine_info_vvtl_Invalid := BaseFile_Fields.InValid_engine_info_vvtl((SALT31.StrType)le.engine_info_vvtl);
    SELF.iso_liability_Invalid := BaseFile_Fields.InValid_iso_liability((SALT31.StrType)le.iso_liability);
    SELF.series_name_condensed_Invalid := BaseFile_Fields.InValid_series_name_condensed((SALT31.StrType)le.series_name_condensed);
    SELF.aces_data_Invalid := BaseFile_Fields.InValid_aces_data((SALT31.StrType)le.aces_data);
    SELF.base_shipping_weight_expanded_Invalid := BaseFile_Fields.InValid_base_shipping_weight_expanded((SALT31.StrType)le.base_shipping_weight_expanded);
    SELF.customer_defined_data_Invalid := BaseFile_Fields.InValid_customer_defined_data((SALT31.StrType)le.customer_defined_data);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.match_make_Invalid << 0 ) + ( le.match_year_Invalid << 1 ) + ( le.match_vin_Invalid << 2 ) + ( le.make_abbreviation_Invalid << 3 ) + ( le.model_year_Invalid << 4 ) + ( le.vehicle_type_Invalid << 5 ) + ( le.make_name_Invalid << 6 ) + ( le.series_name_Invalid << 7 ) + ( le.body_type_Invalid << 8 ) + ( le.wheels_Invalid << 9 ) + ( le.displacement_Invalid << 10 ) + ( le.cylinders_Invalid << 11 ) + ( le.fuel_Invalid << 12 ) + ( le.carburetion_Invalid << 13 ) + ( le.gvw_Invalid << 14 ) + ( le.wheel_base_Invalid << 15 ) + ( le.tire_size_Invalid << 16 ) + ( le.ton_rating_Invalid << 17 ) + ( le.base_shipping_weight_Invalid << 18 ) + ( le.variance_weight_Invalid << 19 ) + ( le.base_list_price_Invalid << 20 ) + ( le.price_variance_Invalid << 21 ) + ( le.high_performance_code_Invalid << 22 ) + ( le.driving_wheels_Invalid << 23 ) + ( le.location_indicator_Invalid << 24 ) + ( le.air_conditioning_Invalid << 25 ) + ( le.power_steering_Invalid << 26 ) + ( le.power_brakes_Invalid << 27 ) + ( le.power_windows_Invalid << 28 ) + ( le.tilt_wheel_Invalid << 29 ) + ( le.roof_Invalid << 30 ) + ( le.optional_roof1_Invalid << 31 ) + ( le.optional_roof2_Invalid << 32 ) + ( le.radio_Invalid << 33 ) + ( le.optional_radio1_Invalid << 34 ) + ( le.optional_radio2_Invalid << 35 ) + ( le.transmission_Invalid << 36 ) + ( le.optional_transmission1_Invalid << 37 ) + ( le.optional_transmission2_Invalid << 38 ) + ( le.anti_lock_brakes_Invalid << 39 ) + ( le.security_system_Invalid << 40 ) + ( le.daytime_running_lights_Invalid << 41 ) + ( le.visrap_Invalid << 42 ) + ( le.cab_configuration_Invalid << 43 ) + ( le.front_axle_code_Invalid << 44 ) + ( le.rear_axle_code_Invalid << 45 ) + ( le.brakes_code_Invalid << 46 ) + ( le.engine_manufacturer_Invalid << 47 ) + ( le.engine_model_Invalid << 48 ) + ( le.engine_type_code_Invalid << 49 ) + ( le.trailer_body_style_Invalid << 50 ) + ( le.trailer_number_of_axles_Invalid << 51 ) + ( le.trailer_length_Invalid << 52 ) + ( le.proactive_vin_Invalid << 53 ) + ( le.vin_pattern_Invalid << 54 ) + ( le.ncic_data_Invalid << 55 ) + ( le.full_body_style_name_Invalid << 56 ) + ( le.segmentation_code_Invalid << 57 ) + ( le.country_of_origin_Invalid << 58 ) + ( le.engine_liter_information_Invalid << 59 ) + ( le.engine_information_block_type_Invalid << 60 ) + ( le.engine_information_cylinders_Invalid << 61 ) + ( le.engine_information_carburetion_Invalid << 62 ) + ( le.engine_information_head_configuration_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.engine_information_total_valves_Invalid << 0 ) + ( le.engine_information_aspiration_code_Invalid << 1 ) + ( le.engine_information_carburetion_code_Invalid << 2 ) + ( le.engine_information_valves_per_cylinder_Invalid << 3 ) + ( le.transmission_speed_Invalid << 4 ) + ( le.transmission_type_Invalid << 5 ) + ( le.transmission_code_Invalid << 6 ) + ( le.transmission_speed_code_Invalid << 7 ) + ( le.base_model_Invalid << 8 ) + ( le.complete_prefix_file_id_Invalid << 9 ) + ( le.series_name_full_spelling_Invalid << 10 ) + ( le.vis_theft_code_Invalid << 11 ) + ( le.base_list_price_expanded_Invalid << 12 ) + ( le.default_nada_vehicle_id_Invalid << 13 ) + ( le.default_nada_model_Invalid << 14 ) + ( le.default_nada_body_style_Invalid << 15 ) + ( le.default_nada_msrp_Invalid << 16 ) + ( le.default_nada_gvwr_Invalid << 17 ) + ( le.default_nada_gcwr_Invalid << 18 ) + ( le.alt_1_nada_vehicle_id_Invalid << 19 ) + ( le.alt_1_nada_model_Invalid << 20 ) + ( le.alt_1_nada_body_style_Invalid << 21 ) + ( le.alt_1_nada_msrp_Invalid << 22 ) + ( le.alt_1_nada_gvwr_Invalid << 23 ) + ( le.alt_1_nada_gcwr_Invalid << 24 ) + ( le.alt_2_nada_vehicle_id_Invalid << 25 ) + ( le.alt_2_nada_model_Invalid << 26 ) + ( le.alt_2_nada_body_style_Invalid << 27 ) + ( le.alt_2_nada_msrp_Invalid << 28 ) + ( le.alt_2_nada_gvwr_Invalid << 29 ) + ( le.alt_2_nada_gcwr_Invalid << 30 ) + ( le.alt_3_nada_vehicle_id_Invalid << 31 ) + ( le.alt_3_nada_model_Invalid << 32 ) + ( le.alt_3_nada_body_style_Invalid << 33 ) + ( le.alt_3_nada_msrp_Invalid << 34 ) + ( le.alt_3_nada_gvwr_Invalid << 35 ) + ( le.alt_3_nada_gcwr_Invalid << 36 ) + ( le.alt_4_nada_vehicle_id_Invalid << 37 ) + ( le.alt_4_nada_model_Invalid << 38 ) + ( le.alt_4_nada_body_style_Invalid << 39 ) + ( le.alt_4_nada_msrp_Invalid << 40 ) + ( le.alt_4_nada_gvwr_Invalid << 41 ) + ( le.alt_4_nada_gcwr_Invalid << 42 ) + ( le.alt_5_nada_vehicle_id_Invalid << 43 ) + ( le.alt_5_nada_model_Invalid << 44 ) + ( le.alt_5_nada_body_style_Invalid << 45 ) + ( le.alt_5_nada_msrp_Invalid << 46 ) + ( le.alt_5_nada_gvwr_Invalid << 47 ) + ( le.alt_5_nada_gcwr_Invalid << 48 ) + ( le.alt_6_nada_vehicle_id_Invalid << 49 ) + ( le.alt_6_nada_body_style_Invalid << 50 ) + ( le.alt_6_nada_msrp_Invalid << 51 ) + ( le.alt_6_nada_gvwr_Invalid << 52 ) + ( le.alt_6_nada_gcwr_Invalid << 53 ) + ( le.alt_7_nada_vehicle_id_Invalid << 54 ) + ( le.alt_7_nada_model_Invalid << 55 ) + ( le.alt_7_nada_body_style_Invalid << 56 ) + ( le.alt_7_nada_msrp_Invalid << 57 ) + ( le.alt_7_nada_gvwr_Invalid << 58 ) + ( le.alt_7_nada_gcwr_Invalid << 59 ) + ( le.aaia_codes_Invalid << 60 ) + ( le.incomplete_vehicle_flag_Invalid << 61 ) + ( le.electric_battery_info_type_Invalid << 62 ) + ( le.electric_battery_kilowatts_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.electric_battery_volts_Invalid << 0 ) + ( le.engine_info_proprietary_engine_brand_Invalid << 1 ) + ( le.engine_info_high_output_engine_Invalid << 2 ) + ( le.engine_info_supercharged_Invalid << 3 ) + ( le.engine_info_turbocharged_Invalid << 4 ) + ( le.engine_info_vvtl_Invalid << 5 ) + ( le.iso_liability_Invalid << 6 ) + ( le.series_name_condensed_Invalid << 7 ) + ( le.aces_data_Invalid << 8 ) + ( le.base_shipping_weight_expanded_Invalid << 9 ) + ( le.customer_defined_data_Invalid << 10 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,BaseFile_Layout_VINA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.match_make_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.match_year_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.match_vin_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.make_abbreviation_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.model_year_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.vehicle_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.make_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.series_name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.body_type_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.wheels_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.displacement_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.cylinders_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.fuel_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.carburetion_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.gvw_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.wheel_base_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.tire_size_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.ton_rating_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.base_shipping_weight_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.variance_weight_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.base_list_price_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.price_variance_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.high_performance_code_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.driving_wheels_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.location_indicator_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.air_conditioning_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.power_steering_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.power_brakes_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.power_windows_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.tilt_wheel_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.roof_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.optional_roof1_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.optional_roof2_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.radio_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.optional_radio1_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.optional_radio2_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.transmission_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.optional_transmission1_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.optional_transmission2_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.anti_lock_brakes_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.security_system_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.daytime_running_lights_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.visrap_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.cab_configuration_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.front_axle_code_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.rear_axle_code_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.brakes_code_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.engine_manufacturer_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.engine_model_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.engine_type_code_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.trailer_body_style_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.trailer_number_of_axles_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.trailer_length_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.proactive_vin_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.vin_pattern_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.ncic_data_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.full_body_style_name_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.segmentation_code_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.country_of_origin_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.engine_liter_information_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.engine_information_block_type_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.engine_information_cylinders_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.engine_information_carburetion_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.engine_information_head_configuration_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.engine_information_total_valves_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.engine_information_aspiration_code_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.engine_information_carburetion_code_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.engine_information_valves_per_cylinder_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.transmission_speed_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.transmission_type_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.transmission_code_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.transmission_speed_code_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.base_model_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.complete_prefix_file_id_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.series_name_full_spelling_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.vis_theft_code_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.base_list_price_expanded_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.default_nada_vehicle_id_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.default_nada_model_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.default_nada_body_style_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.default_nada_msrp_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.default_nada_gvwr_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.default_nada_gcwr_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.alt_1_nada_vehicle_id_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.alt_1_nada_model_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.alt_1_nada_body_style_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.alt_1_nada_msrp_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.alt_1_nada_gvwr_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.alt_1_nada_gcwr_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.alt_2_nada_vehicle_id_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.alt_2_nada_model_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.alt_2_nada_body_style_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.alt_2_nada_msrp_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.alt_2_nada_gvwr_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.alt_2_nada_gcwr_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.alt_3_nada_vehicle_id_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.alt_3_nada_model_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.alt_3_nada_body_style_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.alt_3_nada_msrp_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.alt_3_nada_gvwr_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.alt_3_nada_gcwr_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.alt_4_nada_vehicle_id_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.alt_4_nada_model_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.alt_4_nada_body_style_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.alt_4_nada_msrp_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.alt_4_nada_gvwr_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.alt_4_nada_gcwr_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.alt_5_nada_vehicle_id_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.alt_5_nada_model_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.alt_5_nada_body_style_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.alt_5_nada_msrp_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.alt_5_nada_gvwr_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.alt_5_nada_gcwr_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.alt_6_nada_vehicle_id_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.alt_6_nada_body_style_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.alt_6_nada_msrp_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.alt_6_nada_gvwr_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.alt_6_nada_gcwr_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.alt_7_nada_vehicle_id_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.alt_7_nada_model_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.alt_7_nada_body_style_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.alt_7_nada_msrp_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.alt_7_nada_gvwr_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.alt_7_nada_gcwr_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.aaia_codes_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.incomplete_vehicle_flag_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.electric_battery_info_type_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.electric_battery_kilowatts_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.electric_battery_volts_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.engine_info_proprietary_engine_brand_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.engine_info_high_output_engine_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.engine_info_supercharged_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.engine_info_turbocharged_Invalid := (le.ScrubsBits3 >> 4) & 1;
    SELF.engine_info_vvtl_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.iso_liability_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.series_name_condensed_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.aces_data_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.base_shipping_weight_expanded_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.customer_defined_data_Invalid := (le.ScrubsBits3 >> 10) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    match_make_ALLOW_ErrorCount := COUNT(GROUP,h.match_make_Invalid=1);
    match_year_ALLOW_ErrorCount := COUNT(GROUP,h.match_year_Invalid=1);
    match_vin_ALLOW_ErrorCount := COUNT(GROUP,h.match_vin_Invalid=1);
    make_abbreviation_ALLOW_ErrorCount := COUNT(GROUP,h.make_abbreviation_Invalid=1);
    model_year_ALLOW_ErrorCount := COUNT(GROUP,h.model_year_Invalid=1);
    vehicle_type_ALLOW_ErrorCount := COUNT(GROUP,h.vehicle_type_Invalid=1);
    make_name_ALLOW_ErrorCount := COUNT(GROUP,h.make_name_Invalid=1);
    series_name_ALLOW_ErrorCount := COUNT(GROUP,h.series_name_Invalid=1);
    body_type_ALLOW_ErrorCount := COUNT(GROUP,h.body_type_Invalid=1);
    wheels_ALLOW_ErrorCount := COUNT(GROUP,h.wheels_Invalid=1);
    displacement_ALLOW_ErrorCount := COUNT(GROUP,h.displacement_Invalid=1);
    cylinders_ALLOW_ErrorCount := COUNT(GROUP,h.cylinders_Invalid=1);
    fuel_ALLOW_ErrorCount := COUNT(GROUP,h.fuel_Invalid=1);
    carburetion_ALLOW_ErrorCount := COUNT(GROUP,h.carburetion_Invalid=1);
    gvw_ALLOW_ErrorCount := COUNT(GROUP,h.gvw_Invalid=1);
    wheel_base_ALLOW_ErrorCount := COUNT(GROUP,h.wheel_base_Invalid=1);
    tire_size_ALLOW_ErrorCount := COUNT(GROUP,h.tire_size_Invalid=1);
    ton_rating_ALLOW_ErrorCount := COUNT(GROUP,h.ton_rating_Invalid=1);
    base_shipping_weight_ALLOW_ErrorCount := COUNT(GROUP,h.base_shipping_weight_Invalid=1);
    variance_weight_ALLOW_ErrorCount := COUNT(GROUP,h.variance_weight_Invalid=1);
    base_list_price_ALLOW_ErrorCount := COUNT(GROUP,h.base_list_price_Invalid=1);
    price_variance_ALLOW_ErrorCount := COUNT(GROUP,h.price_variance_Invalid=1);
    high_performance_code_ALLOW_ErrorCount := COUNT(GROUP,h.high_performance_code_Invalid=1);
    driving_wheels_ALLOW_ErrorCount := COUNT(GROUP,h.driving_wheels_Invalid=1);
    location_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.location_indicator_Invalid=1);
    air_conditioning_ALLOW_ErrorCount := COUNT(GROUP,h.air_conditioning_Invalid=1);
    power_steering_ALLOW_ErrorCount := COUNT(GROUP,h.power_steering_Invalid=1);
    power_brakes_ALLOW_ErrorCount := COUNT(GROUP,h.power_brakes_Invalid=1);
    power_windows_ALLOW_ErrorCount := COUNT(GROUP,h.power_windows_Invalid=1);
    tilt_wheel_ALLOW_ErrorCount := COUNT(GROUP,h.tilt_wheel_Invalid=1);
    roof_ALLOW_ErrorCount := COUNT(GROUP,h.roof_Invalid=1);
    optional_roof1_ALLOW_ErrorCount := COUNT(GROUP,h.optional_roof1_Invalid=1);
    optional_roof2_ALLOW_ErrorCount := COUNT(GROUP,h.optional_roof2_Invalid=1);
    radio_ALLOW_ErrorCount := COUNT(GROUP,h.radio_Invalid=1);
    optional_radio1_ALLOW_ErrorCount := COUNT(GROUP,h.optional_radio1_Invalid=1);
    optional_radio2_ALLOW_ErrorCount := COUNT(GROUP,h.optional_radio2_Invalid=1);
    transmission_ALLOW_ErrorCount := COUNT(GROUP,h.transmission_Invalid=1);
    optional_transmission1_ALLOW_ErrorCount := COUNT(GROUP,h.optional_transmission1_Invalid=1);
    optional_transmission2_ALLOW_ErrorCount := COUNT(GROUP,h.optional_transmission2_Invalid=1);
    anti_lock_brakes_ALLOW_ErrorCount := COUNT(GROUP,h.anti_lock_brakes_Invalid=1);
    security_system_ALLOW_ErrorCount := COUNT(GROUP,h.security_system_Invalid=1);
    daytime_running_lights_ALLOW_ErrorCount := COUNT(GROUP,h.daytime_running_lights_Invalid=1);
    visrap_ALLOW_ErrorCount := COUNT(GROUP,h.visrap_Invalid=1);
    cab_configuration_ALLOW_ErrorCount := COUNT(GROUP,h.cab_configuration_Invalid=1);
    front_axle_code_ALLOW_ErrorCount := COUNT(GROUP,h.front_axle_code_Invalid=1);
    rear_axle_code_ALLOW_ErrorCount := COUNT(GROUP,h.rear_axle_code_Invalid=1);
    brakes_code_ALLOW_ErrorCount := COUNT(GROUP,h.brakes_code_Invalid=1);
    engine_manufacturer_ALLOW_ErrorCount := COUNT(GROUP,h.engine_manufacturer_Invalid=1);
    engine_model_ALLOW_ErrorCount := COUNT(GROUP,h.engine_model_Invalid=1);
    engine_type_code_ALLOW_ErrorCount := COUNT(GROUP,h.engine_type_code_Invalid=1);
    trailer_body_style_ENUM_ErrorCount := COUNT(GROUP,h.trailer_body_style_Invalid=1);
    trailer_number_of_axles_ALLOW_ErrorCount := COUNT(GROUP,h.trailer_number_of_axles_Invalid=1);
    trailer_length_ALLOW_ErrorCount := COUNT(GROUP,h.trailer_length_Invalid=1);
    proactive_vin_ALLOW_ErrorCount := COUNT(GROUP,h.proactive_vin_Invalid=1);
    vin_pattern_ALLOW_ErrorCount := COUNT(GROUP,h.vin_pattern_Invalid=1);
    ncic_data_ALLOW_ErrorCount := COUNT(GROUP,h.ncic_data_Invalid=1);
    full_body_style_name_ALLOW_ErrorCount := COUNT(GROUP,h.full_body_style_name_Invalid=1);
    segmentation_code_ALLOW_ErrorCount := COUNT(GROUP,h.segmentation_code_Invalid=1);
    country_of_origin_ALLOW_ErrorCount := COUNT(GROUP,h.country_of_origin_Invalid=1);
    engine_liter_information_ALLOW_ErrorCount := COUNT(GROUP,h.engine_liter_information_Invalid=1);
    engine_information_block_type_ALLOW_ErrorCount := COUNT(GROUP,h.engine_information_block_type_Invalid=1);
    engine_information_cylinders_ALLOW_ErrorCount := COUNT(GROUP,h.engine_information_cylinders_Invalid=1);
    engine_information_carburetion_ENUM_ErrorCount := COUNT(GROUP,h.engine_information_carburetion_Invalid=1);
    engine_information_head_configuration_ENUM_ErrorCount := COUNT(GROUP,h.engine_information_head_configuration_Invalid=1);
    engine_information_total_valves_ALLOW_ErrorCount := COUNT(GROUP,h.engine_information_total_valves_Invalid=1);
    engine_information_aspiration_code_ALLOW_ErrorCount := COUNT(GROUP,h.engine_information_aspiration_code_Invalid=1);
    engine_information_carburetion_code_ALLOW_ErrorCount := COUNT(GROUP,h.engine_information_carburetion_code_Invalid=1);
    engine_information_valves_per_cylinder_ALLOW_ErrorCount := COUNT(GROUP,h.engine_information_valves_per_cylinder_Invalid=1);
    transmission_speed_ALLOW_ErrorCount := COUNT(GROUP,h.transmission_speed_Invalid=1);
    transmission_type_ENUM_ErrorCount := COUNT(GROUP,h.transmission_type_Invalid=1);
    transmission_code_ALLOW_ErrorCount := COUNT(GROUP,h.transmission_code_Invalid=1);
    transmission_speed_code_ALLOW_ErrorCount := COUNT(GROUP,h.transmission_speed_code_Invalid=1);
    base_model_ALLOW_ErrorCount := COUNT(GROUP,h.base_model_Invalid=1);
    complete_prefix_file_id_ALLOW_ErrorCount := COUNT(GROUP,h.complete_prefix_file_id_Invalid=1);
    series_name_full_spelling_ALLOW_ErrorCount := COUNT(GROUP,h.series_name_full_spelling_Invalid=1);
    vis_theft_code_ALLOW_ErrorCount := COUNT(GROUP,h.vis_theft_code_Invalid=1);
    base_list_price_expanded_ALLOW_ErrorCount := COUNT(GROUP,h.base_list_price_expanded_Invalid=1);
    default_nada_vehicle_id_ALLOW_ErrorCount := COUNT(GROUP,h.default_nada_vehicle_id_Invalid=1);
    default_nada_model_ALLOW_ErrorCount := COUNT(GROUP,h.default_nada_model_Invalid=1);
    default_nada_body_style_ALLOW_ErrorCount := COUNT(GROUP,h.default_nada_body_style_Invalid=1);
    default_nada_msrp_ALLOW_ErrorCount := COUNT(GROUP,h.default_nada_msrp_Invalid=1);
    default_nada_gvwr_ALLOW_ErrorCount := COUNT(GROUP,h.default_nada_gvwr_Invalid=1);
    default_nada_gcwr_ALLOW_ErrorCount := COUNT(GROUP,h.default_nada_gcwr_Invalid=1);
    alt_1_nada_vehicle_id_ALLOW_ErrorCount := COUNT(GROUP,h.alt_1_nada_vehicle_id_Invalid=1);
    alt_1_nada_model_ALLOW_ErrorCount := COUNT(GROUP,h.alt_1_nada_model_Invalid=1);
    alt_1_nada_body_style_ALLOW_ErrorCount := COUNT(GROUP,h.alt_1_nada_body_style_Invalid=1);
    alt_1_nada_msrp_ALLOW_ErrorCount := COUNT(GROUP,h.alt_1_nada_msrp_Invalid=1);
    alt_1_nada_gvwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_1_nada_gvwr_Invalid=1);
    alt_1_nada_gcwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_1_nada_gcwr_Invalid=1);
    alt_2_nada_vehicle_id_ALLOW_ErrorCount := COUNT(GROUP,h.alt_2_nada_vehicle_id_Invalid=1);
    alt_2_nada_model_ALLOW_ErrorCount := COUNT(GROUP,h.alt_2_nada_model_Invalid=1);
    alt_2_nada_body_style_ALLOW_ErrorCount := COUNT(GROUP,h.alt_2_nada_body_style_Invalid=1);
    alt_2_nada_msrp_ALLOW_ErrorCount := COUNT(GROUP,h.alt_2_nada_msrp_Invalid=1);
    alt_2_nada_gvwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_2_nada_gvwr_Invalid=1);
    alt_2_nada_gcwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_2_nada_gcwr_Invalid=1);
    alt_3_nada_vehicle_id_ALLOW_ErrorCount := COUNT(GROUP,h.alt_3_nada_vehicle_id_Invalid=1);
    alt_3_nada_model_ALLOW_ErrorCount := COUNT(GROUP,h.alt_3_nada_model_Invalid=1);
    alt_3_nada_body_style_ALLOW_ErrorCount := COUNT(GROUP,h.alt_3_nada_body_style_Invalid=1);
    alt_3_nada_msrp_ALLOW_ErrorCount := COUNT(GROUP,h.alt_3_nada_msrp_Invalid=1);
    alt_3_nada_gvwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_3_nada_gvwr_Invalid=1);
    alt_3_nada_gcwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_3_nada_gcwr_Invalid=1);
    alt_4_nada_vehicle_id_ALLOW_ErrorCount := COUNT(GROUP,h.alt_4_nada_vehicle_id_Invalid=1);
    alt_4_nada_model_ALLOW_ErrorCount := COUNT(GROUP,h.alt_4_nada_model_Invalid=1);
    alt_4_nada_body_style_ALLOW_ErrorCount := COUNT(GROUP,h.alt_4_nada_body_style_Invalid=1);
    alt_4_nada_msrp_ALLOW_ErrorCount := COUNT(GROUP,h.alt_4_nada_msrp_Invalid=1);
    alt_4_nada_gvwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_4_nada_gvwr_Invalid=1);
    alt_4_nada_gcwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_4_nada_gcwr_Invalid=1);
    alt_5_nada_vehicle_id_ALLOW_ErrorCount := COUNT(GROUP,h.alt_5_nada_vehicle_id_Invalid=1);
    alt_5_nada_model_ALLOW_ErrorCount := COUNT(GROUP,h.alt_5_nada_model_Invalid=1);
    alt_5_nada_body_style_ALLOW_ErrorCount := COUNT(GROUP,h.alt_5_nada_body_style_Invalid=1);
    alt_5_nada_msrp_ALLOW_ErrorCount := COUNT(GROUP,h.alt_5_nada_msrp_Invalid=1);
    alt_5_nada_gvwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_5_nada_gvwr_Invalid=1);
    alt_5_nada_gcwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_5_nada_gcwr_Invalid=1);
    alt_6_nada_vehicle_id_ALLOW_ErrorCount := COUNT(GROUP,h.alt_6_nada_vehicle_id_Invalid=1);
    alt_6_nada_body_style_ALLOW_ErrorCount := COUNT(GROUP,h.alt_6_nada_body_style_Invalid=1);
    alt_6_nada_msrp_ALLOW_ErrorCount := COUNT(GROUP,h.alt_6_nada_msrp_Invalid=1);
    alt_6_nada_gvwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_6_nada_gvwr_Invalid=1);
    alt_6_nada_gcwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_6_nada_gcwr_Invalid=1);
    alt_7_nada_vehicle_id_ALLOW_ErrorCount := COUNT(GROUP,h.alt_7_nada_vehicle_id_Invalid=1);
    alt_7_nada_model_ALLOW_ErrorCount := COUNT(GROUP,h.alt_7_nada_model_Invalid=1);
    alt_7_nada_body_style_ALLOW_ErrorCount := COUNT(GROUP,h.alt_7_nada_body_style_Invalid=1);
    alt_7_nada_msrp_ALLOW_ErrorCount := COUNT(GROUP,h.alt_7_nada_msrp_Invalid=1);
    alt_7_nada_gvwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_7_nada_gvwr_Invalid=1);
    alt_7_nada_gcwr_ALLOW_ErrorCount := COUNT(GROUP,h.alt_7_nada_gcwr_Invalid=1);
    aaia_codes_ALLOW_ErrorCount := COUNT(GROUP,h.aaia_codes_Invalid=1);
    incomplete_vehicle_flag_ALLOW_ErrorCount := COUNT(GROUP,h.incomplete_vehicle_flag_Invalid=1);
    electric_battery_info_type_ENUM_ErrorCount := COUNT(GROUP,h.electric_battery_info_type_Invalid=1);
    electric_battery_kilowatts_ALLOW_ErrorCount := COUNT(GROUP,h.electric_battery_kilowatts_Invalid=1);
    electric_battery_volts_ALLOW_ErrorCount := COUNT(GROUP,h.electric_battery_volts_Invalid=1);
    engine_info_proprietary_engine_brand_ALLOW_ErrorCount := COUNT(GROUP,h.engine_info_proprietary_engine_brand_Invalid=1);
    engine_info_high_output_engine_ALLOW_ErrorCount := COUNT(GROUP,h.engine_info_high_output_engine_Invalid=1);
    engine_info_supercharged_ALLOW_ErrorCount := COUNT(GROUP,h.engine_info_supercharged_Invalid=1);
    engine_info_turbocharged_ALLOW_ErrorCount := COUNT(GROUP,h.engine_info_turbocharged_Invalid=1);
    engine_info_vvtl_ALLOW_ErrorCount := COUNT(GROUP,h.engine_info_vvtl_Invalid=1);
    iso_liability_ALLOW_ErrorCount := COUNT(GROUP,h.iso_liability_Invalid=1);
    series_name_condensed_ALLOW_ErrorCount := COUNT(GROUP,h.series_name_condensed_Invalid=1);
    aces_data_ALLOW_ErrorCount := COUNT(GROUP,h.aces_data_Invalid=1);
    base_shipping_weight_expanded_ALLOW_ErrorCount := COUNT(GROUP,h.base_shipping_weight_expanded_Invalid=1);
    customer_defined_data_ALLOW_ErrorCount := COUNT(GROUP,h.customer_defined_data_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT31.StrType ErrorMessage;
    SALT31.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.match_make_Invalid,le.match_year_Invalid,le.match_vin_Invalid,le.make_abbreviation_Invalid,le.model_year_Invalid,le.vehicle_type_Invalid,le.make_name_Invalid,le.series_name_Invalid,le.body_type_Invalid,le.wheels_Invalid,le.displacement_Invalid,le.cylinders_Invalid,le.fuel_Invalid,le.carburetion_Invalid,le.gvw_Invalid,le.wheel_base_Invalid,le.tire_size_Invalid,le.ton_rating_Invalid,le.base_shipping_weight_Invalid,le.variance_weight_Invalid,le.base_list_price_Invalid,le.price_variance_Invalid,le.high_performance_code_Invalid,le.driving_wheels_Invalid,le.location_indicator_Invalid,le.air_conditioning_Invalid,le.power_steering_Invalid,le.power_brakes_Invalid,le.power_windows_Invalid,le.tilt_wheel_Invalid,le.roof_Invalid,le.optional_roof1_Invalid,le.optional_roof2_Invalid,le.radio_Invalid,le.optional_radio1_Invalid,le.optional_radio2_Invalid,le.transmission_Invalid,le.optional_transmission1_Invalid,le.optional_transmission2_Invalid,le.anti_lock_brakes_Invalid,le.security_system_Invalid,le.daytime_running_lights_Invalid,le.visrap_Invalid,le.cab_configuration_Invalid,le.front_axle_code_Invalid,le.rear_axle_code_Invalid,le.brakes_code_Invalid,le.engine_manufacturer_Invalid,le.engine_model_Invalid,le.engine_type_code_Invalid,le.trailer_body_style_Invalid,le.trailer_number_of_axles_Invalid,le.trailer_length_Invalid,le.proactive_vin_Invalid,le.vin_pattern_Invalid,le.ncic_data_Invalid,le.full_body_style_name_Invalid,le.segmentation_code_Invalid,le.country_of_origin_Invalid,le.engine_liter_information_Invalid,le.engine_information_block_type_Invalid,le.engine_information_cylinders_Invalid,le.engine_information_carburetion_Invalid,le.engine_information_head_configuration_Invalid,le.engine_information_total_valves_Invalid,le.engine_information_aspiration_code_Invalid,le.engine_information_carburetion_code_Invalid,le.engine_information_valves_per_cylinder_Invalid,le.transmission_speed_Invalid,le.transmission_type_Invalid,le.transmission_code_Invalid,le.transmission_speed_code_Invalid,le.base_model_Invalid,le.complete_prefix_file_id_Invalid,le.series_name_full_spelling_Invalid,le.vis_theft_code_Invalid,le.base_list_price_expanded_Invalid,le.default_nada_vehicle_id_Invalid,le.default_nada_model_Invalid,le.default_nada_body_style_Invalid,le.default_nada_msrp_Invalid,le.default_nada_gvwr_Invalid,le.default_nada_gcwr_Invalid,le.alt_1_nada_vehicle_id_Invalid,le.alt_1_nada_model_Invalid,le.alt_1_nada_body_style_Invalid,le.alt_1_nada_msrp_Invalid,le.alt_1_nada_gvwr_Invalid,le.alt_1_nada_gcwr_Invalid,le.alt_2_nada_vehicle_id_Invalid,le.alt_2_nada_model_Invalid,le.alt_2_nada_body_style_Invalid,le.alt_2_nada_msrp_Invalid,le.alt_2_nada_gvwr_Invalid,le.alt_2_nada_gcwr_Invalid,le.alt_3_nada_vehicle_id_Invalid,le.alt_3_nada_model_Invalid,le.alt_3_nada_body_style_Invalid,le.alt_3_nada_msrp_Invalid,le.alt_3_nada_gvwr_Invalid,le.alt_3_nada_gcwr_Invalid,le.alt_4_nada_vehicle_id_Invalid,le.alt_4_nada_model_Invalid,le.alt_4_nada_body_style_Invalid,le.alt_4_nada_msrp_Invalid,le.alt_4_nada_gvwr_Invalid,le.alt_4_nada_gcwr_Invalid,le.alt_5_nada_vehicle_id_Invalid,le.alt_5_nada_model_Invalid,le.alt_5_nada_body_style_Invalid,le.alt_5_nada_msrp_Invalid,le.alt_5_nada_gvwr_Invalid,le.alt_5_nada_gcwr_Invalid,le.alt_6_nada_vehicle_id_Invalid,le.alt_6_nada_body_style_Invalid,le.alt_6_nada_msrp_Invalid,le.alt_6_nada_gvwr_Invalid,le.alt_6_nada_gcwr_Invalid,le.alt_7_nada_vehicle_id_Invalid,le.alt_7_nada_model_Invalid,le.alt_7_nada_body_style_Invalid,le.alt_7_nada_msrp_Invalid,le.alt_7_nada_gvwr_Invalid,le.alt_7_nada_gcwr_Invalid,le.aaia_codes_Invalid,le.incomplete_vehicle_flag_Invalid,le.electric_battery_info_type_Invalid,le.electric_battery_kilowatts_Invalid,le.electric_battery_volts_Invalid,le.engine_info_proprietary_engine_brand_Invalid,le.engine_info_high_output_engine_Invalid,le.engine_info_supercharged_Invalid,le.engine_info_turbocharged_Invalid,le.engine_info_vvtl_Invalid,le.iso_liability_Invalid,le.series_name_condensed_Invalid,le.aces_data_Invalid,le.base_shipping_weight_expanded_Invalid,le.customer_defined_data_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,BaseFile_Fields.InvalidMessage_match_make(le.match_make_Invalid),BaseFile_Fields.InvalidMessage_match_year(le.match_year_Invalid),BaseFile_Fields.InvalidMessage_match_vin(le.match_vin_Invalid),BaseFile_Fields.InvalidMessage_make_abbreviation(le.make_abbreviation_Invalid),BaseFile_Fields.InvalidMessage_model_year(le.model_year_Invalid),BaseFile_Fields.InvalidMessage_vehicle_type(le.vehicle_type_Invalid),BaseFile_Fields.InvalidMessage_make_name(le.make_name_Invalid),BaseFile_Fields.InvalidMessage_series_name(le.series_name_Invalid),BaseFile_Fields.InvalidMessage_body_type(le.body_type_Invalid),BaseFile_Fields.InvalidMessage_wheels(le.wheels_Invalid),BaseFile_Fields.InvalidMessage_displacement(le.displacement_Invalid),BaseFile_Fields.InvalidMessage_cylinders(le.cylinders_Invalid),BaseFile_Fields.InvalidMessage_fuel(le.fuel_Invalid),BaseFile_Fields.InvalidMessage_carburetion(le.carburetion_Invalid),BaseFile_Fields.InvalidMessage_gvw(le.gvw_Invalid),BaseFile_Fields.InvalidMessage_wheel_base(le.wheel_base_Invalid),BaseFile_Fields.InvalidMessage_tire_size(le.tire_size_Invalid),BaseFile_Fields.InvalidMessage_ton_rating(le.ton_rating_Invalid),BaseFile_Fields.InvalidMessage_base_shipping_weight(le.base_shipping_weight_Invalid),BaseFile_Fields.InvalidMessage_variance_weight(le.variance_weight_Invalid),BaseFile_Fields.InvalidMessage_base_list_price(le.base_list_price_Invalid),BaseFile_Fields.InvalidMessage_price_variance(le.price_variance_Invalid),BaseFile_Fields.InvalidMessage_high_performance_code(le.high_performance_code_Invalid),BaseFile_Fields.InvalidMessage_driving_wheels(le.driving_wheels_Invalid),BaseFile_Fields.InvalidMessage_location_indicator(le.location_indicator_Invalid),BaseFile_Fields.InvalidMessage_air_conditioning(le.air_conditioning_Invalid),BaseFile_Fields.InvalidMessage_power_steering(le.power_steering_Invalid),BaseFile_Fields.InvalidMessage_power_brakes(le.power_brakes_Invalid),BaseFile_Fields.InvalidMessage_power_windows(le.power_windows_Invalid),BaseFile_Fields.InvalidMessage_tilt_wheel(le.tilt_wheel_Invalid),BaseFile_Fields.InvalidMessage_roof(le.roof_Invalid),BaseFile_Fields.InvalidMessage_optional_roof1(le.optional_roof1_Invalid),BaseFile_Fields.InvalidMessage_optional_roof2(le.optional_roof2_Invalid),BaseFile_Fields.InvalidMessage_radio(le.radio_Invalid),BaseFile_Fields.InvalidMessage_optional_radio1(le.optional_radio1_Invalid),BaseFile_Fields.InvalidMessage_optional_radio2(le.optional_radio2_Invalid),BaseFile_Fields.InvalidMessage_transmission(le.transmission_Invalid),BaseFile_Fields.InvalidMessage_optional_transmission1(le.optional_transmission1_Invalid),BaseFile_Fields.InvalidMessage_optional_transmission2(le.optional_transmission2_Invalid),BaseFile_Fields.InvalidMessage_anti_lock_brakes(le.anti_lock_brakes_Invalid),BaseFile_Fields.InvalidMessage_security_system(le.security_system_Invalid),BaseFile_Fields.InvalidMessage_daytime_running_lights(le.daytime_running_lights_Invalid),BaseFile_Fields.InvalidMessage_visrap(le.visrap_Invalid),BaseFile_Fields.InvalidMessage_cab_configuration(le.cab_configuration_Invalid),BaseFile_Fields.InvalidMessage_front_axle_code(le.front_axle_code_Invalid),BaseFile_Fields.InvalidMessage_rear_axle_code(le.rear_axle_code_Invalid),BaseFile_Fields.InvalidMessage_brakes_code(le.brakes_code_Invalid),BaseFile_Fields.InvalidMessage_engine_manufacturer(le.engine_manufacturer_Invalid),BaseFile_Fields.InvalidMessage_engine_model(le.engine_model_Invalid),BaseFile_Fields.InvalidMessage_engine_type_code(le.engine_type_code_Invalid),BaseFile_Fields.InvalidMessage_trailer_body_style(le.trailer_body_style_Invalid),BaseFile_Fields.InvalidMessage_trailer_number_of_axles(le.trailer_number_of_axles_Invalid),BaseFile_Fields.InvalidMessage_trailer_length(le.trailer_length_Invalid),BaseFile_Fields.InvalidMessage_proactive_vin(le.proactive_vin_Invalid),BaseFile_Fields.InvalidMessage_vin_pattern(le.vin_pattern_Invalid),BaseFile_Fields.InvalidMessage_ncic_data(le.ncic_data_Invalid),BaseFile_Fields.InvalidMessage_full_body_style_name(le.full_body_style_name_Invalid),BaseFile_Fields.InvalidMessage_segmentation_code(le.segmentation_code_Invalid),BaseFile_Fields.InvalidMessage_country_of_origin(le.country_of_origin_Invalid),BaseFile_Fields.InvalidMessage_engine_liter_information(le.engine_liter_information_Invalid),BaseFile_Fields.InvalidMessage_engine_information_block_type(le.engine_information_block_type_Invalid),BaseFile_Fields.InvalidMessage_engine_information_cylinders(le.engine_information_cylinders_Invalid),BaseFile_Fields.InvalidMessage_engine_information_carburetion(le.engine_information_carburetion_Invalid),BaseFile_Fields.InvalidMessage_engine_information_head_configuration(le.engine_information_head_configuration_Invalid),BaseFile_Fields.InvalidMessage_engine_information_total_valves(le.engine_information_total_valves_Invalid),BaseFile_Fields.InvalidMessage_engine_information_aspiration_code(le.engine_information_aspiration_code_Invalid),BaseFile_Fields.InvalidMessage_engine_information_carburetion_code(le.engine_information_carburetion_code_Invalid),BaseFile_Fields.InvalidMessage_engine_information_valves_per_cylinder(le.engine_information_valves_per_cylinder_Invalid),BaseFile_Fields.InvalidMessage_transmission_speed(le.transmission_speed_Invalid),BaseFile_Fields.InvalidMessage_transmission_type(le.transmission_type_Invalid),BaseFile_Fields.InvalidMessage_transmission_code(le.transmission_code_Invalid),BaseFile_Fields.InvalidMessage_transmission_speed_code(le.transmission_speed_code_Invalid),BaseFile_Fields.InvalidMessage_base_model(le.base_model_Invalid),BaseFile_Fields.InvalidMessage_complete_prefix_file_id(le.complete_prefix_file_id_Invalid),BaseFile_Fields.InvalidMessage_series_name_full_spelling(le.series_name_full_spelling_Invalid),BaseFile_Fields.InvalidMessage_vis_theft_code(le.vis_theft_code_Invalid),BaseFile_Fields.InvalidMessage_base_list_price_expanded(le.base_list_price_expanded_Invalid),BaseFile_Fields.InvalidMessage_default_nada_vehicle_id(le.default_nada_vehicle_id_Invalid),BaseFile_Fields.InvalidMessage_default_nada_model(le.default_nada_model_Invalid),BaseFile_Fields.InvalidMessage_default_nada_body_style(le.default_nada_body_style_Invalid),BaseFile_Fields.InvalidMessage_default_nada_msrp(le.default_nada_msrp_Invalid),BaseFile_Fields.InvalidMessage_default_nada_gvwr(le.default_nada_gvwr_Invalid),BaseFile_Fields.InvalidMessage_default_nada_gcwr(le.default_nada_gcwr_Invalid),BaseFile_Fields.InvalidMessage_alt_1_nada_vehicle_id(le.alt_1_nada_vehicle_id_Invalid),BaseFile_Fields.InvalidMessage_alt_1_nada_model(le.alt_1_nada_model_Invalid),BaseFile_Fields.InvalidMessage_alt_1_nada_body_style(le.alt_1_nada_body_style_Invalid),BaseFile_Fields.InvalidMessage_alt_1_nada_msrp(le.alt_1_nada_msrp_Invalid),BaseFile_Fields.InvalidMessage_alt_1_nada_gvwr(le.alt_1_nada_gvwr_Invalid),BaseFile_Fields.InvalidMessage_alt_1_nada_gcwr(le.alt_1_nada_gcwr_Invalid),BaseFile_Fields.InvalidMessage_alt_2_nada_vehicle_id(le.alt_2_nada_vehicle_id_Invalid),BaseFile_Fields.InvalidMessage_alt_2_nada_model(le.alt_2_nada_model_Invalid),BaseFile_Fields.InvalidMessage_alt_2_nada_body_style(le.alt_2_nada_body_style_Invalid),BaseFile_Fields.InvalidMessage_alt_2_nada_msrp(le.alt_2_nada_msrp_Invalid),BaseFile_Fields.InvalidMessage_alt_2_nada_gvwr(le.alt_2_nada_gvwr_Invalid),BaseFile_Fields.InvalidMessage_alt_2_nada_gcwr(le.alt_2_nada_gcwr_Invalid),BaseFile_Fields.InvalidMessage_alt_3_nada_vehicle_id(le.alt_3_nada_vehicle_id_Invalid),BaseFile_Fields.InvalidMessage_alt_3_nada_model(le.alt_3_nada_model_Invalid),BaseFile_Fields.InvalidMessage_alt_3_nada_body_style(le.alt_3_nada_body_style_Invalid),BaseFile_Fields.InvalidMessage_alt_3_nada_msrp(le.alt_3_nada_msrp_Invalid),BaseFile_Fields.InvalidMessage_alt_3_nada_gvwr(le.alt_3_nada_gvwr_Invalid),BaseFile_Fields.InvalidMessage_alt_3_nada_gcwr(le.alt_3_nada_gcwr_Invalid),BaseFile_Fields.InvalidMessage_alt_4_nada_vehicle_id(le.alt_4_nada_vehicle_id_Invalid),BaseFile_Fields.InvalidMessage_alt_4_nada_model(le.alt_4_nada_model_Invalid),BaseFile_Fields.InvalidMessage_alt_4_nada_body_style(le.alt_4_nada_body_style_Invalid),BaseFile_Fields.InvalidMessage_alt_4_nada_msrp(le.alt_4_nada_msrp_Invalid),BaseFile_Fields.InvalidMessage_alt_4_nada_gvwr(le.alt_4_nada_gvwr_Invalid),BaseFile_Fields.InvalidMessage_alt_4_nada_gcwr(le.alt_4_nada_gcwr_Invalid),BaseFile_Fields.InvalidMessage_alt_5_nada_vehicle_id(le.alt_5_nada_vehicle_id_Invalid),BaseFile_Fields.InvalidMessage_alt_5_nada_model(le.alt_5_nada_model_Invalid),BaseFile_Fields.InvalidMessage_alt_5_nada_body_style(le.alt_5_nada_body_style_Invalid),BaseFile_Fields.InvalidMessage_alt_5_nada_msrp(le.alt_5_nada_msrp_Invalid),BaseFile_Fields.InvalidMessage_alt_5_nada_gvwr(le.alt_5_nada_gvwr_Invalid),BaseFile_Fields.InvalidMessage_alt_5_nada_gcwr(le.alt_5_nada_gcwr_Invalid),BaseFile_Fields.InvalidMessage_alt_6_nada_vehicle_id(le.alt_6_nada_vehicle_id_Invalid),BaseFile_Fields.InvalidMessage_alt_6_nada_body_style(le.alt_6_nada_body_style_Invalid),BaseFile_Fields.InvalidMessage_alt_6_nada_msrp(le.alt_6_nada_msrp_Invalid),BaseFile_Fields.InvalidMessage_alt_6_nada_gvwr(le.alt_6_nada_gvwr_Invalid),BaseFile_Fields.InvalidMessage_alt_6_nada_gcwr(le.alt_6_nada_gcwr_Invalid),BaseFile_Fields.InvalidMessage_alt_7_nada_vehicle_id(le.alt_7_nada_vehicle_id_Invalid),BaseFile_Fields.InvalidMessage_alt_7_nada_model(le.alt_7_nada_model_Invalid),BaseFile_Fields.InvalidMessage_alt_7_nada_body_style(le.alt_7_nada_body_style_Invalid),BaseFile_Fields.InvalidMessage_alt_7_nada_msrp(le.alt_7_nada_msrp_Invalid),BaseFile_Fields.InvalidMessage_alt_7_nada_gvwr(le.alt_7_nada_gvwr_Invalid),BaseFile_Fields.InvalidMessage_alt_7_nada_gcwr(le.alt_7_nada_gcwr_Invalid),BaseFile_Fields.InvalidMessage_aaia_codes(le.aaia_codes_Invalid),BaseFile_Fields.InvalidMessage_incomplete_vehicle_flag(le.incomplete_vehicle_flag_Invalid),BaseFile_Fields.InvalidMessage_electric_battery_info_type(le.electric_battery_info_type_Invalid),BaseFile_Fields.InvalidMessage_electric_battery_kilowatts(le.electric_battery_kilowatts_Invalid),BaseFile_Fields.InvalidMessage_electric_battery_volts(le.electric_battery_volts_Invalid),BaseFile_Fields.InvalidMessage_engine_info_proprietary_engine_brand(le.engine_info_proprietary_engine_brand_Invalid),BaseFile_Fields.InvalidMessage_engine_info_high_output_engine(le.engine_info_high_output_engine_Invalid),BaseFile_Fields.InvalidMessage_engine_info_supercharged(le.engine_info_supercharged_Invalid),BaseFile_Fields.InvalidMessage_engine_info_turbocharged(le.engine_info_turbocharged_Invalid),BaseFile_Fields.InvalidMessage_engine_info_vvtl(le.engine_info_vvtl_Invalid),BaseFile_Fields.InvalidMessage_iso_liability(le.iso_liability_Invalid),BaseFile_Fields.InvalidMessage_series_name_condensed(le.series_name_condensed_Invalid),BaseFile_Fields.InvalidMessage_aces_data(le.aces_data_Invalid),BaseFile_Fields.InvalidMessage_base_shipping_weight_expanded(le.base_shipping_weight_expanded_Invalid),BaseFile_Fields.InvalidMessage_customer_defined_data(le.customer_defined_data_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.match_make_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.match_year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.match_vin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.make_abbreviation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.model_year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vehicle_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.make_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.series_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.body_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.wheels_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.displacement_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cylinders_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fuel_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.carburetion_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gvw_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.wheel_base_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.tire_size_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ton_rating_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.base_shipping_weight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.variance_weight_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.base_list_price_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.price_variance_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.high_performance_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.driving_wheels_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.location_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.air_conditioning_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.power_steering_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.power_brakes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.power_windows_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.tilt_wheel_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.roof_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.optional_roof1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.optional_roof2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.radio_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.optional_radio1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.optional_radio2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transmission_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.optional_transmission1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.optional_transmission2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.anti_lock_brakes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.security_system_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.daytime_running_lights_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.visrap_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cab_configuration_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.front_axle_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rear_axle_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.brakes_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_manufacturer_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_type_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.trailer_body_style_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.trailer_number_of_axles_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.trailer_length_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proactive_vin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vin_pattern_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ncic_data_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.full_body_style_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.segmentation_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_of_origin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_liter_information_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_information_block_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_information_cylinders_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_information_carburetion_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.engine_information_head_configuration_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.engine_information_total_valves_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_information_aspiration_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_information_carburetion_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_information_valves_per_cylinder_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transmission_speed_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transmission_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.transmission_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transmission_speed_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.base_model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.complete_prefix_file_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.series_name_full_spelling_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vis_theft_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.base_list_price_expanded_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.default_nada_vehicle_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.default_nada_model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.default_nada_body_style_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.default_nada_msrp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.default_nada_gvwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.default_nada_gcwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_1_nada_vehicle_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_1_nada_model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_1_nada_body_style_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_1_nada_msrp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_1_nada_gvwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_1_nada_gcwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_2_nada_vehicle_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_2_nada_model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_2_nada_body_style_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_2_nada_msrp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_2_nada_gvwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_2_nada_gcwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_3_nada_vehicle_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_3_nada_model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_3_nada_body_style_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_3_nada_msrp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_3_nada_gvwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_3_nada_gcwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_4_nada_vehicle_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_4_nada_model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_4_nada_body_style_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_4_nada_msrp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_4_nada_gvwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_4_nada_gcwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_5_nada_vehicle_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_5_nada_model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_5_nada_body_style_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_5_nada_msrp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_5_nada_gvwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_5_nada_gcwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_6_nada_vehicle_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_6_nada_body_style_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_6_nada_msrp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_6_nada_gvwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_6_nada_gcwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_7_nada_vehicle_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_7_nada_model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_7_nada_body_style_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_7_nada_msrp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_7_nada_gvwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.alt_7_nada_gcwr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aaia_codes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.incomplete_vehicle_flag_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.electric_battery_info_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.electric_battery_kilowatts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.electric_battery_volts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_info_proprietary_engine_brand_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_info_high_output_engine_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_info_supercharged_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_info_turbocharged_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.engine_info_vvtl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.iso_liability_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.series_name_condensed_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aces_data_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.base_shipping_weight_expanded_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.customer_defined_data_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'match_make','match_year','match_vin','make_abbreviation','model_year','vehicle_type','make_name','series_name','body_type','wheels','displacement','cylinders','fuel','carburetion','gvw','wheel_base','tire_size','ton_rating','base_shipping_weight','variance_weight','base_list_price','price_variance','high_performance_code','driving_wheels','location_indicator','air_conditioning','power_steering','power_brakes','power_windows','tilt_wheel','roof','optional_roof1','optional_roof2','radio','optional_radio1','optional_radio2','transmission','optional_transmission1','optional_transmission2','anti_lock_brakes','security_system','daytime_running_lights','visrap','cab_configuration','front_axle_code','rear_axle_code','brakes_code','engine_manufacturer','engine_model','engine_type_code','trailer_body_style','trailer_number_of_axles','trailer_length','proactive_vin','vin_pattern','ncic_data','full_body_style_name','segmentation_code','country_of_origin','engine_liter_information','engine_information_block_type','engine_information_cylinders','engine_information_carburetion','engine_information_head_configuration','engine_information_total_valves','engine_information_aspiration_code','engine_information_carburetion_code','engine_information_valves_per_cylinder','transmission_speed','transmission_type','transmission_code','transmission_speed_code','base_model','complete_prefix_file_id','series_name_full_spelling','vis_theft_code','base_list_price_expanded','default_nada_vehicle_id','default_nada_model','default_nada_body_style','default_nada_msrp','default_nada_gvwr','default_nada_gcwr','alt_1_nada_vehicle_id','alt_1_nada_model','alt_1_nada_body_style','alt_1_nada_msrp','alt_1_nada_gvwr','alt_1_nada_gcwr','alt_2_nada_vehicle_id','alt_2_nada_model','alt_2_nada_body_style','alt_2_nada_msrp','alt_2_nada_gvwr','alt_2_nada_gcwr','alt_3_nada_vehicle_id','alt_3_nada_model','alt_3_nada_body_style','alt_3_nada_msrp','alt_3_nada_gvwr','alt_3_nada_gcwr','alt_4_nada_vehicle_id','alt_4_nada_model','alt_4_nada_body_style','alt_4_nada_msrp','alt_4_nada_gvwr','alt_4_nada_gcwr','alt_5_nada_vehicle_id','alt_5_nada_model','alt_5_nada_body_style','alt_5_nada_msrp','alt_5_nada_gvwr','alt_5_nada_gcwr','alt_6_nada_vehicle_id','alt_6_nada_body_style','alt_6_nada_msrp','alt_6_nada_gvwr','alt_6_nada_gcwr','alt_7_nada_vehicle_id','alt_7_nada_model','alt_7_nada_body_style','alt_7_nada_msrp','alt_7_nada_gvwr','alt_7_nada_gcwr','aaia_codes','incomplete_vehicle_flag','electric_battery_info_type','electric_battery_kilowatts','electric_battery_volts','engine_info_proprietary_engine_brand','engine_info_high_output_engine','engine_info_supercharged','engine_info_turbocharged','engine_info_vvtl','iso_liability','series_name_condensed','aces_data','base_shipping_weight_expanded','customer_defined_data','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Char','Invalid_Nums','Invalid_Vin','Invalid_Abbreviation','Invalid_Nums','Invalid_Vehicle_Type','Invalid_Char','Invalid_Char','Invalid_Body_Type','Invalid_Nums','Invalid_Nums_Blank','Invalid_Nums_Rotary','Invalid_Fuel','Invalid_Carburetion_Num','Invalid_Nums_Rotary','Invalid_Decimal','Invalid_Tire_Size','Invalid_Char_No_Spec','Invalid_Decimal','Invalid_Nums','Invalid_Char','Invalid_Nums','Invalid_HPC','Invalid_Wheel','Invalid_Location','Invalid_Option_SOUN','Invalid_Option_SOUN','Invalid_Option_SOUN','Invalid_Option_SOUN','Invalid_Option_SOUN','Invalid_Roof','Invalid_Roof','Invalid_Roof','Invalid_Radio','Invalid_Radio','Invalid_Radio','Invalid_Transmission','Invalid_Transmission','Invalid_Transmission','Invalid_ALB','Invalid_Security','Invalid_Option_SOUN','Invalid_Visrap','Invalid_Cab','Invalid_FAC','Invalid_RAC','Invalid_Brakes','Invalid_Char','Invalid_Char','Invalid_Engine_Type','Invalid_Trailer_Body','Invalid_Num_Axles','Invalid_Trailer_length','Invalid_Proactive_VIN_Ind','Invalid_VIN_Pattern','Invalid_Char','Invalid_Char','Invalid_Segmentation_Codes','Invalid_Char','Invalid_Liter','Invalid_Block_Type','Invalid_engine_information_cylinders','Invalid_Carburetion','Invalid_Head_Configuration','Invalid_Valves','Invalid_Aspiration_Code','Invalid_Carburetion_Code','Invalid_VPC','Invalid_Transmission_Speed','Invalid_Transmission_Type','Invalid_Transmission_Code','Invalid_Transmission_Speed_Code','Invalid_Char','Invalid_Nums','Invalid_Char','Invalid_Y_or_N','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Y_or_N','Invalid_Battery_Type','Invalid_Battery_KW','Invalid_Battery_Volts','Invalid_Engine_Brand','Invalid_Y_or_N','Invalid_Supercharged','Invalid_Turbocharged','Invalid_Y_or_N_orBlank','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Decimal','Invalid_Char','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.match_make,(SALT31.StrType)le.match_year,(SALT31.StrType)le.match_vin,(SALT31.StrType)le.make_abbreviation,(SALT31.StrType)le.model_year,(SALT31.StrType)le.vehicle_type,(SALT31.StrType)le.make_name,(SALT31.StrType)le.series_name,(SALT31.StrType)le.body_type,(SALT31.StrType)le.wheels,(SALT31.StrType)le.displacement,(SALT31.StrType)le.cylinders,(SALT31.StrType)le.fuel,(SALT31.StrType)le.carburetion,(SALT31.StrType)le.gvw,(SALT31.StrType)le.wheel_base,(SALT31.StrType)le.tire_size,(SALT31.StrType)le.ton_rating,(SALT31.StrType)le.base_shipping_weight,(SALT31.StrType)le.variance_weight,(SALT31.StrType)le.base_list_price,(SALT31.StrType)le.price_variance,(SALT31.StrType)le.high_performance_code,(SALT31.StrType)le.driving_wheels,(SALT31.StrType)le.location_indicator,(SALT31.StrType)le.air_conditioning,(SALT31.StrType)le.power_steering,(SALT31.StrType)le.power_brakes,(SALT31.StrType)le.power_windows,(SALT31.StrType)le.tilt_wheel,(SALT31.StrType)le.roof,(SALT31.StrType)le.optional_roof1,(SALT31.StrType)le.optional_roof2,(SALT31.StrType)le.radio,(SALT31.StrType)le.optional_radio1,(SALT31.StrType)le.optional_radio2,(SALT31.StrType)le.transmission,(SALT31.StrType)le.optional_transmission1,(SALT31.StrType)le.optional_transmission2,(SALT31.StrType)le.anti_lock_brakes,(SALT31.StrType)le.security_system,(SALT31.StrType)le.daytime_running_lights,(SALT31.StrType)le.visrap,(SALT31.StrType)le.cab_configuration,(SALT31.StrType)le.front_axle_code,(SALT31.StrType)le.rear_axle_code,(SALT31.StrType)le.brakes_code,(SALT31.StrType)le.engine_manufacturer,(SALT31.StrType)le.engine_model,(SALT31.StrType)le.engine_type_code,(SALT31.StrType)le.trailer_body_style,(SALT31.StrType)le.trailer_number_of_axles,(SALT31.StrType)le.trailer_length,(SALT31.StrType)le.proactive_vin,(SALT31.StrType)le.vin_pattern,(SALT31.StrType)le.ncic_data,(SALT31.StrType)le.full_body_style_name,(SALT31.StrType)le.segmentation_code,(SALT31.StrType)le.country_of_origin,(SALT31.StrType)le.engine_liter_information,(SALT31.StrType)le.engine_information_block_type,(SALT31.StrType)le.engine_information_cylinders,(SALT31.StrType)le.engine_information_carburetion,(SALT31.StrType)le.engine_information_head_configuration,(SALT31.StrType)le.engine_information_total_valves,(SALT31.StrType)le.engine_information_aspiration_code,(SALT31.StrType)le.engine_information_carburetion_code,(SALT31.StrType)le.engine_information_valves_per_cylinder,(SALT31.StrType)le.transmission_speed,(SALT31.StrType)le.transmission_type,(SALT31.StrType)le.transmission_code,(SALT31.StrType)le.transmission_speed_code,(SALT31.StrType)le.base_model,(SALT31.StrType)le.complete_prefix_file_id,(SALT31.StrType)le.series_name_full_spelling,(SALT31.StrType)le.vis_theft_code,(SALT31.StrType)le.base_list_price_expanded,(SALT31.StrType)le.default_nada_vehicle_id,(SALT31.StrType)le.default_nada_model,(SALT31.StrType)le.default_nada_body_style,(SALT31.StrType)le.default_nada_msrp,(SALT31.StrType)le.default_nada_gvwr,(SALT31.StrType)le.default_nada_gcwr,(SALT31.StrType)le.alt_1_nada_vehicle_id,(SALT31.StrType)le.alt_1_nada_model,(SALT31.StrType)le.alt_1_nada_body_style,(SALT31.StrType)le.alt_1_nada_msrp,(SALT31.StrType)le.alt_1_nada_gvwr,(SALT31.StrType)le.alt_1_nada_gcwr,(SALT31.StrType)le.alt_2_nada_vehicle_id,(SALT31.StrType)le.alt_2_nada_model,(SALT31.StrType)le.alt_2_nada_body_style,(SALT31.StrType)le.alt_2_nada_msrp,(SALT31.StrType)le.alt_2_nada_gvwr,(SALT31.StrType)le.alt_2_nada_gcwr,(SALT31.StrType)le.alt_3_nada_vehicle_id,(SALT31.StrType)le.alt_3_nada_model,(SALT31.StrType)le.alt_3_nada_body_style,(SALT31.StrType)le.alt_3_nada_msrp,(SALT31.StrType)le.alt_3_nada_gvwr,(SALT31.StrType)le.alt_3_nada_gcwr,(SALT31.StrType)le.alt_4_nada_vehicle_id,(SALT31.StrType)le.alt_4_nada_model,(SALT31.StrType)le.alt_4_nada_body_style,(SALT31.StrType)le.alt_4_nada_msrp,(SALT31.StrType)le.alt_4_nada_gvwr,(SALT31.StrType)le.alt_4_nada_gcwr,(SALT31.StrType)le.alt_5_nada_vehicle_id,(SALT31.StrType)le.alt_5_nada_model,(SALT31.StrType)le.alt_5_nada_body_style,(SALT31.StrType)le.alt_5_nada_msrp,(SALT31.StrType)le.alt_5_nada_gvwr,(SALT31.StrType)le.alt_5_nada_gcwr,(SALT31.StrType)le.alt_6_nada_vehicle_id,(SALT31.StrType)le.alt_6_nada_body_style,(SALT31.StrType)le.alt_6_nada_msrp,(SALT31.StrType)le.alt_6_nada_gvwr,(SALT31.StrType)le.alt_6_nada_gcwr,(SALT31.StrType)le.alt_7_nada_vehicle_id,(SALT31.StrType)le.alt_7_nada_model,(SALT31.StrType)le.alt_7_nada_body_style,(SALT31.StrType)le.alt_7_nada_msrp,(SALT31.StrType)le.alt_7_nada_gvwr,(SALT31.StrType)le.alt_7_nada_gcwr,(SALT31.StrType)le.aaia_codes,(SALT31.StrType)le.incomplete_vehicle_flag,(SALT31.StrType)le.electric_battery_info_type,(SALT31.StrType)le.electric_battery_kilowatts,(SALT31.StrType)le.electric_battery_volts,(SALT31.StrType)le.engine_info_proprietary_engine_brand,(SALT31.StrType)le.engine_info_high_output_engine,(SALT31.StrType)le.engine_info_supercharged,(SALT31.StrType)le.engine_info_turbocharged,(SALT31.StrType)le.engine_info_vvtl,(SALT31.StrType)le.iso_liability,(SALT31.StrType)le.series_name_condensed,(SALT31.StrType)le.aces_data,(SALT31.StrType)le.base_shipping_weight_expanded,(SALT31.StrType)le.customer_defined_data,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,139,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'match_make:Invalid_Char:ALLOW'
          ,'match_year:Invalid_Nums:ALLOW'
          ,'match_vin:Invalid_Vin:ALLOW'
          ,'make_abbreviation:Invalid_Abbreviation:ALLOW'
          ,'model_year:Invalid_Nums:ALLOW'
          ,'vehicle_type:Invalid_Vehicle_Type:ALLOW'
          ,'make_name:Invalid_Char:ALLOW'
          ,'series_name:Invalid_Char:ALLOW'
          ,'body_type:Invalid_Body_Type:ALLOW'
          ,'wheels:Invalid_Nums:ALLOW'
          ,'displacement:Invalid_Nums_Blank:ALLOW'
          ,'cylinders:Invalid_Nums_Rotary:ALLOW'
          ,'fuel:Invalid_Fuel:ALLOW'
          ,'carburetion:Invalid_Carburetion_Num:ALLOW'
          ,'gvw:Invalid_Nums_Rotary:ALLOW'
          ,'wheel_base:Invalid_Decimal:ALLOW'
          ,'tire_size:Invalid_Tire_Size:ALLOW'
          ,'ton_rating:Invalid_Char_No_Spec:ALLOW'
          ,'base_shipping_weight:Invalid_Decimal:ALLOW'
          ,'variance_weight:Invalid_Nums:ALLOW'
          ,'base_list_price:Invalid_Char:ALLOW'
          ,'price_variance:Invalid_Nums:ALLOW'
          ,'high_performance_code:Invalid_HPC:ALLOW'
          ,'driving_wheels:Invalid_Wheel:ALLOW'
          ,'location_indicator:Invalid_Location:ALLOW'
          ,'air_conditioning:Invalid_Option_SOUN:ALLOW'
          ,'power_steering:Invalid_Option_SOUN:ALLOW'
          ,'power_brakes:Invalid_Option_SOUN:ALLOW'
          ,'power_windows:Invalid_Option_SOUN:ALLOW'
          ,'tilt_wheel:Invalid_Option_SOUN:ALLOW'
          ,'roof:Invalid_Roof:ALLOW'
          ,'optional_roof1:Invalid_Roof:ALLOW'
          ,'optional_roof2:Invalid_Roof:ALLOW'
          ,'radio:Invalid_Radio:ALLOW'
          ,'optional_radio1:Invalid_Radio:ALLOW'
          ,'optional_radio2:Invalid_Radio:ALLOW'
          ,'transmission:Invalid_Transmission:ALLOW'
          ,'optional_transmission1:Invalid_Transmission:ALLOW'
          ,'optional_transmission2:Invalid_Transmission:ALLOW'
          ,'anti_lock_brakes:Invalid_ALB:ALLOW'
          ,'security_system:Invalid_Security:ALLOW'
          ,'daytime_running_lights:Invalid_Option_SOUN:ALLOW'
          ,'visrap:Invalid_Visrap:ALLOW'
          ,'cab_configuration:Invalid_Cab:ALLOW'
          ,'front_axle_code:Invalid_FAC:ALLOW'
          ,'rear_axle_code:Invalid_RAC:ALLOW'
          ,'brakes_code:Invalid_Brakes:ALLOW'
          ,'engine_manufacturer:Invalid_Char:ALLOW'
          ,'engine_model:Invalid_Char:ALLOW'
          ,'engine_type_code:Invalid_Engine_Type:ALLOW'
          ,'trailer_body_style:Invalid_Trailer_Body:ENUM'
          ,'trailer_number_of_axles:Invalid_Num_Axles:ALLOW'
          ,'trailer_length:Invalid_Trailer_length:ALLOW'
          ,'proactive_vin:Invalid_Proactive_VIN_Ind:ALLOW'
          ,'vin_pattern:Invalid_VIN_Pattern:ALLOW'
          ,'ncic_data:Invalid_Char:ALLOW'
          ,'full_body_style_name:Invalid_Char:ALLOW'
          ,'segmentation_code:Invalid_Segmentation_Codes:ALLOW'
          ,'country_of_origin:Invalid_Char:ALLOW'
          ,'engine_liter_information:Invalid_Liter:ALLOW'
          ,'engine_information_block_type:Invalid_Block_Type:ALLOW'
          ,'engine_information_cylinders:Invalid_engine_information_cylinders:ALLOW'
          ,'engine_information_carburetion:Invalid_Carburetion:ENUM'
          ,'engine_information_head_configuration:Invalid_Head_Configuration:ENUM'
          ,'engine_information_total_valves:Invalid_Valves:ALLOW'
          ,'engine_information_aspiration_code:Invalid_Aspiration_Code:ALLOW'
          ,'engine_information_carburetion_code:Invalid_Carburetion_Code:ALLOW'
          ,'engine_information_valves_per_cylinder:Invalid_VPC:ALLOW'
          ,'transmission_speed:Invalid_Transmission_Speed:ALLOW'
          ,'transmission_type:Invalid_Transmission_Type:ENUM'
          ,'transmission_code:Invalid_Transmission_Code:ALLOW'
          ,'transmission_speed_code:Invalid_Transmission_Speed_Code:ALLOW'
          ,'base_model:Invalid_Char:ALLOW'
          ,'complete_prefix_file_id:Invalid_Nums:ALLOW'
          ,'series_name_full_spelling:Invalid_Char:ALLOW'
          ,'vis_theft_code:Invalid_Y_or_N:ALLOW'
          ,'base_list_price_expanded:Invalid_Char:ALLOW'
          ,'default_nada_vehicle_id:Invalid_Char:ALLOW'
          ,'default_nada_model:Invalid_Char:ALLOW'
          ,'default_nada_body_style:Invalid_Char:ALLOW'
          ,'default_nada_msrp:Invalid_Char:ALLOW'
          ,'default_nada_gvwr:Invalid_Char:ALLOW'
          ,'default_nada_gcwr:Invalid_Char:ALLOW'
          ,'alt_1_nada_vehicle_id:Invalid_Char:ALLOW'
          ,'alt_1_nada_model:Invalid_Char:ALLOW'
          ,'alt_1_nada_body_style:Invalid_Char:ALLOW'
          ,'alt_1_nada_msrp:Invalid_Char:ALLOW'
          ,'alt_1_nada_gvwr:Invalid_Char:ALLOW'
          ,'alt_1_nada_gcwr:Invalid_Char:ALLOW'
          ,'alt_2_nada_vehicle_id:Invalid_Char:ALLOW'
          ,'alt_2_nada_model:Invalid_Char:ALLOW'
          ,'alt_2_nada_body_style:Invalid_Char:ALLOW'
          ,'alt_2_nada_msrp:Invalid_Char:ALLOW'
          ,'alt_2_nada_gvwr:Invalid_Char:ALLOW'
          ,'alt_2_nada_gcwr:Invalid_Char:ALLOW'
          ,'alt_3_nada_vehicle_id:Invalid_Char:ALLOW'
          ,'alt_3_nada_model:Invalid_Char:ALLOW'
          ,'alt_3_nada_body_style:Invalid_Char:ALLOW'
          ,'alt_3_nada_msrp:Invalid_Char:ALLOW'
          ,'alt_3_nada_gvwr:Invalid_Char:ALLOW'
          ,'alt_3_nada_gcwr:Invalid_Char:ALLOW'
          ,'alt_4_nada_vehicle_id:Invalid_Char:ALLOW'
          ,'alt_4_nada_model:Invalid_Char:ALLOW'
          ,'alt_4_nada_body_style:Invalid_Char:ALLOW'
          ,'alt_4_nada_msrp:Invalid_Char:ALLOW'
          ,'alt_4_nada_gvwr:Invalid_Char:ALLOW'
          ,'alt_4_nada_gcwr:Invalid_Char:ALLOW'
          ,'alt_5_nada_vehicle_id:Invalid_Char:ALLOW'
          ,'alt_5_nada_model:Invalid_Char:ALLOW'
          ,'alt_5_nada_body_style:Invalid_Char:ALLOW'
          ,'alt_5_nada_msrp:Invalid_Char:ALLOW'
          ,'alt_5_nada_gvwr:Invalid_Char:ALLOW'
          ,'alt_5_nada_gcwr:Invalid_Char:ALLOW'
          ,'alt_6_nada_vehicle_id:Invalid_Char:ALLOW'
          ,'alt_6_nada_body_style:Invalid_Char:ALLOW'
          ,'alt_6_nada_msrp:Invalid_Char:ALLOW'
          ,'alt_6_nada_gvwr:Invalid_Char:ALLOW'
          ,'alt_6_nada_gcwr:Invalid_Char:ALLOW'
          ,'alt_7_nada_vehicle_id:Invalid_Char:ALLOW'
          ,'alt_7_nada_model:Invalid_Char:ALLOW'
          ,'alt_7_nada_body_style:Invalid_Char:ALLOW'
          ,'alt_7_nada_msrp:Invalid_Char:ALLOW'
          ,'alt_7_nada_gvwr:Invalid_Char:ALLOW'
          ,'alt_7_nada_gcwr:Invalid_Char:ALLOW'
          ,'aaia_codes:Invalid_Char:ALLOW'
          ,'incomplete_vehicle_flag:Invalid_Y_or_N:ALLOW'
          ,'electric_battery_info_type:Invalid_Battery_Type:ENUM'
          ,'electric_battery_kilowatts:Invalid_Battery_KW:ALLOW'
          ,'electric_battery_volts:Invalid_Battery_Volts:ALLOW'
          ,'engine_info_proprietary_engine_brand:Invalid_Engine_Brand:ALLOW'
          ,'engine_info_high_output_engine:Invalid_Y_or_N:ALLOW'
          ,'engine_info_supercharged:Invalid_Supercharged:ALLOW'
          ,'engine_info_turbocharged:Invalid_Turbocharged:ALLOW'
          ,'engine_info_vvtl:Invalid_Y_or_N_orBlank:ALLOW'
          ,'iso_liability:Invalid_Char:ALLOW'
          ,'series_name_condensed:Invalid_Char:ALLOW'
          ,'aces_data:Invalid_Char:ALLOW'
          ,'base_shipping_weight_expanded:Invalid_Decimal:ALLOW'
          ,'customer_defined_data:Invalid_Char:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,BaseFile_Fields.InvalidMessage_match_make(1)
          ,BaseFile_Fields.InvalidMessage_match_year(1)
          ,BaseFile_Fields.InvalidMessage_match_vin(1)
          ,BaseFile_Fields.InvalidMessage_make_abbreviation(1)
          ,BaseFile_Fields.InvalidMessage_model_year(1)
          ,BaseFile_Fields.InvalidMessage_vehicle_type(1)
          ,BaseFile_Fields.InvalidMessage_make_name(1)
          ,BaseFile_Fields.InvalidMessage_series_name(1)
          ,BaseFile_Fields.InvalidMessage_body_type(1)
          ,BaseFile_Fields.InvalidMessage_wheels(1)
          ,BaseFile_Fields.InvalidMessage_displacement(1)
          ,BaseFile_Fields.InvalidMessage_cylinders(1)
          ,BaseFile_Fields.InvalidMessage_fuel(1)
          ,BaseFile_Fields.InvalidMessage_carburetion(1)
          ,BaseFile_Fields.InvalidMessage_gvw(1)
          ,BaseFile_Fields.InvalidMessage_wheel_base(1)
          ,BaseFile_Fields.InvalidMessage_tire_size(1)
          ,BaseFile_Fields.InvalidMessage_ton_rating(1)
          ,BaseFile_Fields.InvalidMessage_base_shipping_weight(1)
          ,BaseFile_Fields.InvalidMessage_variance_weight(1)
          ,BaseFile_Fields.InvalidMessage_base_list_price(1)
          ,BaseFile_Fields.InvalidMessage_price_variance(1)
          ,BaseFile_Fields.InvalidMessage_high_performance_code(1)
          ,BaseFile_Fields.InvalidMessage_driving_wheels(1)
          ,BaseFile_Fields.InvalidMessage_location_indicator(1)
          ,BaseFile_Fields.InvalidMessage_air_conditioning(1)
          ,BaseFile_Fields.InvalidMessage_power_steering(1)
          ,BaseFile_Fields.InvalidMessage_power_brakes(1)
          ,BaseFile_Fields.InvalidMessage_power_windows(1)
          ,BaseFile_Fields.InvalidMessage_tilt_wheel(1)
          ,BaseFile_Fields.InvalidMessage_roof(1)
          ,BaseFile_Fields.InvalidMessage_optional_roof1(1)
          ,BaseFile_Fields.InvalidMessage_optional_roof2(1)
          ,BaseFile_Fields.InvalidMessage_radio(1)
          ,BaseFile_Fields.InvalidMessage_optional_radio1(1)
          ,BaseFile_Fields.InvalidMessage_optional_radio2(1)
          ,BaseFile_Fields.InvalidMessage_transmission(1)
          ,BaseFile_Fields.InvalidMessage_optional_transmission1(1)
          ,BaseFile_Fields.InvalidMessage_optional_transmission2(1)
          ,BaseFile_Fields.InvalidMessage_anti_lock_brakes(1)
          ,BaseFile_Fields.InvalidMessage_security_system(1)
          ,BaseFile_Fields.InvalidMessage_daytime_running_lights(1)
          ,BaseFile_Fields.InvalidMessage_visrap(1)
          ,BaseFile_Fields.InvalidMessage_cab_configuration(1)
          ,BaseFile_Fields.InvalidMessage_front_axle_code(1)
          ,BaseFile_Fields.InvalidMessage_rear_axle_code(1)
          ,BaseFile_Fields.InvalidMessage_brakes_code(1)
          ,BaseFile_Fields.InvalidMessage_engine_manufacturer(1)
          ,BaseFile_Fields.InvalidMessage_engine_model(1)
          ,BaseFile_Fields.InvalidMessage_engine_type_code(1)
          ,BaseFile_Fields.InvalidMessage_trailer_body_style(1)
          ,BaseFile_Fields.InvalidMessage_trailer_number_of_axles(1)
          ,BaseFile_Fields.InvalidMessage_trailer_length(1)
          ,BaseFile_Fields.InvalidMessage_proactive_vin(1)
          ,BaseFile_Fields.InvalidMessage_vin_pattern(1)
          ,BaseFile_Fields.InvalidMessage_ncic_data(1)
          ,BaseFile_Fields.InvalidMessage_full_body_style_name(1)
          ,BaseFile_Fields.InvalidMessage_segmentation_code(1)
          ,BaseFile_Fields.InvalidMessage_country_of_origin(1)
          ,BaseFile_Fields.InvalidMessage_engine_liter_information(1)
          ,BaseFile_Fields.InvalidMessage_engine_information_block_type(1)
          ,BaseFile_Fields.InvalidMessage_engine_information_cylinders(1)
          ,BaseFile_Fields.InvalidMessage_engine_information_carburetion(1)
          ,BaseFile_Fields.InvalidMessage_engine_information_head_configuration(1)
          ,BaseFile_Fields.InvalidMessage_engine_information_total_valves(1)
          ,BaseFile_Fields.InvalidMessage_engine_information_aspiration_code(1)
          ,BaseFile_Fields.InvalidMessage_engine_information_carburetion_code(1)
          ,BaseFile_Fields.InvalidMessage_engine_information_valves_per_cylinder(1)
          ,BaseFile_Fields.InvalidMessage_transmission_speed(1)
          ,BaseFile_Fields.InvalidMessage_transmission_type(1)
          ,BaseFile_Fields.InvalidMessage_transmission_code(1)
          ,BaseFile_Fields.InvalidMessage_transmission_speed_code(1)
          ,BaseFile_Fields.InvalidMessage_base_model(1)
          ,BaseFile_Fields.InvalidMessage_complete_prefix_file_id(1)
          ,BaseFile_Fields.InvalidMessage_series_name_full_spelling(1)
          ,BaseFile_Fields.InvalidMessage_vis_theft_code(1)
          ,BaseFile_Fields.InvalidMessage_base_list_price_expanded(1)
          ,BaseFile_Fields.InvalidMessage_default_nada_vehicle_id(1)
          ,BaseFile_Fields.InvalidMessage_default_nada_model(1)
          ,BaseFile_Fields.InvalidMessage_default_nada_body_style(1)
          ,BaseFile_Fields.InvalidMessage_default_nada_msrp(1)
          ,BaseFile_Fields.InvalidMessage_default_nada_gvwr(1)
          ,BaseFile_Fields.InvalidMessage_default_nada_gcwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_1_nada_vehicle_id(1)
          ,BaseFile_Fields.InvalidMessage_alt_1_nada_model(1)
          ,BaseFile_Fields.InvalidMessage_alt_1_nada_body_style(1)
          ,BaseFile_Fields.InvalidMessage_alt_1_nada_msrp(1)
          ,BaseFile_Fields.InvalidMessage_alt_1_nada_gvwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_1_nada_gcwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_2_nada_vehicle_id(1)
          ,BaseFile_Fields.InvalidMessage_alt_2_nada_model(1)
          ,BaseFile_Fields.InvalidMessage_alt_2_nada_body_style(1)
          ,BaseFile_Fields.InvalidMessage_alt_2_nada_msrp(1)
          ,BaseFile_Fields.InvalidMessage_alt_2_nada_gvwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_2_nada_gcwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_3_nada_vehicle_id(1)
          ,BaseFile_Fields.InvalidMessage_alt_3_nada_model(1)
          ,BaseFile_Fields.InvalidMessage_alt_3_nada_body_style(1)
          ,BaseFile_Fields.InvalidMessage_alt_3_nada_msrp(1)
          ,BaseFile_Fields.InvalidMessage_alt_3_nada_gvwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_3_nada_gcwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_4_nada_vehicle_id(1)
          ,BaseFile_Fields.InvalidMessage_alt_4_nada_model(1)
          ,BaseFile_Fields.InvalidMessage_alt_4_nada_body_style(1)
          ,BaseFile_Fields.InvalidMessage_alt_4_nada_msrp(1)
          ,BaseFile_Fields.InvalidMessage_alt_4_nada_gvwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_4_nada_gcwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_5_nada_vehicle_id(1)
          ,BaseFile_Fields.InvalidMessage_alt_5_nada_model(1)
          ,BaseFile_Fields.InvalidMessage_alt_5_nada_body_style(1)
          ,BaseFile_Fields.InvalidMessage_alt_5_nada_msrp(1)
          ,BaseFile_Fields.InvalidMessage_alt_5_nada_gvwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_5_nada_gcwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_6_nada_vehicle_id(1)
          ,BaseFile_Fields.InvalidMessage_alt_6_nada_body_style(1)
          ,BaseFile_Fields.InvalidMessage_alt_6_nada_msrp(1)
          ,BaseFile_Fields.InvalidMessage_alt_6_nada_gvwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_6_nada_gcwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_7_nada_vehicle_id(1)
          ,BaseFile_Fields.InvalidMessage_alt_7_nada_model(1)
          ,BaseFile_Fields.InvalidMessage_alt_7_nada_body_style(1)
          ,BaseFile_Fields.InvalidMessage_alt_7_nada_msrp(1)
          ,BaseFile_Fields.InvalidMessage_alt_7_nada_gvwr(1)
          ,BaseFile_Fields.InvalidMessage_alt_7_nada_gcwr(1)
          ,BaseFile_Fields.InvalidMessage_aaia_codes(1)
          ,BaseFile_Fields.InvalidMessage_incomplete_vehicle_flag(1)
          ,BaseFile_Fields.InvalidMessage_electric_battery_info_type(1)
          ,BaseFile_Fields.InvalidMessage_electric_battery_kilowatts(1)
          ,BaseFile_Fields.InvalidMessage_electric_battery_volts(1)
          ,BaseFile_Fields.InvalidMessage_engine_info_proprietary_engine_brand(1)
          ,BaseFile_Fields.InvalidMessage_engine_info_high_output_engine(1)
          ,BaseFile_Fields.InvalidMessage_engine_info_supercharged(1)
          ,BaseFile_Fields.InvalidMessage_engine_info_turbocharged(1)
          ,BaseFile_Fields.InvalidMessage_engine_info_vvtl(1)
          ,BaseFile_Fields.InvalidMessage_iso_liability(1)
          ,BaseFile_Fields.InvalidMessage_series_name_condensed(1)
          ,BaseFile_Fields.InvalidMessage_aces_data(1)
          ,BaseFile_Fields.InvalidMessage_base_shipping_weight_expanded(1)
          ,BaseFile_Fields.InvalidMessage_customer_defined_data(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.match_make_ALLOW_ErrorCount
          ,le.match_year_ALLOW_ErrorCount
          ,le.match_vin_ALLOW_ErrorCount
          ,le.make_abbreviation_ALLOW_ErrorCount
          ,le.model_year_ALLOW_ErrorCount
          ,le.vehicle_type_ALLOW_ErrorCount
          ,le.make_name_ALLOW_ErrorCount
          ,le.series_name_ALLOW_ErrorCount
          ,le.body_type_ALLOW_ErrorCount
          ,le.wheels_ALLOW_ErrorCount
          ,le.displacement_ALLOW_ErrorCount
          ,le.cylinders_ALLOW_ErrorCount
          ,le.fuel_ALLOW_ErrorCount
          ,le.carburetion_ALLOW_ErrorCount
          ,le.gvw_ALLOW_ErrorCount
          ,le.wheel_base_ALLOW_ErrorCount
          ,le.tire_size_ALLOW_ErrorCount
          ,le.ton_rating_ALLOW_ErrorCount
          ,le.base_shipping_weight_ALLOW_ErrorCount
          ,le.variance_weight_ALLOW_ErrorCount
          ,le.base_list_price_ALLOW_ErrorCount
          ,le.price_variance_ALLOW_ErrorCount
          ,le.high_performance_code_ALLOW_ErrorCount
          ,le.driving_wheels_ALLOW_ErrorCount
          ,le.location_indicator_ALLOW_ErrorCount
          ,le.air_conditioning_ALLOW_ErrorCount
          ,le.power_steering_ALLOW_ErrorCount
          ,le.power_brakes_ALLOW_ErrorCount
          ,le.power_windows_ALLOW_ErrorCount
          ,le.tilt_wheel_ALLOW_ErrorCount
          ,le.roof_ALLOW_ErrorCount
          ,le.optional_roof1_ALLOW_ErrorCount
          ,le.optional_roof2_ALLOW_ErrorCount
          ,le.radio_ALLOW_ErrorCount
          ,le.optional_radio1_ALLOW_ErrorCount
          ,le.optional_radio2_ALLOW_ErrorCount
          ,le.transmission_ALLOW_ErrorCount
          ,le.optional_transmission1_ALLOW_ErrorCount
          ,le.optional_transmission2_ALLOW_ErrorCount
          ,le.anti_lock_brakes_ALLOW_ErrorCount
          ,le.security_system_ALLOW_ErrorCount
          ,le.daytime_running_lights_ALLOW_ErrorCount
          ,le.visrap_ALLOW_ErrorCount
          ,le.cab_configuration_ALLOW_ErrorCount
          ,le.front_axle_code_ALLOW_ErrorCount
          ,le.rear_axle_code_ALLOW_ErrorCount
          ,le.brakes_code_ALLOW_ErrorCount
          ,le.engine_manufacturer_ALLOW_ErrorCount
          ,le.engine_model_ALLOW_ErrorCount
          ,le.engine_type_code_ALLOW_ErrorCount
          ,le.trailer_body_style_ENUM_ErrorCount
          ,le.trailer_number_of_axles_ALLOW_ErrorCount
          ,le.trailer_length_ALLOW_ErrorCount
          ,le.proactive_vin_ALLOW_ErrorCount
          ,le.vin_pattern_ALLOW_ErrorCount
          ,le.ncic_data_ALLOW_ErrorCount
          ,le.full_body_style_name_ALLOW_ErrorCount
          ,le.segmentation_code_ALLOW_ErrorCount
          ,le.country_of_origin_ALLOW_ErrorCount
          ,le.engine_liter_information_ALLOW_ErrorCount
          ,le.engine_information_block_type_ALLOW_ErrorCount
          ,le.engine_information_cylinders_ALLOW_ErrorCount
          ,le.engine_information_carburetion_ENUM_ErrorCount
          ,le.engine_information_head_configuration_ENUM_ErrorCount
          ,le.engine_information_total_valves_ALLOW_ErrorCount
          ,le.engine_information_aspiration_code_ALLOW_ErrorCount
          ,le.engine_information_carburetion_code_ALLOW_ErrorCount
          ,le.engine_information_valves_per_cylinder_ALLOW_ErrorCount
          ,le.transmission_speed_ALLOW_ErrorCount
          ,le.transmission_type_ENUM_ErrorCount
          ,le.transmission_code_ALLOW_ErrorCount
          ,le.transmission_speed_code_ALLOW_ErrorCount
          ,le.base_model_ALLOW_ErrorCount
          ,le.complete_prefix_file_id_ALLOW_ErrorCount
          ,le.series_name_full_spelling_ALLOW_ErrorCount
          ,le.vis_theft_code_ALLOW_ErrorCount
          ,le.base_list_price_expanded_ALLOW_ErrorCount
          ,le.default_nada_vehicle_id_ALLOW_ErrorCount
          ,le.default_nada_model_ALLOW_ErrorCount
          ,le.default_nada_body_style_ALLOW_ErrorCount
          ,le.default_nada_msrp_ALLOW_ErrorCount
          ,le.default_nada_gvwr_ALLOW_ErrorCount
          ,le.default_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_1_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_1_nada_model_ALLOW_ErrorCount
          ,le.alt_1_nada_body_style_ALLOW_ErrorCount
          ,le.alt_1_nada_msrp_ALLOW_ErrorCount
          ,le.alt_1_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_1_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_2_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_2_nada_model_ALLOW_ErrorCount
          ,le.alt_2_nada_body_style_ALLOW_ErrorCount
          ,le.alt_2_nada_msrp_ALLOW_ErrorCount
          ,le.alt_2_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_2_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_3_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_3_nada_model_ALLOW_ErrorCount
          ,le.alt_3_nada_body_style_ALLOW_ErrorCount
          ,le.alt_3_nada_msrp_ALLOW_ErrorCount
          ,le.alt_3_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_3_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_4_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_4_nada_model_ALLOW_ErrorCount
          ,le.alt_4_nada_body_style_ALLOW_ErrorCount
          ,le.alt_4_nada_msrp_ALLOW_ErrorCount
          ,le.alt_4_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_4_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_5_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_5_nada_model_ALLOW_ErrorCount
          ,le.alt_5_nada_body_style_ALLOW_ErrorCount
          ,le.alt_5_nada_msrp_ALLOW_ErrorCount
          ,le.alt_5_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_5_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_6_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_6_nada_body_style_ALLOW_ErrorCount
          ,le.alt_6_nada_msrp_ALLOW_ErrorCount
          ,le.alt_6_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_6_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_7_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_7_nada_model_ALLOW_ErrorCount
          ,le.alt_7_nada_body_style_ALLOW_ErrorCount
          ,le.alt_7_nada_msrp_ALLOW_ErrorCount
          ,le.alt_7_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_7_nada_gcwr_ALLOW_ErrorCount
          ,le.aaia_codes_ALLOW_ErrorCount
          ,le.incomplete_vehicle_flag_ALLOW_ErrorCount
          ,le.electric_battery_info_type_ENUM_ErrorCount
          ,le.electric_battery_kilowatts_ALLOW_ErrorCount
          ,le.electric_battery_volts_ALLOW_ErrorCount
          ,le.engine_info_proprietary_engine_brand_ALLOW_ErrorCount
          ,le.engine_info_high_output_engine_ALLOW_ErrorCount
          ,le.engine_info_supercharged_ALLOW_ErrorCount
          ,le.engine_info_turbocharged_ALLOW_ErrorCount
          ,le.engine_info_vvtl_ALLOW_ErrorCount
          ,le.iso_liability_ALLOW_ErrorCount
          ,le.series_name_condensed_ALLOW_ErrorCount
          ,le.aces_data_ALLOW_ErrorCount
          ,le.base_shipping_weight_expanded_ALLOW_ErrorCount
          ,le.customer_defined_data_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.match_make_ALLOW_ErrorCount
          ,le.match_year_ALLOW_ErrorCount
          ,le.match_vin_ALLOW_ErrorCount
          ,le.make_abbreviation_ALLOW_ErrorCount
          ,le.model_year_ALLOW_ErrorCount
          ,le.vehicle_type_ALLOW_ErrorCount
          ,le.make_name_ALLOW_ErrorCount
          ,le.series_name_ALLOW_ErrorCount
          ,le.body_type_ALLOW_ErrorCount
          ,le.wheels_ALLOW_ErrorCount
          ,le.displacement_ALLOW_ErrorCount
          ,le.cylinders_ALLOW_ErrorCount
          ,le.fuel_ALLOW_ErrorCount
          ,le.carburetion_ALLOW_ErrorCount
          ,le.gvw_ALLOW_ErrorCount
          ,le.wheel_base_ALLOW_ErrorCount
          ,le.tire_size_ALLOW_ErrorCount
          ,le.ton_rating_ALLOW_ErrorCount
          ,le.base_shipping_weight_ALLOW_ErrorCount
          ,le.variance_weight_ALLOW_ErrorCount
          ,le.base_list_price_ALLOW_ErrorCount
          ,le.price_variance_ALLOW_ErrorCount
          ,le.high_performance_code_ALLOW_ErrorCount
          ,le.driving_wheels_ALLOW_ErrorCount
          ,le.location_indicator_ALLOW_ErrorCount
          ,le.air_conditioning_ALLOW_ErrorCount
          ,le.power_steering_ALLOW_ErrorCount
          ,le.power_brakes_ALLOW_ErrorCount
          ,le.power_windows_ALLOW_ErrorCount
          ,le.tilt_wheel_ALLOW_ErrorCount
          ,le.roof_ALLOW_ErrorCount
          ,le.optional_roof1_ALLOW_ErrorCount
          ,le.optional_roof2_ALLOW_ErrorCount
          ,le.radio_ALLOW_ErrorCount
          ,le.optional_radio1_ALLOW_ErrorCount
          ,le.optional_radio2_ALLOW_ErrorCount
          ,le.transmission_ALLOW_ErrorCount
          ,le.optional_transmission1_ALLOW_ErrorCount
          ,le.optional_transmission2_ALLOW_ErrorCount
          ,le.anti_lock_brakes_ALLOW_ErrorCount
          ,le.security_system_ALLOW_ErrorCount
          ,le.daytime_running_lights_ALLOW_ErrorCount
          ,le.visrap_ALLOW_ErrorCount
          ,le.cab_configuration_ALLOW_ErrorCount
          ,le.front_axle_code_ALLOW_ErrorCount
          ,le.rear_axle_code_ALLOW_ErrorCount
          ,le.brakes_code_ALLOW_ErrorCount
          ,le.engine_manufacturer_ALLOW_ErrorCount
          ,le.engine_model_ALLOW_ErrorCount
          ,le.engine_type_code_ALLOW_ErrorCount
          ,le.trailer_body_style_ENUM_ErrorCount
          ,le.trailer_number_of_axles_ALLOW_ErrorCount
          ,le.trailer_length_ALLOW_ErrorCount
          ,le.proactive_vin_ALLOW_ErrorCount
          ,le.vin_pattern_ALLOW_ErrorCount
          ,le.ncic_data_ALLOW_ErrorCount
          ,le.full_body_style_name_ALLOW_ErrorCount
          ,le.segmentation_code_ALLOW_ErrorCount
          ,le.country_of_origin_ALLOW_ErrorCount
          ,le.engine_liter_information_ALLOW_ErrorCount
          ,le.engine_information_block_type_ALLOW_ErrorCount
          ,le.engine_information_cylinders_ALLOW_ErrorCount
          ,le.engine_information_carburetion_ENUM_ErrorCount
          ,le.engine_information_head_configuration_ENUM_ErrorCount
          ,le.engine_information_total_valves_ALLOW_ErrorCount
          ,le.engine_information_aspiration_code_ALLOW_ErrorCount
          ,le.engine_information_carburetion_code_ALLOW_ErrorCount
          ,le.engine_information_valves_per_cylinder_ALLOW_ErrorCount
          ,le.transmission_speed_ALLOW_ErrorCount
          ,le.transmission_type_ENUM_ErrorCount
          ,le.transmission_code_ALLOW_ErrorCount
          ,le.transmission_speed_code_ALLOW_ErrorCount
          ,le.base_model_ALLOW_ErrorCount
          ,le.complete_prefix_file_id_ALLOW_ErrorCount
          ,le.series_name_full_spelling_ALLOW_ErrorCount
          ,le.vis_theft_code_ALLOW_ErrorCount
          ,le.base_list_price_expanded_ALLOW_ErrorCount
          ,le.default_nada_vehicle_id_ALLOW_ErrorCount
          ,le.default_nada_model_ALLOW_ErrorCount
          ,le.default_nada_body_style_ALLOW_ErrorCount
          ,le.default_nada_msrp_ALLOW_ErrorCount
          ,le.default_nada_gvwr_ALLOW_ErrorCount
          ,le.default_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_1_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_1_nada_model_ALLOW_ErrorCount
          ,le.alt_1_nada_body_style_ALLOW_ErrorCount
          ,le.alt_1_nada_msrp_ALLOW_ErrorCount
          ,le.alt_1_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_1_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_2_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_2_nada_model_ALLOW_ErrorCount
          ,le.alt_2_nada_body_style_ALLOW_ErrorCount
          ,le.alt_2_nada_msrp_ALLOW_ErrorCount
          ,le.alt_2_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_2_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_3_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_3_nada_model_ALLOW_ErrorCount
          ,le.alt_3_nada_body_style_ALLOW_ErrorCount
          ,le.alt_3_nada_msrp_ALLOW_ErrorCount
          ,le.alt_3_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_3_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_4_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_4_nada_model_ALLOW_ErrorCount
          ,le.alt_4_nada_body_style_ALLOW_ErrorCount
          ,le.alt_4_nada_msrp_ALLOW_ErrorCount
          ,le.alt_4_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_4_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_5_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_5_nada_model_ALLOW_ErrorCount
          ,le.alt_5_nada_body_style_ALLOW_ErrorCount
          ,le.alt_5_nada_msrp_ALLOW_ErrorCount
          ,le.alt_5_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_5_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_6_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_6_nada_body_style_ALLOW_ErrorCount
          ,le.alt_6_nada_msrp_ALLOW_ErrorCount
          ,le.alt_6_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_6_nada_gcwr_ALLOW_ErrorCount
          ,le.alt_7_nada_vehicle_id_ALLOW_ErrorCount
          ,le.alt_7_nada_model_ALLOW_ErrorCount
          ,le.alt_7_nada_body_style_ALLOW_ErrorCount
          ,le.alt_7_nada_msrp_ALLOW_ErrorCount
          ,le.alt_7_nada_gvwr_ALLOW_ErrorCount
          ,le.alt_7_nada_gcwr_ALLOW_ErrorCount
          ,le.aaia_codes_ALLOW_ErrorCount
          ,le.incomplete_vehicle_flag_ALLOW_ErrorCount
          ,le.electric_battery_info_type_ENUM_ErrorCount
          ,le.electric_battery_kilowatts_ALLOW_ErrorCount
          ,le.electric_battery_volts_ALLOW_ErrorCount
          ,le.engine_info_proprietary_engine_brand_ALLOW_ErrorCount
          ,le.engine_info_high_output_engine_ALLOW_ErrorCount
          ,le.engine_info_supercharged_ALLOW_ErrorCount
          ,le.engine_info_turbocharged_ALLOW_ErrorCount
          ,le.engine_info_vvtl_ALLOW_ErrorCount
          ,le.iso_liability_ALLOW_ErrorCount
          ,le.series_name_condensed_ALLOW_ErrorCount
          ,le.aces_data_ALLOW_ErrorCount
          ,le.base_shipping_weight_expanded_ALLOW_ErrorCount
          ,le.customer_defined_data_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,139,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT31.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT31.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
