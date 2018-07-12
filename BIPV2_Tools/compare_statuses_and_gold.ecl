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

import BIPV2,Advo;

EXPORT compare_statuses_and_gold(

   pBase_Sprint   = 'BIPV2.KeySuffix'
  ,pFather_Sprint = 'BIPV2.KeySuffix_mod2.PreviousBuildDate'
  ,pDs_Base       = 'bipv2.CommonBase.DS_CLEAN'
  ,pDs_Father     = 'bipv2.CommonBase.DS_CLEAN_BASE'  

) :=
functionmacro

ds_base   := pDs_Base      ;
ds_father := pDs_Father ;

ds_base_slim_prep   := table(ds_base   ,{seleid,string source := mdr.sourceTools.translatesource(source),dt_last_seen,company_status_derived,seleid_status_public},seleid,source,dt_last_seen,company_status_derived,seleid_status_public,merge  );
ds_father_slim_prep := table(ds_father ,{seleid,string source := mdr.sourceTools.translatesource(source),dt_last_seen,company_status_derived,seleid_status_public},seleid,source,dt_last_seen,company_status_derived,seleid_status_public,merge  );

ds_base_slim_prep2   := table(ds_base_slim_prep   ,{seleid,source} ,seleid,source ,merge);
ds_father_slim_prep2 := table(ds_father_slim_prep ,{seleid,source} ,seleid,source ,merge);

ds_base_slim_prep3   := table(ds_base_slim_prep2   ,{seleid,unsigned cnt := count(group)} ,seleid ,merge);
ds_father_slim_prep3 := table(ds_father_slim_prep2 ,{seleid,unsigned cnt := count(group)} ,seleid ,merge);

ds_base_slim   := join(ds_base_slim_prep    ,ds_base_slim_prep3  (cnt = 1) ,left.seleid = right.seleid ,transform(left) ,hash);
ds_father_slim := join(ds_father_slim_prep  ,ds_father_slim_prep3(cnt = 1) ,left.seleid = right.seleid ,transform(left) ,hash);

ds_sample_base          := ds_base_slim : persist('~persist::lbentley::ds_sample_base');
// ds_set_statuses_base := BIPV2_Tools.mac_Set_Statuses(ds_sample_base  ,seleid,seleid_status_public,false,87324387,true,,true);

// -- base
ds_prep_rollup_base  := project(sort(distribute(ds_sample_base,seleid),seleid,-if(dt_last_seen = 0  ,99999999,dt_last_seen) ,source ,local) 
                    ,transform({unsigned6 seleid,dataset({string file,recordof(left) - seleid}) recs}
                      ,self.recs := dataset([{pBase_Sprint,left.source,left.dt_last_seen,left.company_status_derived,left.seleid_status_public}],{string file,recordof(left) - seleid})  
                      ,self           := left
                    ),local);
ds_rollup_base       := rollup(ds_prep_rollup_base  ,left.seleid = right.seleid ,transform(recordof(left),self.recs := left.recs + right.recs,self := left),local);


// -- father
ds_sample_father       := ds_father_slim : persist('~persist::lbentley::ds_sample_father');
// ds_set_statuses_father := BIPV2_Tools.mac_Set_Statuses(ds_sample_father  ,seleid,seleid_status_public,false,87324387,true,'20170801',true);

ds_prep_rollup_father  := project(sort(distribute(ds_sample_father,seleid),seleid,-if(dt_last_seen = 0  ,99999999,dt_last_seen) ,source ,local) 
                    ,transform({unsigned6 seleid,dataset({string file,recordof(left) - seleid}) recs}
                      ,self.recs := dataset([{pFather_Sprint,left.source,left.dt_last_seen,left.company_status_derived,left.seleid_status_public}],{string file,recordof(left) - seleid})  
                      ,self           := left
                    ),local);
ds_rollup_father       := rollup(ds_prep_rollup_father  ,left.seleid = right.seleid ,transform(recordof(left),self.recs := left.recs + right.recs,self := left),local);

ds_compare := join(ds_rollup_base ,ds_rollup_father ,left.seleid = right.seleid   ,transform({recordof(left)}
  ,self.recs := left.recs  
              + right.recs
              ,self := left),hash);


