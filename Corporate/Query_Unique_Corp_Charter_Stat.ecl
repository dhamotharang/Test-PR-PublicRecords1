f := Corporate.File_Corp4_Base;

layout_corp_slim := record
f.state_origin;
f.sos_ter_nbr;
end;

fslim := table(f, layout_corp_slim);

fslim_dedup := dedup(fslim, state_origin, sos_ter_nbr, all);

layout_corp_stat := record
fslim_dedup.state_origin;
corp_charter_cnt := count(group);
end;

fstat := table(fslim_dedup, layout_corp_stat, state_origin, few);

output(fstat);