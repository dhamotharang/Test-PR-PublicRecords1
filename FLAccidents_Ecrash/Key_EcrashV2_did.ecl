import doxie,FLAccidents,Data_Services;

allrecs := FLAccidents_Ecrash.File_KeybuildV2.out;
dst_did_base := distribute(allrecs(did<>'',did<>'000000000000'), hash(did, orig_accnbr));
srt_did_base := sort(dst_did_base, did, orig_accnbr,vin, local);
ded_did_base := dedup(srt_did_base, did, orig_accnbr,vin, local);  

export key_EcrashV2_did := index(ded_did_base
                                ,{unsigned6 l_did := (integer)did}
								,{accident_nbr,vin,orig_accnbr}
							    ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_did_' + doxie.Version_SuperKey);
