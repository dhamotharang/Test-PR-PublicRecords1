
EXPORT BaseFile_MAC_PopulationStatistics(infile,Ref='',Input_match_make = '',Input_match_year = '',Input_match_vin = '',Input_make_abbreviation = '',Input_model_year = '',Input_vehicle_type = '',Input_make_name = '',Input_series_name = '',Input_body_type = '',Input_wheels = '',Input_displacement = '',Input_cylinders = '',Input_fuel = '',Input_carburetion = '',Input_gvw = '',Input_wheel_base = '',Input_tire_size = '',Input_ton_rating = '',Input_base_shipping_weight = '',Input_variance_weight = '',Input_base_list_price = '',Input_price_variance = '',Input_high_performance_code = '',Input_driving_wheels = '',Input_iso_physical_damage = '',Input_location_indicator = '',Input_air_conditioning = '',Input_power_steering = '',Input_power_brakes = '',Input_power_windows = '',Input_tilt_wheel = '',Input_roof = '',Input_optional_roof1 = '',Input_optional_roof2 = '',Input_radio = '',Input_optional_radio1 = '',Input_optional_radio2 = '',Input_transmission = '',Input_optional_transmission1 = '',Input_optional_transmission2 = '',Input_anti_lock_brakes = '',Input_security_system = '',Input_daytime_running_lights = '',Input_visrap = '',Input_cab_configuration = '',Input_front_axle_code = '',Input_rear_axle_code = '',Input_brakes_code = '',Input_engine_manufacturer = '',Input_engine_model = '',Input_engine_type_code = '',Input_trailer_body_style = '',Input_trailer_number_of_axles = '',Input_trailer_length = '',Input_proactive_vin = '',Input_ma_state_exceptions = '',Input_filler_1 = '',Input_series_abbreviation = '',Input_vin_pattern = '',Input_ncic_data = '',Input_full_body_style_name = '',Input_nvpp_make_code = '',Input_nvpp_make_abbreviation = '',Input_nvpp_series_model = '',Input_nvpp_series_name = '',Input_segmentation_code = '',Input_country_of_origin = '',Input_engine_liter_information = '',Input_engine_information_filler1 = '',Input_engine_information_block_type = '',Input_engine_information_cylinders = '',Input_engine_information_filler2 = '',Input_engine_information_carburetion = '',Input_engine_information_filler3 = '',Input_engine_information_head_configuration = '',Input_engine_information_filler4 = '',Input_engine_information_total_valves = '',Input_engine_information_filler5 = '',Input_engine_information_aspiration_code = '',Input_engine_information_carburetion_code = '',Input_engine_information_valves_per_cylinder = '',Input_transmission_speed = '',Input_transmission_filler1 = '',Input_transmission_type = '',Input_transmission_filler2 = '',Input_transmission_code = '',Input_transmission_filler3 = '',Input_transmission_speed_code = '',Input_base_model = '',Input_complete_prefix_file_id = '',Input_series_name_full_spelling = '',Input_vis_theft_code = '',Input_base_list_price_expanded = '',Input_default_nada_vehicle_id = '',Input_default_nada_model = '',Input_default_nada_body_style = '',Input_default_nada_msrp = '',Input_default_nada_gvwr = '',Input_default_nada_gcwr = '',Input_alt_1_nada_vehicle_id = '',Input_alt_1_nada_model = '',Input_alt_1_nada_body_style = '',Input_alt_1_nada_msrp = '',Input_alt_1_nada_gvwr = '',Input_alt_1_nada_gcwr = '',Input_alt_2_nada_vehicle_id = '',Input_alt_2_nada_model = '',Input_alt_2_nada_body_style = '',Input_alt_2_nada_msrp = '',Input_alt_2_nada_gvwr = '',Input_alt_2_nada_gcwr = '',Input_alt_3_nada_vehicle_id = '',Input_alt_3_nada_model = '',Input_alt_3_nada_body_style = '',Input_alt_3_nada_msrp = '',Input_alt_3_nada_gvwr = '',Input_alt_3_nada_gcwr = '',Input_alt_4_nada_vehicle_id = '',Input_alt_4_nada_model = '',Input_alt_4_nada_body_style = '',Input_alt_4_nada_msrp = '',Input_alt_4_nada_gvwr = '',Input_alt_4_nada_gcwr = '',Input_alt_5_nada_vehicle_id = '',Input_alt_5_nada_model = '',Input_alt_5_nada_body_style = '',Input_alt_5_nada_msrp = '',Input_alt_5_nada_gvwr = '',Input_alt_5_nada_gcwr = '',Input_alt_6_nada_vehicle_id = '',Input_alt_6_nada_model = '',Input_alt_6_nada_body_style = '',Input_alt_6_nada_msrp = '',Input_alt_6_nada_gvwr = '',Input_alt_6_nada_gcwr = '',Input_alt_7_nada_vehicle_id = '',Input_alt_7_nada_model = '',Input_alt_7_nada_body_style = '',Input_alt_7_nada_msrp = '',Input_alt_7_nada_gvwr = '',Input_alt_7_nada_gcwr = '',Input_aaia_codes = '',Input_incomplete_vehicle_flag = '',Input_filler2 = '',Input_electric_battery_info_type = '',Input_filler3 = '',Input_electric_battery_kilowatts = '',Input_filler4 = '',Input_electric_battery_volts = '',Input_filler5 = '',Input_engine_info_proprietary_engine_brand = '',Input_filler6 = '',Input_engine_info_high_output_engine = '',Input_engine_info_supercharged = '',Input_engine_info_turbocharged = '',Input_engine_info_vvtl = '',Input_iso_liability = '',Input_series_name_condensed = '',Input_aces_data = '',Input_base_shipping_weight_expanded = '',Input_filler7 = '',Input_customer_defined_data = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_VINA;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_match_make)='' )
      '' 
    #ELSE
        IF( le.Input_match_make = (TYPEOF(le.Input_match_make))'','',':match_make')
    #END

