import doxie, data_services;

flcrash_dlnbr_base := flaccidents.basefile_flcrash_ss(driver_license_nbr<>'');

dst_dlnbr_base := distribute(flcrash_dlnbr_base, hash(driver_license_nbr, accident_nbr));
srt_dlnbr_base := sort(dst_dlnbr_base, driver_license_nbr, accident_nbr, local);
dep_dlnbr_base := dedup(srt_dlnbr_base, driver_license_nbr, accident_nbr, local);

export key_flcrash_dlnbr := index(dep_dlnbr_base,
                                  {l_dlnbr := driver_license_nbr},
                                  {accident_nbr},
                                  data_services.data_location.prefix() + 'thor_data400::key::flcrash_dlnbr_' + doxie.Version_SuperKey);