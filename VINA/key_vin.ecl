

import doxie;

f_vin := VINA.file_vina_infile;

// fix the fields
slim_vina := record

f_vin.match_make;
f_vin.match_year;
f_vin.match_vin;
f_vin.make_abbreviation;
f_vin.model_year;
f_vin.vehicle_type;
f_vin.make_name;
f_vin.series_name;
f_vin.body_type;
f_vin.wheels;
f_vin.displacement;
f_vin.cylinders;
f_vin.fuel;
f_vin.carburetion;
f_vin.gvw;
f_vin.wheel_base;
f_vin.tire_size;
f_vin.ton_rating;

f_vin.base_shipping_weight;
f_vin.variance_weight;
f_vin.base_list_price;
f_vin.price_variance;
f_vin.high_performance_code;

f_vin.driving_wheels;
f_vin.iso_physical_damage;
f_vin.location_indicator;
f_vin.air_conditioning;
f_vin.power_steering;
f_vin.power_brakes;
f_vin.power_windows;
f_vin.tilt_wheel;
f_vin.roof;
f_vin.optional_roof1;
f_vin.optional_roof2;
f_vin.radio;
f_vin.optional_radio1;
f_vin.optional_radio2;
f_vin.transmission;
f_vin.optional_transmission1;
f_vin.optional_transmission2;
f_vin.anti_lock_brakes;
f_vin.security_system;
f_vin.daytime_running_lights;
f_vin.visrap;
f_vin.cab_configuration;
f_vin.front_axle_code;
f_vin.rear_axle_code;
f_vin.brakes_code;
f_vin.engine_manufacturer;
f_vin.engine_model;
f_vin.engine_type_code;
f_vin.trailer_body_style;
f_vin.trailer_number_of_axles;
f_vin.trailer_length;
f_vin.proactive_vin;
f_vin.ma_state_exceptions;
f_vin.filler_1;
f_vin.series_abbreviation;
f_vin.vin_pattern;
f_vin.ncic_data;
f_vin.full_body_style_name;
f_vin.nvpp_make_code;
f_vin.nvpp_make_abbreviation;
f_vin.nvpp_series_model;
f_vin.nvpp_series_name;
f_vin.segmentation_code;
f_vin.country_of_origin;
f_vin.engine_liter_information;
f_vin.engine_information_filler1;
f_vin.engine_information_block_type;
f_vin.engine_information_cylinders;
f_vin.engine_information_filler2;
f_vin.engine_information_carburetion;
f_vin.engine_information_filler3;
f_vin.engine_information_head_configuration;
f_vin.engine_information_filler4;
f_vin.engine_information_total_valves;
f_vin.engine_information_filler5;
f_vin.engine_information_aspiration_code;
f_vin.engine_information_carburetion_code;
f_vin.engine_information_valves_per_cylinder;
f_vin.transmission_speed;
f_vin.transmission_filler1;
f_vin.transmission_type;
f_vin.transmission_filler2;
f_vin.transmission_code;
f_vin.transmission_filler3;
f_vin.transmission_speed_code;
f_vin.base_model;
f_vin.complete_prefix_file_id;
f_vin.series_name_full_spelling;
f_vin.vis_theft_code;
f_vin.base_list_price_expanded;
f_vin.default_nada_vehicle_id;
f_vin.default_nada_model;
f_vin.default_nada_body_style;
f_vin.default_nada_msrp;
f_vin.default_nada_gvwr;
f_vin.default_nada_gcwr;
f_vin.alt_1_nada_vehicle_id;
f_vin.alt_1_nada_model;
f_vin.alt_1_nada_body_style;
f_vin.alt_1_nada_msrp;
f_vin.alt_1_nada_gvwr;
f_vin.alt_1_nada_gcwr;

f_vin.alt_2_nada_vehicle_id;
f_vin.alt_2_nada_model;
f_vin.alt_2_nada_body_style;
f_vin.alt_2_nada_msrp;
f_vin.alt_2_nada_gvwr;
f_vin.alt_2_nada_gcwr;

f_vin.alt_3_nada_vehicle_id;
f_vin.alt_3_nada_model;
f_vin.alt_3_nada_body_style;
f_vin.alt_3_nada_msrp;
f_vin.alt_3_nada_gvwr;
f_vin.alt_3_nada_gcwr;

f_vin.alt_4_nada_vehicle_id;
f_vin.alt_4_nada_model;
f_vin.alt_4_nada_body_style;
f_vin.alt_4_nada_msrp;
f_vin.alt_4_nada_gvwr;
f_vin.alt_4_nada_gcwr;

f_vin.alt_5_nada_vehicle_id;
f_vin.alt_5_nada_model;
f_vin.alt_5_nada_body_style;
f_vin.alt_5_nada_msrp;
f_vin.alt_5_nada_gvwr;
f_vin.alt_5_nada_gcwr;

f_vin.alt_6_nada_vehicle_id;
f_vin.alt_6_nada_model;
f_vin.alt_6_nada_body_style;
f_vin.alt_6_nada_msrp;
f_vin.alt_6_nada_gvwr;
f_vin.alt_6_nada_gcwr;

f_vin.alt_7_nada_vehicle_id;
f_vin.alt_7_nada_model;
f_vin.alt_7_nada_body_style;
f_vin.alt_7_nada_msrp;
f_vin.alt_7_nada_gvwr;
f_vin.alt_7_nada_gcwr;

f_vin.aaia_codes;
f_vin.incomplete_vehicle_flag;
f_vin.filler2;
f_vin.electric_battery_info_type;
f_vin.filler3;
f_vin.electric_battery_kilowatts;
f_vin.filler4;
f_vin.electric_battery_volts;
f_vin.filler5;
f_vin.engine_info_proprietary_engine_brand;
f_vin.filler6;
f_vin.engine_info_high_output_engine;
f_vin.engine_info_supercharged;
f_vin.engine_info_turbocharged;
f_vin.engine_info_vvtl;
f_vin.iso_liability;
f_vin.series_name_condensed;
f_vin.aces_data;
f_vin.base_shipping_weight_expanded;
f_vin.filler7;
f_vin.customer_defined_data;



end;

// fix here
// make this work with vina
tbl_vin := table(f_vin,slim_vina,

match_make,match_year,match_vin,make_abbreviation,model_year,vehicle_type,make_name,
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
			
			
			,few);

// fix_here			
// make this work with vina
export key_vin := index(tbl_vin,
             {
			string1 l_vin1 := match_vin[1],
			string1 l_vin2 := match_vin[2],
			string1 l_vin3 := match_vin[3],
			string1 l_vin4 := match_vin[4],
			string1 l_vin5 := match_vin[5],
			string1 l_vin6 := match_vin[6],
			string1 l_vin7 := match_vin[7],
			string1 l_vin8 := match_vin[8],
			string1 l_vin9 := match_vin[9],
			string1 l_vin10 := match_vin[10],
			string1 l_vin11 := match_vin[11],
			string1 l_vin12 := match_vin[12],
			string1 l_vin13 := match_vin[13],
			string1 l_vin14 := match_vin[14],
			string1 l_vin15 := match_vin[15],
			string1 l_vin16 := match_vin[16],
			string1 l_vin17 := match_vin[17]
			
			},{
			
		match_make,match_year,match_vin,make_abbreviation,model_year,vehicle_type,make_name,
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
              '~thor_data400::key::vina::vin_'+doxie.Version_SuperKey);
			  
