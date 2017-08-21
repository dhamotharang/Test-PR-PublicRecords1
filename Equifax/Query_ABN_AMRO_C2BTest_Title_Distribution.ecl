import ut;

#workunit ('name', 'ABN AMRO C2BTest Title Distribution Stats ' + Business_Header.version);

bc := dataset('~thor_data400::TMTEST::abn_amro_c2btest_data_append', Equifax.Layout_ABN_AMRO_C2BTest_Base, flat, __compressed__);
//bc := Equifax.abn_amro_c2btest_data_append;

bc_dedup := dedup(bc, seq, contact_title, all);

layout_bc_slim := record
bc_dedup.contact_title;
end;

bc_slim := table(bc(contact_title <> ''), layout_bc_slim);

layout_bc_title_stat := record
bc_slim.contact_title;
unsigned4 cnt := count(group);
end;

bc_title_stat := table(bc_slim, layout_bc_title_stat, contact_title, few);

output(topn(bc_title_stat, 1000, -cnt), all, named('Business_Contact_Title_Distribution'));


layout_bc_title_rank_stat := record
cnt_title_total := count(group);
cnt_title_rank_1 := count(group, ut.TitleRank(bc_slim.contact_title) = 1);
cnt_title_rank_2 := count(group, ut.TitleRank(bc_slim.contact_title) = 2);
cnt_title_rank_3 := count(group, ut.TitleRank(bc_slim.contact_title) = 3);
cnt_title_rank_4 := count(group, ut.TitleRank(bc_slim.contact_title) = 4);
cnt_title_rank_5 := count(group, ut.TitleRank(bc_slim.contact_title) = 5);
cnt_title_rank_6 := count(group, ut.TitleRank(bc_slim.contact_title) = 6);
cnt_title_rank_other := count(group, ut.TitleRank(bc_slim.contact_title) > 6);
end;

bc_title_rank_stat := table(bc_slim, layout_bc_title_rank_stat, few);

output(bc_title_rank_stat, named('Business_Contact_Title_Rank_Distribution'));
