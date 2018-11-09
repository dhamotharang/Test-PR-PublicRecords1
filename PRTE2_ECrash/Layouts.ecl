import FLAccidents_Ecrash, FLAccidents, BIPV2 ;

EXPORT Layouts := module

//Layouts are created for each custom key, but not for autokeys.  You will need to look at these
 //and find matching layouts in the production code that have all the same fields and then reference
 //the production keys instead of these.

EXPORT Input := RECORD, maxlength(5800)
string40	l_accnbr;
string2		report_code;
string2		jurisdiction_state;
string100	jurisdiction;
string		orig_accnbr;
string11	vehicle_incident_id;
string1		vehicle_status;
	
string8		accident_date;
string12	did;
unsigned1 did_score;
string8		dob,
string12	b_did,
string1		rec_type_4;
string8		dt_first_seen;
string8		dt_last_seen;
string150	orig_street_address1;
string100	orig_street_address2;

//clean address
string10  prim_range,
string2   predir,
string28  prim_name,
string4   addr_suffix,
string2   postdir,
string8   sec_range,
string10  unit_desig,
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

//clean name
string5   title,
string20  fname,
string20  mname,
string20  lname,
// string5   suffix,
string3   score,
string25  cname,
	
string100	record_type;
string65	report_code_desc;
string25	report_category;
string30	vin;
string25	driver_license_nbr;
string2		dlnbr_st;
string10	tag_nbr;
string2		tagnbr_st;

string2   day_week,
string2   hr_accident,
string2   min_accident,
string2   hr_off_notified,
string2   min_off_notified,
string2   hr_off_arrived,
string2   min_off_arrived,
string4   city_nbr,
	
string100	accident_location;
string100	accident_street;
string100	accident_cross_street;
string60	next_street;	
	
string11	jurisdiction_nbr;
string64	image_hash;
string1		airbags_deploy;
string50	Policy_num,
string8		Policy_Effective_Date,
string8		Policy_Expiration_Date,
string4		Report_Has_Coversheet,
string1		other_vin_indicator;
string7		vehicle_unit_number;
string50	vehicle_incident_city;
string2		vehicle_incident_st;
string100	carrier_name;
string5		client_type_id;
string4		towed;
string80	impact_location;

string1		vehicle_owner_driver_code;
string1		vehicle_driver_action;
string4		vehicle_year;
string100	vehicle_make;
string2		vehicle_type;
string36	vehicle_travel_on;
string1		direction_travel;
string3		est_vehicle_speed;
string2		posted_speed;
string7		est_vehicle_damage;
string1		damage_type;
string25	vehicle_removed_by;
string1		how_removed_code;
	
string15	point_of_impact;
string2		vehicle_movement;
string2		vehicle_function;
string2		vehs_first_defect;
string2		vehs_second_defect;
string2		vehicle_modified;
string2		vehicle_roadway_loc;
string1		hazard_material_transport;
string3		total_occu_vehicle;
string3		total_occu_saf_equip;
string1		moving_violation;
string1		vehicle_insur_code;
string1		vehicle_fault_code;
string2		vehicle_cap_code;
string1		vehicle_fr_code;
string2		vehicle_use;
string1		placarded;
string1		dhsmv_vehicle_ind;

//Vehicle Information	
string42	vehicle_seg;
string1		vehicle_seg_type;
string14	match_code;
string4		model_year;
string3		manufacturer_corporation;
string1		division_code;
string2		vehicle_group_code;
string2		vehicle_subgroup_code;
string2		vehicle_series_code;
string2		body_style_code;
string3		vehicle_abbreviation;
string1		assembly_country;
string1		headquarter_country;
string1		number_of_doors;
string1		seating_capacity;
string2		number_of_cylinders;
string4		engine_size;
string1		fuel_code;
string1		carburetion_type;
string1		number_of_barrels;
string1		price_class_code;
string2		body_size_code;
string1		number_of_wheels_on_road;
string1		number_of_driving_wheels;
string1		drive_type;
string1		steering_type;
string1		gvw_code;
string1		load_capacity_code;
string1		cab_type_code;
string2		bed_length;
string1		rim_size;
string5		manufacture_body_style;
string1		vehicle_type_code;
string3		car_line_code;
string1		car_series_code;
string1		car_body_style_code;
string1		engine_cylinder_code;
string3		truck_make_abbreviation;
string3		truck_body_style_abbreviation;
string3		motorcycle_make_abbreviation;
string3		vina_series;
string3		vina_model;
string5		reference_number;
string3		vina_make;
string2		vina_body_style;
string100	make_description;
string100	model_description;
string20	series_description;
string3		car_series;
string2		car_body_style;
string3		car_cid;
string2		car_cylinders;
string1		car_carburetion;
string1		car_fuel_code;
//Truck
string2		truck_chassis_body_style;
string2		truck_wheels_driving_wheels;
string4		truck_cid;
string2		truck_cylinders;
string1		truck_fuel_code;
string1		truck_manufacturers_gvw_code;
string2		truck_ton_rating_code;
string3		truck_series;
string3		truck_model;

//Motorcycle
string3		motorcycle_model;
string4		motorcycle_engine_displacement;
string2		motorcycle_type_of_bike;
string2		motorcycle_cylinder_coding;

string40	addl_report_number;
string9		agency_ori;
string100	Insurance_Company_Standardized;
string1		is_available_for_public;
string20	report_status;
string4		work_type_id;
string60	orig_fname;
string100	orig_lname;
string60	orig_mname;
string150	orig_full_name;
string12	cru_order_id;
string2		cru_sequence_nbr;
string8		date_vendor_last_reported;
string3		report_type_id;
string70	tif_image_hash;
string11	super_report_id;
string11	report_id;
string100	Vendor_Code;
string20	vendor_report_id := '';
string2		source_id;