ds_compare_more := project(ds_compare ,transform(
  {recordof(left),dataset(recordof(ds_compare.recs)) compare }
  ,self.compare := sort(rollup(sort(left.recs/*(dt_last_seen != 0)*/,source,company_status_derived,dt_last_seen,-file),left.source = right.source and trim(left.company_status_derived) = trim(right.company_status_derived) and left.dt_last_seen = right.dt_last_seen ,transform(recordof(left),self.file := trim(left.file) + ',' + trim(right.file),self := left)),-file,source);
  ,self         := left
));


// -- anytime in the compare child dataset the file = 'Sprint 52', take the source field and those are the sources that contributed to the change in status
ds_compare_diff_status := ds_compare_more(    recs(trim(file) = pBase_Sprint)[1].seleid_status_public 
                                          !=  recs(trim(file) = pFather_Sprint)[1].seleid_status_public
                                         );

ds_compare_diff_status_sources := project(ds_compare_diff_status  ,transform({unsigned6 seleid,string1 old_status,string1 new_status,set of string sources}
  ,self.seleid      := left.seleid
  ,self.old_status  := left.recs(trim(file) = pFather_Sprint)[1].seleid_status_public
  ,self.new_status  := left.recs(trim(file) = pBase_Sprint)[1].seleid_status_public
  ,self.sources     := set(sort(project(left.compare(trim(file) = pBase_Sprint),{string source}),source),source)
));

ds_compare_diff_status_sources_table := table(ds_compare_diff_status_sources  ,{sources ,old_status,new_status,unsigned cnt := count(group)} ,sources,old_status,new_status ,merge)
: persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_compare_diff_status_sources_table'); 
ds_compare_diff_status_sources_table_persist := dataset('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_compare_diff_status_sources_table__p2005591066'  ,recordof(ds_compare_diff_status_sources_table),flat);

// -- seleids that exist in either sprint only
ds_compare_only := join(ds_rollup_base ,ds_rollup_father ,left.seleid = right.seleid   ,transform({recordof(left)}
  ,self.recs := left.recs  
              + right.recs
              ,self := if(left.seleid != 0  ,left ,right)),hash,full only);

ds_compare_diff_status_sources_only := project(ds_compare_only  ,transform({unsigned6 seleid,string file,string1 status,set of string sources}
  ,self.seleid  := left.seleid
  ,self.file    := if(exists(left.recs(trim(file) = pBase_Sprint)) ,pBase_Sprint  ,pFather_Sprint)
  ,self.status  := left.recs[1].seleid_status_public
  ,self.sources := set(sort(left.recs,source),source)
));
  

ds_compare_diff_status_sources_table_only := table(ds_compare_diff_status_sources_only  ,{sources,file,status ,unsigned cnt := count(group)} ,sources ,file,status,merge)
: persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_compare_diff_status_sources_table_only'); 
ds_compare_diff_status_sources_table_only_persist := dataset('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_compare_diff_status_sources_table_only__p2285965096'  ,recordof(ds_compare_diff_status_sources_table_only),flat);


// -- outputs
output_status_info := parallel(
   output(topn(ds_compare_diff_status_sources_table(trim(new_status) != trim(old_status))           ,100,-cnt),named('existing_clusters_changed_statuses'             ),all)
  ,output(topn(ds_compare_diff_status_sources_table_only                                            ,100,-cnt),named('new_clusters_statuses'                          ),all)
  ,output(topn(ds_compare_diff_status_sources_table(trim(new_status) = '' ,trim(old_status) != '' ) ,100,-cnt),named('existing_clusters_changed_statuses_to_active'   ),all)
  ,output(topn(ds_compare_diff_status_sources_table(trim(new_status) = 'D',trim(old_status) != 'D') ,100,-cnt),named('existing_clusters_changed_statuses_to_defunct'  ),all)
  ,output(topn(ds_compare_diff_status_sources_table(trim(new_status) = 'I',trim(old_status) != 'I') ,100,-cnt),named('existing_clusters_changed_statuses_to_inactive' ),all)
);