+    #IF( #TEXT(Input_match_year)='' )
      '' 
    #ELSE
        IF( le.Input_match_year = (TYPEOF(le.Input_match_year))'','',':match_year')
    #END

+    #IF( #TEXT(Input_match_vin)='' )
      '' 
    #ELSE
        IF( le.Input_match_vin = (TYPEOF(le.Input_match_vin))'','',':match_vin')
    #END

+    #IF( #TEXT(Input_make_abbreviation)='' )
      '' 
    #ELSE
        IF( le.Input_make_abbreviation = (TYPEOF(le.Input_make_abbreviation))'','',':make_abbreviation')
    #END

+    #IF( #TEXT(Input_model_year)='' )
      '' 
    #ELSE
        IF( le.Input_model_year = (TYPEOF(le.Input_model_year))'','',':model_year')
    #END

+    #IF( #TEXT(Input_vehicle_type)='' )
      '' 
    #ELSE
        IF( le.Input_vehicle_type = (TYPEOF(le.Input_vehicle_type))'','',':vehicle_type')
    #END

+    #IF( #TEXT(Input_make_name)='' )
      '' 
    #ELSE
        IF( le.Input_make_name = (TYPEOF(le.Input_make_name))'','',':make_name')
    #END

+    #IF( #TEXT(Input_series_name)='' )
      '' 
    #ELSE
        IF( le.Input_series_name = (TYPEOF(le.Input_series_name))'','',':series_name')
    #END

+    #IF( #TEXT(Input_body_type)='' )
      '' 
    #ELSE
        IF( le.Input_body_type = (TYPEOF(le.Input_body_type))'','',':body_type')
    #END

+    #IF( #TEXT(Input_wheels)='' )
      '' 
    #ELSE
        IF( le.Input_wheels = (TYPEOF(le.Input_wheels))'','',':wheels')
    #END

+    #IF( #TEXT(Input_displacement)='' )
      '' 
    #ELSE
        IF( le.Input_displacement = (TYPEOF(le.Input_displacement))'','',':displacement')
    #END

+    #IF( #TEXT(Input_cylinders)='' )
      '' 
    #ELSE
        IF( le.Input_cylinders = (TYPEOF(le.Input_cylinders))'','',':cylinders')
    #END

+    #IF( #TEXT(Input_fuel)='' )
      '' 
    #ELSE
        IF( le.Input_fuel = (TYPEOF(le.Input_fuel))'','',':fuel')
    #END

+    #IF( #TEXT(Input_carburetion)='' )
      '' 
    #ELSE
        IF( le.Input_carburetion = (TYPEOF(le.Input_carburetion))'','',':carburetion')
    #END

+    #IF( #TEXT(Input_gvw)='' )
      '' 
    #ELSE
        IF( le.Input_gvw = (TYPEOF(le.Input_gvw))'','',':gvw')
    #END

+    #IF( #TEXT(Input_wheel_base)='' )
      '' 
    #ELSE
        IF( le.Input_wheel_base = (TYPEOF(le.Input_wheel_base))'','',':wheel_base')
    #END

+    #IF( #TEXT(Input_tire_size)='' )
      '' 
    #ELSE
        IF( le.Input_tire_size = (TYPEOF(le.Input_tire_size))'','',':tire_size')
    #END

+    #IF( #TEXT(Input_ton_rating)='' )
      '' 
    #ELSE
        IF( le.Input_ton_rating = (TYPEOF(le.Input_ton_rating))'','',':ton_rating')
    #END

+    #IF( #TEXT(Input_base_shipping_weight)='' )
      '' 
    #ELSE
        IF( le.Input_base_shipping_weight = (TYPEOF(le.Input_base_shipping_weight))'','',':base_shipping_weight')
    #END

+    #IF( #TEXT(Input_variance_weight)='' )
      '' 
    #ELSE
        IF( le.Input_variance_weight = (TYPEOF(le.Input_variance_weight))'','',':variance_weight')
    #END

+    #IF( #TEXT(Input_base_list_price)='' )
      '' 
    #ELSE
        IF( le.Input_base_list_price = (TYPEOF(le.Input_base_list_price))'','',':base_list_price')
    #END

+    #IF( #TEXT(Input_price_variance)='' )
      '' 
    #ELSE
        IF( le.Input_price_variance = (TYPEOF(le.Input_price_variance))'','',':price_variance')
    #END

+    #IF( #TEXT(Input_high_performance_code)='' )
      '' 
    #ELSE
        IF( le.Input_high_performance_code = (TYPEOF(le.Input_high_performance_code))'','',':high_performance_code')
    #END

+    #IF( #TEXT(Input_driving_wheels)='' )
      '' 
    #ELSE
        IF( le.Input_driving_wheels = (TYPEOF(le.Input_driving_wheels))'','',':driving_wheels')
    #END

