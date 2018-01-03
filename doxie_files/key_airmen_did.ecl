import faa,doxie, data_services;

export key_airmen_did := index(
	faa.file_airmen_data_out,
	{UNSIGNED8 did := (UNSIGNED8) did_out}, {faa.file_airmen_data_out},
	data_services.data_location.prefix() + 'thor_data400::key::airmen_did_' + doxie.Version_SuperKey);