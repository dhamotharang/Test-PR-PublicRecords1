import liensv2, Doxie, ut;

get_recs := LiensV2.file_liens_main;
dist_id := distribute(get_recs, hash(TMSID,RMSID));
sort_id := sort(dist_id, TMSID, RMSID,local);

export 	Key_liens_RMSID := index(sort_id,{RMSID},{TMSID},'~thor_data400::key::liensv2::main::RMSID_' + doxie.Version_SuperKey);