+    #IF( #TEXT(Input_iso_physical_damage)='' )
      '' 
    #ELSE
        IF( le.Input_iso_physical_damage = (TYPEOF(le.Input_iso_physical_damage))'','',':iso_physical_damage')
    #END

+    #IF( #TEXT(Input_location_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_location_indicator = (TYPEOF(le.Input_location_indicator))'','',':location_indicator')
    #END

+    #IF( #TEXT(Input_air_conditioning)='' )
      '' 
    #ELSE
        IF( le.Input_air_conditioning = (TYPEOF(le.Input_air_conditioning))'','',':air_conditioning')
    #END

+    #IF( #TEXT(Input_power_steering)='' )
      '' 
    #ELSE
        IF( le.Input_power_steering = (TYPEOF(le.Input_power_steering))'','',':power_steering')
    #END

+    #IF( #TEXT(Input_power_brakes)='' )
      '' 
    #ELSE
        IF( le.Input_power_brakes = (TYPEOF(le.Input_power_brakes))'','',':power_brakes')
    #END

+    #IF( #TEXT(Input_power_windows)='' )
      '' 
    #ELSE
        IF( le.Input_power_windows = (TYPEOF(le.Input_power_windows))'','',':power_windows')
    #END

+    #IF( #TEXT(Input_tilt_wheel)='' )
      '' 
    #ELSE
        IF( le.Input_tilt_wheel = (TYPEOF(le.Input_tilt_wheel))'','',':tilt_wheel')
    #END

+    #IF( #TEXT(Input_roof)='' )
      '' 
    #ELSE
        IF( le.Input_roof = (TYPEOF(le.Input_roof))'','',':roof')
    #END

+    #IF( #TEXT(Input_optional_roof1)='' )
      '' 
    #ELSE
        IF( le.Input_optional_roof1 = (TYPEOF(le.Input_optional_roof1))'','',':optional_roof1')
    #END

+    #IF( #TEXT(Input_optional_roof2)='' )
      '' 
    #ELSE
        IF( le.Input_optional_roof2 = (TYPEOF(le.Input_optional_roof2))'','',':optional_roof2')
    #END

+    #IF( #TEXT(Input_radio)='' )
      '' 
    #ELSE
        IF( le.Input_radio = (TYPEOF(le.Input_radio))'','',':radio')
    #END

+    #IF( #TEXT(Input_optional_radio1)='' )
      '' 
    #ELSE
        IF( le.Input_optional_radio1 = (TYPEOF(le.Input_optional_radio1))'','',':optional_radio1')
    #END

+    #IF( #TEXT(Input_optional_radio2)='' )
      '' 
    #ELSE
        IF( le.Input_optional_radio2 = (TYPEOF(le.Input_optional_radio2))'','',':optional_radio2')
    #END

+    #IF( #TEXT(Input_transmission)='' )
      '' 
    #ELSE
        IF( le.Input_transmission = (TYPEOF(le.Input_transmission))'','',':transmission')
    #END

+    #IF( #TEXT(Input_optional_transmission1)='' )
      '' 
    #ELSE
        IF( le.Input_optional_transmission1 = (TYPEOF(le.Input_optional_transmission1))'','',':optional_transmission1')
    #END

+    #IF( #TEXT(Input_optional_transmission2)='' )
      '' 
    #ELSE
        IF( le.Input_optional_transmission2 = (TYPEOF(le.Input_optional_transmission2))'','',':optional_transmission2')
    #END

+    #IF( #TEXT(Input_anti_lock_brakes)='' )
      '' 
    #ELSE
        IF( le.Input_anti_lock_brakes = (TYPEOF(le.Input_anti_lock_brakes))'','',':anti_lock_brakes')
    #END

+    #IF( #TEXT(Input_security_system)='' )
      '' 
    #ELSE
        IF( le.Input_security_system = (TYPEOF(le.Input_security_system))'','',':security_system')
    #END

+    #IF( #TEXT(Input_daytime_running_lights)='' )
      '' 
    #ELSE
        IF( le.Input_daytime_running_lights = (TYPEOF(le.Input_daytime_running_lights))'','',':daytime_running_lights')
    #END

+    #IF( #TEXT(Input_visrap)='' )
      '' 
    #ELSE
        IF( le.Input_visrap = (TYPEOF(le.Input_visrap))'','',':visrap')
    #END

+    #IF( #TEXT(Input_cab_configuration)='' )
      '' 
    #ELSE
        IF( le.Input_cab_configuration = (TYPEOF(le.Input_cab_configuration))'','',':cab_configuration')
    #END

+    #IF( #TEXT(Input_front_axle_code)='' )
      '' 
    #ELSE
        IF( le.Input_front_axle_code = (TYPEOF(le.Input_front_axle_code))'','',':front_axle_code')
    #END

+    #IF( #TEXT(Input_rear_axle_code)='' )
      '' 
    #ELSE
        IF( le.Input_rear_axle_code = (TYPEOF(le.Input_rear_axle_code))'','',':rear_axle_code')
    #END

+    #IF( #TEXT(Input_brakes_code)='' )
      '' 
    #ELSE
        IF( le.Input_brakes_code = (TYPEOF(le.Input_brakes_code))'','',':brakes_code')
    #END

