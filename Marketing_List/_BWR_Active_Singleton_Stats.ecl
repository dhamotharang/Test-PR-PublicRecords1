// BIPV2_ProxID._BWR_Singleton_Stats

ds_mkrting  := Marketing_List.Files().business_information.qa;
ds_bip_base := bipv2.CommonBase.ds_base;

ds_mrkting_proxids  := table(ds_mkrting  ,{proxid} ,proxid ,merge);
ds_bip_base_slim    := table(ds_bip_base ,{proxid,proxid_status_public}  ,proxid,proxid_status_public ,merge);
ds_bip_base_slim_ingest_status    := table(ds_bip_base ,{proxid,ingest_status}  ,proxid,ingest_status ,merge);

ds_bip_base_cnt    := table(ds_bip_base ,{proxid,unsigned cnt := count(group)}  ,proxid,merge);

ds_bip_base_combined2 := join(ds_bip_base_slim ,ds_bip_base_cnt(cnt = 1)  ,left.proxid = right.proxid ,transform({recordof(left) or recordof(right)},self := left,self := right)  ,hash);
ds_bip_base_combined := join(ds_bip_base_combined2 ,ds_bip_base_slim_ingest_status  ,left.proxid = right.proxid ,transform({recordof(left) or recordof(right)},self := left,self := right)  ,hash);

ds_mrkting_status := join(ds_bip_base_combined  ,ds_mrkting_proxids  ,left.proxid = right.proxid  ,transform({unsigned6 proxid,string proxid_status_public,unsigned cnt},self := right,self := left)  ,hash,keep(1));

ds_table := table(ds_mrkting_status ,{proxid_status_public  ,unsigned cnt := count(group)}  ,proxid_status_public ,few);

ds_table2 := table(ds_mrkting_status ,{proxid_status_public  ,string cluster_type := if(cnt = 1,'Singleton','Non-singleton')  ,unsigned cnt := count(group)}  ,proxid_status_public ,if(cnt = 1,1,2),few);

output(count(ds_bip_base_cnt) ,named('total_proxids'));
output(count(ds_bip_base_cnt(cnt = 1)) ,named('total_proxid_singletons'));
output(count(ds_bip_base_combined(trim(proxid_status_public) = '',cnt = 1)) ,named('total_proxid_active_singletons'));
output(count(ds_bip_base_combined(trim(proxid_status_public) != '',cnt = 1)) ,named('total_proxid_Not_Active_singletons'));
output(count(ds_bip_base_combined(trim(proxid_status_public) != '',cnt = 1,trim(ingest_status) = 'Old')) ,named('total_proxid_Not_Active_Old_singletons'));
output(count(ds_bip_base_combined(trim(proxid_status_public) = '',cnt = 1,trim(ingest_status) = 'Old')) ,named('total_proxid_Active_Old_singletons'));
output(count(ds_bip_base_combined(trim(proxid_status_public) = '',cnt = 1,trim(ingest_status) != 'Old')) ,named('total_proxid_Active_Not_Old_singletons'));
output(ds_table ,named('Marketing_Status_counts'));
output(ds_table2  ,named('Marketing_Status_counts_with_singletons'),all);

// -------------------------------
// ds_bip_mrkting                            := table(ds_bip_base ,{proxid,string source := mdr.sourcetools.translatesource(source) }  ,proxid,source  ,merge  );
// ds_bip_mrkting_cnt_sources_per_proxid     := table(ds_bip_mrkting ,{proxid ,unsigned cnt := count(group)}  ,proxid  ,merge  );
// ds_bip_mrkting_singleton_sourced_proxids  := ds_bip_mrkting_cnt_sources_per_proxid(cnt = 1);
