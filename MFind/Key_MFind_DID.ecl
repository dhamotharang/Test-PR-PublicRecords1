import MFind, Doxie, ut;

get_recs := MFind.File_MFind_Clean;

slim_party := table(get_recs(did != 0), {get_recs.did, get_recs.trim_vid});

slim_dist   := distribute(slim_party, hash(did, trim_vid));
slim_sort   := sort(slim_dist, did, trim_vid, local);
slim_dedup  := dedup(slim_sort, did, trim_vid, local);

export Key_MFind_DID := index(slim_dedup,{did},{trim_vid},
'~thor_data400::key::mfind::DID_'+ doxie.Version_SuperKey);

