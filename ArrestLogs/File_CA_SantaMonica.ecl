Import ArrestLogs,data_services;

EXPORT File_CA_SantaMonica := MODULE


	EXPORT raw	:= dataset(data_services.foreign_prod+'thor_data400::in::arrlog::ca::santa_monica',ArrestLogs.layout_CA_SantaMonica.raw_in_new, CSV(SEPARATOR(','),heading(1),quote('"')));

	
END;