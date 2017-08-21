
import Data_Services;

r := RECORD
  string23 eid;
  string12 gh12;
  unsigned1 etype;
  unsigned5 recordid_raids;
  string50 ir_number;
  unsigned4 personstamp;
  string30 name_type;
  string30 last_name;
  string30 first_name;
  string30 middle_name;
  string100 moniker;
  string100 persons_address;
  string25 dob;
  string25 race;
  string20 sex;
  string20 hair;
  string10 hair_length;
  string20 eyes;
  string20 hand_use;
  string20 speech;
  string20 teeth;
  string50 physical_condition;
  string50 build;
  string30 complexion;
  string20 facial_hair;
  string20 hat;
  string20 mask;
  string20 glasses;
  string20 appearance;
  string20 shirt;
  string20 pants;
  string20 shoes;
  string20 jacket;
  string128 soundex;
  unsigned2 weight_1;
  unsigned2 weight_2;
  unsigned2 height_1;
  unsigned2 height_2;
  unsigned2 age_1;
  unsigned2 age_2;
  string100 persons_sid;
  string picture;
  string50 facial_recognition;
  real8 persons_x_coordinate;
  real8 persons_y_coordinate;
  real8 persons_x_projected;
  real8 persons_y_projected;
  unsigned1 persons_accuracy_code;
  string20 persons_accuracy;
  string1 persons_geocoded;
  string25 edit_date;
  unsigned4 ori;
  string1 quarantined;
  integer8 mo_relationship;
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
	unsigned8 lexid;
 END;


d:=dataset([],r);

EXPORT Key_Payload_Person(string v='qa', boolean isDelta = false) := 
							index(d,{eid},{d},data_services.Data_location.Prefix('BAIR')+
														'thor_data400::key::bair::persons::' + if(isDelta, 'delta::', '') + v + '::eid', OPT);