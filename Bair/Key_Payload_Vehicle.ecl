import Data_Services;

r := RECORD
  string23 eid;
  string12 gh12;
  unsigned1 etype;
  unsigned5 recordid_raids;
  string50 ir_number;
  unsigned4 vehiclestamp;
  string16 plate;
  string30 plate_state;
  string30 make;
  string30 model;
  string30 style;
  string20 color;
  string10 year;
  string20 type;
  string50 vehicle_status;
  string100 vehicle_address;
  real8 vehicle_x_coordinate;
  real8 vehicle_y_coordinate;
  real8 vehicle_x_projected;
  real8 vehicle_y_projected;
  unsigned1 vehicle_accuracy_code;
  string20 vehicle_accuracy;
  string10 vehicle_geocoded;
  string25 edit_date;
  unsigned4 ori;
  string1 quarantined;
  integer8 person_relationship;
  unsigned2 group_id;
  string25 raids_activitydate;
  unsigned4 import_instance_id;
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

EXPORT Key_Payload_Vehicle(string v='qa', boolean isDelta = false) := 
							index(d,{eid},{d},data_services.Data_location.Prefix('BAIR')+
														'thor_data400::key::bair::vehicle::' + if(isDelta, 'delta::', '') + v + '::eid', OPT);
 