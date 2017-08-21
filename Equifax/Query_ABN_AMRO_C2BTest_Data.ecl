f := Equifax.abn_amro_c2btest_data_append;

layout_stat := record
cnt_total := count(group);
cnt_bdid_nonzero := count(group, f.bdid <> 0);
cnt_bdid_zero := count(group, f.bdid = 0);
cnt_conf_0 := count(group, f.confidence_level = 0);
cnt_conf_1 := count(group, f.confidence_level = 1);
cnt_conf_2 := count(group, f.confidence_level = 2);
cnt_conf_3 := count(group, f.confidence_level = 3);
cnt_conf_4 := count(group, f.confidence_level = 4);
cnt_conf_5 := count(group, f.confidence_level = 5);
cnt_conf_6 := count(group, f.confidence_level = 6);
cnt_conf_7 := count(group, f.confidence_level = 7);
cnt_nonblank_sic := count(group, f.sic_code1 <> '');
cnt_nonzero_employees := count(group, f.number_of_employees <> '');
cnt_nonzero_annual_sales := count(group, f.annual_sales <> '');
end;

fstat := table(f, layout_stat, few);
output(fstat);

output(choosen(f,5000),all);