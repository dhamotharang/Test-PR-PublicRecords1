Import Data_Services, doxie,FLAccidents;

allrecs := FLAccidents_Ecrash.File_KeybuildV2.prout;
dst_bdid_base := distribute(allrecs(b_did<>'',b_did<>'000000000000'), hash(b_did, orig_accnbr));
srt_bdid_base := sort(dst_bdid_base, b_did, orig_accnbr, local);
ded_bdid_base := dedup(srt_bdid_base, b_did, orig_accnbr, local);  

export key_EcrashV2_bdid := index(ded_bdid_base
                                ,{unsigned6 l_bdid := (integer)b_did}
								,{accident_nbr,orig_accnbr}
							    ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2_bdid_' + doxie.Version_SuperKey);


