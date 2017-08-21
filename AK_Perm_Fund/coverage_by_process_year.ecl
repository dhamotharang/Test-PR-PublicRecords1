ds := ak_perm_fund.file_APF_In;

r1 := record
 ds.process_year;
 count_ := count(group);
end;

ta1 := sort(table(ds,r1,process_year,few),process_year);

export coverage_by_process_year := output(ta1,all);