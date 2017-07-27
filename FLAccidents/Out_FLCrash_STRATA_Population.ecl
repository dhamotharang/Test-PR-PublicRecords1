
EXPORT Out_FLCrash_STRATA_Population(pFLCrash0
                                    ,pFLCrash1
									,pFLCrash2
                                    ,pFLCrash3
									,pFLCrash4
									,pFLCrash5
                                    ,pFLCrash6
									,pFLCrash7
									,pFLCrash8
									,pFLCrashDID
							        ,pVersion
									,zOut) := MACRO
import STRATA;


	#uniquename(rPopulationStats_FLCrash0);
	#uniquename(dPopulationStats_FLCrash0);
	#uniquename(zFLCrash0);
	#uniquename(rPopulationStats_FLCrash1);
	#uniquename(dPopulationStats_FLCrash1);
	#uniquename(zFLCrash1);
	#uniquename(rPopulationStats_FLCrash2);
	#uniquename(dPopulationStats_FLCrash2);
	#uniquename(zFLCrash2);
	#uniquename(rPopulationStats_FLCrash3);
	#uniquename(dPopulationStats_FLCrash3);
	#uniquename(zFLCrash3);
	#uniquename(rPopulationStats_FLCrash4);
	#uniquename(dPopulationStats_FLCrash4);
	#uniquename(zFLCrash4);
	#uniquename(rPopulationStats_FLCrash5);
	#uniquename(dPopulationStats_FLCrash5);
	#uniquename(zFLCrash5);
	#uniquename(rPopulationStats_FLCrash6);
	#uniquename(dPopulationStats_FLCrash6);
	#uniquename(zFLCrash6);
	#uniquename(rPopulationStats_FLCrash7);
	#uniquename(dPopulationStats_FLCrash7);
	#uniquename(zFLCrash7);
	#uniquename(rPopulationStats_FLCrash8);
	#uniquename(dPopulationStats_FLCrash8);
	#uniquename(zFLCrash8);
	#uniquename(rPopulationStats_FLCrashDID);
	#uniquename(dPopulationStats_FLCrashDID);
	#uniquename(zFLCrashDID);

// Create the Florida Crash 0 record layout
%rPopulationStats_FLCrash0%
 :=
  record
    CountGroup                                                   := count(group);
    rec_type_o_CountNonBlank                            := sum(group,if(pFLCrash0.rec_type_o<>'',1,0));
    accident_nbr_CountNonBlank                          := sum(group,if(pFLCrash0.accident_nbr<>'',1,0));
    filler1_CountNonBlank                               := sum(group,if(pFLCrash0.filler1<>'',1,0));
    microfilm_nbr_CountNonBlank                         := sum(group,if(pFLCrash0.microfilm_nbr<>'',1,0));
    st_road_accident_CountNonBlank                      := sum(group,if(pFLCrash0.st_road_accident<>'',1,0));
    accident_date_CountNonBlank                         := sum(group,if(pFLCrash0.accident_date<>'',1,0));
    pFLCrash0.city_nbr;
    ft_city_town_CountNonBlank                          := sum(group,if(pFLCrash0.ft_city_town<>'',1,0));
    miles_city_town_CountNonBlank                       := sum(group,if(pFLCrash0.miles_city_town<>'',1,0));
    direction_city_town_CountNonBlank                   := sum(group,if(pFLCrash0.direction_city_town<>'',1,0));
    city_town_name_CountNonBlank                        := sum(group,if(pFLCrash0.city_town_name<>'',1,0));
    county_name_CountNonBlank                           := sum(group,if(pFLCrash0.county_name<>'',1,0));
    at_node_nbr_CountNonBlank                           := sum(group,if(pFLCrash0.at_node_nbr<>'',1,0));
    ft_miles_node_CountNonBlank                         := sum(group,if(pFLCrash0.ft_miles_node<>'',1,0));
    ft_miles_code1_CountNonBlank                        := sum(group,if(pFLCrash0.ft_miles_code1<>'',1,0));
    from_node_nbr_CountNonBlank                         := sum(group,if(pFLCrash0.from_node_nbr<>'',1,0));
    next_node_rdwy_CountNonBlank                        := sum(group,if(pFLCrash0.next_node_rdwy<>'',1,0));
    st_road_hhwy_name_CountNonBlank                     := sum(group,if(pFLCrash0.st_road_hhwy_name<>'',1,0));
    at_intersect_of_CountNonBlank                       := sum(group,if(pFLCrash0.at_intersect_of<>'',1,0));
    ft_miles_from_intersect_CountNonBlank               := sum(group,if(pFLCrash0.ft_miles_from_intersect<>'',1,0));
    ft_miles_code2_CountNonBlank                        := sum(group,if(pFLCrash0.ft_miles_code2<>'',1,0));
    intersect_dir_of_CountNonBlank                      := sum(group,if(pFLCrash0.intersect_dir_of<>'',1,0));
    of_intersect_of_CountNonBlank                       := sum(group,if(pFLCrash0.of_intersect_of<>'',1,0));
    codeable_noncodeable_CountNonBlank                  := sum(group,if(pFLCrash0.codeable_noncodeable<>'',1,0));
    type_fr_case_CountNonBlank                          := sum(group,if(pFLCrash0.type_fr_case<>'',1,0));
    action_code_CountNonBlank                           := sum(group,if(pFLCrash0.action_code<>'',1,0));
    filler2_CountNonBlank                               := sum(group,if(pFLCrash0.filler2<>'',1,0));
    dot_type_facility_CountNonBlank                     := sum(group,if(pFLCrash0.dot_type_facility<>'',1,0));
    dot_road_type_CountNonBlank                         := sum(group,if(pFLCrash0.dot_road_type<>'',1,0));
    dot_nbr_lanes_CountNonBlank                         := sum(group,if(pFLCrash0.dot_nbr_lanes<>'',1,0));
    dot_site_loc_CountNonBlank                          := sum(group,if(pFLCrash0.dot_site_loc<>'',1,0));
    dot_district_ind_CountNonBlank                      := sum(group,if(pFLCrash0.dot_district_ind<>'',1,0));
    dot_county_CountNonBlank                            := sum(group,if(pFLCrash0.dot_county<>'',1,0));
    dot_section_nbr_CountNonBlank                       := sum(group,if(pFLCrash0.dot_section_nbr<>'',1,0));
    dot_skid_resistance_CountNonBlank                   := sum(group,if(pFLCrash0.dot_skid_resistance<>'',1,0));
    dot_friction_coarse_CountNonBlank                   := sum(group,if(pFLCrash0.dot_friction_coarse<>'',1,0));
    dot_avg_daily_traffic_CountNonBlank                 := sum(group,if(pFLCrash0.dot_avg_daily_traffic<>'',1,0));
    dot_node_nbr_CountNonBlank                          := sum(group,if(pFLCrash0.dot_node_nbr<>'',1,0));
    dot_distance_node_CountNonBlank                     := sum(group,if(pFLCrash0.dot_distance_node<>'',1,0));
    dot_dir_from_node_CountNonBlank                     := sum(group,if(pFLCrash0.dot_dir_from_node<>'',1,0));
    dot_st_road_nbr_CountNonBlank                       := sum(group,if(pFLCrash0.dot_st_road_nbr<>'',1,0));
    dot_us_road_nbr_CountNonBlank                       := sum(group,if(pFLCrash0.dot_us_road_nbr<>'',1,0));
    dot_milepost_CountNonBlank                          := sum(group,if(pFLCrash0.dot_milepost<>'',1,0));
    dot_hhwy_loc_CountNonBlank                          := sum(group,if(pFLCrash0.dot_hhwy_loc<>'',1,0));
    dot_subsection_CountNonBlank                        := sum(group,if(pFLCrash0.dot_subsection<>'',1,0));
    dot_system_type_CountNonBlank                       := sum(group,if(pFLCrash0.dot_system_type<>'',1,0));
    dot_travelway_CountNonBlank                         := sum(group,if(pFLCrash0.dot_travelway<>'',1,0));
    dot_node_type_CountNonBlank                         := sum(group,if(pFLCrash0.dot_node_type<>'',1,0));
    dot_fixture_type_CountNonBlank                      := sum(group,if(pFLCrash0.dot_fixture_type<>'',1,0));
    dot_side_of_road_CountNonBlank                      := sum(group,if(pFLCrash0.dot_side_of_road<>'',1,0));
    dot_accident_severity_CountNonBlank                 := sum(group,if(pFLCrash0.dot_accident_severity<>'',1,0));
    dot_lane_id_CountNonBlank                           := sum(group,if(pFLCrash0.dot_lane_id<>'',1,0));
    filler3_CountNonBlank                               := sum(group,if(pFLCrash0.filler3<>'',1,0));
    dhsmv_veh_crash_ind_CountNonBlank                   := sum(group,if(pFLCrash0.dhsmv_veh_crash_ind<>'',1,0));
    acc_key_online_update_CountNonBlank                 := sum(group,if(pFLCrash0.acc_key_online_update<>'',1,0));
    form_type_CountNonBlank                             := sum(group,if(pFLCrash0.form_type<>'',1,0));
    update_nbr_CountNonBlank                            := sum(group,if(pFLCrash0.update_nbr<>'',1,0));
    accident_error_CountNonBlank                        := sum(group,if(pFLCrash0.accident_error<>'',1,0));
    filler4_CountNonBlank                               := sum(group,if(pFLCrash0.filler4<>'',1,0));
  end;

