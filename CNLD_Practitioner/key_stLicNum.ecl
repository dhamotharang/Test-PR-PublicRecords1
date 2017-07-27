IMPORT doxie, CNLD_Practitioner;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(st_lic_in !='' and st_lic_num !=''),hash(st_lic_in,st_lic_num)),st_lic_in,st_lic_num,gennum,local),st_lic_in,st_lic_num,gennum,local);

EXPORT key_stLicNum := INDEX(KeyBase,
														{st_lic_in,st_lic_num},
														{gennum},
														'~thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::stLicNum');