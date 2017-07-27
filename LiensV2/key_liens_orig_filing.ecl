import liensv2, Doxie;

get_recs := LiensV2.file_liens_main;

slim_rec := record

get_recs.tmsid;
get_recs.rmsid;
get_recs.orig_filing_number;
string2 filing_state;

end;

slim_rec tslim(get_recs L) := transform

self.filing_state := if(length(trim(L.filing_jurisdiction, left, right)) = 2, L.filing_jurisdiction, L.filing_state);
self := L;

end;
					   
slim_main := project(get_recs(orig_filing_number <> ''), tslim(left));

slim_dist := distribute(slim_main, hash(tmsid, rmsid, orig_filing_number, filing_state));

slim_sort  := sort(slim_dist, tmsid, rmsid, orig_filing_number, filing_state, local);

slim_dedup := dedup(slim_sort, tmsid, rmsid, orig_filing_number,filing_state, local);


export Key_liens_orig_filing := index(slim_dedup,{orig_filing_number,filing_state,},{TMSID,RMSID},'~thor_data400::key::liensv2::orig_filing_' + doxie.Version_SuperKey);
