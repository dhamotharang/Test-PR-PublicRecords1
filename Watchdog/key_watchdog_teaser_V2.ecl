import header, ut, doxie,Watchdog,data_services;

fake_dataset := dataset([],{Watchdog.key_watchdog_nonglb_nonblank_V2, string20 pfname := ''});

EXPORT key_watchdog_teaser_V2 := index(fake_dataset, {lname, st, pfname, fname, zip}, {fake_dataset},
																		data_services.Data_Location.Watchdog_Best +
																		'thor_data400::key::watchdog_nonglb_noneq.teaser_' + doxie.Version_SuperKey);