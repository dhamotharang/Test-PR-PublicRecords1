IMPORT doxie, CNLD_Practitioner, data_services;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(did != 0),hash(did)),did,gennum,local),did,gennum,local);

EXPORT key_DID := INDEX(KeyBase,
												{did},
												{gennum},
							          data_services.data_location.prefix() + 'thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::DID');