/* -- GOLD GOLD GOLD ---------------------------------------------------------------*/
// shared isJustPOBox := exists(AddBackNew.prim_names(prim_name[1..6] = 'PO BOX')) and count(AddBackNew.prim_names) = count(AddBackNew.prim_names(prim_name[1..6] = 'PO BOX'));
// BIPV2_PostProcess.constants.SuperCore
// source in BIPV2_PostProcess.constants.tricore, source not in BIPV2_PostProcess.constants.SuperCore
// source in BIPV2_PostProcess.constants.secondTierSources 
// addr_types(addr_type = 'B')

// shared isGold := 
  // isActive
  // AND isNotJustPOBox
  // AND (
    // hasSuperCoreSrc 
    // OR 
    // ((hasOtherCoreSrc or has2TSrc) and (hasMultipleSources or hasBizAddr))
  // );     

ds_base_gold_count_sources := table(table(ds_base  ,{seleid,source} ,seleid,source ,merge)  ,{seleid,unsigned cnt := count(group)} ,seleid ,merge);

ds_base_gold_prep := table(ds_base  ,{seleid,source,dt_last_seen,company_status_derived,seleid_status_public,sele_gold,zip,prim_range,prim_name,sec_range} ,seleid,source,dt_last_seen,company_status_derived,seleid_status_public,sele_gold,zip,prim_range,prim_name,sec_range ,merge);

ds_base_gold_prep2 := 
  join(
    ds_base_gold_prep,
    pull(Advo.Key_Addr1),
      left.zip = right.zip and 
      left.prim_range = right.prim_Range and
      left.prim_name = right.prim_name and      
      left.sec_range = right.sec_range    
    ,transform({recordof(left),string1 addr_type}
      ,self.addr_type :=
        map(right.Residential_or_Business_Ind = 'A'   => 'R',
            right.Residential_or_Business_Ind = 'B'   => 'B',     
            '')
      ,self := left
    
    )
    ,keep(1),
    left outer ,hash
  );

ds_base_slim_prep_gold   := table(ds_base_gold_prep2   ,{seleid,string source := mdr.sourceTools.translatesource(source),dt_last_seen,company_status_derived,seleid_status_public,sele_gold  
,unsigned count_NonPOBoxes   := sum(group,if(prim_name[1..6] != 'PO BOX'                                                                            ,1,0))     
,unsigned count_SuperCoreSrc := sum(group,if(source in BIPV2_PostProcess.constants.SuperCore                                                        ,1,0))     
,unsigned count_OtherCoreSrc := sum(group,if(source in BIPV2_PostProcess.constants.tricore and source not in BIPV2_PostProcess.constants.SuperCore  ,1,0))     
,unsigned count_2ndTierSrc   := sum(group,if(source in BIPV2_PostProcess.constants.secondTierSources                                                ,1,0))     
,unsigned count_BizAddr      := sum(group,if(addr_type = 'B'                                                                                        ,1,0))     
} ,seleid,source,dt_last_seen,company_status_derived,seleid_status_public,sele_gold ,merge);



ds_base_slim_gold := join(ds_base_slim_prep_gold  ,ds_base_gold_count_sources ,left.seleid = right.seleid ,transform({recordof(left),unsigned count_sources}
,self.count_sources := right.cnt
,self               := left
)  ,hash);

// -- Father
ds_father_gold_count_sources := table(table(ds_father  ,{seleid,source} ,seleid,source ,merge)  ,{seleid,unsigned cnt := count(group)} ,seleid ,merge);

ds_father_gold_prep := table(ds_father  ,{seleid,source,dt_last_seen,company_status_derived,seleid_status_public,sele_gold,zip,prim_range,prim_name,sec_range} ,seleid,source,dt_last_seen,company_status_derived,seleid_status_public,sele_gold,zip,prim_range,prim_name,sec_range ,merge);

ds_father_gold_prep2 := 
  join(
    ds_father_gold_prep,
    pull(Advo.Key_Addr1),
      left.zip = right.zip and 
      left.prim_range = right.prim_Range and
      left.prim_name = right.prim_name and      
      left.sec_range = right.sec_range    
    ,transform({recordof(left),string1 addr_type}
      ,self.addr_type :=
        map(right.Residential_or_Business_Ind = 'A'   => 'R',
            right.Residential_or_Business_Ind = 'B'   => 'B',     
            '')
      ,self := left
    
    )
    ,keep(1),
    left outer ,hash
  );

