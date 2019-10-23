EXPORT fn_invalid_dates_daily_correction(dataset(UtilFile.layout_util.base) infile) := function

//add new daily file in historical data
comb_did_file := utilfile.file_util.full_did + project(infile, transform(utilfile.Layout_DID_Out, self := left));

full_did := comb_did_file((unsigned)did > 0);
full_no_did := comb_did_file((unsigned)did = 0);

p2_dist  := distribute(full_did((addr_type = 'S' or (addr_type = 'B' and addr_dual = 'N')) and date_first_seen <> ''),hash(did));
p2_sort  := sort      (p2_dist,did,prim_range,prim_name,zip,date_first_seen,connect_date,local);
p2_group := group(p2_sort, did,prim_range,prim_name,zip, local);

min_dates(string l, string r) := if(l<>'' and r<>'', min(l, r), if(l<>'', l, r));

p2_sort trollup(p2_sort le, p2_sort ri) := transform
 self.date_first_seen := min_dates(le.date_first_seen,ri.date_first_seen);
 self.connect_date   := min_dates(le.connect_date,ri.connect_date);
 self := le;
end;

p2_rollup := group(rollup(p2_group,true,trollup(left,right)));

//correct the dates on the billing address with addr_daul = 'Y' normalized with the incorrect assumptions.

b_dual_addr := infile(addr_type = 'B' and addr_dual = 'Y');
b_no_dual_addr := infile(~(addr_type = 'B' and addr_dual = 'Y'));

UtilFile.layout_util.base tjoin(b_dual_addr le, p2_rollup ri) := transform
self.date_first_seen := if(le.date_first_seen <> '' and le.date_first_seen < ri.date_first_seen, ri.date_first_seen,
if(le.date_first_seen <> '' and le.date_first_seen >= ri.date_first_seen and ri.date_first_seen <> '', le.date_first_seen, le.record_date));
self.connect_date    := if(le.connect_date <> '' and le.connect_date < ri.connect_date, ri.connect_date,
if(le.connect_date <> '' and le.connect_date >= ri.connect_date and ri.connect_date <> '', le.connect_date, le.record_date));
self.csa_indicator   := if(le.date_first_seen <> '' and le.date_first_seen < ri.date_first_seen, 'Y',
if(le.date_first_seen <> '' and le.date_first_seen >= ri.date_first_seen and ri.date_first_seen <> '', 'N', le.csa_indicator));
self := le;

end;

csa_out := join(distribute(b_dual_addr,hash(did)), p2_rollup, left.did = right.did 
and left.prim_name = right.prim_name 
and left.prim_range = right.prim_range
and left.zip=right.zip, tjoin(left,right), left outer,local);

//combine fixed the incorrect dates and correct dates 

outfile	:= csa_out + b_no_dual_addr;

return outfile;

end;