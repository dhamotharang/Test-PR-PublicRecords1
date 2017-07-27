f := Equifax.File_SSN(ssn_type = '1');

count(f);

fdedup := dedup(f, cid, pid, all);

count(fdedup);

layout_slim := record
f.cid;
f.pid;
end;

fslim := table(f, layout_slim);

layout_stat := record
fslim.cid;
fslim.pid;
cnt := count(group);
end;

fstat := table(fslim, layout_stat, cid, pid);
count(fstat(cnt > 1));
output(fstat(cnt > 1));

