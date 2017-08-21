Import Data_Services, doxie;

export key_prep_hunters_did := index(
	emerges.file_hunters_keybuild((integer)did_out != 0),
	{UNSIGNED8 did := (UNSIGNED8) did_out}, {emerges.file_hunters_keybuild},
	Data_Services.Data_location.Prefix('emerges')+'thor_data400::key::hunters_doxie_did' + thorlib.wuid());