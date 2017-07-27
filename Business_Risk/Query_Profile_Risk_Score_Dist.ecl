bhb := Business_Header.File_Business_Header_Best(zip <> 0, prim_name <> '');

layout_bhb_nonblank := record
bhb.bdid;
end;

bhb_nonblank_list := table(bhb, layout_bhb_nonblank);

brt := Business_Risk.BDID_Risk_Table;

layout_brt_score := record
brt.bdid;
brt.PRScore;
end;

brt_score := table(brt, layout_brt_score);

layout_score := record
unsigned1 PRScore;
end;

brt_score_nonblank := join(brt_score,
                           bhb_nonblank_list,
					  left.bdid = right.bdid,
					  transform(layout_score, self := left),
					  hash);


brt_score_blank := join(brt_score,
                           bhb_nonblank_list,
					  left.bdid = right.bdid,
					  transform(layout_score, self := left),
					  left only,
					  hash);

layout_stat_nonblank := record
brt_score_nonblank.PRScore;
cnt := count(group);
end;

brt_stat_nonblank := table(brt_score_nonblank, layout_stat_nonblank, PRScore, few);
output(brt_stat_nonblank, all);

layout_stat_blank := record
brt_score_blank.PRScore;
cnt := count(group);
end;

brt_stat_blank := table(brt_score_blank, layout_stat_blank, PRScore, few);
output(brt_stat_blank, all);