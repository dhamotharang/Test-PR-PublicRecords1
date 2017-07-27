import ut;

export suffix_value(string5 l, string5 r) :=
  MAP( l='' or r='' => 0,
       ut.NNEQ_suffix(l,r) => 1,
       -1 );