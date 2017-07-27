f := Equifax.business_prep;

layout_slim := record
f.cid;
f.pid;
f.bdid;
end;

fslim := table(f(bdid <> 0), layout_slim);
fslim_dedup := dedup(fslim, cid, pid, bdid, all);

layout_stat := record
fslim_dedup.cid;
fslim_dedup.pid;
bdid_cnt := count(group);
end;

fstat := table(fslim_dedup, layout_stat, cid, pid, few);

output(fstat(bdid_cnt >= 10), all);

layout_stat1 := record
fstat.bdid_cnt;
cid_pid_cnt := count(group);
end;

fstat1 := table(fstat, layout_stat1, bdid_cnt, few);

output(fstat1, all);
