export Constants(string filedate) := module
	// autokey
	export autokey_keyname := '~thor_data400::key::voters::autokey::@version@::';
	export autokey_logical := '~thor_data400::key::voters::' + filedate + '::autokey::';

	export STRING stem		:= '~thor_data400::base';
	export STRING srcType:= 'votersv2';
	export STRING qual		:= 'test';
end;