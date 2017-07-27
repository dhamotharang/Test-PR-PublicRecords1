f := Corp.File_Corp_Cont_Out;

layout_corp_cont_slim := record
f.corp_state_origin;
f.did;
end;

fslim := table(f(did <> ''), layout_corp_cont_slim);

fslim_dedup := dedup(fslim, corp_state_origin, did, all);

layout_corp_cont_stat := record
fslim_dedup.corp_state_origin;
unique_did_cnt := count(group);
end;

fstat := table(fslim_dedup, layout_corp_cont_stat, corp_state_origin, few);

output(fstat);