+    #IF( #TEXT(Input_engine_manufacturer)='' )
      '' 
    #ELSE
        IF( le.Input_engine_manufacturer = (TYPEOF(le.Input_engine_manufacturer))'','',':engine_manufacturer')
    #END

+    #IF( #TEXT(Input_engine_model)='' )
      '' 
    #ELSE
        IF( le.Input_engine_model = (TYPEOF(le.Input_engine_model))'','',':engine_model')
    #END

+    #IF( #TEXT(Input_engine_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_engine_type_code = (TYPEOF(le.Input_engine_type_code))'','',':engine_type_code')
    #END

+    #IF( #TEXT(Input_trailer_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_trailer_body_style = (TYPEOF(le.Input_trailer_body_style))'','',':trailer_body_style')
    #END

+    #IF( #TEXT(Input_trailer_number_of_axles)='' )
      '' 
    #ELSE
        IF( le.Input_trailer_number_of_axles = (TYPEOF(le.Input_trailer_number_of_axles))'','',':trailer_number_of_axles')
    #END

+    #IF( #TEXT(Input_trailer_length)='' )
      '' 
    #ELSE
        IF( le.Input_trailer_length = (TYPEOF(le.Input_trailer_length))'','',':trailer_length')
    #END

+    #IF( #TEXT(Input_proactive_vin)='' )
      '' 
    #ELSE
        IF( le.Input_proactive_vin = (TYPEOF(le.Input_proactive_vin))'','',':proactive_vin')
    #END

+    #IF( #TEXT(Input_ma_state_exceptions)='' )
      '' 
    #ELSE
        IF( le.Input_ma_state_exceptions = (TYPEOF(le.Input_ma_state_exceptions))'','',':ma_state_exceptions')
    #END

+    #IF( #TEXT(Input_filler_1)='' )
      '' 
    #ELSE
        IF( le.Input_filler_1 = (TYPEOF(le.Input_filler_1))'','',':filler_1')
    #END

+    #IF( #TEXT(Input_series_abbreviation)='' )
      '' 
    #ELSE
        IF( le.Input_series_abbreviation = (TYPEOF(le.Input_series_abbreviation))'','',':series_abbreviation')
    #END

+    #IF( #TEXT(Input_vin_pattern)='' )
      '' 
    #ELSE
        IF( le.Input_vin_pattern = (TYPEOF(le.Input_vin_pattern))'','',':vin_pattern')
    #END

+    #IF( #TEXT(Input_ncic_data)='' )
      '' 
    #ELSE
        IF( le.Input_ncic_data = (TYPEOF(le.Input_ncic_data))'','',':ncic_data')
    #END

+    #IF( #TEXT(Input_full_body_style_name)='' )
      '' 
    #ELSE
        IF( le.Input_full_body_style_name = (TYPEOF(le.Input_full_body_style_name))'','',':full_body_style_name')
    #END

+    #IF( #TEXT(Input_nvpp_make_code)='' )
      '' 
    #ELSE
        IF( le.Input_nvpp_make_code = (TYPEOF(le.Input_nvpp_make_code))'','',':nvpp_make_code')
    #END

+    #IF( #TEXT(Input_nvpp_make_abbreviation)='' )
      '' 
    #ELSE
        IF( le.Input_nvpp_make_abbreviation = (TYPEOF(le.Input_nvpp_make_abbreviation))'','',':nvpp_make_abbreviation')
    #END

+    #IF( #TEXT(Input_nvpp_series_model)='' )
      '' 
    #ELSE
        IF( le.Input_nvpp_series_model = (TYPEOF(le.Input_nvpp_series_model))'','',':nvpp_series_model')
    #END

+    #IF( #TEXT(Input_nvpp_series_name)='' )
      '' 
    #ELSE
        IF( le.Input_nvpp_series_name = (TYPEOF(le.Input_nvpp_series_name))'','',':nvpp_series_name')
    #END

+    #IF( #TEXT(Input_segmentation_code)='' )
      '' 
    #ELSE
        IF( le.Input_segmentation_code = (TYPEOF(le.Input_segmentation_code))'','',':segmentation_code')
    #END

+    #IF( #TEXT(Input_country_of_origin)='' )
      '' 
    #ELSE
        IF( le.Input_country_of_origin = (TYPEOF(le.Input_country_of_origin))'','',':country_of_origin')
    #END

+    #IF( #TEXT(Input_engine_liter_information)='' )
      '' 
    #ELSE
        IF( le.Input_engine_liter_information = (TYPEOF(le.Input_engine_liter_information))'','',':engine_liter_information')
    #END

+    #IF( #TEXT(Input_engine_information_filler1)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_filler1 = (TYPEOF(le.Input_engine_information_filler1))'','',':engine_information_filler1')
    #END

+    #IF( #TEXT(Input_engine_information_block_type)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_block_type = (TYPEOF(le.Input_engine_information_block_type))'','',':engine_information_block_type')
    #END

+    #IF( #TEXT(Input_engine_information_cylinders)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_cylinders = (TYPEOF(le.Input_engine_information_cylinders))'','',':engine_information_cylinders')
    #END

+    #IF( #TEXT(Input_engine_information_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_filler2 = (TYPEOF(le.Input_engine_information_filler2))'','',':engine_information_filler2')
    #END

