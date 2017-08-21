//Virginia Dept. of Profess./Occupational Regulation / Multiple Professions //


export files_VAS0849 := MODULE
	export active := dataset('~thor_data400::in::proflic_mari::vas0849::using::active_license',Prof_License_Mari.layout_VAS0849.src,csv(SEPARATOR('\t'),heading(1)));
	export inactive := dataset('~thor_data400::in::proflic_mari::vas0849::using::inactive_license',Prof_License_Mari.layout_VAS0849.src,csv(SEPARATOR('\t'),heading(1)));
	
END;

