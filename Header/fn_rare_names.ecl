export fn_rare_names(dataset(layout_matchcandidates) h) := function

r := record
  h.fname;
  h.lname;
  h.did;
  end;

t := distribute( table( h(fname<>'',lname<>''), r ), hash(fname,lname) );

std := dedup( sort(t, fname, lname, did, local), fname, lname, did, local );

rc := record
  t.fname;
  t.lname;
  unsigned4 cnt := count(group);
  end;

tc := table(t,rc,fname,lname,local);

return tc(cnt<100);
  end;