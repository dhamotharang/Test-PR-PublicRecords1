#workunit ('name', 'Business Header GroupID Research');

bh := Business_Header.File_Super_Group;
/*
// Count Unique BDIDs in the Business Header file
layout_bh_slim := record
bh.group_id;
end;

bh_slim := table(bh, layout_bh_slim);

layout_bh_stat := record
bh_slim.group_id;
cnt := count(group);
end;

bh_stats := table(bh_slim, layout_bh_stat, group_id);

count(bh_stats);  // number of unique bdids


output(topn(bh_stats, 1000,-cnt),all);

//now for top 10 groups, get best information for all companies in a group, and aggregate on company name
top1 := topn(bh_stats,1,-cnt);
top2 := choosen(topn(bh_stats,2,-cnt),1,2);
top3 := choosen(topn(bh_stats,3,-cnt),1,3);
top4 := choosen(topn(bh_stats,4,-cnt),1,4);
top5 := choosen(topn(bh_stats,5,-cnt),1,5);

//now got top 5 groupids
//now get the bdids in those groups from the supergroup file
layout_bh_group := record
top1.group_id;
end;

top1_grouponly := table(top1,layout_bh_group);
*/
bs := Business_Header.File_Super_Group;

layout_bh_bdid := record
bs.bdid;
end;

top1_bdids := sort(distribute(table(bs(group_id = 95774001),layout_bh_bdid), bdid),bdid,local);
top2_bdids := sort(distribute(table(bs(group_id = 11224),layout_bh_bdid), bdid),bdid,local);
top3_bdids := sort(distribute(table(bs(group_id = 25587),layout_bh_bdid), bdid),bdid,local);
top4_bdids := sort(distribute(table(bs(group_id = 27169),layout_bh_bdid), bdid),bdid,local);
top5_bdids := sort(distribute(table(bs(group_id = 52211),layout_bh_bdid), bdid),bdid,local);
top6_bdids := sort(distribute(table(bs(group_id = 534),layout_bh_bdid), bdid),bdid,local);
top7_bdids := sort(distribute(table(bs(group_id = 12008),layout_bh_bdid), bdid),bdid,local);
top8_bdids := sort(distribute(table(bs(group_id = 15798),layout_bh_bdid), bdid),bdid,local);
top9_bdids := sort(distribute(table(bs(group_id = 6916),layout_bh_bdid), bdid),bdid,local);
top10_bdids := sort(distribute(table(bs(group_id = 42658),layout_bh_bdid), bdid),bdid,local);

output('top1 number of bdids: ' + count(top1_bdids));
output('top2 number of bdids: ' + count(top2_bdids));
output('top3 number of bdids: ' + count(top3_bdids));
output('top4 number of bdids: ' + count(top4_bdids));
output('top5 number of bdids: ' + count(top5_bdids));
output('top6 number of bdids: ' + count(top6_bdids));
output('top7 number of bdids: ' + count(top7_bdids));
output('top8 number of bdids: ' + count(top8_bdids));
output('top9 number of bdids: ' + count(top9_bdids));
output('top10 number of bdids: ' + count(top10_bdids));
 
bhb := sort(distribute(business_header.File_Business_Header_Best,bdid),bdid,local);


business_header.Layout_BH_Best getbestinfo(layout_bh_bdid l, bhb R) := transform
self := R;
end;

top1_best := join(top1_bdids, bhb, left.bdid = right.bdid,getbestinfo(left,right),local);
top2_best := join(top2_bdids, bhb, left.bdid = right.bdid,getbestinfo(left,right),local);
top3_best := join(top3_bdids, bhb, left.bdid = right.bdid,getbestinfo(left,right),local);
top4_best := join(top4_bdids, bhb, left.bdid = right.bdid,getbestinfo(left,right),local);
top5_best := join(top5_bdids, bhb, left.bdid = right.bdid,getbestinfo(left,right),local);
top6_best := join(top6_bdids, bhb, left.bdid = right.bdid,getbestinfo(left,right),local);
top7_best := join(top7_bdids, bhb, left.bdid = right.bdid,getbestinfo(left,right),local);
top8_best := join(top8_bdids, bhb, left.bdid = right.bdid,getbestinfo(left,right),local);
top9_best := join(top9_bdids, bhb, left.bdid = right.bdid,getbestinfo(left,right),local);
top10_best := join(top10_bdids, bhb, left.bdid = right.bdid,getbestinfo(left,right),local);

