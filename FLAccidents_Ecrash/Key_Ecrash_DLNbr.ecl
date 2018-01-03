import doxie,FLAccidents, data_services;

ecrash_dlnbr_base := FLAccidents_Ecrash.File_Keybuild(driver_license_nbr<>'');

dst_dlnbr_base := distribute(ecrash_dlnbr_base, hash(driver_license_nbr, accident_nbr));
srt_dlnbr_base := sort(dst_dlnbr_base, driver_license_nbr, accident_nbr, local);
dep_dlnbr_base := dedup(srt_dlnbr_base, driver_license_nbr, accident_nbr, local);

export key_ecrash_dlnbr := index(dep_dlnbr_base,
                                 {l_dlnbr := driver_license_nbr},
                                 {accident_nbr},
                                 data_services.data_location.prefix() + 'thor_data400::key::ecrash_dlnbr_' + doxie.Version_SuperKey);