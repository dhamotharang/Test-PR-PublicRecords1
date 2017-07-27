import dnb_feinv2, Doxie, ut;

get_recs := DNB_FEINv2.File_DNB_Fein_base_main;

slim_party := table(get_recs((unsigned6)bdid != 0), {get_recs.bdid,
                               get_recs.tmsid});

slim_dist   := distribute(slim_party,hash(tmsid,bdid)); 
slim_sort   := sort(slim_dist, tmsid, bdid,local);
slim_dedup  := dedup(slim_sort,tmsid, bdid,local);

export key_DNB_Fein_BDID := index(slim_dedup,{unsigned6 p_bdid :=(unsigned6)bdid},{TMSID},
'~thor_data400::key::dnbfein::BDID_' + Doxie.Version_SuperKey);



