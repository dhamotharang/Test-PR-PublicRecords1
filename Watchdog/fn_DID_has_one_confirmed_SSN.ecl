import header;

export fn_DID_has_one_confirmed_SSN(dataset(recordof(header.layout_header)) in_hdr) := function

//get EQ confirmed SSN
EQ_confirmed_SSN := in_hdr(jflag3='C' and src='EQ' and ssn<>'');

r1 := record
 EQ_confirmed_SSN.did;
 EQ_confirmed_SSN.ssn;
 integer did_ct:=1;
 integer ssn_ct:=1;
end;

r1 t1(EQ_confirmed_SSN le) := transform
 self := le;
end;

p1 := project(EQ_confirmed_SSN,t1(left));

dist1 := distribute(p1,hash(did));

dist2 := distribute(p1,hash(ssn));
sort2 := sort(dist2,ssn,did,local);
dupd2 := dedup(sort2,ssn,did,local);

r1 t2(r1 le, r1 ri) := transform
 self.did_ct := le.did_ct+1;
 self        := le;
end;

p2 := rollup(dupd2,left.ssn=right.ssn,t2(left,right),local);

confirmeds_with_one_did      := p2(did_ct=1);
confirmeds_with_one_did_dist := distribute(confirmeds_with_one_did,hash(did));

recordof(dist1) t3(r1 le, r1 ri) := transform
 self := le;
end;

j1 := join(dist1,confirmeds_with_one_did_dist,left.did=right.did,t3(left,right),local);

j1_sort := sort(j1,did,ssn,local);
j1_dupd := dedup(j1_sort,did,ssn,local);

r1 t4(r1 le, r1 ri) := transform
 self.ssn_ct := le.ssn_ct+1;
 self        := le;
end;

p3 := rollup(j1_dupd,left.did=right.did,t4(left,right),local);

confirmeds_with_one_ssn := p3(ssn_ct=1);

return confirmeds_with_one_ssn;

end;