+    #IF( #TEXT(Input_engine_information_carburetion)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_carburetion = (TYPEOF(le.Input_engine_information_carburetion))'','',':engine_information_carburetion')
    #END

+    #IF( #TEXT(Input_engine_information_filler3)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_filler3 = (TYPEOF(le.Input_engine_information_filler3))'','',':engine_information_filler3')
    #END

+    #IF( #TEXT(Input_engine_information_head_configuration)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_head_configuration = (TYPEOF(le.Input_engine_information_head_configuration))'','',':engine_information_head_configuration')
    #END

+    #IF( #TEXT(Input_engine_information_filler4)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_filler4 = (TYPEOF(le.Input_engine_information_filler4))'','',':engine_information_filler4')
    #END

+    #IF( #TEXT(Input_engine_information_total_valves)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_total_valves = (TYPEOF(le.Input_engine_information_total_valves))'','',':engine_information_total_valves')
    #END

+    #IF( #TEXT(Input_engine_information_filler5)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_filler5 = (TYPEOF(le.Input_engine_information_filler5))'','',':engine_information_filler5')
    #END

+    #IF( #TEXT(Input_engine_information_aspiration_code)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_aspiration_code = (TYPEOF(le.Input_engine_information_aspiration_code))'','',':engine_information_aspiration_code')
    #END

+    #IF( #TEXT(Input_engine_information_carburetion_code)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_carburetion_code = (TYPEOF(le.Input_engine_information_carburetion_code))'','',':engine_information_carburetion_code')
    #END

+    #IF( #TEXT(Input_engine_information_valves_per_cylinder)='' )
      '' 
    #ELSE
        IF( le.Input_engine_information_valves_per_cylinder = (TYPEOF(le.Input_engine_information_valves_per_cylinder))'','',':engine_information_valves_per_cylinder')
    #END

+    #IF( #TEXT(Input_transmission_speed)='' )
      '' 
    #ELSE
        IF( le.Input_transmission_speed = (TYPEOF(le.Input_transmission_speed))'','',':transmission_speed')
    #END

+    #IF( #TEXT(Input_transmission_filler1)='' )
      '' 
    #ELSE
        IF( le.Input_transmission_filler1 = (TYPEOF(le.Input_transmission_filler1))'','',':transmission_filler1')
    #END

+    #IF( #TEXT(Input_transmission_type)='' )
      '' 
    #ELSE
        IF( le.Input_transmission_type = (TYPEOF(le.Input_transmission_type))'','',':transmission_type')
    #END

+    #IF( #TEXT(Input_transmission_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_transmission_filler2 = (TYPEOF(le.Input_transmission_filler2))'','',':transmission_filler2')
    #END

+    #IF( #TEXT(Input_transmission_code)='' )
      '' 
    #ELSE
        IF( le.Input_transmission_code = (TYPEOF(le.Input_transmission_code))'','',':transmission_code')
    #END

+    #IF( #TEXT(Input_transmission_filler3)='' )
      '' 
    #ELSE
        IF( le.Input_transmission_filler3 = (TYPEOF(le.Input_transmission_filler3))'','',':transmission_filler3')
    #END

+    #IF( #TEXT(Input_transmission_speed_code)='' )
      '' 
    #ELSE
        IF( le.Input_transmission_speed_code = (TYPEOF(le.Input_transmission_speed_code))'','',':transmission_speed_code')
    #END

+    #IF( #TEXT(Input_base_model)='' )
      '' 
    #ELSE
        IF( le.Input_base_model = (TYPEOF(le.Input_base_model))'','',':base_model')
    #END

+    #IF( #TEXT(Input_complete_prefix_file_id)='' )
      '' 
    #ELSE
        IF( le.Input_complete_prefix_file_id = (TYPEOF(le.Input_complete_prefix_file_id))'','',':complete_prefix_file_id')
    #END

+    #IF( #TEXT(Input_series_name_full_spelling)='' )
      '' 
    #ELSE
        IF( le.Input_series_name_full_spelling = (TYPEOF(le.Input_series_name_full_spelling))'','',':series_name_full_spelling')
    #END

+    #IF( #TEXT(Input_vis_theft_code)='' )
      '' 
    #ELSE
        IF( le.Input_vis_theft_code = (TYPEOF(le.Input_vis_theft_code))'','',':vis_theft_code')
    #END

+    #IF( #TEXT(Input_base_list_price_expanded)='' )
      '' 
    #ELSE
        IF( le.Input_base_list_price_expanded = (TYPEOF(le.Input_base_list_price_expanded))'','',':base_list_price_expanded')
    #END

+    #IF( #TEXT(Input_default_nada_vehicle_id)='' )
      '' 
    #ELSE
        IF( le.Input_default_nada_vehicle_id = (TYPEOF(le.Input_default_nada_vehicle_id))'','',':default_nada_vehicle_id')
    #END

+    #IF( #TEXT(Input_default_nada_model)='' )
      '' 
    #ELSE
        IF( le.Input_default_nada_model = (TYPEOF(le.Input_default_nada_model))'','',':default_nada_model')
    #END

+    #IF( #TEXT(Input_default_nada_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_default_nada_body_style = (TYPEOF(le.Input_default_nada_body_style))'','',':default_nada_body_style')
    #END

+    #IF( #TEXT(Input_default_nada_msrp)='' )
      '' 
    #ELSE
        IF( le.Input_default_nada_msrp = (TYPEOF(le.Input_default_nada_msrp))'','',':default_nada_msrp')
    #END

