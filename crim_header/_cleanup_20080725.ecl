/*
//
// ran as step1 with it20 in
//
my_ch := crim_header.file_crim_header;

//
crim_header.layout_crim_header to_undo(my_ch l) := transform
self.cdl := l.rid;
self := l;
end;
undone_ch := project(my_ch,to_undo(left));
//
//count(undone_ch);
//
output(undone_ch,,'~thor_data400::temp::cdl::it00_it20undone_20080725');
*/
//
// ran with above output as input.
//
my_ch := crim_header.file_crim_header;
//
dist_on_ofk :=distribute(my_ch,hash(offender_key));
//
crim_header.layout_crim_header trollup(dist_on_ofk l,dist_on_ofk r) := transform
self.earliest_process_date	:= if (l.earliest_process_date < r.earliest_process_date, l.earliest_process_date, r.earliest_process_date);
self.latest_process_date	:=   if (l.latest_process_date   > r.latest_process_date,   l.latest_process_date,   r.latest_process_date);
self.cdl := if (l.cdl< r.cdl, l.cdl, r.cdl);
self.rid := if (l.rid< r.rid, l.rid, r.rid);
self.in_latest := if(l.in_latest or r.in_latest, true,false);
self := l;
end;
rollup_on_all := rollup(sort(dist_on_ofk,except cdl,rid,in_latest,earliest_process_date,latest_process_date),trollup(left,right),except cdl,rid,in_latest,earliest_process_date,latest_process_date,local);
//
output(rollup_on_all,,'~thor_data400::temp::cdl::it00_it20undone_rerolledup_20080725');
