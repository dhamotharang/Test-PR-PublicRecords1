Import data_services;
r:=RECORD,maxlength(60000)
  string50 email_address;
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;
d	:=dataset([],r);

EXPORT Key_Email(string Platform) :=	Index(d,{email_address,entity_type_id,entity_sub_type_id},{d},
																						data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																						+Platform +'::qa::email');