//Driver Section
string2		section_nbr;
string25  driver_full_name;
string1   driver_name_suffix;
string150 driver_st_city;
string2   driver_resident_state;
string9   driver_zip;
string8   driver_dob;
string15  driver_dl_nbr;
string2   driver_lic_st;
string1		driver_lic_type;
string1		driver_bac_test_type;
string1		dl_nbr_good_bad;
string1		driver_alco_drug_code;
string1		driver_physical_defects;
string1		driver_residence;
string1		driver_race;
string1		driver_sex;
string1		driver_injury_severity;
string1		first_driver_safety;
string1		second_driver_safety;
string1		driver_eject_code;
string1		recommand_reexam;
string10	driver_phone_nbr;
string1   pop_code;
string1   rural_urban_code;
string2   site_loc;
string2   first_harmful_event;
string2   subs_harmful_event;
string1   on_off_roadway;
string2   light_condition;
string2   weather;
string2   rd_surface_type;
string2   type_shoulder;
string2   rd_surface_condition;
//
string2		first_contrib_cause;
string2		second_contrib_cause;
string2		third_contrib_cause;
string2   first_contrib_envir;
string2   second_contrib_envir;
string2   first_traffic_control;
string2   second_traffic_control;
string2   trafficway_char;
string2   nbr_lanes;
string1   divided_undivided;
string2   rd_sys_id;
string1   invest_agency;
string1   accident_injury_severity;
string1   accident_damage_severity;
string1   accident_insur_code;
string1   accident_fault_code;
string1   alcohol_drug;
string7   total_tar_damage;
string36  total_vehicle_damage;
string7   total_prop_damage_amt;
string5   total_nbr_persons;
string2   total_nbr_drivers;
string3   total_nbr_vehicles;
string3   total_nbr_fatalities;
string2   total_nbr_non_traffic_fatal;
string3   total_nbr_injuries;
string2   total_nbr_pedestrian;
string2   total_nbr_pedalcyclist;

string1   invest_complete;
string1   photos_taken;
string1   first_aid_person_type;
string1   type_driver_accident;
string2   hr_ems_notified;
string2   min_ems_notified;
string2   hr_ems_arrived;
string2   min_ems_arrived;
string1   injured_taken_to_code;
string1   location_type;

//offenses
string8		first_offense_charged;
string2		first_frdl_sys_charge_code;
string1		req_endorsement;

//Passenger
string25  passenger_full_name,
string40  passenger_st_city,
string2   passenger_state,
string9   passenger_zip,
string2		passenger_nbr;
string2		passenger_age;
string1		passenger_location;
string1		passenger_injury_sev;
string1		first_passenger_safe;
string1		second_passenger_safe;
string1		passenger_eject_code;

//
string7   first_citation_nbr;
string2   driver_fr_injury_cap_code;
string1   rec_type_o,
string11  microfilm_nbr;
string4   ft_city_town;
string2   miles_city_town;
string50  city_town_name;
string50  county_name;
string5   at_node_nbr;
string5   from_node_nbr;
string5   next_node_rdwy;
string36  st_road_hhwy_name;
string4   ft_miles_from_intersect;
string1   ft_miles_code2;
string1   intersect_dir_of;
string36  of_intersect_of;
string1   codeable_noncodeable;
string1   type_fr_case;
string2   dot_county;
string15  acc_key_online_update;
string1   form_type;
string8   filler4;
unsigned8 __internal_fpos__;
string50	cust_name;
string10	bug_num;
string8		link_dob;
string9		link_ssn;
string9		link_fein;
string8		link_inc_date;
END;

//Base Layouts
EXPORT Base := RECORD 
FLAccidents_Ecrash.Layout_Basefile; 
BIPV2.IDlayouts.l_xlink_ids;
string2		jurisdiction_state;
string100	jurisdiction;
string50	cust_name;
string10	bug_num;
string8		link_dob;
string9		link_ssn;
string9		link_fein;
string8		link_inc_date;
END;


export Base_FLCrash0 := RECORD
FLAccidents.Layout_FLCrash0;
string2		jurisdiction_state;
string100	jurisdiction;
END;

export Base_FLCrash1 := RECORD
FLAccidents.Layout_FLCrash1;
string2		jurisdiction_state;
string100	jurisdiction;
END;

export Base_FLCrash3v := RECORD
FLAccidents.Layout_FLCrash3v;
string2		jurisdiction_state;
string100	jurisdiction;
END;

export Base_FLCrash8 := RECORD
FLAccidents.Layout_FLCrash8;
string2		jurisdiction_state;
string100	jurisdiction;
END;


export Base_flcrash2v := record
FLAccidents.aid_layouts.flcrash2v;
string2		jurisdiction_state;
string100	jurisdiction;
string50	cust_name;
string10	bug_num;
string8		link_dob;
string9		link_ssn;
string9		link_fein;
string8		link_inc_date;
end;

export Base_flcrash4 := record
FLAccidents.aid_layouts.flcrash4;
string2		jurisdiction_state;
string100	jurisdiction;
string50	cust_name;
string10	bug_num;
string8		link_dob;
string9		link_ssn;
string9		link_fein;
string8		link_inc_date;
end;

export Base_flcrash5 := record
FLAccidents.aid_layouts.flcrash5;
string2		jurisdiction_state;
string100	jurisdiction;
string50	cust_name;
string10	bug_num;
string8		link_dob;
string9		link_ssn;
string9		link_fein;
string8		link_inc_date;
end;

export Base_flcrash6 := record
FLAccidents.aid_layouts.flcrash6;
string2		jurisdiction_state;
string100	jurisdiction;
string50	cust_name;
string10	bug_num;
string8		link_dob;
string9		link_ssn;
end;

export Base_flcrash7 := record
FLAccidents.aid_layouts.flcrash7;
string2		jurisdiction_state;
string100	jurisdiction;
string50	cust_name;
string10	bug_num;
string8		link_dob;
string9		link_ssn;
string9		link_fein;
string8		link_inc_date;
end;

export Base_flcrash9 := record
FLAccidents.aid_layouts.flcrash9;
string2		jurisdiction_state;
string100	jurisdiction;
string50	cust_name;
string10	bug_num;
string8		link_dob;
string9		link_ssn;
string9		link_fein;
string8		link_inc_date;
end;

export Base_flcrashss := record
FLAccidents.aid_layouts.flcrashss;
string2		jurisdiction_state;
string100	jurisdiction;
end;



// Key Layouts
EXPORT key_ecrash0 := RECORD
 string2 	report_code;
 string25 report_category;
 string65 report_code_desc;
 string1  rec_type_o,
 string40 accident_nbr,
 string4  filler1,
 string11 microfilm_nbr,
 string1  st_road_accident,
 string8  accident_date,
 string4  city_nbr,
 string4  ft_city_town,
 string2  miles_city_town,
 string1  direction_city_town,
 string50 city_town_name,
 string50 county_name,
 string5  at_node_nbr,
 string4  ft_miles_node,
 string1  ft_miles_code1,
 string5  from_node_nbr,
 string5  next_node_rdwy,
 string36 st_road_hhwy_name,
 string36 at_intersect_of,
 string4  ft_miles_from_intersect,
 string1  ft_miles_code2,
 string1  intersect_dir_of,
 string36 of_intersect_of,
 string1  codeable_noncodeable,
 string1  type_fr_case,
 string1  action_code,
 string1  filler2,
 string1  dot_type_facility,
 string1  dot_road_type,
 string2  dot_nbr_lanes,
 string2  dot_site_loc,
 string1  dot_district_ind,
 string2  dot_county,
 string3  dot_section_nbr,
 string2  dot_skid_resistance,
 string1  dot_friction_coarse,
 string6  dot_avg_daily_traffic,
 string5  dot_node_nbr,
 string5  dot_distance_node,
 string1  dot_dir_from_node,
 string6  dot_st_road_nbr,
 string5  dot_us_road_nbr,
 string6  dot_milepost,
 string1  dot_hhwy_loc,
 string3  dot_subsection,
 string1  dot_system_type,
 string1  dot_travelway,
 string2  dot_node_type,
 string2  dot_fixture_type,
 string1  dot_side_of_road,
 string1  dot_accident_severity,
 string1  dot_lane_id,
 string98 filler3,
 string1  dhsmv_veh_crash_ind,
 string15 acc_key_online_update,
 string1  form_type,
 string2  update_nbr,
 string1  accident_error,
 string40 orig_accnbr, 
 string8  filler4
