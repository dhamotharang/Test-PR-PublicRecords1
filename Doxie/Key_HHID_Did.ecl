import header, data_services;

hf := header.File_HHID_Current;

export Key_HHID_Did := index(
	hf,	{hhid_relat, ver}, {did},
	data_services.data_location.prefix() + 'thor_data400::key::hhid_did_' + version_superkey, OPT);