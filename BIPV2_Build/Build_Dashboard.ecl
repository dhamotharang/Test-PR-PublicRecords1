// Bug: 149854 - LINKING: Dashboard
/*
Manish may be interested if we manage to automatically pull information from
either WUs or Roxie for the dashboard.

maybe not all on day 1, but some stats that would be interesting here...

- segmentation stats  W20140623-031246
- external hit rates from test file
- internal precision number (proxid)  -- have to calculate
- short cycle P&R numbers (not sure)  -- W20140624-125100  -- BIPV2_Testing.proc_Xlink_Sample('20140529');
- search hit rate (from our own test file, but should be predictive of QAs  -- from **David**. 
number...could get a sample of their file)

and Vern, this cell is a good one for the dashboard (maybe just 2 decimal points)
pct sameseleids: 99.62396440328884
output( BIPV2_PostProcess.fieldStats_IDcounts().change)

W20140623-031246 - seg stats from last build
  use prox segmentation stats v2
  and the rest of the ids.
BIPV2_PostProcess.proc_segmentation('20140529').run;
*/
/*
BIPV2_Build.proc_Dashboard('20140529');
*/
/*
  Next steps here:
  1)    For short cycle, lets just show the ALL NOW and ALL FUTURE, and just call
  them Precision Now, Precision Future, Recall Now, Recall Future.  --DONE!!!!
  2)    For all of the charts, we need to show the previous sprints results (or
  maybe the last two sprints), so that you can tell what is normal when you are
  looking at it.
*/

import BIPV2_PostProcess,bipv2,wk_ut,tools,ut,std;

thecurrentdate  := (STRING8)Std.Date.Today();         
highwuid        := 'W' + thecurrentdate + '-999999';

