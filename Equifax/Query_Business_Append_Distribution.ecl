f := Equifax.business_append;

layout_id := record
f.cid;
f.pid;
f.bdid;
end;

fid := table(f, layout_id);

fid_dedup := dedup(fid, all);


layout_id_stat := record
fid_dedup.bdid;
cid_pid_cnt := count(group);
end;

fid_stat := table(fid_dedup, layout_id_stat, bdid, few);

output(fid_stat(cid_pid_cnt > 1),all);

