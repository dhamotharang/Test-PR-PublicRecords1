import doxie;
delta_file := watchdog.File_Delta;
export Key_Watchdog_Delta := index(watchdog.File_Delta,{did},{delta_file},'~thor_data400::key::watchdog_delta.did_' + doxie.Version_SuperKey);