ds_father_slim_prep_gold   := table(ds_father_gold_prep2   ,{seleid,string source := mdr.sourceTools.translatesource(source),dt_last_seen,company_status_derived,seleid_status_public,sele_gold  
,unsigned count_NonPOBoxes   := sum(group,if(prim_name[1..6] != 'PO BOX'                                                                            ,1,0))     
,unsigned count_SuperCoreSrc := sum(group,if(source in BIPV2_PostProcess.constants.SuperCore                                                        ,1,0))     
,unsigned count_OtherCoreSrc := sum(group,if(source in BIPV2_PostProcess.constants.tricore and source not in BIPV2_PostProcess.constants.SuperCore  ,1,0))     
,unsigned count_2ndTierSrc   := sum(group,if(source in BIPV2_PostProcess.constants.secondTierSources                                                ,1,0))     
,unsigned count_BizAddr      := sum(group,if(addr_type = 'B'                                                                                        ,1,0))     
} ,seleid,source,dt_last_seen,company_status_derived,seleid_status_public,sele_gold ,merge);

ds_father_slim_gold := join(ds_father_slim_prep_gold  ,ds_father_gold_count_sources ,left.seleid = right.seleid ,transform({recordof(left),unsigned count_sources}
,self.count_sources := right.cnt
,self               := left
)  ,hash);

// ds_father_slim := table(ds_father ,{seleid,string source := mdr.sourceTools.translatesource(source),dt_last_seen,company_status_derived,seleid_status_public}  );

ds_sample_base_gold          := ds_base_slim_gold : persist('~persist::lbentley::ds_sample_base_gold');

// -- base
ds_prep_rollup_base_gold  := project(sort(distribute(ds_sample_base_gold,seleid),seleid,-if(dt_last_seen = 0  ,99999999,dt_last_seen) ,source ,local) 
                    ,transform({unsigned6 seleid,dataset({string file,recordof(left) - seleid}) recs}
                      ,self.recs := dataset([{pBase_Sprint,left.source,left.dt_last_seen,left.company_status_derived,left.seleid_status_public,left.sele_gold,left.count_NonPOBoxes,left.count_SuperCoreSrc,left.count_OtherCoreSrc,left.count_2ndTierSrc,left.count_BizAddr,left.count_sources}],{string file,recordof(left) - seleid})  
                      ,self           := left
                    ),local);
ds_rollup_base_gold       := rollup(ds_prep_rollup_base_gold  ,left.seleid = right.seleid ,transform(recordof(left),self.recs := left.recs + right.recs,self := left),local);


// -- father
ds_sample_father_gold       := ds_father_slim_gold : persist('~persist::lbentley::ds_sample_father_gold');

ds_prep_rollup_father_gold  := project(sort(distribute(ds_sample_father_gold,seleid),seleid,-if(dt_last_seen = 0  ,99999999,dt_last_seen) ,source ,local) 
                    ,transform({unsigned6 seleid,dataset({string file,recordof(left) - seleid}) recs}
                      ,self.recs := dataset([{pFather_Sprint,left.source,left.dt_last_seen,left.company_status_derived,left.seleid_status_public,left.sele_gold,left.count_NonPOBoxes,left.count_SuperCoreSrc,left.count_OtherCoreSrc,left.count_2ndTierSrc,left.count_BizAddr,left.count_sources}],{string file,recordof(left) - seleid})  
                      ,self           := left
                    ),local);
ds_rollup_father_gold       := rollup(ds_prep_rollup_father_gold  ,left.seleid = right.seleid ,transform(recordof(left),self.recs := left.recs + right.recs,self := left),local);

ds_compare_gold := join(ds_rollup_base_gold ,ds_rollup_father_gold ,left.seleid = right.seleid   ,transform({recordof(left)}
  ,self.recs := left.recs  
              + right.recs
              ,self := left),hash);