end;

 
EXPORT key_ecrash1 :=record
  string2 	report_code;
  string25 	report_category;
  string65	report_code_desc;
	string1   rec_type_1,
	string40  accident_nbr,
	string4   filler1,
	string1   day_week,
	string2   hr_accident,
	string2   min_accident,
	string2   hr_off_notified,
	string2   min_off_notified,
	string2   hr_off_arrived,
	string2   min_off_arrived,
	string4   city_nbr,
	string1   pop_code,
	string1   rural_urban_code,
	string2   site_loc,
	string2   first_harmful_event,
	string2   subs_harmful_event,
	string1   on_off_roadway,
	string2   light_condition,
	string2   weather,
	string2   rd_surface_type,
	string2   type_shoulder,
	string2   rd_surface_condition,
	string2   first_contrib_cause,
	string2   second_contrib_cause,
	string2   first_contrib_envir,
	string2   second_contrib_envir,
	string2   first_traffic_control,
	string2   second_traffic_control,
	string2   trafficway_char,
	string2   nbr_lanes,
	string1   divided_undivided,
	string2   rd_sys_id,
	string1   invest_agency,
	string1   accident_injury_severity,
	string1   accident_damage_severity,
	string1   accident_insur_code,
	string1   accident_fault_code,
	string1   alcohol_drug,
	string7   total_tar_damage,
	string36  total_vehicle_damage,
	string7   total_prop_damage_amt,
	string4   total_nbr_persons,
	string2   total_nbr_drivers,
	string3   total_nbr_vehicles,
	string3   total_nbr_fatalities,
	string2   total_nbr_non_traffic_fatal,
	string3   total_nbr_injuries,
	string2   total_nbr_pedestrian,
	string2   total_nbr_pedalcyclist,
	string15  invest_agy_rpt_nbr,
	string100  invest_name,
	string16  filler2,
	string30  invest_rank,
	string6   invest_id_badge_nbr,
	string30  dept_name,
	string1   invest_maede,
	string1   invest_complete,
	string8   report_date,
	string1   photos_taken,
	string1   photos_taken_whom,
	string30  first_aid_name,
	string16  filler3,
	string1   first_aid_person_type,
	string41  injured_taken_to,
	string25  injured_taken_by,
	string1   type_driver_accident,
	string2   hr_ems_notified,
	string2   min_ems_notified,
	string2   hr_ems_arrived,
	string2   min_ems_arrived,
	string1   injured_taken_to_code,
	string1   location_type,
	string20  first_aid_person_type_desc,     // string1 first_aid_person_type
  string40  accident_fault_code_desc,       // string1 accident_fault_code
  string40  alcohol_drug_desc,              // string1 alcohol_drug
  string100 accident_damage_severity_desc,  // string1 accident_damage_severity
	string100 invest_agency_desc,           	// string1 invest_agency,
  string110 first_harmful_event_desc,       // string2 first_harmful_event
  string40  light_condition_desc,           // string2 light_condition
  string40  weather_desc,               		// string2 weather
  string40  rd_surface_type_desc,        		// string2 rd_surface_type, 
  string10  type_shoulder_desc,          		// string2 type_shoulder, 
  string40  rd_surface_condition_desc,  		// string2 rd_surface_condition, 
  string50  first_contrib_cause_desc,   		// string2 first_contrib_cause, 
  string50  second_contrib_cause_desc,  		// string2 second_contrib_cause, 
  string40  first_contrib_envir_desc,   		// string2 first_contrib_envir, 
  string40  second_contrib_envir_desc,  		// string2 second_contrib_envir, 
  string30  first_traffic_control_desc,			// string2 first_traffic_control, 
  string30  second_traffic_control_desc,		// string2 second_traffic_control 
	string9   day_week_desc;
  string30  location_type_desc;
	string40  orig_accnbr; 
	string64  filler4,
  end;
	
	
EXPORT key_ecrashv2 := record
  string2 	report_code;
  string25 	report_category;
  string65 	report_code_desc;
	string25 	vehicle_incident_city;
	string2 	vehicle_incident_st;
	string40 	carrier_name;
	string5		client_type_id;
  string12 	did,
	unsigned1 did_score,
	string12 	b_did, 
  unsigned1 b_did_score,
	string1   rec_type_2,
	string40  accident_nbr,
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
	string150 vehicle_owner_st_city,
	string18  filler3,
	string2   vehicle_owner_st,
	string9   vehicle_owner_zip,
	string1   vehicle_owner_forge_asterisk,
	string15  vehicle_owner_dl_nbr,
	string8   vehicle_owner_dob,
	string1   vehicle_owner_sex,
	string1   vehicle_owner_race,
	string15  point_of_impact,
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
	string40  orig_accnbr,
	string15  direction_travel_desc,
	string25  vehicle_type_desc,
	string30  point_of_impact_desc, 
	string30  vehicle_use_desc,
  end;

EXPORT key_ecrash3v := record
  string2 	report_code;
  string25 	report_category;
  string65 	report_code_desc;
  string1    rec_type_3,
	string40   accident_nbr,
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
	string4    model_year,
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
	string2    number_of_cylinders,
	string4    engine_size,
	string1    fuel_code,
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
	string3    vina_series,
	string3    vina_model,
	string5    reference_number,
	string3    vina_make,
	string2    vina_body_style,
	string20   make_description,
	string20   model_description,
	string20   series_description,
	string2    blank3,
	string3    car_series,
	string2    car_body_style,
	string3    car_cid,
	string2    car_cylinders,
	string1    car_carburetion,
	string1    car_fuel_code,
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
	string40   orig_accnbr; 
  end;

