slim_layout := record
    string8 dt_first_seen;
    string8 dt_last_seen;
    string2 report_code;
    string25 report_category;
    string65 report_code_desc;
	string10 vehicle_incident_id;
	string1	vehicle_status;
	string50 accident_location;
	string25 accident_street;
	string25 accident_cross_street;
	string100  jurisdiction;
	string2 jurisdiction_state;
	string11 jurisdiction_nbr;
	string64 IMAGE_HASH;
	string1 AIRBAGS_DEPLOY;
	string12  did,
	string40  accident_nbr,
	string8   accident_date, 
	string5   title,
	string20  fname,
	string20  mname,
	string20  lname,
	string5   name_suffix,
	string12  b_did,
	string25  cname,
	string10  prim_range,
	string2   predir,
	string28  prim_name,
	string4   addr_suffix,
	string2   postdir,
	string10  unit_desig,
	string8   sec_range,
	string25  v_city_name,
	string2   st,
	string5   zip,
	string4   zip4,
    string20  record_type,
	string15  driver_license_nbr,
	string2   dlnbr_st,
	string22  vin,
	string8   tag_nbr,
	string2   tagnbr_st,
	string8 dob,
	
	string25 vehicle_incident_city;
	string2 vehicle_incident_st;
	string41 carrier_name;
	string5	client_type_id;
	string30 Policy_num,	   
  string8 Policy_Effective_Date,   
	string8 Policy_Expiration_Date,
	string4 Report_Has_Coversheet,
	string1 other_vin_indicator;
	string3 vehicle_unit_number;
	string4 towed,
	string80 impact_location,

	string1   vehicle_owner_driver_code,
	string1   vehicle_driver_action,
	string4   vehicle_year,
	string4   vehicle_make,  
	string2   vehicle_type,
	string36  vehicle_travel_on,
	string1   direction_travel,
	string3   est_vehicle_speed,
	string2   posted_speed,
	string7   est_vehicle_damage,
	string1   damage_type,
	string25  vehicle_removed_by,
	string1   how_removed_code,
	
	string15  point_of_impact,
	string2   vehicle_movement,
	string2   vehicle_function,
	string2   vehs_first_defect,
	string2   vehs_second_defect,
	string2   vehicle_modified,
	string2   vehicle_roadway_loc,
	string1   hazard_material_transport,
	string3   total_occu_vehicle,
	string3   total_occu_saf_equip,
	string1   moving_violation,
	string1   vehicle_insur_code,
	string1   vehicle_fault_code,
	string2   vehicle_cap_code,
	string1   vehicle_fr_code,
	string2   vehicle_use,
	string1   placarded,
	string1   dhsmv_vehicle_ind,
	
	string42  vehicle_seg,
	string1   vehicle_seg_type,
	string14  match_code,
	string4   model_year,
	string3   manufacturer_corporation,
	string1   division_code,
	string2   vehicle_group_code,
	string2   vehicle_subgroup_code,
	string2   vehicle_series_code,
	string2   body_style_code,
	string3   vehicle_abbreviation,
	string1   assembly_country,
	string1   headquarter_country,
	string1   number_of_doors,
	string1   seating_capacity,
	string2   number_of_cylinders,
	string4   engine_size,
	string1   fuel_code,
	string1   carburetion_type,
	string1   number_of_barrels,
	string1   price_class_code,
	string2   body_size_code,
	string1   number_of_wheels_on_road,
	string1   number_of_driving_wheels,
	string1   drive_type,
	string1   steering_type,
	string1   gvw_code,
	string1   load_capacity_code,
	string1   cab_type_code,
	string2   bed_length,
	string1   rim_size,
	string5   manufacture_body_style,
	string1   vehicle_type_code,
	string3   car_line_code,
	string1   car_series_code,
	string1   car_body_style_code,
	string1   engine_cylinder_code,
	string3   truck_make_abbreviation,
	string3   truck_body_style_abbreviation,
	string3   motorcycle_make_abbreviation,
	string3   vina_series,
	string3   vina_model,
	string5   reference_number,
	string3   vina_make,
	string2   vina_body_style,
	string20  make_description,
	string20  model_description,
	string20  series_description,
	string3   car_series,
	string2   car_body_style,
	string3   car_cid,
	string2   car_cylinders,
	string1   car_carburetion,
	string1   car_fuel_code,
	string2   truck_chassis_body_style,
	string2   truck_wheels_driving_wheels,
	string4   truck_cid,
	string2   truck_cylinders,
	string1   truck_fuel_code,
	string1   truck_manufacturers_gvw_code,
	string2   truck_ton_rating_code,
	string3   truck_series,
	string3   truck_model,
	string3   motorcycle_model,
	string4   motorcycle_engine_displacement,
	string2   motorcycle_type_of_bike,
	string2   motorcycle_cylinder_coding,
  end;

allrecs := FLAccidents_Ecrash.File_Keybuild_prep;

slim_layout slimrecs(allrecs L) := transform
self 								:= L;
end;

outrecs := project(allrecs,slimrecs(left));

export File_Keybuild := outrecs;

