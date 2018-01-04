IMPORT doxie, CNLD_Practitioner, data_services;

KeyBase := CNLD_Practitioner.Files().KeyBuild.Built(gennum != '');

EXPORT key_PractitionerID := INDEX(KeyBase,
																	{gennum},
																	{keybase},
																	data_services.data_location.prefix() + 'thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::PractitionerID');