EXPORT key_ecrash4 := record
  string2 	report_code;
  string25 	report_category;
  string65 	report_code_desc;
	string22  vehicle_id_nbr,
	string4   vehicle_year,
	string4   vehicle_make,
	string20  make_description,
	string20  model_description,
	string25 	vehicle_incident_city;
	string2 	vehicle_incident_st;
	string15  point_of_impact,
	string40 	carrier_name;
	string5		client_type_id;
 	string12 	did,
	unsigned1 did_score,
	string1   rec_type_4,
	string40  accident_nbr,
	string2   section_nbr,
	string2   filler1,
	string25  driver_full_name,
	string16  filler2, 
	string1   driver_name_suffix,
	string150  driver_st_city,
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
	string51  filler5,//claim_nbr
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
	string40  orig_accnbr, 
	string25 	driver_race_desc,
  string8 	driver_sex_desc,
  string40 	driver_residence_desc ,
	string41  ins_company_name:= '';	
	string25  ins_policy_nbr:='';	
end;
 
//Key_ECrash5 
EXPORT key_ecrash5 := record
  string2 report_code;
  string25 report_category;
  string65 report_code_desc;
 	string12 did,
	unsigned1 did_score,
	string1   rec_type_5,
	string40  accident_nbr,
	string2   section_nbr,
	string2   passenger_nbr,
	string25  passenger_full_name,
	string16  filler1,
	string1   passenger_name_suffix,
	string150  passenger_st_city,
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
	string40 orig_accnbr, 
  end;


EXPORT key_ecrash6 := record
 string2 		report_code;
 string25 	report_category;
 string65 	report_code_desc;
	string12 	did,
	unsigned1 did_score,
	string1   rec_type_6,
	string40  accident_nbr,
	string2   section_nbr,
	string2   filler1,
	string25  pedest_full_name,
	string16  filler2,
	string1   ped_name_suffix,
	string150 ped_st_city,
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
	string40 orig_accnbr,
	string25 ped_race_desc,
  string8 ped_sex_desc,
end;

EXPORT key_ecrash7 := record
  string2 	report_code;
  string25 	report_category;
  string65 	report_code_desc;
	string12  did,
	unsigned1 did_score,
	string12  b_did, 
  unsigned1 b_did_score,
	string1   rec_type_7,
	string40  accident_nbr,
	string2   prop_damage_code,
	string2   prop_damage_nbr,
	string25  prop_damaged,
	string7   prop_damage_amount,
	string25  prop_owner_name,
	string16  filler1,
	string1   prop_owner_suffix,
	string150 prop_owner_st_city,
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
	string40 orig_accnbr, 
  end;

EXPORT key_ecrash8	:= RECORD
  string2 	report_code;
  string25 	report_category;
  string65 	report_code_desc;
	string1 	rec_type_8;
	string40 	accident_nbr;
	string2 	section_no;
	string2 	filler;
	string40 	carrier_name;
	string40 	carrier_address;
	string20 	carrier_city;
	string2 	carrier_state;
	string9 	carrier_zip;
	string8 	us_dot_or_icc_id_nums;
	string1 	source_or_carrier_info;
	string40 	orig_accnbr, 
	string266 filler3;
  end;
	
//Analytic Keys	
EXPORT ecrashv2analytics_byagencyid := RECORD
  string11 agencyid;
  string10 accident_date;
  string30 precinct;
  string20 beat;
  integer8 accidentcnt;
  integer8 injurycnt;
  integer8 fatalcnt;
  integer8 unknowncnt;
 END;
 
EXPORT ecrashv2analytics_bycollisiontype := RECORD
  string11 agencyid;
  string8 accident_date;
  integer8 accidentcnt;
  integer8 ctfrontrear;
  integer8 ctfrontfront;
  integer8 ctangle;
  integer8 ctsideswipesame;
  integer8 ctsideswipeopposite;
  integer8 ctrearside;
  integer8 ctrearrear;
  integer8 ctother;
  integer8 ctunknown;
 END;

EXPORT ecrashv2analytics_bydow := RECORD
  string11 agencyid;
  string8 accident_date;
  integer8 dayofweek;
  integer8 accidentcnt;
  integer8 injurycnt;
  integer8 fatalcnt;
  integer8 unknowncnt;
 END;

EXPORT ecrashv2analytics_byhod := RECORD
  string11 agencyid;
  string8 accident_date;
  integer8 hourofday;
  integer8 accidentcnt;
  integer8 injurycnt;
  integer8 fatalcnt;
  integer8 unknowncnt;
 END;

EXPORT ecrashv2analytics_byinter := RECORD
  string11 agencyid;
  string8 accident_date;
  integer8 dayofweek;
  integer8 tour;
  string intersection;
  integer8 accidentcnt;
  integer8 atvehicle;
  integer8 atpedestrian;
  integer8 atbicycle;
  integer8 atmotorcycle;
  integer8 atanimal;
  integer8 attrain;
  integer8 atunknown;
  integer8 ctfrontrear;
  integer8 ctfrontfront;
  integer8 ctangle;
  integer8 ctsideswipesame;
  integer8 ctsideswipeopposite;
  integer8 ctrearside;
  integer8 ctrearrear;
  integer8 ctother;
  integer8 ctunknown;
  integer8 injurycnt;
  integer8 fatalcnt;
  integer8 propdmgcnt;
 END;

EXPORT ecrashv2analytics_bymoy := RECORD
  string11 agencyid;
  string8 accident_date;
  string2 monthofyear;
  integer8 accidentcnt;
  integer8 injurycnt;
  integer8 fatalcnt;
  integer8 unknowncnt;
 END;

 
