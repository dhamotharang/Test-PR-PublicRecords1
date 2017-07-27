import doxie,ut;
df := file_proflicense_keybuilt;


export key_proflic_did := index(
	df((unsigned)did != 0), //
	{UNSIGNED6 s_did := (UNSIGNED6) did}, {df},
	'~thor_data400::key::prolicense_did_' + doxie.Version_SuperKey);