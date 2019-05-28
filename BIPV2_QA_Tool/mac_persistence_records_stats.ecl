/* -----------------------------------------
ds_Seleid_persistence_stats := wk_ut.get_DS_Result('W20181118-152625'  ,'Result 6'  ,BIPV2_QA_Tool.Layouts.strata_persistence_stats); //BIPV2_POWID 20181101a PostProcess

BIPV2_QA_Tool.mac_persistence_records_stats(ds_Seleid_persistence_stats ,'Seleid' ,'20181002');
BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_Seleid_persistence_stats ,'Seleid' ,'20181002');

ds_proxid_persistence_stats := wk_ut.get_DS_Result('W20181109-065601'  ,'Result 10'  ,BIPV2_QA_Tool.Layouts.strata_persistence_stats);  //BIPV2_Build.build_hrchy  20181101

BIPV2_QA_Tool.mac_persistence_records_stats(ds_proxid_persistence_stats ,'Proxid' ,'20181002');
BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_proxid_persistence_stats ,'Proxid' ,'20181002');
*/

EXPORT mac_persistence_records_stats(

   pStrata_Persistence_Stats  // result of BIPV2_Strata.PersistenceStats
  ,pID
  ,pversion
  ,pOutputFile                = 'true'

) :=
functionmacro

  import tools,BIPV2_QA_Tool;
  
  ds_persistence_stats := pStrata_Persistence_Stats;

  ds_persistence_record_stats_qa_tool := dataset([
     {trim(pID) ,trim(pversion) ,'Current Records'        ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Current Records'                 ,trim(stat_desc) = 'total'              )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Previous Records'       ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Previous Records'                ,trim(stat_desc) = 'total'              )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'New Records'            ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Current Records'                 ,trim(stat_desc) = 'New Records'        )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Deleted Records'        ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Previous Records'                ,trim(stat_desc) = 'Deleted Records'    )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Persistent Records'     ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Persistent Records'              ,trim(stat_desc) = 'total'              )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Same Cluster'           ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Persistent Records'              ,trim(stat_desc) = 'Same Cluster'       )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Diff Cluster'           ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Persistent Records'              ,trim(stat_desc) = 'Diff Cluster'       )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Collapsed Records'      ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Persistent Records Diff Cluster' ,trim(stat_desc) = 'Collapsed Records'  )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Split Records'          ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Persistent Records Diff Cluster' ,trim(stat_desc) = 'Split Records'      )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Shuffled Records'       ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Persistent Records Diff Cluster' ,trim(stat_desc) = 'Shuffled Records'   )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Shifted Records'        ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Persistent Records Diff Cluster' ,trim(stat_desc) = 'Shifted Records'    )[1].stat_value }
    ,{trim(pID) ,trim(pversion) ,'Persistent Record Pct'  ,(real8)ds_persistence_stats(trim(cluster_type) = 'pct_persistent_records'            ,trim(stat_desc) = '(Persistent Records Same Cluster)/(Previous Records Total)')[1].stat_value / 100 }
  ],BIPV2_QA_Tool.Layouts.persistence_stats);

  #IF(pOutputFile = true)

    thefilename                     := BIPV2_QA_Tool.Filenames(trim(pversion),,trim(pID)).Persistence_Record_Stats.logical;
    output_persistence_record_stats := tools.macf_WriteFile(thefilename  ,ds_persistence_record_stats_qa_tool ,pOverwrite := true);

    result := sequential(
       output_persistence_record_stats
      ,BIPV2_QA_Tool.Promote(trim(pversion),trim(pID)).new2qaMult
    );

    return result;
  #ELSE
    return ds_persistence_record_stats_qa_tool;
  #END
endmacro;