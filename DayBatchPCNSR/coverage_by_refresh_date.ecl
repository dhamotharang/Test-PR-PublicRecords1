pcnsr_file := daybatchpcnsr.file_pcnsr;

r1 := record
 pcnsr_file.refresh_date;
 count_ := count(group);
end;

ta1 := sort(table(pcnsr_file,r1,refresh_date,few),refresh_date);

export coverage_by_refresh_date := output(ta1,all);