EXPORT ecrashv2_accnbrv1 := RECORD
	string40 l_accnbr;
  string2 report_code;
  string2 jurisdiction_state;
  string100 jurisdiction;
  string40 orig_accnbr;
  string11 vehicle_incident_id;
  string1 vehicle_status;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string8 accident_date;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string8 dob;
  string12 b_did;
  string25 cname;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string100 record_type;
  string65 	report_code_desc;
  string25 	report_category;
  string30 	vin;
  string25 	driver_license_nbr;
  string2 	dlnbr_st;
  string10 	tag_nbr;
  string2 	tagnbr_st;
  string100 accident_location;
  string100 accident_street;
  string100 accident_cross_street;
  string60 	next_street;
  string11 	jurisdiction_nbr;
  string64 	image_hash;
  string1 	airbags_deploy;
  string50 	policy_num;
  string8 	policy_effective_date;
  string8 	policy_expiration_date;
  string4 	report_has_coversheet;
  string1 	other_vin_indicator;
  string7 	vehicle_unit_number;
  string50 	vehicle_incident_city;
  string2 	vehicle_incident_st;
  string100 carrier_name;
  string5 	client_type_id;
  string4 	towed;
  string80 	impact_location;
  string1 	vehicle_owner_driver_code;
  string1 	vehicle_driver_action;
  string4 	vehicle_year;
  string100 vehicle_make;
  string2 	vehicle_type;
  string36 	vehicle_travel_on;
  string1 	direction_travel;
  string3 	est_vehicle_speed;
  string2 	posted_speed;
  string7 	est_vehicle_damage;
  string1 	damage_type;
  string25 	vehicle_removed_by;
  string1 	how_removed_code;
  string15 	point_of_impact;
  string2 	vehicle_movement;
  string2 	vehicle_function;
  string2 	vehs_first_defect;
  string2 	vehs_second_defect;
  string2 	vehicle_modified;
  string2 	vehicle_roadway_loc;
  string1 	hazard_material_transport;
  string3 	total_occu_vehicle;
  string3 	total_occu_saf_equip;
  string1 	moving_violation;
  string1 	vehicle_insur_code;
  string1 	vehicle_fault_code;
  string2 	vehicle_cap_code;
  string1 	vehicle_fr_code;
  string2 	vehicle_use;
  string1 	placarded;
  string1 	dhsmv_vehicle_ind;
  string42 	vehicle_seg;
  string1 	vehicle_seg_type;
  string14 	match_code;
  string4 	model_year;
  string3 	manufacturer_corporation;
  string1 	division_code;
  string2 	vehicle_group_code;
  string2 	vehicle_subgroup_code;
  string2 	vehicle_series_code;
  string2 	body_style_code;
  string3 	vehicle_abbreviation;
  string1 	assembly_country;
  string1 	headquarter_country;
  string1 	number_of_doors;
  string1 	seating_capacity;
  string2 	number_of_cylinders;
  string4 	engine_size;
  string1 	fuel_code;
  string1 	carburetion_type;
  string1 	number_of_barrels;
  string1 	price_class_code;
  string2 	body_size_code;
  string1 	number_of_wheels_on_road;
  string1 	number_of_driving_wheels;
  string1 	drive_type;
  string1 	steering_type;
  string1 	gvw_code;
  string1 	load_capacity_code;
  string1 	cab_type_code;
  string2 	bed_length;
  string1 	rim_size;
  string5	 	manufacture_body_style;
  string1 	vehicle_type_code;
  string3		car_line_code;
  string1 	car_series_code;
  string1	 	car_body_style_code;
  string1 	engine_cylinder_code;
  string3 	truck_make_abbreviation;
  string3 	truck_body_style_abbreviation;
  string3 	motorcycle_make_abbreviation;
  string3 	vina_series;
  string3 	vina_model;
  string5 	reference_number;
  string3 	vina_make;
  string2 	vina_body_style;
  string100 make_description;
  string100 model_description;
  string20 	series_description;
  string3 	car_series;
  string2 	car_body_style;
  string3 	car_cid;
  string2 	car_cylinders;
  string1 	car_carburetion;
  string1 	car_fuel_code;
  string2 	truck_chassis_body_style;
  string2 	truck_wheels_driving_wheels;
  string4 	truck_cid;
  string2 	truck_cylinders;
  string1 	truck_fuel_code;
  string1 	truck_manufacturers_gvw_code;
  string2 	truck_ton_rating_code;
  string3 	truck_series;
  string3 	truck_model;
  string3 	motorcycle_model;
  string4 	motorcycle_engine_displacement;
  string2 	motorcycle_type_of_bike;
  string2 	motorcycle_cylinder_coding;
  string40 	addl_report_number;
  string9 	agency_ori;
  string100 insurance_company_standardized;
  string1 	is_available_for_public;
  string20 	report_status;
  string4 	work_type_id;
  string60 	orig_fname;
  string100 orig_lname;
  string60 	orig_mname;
  string150 orig_full_name;
  string11 	ssn;
  string12 	cru_order_id;
  string2 	cru_sequence_nbr;
  string8 	date_vendor_last_reported;
  string3 	report_type_id;
  string70 	tif_image_hash;
  string11 	super_report_id;
  string11 	report_id;
  string100 vendor_code;
  string20 	vendor_report_id;
  unsigned6 idfield;
  string20 	reportlinkid;
  string3 	page_count;
	//Buycrash project KY integration		
	string3		contrib_source;
	string8 	creation_date;
	
	//Buycrash Release 4		
	string12 	officer_id;
	
	//Appriss Integration
	STRING1 Releasable;
	
	//Added 7/12/18 Jira DF-22370
	STRING10 date_report_submitted;
 
  unsigned8 __internal_fpos__;
 END;
 
