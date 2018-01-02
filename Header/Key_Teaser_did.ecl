import ut, doxie, data_services;

teaser := Header.file_teaser;

export Key_Teaser_did := index(teaser, {did},{teaser},
															 data_services.data_location.prefix() + 'thor_data400::key::watchdog_nonglb.teaser_did_' + doxie.Version_SuperKey);