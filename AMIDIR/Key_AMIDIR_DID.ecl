import AMIDIR, Doxie;

file_in := AMIDIR.File_AMIDIR_DID_SSN_BDID;
AMIDIR_did_base := file_in((unsigned8)did<>0);

dist_did_base := distribute(AMIDIR_did_base, hash(did));
sort_did_base := sort(dist_did_base, did,local);
dedup_did_base := dedup(sort_did_base, did,local);

export key_AMIDIR_did := index(AMIDIR_did_base, 
                                {unsigned6 l_did := (unsigned)did},{dedup_did_base},
				            '~thor_data400::key::amidir_did_' + Doxie.Version_SuperKey);





