import doxie,FLAccidents, data_services;

ecrash_vin_base := FLAccidents_Ecrash.File_Keybuild(vin<>'' and vin<>'0' );

dst_vin_base := distribute(ecrash_vin_base, hash(vin, accident_nbr));
srt_vin_base := sort(dst_vin_base, vin, accident_nbr, local);
dep_vin_base := dedup(srt_vin_base, vin, accident_nbr, local);

export key_ecrash_vin := index(dep_vin_base,
                               {l_vin := vin},
                               {accident_nbr},
                               data_services.data_location.prefix() + 'thor_data400::key::ecrash_vin_' + doxie.Version_SuperKey);