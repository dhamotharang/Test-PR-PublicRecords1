import doxie,FLAccidents, data_services;

allrecs := FLAccidents_Ecrash.File_Keybuild(vin+driver_license_nbr+tag_nbr+lname <>'');

crash_base := allrecs
						((accident_date<>'' and (unsigned) accident_date<>0));
											 
dst_base := distribute(crash_base, hash(accident_date));
srt_base := sort(dst_base, except did, except b_did, local);
dep_base := dedup(srt_base, except did, except b_did, local);

export key_ecrash_dol := index(dep_base,
                               {accident_date},
                               {dep_base},
                               data_services.data_location.prefix() + 'thor_data400::key::ecrash_dol_' + doxie.Version_SuperKey);