/*2015-11-16T20:52:51Z (Srilatha Katukuri)
#193680 - CR 323
*/
/*2015-08-07T18:13:16Z (Srilatha Katukuri)
#186387  - Dedup field changes
*/
/*2015-07-24T21:33:22Z (Srilatha Katukuri)
#173256 Rolled back dedup fields
*/
/*2015-04-15T19:12:04Z (Srilatha Katukuri)
# 173256- Check in
*/
/*2015-02-11T00:43:45Z (Ayeesha Kayttala)
bug# 173256 - code review 
*/
Import Data_Services, doxie,FLAccidents, STD;

allrecs := FLAccidents_Ecrash.File_KeybuildV2.out(vin+driver_license_nbr+tag_nbr+lname <>'' and 
																									(trim(report_type_id,all) in ['A','DE'] or STD.str.ToUpperCase(trim(vendor_code,left,right)) = 'CMPD'));

slim_layout := RECORD
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
	string100 Vendor_Code,
  string20  vendor_report_id,	
	unsigned8 Idfield,
  string20  ReportLinkID,	
 END;


crash_base := project(allrecs
						((accident_date<>'' and (unsigned) accident_date<>0) ), slim_layout);
											 
dst_base := distribute(crash_base, hash(accident_date));
srt_base := sort(dst_base, except did, except b_did, local);
//dep_base := dedup(srt_base, except did, except b_did, local);
dep_base := dedup(srt_base, accident_nbr, accident_date, report_code, jurisdiction, jurisdiction_state, report_type_id, local);

export key_ecrashV2_dol := index(dep_base
                                  ,{accident_date,report_code,jurisdiction_state, jurisdiction}

								   ,{dep_base}
							   ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_dol_' + doxie.Version_SuperKey);
								