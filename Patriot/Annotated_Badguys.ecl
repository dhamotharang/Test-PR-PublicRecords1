jt := dids_with_namehook;

popu := record
  jt.fname;
  jt.mname;
  jt.lname;
  unsigned4 cnt := count(group);
  end;

ta := table(dedup(jt,fname,mname,lname,did,all),popu,fname,mname,lname);

export Annotated_Badguys := sort(ta,-cnt) : persist('Patriot::Annotated_Badguys');