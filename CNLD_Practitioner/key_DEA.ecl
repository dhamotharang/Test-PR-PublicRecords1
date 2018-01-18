IMPORT doxie, CNLD_Practitioner, data_services;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(deanbr != ''),hash(deanbr)),deanbr,gennum,local),deanbr,gennum,local);

EXPORT key_DEA := INDEX(KeyBase,
												{deanbr},
												{gennum},
							          data_services.data_location.prefix() + 'thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::DEA');