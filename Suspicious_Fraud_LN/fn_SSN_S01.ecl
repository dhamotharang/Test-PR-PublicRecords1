import ut;

/*count first seen third DID assign to SSN*/

export fn_SSN_S01(infile, outf):= macro

h_ssn_did_dist := distribute(project(infile((string6)dt_last_seen+'31'> Suspicious_Fraud_LN.search_range), transform(recordof(infile), self.cnt := 1, self := left)), hash(ssn));
h_ssn_did_plus_sort := sort(h_ssn_did_dist, ssn, dt_first_seen, local);

//h_ssn_did_plus_sort := sort(h_ssn_did_dist, ssn, dt_first_seen, local);

h_ssn_did_plus_sort tIterations01(h_ssn_did_plus_sort le, h_ssn_did_plus_sort ri) := transform

self.cnt := if(le.ssn = ri.ssn, le.cnt + 1, 1);
self := ri;

end;

d_ssn_DIDcnt_iter := iterate(h_ssn_did_plus_sort,  tIterations01(left,right),local);

//append dt_last_seen
d_ssn_DIDcnt_dedup := dedup(sort(distribute(d_ssn_DIDcnt_iter, hash(SSN)), SSN, -dt_last_seen, local), SSN, local);

Suspicious_Fraud_LN.layouts.temp_ssn tjoin_dt_last_seen(d_ssn_DIDcnt_iter le, d_ssn_DIDcnt_dedup ri) := transform
self.dt_first_seen_DIDcnt := le.dt_first_seen;
self.dt_last_seen_DIDcnt := ri.dt_last_seen;
self := le;
self := [];
end;

d_ssn_DIDcnt_dates := join(d_ssn_DIDcnt_iter(cnt = 3), d_ssn_DIDcnt_dedup,left.SSN = right.SSN, 
tjoin_dt_last_seen(left, right),local);

outf := d_ssn_DIDcnt_dates;

endmacro;