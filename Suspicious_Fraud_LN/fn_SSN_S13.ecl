import header,ut;

EXPORT fn_SSN_S13(dataset(Suspicious_Fraud_LN.layouts.temp_SSN) infile) := function

// append addr counts per ssn

sysdate := ut.GetDate;

addr_slim := RECORD
	infile.ssn;
	addr1 := trim(infile.zip) + trim(infile.prim_name) + trim(infile.prim_range);
	dt_first_seen := min(group,if(infile.dt_first_seen = 0,999999,infile.dt_first_seen));
  dt_last_seen := max(group,infile.dt_last_seen);
	cnt := COUNT(GROUP);
END;
d_addr := TABLE(distribute(infile(TRIM(zip)<>'' and (trim(prim_name)<>'' or trim(prim_range)<>'')), hash(ssn)), addr_slim, 
								ssn, zip, prim_name, prim_range, LOCAL);
									
d_addr_sort := sort(project(d_addr(ut.DaysApart(sysdate[1..6]+'31', (string6)dt_first_seen[1..6]+'31') < 91),
 transform(addr_slim, self.cnt := 1, self := left)), ssn, dt_first_seen, local);

addr_slim tIterationS13(d_addr_sort le, d_addr_sort ri) := transform

self.cnt := if(le.ssn = ri.ssn, le.cnt + 1, 1);
self := ri;

end;

d_ssn_addr_cnt_c3_iter := iterate(d_addr_sort,  tIterationS13(left,right),local);

//append dt_last_seen
d_ssn_addr_cnt_c3_dedup := dedup(sort(distribute(d_ssn_addr_cnt_c3_iter, hash(SSN)), SSN, -dt_last_seen, local), SSN, local);

#uniquename(tjoin_dt_last_seen)

Suspicious_Fraud_LN.layouts.temp_ssn %tjoin_dt_last_seen%(d_ssn_addr_cnt_c3_iter le, d_ssn_addr_cnt_c3_dedup ri) := transform
self.dt_first_seen_recentADDRcnt := le.dt_first_seen;
self.dt_last_seen_recentADDRcnt := ri.dt_last_seen;
self := le;
self := [];
end;

d_ssn_addr_cnt_c3_dates := join(d_ssn_addr_cnt_c3_iter(cnt = 3), d_ssn_addr_cnt_c3_dedup,left.SSN = right.SSN, 
%tjoin_dt_last_seen%(left, right),local);

return d_ssn_addr_cnt_c3_dates;

end;

				
