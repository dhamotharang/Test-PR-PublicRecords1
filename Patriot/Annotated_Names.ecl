// Take actual names, with 'badguy' names hooked and use hook to get badguy
// scores from annotated_badguys

ann_names := record
  string20 fname;
  string20 mname;
  string20 lname;
  unsigned4 cnt;
  end;

ann_names take_score(names_with_namehook le,annotated_badguys ri) := transform
  self.cnt := ri.cnt;
  self := le;
  end;

j := join(names_with_namehook,annotated_badguys,left.bad_fname=right.fname and
          left.bad_mname=right.mname and left.bad_lname=right.lname,
          take_score(left,right),hash);
export Annotated_Names := j : persist('annotated_names');