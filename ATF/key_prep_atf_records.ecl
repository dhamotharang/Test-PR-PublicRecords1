import doxie;

export key_prep_atf_records := index(atf.file_firearms_explosives_keybase,
	{UNSIGNED8 fpos := __fpos}, {atf.file_firearms_explosives_keybase},
	'~thor_data400::key::atf_firearms_records' + thorlib.wuid());