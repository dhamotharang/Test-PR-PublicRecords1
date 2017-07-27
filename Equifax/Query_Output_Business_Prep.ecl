#option('outputLimit', 30);

f := Equifax.business_prep;

fsort := sort(f, cid, pid, if(bdid <> 0, 0, 1), bdid);

output(fsort, all);
