abius_company_base := infousa.File_ABIUS_Company_Data_In;

// Count blank fields 
layout_abius_slim := record
abius_company_base.DATE_ADDED;
abius_company_base.PRODUCTION_DATE;
end;

abius_slim := table(abius_company_base, layout_abius_slim);

layout_abius_stat_added := record
abius_slim.DATE_ADDED;
cnt := count(group);
end;

abius_stats_added := table(abius_slim, layout_abius_stat_added, DATE_ADDED);

layout_abius_stat_prod := record
abius_slim.PRODUCTION_DATE;
cnt := count(group);
end;

abius_stats_prod := table(abius_slim, layout_abius_stat_prod, PRODUCTION_DATE);

output('TOTAL RECS IN ABIUS FILE: ' + count(infousa.File_ABIUS_Company_Data_In));
output('TOTAL RECS IN ABIUS FILE WITH DATE ADDED POPULATED: ' + 
		count(infousa.File_ABIUS_Company_Data_In(DATE_ADDED <> '')));
output('TOTAL RECS IN ABIUS FILE WITH PRODUCTION DATE POPULATED: ' + 
		count(infousa.File_ABIUS_Company_Data_In(PRODUCTION_DATE <> '')));
output(abius_stats_added, all);
output(count(abius_stats_added));
output(abius_stats_prod, all);
output(count(abius_stats_prod));