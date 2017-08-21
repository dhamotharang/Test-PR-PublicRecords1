import data_services;

r := RECORD
 unsigned5 recordid_raids;
  unsigned4 ori;
  unsigned4 id;
  unsigned2 fieldid;
  string150 string_val;
  integer8 integer_val;
  real8 decimal_val;
  string25 datetime_val;
  string1 yes_no_val;
 END;


d:=dataset([],r);

EXPORT Key_Payload_Person_UDF(string v='qa', boolean isDelta = false) := 
							index(d,{recordid_raids,ori},{d},data_services.Data_location.Prefix('BAIR')+
														'thor_data400::key::bair::persons_udf::' + if(isDelta, 'delta::', '') + v,OPT);
