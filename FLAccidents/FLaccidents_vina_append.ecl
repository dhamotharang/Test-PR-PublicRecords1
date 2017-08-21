import VehLic;

EXPORT FLAccidents_vina_append(
	dataset(recordof(FLAccidents.Layout_FLCrash2v_v2))	ds_FLCrash2_0,
	dataset(recordof(FLAccidents.Layout_FLCrash3v_v2))	ds_FLCrash3_0)	:=
MODULE

SHARED ds_FLCrash2				:=	sort(distribute(ds_FLCrash2_0,hash(vehicle_id_nbr)),vehicle_id_nbr,local);
SHARED ds_FLCrash3				:=	sort(distribute(ds_FLCrash3_0,hash(towed_trlr_veh_id_nbr)),towed_trlr_veh_id_nbr,local);
SHARED ds_vin_file_thiscycle	:=	sort(distribute(FLAccidents.FLAccidents_vina(ds_FLCrash2_0,ds_FLCrash3_0,VehLic.File_VINA(vin<>'')).vina_info_layout,hash(vin_input)),vin_input,local);

r_FLCrash2v	:=	record
	string1   rec_type_2,
	string9   accident_nbr,
	string2   section_nbr,
	string2   filler1,
	string1   vehicle_owner_driver_code,
	string1   vehicle_driver_action,
	string4   vehicle_year,
	string4   vehicle_make,
	string2   vehicle_type,
	string8   vehicle_tag_nbr,
	string2   vehicle_reg_state,
	string22  vehicle_id_nbr,
	string36  vehicle_travel_on,
	string1   direction_travel,
	string3   est_vehicle_speed,
	string2   posted_speed,
	string7   est_vehicle_damage,
	string1   damage_type,
	string41  ins_company_name,
	string25  ins_policy_nbr,
	string25  vehicle_removed_by,
	string1   how_removed_code,
	string25  vehicle_owner_name,
	string16  filler2,
	string1   vehicle_owner_suffix,
	string60	vehicle_owner_address,
	string60  vehicle_owner_st_city,
	string18  filler3,
	string2   vehicle_owner_st,
	string9   vehicle_owner_zip,
	string1   vehicle_owner_forge_asterisk,
	string15  vehicle_owner_dl_nbr,
	string8   vehicle_owner_dob,
	string1   vehicle_owner_sex,
	string1   vehicle_owner_race,
	string2   point_of_impact,
	string2   vehicle_movement,
	string2   vehicle_function,
	string1   filler4,
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
	string31  filler5,
	string10  prim_range,
	string2   predir,
	string28  prim_name,
	string4   addr_suffix,
	string2   postdir,
	string10  unit_desig,
	string8   sec_range,
	string25  p_city_name,
	string25  v_city_name,
	string2   st,
	string5   zip,
	string4   zip4,
	string4   cart,
	string1   cr_sort_sz,
	string4   lot,
	string1   lot_order,
	string2   dpbc,
	string1   chk_digit,
	string2   rec_type,
	string2   ace_fips_st,
	string3   county,
	string10  geo_lat,
	string11  geo_long,
	string4   msa,
	string7   geo_blk,
	string1   geo_match,
	string4   err_stat,
	string5   title,
	string20  fname,
	string20  mname,
	string20  lname,
	string5   suffix,
	string3   score,
	string25  cname,
	string4   blank1,
	string42  vehicle_seg,
	string1   vehicle_seg_type,
	string14  match_code,
	string1   blank2,
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
	string5   reference_number,
	string3   vina_make,
	string2   blank3,
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
	ds_vin_file_thiscycle;
end;
r_FLCrash2v	j_FLCrash2v(ds_FLCrash2 l, ds_vin_file_thiscycle r) :=	transform
	self.vin_input				:=	if(r.vin_input='',l.vehicle_id_nbr,r.vin_input);
	self.veh_type				:=	if(r.vin_input='' and l.vehicle_id_nbr=''
										,'P'
										,if(r.vin_input=''
											,'U'
											,r.veh_type
											)
										);
	self.vin					:=	if(r.vin_input='',l.vehicle_id_nbr,r.vin);
	self.vin_error_status		:=	if(r.vin_input='' and l.vehicle_id_nbr=''
										,'000XXXXXXXXXXXXXXXXX'
										,if(r.vin_input=''
											,'X1000000000000000000'
											,r.vin_error_status
											)
										);
	self.vin_pattern_indicator	:=	if(r.vin_input='','0',r.vin_pattern_indicator);
	self.bypass_code			:=	if(r.vin_input='','B',r.bypass_code);
	self						:=	l;
	self						:=	r;
