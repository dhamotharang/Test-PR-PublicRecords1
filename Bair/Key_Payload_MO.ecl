﻿import data_services;

r := RECORD
  string23 eid;
  string12 gh12;
  unsigned1 etype;
  unsigned5 recordid_raids;
  string100 ir_number;
  string100 crime;
  string30 location_type;
  string50 object_of_attack_1;
  string50 object_of_attack_2;
  string50 point_of_entry_1;
  string50 point_of_entry_2;
  string50 method_of_entry_1;
  string50 method_of_entry_2;
  string150 suspects_actions_against_person_1;
  string150 suspects_actions_against_person_2;
  string150 suspects_actions_against_person_3;
  string150 suspects_actions_against_person_4;
  string150 suspects_actions_against_person_5;
  string150 suspects_actions_against_property_1;
  string150 suspects_actions_against_property_2;
  string150 suspects_actions_against_property_3;
  string50 property_taken_1;
  string50 property_taken_2;
  string50 property_taken_3;
  string10 property_value;
  string50 weapon_type_1;
  string50 weapon_type_2;
  string100 method_of_departure;
  string25 first_date;
  string25 last_date;
  string25 first_date_time;
  string25 last_date_time;
  integer8 duration;
  integer8 sequence;
  string6 first_day;
  real8 interval;
  string6 last_day;
  string100 address_of_crime;
  string50 address_name;
  string50 beat;
  string100 rd;
  string10 companions;
  string16 apt;
  string100 trend;
  integer8 commonalities;
  string1 marked;
  unsigned4 mostamp;
  real8 t_coordinate;
  real8 x_coordinate;
  real8 y_coordinate;
  string25 edit_date;
  string150 agency;
  unsigned1 accuracy_code;
	string20  accuracy;
  unsigned4 ucr_group;
  unsigned4 ori;
  string1 geocoded;
  string1 raids;
  real8 x_offset;
  real8 y_offset;
  real8 projected_x;
  real8 projected_y;
  integer8 citizen_observer_id;
  string1 quarantined;
  string150 public_address;
  unsigned2 group_id;
  string25 raids_activitydate;
  unsigned4 incidentid;
  unsigned2 first_time;
  unsigned2 last_time;
  unsigned5 import_instance_id;
  string150 public_synopsis;
  string1 le_only;
  string25 report_date;
  string50 coordinate;
  unsigned4 data_provider_id;
  string50 data_provider_ori;
  string200 data_provider_name;
  string50 address;
  real8 latitude;
  real8 longitude;
  string50 city;
  string5 state;
  string50 zip;
  real8 boundingboxsouthwestlat;
  real8 boundingboxsouthwestlong;
  real8 boundingboxnortheastlat;
  real8 boundingboxnortheastlong;
 END;


d:=dataset([],r);

EXPORT Key_Payload_MO(string v='qa', boolean isDelta = false) := 
							index(d,{eid},{d},data_services.Data_location.Prefix('BAIR')+
														'thor_data400::key::bair::mo::' + if(isDelta, 'delta::', '') + v + '::eid', OPT);
