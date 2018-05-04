Import data_services,doxie;
r:=RECORD,maxlength(60000)
  unsigned1 octet1;
  unsigned1 octet2;
  unsigned1 octet3;
  unsigned1 octet4;
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;
d	:=dataset([],r);

EXPORT Key_IPRange(string Platform) :=	Index(d,{octet1,octet2,octet3,octet4,entity_type_id,entity_sub_type_id},{d},
																				data_services.Data_location.Prefix(Platform) +'thor_data400::key::' 
																				+Platform	+ '::'+ doxie.Version_SuperKey +'::iprange');
