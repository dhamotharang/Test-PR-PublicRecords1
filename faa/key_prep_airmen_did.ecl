export key_prep_airmen_did := index(
	file_airmen_data_bldg((integer)did_out != 0),
	{UNSIGNED8 did := (UNSIGNED8) did_out}, {file_airmen_data_bldg},
	'~thor_data400::key::airmen_did' + thorlib.wuid());