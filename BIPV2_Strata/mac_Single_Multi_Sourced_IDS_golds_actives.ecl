import bipv2_build,paw,bipv2,strata,tools,mdr;

EXPORT mac_Single_Multi_Sourced_IDS_golds_actives(

   pversion           = 'bipv2.KeySuffix'                           // build date
  ,pDataset           = 'bipv2.CommonBase.ds_built'
  ,pBIP_ID            = 'Seleid'                                    // ID to do this on
  ,pEmail_List        = 'BIPV2_Build.mod_email.emailList'           // email list 
  ,pIsTesting         = 'tools._Constants.IsDataland'
  ,pOverwrite         = 'false'
  ,pOutputDatasetOnly = 'false'
) :=
functionmacro

  #uniquename(ds_base)
  %ds_base%   := pDataset ;
  // ds_base  := bipv2.CommonBase.ds_clean;

  ds_base_seleids  := table(%ds_base%  ,{pBIP_ID},pBIP_ID,merge);
  // ds_clean_pBIP_IDs := table(ds_clean ,{pBIP_ID},pBIP_ID,merge);

  // output(count(ds_base_pBIP_IDs  ),named('count_ds_base_pBIP_IDs' ));
  // output(count(ds_clean_pBIP_IDs ),named('count_ds_clean_pBIP_IDs'));
  import mdr;
  //get specific source only ids
  ds_base_prep_pBIP_ID := project(table(%ds_base% ,{pBIP_ID,source,seleid_status_private,sele_gold},pBIP_ID,source,seleid_status_private,sele_gold,merge),transform(
  {unsigned6 pBIP_ID, set of string sources,string1 seleid_status_private ,string1 sele_gold}
  ,self.sources := [mdr.sourceTools.translatesource(left.source)]
  ,self := left
  ));

  ds_rollup_pBIP_ID := rollup(sort(distribute(ds_base_prep_pBIP_ID,pBIP_ID),pBIP_ID,local) ,left.pBIP_ID = right.pBIP_ID
  ,transform(recordof(left),self.sources := left.sources + right.sources,self := left),local);

  ds_table_sources := table(ds_rollup_pBIP_ID  ,{sources
    ,unsigned cnt           := count(group)
    ,unsigned cnt_gold      := sum(group,if(trim(sele_gold            ) = 'G',1,0))
    ,unsigned cnt_active    := sum(group,if(trim(seleid_status_private) = '' ,1,0))
    ,unsigned cnt_inactive  := sum(group,if(trim(seleid_status_private) = 'I',1,0))
    ,unsigned cnt_defunct   := sum(group,if(trim(seleid_status_private) = 'D',1,0))
  },sources,merge);

  ds_sources := table(ds_base_prep_pBIP_ID ,{string source := sources[1]},sources[1],merge);

  lay_child := {
     unsigned total         := 0
    ,unsigned cnt_gold      := 0
    ,unsigned cnt_active    := 0
    ,unsigned cnt_inactive  := 0
    ,unsigned cnt_defunct   := 0
  };

  lay_result := {string source
  ,unsigned cnt_total := 0
  ,unsigned cnt_gold      := 0
  ,unsigned cnt_active    := 0
  ,unsigned cnt_inactive  := 0
  ,unsigned cnt_defunct   := 0
  ,lay_child single_source
  ,lay_child multi_source
  // ,unsigned cnt_single_source
  // ,unsigned cnt_multi_source := 0
  // ,unsigned cnt_gold      := 0
  // ,unsigned cnt_active    := 0
  // ,unsigned cnt_inactive  := 0
  // ,unsigned cnt_defunct   := 0  
  // ,unsigned cnt_total := 0
  };

  ds_result := join(ds_table_sources  ,ds_sources ,right.source in left.sources ,transform(lay_result
    ,self.source                        := right.source
    ,self.single_source.total           := if(count(left.sources)  = 1 ,left.cnt          ,0)
    ,self.single_source.cnt_gold        := if(count(left.sources)  = 1 ,left.cnt_gold     ,0)
    ,self.single_source.cnt_active      := if(count(left.sources)  = 1 ,left.cnt_active   ,0)
    ,self.single_source.cnt_inactive    := if(count(left.sources)  = 1 ,left.cnt_inactive ,0)
    ,self.single_source.cnt_defunct     := if(count(left.sources)  = 1 ,left.cnt_defunct  ,0)

    ,self.multi_source.total            := if(count(left.sources)  <> 1,left.cnt          ,0)
    ,self.multi_source.cnt_gold         := if(count(left.sources)  <> 1,left.cnt_gold     ,0)
    ,self.multi_source.cnt_active       := if(count(left.sources)  <> 1,left.cnt_active   ,0)
    ,self.multi_source.cnt_inactive     := if(count(left.sources)  <> 1,left.cnt_inactive ,0)
    ,self.multi_source.cnt_defunct      := if(count(left.sources)  <> 1,left.cnt_defunct  ,0)

    ,self.cnt_total        := left.cnt
    ,self.cnt_gold         := left.cnt_gold     
    ,self.cnt_active       := left.cnt_active   
    ,self.cnt_inactive     := left.cnt_inactive 
    ,self.cnt_defunct      := left.cnt_defunct  
    // ,self.countgroup        := left.cnt
  ),all);

  ds_sum_it := table(ds_result 
    ,{source
    ,unsigned cnt_total    := sum(group,cnt_total   )
    ,unsigned cnt_gold     := sum(group,cnt_gold    )
    ,unsigned cnt_active   := sum(group,cnt_active  )
    ,unsigned cnt_inactive := sum(group,cnt_inactive)
    ,unsigned cnt_defunct  := sum(group,cnt_defunct )

    ,unsigned cnt_single_source_total    := sum(group,single_source.total       )
    ,unsigned cnt_single_source_gold     := sum(group,single_source.cnt_gold    )
    ,unsigned cnt_single_source_active   := sum(group,single_source.cnt_active  )
    ,unsigned cnt_single_source_inactive := sum(group,single_source.cnt_inactive)
    ,unsigned cnt_single_source_defunct  := sum(group,single_source.cnt_defunct )

    ,unsigned cnt_multi_source_total     := sum(group,multi_source.total        )
    ,unsigned cnt_multi_source_gold      := sum(group,multi_source.cnt_gold     )
    ,unsigned cnt_multi_source_active    := sum(group,multi_source.cnt_active   )
    ,unsigned cnt_multi_source_inactive  := sum(group,multi_source.cnt_inactive )
    ,unsigned cnt_multi_source_defunct   := sum(group,multi_source.cnt_defunct  )
  },source,merge);

  lay_child2 := {
     string total         := ''
    ,string cnt_gold      := ''
    ,string cnt_active    := ''
    ,string cnt_inactive  := ''
    ,string cnt_defunct   := ''
  };

  lay_result2 := {
     string source
    ,string cnt_total           
    ,string cnt_gold      := 0
    ,string cnt_active    := 0
    ,string cnt_inactive  := 0
    ,string cnt_defunct   := 0

    ,lay_child2 single_source
    ,lay_child2 multi_source

    // ,string cnt_single_source 
    // ,string cnt_multi_source    
    // ,string cnt_gold            
    // ,string cnt_active          
    // ,string cnt_inactive        
    // ,string cnt_defunct           
  };
    
  ds_result1 := sort(project(ds_sum_it
    ,transform(lay_result2
      ,self.cnt_total                     := ut.fIntWithCommas(left.cnt_total                 ) + '(' + realformat(left.cnt_total                   / count(ds_base_seleids)          * 100.0  ,7,3) + '%)'
      ,self.cnt_gold                      := ut.fIntWithCommas(left.cnt_gold                  ) + '(' + realformat(left.cnt_gold                    / left.cnt_total                  * 100.0  ,7,3) + '%)'
      ,self.cnt_active                    := ut.fIntWithCommas(left.cnt_active                ) + '(' + realformat(left.cnt_active                  / left.cnt_total                  * 100.0  ,7,3) + '%)'
      ,self.cnt_inactive                  := ut.fIntWithCommas(left.cnt_inactive              ) + '(' + realformat(left.cnt_inactive                / left.cnt_total                  * 100.0  ,7,3) + '%)'
      ,self.cnt_defunct                   := ut.fIntWithCommas(left.cnt_defunct               ) + '(' + realformat(left.cnt_defunct                 / left.cnt_total                  * 100.0  ,7,3) + '%)'

      ,self.single_source.total           := ut.fIntWithCommas(left.cnt_single_source_total   ) + '(' + realformat(left.cnt_single_source_total     / left.cnt_total                  * 100.0  ,7,3) + '%)'
      ,self.single_source.cnt_gold        := ut.fIntWithCommas(left.cnt_single_source_gold    ) + '(' + realformat(left.cnt_single_source_gold      / left.cnt_single_source_total    * 100.0  ,7,3) + '%)'
      ,self.single_source.cnt_active      := ut.fIntWithCommas(left.cnt_single_source_active  ) + '(' + realformat(left.cnt_single_source_active    / left.cnt_single_source_total    * 100.0  ,7,3) + '%)'
      ,self.single_source.cnt_inactive    := ut.fIntWithCommas(left.cnt_single_source_inactive) + '(' + realformat(left.cnt_single_source_inactive  / left.cnt_single_source_total    * 100.0  ,7,3) + '%)'
      ,self.single_source.cnt_defunct     := ut.fIntWithCommas(left.cnt_single_source_defunct ) + '(' + realformat(left.cnt_single_source_defunct   / left.cnt_single_source_total    * 100.0  ,7,3) + '%)'

      ,self.multi_source.total            := ut.fIntWithCommas(left.cnt_multi_source_total    ) + '(' + realformat(left.cnt_multi_source_total      / left.cnt_total                  * 100.0  ,7,3) + '%)'
      ,self.multi_source.cnt_gold         := ut.fIntWithCommas(left.cnt_multi_source_gold     ) + '(' + realformat(left.cnt_multi_source_gold       / left.cnt_multi_source_total     * 100.0  ,7,3) + '%)'
      ,self.multi_source.cnt_active       := ut.fIntWithCommas(left.cnt_multi_source_active   ) + '(' + realformat(left.cnt_multi_source_active     / left.cnt_multi_source_total     * 100.0  ,7,3) + '%)'
      ,self.multi_source.cnt_inactive     := ut.fIntWithCommas(left.cnt_multi_source_inactive ) + '(' + realformat(left.cnt_multi_source_inactive   / left.cnt_multi_source_total     * 100.0  ,7,3) + '%)'
      ,self.multi_source.cnt_defunct      := ut.fIntWithCommas(left.cnt_multi_source_defunct  ) + '(' + realformat(left.cnt_multi_source_defunct    / left.cnt_multi_source_total     * 100.0  ,7,3) + '%)'

      ,self                     := left
    )),source);
 
  ds_table_gold_active := table(ds_base_prep_pBIP_ID  ,{pBIP_ID,seleid_status_private,sele_gold},pBIP_ID,seleid_status_private,sele_gold,merge);
  ds_single_source_clusters   := ds_rollup_pBIP_ID(count(sources) = 1);
  ds_multiple_source_clusters := ds_rollup_pBIP_ID(count(sources) > 1);
  ds_table_gold_active_all := join(ds_table_gold_active ,ds_rollup_pBIP_ID  ,left.seleid = right.seleid ,transform({boolean isSingleton,recordof(left)},self.isSingleton := if(count(right.sources) = 1 ,true ,false)  ,self := left)  ,hash);
  
  ds_table_gold_active_singletons     := ds_table_gold_active_all(isSingleton = true );
  ds_table_gold_active_multi_sourced  := ds_table_gold_active_all(isSingleton = false);
  
  cnt_gold_seleids      := count(ds_table_gold_active_all(sele_gold = 'G'));
  cnt_active_seleids    := count(ds_table_gold_active_all(trim(seleid_status_private) = ''));
  cnt_Inactive_seleids  := count(ds_table_gold_active_all(trim(seleid_status_private) = 'I'));
  cnt_Defunct_seleids   := count(ds_table_gold_active_all(trim(seleid_status_private) = 'D'));

  cnt_seleids_single_source           := count(ds_table_gold_active_singletons);
  cnt_gold_seleids_single_source      := count(ds_table_gold_active_singletons(sele_gold = 'G'));
  cnt_active_seleids_single_source    := count(ds_table_gold_active_singletons(trim(seleid_status_private) = ''));
  cnt_Inactive_seleids_single_source  := count(ds_table_gold_active_singletons(trim(seleid_status_private) = 'I'));
  cnt_Defunct_seleids_single_source   := count(ds_table_gold_active_singletons(trim(seleid_status_private) = 'D'));
  
  cnt_seleids_multi_source           := count(ds_table_gold_active_multi_sourced);
  cnt_gold_seleids_multi_source      := count(ds_table_gold_active_multi_sourced(sele_gold = 'G'));
  cnt_active_seleids_multi_source    := count(ds_table_gold_active_multi_sourced(trim(seleid_status_private) = ''));
  cnt_Inactive_seleids_multi_source  := count(ds_table_gold_active_multi_sourced(trim(seleid_status_private) = 'I'));
  cnt_Defunct_seleids_multi_source   := count(ds_table_gold_active_multi_sourced(trim(seleid_status_private) = 'D'));
  
  // -- NEED TO DO JOINS ON ABOVE DATASETS TO FIGURE OUT HOW MANY OF THOSE SELEIDS ARE SINGLE AND MULTI SOURCED  FOR GOLD, ACTIVE, INACTIVE AND DEFUNCT.
  ds_totals := dataset([{

   'Totals'                                                                                                                                                                  //source
  ,ut.fIntWithCommas(count(ds_base_seleids            )) + '(100.00%)'                                                                                                       //cnt_total        
  ,ut.fIntWithCommas(cnt_gold_seleids                  ) + '(' + realformat(cnt_gold_seleids                     / count(ds_base_seleids)             * 100.0  ,7,3) + '%)'  //cnt_gold    
  ,ut.fIntWithCommas(cnt_active_seleids                ) + '(' + realformat(cnt_active_seleids                   / count(ds_base_seleids)             * 100.0  ,7,3) + '%)'  //cnt_active  
  ,ut.fIntWithCommas(cnt_Inactive_seleids              ) + '(' + realformat(cnt_Inactive_seleids                 / count(ds_base_seleids)             * 100.0  ,7,3) + '%)'  //cnt_inactive
  ,ut.fIntWithCommas(cnt_Defunct_seleids               ) + '(' + realformat(cnt_Defunct_seleids                  / count(ds_base_seleids)             * 100.0  ,7,3) + '%)'  //cnt_defunct 

  ,ut.fIntWithCommas(cnt_seleids_single_source         ) + '(' + realformat(cnt_seleids_single_source            / count(ds_base_seleids)             * 100.0  ,7,3) + '%)'  //cnt_single_source_total   
  ,ut.fIntWithCommas(cnt_gold_seleids_single_source    ) + '(' + realformat(cnt_gold_seleids_single_source       / cnt_seleids_single_source          * 100.0  ,7,3) + '%)'  //cnt_single_source_gold    
  ,ut.fIntWithCommas(cnt_active_seleids_single_source  ) + '(' + realformat(cnt_active_seleids_single_source     / cnt_seleids_single_source          * 100.0  ,7,3) + '%)'  //cnt_single_source_active  
  ,ut.fIntWithCommas(cnt_Inactive_seleids_single_source) + '(' + realformat(cnt_Inactive_seleids_single_source   / cnt_seleids_single_source          * 100.0  ,7,3) + '%)'  //cnt_single_source_inactive
  ,ut.fIntWithCommas(cnt_Defunct_seleids_single_source ) + '(' + realformat(cnt_Defunct_seleids_single_source    / cnt_seleids_single_source          * 100.0  ,7,3) + '%)'  //cnt_single_source_defunct 
                     
  ,ut.fIntWithCommas(cnt_seleids_multi_source          ) + '(' + realformat(cnt_seleids_multi_source             / count(ds_base_seleids)             * 100.0  ,7,3) + '%)'  //cnt_multi_source_total   
  ,ut.fIntWithCommas(cnt_gold_seleids_multi_source     ) + '(' + realformat(cnt_gold_seleids_multi_source        / cnt_seleids_multi_source           * 100.0  ,7,3) + '%)'  //cnt_multi_source_gold    
  ,ut.fIntWithCommas(cnt_active_seleids_multi_source   ) + '(' + realformat(cnt_active_seleids_multi_source      / cnt_seleids_multi_source           * 100.0  ,7,3) + '%)'  //cnt_multi_source_active  
  ,ut.fIntWithCommas(cnt_Inactive_seleids_multi_source ) + '(' + realformat(cnt_Inactive_seleids_multi_source    / cnt_seleids_multi_source           * 100.0  ,7,3) + '%)'  //cnt_multi_source_inactive
  ,ut.fIntWithCommas(cnt_Defunct_seleids_multi_source  ) + '(' + realformat(cnt_Defunct_seleids_multi_source     / cnt_seleids_multi_source           * 100.0  ,7,3) + '%)'  //cnt_multi_source_defunct 
  
  }],lay_result2);

  ds_result2 := ds_result1 + ds_totals : independent;
  //bip_id,source, cnt_single_source, cnt_multi_source,cnt_total

  // countds_base_prep_pBIP_ID := count(ds_base_prep_pBIP_ID);
  // countds_rollup_pBIP_ID    := count(ds_rollup_seleid   );
  // countds_table_sources    := count(ds_table_sources   );
  // countds_sources          := count(ds_sources         );
  // countds_result           := count(ds_result          );
  // countds_result1          := count(ds_result1         );
  // countds_totals           := count(ds_totals          );
  // countds_result2          := count(ds_result2         );

  // output(countds_base_prep_seleid ,named('countds_base_prep_seleid'));
  // output(countds_rollup_seleid    ,named('countds_rollup_seleid'   ));
  // output(countds_table_sources    ,named('countds_table_sources'   ));
  // output(countds_sources          ,named('countds_sources'         ));
  // output(countds_result           ,named('countds_result'          ));
  // output(countds_result1          ,named('countds_result1'         ));
  // output(countds_totals           ,named('countds_totals'          ));
  // output(countds_result2          ,named('countds_result2'         ));

  // output(ds_base_prep_seleid ,named('ds_base_prep_seleid'));
  // output(ds_rollup_seleid    ,named('ds_rollup_seleid'   ));
  // output(ds_table_sources    ,named('ds_table_sources'   ));
  // output(ds_sources          ,named('ds_sources'         ));
  // output(ds_result           ,named('ds_result'          ));
  // output(ds_result1          ,named('ds_result1'         ));
  // output(ds_totals           ,named('ds_totals'          ));
  // output(ds_result2          ,named('ds_result2'         ),all);
  #IF(pOutputDatasetOnly = false)
    return Strata.macf_CreateXMLStats (ds_result2 ,'BIPV2',#TEXT(pBIP_ID)  ,pversion	,pEmail_List	,'Sourced' ,'Single_and_Multi'	,pIsTesting,pOverwrite);
  #ELSE
    return ds_result2;
  #END

endmacro;