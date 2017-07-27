integer adj(x) := if(x <> 0 and x % 100 = 0, x + 13, x);

export EarliestDate(integer l, integer r) := if ( l=0 or r<>0 and adj(r)<adj(l),r,l);