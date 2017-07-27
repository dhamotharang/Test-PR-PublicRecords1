f := Equifax.principal_business_extended;

count(f);

count(f(record_type='1'));
count(f(record_type='2'));


layout_slim := record
f.cid;
f.pid;
f.record_type;
end;

fslim := table(f, layout_slim);

layout_stat := record
fslim.cid;
fslim.pid;
rec_type1_cnt := count(group, fslim.record_type = '1');
rec_type2_cnt := count(group, fslim.record_type = '2');
end;

fstat := table(fslim, layout_stat, cid, pid, few);

layout_stat1 := record
fstat.rec_type1_cnt;
fstat.rec_type2_cnt;
cid_pid_cnt := count(group);
end;

fstat1 := table(fstat, layout_stat1, rec_type1_cnt, rec_type2_cnt, few);

output(fstat1,all);
