import Data_Services;

r := RECORD
 string23 eid;
 unsigned4 personid;
 unsigned4 personvehicleid;
 unsigned8 lexid;
 string1 driver;
 string20 first_name;
 string20 last_name;
 string20 licensenumber;
 string20 licensestate;
 string50 race;
 string10 sex;
 string30 city;
 string20 state;
 unsigned2 age;
 string40 airbag;
 string40 seatbelt;
 string driveractions;
 unsigned4 data_provider_id;
END;

d:=dataset([],r);

EXPORT Key_Payload_Crash_Person(string v='qa',boolean isDelta = false) := INDEX(d,{eid},{d},	data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::crash::person::v2::' + if(isDelta, 'delta::', '') +v+'::eid', OPT);
