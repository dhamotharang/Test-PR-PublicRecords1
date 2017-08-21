export Persisted := 
MODULE

export PdodgyDids := dataset('~thor400_84::dodgy_dids', Header.layout_DodgyDids, thor);
export PdidRules0_1 := dataset('~thor400_84::Did_Rules0_1', header.Layout_PairMatch, thor);
export PdidRules0_2 := dataset('~thor400_84::Did_Rules0_2', header.Layout_PairMatch, thor);
export PHeaderJoined := dataset('~thor400_84::header_joined', header.Layout_Header, thor);
export Pwith_did_mid := dataset('~thor400_84::persist::with_did_mid', header.Layout_Header, thor);
// export PdidRules1 := dataset('~thor400_84::Did_Rules1', header.Layout_PairMatch, thor);
export PmatchCandidates1 := dataset('~thor400_84::match_candidates_1', header.Layout_MatchCandidates, thor);
export PmatchCandidates2 := dataset('~thor400_84::match_candidates_2', header.Layout_MatchCandidates, thor);

export Pheaderbuild_util_na_match := 		dataset('~thor400_84::headerbuild_util_na_match',recordof(Header.Matched2Util),flat);
export PHeader_Joined := 		dataset('~thor400_84::Header_Joined',header.Layout_Header,flat);

export PnewHeader := 		dataset('~thor_data400::base::header',header.Layout_Header,flat);
export PprodHeader := 	dataset('~thor_data400::base::header_prod',header.Layout_Header,flat);
// export PaprilHeader := 	dataset('~thor_data400::base::headerw20070328-114439',header.Layout_Header,flat);
// export PmayHeader := 		dataset('~thor_data400::base::headerw20070429-125947',header.Layout_Header,flat);
export PmayHeader := 	dataset('~thor_data400::base::headerw20070602-093712',header.Layout_Header,flat);
export PJuneHeader := 	dataset('~thor_data400::base::headerw20070624-153307',header.Layout_Header,flat);
export PJulyHeader := 	dataset('~thor_data400::base::headerw20070724-163904',header.Layout_Header,flat);
export PAugustHeader := dataset('~thor_data400::base::headerw20070830-093727_dtlastseen_patch', header.Layout_Header,flat);

shared new := PnewHeader;
shared old := PprodHeader;

shared n := dedup(project(new(jflag2 = ''), {new.did}), local);
shared o := dedup(project(old(jflag2 = ''), {old.did}), local);

export newDIDs := join(n,o,left.did = right.did, left only, local);
export newDIDsRecords := join(new, newDIDs, left.did = right.did, local);

END;