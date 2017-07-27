f := Equifax.business_prep;

count(f);
count(f(bdid <> 0));
output(enth(f,1000),all);

layout_slim := record
f.cid;
f.pid;
f.bdid;
end;

fslim := table(f(bdid <> 0), layout_slim);

fdedup := dedup(fslim, cid, pid, all);

count(fdedup);
