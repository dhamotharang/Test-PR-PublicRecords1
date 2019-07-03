import watchdog,data_services,doxie;

//See key_Prep_Watchdog...
export key_watchdog_nonglb_nonblank_old

				:= INDEX(dataset([],watchdog.Layout_best_flags)

					,watchdog.Layout_best_flags
					,data_services.Data_Location.Watchdog_Best 
							
							+ 'thor_data400::key::watchdog_nonglb.did_nonblank_'+doxie.Version_SuperKey
);