import Data_Services;

r := RECORD
  string23 eid;
  unsigned4 vehicleid;
  string20 vin;
  string20 plate;
  string20 platestate;
  string10 year;
  string40 make;
  string30 model;
  string1 towed;
  string50 vehicle_type;
  string damage;
  string action;
  string sequence;
  string driverimpairment;
  unsigned4 data_provider_id;
 END;

d:=dataset([],r);
 
 EXPORT Key_Payload_Crash_Vehicle(string v='qa',boolean isDelta = false) := INDEX(d,{eid},{d},	data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::crash::vehicle::v2::' + if(isDelta, 'delta::', '') +v+'::eid', OPT);
