Import data_services;
r:=RECORD,maxlength(60000)
  unsigned6 appended_provider_id;
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
END;
d	:=dataset([],r);

EXPORT Key_Appproviderid(string Platform) := Index(d,{appended_provider_id,entity_type_id,entity_sub_type_id},{d},
																									 data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									 +Platform	+'::qa::appproviderid');