Import Data_Services, doxie;

export key_prep_ccw_did := index(
	file_ccw_keybuild((integer)did_out != 0),
	{UNSIGNED8 did := (UNSIGNED8) did_out}, {file_ccw_keybuild},
	Data_Services.Data_location.Prefix('emerges')+'thor_data400::key::ccw_doxie_did' + thorlib.wuid());