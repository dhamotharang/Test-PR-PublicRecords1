IMPORT doxie, CNLD_Practitioner, data_services;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(zip != ''),hash(zip)),zip,gennum,local),zip,gennum,local);

EXPORT key_ZIP := INDEX(KeyBase,
												{zip},
												{gennum},
							          data_services.data_location.prefix() + 'thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::zip');