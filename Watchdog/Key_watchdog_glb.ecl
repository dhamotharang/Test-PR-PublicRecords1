import doxie,ut,_Control,data_services, vault;

#IF(_Control.Environment.onVault) 
export Key_Watchdog_glb := ungroup(vault.Watchdog.Key_watchdog_glb);
#ELSE
export Key_Watchdog_glb := INDEX(file_best,
                                 Layout_Key,
                                 data_services.data_location.prefix() + 'thor_data400::key::watchdog_best.did_'+doxie.Version_SuperKey);
#END;


