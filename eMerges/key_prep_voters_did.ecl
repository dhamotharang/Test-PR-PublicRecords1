Import Data_Services, doxie;

export key_prep_voters_did := index(
	emerges.file_voters_keybuild((integer)did_out != 0),
	{UNSIGNED8 did := (UNSIGNED8) did_out}, {emerges.file_voters_keybuild},
	Data_Services.Data_location.Prefix('emerges')+'thor_data400::key::voters_doxie_did' + thorlib.wuid());