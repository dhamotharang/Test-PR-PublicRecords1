import ut, Suspicious_Fraud_LN;

/*count first seen fifth DID assign to phone10*/

export fn_phone_P09(infile, outf):= macro

h_phone09_did_dist := distribute(project(infile((string6)dt_last_seen+'31'> Suspicious_Fraud_LN.search_range), transform(recordof(infile), self.cnt := 1, self := left)), hash(phone10));

h_phone09_did_plus_sort := sort(h_phone09_did_dist, phone10, dt_first_seen, local);

h_phone09_did_plus_sort tIterations01(h_phone09_did_plus_sort le, h_phone09_did_plus_sort ri) := transform

self.cnt := if(le.phone10 = ri.phone10, le.cnt + 1, 1);
self := ri;

end;

d_phone09_DIDcnt_iter := iterate(h_phone09_did_plus_sort,  tIterations01(left,right),local);

//append dt_last_seen
#uniquename(tjoin_dt_last_seen)
d_phone09_DIDcnt_dedup := dedup(sort(distribute(d_phone09_DIDcnt_iter, hash(phone10)), phone10, -dt_last_seen, local), phone10, local);

Suspicious_Fraud_LN.layouts.slim_phone %tjoin_dt_last_seen%(d_phone09_DIDcnt_iter le, d_phone09_DIDcnt_dedup ri) := transform
self.dt_first_seen_DIDcnt := le.dt_first_seen;
self.dt_last_seen_DIDcnt := ri.dt_last_seen;
self := le;
self := [];
end;

d_phone09_DIDcnt_dates := join(d_phone09_DIDcnt_iter(cnt = 5), d_phone09_DIDcnt_dedup,left.phone10 = right.phone10, 
%tjoin_dt_last_seen%(left, right),local);

outf := d_phone09_DIDcnt_dates;

endmacro;