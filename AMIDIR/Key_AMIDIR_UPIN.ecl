import AMIDIR, Doxie;

file_in := AMIDIR.File_AMIDIR_DID_SSN_BDID;
AMIDIR_UPIN_base := file_in(UPIN<>'');

dist_UPIN_base := distribute(AMIDIR_UPIN_base, hash(UPIN));
sort_UPIN_base := sort(dist_UPIN_base,UPIN,local);
dedup_UPIN_base := dedup(sort_UPIN_base, UPIN,local);

export key_AMIDIR_UPIN := index(AMIDIR_UPIN_base, 
                                {l_UPIN := UPIN},{dedup_UPIN_base},
				            '~thor_data400::key::amidir_UPIN_' + Doxie.Version_SuperKey);



