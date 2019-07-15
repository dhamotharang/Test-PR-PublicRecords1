version         := '20181101'         ;

wuid_runingest              := 'W20181102-002206' ;
wuid_powid_postprocess      := 'W20181118-152625' ; 
wuid_hrchy                  := 'W20181109-065601' ;
ds_base                     := bipv2.CommonBase.DS_Base   ;
ds_father                   := bipv2.CommonBase.DS_Father ;

BIPV2_QA_Tool.mac_Ingest_Stats              (wuid_runingest,version); //BIPV2 runIngest 20181101
BIPV2_QA_Tool.proc_PostProcess_Stats        (version  ,ds_base ,ds_father); // -- PostProcess Stats.  Includes entity and postlink stats

ds_Seleid_persistence_stats := wk_ut.get_DS_Result(wuid_powid_postprocess   ,'Result 6'  ,BIPV2_QA_Tool.Layouts.strata_persistence_stats); //BIPV2_POWID 20181101a PostProcess
ds_proxid_persistence_stats := wk_ut.get_DS_Result(wuid_hrchy               ,'Result 10' ,BIPV2_QA_Tool.Layouts.strata_persistence_stats); //BIPV2_Build.build_hrchy  20181101

BIPV2_QA_Tool.mac_persistence_records_stats (ds_Seleid_persistence_stats ,'Seleid' ,version);
BIPV2_QA_Tool.mac_persistence_cluster_stats (ds_Seleid_persistence_stats ,'Seleid' ,version);

BIPV2_QA_Tool.mac_persistence_records_stats (ds_proxid_persistence_stats ,'Proxid' ,version);
BIPV2_QA_Tool.mac_persistence_cluster_stats (ds_proxid_persistence_stats ,'Proxid' ,version);

/*
// -- Iteration Stats
Build_Date  := bipv2.KeySuffix;
iter        := '400';

output(BIPV2_QA_Tool.mac_Iteration_Stats('W20181118-025102'  ,lgid3   ,Build_Date  ,iter   ,BIPV2_LGID3.Config.MatchThreshold      ,'BIPV2_LGID3'      ,false) ,named('BIPV2_LGID3_iteration_stats'     ));
output(BIPV2_QA_Tool.mac_Iteration_Stats('W20181106-204106'  ,proxid  ,Build_Date  ,iter   ,BIPV2_Proxid_mj6.Config.MatchThreshold ,'BIPV2_Proxid_mj6' ,false) ,named('BIPV2_Proxid_mj6_iteration_stats'));
*/