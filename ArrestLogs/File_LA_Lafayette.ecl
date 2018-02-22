import ut, Data_Services;
export File_LA_Lafayette  := dataset(data_services.data_location.prefix() + 'thor_data400::in::arrlog::la::lafayette',	
				Layout_LA_Lafayette,csv(heading(1),terminator('\n'), separator('|')));
				
				