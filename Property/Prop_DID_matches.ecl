import watchdog,ut,header;

p := property.Prop_DID((integer)did>0);

slim_prop := record
p.did;
string12 fares_id := p.vendor_id[1..12];
p.fname;
p.lname;
string9 best_ssn := '';
string4 birth_year := '';
end;

slim_p := distribute(table(p,slim_prop),hash(did));
best_file := watchdog.File_Best;

slim_prop addBest(slim_p L, watchdog.Layout_Best R) := transform
 self.best_ssn := r.ssn;
 self.birth_year := (string)(r.dob div 10000);
 self := l;
end;

with_best := join(slim_p,best_file,left.did=right.did,addBest(left,right),local);

did_out := record
 unsigned6 did1;
 unsigned6 did2;
 string12 fares_id;
end;

did_out matchingDIDs(slim_prop L, slim_prop R) := transform
 self.did1 := if(l.did>r.did,r.did,l.did);
 self.did2 := if(l.did<r.did,r.did,l.did);
 self := l;
end;

fares_dis := distribute(with_best,hash(fares_id));

j := join(fares_dis,fares_dis,left.fares_id=right.fares_id and left.fname=right.fname and
			  left.lname = right.lname and left.did!=right.did and ut.NNEQ_SSN(left.best_ssn,right.best_ssn) and
			  ut.NNEQ_Int(left.birth_year,right.birth_year), matchingDIDs(left,right),local);

dup := dedup(j,did1,did2,all);

header.Layout_PairMatch reformat(dup L) := transform
  self.new_rid := l.did1;
  self.old_rid := l.did2;
  self.pflag := 11;
  end;

export Prop_DID_matches := project(dup(did1>0),reformat(left)) : persist('persist::prop_did_matches');