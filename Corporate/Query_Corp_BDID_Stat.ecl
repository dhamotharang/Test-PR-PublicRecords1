f := Corporate.File_Corp4_Base;

layout_corp_slim := record
f.state_origin;
f.bdid;
end;

fslim := table(f(bdid <> 0), layout_corp_slim);

fslim_dedup := dedup(fslim, state_origin, bdid, all);

layout_corp_stat := record
fslim_dedup.state_origin;
unique_bdid_cnt := count(group);
end;

fstat := table(fslim_dedup, layout_corp_stat, state_origin, few);

output(fstat);