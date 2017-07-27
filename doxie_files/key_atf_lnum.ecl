import atf,doxie;

export key_atf_lnum := index(doxie_files.File_ATF_KeyBuilt,
	{license_number, __fpos},
	'~thor_data400::key::atf_firearms_lnum_' + doxie.Version_SuperKey);