EXPORT ecrashv2_accnbr := RECORD
  string40 l_accnbr;
  string2 report_code;
  string2 jurisdiction_state;
  string100 jurisdiction;
  string40 orig_accnbr;
  string11 vehicle_incident_id;
  string1 vehicle_status;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string8 accident_date;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string8 dob;
  string12 b_did;
  string25 cname;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string100 record_type;
  string65 report_code_desc;
  string25 report_category;
  string30 vin;
  string25 driver_license_nbr;
  string2 dlnbr_st;
  string10 tag_nbr;
  string2 tagnbr_st;
  string100 accident_location;
  string100 accident_street;
  string100 accident_cross_street;
  string60 next_street;
  string11 jurisdiction_nbr;
  string64 image_hash;
  string1 airbags_deploy;
  string50 policy_num;
  string8 policy_effective_date;
  string8 policy_expiration_date;
  string4 report_has_coversheet;
  string1 other_vin_indicator;
  string7 vehicle_unit_number;
  string50 vehicle_incident_city;
  string2 vehicle_incident_st;
  string100 carrier_name;
  string5 client_type_id;
  string4 towed;
  string80 impact_location;
  string1 vehicle_owner_driver_code;
  string1 vehicle_driver_action;
  string4 vehicle_year;
  string100 vehicle_make;
  string2 vehicle_type;
  string36 vehicle_travel_on;
  string1 direction_travel;
  string3 est_vehicle_speed;
  string2 posted_speed;
  string7 est_vehicle_damage;
  string1 damage_type;
  string25 vehicle_removed_by;
  string1 how_removed_code;
  string15 point_of_impact;
  string2 vehicle_movement;
  string2 vehicle_function;
  string2 vehs_first_defect;
  string2 vehs_second_defect;
  string2 vehicle_modified;
  string2 vehicle_roadway_loc;
  string1 hazard_material_transport;
  string3 total_occu_vehicle;
  string3 total_occu_saf_equip;
  string1 moving_violation;
  string1 vehicle_insur_code;
  string1 vehicle_fault_code;
  string2 vehicle_cap_code;
  string1 vehicle_fr_code;
  string2 vehicle_use;
  string1 placarded;
  string1 dhsmv_vehicle_ind;
  string42 vehicle_seg;
  string1 vehicle_seg_type;
  string14 match_code;
  string4 model_year;
  string3 manufacturer_corporation;
  string1 division_code;
  string2 vehicle_group_code;
  string2 vehicle_subgroup_code;
  string2 vehicle_series_code;
  string2 body_style_code;
  string3 vehicle_abbreviation;
  string1 assembly_country;
  string1 headquarter_country;
  string1 number_of_doors;
  string1 seating_capacity;
  string2 number_of_cylinders;
  string4 engine_size;
  string1 fuel_code;
  string1 carburetion_type;
  string1 number_of_barrels;
  string1 price_class_code;
  string2 body_size_code;
  string1 number_of_wheels_on_road;
  string1 number_of_driving_wheels;
  string1 drive_type;
  string1 steering_type;
  string1 gvw_code;
  string1 load_capacity_code;
  string1 cab_type_code;
  string2 bed_length;
  string1 rim_size;
  string5 manufacture_body_style;
  string1 vehicle_type_code;
  string3 car_line_code;
  string1 car_series_code;
  string1 car_body_style_code;
  string1 engine_cylinder_code;
  string3 truck_make_abbreviation;
  string3 truck_body_style_abbreviation;
  string3 motorcycle_make_abbreviation;
  string3 vina_series;
  string3 vina_model;
  string5 reference_number;
  string3 vina_make;
  string2 vina_body_style;
  string100 make_description;
  string100 model_description;
  string20 series_description;
  string3 car_series;
  string2 car_body_style;
  string3 car_cid;
  string2 car_cylinders;
  string1 car_carburetion;
  string1 car_fuel_code;
  string2 truck_chassis_body_style;
  string2 truck_wheels_driving_wheels;
  string4 truck_cid;
  string2 truck_cylinders;
  string1 truck_fuel_code;
  string1 truck_manufacturers_gvw_code;
  string2 truck_ton_rating_code;
  string3 truck_series;
  string3 truck_model;
  string3 motorcycle_model;
  string4 motorcycle_engine_displacement;
  string2 motorcycle_type_of_bike;
  string2 motorcycle_cylinder_coding;
  string40 addl_report_number;
  string9 agency_ori;
  string100 insurance_company_standardized;
  string1 is_available_for_public;
  string20 report_status;
  string4 work_type_id;
  string60 orig_fname;
  string100 orig_lname;
  string60 orig_mname;
  string150 orig_full_name;
  string11 ssn;
  string12 cru_order_id;
  string2 cru_sequence_nbr;
  string8 date_vendor_last_reported;
  string3 report_type_id;
  unsigned8 __internal_fpos__;
 END;

 
EXPORT ecrashv2_dol := RECORD
  string8 accident_date;
  string2 report_code;
  string2 jurisdiction_state;
  string100 jurisdiction;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string25 report_category;
  string65 report_code_desc;
  string11 vehicle_incident_id;
  string1 vehicle_status;
  string100 accident_location;
  string100 accident_street;
  string100 accident_cross_street;
  string11 jurisdiction_nbr;
  string64 image_hash;
  string1 airbags_deploy;
  string12 did;
  string40 accident_nbr;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string12 b_did;
  string25 cname;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string100 record_type;
  string25 driver_license_nbr;
  string2 dlnbr_st;
  string30 vin;
  string10 tag_nbr;
  string2 tagnbr_st;
  string8 dob;
  string50 vehicle_incident_city;
  string2 vehicle_incident_st;
  string100 carrier_name;
  string5 client_type_id;
  string50 policy_num;
  string8 policy_effective_date;
  string8 policy_expiration_date;
  string4 report_has_coversheet;
  string1 other_vin_indicator;
  string7 vehicle_unit_number;
  string4 towed;
  string80 impact_location;
  string1 vehicle_owner_driver_code;
  string1 vehicle_driver_action;
  string4 vehicle_year;
  string100 vehicle_make;
  string2 vehicle_type;
  string36 vehicle_travel_on;
  string1 direction_travel;
  string3 est_vehicle_speed;
  string2 posted_speed;
  string7 est_vehicle_damage;
  string1 damage_type;
  string25 vehicle_removed_by;
  string1 how_removed_code;
  string15 point_of_impact;
  string2 vehicle_movement;
  string2 vehicle_function;
  string2 vehs_first_defect;
  string2 vehs_second_defect;
  string2 vehicle_modified;
  string2 vehicle_roadway_loc;
  string1 hazard_material_transport;
  string3 total_occu_vehicle;
  string3 total_occu_saf_equip;
  string1 moving_violation;
  string1 vehicle_insur_code;
  string1 vehicle_fault_code;
  string2 vehicle_cap_code;
  string1 vehicle_fr_code;
  string2 vehicle_use;
  string1 placarded;
  string1 dhsmv_vehicle_ind;
  string42 vehicle_seg;
  string1 vehicle_seg_type;
  string14 match_code;
  string4 model_year;
  string3 manufacturer_corporation;
  string1 division_code;
  string2 vehicle_group_code;
  string2 vehicle_subgroup_code;
  string2 vehicle_series_code;
  string2 body_style_code;
  string3 vehicle_abbreviation;
  string1 assembly_country;
  string1 headquarter_country;
  string1 number_of_doors;
  string1 seating_capacity;
  string2 number_of_cylinders;
  string4 engine_size;
  string1 fuel_code;
  string1 carburetion_type;
  string1 number_of_barrels;
  string1 price_class_code;
  string2 body_size_code;
  string1 number_of_wheels_on_road;
  string1 number_of_driving_wheels;
  string1 drive_type;
  string1 steering_type;
  string1 gvw_code;
  string1 load_capacity_code;
  string1 cab_type_code;
  string2 bed_length;
  string1 rim_size;
  string5 manufacture_body_style;
  string1 vehicle_type_code;
  string3 car_line_code;
  string1 car_series_code;
  string1 car_body_style_code;
  string1 engine_cylinder_code;
  string3 truck_make_abbreviation;
  string3 truck_body_style_abbreviation;
  string3 motorcycle_make_abbreviation;
  string3 vina_series;
  string3 vina_model;
  string5 reference_number;
  string3 vina_make;
  string2 vina_body_style;
  string100 make_description;
  string100 model_description;
  string20 series_description;
  string3 car_series;
  string2 car_body_style;
  string3 car_cid;
  string2 car_cylinders;
  string1 car_carburetion;
  string1 car_fuel_code;
  string2 truck_chassis_body_style;
  string2 truck_wheels_driving_wheels;
  string4 truck_cid;
  string2 truck_cylinders;
  string1 truck_fuel_code;
  string1 truck_manufacturers_gvw_code;
  string2 truck_ton_rating_code;
  string3 truck_series;
  string3 truck_model;
  string3 motorcycle_model;
  string4 motorcycle_engine_displacement;
  string2 motorcycle_type_of_bike;
  string2 motorcycle_cylinder_coding;
  string60 next_street;
  string40 orig_accnbr;
  string40 addl_report_number;
  string9 agency_ori;
  string100 insurance_company_standardized;
  string1 is_available_for_public;
  string20 report_status;
  string4 work_type_id;
  string150 orig_full_name;
  string60 orig_fname;
  string100 orig_lname;
  string60 orig_mname;
  string11 ssn;
  string12 cru_order_id;
  string2 cru_sequence_nbr;
  string8 date_vendor_last_reported;
  string3 report_type_id;
  string11 report_id;
  string11 super_report_id;
  string100 vendor_code;
  string20 vendor_report_id;
  unsigned8 idfield;
  string20 reportlinkid;
  unsigned8 __internal_fpos__;
 END;
 
 
