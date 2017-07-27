export Constants(string filedate='') := module
	// autokey
	export ak_keyname := '~thor_data400::key::mar_div::autokey::';
	export ak_logical := '~thor_data400::key::mar_div::'+filedate+'::autokey::';
	export ak_dataset := marriage_divorce_v2.file_searchautokey;
	export ak_skipSet := ['P','S','B','Q','F'];
	export ak_typeStr	:= 'BC';
	
	export STRING stem		:= '~thor_data400::base';
	export STRING srcType:= 'md';
	export STRING qual		:= 'test';
end;
