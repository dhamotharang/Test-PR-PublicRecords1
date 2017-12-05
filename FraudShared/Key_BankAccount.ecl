Import data_services;
r:=RECORD,maxlength(60000)
  string20 bank_account_number_1;
  string20 bank_routing_number_1;
  string20 bank_account_number_2;
  string20 bank_routing_number_2;
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;
d	:=dataset([],r);

EXPORT Key_BankAccount(string Platform) := Index(d,{bank_account_number_1,bank_routing_number_1,bank_account_number_2,bank_routing_number_2,entity_type_id,entity_sub_type_id},{d},
																									 data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									 +Platform	+'::qa::BankAccount');