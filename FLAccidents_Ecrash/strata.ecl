import strata;

export strata(string filedate) := function

d := BaseFile;


rPopulationStats_File_ECrash
 :=
  record
 CountGroup									 := count(group);

 d.st;   
dt_first_seen_CountNonBlank                             := sum(group,if( d.dt_first_seen <>'',1,0));
dt_last_seen_CountNonBlank                              := sum(group,if(d.dt_last_seen <>'',1,0));
report_code_CountNonBlank                               := sum(group,if(d.report_code <>'',1,0));
report_category_CountNonBlank                           := sum(group,if( d.report_category <>'',1,0));
report_code_desc_CountNonBlank                          := sum(group,if(d.report_code_desc <>'',1,0));
incident_id_CountNonBlank                               := sum(group,if( d.incident_id <>'',1,0));
vin_status_CountNonBlank                          		  := sum(group,if( d.vin_status <>'',1,0));
did_CountNonBlank                                       := sum(group,if(d.did <> 0,1 ,0 ));
title_CountNonBlank                                     := sum(group,if( d.title <>'',1,0));
fname_CountNonBlank                                     := sum(group,if( d.fname <>'',1,0));
mname_CountNonBlank                                     := sum(group,if( d.mname <>'',1,0));
lname_CountNonBlank                                     := sum(group,if( d.lname <>'',1,0));
suffix_CountNonBlank                                    := sum(group,if( d.suffix <>'',1,0));
prim_range_CountNonBlank                                := sum(group,if( d.prim_range <>'',1,0));
predir_CountNonBlank                                    := sum(group,if(d.predir <>'',1,0));
prim_name_CountNonBlank                                 := sum(group,if(d.prim_name <>'',1,0));
postdir_CountNonBlank                                   := sum(group,if( d.postdir <>'',1,0));
unit_desig_CountNonBlank                                := sum(group,if( d.unit_desig <>'',1,0));
sec_range_CountNonBlank                                 := sum(group,if( d.sec_range  <>'',1,0));
v_city_name_CountNonBlank                               := sum(group,if( d.v_city_name <>'',1,0));
st_CountNonBlank                                        := sum(group,if( d.st <>'',1,0));
z5_CountNonBlank                                        := sum(group,if( d.z5 <>'',1,0));
vin_CountNonBlank                                       := sum(group,if( d.vin <>'',1,0));
    
end;

tStats := table(d,rPopulationStats_File_ECrash,st,few);
strata.createXMLStats(tStats,'AccidentReports-ECrash','data',filedate,'skasavajjala@seisint.com',resultsOut);

d1 := d(agency_id not in  [ '0','']  );

rPopulationStats_File_ECrash_V2                                                                     
 :=                                                                                                 
  record                                                                                            
 CountGroup									 := count(group);                                                       
 d1.agency_id;                                                                                      
 d1.st;                                                                                             
                                                                                                    
dt_first_seen_CountNonBlank                             := sum(group,if( d1.dt_first_seen <>'',1,0));
dt_last_seen_CountNonBlank                              := sum(group,if(d1.dt_last_seen <>'',1,0)); 
report_code_CountNonBlank                               := sum(group,if(d1.report_code <>'',1,0));  
report_category_CountNonBlank                           := sum(group,if( d1.report_category <>'',1,0));
report_code_desc_CountNonBlank                          := sum(group,if(d1.report_code_desc <>'',1,0));
incident_id_CountNonBlank                               := sum(group,if( d1.incident_id <>'',1,0)); 
vin_status_CountNonBlank                          		  := sum(group,if( d1.vin_status <>'',1,0));  
did_CountNonBlank                                       := sum(group,if(d1.did <> 0,1 ,0 ));        
title_CountNonBlank                                     := sum(group,if( d1.title <>'',1,0));       
fname_CountNonBlank                                     := sum(group,if( d1.fname <>'',1,0));       
mname_CountNonBlank                                     := sum(group,if( d1.mname <>'',1,0));       
lname_CountNonBlank                                     := sum(group,if( d1.lname <>'',1,0));       
suffix_CountNonBlank                                    := sum(group,if( d1.suffix <>'',1,0));      
prim_range_CountNonBlank                                := sum(group,if( d1.prim_range <>'',1,0));  
predir_CountNonBlank                                    := sum(group,if(d1.predir <>'',1,0));       
prim_name_CountNonBlank                                 := sum(group,if(d1.prim_name <>'',1,0));    
postdir_CountNonBlank                                   := sum(group,if( d1.postdir <>'',1,0));     
unit_desig_CountNonBlank                                := sum(group,if( d1.unit_desig <>'',1,0));  
sec_range_CountNonBlank                                 := sum(group,if( d1.sec_range  <>'',1,0));  
v_city_name_CountNonBlank                               := sum(group,if( d1.v_city_name <>'',1,0)); 
st_CountNonBlank                                        := sum(group,if( d1.st <>'',1,0));          
z5_CountNonBlank                                        := sum(group,if( d1.z5 <>'',1,0));          
vin_CountNonBlank                                       := sum(group,if( d1.vin <>'',1,0));         
                                                                                                    
