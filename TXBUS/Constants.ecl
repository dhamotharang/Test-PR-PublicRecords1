import data_services;

export Constants := module

   export Cluster := data_services.data_location.prefix() + 'thor_data400::';
   
   export autokey_logical(string filedate) := data_services.data_location.prefix() + 'thor_data400::key::txbus::'+ filedate + '::autokey::';
   
   export autokey_keyname := data_services.data_location.prefix() + 'thor_data400::key::txbus::autokey::@version@::';
   
   export autokey_qa_name := data_services.data_location.prefix() + 'thor_data400::key::txbus::autokey::qa::';
   //P in this set to skip personal phones
   //Q in this set to skip business phones
   //S in this set to skip SSN
   //F in this set to skip FEIN
   //C in this set to skip ALL personal (Contact) data
   //B in this set to skip ALL Business data   
   export skip_set := ['F','P','S'];

  // boolean search
	export STRING stem		:= '~thor_data400::base';
	export STRING srcType := 'txbus';
	export STRING qual		:= 'test';

end;