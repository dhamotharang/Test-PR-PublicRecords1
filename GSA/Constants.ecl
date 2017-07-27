import tools;
export Constants(string filedate = '') := module    

	export str_autokeyname   := cluster+'key::gsa::autokey::qa::';
	export ak_keyname	     := cluster+'key::gsa::autokey::@version@::';
	export ak_logical	     := cluster+'key::gsa::'+filedate+'::autokey::';
	export ak_dataset	     := file_SearchAutokey();
	export ak_skipSet	     := ['P','Q','S','F'];
	export ak_typeStr	     := 'AK';
	export ak_qa_keyname	 := cluster+'key::gsa::autokey::qa::';
	export IsTesting			 := Tools._Constants.IsDataland;
	
	end;
