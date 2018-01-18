import doxie, data_services;

allrecs := FLAccidents.ntlc_ss_Keybuild;
dst_bdid_base := distribute(allrecs(b_did<>'',b_did<>'000000000000'), hash(b_did, accident_nbr));
srt_bdid_base := sort(dst_bdid_base, b_did, accident_nbr, local);
ded_bdid_base := dedup(srt_bdid_base, b_did, accident_nbr, local);  

export key_ntlcrash_bdid := index(ded_bdid_base,
                                  {unsigned6 l_bdid := (integer)b_did},
                                  {accident_nbr},
                                  data_services.data_location.prefix() + 'thor_data400::key::ntlcrash_bdid_' + doxie.Version_SuperKey);