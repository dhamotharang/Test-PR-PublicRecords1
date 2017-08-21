
import AMIDIR, Doxie;

file_in := AMIDIR.File_AMIDIR_DID_SSN_BDID;
AMIDIR_LicNumber_base := file_in(License_Number<>'');

dist_LicNumber_base := distribute(AMIDIR_LicNumber_base, hash(License_Number));
sort_LicNumber_base := sort(dist_LicNumber_base,License_Number,local);
dedup_LicNumber_base := dedup(sort_LicNumber_base, License_Number,local);

export key_AMIDIR_LicNumber := index(AMIDIR_LicNumber_base, 
                                {l_LicNumber := License_Number},{dedup_LicNumber_base},
				            '~thor_data400::key::amidir_LicNumber_' + Doxie.Version_SuperKey);









