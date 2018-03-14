Import data_services,doxie;
r:=RECORD,maxlength(60000)
  string256	ind_type_description;
  unsigned2	entity_type_id;
  unsigned2	entity_sub_type_id;
  unsigned8	record_id;
  unsigned8	uid;
 END;

d	:=dataset([],r);

EXPORT Key_CustomerProgram(string Platform) := Index(d,{ind_type_description,entity_type_id,entity_sub_type_id},{d},
																									 data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									 +Platform	+ '::'+ doxie.Version_SuperKey +'::customerprogram');