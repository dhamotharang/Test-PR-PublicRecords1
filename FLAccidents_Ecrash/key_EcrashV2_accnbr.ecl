Import Data_Services, doxie,FLAccidents;

Ecrash := FLAccidents_Ecrash.File_KeybuildV2.out(report_code in ['EA','TM','TF']);//for ecrash iyetek they need report number displayed even no vin and name

Filter_CRU := FLAccidents_Ecrash.File_KeybuildV2.out(report_code not in ['EA','TM','TF']);

crash_accnbr_base := 	Ecrash + Filter_CRU (vin+driver_license_nbr+tag_nbr+lname <>'') ; 
						
// normalize addl_report_number 

NormAddlRpt := project(crash_accnbr_base(trim(addl_report_number,left,right) not in ['','0','UNK', 'UNKNOWN'] and report_code in ['TF','TM']), transform( {crash_accnbr_base}, 

self.accident_nbr :=stringlib.StringFilter(left.addl_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
 self := left)); 

crash_accnbr_base_norm := (crash_accnbr_base + NormAddlRpt) (trim(accident_nbr,left,right)<>'');
											 
dst_accnbr_base := distribute(crash_accnbr_base_norm, hash(orig_accnbr));
srt_accnbr_base := sort(dst_accnbr_base, except did, except b_did, local);
dep_accnbr_base := dedup(srt_accnbr_base, except did, except b_did, local);

																				
export key_EcrashV2_accnbr := index(dep_accnbr_base
                                  ,{string40 l_accnbr := accident_nbr, report_code,jurisdiction_state, jurisdiction}

								 ,{
								   orig_accnbr, 
								   vehicle_incident_id,
									 vehicle_status,
									 dt_first_seen,
									 dt_last_seen,
									 accident_date,
									 did,
									 title,fname,mname,lname,name_suffix,
									 dob,
									 b_did,
									 cname,
								   prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip,zip4,
								   record_type,
									 report_code_desc,
									 report_category,
									 vin,
									 driver_license_nbr,
									 dlnbr_st,
									 tag_nbr,
									 tagnbr_st,
								   accident_location,accident_street,accident_cross_street,next_street, // new field 
									 jurisdiction,jurisdiction_state,jurisdiction_nbr,
									 IMAGE_HASH,
									 AIRBAGS_DEPLOY,
									 Policy_num,Policy_Effective_Date,Policy_Expiration_Date,
									 Report_Has_Coversheet, 
									 other_vin_indicator,
									 vehicle_Unit_Number,
									 vehicle_incident_city;
vehicle_incident_st;
carrier_name;
client_type_id;
towed,
impact_location,
vehicle_owner_driver_code,
vehicle_driver_action,
vehicle_year,
vehicle_make,
vehicle_type,
vehicle_travel_on,
direction_travel,
est_vehicle_speed,
posted_speed,
est_vehicle_damage,
damage_type,
vehicle_removed_by,
how_removed_code,
point_of_impact,
vehicle_movement,
vehicle_function,
vehs_first_defect,
vehs_second_defect,
vehicle_modified,
vehicle_roadway_loc,
hazard_material_transport,
total_occu_vehicle,
total_occu_saf_equip,
moving_violation,
vehicle_insur_code,
vehicle_fault_code,
vehicle_cap_code,
vehicle_fr_code,
vehicle_use,
placarded,
dhsmv_vehicle_ind,
vehicle_seg,
vehicle_seg_type,
match_code,
model_year,
manufacturer_corporation,
division_code,
vehicle_group_code,
vehicle_subgroup_code,
vehicle_series_code,
body_style_code,
vehicle_abbreviation,
assembly_country,
headquarter_country,
number_of_doors,
seating_capacity,
number_of_cylinders,
engine_size,
fuel_code,
carburetion_type,
number_of_barrels,
price_class_code,
body_size_code,
number_of_wheels_on_road,
number_of_driving_wheels,
drive_type,
steering_type,
gvw_code,
load_capacity_code,
cab_type_code,
bed_length,
rim_size,
manufacture_body_style,
vehicle_type_code,
car_line_code,
car_series_code,
car_body_style_code,
engine_cylinder_code,
truck_make_abbreviation,
truck_body_style_abbreviation,
motorcycle_make_abbreviation,
vina_series,
vina_model,
reference_number,
vina_make,
vina_body_style,
make_description,
model_description,
series_description,
car_series,
car_body_style,
car_cid,
car_cylinders,
car_carburetion,
car_fuel_code,
truck_chassis_body_style,
truck_wheels_driving_wheels,
truck_cid,
truck_cylinders,
truck_fuel_code,
truck_manufacturers_gvw_code,
truck_ton_rating_code,
truck_series,
truck_model,
motorcycle_model,
motorcycle_engine_displacement,
motorcycle_type_of_bike,
motorcycle_cylinder_coding,
addl_report_number,
agency_ori,
Insurance_Company_Standardized ,
is_available_for_public,
report_status,
work_type_id,
orig_fname; 
orig_lname; 
orig_mname;  
orig_full_name ; 
ssn;
cru_order_id;
cru_sequence_nbr;
date_vendor_last_reported; 
report_type_id;								 
									 }
							      ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_accnbr_' + doxie.Version_SuperKey);
 


