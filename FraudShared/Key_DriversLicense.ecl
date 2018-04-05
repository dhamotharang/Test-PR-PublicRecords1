Import data_services;
r:=RECORD,maxlength(60000)
  string25 drivers_license;
  string2 drivers_license_state;
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;
d	:=dataset([],r);

EXPORT Key_DriversLicense(string Platform) := Index(d,{drivers_license,drivers_license_state,entity_type_id,entity_sub_type_id},{d},
																									 data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									 +Platform	+'::qa::DriversLicense');