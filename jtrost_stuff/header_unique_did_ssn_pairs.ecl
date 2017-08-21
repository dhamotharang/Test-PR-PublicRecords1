import header;

hdr_in := header.File_Headers(ssn<>'');

r1 := record
 hdr_in.did;
 hdr_in.ssn;
 boolean eq_or_ut;
 boolean other;
end;

src_rs := ['EQ','MU','U','UT','UW'];

r1 t1(hdr_in le) := transform
 self.eq_or_ut := if(trim(le.src)     in src_rs,true,false);
 self.other    := if(trim(le.src) not in src_rs,true,false);
 self          := le;
end;

p1 := dedup(sort(distribute(project(hdr_in,t1(left)),hash(did,ssn,eq_or_ut,other)),did,ssn,eq_or_ut,other,local),did,ssn,eq_or_ut,other,local) : persist('unique_hdr_did_ssn_pairs1');

r1 t_rollup(p1 le, p1 ri) := transform
 self.eq_or_ut := if(le.eq_or_ut=true,le.eq_or_ut,ri.eq_or_ut);
 self.other    := if(le.other   =true,le.other,   ri.other);
 self          := le;
end;

p_rollup := rollup(p1,left.did=right.did and left.ssn=right.ssn,t_rollup(left,right));

export header_unique_did_ssn_pairs := p_rollup : persist('unique_hdr_did_ssn_pairs2');