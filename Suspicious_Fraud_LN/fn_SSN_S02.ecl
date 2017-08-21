EXPORT fn_SSN_S02(infile, outf) := macro

//find out SSN first reported in last 6 months 

ssn_in_c6 := distribute(infile(ut.DaysApart(sysdate[1..6] + '31', (string6)dt_first_seen +'31') < 183), hash(ssn));
	
SSN_above_c6 := infile(ut.DaysApart(sysdate[1..6] + '31', (string6)dt_first_seen+'31') >= 183); 


SSN_above_c6_dedup := dedup(sort(distribute(SSN_above_c6, hash(ssn)), ssn, local), ssn, local);

ssn_in_c6 tjoin(ssn_in_c6 le, SSN_above_c6_dedup ri) := transform

self := le;

end;

h_ssn_c6_only := join(ssn_in_c6,SSN_above_c6_dedup, left.ssn = right.ssn, tjoin(left, right), left only, local);

//count first seen second DID assign to SSN
h_ssn_didcnt_c6_dist := distribute(project(h_ssn_c6_only, transform(recordof(infile), self.cnt := 1, self := left)), hash(ssn));
h_ssn_didcnt_c6_sort := sort(h_ssn_didcnt_c6_dist, ssn, dt_first_seen, local);

ssn_slim tIterations02(h_ssn_didcnt_c6_sort le, h_ssn_didcnt_c6_sort ri) := transform

self.cnt := if(le.ssn = ri.ssn, le.cnt + 1, 1);
self := ri;

end;

d_ssn_DIDcnt_c6_iter := iterate(h_ssn_didcnt_c6_sort,  tIterations02(left,right),local);

//append dt_last_seen
d_ssn_DIDcnt_c6_dedup := dedup(sort(distribute(d_ssn_DIDcnt_c6_iter, hash(SSN)), SSN, -dt_last_seen, local), SSN, local);

#uniquename(tjoin_dt_last_seen)
Suspicious_Fraud_LN.layouts.temp_ssn %tjoin_dt_last_seen%(d_ssn_DIDcnt_c6_iter le, d_ssn_DIDcnt_dedup ri) := transform
self.dt_first_seen_DIDcnt_c6 := le.dt_first_seen;
self.dt_last_seen_DIDcnt_c6 := ri.dt_last_seen;
self := le;
self := [];
end;

d_ssn_DIDcnt_c6_dates := join(d_ssn_DIDcnt_c6_iter(cnt = 2), d_ssn_DIDcnt_dedup,left.SSN = right.SSN, 
%tjoin_dt_last_seen%(left, right),local);

outf := d_ssn_DIDcnt_c6_dates;

endmacro;