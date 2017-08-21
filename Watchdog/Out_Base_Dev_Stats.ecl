import strata;

ds := dataset('persist::watchdog_joined',layout_best,flat);

tStats := watchdog.Stats1_best_x_date;

zOrig_Stats := output(choosen(tStats,all));

STRATA.createXMLStats(tStats,'Watchdog','Data',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zPopulation_Stats,'View','Population')

export Out_Base_Dev_Stats := parallel(zOrig_Stats
									  ,zPopulation_Stats
									  );