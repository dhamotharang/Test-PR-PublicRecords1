﻿import Data_Services;

r:=	RECORD
  string23 eid;
  string12 gh12;
  unsigned1 etype;
  unsigned2 id;
  unsigned2 incident_id;
  string20 name_type;
  string50 first_name;
  string50 middle_name;
  string50 last_name;
  string100 moniker;
  string20 ssn;
  string25 dob;
  string10 sex;
  string50 race;
  string20 ethnicity;
  string20 country_of_origin;
  string10 height;
  string10 weight;
  string20 eye_color;
  string20 hair_color;
  string20 hair_style;
  string20 facial_hair;
  string100 tattoo_text_1;
  string100 tattoo_location_1;
  string100 tattoo_text_2;
  string100 tattoo_location_2;
  string100 occupation;
  string150 place_of_employment;
  string100 entity_address;
  string20 entity_city;
  string20 entity_state;
  string20 entity_zip;
  real8 person_x;
  real8 person_y;
  string20 phone_number;
  string10 phone_type;
  string50 email_address;
  string100 social_media_type_1;
  string100 user_name_site_1;
  string100 social_media_type_2;
  string100 user_name_site_2;
  string100 social_media_type_3;
  string100 user_name_site_3;
  string100 social_media_type_4;
  string100 user_name_site_4;
  string10 organization_type;
  string10 organization_sub_type;
  string50 organization_name;
  string10 number_of_members;
  string100 organization_rank_role;
  string20 entity_source_type;
  string100 source_reliability;
  string100 entity_content_validity;
  integer8 entity_source_score;
  string25 entity_entry_date;
  string25 entity_purge_date;
  string20 vehicle_type;
  string50 vehicle_make;
  string50 vehicle_model;
  string20 vehicle_color;
  integer8 vehicle_year;
  string100 vehicle_plate;
  string30 vehicle_plate_state;
  unsigned4 vehicle_notes_id;
  unsigned4 entity_photo_id;
  unsigned4 entity_notes_id;
  unsigned2 priority;
  string50 vehicle_color_secondary;
  string17 vehicle_vin;
  string100 photo;
  string20 case_number;
  string20 call_case_number;
  string25 incident_date;
  unsigned2 incident_time;
  integer2 reporting_officer_id;
  string50 incident_type;
  string100 incident_address;
  string25 incident_city;
  string25 incident_state;
  string25 incident_zip;
  real8 x;
  real8 y;
  string50 address_name;
  string50 location_type;
  string50 source_relaiability;
  string50 incident_content_validity;
  string50 source_type;
  integer2 incident_source_score;
  string25 incident_entry_date;
  string25 incident_purge_date;
  unsigned2 notes_id;
  real8 coordinate;
  string25 update_date;
  string25 purgedate_computed;
  string duration_since;
  string50 reporting_officer_first_name;
  string50 reporting_officer_last_name;
  unsigned4 data_provider_id;
  string50 data_provider_ori;
  string200 data_provider_name;
 END;

d:=dataset([],r);

EXPORT Key_Payload_Intel_V2(string v='qa', boolean isDelta = false) := 
	index(d,{eid},{d},data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::intel::v2::'+ if(isDelta, 'delta::', '')+v+'::eid');
