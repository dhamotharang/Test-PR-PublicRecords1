import AMIDIR, Doxie;

file_in := AMIDIR.File_AMIDIR_DID_SSN_BDID;
AMIDIR_busname_base := file_in(business_name<> '');

dist_busname_base := distribute(AMIDIR_busname_base, hash(business_name));
sort_busname_base := sort(dist_busname_base, business_name,local);
dedup_busname_base := dedup(sort_busname_base, business_name,local);

export key_AMIDIR_busname := index(AMIDIR_busname_base, 
                                {l_busname := business_name},{dedup_busname_base},
				            '~thor_data400::key::amidir_busname_' + Doxie.Version_SuperKey);










