import doxie,FLAccidents;

ecrash_tagnbr_base := FLAccidents_Ecrash.File_Keybuild(tag_nbr<>'');

dst_tagnbr_base := distribute(ecrash_tagnbr_base, hash(tag_nbr, accident_nbr));
srt_tagnbr_base := sort(dst_tagnbr_base, tag_nbr, accident_nbr, local);
dep_tagnbr_base := dedup(srt_tagnbr_base, tag_nbr, accident_nbr, local);

export key_Ecrash_tagnbr := index(dep_tagnbr_base
                                  ,{l_tagnbr := tag_nbr}
								  ,{accident_nbr}
								  ,'~thor_data400::key::ecrash_tagnbr_' + doxie.Version_SuperKey);
