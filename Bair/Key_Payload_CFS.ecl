import Data_Services;

r := RECORD
	string23	eid := '';
	STRING12 	gh12 := '';
	unsigned1 etype; // [1 - EVE, 2 - CFS, 3 - Crash, 4 - Lpr, 5 - Inte, 6 - Shotstopper, 7 - Offenders]
  unsigned4 cfs_id;
  unsigned4 ori;
  string100 event_number;
  string25 edit_date;
  string30 report_number;
  string100 caller_address;
  string100 address;
  string100 place_name;
  string50 location_type;
  string30 district;
  string30 beat;
  string510 rd;
  string50 how_received;
  string50 initial_type;
  string50 final_type;
  string30 disposition;
  string30 priority1;
  string25 date_occurred;
  string25 date_time_received;
  string1 report_flag;
  string50 event_relationship;
  string25 date_time_archived;
  string30 incident_code;
  string150 incident_progress;
  string50 city;
  string50 call_taker;
  string50 contacting_officer;
  string50 complainant;
  string30 current_phone;
  string100 complainant_address;
  string50 status;
  string30 apartment_number;
  real8 total_minutes_on_call;
  real8 x_coordinate;
  real8 y_coordinate;
  real8 projected_x_coordinate;
  real8 projected_y_coordinate;
  string1 geocoded;
  unsigned1 accuracy_code;
  string20 accuracy;
  real8 complainant_x_coordinate;
  real8 complainant_y_coordinate;
  real8 complainant_projected_x_coordinate;
  real8 complainant_projected_y_coordinate;
  string1 complainant_geocoded;
  unsigned1 complainant_accuracy;
  string1 quarantined;
  unsigned2 group_id;
  unsigned4 import_instance_id;
  unsigned4 initial_ucr_group;
  unsigned4 final_ucr_group;
  string20 coordinate;
  unsigned4 cfs_officers_id;
  string25 date_time_dispatched;
  string25 date_time_enroute;
  string25 date_time_arrived;
  string25 date_time_cleared;
  real8 minutes_on_call;
  real8 minutes_response;
  string30 unit;
  string50 officer_name;
  string1 primary_officer;
  unsigned4 data_provider_id;
  string50 data_provider_ori;
  string200 data_provider_name;
	unsigned8 lexid;
END;

d:=dataset([],r);

EXPORT Key_Payload_CFS(string v = 'qa', boolean isDelta = false) := 
													index(d,{eid},{d},data_services.Data_location.Prefix('BAIR')+
																						'thor_data400::key::bair::cfs::' + if(isDelta, 'delta::', '') + v + '::eid', OPT);
