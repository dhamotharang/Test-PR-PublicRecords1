import header,ut,lib_datalib;
f := header.file_headers;
r1 := record
  f;
  unsigned one := 1;
  end;

r1 take_l(f le) := transform
  self := le;
  end;

t_score := record
  unsigned6 did;
  string20 fname;
  string20 mname;
  string20 lname;
  end;

jo := join(f,distribute(bad_dids,hash(did)),left.did=right.did,take_l(left),local);

b_ndist := badnames_everynode;

t_score take(jo le, b_ndist ri) := transform
  self.did := le.did;
  self.fname := ri.fname;
  self.mname := ri.mname;
  self.lname := ri.lname;
  end;

jt := join(jo,b_ndist,left.one=right.one and
                        lib_datalib.datalib.DoNamesMatch(left.fname,left.mname,left.lname,
                                     right.fname,right.mname,right.lname,3)<3,
                         take(left,right),local,right outer);

export Dids_With_Namehook := jt : persist('Patriot::Dids_With_Namehook');