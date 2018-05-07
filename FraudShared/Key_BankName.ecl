Import data_services,doxie;
r:=RECORD  
	string50 bank_name;
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;
d	:=dataset([],r);

EXPORT Key_BankName(string Platform) := Index(d,{bank_name,entity_type_id,entity_sub_type_id},{d},
																									 data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									 +Platform	+ '::'+ doxie.Version_SuperKey +'::bankname');