import ut, _control;

export Entiera_Constants(string filedate = '') := module
	
	export Cluster := Constants.FileNameClusterPrefix;
	
	// autokey
	export ak_keyname := Cluster	+	'key::entiera::autokey::@version@::';
	export ak_qa_keyname := Cluster	+	'key::entiera::autokey::qa::';
	export ak_logical := Cluster	+	'key::entiera::'+filedate+'::autokey::';
	export ak_dataset := File_Entiera_AutoKey;
	export ak_skipSet := ['P','B'];
	export ak_typeStr	:= 'BC';
	
	export STRING stem		:= Cluster	+	'base';
	export STRING srcType:= 'entiera';
	export STRING qual		:= 'test';
end;
