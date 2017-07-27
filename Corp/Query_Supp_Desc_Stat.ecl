f := Corp.File_Corp_Supp_Base;

layout_supp_slim := record
f.supp_type_cd;
f.supp_type_desc;
end;

fslim := table(f, layout_supp_slim);

layout_supp_stat := record
fslim.supp_type_cd;
fslim.supp_type_desc;
cnt := count(group);
end;

fstat := table(fslim, layout_supp_stat, supp_type_cd, supp_type_desc);

output(choosen(fstat,1000));