export integer namecheck(string20 f1,string20 m1, string20 l1,
   string20 f2,string20 m2, string20 l2) := Min(datalib.namematch(f1,m1,l1,f2,m2,l2),3);