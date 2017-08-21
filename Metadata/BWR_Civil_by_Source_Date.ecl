// Civil by Source Date by John J. Bulten W20070926-134811 20080623-121115

dDev := dedup(table(civil_court.File_In_Case_Activity/*(state_origin='CA')*/,{source_file},unsorted));
dDev2 := dedup(table(civil_court.File_In_Matter/*(state_origin='CA')*/,{source_file,filing_date},unsorted));

output(table(dDev,{source_file,count(group)},source_file),all);
output(table(dDev2,{source_file,count(group)},source_file),all);

output(table(dDev2,{source_file,filing_date,count(group)},source_file,filing_date),all);