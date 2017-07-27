import liensv2, Doxie, ut;

get_recs := LiensV2.file_liens_main;

slim_rec := record

get_recs.tmsid;
get_recs.rmsid;
get_recs.filing_number;
get_recs.orig_filing_number;
string2 filing_state;

end;

slim_rec tslim(get_recs L, integer cnt) := transform

self.filing_state := if(length(trim(L.filing_jurisdiction, left, right)) = 2, L.filing_jurisdiction, L.filing_state);
self.filing_number := choose(cnt, L.filing_number, L.orig_filing_number);
self := L;

end;
					   
slim_main := normalize(get_recs(filing_number <> '' or orig_filing_number <> ''),2, tslim(left, counter));

slim_dist := distribute(slim_main, hash(tmsid, rmsid, filing_number,filing_state));

slim_sort  := sort(slim_dist, tmsid, rmsid, filing_number,filing_state, local);

slim_dedup := dedup(slim_sort, tmsid, rmsid, filing_number,filing_state, local);


export Key_fcra_liens_filing := index(slim_dedup,{filing_number, filing_state},{TMSID,RMSID},

'~thor_data400::key::liensv2::fcra::qa::filing_number');
