import ut, _control;

export Constants (string filedate = '') := module
	
	export Cluster := '~thor_200::';
	
	// autokey
	export ak_keyname := Cluster	+	'key::email_data::autokey::@version@::';
	export ak_qa_keyname := Cluster	+	'key::email_data::autokey::qa::';
	export ak_logical := Cluster	+	'key::email_data::'+filedate+'::autokey::';
	export ak_dataset := File_AutoKey;
	export ak_skipSet := ['P','B'];
	export ak_typeStr	:= 'BC';
	export STRING srcType:= 'email_data';
end;
