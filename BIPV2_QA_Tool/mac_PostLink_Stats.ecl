/* BH-579 QA monitoring tool - Postlink and Entity stats 

entity stats:

  new ids by source   : clusters that contain source and did not exist in father file
  matches by source   : new records with did < rid, or existing records that have new did < father did
  singletons by source: BIPV2_Strata.mac_Single_Multi_Sourced_IDS
  total ids by source : BIPV2_Strata.mac_Single_Multi_Sourced_IDS

 Post Link Stats  	
  ID      Stat  	                                                  cnt 
  Proxid  %Current Clusters, New	
  Proxid  %Current Clusters, New, All New Records 	
  Proxid  %Current Clusters, Still Exist 	
  Proxid  %Current Clusters, Still Exist, Same Records 	
  Proxid  %Previous Clusters, Disappeared 	
  Proxid  %Previous Clusters Disappeared, Cluster Collapse 	
	
  Proxid  %Current Records, New 	
  Proxid  %Previous Records, Disappeared 	
  Proxid  %Previous Records, Same ID 	
  Proxid  %Previous Records, Different ID 	
  Proxid  %Previous Records, Different ID from Cluster Collapse 	
    	
  Proxid  Cluster Count, Singleton	
  Proxid  Cluster Count, 2 to 10 Records	
  Proxid  Cluster Count, 11 to 100 Records	
  Proxid  Cluster Count, 101 to 1000 Records	
  Proxid  Cluster Count, 1001 or More Records	
    	
  Proxid   Cluster Count by segmentaion (varies by header)  	
										 {'Segmentation Count, Core',cnt_Core},
										 {'Segmentation Count, Dead',cnt_Dead},
										 {'Segmentation Count, No SSN',cnt_nossn},
										 {'Segmentation Count, Inactive',cnt_inactive},
										 {'Segmentation Count, C_Merge',cnt_cmerge},
										 {'Segmentation Count, H_Merge',cnt_hmerge},
										 {'Segmentation Count, Noise',cnt_noise}],statRec);
    
*/


