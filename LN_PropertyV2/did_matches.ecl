import watchdog,ut,header;

p := ln_propertyv2.File_Search_DID(did>0);

slim_prop := record
 p.did;
 p.ln_fares_id;
 p.fname;
 p.lname;
 string9 best_ssn := '';
 string4 birth_year := '';
end;

slim_p    := distribute(table(p,slim_prop),hash(did));
best_file := watchdog.File_Best;

slim_prop addBest(slim_p le, watchdog.Layout_Best ri) := transform
 self.best_ssn   := ri.ssn;
 self.birth_year := (string)(ri.dob div 10000);
 self            := le;
end;

with_best := join(slim_p,best_file,left.did=right.did,addBest(left,right),local);

did_out := record
 unsigned6 did1;
 unsigned6 did2;
 string12  ln_fares_id;
end;

did_out matchingDIDs(slim_prop le, slim_prop ri) := transform
 self.did1 := if(le.did>ri.did,ri.did,le.did);
 self.did2 := if(le.did<ri.did,ri.did,le.did);
 self      := le;
end;

fares_dis := distribute(with_best,hash(ln_fares_id));

j := join(fares_dis,fares_dis,
          left.ln_fares_id = right.ln_fares_id      and 
		  left.fname       = right.fname            and
		  left.lname       = right.lname            and 
		  left.did        != right.did              and 
		  ut.NNEQ_SSN(left.best_ssn,right.best_ssn) and
		  ut.NNEQ_Int(left.birth_year,right.birth_year),
		  matchingDIDs(left,right),
		  local
		 );

dup := dedup(j,did1,did2,all);

header.Layout_PairMatch reformat(dup L) := transform
  self.new_rid := l.did1;
  self.old_rid := l.did2;
  self.pflag   := 11;
  end;

export did_matches := project(dup(did1>0),reformat(left)) : persist('persist::ln_propertyv2_did_matches');