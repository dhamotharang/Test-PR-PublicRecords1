import header;

export fn_DID_has_one_confirmed_SSN(dataset(recordof(header.layout_header)) in_hdr) := function

//get EQ confirmed SSN
EQ_confirmed_SSN := in_hdr(jflag3='C' and src='EQ' and ssn<>'');

//slim dataset and count confirmed SSN
eq_slim  := table(EQ_confirmed_SSN, {did, ssn});
eq_dedup := dedup(eq_slim, did, ssn, all);

eq_ssn_rec := record
 eq_slim;
 integer ssn_cnt := 1;
end;

eq_ssn:= project(eq_dedup,transform(eq_ssn_rec,self:=left));

eq_dist := distribute(eq_ssn, hash(did));
eq_grp  := group(sort(eq_dist,did,local), did, local);

eq_ssn_rec t_cnt(eq_grp le, eq_grp ri) := transform
 self.ssn_cnt := le.ssn_cnt+1;
 self         := ri;
end;

eq_rollup := group(rollup(eq_grp,left.did=right.did,t_cnt(left,right)));

//EQ confirmed unique SSN
eq_has_unique_ssn := eq_rollup(ssn_cnt = 1);

return eq_has_unique_ssn;

end;