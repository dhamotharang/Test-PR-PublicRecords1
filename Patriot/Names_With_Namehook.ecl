import header,ut,lib_datalib;

f := File_ScoredNames(score<3);

t_score := record
  string20 fname;
  string20 mname;
  string20 lname;
  string20 bad_fname; // these are the 'hook' values
  string20 bad_mname;
  string20 bad_lname;
  end;

b_ndist := patriot.Bad_Names;

t_score take(f le, b_ndist ri) := transform
  self := le;
  self.bad_fname := ri.fname;
  self.bad_mname := ri.mname;
  self.bad_lname := ri.lname;
  end;

jt := join(f,b_ndist, datalib.DoNamesMatch(left.fname,left.mname,left.lname,
                                     right.fname,right.mname,right.lname,3)<3,
                         take(left,right),left outer,all);

export Names_With_Namehook := jt : persist('Names_With_Namehook');