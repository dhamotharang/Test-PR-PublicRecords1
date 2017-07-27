#option('outputLimit', 30);

f := Equifax.business_append;

fdedup := dedup(f, cid, pid, bdid, all);

fsort := sort(fdedup, cid, pid, bdid);

output(fsort, all);