+    #IF( #TEXT(Input_default_nada_gvwr)='' )
      '' 
    #ELSE
        IF( le.Input_default_nada_gvwr = (TYPEOF(le.Input_default_nada_gvwr))'','',':default_nada_gvwr')
    #END

+    #IF( #TEXT(Input_default_nada_gcwr)='' )
      '' 
    #ELSE
        IF( le.Input_default_nada_gcwr = (TYPEOF(le.Input_default_nada_gcwr))'','',':default_nada_gcwr')
    #END

+    #IF( #TEXT(Input_alt_1_nada_vehicle_id)='' )
      '' 
    #ELSE
        IF( le.Input_alt_1_nada_vehicle_id = (TYPEOF(le.Input_alt_1_nada_vehicle_id))'','',':alt_1_nada_vehicle_id')
    #END

+    #IF( #TEXT(Input_alt_1_nada_model)='' )
      '' 
    #ELSE
        IF( le.Input_alt_1_nada_model = (TYPEOF(le.Input_alt_1_nada_model))'','',':alt_1_nada_model')
    #END

+    #IF( #TEXT(Input_alt_1_nada_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_alt_1_nada_body_style = (TYPEOF(le.Input_alt_1_nada_body_style))'','',':alt_1_nada_body_style')
    #END

+    #IF( #TEXT(Input_alt_1_nada_msrp)='' )
      '' 
    #ELSE
        IF( le.Input_alt_1_nada_msrp = (TYPEOF(le.Input_alt_1_nada_msrp))'','',':alt_1_nada_msrp')
    #END

+    #IF( #TEXT(Input_alt_1_nada_gvwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_1_nada_gvwr = (TYPEOF(le.Input_alt_1_nada_gvwr))'','',':alt_1_nada_gvwr')
    #END

+    #IF( #TEXT(Input_alt_1_nada_gcwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_1_nada_gcwr = (TYPEOF(le.Input_alt_1_nada_gcwr))'','',':alt_1_nada_gcwr')
    #END

+    #IF( #TEXT(Input_alt_2_nada_vehicle_id)='' )
      '' 
    #ELSE
        IF( le.Input_alt_2_nada_vehicle_id = (TYPEOF(le.Input_alt_2_nada_vehicle_id))'','',':alt_2_nada_vehicle_id')
    #END

+    #IF( #TEXT(Input_alt_2_nada_model)='' )
      '' 
    #ELSE
        IF( le.Input_alt_2_nada_model = (TYPEOF(le.Input_alt_2_nada_model))'','',':alt_2_nada_model')
    #END

+    #IF( #TEXT(Input_alt_2_nada_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_alt_2_nada_body_style = (TYPEOF(le.Input_alt_2_nada_body_style))'','',':alt_2_nada_body_style')
    #END

+    #IF( #TEXT(Input_alt_2_nada_msrp)='' )
      '' 
    #ELSE
        IF( le.Input_alt_2_nada_msrp = (TYPEOF(le.Input_alt_2_nada_msrp))'','',':alt_2_nada_msrp')
    #END

+    #IF( #TEXT(Input_alt_2_nada_gvwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_2_nada_gvwr = (TYPEOF(le.Input_alt_2_nada_gvwr))'','',':alt_2_nada_gvwr')
    #END

+    #IF( #TEXT(Input_alt_2_nada_gcwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_2_nada_gcwr = (TYPEOF(le.Input_alt_2_nada_gcwr))'','',':alt_2_nada_gcwr')
    #END

+    #IF( #TEXT(Input_alt_3_nada_vehicle_id)='' )
      '' 
    #ELSE
        IF( le.Input_alt_3_nada_vehicle_id = (TYPEOF(le.Input_alt_3_nada_vehicle_id))'','',':alt_3_nada_vehicle_id')
    #END

+    #IF( #TEXT(Input_alt_3_nada_model)='' )
      '' 
    #ELSE
        IF( le.Input_alt_3_nada_model = (TYPEOF(le.Input_alt_3_nada_model))'','',':alt_3_nada_model')
    #END

+    #IF( #TEXT(Input_alt_3_nada_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_alt_3_nada_body_style = (TYPEOF(le.Input_alt_3_nada_body_style))'','',':alt_3_nada_body_style')
    #END

+    #IF( #TEXT(Input_alt_3_nada_msrp)='' )
      '' 
    #ELSE
        IF( le.Input_alt_3_nada_msrp = (TYPEOF(le.Input_alt_3_nada_msrp))'','',':alt_3_nada_msrp')
    #END

+    #IF( #TEXT(Input_alt_3_nada_gvwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_3_nada_gvwr = (TYPEOF(le.Input_alt_3_nada_gvwr))'','',':alt_3_nada_gvwr')
    #END

+    #IF( #TEXT(Input_alt_3_nada_gcwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_3_nada_gcwr = (TYPEOF(le.Input_alt_3_nada_gcwr))'','',':alt_3_nada_gcwr')
    #END

+    #IF( #TEXT(Input_alt_4_nada_vehicle_id)='' )
      '' 
    #ELSE
        IF( le.Input_alt_4_nada_vehicle_id = (TYPEOF(le.Input_alt_4_nada_vehicle_id))'','',':alt_4_nada_vehicle_id')
    #END

