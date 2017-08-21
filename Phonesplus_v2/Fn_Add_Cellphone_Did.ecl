export Fn_Add_Cellphone_Did(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

cells_no_did     := dedup(sort(distribute(phplus_in(in_flag and append_phone_type in Translation_Codes.cellphone_types), hash(npa+phone7)), npa+phone7, if(pdid = 0,1,2), -did, local), npa+phone7, local) (pdid > 0);
find_dids_below := dedup(sort(distribute(phplus_in(~in_flag and append_phone_type in Translation_Codes.cellphone_types), hash(npa+phone7)), npa+phone7, if(pdid = 0,1,2), -confidencescore, local), npa+phone7, local) (pdid = 0);

cell_with_did := join(distribute(find_dids_below, hash(npa+phone7)),
											distribute(cells_no_did, hash(npa+phone7)),
											left.npa+left.phone7 = right.npa+right.phone7,
											transform(recordof(phplus_in), self := left),
											local);

// put above the line cellphones with did
recordof(phplus_in) t_apply_rules_with_nodid(phplus_in  le, cell_with_did ri) := transform
	self.in_flag := if(le.npa+le.phone7 = ri.npa+ri.phone7 and le.confidencescore = ri.confidencescore and le.rules = ri.rules, true, le.in_flag);
	self := le;
end;

set_in_flag := join(distribute(phplus_in, hash(npa+phone7)),
									  distribute(cell_with_did, hash(npa+phone7)),
										left.npa+left.phone7 = right.npa+right.phone7 and
										left.confidencescore = right.confidencescore and
										left.rules = right.rules,
										t_apply_rules_with_nodid(left, right),
										left outer,
										local);

return set_in_flag;
end;




