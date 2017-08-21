import	_control,PRTE_CSV;

export	Proc_Build_Vina_Key(string	pIndexVersion)	:=
function
	// Get the key layout definitions
	rKeyVina__vina__vin	:=
	record
		PRTE_CSV.Vina.rthor_data400__key__vina__vin;
	end;
	
	// Reformat the csv datasets to the layouts defined above
	dKeyVina__vina__vin	:= 	project(PRTE_CSV.Vina.dthor_data400__key__vina__vin,rKeyVina__vina__vin);
	
	// Index definitions for keys
	kKeyVina__vina__vin	:=	index(	dKeyVina__vina__vin,
																	{l_vin1,l_vin2,l_vin3,l_vin4,l_vin5,l_vin6,l_vin7,l_vin8,l_vin9,l_vin10,l_vin11,l_vin12,l_vin13,l_vin14,l_vin15,l_vin16,l_vin17},
																	{	match_make,match_year,match_vin,make_abbreviation,model_year,vehicle_type,make_name,
																		series_name,body_type,wheels,displacement,cylinders,fuel,carburetion,gvw,wheel_base,tire_size,
																		ton_rating,base_shipping_weight,variance_weight,base_list_price,price_variance,high_performance_code,
																		driving_wheels,iso_physical_damage,location_indicator,air_conditioning,power_steering,power_brakes,
																		power_windows,tilt_wheel,roof,optional_roof1,optional_roof2,radio,optional_radio1,optional_radio2,
																		transmission,optional_transmission1,optional_transmission2,anti_lock_brakes,security_system,
																		daytime_running_lights,visrap,cab_configuration,front_axle_code,rear_axle_code,brakes_code,
																		engine_manufacturer,engine_model,engine_type_code,trailer_body_style,trailer_number_of_axles,
																		trailer_length,proactive_vin,ma_state_exceptions,filler_1,series_abbreviation,vin_pattern,ncic_data,
																		full_body_style_name,nvpp_make_code,nvpp_make_abbreviation,nvpp_series_model,nvpp_series_name,
																		segmentation_code,country_of_origin,engine_liter_information,engine_information_filler1,engine_information_block_type,
																		engine_information_cylinders,engine_information_filler2,engine_information_carburetion,engine_information_filler3,
																		engine_information_head_configuration,engine_information_filler4,engine_information_total_valves,
																		engine_information_filler5,engine_information_aspiration_code,engine_information_carburetion_code,
																		engine_information_valves_per_cylinder,transmission_speed,transmission_filler1,transmission_type,
																		transmission_filler2,transmission_code,transmission_filler3,transmission_speed_code,base_model,
																		complete_prefix_file_id,series_name_full_spelling,vis_theft_code,base_list_price_expanded,
																		default_nada_vehicle_id,default_nada_model,default_nada_body_style,default_nada_msrp,
																		default_nada_gvwr,default_nada_gcwr,alt_1_nada_vehicle_id,alt_1_nada_model,alt_1_nada_body_style,
																		alt_1_nada_msrp,alt_1_nada_gvwr,alt_1_nada_gcwr,alt_2_nada_vehicle_id,alt_2_nada_model,
																		alt_2_nada_body_style,alt_2_nada_msrp,alt_2_nada_gvwr,alt_2_nada_gcwr,alt_3_nada_vehicle_id,
																		alt_3_nada_model,alt_3_nada_body_style,alt_3_nada_msrp,alt_3_nada_gvwr,alt_3_nada_gcwr,
																		alt_4_nada_vehicle_id,alt_4_nada_model,alt_4_nada_body_style,alt_4_nada_msrp,alt_4_nada_gvwr,alt_4_nada_gcwr,
																		alt_5_nada_vehicle_id,alt_5_nada_model,alt_5_nada_body_style,alt_5_nada_msrp,alt_5_nada_gvwr,alt_5_nada_gcwr,
																		alt_6_nada_vehicle_id,alt_6_nada_model,alt_6_nada_body_style,alt_6_nada_msrp,alt_6_nada_gvwr,alt_6_nada_gcwr,
																		alt_7_nada_vehicle_id,alt_7_nada_model,alt_7_nada_body_style,alt_7_nada_msrp,alt_7_nada_gvwr,alt_7_nada_gcwr,
																		aaia_codes,incomplete_vehicle_flag,filler2,electric_battery_info_type,filler3,electric_battery_kilowatts,filler4,
																		electric_battery_volts,filler5,engine_info_proprietary_engine_brand,filler6,engine_info_high_output_engine,
																		engine_info_supercharged,engine_info_turbocharged,engine_info_vvtl,iso_liability,series_name_condensed,
																		aces_data,base_shipping_weight_expanded,filler7,customer_defined_data
																	},
																	'~prte::key::vina::' + pIndexVersion + '::vin'
																);
	
	
	return	sequential(	build(kKeyVina__vina__vin,update),
											PRTE.UpdateVersion(	'Vina_VinKeys',												//	Package name
																					pIndexVersion,												//	Package version
																					_control.MyInfo.EmailAddressNormal,		//	Who to email with specifics
																					'B',																	//	B = Boca,A = Alpharetta
																					'N',																	//	N = Non-FCRA,F = FCRA
																					'N'																		//	N = Do not also include boolean,Y = Include boolean,too
																				)
										);
end;