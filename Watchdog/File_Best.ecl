import ut,_Control,data_services, watchdog,PRTE2_Header,PRTE2_Watchdog;

boolean is_NewLayout := true; // for build set to true so it will build the file in new layout
//ds := dataset(data_services.Data_Location.Watchdog_Best + 'thor_data400::BASE::Watchdog_Best',Layout_Best,thor);
ds := dataset(data_services.foreign_prod + 'thor_data400::BASE::Watchdog_Best',watchdog.Layout_Best,thor);


watchdog.Mac_File_Best(ds,is_NewLayout,outfile);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export File_Best := PRTE2_Watchdog.Files.file_best;
#ELSE
export File_Best := IF(CLUSTERSIZE = 400, DISTRIBUTED(outfile, HASH((INTEGER)did)),
									 DISTRIBUTE(outfile, HASH((INTEGER)did)));
#END