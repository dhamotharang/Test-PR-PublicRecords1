import header, ut, doxie,Watchdog,data_services;

fake_dataset := dataset([],{Watchdog.key_watchdog_nonglb_nonblank_V2_old, string20 pfname := ''});

EXPORT key_watchdog_teaser_V2_old := index(fake_dataset, {lname, st, pfname, fname, zip}, {fake_dataset},
																		data_services.foreign_prod+
																		'thor_data400::key::watchdog_nonglb_noneq.teaser_' + doxie.Version_SuperKey);
																		

