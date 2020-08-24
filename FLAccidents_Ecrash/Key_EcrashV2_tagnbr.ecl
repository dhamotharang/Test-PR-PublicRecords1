Import Data_Services, doxie,FLAccidents;

ecrash_tagnbr_base := FLAccidents_Ecrash.File_KeybuildV2.out(tag_nbr<>'');

dst_tagnbr_base := distribute(ecrash_tagnbr_base, hash(tag_nbr, orig_accnbr));
srt_tagnbr_base := sort(dst_tagnbr_base, tag_nbr, orig_accnbr, local);
dep_tagnbr_base := dedup(srt_tagnbr_base, tag_nbr, orig_accnbr, local);

export key_EcrashV2_tagnbr := index(dep_tagnbr_base
                                  ,{l_tagnbr := tag_nbr}
								  ,{accident_nbr,orig_accnbr}
								  ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_tagnbr_' + doxie.Version_SuperKey);
