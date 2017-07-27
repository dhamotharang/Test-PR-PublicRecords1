import data_services;

export Constants(string filedate) := module
	// autokey
	export ak_keyname := Data_services.Data_location.prefix('Watercraft') + 'thor_data400::' + 'key::watercraft::autokey::';
	export ak_logical := Data_services.Data_location.prefix('Watercraft') + 'thor_data400::' + 'key::watercraft::' + filedate + '::autokey::';
	export ak_typeStr := 'VESS';
	
	// autokey for BIDs
	export ak_keyname_bid := Data_services.Data_location.prefix('Watercraft') + 'thor_data400::' + 'key::watercraft::autokey::bid::';
	export ak_logical_bid := Data_services.Data_location.prefix('Watercraft') + 'thor_data400::' + 'key::watercraft::' + filedate + '::autokey::bid::';
	export ak_typeStr_bid := 'VESS';
	
	// boolean search
	export STRING stem		:= Data_services.Data_location.prefix('Watercraft') + 'thor_data400';
	export STRING srcType := 'WATERCRAFT';
	export STRING qual		:= 'test';
	
end;