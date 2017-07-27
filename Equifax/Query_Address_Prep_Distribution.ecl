f := Equifax.address_prep;

//fsort := sort(f, pid, cid);
//output(choosen(fsort,1000));

layout_slim := record
f.cid;
f.pid;
end;

fslim := table(f, layout_slim);

fdedup := dedup(fslim, pid, cid, all);

layout_stat := record
fdedup.cid;
cnt := count(group);
end;

fstat := table(fdedup, layout_stat, cid);
output(fstat(cnt > 1));

layout_fstat1 := record
fstat.cnt;
num := count(group);
end;

fstat1 := table(fstat, layout_fstat1, cnt, few);

output(fstat1, all);
