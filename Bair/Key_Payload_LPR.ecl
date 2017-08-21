import Data_Services;

r := RECORD
  string23 eid;
  string12 gh12;
  unsigned1 etype;
  string100 licenseplaterecordguid;
  string100 eventnumber;
  string25 capturedatetime;
  string40 plate;
  string40 platealternate;
  integer8 confidence;
  real8 x_coordinate;
  real8 y_coordinate;
  string50 coordinate;
  unsigned4 data_provider_id;
  string50 data_provider_ori;
  string200 data_provider_name;
	boolean has_image;
END;


d:=dataset([],r);

EXPORT Key_Payload_LPR(string v='qa', boolean isDelta = false) := 
							index(d,{eid},{d},data_services.Data_location.Prefix('BAIR') +
														'thor_data400::key::bair::licenseplateevent::' + if(isDelta, 'delta::', '') + v + '::eid',OPT);
							
