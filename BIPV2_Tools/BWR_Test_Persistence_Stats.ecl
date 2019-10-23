// -- BH-449 -- 
// -- then run active and gold calculations on results
// -- also run persistent stats
// -- also create full commonbase file
/*
  MODIFY THESE ATTRIBUTES IN YOUR SANDBOX FOR THE BUILDING OF THE XLINK KEYS(IT WILL USE YOUR NEW PATCHED BASE TO CREATE THEM):
    BIPV2.commonbase          -- point ds_xlink to the patched base file
    BizLinkFull.File_BizHead  -- remove first line, // #OPTION('multiplePersistInstances',FALSE);
*/

pversion              := '20180416_BH333_test';
//num_proxid_iters      := 5;
//num_lgid3_iters       := 10;
patched_full_filename := '~thor_data400::bipv2::internal_linking::20180416_BH333_patched_test';
ds_base               := BIPV2.CommonBase.DS_BASE;

#STORED('BIPV2_COMMONBASE_FILE_BUILT' ,'~thor_data400::bipv2::internal_linking::20180416_BH333_patched_test'      );  //for xlink

// sequential(
   // BIPV2_ProxID._proc_Multiple_Iterations                (1,num_proxid_iters,pversion,'BIPV2_Files.files_dotid().DS_BASE','thor50_dev_eclcc',BIPV2_Files.files_dotid().FILE_BASE)
  // ,BIPV2_Build.proc_hrchy                                (pversion,'thor50_dev_eclcc')
  // ,BIPV2_Build.proc_lgid3                ().MultIter_run (1,num_lgid3_iters  ,true  ,true   ,true  ,true ,pversion,'thor50_dev_eclcc')
// );

// pversion          := '20180322_BH449_test_0';
// BIPV2_ProxID.promote(pversion).new2built;

ds_lgid3 := BIPV2_Files.files_lgid3.DS_BASE;

ds_base_patched     := ds_lgid3;
ds_base_before      := join(ds_base  ,ds_lgid3 ,left.rcid = right.rcid,transform(left),hash);
ds_base_not_patched := join(ds_base  ,ds_lgid3 ,left.rcid = right.rcid,transform(left),left only,hash);
ds_base_concat := ds_base_patched + ds_base_not_patched;

ds_proxid_persistence := BIPV2_Strata.PersistenceStats(ds_base_concat, ds_base,rcid,proxid,false);
ds_seleid_persistence := BIPV2_Strata.PersistenceStats(ds_base_concat, ds_base,rcid,seleid,false);
lay_stats := {string ID,string stat, string subtype  ,unsigned cnt};

ds_important_persistent_stats := dataset([
       {'Proxid' ,'Percent Persistent'  ,'Clusters' ,(unsigned)ds_proxid_persistence(cluster_type = 'pct_persistent_clusters',stat_desc = '(Same Cluster)/(Previous Cluster Total)'                   )[1].stat_value}
      ,{'Proxid' ,'Percent Persistent'  ,'Records'  ,(unsigned)ds_proxid_persistence(cluster_type = 'pct_persistent_records' ,stat_desc = '(Persistent Records Same Cluster)/(Previous Records Total)')[1].stat_value}
      ,{'Seleid' ,'Percent Persistent'  ,'Clusters' ,(unsigned)ds_seleid_persistence(cluster_type = 'pct_persistent_clusters',stat_desc = '(Same Cluster)/(Previous Cluster Total)'                   )[1].stat_value}
      ,{'Seleid' ,'Percent Persistent'  ,'Records'  ,(unsigned)ds_seleid_persistence(cluster_type = 'pct_persistent_records' ,stat_desc = '(Persistent Records Same Cluster)/(Previous Records Total)')[1].stat_value}
],lay_stats);

ds_blank_stats := dataset([
   {'Proxid' ,'Before' ,'Clusters' ,count(table(ds_base_before                                    ,{proxid},proxid,merge))}
  ,{'Proxid' ,'After'  ,'Clusters' ,count(table(ds_lgid3                                          ,{proxid},proxid,merge))}
  ,{'Seleid' ,'Before' ,'Clusters' ,count(table(ds_base_before                                    ,{seleid},seleid,merge))}
  ,{'Seleid' ,'After'  ,'Clusters' ,count(table(ds_lgid3                                          ,{seleid},seleid,merge))}
  ,{'Proxid' ,'Before' ,'Actives'  ,count(table(ds_base_before(trim(proxid_status_public) = '' )  ,{proxid},proxid,merge))}
  ,{'Seleid' ,'Before' ,'Actives'  ,count(table(ds_base_before(trim(seleid_status_public) = '' )  ,{seleid},seleid,merge))}
  ,{'Seleid' ,'Before' ,'Golds'    ,count(table(ds_base_before(trim(sele_gold           ) = 'G')  ,{seleid},seleid,merge))}
],lay_stats);

ds_stats := dataset([
   {'Record Count','ds_base_patched    '  ,'Records' ,count(ds_lgid3             )}
  ,{'Record Count','ds_base_not_patched'  ,'Records' ,count(ds_base_not_patched  )}
  ,{'Record Count','ds_base_before     '  ,'Records' ,count(ds_base              )}
  ,{'Record Count','ds_base_concat     '  ,'Records' ,count(ds_base_concat       )}

],lay_stats);

// -- persistent stats
sequential(
   output(ds_base_concat ,,patched_full_filename,compressed,overwrite)
  ,output(''                              ,named('Todays_Date_For_Calculating_Actives'),overwrite)
  ,output(ds_stats                        ,named('ds_important_stats'                 ),extend,all)
  ,output(ds_blank_stats                  ,named('ds_important_stats'                 ),extend,all)
  ,output(ds_important_persistent_stats   ,named('ds_important_stats'                 ),extend,all)
  ,output(ds_proxid_persistence           ,named('Proxid_Persistence_Stats'           ))
  ,output(ds_seleid_persistence           ,named('Seleid_Persistence_Stats'           ))
  // ,BIPV2_Build.Build_CommonBase(pversion,ds_lgid3).ds_header_test;
  ,BIPV2_PostProcess.proc_segmentation(pversion ,ds_lgid3  ,pPopulateStatus := true ,pGoldOutputModifier := 'test_buildcommonbase').prox_sele_test_stats
  ,BizLinkFull.Proc_Build_All(pversion,false,false)
);

/*
  BH-449 -- look at exploding rest of D&B fein clusters
  building xlink keys on patched commonbase file.
  then i will run some appends on datasets to see how different they are.

  Modified:
    BIPV2.commonbase          -- point ds_xlink to the patched base file
    BizLinkFull.File_BizHead  -- remove first line, // #OPTION('multiplePersistInstances',FALSE);

*/
//BIPV2_Build.proc_xlink                (pversion ,false      );