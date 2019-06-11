import bipv2_build,paw,bipv2,strata,tools,mdr;

EXPORT mac_Single_Multi_Sourced_IDS(

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
  ds_base_prep_pBIP_ID := project(table(%ds_base% ,{pBIP_ID,source},pBIP_ID,source,merge),transform(
  {unsigned6 pBIP_ID, set of string sources}
  ,self.sources := [mdr.sourceTools.translatesource(left.source)]
  ,self := left
  ));

  ds_rollup_pBIP_ID := rollup(sort(distribute(ds_base_prep_pBIP_ID,pBIP_ID),pBIP_ID,local) ,left.pBIP_ID = right.pBIP_ID
  ,transform(recordof(left),self.sources := left.sources + right.sources,self := left),local);

  ds_table_sources := table(ds_rollup_pBIP_ID  ,{sources,unsigned cnt := count(group)},sources,merge);

  ds_sources := table(ds_base_prep_pBIP_ID ,{string source := sources[1]},sources[1],merge);

  lay_result := {string source, unsigned countgroup := 0,unsigned cnt_single_source,unsigned cnt_multi_source := 0, unsigned cnt_total := 0,string pct_single_source := '',string pct_multi_source := '', string pct_total := '', string pct_single_source_of_total := ''};

  ds_result := join(ds_table_sources  ,ds_sources ,right.source in left.sources ,transform(lay_result
    ,self.source            := right.source
    ,self.cnt_single_source := if(count(left.sources)  = 1 ,left.cnt  ,0)
    ,self.cnt_multi_source  := if(count(left.sources) <> 1 ,left.cnt  ,0)
    ,self.cnt_total         := left.cnt
    ,self.countgroup        := left.cnt
  ),all);

  ds_result1 := sort(project(table(ds_result 
    ,{source,unsigned cnt_single_source := sum(group,cnt_single_source),unsigned cnt_multi_source := sum(group,cnt_multi_source),unsigned cnt_total := sum(group,cnt_total)},source,merge)
    ,transform(lay_result
      ,self.pct_single_source         := (string)truncate((real8)realformat(left.cnt_single_source  / left.cnt_total           * 100.0  ,6,2) * 100)
      ,self.pct_multi_source          := (string)truncate((real8)realformat(left.cnt_multi_source   / left.cnt_total           * 100.0  ,6,2) * 100)
      ,self.pct_total                 := (string)truncate((real8)realformat(left.cnt_total          / count(ds_base_seleids )  * 100.0  ,6,2) * 100)
      ,self.pct_single_source_of_total:= (string)truncate((real8)realformat(left.cnt_single_source  / count(ds_base_seleids )  * 100.0  ,6,2) * 100)
      ,self.countgroup                := left.cnt_total
      ,self                           := left
    )),source);
    
  ds_totals := dataset([{'Totals'
  ,count(ds_base_seleids)
  ,sum(ds_result1,cnt_single_source) 
  ,count(ds_base_seleids) - sum(ds_result1,cnt_single_source)
  ,count(ds_base_seleids)
  ,(string)truncate((real8)realformat(sum(ds_result1,cnt_single_source) / count(ds_base_seleids) * 100.0  ,6,2) * 100)
  ,(string)truncate((real8)realformat((count(ds_base_seleids) - sum(ds_result1,cnt_single_source)) / count(ds_base_seleids) * 100.0  ,6,2) * 100)
  ,10000
  ,(string)truncate((real8)realformat(sum(ds_result1,cnt_single_source) / count(ds_base_seleids) * 100.0  ,6,2) * 100)
  }],lay_result);

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