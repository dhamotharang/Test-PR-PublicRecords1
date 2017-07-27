import liensv2, Doxie, ut;

get_recs := project(LiensV2.file_liens_party,transform(LiensV2.Layout_liens_party_ssn,self:=left));

slim_party := table(get_recs((unsigned6)did != 0), {get_recs.did,
                               get_recs.tmsid,
						       get_recs.rmsid});

slim_dist   := distribute(slim_party, hash(tmsid, rmsid, did));
slim_sort   := sort(slim_dist, tmsid, rmsid, did, local);
slim_dedup  := dedup(slim_sort, tmsid, rmsid, did, local);

export Key_liens_DID := index(slim_dedup,{unsigned6 did := (unsigned6)did},{TMSID,RMSID},'~thor_data400::key::liensv2::DID_' + doxie.Version_SuperKey);
