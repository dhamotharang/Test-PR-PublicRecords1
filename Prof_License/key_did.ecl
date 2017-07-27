import doxie;

export key_did := index(
	file_doxie((unsigned)did != 0),
	{UNSIGNED8 s_did := (UNSIGNED8) did}, {file_doxie},
	'~thor_data400::key::prolicense_did' + doxie.version_Keys);