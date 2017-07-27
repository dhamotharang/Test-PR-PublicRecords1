h := header.File_Headers;

t := record
  qstring20 fname := datalib.preferredFirst(h.fname);
  h.lname;
  h.did;
  end;

tt := table(h,t);

th := distribute(tt,hash(fname,lname));

ta := dedup(sort(th,lname,fname,did,local),lname,fname,did,local);

tc := record
  ta.fname;
  ta.lname;
  integer4 cnt := count(group);
  end;

tct := table(ta,tc,fname,lname,local);

tad := count(dedup(tt,did,all)); // now fixed : stored('hack_this');

O_Res := record
  tct.fname;
  tct.lname;
  real8 percentage := tct.cnt / tad;
  end;

export FullName_Frequencies := table(tct,O_Res) : persist('Fullname_frequencies') ;