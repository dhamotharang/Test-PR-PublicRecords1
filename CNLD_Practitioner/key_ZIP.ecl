IMPORT doxie, CNLD_Practitioner;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(zip != ''),hash(zip)),zip,gennum,local),zip,gennum,local);

EXPORT key_ZIP := INDEX(KeyBase,
												{zip},
												{gennum},
							          '~thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::zip');