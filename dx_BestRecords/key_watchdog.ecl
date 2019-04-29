IMPORT $;
IMPORT doxie, Data_Services;

rec_key := $.layout_best;

string lfn := data_services.data_location.prefix ('Watchdog_Best') +
                'thor_data400::key::watchdog_' + doxie.Version_SuperKey;
								
EXPORT key_watchdog(integer data_category = 0) := INDEX({rec_key.did}, rec_key-did, lfn, OPT);
