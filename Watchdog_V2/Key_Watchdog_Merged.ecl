IMPORT doxie, Data_Services;

	ds := PROJECT(watchdog_V2.File_Merged, Watchdog_V2.Layout_Key_Merged);

EXPORT Key_Watchdog_Merged  := 
	 INDEX(ds,{did}, {ds},
			Data_Services.Data_location.Prefix('Watchdog_Best')+ 'thor_data400::key::watchdog_merged_'+doxie.Version_SuperKey);
