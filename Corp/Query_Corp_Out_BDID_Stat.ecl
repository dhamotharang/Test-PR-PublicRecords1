f := Corp.File_Corp_Out;

layout_corp_slim := record
f.corp_state_origin;
f.bdid;
end;

fslim := table(f(bdid <> ''), layout_corp_slim);

fslim_dedup := dedup(fslim, corp_state_origin, bdid, all);

layout_corp_stat := record
fslim_dedup.corp_state_origin;
unique_bdid_cnt := count(group);
end;

fstat := table(fslim_dedup, layout_corp_stat, corp_state_origin, few);

output(fstat);