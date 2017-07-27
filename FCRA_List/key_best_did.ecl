Import Data_Services, doxie, FCRA_list;

Best_FCRA_list := FCRA_list.file_best;

//build index on DID

export Key_Best_did := INDEX(Best_FCRA_list,{did},{Best_FCRA_list},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::watchdog_best_FCRA_list::'+ doxie.Version_SuperKey+ '::did');