// Create the Florida Crash 1 record layout
%rPopulationStats_FLCrash1%
 :=
  record
    CountGroup                                                       := count(group);
    rec_type_1_CountNonBlank                                := sum(group,if(pFLCrash1.rec_type_1<>'',1,0));
    accident_nbr_CountNonBlank                              := sum(group,if(pFLCrash1.accident_nbr<>'',1,0));
    filler1_CountNonBlank                                   := sum(group,if(pFLCrash1.filler1<>'',1,0));
    day_week_CountNonBlank                                  := sum(group,if(pFLCrash1.day_week<>'',1,0));
    hr_accident_CountNonBlank                               := sum(group,if(pFLCrash1.hr_accident<>'',1,0));
    min_accident_CountNonBlank                              := sum(group,if(pFLCrash1.min_accident<>'',1,0));
    hr_off_notified_CountNonBlank                           := sum(group,if(pFLCrash1.hr_off_notified<>'',1,0));
    min_off_notified_CountNonBlank                          := sum(group,if(pFLCrash1.min_off_notified<>'',1,0));
    hr_off_arrived_CountNonBlank                            := sum(group,if(pFLCrash1.hr_off_arrived<>'',1,0));
    min_off_arrived_CountNonBlank                           := sum(group,if(pFLCrash1.min_off_arrived<>'',1,0));
    pFLCrash1.city_nbr;
    pop_code_CountNonBlank                                  := sum(group,if(pFLCrash1.pop_code<>'',1,0));
    rural_urban_code_CountNonBlank                          := sum(group,if(pFLCrash1.rural_urban_code<>'',1,0));
    site_loc_CountNonBlank                                  := sum(group,if(pFLCrash1.site_loc<>'',1,0));
    first_harmful_event_CountNonBlank                       := sum(group,if(pFLCrash1.first_harmful_event<>'',1,0));
    subs_harmful_event_CountNonBlank                        := sum(group,if(pFLCrash1.subs_harmful_event<>'',1,0));
    on_off_roadway_CountNonBlank                            := sum(group,if(pFLCrash1.on_off_roadway<>'',1,0));
    light_condition_CountNonBlank                           := sum(group,if(pFLCrash1.light_condition<>'',1,0));
    weather_CountNonBlank                                   := sum(group,if(pFLCrash1.weather<>'',1,0));
    rd_surface_type_CountNonBlank                           := sum(group,if(pFLCrash1.rd_surface_type<>'',1,0));
    type_shoulder_CountNonBlank                             := sum(group,if(pFLCrash1.type_shoulder<>'',1,0));
    rd_surface_condition_CountNonBlank                      := sum(group,if(pFLCrash1.rd_surface_condition<>'',1,0));
    first_contrib_cause_CountNonBlank                       := sum(group,if(pFLCrash1.first_contrib_cause<>'',1,0));
    second_contrib_cause_CountNonBlank                      := sum(group,if(pFLCrash1.second_contrib_cause<>'',1,0));
    first_contrib_envir_CountNonBlank                       := sum(group,if(pFLCrash1.first_contrib_envir<>'',1,0));
    second_contrib_envir_CountNonBlank                      := sum(group,if(pFLCrash1.second_contrib_envir<>'',1,0));
    first_traffic_control_CountNonBlank                     := sum(group,if(pFLCrash1.first_traffic_control<>'',1,0));
    second_traffic_control_CountNonBlank                    := sum(group,if(pFLCrash1.second_traffic_control<>'',1,0));
    trafficway_char_CountNonBlank                           := sum(group,if(pFLCrash1.trafficway_char<>'',1,0));
    nbr_lanes_CountNonBlank                                 := sum(group,if(pFLCrash1.nbr_lanes<>'',1,0));
    divided_undivided_CountNonBlank                         := sum(group,if(pFLCrash1.divided_undivided<>'',1,0));
    rd_sys_id_CountNonBlank                                 := sum(group,if(pFLCrash1.rd_sys_id<>'',1,0));
    invest_agency_CountNonBlank                             := sum(group,if(pFLCrash1.invest_agency<>'',1,0));
    accident_injury_severity_CountNonBlank                  := sum(group,if(pFLCrash1.accident_injury_severity<>'',1,0));
    accident_damage_severity_CountNonBlank                  := sum(group,if(pFLCrash1.accident_damage_severity<>'',1,0));
    accident_insur_code_CountNonBlank                       := sum(group,if(pFLCrash1.accident_insur_code<>'',1,0));
    accident_fault_code_CountNonBlank                       := sum(group,if(pFLCrash1.accident_fault_code<>'',1,0));
    alcohol_drug_CountNonBlank                              := sum(group,if(pFLCrash1.alcohol_drug<>'',1,0));
    total_tar_damage_CountNonBlank                          := sum(group,if(pFLCrash1.total_tar_damage<>'',1,0));
    total_vehicle_damage_CountNonBlank                      := sum(group,if(pFLCrash1.total_vehicle_damage<>'',1,0));
    total_prop_damage_amt_CountNonBlank                     := sum(group,if(pFLCrash1.total_prop_damage_amt<>'',1,0));
    total_nbr_persons_CountNonBlank                         := sum(group,if(pFLCrash1.total_nbr_persons<>'',1,0));
    total_nbr_drivers_CountNonBlank                         := sum(group,if(pFLCrash1.total_nbr_drivers<>'',1,0));
    total_nbr_vehicles_CountNonBlank                        := sum(group,if(pFLCrash1.total_nbr_vehicles<>'',1,0));
    total_nbr_fatalities_CountNonBlank                      := sum(group,if(pFLCrash1.total_nbr_fatalities<>'',1,0));
    total_nbr_non_traffic_fatal_CountNonBlank               := sum(group,if(pFLCrash1.total_nbr_non_traffic_fatal<>'',1,0));
    total_nbr_injuries_CountNonBlank                        := sum(group,if(pFLCrash1.total_nbr_injuries<>'',1,0));
    total_nbr_pedestrian_CountNonBlank                      := sum(group,if(pFLCrash1.total_nbr_pedestrian<>'',1,0));
    total_nbr_pedalcyclist_CountNonBlank                    := sum(group,if(pFLCrash1.total_nbr_pedalcyclist<>'',1,0));
    invest_agy_rpt_nbr_CountNonBlank                        := sum(group,if(pFLCrash1.invest_agy_rpt_nbr<>'',1,0));
    invest_name_CountNonBlank                               := sum(group,if(pFLCrash1.invest_name<>'',1,0));
    filler2_CountNonBlank                                   := sum(group,if(pFLCrash1.filler2<>'',1,0));
    invest_rank_CountNonBlank                               := sum(group,if(pFLCrash1.invest_rank<>'',1,0));
    invest_id_badge_nbr_CountNonBlank                       := sum(group,if(pFLCrash1.invest_id_badge_nbr<>'',1,0));
    dept_name_CountNonBlank                                 := sum(group,if(pFLCrash1.dept_name<>'',1,0));
    invest_maede_CountNonBlank                              := sum(group,if(pFLCrash1.invest_maede<>'',1,0));
    invest_complete_CountNonBlank                           := sum(group,if(pFLCrash1.invest_complete<>'',1,0));
    report_date_CountNonBlank                               := sum(group,if(pFLCrash1.report_date<>'',1,0));
    photos_taken_CountNonBlank                              := sum(group,if(pFLCrash1.photos_taken<>'',1,0));
    photos_taken_whom_CountNonBlank                         := sum(group,if(pFLCrash1.photos_taken_whom<>'',1,0));
    first_aid_name_CountNonBlank                            := sum(group,if(pFLCrash1.first_aid_name<>'',1,0));
    filler3_CountNonBlank                                   := sum(group,if(pFLCrash1.filler3<>'',1,0));
    first_aid_person_type_CountNonBlank                     := sum(group,if(pFLCrash1.first_aid_person_type<>'',1,0));
    injured_taken_to_CountNonBlank                          := sum(group,if(pFLCrash1.injured_taken_to<>'',1,0));
    injured_taken_by_CountNonBlank                          := sum(group,if(pFLCrash1.injured_taken_by<>'',1,0));
    type_driver_accident_CountNonBlank                      := sum(group,if(pFLCrash1.type_driver_accident<>'',1,0));
    hr_ems_notified_CountNonBlank                           := sum(group,if(pFLCrash1.hr_ems_notified<>'',1,0));
    min_ems_notified_CountNonBlank                          := sum(group,if(pFLCrash1.min_ems_notified<>'',1,0));
    hr_ems_arrived_CountNonBlank                            := sum(group,if(pFLCrash1.hr_ems_arrived<>'',1,0));
    min_ems_arrived_CountNonBlank                           := sum(group,if(pFLCrash1.min_ems_arrived<>'',1,0));
    injured_taken_to_code_CountNonBlank                     := sum(group,if(pFLCrash1.injured_taken_to_code<>'',1,0));
    location_type_CountNonBlank                             := sum(group,if(pFLCrash1.location_type<>'',1,0));
    filler4_CountNonBlank                                   := sum(group,if(pFLCrash1.filler4<>'',1,0));
  end;
  
