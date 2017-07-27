//build the bdid key for flcrash file
import doxie;

bdid_base := flaccidents.basefile_flcrash_ss;

dst_bdid_base := distribute(bdid_base(b_did<>'',b_did<>'000000000000'), hash(b_did, accident_nbr));
srt_bdid_base := sort(dst_bdid_base, b_did, accident_nbr, local);
ded_bdid_base := dedup(srt_bdid_base, b_did, accident_nbr, local);  

export key_flcrash_bdid := index(ded_bdid_base
                                ,{unsigned6 l_bdid := (integer)b_did}
								,{accident_nbr}
							    ,'~thor_data400::key::flcrash_bdid_' + doxie.Version_SuperKey);
