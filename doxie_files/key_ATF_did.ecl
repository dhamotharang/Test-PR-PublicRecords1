import atf,doxie;

export key_ATF_did := index(doxie_files.File_ATF_KeyBuilt,
	{UNSIGNED8 did := (UNSIGNED8) did_out, __fpos},
	'~thor_data400::key::atf_firearms_did_' + doxie.version_superkey);