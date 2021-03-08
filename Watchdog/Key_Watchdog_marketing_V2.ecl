import doxie,data_services; 
//See key_Prep_Watchdog...
export Key_Watchdog_marketing_V2 :=	INDEX(file_best_marketing

		,watchdog.Layout_best_flags
		,Data_services.Data_location.Prefix('Watchdog_Best')
			+'thor_data400::key::watchdog_marketing_noneq.did_'+doxie.Version_SuperKey);
