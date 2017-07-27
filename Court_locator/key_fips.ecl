import doxie;

allrecs := Court_locator.file_lookup_base(fipscode<>'00000');

									 
dst_base := distribute(allrecs, hash(fipscode));

export key_fips := index(dst_base
                 ,{string5 l_fips := fipscode}
								 ,{dst_base}
										,'~thor_data400::key::courtlocatorlookup::fips_' + doxie.Version_SuperKey);
 