+    #IF( #TEXT(Input_alt_4_nada_model)='' )
      '' 
    #ELSE
        IF( le.Input_alt_4_nada_model = (TYPEOF(le.Input_alt_4_nada_model))'','',':alt_4_nada_model')
    #END

+    #IF( #TEXT(Input_alt_4_nada_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_alt_4_nada_body_style = (TYPEOF(le.Input_alt_4_nada_body_style))'','',':alt_4_nada_body_style')
    #END

+    #IF( #TEXT(Input_alt_4_nada_msrp)='' )
      '' 
    #ELSE
        IF( le.Input_alt_4_nada_msrp = (TYPEOF(le.Input_alt_4_nada_msrp))'','',':alt_4_nada_msrp')
    #END

+    #IF( #TEXT(Input_alt_4_nada_gvwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_4_nada_gvwr = (TYPEOF(le.Input_alt_4_nada_gvwr))'','',':alt_4_nada_gvwr')
    #END

+    #IF( #TEXT(Input_alt_4_nada_gcwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_4_nada_gcwr = (TYPEOF(le.Input_alt_4_nada_gcwr))'','',':alt_4_nada_gcwr')
    #END

+    #IF( #TEXT(Input_alt_5_nada_vehicle_id)='' )
      '' 
    #ELSE
        IF( le.Input_alt_5_nada_vehicle_id = (TYPEOF(le.Input_alt_5_nada_vehicle_id))'','',':alt_5_nada_vehicle_id')
    #END

+    #IF( #TEXT(Input_alt_5_nada_model)='' )
      '' 
    #ELSE
        IF( le.Input_alt_5_nada_model = (TYPEOF(le.Input_alt_5_nada_model))'','',':alt_5_nada_model')
    #END

+    #IF( #TEXT(Input_alt_5_nada_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_alt_5_nada_body_style = (TYPEOF(le.Input_alt_5_nada_body_style))'','',':alt_5_nada_body_style')
    #END

+    #IF( #TEXT(Input_alt_5_nada_msrp)='' )
      '' 
    #ELSE
        IF( le.Input_alt_5_nada_msrp = (TYPEOF(le.Input_alt_5_nada_msrp))'','',':alt_5_nada_msrp')
    #END

+    #IF( #TEXT(Input_alt_5_nada_gvwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_5_nada_gvwr = (TYPEOF(le.Input_alt_5_nada_gvwr))'','',':alt_5_nada_gvwr')
    #END

+    #IF( #TEXT(Input_alt_5_nada_gcwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_5_nada_gcwr = (TYPEOF(le.Input_alt_5_nada_gcwr))'','',':alt_5_nada_gcwr')
    #END

+    #IF( #TEXT(Input_alt_6_nada_vehicle_id)='' )
      '' 
    #ELSE
        IF( le.Input_alt_6_nada_vehicle_id = (TYPEOF(le.Input_alt_6_nada_vehicle_id))'','',':alt_6_nada_vehicle_id')
    #END

+    #IF( #TEXT(Input_alt_6_nada_model)='' )
      '' 
    #ELSE
        IF( le.Input_alt_6_nada_model = (TYPEOF(le.Input_alt_6_nada_model))'','',':alt_6_nada_model')
    #END

+    #IF( #TEXT(Input_alt_6_nada_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_alt_6_nada_body_style = (TYPEOF(le.Input_alt_6_nada_body_style))'','',':alt_6_nada_body_style')
    #END

+    #IF( #TEXT(Input_alt_6_nada_msrp)='' )
      '' 
    #ELSE
        IF( le.Input_alt_6_nada_msrp = (TYPEOF(le.Input_alt_6_nada_msrp))'','',':alt_6_nada_msrp')
    #END

+    #IF( #TEXT(Input_alt_6_nada_gvwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_6_nada_gvwr = (TYPEOF(le.Input_alt_6_nada_gvwr))'','',':alt_6_nada_gvwr')
    #END

+    #IF( #TEXT(Input_alt_6_nada_gcwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_6_nada_gcwr = (TYPEOF(le.Input_alt_6_nada_gcwr))'','',':alt_6_nada_gcwr')
    #END

+    #IF( #TEXT(Input_alt_7_nada_vehicle_id)='' )
      '' 
    #ELSE
        IF( le.Input_alt_7_nada_vehicle_id = (TYPEOF(le.Input_alt_7_nada_vehicle_id))'','',':alt_7_nada_vehicle_id')
    #END

+    #IF( #TEXT(Input_alt_7_nada_model)='' )
      '' 
    #ELSE
        IF( le.Input_alt_7_nada_model = (TYPEOF(le.Input_alt_7_nada_model))'','',':alt_7_nada_model')
    #END

+    #IF( #TEXT(Input_alt_7_nada_body_style)='' )
      '' 
    #ELSE
        IF( le.Input_alt_7_nada_body_style = (TYPEOF(le.Input_alt_7_nada_body_style))'','',':alt_7_nada_body_style')
    #END

+    #IF( #TEXT(Input_alt_7_nada_msrp)='' )
      '' 
    #ELSE
        IF( le.Input_alt_7_nada_msrp = (TYPEOF(le.Input_alt_7_nada_msrp))'','',':alt_7_nada_msrp')
    #END

+    #IF( #TEXT(Input_alt_7_nada_gvwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_7_nada_gvwr = (TYPEOF(le.Input_alt_7_nada_gvwr))'','',':alt_7_nada_gvwr')
    #END

