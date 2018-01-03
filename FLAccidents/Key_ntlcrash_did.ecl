import doxie, data_services;

allrecs := FLAccidents.ntlc_ss_Keybuild;
dst_did_base := distribute(allrecs(did<>'',did<>'000000000000'), hash(did, accident_nbr));
srt_did_base := sort(dst_did_base, did, accident_nbr,vin, local);
ded_did_base := dedup(srt_did_base, did, accident_nbr,vin, local);  

export key_ntlcrash_did := index(ded_did_base,
                                 {unsigned6 l_did := (integer)did},
                                 {accident_nbr,vin},
                                 data_services.data_location.prefix() + 'thor_data400::key::ntlcrash_did_' + doxie.Version_SuperKey);