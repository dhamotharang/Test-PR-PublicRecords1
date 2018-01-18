import doxie, data_services;

flcrash_vin_base := flaccidents.basefile_flcrash_ss(vin<>'');

dst_vin_base := distribute(flcrash_vin_base, hash(vin, accident_nbr));
srt_vin_base := sort(dst_vin_base, vin, accident_nbr, local);
dep_vin_base := dedup(srt_vin_base, vin, accident_nbr, local);

export key_flcrash_vin := index(dep_vin_base,
                                {l_vin := vin},
                                {accident_nbr},
                                data_services.data_location.prefix() + 'thor_data400::key::flcrash_vin_' + doxie.Version_SuperKey);