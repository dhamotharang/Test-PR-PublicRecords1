Import data_services;
r:=RECORD,maxlength(60000)
	unsigned8 hash64_user;	
	unsigned8 hash64_host; 
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;
d	:=dataset([],r);

EXPORT Key_User(string Platform) :=	Index(d,{hash64_user,hash64_host,entity_type_id,entity_sub_type_id},{d},
																				data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																				+Platform	+'::qa::user');


