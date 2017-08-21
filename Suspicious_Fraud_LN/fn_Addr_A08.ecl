import ut;
EXPORT fn_Addr_A08(dataset(layouts.slim_address) infile) := function 

infile_has_did := distribute(infile(did<>0), address_id);
did_addr_slim := RECORD
	infile.prim_range;
	infile.predir;
	infile.prim_name;
	infile.suffix;
	infile.postdir;
	infile.unit_desig;
	infile.sec_range;
	infile.city_name;
	infile.st;
	infile.zip;
	infile.address_id;
	infile.did;
	dt_first_seen_DIDcnt := min(group,if(infile.dt_first_seen = 0, 999999,infile.dt_first_seen));
	dt_last_seen_DIDcnt  := max(group,infile.dt_last_seen);
	cnt := COUNT(GROUP);
END;

d_addr_did := TABLE(infile_has_did, did_addr_slim, prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip, did, address_id,LOCAL) : persist('~thor_data400::persist::d_addr_did_best');
sysdate := ut.GetDate;
//d_addr_did := dataset(ut.foreign_dataland + 'thor_data400::persist::d_addr_did_best',did_addr_slim,flat);
d_addr_did_dist := distribute(project(d_addr_did((string6)dt_last_seen_DIDcnt+'31'> Suspicious_Fraud_LN.search_range and (string6)dt_last_seen_DIDcnt <= sysdate[1..6]), transform(did_addr_slim, self.cnt := 1, self := left)),address_id);

h_addr_didcnt_sort := sort(d_addr_did_dist, address_id, dt_first_seen_DIDcnt, local);

did_addr_slim tIterationA08(h_addr_didcnt_sort le, h_addr_didcnt_sort ri) := transform
 
self.cnt := if(le.address_id = ri.address_id, le.cnt + 1, 1);
self := ri;

end;

d_addr_DIDcnt_iter := iterate(h_addr_didcnt_sort, tIterationA08(left,right),local);

//append dt_last_seen
d_addr_DIDcnt_dedup := dedup(sort(distribute(d_addr_DIDcnt_iter, address_id), address_id, -dt_last_seen_DIDcnt, local), address_id, local);

#uniquename(tjoin_dt_last_seen)
Suspicious_Fraud_LN.layouts.slim_address %tjoin_dt_last_seen%(d_addr_DIDcnt_iter le, d_addr_DIDcnt_dedup ri) := transform
self.dt_first_seen_DIDcnt := le.dt_first_seen_DIDcnt;
self.dt_last_seen_DIDcnt := ri.dt_last_seen_DIDcnt;
self := le;
self := [];
end;

d_addr_A08 := join(d_addr_DIDcnt_iter(cnt = 30 and dt_first_seen_DIDcnt != 999999), d_addr_DIDcnt_dedup,left.address_id = right.address_id, 
%tjoin_dt_last_seen%(left, right),local);

return d_addr_A08;

end;

