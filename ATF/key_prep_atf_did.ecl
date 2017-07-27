import doxie;

export key_prep_atf_did := index(atf.file_firearms_explosives_keybase((integer)did_out != 0),
	{UNSIGNED8 did := (UNSIGNED8) did_out, __fpos},
	'~thor_data400::key::atf_firearms_did' + thorlib.wuid());