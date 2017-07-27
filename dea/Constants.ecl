export Constants(string filedate) := module
	// autokey
	export ak_keyname := '~thor_data400::key::dea::@version@::autokey::';
	export ak_logical := '~thor_data400::key::dea::' + filedate + '::autokey::';
  export ak_QAname := '~thor_data400::key::dea::qa::autokey::';
		
	export ak_typestr := 'AK';
	
	// boolean search
	export STRING stem		:= '~thor_data400';
	export STRING srcType := 'dea';
	export STRING qual		:= 'test';
	
  export skip_set := ['P','Q','F'];
end;


//P in this set to skip personal phones
//Q in this set to skip business phones
//S in this set to skip SSN
//F in this set to skip FEIN
//C in this set to skip ALL personal (Contact) data
//B in this set to skip ALL Business data