ds_compare_more_gold := project(ds_compare_gold ,transform(
  {recordof(left),dataset(recordof(ds_compare_gold.recs)) compare }
  ,self.compare := sort(rollup(sort(left.recs/*(dt_last_seen != 0)*/,source,company_status_derived,dt_last_seen,count_NonPOBoxes,count_BizAddr,-file)
                        ,left.source = right.source and trim(left.company_status_derived) = trim(right.company_status_derived) and left.dt_last_seen = right.dt_last_seen and left.count_NonPOBoxes = right.count_NonPOBoxes 
                          and left.count_SuperCoreSrc = right.count_SuperCoreSrc and left.count_OtherCoreSrc = right.count_OtherCoreSrc and left.count_2ndTierSrc = right.count_2ndTierSrc and left.count_BizAddr = right.count_BizAddr
                        ,transform(recordof(left),self.file := trim(left.file) + ',' + trim(right.file),self := left))
                   ,-file,source);
  ,self         := left
));


// -- anytime in the compare child dataset the file = 'Sprint 52', take the source field and those are the sources that contributed to the change in status
ds_compare_diff_status_gold := ds_compare_more_gold(    recs(trim(file) = pBase_Sprint)[1].sele_gold 
                                          !=  recs(trim(file) = pFather_Sprint)[1].sele_gold
                                         );

ds_compare_diff_status_sources_gold := project(ds_compare_diff_status_gold  ,transform({unsigned6 seleid,string1 old_gold,string1 new_gold,string1 old_status,string1 new_status,set of string sources}
  ,self.seleid      := left.seleid
  ,self.old_status  := left.recs(trim(file) = pFather_Sprint)[1].seleid_status_public
  ,self.new_status  := left.recs(trim(file) = pBase_Sprint)[1].seleid_status_public
  ,self.old_gold    := left.recs(trim(file) = pFather_Sprint)[1].sele_gold
  ,self.new_gold    := left.recs(trim(file) = pBase_Sprint)[1].sele_gold
  ,self.sources     := set(sort(project(left.compare(trim(file) = pBase_Sprint),{string source}),source),source)
));

ds_compare_diff_status_sources_table_gold := table(ds_compare_diff_status_sources_gold  ,{sources ,old_gold,new_gold,old_status,new_status,unsigned cnt := count(group)} ,sources,old_gold,new_gold,old_status,new_status ,merge)
: persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_compare_diff_status_sources_table_gold'); 
ds_compare_diff_status_sources_table_gold_persist := dataset('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_compare_diff_status_sources_table_gold__p2161375960'  ,recordof(ds_compare_diff_status_sources_table_gold),flat);

// -- seleids that exist in either sprint only
ds_compare_only_gold := join(ds_rollup_base_gold ,ds_rollup_father_gold ,left.seleid = right.seleid   ,transform({recordof(left)}
  ,self.recs := left.recs  
              + right.recs
              ,self := if(left.seleid != 0  ,left ,right)),hash,full only);

ds_compare_diff_status_sources_only_gold := project(ds_compare_only_gold  ,transform({unsigned6 seleid,string file,string1 gold,string1 status,set of string sources}
  ,self.seleid  := left.seleid
  ,self.file    := if(exists(left.recs(trim(file) = pBase_Sprint)) ,pBase_Sprint  ,pFather_Sprint)
  ,self.status  := left.recs[1].seleid_status_public
  ,self.gold    := left.recs[1].sele_gold
  ,self.sources := set(sort(left.recs,source),source)
));
  
