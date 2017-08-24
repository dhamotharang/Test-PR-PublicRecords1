import data_services;

r := RECORD
	string23 eid;
  unsigned4 data_provider_id;
  unsigned4 stamp;
  string personudf1;
  string personudf2;
  string personudf3;
  string personudf4;
	unsigned1 personudf1_type; // 0-none, 1-string, 2-integer, 3-decimal, 4-date, 5-boolean
  unsigned1 personudf2_type;
  unsigned1 personudf3_type;
  unsigned1 personudf4_type;
end;

d:=dataset([],r);

EXPORT Key_Payload_Person_UDF_V2(string v='qa', boolean isDelta = false) := 
							index(d,{eid,data_provider_id,stamp},{d},data_services.Data_location.Prefix('BAIR')+
														'thor_data400::key::bair::persons_udfv2::' + if(isDelta, 'delta::', '') + v,OPT);