Import Data_Services, doxie,FLAccidents;

ecrash_dlnbr_base := FLAccidents_Ecrash.File_KeybuildV2.out(driver_license_nbr<>'');

dst_dlnbr_base := distribute(ecrash_dlnbr_base, hash(driver_license_nbr, orig_accnbr));
srt_dlnbr_base := sort(dst_dlnbr_base, driver_license_nbr, orig_accnbr, local);
dep_dlnbr_base := dedup(srt_dlnbr_base, driver_license_nbr, orig_accnbr, local);

export key_ecrashV2_dlnbr := index(dep_dlnbr_base
                                 ,{l_dlnbr := driver_license_nbr}
								 ,{accident_nbr,orig_accnbr}
							     ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_dlnbr_' + doxie.Version_SuperKey);

