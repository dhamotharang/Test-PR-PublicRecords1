import liensv2, Doxie, Data_Services;
get_recs := project(LiensV2.file_liens_party,transform(liensv2.layout_liens_party_ssn,self:=left));

slim_rec := record

get_recs.tmsid;
get_recs.rmsid;
get_recs.ssn;

end;

slim_rec tslim(get_recs L) := transform

self.ssn := if((unsigned6)L.ssn <> 0, if(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), L.app_ssn);
self := L;

end;
					   
slim_party := project(get_recs, tslim(left));

slim_dist   := distribute(slim_party(ssn <> ''), hash(tmsid, rmsid, ssn));
slim_sort   := sort(slim_dist, tmsid, rmsid, ssn, local);
slim_dedup  := dedup(slim_sort, tmsid, rmsid, ssn, local);

export Key_liens_SSN := index(slim_dedup,{ssn},{TMSID,RMSID},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::SSN_' + doxie.Version_SuperKey);


