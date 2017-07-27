import doxie;

export key_prep_atf_trad := index(atf.file_firearms_explosives_keybase,
	{Business_Name, __fpos},
	'~thor_data400::key::atf_firearms_trad' + thorlib.wuid());