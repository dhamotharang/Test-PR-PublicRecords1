import doxie, data_services;

export key_ATF_records := index(doxie_files.File_ATF_KeyBuilt,
	{UNSIGNED8 fpos := __fpos}, {doxie_files.File_ATF_KeyBuilt},
	data_services.data_location.prefix() + 'thor_data400::key::atf_firearms_records_' + doxie.Version_SuperKey);