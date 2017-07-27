export layout_vina_infile := 

record
string3	match_make;
string4	match_year;
string17	match_vin;
string4	make_abbreviation;
string4	model_year;
string1	vehicle_type;	//p=passenger,t=truck,m=motorcycle,c=trailer
string35	make_name;	// ie Chevrolet
string25	series_name;	// ie Blazer
string2	body_type;			// not for trailers
string2	wheels;			// trucks only ... The first position represents the number of axles on the vehicle times two and the second position represents the number of drive axles times two.
string4	displacement;	// motorcycles are ccs all others are cid
string2	cylinders;
string1 fuel;	// 
// For Passengers and Trucks only.
// This code represents the type of fuel suggested by the manufacturer.
// B = Hybrid engine: combined gasoline and electric power
// C = Gasoline engine that can be easily converted to a gaseous powered engine (powered by natural gas, propane,
// E = Electric
// F = Flexible fuel
// G = Gas
// H = Ethanol fuel only
// M = Methanol gas only
// N = Compressed natural gas
// P = Propane gas
string1	carburetion;
string1	gvw;
// Blank for Passengers GVW for Trucks The manufacturer’s GVW rating. Codes and associated weight ranges are as follows:
// 1=6,000 and less
// 2=6,001 - 10,000
// 3=10,001 - 14,000
// 4=14,001 - 16,000
// 5=16,001 - 19,500
// 6=19,501 - 26,000
// 7=26,001 - 33,000
// 8=33,001 and greater
// 9=Weight unknown
// Cycles for Motorcycles:
// 1, 2, 3,…=Number of cycles of the bike.
// R=Rotary
string8	wheel_base; // in inches ....
string6	tire_size;
string2	ton_rating; // for trucks only

string4	base_shipping_weight;
string2	variance_weight;
string5	base_list_price; // A=10 Z=34 there is no O .... a price of $132,250 is represented as D2250
string2	price_variance;
string1	high_performance_code;

string1	driving_wheels;
string12	iso_physical_damage; //// lots of fancy stuff here ... see docs
string1	location_indicator;
string1	air_conditioning;
string1	power_steering;
string1	power_brakes;
string1	power_windows;
string1	tilt_wheel;
string1	roof;
string1	optional_roof1;
string1	optional_roof2;
string1	radio;
string1	optional_radio1;
string1	optional_radio2;
string1	transmission;
string1	optional_transmission1;
string1	optional_transmission2;
string1	anti_lock_brakes;
string1	security_system;
string1	daytime_running_lights;
string1	visrap;
string1	cab_configuration;
string1	front_axle_code;
string1	rear_axle_code;
string1	brakes_code;
string15	engine_manufacturer;
string15	engine_model;
string1	engine_type_code;
string3	trailer_body_style;
string1	trailer_number_of_axles;
string3	trailer_length;
string1	proactive_vin;
string6	ma_state_exceptions;
string6	filler_1;
string6	series_abbreviation;
string17	vin_pattern;
string7	ncic_data;
string20	full_body_style_name;
string2	nvpp_make_code;
string3	nvpp_make_abbreviation;
string4	nvpp_series_model;
string30	nvpp_series_name;
string1	segmentation_code;
string20	country_of_origin;
string5	engine_liter_information;
string1	engine_information_filler1;
string1	engine_information_block_type;
string2	engine_information_cylinders;
string1	engine_information_filler2;
string3	engine_information_carburetion;
string1	engine_information_filler3;
string4	engine_information_head_configuration;
string1	engine_information_filler4;
string3	engine_information_total_valves;
string1	engine_information_filler5;
string1	engine_information_aspiration_code;
string1	engine_information_carburetion_code;
string1	engine_information_valves_per_cylinder;
string5	transmission_speed;
string1	transmission_filler1;
string7	transmission_type;
string1	transmission_filler2;
string1	transmission_code;
string1	transmission_filler3;
string1	transmission_speed_code;
string17	base_model;
string7	complete_prefix_file_id;
string10	series_name_full_spelling;
string1	vis_theft_code;
string7	base_list_price_expanded;
string8	default_nada_vehicle_id;
string30	default_nada_model;
string30	default_nada_body_style;
string6	default_nada_msrp;
string6	default_nada_gvwr;
string6	default_nada_gcwr;
string8	alt_1_nada_vehicle_id;
string30	alt_1_nada_model;
string30	alt_1_nada_body_style;
string6	alt_1_nada_msrp;
string6	alt_1_nada_gvwr;
string6	alt_1_nada_gcwr;

string8	alt_2_nada_vehicle_id;
string30	alt_2_nada_model;
string30	alt_2_nada_body_style;
string6	alt_2_nada_msrp;
string6	alt_2_nada_gvwr;
string6	alt_2_nada_gcwr;

string8	alt_3_nada_vehicle_id;
string30	alt_3_nada_model;
string30	alt_3_nada_body_style;
string6	alt_3_nada_msrp;
string6	alt_3_nada_gvwr;
string6	alt_3_nada_gcwr;

string8	alt_4_nada_vehicle_id;
string30	alt_4_nada_model;
string30	alt_4_nada_body_style;
string6	alt_4_nada_msrp;
string6	alt_4_nada_gvwr;
string6	alt_4_nada_gcwr;

string8	alt_5_nada_vehicle_id;
string30	alt_5_nada_model;
string30	alt_5_nada_body_style;
string6	alt_5_nada_msrp;
string6	alt_5_nada_gvwr;
string6	alt_5_nada_gcwr;

string8	alt_6_nada_vehicle_id;
string30	alt_6_nada_model;
string30	alt_6_nada_body_style;
string6	alt_6_nada_msrp;
string6	alt_6_nada_gvwr;
string6	alt_6_nada_gcwr;

string8	alt_7_nada_vehicle_id;
string30	alt_7_nada_model;
string30	alt_7_nada_body_style;
string6	alt_7_nada_msrp;
string6	alt_7_nada_gvwr;
string6	alt_7_nada_gcwr;

string49	aaia_codes;
string1	incomplete_vehicle_flag;
string1	filler2;
string4	electric_battery_info_type;
string1	filler3;
string4	electric_battery_kilowatts;
string1	filler4;
string4	electric_battery_volts;
string1	filler5;
string1	engine_info_proprietary_engine_brand;
string1	filler6;
string1	engine_info_high_output_engine;
string1	engine_info_supercharged;
string1	engine_info_turbocharged;
string1	engine_info_vvtl;
string7	iso_liability;
string20	series_name_condensed;
string97	aces_data;
string5	base_shipping_weight_expanded;
string169	filler7;
string25	customer_defined_data;

string1 crlf
end;