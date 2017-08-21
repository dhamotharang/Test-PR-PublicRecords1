f := TM_Test.BayArea2000_Executives;

count(f);
count(f(did <> 0));


layout_slim := record
f.rid;
f.did;
end;

fslim := table(f, layout_slim);

count(dedup(fslim(did <> 0),all));

count(dedup(fslim(did <> 0), rid, all));

count(dedup(fslim(did <> 0), did, all));

layout_stat := record
fslim.rid;
cnt := count(group);
end;

fstat := table(fslim(did <> 0), layout_stat, rid);

count(fstat);
