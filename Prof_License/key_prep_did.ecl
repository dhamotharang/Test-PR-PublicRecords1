df := prof_license.file_keybase;

export key_prep_did := index(
	df((unsigned)did != 0),
	{UNSIGNED6 s_did := (UNSIGNED6) did}, {df.license_number},
	'~thor_data400::key::prolicense_did' + thorlib.wuid());