EXPORT ecrashv2_lastname_state := RECORD
  string20 lname;
  string2 jurisdiction_state;
  string100 jurisdiction;
  string40 accident_nbr;
  string40 orig_accnbr;
  string40 addl_report_number;
  string8 accident_date;
  string2 report_code;
  string11 jurisdiction_nbr;
  string4 work_type_id;
  string3 report_type_id;
  string11 report_id;
  string9 agency_ori;
  string100 vendor_code;
  string20 vendor_report_id;
  string20 reportlinkid;
  string8 date_vendor_last_reported;
  string100 accident_location;
  unsigned6 idfield;
 END;
 
EXPORT ecrashv2_partialaccnbr := RECORD
  string4 partial_report_nbr;
  string2 report_code;
  string2 jurisdiction_state;
  string100 jurisdiction;
  string8 accident_date;
  string40 l_accnbr;
  string40 orig_accnbr;
  string40 addl_report_number;
  string3 report_type_id;
  string4 work_type_id;
  string100 vendor_code;
  string20 vendor_report_id;
  unsigned8 idfield;
  string20 reportlinkid;
  unsigned8 __internal_fpos__;
 END;
 
EXPORT ecrashv2_photoid := RECORD
  string11 super_report_id;
	FLAccidents_Ecrash.Layouts.PhotoLayout;
 END;
 
EXPORT ecrashv2_prefname_state := RECORD
  string20 fname;
  string2 jurisdiction_state;
  string100 jurisdiction;
  string40 accident_nbr;
  string40 orig_accnbr;
  string40 addl_report_number;
  string8 accident_date;
  string2 report_code;
  string11 jurisdiction_nbr;
  string4 work_type_id;
  string3 report_type_id;
  string11 report_id;
  string9 agency_ori;
  string100 vendor_code;
  string20 vendor_report_id;
  string20 reportlinkid;
  string8 date_vendor_last_reported;
  string100 accident_location;
  unsigned6 idfield;
 END;

EXPORT ecrashv2_standlocation := RECORD
  string100 partial_accident_location;
  string2 jurisdiction_state;
  string100 jurisdiction;
  string40 accident_nbr;
  string40 orig_accnbr;
  string40 addl_report_number;
  string8 accident_date;
  string2 report_code;
  string11 jurisdiction_nbr;
  string4 work_type_id;
  string3 report_type_id;
  string11 report_id;
  string9 agency_ori;
  string100 vendor_code;
  string20 vendor_report_id;
  string20 reportlinkid;
  string8 date_vendor_last_reported;
  string100 accident_location;
  unsigned6 idfield;
 END;
 
EXPORT ecrashv2_supplemental := RECORD
  string11 super_report_id;
  string11 report_id;
  string64 hash_key;
  string40 accident_nbr;
  string2 report_code;
  string100 jurisdiction;
  string2 jurisdiction_state;
  string8 accident_date;
  string40 orig_accnbr;
  string4 work_type_id;
  string3 report_type_id;
  string9 agency_ori;
  string40 addl_report_number;
  string100 vendor_code;
  string20 vendor_report_id;
  string3 page_count;
  unsigned8 __internal_fpos__;
 END;
 
 
EXPORT ecrashv2_vin7 := RECORD
  string7 l_vin7;
  string30 l_vin;
  string40 accident_nbr;
  string40 orig_accnbr;
  unsigned8 __internal_fpos__;
 END;

 
EXPORT keybuild_SSv2 := FLAccidents_Ecrash.Layout_keybuild_SSv2;


EXPORT keybuild_SSv3 := RECORD
	FLAccidents_Ecrash.Layout_keybuild_SSv2; 
	string orig_case_identifier; 
	string orig_state_report_number; 
end; 

