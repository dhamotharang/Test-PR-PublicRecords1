IMPORT doxie, CNLD_Practitioner;

KeyBase := CNLD_Practitioner.Files().KeyBuild.Built(gennum != '');

EXPORT key_PractitionerID := INDEX(KeyBase,
																	{gennum},
																	{keybase},
																	'~thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::PractitionerID');