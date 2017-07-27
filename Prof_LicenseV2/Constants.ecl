export Constants := module

   export Cluster := '~thor_data400::';
   
   export autokey_logical(string filedate) := '~thor_data400::key::prolicV2::'+ filedate + '::autokey::';
   
   export autokey_keyname := '~thor_data400::key::prolicV2::autokey::@version@::';
   
   export autokey_qa_name := '~thor_data400::key::prolicV2::autokey::qa::';
	 
	 export bid_autokey_logical(string filedate) := '~thor_data400::key::prolicV2::'+ filedate + '::autokey::bid::';
   
   export bid_autokey_keyname := '~thor_data400::key::prolicV2::autokey::@version@::bid::';
   
   export bid_autokey_qa_name := '~thor_data400::key::prolicV2::autokey::qa::bid::';

	 export STRING stem		:= '~thor_data400::base';
	 export STRING srcType:= 'Prolic';
	 export STRING qual		:= 'test';	 
   //P in this set to skip personal phones
   //Q in this set to skip business phones
   //S in this set to skip SSN
   //F in this set to skip FEIN
   //C in this set to skip ALL personal (Contact) data
   //B in this set to skip ALL Business data   
   export skip_set := ['F','P'];
	 
	 EXPORT BUILD_BID_KEYS   := TRUE;
   EXPORT JOIN_LIMIT_LARGE := 1000;
   EXPORT JOIN_LIMIT_SMALL := 100;
   
end;