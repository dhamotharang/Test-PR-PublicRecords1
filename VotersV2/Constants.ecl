import data_services;

export Constants(string filedate) := module
	// autokey
	export autokey_keyname := data_services.data_location.prefix() + 'thor_data400::key::voters::autokey::@version@::';
	export autokey_logical := data_services.data_location.prefix() + 'thor_data400::key::voters::' + filedate + '::autokey::';

	export STRING stem		:= '~thor_data400::base';
	export STRING srcType:= 'votersv2';
	export STRING qual		:= 'test';
end;