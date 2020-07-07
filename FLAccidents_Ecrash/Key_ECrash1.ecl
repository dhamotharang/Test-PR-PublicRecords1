Import Data_Services, doxie, FLAccidents, STD;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc1	:= FLAccidents.basefile_flcrash1;
xpnd_layout :=record
  string2 report_code;
  string25 report_category;
  string65 report_code_desc;
	string1   rec_type_1,
	string40   accident_nbr,
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
	string36   total_vehicle_damage,
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
	string30   invest_rank,
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
	string20   first_aid_person_type_desc,          //string1   first_aid_person_type
  string40   accident_fault_code_desc ,            //string1   accident_fault_code
  string40   alcohol_drug_desc  ,               // string1  alcohol_drug
  string100  accident_damage_severity_desc ,  // string1   accident_damage_severity
	string100   invest_agency_desc ,           //,	string1   invest_agency,
  string110  first_harmful_event_desc ,      //string2   first_harmful_event
  string40   light_condition_desc ,          //string2   light_condition
  string40   weather_desc   ,               //string2  weather
  string40   rd_surface_type_desc ,        //, string2   rd_surface_type, 
  string10   type_shoulder_desc,          //, string2   type_shoulder, 
  string40   rd_surface_condition_desc ,  //, string2   rd_surface_condition, 
  string50   first_contrib_cause_desc,   //, string2   first_contrib_cause, 
  string50   second_contrib_cause_desc,  //, string2   second_contrib_cause, 
  string40   first_contrib_envir_desc,   // , string2   first_contrib_envir, 
  string40   second_contrib_envir_desc,  // , string2   second_contrib_envir, 
  string30   first_traffic_control_desc ,// , string2   first_traffic_control, 
  string30   second_traffic_control_desc,//, string2   second_traffic_control 
	string9    day_week_desc;
  string30   location_type_desc;
	string40  orig_accnbr ; 
	string64  filler4,
  end;
xpnd_layout xpndrecs(flc1 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.accident_nbr := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.orig_accnbr := l.accident_nbr; 
self.invest_agency_desc := trim(l.dept_name,left,right); 
self 								:= L;
self := []; 
end;

pflc1:= project(flc1,xpndrecs(left));
  
//ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.

ecrashfile := eCrashBaseAgencyExclusion; 

xpnd_layout xpndecrash(ecrashfile L) := transform

	self.rec_type_1 := '1'; 
	t_accident_nbr 			:= if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
	t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
  self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);  
  self.orig_accnbr := t_accident_nbr;
	self.hr_off_notified :=l.time_notified[1..2];
  self.min_off_notified:=l.time_notified[4..5];
  self.hr_off_arrived:=l.officer_arrival_time[1..2];
  self.min_off_arrived:=l.officer_arrival_time[4..5];
	self.city_nbr := l.city_code; 
	self.site_loc := ''; 
	self.trafficway_char := ''; 
	self.nbr_lanes := l.number_of_lanes; 
	self.divided_undivided := ''; 
	self.total_vehicle_damage := l.vehicle_damage_amount; 
	self.total_nbr_vehicles := l.number_of_vehicles; 
	self.total_nbr_fatalities := l.total_fatal_injuries; 
	self.total_nbr_non_traffic_fatal := l.total_nonfatal_injuries;
	self.invest_name := l.investigating_officer_name; 
	self.invest_rank := l.officer_rank; 
	self.dept_name:=l.officer_department;
	self.report_date:=l.officer_report_date;
	self.first_aid_name :=l.person_first_aid_party_type_description;
	self.first_aid_person_type_desc:=l.person_first_aid_party_type;          //string1   first_aid_person_type,
  self.accident_fault_code_desc := l.primary_fault_indicator;          //string1   accident_fault_code,  
  self.alcohol_drug_desc  := l.alcohol_drug_use;                //string1   alcohol_drug,
  self.accident_damage_severity_desc := l.Damaged_Areas_Severity1;   // string1   accident_damage_severity
  self.invest_agency_desc  := l.agency_name;           //,	string1   invest_agency,
  self.first_harmful_event_desc  := l.first_harmful_event;      //string2   first_harmful_event
  self.light_condition_desc := l.light_condition1;           //string2   light_condition
  self.weather_desc  := l.weather_condition1;                //string2  weather
  self.rd_surface_type_desc := l.road_surface;         //, string2   rd_surface_type, 
  self.type_shoulder_desc := l.shoulder_type;          //, string2   type_shoulder, 
  self.rd_surface_condition_desc := l.road_surface_condition;   //, string2   rd_surface_condition, 
  self.first_contrib_cause_desc := l.contributing_factors1;   //, string2   first_contrib_cause, 
  self.second_contrib_cause_desc := l.contributing_factors2; //, string2   second_contrib_cause, 
  self.first_contrib_envir_desc:= l.contributing_circumstances_environmental1;  // , string2   first_contrib_envir, 
  self.second_contrib_envir_desc:= l.contributing_circumstances_environmental2;  // , string2   second_contrib_envir, 
  self.first_traffic_control_desc:= l.traffic_control_type_at_intersection1;// , string2   first_traffic_control, 
  self.second_traffic_control_desc:= l.traffic_control_type_at_intersection2;//, string2   second_traffic_control 
	self.hr_ems_notified :=l.EMS_Notified_Time[1..2]; //currently this is blank
	self.min_ems_notified:=l.EMS_Notified_Time[4..5];
	self.hr_ems_arrived :=l.EMS_Arrival_Time[1..2];//currently this is blank not sure about the format
	self.min_ems_arrived:=l.EMS_Arrival_Time[4..5];
	self.day_week_desc  := l.day_of_week;
	self.location_type_desc := l.location_type; 
	self.location_type :='';
  self := l ; 
  self:=[];
 end; 
 
 pecrash := project(ecrashfile, xpndecrash(left)); 
 

//iyetek 
/*
iyetekFile := FLAccidents_Ecrash.BaseFile_Iyetek;

xpnd_layout xpndiyetek(iyetekFile L) := transform
 
 t_scrub := STD.Str.Filter(L.state_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);  
self.orig_accnbr := L.state_report_number; 
self.invest_agency_desc  := l.agency_name;
self.invest_name := l.investigating_officer_name; 
self.report_date:=l.officer_report_date;
self.rec_type_1 := '1';
self:= l ; 
self := []; 
end; 

piyetek := project(iyetekFile , xpndiyetek(left)); */

ptotal := dedup(pflc1+pecrash,all); 
export key_Ecrash1 := index(ptotal
                            ,{string40 l_acc_nbr := accident_nbr}
							,{ptotal}
							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash1_' + doxie.Version_SuperKey);