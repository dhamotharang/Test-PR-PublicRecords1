export Layout_FLCrash1_v4 := record
//	string1   rec_type_1,
	string   accident_nbr,
//	string  Image_nbr,
	string	crash_yr,	//new field added yyyy
	string	crash_date,	//new field mm/dd/yyyy and military time
	string  report_date, // mm/dd/yyyy and military time
	string  invest_agy_rpt_nbr,
//	string    codeable_noncodeable
//	string   day_week,
//  string   hr_accident - now part of crash_date field
//  string   min_accident - now part of crash_date field
//  string   am_pm - now part of crash_date field
	string	form_type,	//new field
	string  total_nbr_vehicles,
	string  total_nbr_persons,
	string	total_nbr_narratives,	//new field
	string  county_code,
	string  city_code,
	string  county_name,
	string  city_name,
	string  rural_urban_code,
	string	notified_date,
	// string   hr_off_notified - now part of notified_date
	// string   min_off_notified - now part of notified_date
	// string    am_pm_notified - now part of notified_date
	string	dispatched_date,	// mm/dd/yyyy and military time
	string	arrived_date,	// mm/dd/yyyy and military time	
	// string   hr_off_arrived	- now part of arrived_date
	// string   min_off_arrived- now part of arrived_date
	// string    am_pm_arrived- now part of arrived_date
	string	cleared_date,	// mm/dd/yyyy and military time
	string  invest_complete,
	string	reason_incomplete,	//new field
	string	notified_by,	//new field
	string	st_road_hhwy_name,	//was part of DOT file
	string	street_address, //new field
	string	latitude,	//new field
	string	longitude,	//new field
	string	ft_from_intersect,	//was part of DOT file
	string	miles_from_intersect,	//was part of DOT file
	string	intersect_dir_of,	//was part of DOT file
	string	of_intersect_of,	//was part of DOT file
	string	from_milepost_nbr,	//new field
	string  rd_sys_id,
	string  type_shoulder,
	string	type_intersect,	//new field
	string  photos_taken,
	string  light_condition,
	string  weather,
	//string  rd_surface_type, - now part of rd_surface_condition
	string   rd_surface_condition,
	string	school_bus_code,	//new field
	string	type_impact,	//new field
	string  first_harmful_event, //receiving this field again
	string  site_loc,
	string	interchange_flag,	//new field
	string	dot_site_loc,	//was part of DOT file 
	string   rd_condition_primary,
	string   rd_condition_secondary,
	string   rd_condition_third, //new field
	//	string   on_off_roadway, - now part of sit_loc field
	string   vision_obstructed_primary,
	string   vision_obstructed_secondary,
	string   vision_obstructed_third, //new field
	// string   first_traffic_control, - now part of vehicle file
	// string   second_traffic_control, - now part of vehicle file
	// string   trafficway_char, - now part of vehicle file
	// string   nbr_lanes, - now part of vehicle file
	// string   divided_undivided, - now part of vehicle file
	// string   accident_injury_severity,
	// string   accident_damage_severity,
	// string   accident_fault_code,
	// string   alcohol_drug,
	// string   total_tar_damage,
	// string   total_vehicle_damage,
	// string   total_prop_damage_amt,
	// string   total_nbr_drivers,
	// string   total_nbr_fatalities,
	// string   total_nbr_non_traffic_fatal,
	// string   total_nbr_injuries,
	// string   total_nbr_pedestrian,
	// string   total_nbr_pedalcyclist,
	string	 work_zone_flag,
	string	 work_zone_crash,
	string	 work_zone_type,
	string   workers_present,
	string	 law_enforcement_present,
	string   invest_id_badge_nbr,
	string   invest_rank,
	string	 invest_fname,
	string	 invest_mname,
	string	 invest_lname,
	string	 invest_suffix,
	string   invest_agency,
	string	 invest_agency_type,
	// string  first_aid_name_code,
	// string   hr_ems_notified,
	// string   min_ems_notified,
	// string    am_pm_ems_notified,
	// string   hr_ems_arrived,
	// string   min_ems_arrived,
	// string    am_pm_ems_arrived,
	// string   injured_taken_to_code, - now part of driver or passenger file
	// string   location_type,
	// string ORMD_Flag
	string load_date
end;