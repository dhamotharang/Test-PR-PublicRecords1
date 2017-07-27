//had to create these temp layouts as queries are using raw layouts directly FLAccidents.Layout_FLCrash7 

export Layout_temp := module

export flcrash2v := record
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
	string40  vehicle_owner_address,
	string40  vehicle_owner_st_city,
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
	string4   model_year,
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
	string2   blank3,
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
export flcrash4 := record
	string1   rec_type_4,
	string9   accident_nbr,
	string2   section_nbr,
	string2   filler1,
	string25  driver_full_name,
	string16  filler2,
	string1   driver_name_suffix,
	string60  driver_address,
	string40  driver_st_city,
	string18  filler3,
	string2   driver_resident_state,
	string9   driver_zip,
	string8   driver_dob,
	string1   driver_dl_force_asterisk,
	string15  driver_dl_nbr,
	string2   driver_lic_st,
	string1   driver_lic_type,
	string1   driver_bac_test_type,
	string1   driver_bac_force_code,
	string2   driver_bac_test_results,
	string2   filler4,
	string1   driver_alco_drug_code,
	string1   driver_physical_defects,
	string1   driver_residence,
	string1   driver_race,
	string1   driver_sex,
	string1   driver_injury_severity,
	string1   first_driver_safety,
	string1   second_driver_safety,
	string1   driver_eject_code,
	string1   recommand_reexam,
	string10  driver_phone_nbr,
	string2   first_contrib_cause,
	string2   second_contrib_cause,
	string2   third_contrib_cause,
	string8   first_offense_charged,
	string2   first_frdl_sys_charge_code,
	string8   second_offense_charged,
	string2   second_frdl_sys_charge_code,
	string8   third_offense_charged,
	string2   third_frdl_sys_charge_code,
	string7   first_citation_nbr,
	string7   second_citation_nbr,
	string7   third_citation_nbr,
	string2   driver_fr_injury_cap_code,
	string1   dl_nbr_good_bad,
	string8   fourth_offense_charged,
	string2   fourth_frdl_sys_charge_code,
	string8   fifth_offense_charged,
	string2   fifth_frdl_sys_charge_code,
	string8   sixth_offense_charged,
	string2   sixth_frdl_sys_charge_code,
	string8   seveth_offense_charged,
	string2   seveth_frdl_sys_charge_code,
	string8   eighth_offense_charged,
	string2   eighth_frdl_sys_charge_code,
	string7   fourth_citation_nbr,
	string7   fifth_citation_nbr,
	string7   sixth_citation_nbr,
	string7   seventh_citation_nbr,
	string7   eighth_citation_nbr,
	string1   req_endorsement,
	string25  oos_dl_nbr,
	string51  filler5,
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
	string41  ins_company_name,
	string25  ins_policy_nbr,	
end;
export flcrash5 := record
	string1   rec_type_5,
	string9   accident_nbr,
	string2   section_nbr,
	string2   passenger_nbr,
	string25  passenger_full_name,
	string16  filler1,
	string1   passenger_name_suffix,
	string60  passenger_address,
	string40  passenger_st_city,
	string18  filler2,
	string2   passenger_state,
	string9   passenger_zip,
	string2   passenger_age,
	string1   passenger_location,
	string1   passenger_injury_sev,
	string1   first_passenger_safe,
	string1   second_passenger_safe,
	string1   passenger_eject_code,
	string2   passenger_fr_cap_code,
	string266 filler3,
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
end;
export flcrash6 := record
	string1   rec_type_6,
	string9   accident_nbr,
	string2   section_nbr,
	string2   filler1,
	string25  pedest_full_name,
	string16  filler2,
	string1   ped_name_suffix,
	string60  ped_address,
	string40  ped_st_city,
	string18  filler3,
	string2   ped_state,
	string9   ped_zip,
	string8   ded_dob,
	string1   ped_bac_test_type,
	string1   ped_bac_force_code,
	string2   ped_bac_results,
	string2   filler4,
	string1   ped_alco_drugs,
	string1   ped_physical_defect,
	string1   ped_residence,
	string1   ped_race,
	string1   ped_sex,
	string1   ped_injury_sev,
	string2   ped_first_contrib_cause,
	string2   ped_second_contrib_cause,
	string2   ped_third_contrib_cause,
	string2   ped_action,
	string8   first_offense_charged,
	string2   first_frdl_sys_charge_code,
	string8   second_offense_charged,
	string2   second_frdl_sys_charge_code,
	string8   third_offense_charged,
	string2   third_frdl_sys_charge_code,
	string7   first_citation_nbr,
	string7   second_citation_nbr,
	string7   third_citation_nbr,
	string2   ped_fr_injury_cap,
	string8   fourth_offense_charged,
	string2   fourth_frdl_sys_charge_code,
	string8   fifth_offense_charged,
	string2   fifth_frdl_sys_charge_code,
	string8   sixth_offense_charged,
	string2   sixth_sys_charge_code,
	string8   seventh_offense_charged,
	string2   seventh_sys_charge_code,
	string8   eighth_offense_charged,
	string2   eighth_sys_charge_code,
	string7   fourth_citation_issued,
	string7   fifth_citation_issued,
	string7   sixth_citation_issued,
	string7   seventh_citation_issued,
	string7   eighth_citation_issued,
	string15  ped_dl_nbr,
	string94  filler5,
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
end;

export flcrash7 :=  record
	string1   rec_type_7,
	string9   accident_nbr,
	string2   prop_damage_code,
	string2   prop_damage_nbr,
	string25  prop_damaged,
	string7   prop_damage_amount,
	string25  prop_owner_name,
	string16  filler1,
	string1   prop_owner_suffix,
	string60  prop_owner_address,
	string40  prop_owner_st_city,
	string18  filler2,
	string2   prop_owner_state,
	string9   prop_owner_zip,
	string2   fr_fixed_object_cap_code,
	string241 filler3,
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
end;
end;