Import Data_Services, doxie,FLAccidents;

ecrash_vin_base := FLAccidents_Ecrash.File_KeybuildV2.prout(vin<>'' and vin<>'0' );

dst_vin_base := distribute(ecrash_vin_base, hash(vin, orig_accnbr));
srt_vin_base := sort(dst_vin_base, vin, orig_accnbr, local);
dep_vin_base := dedup(srt_vin_base, vin, orig_accnbr, local);

export key_ecrashV2_vin := index(dep_vin_base
                               ,{l_vin := vin}
							   ,{accident_nbr,orig_accnbr}
							   ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_vin_' + doxie.Version_SuperKey);
