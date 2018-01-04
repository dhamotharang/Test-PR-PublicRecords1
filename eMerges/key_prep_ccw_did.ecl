import doxie, data_services;

export key_prep_ccw_did := index(
	file_ccw_keybuild((integer)did_out != 0),
	{UNSIGNED8 did := (UNSIGNED8) did_out}, {file_ccw_keybuild},
	data_services.data_location.prefix() + 'thor_data400::key::ccw_doxie_did' + thorlib.wuid());