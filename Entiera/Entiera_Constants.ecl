import ut;

export Entiera_Constants(string filedate='') := module
	
	export Cluster := '~thor_200::';
	
	// autokey
	export ak_keyname := '~thor_200::key::entiera::autokey::@version@::';
	export ak_qa_keyname := '~thor_200::key::entiera::autokey::qa::';
	export ak_logical := '~thor_200::key::entiera::'+filedate+'::autokey::';
	export ak_dataset := File_Entiera_AutoKey;
	export ak_skipSet := ['P','B'];
	export ak_typeStr	:= 'BC';
	
	export STRING stem		:= '~thor_200::base';
	export STRING srcType:= 'entiera';
	export STRING qual		:= 'test';
end;