end;                                                                                                


tStats_v2 := table(d1,rPopulationStats_File_ECrash_V2,agency_id,st,few);
strata.createXMLStats(tStats_v2,'AccidentReports-ECrash_V2','data',filedate,'skasavajjala@seisint.com',resultsOutv2);


infile_accidents := FLAccidents_Ecrash.key_EcrashV2_accnbrv1; 

infile := project(infile_accidents , transform({infile_accidents, string10 source_id }, 
                     self.source_id := map(left.report_code in ['FA','TM','TF'] => left.report_code,
															                      left.report_code[1] ='I' => 'CRU-INQ',
																										left.report_code = 'EA' and left.work_type_id in ['1' ,'0','NULL']=> 'ECRASH', 
																										left.report_code = 'EA' and left.work_type_id in ['2' ,'3'] => 'EA-CRU', 'CRU-NIGHTLY'), self:= left));

rPopulationStats_infile
 :=
  record
    infile.source_id;
    CountGroup									 := count(group);
		did_rate                     := sum(group,IF((unsigned)infile(fname not in ['','NULL','0'] and lname not in ['','NULL','0']).did <> 0,1,0))/sum(group,IF(infile.lname not in ['','NULL','0'] and infile.fname not in ['','NULL','0'],1,0)) * 100;
    l_accnbr_CountNonBlank                                     := sum(group,if(infile.l_accnbr<>'',1,0));
    report_code_CountNonBlank                                  := sum(group,if(trim(infile.report_code,left,right) not in ['','NULL','0'],1,0));
    jurisdiction_state_CountNonBlank                           := sum(group,if(trim(infile.jurisdiction_state,left,right) not in ['','NULL','0'],1,0));
    jurisdiction_CountNonBlank                                 := sum(group,if(trim(infile.jurisdiction,left,right) not in ['','NULL','0'],1,0));
    orig_accnbr_CountNonBlank                                  := sum(group,if(trim(infile.orig_accnbr,left,right) not in ['','NULL','0'],1,0));
    vehicle_incident_id_CountNonBlank                          := sum(group,if(trim(infile.vehicle_incident_id,left,right) not in ['','NULL','0'],1,0));
    vehicle_status_CountNonBlank                               := sum(group,if(trim(infile.vehicle_status,left,right) not in ['','NULL','0'],1,0));
    dt_first_seen_CountNonBlank                                := sum(group,if(trim(infile.dt_first_seen,left,right) not in ['','NULL','0'],1,0));
    dt_last_seen_CountNonBlank                                 := sum(group,if(trim(infile.dt_last_seen,left,right) not in ['','NULL','0'],1,0));
    accident_date_CountNonBlank                                := sum(group,if(trim(infile.accident_date,left,right) not in ['','NULL','0'],1,0));
    did_CountNonBlank                                          := sum(group,if((unsigned)(infile.did)<>0,1,0));
    title_CountNonBlank                                        := sum(group,if(trim(infile.title,left,right) not in ['','NULL','0'],1,0));
    fname_CountNonBlank                                        := sum(group,if(trim(infile.fname,left,right) not in ['','NULL','0'],1,0));
    mname_CountNonBlank                                        := sum(group,if(trim(infile.mname,left,right) not in ['','NULL','0'],1,0));
    lname_CountNonBlank                                        := sum(group,if(trim(infile.lname,left,right) not in ['','NULL','0'],1,0));
    name_suffix_CountNonBlank                                  := sum(group,if(trim(infile.name_suffix,left,right) not in ['','NULL','0'],1,0));
    dob_CountNonBlank                                          := sum(group,if(trim(infile.dob,left,right) not in ['','NULL','0'],1,0));
    b_did_CountNonBlank                                        := sum(group,if(trim(infile.b_did,left,right) not in ['','NULL','0'],1,0));
    cname_CountNonBlank                                        := sum(group,if(trim(infile.cname,left,right) not in ['','NULL','0'],1,0));
    prim_range_CountNonBlank                                   := sum(group,if(trim(infile.prim_range,left,right) not in ['','NULL','0'],1,0));
    predir_CountNonBlank                                       := sum(group,if(trim(infile.predir,left,right) not in ['','NULL','0'],1,0));
    prim_name_CountNonBlank                                    := sum(group,if(trim(infile.prim_name,left,right) not in ['','NULL','0'],1,0));
    addr_suffix_CountNonBlank                                  := sum(group,if(trim(infile.addr_suffix,left,right) not in ['','NULL','0'],1,0));
    postdir_CountNonBlank                                      := sum(group,if(trim(infile.postdir,left,right) not in ['','NULL','0'],1,0));
    unit_desig_CountNonBlank                                   := sum(group,if(trim(infile.unit_desig,left,right) not in ['','NULL','0'],1,0));
    sec_range_CountNonBlank                                    := sum(group,if(trim(infile.sec_range,left,right) not in ['','NULL','0'],1,0));
    v_city_name_CountNonBlank                                  := sum(group,if(trim(infile.v_city_name,left,right) not in ['','NULL','0'],1,0));
    st_CountNonBlank                                           := sum(group,if(trim(infile.st,left,right) not in ['','NULL','0'],1,0));
    zip_CountNonBlank                                          := sum(group,if(trim(infile.zip,left,right) not in ['','NULL','0'],1,0));
    zip4_CountNonBlank                                         := sum(group,if(trim(infile.zip4,left,right) not in ['','NULL','0'],1,0));
    record_type_CountNonBlank                                  := sum(group,if(trim(infile.record_type,left,right) not in ['','NULL','0'],1,0));
    report_code_desc_CountNonBlank                             := sum(group,if(trim(infile.report_code_desc,left,right) not in ['','NULL','0'],1,0));
    report_category_CountNonBlank                              := sum(group,if(trim(infile.report_category,left,right) not in ['','NULL','0'],1,0));
    vin_CountNonBlank                                          := sum(group,if(trim(infile.vin,left,right) not in ['','NULL','0'],1,0));
    driver_license_nbr_CountNonBlank                           := sum(group,if(trim(infile.driver_license_nbr,left,right) not in ['','NULL','0'],1,0));
    dlnbr_st_CountNonBlank                                     := sum(group,if(trim(infile.dlnbr_st,left,right) not in ['','NULL','0'],1,0));
    tag_nbr_CountNonBlank                                      := sum(group,if(trim(infile.tag_nbr,left,right) not in ['','NULL','0'],1,0));
    tagnbr_st_CountNonBlank                                    := sum(group,if(trim(infile.tagnbr_st,left,right) not in ['','NULL','0'],1,0));
    accident_location_CountNonBlank                            := sum(group,if(trim(infile.accident_location,left,right) not in ['','NULL','0'],1,0));
    accident_street_CountNonBlank                              := sum(group,if(trim(infile.accident_street,left,right) not in ['','NULL','0'],1,0));
    accident_cross_street_CountNonBlank                        := sum(group,if(trim(infile.accident_cross_street,left,right) not in ['','NULL','0'],1,0));
    next_street_CountNonBlank                                  := sum(group,if(trim(infile.next_street,left,right) not in ['','NULL','0'],1,0));
    jurisdiction_nbr_CountNonBlank                             := sum(group,if(trim(infile.jurisdiction_nbr,left,right) not in ['','NULL','0'],1,0));
    image_hash_CountNonBlank                                   := sum(group,if(trim(infile.image_hash,left,right) not in ['','NULL','0'],1,0));
    airbags_deploy_CountNonBlank                               := sum(group,if(trim(infile.airbags_deploy,left,right) not in ['','NULL','0'],1,0));
    policy_num_CountNonBlank                                   := sum(group,if(trim(infile.policy_num,left,right) not in ['','NULL','0'],1,0));
    policy_effective_date_CountNonBlank                        := sum(group,if(trim(infile.policy_effective_date,left,right) not in ['','NULL','0'],1,0));
    policy_expiration_date_CountNonBlank                       := sum(group,if(trim(infile.policy_expiration_date,left,right) not in ['','NULL','0'],1,0));
    report_has_coversheet_CountNonBlank                        := sum(group,if(trim(infile.report_has_coversheet,left,right) not in ['','NULL','0'],1,0));
    other_vin_indicator_CountNonBlank                          := sum(group,if(trim(infile.other_vin_indicator,left,right) not in ['','NULL','0'],1,0));
    vehicle_unit_number_CountNonBlank                          := sum(group,if(trim(infile.vehicle_unit_number,left,right) not in ['','NULL','0'],1,0));
    vehicle_incident_city_CountNonBlank                        := sum(group,if(trim(infile.vehicle_incident_city,left,right) not in ['','NULL','0'],1,0));
    vehicle_incident_st_CountNonBlank                          := sum(group,if(trim(infile.vehicle_incident_st,left,right) not in ['','NULL','0'],1,0));
    carrier_name_CountNonBlank                                 := sum(group,if(trim(infile.carrier_name,left,right) not in ['','NULL','0'],1,0));
    client_type_id_CountNonBlank                               := sum(group,if(trim(infile.client_type_id,left,right) not in ['','NULL','0'],1,0));
    towed_CountNonBlank                                        := sum(group,if(trim(infile.towed,left,right) not in ['','NULL','0'],1,0));
    impact_location_CountNonBlank                              := sum(group,if(trim(infile.impact_location,left,right) not in ['','NULL','0'],1,0));
    vehicle_owner_driver_code_CountNonBlank                    := sum(group,if(trim(infile.vehicle_owner_driver_code,left,right) not in ['','NULL','0'],1,0));
    vehicle_driver_action_CountNonBlank                        := sum(group,if(trim(infile.vehicle_driver_action,left,right) not in ['','NULL','0'],1,0));
    vehicle_year_CountNonBlank                                 := sum(group,if(trim(infile.vehicle_year,left,right) not in ['','NULL','0'],1,0));
    vehicle_make_CountNonBlank                                 := sum(group,if(trim(infile.vehicle_make,left,right) not in ['','NULL','0'],1,0));
    vehicle_type_CountNonBlank                                 := sum(group,if(trim(infile.vehicle_type,left,right) not in ['','NULL','0'],1,0));
    vehicle_travel_on_CountNonBlank                            := sum(group,if(trim(infile.vehicle_travel_on,left,right) not in ['','NULL','0'],1,0));
    direction_travel_CountNonBlank                             := sum(group,if(trim(infile.direction_travel,left,right) not in ['','NULL','0'],1,0));
    est_vehicle_speed_CountNonBlank                            := sum(group,if(trim(infile.est_vehicle_speed,left,right) not in ['','NULL','0'],1,0));
    posted_speed_CountNonBlank                                 := sum(group,if(trim(infile.posted_speed,left,right) not in ['','NULL','0'],1,0));
    est_vehicle_damage_CountNonBlank                           := sum(group,if(trim(infile.est_vehicle_damage,left,right) not in ['','NULL','0'],1,0));
    damage_type_CountNonBlank                                  := sum(group,if(trim(infile.damage_type,left,right) not in ['','NULL','0'],1,0));
    vehicle_removed_by_CountNonBlank                           := sum(group,if(trim(infile.vehicle_removed_by,left,right) not in ['','NULL','0'],1,0));
    how_removed_code_CountNonBlank                             := sum(group,if(trim(infile.how_removed_code,left,right) not in ['','NULL','0'],1,0));
    point_of_impact_CountNonBlank                              := sum(group,if(trim(infile.point_of_impact,left,right) not in ['','NULL','0'],1,0));
    vehicle_movement_CountNonBlank                             := sum(group,if(trim(infile.vehicle_movement,left,right) not in ['','NULL','0'],1,0));
    vehicle_function_CountNonBlank                             := sum(group,if(trim(infile.vehicle_function,left,right) not in ['','NULL','0'],1,0));
    vehs_first_defect_CountNonBlank                            := sum(group,if(trim(infile.vehs_first_defect,left,right) not in ['','NULL','0'],1,0));
    vehs_second_defect_CountNonBlank                           := sum(group,if(trim(infile.vehs_second_defect,left,right) not in ['','NULL','0'],1,0));
    vehicle_modified_CountNonBlank                             := sum(group,if(trim(infile.vehicle_modified,left,right) not in ['','NULL','0'],1,0));
    vehicle_roadway_loc_CountNonBlank                          := sum(group,if(trim(infile.vehicle_roadway_loc,left,right) not in ['','NULL','0'],1,0));
    hazard_material_transport_CountNonBlank                    := sum(group,if(trim(infile.hazard_material_transport,left,right) not in ['','NULL','0'],1,0));
    total_occu_vehicle_CountNonBlank                           := sum(group,if(trim(infile.total_occu_vehicle,left,right) not in ['','NULL','0'],1,0));
    total_occu_saf_equip_CountNonBlank                         := sum(group,if(trim(infile.total_occu_saf_equip,left,right) not in ['','NULL','0'],1,0));
    moving_violation_CountNonBlank                             := sum(group,if(trim(infile.moving_violation,left,right) not in ['','NULL','0'],1,0));
    vehicle_insur_code_CountNonBlank                           := sum(group,if(trim(infile.vehicle_insur_code,left,right) not in ['','NULL','0'],1,0));
    vehicle_fault_code_CountNonBlank                           := sum(group,if(trim(infile.vehicle_fault_code,left,right) not in ['','NULL','0'],1,0));
    vehicle_cap_code_CountNonBlank                             := sum(group,if(trim(infile.vehicle_cap_code,left,right) not in ['','NULL','0'],1,0));
    vehicle_fr_code_CountNonBlank                              := sum(group,if(trim(infile.vehicle_fr_code,left,right) not in ['','NULL','0'],1,0));
    vehicle_use_CountNonBlank                                  := sum(group,if(trim(infile.vehicle_use,left,right) not in ['','NULL','0'],1,0));
    placarded_CountNonBlank                                    := sum(group,if(trim(infile.placarded,left,right) not in ['','NULL','0'],1,0));
    dhsmv_vehicle_ind_CountNonBlank                            := sum(group,if(trim(infile.dhsmv_vehicle_ind,left,right) not in ['','NULL','0'],1,0));
    vehicle_seg_CountNonBlank                                  := sum(group,if(trim(infile.vehicle_seg,left,right) not in ['','NULL','0'],1,0));
    vehicle_seg_type_CountNonBlank                             := sum(group,if(trim(infile.vehicle_seg_type,left,right) not in ['','NULL','0'],1,0));
    match_code_CountNonBlank                                   := sum(group,if(trim(infile.match_code,left,right) not in ['','NULL','0'],1,0));
    model_year_CountNonBlank                                   := sum(group,if(trim(infile.model_year,left,right) not in ['','NULL','0'],1,0));
    manufacturer_corporation_CountNonBlank                     := sum(group,if(trim(infile.manufacturer_corporation,left,right) not in ['','NULL','0'],1,0));
    division_code_CountNonBlank                                := sum(group,if(trim(infile.division_code,left,right) not in ['','NULL','0'],1,0));
    vehicle_group_code_CountNonBlank                           := sum(group,if(trim(infile.vehicle_group_code,left,right) not in ['','NULL','0'],1,0));
    vehicle_subgroup_code_CountNonBlank                        := sum(group,if(trim(infile.vehicle_subgroup_code,left,right) not in ['','NULL','0'],1,0));
    vehicle_series_code_CountNonBlank                          := sum(group,if(trim(infile.vehicle_series_code,left,right) not in ['','NULL','0'],1,0));
    body_style_code_CountNonBlank                              := sum(group,if(trim(infile.body_style_code,left,right) not in ['','NULL','0'],1,0));
    vehicle_abbreviation_CountNonBlank                         := sum(group,if(trim(infile.vehicle_abbreviation,left,right) not in ['','NULL','0'],1,0));
    assembly_country_CountNonBlank                             := sum(group,if(trim(infile.assembly_country,left,right) not in ['','NULL','0'],1,0));
    headquarter_country_CountNonBlank                          := sum(group,if(trim(infile.headquarter_country,left,right) not in ['','NULL','0'],1,0));
    number_of_doors_CountNonBlank                              := sum(group,if(trim(infile.number_of_doors,left,right) not in ['','NULL','0'],1,0));
    seating_capacity_CountNonBlank                             := sum(group,if(trim(infile.seating_capacity,left,right) not in ['','NULL','0'],1,0));
    number_of_cylinders_CountNonBlank                          := sum(group,if(trim(infile.number_of_cylinders,left,right) not in ['','NULL','0'],1,0));
    engine_size_CountNonBlank                                  := sum(group,if(trim(infile.engine_size,left,right) not in ['','NULL','0'],1,0));
    fuel_code_CountNonBlank                                    := sum(group,if(trim(infile.fuel_code,left,right) not in ['','NULL','0'],1,0));
    carburetion_type_CountNonBlank                             := sum(group,if(trim(infile.carburetion_type,left,right) not in ['','NULL','0'],1,0));
    number_of_barrels_CountNonBlank                            := sum(group,if(trim(infile.number_of_barrels,left,right) not in ['','NULL','0'],1,0));
    price_class_code_CountNonBlank                             := sum(group,if(trim(infile.price_class_code,left,right) not in ['','NULL','0'],1,0));
    body_size_code_CountNonBlank                               := sum(group,if(trim(infile.body_size_code,left,right) not in ['','NULL','0'],1,0));
    number_of_wheels_on_road_CountNonBlank                     := sum(group,if(trim(infile.number_of_wheels_on_road,left,right) not in ['','NULL','0'],1,0));
    number_of_driving_wheels_CountNonBlank                     := sum(group,if(trim(infile.number_of_driving_wheels,left,right) not in ['','NULL','0'],1,0));
    drive_type_CountNonBlank                                   := sum(group,if(trim(infile.drive_type,left,right) not in ['','NULL','0'],1,0));
    steering_type_CountNonBlank                                := sum(group,if(trim(infile.steering_type,left,right) not in ['','NULL','0'],1,0));
    gvw_code_CountNonBlank                                     := sum(group,if(trim(infile.gvw_code,left,right) not in ['','NULL','0'],1,0));
    load_capacity_code_CountNonBlank                           := sum(group,if(trim(infile.load_capacity_code,left,right) not in ['','NULL','0'],1,0));
    cab_type_code_CountNonBlank                                := sum(group,if(trim(infile.cab_type_code,left,right) not in ['','NULL','0'],1,0));
    bed_length_CountNonBlank                                   := sum(group,if(trim(infile.bed_length,left,right) not in ['','NULL','0'],1,0));
    rim_size_CountNonBlank                                     := sum(group,if(trim(infile.rim_size,left,right) not in ['','NULL','0'],1,0));
    manufacture_body_style_CountNonBlank                       := sum(group,if(trim(infile.manufacture_body_style,left,right) not in ['','NULL','0'],1,0));
    vehicle_type_code_CountNonBlank                            := sum(group,if(trim(infile.vehicle_type_code,left,right) not in ['','NULL','0'],1,0));
    car_line_code_CountNonBlank                                := sum(group,if(trim(infile.car_line_code,left,right) not in ['','NULL','0'],1,0));
    car_series_code_CountNonBlank                              := sum(group,if(trim(infile.car_series_code,left,right) not in ['','NULL','0'],1,0));
    car_body_style_code_CountNonBlank                          := sum(group,if(trim(infile.car_body_style_code,left,right) not in ['','NULL','0'],1,0));
    engine_cylinder_code_CountNonBlank                         := sum(group,if(trim(infile.engine_cylinder_code,left,right) not in ['','NULL','0'],1,0));
    truck_make_abbreviation_CountNonBlank                      := sum(group,if(trim(infile.truck_make_abbreviation,left,right) not in ['','NULL','0'],1,0));
    truck_body_style_abbreviation_CountNonBlank                := sum(group,if(trim(infile.truck_body_style_abbreviation,left,right) not in ['','NULL','0'],1,0));
    motorcycle_make_abbreviation_CountNonBlank                 := sum(group,if(trim(infile.motorcycle_make_abbreviation,left,right) not in ['','NULL','0'],1,0));
    vina_series_CountNonBlank                                  := sum(group,if(trim(infile.vina_series,left,right) not in ['','NULL','0'],1,0));
    vina_model_CountNonBlank                                   := sum(group,if(trim(infile.vina_model,left,right) not in ['','NULL','0'],1,0));
    reference_number_CountNonBlank                             := sum(group,if(trim(infile.reference_number,left,right) not in ['','NULL','0'],1,0));
    vina_make_CountNonBlank                                    := sum(group,if(trim(infile.vina_make,left,right) not in ['','NULL','0'],1,0));
    vina_body_style_CountNonBlank                              := sum(group,if(trim(infile.vina_body_style,left,right) not in ['','NULL','0'],1,0));
    make_description_CountNonBlank                             := sum(group,if(trim(infile.make_description,left,right) not in ['','NULL','0'],1,0));
    model_description_CountNonBlank                            := sum(group,if(trim(infile.model_description,left,right) not in ['','NULL','0'],1,0));
    series_description_CountNonBlank                           := sum(group,if(trim(infile.series_description,left,right) not in ['','NULL','0'],1,0));
    car_series_CountNonBlank                                   := sum(group,if(trim(infile.car_series,left,right) not in ['','NULL','0'],1,0));
    car_body_style_CountNonBlank                               := sum(group,if(trim(infile.car_body_style,left,right) not in ['','NULL','0'],1,0));
    car_cid_CountNonBlank                                      := sum(group,if(trim(infile.car_cid,left,right) not in ['','NULL','0'],1,0));
    car_cylinders_CountNonBlank                                := sum(group,if(trim(infile.car_cylinders,left,right) not in ['','NULL','0'],1,0));
    car_carburetion_CountNonBlank                              := sum(group,if(trim(infile.car_carburetion,left,right) not in ['','NULL','0'],1,0));
    car_fuel_code_CountNonBlank                                := sum(group,if(trim(infile.car_fuel_code,left,right) not in ['','NULL','0'],1,0));
    truck_chassis_body_style_CountNonBlank                     := sum(group,if(trim(infile.truck_chassis_body_style,left,right) not in ['','NULL','0'],1,0));
    truck_wheels_driving_wheels_CountNonBlank                  := sum(group,if(trim(infile.truck_wheels_driving_wheels,left,right) not in ['','NULL','0'],1,0));
    truck_cid_CountNonBlank                                    := sum(group,if(trim(infile.truck_cid,left,right) not in ['','NULL','0'],1,0));
    truck_cylinders_CountNonBlank                              := sum(group,if(trim(infile.truck_cylinders,left,right) not in ['','NULL','0'],1,0));
    truck_fuel_code_CountNonBlank                              := sum(group,if(trim(infile.truck_fuel_code,left,right) not in ['','NULL','0'],1,0));
    truck_manufacturers_gvw_code_CountNonBlank                 := sum(group,if(trim(infile.truck_manufacturers_gvw_code,left,right) not in ['','NULL','0'],1,0));
    truck_ton_rating_code_CountNonBlank                        := sum(group,if(trim(infile.truck_ton_rating_code,left,right) not in ['','NULL','0'],1,0));
    truck_series_CountNonBlank                                 := sum(group,if(trim(infile.truck_series,left,right) not in ['','NULL','0'],1,0));
    truck_model_CountNonBlank                                  := sum(group,if(trim(infile.truck_model,left,right) not in ['','NULL','0'],1,0));
    motorcycle_model_CountNonBlank                             := sum(group,if(trim(infile.motorcycle_model,left,right) not in ['','NULL','0'],1,0));
    motorcycle_engine_displacement_CountNonBlank               := sum(group,if(trim(infile.motorcycle_engine_displacement,left,right) not in ['','NULL','0'],1,0));
    motorcycle_type_of_bike_CountNonBlank                      := sum(group,if(trim(infile.motorcycle_type_of_bike,left,right) not in ['','NULL','0'],1,0));
    motorcycle_cylinder_coding_CountNonBlank                   := sum(group,if(trim(infile.motorcycle_cylinder_coding,left,right) not in ['','NULL','0'],1,0));
    addl_report_number_CountNonBlank                           := sum(group,if(trim(infile.addl_report_number,left,right) not in ['','NULL','0'],1,0));
    agency_ori_CountNonBlank                                   := sum(group,if(trim(infile.agency_ori,left,right) not in ['','NULL','0'],1,0));
    insurance_company_standardized_CountNonBlank               := sum(group,if(trim(infile.insurance_company_standardized,left,right) not in ['','NULL','0'],1,0));
    is_available_for_public_CountNonBlank                      := sum(group,if(trim(infile.is_available_for_public,left,right) not in ['','NULL','0'],1,0));
    report_status_CountNonBlank                                := sum(group,if(trim(infile.report_status,left,right) not in ['','NULL','0'],1,0));
    work_type_id_CountNonBlank                                 := sum(group,if(trim(infile.work_type_id,left,right) not in ['','NULL','0'],1,0));
    orig_fname_CountNonBlank                                   := sum(group,if(trim(infile.orig_fname,left,right) not in ['','NULL','0'],1,0));
    orig_lname_CountNonBlank                                   := sum(group,if(trim(infile.orig_lname,left,right) not in ['','NULL','0'],1,0));
    orig_mname_CountNonBlank                                   := sum(group,if(trim(infile.orig_mname,left,right) not in ['','NULL','0'],1,0));
    orig_full_name_CountNonBlank                               := sum(group,if(trim(infile.orig_full_name,left,right) not in ['','NULL','0'],1,0));
    ssn_CountNonBlank                                          := sum(group,if(trim(infile.ssn,left,right) not in ['','NULL','0'],1,0));
    cru_order_id_CountNonBlank                                 := sum(group,if(trim(infile.cru_order_id,left,right) not in ['','NULL','0'],1,0));
    cru_sequence_nbr_CountNonBlank                             := sum(group,if(trim(infile.cru_sequence_nbr,left,right) not in ['','NULL','0'],1,0));
    date_vendor_last_reported_CountNonBlank                    := sum(group,if(trim(infile.date_vendor_last_reported,left,right) not in ['','NULL','0'],1,0));
    report_type_id_CountNonBlank                               := sum(group,if(trim(infile.report_type_id,left,right) not in ['','NULL','0'],1,0));
    tif_image_hash_CountNonBlank                               := sum(group,if(trim(infile.tif_image_hash,left,right) not in ['','NULL','0'],1,0));
    
  end;


tStats_index := table(infile,rPopulationStats_infile,source_id,few);

strata.createXMLStats(tStats_index,'AccidentReports-Index','data',filedate,'skasavajjala@seisint.com',resultsOut_index)

return sequential(resultsOut,resultsOutv2,resultsOut_index);
end;



