/*
  examples on production: 
    http://prod_esp:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20171115-162531#/stub/Summary
  uptick in actives for data card.  lets do this for seleid
  
  break up into couple parts
  new clusters(all new records) -- statuses of those per source
  existing clusters:
    switched to active   -- why?
    switched to inactive -- why
    switched to defunct  -- why?
    stayed the same
  
  I guess for the existing clusters, there are:
    ones that are identical, contain the same records with no new records
    ones that contain new records
    ones that 
  
*/
/*
BIPV2_Tools.compare_statuses_and_gold(
   BIPV2.KeySuffix
  ,BIPV2.KeySuffix_mod2.PreviousBuildDate
  ,bipv2.CommonBase.DS_CLEAN2 
  ,bipv2.CommonBase.CLEAN2(bipv2.CommonBase.Common_Base('20190501').logical)
  ,BIPV2.KeySuffix
  ,'20190501d'  //old version key was diff layout, so had to recreate it using the new layout and new name
  ,true
);
*/
import BIPV2,Advo;

EXPORT compare_statuses_and_gold(

   pCurrent_Version           = 'BIPV2.KeySuffix'
  ,pFather_Version            = 'BIPV2.KeySuffix_mod2.PreviousBuildDate'
  ,pDs_Base                   = 'bipv2.CommonBase.DS_CLEAN'
  ,pDs_Father                 = 'bipv2.CommonBase.DS_CLEAN_BASE'  
  ,pCurrentLgid3KeyVersion    = 'BIPV2.KeySuffix'
  ,pFatherLgid3KeyVersion     = 'BIPV2.KeySuffix_mod2.PreviousBuildDate'
  ,pTesting                   = 'false'                                   //if testing, then use clean2 which doesn't do suppression.  this allows the persists to not recalculate on reruns.  makes it quicker for testing.
  ,pActive_Fieldname2         = 'seleid_status_private'
) :=
functionmacro

  import tools,BIPV2,Advo,BIPV2_Tools,BIPV2_Statuses;
  
  old_version := pFather_Version [1..8];
  new_version := pCurrent_Version[1..8];

  old_sprint := BIPV2.KeySuffix_mod2.SprintNumber(old_version);
  new_sprint := BIPV2.KeySuffix_mod2.SprintNumber(new_version);

  ds_new  := BIPV2_Statuses.mac_Calculate_Gold(pDs_Base)  : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_new'); 
  ds_old  := pDs_Father : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_old');

  ds_new_agg := BIPV2_Tools.Agg_Slim(ds_new ,seleid) : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_new_agg');
  ds_old_agg := BIPV2_Tools.Agg_Slim(ds_old ,seleid) : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_old_agg');

  // -- get samples of base files
  ds_built := table(ds_new ,{seleid,pActive_Fieldname2,source,company_status_derived,dt_last_seen,dt_first_seen,dt_vendor_first_reported,dt_vendor_last_reported,ultid,orgid,proxid,powid}) : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_built'); 
  ds_base  := table(ds_old ,{seleid,pActive_Fieldname2,source,company_status_derived,dt_last_seen,dt_first_seen,dt_vendor_first_reported,dt_vendor_last_reported,ultid,orgid,proxid,powid}) : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_base');
  // ds_built := topn(bipv2.CommonBase.ds_base,10000000,seleid)  : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_built'); 
  // ds_base  := join(bipv2.CommonBase.ds_father ,table(ds_built ,{seleid} ,seleid ,merge) ,left.seleid = right.seleid ,transform(left)  ,hash) : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_base');


  // -- Set the statuses for those files, showing underlying sources and dates used for each ID
  ds_get_statuses_built := BIPV2_Statuses.mac_Set_Statuses(ds_built  ,pShow_Work := true,pToday := new_version,pOldWay := true ,pActive_Fieldname  := pActive_Fieldname2) : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_get_statuses_built');
  // ds_get_statuses_base  := dataset('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_get_statuses_base__p499438766' ,recordof(ds_get_statuses_built),flat);
  ds_get_statuses_base  := BIPV2_Statuses.mac_Set_Statuses(ds_base   ,pShow_Work := true,pToday := old_version,pOldWay := true ,pActive_Fieldname  := pActive_Fieldname2) : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_get_statuses_base' );  //keeps rebuilding this even though nothing has changed



  // -- If I join them together, full outer, then I have all the info in one dataset and can query it to my heart's content to 
  // -- get whatever info I want:
  // -- 1. count of existing seleids that changed statuses
  // --    a.  reason they changed statuses
  // --    b.  sources that 
  ds_join_all := join(ds_get_statuses_built ,ds_get_statuses_base ,left.seleid = right.seleid ,transform(
    {unsigned6 seleid,string1 new_status,string1 old_status,dataset(recordof(left)) new_recs  ,dataset(recordof(left)) old_recs}
    // ,self.new_recs.src_recs := left.src_recs
    ,self.new_recs          := dataset(left)
    // ,self.old_recs.src_recs := right.src_recs
    ,self.old_recs          := dataset(right)
    ,self.seleid            := if(left.seleid != 0  ,left.seleid  ,right.seleid)
    ,self.new_status        := left.pActive_Fieldname2
    ,self.old_status        := right.pActive_Fieldname2
  )  ,full outer  ,hash);

  ds_proj_all := project(ds_join_all  ,transform(
    {unsigned6 seleid,string1 new_status,string1 old_status,dataset(recordof(ds_get_statuses_built.active_calculation)) calc_diffs,dataset(recordof(ds_get_statuses_built.src_recs)) src_diffs ,set of string set_diff_sources,recordof(left) - seleid - new_status - old_status}
    ,src_diffs  := join(left.new_recs[1].src_recs           ,left.old_recs[1].src_recs           ,left.source      = right.source      and left.dt_last_seen = right.dt_last_seen and left.company_status_derived = right.company_status_derived  ,transform(left),left only);
     calc_diffs := join(left.new_recs[1].active_calculation ,left.old_recs[1].active_calculation ,left.calculation = right.calculation and left.result       = right.result                                                                       ,transform(left),left only);
      self.src_diffs         := src_diffs;
      self.calc_diffs        := calc_diffs;
      self.set_diff_sources  := set(sort(table(src_diffs,{source},source),source) ,source);
      self                   := left;
  ))  : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_proj_all');

  //get status calculation breakdown by source
  ds_src_status_breakdown_prep := normalize(ds_proj_all ,left.src_diffs ,transform({unsigned6 seleid ,string source,string cluster_type,string1 new_status,string1 old_status ,string Reported_Defunct  ,string Over_2_years_old  ,string Reported_Inactive   } 
    ,self.seleid            := left.seleid
    ,self.source            := right.source
    ,self.new_status        := left.new_status
    ,self.old_status        := left.old_status
    ,self.Reported_Defunct  := if(exists(left.calc_diffs(trim(calculation) = 'Reported Defunct' )) ,if(left.calc_diffs(trim(calculation) = 'Reported Defunct' )[1].result = true  ,'true' ,'false') ,'')
    ,self.Over_2_years_old  := if(exists(left.calc_diffs(trim(calculation) = 'Over 2 years old' )) ,if(left.calc_diffs(trim(calculation) = 'Over 2 years old' )[1].result = true  ,'true' ,'false') ,'')
    ,self.Reported_Inactive := if(exists(left.calc_diffs(trim(calculation) = 'Reported Inactive')) ,if(left.calc_diffs(trim(calculation) = 'Reported Inactive')[1].result = true  ,'true' ,'false') ,'')
    ,self.cluster_type    := map(

      trim(left.new_status) = '' and trim(left.old_status) = ''   and  exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Active Seleids in common'   
     ,trim(left.new_status) = '' and trim(left.old_status) = 'I'  and  exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Seleids switched from Inactive to Active'   
     ,trim(left.new_status) = '' and trim(left.old_status) = 'D'  and  exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Seleids switched from Defunct to Active'   
     ,trim(left.new_status) = ''                                  and ~exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Brand new active Seleids'   
 
     ,trim(left.new_status) = 'I' and trim(left.old_status) = 'I' and  exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Inactive Seleids in common'   
     ,trim(left.new_status) = 'I' and trim(left.old_status) = ''  and  exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Seleids switched from Active to Inactive'   
     ,trim(left.new_status) = 'I' and trim(left.old_status) = 'D' and  exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Seleids switched from Defunct to Inactive'   
     ,trim(left.new_status) = 'I'                                 and ~exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Brand new Inactive Seleids'   
 
     ,trim(left.new_status) = 'D' and trim(left.old_status) = 'D' and  exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Defunct Seleids in common'   
     ,trim(left.new_status) = 'D' and trim(left.old_status) = ''  and  exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Seleids switched from Active to Defunct'   
     ,trim(left.new_status) = 'D' and trim(left.old_status) = 'I' and  exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Seleids switched from Inactive to Defunct'   
     ,trim(left.new_status) = 'D'                                 and ~exists(left.old_recs(seleid != 0)) and  exists(left.new_recs(seleid != 0))  => 'Brand new Defunct Seleids'   

     ,trim(left.old_status) = ''                                  and  exists(left.old_recs(seleid != 0)) and ~exists(left.new_recs(seleid != 0))  => 'Lost Active Seleids'   
     ,trim(left.old_status) = 'I'                                 and  exists(left.old_recs(seleid != 0)) and ~exists(left.new_recs(seleid != 0))  => 'Lost Inactive Seleids'   
     ,trim(left.old_status) = 'D'                                 and  exists(left.old_recs(seleid != 0)) and ~exists(left.new_recs(seleid != 0))  => 'Lost Defunct Seleids'   
     ,                                                                                                                                                'Seleids unchanged'
    )
  ));


  ds_src_status_breakdown_table1 := table(ds_src_status_breakdown_prep    ,{seleid,cluster_type,new_status ,old_status ,Reported_Defunct  ,Over_2_years_old  ,Reported_Inactive  ,source                              } ,seleid ,cluster_type ,new_status ,old_status ,Reported_Defunct  ,Over_2_years_old  ,Reported_Inactive ,source  ,merge);
  ds_src_status_breakdown_table  := table(ds_src_status_breakdown_table1  ,{       cluster_type,new_status ,old_status ,Reported_Defunct  ,Over_2_years_old  ,Reported_Inactive  ,source ,unsigned cnt := count(group)}         ,cluster_type ,new_status ,old_status ,Reported_Defunct  ,Over_2_years_old  ,Reported_Inactive ,source  ,merge);
  ds_src_status_breakdown_table_sort := sort(ds_src_status_breakdown_table ,cluster_type,new_status ,old_status ,Reported_Defunct  ,Over_2_years_old  ,Reported_Inactive   ,-cnt,source);

  ds_src_status_breakdown_table_prep := project(ds_src_status_breakdown_table_sort ,transform({recordof(left) - source - cnt,dataset({string source,unsigned cnt}) source_differences}
    ,self.source_differences  := dataset([{left.source,left.cnt}] ,{string source,unsigned cnt})
    ,self                     := left
  ));

  ds_src_status_breakdown_prep2 := rollup(ds_src_status_breakdown_table_prep  ,transform(recordof(left)
    ,self.source_differences := left.source_differences + right.source_differences
    ,self                    := left
  )   ,cluster_type ,new_status ,old_status ,Reported_Defunct  ,Over_2_years_old  ,Reported_Inactive  );

  ds_src_status_breakdown_seleids_prep := table(ds_src_status_breakdown_table1        ,{seleid,cluster_type,new_status ,old_status ,Reported_Defunct  ,Over_2_years_old  ,Reported_Inactive                               } ,seleid ,cluster_type,new_status ,old_status ,Reported_Defunct  ,Over_2_years_old  ,Reported_Inactive   ,merge);
  ds_src_status_breakdown_seleids      := table(ds_src_status_breakdown_seleids_prep  ,{       cluster_type,new_status ,old_status ,Reported_Defunct  ,Over_2_years_old  ,Reported_Inactive ,unsigned cnt := count(group) }         ,cluster_type,new_status ,old_status ,Reported_Defunct  ,Over_2_years_old  ,Reported_Inactive   ,merge);

  ds_src_status_breakdown := join(ds_src_status_breakdown_prep2 ,ds_src_status_breakdown_seleids
  ,     left.cluster_type       = right.cluster_type
   and  left.new_status         = right.new_status
   and  left.old_status         = right.old_status
   and  left.Reported_Defunct   = right.Reported_Defunct
   and  left.Over_2_years_old   = right.Over_2_years_old
   and  left.Reported_Inactive  = right.Reported_Inactive
  ,transform({string total_seleids,string cluster_type,dataset({string calculation,string result}) status_calculation_differences,dataset({string source,string cnt_seleids}) source_differences}
    ,self.total_seleids                   := ut.fIntWithCommas(right.cnt)
    ,self.source_differences              := project(topn(left.source_differences ,10,-cnt) ,transform({string source,string cnt_seleids},self.cnt_seleids:= ut.fIntWithCommas(left.cnt),self := left))
    ,self.status_calculation_differences  := 
        if(trim(left.Reported_Defunct   ) != '' ,dataset([{'Reported Defunct'  ,left.Reported_Defunct   }],{string calculation,string result}) ,dataset([],{string calculation,string result})  )
      + if(trim(left.Over_2_years_old   ) != '' ,dataset([{'Over 2 years old'  ,left.Over_2_years_old   }],{string calculation,string result}) ,dataset([],{string calculation,string result})  )
      + if(trim(left.Reported_Inactive  ) != '' ,dataset([{'Reported Inactive' ,left.Reported_Inactive  }],{string calculation,string result}) ,dataset([],{string calculation,string result})  )
    ,self                               := left
  ));


  // -- for any particular change in status, the set_diff_sources will show the sources that made it happen
  ds_seleid_new_active_cluster                 := ds_proj_all(trim(new_status) = ''   and not exists(old_recs(seleid != 0)) );
  ds_seleid_new_defunct_cluster                := ds_proj_all(trim(new_status) = 'D'  and not exists(old_recs(seleid != 0)) );
  ds_seleid_new_Inactive_cluster               := ds_proj_all(trim(new_status) = 'I'  and not exists(old_recs(seleid != 0)) );
  ds_seleid_lost_active_cluster                := ds_proj_all(not exists(new_recs(seleid != 0)) and trim(old_status) = ''   );
  ds_seleid_lost_defunct_cluster               := ds_proj_all(not exists(new_recs(seleid != 0)) and trim(old_status) = 'D'  );
  ds_seleid_lost_Inactive_cluster              := ds_proj_all(not exists(new_recs(seleid != 0)) and trim(old_status) = 'I'  );
  ds_seleid_changed_status                     := ds_proj_all(new_status != old_status);
  ds_seleid_changed_status_Inactive_To_Active  := ds_proj_all(trim(new_status) = ''  and trim(old_status) = 'I' and exists(new_recs(seleid != 0)) );
  ds_seleid_changed_status_Defunct_To_Active   := ds_proj_all(trim(new_status) = ''  and trim(old_status) = 'D' and exists(new_recs(seleid != 0)) );
  ds_seleid_changed_status_Active_To_Inactive  := ds_proj_all(trim(new_status) = 'I' and trim(old_status) = ''  and exists(old_recs(seleid != 0)) );
  ds_seleid_changed_status_Defunct_To_Inactive := ds_proj_all(trim(new_status) = 'I' and trim(old_status) = 'D'                                   );
  ds_seleid_changed_status_Active_To_Defunct   := ds_proj_all(trim(new_status) = 'D' and trim(old_status) = ''  and exists(old_recs(seleid != 0)) );
  ds_seleid_changed_status_Inactive_To_Defunct := ds_proj_all(trim(new_status) = 'D' and trim(old_status) = 'I'                                   );

  ds_source_table_new_active_cluster                 := table(ds_seleid_new_active_cluster                 ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_new_defunct_cluster                := table(ds_seleid_new_defunct_cluster                ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_new_Inactive_cluster               := table(ds_seleid_new_Inactive_cluster               ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_lost_active_cluster                := table(ds_seleid_lost_active_cluster                ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_lost_defunct_cluster               := table(ds_seleid_lost_defunct_cluster               ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_lost_Inactive_cluster              := table(ds_seleid_lost_Inactive_cluster              ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_changed_status                     := table(ds_seleid_changed_status                     ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_changed_status_Inactive_To_Active  := table(ds_seleid_changed_status_Inactive_To_Active  ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_changed_status_Defunct_To_Active   := table(ds_seleid_changed_status_Defunct_To_Active   ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_changed_status_Active_To_Inactive  := table(ds_seleid_changed_status_Active_To_Inactive  ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_changed_status_Defunct_To_Inactive := table(ds_seleid_changed_status_Defunct_To_Inactive ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_changed_status_Active_To_Defunct   := table(ds_seleid_changed_status_Active_To_Defunct   ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);
  ds_source_table_changed_status_Inactive_To_Defunct := table(ds_seleid_changed_status_Inactive_To_Defunct ,{set_diff_sources,unsigned cnt := count(group)} ,set_diff_sources ,merge);


  // -- want to know overall totals of statuses from both files
  // -- overall change in actives
  // --    can be broken down into new clusters
  // --                            existing clusters turned active(inactive or defunct turned active)
  // --                            lost active clusters
  // --                            
  // -- top 5 sources that contributed to each of those stats
  // -- summary of all of those sources that contributed to more actives
  top10_contributory_active_sources := normalize(ds_seleid_new_active_cluster
  + ds_seleid_changed_status_Inactive_To_Active
  + ds_seleid_changed_status_Defunct_To_Active 
  ,left.src_diffs ,transform({string source},self.source := right.source));
  top10_contributory_active_sources_table := table(top10_contributory_active_sources  ,{source,unsigned cnt := count(group)} ,source ,merge);

  top10_contributory_inactive_sources := normalize(ds_seleid_new_inactive_cluster
  + ds_seleid_changed_status_active_To_inActive
  + ds_seleid_changed_status_Defunct_To_inActive 
  ,left.src_diffs ,transform({string source},self.source := right.source));
  top10_contributory_inactive_sources_table := table(top10_contributory_inactive_sources  ,{source,unsigned cnt := count(group)} ,source ,merge);

  top10_contributory_defunct_sources := normalize(ds_seleid_new_defunct_cluster
  + ds_seleid_changed_status_Inactive_To_defunct
  + ds_seleid_changed_status_active_To_defunct
  ,left.src_diffs ,transform({string source},self.source := right.source));
  top10_contributory_defunct_sources_table := table(top10_contributory_defunct_sources  ,{source,unsigned cnt := count(group)} ,source ,merge);

  /* 
      -------------------------------------- GOLD STUFF ----------------------------------------------
  */
  new_segs := BIPV2_PostProcess.proc_segmentation(new_version,ds_new,pPopulateStatus := false,pToday := new_version                               ,pUseClean2 := pTesting,pLgid3KeyVersion := pCurrentLgid3KeyVersion ,pPreserveGold := true);
  old_segs := BIPV2_PostProcess.proc_segmentation(old_version,ds_old,pPopulateStatus := false,pToday := old_version,pGoldOutputModifier := '_Old' ,pUseClean2 := pTesting,pLgid3KeyVersion := pFatherLgid3KeyVersion );

  // ds_new_golds := new_segs.modgoldSELEV2.Gold;
  // ds_old_golds := old_segs.modgoldSELEV2.Gold;

  // test_gold_summarys  := new_segs.modgoldSELEV2.ds_src_status_dt_rollup;
  ds_append_gold_field_new := new_segs.modgoldSELEV2_all.ds_append_gold_field       : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_append_gold_field_new');
  ds_append_gold_field_old := old_segs.modgoldSELEV2_all_old.ds_append_gold_field   : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_append_gold_field_old');


  ds_find_gold_diffs := join(ds_append_gold_field_new ,ds_append_gold_field_old ,left.seleid = right.seleid ,transform(
     {unsigned6 seleid ,boolean isgold_new ,boolean isgold_old ,dataset(recordof(ds_append_gold_field_new.gold_calculation)) gold_calc_new,dataset(recordof(ds_append_gold_field_new.gold_calculation)) gold_calc_old,dataset(recordof(ds_append_gold_field_new.src_dt_status)) new_sources  ,dataset(recordof(ds_append_gold_field_new.src_dt_status)) old_sources}
    ,self.seleid      := if(left.seleid != 0 ,left.seleid  ,right.seleid)
    ,self.isgold_new  := left.isgold
    ,self.isgold_old  := right.isgold
    ,self.new_sources := sort(left.src_dt_status ,-dt_last_seen,company_status_derived,source)
    ,self.old_sources := sort(right.src_dt_status,-dt_last_seen,company_status_derived,source)
    ,self.gold_calc_new := left.gold_calculation
    ,self.gold_calc_old := right.gold_calculation
  ),full outer  ,hash) : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_find_gold_diffs');


  ds_find_gold_diffs_all := project(ds_find_gold_diffs  ,transform(

    {unsigned6 seleid,boolean isgold_new ,boolean isgold_old ,dataset(recordof(ds_find_gold_diffs.gold_calc_new)) gold_calc_diff ,dataset(recordof(ds_find_gold_diffs.new_sources)) gold_calc_sources_diff ,set of string set_diff_sources,recordof(left) - seleid - isgold_new - isgold_old}
    
    ,gold_calc_sources_diff := join(left.new_sources   ,left.old_sources   ,left.source      = right.source      and left.dt_last_seen = right.dt_last_seen and left.company_status_derived = right.company_status_derived ,transform(left),left only);
     gold_calc_diff         := join(left.gold_calc_new ,left.gold_calc_old ,left.calculation = right.calculation and left.result       = right.result        ,transform(left),left only);
      self.gold_calc_sources_diff := sort(gold_calc_sources_diff  ,-dt_last_seen,company_status_derived,source);
      self.gold_calc_diff         := gold_calc_diff;
      self.set_diff_sources       := set(sort(table(gold_calc_sources_diff,{source},source),source) ,source);
      self                        := left;
      // self.rid                    := counter;
  ),local)  : persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_find_gold_diffs_all');


  ds_norm_gold_calculations_diff  := normalize(ds_find_gold_diffs_all ,left.gold_calc_diff          ,transform(recordof(left.gold_calc_diff         ),self := right));
  
  ds_norm_gold_calc_sources_diff  := normalize(ds_find_gold_diffs_all(  

         (isgold_new = true and exists(new_sources) and ~exists(old_sources)) 
      or (isgold_new = true and isgold_old = false  and  exists(old_sources))
    ) 
      
    ,left.gold_calc_sources_diff  
    ,transform({unsigned6 seleid,recordof(left.gold_calc_sources_diff )},self.seleid := left.seleid,self := right));

  ds_norm_gold_calculations_table_diff  := table(ds_norm_gold_calculations_diff ,{calculation,result  ,unsigned cnt := count(group)}  ,calculation,result ,merge);
  ds_norm_gold_calc_sources_diff_table  := table(table(ds_norm_gold_calc_sources_diff ,{tier,source ,seleid},tier,source ,seleid,merge) ,{tier,source         ,unsigned cnt := count(group)}  ,tier,source        ,merge);

  // -- 
  ds_norm_notgold_calc_sources_diff  := normalize(ds_find_gold_diffs_all((isgold_new = false and exists(new_sources) and ~exists(old_sources)) or (isgold_new = false and isgold_old = true and exists(old_sources) and exists(new_sources))) ,left.gold_calc_sources_diff  
    ,transform({unsigned6 seleid,recordof(left.gold_calc_sources_diff )},self.seleid := left.seleid,self := right));
  ds_norm_notgold_calc_sources_diff_table  := table(table(ds_norm_notgold_calc_sources_diff ,{tier,source ,seleid},tier,source ,seleid,merge) ,{tier,source         ,unsigned cnt := count(group)}  ,tier,source        ,merge);


  isactive_string             := 'isActive'                                                                       ;
  isnotjustpobox_string       := 'AND isNotJustPOBox'                                                             ;
  isinhrchy_or_lgid3linkable  := 'AND (inHrchy OR isLgid3Linkable)'                                               ;

  isinhrchy                   := 'AND inHrchy'                                               ;
  islgid3linkable             := 'AND isLgid3Linkable'                                               ;


  is_supercore_etc            := 'AND ( hasSuperCoreSrc OR ((hasOtherCoreSrc or has2TSrc) and hasMultipleSources)';


  ds_gold_calculations_summary_slim  := normalize(ds_find_gold_diffs_all  ,left.gold_calc_sources_diff  ,transform({unsigned6 seleid,string cluster_type,boolean isgold_new  ,boolean isgold_old ,string is_Active  ,string is_Not_Just_PO_Box  ,string is_In_Hrchy_Or_Is_Lgid3_Linkable ,string is_In_Hrchy,string Is_Lgid3_Linkable,string is_supercore_or_othercore_or_multiple_sources ,string source}
    ,self.is_Active                                     := if(exists(left.gold_calc_diff(calculation = isactive_string                    )) ,if(left.gold_calc_diff(calculation = isactive_string                    )[1].result = true  ,'true' ,'false') ,'')
    ,self.is_Not_Just_PO_Box                            := if(exists(left.gold_calc_diff(calculation = isnotjustpobox_string              )) ,if(left.gold_calc_diff(calculation = isnotjustpobox_string              )[1].result = true  ,'true' ,'false') ,'')
    ,self.is_In_Hrchy_Or_Is_Lgid3_Linkable              := if(exists(left.gold_calc_diff(calculation = isinhrchy_or_lgid3linkable         )) ,if(left.gold_calc_diff(calculation = isinhrchy_or_lgid3linkable         )[1].result = true  ,'true' ,'false') ,'')

    ,self.is_In_Hrchy                                   := if(exists(left.gold_calc_diff(calculation = isinhrchy                          )) ,if(left.gold_calc_diff(calculation = isinhrchy         )[1].result = true  ,'true' ,'false') ,'')
    ,self.Is_Lgid3_Linkable                             := if(exists(left.gold_calc_diff(calculation = islgid3linkable                    )) ,if(left.gold_calc_diff(calculation = islgid3linkable   )[1].result = true  ,'true' ,'false') ,'')


    ,self.is_supercore_or_othercore_or_multiple_sources := if(exists(left.gold_calc_diff(regexfind('hasSuperCoreSrc',calculation,nocase)  )) ,if(left.gold_calc_diff(regexfind('hasSuperCoreSrc',calculation,nocase)  )[1].result = true  ,'true' ,'false') ,'')
    ,self.source                                        := trim(right.tier) + ' ' + right.source
    ,self.isgold_new                                    := left.isgold_new
    ,self.isgold_old                                    := left.isgold_old
    ,self.cluster_type    := map(
      left.isgold_new = true   and left.isgold_old = true                                                                 => 'Gold Seleids In Common'
     ,left.isgold_new = true   and left.isgold_old = false   and  exists(left.old_sources)                                => 'Seleids switched from Non-Gold to Gold'
     ,left.isgold_new = true   and exists(left.new_sources)  and ~exists(left.old_sources)                                => 'Brand new Gold Seleids'
     
     ,left.isgold_new = false  and left.isgold_old = false   and  exists(left.new_sources)  and exists(left.old_sources)  => 'Not-Gold Seleids In Common'
     ,left.isgold_old = true   and left.isgold_new = false   and  exists(left.new_sources)                                => 'Seleids switched from Gold to Non-gold'
     ,left.isgold_new = false  and exists(left.new_sources)  and ~exists(left.old_sources)                                => 'Brand new Not-Gold Seleids'

     ,left.isgold_old = true   and ~exists(left.new_sources)                                                              => 'Gold Seleids that disappeared'
     ,left.isgold_old = false  and ~exists(left.new_sources)                                                              => 'Not-Gold Seleids that disappeared'
     ,                                                                                                                       'Not Gold Clusters'
    )
    ,self.seleid := left.seleid
  ));

  ds_gold_calculations_summary_table1 := table(ds_gold_calculations_summary_slim    ,{seleid,cluster_type,isgold_new ,isgold_old ,is_Active  ,is_Not_Just_PO_Box  ,is_In_Hrchy_Or_Is_Lgid3_Linkable,is_In_Hrchy,Is_Lgid3_Linkable ,is_supercore_or_othercore_or_multiple_sources ,source                              } ,seleid,cluster_type ,isgold_new ,isgold_old ,is_Active  ,is_Not_Just_PO_Box  ,is_In_Hrchy_Or_Is_Lgid3_Linkable,is_In_Hrchy,Is_Lgid3_Linkable ,is_supercore_or_othercore_or_multiple_sources ,source  ,merge);
  ds_gold_calculations_summary_table  := table(ds_gold_calculations_summary_table1  ,{       cluster_type,isgold_new ,isgold_old ,is_Active  ,is_Not_Just_PO_Box  ,is_In_Hrchy_Or_Is_Lgid3_Linkable,is_In_Hrchy,Is_Lgid3_Linkable ,is_supercore_or_othercore_or_multiple_sources ,source ,unsigned cnt := count(group)}        ,cluster_type ,isgold_new ,isgold_old ,is_Active  ,is_Not_Just_PO_Box  ,is_In_Hrchy_Or_Is_Lgid3_Linkable,is_In_Hrchy,Is_Lgid3_Linkable ,is_supercore_or_othercore_or_multiple_sources ,source  ,merge);
  ds_gold_calculations_summary_table_sort := sort(ds_gold_calculations_summary_table ,cluster_type,isgold_new ,isgold_old ,is_Active  ,is_Not_Just_PO_Box  ,is_In_Hrchy_Or_Is_Lgid3_Linkable,is_In_Hrchy,Is_Lgid3_Linkable ,is_supercore_or_othercore_or_multiple_sources  ,-cnt,source);

  ds_gold_calculations_summary_table_prep := project(ds_gold_calculations_summary_table_sort ,transform({recordof(left) - source - cnt,dataset({string source,unsigned cnt}) source_differences}
    ,self.source_differences  := dataset([{left.source,left.cnt}] ,{string source,unsigned cnt})
    ,self                     := left
  ));

  ds_gold_calculations_summary_prep := rollup(ds_gold_calculations_summary_table_prep  ,transform(recordof(left)
    ,self.source_differences := left.source_differences + right.source_differences
    ,self                    := left
  )   ,cluster_type ,isgold_new ,isgold_old ,is_Active  ,is_Not_Just_PO_Box  ,is_In_Hrchy_Or_Is_Lgid3_Linkable,is_In_Hrchy,Is_Lgid3_Linkable ,is_supercore_or_othercore_or_multiple_sources );

  ds_gold_calculations_summary_seleids_prep := table(ds_gold_calculations_summary_table1    ,{seleid,cluster_type,isgold_new ,isgold_old ,is_Active  ,is_Not_Just_PO_Box  ,is_In_Hrchy_Or_Is_Lgid3_Linkable,is_In_Hrchy,Is_Lgid3_Linkable ,is_supercore_or_othercore_or_multiple_sources} ,seleid,cluster_type ,isgold_new ,isgold_old ,is_Active  ,is_Not_Just_PO_Box  ,is_In_Hrchy_Or_Is_Lgid3_Linkable,is_In_Hrchy,Is_Lgid3_Linkable ,is_supercore_or_othercore_or_multiple_sources  ,merge);
  ds_gold_calculations_summary_seleids      := table(ds_gold_calculations_summary_seleids_prep    ,{cluster_type,isgold_new ,isgold_old ,is_Active  ,is_Not_Just_PO_Box  ,is_In_Hrchy_Or_Is_Lgid3_Linkable,is_In_Hrchy,Is_Lgid3_Linkable ,is_supercore_or_othercore_or_multiple_sources,unsigned cnt := count(group)} ,cluster_type ,isgold_new ,isgold_old ,is_Active  ,is_Not_Just_PO_Box  ,is_In_Hrchy_Or_Is_Lgid3_Linkable,is_In_Hrchy,Is_Lgid3_Linkable ,is_supercore_or_othercore_or_multiple_sources  ,merge);  

  ds_gold_calculations_summary := join(ds_gold_calculations_summary_prep  ,ds_gold_calculations_summary_seleids 
  ,     left.cluster_type                                   = right.cluster_type 
    and left.isgold_new                                     = right.isgold_new 
    and left.isgold_old                                     = right.isgold_old 
    and left.is_Active                                      = right.is_Active  
    and left.is_Not_Just_PO_Box                             = right.is_Not_Just_PO_Box 
    and left.is_In_Hrchy_Or_Is_Lgid3_Linkable               = right.is_In_Hrchy_Or_Is_Lgid3_Linkable 
    and left.is_In_Hrchy                                      = right.is_In_Hrchy 
    and left.Is_Lgid3_Linkable                                = right.Is_Lgid3_Linkable 
    and left.is_supercore_or_othercore_or_multiple_sources  = right.is_supercore_or_othercore_or_multiple_sources
  
  ,transform({string total_seleids,string cluster_type,dataset({string calculation,string result}) gold_calculation_differences,dataset({string source,string cnt_seleids}) source_differences}
    ,self.total_seleids                 := ut.fIntWithCommas(right.cnt)
    ,self.source_differences            := project(topn(left.source_differences ,10,-cnt) ,transform({string source,string cnt_seleids},self.cnt_seleids := ut.fIntWithCommas(left.cnt),self := left))
    ,self.gold_calculation_differences  := 
        if(trim(left.is_Active                                    ) != '' ,dataset([{isactive_string              ,left.is_Active                                     }],{string calculation,string result}) ,dataset([],{string calculation,string result})  )
      + if(trim(left.is_Not_Just_PO_Box                           ) != '' ,dataset([{isnotjustpobox_string        ,left.is_Not_Just_PO_Box                            }],{string calculation,string result}) ,dataset([],{string calculation,string result})  )
      + if(trim(left.is_In_Hrchy_Or_Is_Lgid3_Linkable             ) != '' ,dataset([{isinhrchy_or_lgid3linkable   ,left.is_In_Hrchy_Or_Is_Lgid3_Linkable              }],{string calculation,string result}) ,dataset([],{string calculation,string result})  )

      + if(trim(left.is_In_Hrchy                                    ) != '' ,dataset([{isinhrchy                    ,left.is_In_Hrchy                                     }],{string calculation,string result}) ,dataset([],{string calculation,string result})  )
      + if(trim(left.Is_Lgid3_Linkable                              ) != '' ,dataset([{islgid3linkable              ,left.Is_Lgid3_Linkable                               }],{string calculation,string result}) ,dataset([],{string calculation,string result})  )



      + if(trim(left.is_supercore_or_othercore_or_multiple_sources) != '' ,dataset([{is_supercore_etc             ,left.is_supercore_or_othercore_or_multiple_sources}],{string calculation,string result}) ,dataset([],{string calculation,string result})  )
    ,self                               := left
  ));

  // test_gold_summarys := new_segs.modgoldSELEV2.ds_src_status_dt_rollup;
  // output( count(test_gold_summarys)  ,named('count_test_gold_summarys'),all);
  // output( choosen(sort(WithHeaderDatesRolled  ,source,dt_last_seen,company_status_derived)  ,300)  ,named('WithHeaderDatesRolled'),all);
  // output( choosen(ds_append_gold_field  ,300)  ,named('ds_append_gold_field'),all);
  // output( choosen(test_gold_summarys  ,300)  ,named('test_gold_summarys'),all);
  // modgoldSELEV2.Gold// + modgoldSELEV2.NotGold
  contributory_sources_gold_prep    := project(ds_norm_gold_calc_sources_diff_table     ,transform({string source,unsigned cnt},self.source := trim(left.tier) + ' ' + left.source,self.cnt := left.cnt));
  contributory_sources_notgold_prep := project(ds_norm_notgold_calc_sources_diff_table  ,transform({string source,unsigned cnt},self.source := trim(left.tier) + ' ' + left.source,self.cnt := left.cnt));



  lay_contributory_sources := {string Source,string Count_Seleids};

  top10_contributory_sources_gold     := project(topn(contributory_sources_gold_prep            ,10,-cnt) ,transform(lay_contributory_sources ,self.Count_Seleids := ut.fIntWithCommas(left.cnt),self := left));
  top10_contributory_sources_notgold  := project(topn(contributory_sources_notgold_prep         ,10,-cnt) ,transform(lay_contributory_sources ,self.Count_Seleids := ut.fIntWithCommas(left.cnt),self := left));
  top10_contributory_sources_active   := project(topn(top10_contributory_active_sources_table   ,10,-cnt) ,transform(lay_contributory_sources ,self.Count_Seleids := ut.fIntWithCommas(left.cnt),self := left));
  top10_contributory_sources_inactive := project(topn(top10_contributory_inactive_sources_table ,10,-cnt) ,transform(lay_contributory_sources ,self.Count_Seleids := ut.fIntWithCommas(left.cnt),self := left));
  top10_contributory_sources_defunct  := project(topn(top10_contributory_defunct_sources_table  ,10,-cnt) ,transform(lay_contributory_sources ,self.Count_Seleids := ut.fIntWithCommas(left.cnt),self := left));


  lay_child_stats := {string Stat_Description ,string Count_Seleids := ''};
  
  ds_gold_stats := dataset([
     {'-----------Overall stats------------------','---------------'}
    ,{'New file (Sprint ' + trim(new_sprint) + ', ' + trim(new_version) + ')' ,ut.fIntWithCommas(count(ds_append_gold_field_new(isgold = true) )) }
    ,{'Old file (Sprint ' + trim(old_sprint) + ', ' + trim(old_version) + ')' ,ut.fIntWithCommas(count(ds_append_gold_field_old(isgold = true) )) }  
    ,{'Overall difference(+/-)'                                               ,ut.fIntWithCommas(count(ds_append_gold_field_new(isgold = true) ) - count(ds_append_gold_field_old(isgold = true) )) }
    ,{'Total Clusters gained'                                                 ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_new = true   ,isgold_old = false )))  }
    ,{'Total clusters lost'                                                   ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_old = true   ,isgold_new = false )))  }
    ,{'Total Gold Clusters in common'                                         ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_new = true   ,isgold_old = true  )))  }
                                          
    ,{'------Gained Stats breakdown-------------','---------------'}
    ,{'Brand new gold clusters'                           ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_new = true   ,exists(new_sources)  ,~exists(old_sources)) )) }
    ,{'Existing clusters switched from Non-Gold to Gold'  ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_new = true   ,isgold_old = false   , exists(old_sources)) )) }
                                          
    ,{'--------Lost Stats breakdown-------------','---------------'}
    ,{'Gold clusters that don\'t exist anymore'             ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_old = true   ,~exists(new_sources))))}
    ,{'Existing clusters switched from Gold to Non-gold'    ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_old = true   ,isgold_new = false   , exists(new_sources)) ))   }
                                          
  ] ,lay_child_stats);

  ds_notgold_stats := dataset([
     {'-----------Overall stats------------------','---------------'}
    ,{'New file (Sprint ' + trim(new_sprint) + ', ' + trim(new_version) + ')' ,ut.fIntWithCommas(count(ds_find_gold_diffs_all((isgold_new = false and exists(new_sources)) ))) }
    ,{'Old file (Sprint ' + trim(old_sprint) + ', ' + trim(old_version) + ')' ,ut.fIntWithCommas(count(ds_find_gold_diffs_all((isgold_old = false and exists(old_sources)) ))) }  
    ,{'Overall difference(+/-)'                                               ,ut.fIntWithCommas(count(ds_find_gold_diffs_all((isgold_new = false and exists(new_sources)) )) - count(ds_find_gold_diffs_all((isgold_old = false and exists(old_sources)) ))) }
    ,{'Total Clusters gained'                                                 ,ut.fIntWithCommas(count(ds_find_gold_diffs_all((isgold_new = false and exists(new_sources))  ,(isgold_old = true  or ~exists(old_sources)) )))  }
    ,{'Total clusters lost'                                                   ,ut.fIntWithCommas(count(ds_find_gold_diffs_all((isgold_old = false and exists(old_sources))  ,(isgold_new = true  or ~exists(new_sources)) )))  }
    ,{'Total Non-Gold Clusters in common'                                     ,ut.fIntWithCommas(count(ds_find_gold_diffs_all((isgold_new = false and exists(new_sources))  ,(isgold_old = false and exists(old_sources)) )))  }
                                          
    ,{'------Gained Stats breakdown-------------','---------------'}
    ,{'Brand new Non-gold clusters'                                   ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_new = false   ,exists(new_sources)  ,~exists(old_sources)) )) }
    ,{'Existing clusters switched from Gold to Non-Gold'              ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_new = false   ,isgold_old = true   ,exists(old_sources),exists(new_sources)) )) }
                                          
    ,{'--------Lost Stats breakdown-------------','---------------'}
    ,{'Non-Gold clusters that don\'t exist anymore'                   ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_old = false   ,exists(old_sources) ,~exists(new_sources))))}
    ,{'Existing clusters switched from Non-Gold to Gold'              ,ut.fIntWithCommas(count(ds_find_gold_diffs_all(isgold_old = false   ,isgold_new = true   ,exists(old_sources), exists(new_sources)) ))   }
                                          
  ] ,lay_child_stats);


  ds_active_stats := dataset([
     {'-----------Overall stats------------------','---------------'}
    ,{'New file (Sprint ' + trim(new_sprint) + ', ' + trim(new_version) + ')' ,ut.fIntWithCommas(count(ds_get_statuses_built(trim(pActive_Fieldname2) = '')))  }
    ,{'Old file (Sprint ' + trim(old_sprint) + ', ' + trim(old_version) + ')' ,ut.fIntWithCommas(count(ds_get_statuses_base (trim(pActive_Fieldname2) = '')))  }  
    ,{'Overall difference(+/-)'                                               ,ut.fIntWithCommas(count(ds_get_statuses_built(trim(pActive_Fieldname2) = '')) - count(ds_get_statuses_base (trim(pActive_Fieldname2) = '')))  }
    ,{'Total Clusters gained'                                                 ,ut.fIntWithCommas(count(ds_proj_all((trim(new_status) = '' and exists(new_recs(seleid != 0))) and ((trim(old_status) != '' and exists(old_recs(seleid != 0))) or ~exists(old_recs(seleid != 0)  )))))  }
    ,{'Total clusters lost'                                                   ,ut.fIntWithCommas(count(ds_proj_all((trim(old_status) = '' and exists(old_recs(seleid != 0))) and ((trim(new_status) != '' and exists(new_recs(seleid != 0))) or ~exists(new_recs(seleid != 0)  )))))  }
    ,{'Total Active Clusters in common'                                       ,ut.fIntWithCommas(count(ds_proj_all (trim(new_status) = '' and trim(old_status) = '' and exists(new_recs(seleid != 0)) and exists(old_recs(seleid != 0)))))  }
                                          
    ,{'------Gained Stats breakdown-------------','---------------'}
    ,{'Brand new active clusters'                             ,ut.fIntWithCommas(count(ds_seleid_new_active_cluster                 )) }
    ,{'Existing clusters switched from Inactive to active'    ,ut.fIntWithCommas(count(ds_seleid_changed_status_Inactive_To_Active  )) }
    ,{'Existing clusters switched from Defunct to active'     ,ut.fIntWithCommas(count(ds_seleid_changed_status_Defunct_To_Active   )) }
                                          
    ,{'--------Lost Stats breakdown-------------','---------------'}
    ,{'Active clusters that don\'t exist anymore'             ,ut.fIntWithCommas(count(ds_seleid_lost_active_cluster                )) }
    ,{'Existing clusters switched from Active to Inactive'    ,ut.fIntWithCommas(count(ds_seleid_changed_status_Active_To_Inactive  )) }
    ,{'Existing clusters switched from Active to Defunct'     ,ut.fIntWithCommas(count(ds_seleid_changed_status_Active_To_Defunct   )) }
                                          
  ] ,lay_child_stats);

  ds_inactive_stats := dataset([
     {'-----------Overall stats------------------','---------------'}
    ,{'New file (Sprint ' + trim(new_sprint) + ', ' + trim(new_version) + ')' ,ut.fIntWithCommas(count(ds_get_statuses_built(trim(pActive_Fieldname2) = 'I')))  }
    ,{'Old file (Sprint ' + trim(old_sprint) + ', ' + trim(old_version) + ')' ,ut.fIntWithCommas(count(ds_get_statuses_base (trim(pActive_Fieldname2) = 'I')))  }  
    ,{'Overall difference(+/-)'                                               ,ut.fIntWithCommas(count(ds_get_statuses_built(trim(pActive_Fieldname2) = 'I')) - count(ds_get_statuses_base(trim(pActive_Fieldname2) = 'I')) ) }
    ,{'Total Clusters gained'                                                 ,ut.fIntWithCommas(count(ds_seleid_new_inactive_cluster) + count(ds_seleid_changed_status_active_To_inActive) + count(ds_seleid_changed_status_Defunct_To_inActive))  }
    ,{'Total clusters lost'                                                   ,ut.fIntWithCommas(count(ds_seleid_lost_inactive_cluster) +  count(ds_seleid_changed_status_Inactive_To_Active) + count(ds_seleid_changed_status_Inactive_To_Defunct)) }
    ,{'Total Inactive Clusters in common'                                     ,ut.fIntWithCommas(count(ds_proj_all(trim(new_status) = 'I' and trim(old_status) = 'I')))  }
                                          
    ,{'------Gained Stats breakdown-------------','---------------'}
    ,{'Brand new inactive clusters'                           ,ut.fIntWithCommas(count(ds_seleid_new_inactive_cluster               )) }
    ,{'Existing clusters switched from active to inactive'    ,ut.fIntWithCommas(count(ds_seleid_changed_status_active_To_inActive  )) }
    ,{'Existing clusters switched from defunct to inactive'   ,ut.fIntWithCommas(count(ds_seleid_changed_status_Defunct_To_inActive )) }
                                          
    ,{'--------Lost Stats breakdown-------------','---------------'}
    ,{'Inactive clusters that don\'t exist anymore'           ,ut.fIntWithCommas(count(ds_seleid_lost_inactive_cluster              )) }
    ,{'Existing clusters switched from inactive to active'    ,ut.fIntWithCommas(count(ds_seleid_changed_status_Inactive_To_Active  )) }
    ,{'Existing clusters switched from inactive to Defunct'   ,ut.fIntWithCommas(count(ds_seleid_changed_status_Inactive_To_Defunct )) }
                                          
  ] ,lay_child_stats);

  ds_defunct_stats := dataset([
     {'-----------Overall stats------------------','---------------'}
    ,{'New file (Sprint ' + trim(new_sprint) + ', ' + trim(new_version) + ')' ,ut.fIntWithCommas(count(ds_get_statuses_built(trim(pActive_Fieldname2) = 'D'))) }
    ,{'Old file (Sprint ' + trim(old_sprint) + ', ' + trim(old_version) + ')' ,ut.fIntWithCommas(count(ds_get_statuses_base (trim(pActive_Fieldname2) = 'D'))) }  
    ,{'Overall difference(+/-)'                                               ,ut.fIntWithCommas(count(ds_get_statuses_built(trim(pActive_Fieldname2) = 'D')) - count(ds_get_statuses_base (trim(pActive_Fieldname2) = 'D')) ) }
    ,{'Total Clusters gained'                                                 ,ut.fIntWithCommas(count(ds_seleid_new_defunct_cluster) + count(ds_seleid_changed_status_active_To_Defunct + ds_seleid_changed_status_inactive_To_defunct) ) }
    ,{'Total clusters lost'                                                   ,ut.fIntWithCommas(count(ds_seleid_lost_defunct_cluster) +  count(ds_seleid_changed_status_defunct_To_Active) + count(ds_seleid_changed_status_defunct_To_Inactive) )}
    ,{'Total Defunct Clusters in common'                                      ,ut.fIntWithCommas(count(ds_proj_all(trim(new_status) = 'D' and trim(old_status) = 'D')) ) }
                                          
    ,{'------Gained Stats breakdown-------------','---------------'}
    ,{'Brand new Defunct clusters'                            ,ut.fIntWithCommas(count(ds_seleid_new_defunct_cluster                )) }
    ,{'Existing clusters switched from active to defunct'     ,ut.fIntWithCommas(count(ds_seleid_changed_status_active_To_Defunct   )) }
    ,{'Existing clusters switched from inactive to defunct'   ,ut.fIntWithCommas(count(ds_seleid_changed_status_inactive_To_defunct )) }
                                          
    ,{'--------Lost Stats breakdown-------------','---------------'}
    ,{'Defunct clusters that don\'t exist anymore'            ,ut.fIntWithCommas(count(ds_seleid_lost_defunct_cluster               )) }
    ,{'Existing clusters switched from defunct to active'     ,ut.fIntWithCommas(count(ds_seleid_changed_status_defunct_To_Active   )) }
    ,{'Existing clusters switched from defunct to inactive'   ,ut.fIntWithCommas(count(ds_seleid_changed_status_defunct_To_Inactive )) }
                                          
  ] ,lay_child_stats);


  ds_cluster_stats := dataset([
    { 'Gold'                                                                                            
      ,ds_gold_stats   
      ,top10_contributory_sources_gold                                                              
    }

   ,{  'Non-Gold'                                                                                                                                                                                                                 
      ,ds_notgold_stats                                                                                                       
      ,top10_contributory_sources_Notgold                                                                                                          
    }                                                                                                                                             

   ,{  'Active'                                                                                                                                                                                                                 
      ,ds_active_stats                                                                                                       
      ,top10_contributory_sources_active                                                                                                          
    }                                                                                                                                             

   ,{ 'Inactive'                                                                                                                                                                               
      ,ds_inactive_stats                                                                 
      ,top10_contributory_sources_inactive                                                                     
    }

   ,{ 'Defunct'                                                                                                   
      ,ds_defunct_stats                                                                    
      ,top10_contributory_sources_defunct                                                                       
  }
  ]  ,{
     string                             Status  
    ,dataset(lay_child_stats          ) Comparison_Stats
    ,dataset(lay_contributory_sources ) Top_10_Sources_of_Gained_Seleids

    });

  // string status  
  // unsigned cnt_new_file  
  // unsigned cnt_old_file  
  // unsigned cnt_identical_existing_clusters 
  // unsigned cnt_new_clusters  
  // unsigned cnt_changed_status  
  // unsigned lost_clusters 
  // dataset({string source,unsigned cnt}) top10_contributory_sources}




  ds_stats := dataset([
    {'Count New Seleids'                            ,count(ds_get_statuses_built)}
   ,{'Count Old Seleids'                            ,count(ds_get_statuses_base )}
   ,{'Count Join Together'                          ,count(ds_proj_all)}
   ,{'ds_seleid_new_active_cluster'                 ,count(ds_seleid_new_active_cluster                )}
   ,{'ds_seleid_new_defunct_cluster'                ,count(ds_seleid_new_defunct_cluster               )}
   ,{'ds_seleid_new_Inactive_cluster'               ,count(ds_seleid_new_Inactive_cluster              )}
   ,{'ds_seleid_lost_active_cluster'                ,count(ds_seleid_lost_active_cluster               )}
   ,{'ds_seleid_lost_defunct_cluster'               ,count(ds_seleid_lost_defunct_cluster              )}
   ,{'ds_seleid_lost_Inactive_cluster'              ,count(ds_seleid_lost_Inactive_cluster             )}
   ,{'ds_seleid_changed_status'                     ,count(ds_seleid_changed_status                    )}
   ,{'ds_seleid_changed_status_Inactive_To_Active'  ,count(ds_seleid_changed_status_Inactive_To_Active )}
   ,{'ds_seleid_changed_status_Defunct_To_Active'   ,count(ds_seleid_changed_status_Defunct_To_Active  )}
   ,{'ds_seleid_changed_status_Active_To_Inactive'  ,count(ds_seleid_changed_status_Active_To_Inactive )}
   ,{'ds_seleid_changed_status_Defunct_To_Inactive' ,count(ds_seleid_changed_status_Defunct_To_Inactive)}
   ,{'ds_seleid_changed_status_Active_To_Defunct'   ,count(ds_seleid_changed_status_Active_To_Defunct  )}
   ,{'ds_seleid_changed_status_Inactive_To_Defunct' ,count(ds_seleid_changed_status_Inactive_To_Defunct)}
    
  ]  ,{string statname ,unsigned statvalue});

  output_debug := parallel(
     output('--------------BIPV2_Tools.compare_statuses_and_gold---------------------------------'  ,named('____BIPV2_Tools_compare_statuses_and_gold____'))
    ,output('--------------Overall Stats---------------------------------'                          ,named('____Overall_Stats____'                        ))
    ,output(ds_cluster_stats                                                                                                                                         ,named('Overall_Seleid_Cluster_Stats'))
    ,output(sort(ds_gold_calculations_summary( regexfind('(switched|brand|disappeared)' ,cluster_type,nocase))   ,-(unsigned)STD.Str.FilterOut(total_seleids,',') )  ,named('Details_Of_Gold_Seleid_Changes'  ),all)
    ,output(sort(ds_src_status_breakdown     (~regexfind('common'                       ,cluster_type,nocase))   ,-(unsigned)STD.Str.FilterOut(total_seleids,',') )  ,named('Details_Of_Active_Seleid_Changes'),all)

    ,output('--------------Full Stats for active and gold calculations(including clusters with same status)---------------------------------'                 ,named('____Full_Stats_for_active_and_gold_calculations____'))
    ,output(sort(ds_gold_calculations_summary                                                             ,-(unsigned)STD.Str.FilterOut(total_seleids,',') )  ,named('Details_Of_All_Gold_Seleids'                        ),all)
    ,output(sort(ds_src_status_breakdown                                                                  ,-(unsigned)STD.Str.FilterOut(total_seleids,',') )  ,named('Details_Of_All_Active_Seleids'                      ),all)
     
// Get samples of clusters that were gold because of being in the hierarchy, but are not considered gold anymore. 
// Get samples of clusters that were not gold before because there were not lgid3 linkable, but are now gold.  For thin records(not lgid3 linkable), may need to add requirements to have at least cnp_name, or fein, or corpkey, etc.

    ,output('--------------Gold Status Changes Examples---------------------------------' ,named('____Gold_Status_Changes_Examples____'))
    ,output(choosen(ds_find_gold_diffs_all(isgold_new = true   and exists(new_sources)  and ~exists(old_sources)                          ),300)  ,named('Brand_new_Gold_Seleids'                  ),all)
    ,output(choosen(ds_find_gold_diffs_all(isgold_new = true   and isgold_old = false   and  exists(old_sources)                          ),300)  ,named('Seleids_switched_from_Non_Gold_to_Gold'  ),all)


    ,output(choosen(ds_find_gold_diffs_all(isgold_new = true   and isgold_old = false   and  exists(old_sources) and gold_calc_new(trim(calculation) = 'AND (inHrchy OR isLgid3Linkable)')[1].result = false ),300)  ,named('Seleids_switched_from_Non_Gold_to_Gold_not_Lgid3Linkable'  ),all)


    ,output(choosen(ds_find_gold_diffs_all(isgold_old = true   and isgold_new = false   and  exists(new_sources) and gold_calc_new(regexfind('AND inHrchy'        ,calculation,nocase))[1].result = true  ),300)  ,named('Seleids_switched_from_Gold_to_Non_gold_inHrchy'         ),all)
    ,output(choosen(ds_find_gold_diffs_all(isgold_old = true   and isgold_new = false   and  exists(new_sources) and gold_calc_new(regexfind('AND isLgid3Linkable',calculation,nocase))[1].result = true  ),300)  ,named('Seleids_switched_from_Gold_to_Non_gold_Lgid3Linkable'   ),all)

    ,output(choosen(ds_find_gold_diffs_all(isgold_old = true   and isgold_new = false   and  exists(new_sources)                          ),300)  ,named('Seleids_switched_from_Gold_to_Non_gold'  ),all)
    ,output(choosen(ds_find_gold_diffs_all(isgold_new = false  and exists(new_sources)  and ~exists(old_sources)                          ),300)  ,named('Brand_new_Not_Gold_Seleids'              ),all)
    ,output(choosen(ds_find_gold_diffs_all(isgold_old = true   and ~exists(new_sources)                                                   ),300)  ,named('Gold_Seleids_that_disappeared'           ),all)
    ,output(choosen(ds_find_gold_diffs_all(isgold_old = false  and ~exists(new_sources)                                                   ),300)  ,named('Not_Gold_Seleids_that_disappeared'       ),all)
    ,output(choosen(ds_find_gold_diffs_all(isgold_new = true   and isgold_old = true                                                      ),300)  ,named('Gold_Seleids_In_Common'                  ),all)
    ,output(choosen(ds_find_gold_diffs_all(isgold_new = false  and isgold_old = false   and  exists(new_sources)  and exists(old_sources) ),300)  ,named('Not_Gold_Seleids_In_Common'              ),all)

    ,output('--------------Active Status Changes Examples---------------------------------' ,named('____Active_Status_Changes_Examples____'))
    ,output(topn(ds_proj_all(trim(new_status) = '' and trim(old_status) = 'I'  and  exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Seleids_switched_from_Inactive_to_Active'  )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = '' and trim(old_status) = 'D'  and  exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Seleids_switched_from_Defunct_to_Active'   )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = ''                             and ~exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Brand_new_active_Seleids'                  )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = 'I' and trim(old_status) = ''  and  exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Seleids_switched_from_Active_to_Inactive'  )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = 'I' and trim(old_status) = 'D' and  exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Seleids_switched_from_Defunct_to_Inactive' )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = 'I'                            and ~exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Brand_new_Inactive_Seleids'                )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = 'D' and trim(old_status) = ''  and  exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Seleids_switched_from_Active_to_Defunct'   )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = 'D' and trim(old_status) = 'I' and  exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Seleids_switched_from_Inactive_to_Defunct' )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = 'D'                            and ~exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Brand_new_Defunct_Seleids'                 )  ,all  )
    ,output(topn(ds_proj_all(trim(old_status) = ''                             and  exists(old_recs(seleid != 0)) and ~exists(new_recs(seleid != 0))),300,seleid) ,named('Lost_Active_Seleids'                       )  ,all  )
    ,output(topn(ds_proj_all(trim(old_status) = 'I'                            and  exists(old_recs(seleid != 0)) and ~exists(new_recs(seleid != 0))),300,seleid) ,named('Lost_Inactive_Seleids'                     )  ,all  )
    ,output(topn(ds_proj_all(trim(old_status) = 'D'                            and  exists(old_recs(seleid != 0)) and ~exists(new_recs(seleid != 0))),300,seleid) ,named('Lost_Defunct_Seleids'                      )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = '' and trim(old_status) = ''   and  exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Active_Seleids_in_common'                  )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = 'I' and trim(old_status) = 'I' and  exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Inactive_Seleids_in_common'                )  ,all  )
    ,output(topn(ds_proj_all(trim(new_status) = 'D' and trim(old_status) = 'D' and  exists(old_recs(seleid != 0)) and  exists(new_recs(seleid != 0))),300,seleid) ,named('Defunct_Seleids_in_common'                 )  ,all  )
        
    // ,output( choosen(ds_find_gold_diffs_all(exists(gold_calc_diff) and ~exists(old_sources) and gold_calc_new(regexfind('hasSuperCoreSrc'  ,calculation ,nocase))[1].result = true )   ,300)  ,named('Examples_Of_Gold_supercore_Src_difference_brand_new_clusters'),all)
    // ,output( choosen(ds_find_gold_diffs_all(gold_calc_new(regexfind('hasSuperCoreSrc'  ,calculation ,nocase))[1].result != gold_calc_old(regexfind('hasSuperCoreSrc'  ,calculation ,nocase))[1].result )   ,300)  ,named('Examples_Of_Gold_supercore_Src_differences'),all)
    // ,output( choosen(ds_find_gold_diffs_all(exists(gold_calc_diff) and (gold_calc_new(regexfind('hasSuperCoreSrc'  ,calculation ,nocase))[1].result = false or gold_calc_old(regexfind('hasSuperCoreSrc'  ,calculation ,nocase))[1].result = false  ))   ,300)  ,named('Examples_Of_Gold_supercore_Src_False_and_diff'),all)
    // ,output( choosen(ds_find_gold_diffs_all(gold_calc_new(regexfind('hasSuperCoreSrc'  ,calculation ,nocase))[1].result = false or gold_calc_old(regexfind('hasSuperCoreSrc'  ,calculation ,nocase))[1].result = false  )   ,300)  ,named('Examples_Of_Gold_supercore_Src_False'),all)
    // ,output( count(ds_find_gold_diffs_all(gold_calc_new(regexfind('hasSuperCoreSrc'  ,calculation ,nocase))[1].result = false or gold_calc_old(regexfind('hasSuperCoreSrc'  ,calculation ,nocase))[1].result = false  ) )  ,named('Count_Examples_Of_Gold_supercore_Src_False'),all)

