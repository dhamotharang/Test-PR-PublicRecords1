f := Corp.File_Corp_Base;

layout_slim := record
f.corp_state_origin;
f.corp_vendor;
end;

fslim := table(f, layout_slim);

layout_stat := record
fslim.corp_state_origin;
fslim.corp_vendor;
cnt := count(group);
end;

fstat := table(fslim, layout_stat, corp_state_origin, corp_vendor, few);

output(fstat, all);

