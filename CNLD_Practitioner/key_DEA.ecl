IMPORT doxie, CNLD_Practitioner;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(deanbr != ''),hash(deanbr)),deanbr,gennum,local),deanbr,gennum,local);

EXPORT key_DEA := INDEX(KeyBase,
												{deanbr},
												{gennum},
							          '~thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::DEA');