EXPORT slim_layout := RECORD
  string8 	accident_date;
  string2 	report_code;
  string2 	jurisdiction_state;
  string100 jurisdiction;
  string8 	dt_first_seen;
  string8 	dt_last_seen;
  string25 	report_category;
  string65 	report_code_desc;
  string11 	vehicle_incident_id;
  string1 	vehicle_status;
  string100 accident_location;
  string100 accident_street;
  string100 accident_cross_street;
  string11 	jurisdiction_nbr;
  string64 	image_hash;
  string1 	airbags_deploy;
  string12 	did;
  string40 	accident_nbr;
  string5 	title;
  string20 	fname;
  string20 	mname;
  string20 	lname;
  string5 	name_suffix;
  string12 	b_did;
  string25 	cname;
  string10 	prim_range;
  string2 	predir;
  string28 	prim_name;
  string4 	addr_suffix;
  string2 	postdir;
  string10 	unit_desig;
  string8 	sec_range;
  string25 	v_city_name;
  string2 	st;
  string5 	zip;
  string4 	zip4;
  string100 record_type;
  string25 	driver_license_nbr;
  string2 	dlnbr_st;
  string30 	vin;
  string10 	tag_nbr;
  string2 	tagnbr_st;
  string8 	dob;
  string50 	vehicle_incident_city;
  string2 	vehicle_incident_st;
  string100 carrier_name;
  string5 	client_type_id;
  string50 	policy_num;
  string8 	policy_effective_date;
  string8 	policy_expiration_date;
  string4 	report_has_coversheet;
  string1 	other_vin_indicator;
  string7 	vehicle_unit_number;
  string4 	towed;
  string80 	impact_location;
  string1 	vehicle_owner_driver_code;
  string1 	vehicle_driver_action;
  string4 	vehicle_year;
  string100 vehicle_make;
  string2 	vehicle_type;
  string36 	vehicle_travel_on;
  string1 	direction_travel;
  string3 	est_vehicle_speed;
  string2 	posted_speed;
  string7 	est_vehicle_damage;
  string1 	damage_type;
  string25 	vehicle_removed_by;
  string1 	how_removed_code;
  string15 	point_of_impact;
  string2 	vehicle_movement;
  string2 	vehicle_function;
  string2 	vehs_first_defect;
  string2 	vehs_second_defect;
  string2 	vehicle_modified;
  string2 	vehicle_roadway_loc;
  string1 	hazard_material_transport;
  string3 	total_occu_vehicle;
  string3 	total_occu_saf_equip;
  string1 	moving_violation;
  string1 	vehicle_insur_code;
  string1 	vehicle_fault_code;
  string2 	vehicle_cap_code;
  string1 	vehicle_fr_code;
  string2 	vehicle_use;
  string1 	placarded;
  string1 	dhsmv_vehicle_ind;
  string42 	vehicle_seg;
  string1 	vehicle_seg_type;
  string14 	match_code;
  string4 	model_year;
  string3 	manufacturer_corporation;
  string1 	division_code;
  string2 	vehicle_group_code;
  string2 	vehicle_subgroup_code;
  string2 	vehicle_series_code;
  string2 	body_style_code;
  string3 	vehicle_abbreviation;
  string1 	assembly_country;
  string1 	headquarter_country;
  string1 	number_of_doors;
  string1 	seating_capacity;
  string2 	number_of_cylinders;
  string4 	engine_size;
  string1 	fuel_code;
  string1 	carburetion_type;
  string1 	number_of_barrels;
  string1 	price_class_code;
  string2 	body_size_code;
  string1 	number_of_wheels_on_road;
  string1 	number_of_driving_wheels;
  string1 	drive_type;
  string1 	steering_type;
  string1 	gvw_code;
  string1 	load_capacity_code;
  string1 	cab_type_code;
  string2 	bed_length;
  string1 	rim_size;
  string5 	manufacture_body_style;
  string1 	vehicle_type_code;
  string3 	car_line_code;
  string1 	car_series_code;
  string1 	car_body_style_code;
  string1 	engine_cylinder_code;
  string3 	truck_make_abbreviation;
  string3 	truck_body_style_abbreviation;
  string3 	motorcycle_make_abbreviation;
  string3 	vina_series;
  string3 	vina_model;
  string5 	reference_number;
  string3 	vina_make;
  string2 	vina_body_style;
  string100 make_description;
  string100 model_description;
  string20 	series_description;
  string3 	car_series;
  string2 	car_body_style;
  string3 	car_cid;
  string2 	car_cylinders;
  string1 	car_carburetion;
  string1 	car_fuel_code;
  string2 	truck_chassis_body_style;
  string2 	truck_wheels_driving_wheels;
  string4 	truck_cid;
  string2 	truck_cylinders;
  string1 	truck_fuel_code;
  string1 	truck_manufacturers_gvw_code;
  string2 	truck_ton_rating_code;
  string3 	truck_series;
  string3 	truck_model;
  string3 	motorcycle_model;
  string4 	motorcycle_engine_displacement;
  string2 	motorcycle_type_of_bike;
  string2 	motorcycle_cylinder_coding;
  string60 	next_street;
  string40 	orig_accnbr;
  string40 	addl_report_number;
  string9 	agency_ori;
  string100 insurance_company_standardized;
  string1 	is_available_for_public;
  string20 	report_status;
  string4 	work_type_id;
  string150 orig_full_name;
  string60 	orig_fname;
  string100 orig_lname;
  string60 	orig_mname;
  string11 	ssn;
  string12 	cru_order_id;
  string2 	cru_sequence_nbr;
  string8 	date_vendor_last_reported;
  string3 	report_type_id;
	string11 	report_id; 
	string11 	super_report_id;
	string100 Vendor_Code,
  string20  vendor_report_id,	
	unsigned8 Idfield,
  string20  ReportLinkID,	
 END;


EXPORT slim_rec := record 
string4   partial_report_nbr; 
string2   report_code;
string2   jurisdiction_state;
string100 jurisdiction;
string8   accident_date;
string40  l_accnbr; 
string40  orig_Accnbr; 
string40  addl_report_number; 
string3   report_type_id;
string4   work_type_id;
string100 Vendor_Code,
string20  vendor_report_id,	
unsigned8 Idfield,
string20  ReportLinkID,
unsigned8 __internal_fpos__;	
end;


EXPORT slim_partial_report_nbr := record 
	string40  l_accnbr; 
	string2   report_code;
	string2   jurisdiction_state;
	string100 jurisdiction;
	string8   accident_date;
	string40  orig_Accnbr; 
	string40  addl_report_number; 
	string4   work_type_id;
	string3   report_type_id;
	unsigned8 Idfield,
	string20  ReportLinkID,	
	string100 Vendor_Code,
  string20  vendor_report_id,	
	string4 f1; 
	string4 f2; 
	string4 f3; 
	string4 f4; 
	string4 f5; 
	string4 f6; 
	string4 f7; 
	string4 f8; 
	string4 f9; 
	string4 f10; 
	string4 f11; 
	string4 f12; 
	string4 f13; 
	string4 f14;
	string4 f15;
	string4 f16;
	string4 f17;
	string4 f18;
	string4 f19;
	string4 f20; 
	string4 f21;
	string4 f22;
	string4 f23;
	string4 f24;
	string4 f25;
	string4 f26;
	string4 f27;
	string4 f28;
	string4 f29;
	string4 f30;
	string4 f31;
	string4 f32;
	string4 f33;
	string4 f34;
	string4 f35;
	string4 f36;
	string4 f37;
END; 

	EXPORT search := RECORD
	flaccidents.layout_flcrash_search;
	string2		jurisdiction_state;
	string100	jurisdiction;
	end;


	EXPORT SrchServ	:= record
	flaccidents.Layout_FLCrash_SrchServ;
	string2		jurisdiction_state;
	string100	jurisdiction;
	end;


	EXPORT slim_rec_reportlinkid := FLAccidents_Ecrash.Layouts.key_slim_layout;
		
	EXPORT linkids := FLAccidents_Ecrash.Layout_Keybuild_Linkids;
	
	EXPORT key_search_rec := FLAccidents_Ecrash.Layouts.key_search_layout;
	
	EXPORT key_slim_rec := FLAccidents_Ecrash.Layouts.key_slim_layout;
	
END;