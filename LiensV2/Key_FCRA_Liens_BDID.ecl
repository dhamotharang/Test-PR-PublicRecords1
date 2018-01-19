import liensv2, Data_Services;

get_recs := project(LiensV2.file_liens_party,transform(LiensV2.Layout_liens_party_ssn,self:=left));
slim_party := table(get_recs((unsigned6)bdid != 0), {get_recs.bdid,
                               get_recs.tmsid,
						       get_recs.rmsid});

slim_dist   := distribute(slim_party,hash(tmsid, rmsid,bdid)); 
slim_sort   := sort(slim_dist, tmsid, rmsid,bdid,local);
slim_dedup  := dedup(slim_sort,tmsid, rmsid,bdid,local);

export Key_FCRA_liens_BDID := index(slim_dedup,{unsigned6 p_bdid :=(unsigned6)bdid},{TMSID,RMSID},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::BDID');
