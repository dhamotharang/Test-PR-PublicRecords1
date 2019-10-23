Import data_services,doxie;
r:=RECORD,maxlength(60000)
  string25		mac_address;
  unsigned2	entity_type_id;
  unsigned2	entity_sub_type_id;
  unsigned8	record_id;
  unsigned8	uid;
 END;

d	:=dataset([],r);

EXPORT Key_MACAddress(string Platform) := Index(d,{mac_address,entity_type_id,entity_sub_type_id},{d},
																									 data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									 +Platform	+ '::'+ doxie.Version_SuperKey +'::macaddress');