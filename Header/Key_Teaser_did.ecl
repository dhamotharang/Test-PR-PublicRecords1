import ut, doxie;

teaser := Header.file_teaser;

export Key_Teaser_did := index(teaser, {did},{teaser},
															 '~thor_data400::key::watchdog_nonglb.teaser_did_' + doxie.Version_SuperKey);