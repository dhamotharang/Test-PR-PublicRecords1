import ut;
export ssn_value(string9 l, string9 r) :=
  MAP( l='' or r='' => 0,
       l = r => 3,
	   (unsigned)l % 10000 = (unsigned)r % 10000 AND 
		(((unsigned)l div 10000) = 0 OR ((unsigned)r div 10000) = 0)  => 1,
       ut.stringsimilar(l,r) < 4 => 3-ut.StringSimilar(l,r),
       -10 );