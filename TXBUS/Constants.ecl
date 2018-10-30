import Data_Services;

export Constants := module

   export Cluster := '~thor_data400::';   
	 
	 export cleaned_name := '~thor_data400::in::txbus::qa::Clean_updates::Superfile';
	 
	 export base_name := '~thor_data400::base::txbus::basefile';
   
   export autokey_logical(string filedate) := '~thor_data400::key::txbus::'+ filedate + '::autokey::';
   
   export autokey_keyname := '~thor_data400::key::txbus::autokey::@version@::';
   
   export autokey_qa_name := '~thor_data400::key::txbus::autokey::qa::';
	 
	 export bid_autokey_logical(string filedate) := '~thor_data400::key::txbus::'+ filedate + '::autokey::bid::';
   
   export bid_autokey_keyname := '~thor_data400::key::txbus::autokey::@version@::bid::';
   
   export bid_autokey_qa_name := '~thor_data400::key::txbus::autokey::qa::bid::';
	 
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
	
	export Build_BID_Keys := true;

end;