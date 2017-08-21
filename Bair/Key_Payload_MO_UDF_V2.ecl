import data_services;

r := RECORD
	string23 eid;
  unsigned4 data_provider_id;
  unsigned4 stamp;
  string moudf1;
  string moudf2;
  string moudf3;
  string moudf4;
  string moudf5;
  string moudf6;
  string moudf7;
  string moudf8;
	unsigned1 udf1_type; // 0-none, 1-string, 2-integer, 3-decimal, 4-date, 5-boolean
  unsigned1 udf2_type;
  unsigned1 udf3_type;
  unsigned1 udf4_type;
  unsigned1 udf5_type;
  unsigned1 udf6_type;
  unsigned1 udf7_type;
  unsigned1 udf8_type;
end;


d:=dataset([],r);

EXPORT Key_Payload_MO_UDF_V2(string v='qa', boolean isDelta = false) := 
							index(d,{eid,data_provider_id,stamp},{d},data_services.Data_location.Prefix('BAIR')+
														'thor_data400::key::bair::mo_udfv2::' + if(isDelta, 'delta::', '') + v, OPT);