// Create the Florida Crash 2 record layout
%rPopulationStats_FLCrash2%
 :=
  record
    CountGroup                                                          := count(group);
		UltID_CountNonZero	                         			         := sum(group,if(pFLCrash2.UltID   <> 0   ,1,0));
		OrgID_CountNonZero	                         			         := sum(group,if(pFLCrash2.OrgID   <> 0   ,1,0));
		SeleID_CountNonZero                                        := sum(group,if(pFLCrash2.SeleID  <> 0   ,1,0));
 		ProxID_CountNonZero 	                       		           := sum(group,if(pFLCrash2.ProxID  <> 0   ,1,0));
		POWID_CountNonZero 	                         		           := sum(group,if(pFLCrash2.POWID   <> 0   ,1,0));
		EmpID_CountNonZero 	   											 		           := sum(group,if(pFLCrash2.EmpID   <> 0   ,1,0));
	  DotID_CountNonZero	 												 		           := sum(group,if(pFLCrash2.DotID   <> 0   ,1,0));
		UltScore_CountNonZero 	                     			         := sum(group,if(pFLCrash2.UltScore  <> 0   ,1,0));
    OrgScore_CountNonZero 	                     			         := sum(group,if(pFLCrash2.OrgScore  <> 0   ,1,0));
    SeleScore_CountNonZero 	                     			         := sum(group,if(pFLCrash2.SeleScore <> 0   ,1,0));
	  ProxScore_CountNonZero 	                     			         := sum(group,if(pFLCrash2.ProxScore <> 0   ,1,0));
		POWScore_CountNonZero 	                     	             := sum(group,if(pFLCrash2.POWScore  <> 0   ,1,0));
 		EmpScore_CountNonZero 	 									   		           := sum(group,if(pFLCrash2.EmpScore  <> 0   ,1,0));
		DotScore_CountNonZero 	  									 			         := sum(group,if(pFLCrash2.DotScore  <> 0   ,1,0));
		UltWeight_CountNonZero 	                     		           := sum(group,if(pFLCrash2.UltWeight <> 0   ,1,0));		
		OrgWeight_CountNonZero 	                     		           := sum(group,if(pFLCrash2.OrgWeight <> 0   ,1,0));
		SeleWeight_CountNonZero 	                     		         := sum(group,if(pFLCrash2.SeleWeight <> 0   ,1,0));
		ProxWeight_CountNonZero 	                                 := sum(group,if(pFLCrash2.ProxWeight <> 0   ,1,0));
		POWWeight_CountNonZero 	                     	             := sum(group,if(pFLCrash2.POWWeight  <> 0   ,1,0));
		EmpWeight_CountNonZero 	 				             		           := sum(group,if(pFLCrash2.EmpWeight  <> 0   ,1,0));
    DotWeight_CountNonZero 	 										 		           := sum(group,if(pFLCrash2.DotWeight  <> 0   ,1,0));
    did_CountNonBlank                                          := sum(group,if(pFLCrash2.did<>'',1,0));
    did_score_CountNonZero                                     := sum(group,if(pFLCrash2.did_score<>0,1,0));
    b_did_CountNonBlank                                        := sum(group,if(pFLCrash2.b_did<>'',1,0));
    b_did_score_CountNonZero                                   := sum(group,if(pFLCrash2.b_did_score<>0,1,0));
    rec_type_2_CountNonBlank                                   := sum(group,if(pFLCrash2.rec_type_2<>'',1,0));
    accident_nbr_CountNonBlank                                 := sum(group,if(pFLCrash2.accident_nbr<>'',1,0));
    pFLCrash2.section_nbr;
    filler1_CountNonBlank                                      := sum(group,if(pFLCrash2.filler1<>'',1,0));
    vehicle_owner_driver_code_CountNonBlank                    := sum(group,if(pFLCrash2.vehicle_owner_driver_code<>'',1,0));
    vehicle_driver_action_CountNonBlank                        := sum(group,if(pFLCrash2.vehicle_driver_action<>'',1,0));
    vehicle_year_CountNonBlank                                 := sum(group,if(pFLCrash2.vehicle_year<>'',1,0));
    vehicle_make_CountNonBlank                                 := sum(group,if(pFLCrash2.vehicle_make<>'',1,0));
    vehicle_type_CountNonBlank                                 := sum(group,if(pFLCrash2.vehicle_type<>'',1,0));
    vehicle_tag_nbr_CountNonBlank                              := sum(group,if(pFLCrash2.vehicle_tag_nbr<>'',1,0));
    vehicle_reg_state_CountNonBlank                            := sum(group,if(pFLCrash2.vehicle_reg_state<>'',1,0));
    vehicle_id_nbr_CountNonBlank                               := sum(group,if(pFLCrash2.vehicle_id_nbr<>'',1,0));
    vehicle_travel_on_CountNonBlank                            := sum(group,if(pFLCrash2.vehicle_travel_on<>'',1,0));
    direction_travel_CountNonBlank                             := sum(group,if(pFLCrash2.direction_travel<>'',1,0));
    est_vehicle_speed_CountNonBlank                            := sum(group,if(pFLCrash2.est_vehicle_speed<>'',1,0));
    posted_speed_CountNonBlank                                 := sum(group,if(pFLCrash2.posted_speed<>'',1,0));
    est_vehicle_damage_CountNonBlank                           := sum(group,if(pFLCrash2.est_vehicle_damage<>'',1,0));
    damage_type_CountNonBlank                                  := sum(group,if(pFLCrash2.damage_type<>'',1,0));
    ins_company_name_CountNonBlank                             := sum(group,if(pFLCrash2.ins_company_name<>'',1,0));
    ins_policy_nbr_CountNonBlank                               := sum(group,if(pFLCrash2.ins_policy_nbr<>'',1,0));
    vehicle_removed_by_CountNonBlank                           := sum(group,if(pFLCrash2.vehicle_removed_by<>'',1,0));
    how_removed_code_CountNonBlank                             := sum(group,if(pFLCrash2.how_removed_code<>'',1,0));
    vehicle_owner_name_CountNonBlank                           := sum(group,if(pFLCrash2.vehicle_owner_name<>'',1,0));
    filler2_CountNonBlank                                      := sum(group,if(pFLCrash2.filler2<>'',1,0));
    vehicle_owner_suffix_CountNonBlank                         := sum(group,if(pFLCrash2.vehicle_owner_suffix<>'',1,0));
    vehicle_owner_st_city_CountNonBlank                        := sum(group,if(pFLCrash2.vehicle_owner_st_city<>'',1,0));
    filler3_CountNonBlank                                      := sum(group,if(pFLCrash2.filler3<>'',1,0));
    vehicle_owner_st_CountNonBlank                             := sum(group,if(pFLCrash2.vehicle_owner_st<>'',1,0));
    vehicle_owner_zip_CountNonBlank                            := sum(group,if(pFLCrash2.vehicle_owner_zip<>'',1,0));
    vehicle_owner_forge_asterisk_CountNonBlank                 := sum(group,if(pFLCrash2.vehicle_owner_forge_asterisk<>'',1,0));
    vehicle_owner_dl_nbr_CountNonBlank                         := sum(group,if(pFLCrash2.vehicle_owner_dl_nbr<>'',1,0));
    vehicle_owner_dob_CountNonBlank                            := sum(group,if(pFLCrash2.vehicle_owner_dob<>'',1,0));
    vehicle_owner_sex_CountNonBlank                            := sum(group,if(pFLCrash2.vehicle_owner_sex<>'',1,0));
    vehicle_owner_race_CountNonBlank                           := sum(group,if(pFLCrash2.vehicle_owner_race<>'',1,0));
    point_of_impact_CountNonBlank                              := sum(group,if(pFLCrash2.point_of_impact<>'',1,0));
    vehicle_movement_CountNonBlank                             := sum(group,if(pFLCrash2.vehicle_movement<>'',1,0));
    vehicle_function_CountNonBlank                             := sum(group,if(pFLCrash2.vehicle_function<>'',1,0));
    filler4_CountNonBlank                                      := sum(group,if(pFLCrash2.filler4<>'',1,0));
    vehs_first_defect_CountNonBlank                            := sum(group,if(pFLCrash2.vehs_first_defect<>'',1,0));
    vehs_second_defect_CountNonBlank                           := sum(group,if(pFLCrash2.vehs_second_defect<>'',1,0));
    vehicle_modified_CountNonBlank                             := sum(group,if(pFLCrash2.vehicle_modified<>'',1,0));
    vehicle_roadway_loc_CountNonBlank                          := sum(group,if(pFLCrash2.vehicle_roadway_loc<>'',1,0));
    hazard_material_transport_CountNonBlank                    := sum(group,if(pFLCrash2.hazard_material_transport<>'',1,0));
    total_occu_vehicle_CountNonBlank                           := sum(group,if(pFLCrash2.total_occu_vehicle<>'',1,0));
    total_occu_saf_equip_CountNonBlank                         := sum(group,if(pFLCrash2.total_occu_saf_equip<>'',1,0));
    moving_violation_CountNonBlank                             := sum(group,if(pFLCrash2.moving_violation<>'',1,0));
    vehicle_insur_code_CountNonBlank                           := sum(group,if(pFLCrash2.vehicle_insur_code<>'',1,0));
    vehicle_fault_code_CountNonBlank                           := sum(group,if(pFLCrash2.vehicle_fault_code<>'',1,0));
    vehicle_cap_code_CountNonBlank                             := sum(group,if(pFLCrash2.vehicle_cap_code<>'',1,0));
    vehicle_fr_code_CountNonBlank                              := sum(group,if(pFLCrash2.vehicle_fr_code<>'',1,0));
    vehicle_use_CountNonBlank                                  := sum(group,if(pFLCrash2.vehicle_use<>'',1,0));
    placarded_CountNonBlank                                    := sum(group,if(pFLCrash2.placarded<>'',1,0));
    dhsmv_vehicle_ind_CountNonBlank                            := sum(group,if(pFLCrash2.dhsmv_vehicle_ind<>'',1,0));
    filler5_CountNonBlank                                      := sum(group,if(pFLCrash2.filler5<>'',1,0));
    prim_range_CountNonBlank                                   := sum(group,if(pFLCrash2.prim_range<>'',1,0));
    predir_CountNonBlank                                       := sum(group,if(pFLCrash2.predir<>'',1,0));
    prim_name_CountNonBlank                                    := sum(group,if(pFLCrash2.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                                  := sum(group,if(pFLCrash2.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                      := sum(group,if(pFLCrash2.postdir<>'',1,0));
    unit_desig_CountNonBlank                                   := sum(group,if(pFLCrash2.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                    := sum(group,if(pFLCrash2.sec_range<>'',1,0));
    p_city_name_CountNonBlank                                  := sum(group,if(pFLCrash2.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                                  := sum(group,if(pFLCrash2.v_city_name<>'',1,0));
    st_CountNonBlank                                           := sum(group,if(pFLCrash2.st<>'',1,0));
    zip_CountNonBlank                                          := sum(group,if(pFLCrash2.zip<>'',1,0));
    zip4_CountNonBlank                                         := sum(group,if(pFLCrash2.zip4<>'',1,0));
    cart_CountNonBlank                                         := sum(group,if(pFLCrash2.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                                   := sum(group,if(pFLCrash2.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                          := sum(group,if(pFLCrash2.lot<>'',1,0));
    lot_order_CountNonBlank                                    := sum(group,if(pFLCrash2.lot_order<>'',1,0));
    dpbc_CountNonBlank                                         := sum(group,if(pFLCrash2.dpbc<>'',1,0));
    chk_digit_CountNonBlank                                    := sum(group,if(pFLCrash2.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                     := sum(group,if(pFLCrash2.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                                  := sum(group,if(pFLCrash2.ace_fips_st<>'',1,0));
    county_CountNonBlank                                       := sum(group,if(pFLCrash2.county<>'',1,0));
    geo_lat_CountNonBlank                                      := sum(group,if(pFLCrash2.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                     := sum(group,if(pFLCrash2.geo_long<>'',1,0));
    msa_CountNonBlank                                          := sum(group,if(pFLCrash2.msa<>'',1,0));
    geo_blk_CountNonBlank                                      := sum(group,if(pFLCrash2.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                    := sum(group,if(pFLCrash2.geo_match<>'',1,0));
    err_stat_CountNonBlank                                     := sum(group,if(pFLCrash2.err_stat<>'',1,0));
    title_CountNonBlank                                        := sum(group,if(pFLCrash2.title<>'',1,0));
    fname_CountNonBlank                                        := sum(group,if(pFLCrash2.fname<>'',1,0));
    mname_CountNonBlank                                        := sum(group,if(pFLCrash2.mname<>'',1,0));
    lname_CountNonBlank                                        := sum(group,if(pFLCrash2.lname<>'',1,0));
    suffix_CountNonBlank                                       := sum(group,if(pFLCrash2.suffix<>'',1,0));
    score_CountNonBlank                                        := sum(group,if(pFLCrash2.score<>'',1,0));
    cname_CountNonBlank                                        := sum(group,if(pFLCrash2.cname<>'',1,0));
    blank1_CountNonBlank                                       := sum(group,if(pFLCrash2.blank1<>'',1,0));
    vehicle_seg_CountNonBlank                                  := sum(group,if(pFLCrash2.vehicle_seg<>'',1,0));
    vehicle_seg_type_CountNonBlank                             := sum(group,if(pFLCrash2.vehicle_seg_type<>'',1,0));
    match_code_CountNonBlank                                   := sum(group,if(pFLCrash2.match_code<>'',1,0));
    model_year_CountNonBlank                                   := sum(group,if(pFLCrash2.model_year<>'',1,0));
    blank2_CountNonBlank                                       := sum(group,if(pFLCrash2.blank2<>'',1,0));
    manufacturer_corporation_CountNonBlank                     := sum(group,if(pFLCrash2.manufacturer_corporation<>'',1,0));
    division_code_CountNonBlank                                := sum(group,if(pFLCrash2.division_code<>'',1,0));
    vehicle_group_code_CountNonBlank                           := sum(group,if(pFLCrash2.vehicle_group_code<>'',1,0));
    vehicle_subgroup_code_CountNonBlank                        := sum(group,if(pFLCrash2.vehicle_subgroup_code<>'',1,0));
    vehicle_series_code_CountNonBlank                          := sum(group,if(pFLCrash2.vehicle_series_code<>'',1,0));
    body_style_code_CountNonBlank                              := sum(group,if(pFLCrash2.body_style_code<>'',1,0));
    vehicle_abbreviation_CountNonBlank                         := sum(group,if(pFLCrash2.vehicle_abbreviation<>'',1,0));
    assembly_country_CountNonBlank                             := sum(group,if(pFLCrash2.assembly_country<>'',1,0));
    headquarter_country_CountNonBlank                          := sum(group,if(pFLCrash2.headquarter_country<>'',1,0));
    number_of_doors_CountNonBlank                              := sum(group,if(pFLCrash2.number_of_doors<>'',1,0));
    seating_capacity_CountNonBlank                             := sum(group,if(pFLCrash2.seating_capacity<>'',1,0));
    number_of_cylinders_CountNonBlank                          := sum(group,if(pFLCrash2.number_of_cylinders<>'',1,0));
    engine_size_CountNonBlank                                  := sum(group,if(pFLCrash2.engine_size<>'',1,0));
    fuel_code_CountNonBlank                                    := sum(group,if(pFLCrash2.fuel_code<>'',1,0));
    carburetion_type_CountNonBlank                             := sum(group,if(pFLCrash2.carburetion_type<>'',1,0));
    number_of_barrels_CountNonBlank                            := sum(group,if(pFLCrash2.number_of_barrels<>'',1,0));
    price_class_code_CountNonBlank                             := sum(group,if(pFLCrash2.price_class_code<>'',1,0));
    body_size_code_CountNonBlank                               := sum(group,if(pFLCrash2.body_size_code<>'',1,0));
    number_of_wheels_on_road_CountNonBlank                     := sum(group,if(pFLCrash2.number_of_wheels_on_road<>'',1,0));
    number_of_driving_wheels_CountNonBlank                     := sum(group,if(pFLCrash2.number_of_driving_wheels<>'',1,0));
    drive_type_CountNonBlank                                   := sum(group,if(pFLCrash2.drive_type<>'',1,0));
    steering_type_CountNonBlank                                := sum(group,if(pFLCrash2.steering_type<>'',1,0));
    gvw_code_CountNonBlank                                     := sum(group,if(pFLCrash2.gvw_code<>'',1,0));
    load_capacity_code_CountNonBlank                           := sum(group,if(pFLCrash2.load_capacity_code<>'',1,0));
    cab_type_code_CountNonBlank                                := sum(group,if(pFLCrash2.cab_type_code<>'',1,0));
    bed_length_CountNonBlank                                   := sum(group,if(pFLCrash2.bed_length<>'',1,0));
    rim_size_CountNonBlank                                     := sum(group,if(pFLCrash2.rim_size<>'',1,0));
    manufacture_body_style_CountNonBlank                       := sum(group,if(pFLCrash2.manufacture_body_style<>'',1,0));
    vehicle_type_code_CountNonBlank                            := sum(group,if(pFLCrash2.vehicle_type_code<>'',1,0));
    car_line_code_CountNonBlank                                := sum(group,if(pFLCrash2.car_line_code<>'',1,0));
    car_series_code_CountNonBlank                              := sum(group,if(pFLCrash2.car_series_code<>'',1,0));
    car_body_style_code_CountNonBlank                          := sum(group,if(pFLCrash2.car_body_style_code<>'',1,0));
    engine_cylinder_code_CountNonBlank                         := sum(group,if(pFLCrash2.engine_cylinder_code<>'',1,0));
    truck_make_abbreviation_CountNonBlank                      := sum(group,if(pFLCrash2.truck_make_abbreviation<>'',1,0));
    truck_body_style_abbreviation_CountNonBlank                := sum(group,if(pFLCrash2.truck_body_style_abbreviation<>'',1,0));
    motorcycle_make_abbreviation_CountNonBlank                 := sum(group,if(pFLCrash2.motorcycle_make_abbreviation<>'',1,0));
    vina_series_CountNonBlank                                  := sum(group,if(pFLCrash2.vina_series<>'',1,0));
    vina_model_CountNonBlank                                   := sum(group,if(pFLCrash2.vina_model<>'',1,0));
    reference_number_CountNonBlank                             := sum(group,if(pFLCrash2.reference_number<>'',1,0));
    vina_make_CountNonBlank                                    := sum(group,if(pFLCrash2.vina_make<>'',1,0));
    vina_body_style_CountNonBlank                              := sum(group,if(pFLCrash2.vina_body_style<>'',1,0));
    make_description_CountNonBlank                             := sum(group,if(pFLCrash2.make_description<>'',1,0));
    model_description_CountNonBlank                            := sum(group,if(pFLCrash2.model_description<>'',1,0));
    series_description_CountNonBlank                           := sum(group,if(pFLCrash2.series_description<>'',1,0));
    blank3_CountNonBlank                                       := sum(group,if(pFLCrash2.blank3<>'',1,0));
    car_series_CountNonBlank                                   := sum(group,if(pFLCrash2.car_series<>'',1,0));
    car_body_style_CountNonBlank                               := sum(group,if(pFLCrash2.car_body_style<>'',1,0));
    car_cid_CountNonBlank                                      := sum(group,if(pFLCrash2.car_cid<>'',1,0));
    car_cylinders_CountNonBlank                                := sum(group,if(pFLCrash2.car_cylinders<>'',1,0));
    car_carburetion_CountNonBlank                              := sum(group,if(pFLCrash2.car_carburetion<>'',1,0));
    car_fuel_code_CountNonBlank                                := sum(group,if(pFLCrash2.car_fuel_code<>'',1,0));
    truck_chassis_body_style_CountNonBlank                     := sum(group,if(pFLCrash2.truck_chassis_body_style<>'',1,0));
    truck_wheels_driving_wheels_CountNonBlank                  := sum(group,if(pFLCrash2.truck_wheels_driving_wheels<>'',1,0));
    truck_cid_CountNonBlank                                    := sum(group,if(pFLCrash2.truck_cid<>'',1,0));
    truck_cylinders_CountNonBlank                              := sum(group,if(pFLCrash2.truck_cylinders<>'',1,0));
    truck_fuel_code_CountNonBlank                              := sum(group,if(pFLCrash2.truck_fuel_code<>'',1,0));
    truck_manufacturers_gvw_code_CountNonBlank                 := sum(group,if(pFLCrash2.truck_manufacturers_gvw_code<>'',1,0));
    truck_ton_rating_code_CountNonBlank                        := sum(group,if(pFLCrash2.truck_ton_rating_code<>'',1,0));
    truck_series_CountNonBlank                                 := sum(group,if(pFLCrash2.truck_series<>'',1,0));
    truck_model_CountNonBlank                                  := sum(group,if(pFLCrash2.truck_model<>'',1,0));
    motorcycle_model_CountNonBlank                             := sum(group,if(pFLCrash2.motorcycle_model<>'',1,0));
    motorcycle_engine_displacement_CountNonBlank               := sum(group,if(pFLCrash2.motorcycle_engine_displacement<>'',1,0));
    motorcycle_type_of_bike_CountNonBlank                      := sum(group,if(pFLCrash2.motorcycle_type_of_bike<>'',1,0));
    motorcycle_cylinder_coding_CountNonBlank                   := sum(group,if(pFLCrash2.motorcycle_cylinder_coding<>'',1,0));
  end;

// Create the Florida Crash 3 record layout
%rPopulationStats_FLCrash3%
 :=
  record
    CountGroup                                                            := count(group);
    rec_type_3_CountNonBlank                                     := sum(group,if(pFLCrash3.rec_type_3<>'',1,0));
    accident_nbr_CountNonBlank                                   := sum(group,if(pFLCrash3.accident_nbr<>'',1,0));
    pFLCrash3.section_nbr;
    filler1_CountNonBlank                                        := sum(group,if(pFLCrash3.filler1<>'',1,0));
    towed_trlr_veh_yr_CountNonBlank                              := sum(group,if(pFLCrash3.towed_trlr_veh_yr<>'',1,0));
    towed_trlr_make_CountNonBlank                                := sum(group,if(pFLCrash3.towed_trlr_make<>'',1,0));
    towed_trailer_type_CountNonBlank                             := sum(group,if(pFLCrash3.towed_trailer_type<>'',1,0));
    towed_trlr_veh_tag_nbr_CountNonBlank                         := sum(group,if(pFLCrash3.towed_trlr_veh_tag_nbr<>'',1,0));
    towed_trlr_veh_state_CountNonBlank                           := sum(group,if(pFLCrash3.towed_trlr_veh_state<>'',1,0));
    towed_trlr_veh_id_nbr_CountNonBlank                          := sum(group,if(pFLCrash3.towed_trlr_veh_id_nbr<>'',1,0));
    towed_trlr_veh_est_damage_CountNonBlank                      := sum(group,if(pFLCrash3.towed_trlr_veh_est_damage<>'',1,0));
    towed_trlr_veh_owner_name_CountNonBlank                      := sum(group,if(pFLCrash3.towed_trlr_veh_owner_name<>'',1,0));
    filler2_CountNonBlank                                        := sum(group,if(pFLCrash3.filler2<>'',1,0));
    towed_trlr_veh_owner_name_suffix_CountNonBlank               := sum(group,if(pFLCrash3.towed_trlr_veh_owner_name_suffix<>'',1,0));
    towed_trlr_veh_owner_st_city_CountNonBlank                   := sum(group,if(pFLCrash3.towed_trlr_veh_owner_st_city<>'',1,0));
    filler3_CountNonBlank                                        := sum(group,if(pFLCrash3.filler3<>'',1,0));
    towed_trlr_veh_owner_st_CountNonBlank                        := sum(group,if(pFLCrash3.towed_trlr_veh_owner_st<>'',1,0));
    towed_trlr_veh_owner_zip_CountNonBlank                       := sum(group,if(pFLCrash3.towed_trlr_veh_owner_zip<>'',1,0));
    towed_trlr_fr_cap_code_CountNonBlank                         := sum(group,if(pFLCrash3.towed_trlr_fr_cap_code<>'',1,0));
    filler4_CountNonBlank                                        := sum(group,if(pFLCrash3.filler4<>'',1,0));
    blank1_CountNonBlank                                         := sum(group,if(pFLCrash3.blank1<>'',1,0));
    vehicle_seg_CountNonBlank                                    := sum(group,if(pFLCrash3.vehicle_seg<>'',1,0));
    vehicle_seg_type_CountNonBlank                               := sum(group,if(pFLCrash3.vehicle_seg_type<>'',1,0));
    match_code_CountNonBlank                                     := sum(group,if(pFLCrash3.match_code<>'',1,0));
    model_year_CountNonBlank                                     := sum(group,if(pFLCrash3.model_year<>'',1,0));
    blank2_CountNonBlank                                         := sum(group,if(pFLCrash3.blank2<>'',1,0));
    manufacturer_corporation_CountNonBlank                       := sum(group,if(pFLCrash3.manufacturer_corporation<>'',1,0));
    division_code_CountNonBlank                                  := sum(group,if(pFLCrash3.division_code<>'',1,0));
    vehicle_group_code_CountNonBlank                             := sum(group,if(pFLCrash3.vehicle_group_code<>'',1,0));
    vehicle_subgroup_code_CountNonBlank                          := sum(group,if(pFLCrash3.vehicle_subgroup_code<>'',1,0));
    vehicle_series_code_CountNonBlank                            := sum(group,if(pFLCrash3.vehicle_series_code<>'',1,0));
    body_style_code_CountNonBlank                                := sum(group,if(pFLCrash3.body_style_code<>'',1,0));
    vehicle_abbreviation_CountNonBlank                           := sum(group,if(pFLCrash3.vehicle_abbreviation<>'',1,0));
    assembly_country_CountNonBlank                               := sum(group,if(pFLCrash3.assembly_country<>'',1,0));
    headquarter_country_CountNonBlank                            := sum(group,if(pFLCrash3.headquarter_country<>'',1,0));
    number_of_doors_CountNonBlank                                := sum(group,if(pFLCrash3.number_of_doors<>'',1,0));
    seating_capacity_CountNonBlank                               := sum(group,if(pFLCrash3.seating_capacity<>'',1,0));
    number_of_cylinders_CountNonBlank                            := sum(group,if(pFLCrash3.number_of_cylinders<>'',1,0));
    engine_size_CountNonBlank                                    := sum(group,if(pFLCrash3.engine_size<>'',1,0));
    fuel_code_CountNonBlank                                      := sum(group,if(pFLCrash3.fuel_code<>'',1,0));
    carburetion_type_CountNonBlank                               := sum(group,if(pFLCrash3.carburetion_type<>'',1,0));
    number_of_barrels_CountNonBlank                              := sum(group,if(pFLCrash3.number_of_barrels<>'',1,0));
    price_class_code_CountNonBlank                               := sum(group,if(pFLCrash3.price_class_code<>'',1,0));
    body_size_code_CountNonBlank                                 := sum(group,if(pFLCrash3.body_size_code<>'',1,0));
    number_of_wheels_on_road_CountNonBlank                       := sum(group,if(pFLCrash3.number_of_wheels_on_road<>'',1,0));
    number_of_driving_wheels_CountNonBlank                       := sum(group,if(pFLCrash3.number_of_driving_wheels<>'',1,0));
    drive_type_CountNonBlank                                     := sum(group,if(pFLCrash3.drive_type<>'',1,0));
    steering_type_CountNonBlank                                  := sum(group,if(pFLCrash3.steering_type<>'',1,0));
    gvw_code_CountNonBlank                                       := sum(group,if(pFLCrash3.gvw_code<>'',1,0));
    load_capacity_code_CountNonBlank                             := sum(group,if(pFLCrash3.load_capacity_code<>'',1,0));
    cab_type_code_CountNonBlank                                  := sum(group,if(pFLCrash3.cab_type_code<>'',1,0));
    bed_length_CountNonBlank                                     := sum(group,if(pFLCrash3.bed_length<>'',1,0));
    rim_size_CountNonBlank                                       := sum(group,if(pFLCrash3.rim_size<>'',1,0));
    manufacture_body_style_CountNonBlank                         := sum(group,if(pFLCrash3.manufacture_body_style<>'',1,0));
    vehicle_type_code_CountNonBlank                              := sum(group,if(pFLCrash3.vehicle_type_code<>'',1,0));
    car_line_code_CountNonBlank                                  := sum(group,if(pFLCrash3.car_line_code<>'',1,0));
    car_series_code_CountNonBlank                                := sum(group,if(pFLCrash3.car_series_code<>'',1,0));
    car_body_style_code_CountNonBlank                            := sum(group,if(pFLCrash3.car_body_style_code<>'',1,0));
    engine_cylinder_code_CountNonBlank                           := sum(group,if(pFLCrash3.engine_cylinder_code<>'',1,0));
    truck_make_abbreviation_CountNonBlank                        := sum(group,if(pFLCrash3.truck_make_abbreviation<>'',1,0));
    truck_body_style_abbreviation_CountNonBlank                  := sum(group,if(pFLCrash3.truck_body_style_abbreviation<>'',1,0));
    motorcycle_make_abbreviation_CountNonBlank                   := sum(group,if(pFLCrash3.motorcycle_make_abbreviation<>'',1,0));
    vina_series_CountNonBlank                                    := sum(group,if(pFLCrash3.vina_series<>'',1,0));
    vina_model_CountNonBlank                                     := sum(group,if(pFLCrash3.vina_model<>'',1,0));
    reference_number_CountNonBlank                               := sum(group,if(pFLCrash3.reference_number<>'',1,0));
    vina_make_CountNonBlank                                      := sum(group,if(pFLCrash3.vina_make<>'',1,0));
    vina_body_style_CountNonBlank                                := sum(group,if(pFLCrash3.vina_body_style<>'',1,0));
    make_description_CountNonBlank                               := sum(group,if(pFLCrash3.make_description<>'',1,0));
    model_description_CountNonBlank                              := sum(group,if(pFLCrash3.model_description<>'',1,0));
    series_description_CountNonBlank                             := sum(group,if(pFLCrash3.series_description<>'',1,0));
    blank3_CountNonBlank                                         := sum(group,if(pFLCrash3.blank3<>'',1,0));
    car_series_CountNonBlank                                     := sum(group,if(pFLCrash3.car_series<>'',1,0));
    car_body_style_CountNonBlank                                 := sum(group,if(pFLCrash3.car_body_style<>'',1,0));
    car_cid_CountNonBlank                                        := sum(group,if(pFLCrash3.car_cid<>'',1,0));
    car_cylinders_CountNonBlank                                  := sum(group,if(pFLCrash3.car_cylinders<>'',1,0));
    car_carburetion_CountNonBlank                                := sum(group,if(pFLCrash3.car_carburetion<>'',1,0));
    car_fuel_code_CountNonBlank                                  := sum(group,if(pFLCrash3.car_fuel_code<>'',1,0));
    truck_chassis_body_style_CountNonBlank                       := sum(group,if(pFLCrash3.truck_chassis_body_style<>'',1,0));
    truck_wheels_driving_wheels_CountNonBlank                    := sum(group,if(pFLCrash3.truck_wheels_driving_wheels<>'',1,0));
    truck_cid_CountNonBlank                                      := sum(group,if(pFLCrash3.truck_cid<>'',1,0));
    truck_cylinders_CountNonBlank                                := sum(group,if(pFLCrash3.truck_cylinders<>'',1,0));
    truck_fuel_code_CountNonBlank                                := sum(group,if(pFLCrash3.truck_fuel_code<>'',1,0));
    truck_manufacturers_gvw_code_CountNonBlank                   := sum(group,if(pFLCrash3.truck_manufacturers_gvw_code<>'',1,0));
    truck_ton_rating_code_CountNonBlank                          := sum(group,if(pFLCrash3.truck_ton_rating_code<>'',1,0));
    truck_series_CountNonBlank                                   := sum(group,if(pFLCrash3.truck_series<>'',1,0));
    truck_model_CountNonBlank                                    := sum(group,if(pFLCrash3.truck_model<>'',1,0));
    motorcycle_model_CountNonBlank                               := sum(group,if(pFLCrash3.motorcycle_model<>'',1,0));
    motorcycle_engine_displacement_CountNonBlank                 := sum(group,if(pFLCrash3.motorcycle_engine_displacement<>'',1,0));
    motorcycle_type_of_bike_CountNonBlank                        := sum(group,if(pFLCrash3.motorcycle_type_of_bike<>'',1,0));
    motorcycle_cylinder_coding_CountNonBlank                     := sum(group,if(pFLCrash3.motorcycle_cylinder_coding<>'',1,0));
  end;

// Create the Florida Crash 4 record layout
%rPopulationStats_FLCrash4%
 :=
  record
    CountGroup                                                       := count(group);
    did_CountNonBlank                                       := sum(group,if(pFLCrash4.did<>'',1,0));
    did_score_CountNonZero                                  := sum(group,if(pFLCrash4.did_score<>0,1,0));
    rec_type_4_CountNonBlank                                := sum(group,if(pFLCrash4.rec_type_4<>'',1,0));
    accident_nbr_CountNonBlank                              := sum(group,if(pFLCrash4.accident_nbr<>'',1,0));
    pFLCrash4.section_nbr;
    filler1_CountNonBlank                                   := sum(group,if(pFLCrash4.filler1<>'',1,0));
    driver_full_name_CountNonBlank                          := sum(group,if(pFLCrash4.driver_full_name<>'',1,0));
    filler2_CountNonBlank                                   := sum(group,if(pFLCrash4.filler2<>'',1,0));
    driver_name_suffix_CountNonBlank                        := sum(group,if(pFLCrash4.driver_name_suffix<>'',1,0));
    driver_st_city_CountNonBlank                            := sum(group,if(pFLCrash4.driver_st_city<>'',1,0));
    filler3_CountNonBlank                                   := sum(group,if(pFLCrash4.filler3<>'',1,0));
    driver_resident_state_CountNonBlank                     := sum(group,if(pFLCrash4.driver_resident_state<>'',1,0));
    driver_zip_CountNonBlank                                := sum(group,if(pFLCrash4.driver_zip<>'',1,0));
    driver_dob_CountNonBlank                                := sum(group,if(pFLCrash4.driver_dob<>'',1,0));
    driver_dl_force_asterisk_CountNonBlank                  := sum(group,if(pFLCrash4.driver_dl_force_asterisk<>'',1,0));
    driver_dl_nbr_CountNonBlank                             := sum(group,if(pFLCrash4.driver_dl_nbr<>'',1,0));
    driver_lic_st_CountNonBlank                             := sum(group,if(pFLCrash4.driver_lic_st<>'',1,0));
    driver_lic_type_CountNonBlank                           := sum(group,if(pFLCrash4.driver_lic_type<>'',1,0));
    driver_bac_test_type_CountNonBlank                      := sum(group,if(pFLCrash4.driver_bac_test_type<>'',1,0));
    driver_bac_force_code_CountNonBlank                     := sum(group,if(pFLCrash4.driver_bac_force_code<>'',1,0));
    driver_bac_test_results_CountNonBlank                   := sum(group,if(pFLCrash4.driver_bac_test_results<>'',1,0));
    filler4_CountNonBlank                                   := sum(group,if(pFLCrash4.filler4<>'',1,0));
    driver_alco_drug_code_CountNonBlank                     := sum(group,if(pFLCrash4.driver_alco_drug_code<>'',1,0));
    driver_physical_defects_CountNonBlank                   := sum(group,if(pFLCrash4.driver_physical_defects<>'',1,0));
    driver_residence_CountNonBlank                          := sum(group,if(pFLCrash4.driver_residence<>'',1,0));
    driver_race_CountNonBlank                               := sum(group,if(pFLCrash4.driver_race<>'',1,0));
    driver_sex_CountNonBlank                                := sum(group,if(pFLCrash4.driver_sex<>'',1,0));
    driver_injury_severity_CountNonBlank                    := sum(group,if(pFLCrash4.driver_injury_severity<>'',1,0));
    first_driver_safety_CountNonBlank                       := sum(group,if(pFLCrash4.first_driver_safety<>'',1,0));
    second_driver_safety_CountNonBlank                      := sum(group,if(pFLCrash4.second_driver_safety<>'',1,0));
    driver_eject_code_CountNonBlank                         := sum(group,if(pFLCrash4.driver_eject_code<>'',1,0));
    recommand_reexam_CountNonBlank                          := sum(group,if(pFLCrash4.recommand_reexam<>'',1,0));
    driver_phone_nbr_CountNonBlank                          := sum(group,if(pFLCrash4.driver_phone_nbr<>'',1,0));
    first_contrib_cause_CountNonBlank                       := sum(group,if(pFLCrash4.first_contrib_cause<>'',1,0));
    second_contrib_cause_CountNonBlank                      := sum(group,if(pFLCrash4.second_contrib_cause<>'',1,0));
    third_contrib_cause_CountNonBlank                       := sum(group,if(pFLCrash4.third_contrib_cause<>'',1,0));
    first_offense_charged_CountNonBlank                     := sum(group,if(pFLCrash4.first_offense_charged<>'',1,0));
    first_frdl_sys_charge_code_CountNonBlank                := sum(group,if(pFLCrash4.first_frdl_sys_charge_code<>'',1,0));
    second_offense_charged_CountNonBlank                    := sum(group,if(pFLCrash4.second_offense_charged<>'',1,0));
    second_frdl_sys_charge_code_CountNonBlank               := sum(group,if(pFLCrash4.second_frdl_sys_charge_code<>'',1,0));
    third_offense_charged_CountNonBlank                     := sum(group,if(pFLCrash4.third_offense_charged<>'',1,0));
    third_frdl_sys_charge_code_CountNonBlank                := sum(group,if(pFLCrash4.third_frdl_sys_charge_code<>'',1,0));
    first_citation_nbr_CountNonBlank                        := sum(group,if(pFLCrash4.first_citation_nbr<>'',1,0));
    second_citation_nbr_CountNonBlank                       := sum(group,if(pFLCrash4.second_citation_nbr<>'',1,0));
    third_citation_nbr_CountNonBlank                        := sum(group,if(pFLCrash4.third_citation_nbr<>'',1,0));
    driver_fr_injury_cap_code_CountNonBlank                 := sum(group,if(pFLCrash4.driver_fr_injury_cap_code<>'',1,0));
    dl_nbr_good_bad_CountNonBlank                           := sum(group,if(pFLCrash4.dl_nbr_good_bad<>'',1,0));
    fourth_offense_charged_CountNonBlank                    := sum(group,if(pFLCrash4.fourth_offense_charged<>'',1,0));
    fourth_frdl_sys_charge_code_CountNonBlank               := sum(group,if(pFLCrash4.fourth_frdl_sys_charge_code<>'',1,0));
    fifth_offense_charged_CountNonBlank                     := sum(group,if(pFLCrash4.fifth_offense_charged<>'',1,0));
    fifth_frdl_sys_charge_code_CountNonBlank                := sum(group,if(pFLCrash4.fifth_frdl_sys_charge_code<>'',1,0));
    sixth_offense_charged_CountNonBlank                     := sum(group,if(pFLCrash4.sixth_offense_charged<>'',1,0));
    sixth_frdl_sys_charge_code_CountNonBlank                := sum(group,if(pFLCrash4.sixth_frdl_sys_charge_code<>'',1,0));
    seveth_offense_charged_CountNonBlank                    := sum(group,if(pFLCrash4.seveth_offense_charged<>'',1,0));
    seveth_frdl_sys_charge_code_CountNonBlank               := sum(group,if(pFLCrash4.seveth_frdl_sys_charge_code<>'',1,0));
    eighth_offense_charged_CountNonBlank                    := sum(group,if(pFLCrash4.eighth_offense_charged<>'',1,0));
    eighth_frdl_sys_charge_code_CountNonBlank               := sum(group,if(pFLCrash4.eighth_frdl_sys_charge_code<>'',1,0));
    fourth_citation_nbr_CountNonBlank                       := sum(group,if(pFLCrash4.fourth_citation_nbr<>'',1,0));
    fifth_citation_nbr_CountNonBlank                        := sum(group,if(pFLCrash4.fifth_citation_nbr<>'',1,0));
    sixth_citation_nbr_CountNonBlank                        := sum(group,if(pFLCrash4.sixth_citation_nbr<>'',1,0));
    seventh_citation_nbr_CountNonBlank                      := sum(group,if(pFLCrash4.seventh_citation_nbr<>'',1,0));
    eighth_citation_nbr_CountNonBlank                       := sum(group,if(pFLCrash4.eighth_citation_nbr<>'',1,0));
    req_endorsement_CountNonBlank                           := sum(group,if(pFLCrash4.req_endorsement<>'',1,0));
    oos_dl_nbr_CountNonBlank                                := sum(group,if(pFLCrash4.oos_dl_nbr<>'',1,0));
    filler5_CountNonBlank                                   := sum(group,if(pFLCrash4.filler5<>'',1,0));
    prim_range_CountNonBlank                                := sum(group,if(pFLCrash4.prim_range<>'',1,0));
    predir_CountNonBlank                                    := sum(group,if(pFLCrash4.predir<>'',1,0));
    prim_name_CountNonBlank                                 := sum(group,if(pFLCrash4.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                               := sum(group,if(pFLCrash4.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                   := sum(group,if(pFLCrash4.postdir<>'',1,0));
    unit_desig_CountNonBlank                                := sum(group,if(pFLCrash4.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                 := sum(group,if(pFLCrash4.sec_range<>'',1,0));
    p_city_name_CountNonBlank                               := sum(group,if(pFLCrash4.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                               := sum(group,if(pFLCrash4.v_city_name<>'',1,0));
    st_CountNonBlank                                        := sum(group,if(pFLCrash4.st<>'',1,0));
    zip_CountNonBlank                                       := sum(group,if(pFLCrash4.zip<>'',1,0));
    zip4_CountNonBlank                                      := sum(group,if(pFLCrash4.zip4<>'',1,0));
    cart_CountNonBlank                                      := sum(group,if(pFLCrash4.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                                := sum(group,if(pFLCrash4.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                       := sum(group,if(pFLCrash4.lot<>'',1,0));
    lot_order_CountNonBlank                                 := sum(group,if(pFLCrash4.lot_order<>'',1,0));
    dpbc_CountNonBlank                                      := sum(group,if(pFLCrash4.dpbc<>'',1,0));
    chk_digit_CountNonBlank                                 := sum(group,if(pFLCrash4.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                  := sum(group,if(pFLCrash4.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                               := sum(group,if(pFLCrash4.ace_fips_st<>'',1,0));
    county_CountNonBlank                                    := sum(group,if(pFLCrash4.county<>'',1,0));
    geo_lat_CountNonBlank                                   := sum(group,if(pFLCrash4.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                  := sum(group,if(pFLCrash4.geo_long<>'',1,0));
    msa_CountNonBlank                                       := sum(group,if(pFLCrash4.msa<>'',1,0));
    geo_blk_CountNonBlank                                   := sum(group,if(pFLCrash4.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                 := sum(group,if(pFLCrash4.geo_match<>'',1,0));
    err_stat_CountNonBlank                                  := sum(group,if(pFLCrash4.err_stat<>'',1,0));
    title_CountNonBlank                                     := sum(group,if(pFLCrash4.title<>'',1,0));
    fname_CountNonBlank                                     := sum(group,if(pFLCrash4.fname<>'',1,0));
    mname_CountNonBlank                                     := sum(group,if(pFLCrash4.mname<>'',1,0));
    lname_CountNonBlank                                     := sum(group,if(pFLCrash4.lname<>'',1,0));
    suffix_CountNonBlank                                    := sum(group,if(pFLCrash4.suffix<>'',1,0));
    score_CountNonBlank                                     := sum(group,if(pFLCrash4.score<>'',1,0));
    cname_CountNonBlank                                     := sum(group,if(pFLCrash4.cname<>'',1,0));
  end;

// Create the Florida Crash 5 record layout
%rPopulationStats_FLCrash5%
 :=
  record
    CountGroup                                                 := count(group);
    did_CountNonBlank                                 := sum(group,if(pFLCrash5.did<>'',1,0));
    did_score_CountNonZero                            := sum(group,if(pFLCrash5.did_score<>0,1,0));
    rec_type_5_CountNonBlank                          := sum(group,if(pFLCrash5.rec_type_5<>'',1,0));
    accident_nbr_CountNonBlank                        := sum(group,if(pFLCrash5.accident_nbr<>'',1,0));
    pFLCrash5.section_nbr;
    passenger_nbr_CountNonBlank                       := sum(group,if(pFLCrash5.passenger_nbr<>'',1,0));
    passenger_full_name_CountNonBlank                 := sum(group,if(pFLCrash5.passenger_full_name<>'',1,0));
    filler1_CountNonBlank                             := sum(group,if(pFLCrash5.filler1<>'',1,0));
    passenger_name_suffix_CountNonBlank               := sum(group,if(pFLCrash5.passenger_name_suffix<>'',1,0));
    passenger_st_city_CountNonBlank                   := sum(group,if(pFLCrash5.passenger_st_city<>'',1,0));
    filler2_CountNonBlank                             := sum(group,if(pFLCrash5.filler2<>'',1,0));
    passenger_state_CountNonBlank                     := sum(group,if(pFLCrash5.passenger_state<>'',1,0));
    passenger_zip_CountNonBlank                       := sum(group,if(pFLCrash5.passenger_zip<>'',1,0));
    passenger_age_CountNonBlank                       := sum(group,if(pFLCrash5.passenger_age<>'',1,0));
    passenger_location_CountNonBlank                  := sum(group,if(pFLCrash5.passenger_location<>'',1,0));
    passenger_injury_sev_CountNonBlank                := sum(group,if(pFLCrash5.passenger_injury_sev<>'',1,0));
    first_passenger_safe_CountNonBlank                := sum(group,if(pFLCrash5.first_passenger_safe<>'',1,0));
    second_passenger_safe_CountNonBlank               := sum(group,if(pFLCrash5.second_passenger_safe<>'',1,0));
    passenger_eject_code_CountNonBlank                := sum(group,if(pFLCrash5.passenger_eject_code<>'',1,0));
    passenger_fr_cap_code_CountNonBlank               := sum(group,if(pFLCrash5.passenger_fr_cap_code<>'',1,0));
    filler3_CountNonBlank                             := sum(group,if(pFLCrash5.filler3<>'',1,0));
    prim_range_CountNonBlank                          := sum(group,if(pFLCrash5.prim_range<>'',1,0));
    predir_CountNonBlank                              := sum(group,if(pFLCrash5.predir<>'',1,0));
    prim_name_CountNonBlank                           := sum(group,if(pFLCrash5.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                         := sum(group,if(pFLCrash5.addr_suffix<>'',1,0));
    postdir_CountNonBlank                             := sum(group,if(pFLCrash5.postdir<>'',1,0));
    unit_desig_CountNonBlank                          := sum(group,if(pFLCrash5.unit_desig<>'',1,0));
    sec_range_CountNonBlank                           := sum(group,if(pFLCrash5.sec_range<>'',1,0));
    p_city_name_CountNonBlank                         := sum(group,if(pFLCrash5.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                         := sum(group,if(pFLCrash5.v_city_name<>'',1,0));
    st_CountNonBlank                                  := sum(group,if(pFLCrash5.st<>'',1,0));
    zip_CountNonBlank                                 := sum(group,if(pFLCrash5.zip<>'',1,0));
    zip4_CountNonBlank                                := sum(group,if(pFLCrash5.zip4<>'',1,0));
    cart_CountNonBlank                                := sum(group,if(pFLCrash5.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                          := sum(group,if(pFLCrash5.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                 := sum(group,if(pFLCrash5.lot<>'',1,0));
    lot_order_CountNonBlank                           := sum(group,if(pFLCrash5.lot_order<>'',1,0));
    dpbc_CountNonBlank                                := sum(group,if(pFLCrash5.dpbc<>'',1,0));
    chk_digit_CountNonBlank                           := sum(group,if(pFLCrash5.chk_digit<>'',1,0));
    rec_type_CountNonBlank                            := sum(group,if(pFLCrash5.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                         := sum(group,if(pFLCrash5.ace_fips_st<>'',1,0));
    county_CountNonBlank                              := sum(group,if(pFLCrash5.county<>'',1,0));
    geo_lat_CountNonBlank                             := sum(group,if(pFLCrash5.geo_lat<>'',1,0));
    geo_long_CountNonBlank                            := sum(group,if(pFLCrash5.geo_long<>'',1,0));
    msa_CountNonBlank                                 := sum(group,if(pFLCrash5.msa<>'',1,0));
    geo_blk_CountNonBlank                             := sum(group,if(pFLCrash5.geo_blk<>'',1,0));
    geo_match_CountNonBlank                           := sum(group,if(pFLCrash5.geo_match<>'',1,0));
    err_stat_CountNonBlank                            := sum(group,if(pFLCrash5.err_stat<>'',1,0));
    title_CountNonBlank                               := sum(group,if(pFLCrash5.title<>'',1,0));
    fname_CountNonBlank                               := sum(group,if(pFLCrash5.fname<>'',1,0));
    mname_CountNonBlank                               := sum(group,if(pFLCrash5.mname<>'',1,0));
    lname_CountNonBlank                               := sum(group,if(pFLCrash5.lname<>'',1,0));
    suffix_CountNonBlank                              := sum(group,if(pFLCrash5.suffix<>'',1,0));
    score_CountNonBlank                               := sum(group,if(pFLCrash5.score<>'',1,0));
    cname_CountNonBlank                               := sum(group,if(pFLCrash5.cname<>'',1,0));
  end;

// Create the Florida Crash 6 record layout
%rPopulationStats_FLCrash6%
 :=
  record
    CountGroup                                                       := count(group);
    did_CountNonBlank                                       := sum(group,if(pFLCrash6.did<>'',1,0));
    did_score_CountNonZero                                  := sum(group,if(pFLCrash6.did_score<>0,1,0));
    rec_type_6_CountNonBlank                                := sum(group,if(pFLCrash6.rec_type_6<>'',1,0));
    accident_nbr_CountNonBlank                              := sum(group,if(pFLCrash6.accident_nbr<>'',1,0));
    pFLCrash6.section_nbr;
    filler1_CountNonBlank                                   := sum(group,if(pFLCrash6.filler1<>'',1,0));
    pedest_full_name_CountNonBlank                          := sum(group,if(pFLCrash6.pedest_full_name<>'',1,0));
    filler2_CountNonBlank                                   := sum(group,if(pFLCrash6.filler2<>'',1,0));
    ped_name_suffix_CountNonBlank                           := sum(group,if(pFLCrash6.ped_name_suffix<>'',1,0));
    ped_st_city_CountNonBlank                               := sum(group,if(pFLCrash6.ped_st_city<>'',1,0));
    filler3_CountNonBlank                                   := sum(group,if(pFLCrash6.filler3<>'',1,0));
    ped_state_CountNonBlank                                 := sum(group,if(pFLCrash6.ped_state<>'',1,0));
    ped_zip_CountNonBlank                                   := sum(group,if(pFLCrash6.ped_zip<>'',1,0));
    ded_dob_CountNonBlank                                   := sum(group,if(pFLCrash6.ded_dob<>'',1,0));
    ped_bac_test_type_CountNonBlank                         := sum(group,if(pFLCrash6.ped_bac_test_type<>'',1,0));
    ped_bac_force_code_CountNonBlank                        := sum(group,if(pFLCrash6.ped_bac_force_code<>'',1,0));
    ped_bac_results_CountNonBlank                           := sum(group,if(pFLCrash6.ped_bac_results<>'',1,0));
    filler4_CountNonBlank                                   := sum(group,if(pFLCrash6.filler4<>'',1,0));
    ped_alco_drugs_CountNonBlank                            := sum(group,if(pFLCrash6.ped_alco_drugs<>'',1,0));
    ped_physical_defect_CountNonBlank                       := sum(group,if(pFLCrash6.ped_physical_defect<>'',1,0));
    ped_residence_CountNonBlank                             := sum(group,if(pFLCrash6.ped_residence<>'',1,0));
    ped_race_CountNonBlank                                  := sum(group,if(pFLCrash6.ped_race<>'',1,0));
    ped_sex_CountNonBlank                                   := sum(group,if(pFLCrash6.ped_sex<>'',1,0));
    ped_injury_sev_CountNonBlank                            := sum(group,if(pFLCrash6.ped_injury_sev<>'',1,0));
    ped_first_contrib_cause_CountNonBlank                   := sum(group,if(pFLCrash6.ped_first_contrib_cause<>'',1,0));
    ped_second_contrib_cause_CountNonBlank                  := sum(group,if(pFLCrash6.ped_second_contrib_cause<>'',1,0));
    ped_third_contrib_cause_CountNonBlank                   := sum(group,if(pFLCrash6.ped_third_contrib_cause<>'',1,0));
    ped_action_CountNonBlank                                := sum(group,if(pFLCrash6.ped_action<>'',1,0));
    first_offense_charged_CountNonBlank                     := sum(group,if(pFLCrash6.first_offense_charged<>'',1,0));
    first_frdl_sys_charge_code_CountNonBlank                := sum(group,if(pFLCrash6.first_frdl_sys_charge_code<>'',1,0));
    second_offense_charged_CountNonBlank                    := sum(group,if(pFLCrash6.second_offense_charged<>'',1,0));
    second_frdl_sys_charge_code_CountNonBlank               := sum(group,if(pFLCrash6.second_frdl_sys_charge_code<>'',1,0));
    third_offense_charged_CountNonBlank                     := sum(group,if(pFLCrash6.third_offense_charged<>'',1,0));
    third_frdl_sys_charge_code_CountNonBlank                := sum(group,if(pFLCrash6.third_frdl_sys_charge_code<>'',1,0));
    first_citation_nbr_CountNonBlank                        := sum(group,if(pFLCrash6.first_citation_nbr<>'',1,0));
    second_citation_nbr_CountNonBlank                       := sum(group,if(pFLCrash6.second_citation_nbr<>'',1,0));
    third_citation_nbr_CountNonBlank                        := sum(group,if(pFLCrash6.third_citation_nbr<>'',1,0));
    ped_fr_injury_cap_CountNonBlank                         := sum(group,if(pFLCrash6.ped_fr_injury_cap<>'',1,0));
    fourth_offense_charged_CountNonBlank                    := sum(group,if(pFLCrash6.fourth_offense_charged<>'',1,0));
    fourth_frdl_sys_charge_code_CountNonBlank               := sum(group,if(pFLCrash6.fourth_frdl_sys_charge_code<>'',1,0));
    fifth_offense_charged_CountNonBlank                     := sum(group,if(pFLCrash6.fifth_offense_charged<>'',1,0));
    fifth_frdl_sys_charge_code_CountNonBlank                := sum(group,if(pFLCrash6.fifth_frdl_sys_charge_code<>'',1,0));
    sixth_offense_charged_CountNonBlank                     := sum(group,if(pFLCrash6.sixth_offense_charged<>'',1,0));
    sixth_sys_charge_code_CountNonBlank                     := sum(group,if(pFLCrash6.sixth_sys_charge_code<>'',1,0));
    seventh_offense_charged_CountNonBlank                   := sum(group,if(pFLCrash6.seventh_offense_charged<>'',1,0));
    seventh_sys_charge_code_CountNonBlank                   := sum(group,if(pFLCrash6.seventh_sys_charge_code<>'',1,0));
    eighth_offense_charged_CountNonBlank                    := sum(group,if(pFLCrash6.eighth_offense_charged<>'',1,0));
    eighth_sys_charge_code_CountNonBlank                    := sum(group,if(pFLCrash6.eighth_sys_charge_code<>'',1,0));
    fourth_citation_issued_CountNonBlank                    := sum(group,if(pFLCrash6.fourth_citation_issued<>'',1,0));
    fifth_citation_issued_CountNonBlank                     := sum(group,if(pFLCrash6.fifth_citation_issued<>'',1,0));
    sixth_citation_issued_CountNonBlank                     := sum(group,if(pFLCrash6.sixth_citation_issued<>'',1,0));
    seventh_citation_issued_CountNonBlank                   := sum(group,if(pFLCrash6.seventh_citation_issued<>'',1,0));
    eighth_citation_issued_CountNonBlank                    := sum(group,if(pFLCrash6.eighth_citation_issued<>'',1,0));
    ped_dl_nbr_CountNonBlank                                := sum(group,if(pFLCrash6.ped_dl_nbr<>'',1,0));
    filler5_CountNonBlank                                   := sum(group,if(pFLCrash6.filler5<>'',1,0));
    prim_range_CountNonBlank                                := sum(group,if(pFLCrash6.prim_range<>'',1,0));
    predir_CountNonBlank                                    := sum(group,if(pFLCrash6.predir<>'',1,0));
    prim_name_CountNonBlank                                 := sum(group,if(pFLCrash6.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                               := sum(group,if(pFLCrash6.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                   := sum(group,if(pFLCrash6.postdir<>'',1,0));
    unit_desig_CountNonBlank                                := sum(group,if(pFLCrash6.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                 := sum(group,if(pFLCrash6.sec_range<>'',1,0));
    p_city_name_CountNonBlank                               := sum(group,if(pFLCrash6.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                               := sum(group,if(pFLCrash6.v_city_name<>'',1,0));
    st_CountNonBlank                                        := sum(group,if(pFLCrash6.st<>'',1,0));
    zip_CountNonBlank                                       := sum(group,if(pFLCrash6.zip<>'',1,0));
    zip4_CountNonBlank                                      := sum(group,if(pFLCrash6.zip4<>'',1,0));
    cart_CountNonBlank                                      := sum(group,if(pFLCrash6.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                                := sum(group,if(pFLCrash6.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                       := sum(group,if(pFLCrash6.lot<>'',1,0));
    lot_order_CountNonBlank                                 := sum(group,if(pFLCrash6.lot_order<>'',1,0));
    dpbc_CountNonBlank                                      := sum(group,if(pFLCrash6.dpbc<>'',1,0));
    chk_digit_CountNonBlank                                 := sum(group,if(pFLCrash6.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                  := sum(group,if(pFLCrash6.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                               := sum(group,if(pFLCrash6.ace_fips_st<>'',1,0));
    county_CountNonBlank                                    := sum(group,if(pFLCrash6.county<>'',1,0));
    geo_lat_CountNonBlank                                   := sum(group,if(pFLCrash6.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                  := sum(group,if(pFLCrash6.geo_long<>'',1,0));
    msa_CountNonBlank                                       := sum(group,if(pFLCrash6.msa<>'',1,0));
    geo_blk_CountNonBlank                                   := sum(group,if(pFLCrash6.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                 := sum(group,if(pFLCrash6.geo_match<>'',1,0));
    err_stat_CountNonBlank                                  := sum(group,if(pFLCrash6.err_stat<>'',1,0));
    title_CountNonBlank                                     := sum(group,if(pFLCrash6.title<>'',1,0));
    fname_CountNonBlank                                     := sum(group,if(pFLCrash6.fname<>'',1,0));
    mname_CountNonBlank                                     := sum(group,if(pFLCrash6.mname<>'',1,0));
    lname_CountNonBlank                                     := sum(group,if(pFLCrash6.lname<>'',1,0));
    suffix_CountNonBlank                                    := sum(group,if(pFLCrash6.suffix<>'',1,0));
    score_CountNonBlank                                     := sum(group,if(pFLCrash6.score<>'',1,0));
    cname_CountNonBlank                                     := sum(group,if(pFLCrash6.cname<>'',1,0));
  end;

// Create the Florida Crash 7 record layout
%rPopulationStats_FLCrash7%
 :=
  record
    CountGroup                                                    := count(group);
		UltID_CountNonZero	                         			   := sum(group,if(pFLCrash7.UltID   <> 0   ,1,0));
		OrgID_CountNonZero	                         			   := sum(group,if(pFLCrash7.OrgID   <> 0   ,1,0));
		SeleID_CountNonZero                                  := sum(group,if(pFLCrash7.SeleID  <> 0   ,1,0));
 		ProxID_CountNonZero 	                       		     := sum(group,if(pFLCrash7.ProxID  <> 0   ,1,0));
		POWID_CountNonZero 	                         		     := sum(group,if(pFLCrash7.POWID   <> 0   ,1,0));
		EmpID_CountNonZero 	   											 		     := sum(group,if(pFLCrash7.EmpID   <> 0   ,1,0));
	  DotID_CountNonZero	 												 		     := sum(group,if(pFLCrash7.DotID   <> 0   ,1,0));
		UltScore_CountNonZero 	                     			   := sum(group,if(pFLCrash7.UltScore  <> 0   ,1,0));
    OrgScore_CountNonZero 	                     			   := sum(group,if(pFLCrash7.OrgScore  <> 0   ,1,0));
    SeleScore_CountNonZero 	                     			   := sum(group,if(pFLCrash7.SeleScore <> 0   ,1,0));
	  ProxScore_CountNonZero 	                     			   := sum(group,if(pFLCrash7.ProxScore <> 0   ,1,0));
		POWScore_CountNonZero 	                     	       := sum(group,if(pFLCrash7.POWScore  <> 0   ,1,0));
 		EmpScore_CountNonZero 	 									   		     := sum(group,if(pFLCrash7.EmpScore  <> 0   ,1,0));
		DotScore_CountNonZero 	  									 			   := sum(group,if(pFLCrash7.DotScore  <> 0   ,1,0));
		UltWeight_CountNonZero 	                     		     := sum(group,if(pFLCrash7.UltWeight <> 0   ,1,0));		
		OrgWeight_CountNonZero 	                     		     := sum(group,if(pFLCrash7.OrgWeight <> 0   ,1,0));
		SeleWeight_CountNonZero 	                     		   := sum(group,if(pFLCrash7.SeleWeight <> 0   ,1,0));
		ProxWeight_CountNonZero 	                           := sum(group,if(pFLCrash7.ProxWeight <> 0   ,1,0));
		POWWeight_CountNonZero 	                     	       := sum(group,if(pFLCrash7.POWWeight  <> 0   ,1,0));
		EmpWeight_CountNonZero 	 				             		     := sum(group,if(pFLCrash7.EmpWeight  <> 0   ,1,0));
    DotWeight_CountNonZero 	 										 		     := sum(group,if(pFLCrash7.DotWeight  <> 0   ,1,0));
    did_CountNonBlank                                    := sum(group,if(pFLCrash7.did<>'',1,0));
    did_score_CountNonZero                               := sum(group,if(pFLCrash7.did_score<>0,1,0));
    b_did_CountNonBlank                                  := sum(group,if(pFLCrash7.b_did<>'',1,0));
    b_did_score_CountNonZero                             := sum(group,if(pFLCrash7.b_did_score<>0,1,0));
    rec_type_7_CountNonBlank                             := sum(group,if(pFLCrash7.rec_type_7<>'',1,0));
    accident_nbr_CountNonBlank                           := sum(group,if(pFLCrash7.accident_nbr<>'',1,0));
    pFLCrash7.prop_damage_code;
    prop_damage_nbr_CountNonBlank                        := sum(group,if(pFLCrash7.prop_damage_nbr<>'',1,0));
    prop_damaged_CountNonBlank                           := sum(group,if(pFLCrash7.prop_damaged<>'',1,0));
    prop_damage_amount_CountNonBlank                     := sum(group,if(pFLCrash7.prop_damage_amount<>'',1,0));
    prop_owner_name_CountNonBlank                        := sum(group,if(pFLCrash7.prop_owner_name<>'',1,0));
    filler1_CountNonBlank                                := sum(group,if(pFLCrash7.filler1<>'',1,0));
    prop_owner_suffix_CountNonBlank                      := sum(group,if(pFLCrash7.prop_owner_suffix<>'',1,0));
    prop_owner_st_city_CountNonBlank                     := sum(group,if(pFLCrash7.prop_owner_st_city<>'',1,0));
    filler2_CountNonBlank                                := sum(group,if(pFLCrash7.filler2<>'',1,0));
    prop_owner_state_CountNonBlank                       := sum(group,if(pFLCrash7.prop_owner_state<>'',1,0));
    prop_owner_zip_CountNonBlank                         := sum(group,if(pFLCrash7.prop_owner_zip<>'',1,0));
    fr_fixed_object_cap_code_CountNonBlank               := sum(group,if(pFLCrash7.fr_fixed_object_cap_code<>'',1,0));
    filler3_CountNonBlank                                := sum(group,if(pFLCrash7.filler3<>'',1,0));
    prim_range_CountNonBlank                             := sum(group,if(pFLCrash7.prim_range<>'',1,0));
    predir_CountNonBlank                                 := sum(group,if(pFLCrash7.predir<>'',1,0));
    prim_name_CountNonBlank                              := sum(group,if(pFLCrash7.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                            := sum(group,if(pFLCrash7.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                := sum(group,if(pFLCrash7.postdir<>'',1,0));
    unit_desig_CountNonBlank                             := sum(group,if(pFLCrash7.unit_desig<>'',1,0));
    sec_range_CountNonBlank                              := sum(group,if(pFLCrash7.sec_range<>'',1,0));
    p_city_name_CountNonBlank                            := sum(group,if(pFLCrash7.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                            := sum(group,if(pFLCrash7.v_city_name<>'',1,0));
    st_CountNonBlank                                     := sum(group,if(pFLCrash7.st<>'',1,0));
    zip_CountNonBlank                                    := sum(group,if(pFLCrash7.zip<>'',1,0));
    zip4_CountNonBlank                                   := sum(group,if(pFLCrash7.zip4<>'',1,0));
    cart_CountNonBlank                                   := sum(group,if(pFLCrash7.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                             := sum(group,if(pFLCrash7.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                    := sum(group,if(pFLCrash7.lot<>'',1,0));
    lot_order_CountNonBlank                              := sum(group,if(pFLCrash7.lot_order<>'',1,0));
    dpbc_CountNonBlank                                   := sum(group,if(pFLCrash7.dpbc<>'',1,0));
    chk_digit_CountNonBlank                              := sum(group,if(pFLCrash7.chk_digit<>'',1,0));
    rec_type_CountNonBlank                               := sum(group,if(pFLCrash7.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                            := sum(group,if(pFLCrash7.ace_fips_st<>'',1,0));
    county_CountNonBlank                                 := sum(group,if(pFLCrash7.county<>'',1,0));
    geo_lat_CountNonBlank                                := sum(group,if(pFLCrash7.geo_lat<>'',1,0));
    geo_long_CountNonBlank                               := sum(group,if(pFLCrash7.geo_long<>'',1,0));
    msa_CountNonBlank                                    := sum(group,if(pFLCrash7.msa<>'',1,0));
    geo_blk_CountNonBlank                                := sum(group,if(pFLCrash7.geo_blk<>'',1,0));
    geo_match_CountNonBlank                              := sum(group,if(pFLCrash7.geo_match<>'',1,0));
    err_stat_CountNonBlank                               := sum(group,if(pFLCrash7.err_stat<>'',1,0));
    title_CountNonBlank                                  := sum(group,if(pFLCrash7.title<>'',1,0));
    fname_CountNonBlank                                  := sum(group,if(pFLCrash7.fname<>'',1,0));
    mname_CountNonBlank                                  := sum(group,if(pFLCrash7.mname<>'',1,0));
    lname_CountNonBlank                                  := sum(group,if(pFLCrash7.lname<>'',1,0));
    suffix_CountNonBlank                                 := sum(group,if(pFLCrash7.suffix<>'',1,0));
    score_CountNonBlank                                  := sum(group,if(pFLCrash7.score<>'',1,0));
    cname_CountNonBlank                                  := sum(group,if(pFLCrash7.cname<>'',1,0));
  end;

// Create the Florida Crash 8 record layout
%rPopulationStats_FLCrash8%
 :=
  record
    CountGroup                                                    := count(group);
    rec_type_8_CountNonBlank                             := sum(group,if(pFLCrash8.rec_type_8<>'',1,0));
    accident_nbr_CountNonBlank                           := sum(group,if(pFLCrash8.accident_nbr<>'',1,0));
    pFLCrash8.section_no;
	filler_CountNonBlank								:= sum(group,if(pFLCrash8.filler<>'',1,0));
	carrier_name_CountNonBlank							:= sum(group,if(pFLCrash8.carrier_name<>'',1,0));
	carrier_address_CountNonBlank						:= sum(group,if(pFLCrash8.carrier_address<>'',1,0));
	carrier_city_CountNonBlank							:= sum(group,if(pFLCrash8.carrier_city<>'',1,0));
	carrier_state_CountNonBlank							:= sum(group,if(pFLCrash8.carrier_state<>'',1,0));
	carrier_zip_CountNonBlank							:= sum(group,if(pFLCrash8.carrier_zip<>'',1,0));
	us_dot_or_icc_id_nums_CountNonBlank					:= sum(group,if(pFLCrash8.us_dot_or_icc_id_nums<>'',1,0));
	source_or_carrier_info_CountNonBlank				:= sum(group,if(pFLCrash8.source_or_carrier_info<>'',1,0));
	filler3_CountNonBlank								:= sum(group,if(pFLCrash8.filler3<>'',1,0));
  end;

// Create the Florida Crash DID record layout
%rPopulationStats_FLCrashDID%
 :=
  record
    string3  grouping                              := 'ALL';
    CountGroup                                                := count(group);
    did_CountNonBlank                              := sum(group,if(pFLCrashDID.did<>'',1,0));
    did_score_CountNonZero                         := sum(group,if(pFLCrashDID.did_score<>0,1,0));
    accident_nbr_CountNonBlank                     := sum(group,if(pFLCrashDID.accident_nbr<>'',1,0));
    accident_date_CountNonBlank                    := sum(group,if(pFLCrashDID.accident_date<>'',1,0));
    title_CountNonBlank                            := sum(group,if(pFLCrashDID.title<>'',1,0));
    fname_CountNonBlank                            := sum(group,if(pFLCrashDID.fname<>'',1,0));
    mname_CountNonBlank                            := sum(group,if(pFLCrashDID.mname<>'',1,0));
    lname_CountNonBlank                            := sum(group,if(pFLCrashDID.lname<>'',1,0));
    name_suffix_CountNonBlank                      := sum(group,if(pFLCrashDID.name_suffix<>'',1,0));
    cname_CountNonBlank                            := sum(group,if(pFLCrashDID.cname<>'',1,0));
    prim_range_CountNonBlank                       := sum(group,if(pFLCrashDID.prim_range<>'',1,0));
    predir_CountNonBlank                           := sum(group,if(pFLCrashDID.predir<>'',1,0));
    prim_name_CountNonBlank                        := sum(group,if(pFLCrashDID.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                      := sum(group,if(pFLCrashDID.addr_suffix<>'',1,0));
    postdir_CountNonBlank                          := sum(group,if(pFLCrashDID.postdir<>'',1,0));
    unit_desig_CountNonBlank                       := sum(group,if(pFLCrashDID.unit_desig<>'',1,0));
    sec_range_CountNonBlank                        := sum(group,if(pFLCrashDID.sec_range<>'',1,0));
    v_city_name_CountNonBlank                      := sum(group,if(pFLCrashDID.v_city_name<>'',1,0));
    st_CountNonBlank                               := sum(group,if(pFLCrashDID.st<>'',1,0));
    zip_CountNonBlank                              := sum(group,if(pFLCrashDID.zip<>'',1,0));
    zip4_CountNonBlank                             := sum(group,if(pFLCrashDID.zip4<>'',1,0));
    record_type_CountNonBlank                      := sum(group,if(pFLCrashDID.record_type<>'',1,0));
    vin_CountNonBlank                              := sum(group,if(pFLCrashDID.vin<>'',1,0));
    driver_license_nbr_CountNonBlank               := sum(group,if(pFLCrashDID.driver_license_nbr<>'',1,0));
    tag_nbr_CountNonBlank                          := sum(group,if(pFLCrashDID.tag_nbr<>'',1,0));
  end;

// Create the Florida Crash 0 table and run the STRATA statistics
%dPopulationStats_FLCrash0% := table(pFLCrash0
							  	    ,%rPopulationStats_FLCrash0%
									,city_nbr
									,few);
STRATA.createXMLStats(%dPopulationStats_FLCrash0%
					 ,'Florida Crash Reports'
					 ,'FLCrash 0'
					 ,pVersion
					 ,''
					 ,%zFLCrash0%);
					 
// Create the Florida Crash 1 table and run the STRATA statistics
%dPopulationStats_FLCrash1% := table(pFLCrash1
							  	    ,%rPopulationStats_FLCrash1%
									,city_nbr
									,few);
STRATA.createXMLStats(%dPopulationStats_FLCrash1%
					 ,'Florida Crash Reports'
					 ,'FLCrash 1'
					 ,pVersion
					 ,''
					 ,%zFLCrash1%);
					 
// Create the Florida Crash 2 table and run the STRATA statistics
%dPopulationStats_FLCrash2% := table(pFLCrash2
							  	    ,%rPopulationStats_FLCrash2%
									,section_nbr
									,few);
STRATA.createXMLStats(%dPopulationStats_FLCrash2%
					 ,'Florida Crash Reports'
					 ,'FLCrash 2V'
					 ,pVersion
					 ,''
					 ,%zFLCrash2%);
					 
// Create the Florida Crash 3 table and run the STRATA statistics
%dPopulationStats_FLCrash3% := table(pFLCrash3
							  	    ,%rPopulationStats_FLCrash3%
									,section_nbr
									,few);
STRATA.createXMLStats(%dPopulationStats_FLCrash3%
					 ,'Florida Crash Reports'
					 ,'FLCrash 3'
					 ,pVersion
					 ,''
					 ,%zFLCrash3%);
					 
// Create the Florida Crash 4 table and run the STRATA statistics
%dPopulationStats_FLCrash4% := table(pFLCrash4
							  	    ,%rPopulationStats_FLCrash4%
									,section_nbr
									,few);
STRATA.createXMLStats(%dPopulationStats_FLCrash4%
					 ,'Florida Crash Reports'
					 ,'FLCrash 4'
					 ,pVersion
					 ,''
					 ,%zFLCrash4%);
					 
// Create the Florida Crash 5 table and run the STRATA statistics
%dPopulationStats_FLCrash5% := table(pFLCrash5
							  	    ,%rPopulationStats_FLCrash5%
									,section_nbr
									,few);
STRATA.createXMLStats(%dPopulationStats_FLCrash5%
					 ,'Florida Crash Reports'
					 ,'FLCrash 5'
					 ,pVersion
					 ,''
					 ,%zFLCrash5%);
					 
// Create the Florida Crash 6 table and run the STRATA statistics
%dPopulationStats_FLCrash6% := table(pFLCrash6
							  	    ,%rPopulationStats_FLCrash6%
									,section_nbr
									,few);
STRATA.createXMLStats(%dPopulationStats_FLCrash6%
					 ,'Florida Crash Reports'
					 ,'FLCrash 6'
					 ,pVersion
					 ,''
					 ,%zFLCrash6%);
					 
// Create the Florida Crash 7 table and run the STRATA statistics
%dPopulationStats_FLCrash7% := table(pFLCrash7
							  	    ,%rPopulationStats_FLCrash7%
									,prop_damage_code
									,few);
STRATA.createXMLStats(%dPopulationStats_FLCrash7%
					 ,'Florida Crash Reports'
					 ,'FLCrash 7V'
					 ,pVersion
					 ,''
					 ,%zFLCrash7%);
					 
// Create the Florida Crash 8 table and run the STRATA statistics
%dPopulationStats_FLCrash8% := table(pFLCrash8
							  	    ,%rPopulationStats_FLCrash8%
									,section_no
									,few);
STRATA.createXMLStats(%dPopulationStats_FLCrash8%
					 ,'Florida Crash Reports'
					 ,'FLCrash 8'
					 ,pVersion
					 ,''
					 ,%zFLCrash8%);
					 
// Create the Florida Crash DID table and run the STRATA statistics
%dPopulationStats_FLCrashDID% := table(pFLCrashDID
							  	    ,%rPopulationStats_FLCrashDID%
									,few);
STRATA.createXMLStats(%dPopulationStats_FLCrashDID%
					 ,'Florida Crash Reports'
					 ,'FLCrash DID'
					 ,pVersion
					 ,''
					 ,%zFLCrashDID%);
					 
zOut := parallel(%zFLCrash0%,%zFLCrash1%,%zFLCrash2%
                 ,%zFLCrash3%,%zFLCrash4%,%zFLCrash5%
				 ,%zFLCrash6%,%zFLCrash7%,%zFLCrash8%,%zFLCrashDID%);

ENDMACRO;