ds_compare_diff_status_sources_table_only_gold := table(ds_compare_diff_status_sources_only_gold  ,{sources,file,gold,status,unsigned cnt := count(group)} ,sources ,file,gold,status,merge)
: persist('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_compare_diff_status_sources_table_only_gold'); 
ds_compare_diff_status_sources_table_only_gold_persist := dataset('~persist::BIPV2_Tools::compare_statuses_and_gold::ds_compare_diff_status_sources_table_only_gold__p1053225583'  ,recordof(ds_compare_diff_status_sources_table_only_gold),flat);
// -- outputs
output_gold_info := parallel(
   output(topn(ds_compare_diff_status_sources_table_gold      (trim(new_gold  ) != trim(old_gold  )         ) ,100,-cnt),named('existing_clusters_changed_golds'             ),all)
  ,output(topn(ds_compare_diff_status_sources_table_only_gold (trim(gold      ) = 'G'                       ) ,100,-cnt),named('new_clusters_golds'                          ),all)
  ,output(topn(ds_compare_diff_status_sources_table_gold      (trim(new_gold  ) = 'G',trim(old_gold  ) = '' ) ,100,-cnt),named('existing_clusters_changed_to_gold'           ),all)
  ,output(topn(ds_compare_diff_status_sources_table_gold      (trim(new_gold  ) = '',trim(old_gold  ) = 'G' ) ,100,-cnt),named('existing_clusters_changed_to_non_gold'       ),all)
);

return parallel(
   output_status_info
  ,output_gold_info
);














/*
output(choosen(ds_set_statuses_base  ,300),named('ds_set_statuses_base' ),all);
output(choosen(ds_prep_rollup_base   ,300),named('ds_prep_rollup_base'  ),all);
output(choosen(ds_rollup_base        ,300),named('ds_rollup_base'       ),all);

output(choosen(ds_set_statuses_father  ,300),named('ds_set_statuses_father' ),all);
output(choosen(ds_prep_rollup_father   ,300),named('ds_prep_rollup_father'  ),all);
output(choosen(ds_rollup_father        ,300),named('ds_rollup_father'       ),all);

output(choosen(ds_compare,300)  ,named('ds_compare'),all);
output(choosen(ds_compare_more,300),named('ds_compare_more'),all);

output(choosen(ds_compare_diff_status,300),named('ds_compare_diff_status'),all);
output(choosen(ds_compare_diff_status_sources,300),named('ds_compare_diff_status_sources'),all);

output(choosen(ds_compare_diff_status_sources_only,300),named('ds_compare_diff_status_sources_only'),all);

output(sort(ds_compare_diff_status_sources_table_only,-cnt),named('ds_compare_diff_status_sources_table_only'),all);
output(sort(ds_compare_diff_status_sources_table_only(file = pBase_Sprint),-cnt),named('ds_compare_diff_status_sources_table_only_Sprint55'),all);
output(sort(ds_compare_diff_status_sources_table_only(file = pFather_Sprint),-cnt),named('ds_compare_diff_status_sources_table_only_Sprint54'),all);
output(sort(ds_compare_diff_status_sources_table_only(file = pBase_Sprint,trim(status) = ''),-cnt),named('ds_compare_diff_status_sources_table_only_Sprint55_active'),all);
output(sort(ds_compare_diff_status_sources_table_only(file = pFather_Sprint,trim(status) = ''),-cnt),named('ds_compare_diff_status_sources_table_only_Sprint54_active'),all);

output(sort(ds_compare_diff_status_sources_table_only(file = pBase_Sprint,trim(status) = 'D'),-cnt),named('ds_compare_diff_status_sources_table_only_Sprint55_defunct'),all);
output(sort(ds_compare_diff_status_sources_table_only(file = pFather_Sprint,trim(status) = 'D'),-cnt),named('ds_compare_diff_status_sources_table_only_Sprint54_defunct'),all);
*/
// ds_same_status := join(table(ds_set_statuses_base  ,{seleid,seleid_status_public},seleid,seleid_status_public,merge) 
                   // ,table(ds_set_statuses_father,{seleid,seleid_status_public},seleid,seleid_status_public,merge) ,left.seleid = right.seleid and left.seleid_status_public = right.seleid_status_public  
                   // ,transform({unsigned6 seleid},self := left),hash);

// ds_diff_status := join(ds_rollup_base  ,ds_rollup_father ,left.seleid = right.seleid and left.sprint_55[1].seleid_status_public != right.sprint_54[1].seleid_status_public  
                   // ,transform({unsigned6 seleid},self := left)
                   // ,hash);

// ds_base_not_equal := join(ds_set_statuses_base(dt_last_seen != 0)  ,ds_set_statuses_father(dt_last_seen != 0) ,left.seleid = right.seleid and left.seleid_status_public != right.seleid_status_public and  );


endmacro;
