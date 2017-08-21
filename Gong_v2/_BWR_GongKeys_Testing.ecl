#workunit('name', 'Build Gong Test Keys')
#workunit('protect', true)
#workunit('priority', 'high')

lstUpdateNo   := fileservices.GetSuperFileSubCount(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building') : global; 
lstUpdateName := fileservices.GetSuperFileSubName(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building',lstUpdateNo) : global;
rundate   := stringlib.stringfilter(lstUpdateName,'0123456789')[1..8] : global;

 parallel(
 sequential(gong_v2.proc_build_roxie_keys(rundate), gong_v2.proc_compare_v1_and_v2_keys),
 sequential(Gong_v2.proc_build_keys_history_jtrost(rundate), Gong_v2.proc_compare_history_v1_and_v2_keys)
 )
 : WHEN(event('GONG BASE KEYS COMPLETE','*'), count(1))
 ;