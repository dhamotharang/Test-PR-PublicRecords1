IMPORT doxie, CNLD_Practitioner;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(npi != ''),hash(npi)),npi,gennum,local),npi,gennum,local);

EXPORT key_NPI := INDEX(KeyBase,
												{NPI},
												{gennum},
							          '~thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::NPI');