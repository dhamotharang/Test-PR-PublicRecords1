EXPORT fn_Addr_A11(dataset(layouts.slim_address) infile) := function

src_to_filter := ['FA','FB','FP','LA','LP'];

//infile_addr_dist := distribute(infile(src not in src_to_filter), hash(prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip));
infile_addr_dist := distribute(infile(src not in src_to_filter), address_id);
infile_addr_prop_dist := distribute(infile(src in src_to_filter), address_id);
unsigned3 fn_date_first_seen(date_first_seen,date_vendor_first_reported) :=  IF((unsigned)date_first_seen > 0, (unsigned3)date_first_seen[1..6], (unsigned3)date_vendor_first_reported[1..6]);
unsigned3 fn_date_last_seen(date_last_seen,date_vendor_last_reported) :=  IF((unsigned)date_last_seen > 0, (unsigned3)date_last_seen[1..6], (unsigned3)date_vendor_last_reported[1..6]);

infile_addr_dist tjoin_prop(infile_addr_dist le, infile_addr_prop_dist ri) := transform

self.dt_first_seen_not_personal_property := fn_date_first_seen(le.dt_vendor_first_reported, le.dt_first_seen);
self.dt_last_seen_not_personal_property := fn_date_last_seen(le.dt_vendor_last_reported, le.dt_last_seen);
self := le;

end;

addr_non_prop:= join(infile_addr_dist, infile_addr_prop_dist, left.address_id = right.address_id,
tjoin_prop(left,right), left only, local):persist('~thor_data400::persist::non_property_addr_no_POBOX');
//addr_non_prop := dataset('~thor_data400::persist::non_property_addr', layouts.slim_address, flat);
d_addr_A11 :=addr_non_prop((string6)dt_last_seen_not_personal_property+'31'> Suspicious_Fraud_LN.search_range);

outf := d_addr_A11;

return outf;

end;
