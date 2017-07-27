import doxie;

export key_prep_atf_lnum := index(atf.file_firearms_explosives_keybase,
	{license_number, __fpos},
	'~thor_data400::key::atf_firearms_lnum' + thorlib.wuid());