IMPORT doxie,ut,_Control,Watchdog,Data_Services;

EXPORT Key_watchdog_glb_nonutil_old := INDEX(	watchdog.File_Best_nonutility,
																					Watchdog.Layout_Key,
																					Data_Services.Data_location.Prefix('Watchdog_Best') 
																						+ 'thor_data400::key::watchdog_best_nonutil.did_'
																							+doxie.Version_SuperKey
																				);