f := dataset('~thor_data400::TMTEST::abn_amro_c2btest_data_append', Equifax.Layout_ABN_AMRO_C2BTest_Base, flat, __compressed__);

layout_stat := record
f.seq;
cnt_bdid_nonzero := count(group, f.bdid <> 0);
cnt_bdid_zero := count(group, f.bdid = 0);
cnt_conf_nonzero := count(group, f.confidence_level <> 0);
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

fstat := table(f, layout_stat, seq, few);

layout_fstat1 := record
cnt_seq_bdid_nonzero := count(group, fstat.cnt_bdid_nonzero <> 0);
cnt_seq_bdid_zero := count(group, fstat.cnt_bdid_zero <> 0);
cnt_seq_conf_nonzero := count(group, fstat.cnt_conf_nonzero <> 0);
cnt_seq_conf_0 := count(group, fstat.cnt_conf_0 <> 0);
cnt_seq_conf_1 := count(group, fstat.cnt_conf_1 <> 0);
cnt_seq_conf_2 := count(group, fstat.cnt_conf_2 <> 0);
cnt_seq_conf_3 := count(group, fstat.cnt_conf_3 <> 0);
cnt_seq_conf_4 := count(group, fstat.cnt_conf_4 <> 0);
cnt_seq_conf_5 := count(group, fstat.cnt_conf_5 <> 0);
cnt_seq_conf_6 := count(group, fstat.cnt_conf_6 <> 0);
cnt_seq_conf_7 := count(group, fstat.cnt_conf_7 <> 0);
cnt_seq_nonblank_sic := count(group, fstat.cnt_nonblank_sic <> 0);
cnt_seq_nonzero_employees := count(group, fstat.cnt_nonzero_employees <> 0);
cnt_seq_nonzero_annual_sales := count(group, fstat.cnt_nonzero_annual_sales <> 0);
end;

fstat1 := table(fstat, layout_fstat1);

output(fstat1);

