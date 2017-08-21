f := TM_Test.BayArea2000_prep;

count(f);
count(f(bdid <> 0));


layout_slim := record
f.rid;
f.bdid;
end;

fslim := table(f, layout_slim);

count(dedup(fslim(bdid <> 0), all));

count(dedup(fslim(bdid <> 0), rid, all));

count(dedup(fslim(bdid <> 0), bdid, all));


layout_stat := record
fslim.rid;
cnt := count(group);
end;

fstat := table(fslim(bdid <> 0), layout_stat, rid);

count(fstat);
