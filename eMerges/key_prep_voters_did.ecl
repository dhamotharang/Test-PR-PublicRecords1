import doxie, data_services;

export key_prep_voters_did := index(
	emerges.file_voters_keybuild((integer)did_out != 0),
	{UNSIGNED8 did := (UNSIGNED8) did_out}, {emerges.file_voters_keybuild},
	data_services.data_location.prefix() + 'thor_data400::key::voters_doxie_did' + thorlib.wuid());