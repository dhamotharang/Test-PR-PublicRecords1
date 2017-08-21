import ut;

bc := Business_Header.File_Business_Contacts;

layout_bc_slim := record
bc.company_title;
end;

bc_slim := table(bc(company_title <> ''), layout_bc_slim);

bc_slim_cnt := count(bc_slim);

layout_bc_title_stat := record
bc_slim.company_title;
unsigned4 cnt := count(group);
end;

bc_title_stat := table(bc_slim, layout_bc_title_stat, company_title, few);

layout_freq_stat := record
bc_title_stat.company_title;
bc_title_stat.cnt;
unsigned4 freq := count(group);
total_cnt := sum(group, bc_title_stat.cnt);
real pct_total := sum(group, bc_title_stat.cnt)/bc_slim_cnt;
end;

bc_title_freq := table(bc_title_stat, layout_freq_stat, company_title, cnt, few);

count(bc_title_freq(freq=1));

output(topn(bc_title_freq(freq=1), 10000, -total_cnt),all);

