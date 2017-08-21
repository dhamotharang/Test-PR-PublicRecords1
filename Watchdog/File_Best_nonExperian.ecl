import ut,Data_Services;
ds := dataset(Data_Services.Data_Location.Watchdog_Best + 'thor_data400::BASE::Watchdog_Best_nonen',Layout_Best,thor);


export File_Best_nonExperian := IF(CLUSTERSIZE = 400, DISTRIBUTED(ds, HASH((INTEGER)did)),
									 DISTRIBUTE(ds, HASH((INTEGER)did)));
