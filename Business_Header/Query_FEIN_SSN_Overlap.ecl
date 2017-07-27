bh := Business_Header.File_Business_Header_Base;

layout_bdid_fein := record
bh.bdid;
bh.fein;
end;

bh_fein := table(bh(fein<> 0), layout_bdid_fein);
bh_fein_dedup := dedup(bh_fein, all);

count(bh_fein_dedup);
bh_fein_dedup_fein := dedup(bh_fein_dedup, fein, all);
count(bh_fein_dedup_fein);

h := Header.File_Headers;

layout_ssn := record
ssn := (unsigned4)h.ssn;
end;

h_ssn := table(h(ssn <> '', valid_ssn = 'G'), layout_ssn);
h_ssn_dedup := dedup(h_ssn, all);

count(h_ssn_dedup);

layout_fein_ssn := record
unsigned4 fein_ssn;
end;

// Find overlap between FEIN and valid Header SSN numbers globally
fein_ssn_overlap_global := join(bh_fein_dedup_fein,
                                h_ssn_dedup,
						  left.fein = right.ssn,
						  transform(layout_fein_ssn, self.fein_ssn := left.fein),
						  hash);
						  
count(fein_ssn_overlap_global);