import header,ut;

//when the vendor_id and ssn are equal, propagate the lowest DID
export fn_patch_dids(dataset(recordof(header.layout_header)) in_hdr) := function

    candidates := in_hdr(  ssn<>'' and (integer)vendor_id<>0);
not_candidates := in_hdr(~(ssn<>'' and (integer)vendor_id<>0));

r_candidates_slim := record
 candidates.vendor_id;
 candidates.ssn;
 candidates.did;
 candidates.fname;
 integer count_;
end;

r_candidates_slim t_candidates_slim(candidates le) := transform
 self.count_ := 1;
 self        := le;
end;

p_candidates_slim := sort(distribute(project(candidates(did<>0),t_candidates_slim(left)),hash(vendor_id,ssn)),vendor_id,ssn,local);

r_candidates_slim t_find_min_did(p_candidates_slim le, p_candidates_slim ri) := transform
 self.did    := ut.Min2(le.did,ri.did);
 self.count_ := le.count_+1;
 self        := le;
end;

min_did_for_candidates := rollup(p_candidates_slim,left.vendor_id=right.vendor_id and left.ssn=right.ssn and left.fname[1]=right.fname[1],t_find_min_did(left,right),local);

candidates_dist := distribute(candidates,hash(vendor_id,ssn));

r1 := record
 unsigned6 new_did;
 candidates_dist;
end;

r1 t1(candidates_dist le, min_did_for_candidates ri) := transform
 self.new_did := ut.Min2(le.did,ri.did);
 self         := le;
end;

p1 := join(candidates_dist,min_did_for_candidates,
           left.vendor_id=right.vendor_id and left.ssn=right.ssn and left.fname[1]=right.fname[1],
		   t1(left,right),
		   left outer,keep(1),
		   local
		  );

f1 := p1(new_did<did and did<>0);
f2 := p1(new_did<>0  and did =0);
f3 := p1(new_did=did);

recordof(in_hdr) t_slim_back(p1 le) := transform
 self.did := le.new_did;
 self     := le;
end;

p_slim_back := project(p1,t_slim_back(left));

concat := p_slim_back+not_candidates;

output(count(f1),named('DID_change_something_to_something_else'));
output(count(f2),named('DID_change_nothing_to_something'));
output(count(f3),named('NO_DID_propagation'));
output(count(not_candidates),named('not_even_a_candidate'));

output(choosen(f1,50),named('DID_change_something_to_something_else_SAMPLE'));
output(choosen(f2,50),named('DID_change_nothing_to_something_SAMPLE'));

output(count(in_hdr),named('start'));
output(count(concat),named('end'));

return concat;

end;