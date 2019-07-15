Import data_services,doxie;
r:=RECORD,maxlength(60000)
  string5		zip;
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;

d	:=dataset([],r);

EXPORT Key_Zip(string Platform) := Index(d,{zip,entity_type_id,entity_sub_type_id},{d},
																									 data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									 +Platform	+ '::'+ doxie.Version_SuperKey +'::zip');