EXPORT mac_PostLink_Stats(

   pStrata_Persistence_Stats  // result of BIPV2_Strata.PersistenceStats
  ,pID                        = 'seleid'
  ,pversion                   = 'bipv2.KeySuffix'
  ,pDs_Base                   = 'bipv2.CommonBase.ds_built'
  ,pSegStatsWuid              = ''                          // -- if non-blank, will use this.  Otherwise it will try to find the wuid
  ,pReturnDatasetOnly         = 'false'

) :=
functionmacro

  lID := trim(#TEXT(pID));

  import std,wk_ut,workman;

  thecurrentdate  := (STRING8)Std.Date.Today();         
  highwuid        := 'W' + thecurrentdate + '-999999';
  wuid_segstats   := if(trim(pSegStatsWuid) = ''  
                      ,trim(sort(nothor(wk_ut.get_Running_Workunits('W' + trim(STD.Str.Filter(pversion,'0123456789')) + '-000001',highwuid,'completed')(job = 'BIPV2_PostProcess.proc_segmentation ' + pversion)),-wuid)[1].wuid)//'W20150217-055342'
                      ,pSegStatsWuid
                     );

	ProxSegmentationStatsV2_rec :={string20 segType, string20 segSubType, unsigned4 total};
  wuid_result := map(
     regexfind('proxid',lID,nocase)  => 'ProxSegmentationStatsV2'
    ,regexfind('seleid',lID,nocase)  => 'SeleSegmentationStatsV2'
    ,''
  );
	SegmentationStatsV2                         :=Dataset(WorkUnit(wuid_segstats,wuid_result),ProxSegmentationStatsV2_rec);
  count_gold                                  := Workman.get_Scalar_Result(wuid_segstats ,'count_Gold_SELEID V2');
  count_Total_Active                          := SegmentationStatsV2(trim(segtype,left,right) = 'TOTAL'        ,trim(segsubtype,left,right) = 'Active'              )[1].total;
  count_Core_Tricore                          := SegmentationStatsV2(trim(segtype) = 'CORE'         ,trim(segsubtype) = 'TriCore'             )[1].total;
  count_Core_DualCore                         := SegmentationStatsV2(trim(segtype) = 'CORE'         ,trim(segsubtype) = 'DualCore'            )[1].total;
  count_Core_Singlesource                     := SegmentationStatsV2(trim(segtype) = 'CORE'         ,trim(segsubtype) = 'SingleSource'        )[1].total;
  count_Core_TrustedSource                    := SegmentationStatsV2(trim(segtype) = 'CORE'         ,trim(segsubtype) = 'TrustedSource'       )[1].total;
  count_Emerging_Core_TrustedSourceSingleton  := SegmentationStatsV2(trim(segtype) = 'EMERGINGCORE' ,trim(segsubtype) = 'TrustedSrcSingleton' )[1].total;
  count_Inactive_NoActivity                   := SegmentationStatsV2(trim(segtype) = 'INACTIVE'     ,trim(segsubtype) = 'NoActivity'          )[1].total;
  count_Inactive_Reported_Inactive            := SegmentationStatsV2(trim(segtype) = 'INACTIVE'     ,trim(segsubtype) = 'ReportedInactive'    )[1].total;

  
  ds_persistence_stats := pStrata_Persistence_Stats;
  
  ds_cluster_counts := table(pDs_Base ,{pID,unsigned cnt := count(group)} ,pID  ,merge);
  count_singletons            := count(ds_cluster_counts(cnt = 1));
  count_between_2_and_10      := count(ds_cluster_counts(cnt between 2   and 10   ));
  count_between_11_and_100    := count(ds_cluster_counts(cnt between 11  and 100  ));
  count_between_101_and_1000  := count(ds_cluster_counts(cnt between 101 and 1000 ));
  count_GT_1000               := count(ds_cluster_counts(cnt >= 1001));

  ds_postlink_stats_qa_tool := dataset([
     {lID ,trim(pversion) ,'%Current Clusters, New'	                                  ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Current Clusters'                ,trim(stat_desc) = 'New Clusters(%)'        )[1].stat_value / 100.0 }
    ,{lID ,trim(pversion) ,'%Current Clusters, New, All New Records' 	                ,(real8)ds_persistence_stats(trim(cluster_type) = '1 New Clusters'                    ,trim(stat_desc) = 'All New Records(%)'     )[1].stat_value / 100.0 }
    ,{lID ,trim(pversion) ,'%Current Clusters, Still Exist' 	                        ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Current Clusters'                ,trim(stat_desc) = 'Same Clusters(%)'       )[1].stat_value / 100.0 }
    ,{lID ,trim(pversion) ,'%Current Clusters, Still Exist, Same Records' 	          ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Same Clusters'                   ,trim(stat_desc) = 'Persistent Clusters(%)' )[1].stat_value / 100.0 }
    ,{lID ,trim(pversion) ,'%Previous Clusters, Disappeared' 	                        ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Previous Clusters'               ,trim(stat_desc) = 'Missing Clusters(%)'    )[1].stat_value / 100.0 }
    ,{lID ,trim(pversion) ,'%Previous Clusters Disappeared, Cluster Collapse'         ,(real8)ds_persistence_stats(trim(cluster_type) = '1 Missing Clusters'                ,trim(stat_desc) = 'Collapsed(%)'           )[1].stat_value / 100.0 }
    ,{lID ,trim(pversion) ,'%Current Records, New 	 '                                ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Current Records'                 ,trim(stat_desc) = 'New Records(%)'         )[1].stat_value / 100.0 }
    ,{lID ,trim(pversion) ,'%Previous Records, Disappeared 	 '                        ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Previous Records'                ,trim(stat_desc) = 'Deleted Records(%)'     )[1].stat_value / 100.0 }
    ,{lID ,trim(pversion) ,'%Previous Records, Same ID 	 '                            ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Persistent Records'              ,trim(stat_desc) = 'Same Cluster(%)'        )[1].stat_value / 100.0 }
    ,{lID ,trim(pversion) ,'%Previous Records, Different ID 	 '                      ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Persistent Records'              ,trim(stat_desc) = 'Diff Cluster(%)'        )[1].stat_value / 100.0 }
    ,{lID ,trim(pversion) ,'%Previous Records, Different ID from Cluster Collapse '   ,(real8)ds_persistence_stats(trim(cluster_type) = '2 Persistent Records Diff Cluster' ,trim(stat_desc) = 'Collapsed Records(%)'   )[1].stat_value / 100.0 }

    ,{lID ,trim(pversion) ,'Cluster Count, Singleton	 '                              ,(real8)count_singletons           }
    ,{lID ,trim(pversion) ,'Cluster Count, 2 to 10 Records	 '                        ,(real8)count_between_2_and_10     }
    ,{lID ,trim(pversion) ,'Cluster Count, 11 to 100 Records	 '                      ,(real8)count_between_11_and_100   }
    ,{lID ,trim(pversion) ,'Cluster Count, 101 to 1000 Records	 '                    ,(real8)count_between_101_and_1000 }
    ,{lID ,trim(pversion) ,'Cluster Count, 1001 or More Records '                     ,(real8)count_GT_1000              }
    
    ,{lID ,trim(pversion) ,'Segmentation Count, Gold  '                               ,(real8) count_gold                                }
    ,{lID ,trim(pversion) ,'Segmentation Count, Total Active '                        ,(real8) count_Total_Active                        }
    ,{lID ,trim(pversion) ,'Segmentation Count, Core Tricore  '                       ,(real8) count_Core_Tricore                        }
    ,{lID ,trim(pversion) ,'Segmentation Count, Core DualCore '                       ,(real8) count_Core_DualCore                       }
    ,{lID ,trim(pversion) ,'Segmentation Count, Core Singlesource '                   ,(real8) count_Core_Singlesource                   }
    ,{lID ,trim(pversion) ,'Segmentation Count, Core TrustedSource '                  ,(real8) count_Core_TrustedSource                  }
    ,{lID ,trim(pversion) ,'Segmentation Count, Emerging Core TrustedSourceSingleton' ,(real8) count_Emerging_Core_TrustedSourceSingleton}
    ,{lID ,trim(pversion) ,'Segmentation Count, Inactive NoActivity '                 ,(real8) count_Inactive_NoActivity                 }
    ,{lID ,trim(pversion) ,'Segmentation Count, Inactive Reported Inactive '          ,(real8) count_Inactive_Reported_Inactive          }
  ],BIPV2_QA_Tool.Layouts.persistence_stats);

  import tools;
  // output_postlink_stats := output(ds_postlink_stats_qa_tool ,,BIPV2_QA_Tool.Filenames(trim(pversion),,lID).PostLink_Stats.logical ,overwrite);
  output_postlink_stats := tools.macf_WriteFile(BIPV2_QA_Tool.Filenames(trim(pversion),,lID).PostLink_Stats.logical ,ds_postlink_stats_qa_tool ,pOverwrite := true);


  #IF(pReturnDatasetOnly = false)
    result := sequential(
       // BIPV2_QA_Tool.Promote(trim(pversion),lID).new2qa
      // ,std.file.clearsuperfile(BIPV2_QA_Tool.Filenames(,,lID).PostLink_Stats.qa)
       output_postlink_stats
      ,BIPV2_QA_Tool.Promote(trim(pversion),lID).new2qaMult
    );
    
    return result;
  #ELSE
  
    // return SegmentationStatsV2;//count_Total_Active;
    return ds_postlink_stats_qa_tool;
  #END



endmacro;