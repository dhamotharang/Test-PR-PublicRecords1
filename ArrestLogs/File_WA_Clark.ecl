import ut, Data_Services;

export File_WA_clark  := dataset(data_services.data_location.prefix() + 'thor_data400::in::arrlog::wa::clark',	
				Layout_WA_clark,csv(heading(1),terminator('\n'), separator('|')));