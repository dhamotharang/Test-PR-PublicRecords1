c := pgarg_vehreg_analysis.File_MOMV;
stat_rec := record
c.org_reg_dt;
total:= count(group);
end;

stat_file := table(c,stat_rec,org_reg_dt,few);
sort_stat1 := sort(stat_file,org_reg_dt); 
sort_stat2 := sort(stat_file,-org_reg_dt); 

output(sort_stat1);
output(sort_stat2);