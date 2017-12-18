import doxie,data_services;
delta_file := watchdog.File_Delta;
export Key_Watchdog_Delta := index(watchdog.File_Delta,{did},{delta_file},data_services.data_location.prefix() + 'thor_data400::key::watchdog_delta.did_' + doxie.Version_SuperKey);