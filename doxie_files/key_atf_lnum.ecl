import doxie, data_services;

export key_atf_lnum := index(doxie_files.File_ATF_KeyBuilt,
	{license_number, __fpos},
	data_services.data_location.prefix() + 'thor_data400::key::atf_firearms_lnum_' + doxie.Version_SuperKey);