import data_services;

export Constants(string filedate) := module
	
	// boolean search
	export STRING stem		:= data_services.data_location.prefix() + 'thor_data400';
	export STRING srcType := 'Abius';
	export STRING qual		:= 'test';
	
end;