end;

ds_FLCrash2v	:=	join(ds_FLCrash2, ds_vin_file_thiscycle
						,left.vehicle_id_nbr=right.vin_input
						,j_FLCrash2v(left,right)
						,left outer
						,local
						)
						;

EXPORT FLCrash2_layout  := distribute(ds_FLCrash2v,hash(accident_nbr));

/////////////////////////////////

r_FLCrash3v	:=	record
   	string1    rec_type_3,
	string9    accident_nbr,
	string2    section_nbr,
	string2    filler1,
	string4    towed_trlr_veh_yr,
	string4    towed_trlr_make,
	string2    towed_trailer_type,
	string8    towed_trlr_veh_tag_nbr,
	string2    towed_trlr_veh_state,
	string22   towed_trlr_veh_id_nbr,
	string7    towed_trlr_veh_est_damage,
	string25   towed_trlr_veh_owner_name,
	string16   filler2,
	string1    towed_trlr_veh_owner_name_suffix,
	string40   towed_trlr_veh_owner_st_city,
	string18   filler3,
	string2    towed_trlr_veh_owner_st,
	string9    towed_trlr_veh_owner_zip,
	string2    towed_trlr_fr_cap_code,
	string224  filler4,
	string4    blank1,
	string42   vehicle_seg,
	string1    vehicle_seg_type,
	string14   match_code,
	string1    blank2,
	string3    manufacturer_corporation,
	string1    division_code,
	string2    vehicle_group_code,
	string2    vehicle_subgroup_code,
	string2    vehicle_series_code,
	string2    body_style_code,
	string3    vehicle_abbreviation,
	string1    assembly_country,
	string1    headquarter_country,
	string1    number_of_doors,
	string1    seating_capacity,
	string1    carburetion_type,
	string1    number_of_barrels,
	string1    price_class_code,
	string2    body_size_code,
	string1    number_of_wheels_on_road,
	string1    number_of_driving_wheels,
	string1    drive_type,
	string1    steering_type,
	string1    gvw_code,
	string1    load_capacity_code,
	string1    cab_type_code,
	string2    bed_length,
	string1    rim_size,
	string5    manufacture_body_style,
	string1    vehicle_type_code,
	string3    car_line_code,
	string1    car_series_code,
	string1    car_body_style_code,
	string1    engine_cylinder_code,
	string3    truck_make_abbreviation,
	string3    truck_body_style_abbreviation,
	string3    motorcycle_make_abbreviation,
	string5    reference_number,
	string3    vina_make,
	string2    blank3,
	string2    truck_chassis_body_style,
	string2    truck_wheels_driving_wheels,
	string4    truck_cid,
	string2    truck_cylinders,
	string1    truck_fuel_code,
	string1    truck_manufacturers_gvw_code,
	string2    truck_ton_rating_code,
	string3    truck_series,
	string3    truck_model,
	string3    motorcycle_model,
	string4    motorcycle_engine_displacement,
	string2    motorcycle_type_of_bike,
	string2    motorcycle_cylinder_coding,
	ds_vin_file_thiscycle;
end;

r_FLCrash3v	j_FLCrash3v(ds_FLCrash3 l, ds_vin_file_thiscycle r) :=	transform
	self.vin_input				:=	if(r.vin_input='',l.towed_trlr_veh_id_nbr,r.vin_input);
	self.veh_type				:=	if(r.vin_input='' and l.towed_trlr_veh_id_nbr=''
										,'P'
										,if(r.vin_input=''
											,'U'
											,r.veh_type
											)
										);
	self.vin					:=	if(r.vin_input='',l.towed_trlr_veh_id_nbr,r.vin);
	self.vin_error_status		:=	if(r.vin_input='' and l.towed_trlr_veh_id_nbr=''
										,'000XXXXXXXXXXXXXXXXX'
										,if(r.vin_input=''
											,'X1000000000000000000'
											,r.vin_error_status
											)
										);
	self.vin_pattern_indicator	:=	if(r.vin_input='','0',r.vin_pattern_indicator);
	self.bypass_code			:=	if(r.vin_input='','B',r.bypass_code);
	self						:=	l;
	self						:=	r;
end;


ds_FLCrash3v	:=	join(ds_FLCrash3, ds_vin_file_thiscycle
						,left.towed_trlr_veh_id_nbr=right.vin_input
						,j_FLCrash3v(left,right)
						,left outer
						,local
						)
						;

EXPORT FLCrash3_layout  := distribute(ds_FLCrash3v,hash(accident_nbr));

END;