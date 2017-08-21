import AMIDIR, Doxie;

file_in := AMIDIR.File_AMIDIR_DID_SSN_BDID;
AMIDIR_ssn_base := file_in(ssn<>'');

dist_ssn_base := distribute(AMIDIR_ssn_base, hash(ssn));
sort_ssn_base := sort(dist_ssn_base, ssn,local);
dedup_ssn_base := dedup(sort_ssn_base, ssn,local);

export key_AMIDIR_SSN := index(AMIDIR_ssn_base, 
                                {l_ssn := ssn},{dedup_ssn_base},
				            '~thor_data400::key::amidir_ssn_' + Doxie.Version_SuperKey);





