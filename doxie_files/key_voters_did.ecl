import emerges,doxie;

export key_voters_did := index(
	doxie_files.file_voters_keybase,
	{UNSIGNED8 did := (UNSIGNED8) did_out}, {doxie_files.file_voters_keybase},
	'~thor_data400::key::voters_doxie_did_' + doxie.Version_SuperKey);