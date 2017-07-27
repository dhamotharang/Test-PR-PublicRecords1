f := Corp.File_Corp_Base;

layout_corp_slim := record
f.corp_state_origin;
f.corp_sos_charter_nbr;
end;

fslim := table(f, layout_corp_slim);

fslim_dedup := dedup(fslim, corp_state_origin, corp_sos_charter_nbr, all);

layout_corp_stat := record
fslim_dedup.corp_state_origin;
corp_charter_cnt := count(group);
end;

fstat := table(fslim_dedup, layout_corp_stat, corp_state_origin, few);

output(fstat);