output(top1_best,,'out::bh_top_1_group',overwrite);
output(top2_best,,'out::bh_top_2_group',overwrite);
output(top3_best,,'out::bh_top_3_group',overwrite);
output(top4_best,,'out::bh_top_4_group',overwrite);
output(top5_best,,'out::bh_top_5_group',overwrite);
output(top6_best,,'out::bh_top_6_group',overwrite);
output(top7_best,,'out::bh_top_7_group',overwrite);
output(top8_best,,'out::bh_top_8_group',overwrite);
output(top9_best,,'out::bh_top_9_group',overwrite);
output(top10_best,,'out::bh_top_10_group',overwrite);


layout_comp_table := record
top1_best.company_name;
integer4 cnt := count(group);
end;
layout_comp_table2 := record
top2_best.company_name;
integer4 cnt := count(group);
end;
layout_comp_table3 := record
top3_best.company_name;
integer4 cnt := count(group);
end;
layout_comp_table4 := record
top4_best.company_name;
integer4 cnt := count(group);
end;
layout_comp_table5 := record
top5_best.company_name;
integer4 cnt := count(group);
end;
layout_comp_table6 := record
top6_best.company_name;
integer4 cnt := count(group);
end;
layout_comp_table7 := record
top7_best.company_name;
integer4 cnt := count(group);
end;
layout_comp_table8 := record
top8_best.company_name;
integer4 cnt := count(group);
end;
layout_comp_table9 := record
top9_best.company_name;
integer4 cnt := count(group);
end;
layout_comp_table10 := record
top10_best.company_name;
integer4 cnt := count(group);
end;

top1_companies := table(top1_best, layout_comp_table, company_name);
top2_companies := table(top2_best, layout_comp_table2, company_name);
top3_companies := table(top3_best, layout_comp_table3, company_name);
top4_companies := table(top4_best, layout_comp_table4, company_name);
top5_companies := table(top5_best, layout_comp_table5, company_name);
top6_companies := table(top6_best, layout_comp_table6, company_name);
top7_companies := table(top7_best, layout_comp_table7, company_name);
top8_companies := table(top8_best, layout_comp_table8, company_name);
top9_companies := table(top9_best, layout_comp_table9, company_name);
top10_companies := table(top10_best, layout_comp_table10, company_name);


output(top1_companies,,'out::bh_top1_companY_count',overwrite);
output(top2_companies,,'out::bh_top2_companY_count',overwrite);
output(top3_companies,,'out::bh_top3_companY_count',overwrite);
output(top4_companies,,'out::bh_top4_companY_count',overwrite);
output(top5_companies,,'out::bh_top5_companY_count',overwrite);
output(top6_companies,,'out::bh_top6_companY_count',overwrite);
output(top7_companies,,'out::bh_top7_companY_count',overwrite);
output(top8_companies,,'out::bh_top8_companY_count',overwrite);
output(top9_companies,,'out::bh_top9_companY_count',overwrite);
output(top10_companies,,'out::bh_top10_companY_count',overwrite);

output(topn(top1_companies,1000,-cnt), named('top1_companies'), all);
output(topn(top2_companies,1000,-cnt), named('top2_companies'), all);
output(topn(top3_companies,1000,-cnt), named('top3_companies'), all);
output(topn(top4_companies,1000,-cnt), named('top4_companies'), all);
output(topn(top5_companies,1000,-cnt), named('top5_companies'), all);
output(topn(top6_companies,1000,-cnt), named('top6_companies'), all);
output(topn(top7_companies,1000,-cnt), named('top7_companies'), all);
output(topn(top8_companies,1000,-cnt), named('top8_companies'), all);
output(topn(top9_companies,1000,-cnt), named('top9_companies'), all);
output(topn(top10_companies,1000,-cnt), named('top10_companies'), all);
