IMPORT doxie, CNLD_Practitioner;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(did != 0),hash(did)),did,gennum,local),did,gennum,local);

EXPORT key_DID := INDEX(KeyBase,
												{did},
												{gennum},
							          '~thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::DID');