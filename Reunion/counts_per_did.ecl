import infutor;

export counts_per_did(dataset(recordof(infutor.infutor_header)) hdr_in) := function

r1 := record
 hdr_in;
 integer did_ct := 1;
end;

ta1      := table(hdr_in,r1);
ta1_dist := distribute(ta1,hash(did));
ta1_sort := sort(ta1_dist,did,local);

r1 t1(r1 le, r1 ri) := transform
 self.did_ct := le.did_ct+1;
 self        := le;
end;

p2 := rollup(ta1_sort,left.did=right.did,t1(left,right),local);

r1 t2(r1 le, r1 ri) := transform
 self.did_ct := ri.did_ct;
 self        := le;
end;

j1 := join(ta1_dist,p2,left.did=right.did,t2(left,right),local);
		  
return j1;

end;