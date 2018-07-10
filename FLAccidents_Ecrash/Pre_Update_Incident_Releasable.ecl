﻿/*
One time BWR to expand Incident file layout with new field Releasable.
*/
IMPORT Data_Services;
EXPORT Pre_Update_Incident_Releasable := FUNCTION

 Lay := RECORD,maxlength(20000)
  string incident_id;
  string creation_date;
  string work_type_id;
  string report_id;
  string agency_id;
  string sent_to_hpcc_datetime;
  string corrected_incident;
  string cru_order_id;
  string cru_sequence_nbr;
  string loss_state_abbr;
  string report_type_id;
  string hash_key;
  string case_identifier;
  string crash_county;
  string county_cd;
  string crash_cityplace;
  string crash_city;
  string city_code;
  string first_harmful_event;
  string first_harmful_event_location;
  string manner_crash_impact1;
  string weather_condition1;
  string weather_condition2;
  string light_condition1;
  string light_condition2;
  string road_surface_condition;
  string contributing_circumstances_environmental1;
  string contributing_circumstances_environmental2;
  string contributing_circumstances_environmental3;
  string contributing_circumstances_environmental4;
  string contributing_circumstances_road1;
  string contributing_circumstances_road2;
  string contributing_circumstances_road3;
  string contributing_circumstances_road4;
  string relation_to_junction;
  string intersection_type;
  string school_bus_related;
  string work_zone_related;
  string work_zone_location;
  string work_zone_type;
  string work_zone_workers_present;
  string work_zone_law_enforcement_present;
  string crash_severity;
  string number_of_vehicles;
  string total_nonfatal_injuries;
  string total_fatal_injuries;
  string day_of_week;
  string roadway_curvature;
  string part_of_national_highway_system;
  string roadway_functional_class;
  string access_control;
  string rr_crossing_id;
  string roadway_lighting;
  string traffic_control_type_at_intersection1;
  string traffic_control_type_at_intersection2;
  string ncic_number;
  string state_report_number;
  string ori_number;
  string crash_date;
  string crash_time;
  string lattitude;
  string longitude;
  string milepost1;
  string milepost2;
  string address_number;
  string loss_street;
  string loss_street_route_number;
  string loss_street_type;
  string loss_street_speed_limit;
  string incident_location_indicator;
  string loss_cross_street;
  string loss_cross_street_route_number;
  string loss_cross_street_intersecting_route_segment;
  string loss_cross_street_type;
  string loss_cross_street_speed_limit;
  string loss_cross_street_number_of_lanes;
  string loss_cross_street_orientation;
  string loss_cross_street_route_sign;
  string at_node_number;
  string distance_from_node_feet;
  string distance_from_node_miles;
  string next_node_number;
  string next_roadway_node_number;
  string direction_of_travel;
  string next_street;
  string next_street_type;
  string next_street_suffix;
  string before_or_after_next_street;
  string next_street_distance_feet;
  string next_street_distance_miles;
  string next_street_direction;
  string next_street_route_segment;
  string continuing_toward_street;
  string continuing_street_suffix;
  string continuing_street_direction;
  string continuting_street_route_segment;
  string city_type;
  string outside_city_indicator;
  string outside_city_direction;
  string outside_city_distance_feet;
  string outside_city_distance_miles;
  string crash_type;
  string motor_vehicle_involved_with;
  string report_investigation_type;
  string incident_hit_and_run;
  string tow_away;
  string date_notified;
  string time_notified;
  string notification_method;
  string officer_arrival_time;
  string officer_report_date;
  string officer_report_time;
  string officer_id;
  string officer_department;
  string officer_rank;
  string officer_command;
  string officer_tax_id_number;
  string completed_report_date;
  string supervisor_check_date;
  string supervisor_check_time;
  string supervisor_id;
  string supervisor_rank;
  string reviewers_name;
  string road_surface;
  string roadway_alignment;
  string traffic_way_description;
  string traffic_flow;
  string property_damage_involved;
  string property_damage_description1;
  string property_damage_description2;
  string property_damage_estimate1;
  string property_damage_estimate2;
  string incident_damage_over_limit;
  string property_owner_notified;
  string government_property;
  string accident_condition;
  string unusual_road_condition1;
  string unusual_road_condition2;
  string number_of_lanes;
  string divided_highway;
  string most_harmful_event;
  string second_harmful_event;
  string ems_notified_date;
  string ems_arrival_date;
  string hospital_arrival_date;
  string injured_taken_by;
  string injured_taken_to;
  string incident_transported_for_medical_care;
  string photographs_taken;
  string photographed_by;
  string photographer_id;
  string photography_agency_name;
  string agency_name;
  string judicial_district;
  string precinct;
  string beat;
  string location_type;
  string shoulder_type;
  string investigation_complete;
  string investigation_not_complete_why;
  string investigating_officer_name;
  string investigation_notification_issued;
  string agency_type;
  string no_injury_tow_involved;
  string injury_tow_involved;
  string lars_code1;
  string lars_code2;
  string private_property_incident;
  string accident_involvement;
  string local_use;
  string street_prefix;
  string street_suffix;
  string toll_road;
  string street_description;
  string cross_street_address_number;
  string cross_street_prefix;
  string cross_street_suffix;
  string report_complete;
  string dispatch_notified;
  string counter_report;
  string road_type;
  string agency_code;
  string public_property_employee;
  string bridge_related;
  string ramp_indicator;
  string to_or_from_location;
  string complaint_number;
  string school_zone_related;
  string notify_dot_maintenance;
  string special_location;
  string route_segment;
  string route_sign;
  string route_category_street;
  string route_category_cross_street;
  string route_category_next_street;
  string lane_closed;
  string lane_closure_direction;
  string lane_direction;
  string traffic_detoured;
  string time_closed;
  string pedestrian_signals;
  string work_zone_speed_limit;
  string work_zone_shoulder_median;
  string work_zone_intermittent_moving;
  string work_zone_flagger_control;
  string special_work_zone_characteristics;
  string lane_number;
  string offset_distance_feet;
  string offset_distance_miles;
  string offset_direction;
  string asru_code;
  string mp_grid;
  string number_of_qualifying_units;
  string number_of_hazmat_vehicles;
  string number_of_buses_involved;
  string number_taken_to_treatment;
  string number_vehicles_towed;
  string vehicle_at_fault_unit_number;
  string time_officer_cleared_scene;
  string total_minutes_on_scene;
  string motorists_report;
  string fatality_involved;
  string local_dot_index_number;
  string dor_number;
  string hospital_code;
  string special_jurisdiction;
  string document_type;
  string distance_was_measured;
  string street_orientation;
  string intersecting_route_segment;
  string primary_fault_indicator;
  string first_harmful_event_pedestrian;
  string reference_markers;
  string other_officer_on_scene;
  string other_officer_badge_number;
  string supplemental_report;
  string supplemental_type;
  string amended_report;
  string corrected_report;
  string state_highway_related;
  string roadway_lighting_condition;
  string vendor_reference_number;
  string duplicate_copy_unit_number;
  string other_city_agency_description;
  string notifcation_description;
  string primary_collision_improper_driving_description;
  string weather_other_description;
  string crash_type_description;
  string motor_vehicle_involved_with_animal_description;
  string motor_vehicle_involved_with_fixed_object_description;
  string motor_vehicle_involved_with_other_object_description;
  string other_investigation_time;
  string milepost_detail;
  string utility_pole_number1;
  string utility_pole_number2;
  string utility_pole_number3;
  string utility_pole_number4;
  string incident_special_use;
  string felony_misdemeanor_involved;
  string duplicate_copy_required;
  string highway_district_at_scene;
  string distance_was_approximated;
  string avoidance_maneuver;
  string investigation_at_scene;
  string accident_investigation_site;
  string narrative;
  string narrative_continuance;
  string report_has_coversheet;
  string crash_time_am;
  string crash_time_pm;
  string time_notified_am;
  string time_notified_pm;
  string ems_notified_time;
  string ems_arrival_time;
  string first_aid_by;
  string person_first_aid_party_type;
  string person_first_aid_party_type_description;
  string source_id;
  string traffic_control_condition;
  string intersection_related;
  string special_study_local;
  string special_study_state;
  string off_road_vehicle_involved;
  string location_type2;
  string speed_limit_posted;
  string traffic_control_damage_notify_date;
  string traffic_control_damage_notify_time;
  string traffic_control_damage_notify_name;
  string public_property_damaged;
  string replacement_report;
  string deleted_report;
  string next_street_prefix;
  string incident_damage_amount;
  string dot_use;
  string number_of_persons_involved;
  string unusual_road_condition_other_description;
  string number_of_narrative_sections;
  string cad_number;
  string visibility;
  string accident_at_intersection;
  string accident_not_at_intersection;
  string first_harmful_event_within_interchange;
  string injury_involved;
  string vendor_code;
  string report_property_damage;
  string report_collision_type;
  string report_first_harmful_event;
  string report_light_condition;
  string report_weather_condition;
  string report_road_condition;
  string cru_agency_id;
  string cru_agency_name;
  string vendor_report_id;
  string is_available_for_public;
  string has_addendum;
  string report_agency_ori;
  string report_status;
  string reportlinkid;
  string page_count;
  string is_delete;
  string last_update_date;
  string contrib_source;
  string date_report_submitted;
 END;

										 
	ds_incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
																						 ,Lay
																						 ,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID');
													 

		FLAccidents_Ecrash.Layout_Infiles.incident_new ExpandIncidentLayout(ds_incident L) := TRANSFORM
																																														SELF.Releasable := '1';
																																														SELF := L;
																																													END;

		upd_incident_layout := PROJECT(ds_incident, ExpandIncidentLayout(LEFT));
		
		OUTPUT(upd_incident_layout,,'~thor_data400::in::ecrash::incident_layout_change_releasable_'+workunit,overwrite,__compressed__,
					    csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

		do_all :=  SEQUENTIAL(
														FileServices.StartSuperFileTransaction(),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_layout_change_releasable_'+workunit),
														FileServices.FinishSuperFileTransaction()
												 );
					 
		RETURN do_all;
END;

