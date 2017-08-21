import AMIDIR, Doxie;

file_in := AMIDIR.File_AMIDIR_DID_SSN_BDID;
AMIDIR_DEA_base := file_in(DEA_number<>'');

dist_DEA_base := distribute(AMIDIR_DEA_base, hash(DEA_number));
sort_DEA_base := sort(dist_DEA_base,DEA_number,local);
dedup_DEA_base := dedup(sort_DEA_base, DEA_number,local);

export key_AMIDIR_DEA := index(AMIDIR_DEA_base, 
                                {l_DEA := DEA_number},{dedup_DEA_base},
				            '~thor_data400::key::amidir_DEA_' + Doxie.Version_SuperKey);





