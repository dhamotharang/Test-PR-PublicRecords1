import ut,did_add;
EXPORT fn_Addr_A10(dataset(layouts.slim_address) infile) := function


infile_has_bdid := distribute(infile((unsigned)bdid > 0),address_id);
	bdid_addr_slim := RECORD
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
	infile.bdid;
	dt_first_seen_BDIDcnt := Suspicious_Fraud_LN.fn_dt_first_seen_min(infile.dt_vendor_first_reported,infile.dt_first_seen);
	dt_last_seen_BDIDcnt  := Suspicious_Fraud_LN.fn_dt_last_seen_max(infile.dt_vendor_last_reported,infile.dt_last_seen);
	cnt := COUNT(GROUP);
END;


d_addr_Bdid := TABLE(infile_has_bdid, bdid_addr_slim, prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip, bdid, address_id, LOCAL) : persist('~thor_data400::persist::d_addr_bdid_dt_reported');
//d_addr_Bdid := dataset(ut.foreign_dataland + 'thor_data400::persist::d_addr_Bdid_dt_reported',bdid_addr_slim,flat);
sysdate := ut.GetDate;

DaysToUse:=60;
//start date will be computed from the last header release date (note: not the header build date)
LastHeaderReleaseDate:=did_add.get_EnvVariable('bheader_build_version')[1..8];
FromDateInDays:=ut.DaysSince1900(LastHeaderReleaseDate[1..4],LastHeaderReleaseDate[5..6],LastHeaderReleaseDate[7..8]) - DaysToUse;
FromDate:=ut.DateFrom_DaysSince1900(FromDateInDays);
d_addr_did_dist := distribute(project(d_addr_bdid((string6)dt_last_seen_BDIDcnt+'31'> FromDate and (string6)dt_last_seen_BDIDcnt <= sysdate[1..6]), transform(bdid_addr_slim, self.cnt := 1, self := left)),address_id);

h_addr_Bdidcnt_sort := sort(d_addr_did_dist, address_id, dt_first_seen_BDIDcnt, local);

bdid_addr_slim tIterationA10(h_addr_Bdidcnt_sort le, h_addr_Bdidcnt_sort ri) := transform

self.cnt := if(le.address_id = ri.address_id, le.cnt + 1, 1);
self := ri;

end;

d_addr_BDIDcnt_iter := iterate(h_addr_Bdidcnt_sort, tIterationA10(left,right),local);

//append dt_last_seen
d_addr_BDIDcnt_dedup := dedup(sort(distribute(d_addr_BDIDcnt_iter, address_id), address_id, -dt_last_seen_BDIDcnt, local), address_id, local);

#uniquename(tjoin_dt_last_seen)
Suspicious_Fraud_LN.layouts.slim_address %tjoin_dt_last_seen%(d_addr_BDIDcnt_iter le, d_addr_BDIDcnt_dedup ri) := transform
self.dt_first_seen_BDIDcnt := le.dt_first_seen_BDIDcnt;
self.dt_last_seen_BDIDcnt := ri.dt_last_seen_BDIDcnt;
self := le;
self := [];
end;

d_addr_A10 := join(d_addr_BDIDcnt_iter(cnt = 10 and dt_first_seen_BDIDcnt != 999999), d_addr_BDIDcnt_dedup,left.address_id = right.address_id, 
%tjoin_dt_last_seen%(left, right),local);

return d_addr_A10;

end;

