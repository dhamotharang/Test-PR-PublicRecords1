import ut,Data_Services;
ds := dataset(Data_Services.Data_Location.Watchdog_Best + 'thor_data400::base::watchdog_best_nonen_noneq',Layout_Best,thor);


export File_Best_nonEquifax_nonExperian := IF(CLUSTERSIZE = 400, DISTRIBUTED(ds, HASH((INTEGER)did)),
									 DISTRIBUTE(ds, HASH((INTEGER)did)));