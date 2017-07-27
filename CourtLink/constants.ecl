export Constants(string pVersion = '') := module    

	export str_autokeyname   := cluster+'key::courtLink::autokey::qa::';
	export ak_keyname	     := cluster+'key::courtLink::autokey::@version@::';
	export ak_logical	     := cluster+'key::courtLink::'+pVersion+'::autokey::';
	export ak_dataset	     := courtLink.fileSearchAutokey();
	export ak_skipSet	     := ['P','Q','S','F'];
	export ak_typeStr	     := 'AK';
	export ak_qa_keyname	 := cluster+'key::courtLink::autokey::qa::';
	
	end;