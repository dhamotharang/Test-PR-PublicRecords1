import liensv2, Doxie, Data_Services;

get_recs := LiensV2.file_liens_main;

slim_rec := record

get_recs.tmsid;
get_recs.rmsid;
string20 case_number;
string2 filing_state;

end;

strip_leadingzeroes(string20 number) := regexreplace('^[ |0]*',number,'');

slim_rec tslim(get_recs L, integer cnt) := transform

string20 s_case_number        := if(strip_leadingzeroes(L.case_number)   <> '', L.case_number, ''); 
string20 s_filing_number      := if(strip_leadingzeroes(L.filing_number) <> '', L.filing_number, '');
string20 s_orig_filing_number := if(strip_leadingzeroes(L.orig_filing_number) <> '', L.orig_filing_number, '');

self.case_number := choose(cnt, s_case_number, s_filing_number, s_orig_filing_number);						  
self.filing_state  := if(length(trim(L.filing_jurisdiction, left, right)) = 2, L.filing_jurisdiction, L.filing_state);						                        
self := L;

end;
					   
slim_file := normalize(get_recs(case_number <> '' or filing_number <> '' or orig_filing_number <> ''), 3, tslim(left, counter));


slim_rec tformat(slim_rec L, integer cnt) := transform

self.case_number := choose(cnt, L.case_number, strip_leadingzeroes(L.case_number));
self := L;

end;

file_out := normalize(slim_file(case_number<> ''), 2, tformat(left, counter));

slim_dist  := distribute(file_out, hash(tmsid, rmsid, case_number, filing_state));

slim_sort  := sort(slim_dist, tmsid, rmsid, case_number,filing_state, local);

slim_dedup := dedup(slim_sort, tmsid, rmsid, case_number, filing_state, local);


export Key_liens_case_number := index(slim_dedup,{case_number, filing_state},{TMSID,RMSID},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::case_number_' + doxie.Version_SuperKey);
