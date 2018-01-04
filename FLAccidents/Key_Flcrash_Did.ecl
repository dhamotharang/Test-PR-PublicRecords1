import doxie, data_services;

flcrash_did_base := flaccidents.basefile_flcrash_ss(did<>'',did<>'000000000000');

dst_did_base := distribute(flcrash_did_base, hash(did, accident_nbr));
srt_did_base := sort(dst_did_base, did, accident_nbr, local);
dep_did_base := dedup(srt_did_base, did, accident_nbr, local);

export key_flcrash_did := index(dep_did_base,
                                {unsigned6 l_did := (integer)did},
                                {accident_nbr},
                                data_services.data_location.prefix() + 'thor_data400::key::flcrash_did_' + doxie.Version_SuperKey);