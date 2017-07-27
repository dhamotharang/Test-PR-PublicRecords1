export SSNMatch100(string9 l, string9 r) := 
          MAP(l='' or r ='' => 0,
	         (unsigned)l % 10000 = (unsigned)r % 10000 AND 
	         (((unsigned)l div 10000) = 0 OR ((unsigned)r div 10000) = 0)  => 95,
		    l = r => 100,
              100-datalib.StringSimilar100(l,r));;