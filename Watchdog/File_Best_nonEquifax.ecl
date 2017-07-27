import ut, data_services;

ds := dataset(data_services.Data_Location.Watchdog_Best + 'thor_data400::BASE::Watchdog_Best_noneq',Layout_Best,thor);


export File_Best_nonEquifax := IF(CLUSTERSIZE = 400, DISTRIBUTED(ds, HASH((INTEGER)did)),
									 DISTRIBUTE(ds, HASH((INTEGER)did)));
