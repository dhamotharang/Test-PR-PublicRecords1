import ut;
ds := dataset('~thor_data400::BASE::Watchdog_Best_nonen_father',Layout_Best,thor);


export File_previous_Best_nonExperian := IF(CLUSTERSIZE = 400, DISTRIBUTED(ds, HASH((INTEGER)did)),
									 DISTRIBUTE(ds, HASH((INTEGER)did)));
