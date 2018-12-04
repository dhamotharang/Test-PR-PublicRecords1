/* -----------------------------------------
ds_Seleid_persistence_stats := wk_ut.get_DS_Result('W20181118-152625'  ,'Result 6'  ,BIPV2_QA_Tool.Layouts.strata_persistence_stats); //BIPV2_POWID 20181101a PostProcess

BIPV2_QA_Tool.mac_persistence_records_stats(ds_Seleid_persistence_stats ,'Seleid' ,'20181002');
BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_Seleid_persistence_stats ,'Seleid' ,'20181002');

ds_proxid_persistence_stats := wk_ut.get_DS_Result('W20181109-065601'  ,'Result 10'  ,BIPV2_QA_Tool.Layouts.strata_persistence_stats);  //BIPV2_Build.build_hrchy  20181101

BIPV2_QA_Tool.mac_persistence_records_stats(ds_proxid_persistence_stats ,'Proxid' ,'20181002');
BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_proxid_persistence_stats ,'Proxid' ,'20181002');
*/

EXPORT mac_persistence_cluster_stats(

   pStrata_Persistence_Stats  // result of BIPV2_Strata.PersistenceStats
  ,pID
  ,pversion

) :=
functionmacro

  import tools;
  
  ds_persistence_stats := pStrata_Persistence_Stats;

  // -- persistence stats cluster
  ds_persistence_cluster_stats_qa_tool := dataset([
     {trim(pID) ,trim(pversion) ,'Current Clusters'        ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Current Clusters'                ,trim(stat_desc) = 'total'              )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Previous Clusters'       ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Previous Clusters'               ,trim(stat_desc) = 'total'              )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'New Clusters'            ,(real8)ds_persistence_stats(trim(cluster_type) = '1 New Clusters'                    ,trim(stat_desc) = 'total'              )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Missing Clusters'        ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Previous Clusters'               ,trim(stat_desc) = 'Missing Clusters'   )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Same Clusters'           ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Previous Clusters'               ,trim(stat_desc) = 'Same Clusters'      )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'All New Records'         ,(real8)ds_persistence_stats(trim(cluster_type) = '1 New Clusters'                    ,trim(stat_desc) = 'All New Records'    )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'New Base Record'         ,(real8)ds_persistence_stats(trim(cluster_type) = '1 New Clusters'                    ,trim(stat_desc) = 'New Base Record'    )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'From Split'              ,(real8)ds_persistence_stats(trim(cluster_type) = '1 New Clusters'                    ,trim(stat_desc) = 'From Split'         )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'From Shuffle'            ,(real8)ds_persistence_stats(trim(cluster_type) = '1 New Clusters'                    ,trim(stat_desc) = 'From Shuffle'       )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Deleted Base Record'     ,(real8)ds_persistence_stats(trim(cluster_type) = '1 New Clusters'                    ,trim(stat_desc) = 'Deleted Base Record')[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'All Records Deleted'     ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Missing Clusters'                ,trim(stat_desc) = 'All Records Deleted')[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Collapsed'               ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Missing Clusters'                ,trim(stat_desc) = 'Collapsed'          )[1].stat_value }
    // ,{trim(pID) ,trim(pversion) ,'Deleted Base Record'     ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Missing Clusters'                ,trim(stat_desc) = 'Deleted Base Record')[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Shuffled'                ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Missing Clusters'                ,trim(stat_desc) = 'Shuffled'           )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Recs Removed'            ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Same Clusters'                   ,trim(stat_desc) = 'Recs Removed'       )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Recs Added'              ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Same Clusters'                   ,trim(stat_desc) = 'Recs Added'         )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Recs Mixed'              ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Same Clusters'                   ,trim(stat_desc) = 'Recs Mixed'         )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Persistent Cluster Pct'  ,(real8)ds_persistence_stats(trim(cluster_type) = 'pct_persistent_clusters'           ,trim(stat_desc) = '(Same Cluster)/(Previous Cluster Total)')[1].stat_value }
  ],BIPV2_QA_Tool.Layouts.persistence_stats);

  thefilename                       := BIPV2_QA_Tool.Filenames(trim(pversion),,trim(pID)).Persistence_Cluster_Stats.logical;
  output_persistence_cluster_stats  := tools.macf_WriteFile(thefilename  ,ds_persistence_cluster_stats_qa_tool ,pOverwrite := true);

  result := sequential(
     // std.file.clearsuperfile(BIPV2_QA_Tool.Filenames(,,pID).Persistence_Cluster_Stats.qa)
     output_persistence_cluster_stats
    ,BIPV2_QA_Tool.Promote(trim(pversion),trim(pID)).new2qaMult
  );
  
  return result;

endmacro;