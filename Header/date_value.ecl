import ut;

export date_value(integer l, integer r) :=
  MAP( l=0 or r=0 => 0,
       ut.date_quality(l)>=5 and l=r => 3,
       ut.mob(l)=ut.mob(r) => 2,
       header.sig_near_dob(l,r) => 1,
	  header.Date_Typos(l,r) => 0, -10 );