/*    ,output('--------------Other Stats and examples---------------------------------' ,named('____Other_Stats_and_examples____'))
    ,output(ds_stats ,named('ds_stats'))
    ,output( choosen(ds_find_gold_diffs  ,300)  ,named('Examples_Of_Seleids_with_Gold_Info_Appended'),all)
    ,output( choosen(ds_find_gold_diffs_all(exists(gold_calc_sources_diff))  ,300)  ,named('Examples_Of_Gold_Sources_Differences'),all)
    ,output( choosen(ds_find_gold_diffs_all(exists(gold_calc_diff        ))  ,300)  ,named('Examples_Of_Gold_Calculation_Differences'),all)
    ,output(topn(ds_norm_gold_calculations_table_diff,100,-cnt             ) ,named('Gold_Calculation_Differences_Counts'     ))
    ,output(topn(ds_norm_gold_calc_sources_diff_table,100,-cnt,tier,source ) ,named('Sources_Of_Gold_Calculation_Differences_Counts'))
    
    ,output(topn(ds_source_table_new_active_cluster                  ,400  ,-cnt)  ,named('ds_source_table_new_active_cluster'                ),all)
    ,output(topn(ds_source_table_new_defunct_cluster                 ,400  ,-cnt)  ,named('ds_source_table_new_defunct_cluster'               ),all)
    ,output(topn(ds_source_table_new_Inactive_cluster                ,400  ,-cnt)  ,named('ds_source_table_new_Inactive_cluster'              ),all)
    ,output(topn(ds_source_table_lost_active_cluster                 ,400  ,-cnt)  ,named('ds_source_table_lost_active_cluster'               ),all)
    ,output(topn(ds_source_table_lost_defunct_cluster                ,400  ,-cnt)  ,named('ds_source_table_lost_defunct_cluster'              ),all)
    ,output(topn(ds_source_table_lost_Inactive_cluster               ,400  ,-cnt)  ,named('ds_source_table_lost_Inactive_cluster'             ),all)
    ,output(topn(ds_source_table_changed_status                      ,400  ,-cnt)  ,named('ds_source_table_changed_status'                    ),all)
    ,output(topn(ds_source_table_changed_status_Inactive_To_Active   ,400  ,-cnt)  ,named('ds_source_table_changed_status_Inactive_To_Active' ),all)
    ,output(topn(ds_source_table_changed_status_Defunct_To_Active    ,400  ,-cnt)  ,named('ds_source_table_changed_status_Defunct_To_Active'  ),all)
    ,output(topn(ds_source_table_changed_status_Active_To_Inactive   ,400  ,-cnt)  ,named('ds_source_table_changed_status_Active_To_Inactive' ),all)
    ,output(topn(ds_source_table_changed_status_Defunct_To_Inactive  ,400  ,-cnt)  ,named('ds_source_table_changed_status_Defunct_To_Inactive'),all)
    ,output(topn(ds_source_table_changed_status_Active_To_Defunct    ,400  ,-cnt)  ,named('ds_source_table_changed_status_Active_To_Defunct'  ),all)
    ,output(topn(ds_source_table_changed_status_Inactive_To_Defunct  ,400  ,-cnt)  ,named('ds_source_table_changed_status_Inactive_To_Defunct'),all)

    ,output(topn(ds_seleid_new_active_cluster                  ,400  ,-count(src_diffs))  ,named('ds_seleid_new_active_cluster'                 ),all)
    ,output(topn(ds_seleid_new_defunct_cluster                 ,400  ,-count(src_diffs))  ,named('ds_seleid_new_defunct_cluster'                ),all)
    ,output(topn(ds_seleid_new_Inactive_cluster                ,400  ,-count(src_diffs))  ,named('ds_seleid_new_Inactive_cluster'               ),all)
    ,output(topn(ds_seleid_lost_active_cluster                 ,400  ,-count(src_diffs))  ,named('ds_seleid_lost_active_cluster'                ),all)
    ,output(topn(ds_seleid_lost_defunct_cluster                ,400  ,-count(src_diffs))  ,named('ds_seleid_lost_defunct_cluster'               ),all)
    ,output(topn(ds_seleid_lost_Inactive_cluster               ,400  ,-count(src_diffs))  ,named('ds_seleid_lost_Inactive_cluster'              ),all)
    ,output(topn(ds_seleid_changed_status                      ,400  ,-count(src_diffs))  ,named('ds_seleid_changed_status'                     ),all)
    ,output(topn(ds_seleid_changed_status_Inactive_To_Active   ,400  ,-count(src_diffs))  ,named('ds_seleid_changed_status_Inactive_To_Active'  ),all)
    ,output(topn(ds_seleid_changed_status_Defunct_To_Active    ,400  ,-count(src_diffs))  ,named('ds_seleid_changed_status_Defunct_To_Active'   ),all)
    ,output(topn(ds_seleid_changed_status_Active_To_Inactive   ,400  ,-count(src_diffs))  ,named('ds_seleid_changed_status_Active_To_Inactive'  ),all)
    ,output(topn(ds_seleid_changed_status_Defunct_To_Inactive  ,400  ,-count(src_diffs))  ,named('ds_seleid_changed_status_Defunct_To_Inactive' ),all)
    ,output(topn(ds_seleid_changed_status_Active_To_Defunct    ,400  ,-count(src_diffs))  ,named('ds_seleid_changed_status_Active_To_Defunct'   ),all)
    ,output(topn(ds_seleid_changed_status_Inactive_To_Defunct  ,400  ,-count(src_diffs))  ,named('ds_seleid_changed_status_Inactive_To_Defunct' ),all)

    ,output(topn(ds_get_statuses_built,500,seleid) ,named('ds_get_statuses_built')  ,all  )
    ,output(topn(ds_get_statuses_base ,500,seleid) ,named('ds_get_statuses_base' )  ,all  )
    ,output(topn(ds_proj_all,500,seleid) ,named('ds_join_all')  ,all  )
    ,output(topn(ds_proj_all(new_status != old_status),500,seleid) ,named('ds_join_all_diff_status')  ,all  )

*/
  );

  return output_debug;
  
endmacro;
