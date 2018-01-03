import doxie, data_services;

df := file_proflicense_keybuilt;

export key_proflic_did := index(
	df((unsigned)did != 0), //
	{UNSIGNED6 s_did := (UNSIGNED6) did}, {df},
	data_services.data_location.prefix() + 'thor_data400::key::prolicense_did_' + doxie.Version_SuperKey);