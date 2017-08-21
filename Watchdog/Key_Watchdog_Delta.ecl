Import Data_Services, doxie,ut;
_delta_file := watchdog.File_Delta;
ut.mac_suppress_by_phonetype(_delta_file,phone,st,delta_file,true,did);
export Key_Watchdog_Delta := index(delta_file,{did},{delta_file},Data_Services.Data_location.Prefix('Watchdog_Best')+'thor_data400::key::watchdog_delta.did_' + doxie.Version_SuperKey);