EXPORT Build_Dashboard(
   string pversion  = bipv2.KeySuffix
  ,string pversion2 = pversion
  ,string pSegWuid  = trim(sort(wk_ut.get_Running_Workunits('W' + pversion2 + '-000001',highwuid,'completed')(job = 'BIPV2_PostProcess.proc_segmentation ' + pversion2),-wuid)[1].wuid)   //'W20140817-221115'  //Segmentation status wuid  BIPV2_PostProcess.proc_segmentation 20140725
  ,string pPRWuid   = trim(sort(wk_ut.get_Running_Workunits('W' + pversion2 + '-000001',highwuid,'completed')(job = 'BIPV2 Xlink Sample '                  + pversion2),-wuid)[1].wuid)   //'W20140819-135919'  //Xlink Sample Wuid         BIPV2 Xlink Sample 20140725
  ,string pEAWuid   = trim(sort(wk_ut.get_Running_Workunits('W' + pversion2 + '-000001',highwuid,'completed')(job = 'BIPV2_Build.External_Append_Testing ' + pversion2),-wuid)[1].wuid)   //'W20140821-002729'  //External Append Wuid      BIPV2_Build.External_Append_Testing 20140725
 ) :=
 function

	outr := record
		string ID;

		real average_count;
		unsigned6 median_count;
		unsigned6 max_count;
		unsigned6 total_count;
		unsigned6 total_IDs;
		unsigned6 sum_buckets;
		unsigned6 count_1;
		unsigned6 count_2_to_4;
		unsigned6 count_5_to_19;
		unsigned6 count_20_to_49;
		unsigned6 count_50_to_99;
		unsigned6 count_100_to_249;
		unsigned6 count_250_to_999;
		unsigned6 count_1000_to_9999;
		unsigned6 count_10000_to_99999;
		unsigned6 count_100000_to_999999;
		unsigned6 count_1000000_plus;
		
	end;

  External_append_lay := 
  record
     string               version;
     string5              src                                                                         ;
     integer8             count_0                                                                     ;
     real8                perc_0                                                                      ;
     integer8             count_25                                                                    ;
     real8                perc_25                                                                     ;
     integer8             count_50                                                                    ;
     real8                perc_50                                                                     ;
     integer8             count_75                                                                    ;
     real8                perc_75                                                                     ;
  end;

  getproxsegs    := wk_ut.get_DS_Result(pSegWuid,'ProxSegmentationStatsV2' ,BIPV2_PostProcess.layouts.stats_layout               );    //get prox segs
  getSelesegs    := wk_ut.get_DS_Result(pSegWuid,'SeleSegmentationStatsV2' ,BIPV2_PostProcess.layouts.stats_layout               );    //get Sele segs
  getSeleGold    := wk_ut.get_Scalar_Result(pSegWuid,'count_Gold_SELEID V2'); // get sele gold
  getPowsegs     := wk_ut.get_DS_Result(pSegWuid,'PowSegmentationStatsV2'  ,BIPV2_PostProcess.layouts.stats_layout               );    //get Pow segs
  getOrgsegs     := wk_ut.get_DS_Result(pSegWuid,'OrgSegmentationStatsV2'  ,BIPV2_PostProcess.layouts.stats_layout               );    //get Org segs
  idchangetable  := wk_ut.get_DS_Result(pSegWuid,'IdChangeTable'           ,BIPV2_PostProcess.fieldStats_IDcounts().layout_change);    //get pctsameseleids
  idcountbuckets := wk_ut.get_DS_Result(pSegWuid,'IDCountBuckets'          ,outr);    //get id count buckets
  
  External_Append := wk_ut.get_DS_Result(pEAWuid,'Recall'          ,External_append_lay);    //get Recall external append numbers

  idchangetable_slim  := table(idchangetable,{idtype,pct_sameseleids});
  
  idchangetable_result := dataset([
    {pversion,idchangetable_slim(trim(idtype) = 'seleid')[1].pct_sameseleids,idchangetable_slim(trim(idtype) = 'proxid')[1].pct_sameseleids}
  
  ],{string version,real8 seleid,real8 proxid})[1];
  
  idcountbuckets_slim := table(idcountbuckets,{ID,average_count,median_count,max_count,total_count,total_IDs,sum_buckets});
  
	op := record
		string10  UniqueID;
		unsigned6 cnt;
	end;
  EntityCount := wk_ut.get_DS_Result(pSegWuid   ,'EntityCount'           ,op);    //get entity counts
  total_record_count := wk_ut.get_Scalar_Result(pSegWuid,'TotalRecordCount');

  EntityCount_Flat := dataset([
    {pversion,(unsigned)total_record_count,EntityCount(trim(uniqueid,all) = 'EMPID')[1].cnt,EntityCount(trim(uniqueid,all) = 'POWID')[1].cnt,EntityCount(trim(uniqueid,all) = 'PROXID')[1].cnt,EntityCount(trim(uniqueid,all) = 'SELEID')[1].cnt,EntityCount(trim(uniqueid,all) = 'LGID3')[1].cnt,EntityCount(trim(uniqueid,all) = 'ORGID')[1].cnt}
  
  ],{string version,integer8 Records,integer8 empid,integer8 powid,integer8 proxid,integer8 seleid,integer8 lgid3,integer8 orgid})[1];
  
  layout_pandr := RECORD
    string20 dsname;
    string20 dstime;
    integer4 total_answers_given;
    integer4 total_measured;
    integer4 pct_measured;
    integer4 good_hits;
    integer4 bad_hits;
    integer4 unknown_hits;
    integer4 misses;
    integer4 precision;
    integer4 recall;
    integer4 potential_recall;
    integer4 pct_amgibigous_match;
  END;
 
  shortcyclePandRs := wk_ut.get_DS_Result(pPRWuid,'newSTATS'           ,layout_pandr);    //get P&R numbers for short cycle
  shortcyclePandRs_slim := table(shortcyclePandRs,{dsname,dstime,precision,recall});
  shortcyclePandRs_filter := shortcyclePandRs_slim(trim(dsname,all) = 'ALL',trim(dstime,all) in ['now','future']);  //2 records
  shortcyclePandRs_result := dataset([{
     pversion
    ,shortcyclePandRs_filter(dstime = 'now'    )[1].precision
    ,shortcyclePandRs_filter(dstime = 'future' )[1].precision
    ,shortcyclePandRs_filter(dstime = 'now'    )[1].recall
    ,shortcyclePandRs_filter(dstime = 'future' )[1].recall
    
    }
  ] ,{string version,integer4 Precision_Now  ,integer4 Precision_Future  ,integer4 Recall_Now  ,integer4 Recall_Future})[1];
  
  rachaels_PandRs := dataset([
     {'20140725',96,77} //19  
    ,{'20140821',94,77} //20
    ,{'20140918',96,79} //21
    ,{'20141015',96,84} //22
    ,{'20141113',96,80} //23
    ,{'20141211',96,80} //24
    ,{'20141211',96,81} //25
    ,{'20141211',96,81} //26
    ,{'20141211',96,82} //27
  
  ],{string version,integer4 Precision ,integer4 Recall });
  
