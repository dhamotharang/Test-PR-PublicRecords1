import ut, Data_Services;
ds := dataset(Data_Services.Data_Location.Watchdog_Best + 'thor_data400::BASE::Watchdog_Best_nonglb',Layout_Best,thor);



export File_Best_nonglb := IF(CLUSTERSIZE = 400, ds,
									DISTRIBUTE(ds, HASH((INTEGER)did)));