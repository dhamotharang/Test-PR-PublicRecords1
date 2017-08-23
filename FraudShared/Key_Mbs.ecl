Import data_services;
r:=RECORD,maxlength(60000)
  unsigned6 fdn_file_info_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;
 
d	:=dataset([],r);

EXPORT Key_Mbs(string Platform) :=	Index(d,{fdn_file_info_id},{d},
																					data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																					+Platform +'::qa::mbs');
