export Constants(string filedate) := module
	// autokey
	export autokey_keyname  := Cluster+'key::infutor::autokey::@version@::';
	export autokey_logical  := '~thor_data400::' + 'key::infutor::' + filedate + '::autokey::';
	export ak_typeStr := '\'AK\'';
	export autokey_skip_set := ['Q','F','B'];
	
end;