+    #IF( #TEXT(Input_alt_7_nada_gcwr)='' )
      '' 
    #ELSE
        IF( le.Input_alt_7_nada_gcwr = (TYPEOF(le.Input_alt_7_nada_gcwr))'','',':alt_7_nada_gcwr')
    #END

+    #IF( #TEXT(Input_aaia_codes)='' )
      '' 
    #ELSE
        IF( le.Input_aaia_codes = (TYPEOF(le.Input_aaia_codes))'','',':aaia_codes')
    #END

+    #IF( #TEXT(Input_incomplete_vehicle_flag)='' )
      '' 
    #ELSE
        IF( le.Input_incomplete_vehicle_flag = (TYPEOF(le.Input_incomplete_vehicle_flag))'','',':incomplete_vehicle_flag')
    #END

+    #IF( #TEXT(Input_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_filler2 = (TYPEOF(le.Input_filler2))'','',':filler2')
    #END

+    #IF( #TEXT(Input_electric_battery_info_type)='' )
      '' 
    #ELSE
        IF( le.Input_electric_battery_info_type = (TYPEOF(le.Input_electric_battery_info_type))'','',':electric_battery_info_type')
    #END

+    #IF( #TEXT(Input_filler3)='' )
      '' 
    #ELSE
        IF( le.Input_filler3 = (TYPEOF(le.Input_filler3))'','',':filler3')
    #END

+    #IF( #TEXT(Input_electric_battery_kilowatts)='' )
      '' 
    #ELSE
        IF( le.Input_electric_battery_kilowatts = (TYPEOF(le.Input_electric_battery_kilowatts))'','',':electric_battery_kilowatts')
    #END

+    #IF( #TEXT(Input_filler4)='' )
      '' 
    #ELSE
        IF( le.Input_filler4 = (TYPEOF(le.Input_filler4))'','',':filler4')
    #END

+    #IF( #TEXT(Input_electric_battery_volts)='' )
      '' 
    #ELSE
        IF( le.Input_electric_battery_volts = (TYPEOF(le.Input_electric_battery_volts))'','',':electric_battery_volts')
    #END

+    #IF( #TEXT(Input_filler5)='' )
      '' 
    #ELSE
        IF( le.Input_filler5 = (TYPEOF(le.Input_filler5))'','',':filler5')
    #END

+    #IF( #TEXT(Input_engine_info_proprietary_engine_brand)='' )
      '' 
    #ELSE
        IF( le.Input_engine_info_proprietary_engine_brand = (TYPEOF(le.Input_engine_info_proprietary_engine_brand))'','',':engine_info_proprietary_engine_brand')
    #END

+    #IF( #TEXT(Input_filler6)='' )
      '' 
    #ELSE
        IF( le.Input_filler6 = (TYPEOF(le.Input_filler6))'','',':filler6')
    #END

+    #IF( #TEXT(Input_engine_info_high_output_engine)='' )
      '' 
    #ELSE
        IF( le.Input_engine_info_high_output_engine = (TYPEOF(le.Input_engine_info_high_output_engine))'','',':engine_info_high_output_engine')
    #END

+    #IF( #TEXT(Input_engine_info_supercharged)='' )
      '' 
    #ELSE
        IF( le.Input_engine_info_supercharged = (TYPEOF(le.Input_engine_info_supercharged))'','',':engine_info_supercharged')
    #END

+    #IF( #TEXT(Input_engine_info_turbocharged)='' )
      '' 
    #ELSE
        IF( le.Input_engine_info_turbocharged = (TYPEOF(le.Input_engine_info_turbocharged))'','',':engine_info_turbocharged')
    #END

+    #IF( #TEXT(Input_engine_info_vvtl)='' )
      '' 
    #ELSE
        IF( le.Input_engine_info_vvtl = (TYPEOF(le.Input_engine_info_vvtl))'','',':engine_info_vvtl')
    #END

+    #IF( #TEXT(Input_iso_liability)='' )
      '' 
    #ELSE
        IF( le.Input_iso_liability = (TYPEOF(le.Input_iso_liability))'','',':iso_liability')
    #END

+    #IF( #TEXT(Input_series_name_condensed)='' )
      '' 
    #ELSE
        IF( le.Input_series_name_condensed = (TYPEOF(le.Input_series_name_condensed))'','',':series_name_condensed')
    #END

+    #IF( #TEXT(Input_aces_data)='' )
      '' 
    #ELSE
        IF( le.Input_aces_data = (TYPEOF(le.Input_aces_data))'','',':aces_data')
    #END

+    #IF( #TEXT(Input_base_shipping_weight_expanded)='' )
      '' 
    #ELSE
        IF( le.Input_base_shipping_weight_expanded = (TYPEOF(le.Input_base_shipping_weight_expanded))'','',':base_shipping_weight_expanded')
    #END

+    #IF( #TEXT(Input_filler7)='' )
      '' 
    #ELSE
        IF( le.Input_filler7 = (TYPEOF(le.Input_filler7))'','',':filler7')
    #END

+    #IF( #TEXT(Input_customer_defined_data)='' )
      '' 
    #ELSE
        IF( le.Input_customer_defined_data = (TYPEOF(le.Input_customer_defined_data))'','',':customer_defined_data')
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
