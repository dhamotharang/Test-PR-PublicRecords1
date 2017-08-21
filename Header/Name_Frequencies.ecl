export name_frequencies(
	dataset(header.Layout_Header) h
	) :=
FUNCTION

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

tad := count(dedup(ta,did,all)); 

O_Res := record
  tct.lname;
  real8 percentage := tct.cnt / tad;
  end;

return table(tct,O_Res);

END;