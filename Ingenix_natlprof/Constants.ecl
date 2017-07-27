export Constants := module
	
	export cluster          := '~thor_data400::';
	
	export autokeyname_prov := cluster + 'key::ingenix_providers::autokey::@version@::';
	
	export autokeyname_sanc := cluster + 'key::ingenix_Sanctions::autokey::@version@::';
	
	export provider_AutokeyLogicalName(string filedate)  := cluster + 'key::ingenix_providers::' +filedate+ '::autokey::';
    
	export sanctions_AutokeyLogicalName(string filedate) := cluster + 'key::ingenix_sanctions::' +filedate+ '::autokey::';
	
	export autokey_qa_name_prov := cluster + 'key::ingenix_providers::autokey::qa::';
	
	export autokey_qa_name_sanc := cluster + 'key::ingenix_sanctions::autokey::qa::';
		
	export autokey_typeStr_prov := 'PROV';
	
	export autokey_typeStr_sanc := 'SANC';

	export STRING stem	:= '~thor_data400::base';
	
	export STRING SrcType_sanc := 'ingenix::sanctions';
	
	export STRING SrcType_prov := 'ingenix::provider';
	
	export STRING qual		:= 'test';	 
	
	  //P in this set to skip personal phones
    //Q in this set to skip business phones
    //S in this set to skip SSN
    //F in this set to skip FEIN
    //C in this set to skip ALL personal (Contact) data
    //B in this set to skip ALL Business data  
	export autokey_skip_set_prov := ['B','S'];
	
  // Provider Screening Phase 2 enhancements to add business name to autokeys
	export autokey_skip_set_sanc := ['F','Q', 'P','S'];
	
end;