/*
1)    For short cycle, lets just show the ALL NOW and ALL FUTURE, and just call
      them Precision Now, Precision Future, Recall Now, Recall Future.
    use Rachael's p&R stats
*/  
  joinsegs := sort(join(
     getproxsegs
    ,getSelesegs
    ,   left.segtype    = right.segtype
    and left.segsubtype = right.segsubtype
    ,transform(
      {recordof(left) - total,unsigned8 total_seleids,unsigned8 total_proxids}
      ,self.total_proxids := left.total
      ,self.total_seleids := right.total
      ,self               := left
    )
    ,full outer
  ),segtype,segsubtype);
  
  joinsegs2 := sort(join(
     joinsegs
    ,getOrgsegs
    ,   left.segtype    = right.segtype
    and left.segsubtype = right.segsubtype
    ,transform(
      {recordof(left),unsigned8 total_orgids}
      ,self.total_orgids := right.total
      ,self              := left
    )
    ,full outer
  ),segtype,segsubtype);

  joinsegs3 := sort(join(
     joinsegs2
    ,getPowsegs
    ,   left.segtype    = right.segtype
    and left.segsubtype = right.segsubtype
    ,transform(
      {recordof(left),unsigned8 total_Powids}
      ,self.total_Powids := right.total
      ,self              := left
    )
    ,full outer
  ),segtype,segsubtype);
  
  joinsegs3_slim := table(joinsegs3,{segtype,segsubtype,total_seleids});

  joinsegs3_result := dataset([
  
  {pversion,(unsigned)getSeleGold,joinsegs3_slim(trim(segtype,all) = 'TOTAL',trim(segsubtype,all) = 'Active')[1].total_seleids,joinsegs3_slim(trim(segtype,all) = 'INACTIVE',trim(segsubtype,all) = 'NoActivity')[1].total_seleids,joinsegs3_slim(trim(segtype,all) = 'INACTIVE',trim(segsubtype,all) = 'ReportedInactive')[1].total_seleids}
  
  ],{string version,unsigned total_Gold,unsigned Total_Active,unsigned Total_Inactive,unsigned Total_Defunct})[1];

  returndataset := dataset([
  
    {pversion,BIPV2.KeySuffix_mod2.SprintNumber(pversion),joinsegs3_result,idchangetable_result,rachaels_PandRs(version = pversion),EntityCount_Flat,idcountbuckets_slim,External_Append}
  
  
  ],{string Build_Date,String Sprint,recordof(joinsegs3_result) Sele_Segmentation,recordof(idchangetable_result)  Pct_Same_Seleids,dataset(recordof(rachaels_PandRs)) Precision_Recall
    ,recordof(EntityCount_Flat) EntityCount_Flat,dataset(recordof(idcountbuckets_slim)) IDCountBuckets
    ,dataset(recordof(External_Append)) External_Append
  });

  writefile := tools.macf_WriteFile(filenames(pversion).dashboard.new,returndataset,pOverwrite := true);
  
  return sequential(
     output(pversion ,named('pversion'))
    ,output(pSegWuid ,named('pSegWuid'))
    ,output(pPRWuid  ,named('pPRWuid' ))
    ,output(pEAWuid  ,named('pEAWuid' ))
    ,output(shortcyclePandRs_filter ,named('shortcyclePandRs_filter'))
    ,output(returndataset ,named('ReturnDataset'))
    ,writefile
    ,BIPV2_Build.Promote(pversion,'Dashboard').new2qaMult
  );

  // parallel(
     // output('Dashboard Stats Follow:')
    // ,output(joinsegs3           ,named('Segs'             ))
    // ,output(idchangetable_slim  ,named('idChangeTable'    ))
    // ,output(shortcyclePandRs_slim    ,named('shortcyclePandRs' ))
    // ,output(EntityCount         ,named('EntityCount'      ))
    // ,output(idcountbuckets      ,named('idCountBuckets'   ))
  // );
 
 end;