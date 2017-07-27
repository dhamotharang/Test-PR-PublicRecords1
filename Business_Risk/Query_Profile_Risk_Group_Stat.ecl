// Calculate min, max, and average profile risk scores by group
// Ignore groups with blank addresses

bhb := Business_Header.File_Business_Header_Best(zip <> 0, prim_name <> '');

layout_bhb_nonblank := record
bhb.bdid;
end;

bhb_nonblank_list := table(bhb, layout_bhb_nonblank);

//brt := Business_Risk.BDID_Risk_Table;
layout_bdid_risk_table_temp := record
unsigned6 bdid;
unsigned1 PRScore := 0;
string120 best_CompanyName := '';
string60 best_addr1 := '';
string60 best_addr2 := '';
string10  best_phone := '';
string9   best_fein := '';
unsigned1 busreg_flag;
unsigned1 corp_flag;
unsigned1 dnb_flag;
unsigned1 irs5500_flag;
unsigned1 st_flag;
unsigned1 ucc_flag;
unsigned1 yp_flag;
unsigned1 tier1srcs;
unsigned1 t1scr5;
unsigned1 currphn;
unsigned1 currcorp;
unsigned1 currbr;
unsigned1 currdnb;
unsigned1 currucc;
unsigned1 curry;
unsigned1 currt1cnt;
unsigned1 currt1src4;
unsigned2 year_lj;
unsigned1 lj;
unsigned1 ustic;
unsigned1 t1x;
unsigned2 OFAC_cnt := 0;
unsigned2 cnt_B;
end;

brt := dataset('TEMP::bdid_profile_risk_table', layout_bdid_risk_table_temp, flat);

layout_brt_score := record
brt.bdid;
brt.PRScore;
end;

brt_score := table(brt, layout_brt_score);

brt_score_nonblank := join(brt_score,
                           bhb_nonblank_list,
					  left.bdid = right.bdid,
					  transform(layout_brt_score, self := left),
					  hash);


layout_brt_group := record
unsigned6 group_id;
brt_score_nonblank;
end;

bhg := Business_Header.File_Super_Group;

brt_group := join(brt_score_nonblank,
                  bhg,
			   left.bdid = right.bdid,
			   transform(layout_brt_group, self.group_id := right.group_id, self := left),
			   left outer,
			   hash);
			   
layout_brt_group_slim := record
brt_group.group_id;
brt_group.PRScore;
end;

brt_group_slim := table(brt_group, layout_brt_group_slim);

layout_brt_group_stat := record
brt_group_slim.group_id;
unsigned4 size_grp := count(group);
unsigned1 min_grp_prscore := min(group, brt_group_slim.PRScore);
unsigned1 max_grp_prscore := max(group, brt_group_slim.PRScore);
unsigned1 ave_grp_prscore := round(ave(group, brt_group_slim.PRScore));
end;

brt_group_stat := table(brt_group_slim, layout_brt_group_stat, group_id);

// Calculate distribution of group size, min, max, and average scores
layout_size_stat := record
brt_group_stat.size_grp;
cnt := count(group);
end;

brt_size_group_stat := table(brt_group_stat, layout_size_stat, size_grp, few);
output(brt_size_group_stat, all);

layout_min_stat := record
brt_group_stat.min_grp_prscore;
cnt_groups := count(group);
sum_group_bdids := sum(group, brt_group_stat.size_grp);
end;

brt_min_grp_prscore_stat := table(brt_group_stat, layout_min_stat, min_grp_prscore, few);
output(brt_min_grp_prscore_stat, all);

layout_max_stat := record
brt_group_stat.max_grp_prscore;
cnt_groups := count(group);
sum_group_bdids := sum(group, brt_group_stat.size_grp);
end;

brt_max_grp_prscore_stat := table(brt_group_stat, layout_max_stat, max_grp_prscore, few);
output(brt_max_grp_prscore_stat, all);

layout_ave_stat := record
brt_group_stat.ave_grp_prscore;
cnt_groups := count(group);
sum_group_bdids := sum(group, brt_group_stat.size_grp);
end;

brt_ave_grp_prscore_stat := table(brt_group_stat, layout_ave_stat, ave_grp_prscore, few);
output(brt_ave_grp_prscore_stat, all);