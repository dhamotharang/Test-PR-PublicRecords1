import dx_common;
b1 := dids_with_namehook;
res_type1 := record
  unsigned6 did;
  unsigned4 other_count;
  unsigned4 first_seen;
  unsigned2 rel_count;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	unsigned8 dummy := 0;
  // DF-28226 - fields defined for delta build
	dx_common.layout_metadata;
  end;

res_type1 take_ocount(b1 le,annotated_badguys ri) := transform
  self.did := le.did;
  self.other_count := ri.cnt;
	self.fname := ri.fname;
	self.mname := ri.mname;
	self.lname := ri.lname;
	SELF := [];
  end;

j01 := join(b1,annotated_badguys,left.fname=right.fname and
                               left.mname=right.mname and
                               left.lname=right.lname,
                               take_ocount(left,right),hash);

j0 := dedup(sort(distribute(j01,hash(did)),did,other_count,local),did,local);

res_type1 take_relcount(j0 le,rel_counts ri) := transform
  self.rel_count := ri.cnt;
  self.first_seen := 0;
  self := le;
  end;

j1 := join(j0,rel_counts,left.did=right.did,
             take_relcount(left,right),hash,left outer);

res_type1 take_fs(j1 le,first_seens ri) := transform
  self.first_seen := ri.df;
  self := le;
  end;

j2 := join(j1,first_seens,left.did=right.did,take_fs(left,right),hash,left outer);

export Baddies := j2 : persist('Patriot::Baddies');