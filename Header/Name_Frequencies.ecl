h := header.File_Headers;

t := record
  h.lname;
  h.did;
  end;

tt := table(h,t);

th := distribute(tt,hash(lname));

ta := dedup(sort(th,lname,did,local),lname,did,local);

tc := record
  ta.lname;
  integer4 cnt := count(group);
  end;

tct := table(ta,tc,lname,local);

tad := count(dedup(tt,did,all)); // now fixed : stored('hack_this');

O_Res := record
  tct.lname;
  real8 percentage := tct.cnt / tad;
  end;

export name_frequencies := table(tct,O_Res) : persist('name_frequencies') ;