import ut;

#workunit ('name', 'Business Contact Title Distribution Stats ' + Business_Header.version);

bc := Business_Header.File_Business_Contacts;

layout_bc_slim := record
bc.company_title;
end;

bc_slim := table(bc(company_title <> ''), layout_bc_slim);

layout_bc_title_stat := record
bc_slim.company_title;
unsigned4 cnt := count(group);
end;

bc_title_stat := table(bc_slim, layout_bc_title_stat, company_title, few);

output(topn(bc_title_stat, 1000, -cnt), all, named('Business_Contact_Title_Distribution'));


layout_bc_title_rank_stat := record
cnt_title_total := count(group);
cnt_title_rank_1 := count(group, ut.TitleRank(bc_slim.company_title) = 1);
cnt_title_rank_2 := count(group, ut.TitleRank(bc_slim.company_title) = 2);
cnt_title_rank_3 := count(group, ut.TitleRank(bc_slim.company_title) = 3);
cnt_title_rank_4 := count(group, ut.TitleRank(bc_slim.company_title) = 4);
cnt_title_rank_5 := count(group, ut.TitleRank(bc_slim.company_title) = 5);
cnt_title_rank_6 := count(group, ut.TitleRank(bc_slim.company_title) = 6);
cnt_title_rank_other := count(group, ut.TitleRank(bc_slim.company_title) > 6);
end;

bc_title_rank_stat := table(bc_slim, layout_bc_title_rank_stat, few);

output(bc_title_rank_stat, named('Business_Contact_Title_Rank_Distribution'));
