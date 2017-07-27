IMPORT doxie, CNLD_Practitioner;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(upin_num != ''),hash(upin_num)),upin_num,gennum,local),upin_num,gennum,local);

EXPORT key_UPIN := INDEX(KeyBase,
												{upin_num},
												{gennum},
							          '~thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::UPIN');