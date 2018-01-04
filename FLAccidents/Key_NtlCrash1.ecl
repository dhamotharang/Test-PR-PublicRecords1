import doxie, data_services;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc1	:= FLAccidents.basefile_flcrash1;
xpnd_layout := record
  string2 report_code;
  string25 report_category;
  string65 report_code_desc;
	string1   rec_type_1,
	string10   accident_nbr,
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
	string7   total_vehicle_damage,
	string7   total_prop_damage_amt,
	string4   total_nbr_persons,
	string2   total_nbr_drivers,
	string2   total_nbr_vehicles,
	string3   total_nbr_fatalities,
	string2   total_nbr_non_traffic_fatal,
	string3   total_nbr_injuries,
	string2   total_nbr_pedestrian,
	string2   total_nbr_pedalcyclist,
	string15  invest_agy_rpt_nbr,
	string25  invest_name,
	string16  filler2,
	string4   invest_rank,
	string6   invest_id_badge_nbr,
	string25  dept_name,
	string1   invest_maede,
	string1   invest_complete,
	string6   report_date,
	string1   photos_taken,
	string1   photos_taken_whom,
	string25  first_aid_name,
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
  end;
xpnd_layout xpndrecs(flc1 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self 								:= L;
end;

pflc1:= project(flc1,xpndrecs(left));
  
//ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.


export key_Ntlcrash1 := index(pflc1,
                              {unsigned6 l_acc_nbr := (integer)accident_nbr},
                              {pflc1},
                              data_services.data_location.prefix() + 'thor_data400::key::ntlcrash1_' + doxie.Version_SuperKey);