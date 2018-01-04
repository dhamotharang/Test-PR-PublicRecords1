IMPORT doxie, CNLD_Practitioner, data_services;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(npi != ''),hash(npi)),npi,gennum,local),npi,gennum,local);

EXPORT key_NPI := INDEX(KeyBase,
												{NPI},
												{gennum},
							          data_services.data_location.prefix() + 'thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::NPI');