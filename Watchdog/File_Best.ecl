import ut,_Control,data_services, watchdog;

boolean is_NewLayout := true; // for build set to true so it will build the file in new layout
//ds := dataset(data_services.Data_Location.Watchdog_Best + 'thor_data400::BASE::Watchdog_Best',Layout_Best,thor);
ds := dataset(ut.foreign_prod + 'thor_data400::BASE::Watchdog_Best',watchdog.Layout_Best,thor);


watchdog.Mac_File_Best(ds,is_NewLayout,outfile);

export File_Best := IF(CLUSTERSIZE = 400, DISTRIBUTED(outfile, HASH((INTEGER)did)),
									 DISTRIBUTE(outfile, HASH((INTEGER)did)));