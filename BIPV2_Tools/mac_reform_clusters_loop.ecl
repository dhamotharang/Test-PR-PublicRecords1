/*
  this will group by the pGrouping_Field(which can be a hash of any fields you want, such as cnp_name and address)
  and patch onto every unique group the lowest cluster ID for that group.
  then, it will patch the lowest cluster ID that occurs within the current cluster ID.
  there is an optional parent ID which, if used, it will only group within that parent cluster ID, not the whole dataset.  This is useful
  for when you reset overlinked clusters and want to reform it within that parent cluster, without trying to link to any outside clusters.
  Used within mac_reform_loop with the counter parameter to loop and get to convergence.
*/
EXPORT mac_reform_clusters_loop(

   pDs
  ,pCluster_ID          = 'dotid'
  ,pLowest_Cluster_ID   = 'lowest_dotid'
  ,pGrouping_Field      = 'cnp_name'
  ,pCounter             = ''
  ,pCluster_ID_old      = 'dotid_old'
  ,pParent_ID           = ''//'proxid'

) :=
functionmacro
  
  import wk_ut;
  
  ds_prep_nonblank_grouping1 := pDs(pGrouping_Field != '');
  ds_prep_blank_grouping1    := pDs(pGrouping_Field  = '');

    // -- if no parent id, then group by grouping fields throughout whole dataset.
    #if(trim(#TEXT(pParent_ID)) = '')
      ds_cand_table1       := group(sort(distribute(ds_prep_nonblank_grouping1 ,hash64(pGrouping_Field)),pGrouping_Field,pLowest_Cluster_ID,local),pGrouping_Field,local);
      ds_cand_iter1        := iterate(ds_cand_table1  ,transform(
          recordof(left)
         ,self.pLowest_Cluster_ID := if(left.pLowest_Cluster_ID = 0 ,right.pLowest_Cluster_ID ,left.pLowest_Cluster_ID)
         ,self                  := right
      ));

      ds_cand_table2       := group(sort(distribute(ds_cand_iter1 ,hash64(pCluster_ID)),pCluster_ID,pLowest_Cluster_ID,local),pCluster_ID,local);
      ds_cand_iter2        := iterate(ds_cand_table2  ,transform(
          recordof(left)
         ,self.pLowest_Cluster_ID := if(left.pLowest_Cluster_ID = 0 ,right.pLowest_Cluster_ID ,left.pLowest_Cluster_ID)
         ,self                  := right
      ));
    // -- if parent id, then group by grouping fields within the parent id.
    #ELSE
      ds_cand_table1       := group(sort(distribute(ds_prep_nonblank_grouping1 ,hash64(pParent_ID, pGrouping_Field)),pParent_ID, pGrouping_Field,pLowest_Cluster_ID,local),pParent_ID, pGrouping_Field,local);
      ds_cand_iter1        := iterate(ds_cand_table1  ,transform(
          recordof(left)
         ,self.pLowest_Cluster_ID := if(left.pLowest_Cluster_ID = 0 ,right.pLowest_Cluster_ID ,left.pLowest_Cluster_ID)
         ,self                  := right
      ));

      ds_cand_table2       := group(sort(distribute(ds_cand_iter1 ,hash64(pParent_ID, pCluster_ID)),pParent_ID, pCluster_ID,pLowest_Cluster_ID,local),pParent_ID, pCluster_ID,local);
      ds_cand_iter2        := iterate(ds_cand_table2  ,transform(
          recordof(left)
         ,self.pLowest_Cluster_ID := if(left.pLowest_Cluster_ID = 0 ,right.pLowest_Cluster_ID ,left.pLowest_Cluster_ID)
         ,self                  := right
      ));
    #END
    
    
    ds_final_form       := table(ds_cand_iter2 ,{pCluster_ID_old,pCluster_ID,unsigned6 pLowest_Cluster_ID := min(group,pLowest_Cluster_ID)}, pCluster_ID_old,pCluster_ID,merge);    
    
    ds_reset_candidates  := join(ds_prep_nonblank_grouping1 ,ds_final_form 
      ,   left.pCluster_ID_old    = right.pCluster_ID_old
      and left.pCluster_ID        = right.pCluster_ID  
      ,transform(recordof(left)
        ,self.pCluster_ID        := right.pLowest_Cluster_ID 
        ,self.pLowest_Cluster_ID := right.pLowest_Cluster_ID
        ,self                    := left
      )
    ,hash)
    + ds_prep_blank_grouping1;
  
    lay_clustering      := {string ID,unsigned iteration,unsigned record_count,unsigned cluster_count ,integer diff,string pct_diff,string time};
    ds_clustering_info  := wk_ut.get_DS_Result(workunit,'Clustering_Info'  ,lay_clustering);
    start_id_count      := ds_clustering_info(iteration = 0,trim(ID) = trim(#TEXT(pCluster_ID)))[1].cluster_count;  //iteration zero is the beginning cluster count
    ds_before_ids       := count(table(pDs                  ,{pCluster_ID  } ,pCluster_ID  ,merge));
    ds_after_ids        := count(table(ds_reset_candidates  ,{pCluster_ID  } ,pCluster_ID  ,merge));
    ds_record_count     := count(ds_reset_candidates  );
    count_diff          := ds_before_ids - ds_after_ids;
    lpct_diff           := realformat(ds_after_ids / start_id_count * 100.0,10,4);
    
  ds_loop_info := dataset([
     {'mac_reform.pDs                       '  ,count(pDs                         (pCluster_ID = 0))}
    ,{'mac_reform.ds_prep_nonblank_grouping1'  ,count(ds_prep_nonblank_grouping1  (pCluster_ID = 0))}
    ,{'mac_reform.ds_prep_blank_grouping1   '  ,count(ds_prep_blank_grouping1     (pCluster_ID = 0))}
    ,{'mac_reform.ds_cand_table1            '  ,count(ds_cand_table1              (pCluster_ID = 0))}
    ,{'mac_reform.ds_cand_iter1             '  ,count(ds_cand_iter1               (pCluster_ID = 0))}
    ,{'mac_reform.ds_cand_table2            '  ,count(ds_cand_table2              (pCluster_ID = 0))}
    ,{'mac_reform.ds_cand_iter2             '  ,count(ds_cand_iter2               (pCluster_ID = 0))}
    ,{'mac_reform.ds_final_form             '  ,count(ds_final_form               (pCluster_ID = 0))}
    ,{'mac_reform.ds_reset_candidates       '  ,count(ds_reset_candidates         (pCluster_ID = 0))}
  ],{string step  ,unsigned cnt_zero_clusterids});
    
  return when(project(ds_reset_candidates,transform(recordof(left),self.isdone := if(ds_before_ids = ds_after_ids, true,false),self := left)),
          parallel(
            output(dataset([{#TEXT(pCluster_ID),pCounter,ds_record_count,ds_after_ids ,count_diff ,lpct_diff,wk_ut.getTimeDate()}],{string ID,unsigned iteration,unsigned record_count,unsigned cluster_count ,integer diff,string pct_diff,string time})  ,named('Clustering_Info'),extend)
           // ,output(ds_loop_info                       ,named('ds_loop_info'         ),extend)
         ));
  
endmacro;
