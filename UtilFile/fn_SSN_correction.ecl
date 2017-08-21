EXPORT fn_SSN_correction(dataset(UtilFile.layout_util.daily_in_new) util_daily_in) := function

eq_raw_dist := distribute(util_daily_in, hash(csd_reference_number));

SSN_correction_in := utilfile.file_SSN_correction_in.raw_20160520;
correction_util_dedup := dedup(sort(distribute(SSN_correction_in(reference_num <> '' and ssn <> ''), hash(reference_num)), reference_num, ssn, local), reference_num, ssn, local);

eq_raw_dist tjoin(eq_raw_dist le, correction_util_dedup ri) := transform

self.ssn := if(le.csd_reference_number = ri.reference_num and le.ssn = ri.ssn, '', le.ssn);
self := le;

end;

eq_raw_ssn_correction := join(eq_raw_dist, correction_util_dedup, left.csd_reference_number = right.reference_num
and left.ssn = right.ssn, tjoin(left,right), left outer, local);

return eq_raw_ssn_correction;

end;
