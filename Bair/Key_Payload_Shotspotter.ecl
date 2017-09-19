import Data_Services;

r := RECORD
  string23 eid;
  string12 gh12;
  unsigned1 etype;
  unsigned2 raids_record_id;
  string24 shot_id;
  real8 x_coordinate;
  real8 y_coordinate;
  string100 address;
  string50 coordinate;
  unsigned2 shots;
  string50 beat;
  string50 district;
  string50 shot_source;
  string25 shot_datetime;
  unsigned1 shot_incident_type;
  string24 shot_incident_status;
  unsigned4 data_provider_id;
  string50 data_provider_ori;
  string200 data_provider_name;
 END;

d:=dataset([],r);

EXPORT Key_Payload_Shotspotter(string v='qa',boolean isDelta = false) := 
	index(d,{eid},{d},data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::shotspotter::'+ if(isDelta, 'delta::', '')+v+'::eid');
