Import data_services;
r:=RECORD,maxlength(60000)
	unsigned8 hash64_host; 
	unsigned8 hash64_user;	
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;
d	:=dataset([],r);

EXPORT Key_Host(string Platform) :=	Index(d,{hash64_host,hash64_user,entity_type_id,entity_sub_type_id},{d},
																				data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																				+Platform	+'::qa::host');


