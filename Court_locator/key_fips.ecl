import doxie, data_services;

allrecs := Court_locator.file_lookup_base(fipscode<>'00000');

									 
dst_base := distribute(allrecs, hash(fipscode));

export key_fips := index(dst_base
                 ,{string5 l_fips := fipscode}
								 ,{dst_base}
										,data_services.data_location.prefix() + 'thor_data400::key::courtlocatorlookup::fips_' + doxie.Version_SuperKey);
 