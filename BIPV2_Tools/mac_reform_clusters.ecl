export mac_reform_clusters(
   pDataset
  ,pCluster_ID          //'dotid'
  ,pGrouping_Field      //'cnp_name'
  ,pMax_Iterations      = '10'
  ,pParent_ID           = ''              //proxid
  ,pLowest_Cluster_ID   = ''
  
) :=
functionmacro

  #uniquename(CLUSTER_ID_OLD)
  #SET(CLUSTER_ID_OLD       ,#TEXT(pCluster_ID)   + '_old')

  #uniquename(LOWEST_CLUSTER_ID)
  #IF(trim(#TEXT(pLowest_Cluster_ID)) != '')
    #SET(LOWEST_CLUSTER_ID       ,trim(#TEXT(pLowest_Cluster_ID)))
  #ELSE
    #SET(LOWEST_CLUSTER_ID       ,'lowest_' + trim(#TEXT(pCluster_ID)))
  #END
  
  ds_local      := project(pDataset ,transform({unsigned6 %CLUSTER_ID_OLD%,unsigned6 %LOWEST_CLUSTER_ID%,recordof(left)},self.%CLUSTER_ID_OLD% := left.pCluster_ID,self.%LOWEST_CLUSTER_ID% := left.pCluster_ID,self := left));
 
  #if(trim(#TEXT(pParent_ID)) = '')
  ds_prep_slim  := table(ds_local ,{             %CLUSTER_ID_OLD% ,pCluster_ID ,%LOWEST_CLUSTER_ID% ,pGrouping_Field,boolean isdone := false} 
                                   ,             %CLUSTER_ID_OLD% ,pCluster_ID ,%LOWEST_CLUSTER_ID% ,pGrouping_Field ,merge);
  #ELSE
  ds_prep_slim  := table(ds_local ,{pParent_ID  ,%CLUSTER_ID_OLD% ,pCluster_ID ,%LOWEST_CLUSTER_ID% ,pGrouping_Field,boolean isdone := false} 
                                   ,pParent_ID  ,%CLUSTER_ID_OLD% ,pCluster_ID ,%LOWEST_CLUSTER_ID% ,pGrouping_Field ,merge);
  #END
  
  ds_prep_nonblank_grouping := ds_prep_slim(pGrouping_Field != '');
  ds_prep_blank_grouping    := ds_prep_slim(pGrouping_Field  = '');
  
  ds_prep_blank_grouping_only := join(ds_prep_nonblank_grouping ,ds_prep_blank_grouping ,left.pCluster_ID = right.pCluster_ID   ,transform(right) ,right only  ,hash);
  
  ds_prep_all_grouping := ds_prep_nonblank_grouping + ds_prep_blank_grouping_only;
  
  ds_convergence_loop := loop(ds_prep_all_grouping  
    ,exists(rows(left)(isdone = false)) and counter <= pMax_Iterations
    ,BIPV2_Tools.mac_reform_clusters_loop(rows(left)  ,pCluster_ID  ,%LOWEST_CLUSTER_ID% ,pGrouping_Field  ,counter  ,%CLUSTER_ID_OLD%,pParent_ID)
    );
  
  ds_concat := ds_convergence_loop;  //blank grouping IDs will not need to be patched since they do not contain any good linking info
  // ds_concat := ds_convergence_loop + ds_prep_blank_grouping;  //blank grouping IDs will not need to be patched since they do not contain any good linking info

  ds_initial_clustering_info := dataset([
  #if(trim(#TEXT(pParent_ID)) != '')
    {#TEXT(pParent_ID )  ,0  ,count(ds_prep_all_grouping),count(table(ds_prep_slim,{pParent_ID },pParent_ID ,merge))  ,0  ,'100.00',wk_ut.getTimeDate()},
  #END
    {#TEXT(pCluster_ID)  ,0  ,count(ds_prep_all_grouping),count(table(ds_prep_slim,{pCluster_ID},pCluster_ID,merge))  ,0  ,'100.00',wk_ut.getTimeDate()}
    
    ],{string ID,unsigned iteration,unsigned record_count,unsigned cluster_count ,integer diff,string pct_diff,string time});

  ds_loop_info := dataset([
     {'mac_reform_loop.pDataset'                    ,count(pDataset                   (pCluster_ID = 0))}
    ,{'mac_reform_loop.ds_local'                    ,count(ds_local                   (pCluster_ID = 0))}
    ,{'mac_reform_loop.ds_prep_slim'                ,count(ds_prep_slim               (pCluster_ID = 0))}
    ,{'mac_reform_loop.ds_prep_nonblank_grouping'   ,count(ds_prep_nonblank_grouping  (pCluster_ID = 0))}
    ,{'mac_reform_loop.ds_prep_blank_grouping   '   ,count(ds_prep_blank_grouping     (pCluster_ID = 0))}
    ,{'mac_reform_loop.ds_prep_blank_grouping_only' ,count(ds_prep_blank_grouping_only(pCluster_ID = 0))}
    ,{'mac_reform_loop.ds_prep_all_grouping'        ,count(ds_prep_all_grouping       (pCluster_ID = 0))}
    ,{'mac_reform_loop.ds_convergence_loop'         ,count(ds_convergence_loop        (pCluster_ID = 0))}
    ,{'mac_reform_loop.ds_concat'                   ,count(ds_concat                  (pCluster_ID = 0))}
  ],{string step  ,unsigned cnt_zero_clusterids});


  return when(ds_convergence_loop,parallel(
      output(ds_initial_clustering_info         ,named('Clustering_Info'      ),extend)
     // ,output(ds_loop_info                       ,named('ds_loop_info'         ),extend)
  ));
  
endmacro;
