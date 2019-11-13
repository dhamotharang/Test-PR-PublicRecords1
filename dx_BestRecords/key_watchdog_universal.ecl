IMPORT $;
IMPORT dx_BestRecords,data_services,doxie;

rec_key:=$.layout_watchdog_merged;

string lfn  := Data_Services.Data_Location.Watchdog_Best +'thor_data400::key::watchdog_' + doxie.Version_SuperKey;

EXPORT key_watchdog_universal(integer data_category = 0) := INDEX({rec_key.did}, {rec_key-did}, lfn,OPT);



