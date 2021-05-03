ds_base := table(bipv2.commonbase.ds_built(dt_last_seen != 0) ,{source,dt_last_seen,unsigned cnt := count(group)} ,source,dt_last_seen ,merge)
  : persist('~persist::lbentley::ds_base');

// -- examine frequency of dt_last_seens
ds_base_total_per_source := table(ds_base ,{source,unsigned total_cnt := sum(group,cnt)} ,source  ,merge);

ds_join := join(ds_base ,ds_base_total_per_source ,left.source = right.source ,transform({string source,unsigned4 dt_last_seen,string pct_total,unsigned cnt,unsigned total_cnt} 

  ,self.source := mdr.sourcetools.translatesource(left.source)
  ,self := right
  ,self := left  
  ,self.pct_total := realformat((left.cnt / right.total_cnt) * 100.0 ,8,4)

)  ,lookup);

output(topn(ds_join ,500,-(real8)pct_total,-cnt) ,named('Sources_DESC_pct_date'),all);

output(topn(ds_join ,500,-cnt,-(real8)pct_total) ,named('Sources_DESC_cnt'),all);



ds_dedup := dedup(sort(ds_join ,source,-(real8)pct_total ),source  ,keep(5));

output(topn(ds_dedup ,1000,source,-(real8)pct_total,-cnt) ,named('Sources_source_DESC_pct_date'),all);

ds_dedup2 := dedup(sort(ds_join ,source,-cnt,-(real8)pct_total ),source );
ds_dedup3 := dedup(sort(ds_join ,source,-(real8)pct_total,-cnt ),source );

ds_join2 := join(ds_dedup ,ds_dedup2  ,left.source = right.source ,transform({recordof(left),unsigned highest_cnt},self.highest_cnt := right.cnt      ,self := left)  ,lookup);
ds_join3 := join(ds_join2 ,ds_dedup3  ,left.source = right.source ,transform({recordof(left),string   highest_pct},self.highest_pct := right.pct_total,self := left)  ,lookup);

output(topn(ds_join3 ,1000,-highest_cnt,source,-(real8)pct_total,-cnt) ,named('Sources_source_DESC_pct_date2'),all);
output(topn(ds_join3 ,1000,-(real8)highest_pct,source,-highest_cnt,-cnt) ,named('Sources_source_DESC_pct_date3'),all);
