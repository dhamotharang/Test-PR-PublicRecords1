dcafile := dca.File_DCA_all_In;
//output(voters);

layout_dca_slim := record
dcafile.root;
dcafile.sub;
end;

dca_slim := table(dcafile, layout_dca_slim);

layout_dca_stat := record
dca_slim.root;
dca_slim.sub;
integer4 cnt := count(group);
end;

dca_stats := table(dca_slim, layout_dca_stat, root, sub);

count(dca_stats);

layout_dca_stat_out := record
dca_stats.root;
dca_stats.sub;
string9 cnt_out := ' ';
string1 lf := '\n';
end;

layout_dca_stat_out convert2out(dca_stats L) := transform
self := L;
self.cnt_out := intformat(L.cnt,9,1);
end;

dca_stat_out := project(dca_stats, convert2out(left));


output(dca_stat_out,,'thor_data400::out::dca_source_group_stats',OVERWRITE);
