layout_record_counts := record
unsigned6 bdid;
unsigned3 corp_record_cnt;
unsigned3 ucc_record_cnt;
unsigned3 fbn_record_cnt;
unsigned3 busreg_record_cnt;
unsigned3 bk_record_cnt;
unsigned3 lj_record_cnt;
end;


f := dataset('TEMP::equifax_record_count_rollup', layout_record_counts, flat);

output(choosen(f,1000));
