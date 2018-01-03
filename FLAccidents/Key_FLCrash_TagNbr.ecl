import doxie, data_services;

flcrash_tagnbr_base := flaccidents.basefile_flcrash_ss(tag_nbr<>'');

dst_tagnbr_base := distribute(flcrash_tagnbr_base, hash(tag_nbr, accident_nbr));
srt_tagnbr_base := sort(dst_tagnbr_base, tag_nbr, accident_nbr, local);
dep_tagnbr_base := dedup(srt_tagnbr_base, tag_nbr, accident_nbr, local);

export key_flcrash_tagnbr := index(dep_tagnbr_base,
                                   {l_tagnbr := tag_nbr},
                                   {accident_nbr},
                                   data_services.data_location.prefix() + 'thor_data400::key::flcrash_tagnbr_' + doxie.Version_SuperKey);