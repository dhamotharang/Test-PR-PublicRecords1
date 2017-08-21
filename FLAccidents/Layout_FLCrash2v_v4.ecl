export Layout_FLCrash2v_v4 := record
	string		accident_nbr,
	string		crash_yr,
	string		section_nbr,
//	string   vehicle_owner_driver_code,
	string	 	vehicle_owner_business,	//new field
	string  	vehicle_owner_firstname,
	string  	vehicle_owner_middlename,
	string  	vehicle_owner_lastname,
	string   	vehicle_owner_suffix,
	string		vehicle_owner_phone,
	string  	vehicle_owner_address,
	string  	vehicle_owner_city,
	string   	vehicle_owner_st,
	string   	vehicle_owner_zip,
	string		commercial_vehicle,	//new field
	string		vehicle_motion,			//new field
	string  	vehicle_tag_nbr,
	string   	vehicle_reg_state,
	string		vehicle_reg_expire,	//dd-mon-yy
	string		permanent_reg,			//new field
	string  	vehicle_id_nbr,
//string   vehicle_driver_action, -- now a hit and run flag
	string		hit_and_run,		//new field
	string    vehicle_year,
	string    vehicle_make,
	string		vehicle_model,	//new field
	string		vehicle_style,	//new field
	string		vehicle_color,	//new field
	string   	damage_type,
	string   	est_vehicle_damage,
	string		tow_damage,		//new field
	string  	vehicle_removed_by,
	string   	how_removed_code,
	string		business_flag,		//new field
	string		total_axles,			//new field
	string   	direction_travel,
	string  	vehicle_travel_on,
	string   	est_vehicle_speed,
	string   	posted_speed,
	string		nbr_lanes,
	string    hazard_material_spilled,
	string   	placarded,
	string    placard_name_nbr,
	string    nbr_on_diamond,
	string   	point_of_impact,
	string		most_damage_area,		//new field	
	string   	vehicle_type,
	string		divided_undivided,
// 	string ins_company_name,
// 	string  ins_policy_nbr,
// 	string  vehicle_owner_dl_nbr,
// 	string   vehicle_owner_dob,
// 	string   vehicle_owner_sex,
// 	string   vehicle_owner_race,
	string		comm_vehicle_config,	//new field
	string		comm_use_code,				//new field
	string		carrier_body_type,		//new field
	string		comm_vehicle_weight,	//new field
//	string    work_area,
	string    first_harmful_event,
	string    second_harmful_event,
	string    third_harmful_event,
	string    fourth_harmful_event,
	string		fifth_harmful_event, //new field
	string		emergency_vehicle_use,	//new field
	string		trafficway_char,
	string		road_alignment,			//was part of trafficway_char in events file
//  string   vehicle_roadway_loc,
//  string   hazard_material_transport,
//  string   total_occu_vehicle,
//  string   total_occu_saf_equip,
//  string   vehicle_insur_code,
//  string   vehicle_fault_code,
//	string2   vehicle_cap_code,
//	string1   vehicle_fr_code,
//	string   	vehicle_use,		//Now two seperate fields for Emergency or Commercial use
 	string   	vehicle_movement,
	string		traffic_control,
	string   	vehicle_function,	
	string   	vehs_first_defect,
	string   	vehs_second_defect,
//	string   dhsmv_vehicle_ind,
/* The following fields are in a seperate trailer file and will need to be joined */
// 	string    towed_trlr_veh_yr,
// 	string    towed_trlr_make,
// 	string    towed_trailer_type,
// 	string   towed_trlr_veh_tag_nbr,
// 	string    towed_trlr_veh_state,
// 	string   towed_trlr_veh_id_nbr,
// 	string    towed_trlr_veh_est_damage,
// 	string   towed_trlr_veh_owner_fname,
// 	string   towed_trlr_veh_owner_mname,
// 	string   towed_trlr_veh_owner_lname,
// 	string    towed_trlr_veh_owner_name_suffix,
// 	string   towed_trlr_veh_owner_st_city,
// 	string   towed_trlr_veh_owner_city,
// 	string    towed_trlr_veh_owner_st,
// 	string    towed_trlr_veh_owner_zip,
end;