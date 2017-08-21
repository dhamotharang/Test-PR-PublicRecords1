
import AMIDIR, Doxie;

file_in := AMIDIR.File_AMIDIR_DID_SSN_BDID;
AMIDIR_bdid_base := file_in((unsigned8)bdid<>0);

dist_bdid_base := distribute(AMIDIR_bdid_base, hash(bdid));
sort_bdid_base := sort(dist_bdid_base, bdid,local);
dedup_bdid_base := dedup(sort_bdid_base, bdid,local);

export key_AMIDIR_bdid := index(AMIDIR_bdid_base, 
                                {unsigned6 l_bdid := (unsigned)bdid},{dedup_bdid_base},
				            '~thor_data400::key::amidir_bdid_' + Doxie.Version_SuperKey);




