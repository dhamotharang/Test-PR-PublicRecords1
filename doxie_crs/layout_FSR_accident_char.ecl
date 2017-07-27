export layout_FSR_accident_char := record
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
	string100 invest_name,
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
	string64  filler4,
  // NEW ECRASH FIELDS
  string20  first_aid_person_type_desc;    //string1 first_aid_person_type,
  string40  accident_fault_code_desc;      //string1 accident_fault_code,
  string40  alcohol_drug_desc;             //string1 alcohol_drug,
  string100 accident_damage_severity_desc; //string1 accident_damage_severity,
  string100 invest_agency_desc;            //string1 invest_agency,
  string110 first_harmful_event_desc;      //string2 first_harmful_event,
  string40  light_condition_desc;          //string2 light_condition,
  string40  weather_desc;                  //string2 weather,
  string40  rd_surface_type_desc;          //string2 rd_surface_type,
  string10  type_shoulder_desc;            //string2 type_shoulder,
  string40  rd_surface_condition_desc;     //string2 rd_surface_condition,
  string50  first_contrib_cause_desc;      //string2 first_contrib_cause,
  string50  second_contrib_cause_desc;     //string2 second_contrib_cause,
  string40  first_contrib_envir_desc;      //string2 first_contrib_envir,
  string40  second_contrib_envir_desc;     //string2 second_contrib_envir,
  string30  first_traffic_control_desc;    //string2 first_traffic_control,
  string30  second_traffic_control_desc;   //string2 second_traffic_control,
  string9   day_week_desc;                 //string1 day_week
  string30  location_type_desc;            //string1 location_type 
  string40  orig_accnbr;
  // DESCRIPTIONS NOT IN KEY
	string100 First_Harmful_Event_Name;
	string100	Subs_Harmful_Event_Name;
	string30	Light_Condition_Name;
	string30	Weather_Name;
	string50	Rd_Surface_Condition_Name;
	string100	First_Contrib_Envir_Name;
	string100	Second_Contrib_Envir_Name;
	string100	First_Traffic_Control_Name;
	string100	Second_Traffic_Control_Name;
	string30	Invest_Agency_Name;
	string100	Accident_Injury_Severity_Name;
	string100	Accident_Damage_Severity_Name;
	string30	Alcohol_Drug_Name;
	string10  rural_urban_code_name;
	string15  accident_insur_code_name;
	string10  accident_fault_code_name;
	string30  type_driver_accident_name;
	string10  day_week_name;
	string50  site_loc_name;
	string30  on_off_roadway_name;
	string30  rd_surface_type_name;
	string10  type_shoulder_name;
	string50  first_contrib_cause_name;
	string50  second_contrib_cause_name;
	string40  trafficway_char_name;
	string20  divided_undivided_name;
	string30  rd_sys_id_name;
	string27  invest_complete_name;
	string22  LOCATION_TYPE_name;
	string30  injured_taken_to_code_name;
	string30  photos_taken_name; //'Photos were taken at scene'
	string36  photos_taken_whom_name; //'Photos taken by Investigative Agency'
end;